//
//  FrameControl.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class FrameControl: RawData {
    let frameControlBytes: Int16
    
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

    enum FrameControlSubType {
        case Authentication, Unknown
        func simpleDescription() -> String {
            switch self {
            case .Authentication:
                return "AUTH"
            case .Unknown:
                return "Unknown"
            }
        }
    }
    
    let frameControlSubType: FrameControlSubType
    

    override init(rawData: NSData) {
        self.frameControlBytes = 0
        self.frameControlType = .Unknown
        self.frameControlSubType = .Unknown
        super.init(rawData: rawData)
        
        self.frameControlBytes = self.read(0) as Int16
        
        switch (((self.frameControlBytes) >> 2) & 0x3) {
        case 0x0:
            self.frameControlType = .Management
        case 0x1:
            self.frameControlType = .Control
        case 0x2:
            self.frameControlType = .Data
        case 0x3:
            self.frameControlType = .Reserved
        default:
            self.frameControlType = .Unknown
        }

        switch (((self.frameControlBytes) >> 4) & 0xF) {
        case 0xB:
            self.frameControlSubType = .Authentication
        default:
            self.frameControlSubType = .Unknown
        }

    }
}
