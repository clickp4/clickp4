#ifndef __CLICK_METADATA__
#define __CLICK_METADATA__

/****************************************************
 * intrinsic_metadata_t
 * P4 intrinsic metadata (mandatory)
 ****************************************************/
header_type intrinsic_metadata_t {
	fields {
        ingress_global_timestamp : 48;
        lf_field_list : 8;
        mcast_grp : 16;
        egress_rid : 16;
        resubmit_flag : 8;
        recirculate_flag : 8;
        degist_receiver0 : 8;
        degist_receiver1 : 8;
        degist_receiver2 : 8;
        degist_receiver3 : 8;
        degist_receiver4 : 8;
        degist_receiver5 : 8;
        degist_receiver6 : 8;
        degist_receiver7 : 8;
        degist_receiver8 : 8;
        degist_receiver9 : 8;
	}
}

metadata intrinsic_metadata_t intrinsic_metadata;


/**
 * Metadata.
 */

header_type click_metadata_t {
    fields {
        click_bitmap : 64; // Supprort 64 mododules now.
        click_id      : 32; // Chain ID.
        click_state   : 8 ; // Chain state.
        click_input   : 8 ;
    }
}

metadata click_metadata_t click_metadata;

#endif