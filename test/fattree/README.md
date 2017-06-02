Polciy1 : 
POD之间的流：
Core: L3-switch -> Firewall 
AGG:  L2-switch


EDGE: L2-switch -> IP SG or L2-Switch

Policy2：POD内部的流

AGG：mac-learning -> L2-switch->  QoS

EDGE：mac-learning -> L2-switch -> IP SG  -> QoS


simple_ml 0
l2_switch
l3_switch
simple_sg
fw
simple_qos