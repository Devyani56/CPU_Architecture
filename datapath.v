`include"define.v"
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////
//// Company: NTU
//// Engineer: Dr. Smitha K G
////////////////////////////////////////////////////////////////////////////////////

module datapath_mux (
	// inputs
	clk,
	rst,
	inst,

	//outputs
	aluout
);

// inputs
input		  clk;
input		  rst;
input  [`ISIZE-1:0] inst;


// outputs
output  [`DSIZE-1:0] aluout;


wire [2:0]	aluop;
wire [2:0] aluop_idexe;
wire alusrc;
wire alusrc_idexe;
wire regDST;
wire wen;

wire  [`DSIZE-1:0] aluout_out_wb;
wire [31:0] signext_out;
wire [31:0] signext_out_idexe;
wire [`DSIZE-1:0] rdata1;
wire [`DSIZE-1:0] rdata2;
wire [`DSIZE-1:0] rdata1_outidexe;
wire [`DSIZE-1:0] rdata2_outidexe;
//wire [`DSIZE-1:0] wdata_out;
wire [`ASIZE-1:0] waddr_out;

wire [`ASIZE-1:0] waddr_out_wb;

//wire [`DSIZE-1:0]rdata2_imm=alusrc ? {16'b0,inst[15:0]} : rdata2;//Multiplexer to select the immediate value or rdata2 based on alusrc.
wire [`DSIZE-1:0]rdata2_imm=alusrc_idexe ? signext_out_idexe : rdata2_outidexe;
//when alusrc is 1 then connect immediate data to output else connect rdata2 to output

wire [`ASIZE-1:0]waddr_regDST=regDST ? inst[15:11] : inst[20:16];//Multiplexer to select the inst[15:11] or inst[20:16] as the waddr based on regDST.
//when regDST is 1 then connect inst[15:11] to output else connect inst[20:16] to output

//Here you need to instantiate the control , Alu , regfile and the delay registers. 
    control C0(.inst_cntrl(inst[31:26]),
    .wen_cntrl(wen), 
    .alusrc_cntrl(alusrc), 
    .regdst_cntrl(regDST), 
    .aluop_cntrl(aluop)); 
    
    regfile RF0(.clk(clk), 
    .rst(rst), 
    .wen(wen), 
    .raddr1(inst[25:21]), 
    .raddr2(inst[20:16]), 
    .waddr(waddr_out_wb), 
    .wdata(aluout_out_wb), 
    .rdata1(rdata1), 
    .rdata2(rdata2)); 
    
//    delay_reg DRO(.clk(clk),.rst(rst), .waddrin(waddr_regDST), .wdatain(aluout),.waddrout(waddr_out), .wdataout(wdata_out));


    sign_extend se0(.imm_in(inst[15:0]),
                    .imm_out(signext_out));
                    
                    
    ID_EXE_stage ID_EXE0(.clk(clk),
                         .rst(rst),
                         .rdata1_idexe(rdata1),
                         .rdata2_idexe(rdata2),
                         .a_out(rdata1_outidexe),
                         .b_out(rdata2_outidexe),
                         .opin_idexe(aluop),
                         .srcin_idexe(alusrc),
                         .opout_idexe(aluop_idexe),
                         .srcout_idexe(alusrc_idexe),
                         .signext_in(signext_out),
                         .signext_out(signext_out_idexe),
                         .mux_in(waddr_regDST),
                         .mux_out(waddr_out));
                         
                         
   exe_wb EXE_WB0(.clk(clk),
   .rst(rst),
   .aluout_wb_in(aluout),
   .aluout_wb_out(aluout_out_wb),
   .waddr_wb_in(waddr_out),
   .waddr_wb_out(waddr_out_wb));
        
    alu ALU0(.a(rdata1_outidexe),
    .b(rdata2_imm),
    .op(aluop_idexe),
    .out(aluout));
   
//-insert your code here

endmodule // end of datapath module