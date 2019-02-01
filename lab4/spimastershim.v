// spimastershim.v 
// This is a shim that defines the ports of the spimaster module in
// Verilog-2001 syntax and instantiates it.
// Ed.Casas 2017-1-30


module spimastershim
  #( parameter N = 16 ) 
   (
    input  wire        avs_write,     // avalon_slave.write
    input  wire        avs_read,      // avalon_slave.read
    input  wire [31:0] avs_writedata, //             .writedata
    output wire [31:0] avs_readdata,  //             .readdata
    input  wire        clk,           //   clock_sink.clk
    input  wire        reset,         //   reset_sink.reset
                                      //  conduit_end spi
    output wire        coe_sclk, coe_mosi, coe_csn, coe_dcn, coe_resetn  
    );

   spimaster #( N ) spimaster0
   ( 
     .writedata(avs_writedata), // Avalon MM bus, write data
     .readdata(avs_readdata),   // " read data
     .write(avs_write),         // " write strobe
     .read(avs_read),           // " readstrobe

     .sclk(coe_sclk),           // SPI: SCLK
     .mosi(coe_mosi),           // MOSI
     .csn(coe_csn),             // CS*
     .dcn(coe_dcn),             // D/C*
     .resetn(coe_resetn),       // reset*

     .reset(reset), .clk(clk) ) ;

endmodule
