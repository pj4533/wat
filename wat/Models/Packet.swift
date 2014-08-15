//
//  Packet.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class Packet: NSObject {
    let pcapHeader = pkthdr_t()
    let rawData = NSData()
    
    init(pcapHeader: pkthdr_t, rawData: NSData) {
        self.rawData = rawData
        self.pcapHeader = pcapHeader
    }

    func read<T>(byteLocation: Int) -> T {
        let bytes = self.rawData.subdataWithRange(NSMakeRange(byteLocation, sizeof(T))).bytes
        return UnsafePointer<T>(bytes).memory
    }
}
