/* Linker script to configure memory regions. */
/*MEMORY
{
  FLASH (rx) : ORIGIN = 0x0 + 88K, LENGTH = 256K - 88K
  RAM (rwx) : ORIGIN = 0x20000000 + 8K, LENGTH = 16K - 8K
}*/

/*
XC
SEARCH_DIR(.)
GROUP(-lgcc -lc -lnosys)

MEMORY
{
  FLASH (rx) : ORIGIN = 0x00018000, LENGTH = 0x2B000
  RAM (rwx) :  ORIGIN = 0x20002000, LENGTH = 0x6000
}

INCLUDE "gcc_nrf51_common.ld"
*/



/* xa */
SEARCH_DIR(.)
GROUP(-lgcc -lc -lnosys)

MEMORY
{
  FLASH (rx) : ORIGIN = 0x00018000, LENGTH = 0x2B000
  RAM (rwx) :  ORIGIN = 0x20002000, LENGTH = 0x2000
}


INCLUDE "gcc_nrf51_common.ld"
