#ifndef __CLICK_METADATA__
#define __CLICK_METADATA__


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