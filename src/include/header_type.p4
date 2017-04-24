#ifndef __CLICK_HEADER_TYPE__
#define __CLICK_HEADER_TYPE__

/**
 * Packet Header Type
 */

/**
 * Ethernet header type.
 */
header_type ethernet_t {
    fields {
        dst_addr : 48;
        src_addr : 48;
        eth_type : 16;
    }
}

/**
 * VLAN header type.
 */
header_type vlan_t {
    fields {
        pcp : 3;
        cfi : 1;
        vid : 12;
        eth_type : 16;
    }
}

/**
 * MPLS header type.
 */
header_type mpls_t {
    fields {
        label : 20;
        exp : 3;
        bos : 1;
        ttl : 8;
    }
}

/**
 * IPv4 header type.
 */
header_type ipv4_t {
    fields {
        version : 4;
        ihl : 4;
        diffserv : 8;
        totalLen : 16;
        identification : 16;
        flags : 3;
        frag_offset : 13;
        ttl : 8;
        protocol : 8;
        checksum : 16;
        src_addr : 32;
        dst_addr: 32;
    }
}

/**
 * IPv6 header type.
 */
header_type ipv6_t {
    fields {
        version : 4;
        traffic_class : 8;
        flow_label : 20;
        payload_len : 16;
        next_hdr : 8;
        hop_limit : 8;
        src_addr : 128;
        dst_addr : 128;
    }
}

/**
 * ICMP header type.
 */
header_type icmp_t {
    fields {
        typeCode : 16;
        hdrChecksum : 16;
    }
}


/**
 * TCP header type.
 */
header_type tcp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        seqNo : 32;
        ackNo : 32;
        dataOffset : 4;
        res : 4;
        flags : 8;
        window : 16;
        checksum : 16;
        urgentPtr : 16;
    }
}


/**
 * UDP header type.
 */
header_type udp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        length_ : 16;
        checksum : 16;
    }
}


/**
 * SCTP header type.
 */
header_type sctp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        verifTag : 32;
        checksum : 32;
    }
}

/**
 * GRE header type.
 */
header_type gre_t {
    fields {
        C : 1;
        R : 1;
        K : 1;
        S : 1;
        s : 1;
        recurse : 3;
        flags : 5;
        ver : 3;
        proto : 16;
    }
}


/**
 * NVGRE header type.
 */
header_type nvgre_t {
    fields {
        tni : 24;
        flow_id : 8;
    }
}


/**
 * ARP header type.
 */
header_type arp_t {
    fields {
        hwType : 16;
        protoType : 16;
        hwAddrLen : 8;
        protoAddrLen : 8;
        opcode : 16;
        srcHwAddr : 48;
        srcProtoAddr : 32;
        dstHwAddr : 48;
        dstProtoAddr : 32;
    }
}

/**
 * VXLAN header type.
 */
header_type vxlan_t {
    fields {
        flags : 8;
        reserved : 24;
        vni : 24;
        reserved2 : 8;
    }
}


/**
 * INT header type.
 */
header_type int_t {
    fields {
        ver                     : 2;
        rep                     : 2;
        c                       : 1;
        e                       : 1;
        rsvd1                   : 5;
        ins_cnt                 : 5;
        max_hop_cnt             : 8;
        total_hop_cnt           : 8;
        instruction_mask_0003   : 4;   // split the bits for lookup
        instruction_mask_0407   : 4;
        instruction_mask_0811   : 4;
        instruction_mask_1215   : 4;
        rsvd2                   : 16;
    }
}
header_type int_switch_id_header_t {
    fields {
        bos                 : 1;
        switch_id           : 31;
    }
}
header_type int_ingress_port_id_header_t {
    fields {
        bos                 : 1;
        ingress_port_id_1   : 15;
        ingress_port_id_0   : 16;
    }
}
header_type int_hop_latency_header_t {
    fields {
        bos                 : 1;
        hop_latency         : 31;
    }
}
header_type int_q_occupancy_header_t {
    fields {
        bos                 : 1;
        q_occupancy1        : 7;
        q_occupancy0        : 24;
    }
}
header_type int_ingress_tstamp_header_t {
    fields {
        bos                 : 1;
        ingress_tstamp      : 31;
    }
}
header_type int_egress_port_id_header_t {
    fields {
        bos                 : 1;
        egress_port_id      : 31;
    }
}
header_type int_q_congestion_header_t {
    fields {
        bos                 : 1;
        q_congestion        : 31;
    }
}
header_type int_egress_port_tx_utilization_header_t {
    fields {
        bos                         : 1;
        egress_port_tx_utilization  : 31;
    }
}
header_type int_value_t {
    fields {
        bos         : 1;
        val         : 31;
    }
}



/**
 * Metadata.
 */

header_type click_metadata_t {
    fields {
        click_bitmap : 64; // Supprort 64 mododules now.
        click_id      : 32; // Chain ID.
        click_state   : 8 ; // Chain state.
        click_input   : 8 ;
    }
}

#endif