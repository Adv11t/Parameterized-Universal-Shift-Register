# Parameterized-Universal-Shift-Register

This is a Verilog implementation of a Universal Shift Register with a configurable bit width (default is 3 bits). The register supports four operations based on a 2-bit control signal:

- `00`: Hold (no change)
- `01`: Parallel Load
- `10`: Left Shift (with serial input from right)
- `11`: Right Shift (with serial input from left)

The design uses D flip-flops and a 4:1 multiplexer. A testbench is included to simulate all operations.
