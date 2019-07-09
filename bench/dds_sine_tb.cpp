//
// Created by Trevor Clarke on 2019-07-09.
//
#include <stdlib.h>
#include "Vdds_sine.h"
#include "verilated.h"
#include "Testbench.h"

int main(int argc, char **argv) {
    // Initialize Verilators variables
    Verilated::commandArgs(argc, argv);

    Testbench<Vdds_sine>* tb = new Testbench<Vdds_sine>();

    while(!tb->done()) {
        tb->tick();
    }
    return EXIT_SUCCESS;
}

