print_string:
  pusha
  loop:
    mov al, [si]
    cmp al, 0
    je end_loop
    mov ah, 0x0e
    int 0x10
    add si,1
  jmp loop
  end_loop:
  popa
  ret

print_hex:
  pusha
  push bx
  push si
  mov si, hex_template

  mov bx, dx
  shr bx, 12
  mov bx, [bx+hexabet]
  mov [hex_template+2],bl

  mov bx, dx
  shr bx, 8
  and bx, 0x000f
  mov bx, [bx+hexabet]
  mov [hex_template+3],bl

  mov bx, dx
  shr bx, 4
  and bx, 0x000f
  mov bx, [bx+hexabet]
  mov [hex_template+4],bl

  mov bx, dx
  and bx, 0x000f
  mov bx, [bx+hexabet]
  mov [hex_template+5],bl

  call print_string

  popa
  ret

hex_template:
  db '0x????',0
hexabet:
  db '0123456789abcde',0
