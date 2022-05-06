module alu(A,B,O,CTR,ck);
  input [7:0] A, B;
  input [3:0] CTR;
  input ck;
  output [7:0] O;
  reg [7:0] INA, INB, O;
  reg [3:0] C;
  wire [7:0] OUT;

  // Alu.hs:62:1-9
  reg [3:0] c$ds_app_arg;
  wire [7:0] c$case_alt;
  wire [7:0] c$case_alt_0;
  reg [7:0] result_1;
  // Alu.hs:54:1-3
  reg [7:0] acc = 8'b00000000;
  // Alu.hs:54:1-3
  wire [7:0] a;
  // Alu.hs:54:1-3
  wire [7:0] b;
  // Alu.hs:54:1-3
  wire [3:0] c;
  wire [19:0] eta2;

  assign eta2 = {A,   B,   CTR};

  always @(*) begin
    case(c)
      4'b0000 : c$ds_app_arg = 4'd0;
      4'b0001 : c$ds_app_arg = 4'd1;
      4'b1000 : c$ds_app_arg = 4'd2;
      4'b1001 : c$ds_app_arg = 4'd3;
      4'b1010 : c$ds_app_arg = 4'd4;
      4'b1011 : c$ds_app_arg = 4'd5;
      4'b1100 : c$ds_app_arg = 4'd6;
      4'b1101 : c$ds_app_arg = 4'd7;
      4'b1110 : c$ds_app_arg = 4'd8;
      4'b1111 : c$ds_app_arg = 4'd9;
      default : c$ds_app_arg = 4'd10;
    endcase
  end

  // rotateL begin
  wire [2*8-1:0] bv;
  assign bv = {a,a} << (64'sd1 % 8);
  assign c$case_alt = bv[2*8-1 : 8];
  // rotateL end

  // rotateR begin
  wire [2*8-1:0] bv_0;
  assign bv_0 = {a,a} >> (64'sd1 % 8);
  assign c$case_alt_0 = bv_0[8-1 : 0];
  // rotateR end

  always @(*) begin
    case(c$ds_app_arg)
      4'b0000 : result_1 = a + b;
      4'b0001 : result_1 = a - b;
      4'b0010 : result_1 = a & b;
      4'b0011 : result_1 = a | b;
      4'b0100 : result_1 = a ^ b;
      4'b0101 : result_1 = {8 {1'bx}};
      4'b0110 : result_1 = a >> 64'sd1;
      4'b0111 : result_1 = a << 64'sd1;
      4'b1000 : result_1 = c$case_alt_0;
      4'b1001 : result_1 = c$case_alt;
      default : result_1 = 8'b00000000;
    endcase
  end

  // register begin
  always @(posedge ck) begin : acc_register
    acc <= result_1;
    O <= OUT;
  end
  // register end

  assign a = eta2[19:12];

  assign b = eta2[11:4];

  assign c = eta2[3:0];

  assign OUT = acc;


endmodule
