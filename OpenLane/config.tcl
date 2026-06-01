set ::env(PDK) sky130A
set ::env(DESIGN_NAME) Top

# --- AUTOMATED FILE LOOKUP ---
set verilog_list [list]
catch {set verilog_list [concat $verilog_list [glob -nocomplain $::env(DESIGN_DIR)/src/*.v]]}
catch {set verilog_list [concat $verilog_list [glob -nocomplain $::env(DESIGN_DIR)/src/*/*.v]]}
set ::env(VERILOG_FILES) $verilog_list

set ::env(CLOCK_PORT) clk
set ::env(CLOCK_PERIOD) 150.0
set ::env(IO_PCT) 0.10                        

# --- THE ABSOLUTE SYNTHESIS PRESERVATION SWITCHES ---
set ::env(SYNTH_ELABORATE_ONLY) 0
set ::env(SYNTH_NO_FLIPFLOPS) 0
set ::env(SYNTH_DRIVING_CELL) "sky130_fd_sc_hd__inv_1"
set ::env(SYNTH_MAP_DRIVING_CELL) 1

# --- NETLIST CLEANING BALANCED FOR TIMING ---
set ::env(SYNTH_CLEAN_OUT) 1                    
set ::env(SYNTH_READ_BLACKBOX) 0

# --- ABSOLUTE PHYSICAL CONTROLS ---
set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 2000 2000"
set ::env(CORE_AREA) "10 10 1970 1970"
set ::env(PL_TARGET_DENSITY) 0.45               
set ::env(FP_PDN_AUTO_ADJUST) 1

set ::env(FP_PDN_VPITCH) 120                    
set ::env(FP_PDN_HPITCH) 120                    
set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hd

set ::env(RUN_LINTER) 0
set ::env(MAX_FANOUT_CONSTRAINT) 6              

# --- FOR DRC/ANTENNA SIGN-OFF ---
set ::env(GRT_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(GRT_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 1      
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 1     
set ::env(GRT_RT_ESTIMATE_PARASITICS) 1
set ::env(RUN_DRT) 1
set ::env(GRT_ALLOW_CONGESTION) 0
set ::env(CHECKA_ANTENNAS) 1
set ::env(GRT_REPAIR_ANTENNAS) 1
