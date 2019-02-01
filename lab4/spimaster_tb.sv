// spimaster_tb.sv - testbench for write-only SPI master interface
// ELEX 7660 201710 Lab 4
// Ed.Casas 2017-1-30

module spimaster_tb ;

   logic [31:0] writedata = '0, readdata ;
   logic write = '0, read = '0 ;

   logic sclk, mosi, csn, dcn, resetn ;

   logic reset, clk = '1 ;

   spimaster #(4) s0 (.*) ;

   initial begin

      // $dumpfile("spimaster_tb.vcd");
      // $dumpvars ;

      // reset
      reset = '1 ;
      repeat(2) @(negedge clk) ;
      reset = '0 ;

      // write 0xc5
      writedata = 32'h1c5 ;
      write = '1 ;
      repeat(1) @(negedge clk) ;
      write = '0 ;
      repeat(40) @(negedge clk) ;

      // write 0x5c
      writedata = 32'h5c ;
      write = '1 ;
      repeat(1) @(negedge clk) ;
      write = '0 ;
      repeat(40) @(negedge clk) ;

      $stop ;
      // $finish ;
   end

   // clock
   always
     #500ns clk = ~clk ;
   
endmodule
