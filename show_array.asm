;****************************************************************************************************************************
;Program name: "Random Products Program". This program demonstrates generating random float numbers in IEEE and scientific   *
; decimals that are stored in an array to be sorted and normalize.It also uses a random number generator                    *
;to create the values to be stored in the array based on the user input.                                                    *
;Copyright (C) 2023 Samuel Vo.                                                                                              *
;                                                                                                                           *
;This file is part of the software program "Random Products Program".                                                        *
;Random Products Program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public *
;License version 3 as published by the Free Software Foundation.                                                            *
;Random Products Program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the      *
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
;  This module's purpose is to display the array that is created from the fill_random_array module. The elements are 
;  iterated and stored in this array to be called in executive module for display.
;
;This file
;  File name: show_array.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm


global show_array

extern printf

segment .data

header_line db "IEEE7554                                  Scientific Decimal", 10, 0
value_format db "0x%016lx                      %18.13e", 10, 0

segment .bss


segment .text



show_array:
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


push qword 0  ;remain on the boundary

mov r15, rdi  ;The array
mov r14, rsi  ;The number of elements in the array

;Shows the format of data in the array
push qword 0
mov rax, 0
mov rdi, header_line ;IEEE754 Scientific Decimal
call printf
pop rax

mov r13, 0      ;The index to count the loop

start_Loop:

cmp r13, r14        ;Condition when it reaches the end of the array
je finish

;The user's randomly generated array is displayed 
push qword 0
mov rax, 1                      ;accessing 1 xmm register
mov rdi, value_format           ;"0x%016lx %18.13e" format for IEEE and Scientific decimal
mov rsi, [r15 + r13* 8]         ;copy the array to rsi register
movsd xmm0, [r15 + r13*8]       ;copy the array to xmm0 register 
call printf
pop rax

inc r13         ;increment the loop in r13
jmp start_Loop     

finish:

pop rax          ;reverse the first push qword of this file

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