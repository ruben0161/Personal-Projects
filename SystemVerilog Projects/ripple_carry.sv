//This code is preliminary and subject to change
module half_a (
    input a, b,
    output c, s
);
    assign s = a ^ b;
    assign c = a & b;
endmodule

module full_a (
    input a, b, cin,
    output c, s
);
    wire w1, w2, w3;

    half_a h_instance1( .a(a), .b(b), .s(w1), .c(w2) );
    half_a h_instance2( .a(w1), .b(cin), .s(s), .c(w3) );
    assign c = w2 | w3;
endmodule 

module ripple_as (
    input [7:0] a, b,
    input cin,
    output [7:0] s, 
    output c
);
    wire [8:0] carry;
    assign carry[0] = cin;
    assign c = carry[8];

    genvar i;
    generate
        for (i = 0; i < 8; i++) begin : gen_full_adders
            full_a f_instances( .a(a[i]), .b(b[i]), .cin(carry[i]), .c(carry[i+1]), .s(s[i]) );
        end
    endgenerate
endmodule


