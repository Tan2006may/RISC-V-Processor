# RISC-V 5-Stage Pipelined Processor

## Overview

Cycle-accurate implementation of a 5-stage pipelined RISC-V (RV32I) processor.
Focus is on pipeline behavior, data hazards, forwarding, and timing correctness.

---

## Pipeline Architecture

**Stages:**

* IF – Instruction Fetch
* ID – Instruction Decode + Register Read
* EX – Execute (ALU)
* MEM – Memory Access
* WB – Write Back

**Pipeline Registers:**

* `IF_ID.v`, `ID_EX.v`, `EX_MEM.v`, `MEM_WB.v`

---

## Hazard Handling

### Forwarding Unit (FU)

* Resolves **RAW hazards** using bypassing
* Paths:

  * EX/MEM → EX
  * MEM/WB → EX

---

### Hazard Detection Unit (HDU)

* Detects **load-use hazard**
* Action:

  * Stall PC and IF/ID
  * Insert bubble

---

## Repository Structure

```
Verilog files/
    IF stage/
    ID stage/
    EX stage/
    MEM stage/
    IF_ID.v
    ID_EX.v
    EX_MEM.v
    MEM_WB.v

Testbench/
    TB.v
    instructions_mem.mem
```

---

## How to Run (Vivado)

1. Create a new **RTL project** in Vivado
2. Add all files from:

   * `Verilog files/`
   * `Testbench/TB.v` (as simulation source)
3. Add `instructions_mem.mem` as a **memory initialization file**
4. Set `TB.v` as **top module (simulation)**
5. Run **Behavioral Simulation**

---

## Notes

* Supports **RV32I base instruction set**
* Designed for **pipeline and hazard understanding**
* Focus on **cycle-level correctness**
