GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o kernel.o

%.o: %.cpp
	g++ $(GPPPARAMS) -o $@ -c $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

soos.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T  $< -o $@ $(objects)

install: soos.bin
	sudo cp $< /boot/soos.bin

iso: soos.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	cp $< iso/boot/
	echo 'set timeout=0' > iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo '\n' >> iso/boot/grub/grub.cfg
	echo '### BEGINE SOOS ###' >> iso/boot/grub/grub.cfg
	echo '\n' >> iso/boot/grub/grub.cfg
	echo 'menuentry 'SOOS' {' >> iso/boot/grub/grub.cfg
	echo 'multiboot /boot/soos.bin' >> iso/boot/grub/grub.cfg
	echo 'boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	echo '\n' >> iso/boot/grub/grub.cfg
	echo '### END SOOS ###' >> iso/boot/grub/grub.cfg
	grub-mkrescue --output soos.iso iso
	rm -rf iso
