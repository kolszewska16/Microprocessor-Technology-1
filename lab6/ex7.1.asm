#include "m328PBdef.inc"

.org 0
jmp main ;skip vector table

.org 0x100
jmp int0_isr

main:
	ldi r16, LOW(RAMEND) ;initialize stack for ISR
	out spl, r16
	ldi r16, HIGH(RAMEND)
	out sph, r16
	sbi ddrb, 5 ;portb.5 is output (led0)
	sbi portd, 2 ;pull-up enable for portd.2
	ldi r20, (1<<INT0)
	out eimsk, r20 ;enable int0
	ldi r20, (1<<ISC01)
	sts eicra, r20 ;set int0 active on falling edge
	sei ;enable interrupts

stop:
	jmp stop ;stay forever

int0_isr:
	in r21, pinb ;read portb
	ldi r22, 0x20
	eor r21, r22 ;toggle bit 5
	out portb, r21
	reti