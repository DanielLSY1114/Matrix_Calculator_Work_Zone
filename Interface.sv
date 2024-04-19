`default_nettype none
module ChipInterface(
                input logic clk_25mhz,
                  input logic[6:3] btn,//up3 for reset,down4 for switch, left5 right6 for op
                  input logic gp27,gp26,gp25,gp24,gp23,gp22,gp21,gp20,//input data
                  input logic gp19,// 19 for enter
                  output logic[7:0] led,//43210 is output data, 7 is finish, 6 is error
                  output logic gp17,gp16,gp15,gp14//index
                  );
    
    logic [7:0] data_in;
    logic enter, sw;
    logic rst;
    logic [4:0] data_out;
    logic finish, error;
    logic [3:0] index;
    logic [1:0] operation;

    assign led[5]=enter;

    Synchronizer sync1(.async(btn[3]), .clock(clk_25mhz), .sync(rst));
    Synchronizer sync2(.async(btn[4]), .clock(clk_25mhz), .sync(sw));
    Synchronizer sync14(.async(btn[5]), .clock(clk_25mhz), .sync(operation[1]));
    Synchronizer sync15(.async(btn[6]), .clock(clk_25mhz), .sync(operation[0]));
    Synchronizer sync3(.async(gp27), .clock(clk_25mhz), .sync(data_in[0]));
    Synchronizer sync4(.async(gp26), .clock(clk_25mhz), .sync(data_in[1]));
    Synchronizer sync5(.async(gp25), .clock(clk_25mhz), .sync(data_in[2]));
    Synchronizer sync6(.async(gp24), .clock(clk_25mhz), .sync(data_in[3]));
    Synchronizer sync7(.async(gp23), .clock(clk_25mhz), .sync(data_in[4]));
    Synchronizer sync8(.async(gp22), .clock(clk_25mhz), .sync(data_in[5]));
    Synchronizer sync9(.async(gp21), .clock(clk_25mhz), .sync(data_in[6]));
    Synchronizer sync10(.async(gp20), .clock(clk_25mhz), .sync(data_in[7]));
    Synchronizer sync11(.async(gp19), .clock(clk_25mhz), .sync(enter));

    Matrix_Calculator matrix_calculator(.data_in(data_in),
                                        .enter(enter),
                                        .sw(sw),
                                        .operation(operation), 
                                        .clk(clk_25mhz), 
                                        .rst(rst), 
                                        .data_out(data_out), 
                                        .finish(finish), 
                                        .error(error), 
                                        .index(index));
    
    assign led[4:0] = data_out[4:0];
    assign led[7] = finish;
    assign led[6] = error;
    assign {gp17,gp16,gp15,gp14} = index[3:0];

    
endmodule: ChipInterface