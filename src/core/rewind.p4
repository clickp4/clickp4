#ifndef __CLICK_REWIND__
#define __CLICK_REWIND__


#include "macro.p4"
#include "field_list.p4"

action rewind (state, bitmap) {
    SET_CLICK_STATE(state);
    SET_CLICK_BITMAP(bitmap);
    SET_CLICK_INPUT(0);
    resubmit(reserve_fields);

}

table rewind_table {
    reads {
        CLICK_ID : exact;
        CLICK_STATE : exact;
    }
    actions {
        rewind;
    }
}

control pipeline_rewind {
    if (CLICK_ID != 0) {
        apply(rewind_table);
    }
}

#endif