[bits 32]

video_memory equ 0xb8000
white_on_black equ 0x0f

print_string_pm:
  pusha
  mov edx, video_memory

print_string_pm_loop:
  mov al, [ebx]
  mov ah, white_on_black

  cmp al, 0
  je done

  mov [edx],ax

  add ebx, 1
  add ebx, 2

  jmp print_string_pm_loop

done:
  popa
  ret
