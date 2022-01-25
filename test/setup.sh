#!/usr/bin/env bash
# Installs *most* stuff required for testing.

echo "Creating Python environment"
virtualenv venv
source venv/bin/activate

echo "Installing Python test libraries"
pip install -r requirements.txt

# TODO Need to download ksc. Maybe upload a pre-compiled thing?
# TODO Need to download static test resources.
