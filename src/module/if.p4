#ifndef MODULE
#define MODULE condition

action if_branch(state, bitmap) {
    SET_CLICK_STATE(state);
    SET_CLICK_BITMAP(bitmap);
}

table if_small {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         if_branch;
    }
}

table if_equal {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
        if_branch;
    } 
}

table if_large {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         if_branch;
    }
}

MODULE_INGRESS(if) {
    if (if_metadata.left < if_metadata.right) {
        apply(if_small);
    }
    else if (if_metadata.left > if_metadata.right) {
        apply(if_large);
    } 
    else {
        apply(if_equal);
    }
}

#undef MODULE
#endif