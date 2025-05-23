IO MACRO X,Y
   MOV AH,X
   LEA DX,Y
   INT 21H
   ENDM
DATAS SEGMENT USE16
    N EQU 20
    BUF1 DB N+1
    COUNT1 DB 0
    STR1 DB N+1 DUP(0)
    BUF2 DB N+1
    COUNT2 DB 0
    STR2 DB N+1 DUP(0)
    OUT1 DB 'THE STRING IS MATCH','$'
    OUT2 DB 'THE STRING IS NOT MATCH','$'
    PROMPT1  DB 'Please input string1: ','$'
    PROMPT2  DB 'Please input string2: ','$'
    CRLF  DB 13,10,'$'
DATAS ENDS

STACKS SEGMENT USE16
   ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT USE16
   ASSUME CS:CODES,DS:DATAS,SS:STACKS

START:
    MOV AX,DATAS
    MOV DS,AX
    MOV ES,AX

    IO 9,PROMPT1
    IO 0AH,BUF1
    IO 09H,CRLF
    IO 9,PROMPT2
    IO 0AH,BUF2
    IO 09H,CRLF
    MOV AL,COUNT1
    MOV BL,COUNT2
    CMP AL,BL
    JNZ L
    LEA SI,STR1
    LEA DI,STR2
    MOV CL,COUNT1
    CLD
    REPZ CMPSB
    JNZ L
    IO 09H,OUT1
    JMP EXIT

L:    IO 9H,OUT2  
EXIT: IO 9H,CRLF
    MOV AH,4CH
    INT 21H
CODES ENDS
   END START
