//module YouseiOS(Clock50M,Reset,Type,Set,Swap,Switches,Output);
module YouseiOS(Clock50M,Reset,HD_data, BIOS_Instruction, Indice_HD, Page, Page_out,BiosSign, Page_Update,Output,
					Instrucao,PC_CPU, WriteHD, FisicalAddress, LocalData, PID_CPU, PID_out,ReadData);
	
	input Clock50M,Reset;//,Set,Swap,Type;
	//input [12:0] Switches;
	output wire [31:0] Output;
	output wire [31:0] Instrucao, HD_data, BIOS_Instruction, Indice_HD, Page, Page_out, PC_CPU, FisicalAddress, LocalData,ReadData;
	output wire BiosSign, Page_Update, WriteHD; // HD_wr
	output wire [4:0] PID_CPU;

	wire Clock;
	wire [12:0] Switches;
	wire [31:0] MP_Instruction, PC_PID;
	wire [4:0] MSG_OUT;
	output wire [4:0] PID_out;
	wire SavePage, MSG_Sign, MemWirte;
	
	assign Clock = Clock50M;
	
	MemoriaInstrucoes MI(HD_data, FisicalAddress, MemWirte, Clock, MP_Instruction);
	
	Processador CPU(.Clock(Clock50M), .Reset(~Reset), .Switches(Switches), .OutputData(Output), .InputPC(PC_CPU), .Endereco(PC_PID),
						 .Instrucao(Instrucao), .WriteHD(WriteHD), .Resultado(Indice_HD), .DeslocamentoMemoria(LocalData), .PID_CPU(PID_CPU), .ReadData(ReadData) );
	
	ProccessControlBlock BCP(Clock, PID_out, PC_CPU, PC_PID);
	
	MultiplexeMe MuxBIOS(.BiosSign(BiosSign), .BiosInstruction(BIOS_Instruction),
								.MP_Instruction(MP_Instruction), .Instrucao(Instrucao) );
	
	BIOS BIOSSystem(.clk(Clock), .reset(Reset), .Opcode(HD_data[31:26]), .Opcode_CPU(Instrucao[31:26]), .PC_PID(PC_CPU), .PC_HD(Indice_HD),
						 .BIOS_Instr(BIOS_Instruction), .BiosSign(BiosSign), .SavePage(SavePage), .Page(Page) );
	
	HDSimulado HD(PC_PID, Indice_HD, WriteHD, Clock, HD_data);
	
	SistemaDeArquivos Pages(Clock, Page_Update, PID_out, Page, LocalData, Page_out);
	
	MemoryManagementUnit MMU(BiosSign, PC_PID, Page_out, FisicalAddress);
	
	VARIAVEIS_AMBIENTE Vars(.clk(Clock), .reset(Reset), .SavePage(SavePage), .Instrucao(Instrucao), .PID_Data(PID_CPU), .PID_out(PID_out),
									.MSG_OUT(MSG_OUT), .MSG_Sign(MSG_Sign), .Page_Update(Page_Update), .MemWrite(MemWirte) );
	
endmodule
