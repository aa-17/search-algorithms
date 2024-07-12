# quicksort an array of signed 32-bit integers
#
# arguments:
#
#   a0: starting address of the array
#   a1: start index of the region to be sorted
#   a2: end index of the region to be sorted
#
# returns:
#
#   n/a
.globl sort
sort:
        # place your code here
		addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)	# lo
	sw s1, 8(sp)	# hi
	sw s2, 12(sp)	# hi/pivot index
	
	bge a1, a2, end	# if lo > hi, exit
	
	mv s0, a1          # s0 = lo
    	mv s1, a2          # s1 = hi
							
	jal ra, partition
	
	mv s2, s5	#store s5 into s2, new pivot index
	
	# sort(A, lo, p - 1)
	mv a1, s0	# set lo value
	addi a2, s2, -1	# p - 1, update [hi]
	jal ra, sort
					
	# sort(A, p + 1, hi)
	addi a1, s2, 1	# p + 1, update [lo]
	mv a2, s1	# set hi value
	jal ra, sort
		
end:
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16

        ret # do not remove this line
partition:
        # place your code here
    addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)	# i
	sw s1, 8(sp)	# j
	sw s2, 12(sp)	# pivot index 
	
	addi s0, a1, -1		# i = lo-1
    	#mv s0, a1		# i = lo
	mv s1, a1		# j = lo
	mv s2, a2  		# s2 = hi, j index
	
	slli t0, s2, 2		#pivot t0 = hi * 4
	add t0, t0, a0		#pivot t0 = pointer to A[hi]
	lw s3, 0(t0)		#pivot s3 = load array value A[hi]
	
	slli t0, s1, 2   	# offset of A[j] relative to A[0]
        add t0, a0, t0		# pointer to A[j]address
        lw s4, 0(t0)	 	# s4 = A[j]
	
loop1:
	
	beq s1, s2, done	# if A[j] = A[hi], done, cycled through all 32 arrays
	
        bgt s4, s3, skip	# if A[j] > pivot, jump to skip
        			# else, inc i, check A[i] > A[j]
        
        			
        addi s0, s0, 1		# i = i+1
        
        slli t0, s0, 2   	# offset of A[i] relative to A[0]
        add t0, a0, t0		# pointer to A[i]address
        lw s5, 0(t0)	 	# s5 = A[i]
        
        bge s4, s5, skip	#if A[j] >= A[i], dont swap
        						
jumpswap1:
	jal ra, swap1
                
skip:
        addi s1, s1, 1		# j = j+1
        
        slli t0, s1, 2   	# t0 = s1 (A[j] * 4
        add t0, a0, t0		# pointer to A[j]address
        lw s4, 0(t0)	 	# s4 = A[j]
	
	jal x0, loop1
        
done:
	# swap A[i+1] with A[hi] 
	addi s0, s0, 1		# i = i+1
        
        slli t0, s0, 2   	# t0 = s0 (A[i]) * 4
        add t0, a0, t0		# pointer to A[i]address
        lw s5, 0(t0)	 	# s5 = A[i]
	
	jal swap1
	
	mv s5, s0	#store  new pivot index to s5
	
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16

        ret # do not remove this line

	swap1:
	slli t0, s0, 2	#t0 = s0 * 4, s0: i 
	add t0, a0, t0	#t0 = address of i
	slli t1, s1, 2	#t1 = s1 * 4, s1: j
	add t1, a0, t1	#t1 = address of j
		
	#swap A[i] with A[j]/A[hi]
	lw t2, 0(t0)	#load t2 = i address
	lw t3, 0(t1)	#load t3 = j address
	sw t2, 0(t1)	#store i at j address
	sw t3, 0(t0)	#store j at i address

	ret