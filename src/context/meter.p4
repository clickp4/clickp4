#ifndef __CLICK_CONTEXT_METER__
#define __CLICK_CONTEXT_METER__

/*
 * Meter metadata
 */
 header_type meter_metadata_t {
     fields {
         packet_color : 2;               /* packet color */
         meter_index : 16;               /* meter index */
     }
 }
metadata meter_metadata_t meter_metadata;

#endif