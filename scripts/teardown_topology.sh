#!/bin/bash

ip netns delete R1
ip netns delete R2
ip link delete veth-R1 type veth peer name veth-R2 2>/dev/null

echo "[*] Topology torn down"
