.include"m328pbdef.inc"

.CSEG
.org 0x00
rjmp start

.CSEG
.org 0x32
num: .DB 0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B, 0x77, 0x1F, 0x4E, 0x3D, 0x4F, 0x47

.CSEG
.org 0x100
start:
	ldi r16, 0xFF
	out ddrb, r16	;direction of portb - output and choosing the display
	out ddrd, r16	;direction of portd - output and choosing the number
	out ddrc, r16	;direction of portc - output and "showing" the flags

	;100
	ldi r17, high(100)
	ldi r16, low(100)

	;-100
;	ldi r17, high(-100)
;	ldi r16, low(-100)

	ldi r18, 32
	sub r16, r18
	ldi r19, 0
	sbc r17, r19

	brvc no_overflow
	sbi portc, 0	;portc b0 set => overflow

no_overflow:
	brge positive

	sbi portc, 1	;portc b1 set => negative
	com r17
	com r16
	ldi r18, 1
	add r16, r18

positive:
	mov r18, r16
	mov r19, r17
	lsr r16			;1/2
	ror r17			;1/2 with carry
	lsr r18			;1/2
	lsr r19			;1/2 with carry
	lsr r18			;1/4
	lsr r19			;1/4 with carry
	lsr r18			;1/8
	lsr r19			;1/8 with carry
	lsr r18			;1/16
	lsr r19			;1/16 with carry
	add r16, r18
	adc r17, r19

	call display
	rjmp start

display:
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r28

	;units
	mov r20, r16
	andi r20, 0x0F
	ldi ZL, low(2*num)
	ldi ZH, high(2*num)
	add ZL, r20
	lpm r21, Z
	com r21

	ldi r22, 0b11110111
	out portb, r22
	out portd, r21

	call delay

	;tens
	mov r20, r16
	swap r20
	andi r20, 0x0F
	ldi ZL, low(2*num)
	ldi ZH, high(2*num)
	add ZL, r20
	lpm r23, Z
	com r23

	ldi r24, 0b11111011
	out portb, r24
	out portd, r23
	
	call delay
	
	;hundreds
	mov r20, r17
	andi r20, 0x0F
	ldi ZL, low(2*num)
	ldi ZH, high(2*num)
	add ZL, r20
	lpm r25, Z
	com r25
	
	ldi r26, 0b11111101
	out portb, r26
	out portd, r25

	call delay

	;thousands
	mov r20, r17
	swap r20
	andi r20, 0x0F
	ldi ZL, low(2*num)
	ldi ZH, high(2*num)
	add ZL, r20
	lpm r27, Z
	com r27
	
	ldi r28, 0b11111110
	out portb, r28
	out portd, r27

	call delay

	pop r28
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	
	ret

delay:
	push r24
	push r25

	ldi r24, 100
outer:
	ldi r25, 255
inner:
	dec r25
	brne inner
	dec r24
	brne outer

	pop r25
	pop r24

	ret