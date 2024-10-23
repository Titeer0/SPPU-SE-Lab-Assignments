section .data
global msg6,len6,scount,ncount,occurance,new,new_len
fname db "abc.txt",0
msg db "File opened successfully"
len equ $-msg
msg1 db "File closed successfully"
len1 equ $-msg1
msg2 db "Error in opening file"
len2 equ $-msg2
msg3 db "Spaces: "
len3 equ $-msg3
msg4 db "NewLines: "
len4 equ $-msg4
msg5 db "Enter character: "
len5 equ $-msg5
msg6 db "No of occurences: "
len6 equ $-msg6
new db ""
new_len equ $-new
scount db 0
ncount db 0
ccount db 0
chacount db 0
section .bss
global cnt,cnt2,cnt3,buffer
fd resb 17
buffer resb 200
buffer_len resb 17
cnt resb 2
cnt2 resb 2
cnt3 resb 2
occr resb 2

%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .txt
global _start
_start:
extern spaces,enters,occ
mov rax,2
mov rdi,fname
mov rsi,2
mov rdx,0777
syscall

mov qword[fd],rax
bt rax,63
jc next
scall 1,1,msg,len
jmp next2
next:
scall 1,1,msg2,len2
jmp exit
next2:
scall 0,[fd],buffer,200
mov qword[buffer_len],rax
mov qword[cnt],rax
mov qword[cnt2],rax
mov qword[cnt3],rax
scall 1,1,msg3,len3
call spaces
scall 1,1,msg4,len4
call enters
scall 1,1,msg5,len5
scall 0,1,occr,2
mov bl,byte[occr]
call occ
scall 1,1,msg1,len1
mov rax,3
mov rdi,fname
syscall

exit:
mov rax,60
mov rdi,0
syscall


