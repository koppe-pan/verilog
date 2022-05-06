/* AUTOMATICALLY GENERATED VERILOG-2001 SOURCE CODE.
** GENERATED BY CLASH 1.6.3. DO NOT MODIFY.
*/
`timescale 100fs/100fs
module testBench
    ( // No inputs

      // Outputs
      output wire  result
    );
  // Count4r2m.hs:28:1-9
  reg [3:0] s = 4'b0001;
  // Count4r2m.hs:33:3-5
  wire  \Count4r2m.testBench_clk ;
  wire [2:0] z;
  wire [1:0] result_1;
  wire [3:0] c$ds_app_arg;
  wire  c$result_rec;
  reg [1:0] s_0 = 2'd0;
  wire  f1;
  reg  \f'  = 1'b0;
  // Count4r2m.hs:28:1-9
  wire  \c$Count4r2m.testBench_app_arg ;
  // Count4r2m.hs:28:1-9
  wire  \c$Count4r2m.testBench_app_arg_0 ;
  wire [15:0] c$vecFlat;

  // register begin
  always @(posedge \Count4r2m.testBench_clk  or  posedge  \c$Count4r2m.testBench_app_arg ) begin : s_register
    if ( \c$Count4r2m.testBench_app_arg ) begin
      s <= 4'b0001;
    end else begin
      s <= (s * 4'b0010);
    end
  end
  // register end

  // tbClockGen begin
  // pragma translate_off
  reg  clk;
  // 1 = 0.1ps
  localparam half_period = (100 / 2);
  always begin
    // Delay of 1 mitigates race conditions (https://github.com/steveicarus/iverilog/issues/160)
    #1 clk =  0 ;
    `ifndef VERILATOR
    #100000 forever begin
      if (~ c$result_rec) begin
        $finish;
      end
      clk = ~ clk;
      #half_period;
      clk = ~ clk;
      #half_period;
    end
    `else
    clk = $c("this->tb_clock_gen(",half_period,",true,",(~ c$result_rec),")");
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

  assign \Count4r2m.testBench_clk  = clk;
  // pragma translate_on
  // tbClockGen end

  assign z = s_0 + 2'd1;

  assign result_1 = (z > 3'd3) ? 2'd3 : (z[0+:2]);

  assign c$vecFlat = {4'b0001,   4'b0010,
                      4'b0100,   4'b0000};

  // index begin
  wire [3:0] vecArray [0:4-1];
  genvar i;
  generate
  for (i=0; i < 4; i=i+1) begin : mk_array
    assign vecArray[(4-1)-i] = c$vecFlat[i*4+:4];
  end
  endgenerate
  assign c$ds_app_arg = vecArray[($unsigned({{(64-2) {1'b0}},s_0}))];
  // index end

  assign c$result_rec = \f'  ? \f'  : f1;

  // register begin
  always @(posedge \Count4r2m.testBench_clk  or  posedge  \c$Count4r2m.testBench_app_arg ) begin : s_0_register
    if ( \c$Count4r2m.testBench_app_arg ) begin
      s_0 <= 2'd0;
    end else begin
      s_0 <= result_1;
    end
  end
  // register end

  // assertBitVector begin
  // pragma translate_off
  wire [3:0] maskXor  = c$ds_app_arg ^ c$ds_app_arg;
  wire [3:0] checked  = s ^ maskXor;
  wire [3:0] expected = c$ds_app_arg ^ maskXor;

  always @(posedge \Count4r2m.testBench_clk ) begin
    if (checked !== expected) begin
      $display("@%0tns: %s, expected: %b, actual: %b", $time, ("outputVerifierBitVector"), c$ds_app_arg, s);
      $finish;
    end
  end
  // pragma translate_on
  assign f1 = \f' ;
  // assertBitVector end

  // register begin
  always @(posedge \Count4r2m.testBench_clk  or  posedge  \c$Count4r2m.testBench_app_arg ) begin : f_register
    if ( \c$Count4r2m.testBench_app_arg ) begin
      \f'  <= 1'b0;
    end else begin
      \f'  <= (s_0 == 2'd3);
    end
  end
  // register end

  assign \c$Count4r2m.testBench_app_arg  = (~ (\c$Count4r2m.testBench_app_arg_0 ));

  // resetGen begin
  // pragma translate_off
  reg  rst;
  localparam reset_period = 100000 - 10 + (3 * 100);
  `ifndef VERILATOR
  initial begin
    #1 rst =  1 ;
    #reset_period rst =  0 ;
  end
  `else
  always begin
    // The redundant (rst | ~ rst) is needed to ensure that this is
    // calculated in every cycle by verilator. Without it, the reset will stop
    // being updated and will be stuck as asserted forever.
    rst = $c("this->reset_gen(",reset_period,",true)") & (rst | ~ rst);
  end
  `systemc_interface
  CData reset_gen(vluint32_t reset_period, bool active_high) {
    static vluint32_t to_wait = reset_period;
    static CData reset = active_high ? 1 : 0;
    static bool finished = false;

    if(!finished) {
      if(to_wait == 0) {
        reset = reset == 0 ? 1 : 0;
        finished = true;
      }
      else {
        to_wait = to_wait - 1;
      }
    }

    return reset;
  }
  `verilog
  `endif
  assign \c$Count4r2m.testBench_app_arg_0  = rst;
  // pragma translate_on
  // resetGen end

  assign result = c$result_rec;


endmodule

