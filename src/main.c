#include <stdio.h>
#include "blips.h"

int main(){
    extern signed char samp_1[256]; 
    int numf;
    printf("Welcome to cosmic particle detector ver 0.1\n");
    printf("Testing sample block samp_1\n");

    int sum = 0;
    for(int i = 0; i < 256; i ++){
        if(samp_1[i] < 0)
            sum += -1 * samp_1[i];
        else
            sum += samp_1[i];
    }

    int avg = sum/256;
    int threshold = avg * 3;
    int countedBlips = 0;
    int hold = 0;
    for(int i =0; i < 256; i++){
        if(hold > 0){
            hold -= 1;
            continue;
        }
        if(samp_1[i] > threshold){
            countedBlips++;
            hold = 2;
        }
    }

    printf("value is %d\n", countedBlips);
    numf = blips(samp_1);

    printf("Number blips = %d\n", numf);

    return 0;
}