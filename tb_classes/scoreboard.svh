class scoreboard extends uvm_component;
    virtual alu_bfm bfm;

    `uvm_component_utils(scoreboard)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(virtual alu_bfm)::get(null, "*", "bfm", bfm)) 
            $fatal("Failed to get BFM");
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        bit [31:0] predicted_result;
        forever begin : self_checker
            @(posedge bfm.clk);
            #1
            unique case (bfm.Opcode)
                ALU_ADD  : predicted_result = bfm.A + bfm.B;
                ALU_SUB  : predicted_result = bfm.A - bfm.B;

                ALU_AND  : predicted_result = bfm.A & bfm.B;
                ALU_OR   : predicted_result = bfm.A | bfm.B;
                ALU_XOR  : predicted_result = bfm.A ^ bfm.B;

                ALU_SLL  : predicted_result = bfm.A << bfm.B[4:0];
                ALU_SRL  : predicted_result = bfm.A >> bfm.B[4:0];
                ALU_SRA  : predicted_result = $signed(bfm.A) >>> bfm.B[4:0];

                ALU_SLT  : predicted_result = ($signed(bfm.A) < $signed(bfm.B)) ? 32'd1 : 32'd0;
                ALU_SLTU : predicted_result = (bfm.A < bfm.B) ? 32'd1 : 32'd0;
            endcase

            if (predicted_result !== bfm.Q)
                $error("FAILED: A:%0h B:%0h op:%s Q:%0h expected:%0h",
                        bfm.A, bfm.B, bfm.Opcode.name(), bfm.Q, predicted_result);

        end : self_checker
    endtask : run_phase    
endclass : scoreboard