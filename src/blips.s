.arch armv6                 @ indicate architecture type
.file "blips.h"             @ filename of the module being used
.text                       @ tell assembl we are now in text(code) segment
.align 2                    @ align to 16-bit addresses
.global blips               @ tell assembly to put this in global symbol table
.syntax unified             @ use the unified ARM/Thumb assembly syntax
.arm                        @ ARM (AArch32 default) instructions being used
.type blips, %function      @ make the symbol entry a function type

@ start of the blips implementation
blips:

    @function prologue
    mov     ip, sp          @ ip = sp
    stmfd   sp!, {fp, ip, lr, pc}    @ store calling function information
    sub     fp, ip, #4      @ fp = ip - 4 
 
    @ assume we are using a store before call calling convention
    @ r0 = signed char* samp

    @ calculate average of samp
    mov     r1, #0          @ r1 = 0, counter variable
    mov     r2, #0          @ r2 = 0, accumulator to store sum

    @ first get sum of all the absolute value of all values in samp_1
    fLoop:
        cmp     r1, #256    @ r1 -= 256
        beq     endFLoop    @ if r1 == 256 go to endFLoop 

        ldrsb     r3, [r0, r1]    @ r3 = samp[r1] get byte at r0 offset by r1

        cmp     r3, #0          @ r3 -= 0
        blt     negativeNum     @ if r3 < 0 go to neativeNum

            b       continue    @ go to continue          

        negativeNum:
            rsb     r3, r3, #0  @ r3 = 0 - r3 

        continue:

        add     r2, r2, r3      @ r2 += r3

        add     r1, r1, #1      @ r1 += 1
        b       fLoop           @ go to fLoop    

    endFLoop:

    @ calculate average
    mov     r2, r2, lsr 8   @ r2 = r2/256

    @ calculate threshold
    mov     r3, #3          @ r3 = 3
    mul     r3, r3, r2      @ r3 *= r2 threshold value
    
    @ calculate blip threshold
  
    @ count number of positive blips
    mov     r1, #0          @ r1 = 0, counter variable
    mov     r4, #0          @ r4 = 0, accumulator storing number of positive numbers
    mov     r6, #0          @ r6 = 0, hold variable 
    fLoop2:
        cmp     r1, #255        @ r1 -= 256
        bgt     endFloop2       @ if r1 > 255 go to endFloop2

        cmp     r6, #0          @ r6 -= 0
        beq     noHold          @ if r6 == 0 go to noHold

            sub     r6, r6, #1      @ r6 -= 1
            b       continue2       @ go to continue2

        @ if r6 == 0 do these operations
        noHold:
            ldrsb   r5, [r0, r1]    @ r5 = samp[r1]

            cmp     r5, r3          @ r5 -= r3
            blt     continue2       @ if r5 < r3 go to continue2

                add     r4, r4, 1   @ r4 += 1
                mov     r6, #2      @ r6 = 2

            continue2:
            add     r1, r1, #1      @ r1 += 1
            b       fLoop2          @ go to fLoop2

    endFloop2:

    @ function epilogue
    ret_out:
    mov         r0, r4              @ return out pointer
    ldmea       fp, {fp, sp, pc}    @ do return call
    bx          lr                  @ return to calling function
