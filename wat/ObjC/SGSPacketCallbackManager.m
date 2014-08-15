//
//  SGSPacketCallbackManager.m
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

#import "SGSPacketCallbackManager.h"
#import "wat-Swift.h"

PacketCallback gCallback = nil;

@implementation SGSPacketCallbackManager

void processPacket(u_char *arg, const struct pcap_pkthdr* pkthdr, const u_char * packet){
    
    NSData* packetData = [NSData dataWithBytes:packet length:pkthdr->len];
    pkthdr_t nonConstPkthdr = (pkthdr_t) pkthdr; // :notsureif:
    
    // Assuming RadioTap packet header for now -- could check for this in PacketManager by looking at the datalink type
    RadioTapPacket* packetModel = [[RadioTapPacket alloc] initWithPcapHeader:nonConstPkthdr rawData:packetData];
    
    if (gCallback) {
        gCallback(packetModel);
    }
}

- (void)registerPacketCallbackWithDescriptor:(pcap_t*)descr withBlock:(PacketCallback) block {
    gCallback = block;
    
    int count=0;
    pcap_loop(descr, -1, processPacket, (u_char *)&count);
}

@end
