// lab3top.sv - top-level module for ELEX 7660 lab3
// Ed.Casas 2017-1-23

module lab3top (
                input logic CLOCK_50, 
                input logic [1:0] KEY,
                output logic [7:0] LED,
                output logic spkr ) ;
   
   lab3 u0 (
            .clk_clk       (CLOCK_50),
            .led_export    (LED),  
            .reset_reset_n (KEY[0]),
            .spkr_export   (spkr) 
            );

endmodule
