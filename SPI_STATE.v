
module spi_state(input wire clk,   //system clk
                 input wire reset,  //system asynchronous active high reset
                 input wire[15:0]datain, //binary input data
                output wire spi_cs_l,    //SPI active low chip select
                output wire spi_sclk,    //SPI clock
                output wire spi_data,     // outout data from master to slave
                 output [4:0]counter);
  
  //reg dclk;
  reg [15:0]MOSI; // SPI shift register
  reg [4:0]count;  //control counter
  reg  cs_l;   //SPI chip select (active low)
  reg  sclk;   //
  reg [2:0]state;
  
  always@(posedge clk or posedge reset)
    begin
      if(reset)
        begin
          MOSI<=16'b0;
          count<=5'd16;
          cs_l<=1'b1;
          sclk<=1'b0;
        end
      else 
        begin
          case(state)
            3'b000:begin
              sclk<=1'b0;
              cs_l<=1'b1;
              state<=3'b001;
            end
            3'b001:begin
              sclk<=1'b0;
              cs_l<=1'b0;
              state<=3'b010;
              MOSI<=datain[count-1];
              count<=count-1;
            end
            3'b010:begin
              sclk<=1'b1;
              if(count>0)
                state<=1;
              else begin
                count<=5'd16;
                state<=0;
              end
            end
            default:state<=0;
          endcase
        end
    end
  
  assign spi_cs_l=cs_l;
  assign spi_sclk=sclk;
  assign spi_data=MOSI;
  assign counter=count;
endmodule
