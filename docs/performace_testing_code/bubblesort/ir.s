	.text
	.file	"ir"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	movl	$31, P(%rip)
	movl	$1, p(%rip)
	movl	$20000, N(%rip)         # imm = 0x4E20
	movl	$0, i(%rip)
	xorl	%eax, %eax
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for_body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	p(%rip), %eax
	movslq	i(%rip), %rcx
	movl	%eax, arr(,%rcx,4)
	movl	p(%rip), %eax
	imull	P(%rip), %eax
	cltq
	imulq	$142497619, %rax, %rcx  # imm = 0x87E5753
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$44, %rcx
	addl	%edx, %ecx
	imull	$123456, %ecx, %ecx     # imm = 0x1E240
	subl	%ecx, %eax
	movl	%eax, p(%rip)
	movl	i(%rip), %eax
	incl	%eax
	movl	%eax, i(%rip)
.LBB0_1:                                # %for_condition
                                        # =>This Inner Loop Header: Depth=1
	cmpl	N(%rip), %eax
	jl	.LBB0_2
# BB#3:                                 # %for_after
	movl	$0, i(%rip)
	xorl	%eax, %eax
	jmp	.LBB0_4
	.align	16, 0x90
.LBB0_11:                               # %for_after6
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	i(%rip), %eax
	incl	%eax
	movl	%eax, i(%rip)
.LBB0_4:                                # %for_condition1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
	cmpl	N(%rip), %eax
	jge	.LBB0_10
# BB#5:                                 # %for_body2
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$0, j(%rip)
	xorl	%eax, %eax
	jmp	.LBB0_6
	.align	16, 0x90
.LBB0_9:                                # %ifnext
                                        #   in Loop: Header=BB0_6 Depth=2
	movl	j(%rip), %eax
	incl	%eax
	movl	%eax, j(%rip)
.LBB0_6:                                # %for_condition4
                                        #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	N(%rip), %ecx
	subl	i(%rip), %ecx
	decl	%ecx
	cmpl	%ecx, %eax
	jge	.LBB0_11
# BB#7:                                 # %for_body5
                                        #   in Loop: Header=BB0_6 Depth=2
	movslq	j(%rip), %rax
	movl	arr(,%rax,4), %ecx
	leal	1(%rax), %eax
	cltq
	cmpl	arr(,%rax,4), %ecx
	jle	.LBB0_9
# BB#8:                                 # %if
                                        #   in Loop: Header=BB0_6 Depth=2
	movslq	j(%rip), %rax
	movl	arr(,%rax,4), %eax
	movl	%eax, temp(%rip)
	movslq	j(%rip), %rax
	leal	1(%rax), %ecx
	movslq	%ecx, %rcx
	movl	arr(,%rcx,4), %ecx
	movl	%ecx, arr(,%rax,4)
	movl	temp(%rip), %eax
	movl	j(%rip), %ecx
	incl	%ecx
	movslq	%ecx, %rcx
	movl	%eax, arr(,%rcx,4)
	jmp	.LBB0_9
.LBB0_10:                               # %for_after3
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
	.type	temp,@object            # @temp
	.comm	temp,4,4
	.type	p,@object               # @p
	.comm	p,4,4
	.type	P,@object               # @P
	.comm	P,4,4
	.type	arr,@object             # @arr
	.bss
	.globl	arr
	.align	16
arr:
	.zero	400020
	.size	arr, 400020


	.section	".note.GNU-stack","",@progbits
