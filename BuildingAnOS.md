#OPERATING SYSTEM

&nbsp;

##Intro

&nbsp;

###Booting explained

&nbsp;

```
._____________.                      ._______________.
|             |                      |               |
| MAIN BOARD  |                      | HARD DRIVE    |
|             |----------------------|               |_________
| - BIOS      |                      | - Partitions  |         \
|             |                      | (GRUB, files) |          \
|_____________|                      |_______________|           \
       |       \                                                  \
       |        \                                                  \
       |         \                                                  \
       |          \                   ._______________________.      |
       |           \                  |                       |      |
       |            \_________________|       CPU             |      |
       |                              |                       |      |
       |                              | - Registers           |      |
       |                              | (AX, CX)              |      |
       |                              | (stack pointer,       |      |
       |                              | instruction pointer)  |      |
       |                              |_______________________|      |
       |                                 /                          /
       |                                /                          /
.__________________________________________________.              /
|                                                  |             /
|                     RAM                          |            /
|                                                  |           /
| 1. Firmware from main board is copied to ram     |          /
| 2. Instruction pointer from CPU copied to ram    |         /
| 3. CPU reads instructions and executes firmware  |        /
| 4. Firmware asks the cpu to talk to the HD       |_______/
| 5. CPU loads the HD (bootloader part) into ram   |
| 6. Thanks the bootloader CPU can look into       |
|    other partitions from the hard drive          |
|    and will read /boot/grub/grub.cfg             |
| 7. Then it will load the kernel for the proper   |
|    operating system chosen from GRUB, kernel is  |
|    loaded from /boot/kernel(binary)              |
| 8. Now the operating system will boot            |
|                                                  |
|           RAM WILL BE LOADED WITH:               |
|           Firmware - GRUB - Kernel               |
|__________________________________________________|

```

NOTE: GRUB is here the main bootloader, but for making your own OS it is common to write your own bootloader.

&nbsp;

####Instruction pointer

&nbsp;

TODO

&nbsp;

####Stack pointer

&nbsp;

TODO

&nbsp;

###Building OS

&nbsp;

When programming in C++, C++ expects the **stack pointer** to be set but the **bootloader** will not set the register as a stack pointer. To make this happen we need to make the linking. This
procedure exists out of 2 parts: **assembly code** and the **kernel**.

Software needed:

- GNU G++ (compiler)
- GNU Binutils (assembler and linker)
- libc6-dev-i386

```

.__________________.                      .________________.
|                  |                      |                |
| ASSEMBLY LOADER  |                      | KERNEL(cpp)    |
|                  | -------------------> |                |
| - Sets stack ptr |                      |                |
| - then jump to   |                      |                |
|   the kernel     |                      |________________|
|__________________|                               |
         |                                         |                                                     
         |                                         |
         |                                         |
  compiled with GNU 'as'                    compiled with g++
         |                                         |                            
         |                                         |
         |                                         |
      loader.o                                  kernel.o
          \                                       /
           \                                     /
            \-> link them together using 'ld' <-/
                            |
                            |
                            |
                        kernel.bin

```

&nbsp;

####Show a UI

&nbsp;

Normally to print to the screen you should just use the c++ method **printf()**, but actually printf relies on **glibc** and there is no glibc when there is not yet an OS. So we need to write our "own" printf().

There is a specific RAM location **0xb8000** that will output everything that is in this location to the screen, thanks to the **graphics card**. The **color bytes** are there for foreground and background color. You just need to make sure you don't overwrite these bytes.

```

RAM:

0xb8000
._______._______._______._______._______._______.
|       |       |       |       |       |       |
| color |   a   | color |   b   |       |       |
| bytes |       | bytes |       |       |       |
|_______|_______|_______|_______|_______|_______|       
                   |
                   |
                   |
                   |
            .______|______.
            |             |
            |   SCREEN    |
            |             |
            | ab          |
            |             |
            |_____________|

```

&nbsp;

##Communicate with hardware

&nbsp;

To communicate with hardware everything needs to be byte-perfect.

TODO

```



```

&nbsp;
