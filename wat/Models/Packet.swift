//
//  Packet.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class Packet: RawData {
    let pcapHeader = pkthdr_t()
    
    init(pcapHeader: pkthdr_t, rawData: NSData) {
        self.pcapHeader = pcapHeader
        
        super.init(rawData: rawData)
    }

}
