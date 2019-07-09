add_executable(dds_sine_tb dds_sine_tb.cpp)
target_include_directories(dds_sine_tb PUBLIC ${VERILATOR_INCLUDE_Vdds_sine})
target_link_libraries(
        dds_sine_tb
        Vdds_sine
        ${VERILATOR_LIBRARY}
)
