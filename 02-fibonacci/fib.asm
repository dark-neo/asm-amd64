
; fib.asm
; Dark Neo
; 2014-06-07

; Compile with:
;	nasm -f elf64 fib.asm
;	gcc *.o


; A x64 UNIX program that writes the first 90 Fibonacci numbers.
; This program uses the C library to call the printf() function to show
; the numbers.

;global _start
global main
extern printf

;_start:
main:
	push	rbx				; save for use it.

	mov		ecx,	90		; ecx will countdown to 0.
	xor		rax,	rax		; rax will hold the current_number.
	xor		rbx,	rbx		; rbx will hold the next number.
	inc		rbx				; rbx is originally 1.

print:
	; We need to call C printf() function but using rax, rbx and rcx.
	; printf() may destroy rax and rcx so we will save these before the
	; cal and restore them afterwards.

	push	rax				; caller-save register.
	push	rcx				; caller-save register.

	mov		rdi,	format	; set 1st parameter (format).
	mov		rsi,	rax		; set 2nd parameter (current_number).
	mov		rax,	rax		; because printf is varargs.

	; Stack is already aligned because we pushed three 8 byte 
	; registers.
	call	printf			; printf(format, current_number).
	pop		rcx				; restore caller-save register.
	pop		rax				; restore caller-save register.
	
	mov		rdx,	rax		; save the current number.
	mov		rax,	rbx		; next number is now current.
	add		rbx,	rdx		; get the new next number.
	dec		ecx				; count down.
	jnz		print			; if not done counting, do some more.

	pop		rbx				; restore rbx before returning.
	ret						; return.

format:
	db	"%201d", 10, 0

