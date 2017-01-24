#MAKEFILE
#
#
#
#
#

#Parameters

objects = bootloader.bin

.PHONY: all
all: run

bootloader.bin: bootloader.asm
	nasm -o $@ $<

run: bootloader.bin
	qemu-system-i386 $(objects)
	rm -rf $(objects)
	
	

