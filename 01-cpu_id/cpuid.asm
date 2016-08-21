
; cpuid.asm
; dark_neo
; 2014-06-07

; Compile with:
; 	nasm -f elf64 cpuid.asm
; 	ld [-o cpuid.out] cpuid.o

; Print the CPU name.

; Declaring variables.
section .bss

; Declaring initialized data or constants. Daa does not change at runtime.
section .data

section .text
	global _start

_start:
	xor		eax,	eax		; place 0x0 in EAX for getting the name of
							; processor.
	cpuid
	shl 	rdx,	0x20	; shifting lower 32-bits into uper 32-bits of
							; RDX.
	xor		rdx,	rbx		; moving EBX into EDX.
	push	rcx				; push the string on stack.
	push	rdx
	mov		rdx,	0x10	; since we are pushing 2 registers, the length
							; is not more than 16 bytes.
	mov		rsi,	rsp		; the address of the string is RSP because the
							; string is on the stack.
	push	0x1				; the system call write() has the value 0x1 in
							; the system call table.
	pop		rax
	mov		rdi,	rax		; since we are printing to stdout, the value of
							; the file descriptor is also 0x1.
	syscall					; make the system call.
	mov		eax,	60		; we now make the exit() system call here.
	xor		rdi,	rdi		; the argument is 0x0
	syscall					; this exits the application and give the
							; control back to OS.

