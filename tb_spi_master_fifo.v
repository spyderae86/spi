module spi_master_fifo_tb;

parameter DATA_WIDTH = 8; 
parameter BUFFER_DEPTH = 3; 

// Testbench Signals
wire                  clk_i     ;
wire                  rst_ni    ;
wire                  clr_i     ;
wire                  valid_i   ;
wire [DATA_WIDTH-1:0] data_i    ;
wire [DATA_WIDTH-1:0] data_o    ;
wire                  valid_o   ;
wire                  ready_o   ;
wire [1:0]            elements_o;
wire                  ready_i   ;

// Instantiate the FIFO Module
spi_master_fifo #(.DATA_WIDTH(DATA_WIDTH),.BUFFER_DEPTH(BUFFER_DEPTH)) 
dut (
    .clk_i     (clk_i     ),
    .rst_ni    (rst_ni    ),
    .clr_i     (clr_i     ),
    .valid_i   (valid_i   ),
    .data_i    (data_i    ),
    .ready_i   (ready_i   ), 
    .data_o    (data_o    ),
    .valid_o   (valid_o   ),
    .ready_o   (ready_o   ),
    .elements_o(elements_o)
);
    
drv #(.DATA_WIDTH(DATA_WIDTH),.BUFFER_DEPTH(BUFFER_DEPTH)) 
drv (

    .clk_i     (clk_i     ),
    .rst_ni    (rst_ni    ),
    .clr_i     (clr_i     ),
    .valid_i   (valid_i   ), 
    .data_i    (data_i    ),
    .ready_i   (ready_i   ),
    .data_o    (data_o    ),
    .valid_o   (valid_o   ),
    .ready_o   (ready_o   ),
    .elements_o(elements_o),
    .test_done (test_done )
);

initial begin
    wait (test_done);
    #20;     $finish;
end

initial begin    
    $fsdbDumpfile("test.fsdb");
    $fsdbDumpvars(0,"+all",spi_master_fifo_tb); 
end

endmodule


program drv
#(
    parameter DATA_WIDTH = 32,
    parameter BUFFER_DEPTH = 2,
    parameter LOG_BUFFER_DEPTH = `log2(BUFFER_DEPTH)
)
(
    output logic                      clk_i     ,
    output logic                      rst_ni    ,
    output logic                      clr_i     , 

    input  logic [LOG_BUFFER_DEPTH:0] elements_o,
    input  logic [DATA_WIDTH - 1:0]   data_o    ,
    input  logic                      valid_o   ,

    output logic                      ready_i   ,  //back end

    output logic                      valid_i   ,  //front end
    output logic [DATA_WIDTH - 1:0]   data_i    ,

    input  logic                      ready_o   ,

    output logic                      test_done 
);

/////////////////////////////////////////////////phase1
initial begin
    clk_i = 0;
    forever #5  clk_i = ~clk_i;
end

initial begin
    rst_ni = 0;
    repeat (2) @(posedge clk_i) rst_ni = 1;
end

initial begin
    clr_i = 0;
end
initial begin
    valid_i = 0;
    data_i  = 0;
    ready_i = 0;
    test_done = 0;
end
/////////////////////////////////////////////////phase2
initial begin

    wait(rst_ni);

    repeat (10) @ (posedge clk_i) begin
        valid_i = 1 ;
        data_i  = valid_i ? data_i + 1 : 'dx;
    end

    repeat (10) @ (posedge clk_i) begin
        ready_i = 1 ;
    end

    @ (posedge clk_i) test_done = 1;

end

endprogram
