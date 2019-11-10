//module YouseiOS(Clock50M,Reset,Type,Set,Swap,Switches,Output);
module YouseiOS(Clock50M,Reset,HD_data, BIOS_Instruction, Indice_HD, Page, Page_out,BiosSign, Page_Update,Output,Instrucao,PC_CPU, WriteHD);
	
	input Clock50M,Reset;//,Set,Swap,Type;
	//input [12:0] Switches;
	output wire [31:0] Output;
	output wire [31:0] Instrucao, HD_data, BIOS_Instruction, Indice_HD, Page, Page_out, PC_CPU;
	output wire BiosSign, Page_Update, WriteHD; // HD_wr
	
	wire Clock;
	wire [12:0] Switches;
	wire [31:0] MP_Instruction, PC_PID;
	wire [4:0] PID, MSG_OUT, PID_out;
	wire SavePage, MSG_Sign;
	
	assign Clock = Clock50M;
	
	MemoriaInstrucoes MI(HD_data, PC_PID, 32'B0, Clock, MP_Instruction);
	
	Processador CPU(.Clock(Clock50M),.Reset(~Reset),.Switches(Switches),.OutputData(Output),.Endereco(PC_CPU),.Instrucao(Instrucao), .WriteHD(WriteHD) );
	
	ProccessControlBlock BCP(Clock, PID_out, PC_CPU, PC_PID);
	
	MultiplexeMe MuxBIOS(BiosSign, BIOS_Instruction, MP_Instruction, Instrucao);
	BIOS BIOSSystem(Clock, Reset, HD_data[31:26], PC_PID, BIOS_Instruction, BiosSign, SavePage, Indice_HD, Page);
	
	HDSimulado HD(PC_PID, Indice_HD, WriteHD, Clock, HD_data);
	Paginacao Pages(Clock, Page_Update, PID, Page, Page_out);
	VARIAVEIS_AMBIENTE Vars(.clk(Clock), .reset(Reset), .SavePage(SavePage), .Instrucao(Instrucao),
									.PID_out(PID_out), .MSG_OUT(MSG_OUT), .MSG_Sign(MSG_Sign), .Page_Update(Page_Update) );
	
endmodule
