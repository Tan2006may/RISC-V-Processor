set ::env(PDK) sky130A
set ::env(DESIGN_NAME) Top

set ::env(VERILOG_FILES) [concat \
    [glob $::env(DESIGN_DIR)/src/*.v] \
    [glob "$::env(DESIGN_DIR)/src/*/*.v"] \
]

set ::env(CLOCK_PORT) clk
set ::env(CLOCK_PERIOD) 10.0

set ::env(FP_CORE_UTIL) 30
set ::env(PL_TARGET_DENSITY) 0.55
set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hd

set ::env(RUN_LINTER) 0

set ::env(MAX_FANOUT_CONSTRAINT) 10
