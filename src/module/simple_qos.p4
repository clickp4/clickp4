#ifndef MODULE
#define MODULE simple_qos


#ifndef SIMPLE_QOS_TBL_SZ
#define SIMPLE_QOS_TBL_SZ 1024
#endif


action set_priority(p) {
    modify_field(qos_metadata.priority, p);
}

table qos {
    reads {
        ipv4.src_addr : ternary;
        ipv4.dst_addr : ternary;
        ipv4.proto : ternary;
#ifdef L4_METADATA
        l4_metadata.src_port : ternary;
        l4_metadata.dst_port : ternary;
#else 
        tcp.src_port : ternary;
        tcp.dst_port : ternary;
        udp.src_port : ternary;
        udp.dst_port : ternary;
#endif

    }
    actions {
        nop;
        set_priority;
    }
    size : SIMPLE_QOS_TBL_SZ;
}

MODULE_INGRESS(simple_qos) {
    apply(qos);
}
#undef MODULE
#endif