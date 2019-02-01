module kpdecode (input logic  [3:0] kpc,
			   input logic  [3:0] kpr,
			   output logic [3:0] num,
			   output logic kphit);

int keypad [4][4] = '{'{1,2,3,10},'{4,5,6,11},'{7,8,9,12},'{14,0,15,13}};	
int row;
int col;
	   
always_comb begin
	if (kpr != 'b1111) begin
		kphit <= 1;
		case (kpc)
			'b0111 : col = 0;
			'b1011 : col = 1;
			'b1101 : col = 2;
			'b1110 : col = 3;
		endcase
		case (kpr)
			'b0111 : row = 0;
			'b1011 : row = 1;
			'b1101 : row = 2;
			'b1110 : row = 3;
		endcase	
		
		num = keypad[row][col];
	end
	else
		kphit <= 0;
end
endmodule