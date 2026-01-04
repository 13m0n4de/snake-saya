SAYA := "saya"
RAYLIB_DIR := "raylib-5.5_linux_amd64"
OUTPUT := "snake"

default:
    @just --list

run: build
    ./{{OUTPUT}}

build:
    {{SAYA}} main.saya
    qbe out.ssa -o out.s
    cc out.s -o {{OUTPUT}} -I {{RAYLIB_DIR}}/include/ -L {{RAYLIB_DIR}}/lib/ -l:libraylib.a -lm

clean:
    rm -f out.ssa out.s {{OUTPUT}}
