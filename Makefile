#-------------------------------------------------------------------------------
# SPEX_Update_Test/Makefile
#-------------------------------------------------------------------------------

# Copyright (c) TODO
# SPDX-License-Identifier: BSD-3-clause

#-------------------------------------------------------------------------------

# A simple Makefile for the SPEX_Update_Test, which relies on
# cmake to do the actual build.  All the work is done in cmake so this Makefile
# is just for convenience.

# To compile with an alternate compiler:
#
#       make CC=gcc CXX=g++
#
# To compile/install for system-wide usage:
#
#       make
#       sudo make install
#
# To compile/install for local usage (SuiteSparse/lib and SuiteSparse/include):
#
#       make local
#       make install
#
# To clean up the files:
#
#       make clean

JOBS ?= 8

default:
	( cd build && cmake $(CMAKE_OPTIONS) .. && cmake --build . --config Release -j${JOBS} )

debug:
	( cd build && cmake $(CMAKE_OPTIONS) -DCMAKE_BUILD_TYPE=Debug .. && cmake --build . --config Debug -j${JOBS} )

all: default

demos: default
	( cd build && ./my_demo )

# just compile after running cmake; do not run cmake again
remake:
	( cd build && cmake --build . -j${JOBS} )

# just run cmake to set things up
setup:
	( cd build && cmake $(CMAKE_OPTIONS) .. )

# remove all files not in the distribution
clean:
	- $(RM) -rf build/* Config/*.tmp temp.rb

purge: clean

distclean: clean

runafiro:
	- ./build/ptest lp_afiro
	- ./build/cholupdate lp_afiro

runtest:
	- ./build/ptest

runchol:
	- ./build/cholupdate

