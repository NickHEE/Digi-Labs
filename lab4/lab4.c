// lab4.c - initialize SSD1331 and fill framebuffer with an image
// Ed.Casas 2017-1-31

// add missing code indicated by ...

#include "image.h"		/* image to write to display */

#define INITDATA_SIZE 38

int initdata[INITDATA_SIZE] = { 0xAE, 0x81, 0xFF, 0x82, 0xFF, 0x83, 0xFF,
		     0x87, 0x06, 0x8A, 0x64, 0x8B, 0x78, 0x8C,
		     0x64, 0xA0, 0x73, 0xA1, 0x00, 0xA2, 0x00,
		     0xA4, 0xA8, 0x3F, 0xAD, 0x8E, 0xB0, 0x00,
		     0xB1, 0x31, 0xB3, 0xF0, 0xBB, 0x3A, 0xBE,
		     0x3E, 0x2E, 0xAF } ;

#if 0

#include "system.h"		/* peripheral base addresses */
#define SPIWRITE(x) (*(int*)SPIMASTER_0_BASE) = (x)
#define SPIREAD (*(int*)SPIMASTER_0_BASE)
#define LEDSET(x) (*(int*)PIO_BASE) = (x)

#else

int nv ;
#include <stdio.h>
#define SPIWRITE(x) (printf("%03x%s",x,++nv%16?" ":"\n"))
#define SPIREAD  1
#define LEDSET(x) 

#endif

int main()
{ 
   // controller initialization

   int i, j ;

   for ( i=0 ; i<INITDATA_SIZE ; i++ ) {
      SPIWRITE( ... ) ;
      while ( ( SPIREAD & 1 ) == 0 );
   }

   // fill framebuffer

   for ( j=0 ; j<... ; j++ )
      for ( i=0 ; i<... ; i++ )
      {
	 SPIWRITE( ... image[i][j] ... )  ; /* MS byte */
	 while ( ( SPIREAD & 1 ) == 0 );
	 SPIWRITE( ... ) ;	/* LS byte */
	 while ( ( SPIREAD & 1 ) == 0 );

      }

   return 0;
}
