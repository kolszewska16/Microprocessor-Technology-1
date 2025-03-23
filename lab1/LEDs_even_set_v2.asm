start:
	ldi r16, 0xFF
	out 0x04, r16	;direction of portb - output

	ldi r17, 0xFF
	out 0x05, r17

	cbi 0x05, 0
	cbi 0x05, 2
	cbi 0x05, 4
	cbi 0x05, 6

stop: rjmp stop
