#MAKEFILE
#
#
#
#
#

#Parameters

objects = #kernel.o

.PHONY: all
all: run

kernel.o: kernel.c 
	gcc -ffreestanding -c $< -o $@ -m32

troubleshoot: kernel.o
	objdump -M intel -d $<

bootsector.bin: bootsector.nasm
	nasm -o $@ $<

run: bootsector.bin 
	qemu-system-i386 $<
	
clean: 	
	rm -rf $(objects) bootsector.bin
	

