module Interface(Clock,DataIO,Swap,Type,Halt,Output);
	input Halt,Swap,Type,Clock;
	input [31:0] Output,DataIO;
	
	wire [3:0] reg01,reg02,reg03,reg04;
	wire [3:0] T1,T2,T3,T4;
	reg [31:0] TEMP;
	
	always@(posedge Clock)
	begin	
		
		// MUX //////////////////////
		if( Halt == 1'B0 )
		begin
			TEMP = Output;
		end
			else
			begin
				TEMP = DataIO; // Saída eh Input Data;
			end
	
		////////////////////////////		
	end
	
endmodule
