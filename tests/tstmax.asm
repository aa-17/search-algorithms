# tstmax.asm - RARS test harness for max.asm

.globl  main

.macro exit
        li    a7,10
        ecall
.end_macro

.data
.include "random.data"          # defines data and n

.text
main:
        la    a0, data          # address of the data vector
        lw    a1, n             # number of elements in the data vector
        #jal   ra, max           # call max()
        #exit                    # exit
        
        jal   ra, max           # call max()
        exit                    # exit
        
max:
	mv s1, a0		#set first array element address to s1
	lw s2, (s1)		#load array value
	addi  s0, zero, 1	#counter +1
	mv t0, s2
	
loop:
	blt s2, t0, skip	#check s2 < t0 (highest value found)
	mv t0, s2		#save currrent max value in t0
	addi a0, s0, -1		#save index of s2, max val, into a0 from s0
	
skip:
	beq s0, a1, done	#if counter = 32, finish
	addi  s1, s1, 4		#increment to address of next array element
	lw s2, (s1)		#load array value
	addi  s0, s0, 1		#counter +1
	jal x0, loop
	
done:
	ret
