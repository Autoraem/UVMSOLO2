module top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import control_pkg::*;
    `include "alu_macros.svh"

    alu_bfm bfm();
    alu DUT (
        .A(bfm.A),
        .B(bfm.B),
        .Opcode(bfm.Opcode),
        .Q(bfm.Q),
        .Zero(bfm.Zero),
        .Neg(bfm.Neg),
        .Overflow(bfm.Overflow)
    );

    initial begin
        uvm_config_db#(virtual alu_bfm)::set(null, "*", "bfm", bfm);
        run_test();
    end

endmodule : top