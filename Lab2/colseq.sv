module colseq (input logic  [3:0] kpr ,
			   input logic  clk, reset_n,
			   output logic [3:0] kpc = 'b0111);

logic hold;
			   
always_comb
	if (kpr == 'b1111)
		hold <= 0;
	else
		hold <= 1;

always_ff @ (posedge clk, negedge reset_n) begin
	if (~reset_n)
		kpc <= 'b0111;
	else
		if (~hold)
			kpc = kpc >>> 1;
	
end
endmodule 
