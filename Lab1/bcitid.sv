// bcitid.sv - ELEX 7660 - Module that selects and stores the last 4 digits of my student ID
// Nicholas Huttemann 2018-01-11
module bcitid ( input logic [1:0] digit,
			   output logic [3:0] idnum);
					 
always_comb
	case(digit)
		0 : idnum = 0;
		1 : idnum = 4;
		2 : idnum = 3;
		3 : idnum = 9;
	endcase			 
endmodule 

