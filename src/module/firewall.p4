#define MODULE firewall

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
}

table forward_table {
    reads {
        standard_metadata.ingress_port : exact;
    }
    actions {
        forward;
    }
}

MODULE_INGRESS(firewall) {
    apply(forward_table);
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
