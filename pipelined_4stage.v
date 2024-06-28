`timescale 1ns / 1ps
`include "define.v"

module pipelined_4stage(clk, rst, aluout);

input clk;														
input rst;
output [`DSIZE-1:0] aluout;	
//for memory module - clk and rst from inputs, addr from input, 

wire  [`ISIZE-1:0] instr_out;
wire[`ISIZE-1:0] addr_to_IMM;
wire[`ISIZE-1:0] instr_out_pp;


    PC1 PC(.clk(clk),
    .rst(rst),
    .nextPC(addr_to_IMM),
    .currPC(addr_to_IMM));


    datapath_mux D0(.clk(clk),
    .rst(rst), 
    .inst(instr_out_pp),
    .aluout(aluout)); 
    
    memory MEM(.clk(clk),
    .rst(rst),
    .wen(),
    .addr(addr_to_IMM),
    .data_in(),
    .fileid(0),
    .data_out(instr_out));
    
    
    IF_ID_stage FD0(.clk(clk),
    .rst(rst),
    .inst(instr_out),
    .out(instr_out_pp));
    

endmodule


