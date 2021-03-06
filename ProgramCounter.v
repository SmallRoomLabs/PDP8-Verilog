//
// ProgramCounter.v - for the PDP-8 in Verilog project
//
// github.com/SmallRoomLabs/PDP8-Verilog
// Mats Engstrom - mats.engstrom@gmail.com
//
// ProgramCounter | 1 | 5 | 2 | 0
//

`default_nettype none

module ProgramCounter (
  input clk,
  input reset,
  input [11:0] in,
  input inc,
  input load,
  input irqOverride,
  input ckFetch,
  input LATCH,
  output [11:0] PC,
  output [11:0] PCLAT
);

reg [11:0] thisPC=0;
reg [11:0] thisPCLAT=0;
reg prevLoad=0;

wire thisInc=inc & ~(irqOverride & ckFetch);

assign PC=thisPC;
assign PCLAT=thisPCLAT;

always @(posedge clk) begin 
  if (reset) begin
    thisPC<=12'o0200;
    thisPCLAT<=12'o0200;
    prevLoad<=0;
  end else if (load && !prevLoad) begin
    thisPC <= in;
  end else if (thisInc) begin
    thisPC<=thisPC+1;
  end
  if (LATCH) thisPCLAT<=thisPC;

  prevLoad <= load;
end


endmodule
