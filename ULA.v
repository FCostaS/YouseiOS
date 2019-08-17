module ULA(Dados_1,Dados_2,Opcode,funct,OpALU,Zero,Resultado); // Dados com 32 bits
	
	input		[5:0] Opcode,OpALU; 		// Tipo de operacao a ser realizada
	input		[5:0] funct; 				//
	input 	[31:0] Dados_1, Dados_2;//
	output	reg Zero;					//
	output	reg [31:0] Resultado;	//

	always@(*)
	begin
		case(Opcode)
			6'B000000: // OPERACOES ARITMETICAS BASICAS
				begin
				case(funct)
				6'B000000: Resultado = Dados_1 + Dados_2; // SOMA (ADD)
				6'B000001: Resultado = Dados_1 - Dados_2; // SUBTRAÇÃO (SUB)
				6'B000010: Resultado = Dados_1 * Dados_2; // MULTIPLICAÇÃO (MULT) Sem tratamento de overflow
				6'B000011: Resultado = Dados_1/Dados_2;   // DIVISÃO (DIV)
				6'B000100: Resultado = Dados_1 + 1;       // INCREMENTO (INC)
				6'B000101: Resultado = Dados_1 - 1;       // DECREMENTO (DEC)
				default: Resultado = 32'B0;
				endcase
				Zero = 1'B0;	// Zero não é tomado
				end
			6'B000001: // OPERACOES LOGICAS BASICAS (BIT A BIT)
				begin
				Resultado = 32'B0;
				case(funct)
				6'B000000: Resultado = Dados_1 & Dados_2; // E (AND)
				6'B000001: Resultado = Dados_1 | Dados_2; // Ou (OR)
				6'B000010: Resultado = ~Dados_1;          // Negação (NOT)
				6'B000011: Resultado = Dados_1 ^ Dados_2; // Ou exclusivo (Xor)
				default: Resultado = 32'B0;
				endcase
				Zero = 1'B0; // Zero não é tomado
				end
			6'B000010:
				begin
				Resultado = Dados_1 + Dados_2;    			// Adição Imediato (ADDI)
				Zero = 1'B0;
				end
			6'B000011:
				begin
				Resultado = Dados_1;				   			// Copiar (Move)
				Zero = 1'B0;
				end
			6'B000100:
				begin
				Resultado = 32'B0;
				Resultado[0] = (Dados_1 < Dados_2);  			// Set less than (SLT)
				Zero = 1'B0;
				end
			6'B000101:												// Salto (JUMP)
				begin
				Resultado = Dados_2;
				Zero = 1'B1;
				end
			6'B000110:
				begin
				Resultado = Dados_1 + Dados_2; 				// Ler		(LOAD)
				Zero = 1'B0;
				end
			6'B000111:
				begin
				Resultado = Dados_1 + Dados_2; 				// Gravar	(STORE)
				Zero = 1'B0;		
				end
			6'B001000:
				begin
				Resultado = Dados_1 + Dados_2; 				// Entrada  (IN)
				Zero = 1'B0;
				end
			6'B001001:
				begin
				Resultado = Dados_1; 							// Saída    (OUT)
				Zero = 1'B0;
				end
			6'B001010:												// Desvie se Igual     (BEQ)
				begin
					if(Dados_1 == Dados_2)
					begin
						Zero = 1'B1;
					end
					else
					begin
						Zero = 1'B0;
					end
					Resultado = 32'B0;
				end
			6'B001011:												// Desvie se Diferente (BNE)
				begin
					if(Dados_1 != Dados_2)
					begin
						Zero = 1'B1;
					end
					else
					begin
						Zero = 1'B0;
					end
					Resultado = 32'B0;
				end
				
			6'B001101: // diff (13)
			begin
				Resultado = 32'B0;
				Resultado[0] = (Dados_1 != Dados_2);  			// Set less than ()
				Zero = 1'B0;
			end
			
			6'B001111: // sbt (15)
			begin
				Resultado = 32'B0;
				Resultado[0] = (Dados_1 > Dados_2);  			// Set less than ()
				Zero = 1'B0;
			end
			
			6'B010000: // equal (SET) (16)
			begin
				Resultado = 32'B0;
				Resultado[0] = (Dados_1 == Dados_2);  			// Set less than ()
				Zero = 1'B0;
			end
			
			6'B010001: // sbte (17)
			begin
				Resultado = 32'B0;
				Resultado[0] = (Dados_1 >= Dados_2);  			// Set less than ()
				Zero = 1'B0;
			end
			
			6'B010010: // slte (18)
			begin
				Resultado = 32'B0;
				Resultado[0] = (Dados_1 <= Dados_2);  			// Set less than ()
				Zero = 1'B0;
			end
			
			6'B010011: // JR (19)
			begin
				Resultado = 32'B0;
				Zero = 1'B1;
			end
			
			6'B010100: // SUBI
			begin
				Resultado = Dados_1 - Dados_2;    			// Adição Imediato (SUBI)
				Zero = 1'B0;
			end
				
			default:
				begin
					Resultado = 32'B0;
					Zero = 1'B0;
				end
		endcase
	end
	//
endmodule
