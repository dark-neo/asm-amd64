
/*
 * mw.asm
 * dark_neo
 * 2014-06-10
 */

/* Compile with:
 *	gcc -c mw.asm
 *	gcc `pkg-config --cflags gtk+-2.0` mw.o `pkg-config --libs gtk+-2.0`
 */

/* NOTE: ONLY FOR x86_64 PLATFORMS. */

/*
 * Operation suffixes table:
 *
 * b ==	byte	(8 bit)
 * s ==	short	(16 bit int) or single (32 bit floating point)
 * w ==	word	(16 bit)
 * l ==	long	(32 bit integer or 64 bit floating point)
 * q ==	quad	(64 bit)
 * t ==	ten bytes	(80 bit floating point)
 */

/*
 * If not suffix and no memory operands for the instruction, GAS infers the
 * operand size from the size of destination register operand (the final
 * operand).
 */

/*
 * .LC0: This is a label that create a string with the text between quotes " ".
 */
.LC0:
	.string		"GTK+ Assembly App"				/* App title.	*/
.LC1:
	.string		"Other title"
.global			main							/* C main()		*/
main:
	/* 
	 * Note the 'q' suffix. The opcode is 'quad' (64-bit).
	 * Save the value of RBP on stack.
	 */
	pushq		%rbp
	/* Move the value of RBP to RSP. */
	movq		%rsp,						%rbp
	/*
	 * Substract 32 from RSP. Reserve this space on the stack.
	 * In this case, 32 bytes have been reserved on the stack.
	 * The '$' meaning a constant value.
	 */
	subq		$32,						%rsp

	/* Move to RDI the value of RBP value -20. */
	movl		%edi,						-20(%rbp)
	movq		%rsi,						-32(%rbp)
	/* Move the RBP-32 into RDX and the RBP-20 into RAX. */
	leaq		-32(%rbp),					%rdx
	leaq		-20(%rbp),					%rax

	/*
	 * Ok, this is a bit confused. First at all, the gtk_init() function has
	 * the next C prototype:
	 *  		void gtk_init(int *argc, char ***argv);
	 *
	 * The gtk_init gets an array of arguments counter (argc) and an array of
	 * the strings arguments passing to the program.  Still confused? No
	 * problem:
	 * 	C main prototypes:
	 *			void main(void);
	 *			void main(int argc, char *argv[]);
	 *
	 * Do you see? when you call to the gtk_init() function into a C program,
	 * you MUST do:
	 *		#include <gtk/gtk.h>
	 * 		int main(int argc, char *argv[]) 
	 *		{
	 *			gtk_init(&argc, &argv);
	 *			return 0;
	 *		}
	 *
	 * So, back to our wonderful x64 assembly code, the RDX and the RAX
	 * registers are the 'argc' and 'argv' parameters of the C main function.
	 */
	movq		%rdx,						%rsi		/* argc */
	movq		%rax,						%rdi		/* argv */
	call		gtk_init								/* gtk_init() */
	/*
	 * Hey, and the '<gtk/gtk.h>' header file? O.O
	 * The libaries are included at compile time. They will be pass through the
	 * GNU GCC compiler with the paramenters:
	 * 		`pkg-config --cflags gtk+-2.0`	<-- the GTK flags (include
	 *											the header (.h file)  path).
	 *		`pkg-config --libs gtk+-2.0`	<-- the GTK library files
	 *											(.so files).
	 */

	/*
	 * C prototype:
	 * GtkWidget * gtk_window_new(GtkWindowType type);
	 *
	 * The GtkWindowType is a constant with the position of window when this
	 * is created. I passed the constant 0 meaning: GTK_WINDOW_TOPLEVEL
	 * constant. See the GTK+ reference for more details.
	 */
	movl		$0,							%edi
	call		gtk_window_new
	
	/*
	 * C prototype:
	 * unsinged int gtk_window_get_type(void);
	 *
	 * Returns the GtkWindow type identifier and copy into RAX. 
	 */
	movq		%rax,						-8(%rbp)
	call		gtk_window_get_type

	/*
	 * C macro prototype:
	 * #define G_TYPE_CHECK_INSTANCE_CAST(instance, g_type, c_type) \
	 * 					(_G_TYPE_CIC ((instance), (g_type), c_type))
	 *
	 * Checks that 'instance' is an instance of the typed identified by
	 * 'g_type' and issues a warning if this is not the case.
	 * Returns 'instance' casted to a pointer c_type (with the macro
	 *					_G_TYPE_CIC).
	 *
	 * Params:
	 *	instance: Location of a GTypeInstance struct.
	 *	g_type: The type to be returned.
	 *  c_type: The corresponding C type of g_type.
	 */
	movq		%rax,						%rdx
	movq		-8(%rbp),					%rax
	movq		%rdx,						%rsi
	movq		%rax,						%rdi
	call		g_type_check_instance_cast

	/*
	 * Set the window title.
	 *
	 * C prototype:
	 * void gtk_window_title(GtkWindow *window, const char *window_title);
	 */
	/*movl		$.LC0,						%esi	*/
	movl		$.LC1,						%esi
	movq		%rax,						%rdi
	call		gtk_window_set_title

	movq		-8(%rbp),					%rax
	movq		%rax,						%rdi
	call		gtk_widget_show

	/*
	 * C prototype:
	 * void gtk_main(void);
	 */
	call		gtk_main

	/* Finish the program (like the return 0 in the main function of C */
	mov			$0,							%rax
	leave
	ret

