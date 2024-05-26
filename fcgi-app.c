#include "fcgi_stdio.h"

#include <stdlib.h>

int count;

void initialize(void)
{
  count=0;
}

int main(void)
{
/* Initialization. */  
  initialize();

/* Response loop. */
  while (FCGI_Accept() >= 0)   {
    printf("Content-type: text/html\r\n"
           "\r\n"
           "<title>Hello World page</title>"
           "<h1>Hello World</h1>");
  }
  return 0;
}