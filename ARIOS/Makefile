#MAKEFILE
#
#
#
#
#

#Parameters
objects = obj/boot.o obj/multiboot_header.o obj/long_mode_start.o
rust = target/x86_64-unknown-linux-gnu/debug/libarios.a

obj/%.o: src/%.asm
	mkdir -p $(@D)
	nasm -f elf64 -o $@ $<

kernel.bin: src/linker.ld $(objects) cargo $(rust)
	ld -n --gc-sections -T $< -o $@ $(objects) $(rust)

arios-x86_64.iso: kernel.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	cp $< iso/boot/
	cp src/grub.cfg iso/boot/grub/
	grub2-mkrescue -o $@ iso

clean:
	rm -rf iso $(objects) kernel.bin obj *.lock target

cargo:
	cargo build --target=x86_64-unknown-linux-gnu

virtualbox: arios-x86_64.iso clean
	(killall VirtualBox && sleep 1) || true
	VirtualBox --startvm "REDOX" &

run: arios-x86_64.iso clean
	killall qemu-system-x86_64 && sleep 1 || true
	qemu-system-x86_64 -cdrom arios-x86_64.iso
