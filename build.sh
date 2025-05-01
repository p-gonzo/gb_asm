#!/bin/bash
game_dir=$1
cd "$game_dir" || { echo "Failed to cd into $game_dir"; exit 1; }

# Clean Up
rm "$game_dir.o"
rm "$game_dir.gb"

#Assemble
rgbasm -o "$game_dir.o" "$game_dir.asm"

#Link
rgblink -o "$game_dir.gb" "$game_dir.o"

#Make symbols for debugging
rgblink -n "$game_dir.sym" "$game_dir.o"

#Offset ROM for header information
rgbfix -v -p 0xFF "$game_dir.gb"