#!/usr/bin/env bash

# Option rmstarsilent
if ! grep -F "rmstarsilent" "$HOME/.zshrc" &> /dev/null; then
  {
    echo ""
    echo "# Custom options"
    echo "setopt rmstarsilent"
    echo ""
  } >> "$HOME/.zshrc"
fi
