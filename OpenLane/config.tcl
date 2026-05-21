set ::env(PDK) sky130A
set ::env(DESIGN_NAME) Top

set ::env(VERILOG_FILES) [concat \
    [glob $::env(DESIGN_DIR)/src/*.v] \
    [glob "$::env(DESIGN_DIR)/src/*/*.v"] \
]

set ::env(CLOCK_PORT) clk
set ::env(CLOCK_PERIOD) 10.0

set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 150 150"
set ::env(CORE_AREA) "10 10 140 140"
set ::env(PL_TARGET_DENSITY) 0.40
set ::env(FP_PDN_AUTO_ADJUST) 0

set ::env(FP_PDN_VPITCH) 8
set ::env(FP_PDN_HPITCH) 8
set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hd

set ::env(RUN_LINTER) 0

set ::env(MAX_FANOUT_CONSTRAINT) 10
