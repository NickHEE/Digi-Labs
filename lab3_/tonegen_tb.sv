// tonegen_tb.sv - testbench for ELEX 7660 201710 Lab 3

// test tone generator with frequencies of 0 (on reset), 1Hz and
// 10Hz using a clock frequency of 20Hz

module tonegen_tb ;

   logic [31:0] writedata = '0 ;
   logic write = '0 ;
   logic spkr ;
   logic reset, clk = '1 ;

   tonegen #(20) t0 (.*) ;      // fclk=20Hz

   initial begin

      // reset

      reset = '1 ;
      repeat(2) @(posedge clk) ;
      reset = '0 ;

      // should have no output here (freq should be zero)
      repeat(10) @(posedge clk) ;

      // set frequency to 1Hz (10 high, 10 low)
      writedata = 1 ;
      write = '1 ;
      repeat(2) @(posedge clk) ;
      write = '0 ;
      repeat(25) @(posedge clk) ;

      // set frequency to 10 Hz (1 high, 1 low)
      writedata = 10 ;
      write = '1 ;
      repeat(2) @(posedge clk) ;
      write = '0 ;
      repeat(25) @(posedge clk) ;

      $stop ;
      // $finish ;
   end

   // clock
   always
     #500ns clk = ~clk ;
   
endmodule      

