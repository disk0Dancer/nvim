#!/usr/bin/env swift

import AppKit
import Foundation

typealias Plist = [String: Any]

let colorKeyMap: [String: String] = [
  "Ansi 0 Color": "ANSIBlackColor",
  "Ansi 1 Color": "ANSIRedColor",
  "Ansi 2 Color": "ANSIGreenColor",
  "Ansi 3 Color": "ANSIYellowColor",
  "Ansi 4 Color": "ANSIBlueColor",
  "Ansi 5 Color": "ANSIMagentaColor",
  "Ansi 6 Color": "ANSICyanColor",
  "Ansi 7 Color": "ANSIWhiteColor",
  "Ansi 8 Color": "ANSIBrightBlackColor",
  "Ansi 9 Color": "ANSIBrightRedColor",
  "Ansi 10 Color": "ANSIBrightGreenColor",
  "Ansi 11 Color": "ANSIBrightYellowColor",
  "Background Color": "BackgroundColor",
  "Bold Color": "TextBoldColor",
  "Cursor Color": "CursorColor",
  "Foreground Color": "TextColor",
  "Selection Color": "SelectionColor",
]

// Terminal.app renders some TUI highlight states through ANSI yellow, so keep it
// darker than the upstream TokyoNight accent to preserve white-text contrast.
let terminalColorOverrides: [String: NSColor] = [
  "ANSIYellowColor": color(hex: "#7F6337"),
  "ANSIBrightYellowColor": color(hex: "#8F7040"),
]

func fail(_ message: String) -> Never {
  fputs("error: \(message)\n", stderr)
  exit(1)
}

func color(hex: String, alpha: CGFloat = 1.0) -> NSColor {
  let cleaned = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
  guard cleaned.count == 6, let value = Int(cleaned, radix: 16) else {
    fail("invalid hex color \(hex)")
  }

  let red = CGFloat((value >> 16) & 0xFF) / 255
  let green = CGFloat((value >> 8) & 0xFF) / 255
  let blue = CGFloat(value & 0xFF) / 255
  return NSColor(srgbRed: red, green: green, blue: blue, alpha: alpha)
}

func loadPlist(at path: String) -> Plist {
  let url = URL(fileURLWithPath: path)
  guard let data = try? Data(contentsOf: url) else {
    fail("unable to read \(path)")
  }

  var format = PropertyListSerialization.PropertyListFormat.xml
  guard let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: &format) as? Plist else {
    fail("invalid plist at \(path)")
  }

  return plist
}

func color(from dict: Plist) -> NSColor {
  guard
    let red = dict["Red Component"] as? Double,
    let green = dict["Green Component"] as? Double,
    let blue = dict["Blue Component"] as? Double
  else {
    fail("missing RGB components in color dictionary")
  }

  let alpha = (dict["Alpha Component"] as? Double) ?? 1.0
  return NSColor(srgbRed: red, green: green, blue: blue, alpha: alpha)
}

func archivedColor(_ color: NSColor) -> Data {
  do {
    return try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
  } catch {
    fail("unable to archive NSColor: \(error)")
  }
}

guard CommandLine.arguments.count == 3 else {
  fail("usage: generate_terminal_theme.swift <input.itermcolors> <output.terminal>")
}

let inputPath = CommandLine.arguments[1]
let outputPath = CommandLine.arguments[2]

let source = loadPlist(at: inputPath)
let templatePath = "/System/Applications/Utilities/Terminal.app/Contents/Resources/Initial Settings/Homebrew.terminal"
var output = loadPlist(at: templatePath)

for (sourceKey, targetKey) in colorKeyMap {
  guard let sourceColor = source[sourceKey] as? Plist else {
    continue
  }
  output[targetKey] = archivedColor(color(from: sourceColor))
}

for (targetKey, overrideColor) in terminalColorOverrides {
  output[targetKey] = archivedColor(overrideColor)
}

output["name"] = "TokyoNight Storm"
output["CursorType"] = 2
output["ProfileCurrentVersion"] = "2.07"
output["ShowWindowSettingsNameInTitle"] = false
output["type"] = "Window Settings"

let outputURL = URL(fileURLWithPath: outputPath)
let outputDir = outputURL.deletingLastPathComponent()
try? FileManager.default.createDirectory(at: outputDir, withIntermediateDirectories: true)

do {
  let data = try PropertyListSerialization.data(fromPropertyList: output, format: .xml, options: 0)
  try data.write(to: outputURL)
} catch {
  fail("unable to write \(outputPath): \(error)")
}
