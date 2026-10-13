# verilog-pwm-controller

8-bit PWM generator in Verilog with a self-checking testbench.

## How it works
An 8-bit counter sweeps 0 to 255 and wraps. The output `pwm_out` is high
while `counter < duty`, so `duty` sets the fraction of each 256-cycle
period the output stays on (duty = 64 gives 25%).

## Files
- `pwm.v`: the design (counter, synchronous active-high reset, comparator)
- `pwm_tb.v`: self-checking testbench

## Testbench
Counts high cycles over one full 256-cycle period and compares against
the expected value for duty = 0, 1, 64, 128, and 255. Prints PASS or FAIL
for each.

## Known limitation
At duty = 255 the output is high for 255 of 256 cycles, so it never
reaches a constant 100%.

## Run it
iverilog -g2012 pwm.v pwm_tb.v && vvp a.out

Expected output:
PASS duty=0
PASS duty=1
PASS duty=64
PASS duty=128
PASS duty=255
