.include "m328PBdef.inc"

.org 0
jmp main ;skip vector table

.org 0x100
jmp int0_isr

main:
	ldi r16, LOW(RAMEND) 
	out spl, r16
	ldi r16, HIGH(RAMEND)
	out sph, r16
	sbi ddrb, 5 
	sbi portd, 2 
	ldi r20, (1<<INT0)
	out eimsk, r20 
	ldi r20, (1<<ISC01)
	sts eicra, r20 
	sei 

stop:
	jmp stop 

int0_isr:
	in r21, pinb 
	ldi r22, 0x20
	eor r21, r22 
	out portb, r21
	reti