set dotenv-load

raylib_dir := "raylib-5.5_linux_amd64"
build_dir := "build"
output := "snake"

default:
    @just --list

run: build
    ./build/{{output}}

build:
    mkdir -p {{build_dir}}

    $SAYA raylib.saya -o {{build_dir}}/raylib.ssa -t {{build_dir}}/raylib.td -N raylib
    $SAYA main.saya -o {{build_dir}}/main.ssa -M raylib={{build_dir}}/raylib.td

    qbe {{build_dir}}/raylib.ssa -o {{build_dir}}/raylib.s
    qbe {{build_dir}}/main.ssa -o {{build_dir}}/main.s

    cc -c {{build_dir}}/raylib.s -o {{build_dir}}/raylib.o
    cc -c {{build_dir}}/main.s -o {{build_dir}}/main.o

    cc {{build_dir}}/raylib.o {{build_dir}}/main.o -L {{raylib_dir}}/lib/ -l:libraylib.a -lm -o {{build_dir}}/{{output}}

clean:
    rm -rf {{build_dir}}
