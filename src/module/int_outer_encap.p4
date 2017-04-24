/**
 * P4 59
 * ClickP4 61
 * Modified 4
 */
#define MODULE INIT_OUTER_ENCAP 
#ifdef INT_ENABLE
action int_update_vxlan_gpe_ipv4() {
    add_to_field(ipv4.totalLen, int_metadata.insert_byte_cnt);
    add_to_field(udp.length_, int_metadata.insert_byte_cnt);
    add_to_field(vxlan_gpe_int_header.len, int_metadata.gpe_int_hdr_len8);
}

action int_add_update_vxlan_gpe_ipv4() {
    // INT source - vxlan gpe header is already added (or present)
    // Add the INT shim header for vxlan GPE
    add_header(vxlan_gpe_int_header);
    modify_field(vxlan_gpe_int_header.int_type, 0x01);
    modify_field(vxlan_gpe_int_header.next_proto, 3); // Ethernet
    modify_field(vxlan_gpe.next_proto, 5); // Set proto = INT
    modify_field(vxlan_gpe_int_header.len, int_metadata.gpe_int_hdr_len8);
    add_to_field(ipv4.totalLen, int_metadata.insert_byte_cnt);
    add_to_field(udp.length_, int_metadata.insert_byte_cnt);
}

table int_outer_encap {
    /* REMOVE from open-srouce version -
     * ipv4 and gpe valid bits are used as key so that other outer protocols
     * can be added in future. Table size
     */
    // This table is applied only if it is decided to add INT info
    // as part of transit or source functionality
    // based on outer(underlay) encap, vxlan-GPE, Geneve, .. update
    // outer headers, options, IP total len etc.
    // {int_src, vxlan_gpe, egr_tunnel_type} :
    //      0, 0, X : nop (error)
    //      0, 1, X : update_vxlan_gpe_int (transit case)
    //      1, 0, tunnel_gpe : add_update_vxlan_gpe_int
    //      1, 1, X : add_update_vxlan_gpe_int
    //      miss => nop
    reads {
        ipv4                                : valid;
        vxlan_gpe                           : valid;
        int_metadata_i2e.source             : exact;
        tunnel_metadata.egress_tunnel_type  : ternary;
    }
    actions {
#ifdef INT_TRANSIT_ENABLE
        int_update_vxlan_gpe_ipv4;
#endif
#ifdef INT_EP_ENABLE
        int_add_update_vxlan_gpe_ipv4;
#endif
        nop;
    }
    size : 1024;
}
#endif

MODULE_INGRESS(int_outer_encap) {
#ifdef INT_ENABLE
    if (int_metadata.insert_cnt != 0) {
        apply(int_outer_encap);
    }
#endif
}
#undef MODULE