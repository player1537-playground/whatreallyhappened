cmake_minimum_required(VERSION 3.19.0 FATAL_ERROR)
include(ConfigureAndGenerate)

find_package(ctypes.sh REQUIRED)

configure_and_generate(
    INPUT "${CMAKE_CURRENT_SOURCE_DIR}/whatreallyhappened.bash.in"
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/whatreallyhappened.bash"
    AT_ONLY
)

install(
    PROGRAMS
        ${CMAKE_CURRENT_BINARY_DIR}/whatreallyhappened.bash
    TYPE BIN
)
