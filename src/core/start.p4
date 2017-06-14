#ifndef __CLICK_START__
#define __CLICK_START__

#include "macro.p4"

#ifndef INIT_ETH_MATCH
#define INIT_ETH_MATCH \
            ethernet.dst_addr: ternary; \
            ethernet.src_addr: ternary; \
            ethernet.eth_type: ternary;
#endif

#ifndef INIT_IPv4_MATCH 
#define INIT_IPv4_MATCH  \
            ipv4.dst_addr : ternary; \
            ipv4.src_addr : ternary; \
            ipv4.proto    : ternary;
#endif

#ifndef INIT_IPv6_MATCH
#define INIT_IPv6_MATCH \
        ipv6.dst_addr : ternary; \
        ipv6.src_addr : ternary; \
        ipv6.next_hdr : ternary;
#endif


#ifndef INIT_TCP_MATCH
#define INIT_TCP_MATCH \
            tcp.dst_port : ternary; \
            tcp.src_port : ternary;
#endif

#ifndef INIT_UDP_MATCH
#define INIT_UDP_MATCH \
            udp.dst_port : ternary; \
            udp.src_port : ternary;
#endif

#ifndef INIT_MATCH
#define INIT_MATCH
#endif


action act_set_chain(chain_id, bitmap) {
    SET_CLICK_ID(chain_id);
    SET_CLICK_BITMAP(bitmap);
}

action act_set_bitmap(bitmap) {
    SET_CLICK_BITMAP(bitmap);
}

table tbl_pipeline_start {
    reads {
        INIT_MATCH
        INIT_ETH_MATCH
        INIT_IPv4_MATCH
        INIT_TCP_MATCH
        INIT_UDP_MATCH
    }
    
    actions {
        act_set_chain;
        act_set_bitmap;
    }
    
}

control pipeline_start {
    apply(tbl_pipeline_start);
}

#endif
