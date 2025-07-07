# CRC-Error-Detection-Code
## Overview
This project focuses on error detection in communication systems using the Cyclic Redundancy Check (CRC) technique—an effective and widely adopted method known for its accuracy of up to 99.999%. The CRC mechanism is simulated through a user-typed test bench, demonstrating how data is encoded at the sender’s end and verified at the receiver’s end to detect transmission errors. 
## Principle of CRC
This method of error detection is based on division, in contrast to a checksum, which is based on sum. An encoder on the sender’s side divides the given data bits by certain bits (which are coefficients of the generator polynomial chosen wisely by the programmer, depending on the length of the data bits being transmitted) using modulo 2 division as explained below. The remainder obtained upon this division is the CRC bits augmented at the end of the data bits to be transmitted. On the receiver's end, the complete data received is the data bits along with the remainder. Thus, when this data is divided by the same bits (coefficients of the generator polynomial), using modulo 2 division, the remainder should be 0, if the data is transmitted correctly. If the remainder is non-zero, an error has occurred during transmission.
### Modulo 2 division
This method of division uses the XOR operation between the bits instead of subtraction during the division of binary numbers. This is rational as for binary numbers, addition and subtraction operations yield the same results as XORing.  
0 + 0 = 0  
1 + 0 = 1  
1 + 1 = (1) 0  
0 xor 0 = 0  
1 xor 0 = 1  
1 xor 1 = 0  
In each step, the first k bits of the dividend are XORed with the k bit divisor if the MSB of the dividend bits is 1 (else XOR the dividend bits with string of k 0s) and the next bit of the dividend is pulled down and the process is repeated till there are no further bits to be pulled down. Finally, we get the remainder consisting of k-1 bits. In this method of CRC error detection, the divisor consists of coefficients of the generator polynomial and the dividend is the data bits concatenated with k-1 zeroes so that the k-1 bit remainder obtained by the modulo division can be appended in the end and can be transmitted to the sender. On the sender’s end, modulo 2 division is performed on the transmitted data, which is data bits with the remainder added, thus, now the remainder upon division should be zero if data is transmitted correctly. The divisor bits on both the sending and receiving end are the coefficients of the generator polynomial.
### Generator Polynomial
 The generator polynomial must have a degree greater than zero and a non-zero
 coefficient in the MSB and LSB positions. A polynomial of degree n has n+1
 coefficients. These coefficients written in order from the highest degree term to the lowest degree term constitute our divisor.  
𝑥^5+𝑥^4+𝑥^2+1 is rewritten as  
1.𝑥^5+1.x^4+0.x^3+1.x^2+0.x+1 whose coefficients give 110101.  
Which is our divisor. It contains n+1 bits, here 6 bits for a polynomial of degree 5. The remainder obtained upon division will be of n bits (one less than the divisor). So there will be n CRC bits generated corresponding to a generator polynomial of degree n
## Implementation
### On the transmitter end
We have an encoder, hard-coded in VHDL language, that performs modulo 2 division on our (d + n) bits dividend, where d is the number of data bits to be transmitted and n is the number of zeroes augmented in the end of the data bits, which is also equal to the degree of the chosen generator polynomial. The remainder, also known as CRC bits, n bits long, is appended at the end of the dividend, replacing the zeroes. These (d + n) bits are now transmitted.    
**Modulo-2 division on sender's end**  
![WhatsApp Image 2025-07-07 at 12 52 34_2edb3c85](https://github.com/user-attachments/assets/f106d634-398e-43f0-b51e-490c4045b5f0)    
**Implementation of Encoder on transmitter's end**  
![WhatsApp Image 2025-07-07 at 12 52 34_e119614d](https://github.com/user-attachments/assets/faa3d8ed-b24b-4810-86db-e53941635078)  

## On the receiver's end
We have a decoder, hard-coded in VHDL, that performs modulo 2 division on the
received (d + n) bit data. Since the remainder is added to the original data, now the remainder upon division by generator polynomials on the receiver’s side should be 0, which confirms the correctness of the transmitted data. The width of the CRC plays an important role in the error detection capabilities of the algorithm. The degree of the generator polynomial depends largely on the width of the data to be transmitted. The higher the degree of the polynomial, the higher the number of CRC bits, which offers more unique combinations and thus higher accuracy. If the transmitted data is very large and the CRC bits are limited, there is a possibility of two different data bits having the same CRC bits, and hence, the receiver will not be able to detect this corrupted data. The probability of any random error being detected is 1 − 1/2𝑛, where n is the degree of the polynomial or the number of CRC bits being transmitted along with the data for error detection.  
![WhatsApp Image 2025-07-07 at 12 52 35_4dddc2f4](https://github.com/user-attachments/assets/967f93f1-0d10-4b89-8f76-a02e37c695e8)  
For the testing,  8-bit data was considered, which implies there are 2^8, i.e, 256 possible data words. A degree 8 was chosen as the generator polynomial, which offers an error detection rate of 99.6094%.  
Generator polynomial : 𝑥8 + 𝑥7 + 𝑥6 + 𝑥4 + 𝑥2 + 1  
Divisor: 111010101  
![WhatsApp Image 2025-07-07 at 12 52 34_60bcefa6](https://github.com/user-attachments/assets/059ca1c6-8604-4122-a9b9-11c5bd53f28a)  

