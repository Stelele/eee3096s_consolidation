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

    @calculate average of samp
    mov     r1, #0          @ r1 = 0, counter variable
    mov     r2, #0          @ r2 = 0, accumulator to store sum

    fLoop:
        cmp     r1, #256    @ check if r1 == 256
        beq     endFLoop    @ go to 

        ldr     r3, [r0, r1]    @ r3 = samp[r1] get byte at r0 offset by r1

        cmp     r3, #0      @ check if value is negative or positive
        blt     negativeNum @ go to negativeNum

            add     r2, r2, r3  @ r2 = r2 + r3
            b       continue    @ go to continue          

        negativeNum:
            

        continue:

        add     r2, r2, r3  @ r2 += r3

        add     r1, r1, 1   @ r1 += 1
        b       fLoop       @ go to fLoop    

    endFLoop:


    @ function epilogue
    ret_out:
    ldrb         r1, [r0,252]
    mov         r0, r1              @ return out pointer
    ldmea       fp, {fp, sp, pc}    @ do return call
    bx          lr                  @ return to calling function
