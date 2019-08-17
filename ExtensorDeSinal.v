module ExtensorDeSinal(Entrada,Saida);
	input [15:0] Entrada;
	output reg [31:0] Saida;

	always@(*)
	begin
		if( Entrada[15] == 1'B1 )
		begin
			Saida = {{16{1'B1}},Entrada};
		end
		else
		begin
			Saida = {{16{1'B0}},Entrada};
		end
	end

endmodule
