#include "core/config.p4"
#include "core/define.p4"
#include "core/macro.p4"
#include "core/metadata.p4"
#include "core/context.p4"
#include "core/protocol.p4"
#include "core/start.p4"
#include "core/rewind.p4"
#include "core/module.p4"

control ingress {
#if ENABLE_INITIALIZER == 1
    CHECK(1) {
        pipeline_start();
    }
#endif

#if INGRESS_MODULE_NUM > 1
#ifdef MODULE_1
    CHECK(2) {
        MODULE_1;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 2
#ifdef MODULE_2
    CHECK(4) {
        MODULE_2;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 3
#ifdef MODULE_3
    CHECK(0x10) {
        MODULE_3;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 4
#ifdef MODULE_4
    CHECK(0x20) {
        MODULE_4;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 5
#ifdef MODULE_5
    CHECK(0x40) {
        MODULE_5;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 6
#ifdef MODULE_6
    CHECK(0x80) {
        MODULE_6;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 7
#ifdef MODULE_7
    CHECK(7) {
        MODULE_7;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 8
#ifdef MODULE_8
    CHECK(8) {
        MODULE_8;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 9
#ifdef MODULE_9
    CHECK(9) {
        MODULE_9;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 10
#ifdef MODULE_10
    CHECK(10) {
        MODULE_10;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 11
#ifdef MODULE_11
    CHECK(11) {
        MODULE_11;
    }
#endif
#endif


#if INGRESS_MODULE_NUM > 12
#ifdef MODULE_12
    CHECK(12) {
        MODULE_12;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 13
#ifdef MODULE_13
    CHECK(13) {
        MODULE_13;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 14
#ifdef MODULE_14
    CHECK(14) {
        (MODULE_14);
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 15
#ifdef MODULE_15
    CHECK(15) {
        MODULE_15;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 16
#ifdef MODULE_16
    CHECK(16) {
        MODULE_16;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 17
#ifdef MODULE_17
    CHECK(17) {
        MODULE_17;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 18
#ifdef MODULE_18
    CHECK(18) {
        MODULE_18;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 19
#ifdef MODULE_19
    CHECK(19) {
        MODULE_19;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 20
#ifdef MODULE_20
    CHECK(20) {
        MODULE_20;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 21
#ifdef MODULE_21
    CHECK(21) {
        MODULE_21;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 22
#ifdef MODULE_22
    CHECK(22) {
        MODULE_22;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 23
#ifdef MODULE_23
    CHECK(23) {
        MODULE_23;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 24
#ifdef MODULE_24
    CHECK(24) {
        MODULE_24;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 25
#ifdef MODULE_25
    CHECK(25) {
        MODULE_25;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 26
#ifdef MODULE_26
    CHECK(26) {
        MODULE_26;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 27
#ifdef MODULE_27
    CHECK(27) {
        MODULE_27;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 28
#ifdef MODULE_28
    CHECK(28) {
        MODULE_28;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 29
#ifdef MODULE_29
    CHECK(29) {
        MODULE_29;
    }
#endif
#endif

#if INGRESS_MODULE_NUM > 30
#ifdef MODULE_30
    CHECK(30) {
        MODULE_30;
    }
#endif
#endif

// #if INGRESS_MODULE_NUM > 31
// #ifdef MODULE_31
//     CHECK(31) {
//         MODULE_31;
//     }
// #endif
// #endif
#if ENABLE_REWINDER == 1
    CHECK(31){
        pipeline_rewind();
    }
#endif

}

control egress {

}
// #if EGRESS_MODULE_NUM > 1
// #ifdef MODULE_32
//     CHECK(32) {
//         MODULE_32;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 2
// #ifdef MODULE_33
//     CHECK(33) {
//         MODULE_33;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 3
// #ifdef MODULE_34
//     CHECK(34) {
//         MODULE_34;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 4
// #ifdef MODULE_35
//     CHECK(35) {
//         MODULE_35;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 5
// #ifdef MODULE_36
//     CHECK(36) {
//         MODULE_36;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 6
// #ifdef MODULE_37
//     CHECK(37) {
//         MODULE_37;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 7
// #ifdef MODULE_38
//     CHECK(38) {
//         MODULE_38;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 8
// #ifdef MODULE_39
//     CHECK(39) {
//         MODULE_39;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 9
// #ifdef MODULE_40
//     CHECK(40) {
//         MODULE_40;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 10
// #ifdef MODULE_41
//     CHECK(41) {
//         MODULE_41;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 11
// #ifdef MODULE_42
//     CHECK(42) {
//         MODULE_42;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 12
// #ifdef MODULE_43
//     CHECK(43) {
//         MODULE_43;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 13
// #ifdef MODULE_44
//     CHECK(44) {
//         MODULE_44;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 14
// #ifdef MODULE_45
//     CHECK(45) {
//         MODULE_45;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 15
// #ifdef MODULE_46
//     CHECK(46) {
//         MODULE_46;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 16
// #ifdef MODULE_47
//     CHECK(47) {
//         MODULE_47;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 17
// #ifdef MODULE_48
//     CHECK(48) {
//         MODULE_48;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 18
// #ifdef MODULE_49
//     CHECK(49) {
//         MODULE_49;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 19
// #ifdef MODULE_50
//     CHECK(50) {
//         MODULE_50;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 20
// #ifdef MODULE_51
//     CHECK(51) {
//         MODULE_51;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 21
// #ifdef MODULE_52
//     CHECK(52) {
//         MODULE_52;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 22
// #ifdef MODULE_53
//     CHECK(53) {
//         MODULE_53;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 23
// #ifdef MODULE_54
//     CHECK(54) {
//         MODULE_54;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 24
// #ifdef MODULE_55
//     CHECK(55) {
//         MODULE_55;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 25
// #ifdef MODULE_56
//     CHECK(56) {
//         MODULE_56;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 26
// #ifdef MODULE_57
//     CHECK(57) {
//         MODULE_57;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 27
// #ifdef MODULE_58
//     CHECK(58) {
//         MODULE_58;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 28
// #ifdef MODULE_59
//     CHECK(59) {
//         MODULE_59;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 29
// #ifdef MODULE_60
//     CHECK(60) {
//         MODULE_60;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 30
// #ifdef MODULE_61
//     CHECK(61) {
//         MODULE_61;
//     }
// #endif
// #endif

// #if EGRESS_MODULE_NUM > 31
// #ifdef MODULE_62
//     CHECK(62) {
//         MODULE_62;
//     }
// #endif
// #endif

//     CHECK(63){
//         pipeline_rewind();
//     }

// }
