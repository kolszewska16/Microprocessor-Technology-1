start:
	ldi r16, 0xFF
	out 0x04, r16 ;direction of portb - output

	ldi r16, 0 ;initial value
	out 0x05, r16

loop:
	call delay
	inc r16
	cpi r16, 64
	brne not_reset
	ldi r16, 0

not_reset:
	out 0x05, r16
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