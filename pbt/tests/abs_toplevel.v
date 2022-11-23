module abs_toplevel #( parameter width_p=2 )
(
  input [width_p-1:0] a_i
  ,output logic [width_p-1:0] o
);

   bsg_abs #(.width_p(width_p)) u0 (.a_i(a_i), .o(o));
   
endmodule
