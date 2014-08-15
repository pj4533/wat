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
    let deviceName: String
    
    init(deviceName: String) {
        self.deviceName = deviceName
        self.errorHandler = ErrorHandler()
        
        super.init()
    }
    
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
    }

}