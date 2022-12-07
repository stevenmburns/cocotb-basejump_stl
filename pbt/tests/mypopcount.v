module mypopcount #(parameter width_p="inv")
        ( input logic [width_p-1:0] i,
          output logic [$clog2(width_p+1)-1:0] o);
        
        integer idx;

        always_comb begin
            o = 0;    
            for (idx = 0; idx < width_p; idx = idx + 1) begin
               o = o + i[idx];
            end
        end
   
endmodule
