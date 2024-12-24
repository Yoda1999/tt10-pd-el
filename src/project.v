/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module full_adder (
    input wire a,        // First input
    input wire b,        // Second input
    input wire cin,      // Carry input
    output wire sum,     // Sum output
    output  wire cout     // Carry output
);

    // Internal signals
    wire sum1, c1, c2;

    // Sum calculation
    xor (sum1, a, b);
    xor (sum, sum1, cin);

    // Carry calculation
    and (c1, a, b);
    and (c2, sum1, cin);
    or (cout, c1, c2);

endmodule

