module counter_test ( input logic clk, input logic reset, input logic [0:0] up, input logic [0:0] dn, output logic [6:0] o);

   
   bsg_counter_up_down #(.max_val_p(100), .max_step_p(1), .init_val_p(0)) u0 ( .clk_i(clk), .reset_i(reset), .up_i(up), .down_i(dn), .count_o(o));
   
   
endmodule



