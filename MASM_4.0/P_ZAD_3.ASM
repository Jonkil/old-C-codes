include io.asm

stack segment stack
	DB 138 dup(?)
stack ends
data segment
	NT DW 100		;��������� ���-�� ��������
	T DB 99 dup (?),'$'	;�������� �����
	C1 DB 'Enter some letters no more 100 and put the point','$'
	C2 DB 'Your letters follow is','$'
	C3 DB 'Transformation #','$'
data ends

code segment
	assume ss:stack, ds:data, cs:code

;��������� �������������� �1 - Big To Small
BTS	PROC
	OUTCH '1'
	push SI
	push CX

	mov SI,0
	mov CX,[BP]
NEXT2:	CMP BYTE PTR [BX][SI],'A'
	JB NOBLAT
	CMP BYTE PTR [BX][SI],'Z'
	JA NOBLAT
	SUB BYTE PTR [BX][SI],'A'
	ADD BYTE PTR [BX][SI],'a'
NOBLAT:	INC SI
	LOOP NEXT2

	pop CX
	pop SI
	RET
BTS	ENDP

;��������� �������������� �2 - Delete Double Lat
DDL	PROC
	OUTCH '2'
	push DI
	push SI
	push AX
	push CX

	mov DI,0
	mov SI,1
	mov CX,[BP]
NEXT3:	mov AL,[BX][SI]
	CMP BYTE PTR [BX][DI],AL
	JE DELLAT
	INC DI
	mov AL,[BX][SI]
	mov BYTE PTR [BX][DI],AL
DELLAT: INC SI
	LOOP NEXT3
	INC DI
	mov BYTE PTR [BX][DI],'$'
	mov AL,[DI]
	mov BYTE PTR [BP],AL

	pop CX
	pop AX
	pop SI
	pop DI
	RET
DDL	ENDP


start:	mov AX,data
	mov DS,AX		;�������� �������� data

	LEA DX,C1
	OUTSTR
	NEWLINE

	mov CX,NT		;������ ����� ��������� ������
	mov SI,0
	OUTCH '>'

INT:	INCH AL
	CMP AL,'.'
	JE ENDT
	mov T[SI],AL
	INC SI
	LOOP INT 
ENDT:	mov T[SI],'$'
	DEC SI
	mov NT,SI		;��������� ���-�� ��������

	NEWLINE
	LEA DX,C2
	OUTSTR

	NEWLINE
	OUTCH ' '
	mov DX,offset T
	OUTSTR			;����� �� ����� ��������� ������

	NEWLINE
	NEWLINE
	LEA DX,C3
	OUTSTR

;�������� ������ �� ���������� �� ����� 3 ���. ����
	mov AL,0		;����� ���. ����
	mov SI,0
	mov CX,NT
NEXT1:	CMP T[SI],'a'
	JB NOSLAT
	CMP T[SI],'z'
	JA NOSLAT
	JMP YESLAT
NOSLAT:	CMP T[SI],'A'
	JB NOLAT
	CMP T[SI],'Z'
	JA NOLAT
YESLAT:	INC AL
	CMP AL,3
	JE PRAV1
NOLAT:	INC SI
	LOOP NEXT1

	LEA BP,NT
	LEA BX,T
	CALL DDL		;������� �� ������� 2
	JMP ENDING

PRAV1:	LEA BP,NT
	LEA BX,T
	CALL BTS		;������� �� ������� 1

ENDING:	NEWLINE
	OUTCH ' '
	LEA DX,T
	OUTSTR			;���������� ����������
	NEWLINE

	FINISH
code ends

	END start
