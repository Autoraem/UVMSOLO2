class scoreboard extends uvm_component;
    `uvm_component_utils(scoreboard)

    uvm_tlm_analysis_fifo #(command_data) cmd_fifo;
    uvm_tlm_analysis_fifo #(result_data) rslt_fifo;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        cmd_fifo = new("cmd_fifo", this);
        rslt_fifo = new("rslt_fifo", this);
    endfunction : build_phase

    function void write();
        command_data cmd;
        result_data rslt;
        bit [31:0] predicted_result;

        if(!cmd_fifo.try_get(cmd) || !rslt_fifo.try_get(rslt))
            $fatal("Scoreboard FIFOs should always have data when write is called");

        unique case (cmd.Opcode)
            ALU_ADD  : predicted_result = cmd.A + cmd.B;
            ALU_SUB  : predicted_result = cmd.A - cmd.B;

            ALU_AND  : predicted_result = cmd.A & cmd.B;
            ALU_OR   : predicted_result = cmd.A | cmd.B;
            ALU_XOR  : predicted_result = cmd.A ^ cmd.B;

            ALU_SLL  : predicted_result = cmd.A << cmd.B[4:0];
            ALU_SRL  : predicted_result = cmd.A >> cmd.B[4:0];
            ALU_SRA  : predicted_result = $signed(cmd.A) >>> cmd.B[4:0];

            ALU_SLT  : predicted_result = ($signed(cmd.A) < $signed(cmd.B)) ? 32'd1 : 32'd0;
            ALU_SLTU : predicted_result = (cmd.A < cmd.B) ? 32'd1 : 32'd0;
        endcase

        if (predicted_result !== rslt.Q)
            $error("FAILED: A:%0h B:%0h op:%s Q:%0h expected:%0h",
                    cmd.A, cmd.B, cmd.Opcode.name(), rslt.Q, predicted_result);
    endfunction : write

endclass : scoreboard