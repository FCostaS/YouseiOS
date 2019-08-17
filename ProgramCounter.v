module ProgramCounter(InputPC,Endereco,Clock,Reset,Halt);

	input [31:0] InputPC;
	input Clock, Reset, Halt;
	output reg [31:0] Endereco;

	always@(posedge Clock)
	begin
		if(~Reset)
			begin
				Endereco = 32'B0;
			end
				else if(Halt==1'B1)
				begin
					Endereco = Endereco;
				end
					else
					begin
						Endereco = InputPC;
					end	
	end
	
endmodule
