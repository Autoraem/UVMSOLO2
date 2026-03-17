class scoreboard extends uvm_component;
    `uvm_component_utils(scoreboard)

    uvm_tlm_analysis_fifo #(command_transaction) cmd_fifo;
    uvm_tlm_analysis_fifo #(result_transaction) rslt_fifo;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        cmd_fifo = new("cmd_fifo", this);
        rslt_fifo = new("rslt_fifo", this);
    endfunction : build_phase

    function result_transaction predict_result(command_transaction cmd);
        result_transaction predicted;
        predicted = new("predicted_result");
        unique case (cmd.Opcode)
            ALU_ADD  : predicted.Q = cmd.A + cmd.B;
            ALU_SUB  : predicted.Q = cmd.A - cmd.B;

            ALU_AND  : predicted.Q = cmd.A & cmd.B;
            ALU_OR   : predicted.Q = cmd.A | cmd.B;
            ALU_XOR  : predicted.Q = cmd.A ^ cmd.B;

            ALU_SLL  : predicted.Q = cmd.A << cmd.B[4:0];
            ALU_SRL  : predicted.Q = cmd.A >> cmd.B[4:0];
            ALU_SRA  : predicted.Q = $signed(cmd.A) >>> cmd.B[4:0];

            ALU_SLT  : predicted.Q = ($signed(cmd.A) < $signed(cmd.B)) ? 32'd1 : 32'd0;
            ALU_SLTU : predicted.Q = (cmd.A < cmd.B) ? 32'd1 : 32'd0;
        endcase
        return predicted;
    endfunction : predict_result


    function void write(result_transaction t);
        string data_str;
        command_transaction cmd;
        result_transaction rslt;

        if(!cmd_fifo.try_get(cmd) || !rslt_fifo.try_get(rslt))
            $fatal("Scoreboard FIFOs should always have data when write is called");

        rslt = predict_result(cmd);

        data_str = {                cmd.convert2string(), 
                    " ==> Actual",  rslt.convert2string(), 
                    " /Predicted:", rslt.convert2string()};

        if(!rslt.compare(t))
            `uvm_error("SELF CHECKER", {"FAIL: ", data_str})
        else
            `uvm_info("SELF CHECKER", {"PASS:  ", data_str}, UVM_HIGH)
    endfunction : write

endclass : scoreboard