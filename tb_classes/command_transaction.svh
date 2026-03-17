class command_transaction extends uvm_transaction;
    `uvm_object_utils(command_transaction)
    rand logic [31:0] A;
    rand logic [31:0] B;
    rand alu_op_e Opcode;

    constraint data {
        A dist {'h00000000 := 1, ['h00000001:'hFFFFFFFE] :/ 1, 'hFFFFFFFF := 1}; 
        B dist {'h00000000 := 1, ['h00000001:'hFFFFFFFE] :/ 1, 'hFFFFFFFF := 1};
    }

    function void do_copy(uvm_object rhs);
        command_transaction command_transaction_h;
        if(rhs == null)
            `uvm_fatal("Command Transaction", "Null pointer passed to do_copy");

        if(!$cast(command_transaction_h, rhs))
            `uvm_fatal("Command Transaction", "Object passed to do_copy is not of type command_transaction");    

        super.do_copy(rhs);

        A = command_transaction_h.A;
        B = command_transaction_h.B;
        Opcode = command_transaction_h.Opcode;    
    endfunction : do_copy

    function command_transaction clone_me();
        command_transaction clone;
        uvm_object tmp;

        tmp = this.clone();
        if(!$cast(clone, tmp))
            `uvm_fatal("Command Transaction", "Cloning failed in clone_me");
        return clone;
    endfunction : clone_me

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        command_transaction command_transaction_h;
        bit same;

        if(rhs == null)
            `uvm_fatal("Command Transaction", "Null pointer passed to do_compare");

        if(!$cast(command_transaction_h, rhs)) begin
            same = 0;
        end
        else begin
            same = super.do_compare(rhs, comparer) &&
                   (A == command_transaction_h.A) &&
                   (B == command_transaction_h.B) &&
                   (Opcode == command_transaction_h.Opcode);
        end
        return same;
    endfunction : do_compare

    function string convert2string();
        string s;
        s = $sformatf("Opcode: %s, A: 0x%08h, B: 0x%08h", Opcode.name(), A, B);
        return s;
    endfunction : convert2string

    function new(string name = "command_transaction");
        super.new(name);
    endfunction : new   
endclass : command_transaction