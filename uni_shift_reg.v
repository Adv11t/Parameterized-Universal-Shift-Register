`timescale 1ns / 1ps
/////////////////////////////////////// d flip flop
module dff(input d, input clk, input clr, 
output reg q);
always @(posedge clk) begin
if(clr) begin
q <= 1'b0;
end
else begin
q <= d;
end
end
endmodule
////////////////////////////4:1 mux
module mux(input [1:0] s, 
output reg mout ,
input a,b,c,d);
always @(*) begin
case(s)
2'b00: mout = a;
2'b01: mout = b;
2'b10: mout = c;
2'b11: mout = d;
endcase
end
endmodule
////////////////////////////// universal shift register
module uni_shift_reg #(parameter n = 3)(input clock, input clear , 
input [n-1:0] in,input [1:0] sel, 
input left_in, input right_in,
output [n-1:0] out);
// left in is input from left side for right shift and vice versa
// 2'b00: unchanged
// 2'b01: parallel loading
// 2'b10: left shift
// 2'b11: right shift
wire [n-1:0] dmid, qmid;
genvar i;
generate
for(i=0;i<n;i=i+1) begin: logic
wire a,b,c,d;
assign a = qmid[i];
assign b = in[i];
// c and d written like this to avoid errors in edge cases
assign c = (i == 0) ? right_in : qmid[i-1];
assign d = (i == n-1)   ? left_in  : qmid[i+1];
mux inst1(.s(sel),
.a(a),
.b(b),
.c(c),
.d(d),
.mout(dmid[i]));
dff inst2(.d(dmid[i]),
.clk(clock),
.clr(clear),
.q(qmid[i]));
end
endgenerate
assign out = qmid;
endmodule
