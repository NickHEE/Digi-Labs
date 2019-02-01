// spimaster.sv - SPI master to drive SSD1331 OLED display
// controller. Ed.Casas 2018-1-28

// this is an incomplete example, add your code below

module spimaster
  #( N=16 )
   ( input logic [31:0] writedata, // Avalon MM bus
     output logic [31:0] readdata,
     input logic read, write,
     output logic sclk, mosi, csn, dcn, resetn, // SPI master
     input logic reset, clk ) ;

   // declare your state variables here
   logic [$clog2(N):0] n, n_next ; // timer counter
   logic [2:0] bit_state;

   // combinational next-state logic 
   always_comb begin

      n_next = n ;
      
      if (reset) begin
         n_next = 0 ;
      end
      else begin

        if ( (n == 0) && ( write || (bitNum != 0) ) ) // End of Byte
           n_next = N-1 ;
		   
        if ( n ) begin								      // Delay
			n_next = n-1 ;
			
			if (n >= N-N/2)
				sclk = 0;
			else
				sclk = 1;
		
		if (n == 0 && (bit_state != 0))			      // Delay over, next bit
			bit_state -= 1;
		end
      end

   end
   
	always_comb begin
	
	    if (write) begin
			csn = 0; 								   // Busy
			bit_state = 7;
			dcn = ~writedata[8];                       // Change to register?
	    end
	    else if (bit_state == 0 && n == 0)
			csn = 1; // Idle
	    else
			csn = 1;
	    end

   // registers
   always_ff @(posedge clk) begin
      n <= n_next ;
   end

   // combinational outputs
   assign readdata = {31'b0,csn} ;
   assign resetn = ~reset ;
   assign mosi = writedata[bit_state];

endmodule

