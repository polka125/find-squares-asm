.text
.global findsq
findsq:

# I'm using r12 and r13 as loop counters
	xor	%r12, %r12
	xor	%r13, %r13

		
loop_horizontal:
	push	%rdi
	push	%rsi
	push	%rdx
	
	mov	%rdi, %rsi
	mov	%rdi, %rdx
	dec	%rdx
	mov 	%r12, %rdi
	call a_plus_b_x_c
	mov	%rax, %r9
	mov	%rax, %r10
	

	pop	%rdx
	pop	%rsi
	pop	%rdi

	add	%rsi, %r9
	add	%rdx, %r10

	cmp	$48, (%r9)
	movl	$1, (%r10)
	je 	skip_1
	movl	$0, (%r10)
skip_1:	nop		
	inc	%r12
	cmp 	%r12, %rdi
	jne loop_horizontal

	
	xor	%r12, %r12
	xor	%r13, %r13
	xor	%r9, %r9
	xor	%r10, %r10	
loop_vertical:
	push	%rdi
	push	%rsi
	push	%rdx
	
	mov	%rdi, %rsi
	mov	%r12, %rdx
	mov 	%rdi, %rdi
	dec	%rdi
	call a_plus_b_x_c
	mov	%rax, %r9
	mov	%rax, %r10
	

	pop	%rdx
	pop	%rsi
	pop	%rdi

	add	%rsi, %r9
	add	%rdx, %r10

	cmp	$48, (%r9)
	movl	$1, (%r10)
	je 	skip
	movl	$0, (%r10)
skip:	nop		
	inc	%r12
	cmp 	%r12, %rdi
	jne loop_vertical


	xor	%r12, %r12
	xor	%r13, %r13
	
# dynamic programming 
	cmp	$1, %rdi
	je	findsq_end
 
	dec 	%rdi
	mov	%rdi, %r12
	mov	%rdi, %r13
	dec	%r12
	dec 	%r13
	
loop1:
loop2:
	push	%rdi
	push	%rsi
	push	%rdx
	
	mov 	%rdi, %rsi
	inc	%rsi
	mov	%r13, %rdx
	mov	%r12, %rdi
	
	call	a_plus_b_x_c
	mov	%rax, %r10
	
	pop	%rdx
	pop	%rsi
	pop	%rdi

	mov 	%r10, %r9
	add	%rsi, %r9
	add	%rdx, %r10
	
#main logic of loop here:
logic:
	movl	$0, (%r10)
	cmpl 	$'0', (%r9)
	jne 	loop2_end
	movl	$1, (%r10)

	push	%rdi
	push	%rsi
	push	%rdx
	
	inc	%r12	
	mov 	%rdi, %rsi
	inc	%rsi
	mov	%r13, %rdx
	mov	%r12, %rdi
	dec	%r12

	call	a_plus_b_x_c
	mov	%rax, %r10
	
	pop	%rdx
	pop	%rsi
	pop	%rdi
	add	%rdx, %r10

	push 	%rdi
	push	%rsi
	push	%rdx

	xor	%r14, %r14
	movl	(%r10), %r14d 

	pop	%rdx
	pop	%rsi
	pop	%rdi

	push	%rdi
	push	%rsi
	push	%rdx
	
	inc	%r13	
	mov 	%rdi, %rsi
	inc	%rsi
	mov	%r13, %rdx
	mov	%r12, %rdi
	dec 	%r13

	call	a_plus_b_x_c
	mov	%rax, %r10
	
	pop	%rdx
	pop	%rsi
	pop	%rdi
	add	%rdx, %r10

	push 	%rdi
	push	%rsi
	push	%rdx

	xor	%r15, %r15
	movl	(%r10), %r15d

	pop	%rdx
	pop	%rsi
	pop	%rdi

	push	%rdi
	push	%rsi
	push	%rdx
	
	inc 	%r12
	inc	%r13	
	mov 	%rdi, %rsi
	inc	%rsi
	mov	%r13, %rdx
	mov	%r12, %rdi
	dec	%r13
	dec	%r12

	call	a_plus_b_x_c
	mov	%rax, %r10
	
	pop	%rdx
	pop	%rsi
	pop	%rdi
	add	%rdx, %r10

	push 	%rdi
	push	%rsi
	push	%rdx

	xor	%r8, %r8
	movl	(%r10), %r8d

	pop	%rdx
	pop	%rsi
	pop	%rdi

	push 	%rdi
	push	%rsi
	push	%rdx

	mov	%r14, %rdi
	mov 	%r15, %rsi
	mov	%r8, %rdx
	call 	min3

	pop	%rdx
	pop	%rsi
	pop	%rdi


	push	%rdi
	push	%rsi
	push	%rdx
	push 	%rax	

	mov 	%rdi, %rsi
	inc	%rsi
	mov	%r13, %rdx
	mov	%r12, %rdi
	
	call	a_plus_b_x_c
	mov	%rax, %r10
	
	pop	%rax
	pop	%rdx
	pop	%rsi
	pop	%rdi

	add	%rdx, %r10


	addl	%eax, (%r10)
#	movl 	%eax, (%r10)	

#	ret	
	

loop2_end:	
	dec	%r12
	cmp 	$-1, %r12
	je loop1_end
	jmp loop2
loop1_end:
	mov	%rdi, %r12
	dec	%r12
	dec	%r13
	cmp	$-1, %r13
	je	loop_finish
	jmp	loop1
loop_finish:
	nop

findsq_end:
	ret

# takes rdi rsi rdx as input, calculates 4 * (rdi + rsi * rdx) and stores result in rax
a_plus_b_x_c:
	mov	%rdx, %rax
	mul	%rsi
	add	%rdi, %rax
	mov	$4, %rdx
	mul	%rdx
	ret

	
# calculate min of rdi, rsi, rdx, srotes result in rax 
min3:	
	mov	%rdi, %rax

	cmp	%rax, %rsi
	jg	min3_cont1
	mov 	%rsi, %rax
min3_cont1:

	cmp	%rax, %rdx
	jg	min3_cont2
	mov 	%rdx, %rax
min3_cont2:
	ret
