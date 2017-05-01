#include "core/protocol.p4"
#include "core/metadata.p4"
#include "core/wrapper.p4"
#include "core/start.p4"
#include "core/rewind.p4"
#include "core/define.p4"
#include "core/context.p4"
#include "core/module.p4"

control ingress {

    CHECK(0) {
        pipeline_start();
    }

#ifdef MODULE_1
    CHECK(1) {
        MODULE_1;
    }
#endif

#ifdef MODULE_2
    CHECK(2) {
        MODULE_2;
    }
#endif

#ifdef MODULE_3
    CHECK(3) {
        MODULE_3;
    }
#endif

#ifdef MODULE_4
    CHECK(4) {
        MODULE_4;
    }
#endif

#ifdef MODULE_5
    CHECK(5) {
        MODULE_5;
    }
#endif

#ifdef MODULE_6
    CHECK(6) {
        MODULE_6;
    }
#endif

#ifdef MODULE_7
    CHECK(7) {
        MODULE_7;
    }
#endif

#ifdef MODULE_8
    CHECK(8) {
        MODULE_8;
    }
#endif

#ifdef MODULE_9
    CHECK(9) {
        MODULE_9;
    }
#endif

#ifdef MODULE_10
    CHECK(10) {
        MODULE_10;
    }
#endif

#ifdef MODULE_11
    CHECK(11) {
        MODULE_11;
    }
#endif

#ifdef MODULE_12
    CHECK(12) {
        MODULE_12;
    }
#endif

#ifdef MODULE_13
    CHECK(13) {
        MODULE_13;
    }
#endif

#ifdef MODULE_14
    CHECK(14) {
        (MODULE_14);
    }
#endif

#ifdef MODULE_15
    CHECK(15) {
        MODULE_15;
    }
#endif

#ifdef MODULE_16
    CHECK(16) {
        MODULE_16;
    }
#endif

#ifdef MODULE_17
    CHECK(17) {
        MODULE_17;
    }
#endif

#ifdef MODULE_18
    CHECK(18) {
        MODULE_18;
    }
#endif

#ifdef MODULE_19
    CHECK(19) {
        MODULE_19;
    }
#endif

#ifdef MODULE_20
    CHECK(20) {
        MODULE_20;
    }
#endif

#ifdef MODULE_21
    CHECK(21) {
        MODULE_21;
    }
#endif

#ifdef MODULE_22
    CHECK(22) {
        MODULE_22;
    }
#endif

#ifdef MODULE_23
    CHECK(23) {
        MODULE_23;
    }
#endif

#ifdef MODULE_24
    CHECK(24) {
        MODULE_24;
    }
#endif

#ifdef MODULE_25
    CHECK(25) {
        MODULE_25;
    }
#endif

#ifdef MODULE_26
    CHECK(26) {
        MODULE_26;
    }
#endif

#ifdef MODULE_27
    CHECK(27) {
        MODULE_27;
    }
#endif

#ifdef MODULE_28
    CHECK(28) {
        MODULE_28;
    }
#endif

#ifdef MODULE_29
    CHECK(29) {
        MODULE_29;
    }
#endif

#ifdef MODULE_30
    CHECK(30) {
        MODULE_30;
    }
#endif

#ifdef MODULE_31
    CHECK(31) {
        MODULE_31;
    }
#endif

}

control egress {

#ifdef MODULE_32
    CHECK(32) {
        MODULE_32;
    }
#endif

#ifdef MODULE_33
    CHECK(33) {
        MODULE_33;
    }
#endif

#ifdef MODULE_34
    CHECK(34) {
        MODULE_34;
    }
#endif

#ifdef MODULE_35
    CHECK(35) {
        MODULE_35;
    }
#endif

#ifdef MODULE_36
    CHECK(36) {
        MODULE_36;
    }
#endif

#ifdef MODULE_37
    CHECK(37) {
        MODULE_37;
    }
#endif

#ifdef MODULE_38
    CHECK(38) {
        MODULE_38;
    }
#endif

#ifdef MODULE_39
    CHECK(39) {
        MODULE_39;
    }
#endif

#ifdef MODULE_40
    CHECK(40) {
        MODULE_40;
    }
#endif

#ifdef MODULE_41
    CHECK(41) {
        MODULE_41;
    }
#endif

#ifdef MODULE_42
    CHECK(42) {
        MODULE_42;
    }
#endif

#ifdef MODULE_43
    CHECK(43) {
        MODULE_43;
    }
#endif

#ifdef MODULE_44
    CHECK(44) {
        MODULE_44;
    }
#endif

#ifdef MODULE_45
    CHECK(45) {
        MODULE_45;
    }
#endif

#ifdef MODULE_46
    CHECK(46) {
        MODULE_46;
    }
#endif

#ifdef MODULE_47
    CHECK(47) {
        MODULE_47;
    }
#endif

#ifdef MODULE_48
    CHECK(48) {
        MODULE_48;
    }
#endif

#ifdef MODULE_49
    CHECK(49) {
        MODULE_49;
    }
#endif

#ifdef MODULE_50
    CHECK(50) {
        MODULE_50;
    }
#endif

#ifdef MODULE_51
    CHECK(51) {
        MODULE_51;
    }
#endif

#ifdef MODULE_52
    CHECK(52) {
        MODULE_52;
    }
#endif

#ifdef MODULE_53
    CHECK(53) {
        MODULE_53;
    }
#endif

#ifdef MODULE_54
    CHECK(54) {
        MODULE_54;
    }
#endif

#ifdef MODULE_55
    CHECK(55) {
        MODULE_55;
    }
#endif

#ifdef MODULE_56
    CHECK(56) {
        MODULE_56;
    }
#endif

#ifdef MODULE_57
    CHECK(57) {
        MODULE_57;
    }
#endif

#ifdef MODULE_58
    CHECK(58) {
        MODULE_58;
    }
#endif

#ifdef MODULE_59
    CHECK(59) {
        MODULE_59;
    }
#endif


#ifdef MODULE_60
    CHECK(60) {
        MODULE_60;
    }
#endif


#ifdef MODULE_61
    CHECK(61) {
        MODULE_61;
    }
#endif


#ifdef MODULE_62
    CHECK(62) {
        MODULE_62;
    }
#endif

    CHECK(63){
//        pipeline_rewind();
    }

}
