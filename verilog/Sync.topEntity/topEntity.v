`timescale 100fs/100fs
module sync
    ( // Inputs
      input  clk // clock
    , input  en // enable
    , input [0:0] start

      // Outputs
    , output wire [0:0] result
    );
  // Sync.hs:50:1-4
  reg [2:0] c$ds_app_arg = 3'd0;
  // Sync.hs:32:1-3
  reg [2:0] newAcc;
  wire [3:0] result_1;
  reg [0:0] c$app_arg;
  // Sync.hs:32:1-3
  reg [2:0] c$newAcc_case_alt;

  // register begin
  always @(posedge clk) begin : c$ds_app_arg_register
    if (en) begin
      c$ds_app_arg <= result_1[3:1];
    end
  end
  // register end

  assign result = result_1[0:0];

  always @(*) begin
    case(start)
      1'b1 : newAcc = 3'd1;
      default : newAcc = c$newAcc_case_alt;
    endcase
  end

  assign result_1 = {newAcc,   c$app_arg};

  always @(*) begin
    case(newAcc)
      3'b001 : c$app_arg = 1'b1;
      default : c$app_arg = 1'b0;
    endcase
  end

  always @(*) begin
    case(c$ds_app_arg)
      3'b000 : c$newAcc_case_alt = 3'd0;
      3'b001 : c$newAcc_case_alt = 3'd2;
      3'b010 : c$newAcc_case_alt = 3'd3;
      3'b011 : c$newAcc_case_alt = 3'd4;
      default : c$newAcc_case_alt = 3'd1;
    endcase
  end


endmodule
