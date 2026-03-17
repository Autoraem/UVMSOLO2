class result_transaction extends uvm_transaction;
    logic [31:0] Q;
    logic Zero;
    logic Neg;
    logic Overflow;

    function new(string name = "result_transaction");
        super.new(name);
    endfunction : new

    function void do_copy(uvm_object rhs);
        result_transaction result_transaction_h;
        if(rhs == null)
            `uvm_fatal("Result Transaction", "Null pointer passed to do_copy");

        if(!$cast(result_transaction_h, rhs))
            `uvm_fatal("Result Transaction", "Object passed to do_copy is not of type result_transaction");    

        super.do_copy(rhs);

        Q = result_transaction_h.Q;
        Zero = result_transaction_h.Zero;
        Neg = result_transaction_h.Neg;
        Overflow = result_transaction_h.Overflow;
    endfunction : do_copy

    function string convert2string();
        string s;
        s = $sformatf("Q: 0x%08h, Zero: %b, Neg: %b, Overflow: %b", Q, Zero, Neg, Overflow);
        return s;
    endfunction : convert2string

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        result_transaction result_transaction_h;
        bit same;

        if(rhs == null)
            `uvm_fatal("Result Transaction", "Null pointer passed to do_compare");

        if(!$cast(result_transaction_h, rhs)) begin
            same = 0;
        end
        else begin
            same = super.do_compare(rhs, comparer) &&
                   (Q == result_transaction_h.Q) &&
                   (Zero == result_transaction_h.Zero) &&
                   (Neg == result_transaction_h.Neg) &&
                   (Overflow == result_transaction_h.Overflow);
        end
        return same;
    endfunction : do_compare

endclass : result_transaction