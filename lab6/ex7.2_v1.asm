.include "m328PBdef.inc"

.org 0
jmp main 

.org 0x100
jmp pcint0_isr

main:
	ldi r16, LOW(RAMEND) 
	out spl, r16
	ldi r16, HIGH(RAMEND)
	out sph, r16

	sbi ddrb, 5 
	sbi portb, 7 
	
	ldi r20, (1<<PCIE0)
	sts pcicr, r20
	
	ldi r20, (1<<PCINT7)
	sts pcmsk0, r20

	sei 

stop:
	jmp stop 

pcint0_isr:
	in r21, pinb 
	ldi r22, (1<<5)
	eor r26, r22 
	out portb, r26

	reti