add_synthesis_target(icestick PCF ${CMAKE_CURRENT_SOURCE_DIR}/icestick.pcf
        SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/psk31_top.v
                ${CMAKE_CURRENT_SOURCE_DIR}/../src/dds_sine.v
                ${CMAKE_CURRENT_SOURCE_DIR}/../src/i2s_tx.v
        )

set(VERILOG_MODULE_SOURCES
        Vpsk31_top.cpp
        Vpsk31_top__Syms.cpp
        Vpsk31_top__Trace.cpp
        Vpsk31_top__Trace__Slow.cpp
        Vpsk31_top.h
        Vpsk31_top__Syms.h
        Vpsk31_top__Trace.h
        Vpsk31_top__Trace__Slow.h
        )

verilator_create_module(psk31_top "${VERILOG_MODULE_SOURCES}" ${CMAKE_SOURCE_DIR}/src --trace)
