/**
 * Hash
 * P4 186
 * ClickP4 188
 * Modified 3
 */
#define MODULE simple_hash

#ifndef IPv4_HASH1_ALG
#define IPv4_HASH1_ALG crc16
#endif

#ifndef IPv4_HASH2_ALG
#define IPv4_HASH2_ALG crc16
#endif

#ifndef IPv6_HASH1_ALG
#define IPv6_HASH1_ALG crc16
#endif

#ifndef IPv6_HASH2_ALG
#define IPv6_HASH2_ALG crc16
#endif


#ifndef L2_HASH_ALG
#define L2_HASH_ALG crc16
#endif

#ifndef IPv4_HASH1_FIELDS 
#define IPv4_HASH1_FIELDS \
    ipv4.src_addr; \
    ipv4.dst_addr; \
    ipv4.proto;    \
    tcp.src_port;  \ 
    tcp.dst_port;  \
    udp.src_port;  \
    udp.dst_port
#endif

#ifndef IPv4_HASH2_FIELDS 
#define IPv4_HASH2_FIELDS \
    ethernet.src_addr; \
    ethernet.dst_addr; \
    ipv4.src_addr; \
    ipv4.dst_addr; \
    ipv4.proto;    \
    tcp.src_port;  \ 
    tcp.dst_port;  \
    udp.src_port;  \
    udp.dst_port
#endif


#ifndef IPv6_HASH1_FIELDS 
#define IPv6_HASH1_FIELDS \
    ipv6.src_addr; \
    ipv6.dst_addr; \
    ipv6.next_hdr; \
    tcp.src_port; \
    tcp.dst_port; \
    udp.src_port; \
    udp.dst_port 
#endif

#ifndef IPv6_HASH2_FIELDS 
#define IPv6_HASH2_FIELDS \
    ethernet.src_addr; \
    ethernet.dst_addr; \
    ipv6.src_addr; \
    ipv6.dst_addr; \
    ipv6.next_hdr; \
    tcp.src_port; \
    tcp.dst_port; \
    udp.src_port; \
    udp.dst_port 
#endif


#ifndef L2_HASH_FIELDS 
#define L2_HASH_FIELDS \
    standard_metadata.ingress_port; \
    ethernet.src_addr; 				\
    ethernet.dst_addr;				\
    ethernet.eth_type
#endif


field_list lkp_ipv4_hash1_fields {
	IPv4_HASH1_FIELDS;
}

field_list lkp_ipv4_hash2_fields {
	IPv4_HASH2_FIELDS;
}

field_list_calculation lkp_ipv4_hash1 {
    input {
        lkp_ipv4_hash1_fields;
    }
    algorithm : IPv4_HASH1_ALG;
    output_width : 16;
}

field_list_calculation lkp_ipv4_hash2 {
    input {
        lkp_ipv4_hash2_fields;
    }
    algorithm : IPv4_HASH2_ALG;
    output_width : 16;
}

action compute_lkp_ipv4_hash() {
    modify_field_with_hash_based_offset(hash_metadata.hash1, 0,
                                        lkp_ipv4_hash1, 65536);
    modify_field_with_hash_based_offset(hash_metadata.hash2, 0,
                                        lkp_ipv4_hash2, 65536);
}

field_list lkp_ipv6_hash1_fields {
	IPv6_HASH1_FIELDS;
}

field_list lkp_ipv6_hash2_fields {
	IPv6_HASH2_FIELDS;
}

field_list_calculation lkp_ipv6_hash1 {
    input {
        lkp_ipv6_hash1_fields;
    }
    algorithm : IPv6_HASH1_ALG;
    output_width : 16;
}

field_list_calculation lkp_ipv6_hash2 {
    input {
        lkp_ipv6_hash2_fields;
    }
    algorithm : IPv6_HASH2_ALG;
    output_width : 16;
}

action compute_lkp_ipv6_hash() {

    modify_field_with_hash_based_offset(hash_metadata.hash1, 0,
                                        lkp_ipv6_hash1, 65536);

    modify_field_with_hash_based_offset(hash_metadata.hash2, 0,
                                        lkp_ipv6_hash2, 65536);
}

field_list lkp_non_ip_hash2_fields {
	L2_HASH_FIELDS;
}

field_list_calculation lkp_non_ip_hash2 {
    input {
        lkp_non_ip_hash2_fields;
    }
    algorithm : L2_HASH_ALG;
    output_width : 16;
}

action compute_lkp_non_ip_hash() {
    modify_field_with_hash_based_offset(hash_metadata.hash2, 0,
                                        lkp_non_ip_hash2, 65536);
}

table compute_ipv4_hashes {
    actions {
        compute_lkp_ipv4_hash;
    }
}

table compute_ipv6_hashes {
    actions {
        compute_lkp_ipv6_hash;
    }
}

table compute_non_ip_hashes {
    actions {
        compute_lkp_non_ip_hash;
    }
}

MODULE_INGRESS(simple_hash) {
    if (valid(ipv4))
        apply(compute_ipv4_hashes);
    }
    else if (valid(ipv6)){
    	apply(compute_ipv6_hashes);
    }
    else {
        apply(compute_non_ip_hashes);
    }
}
#undef MODULE