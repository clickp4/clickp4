#ifndef MODULE
#define MODULE for
/**
 * For module
 * A module devised to conduct circular execution of modules. 
 */

/**
 * For module parameters.
 */
#ifndef FOR_TBL_SZ
#define FOR_TBL_SZ 512
#endif

#ifndef FOR_FIELDS

#define FOR_FIELDS          \
            CLICK_ID;       \
            CLICK_STATE;    \
            CLICK_BITMAP;   \
            for_metadata.i; \
            for_metadata.threshold;
#endif

#ifndef FOR_RESUBMIT_FIELDS
#define FOR_RESUBMIT_FIELDS
#endif


field_list for_fields {
    FOR_FIELDS
    FOR_RESUBMIT_FIELDS
}

action for_init(threshold) {
    modify_field(for_metadata.threshold, threshold);
    resubmit(for_fields);
}

action for_loop(bitmap) {
    add_to_field(for_metadata.i, 1);
    SET_CLICK_BITMAP(bitmap);
}

table for_init {
    reads {
        CLICK_ID: exact;
    }
    actions {
        for_init;
    }
    size : FOR_TBL_SZ;
}

table for_loop {
    reads {
        CLICK_ID: exact;
    }
    actions {
        for_loop;
    }
    size : FOR_TBL_SZ;
}

table for_end {
    reads {
        CLICK_ID: exact;
    }
    actions {
        loop_end;
    }
    size : FOR_TBL_SZ;
}

MODULE_INGRESS(for) {
    if (for_metadata.threshold == 0) {
        apply(for_init);
    }
    if (for_metadata.i < for_metadata.threshold) {
        apply(for_loop);
    }
    else {
        apply(for_end);
    }
}

#undef FOR_FIELDS
#undef FOR_RESUBMIT_FIELDS
#undef FOR_TBL_SZ
#undef MODULE
#endif 