FROM debian:trixie-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    mercurial \
    curl \
    wget \
    build-essential \
    libgtk-3-dev \
    libdbus-glib-1-dev \
    libxt-dev \
    libpulse-dev \
    libasound2-dev \
    yasm \
    nasm \
    libclang-dev \
    clang \
    nodejs \
    npm \
    rustc \
    cargo \
    cbindgen \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /firefox-build

# Clone Firefox source code
RUN hg clone https://hg.mozilla.org/mozilla-central firefox-src

WORKDIR /firefox-build/firefox-src

# Bootstrap Firefox build environment
RUN ./mach bootstrap --application-choice=browser --no-interactive

# Build Firefox
RUN ./mach build

# Optional: Package Firefox
RUN ./mach package

# The built Firefox will be in obj-*/dist/firefox/
CMD ["/bin/bash"]
