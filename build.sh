#!/usr/bin/env bash
set -e

# Install LibreOffice
apt-get update && apt-get install -y libreoffice

# Install Python dependencies
pip install -r requirements.txt