//KERNEL
//
//
//
//
#include "types.h"
#include "GDT.h"

//Writing our own printf to make a pointer to the memory location: 0xb8000
void printf(char* str){

  static unsigned short* VideoMemory = (uint16_t*)0xb8000; //video memory is 80 by 25 (screen)

  static uint8_t x =0 , y=0; //cursor

  for (int i=0; str[i] != '\0'; i++){

    switch (str[i]) {

      case '\n':
        y++;
        x=0;
        break;

      case 'T':
        y++;
        x=0;
        printf("NOT IMPLEMENTED YET");
        break;

      default:
        VideoMemory[80*y+x] = (VideoMemory[80*y+x] & 0xFF00) | str[i];
        x++;
    }

    if (x >= 80){ //max width
      y++;
      x=0;
    }

    if (y >= 25){ //max length
      for(y=0; y<25; y++){
        for (x = 0; x < 80; x++) {
          VideoMemory[80*y+x] = (VideoMemory[80*y+x] & 0xFF00) | ' ';
        }
      }

      x=0;
      y=0;
    }
  }
}

typedef void (*constructor)();

extern "C" constructor start_ctors;
extern "C" constructor end_ctors;
extern "C" void callConstructors(){

  for(constructor* i = &start_ctors; i != &end_ctors; i++)
    (*i)();

}

extern "C" void kernelMain(void* multiboot_structure, uint32_t magicnumber){

  printf("1. SEVAHO OS\n");
  printf("2. SEVAHO OS\n");
  printf("3. SEVAHO OS\n");
  printf("4. SEVAHO OS\n");
  printf("5. SEVAHO OS\n");
  printf("T\n");

  GlobalDescriptorTable gdt;

  while(1);

}
