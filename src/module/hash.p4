/**
 * Hash
 * P4 186
 * ClickP4 188
 * Modified 3
 */
#define MODULE HASH



/*****************************************************
 Defining metadata
 *****************************************************/

#include"../context/ipv4.p4"
#include"../context/ipv6.p4"
#include"../context/hash.p4"
#include"../context/tunnel.p4"
#include"../context/l2.p4"
#include"../context/l3.p4"

header_type ingress_metadata_t {
    fields {
        ingress_port : 9;                      /* input physical port */
        ifindex : IFINDEX_BIT_WIDTH;           /* input interface index */
        egress_ifindex : IFINDEX_BIT_WIDTH;    /* egress interface index */
        port_type : 2;                         /* ingress port type */

        outer_bd : BD_BIT_WIDTH;               /* outer BD */
        bd : BD_BIT_WIDTH;                     /* BD */

        drop_flag : 1;                         /* if set, drop the packet */
        drop_reason : 8;                       /* drop reason */
        control_frame: 1;                      /* control frame */
        bypass_lookups : 16;                   /* list of lookups to skip */
        sflow_take_sample : 32 (saturating);
    }
}

metadata ingress_metadata_t ingress_metadata;

header_type hashtarget_intrinsic_metadata_t {
    fields {
        resubmit_flag : 1;              // flag distinguishing original packets
        ingress_global_timestamp : 48;     // global timestamp (ns) taken upon
        mcast_grp : 16;                 // multicast group id (key for the
        deflection_flag : 1;            // flag indicating whether a packet is
        deflect_on_drop : 1;            // flag indicating whether a packet can
        enq_congest_stat : 2;           // queue congestion status at the packet
        deq_congest_stat : 2;           // queue congestion status at the packet
        mcast_hash : 13;                // multicast hashing
        egress_rid : 16;                // Replication ID for multicast
        lf_field_list : 32;             // Learn filter field list
        priority : 3;                   // set packet priority
        ingress_cos: 3;                 // ingress cos
        packet_color: 2;                // packet color
        qid: 5;                         // queue id
    }
}
metadata hashtarget_intrinsic_metadata_t hashtarget_intrinsic_metadata;



field_list lkp_ipv4_hash1_fields {
    ipv4_metadata.lkp_ipv4_sa;
    ipv4_metadata.lkp_ipv4_da;
    l3_metadata.lkp_ip_proto;
    l3_metadata.lkp_l4_sport;
    l3_metadata.lkp_l4_dport;
}

field_list lkp_ipv4_hash2_fields {
    l2_metadata.lkp_mac_sa;
    l2_metadata.lkp_mac_da;
    ipv4_metadata.lkp_ipv4_sa;
    ipv4_metadata.lkp_ipv4_da;
    l3_metadata.lkp_ip_proto;
    l3_metadata.lkp_l4_sport;
    l3_metadata.lkp_l4_dport;
}

field_list_calculation lkp_ipv4_hash1 {
    input {
        lkp_ipv4_hash1_fields;
    }
    algorithm : crc16;
    output_width : 16;
}

field_list_calculation lkp_ipv4_hash2 {
    input {
        lkp_ipv4_hash2_fields;
    }
    algorithm : crc16;
    output_width : 16;
}

action compute_lkp_ipv4_hash() {
    modify_field_with_hash_based_offset(hash_metadata.hash1, 0,
                                        lkp_ipv4_hash1, 65536);
    modify_field_with_hash_based_offset(hash_metadata.hash2, 0,
                                        lkp_ipv4_hash2, 65536);
}

field_list lkp_ipv6_hash1_fields {
    ipv6_metadata.lkp_ipv6_sa;
    ipv6_metadata.lkp_ipv6_da;
    l3_metadata.lkp_ip_proto;
    l3_metadata.lkp_l4_sport;
    l3_metadata.lkp_l4_dport;
}

field_list lkp_ipv6_hash2_fields {
    l2_metadata.lkp_mac_sa;
    l2_metadata.lkp_mac_da;
    ipv6_metadata.lkp_ipv6_sa;
    ipv6_metadata.lkp_ipv6_da;
    l3_metadata.lkp_ip_proto;
    l3_metadata.lkp_l4_sport;
    l3_metadata.lkp_l4_dport;
}

field_list_calculation lkp_ipv6_hash1 {
    input {
        lkp_ipv6_hash1_fields;
    }
    algorithm : crc16;
    output_width : 16;
}

field_list_calculation lkp_ipv6_hash2 {
    input {
        lkp_ipv6_hash2_fields;
    }
    algorithm : crc16;
    output_width : 16;
}

action compute_lkp_ipv6_hash() {

    modify_field_with_hash_based_offset(hash_metadata.hash1, 0,
                                        lkp_ipv6_hash1, 65536);

    modify_field_with_hash_based_offset(hash_metadata.hash2, 0,
                                        lkp_ipv6_hash2, 65536);
}

field_list lkp_non_ip_hash2_fields {
    ingress_metadata.ifindex;
    l2_metadata.lkp_mac_sa;
    l2_metadata.lkp_mac_da;
    l2_metadata.lkp_mac_type;
}

field_list_calculation lkp_non_ip_hash2 {
    input {
        lkp_non_ip_hash2_fields;
    }
    algorithm : crc16;
    output_width : 16;
}

action compute_lkp_non_ip_hash() {
    modify_field_with_hash_based_offset(hash_metadata.hash2, 0,
                                        lkp_non_ip_hash2, 65536);
}

table compute_ipv4_hashes {
    reads {
        ingress_metadata.drop_flag : exact;
    }
    actions {
        compute_lkp_ipv4_hash;
    }
}

table compute_ipv6_hashes {
    reads {
        ingress_metadata.drop_flag : exact;
    }
    actions {
        compute_lkp_ipv6_hash;
    }
}

table compute_non_ip_hashes {
    reads {
        ingress_metadata.drop_flag : exact;
    }
    actions {
        compute_lkp_non_ip_hash;
    }
}

action computed_two_hashes() {
    modify_field(hashtarget_intrinsic_metadata.mcast_hash, hash_metadata.hash1);
    modify_field(hash_metadata.entropy_hash, hash_metadata.hash2);
}

action computed_one_hash() {
    modify_field(hash_metadata.hash1, hash_metadata.hash2);
    modify_field(hashtarget_intrinsic_metadata.mcast_hash, hash_metadata.hash2);
    modify_field(hash_metadata.entropy_hash, hash_metadata.hash2);
}

table compute_other_hashes {
    reads {
        hash_metadata.hash1 : exact;
    }
    actions {
        computed_two_hashes;
        computed_one_hash;
    }
}

MODULE_INGRESS(hash) {
    if (((tunnel_metadata.tunnel_terminate == FALSE) and valid(ipv4)) or
        ((tunnel_metadata.tunnel_terminate == TRUE) and valid(inner_ipv4))) {
#ifndef IPV4_DISABLE
        apply(compute_ipv4_hashes);
#endif /* IPV4_DISABLE */
    }
#ifndef IPV6_DISABLE
    else {
        if (((tunnel_metadata.tunnel_terminate == FALSE) and valid(ipv6)) or
             ((tunnel_metadata.tunnel_terminate == TRUE) and valid(inner_ipv6))) {
            apply(compute_ipv6_hashes);
        }
#endif /* IPV6_DISABLE */
        else {
#ifndef L2_DISABLE
            apply(compute_non_ip_hashes);
#endif /* L2_DISABLE */
        }
#ifndef IPV6_DISABLE
    }
#endif /* IPV6_DISABLE */
    apply(compute_other_hashes);
}
#undef MODULE