; Êàññåòíûé êîïèðîâùèê (ñ) R2AIV 10.2019
; Êîìïèëèðîâàòü ïî àäðåñó 76000

; ÏÐÈÃÐÀØÅÍÈÅ ÄËß ÂÂÎÄÀ ÈÌÅÍÈ ÔÀÉËÀ
; Test

	CLR R2
	MOV #WELCOME,R1
	EMT 20

	CLR R2
	MOV #ENTERFILENAME,R1
	EMT 20

;Î÷èñòêà áóôåðà ââîäà
	MOV #77000,R1
	MOV #77100,R2

CLEARINPUTBUFF:                                                                             
	CLR (R1)+
	CMP R1,R2
	BNE CLEARINPUTBUFF

	MOV #5100,R2
	MOV #77000,R1
	EMT 10

;Óäàëåíèå ñèìâîëà ââîäà èç èìåíè ôàéëà
	MOV #77000,R1

DELENTER:
	MOV (R1),R0
	CMP R0,#12
	BEQ REMOVE
	INC R1
	BR DELENTER

REMOVE:
	MOV #77020, R3
	MOVB #40,(R1)+
	CMPB R1,R3
	BNE REMOVE

	CLR R2
	MOV #ENTERED,R1
	EMT 20

	CLR R2
	MOV #77000,R1
	EMT 20

	MOV #12,R0
	EMT 16

; Î×ÈÑÒÊÀ ÁËÎÊÀ ÏÀÐÀÌÅÒÐÎÂ
	MOV #320,R1
	MOV #360,R2
CLEARPARAM:
	CLR (R1)+
	CMP R1,R2
	BNE CLEARPARAM

;ÊÎÏÈÐÎÂÀÍÈÅ ÈÌÅÍÈ ÔÀÉËÀ Â ÁËÎÊ ÏÀÐÀÌÅÒÐÎÂ
TRYREAD:
	MOV #77000,R1
	MOV #326,R2
NAMECOPY:
	MOVB (R1)+,(R2)+                                            
	CMP R2,#346
	BNE NAMECOPY

	MOV #320,R1
	CLR @#320
	MOVB #3,@#320
	EMT 36

	CMPB @#321,#0
	BNE READERROR
	BEQ NOREADERROR

READERROR:
	CLR R2
	MOV #FOUNDFILE,R1
	EMT 20
	CLR R2
	MOV #20000,R2
	MOV #352,R1
	EMT 20
	MOV #12,R0
	EMT 16
	JMP TRYREAD

NOREADERROR:

	MOV #FILEISREAD,R1
	CLR R2
	EMT 20

	MOV #WAITFORWRITE,R1
	CLR R2
	EMT 20
	EMT 6

	MOV #352,R1
	MOV #326,R2
NAMECOPY2:
	MOV (R2)+,(R1)+
	CMP R1,#372
	BNE NAMECOPY2

	MOV @#346,@#322
	MOV @#350,@#324
	MOV #2,@#320
                                                                     
	MOV #320,R1

	EMT 36

	CLR R2
	MOV #COPYDONE,R1
	EMT 20

	HALT                                                      

WELCOME:
.ASCIZ "-=<ÊÀÑÑÅÒÍÛÉ ÊÎÏÈÐÎÂÙÈÊ R2AIV 10.2019 l0calhost@mail.ru>=-"<12>

FOUNDFILE:
.ASCIZ "Íàéäåíî: "

ENTERFILENAME:
.ASCIZ "Ââåäèòå èìÿ ôàéëà äëÿ ÷òåíèÿ:"

ENTERED:
.ASCIZ "×òåíèå ôàéëà "

FILEISREAD:
.ASCIZ "Ôàéë ïðî÷èòàí!"<12>

WAITFORWRITE:
.ASCIZ "Íàæìèòå ëþáóþ êëàâèøó äëÿ çàïèñè!"<12>

ERRORMSG:
.ASCIZ "Îøèáêà ïðè ÷òåíèè!"<12>

copydone:
.ASCIZ "Êîïèðîâàíèå çàâåðøåíî!"<12>

.END
