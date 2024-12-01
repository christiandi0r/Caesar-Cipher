# Developed by: David Mangaoang, John Stewart, Michael Kaitel, David Agekyan, Christian Ruelas
# CS 2640 - Computer Organization and Assembly Programming 
#
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
encryptAmount: .asciiz "Enter the amount to encrypt by: "
decryptAmount: .asciiz "Enter the amount to decrypt by: "
encryptDone: .asciiz "Here is the encrypted message: "

error: .asciiz "Sorry that is an invalid input, please try again\n"


string: .space 200	#string of 200 bytes


# Exit macro
.macro exit

	li $v0, 10
	syscall
	
.end_macro 

# Newline macro
.macro newline
	
	li $v0, 4
	la $a0, newline
	syscall
	
.end_macro 

# Seperator macro
.macro separator

	li $v0, 4
	la $a0, separator
	syscall

.end_macro 

# Menu macro
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

#print string macro
.macro printString(%str)

	li $v0, 4
	la $a0, %str
	syscall

.end_macro

# User input macro for encrypted/decrypted message
.macro getString
	
	#Get user input (string)
	li $v0, 8
	la $a0, string	#a0 for the buffer
	li $a1, 200	#a1 for the string length, 200 characters
	syscall
.end_macro

.macro getInt
	li $v0, 5
	syscall
	move $t0, $v0
.end_macro

.text
main:
	menu
	
	separator
	
	newline
	
	# Checks user input, if 1 go to encrypt, if 2 go to decrypt, if 3 go to exit
	beq $t0, 1, encrypt
	beq $t0, 2, decrypt
	beq $t0, 3, exit
	printString(error)
	j main
	

encrypt:
	
	# Prompt the user to input a message to encrypt
	printString(encryptInput)
	# Get user input
	getString
	
	# Prompt the user for encrytion amount
	printString(encryptAmount)
	getInt
	
	
	la $s0, string	#load adress of the string to $s0
	
	li $t1, 'a'		#load the ascii values of both upper and lower case A and Z for logic gates
	li $t2, 'z'
	li $t3, 'A'
	li $t4, 'Z'
	li $t5, 32		#to allow spaces in the string the program needs to branch when it sees one
	
	li $s2, 26		#load the value to subtract the int by for overflow

encryptLoop:
	lb $s1, 0($s0)				#load the first byte of the string into $s1
	
	beq $s1, 10, doneEncrypt		#If the charicter is a null charicter then program is done, jump to done
	
	beq $s1, 32, next_char			#if there is a space go to the next charicter
	
	blt $s1, $t3, unexpectedStringItem	#If ascii < A, not a letter print error and retry

	
	bgt $s1, $t2, unexpectedStringItem	#If ascii > z, not a letter print error and retry

	
	bgt $s1, $t4, lowerCaseEncrypt		#If ascii is > Z it is most likely lowercase, move to lower case encrypt (check if not in gap)
	
	ble $s1, $t4, upperCaseEncrypt		#If acsii is <= Z it is most likely uppercase move to upper case encrypt
	
lowerCaseEncrypt:
	blt $s1, $t1, unexpectedStringItem	#IF ascii < a it is most likely not a letter, print error and retry
	
	add $s1, $s1, $t0			#add the key to the charicter to shift it to it's proper place
	bgt $s1, $t2, overflowLow			#if it is no longer a letter have it wrap around( ex. z -> a)
	sb $s1, 0($s0)				#store byte back into string
	j next_char
	
upperCaseEncrypt:
	add $s1, $s1, $t0			#add the key to the charicter to shift it to it's proper place
	bgt $s1, $t4, overflowCap			#if it is no longer a letter have it wrap around(ex. z -> a)
	sb $s1, 0($s0)				#store byte back into string
	j next_char

overflowCap:
	sub $s1, $s1, $s2			#wrap int around to overflow value
	bgt $s1, $t4, overflowCap			#check if capital letter is still over limit
	sb $s1, 0($s0)				#store byte back into string
	j next_char

overflowLow:
	sub $s1, $s1, $s2			#wrap int around to overflow value
	bgt $s1, $t2, overflowCap			#check if capital letter is still over limit
	sb $s1, 0($s0)				#store byte back into string
	j next_char
	
next_char:
	addi $s0, $s0, 1			#set up the next char in the sting and go again
	j encryptLoop

unexpectedStringItem:
	printString(error)			#print out error message and prompts user to try again
	j encrypt

doneEncrypt:
	printString(encryptDone)		#print out encrypted string and jump back to main
	printString(string)
	j main

decrypt:
	
	# Prompt the user to input a message to decrypt
	li $v0, 4
	la $a0, decryptInput
	syscall
	
	getString
	
	exit
	
exit:
	exit
