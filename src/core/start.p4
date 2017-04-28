#ifndef __CLICK_START__
#define __CLICK_START__

#include "wrapper.p4"

action set_chain(chain_id, bitmap) {
    SET_CLICK_ID(chain_id);
    SET_CLICK_BITMAP(bitmap);
}

action set_bitmap(bitmap) {
    SET_CLICK_BITMAP(bitmap);
}

table pipeline_start_table {
    reads {
        SRC_MAC : ternary;
        DST_MAC : ternary;
        ETH_TYPE : ternary;
        IPv4_SRC_ADDR : ternary;
        IPv4_DST_ADDR : ternary;
        IPv6_SRC_ADDR : ternary;
        IPv6_DST_ADDR : ternary;
    }

    actions {
        set_chain;
        set_bitmap;
    }
}

control pipeline_start {
    apply(pipeline_start_table);
}

#endif