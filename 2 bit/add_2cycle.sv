`default_nettype none

module Add_Path(input logic [31:0] mat_A, mat_B,
                input logic clk, rst, add_en,
                input logic sign,
                output logic [95:0] mat_out,
                output logic finish);
    
    logic shift_en;

    logic [47:0] shift_in;
    
    logic [2:0] add1_out, add2_out, add3_out, add4_out;
    logic [2:0] add5_out, add6_out, add7_out, add8_out;

    logic [1:0] add1_in1, add1_in2, add2_in1, add2_in2;
    logic [1:0] add3_in1, add3_in2, add4_in1, add4_in2;
    logic [1:0] add5_in1, add5_in2, add6_in1, add6_in2;
    logic [1:0] add7_in1, add7_in2, add8_in1, add8_in2;

    Adder #(2) add1 (.S(add1_out), .add(~sign), .A(add1_in1), .B(add1_in2));
    Adder #(2) add2 (.S(add2_out), .add(~sign), .A(add2_in1), .B(add2_in2));
    Adder #(2) add3 (.S(add3_out), .add(~sign), .A(add3_in1), .B(add3_in2));
    Adder #(2) add4 (.S(add4_out), .add(~sign), .A(add4_in1), .B(add4_in2));
    Adder #(2) add5 (.S(add5_out), .add(~sign), .A(add5_in1), .B(add5_in2));
    Adder #(2) add6 (.S(add6_out), .add(~sign), .A(add6_in1), .B(add6_in2));
    Adder #(2) add7 (.S(add7_out), .add(~sign), .A(add7_in1), .B(add7_in2));
    Adder #(2) add8 (.S(add8_out), .add(~sign), .A(add8_in1), .B(add8_in2));

    assign shift_in[47:42] = {3'b0, add1_out};
    assign shift_in[41:36] = {3'b0, add2_out};
    assign shift_in[35:30] = {3'b0, add3_out};
    assign shift_in[29:24] = {3'b0, add4_out};
    assign shift_in[23:18] = {3'b0, add5_out};
    assign shift_in[17:12] = {3'b0, add6_out};
    assign shift_in[11:6] = {3'b0, add7_out};
    assign shift_in[5:0] = {3'b0, add8_out};

    ShiftRegister_48_96 shift1 (.data_in(shift_in), .en(shift_en), .clock(clk), .rst(rst), .Q(mat_out));

    add_fsm fsm (.mat_A(mat_A), .mat_B(mat_B), .clk(clk), .rst(rst), .add_en(add_en),
                 .add1_in1(add1_in1), .add1_in2(add1_in2), .add2_in1(add2_in1), .add2_in2(add2_in2),
                 .add3_in1(add3_in1), .add3_in2(add3_in2), .add4_in1(add4_in1), .add4_in2(add4_in2),
                 .add5_in1(add5_in1), .add5_in2(add5_in2), .add6_in1(add6_in1), .add6_in2(add6_in2),
                 .add7_in1(add7_in1), .add7_in2(add7_in2), .add8_in1(add8_in1), .add8_in2(add8_in2),
                 .shift_en(shift_en), .finish(finish));
    

endmodule : Add_Path

module add_fsm (input logic [31:0] mat_A, mat_B,
                input logic clk, rst, add_en,
                output logic [1:0] add1_in1, add1_in2, add2_in1, add2_in2,
                output logic [1:0] add3_in1, add3_in2, add4_in1, add4_in2,
                output logic [1:0] add5_in1, add5_in2, add6_in1, add6_in2,
                output logic [1:0] add7_in1, add7_in2, add8_in1, add8_in2,
                output logic shift_en, finish);

    logic [1:0] mat_A_1, mat_A_2, mat_A_3, mat_A_4;
    logic [1:0] mat_A_5, mat_A_6, mat_A_7, mat_A_8;
    logic [1:0] mat_A_9, mat_A_10, mat_A_11, mat_A_12;
    logic [1:0] mat_A_13, mat_A_14, mat_A_15, mat_A_16;
    logic [1:0] mat_B_1, mat_B_2, mat_B_3, mat_B_4;
    logic [1:0] mat_B_5, mat_B_6, mat_B_7, mat_B_8;
    logic [1:0] mat_B_9, mat_B_10, mat_B_11, mat_B_12;
    logic [1:0] mat_B_13, mat_B_14, mat_B_15, mat_B_16;

    assign mat_A_1 = mat_A[31:30];
    assign mat_A_2 = mat_A[29:28];
    assign mat_A_3 = mat_A[27:26];
    assign mat_A_4 = mat_A[25:24];
    assign mat_A_5 = mat_A[23:22];
    assign mat_A_6 = mat_A[21:20];
    assign mat_A_7 = mat_A[19:18];
    assign mat_A_8 = mat_A[17:16];
    assign mat_A_9 = mat_A[15:14];
    assign mat_A_10 = mat_A[13:12];
    assign mat_A_11 = mat_A[11:10];
    assign mat_A_12 = mat_A[9:8];
    assign mat_A_13 = mat_A[7:6];
    assign mat_A_14 = mat_A[5:4];
    assign mat_A_15 = mat_A[3:2];
    assign mat_A_16 = mat_A[1:0];

    assign mat_B_1 = mat_B[31:30];
    assign mat_B_2 = mat_B[29:28];
    assign mat_B_3 = mat_B[27:26];
    assign mat_B_4 = mat_B[25:24];
    assign mat_B_5 = mat_B[23:22];
    assign mat_B_6 = mat_B[21:20];
    assign mat_B_7 = mat_B[19:18];
    assign mat_B_8 = mat_B[17:16];
    assign mat_B_9 = mat_B[15:14];
    assign mat_B_10 = mat_B[13:12];
    assign mat_B_11 = mat_B[11:10];
    assign mat_B_12 = mat_B[9:8];
    assign mat_B_13 = mat_B[7:6];
    assign mat_B_14 = mat_B[5:4];
    assign mat_B_15 = mat_B[3:2];
    assign mat_B_16 = mat_B[1:0];

    enum logic [1:0] {S,A1,A2,E} cur_state, n_state;
    always_comb begin
        case(cur_state)
            S: begin
                add1_in1 = 2'b0;
                add1_in2 = 2'b0;
                add2_in1 = 2'b0;
                add2_in2 = 2'b0;
                add3_in1 = 2'b0;
                add3_in2 = 2'b0;
                add4_in1 = 2'b0;
                add4_in2 = 2'b0;
                add5_in1 = 2'b0;
                add5_in2 = 2'b0;
                add6_in1 = 2'b0;
                add6_in2 = 2'b0;
                add7_in1 = 2'b0;
                add7_in2 = 2'b0;
                add8_in1 = 2'b0;
                add8_in2 = 2'b0;
                shift_en = 1'b0;
                finish = 1'b0;
                if(add_en) begin
                    n_state = A1;
                end
                else begin
                    n_state = S;
                end
            end
            A1: begin
                add1_in1 = mat_A_1;
                add1_in2 = mat_B_1;
                add2_in1 = mat_A_2;
                add2_in2 = mat_B_2;
                add3_in1 = mat_A_3;
                add3_in2 = mat_B_3;
                add4_in1 = mat_A_4;
                add4_in2 = mat_B_4;
                add5_in1 = mat_A_5;
                add5_in2 = mat_B_5;
                add6_in1 = mat_A_6;
                add6_in2 = mat_B_6;
                add7_in1 = mat_A_7;
                add7_in2 = mat_B_7;
                add8_in1 = mat_A_8;
                add8_in2 = mat_B_8;
                shift_en = 1'b1;
                finish = 1'b0;
                n_state = A2;
            end
            A2: begin
                add1_in1 = mat_A_9;
                add1_in2 = mat_B_9;
                add2_in1 = mat_A_10;
                add2_in2 = mat_B_10;
                add3_in1 = mat_A_11;
                add3_in2 = mat_B_11;
                add4_in1 = mat_A_12;
                add4_in2 = mat_B_12;
                add5_in1 = mat_A_13;
                add5_in2 = mat_B_13;
                add6_in1 = mat_A_14;
                add6_in2 = mat_B_14;
                add7_in1 = mat_A_15;
                add7_in2 = mat_B_15;
                add8_in1 = mat_A_16;
                add8_in2 = mat_B_16;
                shift_en = 1'b1;
                finish = 1'b0;
                n_state = E;
            end
            E: begin
                add1_in1 = 2'b0;
                add1_in2 = 2'b0;
                add2_in1 = 2'b0;
                add2_in2 = 2'b0;
                add3_in1 = 2'b0;
                add3_in2 = 2'b0;
                add4_in1 = 2'b0;
                add4_in2 = 2'b0;
                add5_in1 = 2'b0;
                add5_in2 = 2'b0;
                add6_in1 = 2'b0;
                add6_in2 = 2'b0;
                add7_in1 = 2'b0;
                add7_in2 = 2'b0;
                add8_in1 = 2'b0;
                add8_in2 = 2'b0;
                shift_en = 1'b0;
                finish = 1'b1;
                n_state = E;
            end
            default: begin
                add1_in1 = 2'b0;
                add1_in2 = 2'b0;
                add2_in1 = 2'b0;
                add2_in2 = 2'b0;
                add3_in1 = 2'b0;
                add3_in2 = 2'b0;
                add4_in1 = 2'b0;
                add4_in2 = 2'b0;
                add5_in1 = 2'b0;
                add5_in2 = 2'b0;
                add6_in1 = 2'b0;
                add6_in2 = 2'b0;
                add7_in1 = 2'b0;
                add7_in2 = 2'b0;
                add8_in1 = 2'b0;
                add8_in2 = 2'b0;
                shift_en = 1'b0;
                finish = 1'b0;
                n_state = S;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if(rst)
            cur_state <= S;
        else
            cur_state <= n_state;
    end

endmodule : add_fsm