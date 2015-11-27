# VLIW-Architecture-Design-Project

This is a simple VLIW architecture designed and implemented in Verilog. 

Two sets of instructions (Set1 : load, store, branch and jump; Set2: add, sub, neg and shift) are executed in parallel. 

Basic data dependencies and the load use hazard are handled using a Forwarding Unit and a Hazard Detection unit respectively.
Other dependencies are assumed to be resolved by the compiler.
