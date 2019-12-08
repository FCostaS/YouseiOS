module MemoriaInstrucoes
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=9)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] Endereco,
	input we, clk,
	output [(DATA_WIDTH-1):0] Instrucao
);

	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];	// Declare the RAM variable

	reg [ADDR_WIDTH-1:0] addr_reg; // Variable to hold the registered read address

	initial 
	begin : INIT
		ram[ 0] = 32'B00001000000000010000000000000100; // addi	$ra $zero 4
		ram[ 1] = 32'B00001000000111110000000000110110; // addi	$sp $zero 54
		ram[ 2] = 32'B00010100000000000000000000000011; // jump	main
		ram[ 3] = 32'B00110000000000000000000000000000; // nop	main
		ram[ 4] = 32'B00001000000010000000000000000110; // addi	$t0 $zero 6
		ram[ 5] = 32'B00011100000010000000000000000001; // sw	$t0 1($zero)
		ram[ 6] = 32'B00001000000010000000000000000001; // addi	$t0 $zero 1
		ram[ 7] = 32'B00011100000010000000000000000000; // sw	$t0 0($zero)
		ram[ 8] = 32'B00001000000010000000000000000001; // addi	$t0 $zero 1
		ram[ 9] = 32'B00011100000010000000000000000010; // sw	$t0 2($zero)
		ram[10] = 32'B00110000000000000000000000000000; // nop	L0
		ram[11] = 32'B00011000000101000000000000000000; // lw	$s0 0($zero)
		ram[12] = 32'B00011000000101010000000000000001; // lw	$s1 1($zero)
		ram[13] = 32'B00010010100101010100000000000000; // slt	$t0 $s0 $s1
		ram[14] = 32'B00101001000000000000000000011101; // beq	$t0 0 L1
		ram[15] = 32'B00001000000010010000000000000010; // addi	$t1 $zero 2
		ram[16] = 32'B00011000000101010000000000000010; // lw	$s1 2($zero)
		ram[17] = 32'B00000001001101010101000000000010; // mult	$t2 $t1 $s1
		ram[18] = 32'B00011100000010100000000000000010; // sw	$t2 2($zero)
		ram[19] = 32'B00001000000010000000000000000001; // addi	$t0 $zero 1
		ram[20] = 32'B00011000000101000000000000000000; // lw	$s0 0($zero)
		ram[21] = 32'B00000001000101000100100000000000; // add	$t1 $s0 $t0
		ram[22] = 32'B00011100000010010000000000000000; // sw	$t1 0($zero)
		ram[23] = 32'B00001000000010000000000000000001; // addi	$t0 $zero 1
		ram[24] = 32'B00011000000101000000000000000010; // lw	$s0 2($zero)
		ram[25] = 32'B00000010100010000100100000000001; // sub	$t1 $s0 $t0
		ram[26] = 32'B00001101001000100000000000000000; // move	$a0 $t1 
		ram[27] = 32'B00100100010000000000000000000000; // out	$a0  
		ram[28] = 32'B00010100000000000000000000001010; // jump	L0
		ram[29] = 32'B00110000000000000000000000000000; // nop	L1
		ram[30] = 32'B00010100000000000000000000011110; // halt	   
	end

	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[Endereco] <= data;

		addr_reg <= Endereco;
	end
 
	assign Instrucao = ram[addr_reg];

endmodule

/*
module MemoriaInstrucoes(Endereco,Clock,Instrucao);
	input [31:0] Endereco;
	input Clock;
	output [31:0] Instrucao;
	
	reg[31:0] Memory[23:0];
	integer F = 0;
	
	
	always @(posedge Clock)
	begin
	
		// Codigo	
		if(F == 0)
		begin
		Memory[ 0] = 32'B00001000000000010000000000000011; // addi	$ra $zero 3
		Memory[ 1] = 32'B00001000000111110000000000110101; // addi	$sp $zero 53
		Memory[ 2] = 32'B00010100000000000000000000000011; // jump	main
		Memory[ 3] = 32'B00110000000000000000000000000000; // nop	main
		Memory[ 4] = 32'B00001000000010000000000000000000; // addi	$t0 $zero 0
		Memory[ 5] = 32'B00011100000010000000000000000000; // sw	$t0 0($zero)
		Memory[ 6] = 32'B00001000000010000000000000001010; // addi	$t0 $zero 10
		Memory[ 7] = 32'B00011100000010000000000000000001; // sw	$t0 1($zero)
		Memory[ 8] = 32'B00110000000000000000000000000000; // nop	L0
		Memory[ 9] = 32'B00011000000101000000000000000000; // lw	$s0 0($zero)
		Memory[10] = 32'B00011000000101010000000000000001; // lw	$s1 1($zero)
		Memory[11] = 32'B00010010100101010100000000000000; // slt	$t0 $s0 $s1
		Memory[12] = 32'B00101001000000000000000000010101; // beq	$t0 0 L1
		Memory[13] = 32'B00011000000101010000000000000000; // lw	$s1 0($zero)
		Memory[14] = 32'B00001110101000100000000000000000; // move	$a0 $s1 
		Memory[15] = 32'B00100100010000000000000000000000; // out	$a0  
		Memory[16] = 32'B00001000000010010000000000000001; // addi	$t1 $zero 1
		Memory[17] = 32'B00011000000101000000000000000000; // lw	$s0 0($zero)
		Memory[18] = 32'B00000001001101000101000000000000; // add	$t2 $s0 $t1
		Memory[19] = 32'B00011100000010100000000000000000; // sw	$t2 0($zero)
		Memory[20] = 32'B00010100000000000000000000001000; // jump	L0
		Memory[21] = 32'B00110000000000000000000000000000; // nop	L1
		Memory[22] = 32'B00010100000000000000000000010110; // halt	  
		F = 1;
		end
		///////////////////////////////////
	end
	
	assign Instrucao = Memory[Endereco];
	
endmodule
*/