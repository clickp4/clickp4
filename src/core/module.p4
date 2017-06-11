#ifndef __CLICK_MODULE__
#define __CLICK_MODULE__

#include "../module/simple_ml.p4"
#include "../module/l2_switch.p4"
#include "../module/l3_switch.p4"
#include "../module/simple_sg.p4"
#include "../module/fw.p4"
#include "../module/simple_qos.p4"
#include "../module/redundant.p4"


#define MODULE_1 module_simple_ml()
#define MODULE_2 module_l2_switch()
#define MODULE_3 module_l3_switch()
#define MODULE_4 module_simple_sg()
#define MODULE_5 module_fw()
#define MODULE_6 module_simple_qos()
#define MODULE_7 module_redundant()


#endif
