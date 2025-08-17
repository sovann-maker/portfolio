#!/bin/bash
set -e

# Flutter version to install
FLUTTER_VERSION="3.16.3"
FLUTTER_CHANNEL="stable"

echo "Setting up Flutter $FLUTTER_VERSION..."

# Create Flutter directory if it doesn't exist
mkdir -p $HOME/flutter

# Check if Flutter is already installed
if [ ! -d "$HOME/flutter/bin" ] || ! $HOME/flutter/bin/flutter --version | grep -q "$FLUTTER_VERSION"; then
    echo "Installing Flutter $FLUTTER_VERSION..."
    
    # Remove existing Flutter installation
    rm -rf $HOME/flutter
    
    # Download and install Flutter
    cd $HOME
    curl -O https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
    tar xf flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
    rm flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
fi

# Add Flutter to PATH
export PATH="$HOME/flutter/bin:$PATH"

# Verify installation
flutter --version

# Enable web support
flutter config --enable-web

# Get dependencies and build
flutter pub get
flutter build web --release#!/bin/bash
set -e

# Flutter version to install
FLUTTER_VERSION="3.16.3"
FLUTTER_CHANNEL="stable"

echo "Setting up Flutter $FLUTTER_VERSION..."

# Create Flutter directory if it doesn't exist
mkdir -p $HOME/flutter

# Check if Flutter is already installed
if [ ! -d "$HOME/flutter/bin" ] || ! $HOME/flutter/bin/flutter --version | grep -q "$FLUTTER_VERSION"; then
    echo "Installing Flutter $FLUTTER_VERSION..."
    
    # Remove existing Flutter installation
    rm -rf $HOME/flutter
    
    # Download and install Flutter
    cd $HOME
    curl -O https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
    tar xf flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
    rm flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
fi

# Add Flutter to PATH
export PATH="$HOME/flutter/bin:$PATH"

# Verify installation
flutter --version

# Enable web support
flutter config --enable-web

# Get dependencies and build
flutter pub get
flutter build web --release#!/bin/bash
set -e

# Flutter version to install
FLUTTER_VERSION="3.16.3"
FLUTTER_CHANNEL="stable"

echo "Setting up Flutter $FLUTTER_VERSION..."

# Create Flutter directory if it doesn't exist
mkdir -p /opt/flutter

# Check if the specific Flutter version is already installed
if [ ! -d "/opt/flutter/bin" ] || ! /opt/flutter/bin/flutter --version | grep -q "$FLUTTER_VERSION"; then
    echo "Installing Flutter $FLUTTER_VERSION..."
    
    # Remove existing Flutter installation
    rm -rf /opt/flutter
    
    # Download and install Flutter
    cd /opt
    curl -O https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
    tar xf flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
    rm flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz
else
    echo "Flutter $FLUTTER_VERSION already installed"
fi

# Add Flutter to PATH
export PATH="/opt/flutter/bin:$PATH"

# Verify installation
flutter --version

# Navigate back to project directory
cd $PWD

# Get dependencies and build
flutter pub get
flutter build web --release