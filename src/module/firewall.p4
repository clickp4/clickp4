#define MODULE firewall

table firewall_with_tcp {
    reads {
        ipv4.srcAddr : ternary;
        ipv4.dstAddr : ternary;
        tcp.srcPort  : ternary;
        tcp.dstPort  : ternary;
    }
    actions {
        block;
        nop;
    }
}

table firewall_with_udp {
    reads {
        ipv4.srcAddr : ternary;
        ipv4.dstAddr : ternary;
        udp.srcPort  : ternary;
        udp.dstPort  : ternary;
    }
    actions {
        block;
        noop;
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