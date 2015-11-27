module Mem(input clk, input reset,input memWrite,input memRead, input [31:0] pc, input [31:0] dataIn,output [31:0] IR );
	wire [31:0] Qout0, Qout1, Qout2, Qout3, Qout4, Qout5, Qout6, Qout7,
					Qout8, Qout9, Qout10, Qout11, Qout12, Qout13, Qout14, Qout15;
	wire [15:0]	decOut;
	
	decoder4to16 dec0( pc[5:2], decOut);

	register_Mem r0(clk,reset,memWrite,decOut[0],32'b0000_0001_001_00100_000_010_01001_10001,dataIn,Qout0); //add $r1 0000_0001 ldr $r2, $r0, 01001
	
	//Undefined Instruction
	//register_Mem r1(clk,reset,memWrite,decOut[1],32'b0000_0011_011_11111_000_100_00001_10001,dataIn,Qout1); //sub $r3 0000_0011 ldr $r4,$r0,00001
	
	register_Mem r1(clk,reset,memWrite,decOut[1],32'b0000_0011_011_00101_000_100_00001_10001,dataIn,Qout1); //sub $r3 0000_0011 ldr $r4,$r0,00001
	
	register_Mem r2(clk,reset,memWrite,decOut[2],32'b0000_0101_101_00100_000_110_00000_10000,dataIn,Qout2); //add $r5 0000_0101 str $r6 $r0 00000
	register_Mem r3(clk,reset,memWrite,decOut[3],32'b010_111_00001_00010_010_001_00001_10001,dataIn,Qout3); //asr $r7 $r2 00001 ldr $r2 $r1 00001
	
	
	//************************************************************************************************************************************************
	
	register_Mem r4(clk,reset,memWrite,decOut[4],32'b100_100_00110_01000_000_010_00101_10001,dataIn,Qout4); //$neg $r4 $r4  ld $r2 $r0 00101
	register_Mem r5(clk,reset,memWrite,decOut[5],32'b0000_0111_100_00100_000_010_01010_10000,dataIn,Qout5); //add $r4 0000_0111 str $r2 $r0 01010
	
	//Setting zero Flag
  //register_Mem r5(clk,reset,memWrite,decOut[5],32'b0000_0011_100_00100_000_000_01010_10000,dataIn,Qout5); //add $r4 0000_0011 str $r0 $r0 01010
	
	register_Mem r6(clk,reset,memWrite,decOut[6],32'b0000_1000_110_00101_000_101_01011_10001,dataIn,Qout6); //sub $r6 0001_0000 ldr $r5 $r0 01011
	register_Mem r7(clk,reset,memWrite,decOut[7],32'b0000_0100_101_00100_000_110_01011_10001,dataIn,Qout7); //add $r5 0000_0100 ldr $r6 $r0 01011
	   
	//************************************************************************************************************************************************

   
	register_Mem r8(clk,reset,memWrite,decOut[8],32'b1111_1101_001_00101_100_010_00110_10001,dataIn,Qout8); //sub $r1, 1111_1110 ldr $r2, $r4, 00110
	register_Mem r9(clk,reset,memWrite,decOut[9],32'b010_100_00001_00010_010_011_00000_10001,dataIn,Qout9); //asr $r4 $r2 00001 ldr $r3 $r2 00000
	
	//Undefined Instruction
	register_Mem r10(clk,reset,memWrite,decOut[10],32'b0000_0010_001_00100_0000_0110_010_11011,dataIn,Qout10); // add $r1, 0000_0010 b 0000_0110
	
	//To show Branch not taken
	//register_Mem r10(clk,reset,memWrite,decOut[10],32'b0000_0010_001_00100_0000_0110_001_11011,dataIn,Qout10); // add $r1, 0000_0010 b 0000_0110
	
	//Instruction to show jump. Jumps to 60.
	//register_Mem r10(clk,reset,memWrite,decOut[10],32'b0000_0010_001_00100_0000_0001_111_11100,dataIn,Qout10); // add $r1, 0000_0010 b 0000_0001_111
	
	register_Mem r11(clk,reset,memWrite,decOut[11],32'b001_110_00110_01000_101_100_01000_10001,dataIn,Qout11); //neg $r6 $r1 ldr $r4 $r5 01000
	
	//************************************************************************************************************************************************


	register_Mem r12(clk,reset,memWrite,decOut[12],32'b0000_1000_110_00101_000_111_01111_10001,dataIn,Qout12); // sub $r6 01000 ldr $r7 $r0 01111	
	
	//Exception test where overflow should be high for 3 cycles (Exception comes here)
	// no overflow 
	//register_Mem r13(clk,reset,memWrite,decOut[13],32'b0000_0001_111_00100_000_000_00000_10000,dataIn,Qout13); //add $r7 0000_0001 str $r0 $r0 00000
	register_Mem r13(clk,reset,memWrite,decOut[13],32'b1111_1111_111_00100_000_000_00000_10000,dataIn,Qout13); //add $r7 1111_1111 str $r0 $r0 00000
  
  register_Mem r14(clk,reset,memWrite,decOut[14],32'b0000_1000_011_00100_110_001_01110_10001,dataIn,Qout14); //add $r3 0000_1000 ldr $r1 $r6 01110
	
	//Exception with no branch
	register_Mem r15(clk,reset,memWrite,decOut[15],32'b0000_0001_010_00100_110_000_00000_10000,dataIn,Qout15); //add $r2 0000_0001 str $r0 $r6 00000
	
  
  //Exception with branch
  //register_Mem r15(clk,reset,memWrite,decOut[15],32'b0000_0001_010_00100_1111_0001_001_11011,dataIn,Qout15); //add $r2 0000_0001 b 1111_0001
  
 //************************************************************************************************************************************************

	
	mux16to1 mMem (Qout0,Qout1,Qout2,Qout3,Qout4,Qout5,Qout6,Qout7,Qout8,Qout9,Qout10,Qout11,Qout12,Qout13,Qout14,Qout15,pc[5:2],IR);
endmodule

module DataMem(input clk, input reset,input memWrite,input memRead, input [31:0] pc, input [31:0] dataIn,output [31:0] IR );
	wire [31:0] Qout0, Qout1, Qout2, Qout3, Qout4, Qout5, Qout6, Qout7,
					Qout8, Qout9, Qout10, Qout11, Qout12, Qout13, Qout14, Qout15;
	wire [15:0]	decOut;
	
	decoder4to16 dec0( pc[5:2], decOut);
	
	//overflow shiz register_Mem r0(clk,reset,memWrite,decOut[0],32'b1000_0000_0000_0000_0000_0000_0000_0000,dataIn,Qout0);
	register_Mem r0(clk,reset,memWrite,decOut[0],32'd1,dataIn,Qout0);
	register_Mem r1(clk,reset,memWrite,decOut[1],32'd3,dataIn,Qout1); 
	register_Mem r2(clk,reset,memWrite,decOut[2],32'd7,dataIn,Qout2); 
	register_Mem r3(clk,reset,memWrite,decOut[3],32'd6,dataIn,Qout3); 
	
	register_Mem r4(clk,reset,memWrite,decOut[4],32'd15,dataIn,Qout4);
	register_Mem r5(clk,reset,memWrite,decOut[5],32'd2,dataIn,Qout5); 
	register_Mem r6(clk,reset,memWrite,decOut[6],32'd0,dataIn,Qout6); 
	register_Mem r7(clk,reset,memWrite,decOut[7],32'd23,dataIn,Qout7); 
	   
	register_Mem r8(clk,reset,memWrite,decOut[8],32'd1,dataIn,Qout8); 
	register_Mem r9(clk,reset,memWrite,decOut[9],32'd4,dataIn,Qout9);
	register_Mem r10(clk,reset,memWrite,decOut[10],32'd9,dataIn,Qout10); 
	register_Mem r11(clk,reset,memWrite,decOut[11],32'd8,dataIn,Qout11);
	
	register_Mem r12(clk,reset,memWrite,decOut[12],32'd0,dataIn,Qout12); 
	register_Mem r13(clk,reset,memWrite,decOut[13],32'd5,dataIn,Qout13); 
	register_Mem r14(clk,reset,memWrite,decOut[14],32'd4,dataIn,Qout14); 
	register_Mem r15(clk,reset,memWrite,decOut[15],32'b1000_0000_0000_0000_0000_0000_0000_0000,dataIn,Qout15);  
	
	mux16to1 mMem (Qout0,Qout1,Qout2,Qout3,Qout4,Qout5,Qout6,Qout7,Qout8,Qout9,Qout10,Qout11,Qout12,Qout13,Qout14,Qout15,pc[5:2],IR);
endmodule