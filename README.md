# 8-Bit Parametric Arithmetic Logic Unit (ALU)

## Overview

An **Arithmetic Logic Unit (ALU)** is a fundamental building block of a computer processor (CPU). This project implements a **Parametric 8-bit ALU** in Verilog capable of executing **16 distinct operations** across Arithmetic, Logic, Shift/Rotate, and Comparison categories.

---

## Files

| File | Description |
|------|-------------|
| `ALU.srcs/sources_1/new/alu.v` | RTL design of the 8-Bit Parametric ALU |
| `ALU.srcs/sim_1/new/tb.v` | Testbench with opcode test loop and waveform simulation |

---

## Design Details

### Module: `alu`

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `a` | Input | `w`-bit (8) | First operand input |
| `b` | Input | `w`-bit (8) | Second operand input |
| `sel` | Input | 4-bit | Operation select line (16 opcodes) |
| `out` | Output | `w`-bit (8) | ALU computation result |
| `C` | Output | 1-bit | Carry-Out / Borrow-Out flag |

---

## Operation Table

The ALU evaluates 16 operations based on the 4-bit opcode `sel[3:0]`:

| Opcode (`sel[3:0]`) | Operation | Category | Mathematical / Logical Expression |
| :---: | :--- | :--- | :--- |
| `0000` (0) | **ADD** | Arithmetic | `out = a + b`, sets Carry `C` |
| `0001` (1) | **SUB** | Arithmetic | `out = a - b`, sets Borrow `C` |
| `0010` (2) | **MUL** | Arithmetic | `out = a * b` (lower 8 bits) |
| `0011` (3) | **INC** | Arithmetic | `out = a + 1`, sets Carry `C` |
| `0100` (4) | **DEC** | Arithmetic | `out = a - 1`, sets Borrow `C` |
| `0101` (5) | **ABS** | Arithmetic | `out = \|a\|` (2's complement magnitude) |
| `0110` (6) | **XOR** | Logic | `out = a ^ b` |
| `0111` (7) | **AND** | Logic | `out = a & b` |
| `1000` (8) | **OR**  | Logic | `out = a \| b` |
| `1001` (9) | **NAND**| Logic | `out = ~(a & b)` |
| `1010` (10)| **NOR** | Logic | `out = ~(a \| b)` |
| `1011` (11)| **XNOR**| Logic | `out = ~(a ^ b)` |
| `1100` (12)| **NOT** | Logic | `out = ~a` |
| `1101` (13)| **ROTL**| Shift / Rotate | Rotate Left `a` by 1 bit |
| `1110` (14)| **ASHR**| Shift / Rotate | Arithmetic Right Shift `a` (preserves sign) |
| `1111` (15)| **CMP** | Comparison | If `a > b` → 1, If `a < b` → -1, Else → 0 |

---

## Testbench

The testbench (`tb.v`):
- Drives test operands $a = 100$ (`8'd100`) and $b = 45$ (`8'd45`)
- Cycles through all 16 opcode select values (`sel = 0` to `15`)
- Uses a **10 ns delay per operation** (`#10`) for 160 ns total simulation time

---

## Simulation Output

![Simulation Waveform](waveform_decimal.png)

The waveform confirms the 8-Bit ALU executing all operations across time, displaying operand inputs, control select line `sel[3:0]`, output result `out[7:0]`, and Carry flag `C`.

---

## How to Simulate

### Using Vivado
1. Open Vivado and open `ALU.xpr`
2. Run Behavioral Simulation
3. In the waveform window, set **Radix** to **Unsigned Decimal** and press **F** to Zoom Fit

### Using iverilog

    iverilog -o alu_sim ALU.srcs/sources_1/new/alu.v ALU.srcs/sim_1/new/tb.v
    vvp alu_sim

---

## Tools Used

| Tool | Details |
|------|---------|
| Language | Verilog (IEEE 1364-2001) |
| Simulator | AMD Vivado Simulator (XSim) |
| Timescale | 1ns / 1ps |

---

## Applications

- Central Processing Units (CPUs) and Microcontrollers
- Digital Signal Processors (DSPs)
- Arithmetic logic execution units in RISC-V / ARM architectures

---

## Author

- **Tool:** AMD Vivado 2026.1
