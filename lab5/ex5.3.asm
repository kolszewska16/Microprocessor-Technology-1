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

	;-1000
	ldi r17, high(-1000)
	ldi r16, low(-1000)
	;250
	ldi r19, high(250)
	ldi r18, low(250)

	;1000
;	ldi r17, high(1000)
;	ldi r16, low(1000)
	;250
;	ldi r19, high(250)
;	ldi r18, low(250)

	sub r16, r18
	sbc r17, r19

	brvc no_overflow
	sbi portc, 0	;portc b0 set => overflow

no_overflow:
	brge positive	;portc b1 set => negative

	sbi portc, 1
	com r17
	com r16
	ldi r18, 1
	add r16, r18

positive:
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