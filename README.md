# VLIW-Architecture-Design-Project

This is a simple VLIW architecture designed and implemented in Verilog. It was done as part of the Computer Architecture course (CS F342) that I had taken up at BITS Pilani, Goa. 

Instructions are assumed to be packed into issue packets containing two sets of instructions.
Set1 comprises the load, store, branch and jump instructions while Set2 comprises the add, sub, neg and shift instructions. The two instructions in each issue packet are executed in parallel. A detailed description of the 
instructions is available in the *VLIW_instructions.png* file.

Basic data dependencies and the load-use hazard are handled using a Forwarding Unit and a Hazard Detection unit respectively.
Other dependencies are assumed to be resolved by the compiler. In other words, we assume that two instructions within the same issue packet are independent.



