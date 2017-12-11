	.text
	.file	"ir"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rax
.Ltmp0:
	.cfi_def_cfa_offset 16
	movl	$5000000, N(%rip)       # imm = 0x4C4B40
	movl	$0, i(%rip)
	xorl	%eax, %eax
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for_body
                                        #   in Loop: Header=BB0_1 Depth=1
	movslq	i(%rip), %rax
	movl	$1, isprime(,%rax,4)
	movl	i(%rip), %eax
	incl	%eax
	movl	%eax, i(%rip)
.LBB0_1:                                # %for_condition
                                        # =>This Inner Loop Header: Depth=1
	cmpl	N(%rip), %eax
	jl	.LBB0_2
# BB#3:                                 # %for_after
	movl	$0, k(%rip)
	movl	$2, i(%rip)
	movl	$2, %eax
	jmp	.LBB0_4
	.align	16, 0x90
.LBB0_10:                               # %ifnext
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	i(%rip), %eax
	incl	%eax
	movl	%eax, i(%rip)
.LBB0_4:                                # %for_condition1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_7 Depth 2
	cmpl	N(%rip), %eax
	jge	.LBB0_11
# BB#5:                                 # %for_body2
                                        #   in Loop: Header=BB0_4 Depth=1
	movslq	i(%rip), %rax
	cmpl	$0, isprime(,%rax,4)
	je	.LBB0_10
# BB#6:                                 # %if
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	i(%rip), %eax
	addl	%eax, %eax
	jmp	.LBB0_7
	.align	16, 0x90
.LBB0_8:                                # %for_body6
                                        #   in Loop: Header=BB0_7 Depth=2
	movslq	j(%rip), %rax
	movl	$0, isprime(,%rax,4)
	movl	j(%rip), %eax
	addl	i(%rip), %eax
.LBB0_7:                                # %for_condition5
                                        #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%eax, j(%rip)
	cmpl	N(%rip), %eax
	jl	.LBB0_8
# BB#9:                                 # %for_after7
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	i(%rip), %eax
	movslq	k(%rip), %rcx
	movl	%eax, primes(,%rcx,4)
	incl	k(%rip)
	jmp	.LBB0_10
.LBB0_11:                               # %for_after3
	movl	$.L__unnamed_1, %edi
	movl	$.L__unnamed_2, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L__unnamed_3, %edi
	movl	$.L__unnamed_4, %esi
	xorl	%eax, %eax
	callq	printf
	movl	N(%rip), %esi
	movl	$.L__unnamed_5, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L__unnamed_6, %edi
	movl	$.L__unnamed_7, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L__unnamed_8, %edi
	movl	$.L__unnamed_9, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$.L__unnamed_10, %edi
	movl	$.L__unnamed_11, %esi
	xorl	%eax, %eax
	callq	printf
	movl	k(%rip), %esi
	movl	$.L__unnamed_12, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L__unnamed_13, %edi
	movl	$.L__unnamed_14, %esi
	xorl	%eax, %eax
	callq	printf
	popq	%rax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc

	.type	N,@object               # @N
	.comm	N,4,4
	.type	i,@object               # @i
	.comm	i,4,4
	.type	j,@object               # @j
	.comm	j,4,4
	.type	k,@object               # @k
	.comm	k,4,4
	.type	isprime,@object         # @isprime
	.bss
	.globl	isprime
	.align	16
isprime:
	.zero	20000020
	.size	isprime, 20000020

	.type	primes,@object          # @primes
	.globl	primes
	.align	16
primes:
	.zero	20000020
	.size	primes, 20000020

	.type	.L__unnamed_1,@object   # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_1:
	.asciz	"%s"
	.size	.L__unnamed_1, 3

	.type	.L__unnamed_2,@object   # @1
	.section	.rodata.str1.16,"aMS",@progbits,1
	.align	16
.L__unnamed_2:
	.asciz	"Total Number of Primes up to"
	.size	.L__unnamed_2, 29

	.type	.L__unnamed_3,@object   # @2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_3:
	.asciz	"%s"
	.size	.L__unnamed_3, 3

	.type	.L__unnamed_4,@object   # @3
.L__unnamed_4:
	.asciz	" "
	.size	.L__unnamed_4, 2

	.type	.L__unnamed_5,@object   # @4
.L__unnamed_5:
	.asciz	"%d"
	.size	.L__unnamed_5, 3

	.type	.L__unnamed_6,@object   # @5
.L__unnamed_6:
	.asciz	"%s"
	.size	.L__unnamed_6, 3

	.type	.L__unnamed_7,@object   # @6
.L__unnamed_7:
	.asciz	" "
	.size	.L__unnamed_7, 2

	.type	.L__unnamed_8,@object   # @7
.L__unnamed_8:
	.asciz	"%s"
	.size	.L__unnamed_8, 3

	.type	.L__unnamed_9,@object   # @8
.L__unnamed_9:
	.asciz	"is :"
	.size	.L__unnamed_9, 5

	.type	.L__unnamed_10,@object  # @9
.L__unnamed_10:
	.asciz	"%s"
	.size	.L__unnamed_10, 3

	.type	.L__unnamed_11,@object  # @10
.L__unnamed_11:
	.asciz	" "
	.size	.L__unnamed_11, 2

	.type	.L__unnamed_12,@object  # @11
.L__unnamed_12:
	.asciz	"%d"
	.size	.L__unnamed_12, 3

	.type	.L__unnamed_13,@object  # @12
.L__unnamed_13:
	.asciz	"%s"
	.size	.L__unnamed_13, 3

	.type	.L__unnamed_14,@object  # @13
.L__unnamed_14:
	.asciz	"\n"
	.size	.L__unnamed_14, 2


	.section	".note.GNU-stack","",@progbits
