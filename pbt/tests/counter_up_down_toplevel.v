`include "bsg_defines.v"

module counter_up_down_toplevel #( parameter max_val_p = 0
                                 , parameter init_val_p = 0
                                 , parameter max_step_p = 0
				 , parameter step_width_lp = `BSG_WIDTH(max_step_p)
				 , parameter ptr_width_lp = `BSG_WIDTH(max_val_p))
   



   ( input                            clk_i
   , input                            reset_i

   , input        [step_width_lp-1:0] up_i
   , input        [step_width_lp-1:0] down_i

   , output logic [ptr_width_lp-1:0]  count_o
    );


   bsg_counter_up_down #(.max_val_p(max_val_p), .init_val_p(init_val_p), .max_step_p(max_step_p)) u0 (.clk_i(clk_i), .reset_i(reset_i), .up_i(up_i), .down_i(down_i), .count_o(count_o));

endmodule
