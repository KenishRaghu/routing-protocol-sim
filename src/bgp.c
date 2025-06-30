
#include "routing.h"

void simulate_bgp(network_t *net) {
    printf("[BGP] Starting simulation...\n");

    for (int i = 0; i < net->node_count; i++) {
        node_t *node = &net->nodes[i];
        for (int j = 0; j < node->neighbor_count; j++) {
            int neighbor_id = node->neighbors[j];
            node_t *neighbor = &net->nodes[neighbor_id - 1];

            for (int k = 0; k < neighbor->route_count; k++) {
                route_t route = neighbor->routes[k];
                int exists = 0;

                for (int r = 0; r < node->route_count; r++) {
                    if (strcmp(node->routes[r].network, route.network) == 0) {
                        exists = 1;
                        break;
                    }
                }

                if (!exists && node->route_count < MAX_ROUTES) {
                    route_t new_route;
                    strcpy(new_route.network, route.network);
                    strcpy(new_route.next_hop, neighbor->ip);
                    new_route.metric = route.metric + 1;
                    new_route.active = 1;
                    node->routes[node->route_count++] = new_route;
                }
            }
        }
    }

    gettimeofday(&net->converge_time, NULL);
    net->converged = 1;
}
