start:
	ldi r16, 0xFF
	out 0x08, r16	;pull-up resistors

	ldi r16, 0xFF
	out 0x04, r16	;direction of portb - output

	ldi r16, 0x00
	out 0x07, r16	;direction of portc - input

	ldi r16, 0xFF
	out 0x05, r16	;initial value

loop:
	in r16, 0x06	;reading pinc
	com r16
	out 0x05, r16

	rjmp loop