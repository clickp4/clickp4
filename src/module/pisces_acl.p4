#ifndef MODULE
#define MODULE pisces_acl

table pisces_acl {
    reads {
        ipv4.src_addr : ternary;
        ipv4.dst_addr : ternary;
        ipv4.proto    : ternary;
        
    }
}

MODULE_INGRESS(pisces_acl) {
    apply(pisces_acl);
}

#endif