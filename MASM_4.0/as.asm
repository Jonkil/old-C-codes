{\rtf1\ansi\ansicpg1251\deff0\deflang1049{\fonttbl{\f0\fswiss\fcharset204{\*\fname Arial;}Arial CYR;}{\f1\fswiss\fcharset0 Arial;}}
{\*\generator Msftedit 5.41.15.1503;}\viewkind4\uc1\pard\f0\fs20 include io.asm\par
\par
stack segment stack\par
  DB 138 dup(?)\par
stack ends   \par
\par
data segment\par
   x DB 100 dup(?),'$'\par
   y DB 100 dup(?)\par
\lang1033\f1    z DB 100 dup(?)\lang1049\f0\par
   b DB 'VVEDITE TEXT NE BOLEE 100 SYMBOLOV!','$'\par
   a DB 'VVEDENNIY TEXT!!!','$'\par
   c DB '1','$'\par
   k DB '2','$'\par
data ends\par
\par
code segment\par
assume ss:stack,ds:data,cs:code\par
\par
replacement PROC\par
 push AX\par
 o:mov AL,[BX]\par
 CMP AL,'1'\par
 JB net;<'1'\par
 CMP AL,'9'\par
 JA net;>'9'\par
 SUB AL,'0'\par
 ADD AL,'a'\par
DEC AL\par
 MOV AH,AL\par
 mov [BX],AH;zamena\par
 net: \par
 INC BX\par
 LOOP o\par
 pop AX\par
 RET\par
replacement ENDP\par
\par
\par
\lang1033\f1 change \lang1049\f0  PROC\par
push AX\lang1033\f1\par
O:\lang1049\f0 mov AL,[BX]\par
\lang1033\f1 cmp AL,'1'\par
JB da\par
cmp AL,'9'\par
JA da\lang1049\f0\par
mov [SI],AL\par
\lang1033\f1 INC SI\par
jmp KON\lang1049\f0\par
\lang1033\f1 da:\par
mov[DI],AL\par
INC DI\par
KON:INC BX\par
LOOP O\par
\lang1049\f0 pop AX\par
 RET\par
\lang1033\f1 change \lang1049\f0  ENDP\par
\par
out PROC\par
PUSH AX\par
push DX\par
LEA DX,a\par
OUTSTR\par
newline\par
S:MOV AL,[BX]\par
OUTCH AL\par
INC BX\par
LOOP S\par
NEWLINE\par
pop DX\par
POP AX\par
RET\par
out ENDP\par
\par
\par
\par
start:   mov AX,data\par
\tab  mov DS,AX\par
    LEA DX,b\par
    OUTSTR \par
    newline\par
    mov CX,100\par
    mov BX,0\par
    mov DX,0\par
    m:inch AL\par
    CMP AL,'.'\par
    JE h\par
    mov x[BX],AL\par
    INC BX\par
    INC DX\par
    LOOP m\par
    h:MOV CX,DX\par
    LEA BX,x\par
    call out\par
\par
    mov CX,DX\par
\lang1033\f1 dec CX\par
\lang1049\f0 mov AL,x[\lang1033\f1 CX\lang1049\f0 ]\par
    cmp AL,'\lang1033\f1 A\lang1049\f0 '\par
    JB t;<\par
    CMP AL,'\lang1033\f1 Z\lang1049\f0 '\par
    JA t;>\par
    \lang1033\f1 mov CX,DX\par
    mov BX,0\lang1049\f0\par
\lang1033\f1     M:cmp AL,x[BX]\par
    JNE t\par
    INC BX \par
    LOOP M\lang1049\f0\par
    OUTCH c\par
    newline\par
    mov CX,DX\par
    LEA BX,x\par
    call replacement\par
    MOV CX,DX    \par
    LEA BX,x\par
    call out\par
    JMP en\par
\lang1033\f1 t:\lang1049\f0 OUTCH k\par
    newline\par
    mov CX,DX\par
    mov BX,offset x\par
    mov SI,offset y\par
   \lang1033\f1  mov DI,offset z\par
\lang1049\f0  call \lang1033\f1 change\lang1049\f0\par
    MOV CX,DX\par
    LEA BX,y\par
    call out\par
\lang1033\f1    MOV CX,DX\par
   LEA BX,z\par
    call out\lang1049\f0\par
 \lang1033\f1 en:\lang1049\f0  FINISH\par
code ends\par
\par
\tab END start\par
\lang1033\f1 end\lang1049\f0   \par
}
 