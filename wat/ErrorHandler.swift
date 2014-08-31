//
//  ErrorHandler.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class ErrorHandler: NSObject {
    let colorPrinter = ColorPrinter()
    
    func handleError(error: UnsafeMutablePointer<CChar>) {
        if (error != nil ) {
            self.colorPrinter.print(.Red, String.fromCString(error)!)
            exit(1)
        }
    }

    func handleResult(result: Int32, message: String) {
        if (result != 0) {
            self.colorPrinter.print(.Red, message)
            exit(1)
        }
    }

}
