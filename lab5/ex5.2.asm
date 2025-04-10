start:
	;-318 on 2 registers
	ldi r21, 0xFE	;high byte
	ldi r20, 0xC2	;low byte

	;271 on 2 registers
	ldi r23, 0x01	;high byte
	ldi r22, 0x0F	;low byte

	sub r20, r22	;subtract low byte
	sbc r21, r23	;subtract high byte (with carry)

loop:
	rjmp loop