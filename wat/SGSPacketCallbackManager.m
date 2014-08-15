//
//  SGSPacketCallbackManager.m
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

#import "SGSPacketCallbackManager.h"

PacketCallback gCallback = nil;

@implementation SGSPacketCallbackManager

void processPacket(u_char *arg, const struct pcap_pkthdr* pkthdr, const u_char * packet){
    if (gCallback) {
        gCallback(pkthdr, packet);
    }
}

- (void)registerPacketCallbackWithDescriptor:(pcap_t*)descr withBlock:(PacketCallback) block {
    gCallback = block;
    
    int count=0;
    pcap_loop(descr, -1, processPacket, (u_char *)&count);
}

@end
