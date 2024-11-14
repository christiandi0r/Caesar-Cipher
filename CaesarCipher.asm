#Developed by: David Mangaoang, John Stewart, Michael Kaitel, David Agekyan, Christian Ruelas
#CS 2640
# ----------------------Caesar Cipher--------------------------------
# This MIPS assembly program implements a basic Caesar Cipher menu-driven
# interface that allows the user to select between three options:
# - Encrypt a Message
# - Decrypt a Message
# - Exit the Program
#
# Program Flow:
# 1. Menu Display: The program first displays a main menu with options for
#    encryption, decryption, or exiting.
# 2. User Input: Based on the user’s input:
#    - If the user selects '1', the program prompts them to enter a message
#      to encrypt.
#    - If the user selects '2', the program prompts them to enter a message
#      to decrypt.
#    - If the user selects '3', the program exits.
# 3. Caesar Cipher Transformation: Both encryption and decryption use the
#    Caesar Cipher technique, where each alphabetic character in the message
#    is shifted by a fixed number of positions. This is implemented using MIPS
#    assembly logic to perform the shifts while preserving the case of each letter.
# --------------------------------------------------------------------

.data
menuPrompt: .asciiz "\n--------------- MAIN MENU ---------------\n(1)Encrypt Message\n(2)Decrypt Message\n(3)Exit Program"
input: .asciiz "Enter '1', '2', or '3' for your selection: "
newline: .asciiz "\n"
separator: .asciiz "-----------------------------------------"
encryptInput: .asciiz "Enter a message to encrypt: "
decryptInput: .asciiz "Enter a message to decrypt: "

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

#Seperator macro
.macro separator

	li $v0, 4
	la $a0, separator
	syscall

.end_macro 

#Menu macro
.macro menu
	
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
	
	separator
	
	newline
	
	#Checks user input, if 1 go to encrypt, if 2 go to decrypt, if 3 go to exit
	beq $t0, 1, encrypt
	beq $t0, 2, decrypt
	beq $t0, 3, exit
	

encrypt:
	
	#Prompt the user to input a message to encrypt
	li $v0, 4
	la $a0, encryptInput
	syscall
	
	exit

decrypt:
	
	#Prompt the user to input a message to decrypt
	li $v0, 4
	la $a0, decryptInput
	syscall
	
	exit
	
exit:
	exit
