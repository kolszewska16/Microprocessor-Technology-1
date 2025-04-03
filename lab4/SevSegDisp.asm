.include "m328pbdef.inc"

.CSEG
.org 0x00

rjmp start

.CSEG
.org 0x32
num: .DB 0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B, 0x77, 0x1F, 0x4E, 0x3D, 0x4F, 0x47

.CSEG
.org 0x100

start:
	ldi r16, 0xFF
	out ddrb, r16	;direction of portb - output
	out ddrd, r16	;direction of portd - output

;	ldi r16, 0b1000
	ldi r16, 0x08
	com r16
	out portb, r16

	ldi ZH, high(2*num)
	ldi ZL, low(2*num)

loop:
	lpm r16, Z+
	com r16
	out portd, r16

	call delay

	cpi ZL, low(2*num+16)
	brne loop
	cpi ZH, high(2*num+16)
	brne loop

	ldi ZL, low(2*num)
	ldi ZH, high(2*num)
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
