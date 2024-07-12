# tstmin.asm - RARS test harness for min.asm

.globl  main
.globl min

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
        
        #li    s0, 0		#set index s0 to 1
        
	
        jal   ra, min           # call min()
        exit                    # exit
        
min:
	mv s1, a0		#set first array element address to s1
	lw s2, (s1)
	addi  s0, zero, 1	#counter +1
	mv t0, s2
	
loop:
	bgt s2, t0, skip	#check s2 < t0 (lowest value found)
	mv t0, s2		#save currrent min value in t0
	addi a0, s0, -1		#save index of min val, into a0 from s0
	
skip:
	beq s0, a1, done	#if counter = 32, finish
	addi  s1, s1, 4		#increment to address of next array element
	lw s2, (s1)
	addi  s0, s0, 1		#counter +1
	jal x0, loop
	
done:
	ret
	
	
	 
