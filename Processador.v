//module Processador(Clock,Reset,Type,Set,Swap,Switches,OutputData);
module Processador(Clock, Reset, Switches, OutputData, Endereco, Instrucao, WriteHD);
	
	input Clock,Reset;
	input [12:0] Switches;
	output [31:0] OutputData, Endereco;
	output WriteHD;
	input [31:0] Instrucao;
	
	wire[31:0] Resultado,ImediatoExtendido,Offset,DataIO,ReadData,ResultadoSoma,OutADD,
	InputPC,Saida_Dados_2,M2R,Dados_1,Dados_2;
	wire Zero;
	wire[4:0] WR,indice;
	
	// Variáveis Unidade de Controle
	wire RegWrite,OpIO,Halt,HaltIAS,TypeJR;
	wire [1:0] Mem2Reg;
	wire [5:0] OpALU;
	wire MemRead,MemWrite,AluSrc,RegDst,Desvio;
	
	// Variaveis Dispositivos
	ProgramCounter PC(InputPC,Endereco,Clock,Reset,Halt);  											// Contador do Programa 
	//MemoriaInstrucoes MI(Endereco,Clock,Instrucao);		 											// Memória de Instruções
	
	//MemoriaInstrucoes MI(32'B0,Endereco,32'B0, Clock,Instrucao);
	
	ADD_Offset AO(Endereco,32'B00000000000000000000000000000001,OutADD);							// ADD com Offset
	MUX_Mem2Reg MM2R(Instrucao[20:16],Instrucao[15:11],RegDst,WR);									// MUX Memória de Instruções p/ Registradoress
	Registradores Reg(Instrucao[25:21],Instrucao[20:16],
							WR,M2R,RegWrite,Dados_1,Dados_2,Clock);	 									// Banco de Registradores
	MUX_Reg2ALU MR2A(Dados_2,ImediatoExtendido,AluSrc,Saida_Dados_2); 							// MUX do AluSrc
	ExtensorDeSinal ES(Instrucao[15:0],ImediatoExtendido);											// Extensor de Sina																					
	ADD A(TypeJR,Dados_1,ImediatoExtendido,ResultadoSoma);						 								// ADD do Deslocador de Bits
	ULA ULA(Dados_1,Saida_Dados_2,Instrucao[31:26],Instrucao[5:0],OpALU,Zero,Resultado);	// Unidade Lógica e Aritmética
	MemoriaDados MD(Resultado,Dados_2,MemRead,MemWrite,ReadData,Clock);
	Mux_PCSrc MPCS(Zero,Desvio,ResultadoSoma,OutADD,InputPC);										// MUX para PCSrc
	Mux_4 Mux_4(ReadData,DataIO,Resultado,Resultado+1,Mem2Reg,M2R);												// MUX Memory/ModuloIO/ULAResult																												//
	UnidadedeControle UC(Instrucao[31:26],OpIO,OpALU,MemRead,MemWrite,RegWrite
								,AluSrc,RegDst,Desvio,Mem2Reg,HaltIAS,TypeJR,WriteHD);
	ModuloIO ModuloIO(Clock,Reset,Switches,Set,HaltIAS,OpIO,ImediatoExtendido,Dados_1,Halt,DataIO,OutputData); // Modulo I/O										 		 // Extensor de Sina																																			 // Interface de Comunicacao
            

	// Partes do SO
	/*wire [31:0] HD_data, BIOS_Instruction, PC_HD, Page, Page_out;
	wire HD_wr, BiosSign, SavePage;
	wire [4:0] PID;
	BIOS BS(Clock, Reset, HD_data[31:26], BIOS_Instruction, BiosSign, SavePage, PC_HD, Page, PID);
	HDSimulado HD(Resultado, PC_HD, 0, Clock, HD_data);
	Paginacao Pages(Clock, SavePage, PID, Page, Page_out);
	*/
endmodule
