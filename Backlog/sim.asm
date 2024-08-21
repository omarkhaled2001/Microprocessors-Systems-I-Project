
;ARRAY_INSTRUCTIONS_NAME @ INTIAL CURSER POINT COLOMN= 0->79 & ROW=1
ARRAY_INSTRUCTIONS_NAME  db			 ' MOV  ADD  SUB  DIV  MUL  ADC  SBB  SHL  SHR  ROL  ROR  INC  DEC  AND  XOR  OR  '


;OPERAND1_ARRAY_ADDRESS_MODE_NAME @ INTIAL CURSER POINT COLOMN= 0->79 & ROW=1
OPERAND1_ARRAY_ADDRESS_MODE_NAME  db '             DIRECT             REGISTER INDIRECT             REGESTER          '

;OPERAND2_ARRAY_ADDRESS_MODE_NAME @ INTIAL CURSER POINT COLOMN= 0->79 & ROW=1
OPERAND2_ARRAY_ADDRESS_MODE_NAME  db '        DIRECT        REGISTER INDIRECT        REGESTER        IMMIDIATE        '


COMMAND_LIST DB 0 ;number to choose list 
COMMAND_FORMATION_STEPS DB 0 
GAME_LEVE DB 2 ;number to choose LEVEL 1 OR 2
COPY_SIZE DW 0

INSTRUCT DB 0;0-->F
ADDRESS_MODE1 DB 1;0-->2
ADDRESS_MODE2 DB 3;0-->2  3
OP1 DB 0;0-->F
OP2 DB 0;0-->F
IMM_OP2 DB '0000';   0000-->FFFF

GAME_GOAL DB '105E'

Memory_Update DB '00'
Memory_Location DB 0

PLAYER_1_NAME DB '               ';//15 CHARACTER MAXIMUM 
PLAYER_2_NAME DB '               ';//15 CHARACTER MAXIMUM 
PLAYER_1_SCORE DB '000' 
PLAYER_2_SCORE DB '000'
PLAYER_1_MASSAGE DB '                                                              ';//62 CHARACTER MAXIMUM 
PLAYER_2_MASSAGE DB '                                                              ';//62 CHARACTER MAXIMUM                                                                                                                            

FORBIDDEN_CHARACTER DB '0' ;//ALPHABITICAL OR NUMBERS ONLY 


;main loop:
START_SCREEEN:


	; CLICK_AGAIN:   ;TO ETER IN A VALID REGION
	;-----------------------------------------------------------
	; CALL  دوس كليك يمين
	LLLOOOPPP1:
	mov ax, 3
    int 33h   ;CANCELED
	CMP BX,1   
	JNE LLLOOOPPP1
	;-----------------------------------------------------------
	MOV AX,32 		; check that the click is in the valid region
	CMP DX,AX
	JG VVVVERT
	
	JMP HORZ_LIST
	
	
	VVVVERT:
	MOV AX,128 ; [128 --> for 8 chars] check that the click is in the valid region
	CMP CX,AX
	;CALL CHAT 
	;JMB CLICK_AGAIN
	;JUMP TO CALL CHAT TO TELL HEM TO ENTER IN A VALID REGION
	
	JG HORZ_LIST ; WE WILL REMOVE IT FROM HERE 
				 ; TO MOVE ONLY TO THE VERTICAL IF THE CONDITION IN LINE 188 IS CORRECT 
	JMP VERT_LIST
;--------------------------------------------------------------دلوقت انا ي في افقي او راسي فقط جتي لو داس في حتة تانية	
	HORZ_LIST:
	
	mov ax , cx  	; the position for INSTRUCT 0-->F 
	mov dx ,0
	MOV BX,80			   
	DIV BX  		 ;AX--> 0-->F
	mov INSTRUCT , AL
	
	;----------------------------------------------------------------------------
	; WE SHOULD REFRESH THE SCREEN TO SHOW THE SECOND ADDRESS VERTICAL BAR 

	LLLOOOPPP2:
	mov ax, 3
    int 33h
	CMP BX,1
	JNE LLLOOOPPP2
	
	mov ax , cx  	; the position for ADDRES_MODE1 0-->2
	mov dx ,0
	MOV BX,426			   
	DIV BX   		;AX--> 0-->2
	mov ADDRESS_MODE1 , AL

	;----------------------------------------------------------------------------
	; WE SHOULD REFRESH THE SCREEN TO SHOW THE THIRD INSTRUCT VERTICAL BAR 
	
	
	LLLOOOPPP3:
	mov ax, 3
    int 33h
	CMP BX,1
	JNE LLLOOOPPP3
	
		
	mov ax , cx  	; the position for INSTRUCT 0-->F 
	mov dx ,0
	MOV BX,80			   
	DIV BX  		 ;AX--> 0-->F
	mov OP1 , AL

	;----------------------------------------------------------------------------
	; WE SHOULD REFRESH THE SCREEN TO SHOW THE 4TH ADDRESS VERTICAL BAR 
	
	LLLOOOPPP4:
	mov ax, 3
    int 33h
	CMP BX,1
	JNE LLLOOOPPP4
	
	mov ax , cx 	 ; the position for ADDRES_MODE2 0-->3
	mov dx ,0
	MOV BX,320			   
	DIV BX   		;AX--> 0-->3
	mov ADDRESS_MODE2 , AL
	cmp AX , 2
	JG immediateLOOOP
	JMP OP2222

OP2222:
LLLOOOPPP5:
;----------------------------------------------------------------------------
	; WE SHOULD REFRESH THE SCREEN TO SHOW THE 5TH INSTRUCT VERTICAL BAR 
	
	mov ax, 3
    int 33h
	CMP BX,1
	JNE LLLOOOPPP5
	
	mov ax , cx  	; the position for INSTRUCT 0-->F 
	mov dx ,0
	MOV BX,80			   
	DIV BX  		 ;AX--> 0-->F
	mov OP2 , AL
	JMP EXE  
	; JMP VERT_LIST_AFTER_EXCUTION-1
	
	
immediateLOOOP:
;----------------------------------------------------------------------------
	; WE SHOULD REFRESH THE SCREEN TO SHOW THE 6TH INSTRUCT VERTICAL BAR 

LLLOOOPPP6:
	mov ax, 3
    int 33h
	CMP BX,1
	JNE LLLOOOPPP6
	 
	mov ax , cx  	; the position for INSTRUCT 0-->F 
	mov dx ,0
	MOV BX,80			   
	DIV BX  		 ;AX--> 0-->F
	ADD AL,30H       ;CONVERT TO CHAR
	mov SI , offset IMM_OP2
	mov [si] , al
	
	LLLOOOPPP7:
	mov ax, 3
    int 33h
	CMP BX,1
	JNE LLLOOOPPP7
	 
	mov ax , cx  	; the position for INSTRUCT 0-->F 
	mov dx ,0
	MOV BX,80			   
	DIV BX  		 ;AX--> 0-->F
	ADD AL,30H       ;CONVERT TO CHAR
	mov SI , offset IMM_OP2
	mov [si+1] , al
	
	LLLOOOPPP8:
	mov ax, 3
    int 33h
	CMP BX,1
	JNE LLLOOOPPP8
	 
	mov ax , cx  	; the position for INSTRUCT 0-->F 
	mov dx ,0
	MOV BX,80			   
	DIV BX  		 ;AX--> 0-->F
	ADD AL,30H       ;CONVERT TO CHAR
	mov SI , offset IMM_OP2
	mov [si+2] , al
	
	LLLOOOPPP9:
	mov ax, 3
    int 33h
	CMP BX,1
	JNE LLLOOOPPP9
	 
	mov ax , cx  	; the position for INSTRUCT 0-->F 
	mov dx ,0
	MOV BX,80			   
	DIV BX  		 ;AX--> 0-->F
	ADD AL,30H       ;CONVERT TO CHAR
	mov SI , offset IMM_OP2
	mov [si+3] , al
	
	; -----------------------------------------------------------------------
	;      WE NEED TO STORE ALL THE COMMAND IN A VARIABLE TO EXCUTE IT
	; -----------------------------------------------------------------------
	; WE NEED TO CHECK [SEND] & [CLEAR]
	; WE MAY PUT THEM IN ANOTHER COLOR TO MAKE HEM CLICK ON THEM

	;// JMB VERT_LIST_AFTER_EXCUTION-1


	;CALL EXCUTE
	EXE:
	JMP START_SCREEEN
	
	VERT_LIST:
	mov ax , dx  
	mov dx ,0
	MOV BX,32			   
	DIV BX 
	SUB AX ,1   ; as we already took 32 pixels for the horizontal line
	; STORE IN VARIABLE			
    
	; -----------------------------------------------------------------------
	;      WE NEED TO KNOW WHICH COMMAND HAS BEEN CHOOSEN TO EXCUTE IT
	;      WE WILL DO SWITCH CASES AS FOLLOWS TO KNOW
	; -----------------------------------------------------------------------

	;CMP AX , 2     ; MEANS [SEND] OR [CLEAR] HAS BEEN CLICKED
	;JL CLICK_AGAIN    ; THE [CLICK_AGAIN] IN THE FIRST OF THE PROGRAM  
	; WE ALSO NEED TO CALL CHAT TO ALERT HEM 
	; BUT I DON'T KOW HOW 
	
	;CMP AX , 3    ; IF COME HERE THEN ( AX > 1 )
	;JL EXCUTE_CHAT  ; MEANS ( AX == 2 ) --> [CHAT]
	;HERE WE NEED TO MAKE THE [EXCUTE_CHAT]
	
	;CMP AX , 4    ; IF COME HERE THEN ( AX > 2 )
	;JL POWER_UP_1  ; MEANS ( AX == 3 ) --> [POWER_UP_1]
	;HERE WE NEED TO MAKE THE [POWER_UP_1]

	;CMP AX , 5    ; IF COME HERE THEN ( AX > 3 )
	;JL POWER_UP_2  ; MEANS ( AX == 4 ) --> [POWER_UP_2]
	;HERE WE NEED TO MAKE THE [POWER_UP_2]
	
	;CMP AX , 6    ; IF COME HERE THEN ( AX > 4 )
	;JL POWER_UP_3  ; MEANS ( AX == 5 ) --> [POWER_UP_3]
	;HERE WE NEED TO MAKE THE [POWER_UP_3]
	
	;CMP AX , 7    ; IF COME HERE THEN ( AX > 5 )
	;JL POWER_UP_4  ; MEANS ( AX == 6 ) --> [POWER_UP_4]
	;HERE WE NEED TO MAKE THE [POWER_UP_4]
	
	;CMP AX , 8    ; IF COME HERE THEN ( AX > 6 )
	;JL POWER_UP_5 ; MEANS ( AX == 7 ) --> [POWER_UP_5]
	;HERE WE NEED TO MAKE THE [POWER_UP_5]
	
	; -----------------------------------------------------------------------
	;              EXECUTION OF POWERS SHOULD BE HERE
	; -----------------------------------------------------------------------

	;POWER_UP_1:
	;JMB CLICK_AGAIN ; TO WRITE THE COMMAND
	; THEN CHOOSE THE COMMAND TO EXECUTE
	;JMP START_SCREEEN

	;POWER_UP_2:
	;JMB CLICK_AGAIN ; TO WRITE THE COMMAND
	; THEN CHOOSE THE COMMAND TO EXECUTE
	;JMP START_SCREEEN
	
	;POWER_UP_3:
	; CALL THE FUNCTION WHICH WILL CHANGE THE FORBIDDEN CHARACTER
	;JMP START_SCREEEN
	
	;POWER_UP_4:
	; CALL THE FUNCTION WHICH WILL CLEAR ALL REGISTERS
	
	;JMP START_SCREEEN
	
	
	; -----------------------------------------------------------------------
	;                   END OF THE VERTICAL COMMANDS
	; -----------------------------------------------------------------------

	
	; CLICK_AGAIN2:
	;VERT_LIST_AFTER_EXCUTION-1:        ; IF [CLEAR]
	
	;	LLLOOOPPPX:
	;mov ax, 3
    ;int 33h
	;CMP BX,1
	;JNE LLLOOOPPPX
	
	;mov ax , dx  ; the position for ADDRES_MODE1 0-->2
	;mov dx ,0
	;MOV BX,32			   
	;DIV BX 
	;SUB AX ,1   ; as we already took 32 pixels for the horizontal line
	; STORE IN VARIABLE	
	;CMP AX , 0
	;JG VERT_LIST_AFTER_EXCUTION-2
	
	; HERE WE NEED TO PUT THE [SEND] FUNCTION
	
	;JMP START_SCREEEN
	
	
	;VERT_LIST_AFTER_EXCUTION-2:        ; IF [SEND]
	
	;	LLLOOOPPPY:
	;mov ax, 3
   ; int 33h
	;CMP BX,1
	;JNE LLLOOOPPPY
	
	;mov ax , dx  ; the position for ADDRES_MODE1 0-->2
	;mov dx ,0
	;MOV BX,32			   
	;DIV BX 
	;SUB AX ,1   ; as we already took 32 pixels for the horizontal line
	; STORE IN VARIABLE	
	;CMP AX , 1
	; CALL CHAT
	;JG CLICK_AGAIN2
	
	; HERE WE NEED TO PUT THE [CLEAR] FUNCTION
	
	;JMP CLICK_AGAIN
	
	;JMP START_SCREEEN
	
	
	
	
	
