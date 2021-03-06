//
// MultiLatch.v - for the PDP-8 in Verilog project
//
// github.com/SmallRoomLabs/PDP8-Verilog
// Mats Engstrom - mats.engstrom@gmail.com
//
// MultiLatch | 1 | 7 | 2 | 0
//

`default_nettype none

module MultiLatch (
  input clk, 
  input reset,
  input [11:0] in,
  input setvalue,
  input latch,
  input latch3,
  input oe1,oe2,oe3,
  output [11:0] out1,
  output [11:0] out2
);

reg lastLatch=0;
reg lastLatch3=0;

reg [11:0] data=0;
reg [11:0] data3=0;

wire [11:0] thisIn=setvalue ? 12'o4000 : in;

always @(posedge clk) begin
  if (reset) begin
    data<=0;
    data3<=0;
  end else begin
    if (latch & ~lastLatch) data<=thisIn;
    if (latch3 & ~lastLatch3) data3<=thisIn;
  end
  lastLatch<=latch;
  lastLatch3<=latch3;
end

wire [11:0] out1a=oe1 ? data : 12'b0;
wire [11:0] out1b=oe3 ? data3 : 12'b0;
assign out1=out1a | out1b;
assign out2=oe2 ? data : 12'b0;

endmodule
