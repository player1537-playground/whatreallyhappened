cmake_minimum_required(VERSION 3.19.0 FATAL_ERROR)
project(WhatReallyHappened)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

find_package(UUID 1.0.3 REQUIRED)

add_library(
    whatreallyhappened
    SHARED
        whatreallyhappened/src/whatreallyhappened/wrh.c
)
target_link_libraries(
    whatreallyhappened
    PUBLIC
        UUID::UUID
)
target_include_directories(
    whatreallyhappened
    PUBLIC
        whatreallyhappened/include
)

option(build_examples "Build the examples" OFF)

if(build_examples)
    add_subdirectory(examples)
endif()
