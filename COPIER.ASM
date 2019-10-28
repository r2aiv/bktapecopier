; Кассетный копировщик (с) R2AIV 10.2019
; Компилировать по адресу 76000

; ПРИГРАШЕНИЕ ДЛЯ ВВОДА ИМЕНИ ФАЙЛА

CLR R2
MOV #WELCOME,R1
EMT 20

CLR R2
MOV #ENTERFILENAME,R1
EMT 20

;Очистка буфера ввода
MOV #77000,R1
MOV #77100,R2

CLEARINPUTBUFF:                                                                             
CLR (R1)+
CMP R1,R2
BNE CLEARINPUTBUFF

MOV #5100,R2
MOV #77000,R1
EMT 10

;Удаление символа ввода из имени файла
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

; ОЧИСТКА БЛОКА ПАРАМЕТРОВ
MOV #320,R1
MOV #360,R2
CLEARPARAM:
CLR (R1)+
CMP R1,R2
BNE CLEARPARAM

;КОПИРОВАНИЕ ИМЕНИ ФАЙЛА В БЛОК ПАРАМЕТРОВ
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

                                                       
RET

WELCOME:
.ASCIZ "-=<КАССЕТНЫЙ КОПИРОВЩИК R2AIV 10.2019 l0calhost@mail.ru>=-"<12>

FOUNDFILE:
.ASCIZ "Найдено: "

ENTERFILENAME:
.ASCIZ "Введите имя файла для чтения:"

ENTERED:
.ASCIZ "Чтение файла "

FILEISREAD:
.ASCIZ "Файл прочитан!"<12>

WAITFORWRITE:
.ASCIZ "Нажмите любую клавишу для записи!"<12>

ERRORMSG:
.ASCIZ "Ошибка при чтении!"<12>

copydone:
.ASCIZ "Копирование завершено!"<12>

.END