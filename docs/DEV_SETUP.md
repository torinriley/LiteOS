To set up a development environment for this bootloader project on macOS and Windows, and to include all the commands for the build-and-test process, follow this detailed guide.

## Windows

1.	Install Chocolatey (if not already installed):
Open PowerShell (as Administrator) and run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

2.	Install Required Tools:

	•	NASM (assembler for bootloader):

```powershell
choco install nasm
```

•	mkisofs (use the alternative genisoimage for Windows):

 ```powershell
choco install genisoimage
```

•	QEMU (to emulate the ISO):

 ```powershell
choco install qemu
```

## Development Command Sequence
1. Save your bootloader in a file, e.g., src/boot.asm. Here’s a minimal example:

2. Assemble the Code into a Binary

```powershell
nasm -f bin src/boot.asm -o boot.bin
```

3. Create the Bootable ISO

```powershell
genisoimage -o myos.iso -b boot/boot.bin -no-emul-boot -boot-load-size 4 -boot-info-table iso
```

4. Run QEMU to test the bootable ISO:
5. 
```powershell
qemu-system-x86_64 -cdrom myos.iso
```

