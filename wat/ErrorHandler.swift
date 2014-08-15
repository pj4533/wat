//
//  ErrorHandler.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class ErrorHandler: NSObject {
    var colorPrinter: SGSColorPrinter
    
    override init() {
        self.colorPrinter = SGSColorPrinter()
    }
    
    func handleError(error: UnsafeMutablePointer<CChar>) {
        if (error != nil ) {
            self.colorPrinter.printlnRed(String.fromCString(error))
            exit(1)
        }
    }

    func handleResult(result: Int32, message: String) {
        if (result != 0) {
            self.colorPrinter.printlnRed(message)
            exit(1)
        }
    }

}
