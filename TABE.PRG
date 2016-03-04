STORE 0 TO XBLOCO,XTIT1,XTIT2,XTIT3,XTIT4,XTIT5,XTIT6,XTIT7,XTIT8

@ 10,10 SAY "CODIGO DO 1§ DOC..:" GET CODI_DOC PICT "9999"
READ
AVISO("LIGUE A IMPRESSORA ---> <ENTER> IMPRIME  <ESC> CANCELA")
DO CASE
CASE LASTKEY()=27
     RETURN(.T.)
ENDCASE
set printer to &implpt
SET PRINTER ON
SET DEVICE TO PRINT

USE &shar41 INDEX &shar45
GOTO TOP
CONT=0 
SET DATE FORMAT TO "DD MM YYYY"
MEZANO=DTOC(DATE())
MEZANO=SUBSTR(MEZANO,4,1)+" "+SUBSTR(MEZANO,5,1)+" / "+SUBSTR(MEZANO,7,1)+" "+SUBSTR(MEZANO,8,1)+" "+SUBSTR(MEZANO,9,1)+" "+SUBSTR(MEZANO,10,1)
DO WHILE .NOT. EOF()                                                                                          

   @ 01,01 SAY "+---------------------------------------------------------------------------------------------------------------+---------+-------+"
   @ 02,01 SAY "| ASSESSORIA CONTABIL RIMAX           CONDOMINIO EDIFICIO TAPAJOS  - TABELA DE VALORES P/COBRANCA          MES/ANO: "+MEZANO +" |"
   @ PROW(),117 SAY MEZANO
   @ 03,01 SAY "+-------+------+-------------------------------+-------+-------+-------+-------+-------+-------+-------+--------+---------+-------+"
   @ 04,01 SAY "| BLOCO | APTO |   P R O P R I E T A R I O     |  TIT1 |  TIT2 |  TIT3 |  TIT4 |  TIT5 |  TIT6 |  TIT7 |  TOTAL | N§  DOC |       |"
   @ 05,01 SAY "+-------+------+-------------------------------+-------+-------+-------+-------+-------+-------+-------+--------+---------+-------+"
   
   DO WHILE .NOT. PROW()>56 .AND. .NOT. EOF()
      XBLOCO=BLOCO
      @ PROW()+1,001 SAY "| "+BLOCO+" | "+APTO+" | "+CONDOMINO+"|"
      IF .NOT. EMPTY(TIT1)
         @ PROW()+0,049 SAY TIT1
      ENDIF
      @ PROW()+0,056 SAY "|"
      
      IF .NOT. EMPTY(TIT2)
         @ PROW()+0,057 SAY TIT2
      ENDIF
      @ PROW()+0,064 SAY "|"
      
      IF .NOT. EMPTY(TIT3)
         @ PROW()+0,065 SAY TIT3
      ENDIF
      @ PROW()+0,072 SAY "|"
      
      IF .NOT. EMPTY(TIT4)
         @ PROW()+0,073 SAY TIT4
      ENDIF
      @ PROW()+0,080 SAY "|"
      
      IF .NOT. EMPTY(TIT5)
         @ PROW()+0,081 SAY TIT5
      ENDIF
      @ PROW()+0,088 SAY "|"
      
      IF .NOT. EMPTY(TIT6)
         @ PROW()+0,089 SAY TIT6
      ENDIF
      @ PROW()+0,096 SAY "|"
      
      IF .NOT. EMPTY(TIT7)
         @ PROW()+0,097 SAY TIT7
      ENDIF
      @ PROW()+0,104 SAY "|"
      
      IF .NOT. EMPTY(TOTAL)
         @ PROW()+0,105 SAY TOTAL
      ENDIF
      @ PROW()+0,113 SAY "|"         
      IF CODI_DOC=0
         @ PROW()+0,115 SAY "   "
       ELSE
         @ PROW()+0,115 SAY CODI_DOC+CONT PICT "9999."
      ENDIF 
      @ PROW()+0,123 SAY "|       |"
      
      *@ PROW()+1,001 SAY "+-------+------+-------------------------------+-------+-------+-------+-------+-------+-------+-------+--------+---------+-------+"
      XTIT1=XTIT1+TIT1
      XTIT2=XTIT2+TIT2
      XTIT3=XTIT3+TIT3
      XTIT4=XTIT4+TIT4
      XTIT5=XTIT5+TIT5
      XTIT6=XTIT6+TIT6
      XTIT7=XTIT7+TIT7
      XTIT8=XTIT8+TOTAL
      SKIP +1
      CONT=CONT+1
      IF XBLOCO <> BLOCO
         @ PROW()+1,001 SAY "+-------+------+-------------------------------+-------+-------+-------+-------+-------+-------+-------+--------+---------+-------+"
         @ PROW()+1,001 SAY "| "+ XBLOCO +" |      | TOTAL DESTE BLOCO             |"
         IF .NOT. EMPTY(XTIT1)
            @ PROW()+0,049 SAY XTIT1 PICT "9999.99"
         ENDIF
         @ PROW()+0,056 SAY "|"
         
         IF .NOT. EMPTY(XTIT2)
            @ PROW()+0,057 SAY XTIT2 PICT "9999.99"
         ENDIF
         @ PROW()+0,064 SAY "|"
         
         IF .NOT. EMPTY(XTIT3)
            @ PROW()+0,065 SAY XTIT3 PICT "9999.99"
         ENDIF
         @ PROW()+0,072 SAY "|"
         
         IF .NOT. EMPTY(XTIT4)
            @ PROW()+0,073 SAY XTIT4 PICT "9999.99"
         ENDIF
         @ PROW()+0,080 SAY "|"
         
         IF .NOT. EMPTY(XTIT5)
            @ PROW()+0,081 SAY XTIT5 PICT "9999.99"
         ENDIF
         @ PROW()+0,088 SAY "|"
         
         IF .NOT. EMPTY(XTIT6)
            @ PROW()+0,089 SAY XTIT6 PICT "9999.99"
         ENDIF
         @ PROW()+0,096 SAY "|"
         
         IF .NOT. EMPTY(XTIT7)
            @ PROW()+0,097 SAY XTIT7 PICT "9999.99"
         ENDIF
         @ PROW()+0,104 SAY "|"
         
         IF .NOT. EMPTY(XTIT8)
            @ PROW()+0,105 SAY XTIT8 PICT "9999.99"
         ENDIF
         @ PROW()+0,113 SAY "|         |       |"
         
         @ PROW()+1,001 SAY "+-------+------+-------------------------------+-------+-------+-------+-------+-------+-------+-------+--------+---------+-------+"
         @ PROW()+1,001 SAY "                                                                                                                                   "
         @ PROW()+1,001 SAY "+-------+------+-------------------------------+-------+-------+-------+-------+-------+-------+-------+--------+---------+-------+"
         STORE 0 TO XBLOCO,XTIT1,XTIT2,XTIT3,XTIT4,XTIT5,XTIT6,XTIT7,XTIT8
      ENDIF
   ENDDO
   *IF PROW()>56 
   *   @ PROW()+1,001 SAY "+-------+------+-------------------------------+-------+-------+-------+-------+-------+-------+-------+--------+---------+-------+"
   *ENDIF
ENDDO

@ PROW()+2,001 SAY "TITULOS DOS BLOCOS"
@ PROW()+0,001 SAY "__________________"
@ PROW()+1,000 SAY "   " 

USE &shar51 INDEX &shar52
GOTO TOP
DO WHILE .NOT. EOF()
   @ PROW()+1,001 SAY "BLOCO...:" + BLOCO
   @ PROW()+0,001 SAY "BLOCO...:" + BLOCO
   @ PROW()+0,032 SAY "1)" + TITULO1
   @ PROW()+0,063 SAY "2)" + TITULO2
   @ PROW()+0,094 SAY "3)" + TITULO3
   @ PROW()+1,001 SAY "4)" + TITULO4
   @ PROW()+0,032 SAY "5)" + TITULO5
   @ PROW()+0,063 SAY "6)" + TITULO6
   @ PROW()+0,094 SAY "7)" + TITULO7
   @ PROW()+1,001 SAY REPL("-",131)
   SKIP +1
ENDDO

SET DATE FORMAT TO "DD/MM/YYYY"
SET PRINTER OFF
SET DEVICE TO SCREEN

