//
//  RadioTapPacket.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class RadioTapPacket: Packet {
    let radioTapHeaderSize: Int?
    let managementFrame: ManagementFrame?
    let dataFrame: DataFrame?
    let frameControl: FrameControl?

    override init(pcapHeader: pkthdr_t, rawData: NSData) {
        super.init(pcapHeader: pcapHeader, rawData: rawData)

        self.radioTapHeaderSize = Int(self.read(2) as Int8)
        var frameData = self.rawData.subdataWithRange(NSMakeRange(self.radioTapHeaderSize!, self.rawData.length - self.radioTapHeaderSize!))

        self.frameControl = FrameControl(rawData: frameData)
        
        if self.frameControl?.frameControlType == FrameControl.FrameControlType.Management {
            self.managementFrame = ManagementFrame(frameControl: self.frameControl!, rawData: frameData)
        } else if self.frameControl?.frameControlType == FrameControl.FrameControlType.Data {
            self.dataFrame = DataFrame(frameControl: self.frameControl!, rawData: frameData)
        }

    }
}
