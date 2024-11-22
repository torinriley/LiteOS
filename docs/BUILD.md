# Build and Compile Instructions for the Kernel Project

## Prerequisites
Ensure the following tools are installed on your system:

- **Cross Compiler**: `i386-elf-gcc` and `i386-elf-ld`
- **QEMU Emulator**: `qemu-system-i386`
- **Utilities**: `as`, `objcopy`, and `hexdump`

For macOS, you can use `brew` to install these tools:
```bash
brew install i386-elf-gcc qemu
```

For Linux (Debian/Ubuntu):
```bash
sudo apt update
sudo apt install gcc-i386 qemu-system
```

For Windows, install QEMU and GCC cross-compilers from official sources.

---

## Project Structure

```
src/         # Source files
  kernel.c   # Main kernel code
  linker.ld  # Linker script
  boot.asm   # (Optional) Bootloader code
build/       # Build output directory
```

---

## Build Instructions

### 1. Compile the Kernel Source File
Compile the C file into an object file:
```bash
i386-elf-gcc -ffreestanding -m32 -c src/kernel.c -o build/kernel.o
```

### 2. (Optional) Assemble Multiboot Header
If using a Multiboot header:
```bash
i386-elf-as src/multiboot_header.S -o build/multiboot_header.o
```

### 3. Link the Kernel
#### a) To Build a Flat Binary:
Use the linker script to link the kernel and output a raw binary:
```bash
i386-elf-ld -T src/linker.ld -o build/kernel.bin build/kernel.o --oformat binary
```

#### b) To Build an ELF Executable:
Link the kernel and Multiboot header into an ELF file:
```bash
i386-elf-ld -T src/linker.ld -o build/kernel.elf build/multiboot_header.o build/kernel.o
```

### 4. Run the Kernel
#### a) Test the Flat Binary:
Run the raw binary directly in QEMU:
```bash
qemu-system-i386 -kernel build/kernel.bin
```

#### b) Test the ELF File:
Run the ELF file in QEMU:
```bash
qemu-system-i386 -kernel build/kernel.elf
```

---

## Debugging Tips

### Inspect the Binary
Check the contents of the kernel binary:
```bash
hexdump -C build/kernel.bin | head -n 20
```

### Debug with QEMU
Run QEMU with debug flags to inspect execution:
```bash
qemu-system-i386 -kernel build/kernel.bin -d int -no-reboot -S
```

### Debug with GDB
1. Start QEMU in debug mode:
   ```bash
   qemu-system-i386 -kernel build/kernel.elf -S -s
   ```
2. Connect GDB:
   ```bash
   i386-elf-gdb build/kernel.elf
   target remote :1234
   continue
   ```

---

## Example Output
- For a kernel writing to VGA text buffer:
  - Display: `H` at the top-left corner of the screen.
- For UART-based debugging (if implemented):
  - Output: `Hello, Kernel!` in the terminal.

---

## Expected File Outputs
- `build/kernel.o`: Compiled object file.
- `build/kernel.bin`: Flat binary file.
- `build/kernel.elf`: ELF executable.

Follow the steps above to build, debug, and run your kernel project successfully. Let me know if additional steps or debugging tools are needed!

