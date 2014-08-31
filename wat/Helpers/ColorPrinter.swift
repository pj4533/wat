//
//  ColorPrinter.swift
//  wat
//
//  Created by PJ Gray on 8/31/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

// thanks to mikeash:  https://github.com/mikeash/memorydumper/blob/master/memory.swift
enum PrintColor {
    case Default
    case Red
    case Green
    case Yellow
    case Blue
    case Magenta
    case Cyan
}

class ColorPrinter: NSObject {
    
    let colorCodes: Dictionary<PrintColor, String> = [
        .Default: "39",
        .Red: "31",
        .Green: "32",
        .Yellow: "33",
        .Blue: "34",
        .Magenta: "35",
        .Cyan: "36"
    ]
    func printEscape(color: PrintColor) {
        Swift.print("\u{1B}[\(colorCodes[color]!)m")
    }
    func print(color: PrintColor, _ str: String) {
        printEscape(color)
        Swift.print(str)
        printEscape(.Default)
    }
    func print(str: String) {
        print(.Default, str)
    }
    func println() {
        Swift.println()
    }
    func end() {}
}
