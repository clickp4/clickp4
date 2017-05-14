#ifndef __CLICK_CONTEXT_TUNNEL__
#define __CLICK_CONTEXT_TUNNEL__
/*
 * Tunnel metadata
 */
header_type tunnel_metadata_t {
    fields {
        ingress_tunnel_type : 5;               /* tunnel type from parser */
        tunnel_vni : 24;                       /* tunnel id */
        mpls_enabled : 1;                      /* is mpls enabled on BD */
        mpls_label: 20;                        /* Mpls label */
        mpls_exp: 3;                           /* Mpls Traffic Class */
        mpls_ttl: 8;                           /* Mpls Ttl */
        egress_tunnel_type : 5;                /* type of tunnel */
        tunnel_index: 14;                      /* tunnel index */
        tunnel_src_index : 9;                  /* index to tunnel src ip */
        tunnel_smac_index : 9;                 /* index to tunnel src mac */
        tunnel_dst_index : 14;                 /* index to tunnel dst ip */
        tunnel_dmac_index : 14;                /* index to tunnel dst mac */
        vnid : 24;                             /* tunnel vnid */
        tunnel_terminate : 1;                  /* is tunnel being terminated? */
        tunnel_if_check : 1;                   /* tun terminate xor originate */
        egress_header_count: 4;                /* number of mpls header stack */
        inner_ip_proto : 8;                    /* Inner IP protocol */
        skip_encap_inner : 1;                  /* skip encap_process_inner */
    }
}
metadata tunnel_metadata_t tunnel_metadata;

header ethernet_t inner_ethernet;
header ipv4_t inner_ipv4;
header ipv6_t inner_ipv6;

#endif