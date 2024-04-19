`default_nettype none

module Add_Path(input logic [31:0] mat_A, mat_B,
                input logic clk, rst, add_en,
                input logic sign,
                output logic [95:0] mat_out,
                output logic finish);
    
    logic shift_en;

    logic [95:0] shift_in;
    
    logic [2:0] add1_out, add2_out, add3_out, add4_out;
    logic [2:0] add5_out, add6_out, add7_out, add8_out;
    logic [2:0] add9_out, add10_out, add11_out, add12_out;
    logic [2:0] add13_out, add14_out, add15_out, add16_out;
    
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


    Adder #(2) add1 (.S(add1_out), .add(~sign), .A(mat_A_1), .B(mat_B_1));
    Adder #(2) add2 (.S(add2_out), .add(~sign), .A(mat_A_2), .B(mat_B_2));
    Adder #(2) add3 (.S(add3_out), .add(~sign), .A(mat_A_3), .B(mat_B_3));
    Adder #(2) add4 (.S(add4_out), .add(~sign), .A(mat_A_4), .B(mat_B_4));
    Adder #(2) add5 (.S(add5_out), .add(~sign), .A(mat_A_5), .B(mat_B_5));
    Adder #(2) add6 (.S(add6_out), .add(~sign), .A(mat_A_6), .B(mat_B_6));
    Adder #(2) add7 (.S(add7_out), .add(~sign), .A(mat_A_7), .B(mat_B_7));
    Adder #(2) add8 (.S(add8_out), .add(~sign), .A(mat_A_8), .B(mat_B_8));
    Adder #(2) add9 (.S(add9_out), .add(~sign), .A(mat_A_9), .B(mat_B_9));
    Adder #(2) add10 (.S(add10_out), .add(~sign), .A(mat_A_10), .B(mat_B_10));
    Adder #(2) add11 (.S(add11_out), .add(~sign), .A(mat_A_11), .B(mat_B_11));
    Adder #(2) add12 (.S(add12_out), .add(~sign), .A(mat_A_12), .B(mat_B_12));
    Adder #(2) add13 (.S(add13_out), .add(~sign), .A(mat_A_13), .B(mat_B_13));
    Adder #(2) add14 (.S(add14_out), .add(~sign), .A(mat_A_14), .B(mat_B_14));
    Adder #(2) add15 (.S(add15_out), .add(~sign), .A(mat_A_15), .B(mat_B_15));
    Adder #(2) add16 (.S(add16_out), .add(~sign), .A(mat_A_16), .B(mat_B_16));

    assign shift_in[95:90] = {3'b0, add1_out};
    assign shift_in[89:84] = {3'b0, add2_out};
    assign shift_in[83:78] = {3'b0, add3_out};
    assign shift_in[77:72] = {3'b0, add4_out};
    assign shift_in[71:66] = {3'b0, add5_out};
    assign shift_in[65:60] = {3'b0, add6_out};
    assign shift_in[59:54] = {3'b0, add7_out};
    assign shift_in[53:48] = {3'b0, add8_out};
    assign shift_in[47:42] = {3'b0, add9_out};
    assign shift_in[41:36] = {3'b0, add10_out};
    assign shift_in[35:30] = {3'b0, add11_out};
    assign shift_in[29:24] = {3'b0, add12_out};
    assign shift_in[23:18] = {3'b0, add13_out};
    assign shift_in[17:12] = {3'b0, add14_out};
    assign shift_in[11:6] = {3'b0, add15_out};
    assign shift_in[5:0] = {3'b0, add16_out};

    ShiftRegister_96_96 shift1 (.data_in(shift_in), .en(shift_en), .clock(clk), .rst(rst), .Q(mat_out));

    add_fsm fsm (.mat_A(mat_A), .mat_B(mat_B), .clk(clk), .rst(rst), .add_en(add_en),
                 .shift_en(shift_en), .finish(finish));
    

endmodule : Add_Path

module add_fsm (input logic [31:0] mat_A, mat_B,
                input logic clk, rst, add_en,
                output logic shift_en, finish);



    enum logic [1:0] {S,A1,E} cur_state, n_state;
    always_comb begin
        case(cur_state)
            S: begin
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
                shift_en = 1'b1;
                finish = 1'b0;
                n_state = E;
            end
            E: begin
                shift_en = 1'b0;
                finish = 1'b1;
                n_state = E;
            end
            default: begin
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