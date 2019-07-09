//
// Author: tclarke
// Licensed under the GNU Public License (GPL) v3
//


module dds_sine (
        input clk,
        input rst,
        input [N_TUNING-1:0] tuning_word,
        output reg [9:0] sine
);
parameter SIN_LUT_FILE = "sine_lut.hex";
parameter N_ACCUM = 14;
parameter N_TUNING = 10;

reg [N_ACCUM-1:0] accum = 0;
reg signed [15:0] lut[0:255];
reg [14:0] sine_1sym;
/* verilator lint_off UNUSED */
wire [15:0] sine_2sym;
/* verilator lint_on UNUSED */

initial begin
    $readmemh(SIN_LUT_FILE, lut);
end

always @ (posedge clk) begin
    if (~rst) accum <= 0;
    else      accum <= accum + {3'b0, tuning_word};
    sine_1sym <= accum[N_ACCUM-2] ? lut[~accum[N_ACCUM-3:N_ACCUM-10]][14:0] : lut[accum[N_ACCUM-3:N_ACCUM-10]][14:0];
end

assign sine_2sym = accum[N_ACCUM-1] ? {1'b0, -sine_1sym} : {1'b1, sine_1sym};

always @ (negedge clk) begin
    sine <= sine_2sym[15:6];
end

endmodule

