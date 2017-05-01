#ifndef __CLICK_START__
#define __CLICK_START__

#include "wrapper.p4"

action act_set_chain(chain_id, bitmap) {
    SET_CLICK_ID(chain_id);
    SET_CLICK_BITMAP(bitmap);
}

action act_set_bitmap(bitmap) {
    SET_CLICK_BITMAP(bitmap);
}

table tbl_pipeline_start {
    reads {
        IPv4_SRC_ADDR : ternary;
        IPv4_DST_ADDR : ternary;
        IPv4_PROTO    : ternary;
        tcp.dst_port : ternary;
        tcp.src_port : ternary;
        udp.dst_port : ternary;
        udp.src_port : ternary;
    }

    actions {
        act_set_chain;
        act_set_bitmap;
    }
}

control pipeline_start {
    apply(tbl_pipeline_start);
}

#endif
