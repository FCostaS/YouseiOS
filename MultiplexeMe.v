module MultiplexeMe(
	input BiosSign,
	input [31:0] BiosInstruction, MP_Instruction,
	output reg [31:0] Instrucao
	);

	always@(*)
	begin
	
		if(BiosSign == 1'B1)
		begin
			Instrucao <= BiosInstruction;
		end
			else
			begin
				Instrucao <= MP_Instruction;
			end
			
	end

endmodule

