#ifndef __CLICK_FIELD_LIST__
#define __CLICK_FIELD_LIST__

#include "metadata.p4"

field_list reserve_fields {
    //standard_metadata.ingress_port;
    //standard_metadata.egress_spec;
    //intrinsic_metadata;
    click_metadata.click_bitmap;
    click_metadata.click_id;
}


#endif