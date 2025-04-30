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

	in r23, pinb

	sei 

stop:
	jmp stop 

pcint0_isr:
	in r21, pinb 

	mov r24, r21
	andi r24, (1<<7)

	mov r25, r23
	andi r25, (1<<7)

	cpi r25, (1<<7)
	brne end

	cpi r24, (0<<7)
	brne end

	in r26, portb
	ldi r22, (1<<5)
	eor r26, r22 
	out portb, r26

end:
	mov r23, r21
	reti