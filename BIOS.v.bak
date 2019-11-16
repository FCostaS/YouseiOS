module BIOS
(
	input	clk, reset,
	input [5:0] Opcode, Opcode_CPU,
	input [31:0] PC_PID, PC_HD,
	output reg [31:0] BIOS_Instr,
	output reg BiosSign, SavePage,
	output reg [31:0] Page
);

	// Declare state register
	reg [1:0] state;
	wire [31:0] POST_Instr;

	// Declare states
	parameter A = 0, B = 1, C = 2, D = 3;
	parameter BEGIN_FILE = 6'B010101,
				 END_FILE   = 6'B010110,
				 HD_HEAD    = 6'B010111,
				 HD_END     = 6'B011000,
				 HALT       = 6'B011001,
				 CREATE_FILE= 6'B011101,
				 CLOSE_FILE = 6'B100000; 
	initial 
	begin : INIT
		BiosSign <= 1'b1; /* Indico que a BIOS esta ativa */
	end

	POST PostFirware(.addr(PC_PID),.clk(clk),.q(POST_Instr));
				 
	// Output depends only on the state
	always @(*)
	begin
	
		case (state)
			A:
			begin
				BIOS_Instr <= 32'B00010100000000000000000000000000; /* JUMP to 0 */
			end

			B:
			begin
				BIOS_Instr <= {6'B011111, 5'B00100, 5'B00100, 16'B0000000000000000}; /* ReadHD $t3,0($t3)  */
			end
			
			C:
			begin
				BIOS_Instr <= {6'B011111, 5'B00100, 5'B00100, 16'B0000000000000000}; /* ReadHD $t3,0($t3)  */
			end
			
			D:
			begin
				if(POST_Instr[31:26] == HALT || ~BiosSign)
				begin
					BIOS_Instr <= 32'B00010100000000000000000000000000; /* JUMP to 0 */
				end
				else
				begin
					BIOS_Instr <= POST_Instr;
				end
			end
		endcase
	
	end
	
	always @ (posedge clk)
	begin
	case (state)
	
			D:
			begin
				if(POST_Instr[31:26] == HALT || ~BiosSign)
				begin
					BiosSign <= 1'b0; // BIOS eh desativada
				end
			end
			
			default:
			begin
				BiosSign <= 1'b1; // BIOS ativada
			end

		endcase
	end
	
	// Page Generator
	always @(posedge clk)
	begin
	
		if(BiosSign == 1'B1)
		begin
			if( Opcode == BEGIN_FILE ) // BEGIN_FILE
			begin
				Page[31:16] <= PC_HD[15:0];
				SavePage <= 1'B0;
			end
			else if( Opcode == END_FILE ) // END_FILE
			begin
				Page[15:0] <= PC_HD[15:0];
				SavePage <= 1'B1;
			end
			else
				SavePage <= 1'B0;
		end
		else
		begin
			if( Opcode_CPU == CREATE_FILE ) // BEGIN_FILE
			begin
				Page[31:16] <= PC_HD[15:0];
				SavePage <= 1'B0;
			end
			else if( Opcode_CPU == CLOSE_FILE ) // END_FILE
			begin
				Page[15:0] <= PC_HD[15:0];
				SavePage <= 1'B1;
			end
		end
	
	end

	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			case (state)
				A:
					if(Opcode == BEGIN_FILE)
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
