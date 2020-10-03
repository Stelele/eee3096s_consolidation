#include <stdio.h>
#include "blips.h"

int main(){
    extern signed char samp_1[256]; 
    int numf;
    printf("Welcome to cosmic particle detector ver 0.1\n");
    printf("Testing sample block samp_1\n");
    printf("%d\n",samp_1[10]);
    numf = blips(samp_1);

    printf("Number blips = %d\n", numf);

    return 0;
}