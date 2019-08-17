module Registradores(rs,rt,WR,M2R,RegWrite,Dados_1,Dados_2,Clock);
	input [4:0] rs,rt;					// Codificação dos Registradores
	input [4:0] WR;						// Write Register
	input [31:0] M2R;						// Memória para Registrador
	input RegWrite, Clock;
	
	output [31:0] Dados_1,Dados_2;  	// Dados de Saída
	reg [31:0] Registros[31:0];		// Banco de Registradores
	
	always@(posedge Clock)
	begin

		if(RegWrite==1)
		begin
			Registros[WR] <= M2R;
		end
		
	end
	
	assign Dados_1 = Registros[rs];
	assign Dados_2 = Registros[rt];
	
endmodule 