module MUX_Mem2Reg(D1,D2,RegDst,Saida);
	input [4:0] D1,D2;
	input RegDst;
	output reg [4:0] Saida;

	always@(RegDst or D1 or D2)
	begin
		if( RegDst == 1'B0 ) // D1||D2 0:1
		begin
			Saida = D1;
		end
			else
			begin
				Saida = D2;
			end
	end
endmodule
