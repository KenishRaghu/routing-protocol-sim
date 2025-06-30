
#include "routing.h"

void simulate_ospf(network_t *net) {
    printf("[OSPF] Starting simulation...\n");

    for (int i = 0; i < net->node_count; i++) {
        node_t *node = &net->nodes[i];
        for (int j = 0; j < net->node_count; j++) {
            if (i == j) continue;

            node_t *target = &net->nodes[j];
            route_t route;
            sprintf(route.network, "%s", target->ip);
            sprintf(route.next_hop, "%s", target->ip);
            route.metric = abs(node->id - target->id);
            route.active = 1;
            node->routes[node->route_count++] = route;
        }
    }

    gettimeofday(&net->converge_time, NULL);
    net->converged = 1;
}
