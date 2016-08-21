
; io.asm
; dark_neo
; 2014-06-07

; Compile with:
;	nasm -f elf64 io.asm
;	ld *.o

; Input/Output interaction in x64 Linux assembly.

section .bss

section .data
	; The 10 value is the '\n'.
	pmpt:		db	"Enter your text: ", 10
	pmpt_len:	equ	$ - pmpt
	pmpt_size:	equ	$ - pmpt

	; The program write char-to-char and store into the string.
	; So, we need repeat storing character until ENTER is press.
	; The user can write up 255 characters.
	;	times 	== max characters to store.
	;	0 	== end the input.

	txt:		times 	255 db 0
	txt_len:	equ	$ - txt
	txt_size:	equ 	$ - txt

	; New 'variable' to prompt.
	txt2:		db	10, "YOU HAVE INSERTED: ", 10
	txt2_len:	equ	$ - txt2
	txt2_size:	equ	$ - txt2

section .text
	global _start

_start:
	; ssize_t write(int fd, const void *buf, size_t count);
	mov		rax,	1		; call to sys_write.
	mov		rdi,	1		; fd param (1 == stdout).
	mov		rsi,	pmpt		; buf param.

	;mov		rdx,	5		; number of bytes of string.

	mov		rdx,	pmpt_len	; count param (pmpt length).
	syscall					; call to write() system
						; function.

	; ssize_t read(int fd, void *buf, size_t count);
	mov		rax,	0		; call to sys_read.
	mov		rdi,	0		; fd param (0 == stdin).
	mov		rsi,	txt		; buf param. 'txt' var stores
						; the chars input by user.
	mov		rdx,	txt_size	; count param (txt_size of
						; input string).
	syscall					; call to read() system
						; function.

	; Call to write() once again to output the txt var value.
	; ssize_t write(int fd, const void *buf, size_t count);
	mov		rax,	1		; call to sys_write.
	mov		rdi,	1		; fd param (1 == stdout).
	mov		rsi,	txt2		; buf param.
	mov		rdx,	txt2_len	; count param.
	syscall					; call to write() system
						; function.

	; Call to write() to output the text entered by user.
	; ssize_t write(int fd, const void *buf, size_t count);
	mov		rax,	1		; call to sys_write.
	mov		rdi,	1		; fd param (1 == stdout).
	mov		rsi,	txt		; buf param.
	mov		rdx,	txt_len		; count param.
	syscall					; call to write() system
						; function.

	; Call to exit(0)
	mov		eax,	60
	xor		rdi,	rdi		; exit code 0
	syscall					; call to exit() system
						; function.

