class command_monitor extends uvm_component;
    `uvm_component_utils(command_monitor)

    virtual alu_bfm bfm;

    uvm_analysis_port #(sequence_item) ap;

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual alu_bfm)::get(null, "", "bfm", bfm)) 
            `uvm_fatal("Command Monitor", "BFM not found in config DB");
        bfm.cmd_monitor_h = this;
        ap = new("ap", this);
    endfunction : build_phase

    function void write_to_monitor(logic [31:0] A, logic [31:0] B, alu_op_e Opcode);
        sequence_item cmd;
        `uvm_info("CMD_MONITOR", $sformatf("Monitoring command: A:%0h B:%0h Opcode:%s", A, B, Opcode.name()), UVM_HIGH);
        cmd = new("cmd");
        cmd.A = A;
        cmd.B = B;
        cmd.Opcode = Opcode;
        ap.write(cmd);
    endfunction : write_to_monitor

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : command_monitor
