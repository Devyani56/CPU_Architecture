`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 17:24:09
// Design Name: 
// Module Name: sign_extend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "define.v"
module sign_extend(input [15:0] imm_in,output reg [31:0] imm_out);

always @(imm_in)
begin
    case(imm_in[15])
    
    1: begin
        imm_out[31:16] <= 0'b1111111111111111;
        imm_out[15:0] <= imm_in;
        
        end
    0: begin
        imm_out[31:16] <= 0'b0000000000000000;
        imm_out[15:0] <= imm_in;
        
       end
       
     endcase
end



endmodule
