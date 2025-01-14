section .data
nline db 10,10
nline_len equ $-nline

menu db 10,"-------------MENU-------------------"
db 10,"1. HEX to BCD"
db 10,"2. BCD to HEX"
db 10,"3. EXIT"
db 10
db 10,"Enter your choice: "
menu_len equ $-menu

h2bmsg db 10,"HEX to BCD: "
db 10,"Enter 4 digit HEX number: "
h2bmsg_len equ $-h2bmsg

b2hmsg db 10,"BCD to HEX: "
db 10,"Enter 5 digit BCD number: "
b2hmsg_len equ $-b2hmsg

hmsg db 10,13,"Equivalent HEX number is: "
hmsg_len equ $-hmsg

bmsg db 10,13,"Equivalent BCD number is: "
bmsg_len equ $-bmsg

emsg db 10,"You entered invalid number ",10
emsg_len equ $-emsg

section .bss
buf resb 6
buf_len equ $-buf

digitcount resb 1

ans resw 1
char_ans resb 4

%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro exit 0
print nline , nline_len
mov rax,60
mov rdi,0
syscall
%endmacro

section .text

global _start
 _start:

print menu,menu_len

read buf,2
mov al,[buf]

c1:
cmp al,"1"
jne c2
call hex_bcd
jmp _start

c2:
cmp al,"2"
jne c3
call bcd_hex
jmp _start

c3:
cmp al,"3"
jne err
exit

err:
print emsg,emsg_len
jmp _start


hex_bcd:
print h2bmsg,h2bmsg_len

call accept_16
mov ax,bx

mov rbx,10

back:
xor rdx,rdx
div rbx
push dx
inc byte[digitcount]
cmp rax,0h
jne back
print bmsg, bmsg_len

print_bcd:
pop dx
add dl,30h
mov [char_ans],dl

print char_ans,1

dec byte[digitcount]
jnz print_bcd

ret

bcd_hex:
print b2hmsg,b2hmsg_len
read buf,buf_len

mov rsi,buf
xor rax,rax
mov rbx,10
mov rcx,05

back1:
xor rdx,rdx
mul rbx
xor rdx,rdx
mov dl,[rsi]
sub dl,30h
add rax,rbx
inc rsi
dec rcx
jnz back1

mov [ans],ax
print hmsg,hmsg_len
mov ax,[ans]

call display_16

ret

accept_16:
read buf,5

xor bx,bx
mov rcx,4
mov rsi,buf
next_digit:
shl bx,04
mov al,[rsi]
cmp al,"0"
jb error
cmp al,"9"
jbe sub30

cmp al,"A"
jb error
cmp al,"F"
jbe sub37

cmp al,"a"
jb error
cmp al,"f"
jbe sub57

error:
print emsg,emsg_len
exit

sub57: sub al,20h
sub37: sub al,07h
sub30: sub al,30h

add bx,ax
inc rsi
loop next_digit

ret

display_16:
mov rsi,char_ans+3
mov rcx,4

cnt: mov rdx,0
mov rbx,16
div rbx
cmp dl,09h
jbe add30
add dl,07h

add30:
add dl,30h
mov [rsi],dl
dec rsi
dec rcx
jnz cnt

print char_ans,4

ret
