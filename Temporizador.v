module Temporizador(Clock50M,Clock);
	input Clock50M;
	reg [31:0] Counter;
	output reg Clock;
	
	/*always@(posedge Clock50M)
	begin
		//Clock <= !Clock;
		if( Counter < 1*50*10000 ) //100000
		begin
			Counter <= Counter + 1;
		end
			else
			begin
				Clock <= !Clock;
				Counter <= 0;
			end
	end*/
	
	always@(*)
	begin
		Clock <= Clock50M;
	end

endmodule
