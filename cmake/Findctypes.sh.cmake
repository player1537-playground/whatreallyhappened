cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)
include(ExternalProject)


set(EP_CTYPES_SH ctypes.sh)
ExternalProject_Add(
    ${EP_CTYPES_SH}

    BUILD_IN_SOURCE 1
    UPDATE_DISCONNECTED ON

    GIT_REPOSITORY https://github.com/taviso/ctypes.sh.git
    GIT_TAG 6982e6cb226502cb89173fb272b3ef0438e593c4  # Nov 18, 2020, 6:58 PM EST

    PATCH_COMMAND ./autogen.sh

    CONFIGURE_COMMAND ./configure
        --prefix=<INSTALL_DIR>

    BUILD_COMMAND make

    INSTALL_COMMAND make install
)
ExternalProject_Add_StepTargets(${EP_CTYPES_SH} install)
ExternalProject_Get_Property(${EP_CTYPES_SH} SOURCE_DIR)
ExternalProject_Get_Property(${EP_CTYPES_SH} INSTALL_DIR)
set(ctypes.sh_INSTALL_DIR ${INSTALL_DIR})
set(ctypes.sh_ROOT_DIR ${SOURCE_DIR})
set(ctypes.sh_EXECUTABLE ${INSTALL_DIR}/bin/ctypes.sh)
set(ctypes.sh_TARGET ${EP_CTYPES_SH}-install)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    ctypes.sh
    REQUIRED_VARS
        ctypes.sh_INSTALL_DIR
        ctypes.sh_ROOT_DIR
        ctypes.sh_EXECUTABLE
        ctypes.sh_TARGET
)
