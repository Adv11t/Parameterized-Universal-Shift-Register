`timescale 1ns / 1ps
module testbench;
parameter n = 3;
reg clk,clr;
reg [ 1:0] sel;
reg [n-1:0] inp;
wire [n-1:0] out;
reg left_in, right_in;
// instantiating
uni_shift_reg inst1(.clock(clk), 
.clear(clr), 
.sel(sel), 
.in(inp), 
.out(out), 
.left_in(left_in),
.right_in(right_in));
// 10 ns time period
always #5 clk = ~clk;
initial 
begin
clk = 0;
clr = 0;
sel = 2'b00;
inp = 3'b000;
left_in = 0;
right_in = 0;
// parallel load
inp = 3'b010;
sel = 2'b01;
#10;
//hold
sel = 2'b00;
#10;
//clear
clr =1;
#10;
clr=0;
// left shift 1;
sel = 2'b10;
right_in = 1'b1;
#10;
// right shift 1
sel = 2'b11;
left_in = 1'b1;
#10;
$finish;
end
endmodule
