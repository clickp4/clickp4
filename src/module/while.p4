#ifndef MODULE
#define MODULE while

action set_threshold(threshold) {
    modify_field(while_metadata.threshold, threshold);
}

table while_init {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
        set_threshold;
    }
}

table while_small {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         loop;
         loop_end;
    }
}

table while_equal {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         loop;
         loop_end;
    } 
}

table while_large {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         loop;
         loop_end;
    }
}


action while_sub() {
    // add_to_field(if_metadata.right, 255);
    subtract_from_field(while_metadata.value, while_metadata.threshold);
}

table while_sub {
    actions {
        while_sub;
    }
}


MODULE_INGRESS(while) {
    
    if (while_metadata.threshold == 0) {
        apply(while_init);
    }
    apply(while_sub);
    if (while_metadata.value == 0) {
        apply(while_equal);
    }
    else if (while_metadata.value > 0x80) {
        apply(while_small);
    } 
    else {
        apply(while_large);
    }
}

#undef MODULE
#endif