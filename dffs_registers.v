//Mem
module D_ff_Mem (input clk, input reset, input regWrite, input decOut1b,input init, input d, output reg q);
	always @ (negedge clk)
	begin
	if(reset==1)
		q=init;
	else
		if(regWrite == 1 && decOut1b==1) begin q=d; end
	end
endmodule

module register_Mem(input clk,input reset,input regWrite,input decOut1b,input [31:0]init, input [31:0] d_in, output [31:0] q_out);
	D_ff_Mem dMem0 (clk,reset,regWrite,decOut1b,init[0],d_in[0],q_out[0]);
	D_ff_Mem dMem1 (clk,reset,regWrite,decOut1b,init[1],d_in[1],q_out[1]);
	D_ff_Mem dMem2 (clk,reset,regWrite,decOut1b,init[2],d_in[2],q_out[2]);
	D_ff_Mem dMem3 (clk,reset,regWrite,decOut1b,init[3],d_in[3],q_out[3]);
	
	D_ff_Mem dMem4 (clk,reset,regWrite,decOut1b,init[4],d_in[4],q_out[4]);
	D_ff_Mem dMem5 (clk,reset,regWrite,decOut1b,init[5],d_in[5],q_out[5]);
	D_ff_Mem dMem6 (clk,reset,regWrite,decOut1b,init[6],d_in[6],q_out[6]);
	D_ff_Mem dMem7 (clk,reset,regWrite,decOut1b,init[7],d_in[7],q_out[7]);

	D_ff_Mem dMem8 (clk,reset,regWrite,decOut1b,init[8],d_in[8],q_out[8]);
	D_ff_Mem dMem9 (clk,reset,regWrite,decOut1b,init[9],d_in[9],q_out[9]);
	D_ff_Mem dMem10 (clk,reset,regWrite,decOut1b,init[10],d_in[10],q_out[10]);
	D_ff_Mem dMem11 (clk,reset,regWrite,decOut1b,init[11],d_in[11],q_out[11]);
	
	D_ff_Mem dMem12 (clk,reset,regWrite,decOut1b,init[12],d_in[12],q_out[12]);
	D_ff_Mem dMem13 (clk,reset,regWrite,decOut1b,init[13],d_in[13],q_out[13]);
	D_ff_Mem dMem14 (clk,reset,regWrite,decOut1b,init[14],d_in[14],q_out[14]);
	D_ff_Mem dMem15 (clk,reset,regWrite,decOut1b,init[15],d_in[15],q_out[15]);
	
	D_ff_Mem dMem16 (clk,reset,regWrite,decOut1b,init[16],d_in[16],q_out[16]);
	D_ff_Mem dMem17 (clk,reset,regWrite,decOut1b,init[17],d_in[17],q_out[17]);
	D_ff_Mem dMem18 (clk,reset,regWrite,decOut1b,init[18],d_in[18],q_out[18]);
	D_ff_Mem dMem19 (clk,reset,regWrite,decOut1b,init[19],d_in[19],q_out[19]);
	
	D_ff_Mem dMem20 (clk,reset,regWrite,decOut1b,init[20],d_in[20],q_out[20]);
	D_ff_Mem dMem21 (clk,reset,regWrite,decOut1b,init[21],d_in[21],q_out[21]);
	D_ff_Mem dMem22 (clk,reset,regWrite,decOut1b,init[22],d_in[22],q_out[22]);
	D_ff_Mem dMem23 (clk,reset,regWrite,decOut1b,init[23],d_in[23],q_out[23]);
	
	D_ff_Mem dMem24 (clk,reset,regWrite,decOut1b,init[24],d_in[24],q_out[24]);
	D_ff_Mem dMem25 (clk,reset,regWrite,decOut1b,init[25],d_in[25],q_out[25]);
	D_ff_Mem dMem26 (clk,reset,regWrite,decOut1b,init[26],d_in[26],q_out[26]);
	D_ff_Mem dMem27 (clk,reset,regWrite,decOut1b,init[27],d_in[27],q_out[27]);
	
	D_ff_Mem dMem28 (clk,reset,regWrite,decOut1b,init[28],d_in[28],q_out[28]);
	D_ff_Mem dMem29 (clk,reset,regWrite,decOut1b,init[29],d_in[29],q_out[29]);
	D_ff_Mem dMem30 (clk,reset,regWrite,decOut1b,init[30],d_in[30],q_out[30]);
	D_ff_Mem dMem31 (clk,reset,regWrite,decOut1b,init[31],d_in[31],q_out[31]);
		
endmodule



module decoder4to16( input [3:0] destReg, output reg [15:0] decOut);
	always@(destReg)
	case(destReg)
			4'b0000: decOut=16'b0000000000000001; 
			4'b0001: decOut=16'b0000000000000010;
			4'b0010: decOut=16'b0000000000000100;
			4'b0011: decOut=16'b0000000000001000;
			4'b0100: decOut=16'b0000000000010000;
			4'b0101: decOut=16'b0000000000100000;
			4'b0110: decOut=16'b0000000001000000;
			4'b0111: decOut=16'b0000000010000000;
			4'b1000: decOut=16'b0000000100000000; 
			4'b1001: decOut=16'b0000001000000000;
			4'b1010: decOut=16'b0000010000000000;
			4'b1011: decOut=16'b0000100000000000;
			4'b1100: decOut=16'b0001000000000000;
			4'b1101: decOut=16'b0010000000000000;
			4'b1110: decOut=16'b0100000000000000;
			4'b1111: decOut=16'b1000000000000000;
	endcase
endmodule


module mux16to1( input [31:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,outR8,outR9,outR10,outR11,outR12,outR13,outR14,outR15, input [3:0] Sel, output reg [31:0] outBus );
	always@(outR0 or outR1 or outR2 or outR3 or outR4 or outR5 or outR6 or outR7 or outR8 or outR9 or outR10 or outR11 or outR12 or outR13 or outR14 or outR15 or Sel)
	case (Sel)
				4'b0000: outBus=outR0;
				4'b0001: outBus=outR1;
				4'b0010: outBus=outR2;
				4'b0011: outBus=outR3;
				4'b0100: outBus=outR4;
				4'b0101: outBus=outR5;
				4'b0110: outBus=outR6;
				4'b0111: outBus=outR7;
				4'b1000: outBus=outR8;
				4'b1001: outBus=outR9;
				4'b1010: outBus=outR10;
				4'b1011: outBus=outR11;
				4'b1100: outBus=outR12;
				4'b1101: outBus=outR13;
				4'b1110: outBus=outR14;
				4'b1111: outBus=outR15;
	endcase
endmodule

//Memory Design Ends



//Register File desgin begins
module D_ff (input clk, input reset, input regWrite1, input decOut1b1, input regWrite2, input decOut1b2, input d1, input d2, output reg q);
	always @ (posedge clk)
	begin
	if(reset==1'b1)
		q=0;
	else
		if(regWrite1 == 1'b1 && decOut1b1 ==1'b1) begin q=d1; end
		if(regWrite2 == 1'b1 && decOut1b2 ==1'b1) begin q=d2; end
	end
endmodule

module register32bit( input clk, input reset, input regWrite1, input decOut1b1, input regWrite2, input decOut1b2, input [31:0] writeData1, input [31:0] writeData2, output  [31:0] outR );
	D_ff d0(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[0], writeData2[0], outR[0]);
	D_ff d1(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[1], writeData2[1], outR[1]);
	D_ff d2(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[2], writeData2[2], outR[2]);
	D_ff d3(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[3], writeData2[3], outR[3]);
	D_ff d4(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[4], writeData2[4], outR[4]);
	D_ff d5(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[5], writeData2[5], outR[5]);
	D_ff d6(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[6], writeData2[6], outR[6]);
	D_ff d7(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[7], writeData2[7], outR[7]);
	D_ff d8(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[8], writeData2[8], outR[8]);
	D_ff d9(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[9], writeData2[9], outR[9]);
	D_ff d10(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[10], writeData2[10], outR[10]);
	D_ff d11(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[11], writeData2[11], outR[11]);
	D_ff d12(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[12], writeData2[12], outR[12]);
	D_ff d13(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[13], writeData2[13], outR[13]);
	D_ff d14(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[14], writeData2[14], outR[14]);
	D_ff d15(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[15], writeData2[15], outR[15]);
  D_ff d16(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[16], writeData2[16], outR[16]);
	D_ff d17(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[17], writeData2[17], outR[17]);
	D_ff d18(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[18], writeData2[18], outR[18]);
	D_ff d19(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[19], writeData2[19], outR[19]);
	D_ff d20(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[20], writeData2[20], outR[20]);
	D_ff d21(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[21], writeData2[21], outR[21]);
	D_ff d22(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[22], writeData2[22], outR[22]);
	D_ff d23(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[23], writeData2[23], outR[23]);
  D_ff d24(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[24], writeData2[24], outR[24]);
	D_ff d25(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[25], writeData2[25], outR[25]);
	D_ff d26(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[26], writeData2[26], outR[26]);
	D_ff d27(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[27], writeData2[27], outR[27]);
	D_ff d28(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[28], writeData2[28], outR[28]);
	D_ff d29(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[29], writeData2[29], outR[29]);
	D_ff d30(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[30], writeData2[30], outR[30]);
	D_ff d31(clk, reset, regWrite1, decOut1b1, regWrite2, decOut1b2, writeData1[31], writeData2[31], outR[31]);
endmodule

module registerSet( input clk, input reset, input regWrite1, input [7:0] decOut1, input regWrite2, input [7:0] decOut2, input [31:0] writeData1, input [31:0] writeData2, output [31:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7 );
		register32bit r0( clk, reset, regWrite1, decOut1[0], regWrite2, decOut2[0], writeData1, writeData2, outR0 );
		register32bit r1( clk, reset, regWrite1, decOut1[1], regWrite2, decOut2[1], writeData1, writeData2, outR1 );
		register32bit r2( clk, reset, regWrite1, decOut1[2], regWrite2, decOut2[2], writeData1, writeData2, outR2 );
		register32bit r3( clk, reset, regWrite1, decOut1[3], regWrite2, decOut2[3], writeData1, writeData2, outR3 );
		register32bit r4( clk, reset, regWrite1, decOut1[4], regWrite2, decOut2[4], writeData1, writeData2, outR4 );
		register32bit r5( clk, reset, regWrite1, decOut1[5], regWrite2, decOut2[5], writeData1, writeData2, outR5 );
		register32bit r6( clk, reset, regWrite1, decOut1[6], regWrite2, decOut2[6], writeData1, writeData2, outR6 );
		register32bit r7( clk, reset, regWrite1, decOut1[7], regWrite2, decOut2[7], writeData1, writeData2, outR7 );
endmodule

module decoder3to8( input [2:0] destReg, output reg [7:0] decOut);
  always @(destReg)
    begin
      case(destReg)
        3'b000: decOut = 8'b00000001;
        3'b001: decOut = 8'b00000010;
        3'b010: decOut = 8'b00000100;
        3'b011: decOut = 8'b00001000;
        3'b100: decOut = 8'b00010000;
        3'b101: decOut = 8'b00100000;
        3'b110: decOut = 8'b01000000;
        3'b111: decOut = 8'b10000000;
    endcase
  end
endmodule

module mux8to1(input [31:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7, input [2:0] Sel, output reg [31:0] muxOut );
  always @(Sel or outR0 or outR1 or outR2 or outR3 or outR4 or outR5 or outR6 or outR7)
  begin
    case(Sel)
      3'b000 : muxOut = outR0;
      3'b001 : muxOut = outR1;
      3'b010 : muxOut = outR2;
      3'b011 : muxOut = outR3;
      3'b100 : muxOut = outR4;
      3'b101 : muxOut = outR5;
      3'b110 : muxOut = outR6;
      3'b111 : muxOut = outR7;
  endcase
end
endmodule

module registerFile(input clk, input reset, input regWrite1, input regWrite2, input [2:0] srcRegA, input [2:0] srcRegB, input [2:0] srcRegC, input [2:0] srcRegD, 
	input [2:0] writeReg1,  input [2:0] writeReg2, input [31:0] writeData1, input [31:0] writeData2, output [31:0] outBusA, output [31:0] outBusB, output [31:0] outBusC, output [31:0] outBusD );

 	wire [7:0] decOut1;
 	wire [7:0] decOut2;
    	
	wire [31:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7; 
	   
	decoder3to8 decoder1_insideRegisterFile(writeReg1, decOut1);
	decoder3to8 decoder2_insideRegisterFile(writeReg2, decOut2);
	    
  registerSet rSet0(clk, reset, regWrite1, decOut1, regWrite2, decOut2, writeData1, writeData2, outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7);
    
 	mux8to1 m1_insideRegisterFile(outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,srcRegA,outBusA);
 	mux8to1 m2_insideRegisterFile(outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,srcRegB,outBusB);
 	mux8to1 m3_insideRegisterFile(outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,srcRegC,outBusC);
 	mux8to1 m4_insideRegisterFile(outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,srcRegD,outBusD);
 	  	  	  		 
endmodule
//Register File desgin ends

//Normal Registers begin
module D_ff_n(input clk, input reset, input regWrite, input decOut1b, input d, output reg q);
	always @ (negedge clk)
	begin
	if(reset==1'b1)
		q=0;
	else
		if(regWrite == 1'b1 && decOut1b==1'b1) begin q=d; end
	end
endmodule

//FOr accomodating flush
module D_ff_n_1(input clk, input reset, input flush, input regWrite, input decOut1b, input d, output reg q);
	always @ (negedge clk)
	begin
	if(reset==1'b1 || flush==1'b1)
		q=0;
	else
		if(regWrite == 1'b1 && decOut1b==1'b1) begin q=d; end
	end
endmodule

//Register 32 bit
module register32bit_n( input clk, input reset, input regWrite, input decOut1b, input [31:0] writeData, output  [31:0] outR );
	D_ff_n d0(clk, reset, regWrite, decOut1b, writeData[0], outR[0]);
	D_ff_n d1(clk, reset, regWrite, decOut1b, writeData[1], outR[1]);
	D_ff_n d2(clk, reset, regWrite, decOut1b, writeData[2], outR[2]);
	D_ff_n d3(clk, reset, regWrite, decOut1b, writeData[3], outR[3]);
	D_ff_n d4(clk, reset, regWrite, decOut1b, writeData[4], outR[4]);
	D_ff_n d5(clk, reset, regWrite, decOut1b, writeData[5], outR[5]);
	D_ff_n d6(clk, reset, regWrite, decOut1b, writeData[6], outR[6]);
	D_ff_n d7(clk, reset, regWrite, decOut1b, writeData[7], outR[7]);
	D_ff_n d8(clk, reset, regWrite, decOut1b, writeData[8], outR[8]);
	D_ff_n d9(clk, reset, regWrite, decOut1b, writeData[9], outR[9]);
	D_ff_n d10(clk, reset, regWrite, decOut1b, writeData[10], outR[10]);
	D_ff_n d11(clk, reset, regWrite, decOut1b, writeData[11], outR[11]);
	D_ff_n d12(clk, reset, regWrite, decOut1b, writeData[12], outR[12]);
	D_ff_n d13(clk, reset, regWrite, decOut1b, writeData[13], outR[13]);
	D_ff_n d14(clk, reset, regWrite, decOut1b, writeData[14], outR[14]);
	D_ff_n d15(clk, reset, regWrite, decOut1b, writeData[15], outR[15]);
	D_ff_n d16(clk, reset, regWrite, decOut1b, writeData[16], outR[16]);
	D_ff_n d17(clk, reset, regWrite, decOut1b, writeData[17], outR[17]);
	D_ff_n d18(clk, reset, regWrite, decOut1b, writeData[18], outR[18]);
	D_ff_n d19(clk, reset, regWrite, decOut1b, writeData[19], outR[19]);
	D_ff_n d20(clk, reset, regWrite, decOut1b, writeData[20], outR[20]);
	D_ff_n d21(clk, reset, regWrite, decOut1b, writeData[21], outR[21]);
	D_ff_n d22(clk, reset, regWrite, decOut1b, writeData[22], outR[22]);
	D_ff_n d23(clk, reset, regWrite, decOut1b, writeData[23], outR[23]);
	D_ff_n d24(clk, reset, regWrite, decOut1b, writeData[24], outR[24]);
	D_ff_n d25(clk, reset, regWrite, decOut1b, writeData[25], outR[25]);
	D_ff_n d26(clk, reset, regWrite, decOut1b, writeData[26], outR[26]);
	D_ff_n d27(clk, reset, regWrite, decOut1b, writeData[27], outR[27]);
	D_ff_n d28(clk, reset, regWrite, decOut1b, writeData[28], outR[28]);
	D_ff_n d29(clk, reset, regWrite, decOut1b, writeData[29], outR[29]);
	D_ff_n d30(clk, reset, regWrite, decOut1b, writeData[30], outR[30]);
	D_ff_n d31(clk, reset, regWrite, decOut1b, writeData[31], outR[31]);
endmodule

//Register 32 bit with flush

module register32bit_n_1( input clk, input reset, input flush, input regWrite, input decOut1b, input [31:0] writeData, output  [31:0] outR );
	D_ff_n_1 d0(clk, reset, flush, regWrite, decOut1b, writeData[0], outR[0]);
	D_ff_n_1 d1(clk, reset, flush, regWrite, decOut1b, writeData[1], outR[1]);
	D_ff_n_1 d2(clk, reset, flush, regWrite, decOut1b, writeData[2], outR[2]);
	D_ff_n_1 d3(clk, reset, flush, regWrite, decOut1b, writeData[3], outR[3]);
	D_ff_n_1 d4(clk, reset, flush, regWrite, decOut1b, writeData[4], outR[4]);
	D_ff_n_1 d5(clk, reset, flush, regWrite, decOut1b, writeData[5], outR[5]);
	D_ff_n_1 d6(clk, reset, flush, regWrite, decOut1b, writeData[6], outR[6]);
	D_ff_n_1 d7(clk, reset, flush, regWrite, decOut1b, writeData[7], outR[7]);
	D_ff_n_1 d8(clk, reset, flush, regWrite, decOut1b, writeData[8], outR[8]);
	D_ff_n_1 d9(clk, reset, flush, regWrite, decOut1b, writeData[9], outR[9]);
	D_ff_n_1 d10(clk, reset, flush, regWrite, decOut1b, writeData[10], outR[10]);
	D_ff_n_1 d11(clk, reset, flush, regWrite, decOut1b, writeData[11], outR[11]);
	D_ff_n_1 d12(clk, reset, flush, regWrite, decOut1b, writeData[12], outR[12]);
	D_ff_n_1 d13(clk, reset, flush, regWrite, decOut1b, writeData[13], outR[13]);
	D_ff_n_1 d14(clk, reset, flush, regWrite, decOut1b, writeData[14], outR[14]);
	D_ff_n_1 d15(clk, reset, flush, regWrite, decOut1b, writeData[15], outR[15]);
	D_ff_n_1 d16(clk, reset, flush, regWrite, decOut1b, writeData[16], outR[16]);
	D_ff_n_1 d17(clk, reset, flush, regWrite, decOut1b, writeData[17], outR[17]);
	D_ff_n_1 d18(clk, reset, flush, regWrite, decOut1b, writeData[18], outR[18]);
	D_ff_n_1 d19(clk, reset, flush, regWrite, decOut1b, writeData[19], outR[19]);
	D_ff_n_1 d20(clk, reset, flush, regWrite, decOut1b, writeData[20], outR[20]);
	D_ff_n_1 d21(clk, reset, flush, regWrite, decOut1b, writeData[21], outR[21]);
	D_ff_n_1 d22(clk, reset, flush, regWrite, decOut1b, writeData[22], outR[22]);
	D_ff_n_1 d23(clk, reset, flush, regWrite, decOut1b, writeData[23], outR[23]);
	D_ff_n_1 d24(clk, reset, flush, regWrite, decOut1b, writeData[24], outR[24]);
	D_ff_n_1 d25(clk, reset, flush, regWrite, decOut1b, writeData[25], outR[25]);
	D_ff_n_1 d26(clk, reset, flush, regWrite, decOut1b, writeData[26], outR[26]);
	D_ff_n_1 d27(clk, reset, flush, regWrite, decOut1b, writeData[27], outR[27]);
	D_ff_n_1 d28(clk, reset, flush, regWrite, decOut1b, writeData[28], outR[28]);
	D_ff_n_1 d29(clk, reset, flush, regWrite, decOut1b, writeData[29], outR[29]);
	D_ff_n_1 d30(clk, reset, flush, regWrite, decOut1b, writeData[30], outR[30]);
	D_ff_n_1 d31(clk, reset, flush, regWrite, decOut1b, writeData[31], outR[31]);
endmodule


//Register 1 bit
module register1bit( input clk, input reset, input regWrite, input decOut1b, input writeData, output outR );
	D_ff_n d0(clk, reset, regWrite, decOut1b, writeData, outR);
endmodule

module D_ff_flag(input clk, input reset, input regWrite, input decOut1b, input d, output reg q);
	always @ (posedge clk)
	begin
	if(reset==1'b1)
		q=0;
	else
		if(regWrite == 1'b1 && decOut1b==1'b1) begin q=d; end
	end
endmodule
//Register 1 bit for flag writes
module register1bit_flag( input clk, input reset, input regWrite, input decOut1b, input writeData, output outR );
	D_ff_flag d0(clk, reset, regWrite, decOut1b, writeData, outR);
endmodule

//Register 2 bits
module register2bit( input clk, input reset, input regWrite, input decOut1b, input [1:0]writeData, output [1:0] outR );
	D_ff_n d0(clk, reset, regWrite, decOut1b, writeData[0], outR[0]);
	D_ff_n d1(clk, reset, regWrite, decOut1b, writeData[1], outR[1]);
endmodule
  
  
//Register 3 bits
module register3bit( input clk, input reset, input regWrite, input decOut1b, input [2:0]writeData, output [2:0] outR );
	D_ff_n d0(clk, reset, regWrite, decOut1b, writeData[0], outR[0]);
	D_ff_n d1(clk, reset, regWrite, decOut1b, writeData[1], outR[1]);
	D_ff_n d2(clk, reset, regWrite, decOut1b, writeData[2], outR[2]);
endmodule

//Normal Register ends
  
//Operations
module adder(input [31:0] in1, input [31:0] in2, output reg [31:0] adder_out);
	always@(in1 or in2)
		adder_out = in1 +in2;
endmodule  

module signExt5to32( input [4:0] offset, output reg [31:0] signExtOffset);
	always@(offset)
	begin
			signExtOffset={{27{offset[4]}},offset[4:0]};
	end
endmodule


module signExt8to32( input [7:0] offset, output reg [31:0] signExtOffset);
	always@(offset)
	begin
			signExtOffset={{24{offset[7]}},offset[7:0]};
	end
endmodule

module signExt11to32( input [10:0] offset, output reg [31:0] signExtOffset);
	always@(offset)
	begin
			signExtOffset={{21{offset[10]}},offset[10:0]};
	end
endmodule
  
module leftshift32_1(input [31:0] offset, output reg [31:0] leftShiftOffset);
  always @(offset)
  begin
    leftShiftOffset = offset << 1;
  end
endmodule  
  
module leftshift32_2(input [31:0] offset, output reg [31:0] leftShiftOffset);
  always @(offset)
  begin
    leftShiftOffset = offset << 2;
  end
endmodule  
 
 
//Muxes

module mux2to1_2bit(input [1:0] in1, input [1:0] in2, input sel, output reg [1:0] muxout);
	 always@(in1 or in2 or sel)
	 begin
		case(sel)
			1'b0 : muxout = in1;
			1'b1 : muxout = in2;			
		endcase
	 end
endmodule

module mux4to1_32bit(input [31:0] in1, input [31:0] in2, input [31:0] in3,input [31:0] in4, input [1:0] sel, output reg [31:0] muxout);
	 always@(in1 or in2 or in3 or in4 or sel)
	 begin
		case(sel)
			2'b00 : muxout = in1;
			2'b01 : muxout = in2;
			2'b10 : muxout = in3;
			2'b11 : muxout = in4;
		endcase
	 end
endmodule

module mux2to1_1bit(input in1, input in2, input sel, output reg muxout);
	 always@(in1 or in2 or sel)
	 begin
		case(sel)
			1'b0 : muxout = in1;
			1'b1 : muxout = in2;			
		endcase
	 end
endmodule

module mux2to1_3bit(input [2:0] in1, input [2:0] in2, input sel, output reg [2:0] muxout);
	 always@(in1 or in2 or sel)
	 begin
		case(sel)
			1'b0 : muxout = in1;
			1'b1 : muxout = in2;			
		endcase
	 end
endmodule

module mux2to1_32bit(input [31:0] in1, input [31:0] in2, input sel, output reg [31:0] muxout);
	 always@(in1 or in2 or sel)
	 begin
		case(sel)
			1'b0 : muxout = in1;
			1'b1 : muxout = in2;			
		endcase
	 end
endmodule

//Muxes ends

//Alu   
module alu(input [31:0] aluIn1, input [31:0] aluIn2, input [1:0] aluOp, output reg overflow, output reg carry, output reg neg, output reg zero, output reg [31:0] aluOut);
 reg [32:0] temp;
 reg [31:0] overflow_check;
	always@(aluIn1 or aluIn2 or aluOp)
	begin
		case(aluOp)
			2'b00: begin
			       aluOut = aluIn1 + aluIn2;
			       temp = aluIn1 + aluIn2;
			       if((aluIn1[31]==aluIn2[31]) && (aluIn1[31]!=aluOut[31]))  overflow = 1'b1;
			       else                                                      overflow = 1'b0;
			       if(temp[32] == 1) carry = 1'b1;
			       else              carry = 1'b0;
			       if(aluOut[31] == 1)    neg = 1'b1;
			       else              neg = 1'b0;
			       if(aluOut == 0)   zero = 1'b1;
			       else              zero = 1'b0;
			       end	
			2'b01: begin
			       aluOut = aluIn2 - aluIn1;
			       overflow_check = ~(aluIn1) + 1;
			       if(aluIn1 < aluIn2) carry = 1'b1; 
			       else                carry = 1'b0;
			       if((aluIn1[31]==overflow_check[31]) && (aluIn1[31]!=aluOut[31]))  overflow = 1'b1;
			       else                                                      overflow = 1'b0;
			       if(aluIn1 == 32'b1000_0000_0000_0000_0000_0000_0000_0000 && aluIn2 == 32'd0) overflow = 1'b1;
			       if(aluOut[31] == 1)    neg = 1'b1;
			       else              neg = 1'b0;
			       if(aluOut == 0)   zero = 1'b1;
			       else              zero = 1'b0;
			       end
			2'b10: begin
			       aluOut = aluIn1 >> aluIn2;
			       if(aluIn2 >= 32)  carry = aluIn1[31];
			       else              carry = aluIn1[aluIn2-1];
			       if(aluOut[31] == 1)    neg = 1'b1;
			       else              neg = 1'b0;
			       if(aluOut == 0)   zero = 1'b1;
			       else              zero = 1'b0;
			       overflow = 1'b0;
			       end
			2'b11: begin
			       aluOut = ~(aluIn1) + 1;
			       if( ((aluOut[31]==0) && (aluIn1[31]!=aluOut[31])) || aluIn1 == 32'b1000_0000_0000_0000_0000_0000_0000_0000 )  
			         overflow = 1'b1;
			       else    
			         overflow = 1'b0;
			       //if(aluIn1 == 32'b1000_0000_0000_0000_0000_0000_0000_0000) overflow = 1'b1;
			       if(aluIn1 != 0)   carry = 1'b1;
			       else              carry = 1'b0;
			       if(aluOut[31] == 1)    neg = 1'b1;
			       else              neg = 1'b0;
			       if(aluOut == 0)   zero = 1'b1;
			       else              zero = 1'b0;  
			       end  
		endcase
	end
	assign overflow1 = overflow;
endmodule
  
  
module adder_mem(input [31:0] in1, input [31:0] in2, output reg overflow, output reg carry, output reg [31:0] adder_out);
reg [32:0] temp;
always@(in1 or in2)
  begin
		adder_out = in1 +in2;
		temp = in1 + in2;
	  if((in1[31]==in2[31]) && (in1[31]!=adder_out[31]))  overflow = 1'b1;
	  else                                                overflow = 1'b0;
	  if(temp[32] == 1) carry = 1'b1;
		else              carry = 1'b0;
	end		
endmodule  

//Alu ends

module compareAndSetFlag(input [31:0] memOut, input neg_prev, input zero_prev, output reg N_Final, output reg Z_Final);
    always@(memOut or neg_prev or zero_prev)
    begin
        if(memOut<0)
        begin
            N_Final = 1;
            Z_Final = zero_prev;
        end
        else if(memOut==0)
        begin
            N_Final = neg_prev;
            Z_Final = 1;
        end
        else
        begin 
            Z_Final = zero_prev;
            N_Final = neg_prev;
        end            
    end
    
endmodule
