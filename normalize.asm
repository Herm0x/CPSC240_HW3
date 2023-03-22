;****************************************************************************************************************************
;Program name: "Random Products Program". This program demonstrates generating random float numbers in IEEE and scientific  *
;decimals that are stored in an array to be sorted and normalize.It also uses a random number generator                     *
;to create the values to be stored in the array based on the user input.                                                    *
;Copyright (C) 2023 Samuel Vo.                                                                                              *
;                                                                                                                           *
;This file is part of the software program "Random Products Program".                                                       *
;"Random Products Program" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public *
;License version 3 as published by the Free Software Foundation.                                                            *
;Random Products Program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the    *
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
;  Date program began: 2023-Mar-3
;  Date of last update: 2023-Mar-12
;  Date comments upgraded: 2023-Mar-12
;  Files in this program: main.c, executive.asm, r.sh, fill_random_array, show_array, quick_sort.c, normalize.asm
;  Status: Finished. Alot of testing for cases where a number is a nan, but it failed to find a case with a nan. 
;  References consulted: Professor Holliday's lecture, Professor Holliday's Examples, Johnson Tong (SI Session)
;  Future upgrade possible: none
;
;Purpose
;  This module's purpose is to normalize the array of values and make them fall in between an interval like 1 < num < 2 where num is 
;  all the values in the array. 
;
;This file
;  File name: normalize.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l normalize.lis -o normalize.o normalize.asm



global normalize

segment .data

segment .bss

segment .text

normalize:

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

push qword 0            ;remain on the boundary

mov r15, rdi            ;r15 is the array
mov r14, rsi            ;r14 is the # of slots in array

mov r13, 0              ;r13 is the index

beginLoop:

cmp r13, r14            ;condition when the loop reach the capacity
je done

mov rdx, [r15 + 8 * r13]     ;array is copied to rdx
shl rdx, 12                  ;shift bits to the left by 12 bits in rdx
shr rdx, 12                  ;shift bits to the right by 12 bits in rdx
mov rcx, 1023                ;move the bias number into rcx
shl rcx, 52                  ;shift bits to the left by 52 bits in rcx

or rdx, rcx                 ;Bitwise OR values from rcx and rdx stored into rdx
mov [r15 + 8 * r13], rdx    ;copy the result to the array
inc r13                     ;increment r13
jmp beginLoop

done:

pop rax                 ;reverse the first push qword 

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
