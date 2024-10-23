
section .data
    msg db 'Enter a number: ', 0xA  
    msg_len equ $ - msg               

    result_msg db 'Factorial is: ', 0xA  
    result_msg_len equ $ - result_msg     

    newline db 0xA      

section .bss
    num resb 10       
    result resb 20    

section .text
global _start

_start:
    mov rax, 1          
    mov rdi, 1          
    mov rsi, msg        
    mov rdx, msg_len    
    syscall

    mov rax, 0          
    mov rdi, 0          
    mov rsi, num        
    mov rdx, 10         
    syscall

    mov rsi, num        
    call atoi           

    mov rdi, rax        
    call factorial

    mov rax, 1          
    mov rdi, 1          
    mov rsi, result_msg 
    mov rdx, result_msg_len 
    syscall

    mov rax, 1          
    mov rdi, 1          
    mov rsi, result     
    call strlen         
    syscall

    mov rax, 1          
    mov rdi, 1          
    mov rsi, newline    
    mov rdx, 1          
    syscall

    mov rax, 60         
    xor rdi, rdi        
    syscall

factorial:
    mov rax, 1          
    mov rcx, 2          
.loop:
    imul rax, rcx       
    inc rcx             
    cmp rcx, rdi        
    jle .loop           
    mov rsi, result     
    mov rdi, rax        ; Move the result to rdi for itoa
    call itoa           
    ret

atoi:
    xor rax, rax        
    xor rbx, rbx        
.loop:
    movzx rdx, byte [rsi]  
    inc rsi                
    test rdx, rdx          
    jz .done               
    cmp rdx, '0'           
    jb .done               
    cmp rdx, '9'           
    ja .done               
    sub rdx, '0'           
    imul rax, 10           
    add rax, rdx           
    jmp .loop
.done:
    ret

itoa:
    mov rsi, result     ; Move result buffer into RSI for storing characters
    mov rbx, 10         ; Divider for conversion
    xor rcx, rcx        ; Clear RCX to use as counter for digits

convert_loop:
    xor rdx, rdx        ; Clear RDX for DIV operation
    div rbx             ; Divide RAX by 10, quotient in RAX, remainder in RDX
    add dl, '0'         ; Convert remainder to ASCII
    push dx             ; Push remainder to stack to reverse later
    inc rcx             ; Increment digit counter
    test rax, rax       ; Check if quotient is zero
    jnz convert_loop    ; If not, continue loop

; Now pop from stack to reverse string
    mov rdi, rsi        ; Point RDI to start of result buffer
reverse_loop:
    pop dx              ; Pop a character
    mov [rdi], dl       ; Move character to buffer
    inc rdi             ; Move to next position in buffer
    loop reverse_loop   ; Repeat until RCX decrements to zero

    mov byte [rdi], 0   ; Null-terminate the string
    ret


strlen:
    xor rcx, rcx        
.loop:
    cmp byte [rsi + rcx], 0   
    je .done                   
    inc rcx                    
    jmp .loop                  
.done:
    ret
