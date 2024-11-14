#Developed by: David Mangaoang, John Stewart, Michael Kaitel, David Agekyan, Christian Ruelas
#CS 2640
#Caesar Cipher

.data
newline: .asciiz "\n"

#Exit macro
.macro exit

	li $v0, 10
	syscall
	
.end_macro 

#Newline macro
.macro newline
	
	li $v0, 4
	la $a0, newline
	syscall
	
.end_macro 

#Menu macro
.macro menu
	
	.data
	menuPrompt: .asciiz "\n--------------- MAIN MENU ---------------\n(1)Encrypt Message\n(2)Decrypt Message"
	input: .asciiz "Enter '1' or '2' for your selection: "
	
	.text
	li $v0, 4
	la $a0, menuPrompt
	syscall
	
	newline
	
	newline
	
	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0

.end_macro


.text
main:
	menu
	
exit:
	exit
