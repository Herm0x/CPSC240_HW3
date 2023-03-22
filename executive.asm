;****************************************************************************************************************************
;Program name:"Random Products Program". This program demonstrates generating random float numbers in IEEE and scientific   *
; decimals that are stored in an array to be sorted and normalize.It also uses a random number generator                    *
;to create the values to be stored in the array based on the user input.                                                    *
;Copyright (C) 2023 Samuel Vo.                                                                                              *
;                                                                                                                           *
;This file is part of the software program "Random Products Program".                                                        *
;Random Products Program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public *
;License version 3 as published by the Free Software Foundation.                                                            *
;Random Products Program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the *
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
;  This module's purpose is to manage the other modules and call functions to make an array based on user input. It calls 
;  the quick sort module to sort the array, and display it using the show array module, then it normalizes the array of
;  IEEE values and Scientific decimals.
;
;This file
;  File name: executive.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l executive.lis -o executive.o executive.asm

extern normalize
extern scanf
extern printf
extern show_array
extern fill_random_array
extern stdin
extern strlen
extern fgets
extern qsort
extern compare

input_length equ 256 ;Max bytes of full name, and title

global findName

segment .data

	enterName db "Please Enter your name: ", 0
    enterTitle db "Please enter your title(Mr, Ms, Sargent, Chief, Project Leader, etc): ", 0
    intro_NameTitle db "Nice to meet you ", 0
    space db " ", 0
    newLine db " ", 10, 0


    prog_descrip db "This program will generate 64-bit IEEE float numbers. ", 10, 0
    number_array_prompt db "How many numbers do you want. Today's limit is 100 per customer. ", 0

    storage_msg db "Your numbers have been stored in an array. Here is that array.", 10, 0

    arr_size db "%d", 0


    sort_msg db "The array is now being sorted. ", 10, 0

    update_msg db "Here is the updated array. ", 10, 0


	exitMsg1 db "Good bye ", 0
    exitMsg2 db ". You are welcome any time.", 10, 0

    invalidInput db "That input was invalid! Please try again. ", 10, 0

    normalize_msg db "The random numbers will be normalized. Here is the normalized array ", 10, 0

    sortNorm_msg db "The normalized numbers will be sorted. Here is the sorted normalized array ", 10, 0

	string_format db "%s", 10, 0

segment .bss
	Arr1 resq 100
	fullName resb input_length
    title resb input_length


segment .text
findName:
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

push qword 0   ;Check on the boundary

;Message that displays to prompt user to input name
push qword 0       
mov rax, 0
mov rdi, enterName  ;"Please Enter your name: ", 0
call printf
pop rax

;User inputs their name
push qword 0
mov rax, 0 
mov rdi, fullName           ;move fullName into argument register rdi
mov rsi, input_length       ;provide fgets with second argument, the size of the bytes reserved
mov rdx, [stdin]            ;move the contents at address stdin into 3rd register 
call fgets
pop rax

push qword 0
mov rax, 0
mov rdi, fullName               ;Move fullName into the first argument register
call strlen                     ;Call external function strlen, which returns the length of the string leading up to '\0'
sub rax, 1                      ;The length is stored in rax. Here we subtract 1 from rax to obtain the location of '\n'
mov byte [fullName + rax], 0    ; Replace the byte where '\n' exits with '\0'
pop rax

;Message that prompts user to enter title
push qword 0
mov rax, 0
mov rdi, enterTitle     ;"Please enter your title(Mr, Ms, Sargent, Chief, Project Leader, etc): "
call printf
pop rax
    
;User enters their title
push qword 0
mov rax, 0 
mov rdi, title              ;move fullName into argument register rdi
mov rsi, input_length;      provide fgets with second argument, the size of the bytes reserved
mov rdx, [stdin]            ;move the contents at address stdin into 3rd register 
call fgets
pop rax

push qword 0
mov rax, 0
mov rdi, title                  ;Move title into the first argument register
call strlen                     ;Call external function strlen, which returns the length of the string leading up to '\0'
sub rax, 1                      ;The length is stored in rax. Here we subtract 1 from rax to obtain the location of '\n'
mov byte [title + rax], 0       ;Replace the byte where '\n' exits with '\0'
pop rax

;User title and name is shown with a greeting message
push qword 0
mov rax, 0
mov rdi, intro_NameTitle  ;"Nice to meet you "
call printf
pop rax

;title of the user is displayed
push qword 0
mov rax, 0
mov rdi, title   ;Ex: Mr
call printf
pop rax

;empty space in between string is shown
push qword 0
mov rax, 0
mov rdi, space      ;" "
call printf
pop rax

;User's full name is shown here
push qword 0
mov rax, 0 
mov rdi, fullName  ;Ex: John Doe
call printf
pop rax

;A new line is displayed
push qword 0
mov rax, 0
mov rdi, newLine  ;" "
call printf
pop rax

;Message about the program is shown
push qword 0
mov rax, 0
mov rdi, prog_descrip  ;"This program will generate 64-bit IEEE float numbers. "
call printf
pop rax

return:

;A prompt to ask the user to input a size for the array is shown
push qword 0
mov rax, 0
mov rdi, number_array_prompt        ;"How many numbers do you want. Today's limit is 100 per customer. "
call printf
pop rax

;================User Input ================================

;User inputs the size of array
push qword 0
mov rax, 0
mov rdi, arr_size       ;"%d"
mov rsi, rsp            ;user input for the size is copied to rsi
call scanf
mov r15, [rsp]          ;the user input is backed up into r15
pop rax


;====Valid input check===========================
cmp r15, 0       ;condition to check if the input is negative
jl invalid_Input

cmp r15, 100         ;condition to check if the input is negative
jg invalid_Input

jmp continue

invalid_Input:
;Error message showing about user input was invalid
push qword 0
mov rax, 0
mov rdi, invalidInput       ;"That input was invalid! Please try again. "
call printf
pop rax

jmp return

continue:

;Message to let user know their array is created
push qword 0
mov rax, 0
mov rdi, storage_msg        ;"Your numbers have been stored in an array. Here is that array."
call printf
pop rax

;New line is displayed 
push qword 0
mov rax, 0
mov rdi, newLine            ;"  "
call printf
pop rax

;=========== call fill random array========================================
;call the fill_random_array to generate random values for the user
push qword 0
mov rax, 0 
mov rdi, Arr1               ;The array is copied to the first argument register rdi
mov rsi, r15                ;The number of elements in the array is copied to the second argument register rsi
call fill_random_array      
mov r14, rax                ;The number of elements in the fill_random_array is copied to r14
pop rax

;display the array with unorganized values
push qword 0
mov rax, 0
mov rdi, Arr1       ;The array is copied to the first argument register rdi
mov rsi, r14        ;The number of elements is copied to rsi
call show_array
pop rax

;A new line will be shown
push qword 0
mov rax, 0
mov rdi, newLine    ;"  "
call printf
pop rax

;========= Sorting the array ====================================
;sort first array
push qword 0
mov rdi, Arr1
mov rsi, r14
mov rdx, 8         ;8-bytes is reserved for comparisons
mov rcx, compare   ;comparison is made between each element before sorting
call qsort
pop rax

;message it is being sorted
push qword 0
mov rax, 0
mov rdi, sort_msg       ;"The array is now being sorted. "
call printf
pop rax

;A new line will be shown
push qword 0
mov rax, 0
mov rdi, newLine    ;"  "
call printf
pop rax

;message about updated array
push qword 0
mov rax, 0
mov rdi, update_msg     ;"Here is the updated array. "
call printf
pop rax

;A new line will be shown
push qword 0
mov rax, 0
mov rdi, newLine    ;"  "
call printf
pop rax


;New sorted array displayed here
push qword 0
mov rax, 0
mov rdi, Arr1       ;The array is copied to the first argument register rdi
mov rsi, r14        ;The number of elements is copied to rsi
call show_array
pop rax

;A new line will be shown
push qword 0
mov rax, 0
mov rdi, newLine    ;"  "
call printf
pop rax

;=======normalizing the array ============================================

;message about random numbers will be normalized
push qword 0
mov rax, 0
mov rdi, normalize_msg      ;"The random numbers will be normalized. Here is the normalized array "
call printf
pop rax

;A new line will be shown
push qword 0
mov rax, 0
mov rdi, newLine    ;"  "
call printf
pop rax

;normalize the user's sorted array 
push qword 0
mov rax, 0
mov rdi, Arr1       ;Arr1 is the first parameter copied to rdi
mov rsi, r14        ;number of elements in the array is copied to rsi
call normalize
pop rax

;Unsorted array after it has been normalized
push qword 0
mov rax, 0
mov rdi, Arr1          ;Arr1 is the first argument in the argument register rdi
mov rsi, r14           ;number of elements in the array is copied to rsi
call show_array
pop rax

;A new line will be shown
push qword 0
mov rax, 0
mov rdi, newLine    ;"  "
call printf
pop rax

;sort the normalized array
push qword 0
mov rdi, Arr1
mov rsi, r14
mov rdx, 8         ;8-bytes is reserved for comparisons
mov rcx, compare   ;comparison is made between each element before sorting
call qsort
pop rax

;A message about the sorted normalize array is shown
push qword 0
mov rax, 0
mov rdi, sortNorm_msg    ;"The normalized numbers will be sorted. Here is the sorted normalized array "
call printf
pop rax

;A new line will be shown
push qword 0
mov rax, 0
mov rdi, newLine    ;"  "
call printf
pop rax

;Sorted normalized array will be visible
push qword 0
mov rax, 0
mov rdi, Arr1       ;Arr1 is the first argument passed into rdi
mov rsi, r14        ;number of elements in the array is r14 and backed into rsi
call show_array
pop rax

;New line is displayed 
push qword 0
mov rax, 0
mov rdi, newLine        ;" "
call printf
pop rax

;================== Good Bye Message ============================


;Goodbye message is displayed
push qword 0
mov rax, 0
mov rdi, exitMsg1    ;"Good bye ",
call printf
pop rax

;Title is shown in between Good bye message
push qword 0
mov rax, 0
mov rdi, title   ;Ex: Mr
call printf
pop rax

;Part of the exit message is shown
push qword 0
mov rax, 0
mov rdi, exitMsg2  ;". You are welcome any time.", 10, 0
call printf
pop rax

;New line is displayed 
push qword 0
mov rax, 0
mov rdi, newLine   ;" "
call printf
pop rax

;=========================END OF EXECUTIVE MODULE=================================

pop rax         ;Reverse the first push qword at the beginning

mov rax, fullName   ;The full name is returned to the main module


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



