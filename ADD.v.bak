module ADD(JR_Type,Dados_1,Shifted,ResultadoSoma);
	input [31:0] Shifted,Dados_1;
	output reg [31:0] ResultadoSoma;
	input JR_Type;
	
	//assign ResultadoSoma = Shifted + OutADD;
	//assign ResultadoSoma = Shifted;
	always@(*)
	begin
		if(JR_Type == 1'B0)
		begin
			ResultadoSoma = Shifted;
		end
			else
			begin
				ResultadoSoma = Dados_1;
			end
	end

endmodule
