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
    case Bold
}

class ColorPrinter: NSObject {
    
    let colorCodes: Dictionary<PrintColor, String> = [
        .Default: "39",
        .Red: "31",
        .Green: "32",
        .Yellow: "33",
        .Blue: "34",
        .Magenta: "35",
        .Cyan: "36",
        .Bold: "1"
    ]

    func printBold(color: PrintColor, _ str: String) {
        Swift.print("\u{1B}[\(colorCodes[.Bold]!)m")
        self.print(color, str)
    }
    
    func print(color: PrintColor, _ str: String) {
        Swift.print("\u{1B}[\(colorCodes[color]!)m")
        Swift.print(str)
        Swift.print("\u{1B}[\(colorCodes[color]!)m")
    }
}
