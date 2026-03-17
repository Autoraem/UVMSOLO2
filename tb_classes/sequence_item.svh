class sequence_item extends uvm_sequence_item;
    `uvm_object_utils(sequence_item)
    
    function new(string name = "sequence_item");
        super.new(name);
    endfunction : new

    rand bit [31:0] A;
    rand bit [31:0] B;
    rand alu_op_e Opcode;
    logic [31:0]  Q;
    logic         Zero;
    logic         Neg;
    logic         Overflow;

    constraint op_con {
        Opcode dist {
            ALU_ADD := 2,
            ALU_SUB := 2,
            ALU_AND := 1,
            ALU_OR := 1,
            ALU_XOR := 3,
            ALU_SLL := 1,
            ALU_SRL := 1,
            ALU_SRA := 1,
            ALU_SLT := 1,
            ALU_SLTU := 1
        };
    }

    constraint data {
        A dist {'h00000000 := 1, ['h00000001:'hFFFFFFFE] :/ 1, 'hFFFFFFFF := 1}; 
        B dist {'h00000000 := 1, ['h00000001:'hFFFFFFFE] :/ 1, 'hFFFFFFFF := 1};
    }

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        sequence_item item;
        bit same;

        if(rhs == null)
            `uvm_fatal("Sequence Item", "Null pointer passed to do_compare");

        if(!$cast(item, rhs)) begin
            same = 0;
        end
        else begin
            same = super.do_compare(rhs, comparer) &&
                   (A == item.A) &&
                   (B == item.B) &&
                   (Opcode == item.Opcode) &&
                   (Q == item.Q) &&
                   (Zero == item.Zero) &&
                   (Neg == item.Neg) &&
                   (Overflow == item.Overflow);
        end
        return same;
    endfunction : do_compare

    function void do_copy(uvm_object rhs);
        sequence_item item;
        if(rhs == null)
            `uvm_fatal("Sequence Item", "Null pointer passed to do_copy");

        if(!$cast(item, rhs))
            `uvm_fatal("Sequence Item", "Object passed to do_copy is not of type sequence_item");    

        super.do_copy(rhs);

        A = item.A;
        B = item.B;
        Opcode = item.Opcode;
        Q = item.Q;
        Zero = item.Zero;
        Neg = item.Neg;
        Overflow = item.Overflow;
    endfunction : do_copy

    function string convert2string();
        string s;
        s = $sformatf("Opcode: %s, A: 0x%08h, B: 0x%08h, Q: 0x%08h, Zero: %b, Neg: %b, Overflow: %b", 
                      Opcode.name(), A, B, Q, Zero, Neg, Overflow);
        return s;
    endfunction : convert2string

endclass : sequence_item