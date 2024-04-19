`default_nettype none

module Add_Path(input logic [63:0] mat_A, mat_B,
                input logic clk, rst, add_en,
                input logic sign,
                output logic [159:0] mat_out,
                output logic finish);
    
    logic shift_en;

    logic [79:0] shift_in;
    
    logic [4:0] add1_out, add2_out, add3_out, add4_out;
    logic [4:0] add5_out, add6_out, add7_out, add8_out;

    logic [3:0] add1_in1, add1_in2, add2_in1, add2_in2;
    logic [3:0] add3_in1, add3_in2, add4_in1, add4_in2;
    logic [3:0] add5_in1, add5_in2, add6_in1, add6_in2;
    logic [3:0] add7_in1, add7_in2, add8_in1, add8_in2;

    Adder #(4) add1 (.S(add1_out), .add(~sign), .A(add1_in1), .B(add1_in2));
    Adder #(4) add2 (.S(add2_out), .add(~sign), .A(add2_in1), .B(add2_in2));
    Adder #(4) add3 (.S(add3_out), .add(~sign), .A(add3_in1), .B(add3_in2));
    Adder #(4) add4 (.S(add4_out), .add(~sign), .A(add4_in1), .B(add4_in2));
    Adder #(4) add5 (.S(add5_out), .add(~sign), .A(add5_in1), .B(add5_in2));
    Adder #(4) add6 (.S(add6_out), .add(~sign), .A(add6_in1), .B(add6_in2));
    Adder #(4) add7 (.S(add7_out), .add(~sign), .A(add7_in1), .B(add7_in2));
    Adder #(4) add8 (.S(add8_out), .add(~sign), .A(add8_in1), .B(add8_in2));

    assign shift_in[79:70] = {5'b0, add1_out};
    assign shift_in[69:60] = {5'b0, add2_out};
    assign shift_in[59:50] = {5'b0, add3_out};
    assign shift_in[49:40] = {5'b0, add4_out};
    assign shift_in[39:30] = {5'b0, add5_out};
    assign shift_in[29:20] = {5'b0, add6_out};
    assign shift_in[19:10] = {5'b0, add7_out};
    assign shift_in[9:0] = {5'b0, add8_out};

    ShiftRegister_80_160 shift1 (.data_in(shift_in), .en(shift_en), .clock(clk), .rst(rst), .Q(mat_out));

    add_fsm fsm (.mat_A(mat_A), .mat_B(mat_B), .clk(clk), .rst(rst), .add_en(add_en),
                 .add1_in1(add1_in1), .add1_in2(add1_in2), .add2_in1(add2_in1), .add2_in2(add2_in2),
                 .add3_in1(add3_in1), .add3_in2(add3_in2), .add4_in1(add4_in1), .add4_in2(add4_in2),
                 .add5_in1(add5_in1), .add5_in2(add5_in2), .add6_in1(add6_in1), .add6_in2(add6_in2),
                 .add7_in1(add7_in1), .add7_in2(add7_in2), .add8_in1(add8_in1), .add8_in2(add8_in2),
                 .shift_en(shift_en), .finish(finish));
    

endmodule : Add_Path

module add_fsm (input logic [63:0] mat_A, mat_B,
                input logic clk, rst, add_en,
                output logic [3:0] add1_in1, add1_in2, add2_in1, add2_in2,
                output logic [3:0] add3_in1, add3_in2, add4_in1, add4_in2,
                output logic [3:0] add5_in1, add5_in2, add6_in1, add6_in2,
                output logic [3:0] add7_in1, add7_in2, add8_in1, add8_in2,
                output logic shift_en, finish);

    logic [3:0] mat_A_1, mat_A_2, mat_A_3, mat_A_4;
    logic [3:0] mat_A_5, mat_A_6, mat_A_7, mat_A_8;
    logic [3:0] mat_A_9, mat_A_10, mat_A_11, mat_A_12;
    logic [3:0] mat_A_13, mat_A_14, mat_A_15, mat_A_16;
    logic [3:0] mat_B_1, mat_B_2, mat_B_3, mat_B_4;
    logic [3:0] mat_B_5, mat_B_6, mat_B_7, mat_B_8;
    logic [3:0] mat_B_9, mat_B_10, mat_B_11, mat_B_12;
    logic [3:0] mat_B_13, mat_B_14, mat_B_15, mat_B_16;

    assign mat_A_1 = mat_A[63:60];
    assign mat_A_2 = mat_A[59:56];
    assign mat_A_3 = mat_A[55:52];
    assign mat_A_4 = mat_A[51:48];
    assign mat_A_5 = mat_A[47:44];
    assign mat_A_6 = mat_A[43:40];
    assign mat_A_7 = mat_A[39:36];
    assign mat_A_8 = mat_A[35:32];
    assign mat_A_9 = mat_A[31:28];
    assign mat_A_10 = mat_A[27:24];
    assign mat_A_11 = mat_A[23:20];
    assign mat_A_12 = mat_A[19:16];
    assign mat_A_13 = mat_A[15:12];
    assign mat_A_14 = mat_A[11:8];
    assign mat_A_15 = mat_A[7:4];
    assign mat_A_16 = mat_A[3:0];

    assign mat_B_1 = mat_B[63:60];
    assign mat_B_2 = mat_B[59:56];
    assign mat_B_3 = mat_B[55:52];
    assign mat_B_4 = mat_B[51:48];
    assign mat_B_5 = mat_B[47:44];
    assign mat_B_6 = mat_B[43:40];
    assign mat_B_7 = mat_B[39:36];
    assign mat_B_8 = mat_B[35:32];
    assign mat_B_9 = mat_B[31:28];
    assign mat_B_10 = mat_B[27:24];
    assign mat_B_11 = mat_B[23:20];
    assign mat_B_12 = mat_B[19:16];
    assign mat_B_13 = mat_B[15:12];
    assign mat_B_14 = mat_B[11:8];
    assign mat_B_15 = mat_B[7:4];
    assign mat_B_16 = mat_B[3:0];

    enum logic [1:0] {S,A1,A2,E} cur_state, n_state;
    always_comb begin
        case(cur_state)
            S: begin
                add1_in1 = 4'b0;
                add1_in2 = 4'b0;
                add2_in1 = 4'b0;
                add2_in2 = 4'b0;
                add3_in1 = 4'b0;
                add3_in2 = 4'b0;
                add4_in1 = 4'b0;
                add4_in2 = 4'b0;
                add5_in1 = 4'b0;
                add5_in2 = 4'b0;
                add6_in1 = 4'b0;
                add6_in2 = 4'b0;
                add7_in1 = 4'b0;
                add7_in2 = 4'b0;
                add8_in1 = 4'b0;
                add8_in2 = 4'b0;
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
                add1_in1 = 4'b0;
                add1_in2 = 4'b0;
                add2_in1 = 4'b0;
                add2_in2 = 4'b0;
                add3_in1 = 4'b0;
                add3_in2 = 4'b0;
                add4_in1 = 4'b0;
                add4_in2 = 4'b0;
                add5_in1 = 4'b0;
                add5_in2 = 4'b0;
                add6_in1 = 4'b0;
                add6_in2 = 4'b0;
                add7_in1 = 4'b0;
                add7_in2 = 4'b0;
                add8_in1 = 4'b0;
                add8_in2 = 4'b0;
                shift_en = 1'b0;
                finish = 1'b1;
                n_state = E;
            end
            default: begin
                add1_in1 = 4'b0;
                add1_in2 = 4'b0;
                add2_in1 = 4'b0;
                add2_in2 = 4'b0;
                add3_in1 = 4'b0;
                add3_in2 = 4'b0;
                add4_in1 = 4'b0;
                add4_in2 = 4'b0;
                add5_in1 = 4'b0;
                add5_in2 = 4'b0;
                add6_in1 = 4'b0;
                add6_in2 = 4'b0;
                add7_in1 = 4'b0;
                add7_in2 = 4'b0;
                add8_in1 = 4'b0;
                add8_in2 = 4'b0;
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