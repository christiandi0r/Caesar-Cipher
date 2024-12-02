# Caesar Cipher

## Overview

The Caesar Cipher is one of the simplest and oldest methods of encrypting messages, named after Julius Caesar, who reportedly used it to protect his military communications. This technique involves shifting the letters of the alphabet by a fixed number of places. For example, with a shift of three, the letter 'A' becomes 'D', 'B' becomes 'E', and so on. Despite its simplicity, the Caesar Cipher formed the groundwork for modern cryptographic techniques. In this repository, we'll explore how the Caesar Cipher works, its significance, and its implementation in MIPS assembly.

## Project Details

- **Developed by:** David Mangaoang, John Stewart, Michael Kaitel, David Agekyan, Christian Ruelas
- **Course:** CS 2640 - Computer Organization and Assembly Programming

## Features

- Menu-driven interface for user interaction
- Option to encrypt messages using the Caesar Cipher
- Option to decrypt messages using the Caesar Cipher
- Error handling for invalid inputs
- Preserves letter case during encryption and decryption

## Program Flow

1. **Menu Display:** The program presents a main menu with options for encryption, decryption, or exiting.
2. **User Input:** Based on the user's selection:
   - If the user selects '1', they are prompted to enter a message to encrypt.
   - If the user selects '2', they are prompted to enter a message to decrypt.
   - If the user selects '3', the program exits.
3. **Caesar Cipher Transformation:** The program shifts each alphabetic character in the message by a fixed number of positions while preserving letter case.

## Implementation Details

The program is implemented in MIPS assembly language and utilizes various instructions and techniques to handle user input, perform character shifts, and manage program flow. Key aspects include:

- Syscalls for input and output operations
- Character manipulation to perform shifts based on user-defined keys
- Case preservation for both uppercase and lowercase letters
- Error handling for unexpected inputs

## How to Use

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/Caesar-Cipher.git
