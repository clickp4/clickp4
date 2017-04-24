
/*
 * IPv6 Metadata
 */
header_type ipv6_metadata_t {
    fields {
        lkp_ipv6_sa : 128;                     /* ipv6 source address */
        lkp_ipv6_da : 128;                     /* ipv6 destination address*/

        ipv6_unicast_enabled : 1;              /* is ipv6 unicast routing enabled on BD */
        ipv6_src_is_link_local : 1;            /* source is link local address */
        ipv6_urpf_mode : 2;                    /* 0: none, 1: strict, 3: loose */
    }
}
metadata ipv6_metadata_t ipv6_metadata;