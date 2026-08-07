`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2026 10:21:38
// Design Name: 
// Module Name: alu
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

module alu #(parameter w = 8) (
    input      [w-1:0] a,        // Operand A
    input      [w-1:0] b,        // Operand B
    input      [3:0]   sel,      // 4-bit opcode (16 operations)
    output reg [w-1:0] out,      // Result
    output reg         C         // Carry / Borrow flag
);
    //  Internal w+1 wide wire to capture carry 
    reg [w:0] temp;
    //  Combinational logic 
    always @(*) begin
        // Default all outputs
        temp = {(w+1){1'b0}};
        out  = {w{1'b0}};
        C    = 1'b0;
        case (sel)
            //  Arithmetic 
            4'b0000: begin  // ADD
                temp = {1'b0, a} + {1'b0, b};
                out  = temp[w-1:0];
                C    = temp[w];         // unsigned carry-out
            end
            4'b0001: begin  // SUB  (A - B)
                temp = {1'b0, a} - {1'b0, b};
                out  = temp[w-1:0];
                C    = temp[w];         // borrow flag
            end
            4'b0010: begin  // MUL (lower w bits)
                out = a * b;
            end
            4'b0011: begin  // INC  (A + 1)
                temp = {1'b0, a} + 1'b1;
                out  = temp[w-1:0];
                C    = temp[w];
            end
            4'b0100: begin  // DEC  (A - 1)
                temp = {1'b0, a} - 1'b1;
                out  = temp[w-1:0];
                C    = temp[w];
            end
            4'b0101: begin  // ABS  |A|
                out = a[w-1] ? (~a + 1'b1) : a;
            end
            //  Logical 
            4'b0110: out = a ^ b;     // XOR
            4'b0111: out = a & b;     // AND
            4'b1000: out = a | b;     // OR
            4'b1001: out = ~(a & b);  // NAND
            4'b1010: out = ~(a | b);  // NOR
            4'b1011: out = ~(a ^ b);  // XNOR
            4'b1100: out = ~a;        // NOT A
            // Shift / Rotate 
            4'b1101: begin  // Rotate Left
                C   = a[w-1];
                out = {a[w-2:0], a[w-1]};
            end
            4'b1110: begin  // Arithmetic Right Shift
                C   = a[0];
                out = {a[w-1], a[w-1:1]};
            end
            // Compare 
            4'b1111: begin  // CMP
                if      (a > b) out = {{(w-1){1'b0}}, 1'b1};  //  1
                else if (a < b) out = {w{1'b1}};               // -1
                else            out = {w{1'b0}};               //  0
            end
            default: out = {w{1'b0}};
        endcase
    end
endmodule
