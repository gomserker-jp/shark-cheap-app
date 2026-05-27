#!/usr/bin/env bash
set -euo pipefail

require_command() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "error: '$cmd' is required but not installed." >&2
    exit 1
  fi
}

install_if_missing() {
  local name="$1"
  local install_cmd="$2"
  if ! command -v "$name" >/dev/null 2>&1; then
    echo "Installing $name..."
    eval "$install_cmd"
  else
    echo "$name is already installed."
  fi
}

require_command brew

install_if_missing java "brew install --cask temurin"
install_if_missing xcodegen "brew install xcodegen"
install_if_missing fastlane "brew install fastlane"

echo
echo "Tool versions:"
java -version
xcodegen --version
fastlane --version

