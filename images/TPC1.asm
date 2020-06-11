	.eqv	print_int, 1
	.eqv	print_str, 4
	.eqv	read_int, 5
	.eqv	exit, 10
	.eqv	print_char, 11
	
	.data
	
nlen:	.asciiz	"Numero de termos? "
sfibo:	.asciiz	"Serie de Fibonacci: "
	
	.text
	.globl main
	
main:	la	$a0, nlen
	li	$v0, print_str
	syscall
	
	li	$v0, read_int
	syscall
	
	move	$t0, $v0		# $t0 = n
	
	la	$a0, sfibo
	li	$v0, print_str
	syscall
	
	li	$t1, 0			# $t1 = 0
	
for:	bge	$t1, $t0, done1
	move	$a0, $t1	
	jal	fibo
	move	$a0, $v0		# $a0 = fibo($t1)
	
	li	$v0, print_int
	syscall
	
	li	$a0, ','
	li	$v0, print_char
	syscall
	
	add	$t1, $t1, 1
	j	for
	
done1:	li	$v0, exit
	syscall

fibo:	add	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$t0, 4($sp)
	sw	$t1, 8($sp)
	
	move	$t0, $a0
	
	ble	$a0, 1, done
	
	add	$a0, $t0, -1
	jal	fibo
	
	move	$t1, $v0		# $t1 = aux
	
	add	$a0, $t0, -2
	jal	fibo
	
	add	$v0, $t1, $v0
	
	lw	$ra, 0($sp)	
	lw	$t0, 4($sp)
	lw	$t1, 8($sp)
	add	$sp, $sp, 12
	jr	$ra

done:	move	$v0, $a0
	lw	$ra, 0($sp)	
	lw	$t0, 4($sp)
	lw	$t1, 8($sp)
	add	$sp, $sp, 12
	jr	$ra
