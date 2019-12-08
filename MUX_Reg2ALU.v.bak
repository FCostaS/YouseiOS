module MUX_Reg2ALU(D1,D2,AluSrc,Saida);
	input [31:0] D1,D2;
	input AluSrc;
	output reg [31:0] Saida;

	always@(AluSrc or D1 or D2)
	begin
		if( AluSrc == 1'B0 ) // D1||D2 0:1
		begin
			Saida = D1;
		end
			else
			begin
				Saida = D2;
			end
	end

endmodule
