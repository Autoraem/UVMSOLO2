class parallel_test extends tinyalu_base_test;
    `uvm_component_utils(parallel_test);

    parallel_sequence parallel_h;
        
    function new(string name, uvm_component parent);
        super.new(name,parent);
        parallel_h = new("parallel_h");
    endfunction : new

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        parallel_h.start(sequencer_h);
        phase.drop_objection(this);
    endtask : run_phase
endclass