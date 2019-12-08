// Quartus Prime Verilog Template
// Single port RAM with single read/write address and initial contents 
// specified with an initial block

module POST
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=5)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk,
	output [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	initial 
	begin : INIT
	ram[ 0] = 32'B01010100000000000000000000000000; // begin file	  
	ram[ 1] = 32'B00001000000000010000000000000010; // addi	$ra $zero 2
	ram[ 2] = 32'B00001000000111110000000000011011; // addi	$sp $zero 27
	ram[ 3] = 32'B00010100000000000000000000000100; // jump	main
	ram[ 4] = 32'B00110000000000000000000000000000; // nop	main
	ram[ 5] = 32'B00001000000010000000000000000000; // addi	$t0 $zero 0
	ram[ 6] = 32'B00011100000010000000000000000000; // sw	$t0 0($zero)
	ram[ 7] = 32'B00001000000010000000000000001010; // addi	$t0 $zero 10
	ram[ 8] = 32'B00011100000010000000000000000001; // sw	$t0 1($zero)
	ram[ 9] = 32'B00110000000000000000000000000000; // nop	L0
	ram[10] = 32'B00011000000101000000000000000000; // lw	$s0 0($zero)
	ram[11] = 32'B00011000000101010000000000000001; // lw	$s1 1($zero)
	ram[12] = 32'B01001010100101010100000000000000; // slte	$t0 $s0 $s1
	ram[13] = 32'B00101001000000000000000000010110; // beq	$t0 0 L1
	ram[14] = 32'B00011000000101010000000000000000; // lw	$s1 0($zero)
	ram[15] = 32'B00001110101000100000000000000000; // move	$a0 $s1 
	ram[16] = 32'B00100100010000000000000000000000; // out	$a0  
	ram[17] = 32'B00001000000010010000000000000001; // addi	$t1 $zero 1
	ram[18] = 32'B00011000000101000000000000000000; // lw	$s0 0($zero)
	ram[19] = 32'B00000001001101000101000000000000; // add	$t2 $s0 $t1
	ram[20] = 32'B00011100000010100000000000000000; // sw	$t2 0($zero)
	ram[21] = 32'B00010100000000000000000000001001; // jump	L0
	ram[22] = 32'B00110000000000000000000000000000; // nop	L1 
	ram[23] = 32'B01100100000000000000000000010110; // HALT
	end 

	always @ (posedge clk)
	begin
		addr_reg <= addr;
	end
 
	assign q = ram[addr_reg];

endmodule
