# binary search an array of signed 32-bit integers
#
# arguments:
#
#   a0: starting address of the array
#   a1: number of integers in the array
#   a2: target of the search
#
# returns:
#
#   a0: index of the target (or -1)
.globl search
search:
        # place your code here
	addi a3, x0, 0		# l = 0
	addi a4, a1, -1		# r = n - 1
	
loop1:
	
	add t1, a3, a4		# m index = l + r
	srai t0, t1, 1		# m index = (l + r) / 2
	
	slli t2, t0, 2		# t2 = m * 4
	add t2, t2, a0		# t2 = pointer to mid element
	lw t3, 0(t2)		# t3 = m = value of mid element
	
	beq t3, a2, done	# if m = target, exit
	bge a3,  a4, exit	# if l >= r, exit
	
	bge t3, a2, more	# check m > target
	blt t3, a2, less	# check m < target
	
less:
	addi a3, t0, 1		#l = m + 1
	jal x0, loop1
	
more:
	addi a4, t0, -1		#r = m - 1
	jal x0, loop1	
	
done:
	mv a0, t0		#load target index to a0
	ret
	
exit:
	li a0, -1		# target not found, return -1
	
        ret # do not remove this line
