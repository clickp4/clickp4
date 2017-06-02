# Modules of ClickP4

We have developed tens of modules for ClickP4. Some of them are ported from the switch repository. Some of them are newly added by us. And some of them are ported from the switch repository of P4.


Tested modules :
1. ecmp.p4
2. firewall.p4
3. fw.p4
4. l3_switch
5. redundant
6. simple\_acl
7. simple\_loose\_urpf
8. simple\_sg
9. sflow
10. simple\_nat
11. hash



To be done:

- condition.p4
- egress_qos.p4
- for
- if
- ingress_qos
- int_endpoint
- int_insert.p4
- int\_out\_encap.p4
- ip_acl
- ip_sg
- ipv4_fib
- ipv6_fib
- l2_switch
- lag
- mac
- mac\_acl
- mac\_learning
- mpls
- **mpls\_sr**
- nat
- outer\_multicast
- pisces\_acl
- simple\_hash
- **simple\_lag**
- **simple\_mac\_acl**
- simple\_meterwe
- simple\_qos
- **simple\_vxlan**
- spanning_tree
- stateful\_tcp\_firewall
- storm\_control
- traffic\_class
- vlan
- vtep
- vxlan
- wcmp
- while

Working on:
- ACL :MAC&IP (Chengze)

 TODO -> under developing (U) -> done (D) -> compiled (C) -> tested (T) 

| ID | Module  | Status | Source | Description |
|----|-------: | ------:|-------:|------------:|
| 1 | if | C | New | Act like 'if' in the C language. |
| 2 | for | C | New | Act like 'for' in the C language. |
| 3 | condition | C | New | Act like 'switch' in the C language. |
| 4 | while | C | New | Act like 'while' in general purpose languages. |
| 5 | l2_switch | T | From examples in the P4 repository | Ethernet switch prototype. | 
| 6 | l3_switch | T | From examples in the P4 repository | L3 switch prototype. | 
| 7 | ecmp | C | From examples in the P4 repository | ECMP. |
| 8 | firewall | C | From examples in the P4 repository | Firewall prototype. | 
| 9 | egress_qos | U | Extracted from P4 switches | QoS at the end of the packet processing pipeline. | 
| 10 | hash | U | Extracted from P4 switches | Hash functions. |


| ID | Context | Status | Description |
|----|-------: | ------:|------------:|
| 1 | common_action | C | Contain some common actions. |



## Sample

A sample module for ClickP4.

## L2 switch

A layer 2 switch prototype.

Parameters:
#### L2\_SWITCH\_LEARN
```
Enable source ethernet address learning.
DEFAULT: TRUE
```

#### L2\_SWITCH\_SMAC\_TABLE\_SIZE
```
The table size of smac.
DEFAULT: 1024
```

#### L2\_SWITCH\_SMAC\_TABLE\_SIZE
```
The table size of dmac.
DEFAULT: 1024
```

## L3 switch

A layer 3 switch prototype.

Parameters:
#### L3\_SWITCH\_CHECKSUM
```
Enable l3 checksum.
DEFAULT: TRUE
```

#### L3\_SWITCH\_TABLE\_SIZE
```
The table size of l3 switch.
DEFAULT: 1024
```

#### L3\_SWITCH\_BYPASS
```
Enable packets to bypass l3_switch when the security components set the security flag to DENY.
DEFAULT: TRUE
```

## Simple meter

A meter prototype.

Parameters:

#### SIMPLE\_METER\_TYPE
```
Data type of the meter.
DEFAULT: bytes
```

#### SIMPLE\_METER\_TABLE\_SIZE
```
Tbale size of the meter.
DEFAULT: 1024
```

## Condition

This module acts like 'switch' in the C language.

## If

This module acts like 'if' in the C language.

## While
This module acts like 'while' in the C language.

## For
This module acts like 'for' in the C language.

Parameters: 

#### FOR\_RESUBMIT\_FIELDS
```
Resubmit fields in the for loop.
```

## Firewall 

A firewall prototype.



