section .multiboot_header
header_start: ;label to memory location
  dd 0xe85250d6 ; dd is define double
  dd 0 ; architecture 0, protected mode i386
  dd header_end - header_start ; length CHECKSUM

  dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))
  ; the additional 0x100000000 in the checksum calculation is a small hack1 to avoid a compiler warning

  ;optional multiboot target

  dw 0 ; define word ,type
  dw 0 ; flags
  dw 0 ; size
header_end:
