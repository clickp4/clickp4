#ifndef __CLICK_MODULE__
#define __CLICK_MODULE__

#include "../module/simple_sg.p4"
#include "../module/simple_acl.p4"
#include "../module/l3_switch.p4"


#define MODULE_1 module_simple_sg()
#define MODULE_2 module_simple_acl()
#define MODULE_3 module_l3_switch()


#endif
