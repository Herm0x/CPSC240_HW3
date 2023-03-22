//****************************************************************************************************************************
//Program name: "Random Products Program". This program demonstrates generating random float numbers in IEEE and scientific   *
// decimals that are stored in an array to be sorted and normalize.It also uses a random number generator                    *
//to create the values to be stored in the array based on the user input.                                                    *
//Copyright (C) 2023 Samuel Vo.                                                                                              *
//                                                                                                                           *
//This file is part of the software program "Random Products Program".                                                        *
//Random Products Program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public *
//License version 3 as published by the Free Software Foundation.                                                            *
//Random Products Program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the *
//implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
//details. A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                   *
//****************************************************************************************************************************//
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Samuel Vo
//  Author email: samvo@csu.fullerton.edu
//  Section: 240-07
//
//Program information
//  Program name: Random Products Program
//  Programming languages: Two modules in C and four modules in X86
//  Date program began: 2023-Mar-03
//  Date of last update: 2023-Mar-12
//  Date comments upgraded: 2023-Mar-12
//  Files in this program: main.c, executive.asm, r.sh, fill_random_array, show_array, quick_sort.c, normalize.asm
//  Status: Finished. Alot of testing for cases where a number is a nan, but it failed to find a case with a nan. 
//  References consulted: Professor Holliday's lecture, Professor Holliday's Examples, Johnson Tong (SI Session)
//  Future upgrade possible: none
//
//Purpose
//  This module's purpose is to manage the other modules and call functions to make an array based on user input. It calls 
//  the quick sort module to sort the array, and display it using the show array module, then it normalizes the array of
//  IEEE values and Scientific decimals.
//
//This file
//  File name: main.c
//  Language: C
//  Max page width: 132 columns  [132 column width may not be strictly adhered to.]
//  Compile this file: gcc -c -Wall -no-pie -m64 -std=c2x -o main.o main.c
//  Link this program: g++ -m64 -no-pie -o random.out main.o executive.o fill_random_array.o show_array.o quick_sort.o -std=c2x 




//=================Begin code area ===============================================================================


#include <stdio.h>
#include<stdlib.h>


extern char* findName();


int main()
{
    printf("Welcome to Random Products, LLC" "\n");
    printf("This software is maintained by Samuel Vo");
    printf("\n");

    const char* name = findName();

    printf("Oh, %s. We hope you enjoyed your arrays. Do come again. \n", name);
    printf("A zero will be returned to the operating system. \n");

}