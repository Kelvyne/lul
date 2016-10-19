SRC = src/entry.s
BOOT_OUTPUT = bin/bootsector.bin

all:
	mkdir -p $(shell dirname $(BOOT_OUTPUT))
	nasm -f bin $(SRC) -o $(BOOT_OUTPUT)

clean:
	rm -f $(BOOT_OUTPUT)

fclean: clean

.PHONY: all clean fclean
