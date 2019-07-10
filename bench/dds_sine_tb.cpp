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
    tb->set_tuning_word(0xff);

    while(!tb->done()) {
        double us = tb->mTicks / 100.;
        if (us > 10. && us < 20.) {
            tb->set_tuning_word(0x1ff);
        } else if (us > 20. && us < 30.) {
            tb->set_tuning_word(0x8f);
        } else if (us > 30.) {
            break;
        }
        tb->tick();
    }
    return EXIT_SUCCESS;
}

