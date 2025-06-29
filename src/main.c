#include "routing.h"
#include <unistd.h>

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: %s <protocol> <nodes>\n", argv[0]);
        printf("Example: %s bgp 5\n", argv[0]);
        return 1;
    }

    char *protocol = argv[1];
    int num_nodes = atoi(argv[2]);

    if (num_nodes < 2 || num_nodes > MAX_NODES) {
        printf("Nodes must be between 2 and %d\n", MAX_NODES);
        return 1;
    }

    network_t network;
    init_network(&network);

    printf("=== Routing Protocol Simulation ===\n");
    printf("Protocol: %s\n", protocol);
    printf("Nodes: %d\n", num_nodes);
    printf("===================================\n\n");

    for (int i = 1; i <= num_nodes; i++) {
        char ip[16];
        sprintf(ip, "192.168.1.%d", i);
        add_node(&network, i, ip);
    }

    for (int i = 1; i <= num_nodes; i++) {
        int next = (i % num_nodes) + 1;
        add_link(&network, i, next);
    }

    if (num_nodes >= 4) {
        add_link(&network, 1, 3);
    }

    gettimeofday(&network.start_time, NULL);

    if (strcmp(protocol, "bgp") == 0) {
        simulate_bgp(&network);
    } else if (strcmp(protocol, "ospf") == 0) {
        simulate_ospf(&network);
    } else {
        printf("Unknown protocol: %s\n", protocol);
        return 1;
    }

    print_stats(&network);
    return 0;
}
