.include "m328pbdef.inc"

.CSEG
.org 0x00

rjmp start

.CSEG
.org 0x32
primes: .DB 2, 3, 5, 7, 11, 13, 17, 19, 23, 29

.CSEG
.org 0x100

start:
	ldi r16, 0xFF
	out ddrb, r16	;direction of portb - output

	ldi ZH, high(2*primes)
	ldi ZL, low(2*primes)

loop:
	lpm r16, Z+
	out portb, r16

	call delay

	cpi ZL, low(2*primes+10)
	brne loop
	cpi ZH, high(2*primes+10)
	brne loop

	ldi ZL, low(2*primes)
	ldi ZH, high(2*primes)
	rjmp loop

delay:
	push r17
	push r18
	push r19

	ldi r17, 41 ;outter loop counter
outer_loop:
	ldi r18, 255 ;inner loop counter
inner_loop:
	ldi r19, 255 ;most inner loop counter
inner_most_loop:
	nop
	dec r19
	brne inner_most_loop

	nop
	dec r18
	brne inner_loop

	nop
	dec r17
	brne outer_loop

	pop r19
	pop r18
	pop r17

	ret
