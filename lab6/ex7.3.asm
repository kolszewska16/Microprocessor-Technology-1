.include "m328pbdef.inc"

.org 0
jmp main 

.org 0x0008
rjmp keypad_isr

main:
	ldi r16, LOW(RAMEND)
	out spl, r16
	ldi r16, HIGH(RAMEND)
	out sph, r16

	ldi r16, 0x3F
	out ddrb, r17	;diodes as output

	ldi r20, 0x0F	;0b001111 => 0x0F
	out ddrc, r17	;rows as input, columns as output

	ldi r20, 0x30	;0b110000 => 0x30
	out portc, r17	;pull-up

	;rows
	ldi r20, (1<<PCINT13)|(1<<PCINT12)
	sts pcmsk1, r20

	ldi r20, (1<<pcie1)
	sts pcicr, r20

	ldi r18, 0x00	;output

	sei

loop:
	call led
	rjmp loop

keypad_isr:
	ldi r20, 0
	sts pcmsk1, r20

	ldi r20, 0x30	;0b110000 => 0x30
	out ddrc, r20	;rows as output, columns as input

	ldi r20, 0x0F	;0b001111 => 0x0F
	out portc, r20	;pull-up

	in r16, pinc
	mov r18, r16
	andi r18, 0x0F

	ldi r20, 0x0F	;0b001111 => 0x0F
	out ddrc, r20	;rows as input, columns as output

	ldi r20, 0x30	;0b110000 => 0x30
	out portc, r20	;pull-up

	in r16, pinc
	andi r16, 0x30

	add r18, r16

	ldi r20, (1<<PCINT13)|(1<<PCINT12)
	sts pcmsk1, r20

	reti

led:
	out portb, r18
	ret