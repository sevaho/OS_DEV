.set MAGIC, 0x1badb002 ; #This magic number is needed otherwise the bootloader
.set FLAGS, (1<<0 | 1<<1) ; #won't recognize the kernel as a kernel
.set CHECKSUM, -(MAGIC + FLAGS) ; #Magic number will be set to the bx register

.section .multiboot
  .long MAGIC
  .long FLAGS
  .long CHECKSUM

.section .text
.extern kernelMain ; #Tells the assembler that there will be a kernel thanks to the linker
.extern callConstructors
.global loader

loader:
  mov $kernel_stack, %esp ; #Sets stack pointer

  call callConstructors
  
  push %eax
  push %ebx ; #Used for the magic number
  call kernelMain

_stop: ; #infinte loop
  cli
  hlt
  jmp   _stop


.section .bss
.space 2*1024*1024 ; #2MiB, this is used as buffer between stackpointer and the already loaded things in the RAM
kernel_stack:
