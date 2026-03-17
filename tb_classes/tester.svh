class tester extends uvm_component;
    `uvm_component_utils(tester)

    virtual alu_bfm bfm;
    uvm_put_port #(command_transaction) cmd_port;

    function void build_phase(uvm_phase phase);
        cmd_port = new("cmd_port", this);
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        command_transaction cmd;
        cmd = new("cmd");

        phase.raise_objection(this);
        repeat (1000) begin : test_loop
            cmd = command_transaction::type_id::create("cmd");
            assert(cmd.randomize());
            cmd_port.put(cmd);             
        end : test_loop
        #100; 
        phase.drop_objection(this);
    endtask : run_phase


    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
endclass : tester