### Dependencies

You will need to install make, qemu and nasm.

### Run

The command `make run` will build and run the project on qemu

### Debug

The command `make debug` will build and run the project on qemu with debug
flags. You will then be able to open gdb and use `target remote localhost:1234`
which will connect to qemu.

### Build

The command `make` will build the project.
