/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module full_adder (
    input a,        // First input
    input b,        // Second input
    input cin,      // Carry input
    output sum,     // Sum output
    output cout     // Carry output
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

