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
	ldi r17, 61 ;outter loop counter
outer_loop:
	ldi r18, 255 ;inner loop counter
inner_loop:
	ldi r19, 255 ;most inner loop counter
inner_most_loop:
	dec r19
	brne inner_most_loop

	dec r18
	brne inner_loop

	dec r17
	brne outer_loop

	ret