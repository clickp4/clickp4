#ifndef _L4_CONTEXT_H_
#define _L4_CONTEXT_H_


#define L4_TYPE_TCP 1
#define L4_TYPE_UDP 2 

#define L4_METADATA
header_type l4_metadata_t {
    fields {
        src_port : 16;
        dst_port : 16;
        l4_type  : 8 ;
    }
}

metadata l4_metadata_t l4_metadata;

#endif