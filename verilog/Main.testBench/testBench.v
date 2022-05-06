/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 1.6.3. DO NOT MODIFY.
*/
`timescale 100fs/100fs
module testBench
    ( // No inputs

      // Outputs
      output wire  result
    );
  wire [4:0] z;
  wire [3:0] result_1;
  wire [0:0] c$ds_app_arg;
  wire  c$result_rec;
  reg [3:0] s = 4'd0;
  wire  f1;
  reg  \f'  = 1'b0;
  // Async.hs:77:3-5
  wire  \Main.testBench_clk ;
  // Async.hs:48:1-4
  reg [2:0] c$ds_app_arg_0 = 3'd0;
  wire [0:0] result_2;
  // Async.hs:30:1-3
  reg [2:0] newAcc;
  wire [3:0] result_3;
  reg [0:0] c$app_arg;
  // Async.hs:30:1-3
  wire [2:0] c$newAcc_case_alt;
  // Async.hs:30:1-3
  reg [2:0] c$newAcc_case_alt_0;
  wire [3:0] c$ds_app_arg_1;
  wire [0:0] c$ds_app_arg_2;
  reg [3:0] s_0 = 4'd0;
  wire [14:0] c$vecFlat;
  wire  c$rst;
  wire  c$rst_0;
  wire  c$rst_1;
  wire [14:0] c$vecFlat_0;
  wire  c$rst_2;

  assign z = s + 4'd1;

  assign result_1 = (z > 5'd14) ? 4'd14 : (z[0+:4]);

  assign c$vecFlat = {1'b0,   1'b0,   1'b1,
                      1'b0,   1'b0,   1'b0,   1'b1,   1'b0,   1'b1,
                      1'b0,   1'b0,   1'b0,   1'b1,   1'b0,   1'b0};

  // index begin
  wire [0:0] vecArray [0:15-1];
  genvar i;
  generate
  for (i=0; i < 15; i=i+1) begin : mk_array
    assign vecArray[(15-1)-i] = c$vecFlat[i*1+:1];
  end
  endgenerate
  assign c$ds_app_arg = vecArray[($unsigned({{(64-4) {1'b0}},s}))];
  // index end

  assign c$result_rec = \f'  ? \f'  : f1;

  assign c$rst = ((1'b0));

  // register begin
  always @(posedge \Main.testBench_clk  or  posedge  c$rst) begin : s_register
    if ( c$rst) begin
      s <= 4'd0;
    end else begin
      s <= result_1;
    end
  end
  // register end

  // assert begin
  // pragma translate_off
  always @(posedge \Main.testBench_clk ) begin
    if (result_2 !== c$ds_app_arg) begin
      $display("@%0tns: %s, expected: %b, actual: %b", $time, ("outputVerifier"), c$ds_app_arg, result_2);
      $finish;
    end
  end
  // pragma translate_on
  assign f1 = \f' ;
  // assert end

  assign c$rst_0 = ((1'b0));

  // register begin
  always @(posedge \Main.testBench_clk  or  posedge  c$rst_0) begin : f_register
    if ( c$rst_0) begin
      \f'  <= 1'b0;
    end else begin
      \f'  <= (s == 4'd14);
    end
  end
  // register end

  // tbClockGen begin
  // pragma translate_off
  reg  clk;
  // 1 = 0.1ps
  localparam half_period = (100000 / 2);
  always begin
    // Delay of 1 mitigates race conditions (https://github.com/steveicarus/iverilog/issues/160)
    #1 clk =  0 ;
    `ifndef VERILATOR
    #100000 forever begin
      if (~ (~ c$result_rec)) begin
        $finish;
      end
      clk = ~ clk;
      #half_period;
      clk = ~ clk;
      #half_period;
    end
    `else
    clk = $c("this->tb_clock_gen(",half_period,",true,",(~ (~ c$result_rec)),")");
    `endif
  end

  `ifdef VERILATOR
    `systemc_interface
    CData tb_clock_gen(vluint32_t half_period, bool active_rising, bool result_rec) {
      static vluint32_t init_wait = 100000;
      static vluint32_t to_wait = 0;
      static CData clock = active_rising ? 0 : 1;

      if(init_wait == 0) {
        if(result_rec) {
          std::exit(0);
        }
        else {
          if(to_wait == 0) {
            to_wait = half_period - 1;
            clock = clock == 0 ? 1 : 0;
          }
          else {
            to_wait = to_wait - 1;
          }
        }
      }
      else {
        init_wait = init_wait - 1;
      }

      return clock;
    }
    `verilog
  `endif

  assign \Main.testBench_clk  = clk;
  // pragma translate_on
  // tbClockGen end

  assign c$rst_1 = ((1'b0));

  // register begin
  always @(posedge \Main.testBench_clk  or  posedge  c$rst_1) begin : c$ds_app_arg_0_register
    if ( c$rst_1) begin
      c$ds_app_arg_0 <= 3'd0;
    end else begin
      c$ds_app_arg_0 <= result_3[3:1];
    end
  end
  // register end

  assign result_2 = result_3[0:0];

  always @(*) begin
    case(c$ds_app_arg_2)
      1'b1 : newAcc = 3'd1;
      default : newAcc = c$newAcc_case_alt;
    endcase
  end

  assign result_3 = {newAcc,   c$app_arg};

  always @(*) begin
    case(newAcc)
      3'b001 : c$app_arg = 1'b1;
      default : c$app_arg = 1'b0;
    endcase
  end

  assign c$newAcc_case_alt = (((1'b0))) ? 3'd1 : c$newAcc_case_alt_0;

  always @(*) begin
    case(c$ds_app_arg_0)
      3'b000 : c$newAcc_case_alt_0 = 3'd0;
      3'b001 : c$newAcc_case_alt_0 = 3'd2;
      3'b010 : c$newAcc_case_alt_0 = 3'd3;
      3'b011 : c$newAcc_case_alt_0 = 3'd4;
      default : c$newAcc_case_alt_0 = 3'd1;
    endcase
  end

  assign c$ds_app_arg_1 = (s_0 < 4'd14) ? (s_0 + 4'd1) : s_0;

  assign c$vecFlat_0 = {1'b0,   1'b0,   1'b1,
                        1'b0,   1'b0,   1'b0,   1'b0,   1'b0,   1'b1,
                        1'b0,   1'b0,   1'b0,   1'b1,   1'b0,   1'b0};

  // index begin
  wire [0:0] vecArray_0 [0:15-1];
  genvar i_0;
  generate
  for (i_0=0; i_0 < 15; i_0=i_0+1) begin : mk_array_0
    assign vecArray_0[(15-1)-i_0] = c$vecFlat_0[i_0*1+:1];
  end
  endgenerate
  assign c$ds_app_arg_2 = vecArray_0[($unsigned({{(64-4) {1'b0}},s_0}))];
  // index end

  assign c$rst_2 = ((1'b0));

  // register begin
  always @(posedge \Main.testBench_clk  or  posedge  c$rst_2) begin : s_0_register
    if ( c$rst_2) begin
      s_0 <= 4'd0;
    end else begin
      s_0 <= c$ds_app_arg_1;
    end
  end
  // register end

  assign result = c$result_rec;


endmodule

