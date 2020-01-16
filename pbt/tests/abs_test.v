module abs_test ( input [7:0] a, output [7:0] o);

   
   bsg_abs #(.width_p(8)) u0 ( .a_i(a), .o(o));
   
   
endmodule
