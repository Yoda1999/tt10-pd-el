/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_yoda_1999full_adder (
    input wire a,        // First input
    input wire b,        // Second input
    input wire cin,      // Carry input
    input  wire clk,
    input  wire       ena,
    output wire sum,     // Sum output
    output  wire cout,    // Carry output
    input  wire       rst_n,
    input  wire [7:0] ui_in,
    input wire [7:0] uio_in
);

    // Internal signals
    wire sum1, c1, c2;
    wire _unused = &{clk,ena,rst_n,ui_in,1'b0};
    // Sum calculation
    xor (sum1, a, b);
    xor (sum, sum1, cin);

    // Carry calculation
    and (c1, a, b);
    and (c2, sum1, cin);
    or (cout, c1, c2);

endmodule


