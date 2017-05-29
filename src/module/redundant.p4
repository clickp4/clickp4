#ifndef MODULE
#define MODULE redundant

#ifndef REDUNDANT_NUM
#define REDUNDANT_NUM 1
#endif

header_type redundant_metadata_t {
    fields {
        value : 32;
    }
}


metadata redundant_metadata_t redundant_metadata;

action redundant_action(x) {
    modify_field(redundant_metadata.value, x);
}


#define TEMPLATE(X) \
table redundant_table_##X { \
    reads {                       \
        ipv4.dst_addr : ternary;  \
        ipv4.src_addr : ternary;  \
        ipv4.proto    : ternary;  \
        tcp.src_port  : ternary;  \
        tcp.dst_port  : ternary;  \
    }                             \
    actions {                     \
        redundant_action;         \
    }                            \
}


#define APPLY(X) apply( redundant_table_##X )

TEMPLATE(1)
TEMPLATE(2)
TEMPLATE(3)
TEMPLATE(4)
TEMPLATE(5)
TEMPLATE(6)
TEMPLATE(7)
TEMPLATE(8)
TEMPLATE(9)
TEMPLATE(10)

MODULE_INGRESS(redundant) {
#if REDUNDANT_NUM >= 1
    APPLY(1);
#endif
#if REDUNDANT_NUM >= 2
    APPLY(2);
#endif
#if REDUNDANT_NUM >= 3
    APPLY(3);
#endif
#if REDUNDANT_NUM >= 4
    APPLY(4);
#endif
#if REDUNDANT_NUM >= 5
    APPLY(5);
#endif
#if REDUNDANT_NUM >= 6
    APPLY(6);
#endif
#if REDUNDANT_NUM >= 7
    APPLY(7);
#endif
#if REDUNDANT_NUM >= 8
    APPLY(8);
#endif
#if REDUNDANT_NUM >= 9
    APPLY(9);
#endif
#if REDUNDANT_NUM >= 10
    APPLY(10);
#endif

}


#undef MODULE
#endif