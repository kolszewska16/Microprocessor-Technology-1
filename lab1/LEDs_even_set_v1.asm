start:
	ldi r16, 0xFF
	out 0x04, r16	;direction of portb - output

	ldi r17, 0x00
	out 0x05, r17

	sbi 0x05, 1
	sbi 0x05, 3
	sbi 0x05, 5
	sbi 0x05, 7

stop: rjmp stop
