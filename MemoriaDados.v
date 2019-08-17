module MemoriaDados(Resultado,DadosEscrita,MemRead,MemWrite,ReadData,Clock);
	input  [31:0] Resultado,DadosEscrita;
	input MemRead,MemWrite,Clock;
	output reg [31:0] ReadData;
	
	reg[31:0] Memoria[127:0];
	
	always@(negedge Clock)
	begin
	
		if(MemWrite==1'B1)
		begin
			Memoria[Resultado] = DadosEscrita;
		end
		if(MemRead==1'B1)
		begin
			ReadData = Memoria[Resultado];
		end
	end
	
endmodule
