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
   logic [2:0] bitNum;

   // combinational next-state logic 
    always_comb begin

        n_next = n ;
      
        if (reset) begin
			n_next = 0;
			bitNum = 7;
			csn = 1;
        end
        else begin
			if (write) begin
				csn = 0; 								   // Busy
				bitNum = 7;
				dcn = ~writedata[8];                       // Change to register?
			end
			if (bitNum == 0 && n == 0)
				csn = 1; // Idle
			
			if ( (n == 0) && ( write || (bitNum != 0) ) )     // restart delay for next bit
			   n_next = N-1 ;
			else if ( (n == 0) && ( ~write || (bitNum == 0) ) )     // restart delay for next bit
			   mosi = 0;
			   
			if ( n ) begin								      // Delay sclk
				n_next = n-1 ;
				
				if (n >= N-N/2) begin
					sclk = 0;
					mosi = writedata[bitNum];
				end
				else
					sclk = 1;
					
			end
			if (n == 0 && (bitNum != 0))			      // Delay over, next bit
				bitNum -= 1;
      
		end
	end

   // registers
   always_ff @(posedge clk) begin
      n <= n_next ;
   end
   


   // combinational outputs
   assign readdata = {31'b0,csn} ;
   assign resetn = ~reset ;

endmodule

