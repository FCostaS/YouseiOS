module HDSimulado
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=9)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	output [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	initial 
	begin : INIT
		integer i;
		ram[ 0] = 32'B01011100000000000000000000000000; // HD_HEAD
		ram[ 1] = 32'B01010100000000000000000000000000; // BEGIN_FILE
		ram[ 2] = 32'B00001000000000010000000000000100; // addi	$ra $zero 4
		ram[ 3] = 32'B00001000000111110000000000110110; // addi	$sp $zero 54
		ram[ 4] = 32'B00010100000000000000000000000011; // jump	main
		ram[ 5] = 32'B00110000000000000000000000000000; // nop	main
		ram[ 6] = 32'B00001000000010000000000000000110; // addi	$t0 $zero 6
		ram[ 7] = 32'B00011100000010000000000000000001; // sw	$t0 1($zero)
		ram[ 8] = 32'B00001000000010000000000000000001; // addi	$t0 $zero 1
		ram[ 9] = 32'B00011100000010000000000000000000; // sw	$t0 0($zero)
		ram[10] = 32'B00001000000010000000000000000001; // addi	$t0 $zero 1
		ram[11] = 32'B00011100000010000000000000000010; // sw	$t0 2($zero)
		ram[12] = 32'B00110000000000000000000000000000; // nop	L0
		ram[13] = 32'B00011000000101000000000000000000; // lw	$s0 0($zero)
		ram[14] = 32'B00011000000101010000000000000001; // lw	$s1 1($zero)
		ram[15] = 32'B00010010100101010100000000000000; // slt	$t0 $s0 $s1
		ram[16] = 32'B00101001000000000000000000011101; // beq	$t0 0 L1
		ram[17] = 32'B00001000000010010000000000000010; // addi	$t1 $zero 2
		ram[18] = 32'B00011000000101010000000000000010; // lw	$s1 2($zero)
		ram[19] = 32'B00000001001101010101000000000010; // mult	$t2 $t1 $s1
		ram[20] = 32'B00011100000010100000000000000010; // sw	$t2 2($zero)
		ram[21] = 32'B00001000000010000000000000000001; // addi	$t0 $zero 1
		ram[22] = 32'B00011000000101000000000000000000; // lw	$s0 0($zero)
		ram[23] = 32'B00000001000101000100100000000000; // add	$t1 $s0 $t0
		ram[24] = 32'B00011100000010010000000000000000; // sw	$t1 0($zero)
		ram[25] = 32'B00001000000010000000000000000001; // addi	$t0 $zero 1
		ram[26] = 32'B00011000000101000000000000000010; // lw	$s0 2($zero)
		ram[27] = 32'B00000010100010000100100000000001; // sub	$t1 $s0 $t0
		ram[28] = 32'B00001101001000100000000000000000; // move	$a0 $t1 
		ram[29] = 32'B00100100010000000000000000000000; // out	$a0  
		ram[30] = 32'B00010100000000000000000000001010; // jump	L0
		ram[31] = 32'B00110000000000000000000000000000; // nop	L1
		ram[32] = 32'B00010100000000000000000000011110; // halt	  
		ram[33] = 32'B01011000000000000000000000000000; // END_FILE
		ram[34] = 32'B01100000000000000000000000000000; // HD_END
	end 

	always @ (posedge clk)
	begin
	
		// Write
		if (we)
			ram[addr] <= data;

		addr_reg <= addr;
	end
 
	assign q = ram[addr_reg];

endmodule
