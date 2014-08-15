//
//  RadioTapPacket.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class RadioTapPacket: Packet {
    let radioTapHeaderSize: Int
    let frame: ManagementFrame
    
    enum FrameControlType {
        case Management, Control, Data, Reserved, Unknown
        func simpleDescription() -> String {
            switch self {
            case .Management:
                return "MGMT"
            case .Control:
                return "CTRL"
            case .Data:
                return "DATA"
            case .Reserved:
                return "Reserved"
            case .Unknown:
                return "Unknown"
            }
        }
    }
    
    let frameControlType: FrameControlType

    override init(pcapHeader: pkthdr_t, rawData: NSData) {
        self.radioTapHeaderSize = 0
        self.frameControlType = .Unknown
        self.frame = ManagementFrame(rawData: rawData)
        super.init(pcapHeader: pcapHeader, rawData: rawData)

        self.radioTapHeaderSize = Int(self.read(2) as Int8)
        var fc = self.read(self.radioTapHeaderSize) as Int16
        
        var frameData = self.rawData.subdataWithRange(NSMakeRange(self.radioTapHeaderSize, self.rawData.length - self.radioTapHeaderSize))
                
        switch (((fc) >> 2) & 0x3) {
        case 0x0:
            self.frameControlType = .Management
            self.frame = ManagementFrame(rawData: frameData)
        case 0x1:
            self.frameControlType = .Control
        case 0x2:
            self.frameControlType = .Data
        case 0x3:
            self.frameControlType = .Reserved
        default:
            self.frameControlType = .Unknown
        }
        
    }
}
