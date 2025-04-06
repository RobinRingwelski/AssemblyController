JMP start

buf:	DB 0, 0, 0	; buffer for digits

start:
	MOV A, 7
	ADD A, 5        ; A = 12
	MOV B, buf+2    ; end of buffer
	CALL to_str     ; convert 12 to "12"
	MOV C, B        ; pointer to start of string
	MOV D, 232      ; output
	CALL print

	HLT

; Convert A to string, stores at B (backward), sets C = start
to_str:
	PUSH A
	PUSH B
	PUSH C
	PUSH D

.loop:
	MOV C, 0
	MOV D, A
	MOV A, 0
.loop_sub:
	CMP D, 10
	JC .done
	SUB D, 10
	INC A
	JMP .loop_sub
.done:
	MOV C, D
	ADD C, 48
	DEC B
	MOV [B], C
	CMP A, 0
	JNZ .loop

	MOV C, B

	POP D
	POP C
	POP B
	POP A
	RET

print:
	PUSH A
.loop:
	MOV A, [C]
	CMP A, 0
	JZ .end
	MOV [D], A
	INC C
	INC D
	JMP .loop
.end:
	POP A
	RET