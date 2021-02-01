cmake_minimum_required(VERSION 3.19.0 FATAL_ERROR)

# Thanks https://bloerg.net/2012/11/10/cmake-and-distutils.html

find_program(PYTHON "python")

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/setup.py.in
    ${CMAKE_CURRENT_BINARY_DIR}/setup.py
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/build/timestamp
    COMMAND ${PYTHON} ${CMAKE_CURRENT_BINARY_DIR}/setup.py build
    COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_CURRENT_BINARY_DIR}/build/timestamp
    DEPENDS
        ${CMAKE_CURRENT_SOURCE_DIR}/whatreallyhappened/__init__.py
)

add_custom_target(
    whatreallyhappened_python
    ALL
    DEPENDS
        ${CMAKE_CURRENT_BINARY_DIR}/build/timestamp
)

install(
    CODE "execute_process(COMMAND ${PYTHON} ${CMAKE_CURRENT_BINARY_DIR}/setup.py install)"
)
