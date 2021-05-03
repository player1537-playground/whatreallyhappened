cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)
project(WhatReallyHappened VERSION 0.1.0)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

find_package(UUID 1.0.3 REQUIRED)

add_subdirectory(whatreallyhappened)

option(build_examples "Build the examples" OFF)
if(build_examples)
    add_subdirectory(examples)
endif()
