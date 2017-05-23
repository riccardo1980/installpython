# Purpose:  
Build python version that not relies on LD_LIBRARY_PATH for finding libpython2.7.so

# Method:
Python is compiled with: LDFLAGS=-Wl,-rpath=${INSTALLDIR}/lib where INSTALLDIR is target installation directory.

# Prerequisites
  - gcc
  - wget
  - internet connection

# Provides
  - python install + pip + virtualenv + setuptools

# Usage
Open the script and:  
  - set PYTHON_VERSION as requested python version [tested with PYTHON_VERSION=2.7.13]  
  - set VIRTUALENV_VERSION as requested virtualenv version [tested with VIRTUALENV_VERSION=15.1.0]  
  - set INSTALLDIR as target installation directory  
  - optional: set WORKDIR as directory for downlading and compilation processes  
