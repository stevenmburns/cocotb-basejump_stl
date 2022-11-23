module fifo_1r1w_small_toplevel #( parameter width_p = 0
				, parameter els_p = 0
                                , parameter harden_p     = 0
                                , parameter ready_THEN_valid_p = 0
                                )
    ( input                clk_i
    , input                reset_i

    , input                v_i
    , output               ready_o
    , input [width_p-1:0]  data_i

    , output               v_o
    , output [width_p-1:0] data_o
    , input                yumi_i
    );
    
   bsg_fifo_1r1w_small #(.width_p(width_p), .els_p(els_p), .harden_p(harden_p), .ready_THEN_valid_p(ready_THEN_valid_p)) u0 (.clk_i(clk_i), .reset_i(reset_i), .v_i(v_i), .ready_o(ready_o), .data_i(data_i), .v_o(v_o), .data_o(data_o), .yumi_i(yumi_i));
   
endmodule
