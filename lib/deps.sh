#!/usr/bin/env bash
# Shared helper, sourced by the bootstrap/sync scripts.
# ensure_cmd <command> [package]  installs <package> (default: <command>) if <command> is missing.

ensure_cmd() {
  local cmd="$1" pkg="${2:-$1}" sudo=""
  command -v "$cmd" >/dev/null 2>&1 && return 0

  if [ "$(id -u)" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then sudo="sudo"; fi
  fi

  echo "'$cmd' not found; installing package '$pkg'..."
  if   command -v apt-get >/dev/null 2>&1; then $sudo apt-get update && $sudo apt-get install -y "$pkg"
  elif command -v dnf     >/dev/null 2>&1; then $sudo dnf install -y "$pkg"
  elif command -v yum     >/dev/null 2>&1; then $sudo yum install -y "$pkg"
  elif command -v pacman  >/dev/null 2>&1; then $sudo pacman -S --noconfirm "$pkg"
  elif command -v zypper  >/dev/null 2>&1; then $sudo zypper install -y "$pkg"
  elif command -v apk     >/dev/null 2>&1; then $sudo apk add "$pkg"
  elif command -v brew    >/dev/null 2>&1; then brew install "$pkg"
  else
    echo "No supported package manager found; please install '$pkg' manually." >&2
    return 1
  fi

  command -v "$cmd" >/dev/null 2>&1 || { echo "Failed to install '$cmd'." >&2; return 1; }
}
