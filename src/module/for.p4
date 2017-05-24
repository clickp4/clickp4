#ifndef MODULE
#define MODULE for

action for_init(threshold) {
    modify_field(for_metadata.threshold, threshold);
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
}

table for_loop {
    reads {
        CLICK_ID: exact;
    }
    actions {
        for_loop;
    }
}

table for_end {
    reads {
        CLICK_ID: exact;
    }
    actions {
        loop_end;
    }

}

MODULE_INGRESS(for) {
    apply(for_init);
    if (for_metadata.i < for_metadata.threshold) {
        apply(for_loop);
    }
    else {
        apply(for_end);
    }
}

#undef MODULE
#endif 