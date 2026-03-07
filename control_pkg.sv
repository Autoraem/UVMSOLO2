package control_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    typedef enum logic [3:0] {
        ALU_ADD,
        ALU_SUB,
        ALU_AND,
        ALU_OR,
        ALU_XOR,
        ALU_SLL,
        ALU_SRL,
        ALU_SRA,
        ALU_SLT,
        ALU_SLTU
    } alu_op_e;

    virtual alu_bfm bfm_g;

    `include "coverage.svh"
    `include "base_tester.svh"
    `include "random_tester.svh"
    `include "add_tester.svh"
    `include "scoreboard.svh"
    `include "env.svh"
    `include "random_test.svh"
    `include "add_test.svh"
    
endpackage