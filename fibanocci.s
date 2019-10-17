# Recursive Fibonacci program to demonstrate recursion.
# -----------------------------------------------------
# Data Declarations
.data
prompt: .ascii "Fibonacci Example Program\n\n"
.asciiz "Enter N value: "
results: .asciiz "\nFibonacci of N = "
n: .word 0
answer: .word 0
# -----------------------------------------------------
# Text/code section
.text
.globl main
.ent main
main:
# -----
# Read n value from user
li $v0, 4 # print prompt string
la $a0, prompt
syscall

li $v0, 5 # read N (as integer)
syscall
sw $v0, n
# -----
# Call Fibonacci function.
lw $a0, n
jal fib
sw $v0, answer
# -----
# Display result
li $v0, 4 # print prompt string
la $a0, results
syscall
li $v0, 1 # print integer
lw $a0, answer
syscall
# -----
# Done, terminate program.
li $v0, 10 # terminate
syscall # system call
.end main
# -----------------------------------------------------
# Fibonacci function
# Recursive definition:
# = 0 if n = 0
# = 1 if n = 1
# = fib(n-1) + fib(n-2) if n > 2
# -----
# Arguments
# $a0 - n
# Returns
# $v0 set to fib(n)
.globl fib
.ent fib
fib:
subu $sp, $sp, 8
sw $ra, ($sp)
sw $s0, 4($sp)
move $v0, $a0 # check for base cases
ble $a0, 1, fibDone
move $s0, $a0 # get fib(n-1)
sub $a0, $a0, 1
jal fib
move $a0, $s0
sub $a0, $a0, 2 # set n-2
move $s0, $v0 # save fib(n-1)
jal fib # get fib(n-2)
add $v0, $s0, $v0 # fib(n-1)+fib(n-2)
fibDone:
lw $ra, ($sp)
lw $s0, 4($sp)
addu $sp, $sp, 8
jr $ra
.end fib