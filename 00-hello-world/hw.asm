
; hw.asm
; dark_neo
; 2014-06-06

; Compile with:
;	nasm -f elf64 hw.asm
;	ld [-o hw.out] hw.o

; Print hello world to stdout.

;------ SECTIONS OF ASSEMBLY PROGRAM FILE --------

; BSS SECTION
; It is used for declaring variables.
section .bss

; DATA SECTION
; It is used for declaring initialized data or constants. This data does not
; change at runtime.
section .data
msg:
	db	"Hello World", 10	; Output 'Hello World' + newline.

; TEXT SECTION
; It is used for keeping the actual code. Must begin with the
; declaration of main (if you uses C calls) or _start.
section .text
	global _start

; Arguments for system calls in x64 for Linux.
; rax (syscall number)
; rdi (1st arg)
; rsi (2nd arg)
; rdx (3rd arg)
; rcx (4th arg)
; r8 (5th arg)
; r9 (6th arg)

; More info for x64 Linux system calls:
; http://blog.rchapman.org/post/36801038863/linux-system-call-table-for-x86-64

; Additional info for x86 Linux system calls:
; http://docs.cs.up.ac.za/programming/asm/derick_tut/syscalls.htmlhttp://docs.cs.up.ac.za/programming/asm/derick_tut/syscalls.html

_start:
	mov		rax,	1		; system call 1 is write.
	mov		rdi,	1		; file handle 1 is stdout.
	mov		rsi,	msg		; address of msg string to output.
	mov		rdx,	13		; number of bytes.
	syscall					; ready for system call function.

	; call the function exit(0)
	mov		eax,	60		; system call 60 is exit.
	xor		rdi,	rdi		; exit code 0
	syscall					; invoke OS to exit.

