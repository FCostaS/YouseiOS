module ExtensorDeSinal(Entrada,Saida);
	input [15:0] Entrada;
	output reg [31:0] Saida;

	always@(Entrada)
	begin
		if( Entrada[15] == 1'B1 )
		begin
			Saida <= {{16'B1111111111111111},Entrada};
		end
		else
		begin
			Saida <= {{16'B0000000000000000},Entrada};
		end
	end

endmodule
