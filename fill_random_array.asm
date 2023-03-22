;****************************************************************************************************************************
;Program name: "Random Products Program". This program demonstrates generating random float numbers in IEEE and scientific   *
; decimals that are stored in an array to be sorted and normalize.It also uses a random number generator                    *
;to create the values to be stored in the array based on the user input.                                                    *
;Copyright (C) 2023 Samuel Vo.                                                                                              *
;                                                                                                                           *
;This file is part of the software program "Random Products Program".                                                        *
;Random Products Program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public *
;License version 3 as published by the Free Software Foundation.                                                            *
;Pythagoras' Math Lab Program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the *
;implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
;details. A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                   *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Samuel Vo
;  Author email: samvo@csu.fullerton.edu
;  Section: 240-07
;
;Program information
;  Program name: Random Products Program
;  Programming languages: Two modules in C and four modules in X86
;  Date program began: 2023-Mar-03
;  Date of last update: 2023-Mar-12
;  Date comments upgraded: 2023-Mar-12
;  Files in this program: main.c, executive.asm, r.sh, fill_random_array, show_array, quick_sort.c, normalize.asm
;  Status: Finished. Alot of testing for cases where a number is a nan, but it failed to find a case with a nan. 
;  References consulted: Professor Holliday's lecture, Professor Holliday's Examples, Johnson Tong (SI Session)
;  Future upgrade possible: none
;
;Purpose
;  This module's purpose is to randomly fill the array with floating point values in the form of IEEE and Scientific
;  decimals.
;
;This file
;  File name: fill_random_array.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm



global fill_random_array

segment .data

segment .bss

segment .text

fill_random_array:

;========================= Backup GPRs ==================

push rbp                        
mov rbp, rsp
push rdi                                           ;Backup rdi
push rsi                                           ;Backup rsi
push rdx                                           ;Backup rdx
push rcx                                           ;Backup rcx
push r8                                            ;Backup r8
push r9                                            ;Backup r9
push r10                                           ;Backup r10
push r11                                           ;Backup r11
push r12                                           ;Backup r12
push r13                                           ;Backup r13
push r14                                           ;Backup r14
push r15                                           ;Backup r15
push rbx                                           ;Backup rbx
pushf                                              ;Backup rflags

;========= start the program =============

mov r15, rdi            ;r15 is the array
mov r14, rsi            ;r14 is the # of slots in array

mov r13, 0              ;r13 is the index

start_Loop:

cmp r13, r14            ;condition that loops until it reaches the capacity
je finish 

rdrand r12              ;generate qword

;check for isnan
mov rbx, r12    
shr rbx, 52     ;shifts r12 to the right by the size of mantissa


;if r12 equals 7FF (positive nan) or r12 equals FFF (negative nan) then generate a new random qword
cmp rbx, 0x7FF  ;check if positive nan
je start_Loop
cmp rbx, 0xFFF  ;check if negative nan
je start_Loop

mov[r15 + 8*r13], r12   ;store the qword in the array
inc r13                 ;increment r13
jmp start_Loop

finish:

mov rax, r13            ;The number of random elements are returned to executive module

;===== Restore original values to integer registers ===============================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret                        

;========1=========2=========3=========4=========5=========6=========7=========8==




