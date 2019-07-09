//
// Created by Trevor Clarke on 2019-07-09.
//
#include <stdlib.h>
#include "Vdds_sine.h"
#include "verilated.h"
#include "Testbench.h"

class dds_sine_tb : public Testbench<Vdds_sine>
{
public:
    dds_sine_tb() {}
    virtual ~dds_sine_tb() {}
    void set_tuning_word(unsigned int tw) {
        mpCore->tuning_word = tw;
    }
};

int main(int argc, char **argv) {
    // Initialize Verilators variables
    Verilated::commandArgs(argc, argv);

    dds_sine_tb* tb = new dds_sine_tb();

    tb->opentrace("dds_sine_tb.vcd");
    tb->reset();
    tb->set_tuning_word(15);

    int cnt = 0;
    while(!tb->done()) {
        if (cnt++ > 100000) {
            break;
        }
        tb->tick();
    }
    return EXIT_SUCCESS;
}

