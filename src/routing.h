#ifndef ROUTING_H
#define ROUTING_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>

#define MAX_NODES 20
#define MAX_ROUTES 50

typedef struct {
    char network[16];    // e.g., "192.168.1.0"
    char next_hop[16];   // e.g., "10.0.1.1"
    int metric;
    int active;
} route_t;

typedef struct {
    int id;
    char ip[16];
    route_t routes[MAX_ROUTES];
    int route_count;
    int neighbors[MAX_NODES];
    int neighbor_count;
} node_t;

typedef struct {
    node_t nodes[MAX_NODES];
    int node_count;
    struct timeval start_time;
    struct timeval converge_time;
    int converged;
} network_t;

// Function declarations
void init_network(network_t *net);
void add_node(network_t *net, int id, const char* ip);
void add_link(network_t *net, int node1, int node2);
void simulate_bgp(network_t *net);
void simulate_ospf(network_t *net);
int check_convergence(network_t *net);
void print_stats(network_t *net);
long get_convergence_time_ms(network_t *net);

#endif
