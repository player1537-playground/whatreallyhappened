cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)

add_library(
    whatreallyhappened
    SHARED
        src/whatreallyhappened/wrh.c
)
target_link_libraries(
    whatreallyhappened
    PUBLIC
        UUID::UUID
)
target_include_directories(
    whatreallyhappened
    PUBLIC
        include
)

install(TARGETS whatreallyhappened)

option(build_python "Build the Python library" OFF)
if(build_python)
    add_subdirectory(python)
endif()

option(build_bash "Build the Bash library" OFF)
if(build_bash)
    add_subdirectory(bash)
endif()
