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

* Handles cases where forwarding is not sufficient (load-use hazard).
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

OpenLane/
    Layout Images/
    Top.gds
    Top.sdc
    config.tcl
    manufacturability.rpt
    metrics.csv

Testbench/
    TB.v
    instructions_mem.mem
```

---

## RTL Simulation (Vivado)

1. Create a new **RTL project** in Vivado
2. Add all files from:

   * `Verilog files/`
   * `Testbench/TB.v` (as simulation source)
3. Add `instructions_mem.mem` as a **memory initialization file**
4. Set `TB.v` as **top module (simulation)**
5. Run **Behavioral Simulation**

---
## Physical Design (OpenLane)

The design has been synthesized, placed, routed, and signed off using the **OpenLane** flow to generate the final GDSII file.

### Directory Contents
* **`Top.gds`**: The final signed-off GDSII file, ready for tapeout.
* **`Top.sdc`**: The final signed-off constraints file used for timing analysis.
* **`config.tcl`**: Configuration file used for the OpenLane run (tuned `io_pct` to 0.10 to resolve setup violations and ERC issues).
* **`manufacturability.rpt`**: Final sign-off manufacturability report (DRC/LVS).
* **`metrics.csv`**: Summary of the final design metrics (Area, Power, Timing).
* **`Layout Images/`**: Visual representations of the final floorplan, placement, and routing.

### Key Design Considerations
* **Constraint Tuning**: The `io_pct` parameter was adjusted to `0.10` to mitigate setup timing violations and ensure compliance with Electrical Rule Checks (ERC).
* The memory sizes were reduced and the pitch was increased for the ease of routing.
* Switched to absolute floorplan sizing so as to eliminate the PDN errors.
* All optimization resizers were enabled to achieve an optimal chip area and performance.
* **Sign-off**: The design has passed all necessary checks for manufacturability, including Design Rule Checking (DRC) and Layout Versus Schematic (LVS) and Electrical Rule Check (ERC) verification.

---

## Notes

* Supports **RV32I base instruction set**
* Designed for **pipeline and hazard understanding**
* Focus on **cycle-level correctness*
