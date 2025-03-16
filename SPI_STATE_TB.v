module tb_spi_state();
  reg clk;
  reg reset;
  reg [15:0]datain;
  
  wire spi_cs_l;
  wire spi_sclk;
  wire spi_data;
  wire [4:0]counter;
          //INSTANTIATE THE DESIGN UNDER TEST
  spi_state DTU(.clk(clk),.reset(reset),.datain(datain),.spi_cs_l(spi_cs_l),.spi_sclk(spi_sclk),.spi_data(spi_data),.counter(counter));
   initial
     begin
       clk=0;
       reset=1;
       datain=0;
   end
  always #5 clk=~clk;
  initial
    begin
      #10 reset=0;
      #10 datain=16'hA569;
      #335 datain=16'h2563;
       #335 datain=16'h9B63;
       #335 datain=16'h6A61;
      
       #335 datain=16'hA265;
       #335 datain=16'h7564;
      #10000 $finish;
  end
initial 
begin
$dumpfile("testbench.vcd");
$dumpvars(0,tb_spi_state);
end
 
 
endmodule
