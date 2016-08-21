
This is a branch to development on Assembly programming language to
x86_64 processors (64-bit and 32-bit compatible). Also there are examples
to how to call a C library functions in assembly (see the project *04-c-stdio*
about using the C standard library and *gtk* directory to call an external
C libraries on assembly)

NOTE: the assembly program used in this branch is NASM under Linux OS x86_64.

<h2>REGISTERS USED IN x86_64 ASSEMBLY</h2>
<table>
<tr>
        <td><b>rax</b></td>
        <td>return value</td>
</tr>
<tr>
        <td><b>rbx</b></td>
        <td>callee saved</td>
</tr>
<tr>
        <td><b>rcx</b></td>
        <td>4th argument</td>
</tr>
<tr>
        <td><b>rdx</b></td>
        <td>3rd argument</td>
</tr>
<tr>
        <td><b>rsi</b></td>
        <td>2nd argument</td>
</tr>
<tr>
        <td><b>rbp</b></td>
        <td>callee saved</td>
</tr>
<tr>
        <td><b>rsp</b></td>
        <td>stack pointer</td>
</tr>
<tr>
        <td><b>r8</b></td>
        <td>5th argument</td>
</tr>
<tr>
        <td><b>r9</b></td>
        <td>6th argument</td>
</tr>
<tr>
        <td><b>r10</b></td>
        <td>callee saved</td>
</tr>
<tr>
        <td><b>r11</b></td>
        <td>used for linking</td>
</tr>
<tr>
        <td><b>r12</b></td>
        <td>unused in C</td>
</tr>
<tr>
        <td><b>r13</b></td>
        <td>callee saved</td>
</tr>
<tr>
        <td><b>r14</b></td>
        <td>callee saved</td>
</tr>
<tr>
        <td><b>r15</b></td>
        <td>callee saved</td>
</tr>
</table>

<br><p>
EXPLICATION:
'callee' saved is the return value on function calls.<br>
'Xxx argument' is the function arguments.
</p>


<h2>DATA TYPE</h2>
=========
<table>
<tr>
        <td><b>C type</b></td>
        <td><b>x86_64 size (in bytes)</b></td>
</tr>
<tr>
        <td>char</td>
        <td>1</td>
</tr>
<tr>
        <td>short</td>
        <td>2</td>
</tr>
<tr>
        <td>int</td>
        <td>4</td>
</tr>
<tr>
        <td>unsigned int</td>
        <td>4</td>
</tr>
<tr>
        <td>long int</td>
        <td>8</td>
</tr>
<tr>
        <td>unsigned long</td>
        <td>8</td>
</tr>
<tr>
        <td>void * (any pointer)</td>
        <td>8</td>
</tr>
<tr>
        <td>float</td>
        <td>4</td>
</tr>
<tr>
        <td>double</td>
        <td>8</td>
</tr>
<tr>
        <td>long double</td>
        <td>16</td>
</tr>
</table>


<h2>DIFFERENCES BETWEEN x86 AND x86_64</h2>

<ul>
<li>Pointers and long integers are 64 bit long. Integer arithmetic operations
    support 8, 16, 32 and 64-bit data types.</li><br>

<li>
  The set of general-purpose registers is expanded from 8 to 16.</li><br>

<li>
  Much of the program state is held in registers rather than on the stack. Integer
  and pointer procedure arguments (up to 6) are passed via registers. Some
  procedures do not need to access the stack at all.</li><br>

<li>
  Conditional operations are implemetned using move instructions when possible,
  yielding better performance than traditional branching code.</li><br>

<li>
  Floating-point operations are implemented using a register-oriented instruction
  set, rather than the stack-based approach supported by IA32 (Intel implementation
  of x86).</li>
</ul>


<h2>INTEGER x86_64 ARITHMETIC OPERATIONS</h2>

NOTE: the (q) prefix is the standard for x86_64 for each instruction. But, in NASM,
      the (q) prefix give an error at compiling time.

<table>
<tr>
        <td><b>Instruction</b></td>
        <td><b>Effect</b></td>
        <td><b>Description</b></td>
</tr>
<tr>
        <td>lea(q) S,D</td>
        <td>D = &S</td>
        <td>Load effective address</td>
</tr>
<tr>
        <td>inc(q) D</td>
        <td>D = D + 1</td>
        <td>Increment</td>
</tr>
<tr>
        <td>dec(q) D</td>
        <td>D = D - 1</td>
        <td>Decrement</td>
</tr>
<tr>
        <td>neg(q) D</td>
        <td>D = !D</td>
        <td>Negate</td>
</tr>
<tr>
        <td>not(q) D</td>
        <td>D = ~D</td>
        <td>Complement</td>
</tr>
<tr>
        <td>add(q) S,D</td>
        <td>D = D + S</td>
        <td>Add</td>
</tr>
<tr>
        <td>sub(q) S,D</td>
        <td>D = D - S</td>
        <td>Substract</td>
</tr>
<tr>
        <td>imul(q) S,D</td>
        <td>D = D * S</td>
        <td>Multiply (signed)</td>
</tr>
<tr>
        <td>mul(q) S,D</td>
        <td>D = D * S</td>
        <td>Multiply (unsigned)</td>
</tr>
<tr>
        <td>idiv(q) S,D</td>
        <td>D = D / S</td>
        <td>Divide (signed)</td>
</tr>
<tr>
        <td>div(q) S,D</td>
        <td>D = D / S</td>
        <td>Divide (unsigned)</td>
</tr>
<tr>
        <td>xor(q) S,D</td>
        <td>D = D ^ S</td>
        <td>Exclusive-or</td>
</tr>
<tr>
        <td>or(q) S,D</td>
        <td>D = D | S</td>
        <td>Or</td>
</tr>
<tr>
        <td>and(q) S,D</td>
        <td>D = D &amp; S</td>
        <td>And</td>
</tr>
<tr>
        <td>sal(q) k,D</td>
        <td>D = D &lt;&lt; k</td>
        <td>Left shift</td>
</tr>
<tr>
        <td>sal(q) k,D</td>
        <td>D = D &lt;&lt; k</td>
        <td>Left shift</td>
</tr>
<tr>
        <td>shl(q) k,D</td>
        <td>D = D &lt;&lt; k</td>
        <td>Left shift (same as sal(q))</td>
</tr>
<tr>
        <td>sar(q) k,D</td>
        <td>D = D &gt;&gt; k</td>
        <td>Arithmetic right shift</td>
</tr>
<tr>
        <td>shr(q) k,D</td>
        <td>D = D &gt;&gt; k</td>
        <td>Logical right shift</td>
</tr>
</table>

<br>
<h2>x86_64 CONTROL INSTRUCTIONS</h2>
<table>
<tr>
        <td><b>Instruction</b></td>
        <td><b>Effect</b></td>
        <td><b>Description</b></td>
</tr>
<tr>
        <td>cmp(q) S2,S1</td>
        <td>S1 - S2</td>
        <td>Compare quad words</td>
</tr>
<tr>
        <td>test(q) S2,S1</td>
        <td>S1 & S2</td>
        <td>Test quad words</td>
</tr>
<tr>
        <td>jg (or jmp)</td>
        <td></td>
        <td>Jump (like C goto)</td>
</tr>
<tr>
        <td>cmove S,D</td>
        <td></td>
        <td>Equal / zero</td>
</tr>
<tr>
        <td>cmovne S,D</td>
        <td></td>
        <td>Not equal / not zero</td>
</tr>
<tr>
        <td>cmovs S,D</td>
        <td></td>
        <td>Negative</td>
</tr>
<tr>
        <td>cmovns S,D</td>
        <td></td>
        <td>Non negative</td>
</tr>
<tr>
        <td>cmovg S,D</td>
        <td></td>
        <td>Greater (signed)</td>
</tr>
<tr>
        <td>cmovge S,D</td>
        <td></td>
        <td>Greater or equal (signed)</td>
</tr>
<tr>
        <td>cmovl S,D</td>
        <td></td>
        <td>Less (signed)</td>
</tr>
<tr>
        <td>cmovle S,D</td>
        <td></td>
        <td>Less or equal (signed)</td>
</tr>
<tr>
        <td>cmova S,D</td>
        <td></td>
        <td>Above (unsigned)</td>
</tr>
<tr>
        <td>cmovae S,D</td>
        <td></td>
        <td>Above or equal (unsigned)</td>
</tr>
<tr>
        <td>cmovb S,D</td>
        <td></td>
        <td>Below (unsigned)</td>
</tr>
<tr>
        <td>cmovbe S,D</td>
        <td></td>
        <td>Below or equal (unsigned)</td>
</tr>
</table>
