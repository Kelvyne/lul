BOOT_DIR=./boot/

all: boot

boot:
	make -C $(BOOT_DIR)

run: boot
	qemu-system-x86_64 -drive format=raw,file=$(BOOT_DIR)/bin/bootsector.bin

debug: boot
	qemu-system-x86_64 -s -S -drive format=raw,file=$(BOOT_DIR)/bin/bootsector.bin

clean:
	make -C $(BOOT_DIR) clean

fclean: clean
	make -C $(BOOT_DIR) fclean

.PHONY: all boot run debug clean fclean
