# gb_asm

A personal sandbox for learning Game Boy development using [gbdev.io's assembly tutorial](https://gbdev.io/gb-asm-tutorial/). This repo contains small experiments, helper scripts, and game directories as I work through building simple ROMs in GBZ80 assembly.

---

## 🕹 What's Here

- `hello-world/`: A basic ROM that initializes the LCD and displays a tilemap — first milestone from the tutorial.
- `hardware.inc`: Commonly used Game Boy hardware constants (imported in every `.asm` file).
- `build.sh`: A shell script to assemble, link, and fix a given Game Boy project folder.
- `run.sh`: Launches a `.gb` file in [Emulicious](https://emulicious.net/).

---

## 🚀 Getting Started

### Prerequisites

You'll need the following installed:

- [RGBDS](https://github.com/gbdev/rgbds) — assembler/linker for Game Boy dev
- [Emulicious](https://emulicious.net/) — emulator with good debugging tools
- Java (for running Emulicious)

### Build and Run

From the root of the repo:

```bash
./build.sh hello-world
./run.sh hello-world
```

This will:

1. Assemble hello-world/hello-world.asm

2. Output hello-world.gb

3. Run it in Emulicious

## 🔧 Project Conventions
Each project lives in its own folder.

Folder name and .asm filename must match for build.sh to work.

Emulicious path is currently hardcoded inside run.sh.

## 📦 Future Plans
Add a Makefile for cleaner builds

Create a config file for emulator paths

Add screenshots or GIFs of completed ROMs

Build a simple sprite animation example

## 📚 Credit
Tutorial and foundational knowledge from the excellent gbdev.io.

## 👋 Why This Exists
This is a hobby project — part retro nostalgia, part systems programming curiosity. If you're also hacking on Game Boy ROMs, feel free to fork and build on this!