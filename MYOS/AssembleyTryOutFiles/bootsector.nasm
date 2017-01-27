[org 0x7c00]
;si to print string, dx to print hex

mov bp, 0x9000
mov sp, bp

mov si, MSGREALMODE
call print_string

call switch_to_pm

jmp $
%include "functions.nasm"
%include "diskloader.nasm"
%include "functions32bit.nasm"
%include "gdt.nasm"
%include "switch32bit.nasm"

begin_pm:
  mov ebx, MSGPROTMODE
  call print_string_pm
  jmp $


MSGREALMODE:
  db 'Started in 16 bit mode',0
MSGPROTMODE:
  db 'started in 32 bit mode',0

times 510-($-$$) db 0
dw 0xAA55
