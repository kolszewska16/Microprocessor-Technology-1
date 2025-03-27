.CSEG
.ORG 0
	rjmp start

.DSEG
delay_value: .BYTE 1

.CSEG
start:
	ldi r16, 0xFF
	out 0x04, r16 ;direction of portb - output

	ldi r16, 0 ;initial value
	out 0x05, r16

	ldi r20, 41
;	sts delay_value, r20

loop:
	sts delay_value, r20
	call delay
	inc r16
	cpi r16, 64
	brne not_reset
	ldi r16, 0

not_reset:
	out 0x05, r16
	rjmp loop

delay:
	lds r17, delay_value ;outter loop counter
outer_loop:
	ldi r18, 255 ;inner loop counter
inner_loop:
	ldi r19, 255 ;most inner loop counter
inner_most_loop:
	nop
	dec r19
	brne inner_most_loop

	nop
	dec r18
	brne inner_loop

	nop
	dec r17
	brne outer_loop

	ret