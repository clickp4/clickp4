#ifndef TCP_PROTO

#define TCP_PROTO
header_type tcp_t {
    fields {
        src_port : 16;
        dst_port : 16;
        seq_no : 32;
        ack_no : 32;
        data_offset : 4;
        res : 4;
        flags : 8;
        window : 16;
        checksum : 16;
        urgent_ptr : 16;
    }
}

header tcp_t tcp;

parser parse_tcp {
    extract(tcp);
#ifdef L4_METADATA
    set_metadata(l4_metadata.src_port, tcp.src_port);
    set_metadata(l4_metadata.dst_port, tcp.dst_port);
    set_metadata(l4_metadata.l4_type, L4_TYPE_TCP);
#endif
    return ingress;
}

#endif