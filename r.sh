#!/bin/bash

#Author: Samuel Vo
#Program name: Random Products Program

rm *.o
rm *.lis
rm *.out

echo "This is program <Random Products Program>"

echo "Compile the C module main.c"
gcc -c -Wall -no-pie -m64 -std=c2x -o main.o main.c 

echo "Compile the C++ module quick_sort.c"
gcc -c -Wall -no-pie -m64 -std=c2x -o quick_sort.o quick_sort.c 

echo "Assemble the module executive.asm"
nasm -f elf64 -l executive.lis -o executive.o executive.asm 

echo "Assemble the module fill_random_array.asm"
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm 

echo "Assemble the module show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm 

echo "Assemble the module normalize.asm"
nasm -f elf64 -l normalize.lis -o normalize.o normalize.asm 

echo "Link the five object files already created"
g++ -m64 -no-pie -o random.out main.o executive.o fill_random_array.o show_array.o quick_sort.o normalize.o -std=c2x 

echo "Run the program Random Products Program"
./random.out

echo "The bash script file is now closing."

rm *.o
rm *.lis
rm *.out