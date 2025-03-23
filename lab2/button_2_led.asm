start:
	ldi r16, 0xFF
	out 0x08, r16	;pull-up resistors

	ldi r16, 0xFF
	out 0x04, r16	;direction of portB - output

	ldi r16, 0x00
	out 0x07, r16	;direction of portC - input

	ldi r16, 0xFF
	out 0x05, r16	;initial value
loop:
	sbis 0x06, 0
	cbi 0x05, 0

	sbic 0x06, 0
	sbi 0x05, 0

	rjmp loop