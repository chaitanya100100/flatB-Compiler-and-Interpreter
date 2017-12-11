	.text
	.file	"ir"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	movl	$100003, MOD(%rip)      # imm = 0x186A3
	movl	$5000000, Q(%rip)       # imm = 0x4C4B40
	movl	$5000000, N(%rip)       # imm = 0x4C4B40
	movl	$37, P(%rip)
	movl	$1, p(%rip)
	movl	$0, i(%rip)
	xorl	%eax, %eax
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_5:                                # %ifnext
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	i(%rip), %eax
	incl	%eax
	movl	%eax, i(%rip)
.LBB0_1:                                # %for_condition
                                        # =>This Inner Loop Header: Depth=1
	cmpl	N(%rip), %eax
	jge	.LBB0_6
# BB#2:                                 # %for_body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	p(%rip), %eax
	imull	P(%rip), %eax
	cltd
	idivl	MOD(%rip)
	movl	%edx, p(%rip)
	cmpl	$0, i(%rip)
	je	.LBB0_4
# BB#3:                                 # %if
                                        #   in Loop: Header=BB0_1 Depth=1
	movslq	i(%rip), %rcx
	leal	-1(%rcx), %eax
	movslq	%eax, %rdx
	movslq	p(%rip), %rax
	imulq	$1374389535, %rax, %rsi # imm = 0x51EB851F
	movq	%rsi, %rdi
	shrq	$63, %rdi
	sarq	$37, %rsi
	addl	%edi, %esi
	imull	$100, %esi, %esi
	subl	%esi, %eax
	addl	arr(,%rdx,4), %eax
	cltd
	idivl	MOD(%rip)
	movl	%edx, arr(,%rcx,4)
	jmp	.LBB0_5
	.align	16, 0x90
.LBB0_4:                                # %else
                                        #   in Loop: Header=BB0_1 Depth=1
	movslq	p(%rip), %rax
	imulq	$1717986919, %rax, %rcx # imm = 0x66666667
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$34, %rcx
	addl	%edx, %ecx
	addl	%ecx, %ecx
	leal	(%rcx,%rcx,4), %ecx
	subl	%ecx, %eax
	movslq	i(%rip), %rcx
	movl	%eax, arr(,%rcx,4)
	jmp	.LBB0_5
.LBB0_6:                                # %for_after
	movl	$1, p(%rip)
	movl	$0, i(%rip)
	xorl	%eax, %eax
	jmp	.LBB0_7
	.align	16, 0x90
.LBB0_8:                                # %for_body7
                                        #   in Loop: Header=BB0_7 Depth=1
	movl	p(%rip), %eax
	imull	P(%rip), %eax
	cltd
	idivl	MOD(%rip)
	movl	%edx, p(%rip)
	movslq	i(%rip), %rax
	movl	%edx, queries(,%rax,4)
	movl	i(%rip), %eax
	incl	%eax
	movl	%eax, i(%rip)
.LBB0_7:                                # %for_condition6
                                        # =>This Inner Loop Header: Depth=1
	cmpl	Q(%rip), %eax
	jl	.LBB0_8
# BB#9:                                 # %for_after8
	movl	$0, i(%rip)
	xorl	%eax, %eax
	jmp	.LBB0_10
	.align	16, 0x90
.LBB0_19:                               # %afterloop
                                        #   in Loop: Header=BB0_10 Depth=1
	movl	i(%rip), %eax
	incl	%eax
	movl	%eax, i(%rip)
.LBB0_10:                               # %for_condition11
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_12 Depth 2
	cmpl	Q(%rip), %eax
	jge	.LBB0_18
# BB#11:                                # %for_body12
                                        #   in Loop: Header=BB0_10 Depth=1
	movslq	i(%rip), %rax
	movl	queries(,%rax,4), %eax
	movl	%eax, q(%rip)
	movl	$0, l(%rip)
	movl	N(%rip), %eax
	decl	%eax
	movl	%eax, r(%rip)
	movslq	i(%rip), %rax
	movl	$-1, answers(,%rax,4)
	jmp	.LBB0_12
	.align	16, 0x90
.LBB0_14:                               # %if17
                                        #   in Loop: Header=BB0_12 Depth=2
	movl	m(%rip), %eax
	movslq	i(%rip), %rcx
	movl	%eax, answers(,%rcx,4)
	movl	$1, l(%rip)
	movl	$0, r(%rip)
.LBB0_12:                               # %while_condition
                                        #   Parent Loop BB0_10 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	l(%rip), %eax
	cmpl	r(%rip), %eax
	jge	.LBB0_19
# BB#13:                                # %loop
                                        #   in Loop: Header=BB0_12 Depth=2
	movl	l(%rip), %eax
	addl	r(%rip), %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	sarl	%ecx
	movl	%ecx, m(%rip)
	movslq	m(%rip), %rax
	movl	arr(,%rax,4), %eax
	cmpl	q(%rip), %eax
	je	.LBB0_14
# BB#15:                                # %else18
                                        #   in Loop: Header=BB0_12 Depth=2
	movslq	m(%rip), %rax
	movl	arr(,%rax,4), %eax
	cmpl	q(%rip), %eax
	jle	.LBB0_17
# BB#16:                                # %if22
                                        #   in Loop: Header=BB0_12 Depth=2
	movl	m(%rip), %eax
	decl	%eax
	movl	%eax, r(%rip)
	jmp	.LBB0_12
	.align	16, 0x90
.LBB0_17:                               # %else23
                                        #   in Loop: Header=BB0_12 Depth=2
	movl	m(%rip), %eax
	incl	%eax
	movl	%eax, l(%rip)
	jmp	.LBB0_12
.LBB0_18:                               # %for_after13
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc

	.type	N,@object               # @N
	.comm	N,4,4
	.type	Q,@object               # @Q
	.comm	Q,4,4
	.type	p,@object               # @p
	.comm	p,4,4
	.type	P,@object               # @P
	.comm	P,4,4
	.type	MOD,@object             # @MOD
	.comm	MOD,4,4
	.type	q,@object               # @q
	.comm	q,4,4
	.type	i,@object               # @i
	.comm	i,4,4
	.type	j,@object               # @j
	.comm	j,4,4
	.type	k,@object               # @k
	.comm	k,4,4
	.type	l,@object               # @l
	.comm	l,4,4
	.type	r,@object               # @r
	.comm	r,4,4
	.type	m,@object               # @m
	.comm	m,4,4
	.type	arr,@object             # @arr
	.bss
	.globl	arr
	.align	16
arr:
	.zero	20000020
	.size	arr, 20000020

	.type	queries,@object         # @queries
	.globl	queries
	.align	16
queries:
	.zero	20000020
	.size	queries, 20000020

	.type	answers,@object         # @answers
	.globl	answers
	.align	16
answers:
	.zero	20000020
	.size	answers, 20000020


	.section	".note.GNU-stack","",@progbits
