`include "define.v"

module ID_EXE_stage(clk,rst,rdata1_idexe,rdata2_idexe,a_out,b_out,opin_idexe,srcin_idexe,opout_idexe,srcout_idexe,signext_in,signext_out,mux_in,mux_out);
        input clk;
        input rst;
        input [`DSIZE-1:0] rdata1_idexe;
	    input [`DSIZE-1:0] rdata2_idexe;
	    input [5:0] opin_idexe;
	    input [1:0] srcin_idexe;
	    input [31:0] signext_in;
	    input [`ASIZE-1:0] mux_in;
	    output reg [`DSIZE-1:0] a_out;
	    output reg [`DSIZE-1:0] b_out;
	    output reg [5:0] opout_idexe;
	    output reg [1:0] srcout_idexe;
	    output reg [31:0] signext_out;
	    output reg [`ASIZE-1:0] mux_out;
	    
	    
	    always@(posedge clk)
		begin
			if(rst)
				begin
				a_out <= 0;
				b_out <= 0;
				opout_idexe <= 0;
				srcout_idexe <= 0;
				signext_out <= 0;
				mux_out<=0;
                
				end
			else
			     begin
			     a_out <= rdata1_idexe;
				 b_out <= rdata2_idexe;
				 opout_idexe <= opin_idexe;
				 srcout_idexe <= srcin_idexe;
				 signext_out <= signext_in;
				 mux_out<=mux_in;
			     
			     end
		end
	   
//Here we need not take write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.

endmodule


