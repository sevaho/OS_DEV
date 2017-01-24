[org 0x7c00]

mov bp, 0x8000
mov sp, bp


call findString

jmp $

;functions
;functions
;functions
;It is possible to use an include and storea all functions in a seperate file
;%include "pathToFile/functions.nasm"

findString:

  mov bx, 0
  mov es, bx

  sloop:

    mov al, [es:bx]
    cmp al, 'B'
    jne continue

    mov al, [es:bx+1]
    cmp al, 'I'
    jne continue
    
    mov al, [es:bx+2]
    cmp al, 'O'
    jne continue
    
    mov al, [es:bx+3]
    cmp al, 'S'
    jne continue


    mov dx, es
    call printHex

    

    mov dx, bx
    
    call printHex

    jmp $

    continue:
  
    inc bx
    cmp bx, 0 
    je incrementSegment


    jmp sloop
    
    incrementSegment:
      mov cx, es
      add cx, 0x1000
      mov es, cx
      jmp sloop
    
  ret

printString:
  loop:
    mov al, [si]
    cmp al, 0
    je end
    mov ah, 0x0e
    int 0x10
    add si, 1
  jmp loop
  end:
  ret

printChar:
  mov ah, 0x0e
  int 0x10
  ret

printHex:
  push bx
  push si
  mov si, hexTemplate

  mov bx, dx
  shr bx, 12
  mov bx, [bx+hexAbet]
  mov [hexTemplate+2], bl

  mov bx, dx
  shr bx, 8
  and bx, 0x000f
  mov bx, [bx+hexAbet]
  mov [hexTemplate+3], bl

  mov bx, dx
  shr bx, 4
  and bx, 0x000f
  mov bx, [bx+hexAbet]
  mov [hexTemplate+4], bl

  mov bx, dx
  and bx, 0x000f
  mov bx, [bx+hexAbet]
  mov [hexTemplate+5], bl

  call printString

  pop si
  pop bx

  ret

;Data
;Data
;Data

hexTemplate:
  db '0x????',0
hexAbet:
  db '0123456789abcde'

;MAGIC NUMBER
times 510-($-$$) db 0
dw 0xAA55
