add_executable(dds_sine_tb dds_sine_tb.cpp)
target_include_directories(dds_sine_tb PUBLIC ${VERILATOR_INCLUDE_Vdds_sine})
target_link_libraries(
        dds_sine_tb
        Vdds_sine
        ${VERILATOR_LIBRARY}
)
add_executable(i2s_clk_tb i2s_clk_tb.cpp)
target_include_directories(i2s_clk_tb PUBLIC ${VERILATOR_INCLUDE_Vpsk31_top})
target_link_libraries(
        i2s_clk_tb
        Vpsk31_top
        ${VERILATOR_LIBRARY}
)
