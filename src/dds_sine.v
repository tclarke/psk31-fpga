//
// Author: tclarke
// Licensed under the GNU Public License (GPL) v3
//


module dds_sine (
        input clk,
        input rst,
        input [N_TUNING-1:0] tuning_word,
        output reg signed [N_OUT-1:0] sine,
        output reg signed [N_OUT-1:0] sine_i
);
parameter SIN_LUT_FILE = "/Users/tclarke/embedded/psk31/src/sine_lut.hex";
parameter N_ACCUM = 14;
parameter N_TUNING = 10;
parameter N_OUT = 16;

reg [N_ACCUM-1:0] accum = 0;
reg signed [15:0] lut[0:255];
/* verilator lint_off UNUSED */
reg signed [15:0] sine_1sym;
reg signed [15:0] sine_2sym;
reg signed [15:0] sine_2sym_i;
reg accum_high;
/* verilator lint_on UNUSED */

initial begin
    $readmemh(SIN_LUT_FILE, lut);
end

always @ (posedge clk) begin
    if (~rst) accum <= 0;
    else      accum <= accum + {3'b0, tuning_word};
    {sine_1sym, accum_high} <= {accum[N_ACCUM-2] ? lut[~accum[N_ACCUM-3:N_ACCUM-10]] : lut[accum[N_ACCUM-3:N_ACCUM-10]], accum[N_ACCUM-1]};
    sine_2sym <= accum_high ? -sine_1sym : sine_1sym;
    sine_2sym_i <= accum_high ? sine_1sym : -sine_1sym;
    sine <= sine_2sym[15:16-N_OUT];
    sine_i <= sine_2sym_i[15:16-N_OUT];
end

endmodule

