#ifndef __CLICK_CONTEXT_INT__
#define __CLICK_CONTEXT_INT__
/*
 * INT transit device implementation
 * This example implements INT transit functionality using VxLAN-GPE as
 * underlay protocol. The udp port# for vxlan-gpe is assume to be 4790
 * Only IPv4 is supported as underlay protocol in this example.
 */
header_type int_metadata_t {
    fields {
        switch_id           : 32;
        insert_cnt          : 8;
        insert_byte_cnt     : 16;
        gpe_int_hdr_len     : 16;
        gpe_int_hdr_len8    : 8;
        instruction_cnt     : 16;
    }
}
metadata int_metadata_t int_metadata;

header_type int_metadata_i2e_t {
    fields {
        sink    : 1;
        source  : 1;
    }
}
metadata int_metadata_i2e_t int_metadata_i2e;
#endif