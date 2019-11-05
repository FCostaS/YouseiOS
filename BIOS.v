module BIOS
(
	input	clk, reset,
	input [5:0] Opcode,
	input [31:0] PC_PID,
	output reg [31:0] BIOS_Instr,
	output reg BiosSign, SavePage,
	output reg [31:0] PC_HD, Page
);

	// Declare state register
	reg [1:0] state;
	wire [31:0] POST_Instr;

	// Declare states
	parameter A = 0, B = 1, C = 2, D = 3;
	parameter BEGIN_FILE = 6'B010101,
				 END_FILE = 6'B010110,
				 HD_HEAD = 6'B010111,
				 HD_END = 6'B011000,
				 HALT = 6'B011001;
	initial 
	begin : INIT
		BiosSign <= 1'b1; /* Indico que a BIOS esta ativa */
	end

	POST PostFirware(.addr(PC_PID),.clk(clk),.q(POST_Instr));
				 
	// Output depends only on the state
	always @ (posedge clk)
	begin
	case (state)
			A:
			begin
				BiosSign <= 1'b1; /* Indico que a BIOS esta ativa */
				PC_HD <= 32'b0; /* Contador de Programa da BIOS fixado em -1 */
				BIOS_Instr <= 32'B00010100000000000000000000000000; /* JUMP to 0 */
			end
			B:
			begin
				BiosSign <= 1'b1; /* BIOS ativada */
				PC_HD <= PC_HD + 32'b1; /* Incremento PC do HD */
				BIOS_Instr <= 32'B00010100000000000000000000000000; /* JUMP to 0 */
			end
			C:
			begin
				BiosSign <= 1'b1; /* BIOS ativada */
				PC_HD <= PC_HD + 32'b1;  /* Incremento PC do HD */
				BIOS_Instr <= 32'B00010100000000000000000000000000; /* JUMP to 0 */
			end
			D:
			begin
				if(POST_Instr[31:26] == HALT || ~BiosSign)
				begin
					BiosSign <= 1'b0; /* BIOS eh desativada */
					BIOS_Instr <= 32'B00010100000000000000000000000000; /* JUMP to 0 */
				end
					else
						BIOS_Instr <= POST_Instr;
			end
		endcase
	end
	
	always @(posedge clk)
	begin
	
		if(BiosSign == 1 && Opcode == BEGIN_FILE) // BEGIN_FILE
		begin
			Page[31:16] <= PC_HD[15:0];
			SavePage <= 1'b0;
		end
		else if(BiosSign == 1 && Opcode == END_FILE) // END_FILE
		begin
			Page[15:0] <= PC_HD[15:0];
			SavePage <= 1'b1;
		end
		else
		begin
			SavePage <= 1'b0;
		end
	
	end

	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			case (state)
				A:
					if(Opcode == HD_HEAD)
						state <= B;
					else
						state <= A;
				B:
					if(Opcode == END_FILE)
						state <= C;
					else
						state <= B;
				C:
					if(Opcode == HD_END)
						state <= D;
					else
						state <= C;
				D:
					state <= D;
			endcase
	end

endmodule
