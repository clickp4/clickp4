#ifndef __CLICK_CONTEXT_FABRIC__
#define __CLICK_CONTEXT_FABRIC__
header_type fabric_metadata_t {
    fields {
        packetType : 3;
        fabric_header_present : 1;
        reason_code : 16;              /* cpu reason code */

#ifdef FABRIC_ENABLE
        dst_device : 8;                /* destination device id */
        dst_port : 16;                 /* destination port id */
#endif /* FABRIC_ENABLE */
    }
}

metadata fabric_metadata_t fabric_metadata;
#endif