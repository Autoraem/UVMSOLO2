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
    `include "sequence_item.svh"
    typedef uvm_sequencer #(sequence_item) sequencer;

    `include "add_sequence_item.svh"
    `include "random_sequence.svh"
    `include "runall_sequence.svh"
    `include "add_sequence.svh"
    `include "fibonacci_sequence.svh"
    `include "short_random_sequence.svh"

    `include "result_transaction.svh"
    `include "coverage.svh"
    `include "driver.svh"
    `include "scoreboard.svh"
    `include "command_monitor.svh"
    `include "result_monitor.svh"

    `include "env.svh"
    `include "parallel_sequence.svh"

    `include "alu_base_test.svh"
    `include "full_test.svh"
    `include "fibonacci_test.svh"
    `include "parallel_test.svh"
    
endpackage