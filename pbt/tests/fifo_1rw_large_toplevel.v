module fifo_1rw_large_toplevel #(parameter width_p = 0
                     , parameter els_p = 0
		     , parameter verbose_p = 0
                     )
   (input                  clk_i
    , input                reset_i
    , input [width_p-1:0]  data_i
    , input                v_i
    , input                enq_not_deq_i

    // full and empty are richer
    // than ready_enq and ready_deq
    // which could mean just this cycle

    , output full_o
    , output empty_o
    , output [width_p-1:0] data_o
    );


   bsg_fifo_1rw_large #(.width_p(width_p), .els_p(els_p), .verbose_p(verbose_p)) u0 (.clk_i(clk_i), .reset_i(reset_i), .data_i(data_i), .v_i(v_i), .enq_not_deq_i(enq_not_deq_i), .full_o(full_o), .empty_o(empty_o), .data_o(data_o));

endmodule
