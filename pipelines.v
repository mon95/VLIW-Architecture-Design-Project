//Pipelines

module IF_ID(input clk, input reset,input regWrite, input decOut1b, input flush, input [31:0] pc, input [31:0] instr, output [31:0] p0_pc, output [31:0] p0_intr);
	register32bit_n_1 r0( clk, reset, flush, regWrite, decOut1b, pc, p0_pc);
	register32bit_n_1 r1( clk, reset, flush, regWrite, decOut1b,  instr	, p0_intr);
endmodule
  
module ID_EX(input clk, input reset,input regWrite, input decOut1b, input regWrite1, input regWrite2, input add_shift_bar, input [1:0] aluOp, input memRead, input memWrite, 
  input EPCWrite1, input EPCWrite2, input CauseWrite1, input CauseWrite2, input NFlagWrite1, input NFlagWrite2, input ZFlagWrite1, input ZFlagWrite2, input CFlagWrite1, input CFlagWrite2, input VFlagWrite1, input VFlagWrite2, 
  input [31:0] p0_pc, input [31:0] regOut1, input [31:0] regOut2, input [31:0] regOut3, input [31:0] regOut4,
  input [2:0] rn1, input [2:0] rn2,
  input [2:0] writeReg1, input [2:0] writeReg2, input [2:0] writeReg3, input [31:0] memOffset, input [31:0] shiftImm, input [31:0] addImm,
  output p1_regWrite1, output p1_regWrite2, output p1_add_shift_bar, output [1:0] p1_aluOp, output p1_memRead, output p1_memWrite, 
  output p1_EPCWrite1, output p1_EPCWrite2, output p1_CauseWrite1, output p1_CauseWrite2, output p1_NFlagWrite1, output p1_NFlagWrite2, output p1_ZFlagWrite1, output p1_ZFlagWrite2, output p1_CFlagWrite1, output p1_CFlagWrite2, output p1_VFlagWrite1, output p1_VFlagWrite2,
  output [31:0] p1_p0_pc, output [31:0] p1_regOut1, output [31:0] p1_regOut2, output [31:0] p1_regOut3, output [31:0] p1_regOut4,
  output [2:0] p1_rn1, output [2:0] p1_rn2,
  output [2:0] p1_writeReg1, output [2:0] p1_writeReg2, output [2:0] p1_writeReg3, output [31:0] p1_memOffset, output [31:0] p1_shiftImm, output [31:0] p1_addImm);
   
  register1bit r0(clk, reset, regWrite, decOut1b, regWrite1, p1_regWrite1 );
  register1bit r1(clk, reset, regWrite, decOut1b, regWrite2, p1_regWrite2 );
  register1bit r2(clk, reset, regWrite, decOut1b, add_shift_bar, p1_add_shift_bar );
  register2bit r3(clk, reset, regWrite, decOut1b, aluOp, p1_aluOp );
  register1bit r4(clk, reset, regWrite, decOut1b, memRead, p1_memRead );
  register1bit r5(clk, reset, regWrite, decOut1b, memWrite, p1_memWrite );
  register1bit r6(clk, reset, regWrite, decOut1b, EPCWrite1, p1_EPCWrite1 );
  register1bit r7(clk, reset, regWrite, decOut1b, EPCWrite2, p1_EPCWrite2 );
  register1bit r8(clk, reset, regWrite, decOut1b, CauseWrite1, p1_CauseWrite1 );
  register1bit r9(clk, reset, regWrite, decOut1b, CauseWrite2, p1_CauseWrite2 );
  register1bit r10(clk, reset, regWrite, decOut1b, NFlagWrite1, p1_NFlagWrite1 );
  register1bit r11(clk, reset, regWrite, decOut1b, NFlagWrite2, p1_NFlagWrite2 );
  register1bit r12(clk, reset, regWrite, decOut1b, ZFlagWrite1, p1_ZFlagWrite1 );
  register1bit r13(clk, reset, regWrite, decOut1b, ZFlagWrite2, p1_ZFlagWrite2 );
  register1bit r14(clk, reset, regWrite, decOut1b, CFlagWrite1, p1_CFlagWrite1 );
  register1bit r15(clk, reset, regWrite, decOut1b, CFlagWrite2, p1_CFlagWrite2 );
  register1bit r16(clk, reset, regWrite, decOut1b, VFlagWrite1, p1_VFlagWrite1 );
  register1bit r17(clk, reset, regWrite, decOut1b, VFlagWrite2, p1_VFlagWrite2 );
  
  register32bit_n r18(clk, reset, regWrite, decOut1b, p0_pc, p1_p0_pc );
  register32bit_n r19(clk, reset, regWrite, decOut1b, regOut1, p1_regOut1 );
  register32bit_n r20(clk, reset, regWrite, decOut1b, regOut2, p1_regOut2 );
  register32bit_n r21(clk, reset, regWrite, decOut1b, regOut3, p1_regOut3 );
  register32bit_n r22(clk, reset, regWrite, decOut1b, regOut4, p1_regOut4 );
  
  register3bit r23(clk, reset, regWrite, decOut1b, writeReg1, p1_writeReg1 );
  register3bit r24(clk, reset, regWrite, decOut1b, writeReg2, p1_writeReg2 );
  register3bit r25(clk, reset, regWrite, decOut1b, writeReg3, p1_writeReg3 );
  
  register32bit_n r26(clk, reset, regWrite, decOut1b, memOffset, p1_memOffset );
  register32bit_n r27(clk, reset, regWrite, decOut1b, shiftImm, p1_shiftImm );
  register32bit_n r28(clk, reset, regWrite, decOut1b, addImm, p1_addImm );
  
  register3bit r29(clk, reset, regWrite, decOut1b, rn1, p1_rn1 );
  register3bit r30(clk, reset, regWrite, decOut1b, rn2, p1_rn2 );
endmodule
  
  
module EX_MEM(input clk, input reset, input regWrite, input decOut1b, input p1_regWrite1, input p1_regWrite2, input p1_memRead, input p1_memWrite,
   input p1_NFlagWrite,  input p1_ZFlagWrite,  input p1_CFlagWrite,  input p1_VFlagWrite,  input p1_Overflow,  input p1_Carry,  input p1_Neg,  input p1_Zero,  
   input [31:0] p1_adderOut, input [31:0] p1_AluOut,  input [31:0] p1_str,  input [2:0] p1_writeReg1,  input [2:0] p1_muxOut,
	output p2_regWrite1, output p2_regWrite2, output p2_memRead, output p2_memWrite, output p2_NFlagWrite, output p2_ZFlagWrite,  
	output p2_CFlagWrite, output p2_VFlagWrite, output p2_Overflow, output p2_Carry, output p2_Neg, output p2_Zero, output [31:0] p2_adderOut, 
	output [31:0] p2_AluOut, output [31:0] p2_str, output [2:0] p2_writeReg1, output [2:0] p2_muxOut );
	
	register1bit rp2_regWrite1 ( clk, reset, regWrite, decOut1b, p1_regWrite1, p2_regWrite1 );
	register1bit rp2_regWrite2 ( clk, reset, regWrite, decOut1b, p1_regWrite2, p2_regWrite2 );
	register1bit rp2_memRead ( clk, reset, regWrite, decOut1b, p1_memRead, p2_memRead );
	register1bit rp2_memWrite ( clk, reset, regWrite, decOut1b, p1_memWrite, p2_memWrite );
	register1bit rp2_NFlagWrite ( clk, reset, regWrite, decOut1b, p1_NFlagWrite, p2_NFlagWrite );
  register1bit rp2_ZFlagWrite ( clk, reset, regWrite, decOut1b, p1_ZFlagWrite, p2_ZFlagWrite );
  register1bit rp2_CFlagWrite ( clk, reset, regWrite, decOut1b, p1_CFlagWrite, p2_CFlagWrite );
  register1bit rp2_VFlagWrite ( clk, reset, regWrite, decOut1b, p1_VFlagWrite, p2_VFlagWrite );
  register1bit rp2_Overflow ( clk, reset, regWrite, decOut1b, p1_Overflow, p2_Overflow );
  register1bit rp2_Carry ( clk, reset, regWrite, decOut1b, p1_Carry, p2_Carry );
  register1bit rp2_Neg ( clk, reset, regWrite, decOut1b, p1_Neg, p2_Neg );
  register1bit rp2_Zero ( clk, reset, regWrite, decOut1b, p1_Zero, p2_Zero );
  register32bit_n rp2_adderOut ( clk, reset, regWrite, decOut1b, p1_adderOut, p2_adderOut );
  register32bit_n rp2_AluOut ( clk, reset, regWrite, decOut1b, p1_AluOut, p2_AluOut );
  register32bit_n rp2_str ( clk, reset, regWrite, decOut1b, p1_str, p2_str );
  register3bit rp2_writeReg1 ( clk, reset, regWrite, decOut1b, p1_writeReg1, p2_writeReg1 );
  register3bit rp2_muxOut ( clk, reset, regWrite, decOut1b, p1_muxOut, p2_muxOut );
  
endmodule  

module MEM_WB(input clk, input reset,input regWrite, input decOut1b, input p2_memWrite, input p2_regWrite1, input p2_regWrite2,
 input p2_overflow, input p2_carry, input p2_neg, input p2_zero, 
 input p2_NFlagWrite, input p2_ZFlagWrite, input p2_CFlagWrite, input p2_VFlagWrite,
 input [31:0] memOut, input [31:0] p2_aluOut, 
 input [2:0] p2_writeReg1, input [2:0] p2_muxOut,
 output p3_memWrite, output p3_regWrite1, output p3_regWrite2, 
 output p3_overflow, output p3_carry, output p3_neg, output p3_zero,
 output p3_NFlagWrite, output p3_ZFlagWrite, output p3_CFlagWrite, output p3_VFlagWrite,
 output [31:0] p3_memOut, output [31:0] p3_aluOut, 
 output [2:0] p3_writeReg1, output [2:0] p3_writeReg2);
  register1bit r0(clk, reset, regWrite, decOut1b, p2_memWrite, p3_memWrite );
  register1bit r1(clk, reset, regWrite, decOut1b, p2_regWrite1, p3_regWrite1 );
  register1bit r2(clk, reset, regWrite, decOut1b, p2_regWrite2, p3_regWrite2 );
  register1bit r3(clk, reset, regWrite, decOut1b, p2_overflow, p3_overflow );
  register1bit r4(clk, reset, regWrite, decOut1b, p2_carry, p3_carry );
  register1bit r5(clk, reset, regWrite, decOut1b, p2_neg, p3_neg );
  register1bit r6(clk, reset, regWrite, decOut1b, p2_zero, p3_zero );
  
  register32bit_n r7(clk, reset, regWrite, decOut1b, memOut, p3_memOut );
  register32bit_n r8(clk, reset, regWrite, decOut1b, p2_aluOut, p3_aluOut );
  
  register3bit r9(clk, reset, regWrite, decOut1b, p2_writeReg1, p3_writeReg1 );
  register3bit r10(clk, reset, regWrite, decOut1b, p2_muxOut, p3_writeReg2 );
  
  register1bit r11(clk, reset, regWrite, decOut1b, p2_NFlagWrite, p3_NFlagWrite );
  register1bit r12(clk, reset, regWrite, decOut1b, p2_ZFlagWrite, p3_ZFlagWrite );
  register1bit r13(clk, reset, regWrite, decOut1b, p2_CFlagWrite, p3_CFlagWrite );
  register1bit r14(clk, reset, regWrite, decOut1b, p2_VFlagWrite, p3_VFlagWrite );

 endmodule