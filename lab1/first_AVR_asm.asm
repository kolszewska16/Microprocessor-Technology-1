start:
	.EQU decimal = 16
	.EQU hex = 0x18
	.EQU binary = 0b10011010
	.EQU ascii = 'M'

	ldi r16, decimal
	ldi r17, hex
	ldi r18, binary
	ldi r19, ascii

stop: rjmp stop
