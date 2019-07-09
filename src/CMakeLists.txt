set(VERILOG_MODULE_SOURCES
        Vdds_sine.cpp
        Vdds_sine__Syms.cpp
        Vdds_sine__Trace.cpp
        Vdds_sine__Trace__Slow.cpp
        Vdds_sine.h
        Vdds_sine__Syms.h
        Vdds_sine__Trace.h
        Vdds_sine__Trace__Slow.h
        )

verilator_create_module(dds_sine "${VERILOG_MODULE_SOURCES}" "" --trace)
