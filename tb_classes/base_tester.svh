virtual class base_tester extends uvm_component;
    `uvm_component_utils(base_tester)

    virtual alu_bfm bfm;

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual alu_bfm)::get(this, "", "bfm", bfm)) begin
            `uvm_fatal("BFM_NOT_FOUND", "Base tester did not find BFM in config db")
        end
    endfunction : build_phase

    pure virtual function alu_op_e get_op();

    pure virtual function [31:0] get_data();

    task run_phase(uvm_phase phase);
        bit [31:0] iA;
        bit [31:0] iB;
        alu_op_e iop;
        bit [31:0] oQ;
        bit oZ;
        bit oN;
        bit oV;

        phase.raise_objection(this);
        iA = '0;
        iB = '0;
        iop = get_op();
        oQ = '0;
        oZ = '0;
        oN = '0;
        oV = '0;

        repeat (10000) begin : test_loop
            iA = get_data();
            iB = get_data();
            iop = get_op();

            bfm.send_op(iop, iA, iB, oQ, oZ, oN, oV);
        end : test_loop
        #100; 
        phase.drop_objection(this);
    endtask : run_phase


    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
endclass : base_tester