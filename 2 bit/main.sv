`default_nettype none

module Matrix_Calculator 
    (input logic [7:0] data_in,
     input logic enter, sw,
     input logic [1:0] operation,
     input logic clk, rst,
     output logic [5:0] data_out,
     output logic finish, error,
     output logic [3:0] index);
     // test
    //  output logic[95:0] selected_output,
    //  output logic[95:0] add_output, mul_output,
    //  output logic[31:0] input_matrix_A, input_matrix_B,
    //  output logic input_en);
    
    logic input_en;
    logic[63:0] input_matrix;
    logic[1:0] input_op;
    logic[95:0] add_output, mul_output;
    logic[95:0] selected_output;
    logic[31:0] input_matrix_A, input_matrix_B;
    
    logic add_en, mul_en;
    logic add_finish, mul_finish;
    logic switch_pulse, enter_pulse;

    assign input_matrix_A = input_matrix[63:32];
    assign input_matrix_B = input_matrix[31:0];
    
    ShiftRegister_8_64 shift_register(.data_in(data_in),
                                      .en(enter_pulse && input_en),
                                      .clock(clk),
                                      .rst(rst),
                                      .Q(input_matrix));

    Register #(2) op_reg(.D(operation),
                         .en(enter_pulse && input_en),
                         .clock(clk),
                         .clear(rst),
                         .Q(input_op));
    
    Mux2to1 #(96) output_mux(.Y(selected_output),
                             .I1(add_output),
                             .I0(mul_output),
                             .S(input_op[1]));
    
    matrix_calc_fsm fsm(.clk(clk),
                        .rst(rst),
                        .enter(enter_pulse),
                        .add_finish(add_finish),
                        .mul_finish(mul_finish),
                        .finish(finish),
                        .input_op(input_op),
                        .input_en(input_en),
                        .error(error),
                        .mul_en(mul_en),
                        .add_en(add_en));
    
    Add_Path add_logic(.mat_A(input_matrix_A),
                       .mat_B(input_matrix_B),
                       .clk(clk),
                       .rst(rst),
                       .add_en(add_en),
                       .sign(input_op[0]),
                       .mat_out(add_output),
                       .finish(add_finish));
    
    Multiply_Path mul_logic(.mat_A(input_matrix_A),
                            .mat_B(input_matrix_B),
                            .clk(clk),
                            .rst(rst),
                            .mult_en(mul_en),
                            .mat_out(mul_output),
                            .finish(mul_finish));

    edge_detector sw_de(.clk(clk),
                        .signal(sw),
                        .pulse(switch_pulse));
    
    edge_detector ed_de(.clk(clk),
                        .signal(enter),
                        .pulse(enter_pulse));
    

    // output index logic
    Counter #(4) index_counter(.clock(clk),
                               .clear(rst),
                               .en(finish && switch_pulse),
                               .Q(index));

    // output switching logic
    always_comb begin
        case(index)
            4'd0: data_out = selected_output[95:90];
            4'd1: data_out = selected_output[89:84];
            4'd2: data_out = selected_output[83:78];
            4'd3: data_out = selected_output[77:72];
            4'd4: data_out = selected_output[71:66];
            4'd5: data_out = selected_output[65:60];
            4'd6: data_out = selected_output[59:54];
            4'd7: data_out = selected_output[53:48];
            4'd8: data_out = selected_output[47:42];
            4'd9: data_out = selected_output[41:36];
            4'd10: data_out = selected_output[35:30];
            4'd11: data_out = selected_output[29:24];
            4'd12: data_out = selected_output[23:18];
            4'd13: data_out = selected_output[17:12];
            4'd14: data_out = selected_output[11:6];
            4'd15: data_out = selected_output[5:0];
            default: data_out = 6'b000000;
        endcase
    end

endmodule : Matrix_Calculator


module matrix_calc_fsm (input logic clk, rst,
                        input logic enter,
                        input logic [1:0] input_op,
                        input logic add_finish, mul_finish,
                        output logic finish,
                        output logic input_en, error,
                        output logic mul_en, add_en);
    
    
    enum logic [4:0] {S,S1,S2,S3,S4,S5,S6,S7,S8,M,A,E,F} cur_state, n_state;
    always_comb begin
        case(cur_state)
            S: begin
                input_en = 1'b1;
                error = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if(enter) begin
                    n_state = S1;
                end
                else begin
                    n_state = S;
                end
            end
            S1: begin
                input_en = 1'b1;
                error = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if(enter) begin
                    n_state = S2;
                end
                else begin
                    n_state = S1;
                end
            end
            S2: begin
                input_en = 1'b1;
                error = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if(enter) begin
                    n_state = S3;
                end
                else begin
                    n_state = S2;
                end
            end
            S3: begin
                input_en = 1'b1;
                error = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if(enter) begin
                    n_state = S4;
                end
                else begin
                    n_state = S3;
                end
            end
            S4: begin
                input_en = 1'b1;
                error = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if(enter) begin
                    n_state = S5;
                end
                else begin
                    n_state = S4;
                end
            end
            S5: begin
                input_en = 1'b1;
                error = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if(enter) begin
                    n_state = S6;
                end
                else begin
                    n_state = S5;
                end
            end
            S6: begin
                input_en = 1'b1;
                error = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if(enter) begin
                    n_state = S7;
                end
                else begin
                    n_state = S6;
                end
            end
            S7: begin
                input_en = 1'b1;
                error = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if(enter) begin
                    n_state = S8;
                end
                else begin
                    n_state = S7;
                end
            end
            S8: begin
                input_en = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                if (input_op == 2'b00) begin
                    n_state = M;
                    error = 1'b0;
                    mul_en = 1'b1;
                end
                else if (input_op[1] == 1'b1) begin
                    n_state = A;
                    error = 1'b0;
                    add_en = 1'b1;
                end
                else begin
                    n_state = F;
                    error = 1'b1;
                end
            end
            F: begin
                input_en = 1'b0;
                error = 1'b1;
                mul_en = 1'b0;
                add_en = 1'b0;
                finish = 1'b0;
                n_state = F;
            end
            M: begin
                input_en = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                error = 1'b0;
                if (mul_finish) begin
                    n_state = E;
                    finish = 1'b1;
                end
                else begin
                    n_state = M;
                    finish = 1'b0;
                end
            end
            A: begin
                input_en = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                error = 1'b0;
                if (add_finish) begin
                    n_state = E;
                    finish = 1'b1;
                end
                else begin
                    n_state = A;
                    finish = 1'b0;
                end
            end
            E: begin
                input_en = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                error = 1'b0;
                finish = 1'b1;
                n_state = E;
            end
            default: begin
                input_en = 1'b0;
                mul_en = 1'b0;
                add_en = 1'b0;
                error = 1'b0;
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

endmodule : matrix_calc_fsm



