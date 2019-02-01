// lab4top.sv - top-level module for ELEX 7660 lab4
// Ed.Casas 2017-1-30

module lab4top (
                input logic CLOCK_50,
                output logic [7:0] LED,
                input logic [1:0] KEY,
                output logic rgb_din, rgb_clk, rgb_cs, rgb_dc, rgb_res ) ;
   
   lab4 u0 (
            .clk_clk (CLOCK_50),
            .reset_reset_n (KEY[0]),
            .led_export (LED),
            .spi_sclk (rgb_clk), 
            .spi_mosi (rgb_din), 
            .spi_csn (rgb_cs), 
            .spi_dcn (rgb_dc), 
            .spi_resetn (rgb_res)                       
            );

endmodule
