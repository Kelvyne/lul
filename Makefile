BOOT_DIR=./boot/

all: boot run

boot:
	make -C $(BOOT_DIR)

run: boot
	qemu-system-x86_64 $(BOOT_DIR)/bin/bootsector.bin

clean:
	make -C $(BOOT_DIR) clean

fclean: clean
	make -C $(BOOT_DIR) fclean

.PHONY: all boot run clean fclean
