#ifndef MODULE
#define MODULE condition
/**
 * Condition module
 * A module devised for switching module chains.
 */


/**
 * Condition module parameters.
 */
#ifndef CONDITION_TABLE_SIZE
#define CONDITION_TABLE_SIZE 512
#endif

action condition_branch(state, bitmap) {
    SET_CLICK_STATE(state);
    SET_CLICK_BITMAP(bitmap);
}

table condition_table_1 {
    reads {
        click_metadata.click_id : exact;
        condition_metadata.condition : exact;
    }
    actions {
         condition_branch;
    }
    size : 1024;
}

table condition_table_2 {
    reads {
        click_metadata.click_id : exact;
        condition_metadata.condition : exact;
    }
    actions {
         condition_branch;
    }
    size : 1024;
}

table condition_table_3 {
    reads {
        click_metadata.click_id : exact;
        condition_metadata.condition : exact;
    }
    actions {
         condition_branch;
    }
    size : 1024;
}

table condition_table_4 {
    reads {
        click_metadata.click_id : exact;
        condition_metadata.condition : exact;
    }
    actions {
         condition_branch;
    }
    size : 1024;
}


MODULE_INGRESS(condition) {
    apply(condition_table_1);
    apply(condition_table_2);
    apply(condition_table_3);
    apply(condition_table_4);
}

#undef CONDITION_TABLE_SIZE
#undef MODULE
#endif