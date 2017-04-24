/**
 * P4 492
 * ClickP4 494
 * 2 + 
 */
#define MODULE init_endpoint
#ifdef INT_ENABLE
/* Instr Bit 0 */
action int_set_header_0() { //switch_id
    add_header(int_switch_id_header);
    modify_field(int_switch_id_header.switch_id, int_metadata.switch_id);
}
/* Instr Bit 1 */
action int_set_header_1() { //ingress_port_id
    add_header(int_ingress_port_id_header);
    modify_field(int_ingress_port_id_header.ingress_port_id_1, 0);
    modify_field(int_ingress_port_id_header.ingress_port_id_0,
                    ingress_metadata.ifindex);
}
/* Instr Bit 2 */
action int_set_header_2() { //hop_latency
    add_header(int_hop_latency_header);
    modify_field(int_hop_latency_header.hop_latency,
                    queueing_metadata.deq_timedelta);
}
/* Instr Bit 3 */
action int_set_header_3() { //q_occupancy
    add_header(int_q_occupancy_header);
    modify_field(int_q_occupancy_header.q_occupancy1, 0);
    modify_field(int_q_occupancy_header.q_occupancy0,
                    queueing_metadata.enq_qdepth);
}
/* Instr Bit 4 */
action int_set_header_4() { //ingress_tstamp
    add_header(int_ingress_tstamp_header);
    modify_field(int_ingress_tstamp_header.ingress_tstamp,
                                            i2e_metadata.ingress_tstamp);
}
/* Instr Bit 5 */
action int_set_header_5() { //egress_port_id
    add_header(int_egress_port_id_header);
    modify_field(int_egress_port_id_header.egress_port_id,
                    standard_metadata.egress_port);
}

/* Instr Bit 6 */
action int_set_header_6() { //q_congestion
    add_header(int_q_congestion_header);
    modify_field(int_q_congestion_header.q_congestion, 0x7FFFFFFF);
}
/* Instr Bit 7 */
action int_set_header_7() { //egress_port_tx_utilization
    add_header(int_egress_port_tx_utilization_header);
    modify_field(int_egress_port_tx_utilization_header.egress_port_tx_utilization, 0x7FFFFFFF);
}

/* action function for bits 0-3 combinations, 0 is msb, 3 is lsb */
/* Each bit set indicates that corresponding INT header should be added */
action int_set_header_0003_i0() {
}
action int_set_header_0003_i1() {
    int_set_header_3();
}
action int_set_header_0003_i2() {
    int_set_header_2();
}
action int_set_header_0003_i3() {
    int_set_header_3();
    int_set_header_2();
}
action int_set_header_0003_i4() {
    int_set_header_1();
}
action int_set_header_0003_i5() {
    int_set_header_3();
    int_set_header_1();
}
action int_set_header_0003_i6() {
    int_set_header_2();
    int_set_header_1();
}
action int_set_header_0003_i7() {
    int_set_header_3();
    int_set_header_2();
    int_set_header_1();
}
action int_set_header_0003_i8() {
    int_set_header_0();
}
action int_set_header_0003_i9() {
    int_set_header_3();
    int_set_header_0();
}
action int_set_header_0003_i10() {
    int_set_header_2();
    int_set_header_0();
}
action int_set_header_0003_i11() {
    int_set_header_3();
    int_set_header_2();
    int_set_header_0();
}
action int_set_header_0003_i12() {
    int_set_header_1();
    int_set_header_0();
}
action int_set_header_0003_i13() {
    int_set_header_3();
    int_set_header_1();
    int_set_header_0();
}
action int_set_header_0003_i14() {
    int_set_header_2();
    int_set_header_1();
    int_set_header_0();
}
action int_set_header_0003_i15() {
    int_set_header_3();
    int_set_header_2();
    int_set_header_1();
    int_set_header_0();
}

/* Table to process instruction bits 0-3 */
table int_inst_0003 {
    reads {
        int_header.instruction_mask_0003 : exact;
    }
    actions {
        int_set_header_0003_i0;
        int_set_header_0003_i1;
        int_set_header_0003_i2;
        int_set_header_0003_i3;
        int_set_header_0003_i4;
        int_set_header_0003_i5;
        int_set_header_0003_i6;
        int_set_header_0003_i7;
        int_set_header_0003_i8;
        int_set_header_0003_i9;
        int_set_header_0003_i10;
        int_set_header_0003_i11;
        int_set_header_0003_i12;
        int_set_header_0003_i13;
        int_set_header_0003_i14;
        int_set_header_0003_i15;
    }
    size : 17;
}

/* action function for bits 4-7 combinations, 4 is msb, 7 is lsb */
action int_set_header_0407_i0() {
}
action int_set_header_0407_i1() {
    int_set_header_7();
}
action int_set_header_0407_i2() {
    int_set_header_6();
}
action int_set_header_0407_i3() {
    int_set_header_7();
    int_set_header_6();
}
action int_set_header_0407_i4() {
    int_set_header_5();
}
action int_set_header_0407_i5() {
    int_set_header_7();
    int_set_header_5();
}
action int_set_header_0407_i6() {
    int_set_header_6();
    int_set_header_5();
}
action int_set_header_0407_i7() {
    int_set_header_7();
    int_set_header_6();
    int_set_header_5();
}
action int_set_header_0407_i8() {
    int_set_header_4();
}
action int_set_header_0407_i9() {
    int_set_header_7();
    int_set_header_4();
}
action int_set_header_0407_i10() {
    int_set_header_6();
    int_set_header_4();
}
action int_set_header_0407_i11() {
    int_set_header_7();
    int_set_header_6();
    int_set_header_4();
}
action int_set_header_0407_i12() {
    int_set_header_5();
    int_set_header_4();
}
action int_set_header_0407_i13() {
    int_set_header_7();
    int_set_header_5();
    int_set_header_4();
}
action int_set_header_0407_i14() {
    int_set_header_6();
    int_set_header_5();
    int_set_header_4();
}
action int_set_header_0407_i15() {
    int_set_header_7();
    int_set_header_6();
    int_set_header_5();
    int_set_header_4();
}

/* Table to process instruction bits 4-7 */
table int_inst_0407 {
    reads {
        int_header.instruction_mask_0407 : exact;
    }
    actions {
        int_set_header_0407_i0;
        int_set_header_0407_i1;
        int_set_header_0407_i2;
        int_set_header_0407_i3;
        int_set_header_0407_i4;
        int_set_header_0407_i5;
        int_set_header_0407_i6;
        int_set_header_0407_i7;
        int_set_header_0407_i8;
        int_set_header_0407_i9;
        int_set_header_0407_i10;
        int_set_header_0407_i11;
        int_set_header_0407_i12;
        int_set_header_0407_i13;
        int_set_header_0407_i14;
        int_set_header_0407_i15;
        nop;
    }
    size : 17;
}

/* instruction mask bits 8-15 are not defined in the current spec */
table int_inst_0811 {
    reads {
        int_header.instruction_mask_0811 : exact;
    }
    actions {
        nop;
    }
    size : 16;
}

table int_inst_1215 {
    reads {
        int_header.instruction_mask_1215 : exact;
    }
    actions {
        nop;
    }
    size : 17;
}

/* BOS bit - set for the bottom most header added by INT src device */
action int_set_header_0_bos() { //switch_id
    modify_field(int_switch_id_header.bos, 1);
}
action int_set_header_1_bos() { //ingress_port_id
    modify_field(int_ingress_port_id_header.bos, 1);
}
action int_set_header_2_bos() { //hop_latency
    modify_field(int_hop_latency_header.bos, 1);
}
action int_set_header_3_bos() { //q_occupancy
    modify_field(int_q_occupancy_header.bos, 1);
}
action int_set_header_4_bos() { //ingress_tstamp
    modify_field(int_ingress_tstamp_header.bos, 1);
}
action int_set_header_5_bos() { //egress_port_id
    modify_field(int_egress_port_id_header.bos, 1);
}
action int_set_header_6_bos() { //q_congestion
    modify_field(int_q_congestion_header.bos, 1);
}
action int_set_header_7_bos() { //egress_port_tx_utilization
    modify_field(int_egress_port_tx_utilization_header.bos, 1);
}

table int_bos {
    reads {
        int_header.total_hop_cnt            : ternary;
        int_header.instruction_mask_0003    : ternary;
        int_header.instruction_mask_0407    : ternary;
        int_header.instruction_mask_0811    : ternary;
        int_header.instruction_mask_1215    : ternary;
    }
    actions {
        int_set_header_0_bos;
        int_set_header_1_bos;
        int_set_header_2_bos;
        int_set_header_3_bos;
        int_set_header_4_bos;
        int_set_header_5_bos;
        int_set_header_6_bos;
        int_set_header_7_bos;
        nop;
    }
    size : 17;       // number of instruction bits
}

// update the INT metadata header
action int_set_e_bit() {
    modify_field(int_header.e, 1);
}

action int_update_total_hop_cnt() {
    add_to_field(int_header.total_hop_cnt, 1);
}

table int_meta_header_update {
    // This table is applied only if int_insert table is a hit, which
    // computes insert_cnt
    // E bit is set if insert_cnt == 0
    // Else total_hop_cnt is incremented by one
    reads {
        int_metadata.insert_cnt : ternary;
    }
    actions {
        int_set_e_bit;
        int_update_total_hop_cnt;
    }
    size : 2;
}
#endif

#ifdef INT_EP_ENABLE
action int_set_src () {
    modify_field(int_metadata_i2e.source, 1);
}

action int_set_no_src () {
    modify_field(int_metadata_i2e.source, 0);
}

table int_source {
    // Decide to initiate INT based on client IP address pair
    // lkp_src, lkp_dst addresses are either outer or inner based
    // on if this switch is VTEP src or not respectively.
    //
    // {int_header, lkp_src, lkp_dst}
    //      0, src, dst => int_src=1
    //      1, x, x => mis-config, transient error, int_src=0
    //      miss => int_src=0
    reads {
        int_header                  : valid;
        // use outer ipv4/6 header when VTEP src
        ipv4                        : valid;
        ipv4_metadata.lkp_ipv4_da   : ternary;
        ipv4_metadata.lkp_ipv4_sa   : ternary;

        // use inner_ipv4 header when not VTEP src
        inner_ipv4                  : valid;
        inner_ipv4.dstAddr          : ternary;
        inner_ipv4.srcAddr          : ternary;
    }
    actions {
        int_set_src;
        int_set_no_src;
    }
    size : INT_SOURCE_TABLE_SIZE;
}

field_list int_i2e_mirror_info {
    int_metadata_i2e.sink;
    i2e_metadata.mirror_session_id;
}

action int_sink (mirror_id) {
    modify_field(int_metadata_i2e.sink, 1);

    // If this is sink, need to send the INT information to the
    // pre-processor/monitor. This is done via mirroring
    modify_field(i2e_metadata.mirror_session_id, mirror_id);
    clone_ingress_pkt_to_egress(mirror_id, int_i2e_mirror_info);

    // remove all the INT information from the packet
    // max 24 headers are supported
    remove_header(int_header);
    remove_header(int_val[0]);
    remove_header(int_val[1]);
    remove_header(int_val[2]);
    remove_header(int_val[3]);
    remove_header(int_val[4]);
    remove_header(int_val[5]);
    remove_header(int_val[6]);
    remove_header(int_val[7]);
    remove_header(int_val[8]);
    remove_header(int_val[9]);
    remove_header(int_val[10]);
    remove_header(int_val[11]);
    remove_header(int_val[12]);
    remove_header(int_val[13]);
    remove_header(int_val[14]);
    remove_header(int_val[15]);
    remove_header(int_val[16]);
    remove_header(int_val[17]);
    remove_header(int_val[18]);
    remove_header(int_val[19]);
    remove_header(int_val[20]);
    remove_header(int_val[21]);
    remove_header(int_val[22]);
    remove_header(int_val[23]);
}

action int_sink_gpe (mirror_id) {
    // convert the word len from gpe-shim header to byte_cnt
    shift_left(int_metadata.insert_byte_cnt, int_metadata.gpe_int_hdr_len, 2);
    int_sink(mirror_id);

}

action int_no_sink() {
    modify_field(int_metadata_i2e.sink, 0);
}

table int_terminate {
    /* REMOVE after discussion
     * It would be nice to keep this encap un-aware. But this is used
     * to compute byte count of INT info from shim headers from outer
     * protocols (vxlan_gpe_shim, geneve_tlv etc)
     * That make vxlan_gpe_int_header.valid as part of the key
     */

    // This table is used to decide if this node is INT sink
    // lkp_dst addr can be outer or inner ip addr, depending on how
    // user wants to configure.
    // {int_header, gpe, lkp_dst}
    //  1, 1, dst => int_gpe_sink(remove/update headers), int_sink=1
    //  (one entry per dst_addr)
    //  miss => no_sink
    reads {
        int_header                  : valid;
        vxlan_gpe_int_header        : valid;
        // when configured based on tunnel IPs
        ipv4                        : valid;
        ipv4_metadata.lkp_ipv4_da   : ternary;
        // when configured based on client IPs
        inner_ipv4                  : valid;
        inner_ipv4.dstAddr          : ternary;
    }
    actions {
        int_sink_gpe;
        int_no_sink;
    }
    size : INT_TERMINATE_TABLE_SIZE;
}

action int_sink_update_vxlan_gpe_v4() {
    modify_field(vxlan_gpe.next_proto, vxlan_gpe_int_header.next_proto);
    remove_header(vxlan_gpe_int_header);
    subtract(ipv4.totalLen, ipv4.totalLen, int_metadata.insert_byte_cnt);
    subtract(udp.length_, udp.length_, int_metadata.insert_byte_cnt);
}

table int_sink_update_outer {
    // This table is used to update the outer(underlay) headers on int_sink
    // to reflect removal of INT headers
    // Add more entries as other underlay protocols are added
    // {sink, gpe}
    // 1, 1 => update ipv4 and udp headers
    // miss => nop
    reads {
        vxlan_gpe_int_header        : valid;
        ipv4                        : valid;
        int_metadata_i2e.sink       : exact;
    }
    actions {
        int_sink_update_vxlan_gpe_v4;
        nop;
    }
    size : 2;
}
#endif

/*
 * Check if this switch needs to act as INT source or sink
 */
MODULE_INGRESS(init_endpoint) {
#ifdef INT_EP_ENABLE
    if (not valid(int_header)) {
        apply(int_source);
    } else {
        apply(int_terminate);
        apply(int_sink_update_outer);
    }
#endif
}
#undef MODULE