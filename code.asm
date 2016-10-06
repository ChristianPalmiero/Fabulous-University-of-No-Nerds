N EQU 630
.MODEL SMALL
.STACK
.DATA
SCORES DW N DUP (0)                                           
;I ASSUME TO HAVE 3 PROFESSORS IN THE SCORES ARRAY
C_INIT_1 DB 5, 6, 5, 5, 2, 1, 2, 3, 0, 0, 1, 4, 3, 2, 3, 4, 6, 6, 2, 0  ;C VALUES FOR PROF WITH CODE = 1
C_INIT_2 DB 0, 6, 5, 0, 1, 1, 3, 4, 4, 2, 3, 6, 5, 5, 4, 2, 1, 0, 1, 3  ;C VALUES FOR PROF WITH CODE = 2
C_INIT_3 DB 5, 5, 0, 4, 1, 0, 2, 2, 3, 1, 4, 5, 2, 3, 1, 5, 6, 6, 2, 0  ;C VALUES FOR PROF WITH CODE = 3

A_INIT_1 DB 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 6, 5, 2, 3, 4, 1, 3, 2, 0  ;A VALUES FOR PROF WITH CODE = 1 AND SO ON
A_INIT_2 DB 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6  ;PROF2 HAS AA=6 -> BONUS
A_INIT_3 DB 5, 0, 0, 0, 1, 3, 5, 2, 3, 2, 3, 6, 3, 1, 2, 3, 6, 6, 2, 0

S_INIT_1 DB 2, 3, 1, 6, 6, 5, 4, 3, 1, 3, 1, 0, 0, 0, 3, 2, 5, 5, 2, 5  ;S VALUES FOR PROF WITH CODE = 1 AND SO ON
S_INIT_2 DB 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
S_INIT_3 DB 5, 3, 0, 0, 1, 0, 5, 3, 4, 2, 0, 5, 3, 3, 1, 6, 5, 3, 2, 1

E_INIT_1 DB 4, 6, 5, 0, 2, 0, 3, 3, 1, 4, 1, 0, 6, 5, 3, 2, 1, 3, 2, 5  ;E VALUES FOR PROF WITH CODE = 1 AND SO ON
E_INIT_2 DB 6, 2, 6, 5, 6, 5, 1, 3, 2, 6, 2, 3, 5, 6, 4, 4, 0, 3, 4, 5
E_INIT_3 DB 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6

C_ARR DB 15 DUP (0)         ;array of C critirion for each professor (null entries are invalid entries)
S DB 15 DUP (0)         ;array of S critirion for each professor (null entries are invalid entries)
A DB 15 DUP (0)         ;array of A critirion for each professor (null entries are invalid entries)
E DB 15 DUP (0)         ;array of E critirion for each professor (null entries are invalid entries)
NC DB 15 DUP (0)        ;array of number of C votes for each professor (null entries are invalid entries)
NA DB 15 DUP (0)        ;array of number of S votes for each professor (null entries are invalid entries)
NS DB 15 DUP (0)        ;array of number of A votes for each professor (null entries are invalid entries)
NE_ARR DB 15 DUP (0)        ;array of number of E votes for each professor (null entries are invalid entries)
BONUS DB 15 DUP (0)     ;if bonus[i]=1, the i-th professor has obtained at least one among AC,AA,AS,AE equal to 6
AC DB 15 DUP (0)        ;array of C avg for each professor (null entries are invalid entries)
AS DB 15 DUP (0)        ;array of S avg for each professor (null entries are invalid entries)
AA DB 15 DUP (0)        ;array of A avg for each professor (null entries are invalid entries)
AE DB 15 DUP (0)        ;array of E avg for each professor (null entries are invalid entries)
PS DB 15 DUP (0)        ;array of PS for each professor (null entries are invalid entries)
BEST DB 15 DUP (0)      ;array of codes of "best" professors (null entries are invalid entries)
SUPER DB 15 DUP (0)     ;array of codes of "super" professors (null entries are invalid entries)
VAR DB ? 
MSG_AC DB "AC for professor with code ", "$"
MSG_AA DB "AA for professor with code ", "$"
MSG_AS DB "AS for professor with code ", "$"
MSG_AE DB "AE for professor with code ", "$"
MSG_PS DB "PS for professor with code ", "$"
IS DB " is: ", "$"                           
MSG_BEST DB "Best professor(s) code(s):", 0DH, 0AH, "$"
MSG_SUPER DB "Super professor(s) code(s):", 0DH, 0AH, "$" 
MSG_BONUS DB "Bonus professor(s) code(s):", 0DH, 0AH, "$" 
.CODE
.STARTUP    
MOV VAR, 3              ;# OF PROFESSORS I HAVE IN THE SCORES ARRAY
LEA DI, SCORES  
MOV BP, 1               ;PROF CODE        
XOR BX, BX
EXT_LOOP: MOV CX, 20    ;# OF ENTRIES IN THE SCORES ARRAY FOR EACH PROFESSOR        
XOR SI, SI 
INIT_CICLE: MOV AX, BP
PUSH CX
MOV CL, 12
SHL AX, CL               ;AX=pppp000...0
POP CX
OR [DI], AX   
XOR DH, DH
MOV DL, C_INIT_1[BX][SI] ;C
PUSH CX
MOV CL, 9
SHL DX, CL                ;DX=0000ccc000...0
POP CX
OR [DI], DX
XOR DH, DH
MOV DL, A_INIT_1[BX][SI] ;A
PUSH CX
MOV CL, 6
SHL DX, CL                ;DX=0000000aaa0000...0
POP CX
OR [DI], DX
XOR DH, DH
MOV DL, S_INIT_1[BX][SI] ;S
PUSH CX
MOV CL, 3
SHL DX, CL                ;DX=0000000000sss000;
POP CX
OR [DI], DX
XOR DH, DH
MOV DL, E_INIT_1[BX][SI] ;E
OR [DI], DX              ;DX=000...0eee
ADD DI, 2
INC SI
LOOP INIT_CICLE  
ADD BX, 20               ;from C_INIT_1 I move to C_INIT_2 and so on
XOR SI, SI
INC BP
DEC VAR
CMP VAR, 0
JNE EXT_LOOP    
; ITEM 1C
MOV CX, N
LEA DI, SCORES     
CICLE: MOV AX, [DI]     ;entry of scores array in AX
MOV BX, AX
PUSH CX
MOV CL, 4
SHR BH, CL               ;0000pppp in BH
POP CX
CMP BH, 0
JE AVG                  ;if pppp=0, all next entries are non valid, so I can jump to the next task (avg)
MOV BL, BH
XOR BH, BH
MOV DX, AX
SHR DH, 1
AND DH, 00000111B       ;DH<-ccc
DEC BX                  ;if pppp=1, BX=0 and so on
ADD C_ARR[BX], DH                           
CMP DH, 0               ;if ccc is not equal to 0, I increment NC[i], with i=pppp-1
JE AAAA
INC BYTE PTR NC[BX]              
AAAA: MOV DX, AX        ;next step = aaa
PUSH CX
MOV CL, 6
SHR DX, CL
POP CX
AND DL, 00000111B       ;DL<-aaa        
ADD A[BX], DL
CMP DL, 0               ;if aaa is not equal to 0, I increment NA[i], with i=pppp-1
JE SSS
INC BYTE PTR NA[BX]
SSS: MOV DX, AX         ;next step = sss
PUSH CX
MOV CL, 3
SHR DX, CL
POP CX
AND DL, 00000111B       ;DL<-sss
ADD S[BX], DL
CMP DL, 0               ;if sss is not equal to 0, I increment NS[i], with i=pppp-1
JE EEE
INC BYTE PTR NS[BX]   
EEE: MOV DX, AX         ;next step = eee
AND DL, 00000111B       ;DL<-eee
ADD E[BX], DL
CMP DL, 0               ;if eee is not equal to 0, I increment NE_ARR[i], with i=pppp-1
JE END_FILL
INC BYTE PTR NE_ARR[BX]
END_FILL: ADD DI, 2
LOOP CICLE              
;once the arrays C_ARR,A,S,E,NC,NA.NS,NE_ARR are filled, I compute  AC,AA,AS,AE for each professor
AVG: MOV CX, 15
XOR BX, BX
XOR DX, DX
COMPUTE: LEA DI, C_ARR
LEA SI, NC
ADD DI, DX
ADD SI, DX
MOV AL, [DI]            ;AL<-C[i]
CMP AL, 0               ;if C[i]=0, I can jump to the next task (ps)
JE PS_
XOR AH, AH
PUSH CX
MOV CL, 5
SHL AX, CL               ;5 bits for the fractional part are reserved   
POP CX
PUSH BX
MOV BL, [SI]            ;BL<-NC[i]
DIV BL 
POP BX
MOV AC[BX], AL          ;AL->AC[i]
;I print AC[i]
PUSH AX    
PUSH DX
LEA DX, MSG_AC
MOV AH, 09H
INT 21H
POP DX
PUSH DX
INC DX 
ADD DL, '0'
MOV AH, 02H
INT 21H
LEA DX, IS
MOV AH, 09H
INT 21H
POP DX
POP AX
PUSH DX
MOV DL, AL
CALL PRINT
POP DX
     
JMP COMPUTE_TRICK
COMPUTE_ONE: JMP COMPUTE
COMPUTE_TRICK:

LEA DI, A
LEA SI, NA
ADD DI, DX
ADD SI, DX
MOV AL, [DI]            ;AL<-A[i]
XOR AH, AH
PUSH CX
MOV CL, 5
SHL AX, CL
POP CX 
PUSH BX
MOV BL, [SI]            ;BL<-NA[i]
DIV BL 
POP BX
MOV AA[BX], AL          ;AL->AC[i]
;I print AA[i]
PUSH AX    
PUSH DX
LEA DX, MSG_AA
MOV AH, 09H
INT 21H
POP DX
PUSH DX
INC DX 
ADD DL, '0'
MOV AH, 02H
INT 21H
LEA DX, IS
MOV AH, 09H
INT 21H
POP DX
POP AX
PUSH DX
MOV DL, AL
CALL PRINT
POP DX     

JMP COMPUTE_TRICK_TWO
COMPUTE_TWO: JMP COMPUTE_ONE
COMPUTE_TRICK_TWO:

LEA DI, S
LEA SI, NS
ADD DI, DX
ADD SI, DX
MOV AL, [DI]            ;AL<-S[i]
XOR AH, AH
PUSH CX
MOV CL, 5
SHL AX, CL
POP CX
PUSH BX
MOV BL, [SI]            ;BL<-NS[i]
DIV BL 
POP BX
MOV AS[BX], AL          ;AL->AS[i] 
;I print AS[i]
PUSH AX    
PUSH DX
LEA DX, MSG_AS
MOV AH, 09H
INT 21H
POP DX
PUSH DX
INC DX 
ADD DL, '0'
MOV AH, 02H
INT 21H
LEA DX, IS
MOV AH, 09H
INT 21H
POP DX
POP AX
PUSH DX
MOV DL, AL
CALL PRINT
POP DX

JMP COMPUTE_TRICK_THREE
COMPUTE_THREE: JMP COMPUTE_TWO
COMPUTE_TRICK_THREE:

LEA DI, E
LEA SI, NE_ARR
ADD DI, DX
ADD SI, DX
MOV AL, [DI]            ;AL<-E[i]
XOR AH, AH
PUSH CX
MOV CL, 5
SHL AX, CL
POP CX
PUSH BX
MOV BL, [SI]            ;BL<-NE_ARR[i]
DIV BL 
POP BX
MOV AE[BX], AL          ;AL->AE[i]
;I print AE[i]
PUSH AX    
PUSH DX
LEA DX, MSG_AE
MOV AH, 09H
INT 21H
POP DX
PUSH DX
INC DX 
ADD DL, '0'
MOV AH, 02H
INT 21H
LEA DX, IS
MOV AH, 09H
INT 21H
POP DX
POP AX
PUSH DX
MOV DL, AL
CALL PRINT
POP DX
              
INC DX
INC BX                  ;i=i+1
LOOP COMPUTE_THREE            
;now I compute PS for each professor. PS = (C_ARR+A+S+E)/(NC+NA+NS+NE_ARR)
PS_: MOV CX, 15
XOR DI, DI
NEXT_PS: XOR AX, AX
XOR BX, BX
ADD AL, C_ARR[DI] 
ADC AH,0
CMP AL, 0
JE ITEM2
ADD AL, A[DI]
ADC AH, 0
ADD AL, S[DI]
ADC AH, 0
ADD AL, E[DI]
ADC AH, 0                ;AX = C[i] + A[i] + S[i] + E[i]
ADD BL, NC[DI]
ADD BL, NA[DI]
ADD BL, NS[DI]
ADD BL, NE_ARR[DI]           ;BL = NC[i] + NA[i] + NS[i] + NE_ARR[i]
PUSH CX
MOV CL, 5
SHL AX, CL
POP CX
DIV BL
MOV PS[DI], AL           ;AL = quotient with 3 integer bits + 5 fractional bits       AL->PS[i]
;I print PS[i]
PUSH AX    
PUSH DX
LEA DX, MSG_PS
MOV AH, 09H
INT 21H
POP DX
PUSH DX
MOV DX, DI
INC DX 
ADD DL, '0'
MOV AH, 02H
INT 21H
LEA DX, IS
MOV AH, 09H
INT 21H
POP DX
POP AX
PUSH DX
MOV DL, AL
CALL PRINT
POP DX 

INC DI
LOOP NEXT_PS
ITEM2: MOV CX, 15
LEA SI, PS
XOR BX, BX               ;BL = initial max = 0
COMPUTE_ITEM_2: MOV AL, [SI]      ;AL contains PS[i]
CMP AL, 0
JE ITEM_2_2ND_PART
CMP AL, BL               
JBE NEXT_ROW             ;if ps[i]<=MAX, jump. Otherwise, update max
MOV BL, AL
NEXT_ROW: INC SI
LOOP COMPUTE_ITEM_2
ITEM_2_2ND_PART:         ;In BL I have the max PS
LEA SI, PS
MOV CX, 15     
LEA DI, PS
PUSH DX
PUSH AX
LEA DX,MSG_BEST
MOV AH, 09H
INT 21H
POP AX
POP DX 
PRINT_BEST: MOV AL, [SI]     
CMP AL, 0
JE ITEM3
CMP BL, AL
JNE LOOP_BEST
;I have to print the code of the prof. whose PS=MAX(PS)
MOV DX, SI
SUB DX, DI
INC DX
;Print DL
PUSH AX
PUSH DX
ADD DL, '0'
MOV AH, 02H
INT 21H
MOV DL, 0DH
INT 21H
MOV DL, 0AH
INT 21H
PUSH DX
PUSH AX
LOOP_BEST: INC SI
LOOP PRINT_BEST
ITEM3: PUSH DX
PUSH AX
LEA DX,MSG_SUPER
MOV AH, 09H
INT 21H
POP AX
POP DX
MOV CX, 15
LEA SI, PS
XOR DX, DX
XOR DI, DI               ;DI=k
INC DX                   ;DX=prof code
MOV BL, 10011000B        ;BL = 4.75 (100.11000 in base 2)
COMPUTE_ITEM_3: MOV AL, [SI]
CMP AL, 0
JE BONUS_
CMP AL, BL
JB NEXT_ITEM_3           ;if AL=PS[i] < 4.75, jump. Otherwise, fill super[k] with the code of the current prof and increment k
MOV SUPER[DI], DL
;Print DL
PUSH AX
PUSH DX
ADD DL, '0'
MOV AH, 02H
INT 21H
MOV DL, 0DH
INT 21H
MOV DL, 0AH
INT 21H
PUSH DX
PUSH AX
INC DI
NEXT_ITEM_3: INC SI
INC DX
LOOP COMPUTE_ITEM_3
BONUS_: MOV CX, 15
XOR BX, BX               ;BX= i = prof code-1
COMPUTE_BONUS: LEA SI, AC
ADD SI, BX
MOV AL, [SI]
PUSH CX
MOV CL, 5
SHR AL, CL
POP CX
CMP AL, 6                ;if the integer part of AC is equal to 6, jump. Otherwise, do the same procedure for AA, AS, AE
JE NEXT_PROF
CMP AL, 0
JE END_PROG  
LEA SI, AA
ADD SI, BX
MOV AL, [SI]
PUSH CX
MOV CL, 5
SHR AL, CL
POP CX
CMP AL, 6
JE NEXT_PROF
CMP AL, 0
JE END_PROG
LEA SI, AS
ADD SI, BX
MOV AL, [SI]
PUSH CX
MOV CL, 5
SHR AL, CL
POP CX
CMP AL, 6
JE NEXT_PROF
CMP AL, 0
JE END_PROG
LEA SI, AE
ADD SI, BX
MOV AL, [SI]
PUSH CX
MOV CL, 5
SHR AL, CL
POP CX
CMP AL, 6
JE NEXT_PROF
CMP AL, 0
JE END_PROG
JMP LOOP_BONUS
NEXT_PROF: LEA DI, BONUS ;Bonus[i] is set to 1
ADD DI, BX
MOV [DI], BYTE PTR 1
LOOP_BONUS: INC BX
LOOP COMPUTE_BONUS
END_PROG:PUSH DX
PUSH AX
LEA DX,MSG_BONUS
MOV AH, 09H
INT 21H
POP AX
POP DX
MOV CX, 15
LEA DI, BONUS
PRINT_BON: CMP BYTE PTR [DI], 1
JNE NEXT_B
;Print DI+1
PUSH AX
PUSH DX
MOV DX, DI
LEA AX, BONUS
SUB DX, AX
INC DL
ADD DL, '0'
MOV AH, 02H
INT 21H
MOV DL, 0DH
INT 21H
MOV DL, 0AH
INT 21H
PUSH DX
PUSH AX
NEXT_B: INC DI
LOOP PRINT_BON
.EXIT      

;The following procedure receives in DL a positive number with 3 integer bits and 5 fractional bits and prints its ASCII representation
PRINT PROC 
PUSH AX 
PUSH BX
PUSH CX 
PUSH DX         
;First, the integer digit is printed (3 bits-->0-7)
MOV BL, DL
PUSH CX
MOV CL, 5
SHR DL, CL
POP CX
ADD DL, '0'
MOV AH, 02H
INT 21H
MOV DL, '.'
INT 21H
;Then, the 5 fractional bits are converted in a decimal representation and the 5 fractional digits are printed 
MOV CX, 5  
fr:XOR BH, BH     
AND BL, 00011111b 
MOV AL, BL
MOV DL, 10
MUL DL 
PUSH AX  
PUSH CX
MOV CL, 5
SHR AX, CL
POP CX
MOV DL, AL
ADD DL, '0'
MOV AH, 02H
INT 21H
POP BX 
LOOP FR 
MOV DL, 0DH ;print a CR 
MOV AH, 2 
INT 21H ;print a LF 
MOV DL, 0AH 
INT 21H 
POP DX
POP CX 
POP BX 
POP AX
RET
PRINT ENDP

END