module mul(A,B,O,ck,start,fin);
  input [7:0] A, B;
  input ck,start;
  output [16:0] O;
  output fin;

  // Mul.hs:41:1-9
  reg [81:0] c$ds_app_arg = {17'b00000000000000000,   64'sd0,   1'b0};
  wire [99:0] result_4;
  reg  c$case_alt;
  // Mul.hs:28:1-3
  wire [16:0] y;
  // Mul.hs:28:1-3
  wire [7:0] b;
  // Mul.hs:28:1-3
  wire signed [63:0] y2;
  // Mul.hs:28:1-3
  wire signed [63:0] st;
  wire [15:0] eta4;
  wire [17:0] result;

  assign eta4 = {A, B};

  // register begin
  always @(posedge ck) begin : c$ds_app_arg_register
    if (start==1) begin
      c$ds_app_arg <= {17'b00000000000000000,   64'sd0,   1'b0};
    end else begin
      c$ds_app_arg <= result_4[99:18];
    end
  end
  // register end

  assign result = result_4[17:0];

  assign result_4 = {{(y << 64'sd1) + ({9'b000000000,(eta4[15:8] * (8'b00000001 & (b >> 64'sd7 - y2)))}),
                      y2 + 64'sd1,   c$case_alt},   {y,
                                                     c$ds_app_arg[0:0]}};

  always @(*) begin
    case(y2)
      64'sd7 : c$case_alt = 1'b1;
      default : c$case_alt = 1'b0;
    endcase
  end

  assign y = c$ds_app_arg[81:65];

  assign b = eta4[7:0];

  assign y2 = st;

  assign st = $signed(c$ds_app_arg[64:1]);

  assign O = result[17:1];

  assign fin = result[0:0];


endmodule
