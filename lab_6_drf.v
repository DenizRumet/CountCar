module lab_6_drf(
		input Clk, D1, D2,		//clock and sensors
		output [3:0] CountCar,	//how many car ?
		output [1:0] FSM		//which of the sensors are active?
);


//parameter S0 = 3'b000, S1 = 3'b010, S2 = 3'b011, S3 = 3'b001, S4 = 3'b100, S1b = 3'b101, S2b = 3'b111, S3b = 3'b110;	//car is moving forward and backward
parameter
S0 = 7'b0000001
S1 = 7'b0000010
0000100
0001000
0010000
0100000
1000000
reg [2:0] SS;					//registers
reg [3:0] Count;				//counters



always @ (posedge Clk)	
	begin
		case(SS)		
	S0:		if(D1==1'b1 && D2==1'b0)				//forward
				SS <= S1;
			else
				if (D1 == 1'b0 && D2 == 1'b1)		//back
					SS <= S1b;
				else
					SS <= S0;
					
	S1 : 	if (D1 == 1'b1 && D2 == 1'b1)			
				SS <= S2;
			else
				if (D1 == 1'b0 && D2 == 1'b0)		
					SS <= S0;
				else
					SS <= S1;
	S2 : 	if (D1 == 1'b0 && D2 == 1'b1)
				SS <= S3;
			else
				if (D1 == 1'b1 && D2 == 1'b0)
					SS <= S1;
				else
					SS <= S2;					
	S3 : 	if (D1 == 0 && D2 == 1'b0)
				begin
					SS <= S4;
					Count <= Count + 1'b1;
				end
			else
				if (D1 == 1'b1 && D2 == 1'b1)
					SS <= S2;
				else
					SS <= S3;
					
	S4 : 	SS <= S0;	
				
	S1b :	if (D1 == 1'b1 && D2 == 1'b1)
				SS <= S2b;
			else 
				if (D1 == 1'b0 && D2 == 1'b0)
					SS <= S0;
				else
					SS <= S1b;
			
	
						
	S2b :	if (D1 == 1'b1 && D2 == 1'b0)
				SS <= S3b;
			else
				if (D1 == 1'b0 && D2 == 1'b1)
					SS <= S1b;
				else
					SS <= S2b;
					
					
						
	S3b :	if (D1 == 1'b0 && D2 == 1'b0)
				begin
					SS <= S4;
					Count <= Count - 1'b1;
				end	
			else
				if (D1 == 1'b1 && D2 == 1'b1)
					SS <= S2b;
				else
					SS <= S3b;
						
	
	
						
	default: 	SS <= S0;
		endcase
	end

assign CountCar[3:0] = Count[3:0];
assign FSM = SS [1:0];			//to see which sensor is active at the output 

endmodule
  