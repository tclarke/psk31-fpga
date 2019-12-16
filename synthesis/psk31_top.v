//
// Author: tclarke
// Licensed under the GNU Public License (GPL) v3
//

`include "../src/dds_sine.v"

/* verilator lint_off UNUSED */
module psk31_top (
        input clk,
        input rst,
        output sck,
        output ws,
        output sd
);

wire signed [15:0] sine;
wire signed [15:0] sine_i;
wire signed [15:0] adata;
reg adata_send = 1'b0;
logic i2s_clk = 1'b0;
reg [7:0] i2s_clk_cnt = 8'b0;

initial assign adata = sine;

// The carrier generator.
// DDS_TUNING_WORD = f * 2**DDS_N_ACCUM / f_s   where f is the desired output freq and f_S is the sysclk
dds_sine dds (.clk(clk), .rst(rst), .tuning_word(10'd8), .sine(sine), .sine_i(sine_i));

// The audio output
i2s_tx i2s(.i_sys_clk(clk), .i_sys_rst(~rst),
           .i_left_data(adata), .i_right_data(adata),
           .i_left_vld(adata_send), .i_right_vld(adata_send),
           .o_sck(sck), .o_ws(ws), .o_sd(sd));

// 48kHz clock for the i2s
always @ (posedge clk) begin
    if (i2s_clk_cnt == 250) begin
        i2s_clk_cnt <= 0;
        i2s_clk <= 0;
    end else if (i2s_clk_cnt == 125) begin
        i2s_clk_cnt <= i2s_clk_cnt + 1'b1;
        i2s_clk <= 1;
    end else  i2s_clk_cnt <= i2s_clk_cnt + 1'b1;
end

endmodule

