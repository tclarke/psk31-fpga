//
// Created by Trevor Clarke on 2019-07-09.
//
#include <stdlib.h>
#include "Vpsk31_top.h"
#include "verilated.h"
#include "Testbench.h"

class i2s_clk_tb : public Testbench<Vpsk31_top>
{
public:
    i2s_clk_tb() {}
    virtual ~i2s_clk_tb() {}
};

int main(int argc, char **argv) {
    // Initialize Verilators variables
    Verilated::commandArgs(argc, argv);

    i2s_clk_tb* tb = new i2s_clk_tb();

    tb->opentrace("i2s_clk_tb.vcd");
    tb->reset();

    long start = tb->mTicks;
    bool mid = false;
    while(!tb->done()) {
        tb->tick();
        if (mid && tb->mpCore->psk31_top__DOT__i2s_clk == 0) {
            break;
        } else if (tb->mpCore->psk31_top__DOT__i2s_clk != 0) {
            mid = true;
        }
    }
    long end = tb->mTicks;
    printf("%d ticks  %fkHz\n", end-start, 12000. / (end-start));
    return EXIT_SUCCESS;
}

