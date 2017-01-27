void write(unsigned int i, char c, unsigned char fg, unsigned char bg){
  char *fb = (char *) 0x000B8010;
  fb[i] = c;
  fb[i+1] = ((fg & 0x0F) << 4) | (bg & 0x0F);
}

#define GREEN 2
#define GREY  8
int main(){

  write(0,'A',GREEN,GREY);
  return 0;
	
}

