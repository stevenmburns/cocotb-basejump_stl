module popcount_toplevel #(parameter width_p = 2)
   (input [width_p-1:0] i
    , output [$clog2(width_p+1)-1:0] o
    );

   bsg_popcount #(.width_p(width_p)) u0 (.i(i), .o(o));

endmodule
