cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)
include(ExternalProject)

set(EP_UUID "UUID")
ExternalProject_Add(
    ${EP_UUID}

    URL https://sourceforge.net/projects/libuuid/files/libuuid-${UUID_FIND_VERSION}.tar.gz/download

    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ./configure
        --prefix=<INSTALL_DIR>

    BUILD_COMMAND make

    INSTALL_COMMAND make install
)
ExternalProject_Add_StepTargets(${EP_UUID} install)
ExternalProject_Get_Property(${EP_UUID} SOURCE_DIR)
ExternalProject_Get_Property(${EP_UUID} INSTALL_DIR)
set(UUID_INSTALL_DIR ${INSTALL_DIR})
set(UUID_ROOT_DIR ${SOURCE_DIR})
set(UUID_INCLUDE_DIR ${INSTALL_DIR}/include)
set(UUID_LINK_DIR ${INSTALL_DIR}/lib)
set(UUID_LIBRARIES
    ${UUID_LINK_DIR}/libuuid.so
)

file(MAKE_DIRECTORY ${UUID_INCLUDE_DIR})
file(MAKE_DIRECTORY ${UUID_LINK_DIR})

add_library(
    UUID::UUID
    INTERFACE
    IMPORTED
)
target_link_libraries(
    UUID::UUID
    INTERFACE
        ${UUID_LIBRARIES}
)
target_include_directories(
    UUID::UUID
    INTERFACE
        ${UUID_INCLUDE_DIR}
)
add_dependencies(UUID::UUID ${EP_UUID}-install)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    UUID
    REQUIRED_VARS
        UUID_INSTALL_DIR
        UUID_ROOT_DIR
        UUID_LINK_DIR
        UUID_LIBRARIES
)
