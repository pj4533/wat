//
//  RadioTapPacket.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class RadioTapPacket: Packet {
    let radioTapHeaderSize: Int8

    override init(pcapHeader: pkthdr_t, rawData: NSData) {
        self.radioTapHeaderSize = 0
        super.init(pcapHeader: pcapHeader, rawData: rawData)

        self.radioTapHeaderSize = self.read(2) as Int8
    }
}
