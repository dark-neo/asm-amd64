
; cstdio.asm
; dark_neo
; 2014-08-18

; Compile with:
;	nasm -f elf64 cstdio.asm
;	gcc -Wall -O2 -g cstdio.o

; Example about C function calling in x86_64 assembly code.
; Program that print a text, user write a text on STDIN and show the input
; text to STDOUT.

segment .data
	; *name_msg* is a string which allocate the text "Enter ..." and add the
	; end-of-string character '\0'. In hexadecimal, is a 0x0.
	; 0xA is 10 in decimal base number. Means newline (the '\n' on others
	; programming languages).
	name_msg	db	"Enter your name: ", 0xA, 0x0
	surn_msg	db	0xA, "Enter your surname: ", 0xA, 0x0

	; scanf() format.
	name_surn_fmt	db	"%s", 0x0

	; Variable where store the value read with scanf().
	; Set to NULL (0x0)
	name		dq	0x0
	surname		dq	0x0

	; Variable where store the surname

	; *final_msg* is a message on printf. In C:
	; printf("\nText inserted: %s\n", user_input);
	; with *user_input* declarated as: char user_input[50];
	full_name	db	0xa, "Your full name is: %s %s", 0xa, 0x0

section .text
	; Indicate that I will call to C printf() and fgets() functions.
	extern	printf
	extern	scanf
	extern	getchar
	extern	exit

; Declare the main() function.
global		main

main:
	push	rbp			; Set up stack frame for debugger.

	; Move 0 in RAX. For the C standard library this tells it that their
	; aren't any floating point arguments to pass to the function called.
	; If their were floating point arguments passed to the function, then
	; you would place the amount of floating point arguments. Here we have
	; none, so we pass 0.
	mov	rax,	0x0

	; Move *name_msg* in RDI. RDI is the first argument to the printf
	; function. The second argument to the printf function would be RSI if
	; there another argument. This *name_msg* is the format string passed
	; to printf.
	mov	rdi,	name_msg
	call	printf

	; Call scanf() to read the name:
	mov	rax,	0x0
	mov	rdi,	name_surn_fmt
	mov	rsi,	name
	call	scanf

	; Call getchar() to avoid junk on next scanf call (the 0xA value).
	mov	rax,	0x0
	call	getchar

	; Call printf() to show the surname message.
	mov	rax,	0x0
	mov	rdi,	surn_msg
	call	printf

	; Call scanf() to read the surname:
	mov	rax,	0x0
	mov	rdi,	name_surn_fmt
	mov	rsi,	surname
	call	scanf

	; Call getchar() to avoid junk characters.
	mov	rax,	0x0
	call	getchar

	; Call printf() again to show the value of *full_name* variable.
	mov	rax,	0x0
	mov	rdi,	full_name
	mov	rsi,	name
	mov	rdx,	surname
	call	printf

	; Move 0 in RAX and RDI and return. This is the equivalent to 
	; 'return 0' in C.
	mov	rax,	0x0
	mov	rdi,	0x0
	call	exit
