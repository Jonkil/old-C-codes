  include io.asm     ;������祭�� ����権 �����-�뢮��

stack segment stack
      dw 128 dup (?)
stack ends

data  segment
; ��६���� � ����⠭��
data  ends

code segment
     assume ss:stack, ds:data, cs:code
; ��楤���   
start:
    mov ax,data
    mov ds,ax
; ������� �ணࠬ��
    finish
code ends
    end start 
