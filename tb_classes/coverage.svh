class coverage extends uvm_subscriber #(sequence_item);
    `uvm_component_utils(coverage)

    virtual alu_bfm bfm;

    bit [31:0] A;
    bit [31:0] B;
    alu_op_e Opcode;
    
    covergroup op_cov;
        coverpoint Opcode{
            bins ops = {[ALU_ADD : ALU_SLTU]};
        }
    endgroup
        
    covergroup operands;

        all_ops : coverpoint Opcode {
            bins add  = {ALU_ADD};
            bins sub  = {ALU_SUB};
            bins and_ = {ALU_AND};
            bins or_  = {ALU_OR};
            bins xor_ = {ALU_XOR};
            bins sll  = {ALU_SLL};
            bins srl  = {ALU_SRL};
            bins sra  = {ALU_SRA};
            bins slt  = {ALU_SLT};
            bins sltu = {ALU_SLTU};
        }

        a_leg : coverpoint A{
                bins zeros = {'h00000000};
                bins others= {['h00000001:'hFFFFFFFE]};
                bins ones  = {'hFFFFFFFF};
            }
        
            
        b_leg : coverpoint B{
                bins zeros = {'h00000000};
                bins others= {['h00000001:'hFFFFFFFE]};
                bins ones  = {'hFFFFFFFF};
            }
        
        op_00_FF :  cross a_leg, b_leg, all_ops {
                bins add_00  = (binsof (all_ops) intersect {ALU_ADD})  && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins add_FF  = (binsof (all_ops) intersect {ALU_ADD})  && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins sub_00  = (binsof (all_ops) intersect {ALU_SUB})  && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins sub_FF  = (binsof (all_ops) intersect {ALU_SUB})  && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins and_00  = (binsof (all_ops) intersect {ALU_AND})  && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins and_FF  = (binsof (all_ops) intersect {ALU_AND})  && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins or_00   = (binsof (all_ops) intersect {ALU_OR})   && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins or_FF   = (binsof (all_ops) intersect {ALU_OR})   && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins xor_00  = (binsof (all_ops) intersect {ALU_XOR})  && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins xor_FF  = (binsof (all_ops) intersect {ALU_XOR})  && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins sll_00  = (binsof (all_ops) intersect {ALU_SLL})  && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins sll_FF  = (binsof (all_ops) intersect {ALU_SLL})  && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins srl_00  = (binsof (all_ops) intersect {ALU_SRL})  && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins srl_FF  = (binsof (all_ops) intersect {ALU_SRL})  && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins sra_00  = (binsof (all_ops) intersect {ALU_SRA})  && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins sra_FF  = (binsof (all_ops) intersect {ALU_SRA})  && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins slt_00  = (binsof (all_ops) intersect {ALU_SLT})  && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins slt_FF  = (binsof (all_ops) intersect {ALU_SLT})  && (binsof (a_leg.ones)  || binsof (b_leg.ones)); 
                bins sltu_00 = (binsof (all_ops) intersect {ALU_SLTU}) && (binsof (a_leg.zeros) || binsof (b_leg.zeros));
                bins sltu_FF = (binsof (all_ops) intersect {ALU_SLTU}) && (binsof (a_leg.ones)  || binsof (b_leg.ones));

                ignore_bins others_only = binsof(a_leg.others) && binsof(b_leg.others);

            }
    endgroup

    function new (string name, uvm_component parent);
        super.new(name, parent);
        op_cov = new();
        operands = new();
    endfunction : new

    function void write( sequence_item t);
        A = t.A;
        B = t.B;
        Opcode = t.Opcode;
        op_cov.sample();
        operands.sample();
    endfunction : write


endclass : coverage