#ifndef MODULE
#define MODULE if

/**
 * IF
 * If module has three branch: >, < and =
 */

#ifndef IF_TBL_SZ
#define IF_TBL_SZ 512
#endif

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
    size : IF_TBL_SZ;
}

table if_equal {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
        if_branch;
    } 
    size : IF_TBL_SZ;
}

table if_large {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         if_branch;
    }
    size : F_TBL_SZ;
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

#undef IF_TBL_SZ
#undef MODULE
#endif