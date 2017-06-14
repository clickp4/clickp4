#ifndef MODULE
#define MODULE firewall

/**
 * Simple firewall module 
 */

#ifndef FW_TBL_SZ
#define FW_TBL_SZ 1024
#endif

table firewall {
    reads {
        ipv4.src_addr : ternary;
        ipv4.dst_addr : ternary;
        ipv6.src_addr : ternary;
        ipv6.dst_addr : ternary;
        tcp.src_port  : ternary;
        tcp.dst_port  : ternary;
        udp.src_port  : ternary;
        udp.dst_port  : ternary;
    }
    actions {
        block_;
        nop;
    }
    size : 1024;
}

MODULE_INGRESS(fw) {
    apply(firewall);
}


#undef MODULE
#endif