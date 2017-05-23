#!/bin/bash
set -e

WORKDIR=src
INSTALLDIR=$HOME/mypython
PYTHON_VERSION=2.7.13
VIRTUALENV_VERSION=15.1.0

if [ -d $WORKDIR ]; then
  echo "deleting old WORKDIR: $WORKDIR"
  rm -rf $WORKDIR
fi
mkdir $WORKDIR

if [ -d $INSTALLDIR ]; then
  echo "deleting old INSTALLDIR: $INSTALLDIR"
  rm -rf $INSTALLDIR
fi
mkdir $INSTALLDIR

{
pushd $WORKDIR

# PYTHON
wget http://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
tar -zxf Python-${PYTHON_VERSION}.tgz
pushd Python-${PYTHON_VERSION}
./configure --prefix=$INSTALLDIR --enable-shared LDFLAGS=-Wl,-rpath=${INSTALLDIR}/lib
make
make install
# if install is ok, keep track of my python
PYTHON=$(realpath $INSTALLDIR/bin/python)
popd

# VIRTUALENV
wget https://pypi.python.org/packages/d4/0c/9840c08189e030873387a73b90ada981885010dd9aea134d6de30cd24cb8/virtualenv-${VIRTUALENV_VERSION}.tar.gz
tar -zxf virtualenv-${VIRTUALENV_VERSION}.tar.gz
pushd virtualenv-${VIRTUALENV_VERSION}
$PYTHON setup.py install
# if install is ok, keep track of my python
VIRTUALENV=$(realpath $INSTALLDIR/bin/virtualenv)
popd

# PIP AND SETUPTOOLS
wget https://bootstrap.pypa.io/get-pip.py
$PYTHON get-pip.py

# SUMMARY
echo "##############################################################"
echo "python is installed in: $INSTALLDIR"
echo "python: $PYTHON"
echo "virtualenv: $VIRTUALENV"
echo ""
echo "for a virtual environment, use:"
echo "$VIRTUALENV --always-copy --python=$PYTHON ENVNAME"
} 2>&1 | tee ${0%.*}.log
