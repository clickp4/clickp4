#! /bin/bash

sudo ip link del veth3
sudo ip link del veth4

sudo ip netns del h1
sudo ip netns del h2
