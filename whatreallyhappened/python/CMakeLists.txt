cmake_minimum_required(VERSION 3.19.0 FATAL_ERROR)
include(ConfigureAndGenerate)

# Thanks https://bloerg.net/2012/11/10/cmake-and-distutils.html

find_program(PYTHON "python")

configure_and_generate(
    INPUT "${CMAKE_CURRENT_SOURCE_DIR}/setup.py.in"
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/setup.py"
    AT_ONLY
)

configure_and_generate(
    INPUT "${CMAKE_CURRENT_SOURCE_DIR}/whatreallyhappened.py.in"
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/whatreallyhappened.py"
    AT_ONLY
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/build-timestamp
    COMMAND ${PYTHON} ${CMAKE_CURRENT_BINARY_DIR}/setup.py sdist --format=zip
    COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_CURRENT_BINARY_DIR}/build-timestamp
    DEPENDS
        ${CMAKE_CURRENT_BINARY_DIR}/whatreallyhappened.py
        ${CMAKE_CURRENT_BINARY_DIR}/setup.py
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_custom_target(
    whatreallyhappened_python
    ALL
    DEPENDS
        ${CMAKE_CURRENT_BINARY_DIR}/build-timestamp
)

install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/dist/whatreallyhappened-${CMAKE_PROJECT_VERSION}.zip
    TYPE LIB
)

install(
    CODE "execute_process(COMMAND ${PYTHON} ${CMAKE_CURRENT_BINARY_DIR}/setup.py install)"
)
