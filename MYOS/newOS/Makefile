#MAKEFILE
#
#
#
#
#

#Parameters
GCCPARAMS =  -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
NASMPARAMS = -f elf32
LDPARAMS = -melf_i386

objects = obj/loader.o \
					obj/kmain.o

all:

obj/%.o: src/%.s
	mkdir -p $(@D)
	#nasm $(NASMPARAMS) $< -o $@
	as --32 -o $@ $<

obj/%.o: src/%.c
	gcc $(GCCPARAMS) $< -o $@

kernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

kernel.iso: kernel.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	cp $< iso/boot/
	echo 'set timeout=0' >> iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo '' >> iso/boot/grub/grub.cfg
	echo 'menuentry "MY OS" {' >> iso/boot/grub/grub.cfg
	echo '  multiboot /boot/kernel.bin' >> iso/boot/grub/grub.cfg
	echo '  boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	grub2-mkrescue --output=$@ iso

run: kernel.iso clean	
	qemu-system-i386 -cdrom kernel.iso

clean:
	rm -rf iso $(objects) kernel.bin obj



