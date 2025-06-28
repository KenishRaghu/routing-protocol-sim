all: bgp_sim ospf_sim

bgp_sim: src/bgp_sim.c
	gcc src/bgp_sim.c -o bgp_sim

ospf_sim: src/ospf_sim.c
	gcc src/ospf_sim.c -o ospf_sim

clean:
	rm -f bgp_sim ospf_sim
