`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2026 10:55:25
// Design Name: 
// Module Name: tb
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

module tb;                    
    parameter w = 8;
    reg  [w-1:0] a;
    reg  [w-1:0] b;
    reg  [3:0]   sel;
    wire [w-1:0] out;
    wire         C;
    alu #(.w(w)) DUT (
        .a   (a),
        .b   (b),
        .sel (sel),
        .out (out),
        .C   (C)
    );
    integer i, j;             
    initial begin
        a = 8'd100;           
        b = 8'd45;            
        for (i = 0; i <= 15; i = i + 1) begin   
            sel = i;
            #10;              
        end
        $finish;
    end
endmodule
 

