//
//  SGSPacketCallbackManager.h
//  wat
//
//  Created by PJ Gray on 8/15/14.
//  Copyright (c) 2014 Say Goodnight Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pcap/pcap.h>

typedef void (^PacketCallback)(const struct pcap_pkthdr* pkthdr, const u_char * packet);

@interface SGSPacketCallbackManager : NSObject

- (void)registerPacketCallbackWithDescriptor:(pcap_t*)descr withBlock:(PacketCallback) block;

@end
