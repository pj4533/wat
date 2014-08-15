//
//  PacketManager.swift
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

import Cocoa

class PacketManager: NSObject {
    let errorHandler: ErrorHandler
    let callbackManager: SGSPacketCallbackManager
    let deviceName: String
    
    init(deviceName: String) {
        self.deviceName = deviceName
        self.errorHandler = ErrorHandler()
        self.callbackManager = SGSPacketCallbackManager()
        
        super.init()
    }
    
//    func stringIfMeWithFrame(frame: FrameWithAddresses?, stringSoFar: String) -> String {
//        String outputString = String(stringSoFar)
//        
//        if  frame?.destAddr != nil {
//            outputString += " DEST: \(frame!.destAddrString!)"
//            if (packet.managementFrame?.destAddrString! == "e4:98:d6:3:90:e4") {
//                showOutput = true
//            }
//        }
//        
//        if  (packet.managementFrame?.sourceAddr != nil) {
//            outputString += " SOURCE: \(packet.managementFrame!.sourceAddrString!)"
//            if (packet.managementFrame?.sourceAddrString! == "e4:98:d6:3:90:e4") {
//                showOutput = true
//            }
//        }
//
//        return
//    }
    
    func capture() {
        var error: UnsafeMutablePointer<CChar>
        error = nil
        
        println("Opening device: \(self.deviceName)")
        
        var descr = pcap_create(self.deviceName,error)
        self.errorHandler.handleError(error)
        
        self.errorHandler.handleResult(pcap_set_promisc(descr, 1),message: "Couldn't set promisc mode")
        self.errorHandler.handleResult(pcap_set_rfmon(descr, 1), message: "Couldn't set monitor mode")
        self.errorHandler.handleResult(pcap_activate(descr), message: "Error activating")
        
        println("Datalink Name: \(String.fromCString(pcap_datalink_val_to_name(pcap_datalink(descr)))!)")
        println("Datalink Description: \(String.fromCString(pcap_datalink_val_to_description(pcap_datalink(descr)))!)")
        
        self.callbackManager.registerPacketCallbackWithDescriptor(descr, withBlock: {(packet: RadioTapPacket!) -> Void in
            var outputString = "(\(packet.frameControl!.frameControlType.simpleDescription()))"
            outputString += " \(packet.frameControl!.frameControlSubType.simpleDescription())"
            outputString += " Size: \(packet.rawData.length)"

            var showOutput = false
            if packet.frameControl?.frameControlType == FrameControl.FrameControlType.Management {
                if packet.frameControl?.frameControlSubType == FrameControl.FrameControlSubType.Authentication {

                    if  packet.managementFrame?.destAddr != nil {
                        outputString += " DEST: \(packet.managementFrame!.destAddrString!)"
                        if (packet.managementFrame?.destAddrString! == "e4:98:d6:3:90:e4") {
                            showOutput = true
                        }
                    }

                    if  (packet.managementFrame?.sourceAddr != nil) {
                        outputString += " SOURCE: \(packet.managementFrame!.sourceAddrString!)"
                        if (packet.managementFrame?.sourceAddrString! == "e4:98:d6:3:90:e4") {
                            showOutput = true
                        }
                    }
                    
                }
            } else if packet.frameControl?.frameControlType == FrameControl.FrameControlType.Data {

                if  packet.dataFrame?.destAddr != nil {
                    outputString += " DEST: \(packet.dataFrame!.destAddrString!)"
                    if (packet.dataFrame?.destAddrString! == "e4:98:d6:3:90:e4") {
                        showOutput = true
                    }
                }
                
                if  (packet.dataFrame?.sourceAddr != nil) {
                    outputString += " SOURCE: \(packet.dataFrame!.sourceAddrString!)"
                    if (packet.dataFrame?.sourceAddrString! == "e4:98:d6:3:90:e4") {
                        showOutput = true
                    }
                }
                
            }
            if showOutput {
                println(outputString)
            }
        })
    }

}
