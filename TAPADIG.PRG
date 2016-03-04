PROG=2
CENTRA(23,XDIG[1])
BORDA(05,33,12,44,COR22)
A=ACHOICE(06,34,11,43,DIG,.T.,"FUNCA")
OLDCOR=SETCOLOR()
DO CASE
CASE A=2
     @ 04,02 CLEAR TO 19,78
*     SET COLOR TO &cor17
     CENTRA(05,"DIGITACAO GERAL")
     CENTRA(07,"OS VALORES DIGITADOS SERAO GRAVADOS PARA TODOS OS PROPRIETARIOS")
     BORDA(04,02,19,78,setcolor())
     @ 10,15 SAY "VALORES..:"
     @ 12,15 SAY "P/TITULO 1..:" GET XTIT1
     @ 13,15 SAY "P/TITULO 2..:" GET XTIT2
     @ 14,15 SAY "P/TITULO 3..:" GET XTIT3
     @ 15,15 SAY "P/TITULO 4..:" GET XTIT4
     @ 16,15 SAY "P/TITULO 5..:" GET XTIT5
     @ 17,15 SAY "P/TITULO 6..:" GET XTIT6
     @ 18,15 SAY "P/TITULO 7..:" GET XTIT7
     READ
     @ 20,15 SAY "CONFIRMA....?" GET SN PICT "@!"
     READ
     IF .NOT. SN="S" 
        KEYB CHR(13)+CHR(24)
        RETURN
     ELSEIF LASTKEY()=27
        KEYB CHR(13)+CHR(24)
        RETURN
     ENDIF
     XTOTAL=XTIT1+XTIT2+XTIT3+XTIT4+XTIT5+XTIT6+XTIT7
     USE &SHAR41 INDEX &SHAR45
     GOTO TOP
     IF FLOCK()
     DO WHILE .NOT. EOF()

        IF !EMPTY(XTIT1)
           REPLACE TIT1  WITH XTIT1
        ENDIF
        IF !EMPTY(XTIT2)
           REPLACE TIT2  WITH XTIT2
        ENDIF
        IF !EMPTY(XTIT3)
           REPLACE TIT3  WITH XTIT3
        ENDIF
        IF !EMPTY(XTIT4)
           REPLACE TIT4  WITH XTIT4
        ENDIF
        IF !EMPTY(XTIT5)
           REPLACE TIT5  WITH XTIT5
        ENDIF
        IF !EMPTY(XTIT6)
           REPLACE TIT6  WITH XTIT6
        ENDIF
        IF !EMPTY(XTIT7)
           REPLACE TIT7  WITH XTIT7
        ENDIF
        COMMIT
        SKIP +1
     ENDDO
     ELSE
     AVISO("FLOCK - OUTRO USUARIO ATIVO")
     ENDIF
     KEYB CHR(13)+CHR(24)
CASE A=1
     @ 04,02 CLEAR TO 22,78
*     SET COLOR TO &cor18
     CENTRA(05,"DIGITACAO EM TELA CHEIA")
     BORDA(04,02,22,78,setcolor())
     USE &SHAR41
     INDEX ON BLOCO+APTO TO &SHAR45
     SOMAtapa()
     USE &SHAR41 INDEX &SHAR45 exclusiVE
     DO WHILE .NOT. LASTKEY()=27
        BROWSE(07,03,21,77)
        IF LASTKEY()=27
           SOMAtapa()
           KEYB CHR(13)
           EXIT
        ENDIF
        @ 20,02 CLEAR TO 20,78
     ENDDO
     KEYB CHR(13)

CASE A=3
     @ 04,02 CLEAR TO 19,78
     CENTRA(05,"DIGITA€AO P/BLOCO")
     BORDA(04,02,19,78,setcolor())
     XBLOCO=SPACE(5)
     @ 08,15 SAY "VALORES..:"
     @ 10,15 SAY "BLOCO.......:" GET XBLOCO
     @ 12,15 SAY "P/TITULO 1..:" GET XTIT1
     @ 13,15 SAY "P/TITULO 2..:" GET XTIT2
     @ 14,15 SAY "P/TITULO 3..:" GET XTIT3
     @ 15,15 SAY "P/TITULO 4..:" GET XTIT4
     @ 16,15 SAY "P/TITULO 5..:" GET XTIT5
     @ 17,15 SAY "P/TITULO 6..:" GET XTIT6
     @ 18,15 SAY "P/TITULO 7..:" GET XTIT7
     
     READ
     @ 20,15 SAY "CONFIRMA....?" GET SN PICT "@!"
     READ
     IF .NOT. SN="S"
     KEYB CHR(13)+CHR(24)+CHR(24)
        RETURN
     ELSEIF LASTKEY()=27
     KEYB CHR(13)+CHR(24)+CHR(24)
        RETURN
     ENDIF
     XTOTAL=XTIT1+XTIT2+XTIT3+XTIT4+XTIT5+XTIT6+XTIT7
     USE &SHAR41 INDEX &SHAR45
     GOTO TOP
     IF FLOCK()
     DO WHILE .NOT. EOF()
        IF BLOCO=XBLOCO
           IF !EMPTY(XTIT1)
              REPLACE TIT1  WITH XTIT1
           ENDIF
           IF !EMPTY(XTIT2)
              REPLACE TIT2  WITH XTIT2
           ENDIF
           
           IF !EMPTY(XTIT3)
              REPLACE TIT3  WITH XTIT3
           ENDIF
           IF !EMPTY(XTIT4)
              REPLACE TIT4  WITH XTIT4
           ENDIF
           IF !EMPTY(XTIT5)
              REPLACE TIT5  WITH XTIT5
           ENDIF
           IF !EMPTY(XTIT6)
              REPLACE TIT6  WITH XTIT6
           ENDIF
           IF !EMPTY(XTIT7)
              REPLACE TIT7  WITH XTIT7
           ENDIF
           
           **** REPLACE TOTAL WITH XTOTAL
           COMMIT
        ENDIF
        SKIP +1
     ENDDO
     ELSE
     AVISO("FLOCK - OUTRO USUARIO ATIVO")
     ENDIF

     KEYB CHR(13)+CHR(24)+CHR(24)
CASE A=4
     @ 04,02 CLEAR TO 19,78
     CENTRA(05,"DIGITA€AO DA AGUA P/BLOCO")
     BORDA(04,02,19,78,setcolor())
     XBLOCO=SPACE(5)
     @ 10,15 SAY "VALORES..:"
     @ 12,15 SAY "BLOCO.......:" GET XBLOCO 
     @ 13,15 SAY "VALOR 1§....:" GET XTIT3
     @ 14,15 SAY "VARIACAO +/-:" GET XVARIA VALID(XVARIA$"+-")
     READ
     @ 20,15 SAY "CONFIRMA....?" GET SN PICT "@!"
     READ
     IF .NOT. SN="S"
        KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)  
        RETURN
  
     ELSEIF LASTKEY()=27
       KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)
        RETURN

     ENDIF
     USE &SHAR41 INDEX &SHAR42
     GOTO TOP
     ADIC=0
     IF FLOCK()
     DO WHILE .NOT. EOF()
        IF BLOCO=XBLOCO
           REPLACE TIT3 WITH XTIT3+ADIC
           IF APTO=" 207"
              REPLACE TIT3 WITH 0
           ENDIF
           IF APTO="0209" .OR. APTO="0207"
              ADIC=ADIC
           ELSEIF XVARIA="+"
              ADIC=ADIC+0.01
           ELSEIF XVARIA="-"
              ADIC=ADIC-0.01
           ENDIF
        ENDIF
        SKIP +1
     ENDDO
     ELSE
     AVISO("FLOCK - OUTRO USUARIO ATIVO")
     ENDIF

     KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)
CASE A=5
     KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
CASE A=6
     Conf_somat_blocos()
     KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
ENDCASE
SET COLOR TO &OLDCOR
**************
FUNCTION SOMAtapa
**************
USE &SHAR41
GOTO TOP
IF FLOCK()
DO WHILE .NOT. EOF()
   REPLACE TOTAL WITH TIT1+TIT2+TIT3+TIT4+TIT5+TIT6+TIT7
   SKIP +1
ENDDO
ELSE
AVISO("FLOCK - OUTRO USUARIO ATIVO")
ENDIF
RETURN(.T.)
