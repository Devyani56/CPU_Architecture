`include "define.v"

module exe_wb(clk,rst,aluout_wb_in,aluout_wb_out,waddr_wb_in,waddr_wb_out);

input clk,rst;
input [`DSIZE-1:0] aluout_wb_in;
input [`ASIZE-1:0] waddr_wb_in;
output reg [`ASIZE-1:0] waddr_wb_out;
output reg [`DSIZE-1:0] aluout_wb_out;

 always@(posedge clk)
		begin
			if(rst)
				begin
				
				aluout_wb_out <= 0;
				waddr_wb_out <= 0;

				end
			else
			     begin
			     aluout_wb_out <= aluout_wb_in;
			     waddr_wb_out <= waddr_wb_in;
			     end
		end



//Here we need not take write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.

endmodule
