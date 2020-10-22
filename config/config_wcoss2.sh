#!/bin/bash

# Compiler/MPI combination
#export HPC_COMPILER="cray-intel/19.1.1.217"  # See IMPORTANT NOTE below
export HPC_COMPILER="intel/19.1.1.217"
export HPC_MPI="cray-mpich/8.0.15"

# Build options
export NCO_V=false
export USE_SUDO=N
export PKGDIR=pkg
export LOGDIR=log
export OVERWRITE=Y
export NTHREADS=8
export   MAKE_CHECK=N
export MAKE_VERBOSE=N
export   MAKE_CLEAN=N
export DOWNLOAD_ONLY=F
export STACK_EXIT_ON_FAIL=Y
export WGET="wget -nv"
export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:$PKG_CONFIG_PATH

# WCOSS2 specific
# NOTE:
# On WCOSS2 the Intel compiler module is "intel/19.1.1.217"
# However, on the Cray, the wrappers are cc, ftn, and CC
# The Intel modules have icc, ifort and icpc for CC, FC and CXX respectively
# By specifying "cray-intel", we load the "hpc-cray-intel" module which
# loads the Intel module (as it should), and
# define cc, FC and CC for CC, FC and CXX respectively.
# cray-intel does not imply the native module in this case

source /apps/prod/lmodules/startLmod

#module load lmod/8.3
module unload cpe-cray cce
module load cpe-intel 
module load intel
#module load intel/19.1.1.217/cray-mpich/8.0.15
module load cmake/3.16.5
module load git/2.27.0
#module load expat/2.2.9-intel

if $NCO_V; then 
 module load cray-hdf5-parallel/1.12.0.0
 module load cray-netcdf-hdf5parallel/4.7.4.0
 module load jasper/2.0.16
 module load libjpeg/9c
 module load libpng/1.6.37
 module load zlib/1.2.11
fi

export SERIAL_CC=cc
export SERIAL_FC=ftn
export SERIAL_CXX=CC

export MPI_CC=$SERIAL_CC
export MPI_FC=$SERIAL_FC
export MPI_CXX=$SERIAL_CXX

if $NCO_V; then
 export NetCDF_CONFIG_EXECUTABLE=/opt/cray/pe/netcdf-hdf5parallel/4.7.4.0/INTEL/19.0/bin/nc-config
 export NetCDF_PARALLEL=true
 export NetCDF_HAS_PNETCDF=True
 export NetCDF_PARALLEL=True
 export NetCDF_PATH=/opt/cray/pe/netcdf-hdf5parallel/4.7.4.0/INTEL/19.0
fi
# LMod is coming to WCOSS2
# LMod has disabled "default" and requires exact module match.
# https://lmod.readthedocs.io/en/latest/090_configuring_lmod.html
#module load lmod/8.3
#export LMOD_EXACT_MATCH="no"
#export LMOD_EXTENDED_DEFAULT="yes"
