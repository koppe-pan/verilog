/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 1.6.3. DO NOT MODIFY.
*/
`timescale 100fs/100fs
module topEntity
    ( // Inputs
      input  eta // clock
    , input  eta1 // reset
    , input  eta2 // enable
    , input [0:0] eta_0

      // Outputs
    , output wire [0:0] result
    );
  // Async.hs:48:1-4
  reg [2:0] c$ds_app_arg = 3'd0;
  // Async.hs:30:1-3
  reg [2:0] newAcc;
  wire [3:0] result_1;
  reg [0:0] c$app_arg;
  // Async.hs:30:1-3
  wire [2:0] c$newAcc_case_alt;
  // Async.hs:30:1-3
  reg [2:0] c$newAcc_case_alt_0;

  // register begin
  always @(posedge eta or  posedge  eta1) begin : c$ds_app_arg_register
    if ( eta1) begin
      c$ds_app_arg <= 3'd0;
    end else if (eta2) begin
      c$ds_app_arg <= result_1[3:1];
    end
  end
  // register end

  assign result = result_1[0:0];

  always @(*) begin
    case(eta_0)
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

  assign c$newAcc_case_alt = (eta1) ? 3'd1 : c$newAcc_case_alt_0;

  always @(*) begin
    case(c$ds_app_arg)
      3'b000 : c$newAcc_case_alt_0 = 3'd0;
      3'b001 : c$newAcc_case_alt_0 = 3'd2;
      3'b010 : c$newAcc_case_alt_0 = 3'd3;
      3'b011 : c$newAcc_case_alt_0 = 3'd4;
      default : c$newAcc_case_alt_0 = 3'd1;
    endcase
  end


endmodule

