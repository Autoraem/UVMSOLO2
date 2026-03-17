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

    `include "command_transaction.svh"
    `include "add_transaction.svh"
    `include "result_transaction.svh"

    `include "coverage.svh"
    `include "tester.svh"
    `include "driver.svh"
    `include "scoreboard.svh"
    `include "command_monitor.svh"
    `include "result_monitor.svh"

    `include "env.svh"

    `include "random_test.svh"
    `include "add_test.svh"
    
endpackage