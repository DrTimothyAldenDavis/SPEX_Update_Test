#-------------------------------------------------------------------------------
# SPEX_Update_test/CMakeLists.txt:  cmake for SPEX_Update_test package
#-------------------------------------------------------------------------------

# Copyright (c) TODO

cmake_minimum_required ( VERSION 3.22 )

#-------------------------------------------------------------------------------
# help with building this package and finding SuiteSparse 
#-------------------------------------------------------------------------------

# Requirements:
#   SPEX 3.3.0 or later
#   SuiteSparse_config 7.8.2 or later
#   AMD 3.3.3 or later
#   COLAMD 3.3.3 or later
#   GMP 6.1.2 or later
#   MPFR 4.0.2 or later
#   OpenMP, just for timing routines
#   glpk, at https://www.gnu.org/software/glpk/ , installable with:
#       sudo apt get libglpk-dev

# To build this package, add the location of the CMake config files to
# CMAKE_PREFIX_PATH if the SuiteSparse/SPEX libraries aren't installed at a
# default location.  For example, on Linux or Mac, if you have your own a
# compiled copy of SuiteSparse in ../SPEX or ../SuiteSparse that was compiled
# and installed with SUITESPARSE_LOCAL_INSTALL set to ON, use the following:

    set ( CMAKE_PREFIX_PATH ../v3.3.0/SPEX ../SPEX ../SuiteSparse )

# In SPEX or SuiteSparse, first do
#
#   make local
#   make install
#
# Next, to build and install this package, do the following here:
#
#   make

# Then run the tests:

#   make runafiro
#   make runtest
#   make runchol

message ( STATUS "MY prefix path:    ${CMAKE_PREFIX_PATH}" )
message ( STATUS "Building SPEX_Update_Test" )

#-------------------------------------------------------------------------------
# define the project
#-------------------------------------------------------------------------------

project ( SPEX_Update_Test LANGUAGES C CXX )

#-------------------------------------------------------------------------------
# find library dependencies
#-------------------------------------------------------------------------------

# look for all SuiteSparse packages:
find_package ( SuiteSparse_config 7.8.2 REQUIRED )
find_package ( AMD 3.3.3 REQUIRED )
find_package ( COLAMD 3.3.4 REQUIRED )
find_package ( SPEX 3.3.0 REQUIRED )    # requires GMP and MPFR

# for GMP and MPFR
find_package ( MPFR 4.0.2 REQUIRED )    # from SPEX/cmake_modules
find_package ( GMP 6.1.2 REQUIRED )     # from SPEX/cmake_modules

#-------------------------------------------------------------------------------
# test programs
#-------------------------------------------------------------------------------

include_directories ( ${GMP_INCLUDE_DIR} )
include_directories ( ${MPFR_INCLUDE_DIR} )
include_directories ( ../v3.3.0/SPEX/SPEX/SPEX_Utilities/Demo )
include_directories ( ../v3.3.0/SPEX/SPEX/SPEX_Utilities/Source )

add_executable ( cholupdate "cholupdate.c" "test.c" )
target_link_libraries ( cholupdate PUBLIC m
    SuiteSparse::SuiteSparseConfig
    SuiteSparse::AMD SuiteSparse::COLAMD SuiteSparse::SPEX
    ${MPFR_LIBRARIES} ${GMP_LIBRARIES} OpenMP::OpenMP_C glpk )

add_executable ( ptest "ptest.c" "test.c" )
target_link_libraries ( ptest PUBLIC m
    SuiteSparse::SuiteSparseConfig
    SuiteSparse::AMD SuiteSparse::COLAMD SuiteSparse::SPEX
    ${MPFR_LIBRARIES} ${GMP_LIBRARIES} OpenMP::OpenMP_C glpk )

add_executable ( test_optimal "test_optimal.c" "test.c" )
target_link_libraries ( test_optimal PUBLIC m
    SuiteSparse::SuiteSparseConfig
    SuiteSparse::AMD SuiteSparse::COLAMD SuiteSparse::SPEX
    ${MPFR_LIBRARIES} ${GMP_LIBRARIES} OpenMP::OpenMP_C glpk )

