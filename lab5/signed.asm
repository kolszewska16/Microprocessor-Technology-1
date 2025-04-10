start:
	ldi r16, 70
	ldi r17, 96
	add r16, r17

	ldi r17, -70
	ldi r18, -96
	add r17, r18

	ldi r18, -126
	ldi r19, 30
	add r18, r19

	ldi r19, 126
	ldi r20, -6
	add r19, r20

	ldi r20, -2
	ldi r21, -5
	add r20, r21

loop:
	rjmp loop