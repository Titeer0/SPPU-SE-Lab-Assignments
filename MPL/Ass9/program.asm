section .data

  array db 10h,20h,30h,40h,50h
  msg1: db 'Before overlapped :',0xa
len1: equ $-msg1

  msg2: db 'After overlapped(using string instruction) :',0xa
  len2: equ $-msg2

        msg3: db ' ',0xa
  len3: equ $-msg3
     
        msg4: db ' : '
len4: equ $-msg4
       
     
        count db 0
        count1 db 0
        count2 db 0
        count3 db 0
        count4  db 0
        count5  db 0
 section .bss
  addr resb 16
        num1 resb 2
       

%macro print 2
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro


 section .text
 global _start


 _start:
  ;***** print address and acutal number from array ******
  ;print msg    
  print msg1,len1

  xor rsi,rsi ;clear rsi pointer

  mov rsi,array ;point rsi to array
  mov byte[count],05 ;set counter as 5

     up:mov rbx,rsi ;move contern of rsi to rbx
  push rsi ;stored rsi address to stack
        mov rdi,addr ;point rdi to addr buffer
  call HtoA1 ;print address(16 digit)
  pop rsi


  mov dl,[rsi] ;print number (2 digit)
  push rsi
        mov rdi,num1
call HtoA2
  pop rsi

inc rsi

dec byte[count]
jnz up

 ;*****moving array element to to after 10 position******    
        mov rsi,array
        mov rdi,array+0Ah
mov byte[count3],05h

 loop10:mov dl,00h
  movsb
        dec byte[count3]
        jnz loop10
  ;****** after 3 position(actual overlapping)*****
        xor rsi,rsi

        mov rsi,array+3h ;overlapping on position 3
        mov rdi,array+0Ah ;to print all content [3(before)+5(after)]=10
  mov byte[count5],05h    ;moving 5 digit

 loop11:mov dl,byte[rdi]
        mov byte[rsi],dl
        inc rsi
        inc rdi
        dec byte[count5]
        jnz loop11

        print msg1,len2


        xor rsi,rsi
        mov rsi,array
        mov byte[count4],08h

   up10:mov rbx,rsi
  push rsi
        mov rdi,addr
  call HtoA1
  pop rsi

mov dl,[rsi]
  push rsi
        mov rdi,num1
  call HtoA2
  pop rsi

inc rsi

dec byte[count4]
  jnz up10
               

        mov rax,60
mov rdi,0
syscall


;***** print procedure for address ******
   HtoA1:mov byte[count1],16
    dup1:rol rbx,4
        mov al,bl
        and al,0fh
    cmp al,09
  ja p3
  add al,30h
  jmp p4
    p3: add al,37h
    p4: mov [rdi],al
        inc rdi
        dec byte[count1]
        jnz dup1

 
print addr,16
print msg4,len4

  ret

;***** print procedure for data ******
   HtoA2: mov byte[count2],02
   dup2: rol dl,04
mov al,dl
and al,0fh
cmp al,09h
jg p31
add al,30h
jmp p41

   p31:  add al,37h
   p41:  mov [rdi],al
   
        inc rdi
        dec byte[count2]
        jnz dup2
       
        print num1,02
        print msg3,len3

        ret

