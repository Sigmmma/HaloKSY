#!/usr/bin/env bash
# Compiles the KSY files and runs the test suite against them.

if ! hash ksc; then
	echo "You need the Kaitai Struct compiler (ksc) installed to run tests!"
	exit 1
fi

if ! hash pytest; then
	echo "Can't find pytest. Did you source your Python virtual environment?"
	exit 1
fi

echo "Compiling structs and running tests..."
ksc --target construct --outdir structs/ ../h1/*/* && pytest
