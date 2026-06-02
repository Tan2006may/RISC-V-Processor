# RISC-V 5-Stage Pipelined Processor

A complete end-to-end silicon implementation of a 5-stage pipelined RISC-V (RV32I) processor. This project encompasses cycle-accurate RTL development, thorough hazard verification, and automated Physical Design ASIC tapeout generation using the OpenLane flow.

---

## Pipeline Architecture

The processor implements the base **RV32I** instruction set architecture with a classic 5-stage decoupled execution pipeline optimized for cycle-level correctness:

*   **IF (Instruction Fetch):** Program Counter tracking and instruction memory streaming.
*   **ID (Instruction Decode):** Instruction decoding and dual-port register file reading.
*   **EX (Execute):** Arithmetic Logic Unit (ALU) processing, branch evaluation, and address computation.
*   **MEM (Memory Access):** Synchronous data memory read/write operations.
*   **WB (Write Back):** Register file destination commits.

### Pipeline Registers
State isolation between stages is safely managed by explicit pipeline boundary modules:
*   `IF_ID.v` | `ID_EX.v` | `EX_MEM.v` | `MEM_WB.v`

---

## Hazard Handling & Interlock Logic

### Forwarding Unit (FU)
To minimize execution penalties, a dedicated Forwarding Unit resolves **Read-After-Write (RAW) data hazards** dynamically by bypassing data directly to the execution stage before it is written back to the register file.
*   **Paths:** `EX/MEM → EX` and `MEM/WB → EX`

### Hazard Detection Unit (HDU)
For data dependencies that cannot be resolved via bypassing alone (such as a load-use dependency), the Hazard Detection Unit safely intercepts the execution flow.
*   **Action:** Interlocks the pipeline by stalling the PC and `IF/ID` register while inserting an execution bubble.

---

## Manufacturing Sign-off Metrics

The physical layout database successfully completed the full OpenLane implementation pipeline and achieved a comprehensive **`[SUCCESS]: Flow complete`** sign-off status with absolute zero physical manufacturing defects.


| Verification Metric | Target Threshold | Actual Result | Status |
| :--- | :--- | :--- | :--- |
| **Magic DRC** | 0 Violations | **0** |  PASS |
| **LVS Check** | Netlist Match | **Clean Match** |  PASS |
| **Electrical Rule Check (ERC)** | 0 Violations | **0** |  PASS |
| **Antenna Sign-off** | Automated Flow | **Flow Complete** |  PASS |
| **Target Clock Period** | User Constrained | **150.0 ns** |  PASS |

---

## 🛠️ Physical Design & OpenLane Configuration

The layout was hardened using the **OpenLane** ASIC flow under the **sky130A** process design kit. Key engineering adjustments implemented to secure physical sign-off include:

*   **Constraint Tuning:** Optimized the input/output percentage parameter (`io_pct` to `0.10`) to eliminate setup timing slacks and pass structural Electrical Rule Checks (ERC).
*   **Floorplan Sizing:** Utilized absolute floorplan sizing (`DIE_AREA "0 0 2000 2000"`) to resolve Power Distribution Network (PDN) generation constraints and routing conflicts on the macro bounds.
*   **Macro Optimization:** Scaled register memory configurations and adjusted vertical/horizontal pitch lengths to ensure clean grid alignment during global routing phases.
*   **Automated Resizing:** Enabled all physical optimization resizers during placement and routing iterations to achieve an ideal area-to-performance compromise.

---

##  Repository Structure

```text
├── Verilog files/            # Core RTL Implementation
│   ├── EX stage/             # ALU and execution logic
│   ├── ID stage/             # Decode and register file logic
│   ├── IF stage/             # Instruction Fetch logic
│   ├── MEM stage/            # Memory interface subsystems
│   ├── EX_MEM.v              # Pipeline register (Execute to Memory)
│   ├── ID_EX.v               # Pipeline register (Decode to Execute)
│   ├── IF_ID.v               # Pipeline register (Fetch to Decode)
│   ├── MEM_WB.v              # Pipeline register (Memory to Write-Back)
│   └── Top.v                 # Top-level structural design wrapper
├── OpenLane/                 # Physical Design & Layout Sign-off
│   ├── Layout Images/        # Floorplan, Placement, and Routing captures
│   ├── Top.gds               # Final signed-off manufacturing GDSII layout
│   ├── Top.sdc               # Synopsys Design Constraints timing file
│   ├── config.tcl            # Fine-tuned OpenLane deployment config
│   ├── manufacturability.rpt # Official sign-off DRC/LVS summary log
│   └── metrics.csv           # Final chip area, power, and cell utilization stats
└── Testbench/                # Verification Environment
    ├── TB.v                  # Cycle-accurate testbench wrapper
    └── instructions_mem.mem  # Instruction memory hex initialization file
```

---

## Verification & Simulation Guide

### RTL Behavioral Simulation (AMD Vivado)
1. Initialize a new **RTL Project** inside the Vivado IDE.
2. Add all synthesizable source files located in the `Verilog files/` directory.
3. Import `Testbench/TB.v` as your dedicated **Simulation-Only Source**.
4. Link `instructions_mem.mem` directly to the project as a **Memory Initialization File**.
5. Set `TB.v` as your **Top Simulation Module**.
6. Execute **Run Behavioral Simulation** to observe cycle-accurate pipeline waveforms.
