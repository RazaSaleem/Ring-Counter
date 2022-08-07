// Code your testbench here
// or browse Examples
module tb_PLShift_reg;
  reg clk; // clk
  reg rst;
  reg en;
  reg load;
  reg [7:0] Data;
  wire [3:0] Ones;
  wire[7:0] Seg_Out;
  wire [7:0] Q; // output of module under test
  
  
  PLShift_reg UUT1(.Data(Data),.en(en),.rst(rst),.clk(clk),.load(load),.Ones(Ones),.Q(Q));
  
  PLShift_reg_SSeg UUT2(.Data(Data),.en(en),.rst(rst),.clk(clk),.load(load),.Seg_Out(Seg_Out),.Q(Q));
  
  
  initial
    begin
      clk = 1'b0;
      rst = 1'b0;
      #3 rst = 1'b1;
      #10 rst = 1'b0;
    end
  
  initial begin en=1'b0;
    #30 en=1'b1;
  end
  
  initial begin load=1'b1;
    #40 load=1'b0;
    #30 load=1'b1;
    #20 load=1'b0;
    #30 load=1'b1;
    #20 load=1'b0;
  end

  // Clock generation. 20ns period or 10ns half period
  always
    #10 clk = ~clk;
  initial
    #400 $finish;
  initial begin
    Data=8'd7;
    repeat(30)
      #20
      Data=Data+8'd1;
  end
  initial
    begin
      $dumpfile("dump1.vcd");
      $dumpvars(1);
    end


endmodule
