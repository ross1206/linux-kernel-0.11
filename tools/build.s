	.file	"build.c"
	.section	.rodata
.LC0:
	.string	"%s\n"
	.text
	.globl	die
	.type	die, @function
die:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	stderr(%rip), %rax
	movq	-8(%rbp), %rdx
	movl	$.LC0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE2:
	.size	die, .-die
	.section	.rodata
	.align 8
.LC1:
	.string	"Usage: build bootsect setup system [rootdev] [> image]"
	.text
	.globl	usage
	.type	usage, @function
usage:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$.LC1, %edi
	call	die
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	usage, .-usage
	.section	.rodata
.LC2:
	.string	"FLOPPY"
.LC3:
	.string	"Couldn't stat root device."
.LC4:
	.string	"Root device is (%d, %d)\n"
	.align 8
.LC5:
	.string	"Illegal root device (major = %d)\n"
.LC6:
	.string	"Bad root device --- major #"
.LC7:
	.string	"Unable to open 'boot'"
	.align 8
.LC8:
	.string	"Unable to read header of 'boot'"
.LC9:
	.string	"Non-Minix header of 'boot'"
	.align 8
.LC10:
	.string	"Illegal data segment in 'boot'"
.LC11:
	.string	"Illegal bss in 'boot'"
	.align 8
.LC12:
	.string	"Illegal symbol table in 'boot'"
.LC13:
	.string	"Boot sector %d bytes.\n"
	.align 8
.LC14:
	.string	"Boot block must be exactly 512 bytes"
	.align 8
.LC15:
	.string	"Boot block hasn't got boot flag (0xAA55)"
.LC16:
	.string	"Write call failed"
.LC17:
	.string	"Unable to open 'setup'"
	.align 8
.LC18:
	.string	"Unable to read header of 'setup'"
.LC19:
	.string	"Non-Minix header of 'setup'"
	.align 8
.LC20:
	.string	"Illegal data segment in 'setup'"
.LC21:
	.string	"Illegal bss in 'setup'"
	.align 8
.LC22:
	.string	"Illegal symbol table in 'setup'"
	.align 8
.LC23:
	.string	"Setup exceeds SETUP_SECTS sectors - rewrite build/boot/setup"
.LC24:
	.string	"Setup is %d bytes.\n"
.LC25:
	.string	"Unable to open 'system'"
	.align 8
.LC26:
	.string	"Unable to read header of 'system'"
.LC27:
	.string	"Non-GCC header of 'system'"
.LC28:
	.string	"System is %d bytes.\n"
.LC29:
	.string	"System is too big"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$1224, %rsp
	.cfi_offset 3, -24
	movl	%edi, -1220(%rbp)
	movq	%rsi, -1232(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	cmpl	$4, -1220(%rbp)
	je	.L4
	cmpl	$5, -1220(%rbp)
	je	.L4
	call	usage
.L4:
	cmpl	$5, -1220(%rbp)
	jne	.L5
	movq	-1232(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	movl	$.LC2, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L6
	movq	-1232(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	leaq	-1200(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stat
	testl	%eax, %eax
	je	.L7
	movq	-1232(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	perror
	movl	$.LC3, %edi
	call	die
.L7:
	movq	-1160(%rbp), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	MAJOR
	movb	%al, -1214(%rbp)
	movq	-1160(%rbp), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	MINOR
	movb	%al, -1213(%rbp)
	jmp	.L9
.L6:
	movb	$0, -1214(%rbp)
	movb	$0, -1213(%rbp)
	jmp	.L9
.L5:
	movb	$3, -1214(%rbp)
	movb	$6, -1213(%rbp)
.L9:
	movsbl	-1213(%rbp), %ecx
	movsbl	-1214(%rbp), %edx
	movq	stderr(%rip), %rax
	movl	$.LC4, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	cmpb	$2, -1214(%rbp)
	je	.L10
	cmpb	$3, -1214(%rbp)
	je	.L10
	cmpb	$0, -1214(%rbp)
	je	.L10
	movsbl	-1214(%rbp), %edx
	movq	stderr(%rip), %rax
	movl	$.LC5, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$.LC6, %edi
	call	die
.L10:
	movl	$0, -1212(%rbp)
	jmp	.L11
.L12:
	movl	-1212(%rbp), %eax
	cltq
	movb	$0, -1056(%rbp,%rax)
	addl	$1, -1212(%rbp)
.L11:
	movl	-1212(%rbp), %eax
	cmpl	$1023, %eax
	jbe	.L12
	movq	-1232(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open
	movl	%eax, -1204(%rbp)
	cmpl	$0, -1204(%rbp)
	jns	.L13
	movl	$.LC7, %edi
	call	die
.L13:
	leaq	-1056(%rbp), %rcx
	movl	-1204(%rbp), %eax
	movl	$32, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	cmpq	$32, %rax
	je	.L14
	movl	$.LC8, %edi
	call	die
.L14:
	leaq	-1056(%rbp), %rax
	movq	(%rax), %rax
	cmpq	$68158209, %rax
	je	.L15
	movl	$.LC9, %edi
	call	die
.L15:
	leaq	-1056(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	cmpq	$32, %rax
	je	.L16
	movl	$.LC9, %edi
	call	die
.L16:
	leaq	-1056(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L17
	movl	$.LC10, %edi
	call	die
.L17:
	leaq	-1056(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L18
	movl	$.LC11, %edi
	call	die
.L18:
	leaq	-1056(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L19
	movl	$.LC9, %edi
	call	die
.L19:
	leaq	-1056(%rbp), %rax
	addq	$56, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L20
	movl	$.LC12, %edi
	call	die
.L20:
	leaq	-1056(%rbp), %rcx
	movl	-1204(%rbp), %eax
	movl	$1024, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -1212(%rbp)
	movq	stderr(%rip), %rax
	movl	-1212(%rbp), %edx
	movl	$.LC13, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	cmpl	$512, -1212(%rbp)
	je	.L21
	movl	$.LC14, %edi
	call	die
.L21:
	leaq	-1056(%rbp), %rax
	addq	$510, %rax
	movzwl	(%rax), %eax
	cmpw	$-21931, %ax
	je	.L22
	movl	$.LC15, %edi
	call	die
.L22:
	movzbl	-1213(%rbp), %eax
	movb	%al, -548(%rbp)
	movzbl	-1214(%rbp), %eax
	movb	%al, -547(%rbp)
	leaq	-1056(%rbp), %rax
	movl	$512, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write
	movl	%eax, -1212(%rbp)
	cmpl	$512, -1212(%rbp)
	je	.L23
	movl	$.LC16, %edi
	call	die
.L23:
	movl	-1204(%rbp), %eax
	movl	%eax, %edi
	call	close
	movq	-1232(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open
	movl	%eax, -1204(%rbp)
	cmpl	$0, -1204(%rbp)
	jns	.L24
	movl	$.LC17, %edi
	call	die
.L24:
	leaq	-1056(%rbp), %rcx
	movl	-1204(%rbp), %eax
	movl	$32, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	cmpq	$32, %rax
	je	.L25
	movl	$.LC18, %edi
	call	die
.L25:
	leaq	-1056(%rbp), %rax
	movq	(%rax), %rax
	cmpq	$68158209, %rax
	je	.L26
	movl	$.LC19, %edi
	call	die
.L26:
	leaq	-1056(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	cmpq	$32, %rax
	je	.L27
	movl	$.LC19, %edi
	call	die
.L27:
	leaq	-1056(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L28
	movl	$.LC20, %edi
	call	die
.L28:
	leaq	-1056(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L29
	movl	$.LC21, %edi
	call	die
.L29:
	leaq	-1056(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L30
	movl	$.LC19, %edi
	call	die
.L30:
	leaq	-1056(%rbp), %rax
	addq	$56, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L31
	movl	$.LC22, %edi
	call	die
.L31:
	movl	$0, -1212(%rbp)
	jmp	.L32
.L34:
	movl	-1208(%rbp), %eax
	movslq	%eax, %rdx
	leaq	-1056(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write
	movl	-1208(%rbp), %edx
	movslq	%edx, %rdx
	cmpq	%rdx, %rax
	je	.L33
	movl	$.LC16, %edi
	call	die
.L33:
	movl	-1208(%rbp), %eax
	addl	%eax, -1212(%rbp)
.L32:
	leaq	-1056(%rbp), %rcx
	movl	-1204(%rbp), %eax
	movl	$1024, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -1208(%rbp)
	cmpl	$0, -1208(%rbp)
	jg	.L34
	movl	-1204(%rbp), %eax
	movl	%eax, %edi
	call	close
	cmpl	$2048, -1212(%rbp)
	jle	.L35
	movl	$.LC23, %edi
	call	die
.L35:
	movq	stderr(%rip), %rax
	movl	-1212(%rbp), %edx
	movl	$.LC24, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$0, -1208(%rbp)
	jmp	.L36
.L37:
	movl	-1208(%rbp), %eax
	cltq
	movb	$0, -1056(%rbp,%rax)
	addl	$1, -1208(%rbp)
.L36:
	movl	-1208(%rbp), %eax
	cmpl	$1023, %eax
	jbe	.L37
	jmp	.L38
.L41:
	movl	$2048, %eax
	subl	-1212(%rbp), %eax
	movl	%eax, -1208(%rbp)
	movl	-1208(%rbp), %eax
	cmpl	$1024, %eax
	jbe	.L39
	movl	$1024, -1208(%rbp)
.L39:
	movl	-1208(%rbp), %eax
	movslq	%eax, %rdx
	leaq	-1056(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write
	movl	-1208(%rbp), %edx
	movslq	%edx, %rdx
	cmpq	%rdx, %rax
	je	.L40
	movl	$.LC16, %edi
	call	die
.L40:
	movl	-1208(%rbp), %eax
	addl	%eax, -1212(%rbp)
.L38:
	cmpl	$2047, -1212(%rbp)
	jle	.L41
	movq	-1232(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open
	movl	%eax, -1204(%rbp)
	cmpl	$0, -1204(%rbp)
	jns	.L42
	movl	$.LC25, %edi
	call	die
.L42:
	leaq	-1056(%rbp), %rcx
	movl	-1204(%rbp), %eax
	movl	$1024, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	cmpq	$1024, %rax
	je	.L43
	movl	$.LC26, %edi
	call	die
.L43:
	leaq	-1056(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L44
	movl	$.LC27, %edi
	call	die
.L44:
	movl	$0, -1212(%rbp)
	jmp	.L45
.L47:
	movl	-1208(%rbp), %eax
	movslq	%eax, %rdx
	leaq	-1056(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write
	movl	-1208(%rbp), %edx
	movslq	%edx, %rdx
	cmpq	%rdx, %rax
	je	.L46
	movl	$.LC16, %edi
	call	die
.L46:
	movl	-1208(%rbp), %eax
	addl	%eax, -1212(%rbp)
.L45:
	leaq	-1056(%rbp), %rcx
	movl	-1204(%rbp), %eax
	movl	$1024, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -1208(%rbp)
	cmpl	$0, -1208(%rbp)
	jg	.L47
	movl	-1204(%rbp), %eax
	movl	%eax, %edi
	call	close
	movq	stderr(%rip), %rax
	movl	-1212(%rbp), %edx
	movl	$.LC28, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	cmpl	$131072, -1212(%rbp)
	jle	.L48
	movl	$.LC29, %edi
	call	die
.L48:
	movl	$0, %eax
	movq	-24(%rbp), %rbx
	xorq	%fs:40, %rbx
	je	.L50
	call	__stack_chk_fail
.L50:
	addq	$1224, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
