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

table condition_table {
    reads {
        click_metadata.click_id : exact;
        condition_metadata.condition :　exact;
    }
    actions {
         condition_branch;
    }
    size : CONDITION_TABLE_SIZE;
}

MODULE_INGRESS(condition) {
    apply(condition_table);
}

#undef CONDITION_TABLE_SIZE
#undef MODULE
#endif