interface alu_bfm;
    import control_pkg::*;
    // -------------------------
    // BFM Signals
    // -------------------------
    logic [31:0]  A;
    logic [31:0]  B;
    alu_op_e      Opcode;
    logic [31:0]  Q;
    logic         Zero;
    logic         Neg;
    logic         Overflow;

    bit clk;

    initial begin
        clk = 0;
        forever begin
            #10;
            clk = ~clk;
        end
    end

    task send_op(input alu_op_e iop, input bit [31:0] ia, input bit [31:0] ib, output bit [31:0] oq, output bit oz, output bit on, output bit ov);
        @(negedge clk); // align with negative edge for input setup
        Opcode = iop;
        A = ia;
        B = ib;
        @(posedge clk); // wait for outputs to settle
        oq = Q;
        oz = Zero;
        on = Neg;
        ov = Overflow;
    endtask : send_op


endinterface : alu_bfm