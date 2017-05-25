#ifndef MODULE
#define MODULE firewall

/**
 * Simple firewall module 
 */

#ifndef FW_TBL_SZ
#define FW_TBL_SZ 1024
#endif

table firewall_with_tcp {
    reads {
        ipv4.src_addr : ternary;
        ipv4.dst_addr : ternary;
        tcp.src_port  : ternary;
        tcp.dst_port  : ternary;
    }
    actions {
        block;
        nop;
    }
    size : FW_TBL_SZ;
}

table firewall_with_udp {
    reads {
        ipv4.src_addr : ternary;
        ipv4.dst_addr : ternary;
        udp.src_port  : ternary;
        udp.dst_port  : ternary;
    }
    actions {
        block;
        nop;
    }
    size : FW_TBL_SZ;
}

MODULE_INGRESS(firewall) {
    if (valid(ipv4)) {
        if(valid(udp)) {
            apply(firewall_with_udp);
        }
        else if(valid(tcp)) {
            apply(firewall_with_tcp);
        }
    }
}


#undef MODULE
#endif