#ifndef MODULE
#define MODULE while

#ifndef WHILE_FLOW_MATCH
#define WHILE_FLOW_MATCH \
        ipv4.src_addr : ternary; \
        ipv4.dst_addr : ternary;

action set_threshold(threshold) {
    modify_field(while_metadata.threshold, threshold);
}

table while_init {
    reads {
        while_FLOW_MATCH
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

MODULE_INGRESS(while) {
    
    if (while_metadata.threshold == 0) {
        apply(while_init);
    }
    if (while_metadata.value　< while_metadata.threshold) {
        apply(while_small);
    }
    else if (while_metadata.value　> while_metadata.threshold) {
        apply(while_large);
    } 
    else {
        apply(while_equal);
    }
}

#endif