INCLUDE "../hardware.inc"

SECTION "Header", ROM0[$100]
    jp EntryPoint
    ds $150 - @, 0 ; Make room for the header

SECTION "Main", ROM0

EntryPoint:
    ; Shut down audio circuitry
    ld a, 0
    ld [rNR52], a

WaitVBlank:
    ld a, [rLY]
    cp 144
    jp c, WaitVBlank

    ; Turn off the LCD (must be done during VBlank)
    ld a, 0
    ld [rLCDC], a

    ; Copy tile data to VRAM
    ld de, Tiles
    ld hl, $9000
    ld bc, TilesEnd - Tiles
CopyTiles:
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jp nz, CopyTiles

    ; Copy tilemap to VRAM
    ld de, Tilemap
    ld hl, $9800
    ld bc, TilemapEnd - Tilemap
CopyTilemap:
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jp nz, CopyTilemap

    ; Set LCD control: LCD on, background on
    ld a, LCDCF_ON | LCDCF_BGON
    ld [rLCDC], a

    ; Setup initial palette
    ld a, %11100100
    ld [rBGP], a

    ; Initialize palette pointer and delay
    ld de, PaletteTable     ; DE will hold palette pointer
    
	ld a, [FadeSpeed]
	ld b, a                ; B = frame delay

MainLoop:
    ; Wait for VBlank
WaitVBlankStart:
    ld a, [rLY]
    cp 144
    jp c, WaitVBlankStart

WaitVBlankEnd:
    ld a, [rLY]
    cp 144
    jp nc, WaitVBlankEnd

    ; Decrement frame counter
    dec b
    jp nz, MainLoop         ; Not time yet

    ; Load next palette
    ld a, [de]
    cp $AA
    jp z, ResetPalettePointer

    ld [rBGP], a
    inc de                  ; Move to next palette
    ld a, [FadeSpeed]
	ld b, a                ; Reset frame delay
    jp MainLoop

ResetPalettePointer:
    ld de, PaletteTable
    ld a, [FadeSpeed]
    ld b, a
    jp MainLoop

SECTION "Tile data", ROM0

Tiles:
    INCBIN "./assets/tileset.bin"
TilesEnd:

SECTION "Tilemap", ROM0

Tilemap:
    INCBIN "./assets/tilemap32x32.bin"
TilemapEnd:

SECTION "Palette Table", ROM0

PaletteTable:
    db %11100100
    db %11111001
    db %11111110
    db %11111111
    db %11111110
    db %11111001
    db %11100100
    db $AA  ; Sentinel for reset


SECTION "Vars", rom0

FadeSpeed: db 10
PalettePointer: dw