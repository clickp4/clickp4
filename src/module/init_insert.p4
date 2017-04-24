/**
 * P4 92 
 * ClickP4 94
 * Modified 2
 */
#define MODULE INT_INSERT
#ifdef INT_ENABLE
#ifdef INT_TRANSIT_ENABLE
action int_transit(switch_id) {
    subtract(int_metadata.insert_cnt, int_header.max_hop_cnt,
                                            int_header.total_hop_cnt);
    modify_field(int_metadata.switch_id, switch_id);
    shift_left(int_metadata.insert_byte_cnt, int_metadata.instruction_cnt, 2);
    modify_field(int_metadata.gpe_int_hdr_len8, int_header.ins_cnt);
}
#endif

action int_reset() {
    modify_field(int_metadata.switch_id, 0);
    modify_field(int_metadata.insert_byte_cnt, 0);
    modify_field(int_metadata.insert_cnt, 0);
    modify_field(int_metadata.gpe_int_hdr_len8, 0);
    modify_field(int_metadata.gpe_int_hdr_len, 0);
    modify_field(int_metadata.instruction_cnt, 0);
}

#ifdef INT_EP_ENABLE
action int_src(switch_id, hop_cnt, ins_cnt, ins_mask0003, ins_mask0407, ins_byte_cnt, total_words) {
    modify_field(int_metadata.insert_cnt, hop_cnt);
    modify_field(int_metadata.switch_id, switch_id);
    modify_field(int_metadata.insert_byte_cnt, ins_byte_cnt);
    modify_field(int_metadata.gpe_int_hdr_len8, total_words);
    add_header(int_header);
    modify_field(int_header.ver, 0);
    modify_field(int_header.rep, 0);
    modify_field(int_header.c, 0);
    modify_field(int_header.e, 0);
    modify_field(int_header.rsvd1, 0);
    modify_field(int_header.ins_cnt, ins_cnt);
    modify_field(int_header.max_hop_cnt, hop_cnt);
    modify_field(int_header.total_hop_cnt, 0);
    modify_field(int_header.instruction_mask_0003, ins_mask0003);
    modify_field(int_header.instruction_mask_0407, ins_mask0407);
    modify_field(int_header.instruction_mask_0811, 0); // not supported
    modify_field(int_header.instruction_mask_1215, 0); // not supported
    modify_field(int_header.rsvd2, 0);
}
#endif

table int_insert {
    /* REMOVE - changed src/sink bits to ternary to use TCAM
     * keep int_header.valid in the key to force reset on error condition
     */

    // int_sink takes precedence over int_src
    // {int_src, int_sink, int_header} :
    //      0, 0, 1 => transit  => insert_cnt = max-total
    //      1, 0, 0 => insert (src) => insert_cnt = max
    //      x, 1, x => nop (reset) => insert_cnt = 0
    //      1, 0, 1 => nop (error) (reset) => insert_cnt = 0
    //      miss (0,0,0) => nop (reset)
    reads {
        int_metadata_i2e.source       : ternary;
        int_metadata_i2e.sink         : ternary;
        int_header                    : valid;
    }
    actions {
#ifdef INT_TRANSIT_ENABLE
        int_transit;
#endif
#ifdef INT_EP_ENABLE
        int_src;
#endif
        int_reset;
    }
    size : 3;
}
#endif

MODULE_INGRESS(int_insertion) {
#ifdef INT_ENABLE
    apply(int_insert) {
        int_transit {
            // int_transit | int_src
            // insert_cnt = max_hop_cnt - total_hop_cnt
            // (cannot be -ve, not checked)
            if (int_metadata.insert_cnt != 0) {
                apply(int_inst_0003);
                apply(int_inst_0407);
                apply(int_inst_0811);
                apply(int_inst_1215);
                apply(int_bos);
            }
            apply(int_meta_header_update);
        }
    }
#endif
}
#undef MODULE