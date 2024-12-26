/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_yoda_1999full_adder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal signals
    //wire a,b,cin;
    wire sum,cout;
    wire sum1, c1, c2;
    wire _unused = &{clk,ena,rst_n,uio_in,1'b0};

    wire a=ui_in[0];
    wire b=ui_in[1];
    wire c=ui_in[2];
                   
    // Sum calculation
    xor (sum1, a, b);
    xor (sum, sum1, cin);

    // Carry calculation
    and (c1, a, b);
    and (c2, sum1, cin);
    or (cout, c1, c2);

    assign uo_out={6'b0,cout,sum};
    assign uio_out = 0;
    assign uio_oe  = 0;
endmodule


