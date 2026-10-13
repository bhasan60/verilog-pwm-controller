module tb();
  reg clk, rst;
  reg [7:0] duty;
  wire pwm_out;
  integer high_count;
  integer i;
  pwm u1 (.clk(clk), .rst(rst), .duty(duty), .pwm_out(pwm_out));
  always #5 clk = ~clk;
  initial begin
    clk = 0;
    $dumpfile("dump.vcd");
    $dumpvars;
    rst = 1;
    duty = 0;
    #20;
    rst = 0;
    high_count = 0;
    for (i = 0; i < 256; i = i + 1) begin
      @(posedge clk);
      #1;
      if (pwm_out == 1) high_count = high_count + 1;
    end
    if (high_count == 0) $display("PASS duty=%0d", duty);
    else $display("FAIL: got %0d, expected duty=%0d", high_count, duty);
    duty = 1;
    high_count = 0;
    for (i = 0; i < 256; i = i + 1) begin
      @(posedge clk);
      #1;
      if (pwm_out == 1) high_count = high_count + 1;
    end
    if (high_count == 1) $display("PASS duty=%0d", duty);
    else $display("FAIL: got %0d, expected duty=%0d", high_count, duty);
    duty = 64;
    high_count = 0;
    for (i = 0; i < 256; i = i + 1) begin
      @(posedge clk);
      #1;
      if (pwm_out == 1) high_count = high_count + 1;
    end
    if (high_count == 64) $display("PASS duty=%0d", duty);
    else $display("FAIL: got %0d, expected duty=%0d", high_count, duty);
    duty = 128;
    high_count = 0;
    for (i = 0; i < 256; i = i + 1) begin
      @(posedge clk);
      #1;
      if (pwm_out == 1) high_count = high_count + 1;
    end
    if (high_count == 128) $display("PASS duty=%0d", duty);
    else $display("FAIL: got %0d, expected duty=%0d", high_count, duty);
    duty = 255;
    high_count = 0;
    for (i = 0; i < 256; i = i + 1) begin
      @(posedge clk);
      #1;
      if (pwm_out == 1) high_count = high_count + 1;
    end
    if (high_count == 255) $display("PASS duty=%0d", duty);
    else $display("FAIL: got %0d, expected duty=%0d", high_count, duty);
    $finish;
  end
endmodule
