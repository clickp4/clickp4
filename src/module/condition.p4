#ifndef MODULE
#define MODULE condition

action condition_branch(state, bitmap) {
    SET_CLICK_STATE(state);
    SET_CLICK_BITMAP(bitmap);
}

table condition_table {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         condition_branch;
    }
}

MODULE_INGRESS(condition) {
    apply(condition_table);
}

#undef MODULE
#endif