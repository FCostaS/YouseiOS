//module YouseiOS(Clock50M,Reset,Type,Set,Swap,Switches,Output);
module YouseiOS(Clock50M,Reset,HD_data, BIOS_Instruction, Indice_HD, Page, Page_out,BiosSign, SavePage,Output,Instrucao,PC_PID);
	
	input Clock50M,Reset;//,Set,Swap,Type;
	//input [12:0] Switches;
	output wire [31:0] Output;
	output wire [31:0] Instrucao, HD_data, BIOS_Instruction, Indice_HD, Page, Page_out, PC_PID;
	output wire BiosSign, SavePage; // HD_wr
	
	wire Clock;
	wire [12:0] Switches;
	wire [31:0] MP_Instruction, PC_CPU;
	wire [4:0] PID;
	
	assign Clock = Clock50M;
	
	MemoriaInstrucoes MI(32'B0, PC_PID, 32'B0, Clock, MP_Instruction);
	
	Processador CPU(.Clock(Clock50M),.Reset(~Reset),.Switches(Switches),.OutputData(Output),.Endereco(PC_CPU),.Instrucao(Instrucao) );
	
	ProccessControlBlock BCP(Clock, 0, PC_CPU, PC_PID);
	MultiplexeMe(BiosSign, BIOS_Instruction, MP_Instruction, Instrucao);
	BIOS BIOSSystem(Clock, Reset, HD_data[31:26], PC_CPU, BIOS_Instruction, BiosSign, SavePage, Indice_HD, Page);
	
	HDSimulado HD(PC_PID, Indice_HD, 0, Clock, HD_data);
	Paginacao Pages(Clock, SavePage, PID, Page, Page_out);
	
endmodule
