start:
	ldi r16, 0xFF
	out 0x04, r16	;direction of portb - output

	ldi r16, 0xFF
	out 0x04, r16

	ldi r17, 0b10101010
	out 0x05, r17

stop: rjmp stop
