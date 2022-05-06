module count4r2m(out,ck,res);
  output wire [3:0] out;
  input  ck; // clock
  input  res; // reset

  // Count4r2m.hs:19:1-9
  reg [3:0] s_1 = 4'b0001;

  // register begin
  always @(posedge ck or  negedge  res) begin : s_1_register
    if ( ! res) begin
      s_1 <= 4'b0001;
    end else begin
      s_1 <= (s_1 * 4'b0010);
    end
  end
  // register end

  assign out = s_1;


endmodule
