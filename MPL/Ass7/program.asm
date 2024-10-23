section .data
rm db "Processor is in real mode"
rm_l equ $-rm
pm db "Processor is in protected mode"
pm_l equ $-pm
g db "GDT contents are"
g_l equ $-g
l db "LDT contents are"
l_l equ $-l
t db "Task register contents are"
t_l equ $-t
i db "IDT contents are"
i_l equ $-i
m db "Machine status word"
m_l equ $-m
col db ":"
newline db 10

section .bss
gdt resd 1
resw 1
ldt resw 1
idt resw 1
resw 1
tr resw 1
cr0_data resd 1
dnum_buff resb 04

%macro disp 2
mov rax,01
mov rdi, 01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .text
global _start
_start:

smsw eax
mov[cr0_data],eax
bt eax,0
jc prmode
disp rm,rm_l
jmp next1
prmode:
disp pm,pm_l
disp newline,1

next1 :
sgdt [gdt]
sldt [ldt]
sidt [idt]
str [tr]
disp g,g_l

mov bx,[gdt+4]
call disp_num

mov bx,[gdt+2]
call disp_num

disp col,1
mov bx,[gdt]
call disp_num
disp newline,1

disp l,l_l
mov bx,[ldt]
call disp_num
disp newline,1

disp i,i_l
mov bx,[idt+1]
call disp_num

mov bx,[idt+2]
call disp_num

disp col,1
mov bx,[idt]
call disp_num
disp newline,1

disp t,t_l
mov bx,[tr]
call disp_num
disp newline,1

disp m,m_l
mov bx,[cr0_data + 2]
call disp_num

mov bx,[cr0_data]
call disp_num
disp newline,1

exit:
mov rax,60
mov rdi,0
syscall

disp_num:
mov esi, dnum_buff
mov ecx,4

up1:
rol bx,4
mov dl,bl
and dl,0fh
add dl,30h
cmp dl,39h
jbe skip1
add dl,07h

skip1:
mov [esi],dl
inc esi
loop up1

disp dnum_buff,4
ret
