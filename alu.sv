import control_pkg::*;
module alu (
    input  logic [31:0] A,
    input  logic [31:0] B,
    input  alu_op_e     Opcode,
    output logic [31:0] Q,
    output logic        Zero,
    output logic        Neg,
    output logic        Overflow
);
    logic [4:0] shamt;

    always_comb begin
        shamt = B[4:0];
        Overflow = 1'b0; // still placeholder

        unique case (Opcode)

            ALU_ADD:  Q = A + B;
            ALU_SUB:  Q = A - B;

            ALU_AND:  Q = A & B;
            ALU_OR:   Q = A | B;
            ALU_XOR:  Q = A ^ B;

            ALU_SLL:  Q = A << shamt;
            ALU_SRL:  Q = A >> shamt;
            ALU_SRA:  Q = $signed(A) >>> shamt;

            ALU_SLT:  Q = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
            ALU_SLTU: Q = (A < B) ? 32'd1 : 32'd0;

            default:  Q = 32'b0;

        endcase

        Zero = (Q == 32'b0);
        Neg  = Q[31];
    end

endmodule