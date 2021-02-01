cmake_minimum_required(VERSION 3.19.0 FATAL_ERROR)

find_package(ctypes.sh REQUIRED)

file(
    READ "${CMAKE_CURRENT_SOURCE_DIR}/whatreallyhappened.bash.in"
    _tmp_in
)
string(
    CONFIGURE "${_tmp_in}" _tmp
    @ONLY
)
file(
    GENERATE
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/whatreallyhappened.bash"
    CONTENT "${_tmp}"
)

install(
    PROGRAMS
        ${CMAKE_CURRENT_BINARY_DIR}/whatreallyhappened.bash
    TYPE BIN
)
