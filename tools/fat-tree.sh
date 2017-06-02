#!/bin/bash

SWITCH_DIR=/home/netarchlab/bmv2/targets/simple_switch

INTF_E1_1='-i 1@e1_1'
INTF_E1_2='-i 2@e1_2'
INTF_E1_3='-i 3@eth12'
INTF_E2_1='-i 1@e2_1'
INTF_E2_2='-i 2@e2_2'
INTF_E2_3='-i 3@eth13'
INTF_E3_1='-i 1@e3_1'
INTF_E3_2='-i 2@e3_2'
INTF_E3_3='-i 3@eth14'
INTF_E4_1='-i 1@e4_1'
INTF_E4_2='-i 2@e4_2'
INTF_E4_3='-i 3@eth15'
INTF_A1_1='-i 1@a1_1'
INTF_A1_2='-i 2@a1_2'
INTF_A1_3='-i 3@a1_3'
INTF_A2_1='-i 1@a2_1'
INTF_A2_2='-i 2@a2_2'
INTF_A2_3='-i 3@a2_3'
INTF_A3_1='-i 1@a3_1'
INTF_A3_2='-i 2@a3_2'
INTF_A3_3='-i 3@a3_3'
INTF_A4_1='-i 1@a4_1'
INTF_A4_2='-i 2@a4_2'
INTF_A4_3='-i 3@a4_3'
INTF_C1_1='-i 1@c1_1'
INTF_C1_2='-i 2@c1_2'
INTF_C2_1='-i 1@c2_1'
INTF_C2_2='-i 2@c2_2'
LOG='-L off'

SWITCH_DBG_DIR=/home/netarchlab/bmv2-debug/targets/simple_switch

sudo python fat-tree-link.py

cd $SWITCH_DIR



# E1
for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_E1_1 $INTF_E1_2 $INTF_E1_3 $LOG --thrift-port 9090
} &
done

# E2
for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_E2_1 $INTF_E2_2 $INTF_E2_3 $LOG --thrift-port 9091
} &
done

# E3
for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_E3_1 $INTF_E3_2 $INTF_E3_3 $LOG --thrift-port 9092
} &
done

# E4
for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_E4_1 $INTF_E4_2 $INTF_E4_3 $LOG --thrift-port 9093
    #sudo $SWITCH_DBG_DIR/simple_switch clickp4.json $INTF_E4_1 $INTF_E4_2 $INTF_E4_3 --log-console --thrift-port 9093
} &
done

# A1
for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_A1_1 $INTF_A1_2 $INTF_A1_3 $LOG --thrift-port 9094
} &
done

# A2
for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_A2_1 $INTF_A2_2 $INTF_A2_3 $LOG --thrift-port 9095
} &
done


# A3
for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_A3_1 $INTF_A3_2 $INTF_A3_3 $LOG --thrift-port 9096
} &
done

# A4
for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_A4_1 $INTF_A4_2 $INTF_A4_3 $LOG --thrift-port 9097
} &
done

# Core 1

for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_C1_1 $INTF_C1_2 $LOG --thrift-port 9098
} &
done

# Core 2
sudo ./simple_switch clickp4.json $INTF_C2_1 $INTF_C2_2 $LOG --thrift-port 9099