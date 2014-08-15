//
//  ManagementFrame.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class ManagementFrame: Frame {
    let destAddr = UnsafePointer<ether_addr>()
    let sourceAddr = UnsafePointer<ether_addr>()
    
    var destAddrString: String? {
        get {
            return String.fromCString(ether_ntoa(self.destAddr))
        }
    }

    var sourceAddrString: String? {
        get {
            return String.fromCString(ether_ntoa(self.sourceAddr))
        }
    }

    override init(rawData: NSData) {
        super.init(rawData: rawData)
        
        self.destAddr = UnsafePointer<ether_addr>(self.rawData.subdataWithRange(NSMakeRange(4, 6)).bytes)
        if  self.rawData.length >= 16 {
            self.sourceAddr = UnsafePointer<ether_addr>(self.rawData.subdataWithRange(NSMakeRange(10, 6)).bytes)
        }
        
    }
}
