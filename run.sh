#!/bin/bash
game_dir=$1
emulicious_jar_path="../../Emulicious/Emulicious.jar"
cd "$game_dir" || { echo "Failed to cd into $game_dir"; exit 1; }

java -jar $emulicious_jar_path $(pwd)/$game_dir.gb