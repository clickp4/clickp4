#ifndef MODULE
#define MODULE for 

action for_init(threshold) {
    modify_filed(for_metadata.threshold, threshold);
}

action for_loop(bitmap) {
    add_to_filed(for_metadata.i, 1);
    SET_CLICK_BITMAP(bitmap);
}

table for_init {
    reads {
        CHAIN_ID;
    }
    actions {
        for_init;
    }
}

table for_loop {
    reads {
        CHAIN_ID;
    }
    actions {
        for_loop;
    }
}

table for_end {
    reads {
        CHAIN_ID;
    }
    actions {
        loop_end;
    }

}

table for_end {

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

#endif 