SET DATE FORMAT TO "dd/mm/yyyy"
SET DECIMALS TO 6
X="LPT1"
PARA X
SET PRINTER TO &X
SET EXACT ON
**** GERA TODOS NTX

CLEAR
@ 00,00 TO 24,79
SET COLOR TO R+*
CENTRA(13,"AGUARDE, PROCESSANDO DADOS...")
USE &SHAR21
INDEX ON APTO TO JOTABAPTO
INDEX ON CONDOMINO TO JOTABNOME
CLOSE ALL

***** DECLARACAO AMBIENTE

SET COLOR TO
CLEAR
SET DATE FRENCH
SET SCORE OFF
SET COLOR TO
SET WRAP ON
SET MESSAGE TO 23 CENTER
SET CURSOR ON


*** DECLARACAO DOS VETORES ACHOICE

FIM={"CONFIRMA"}
XFIM={"Confirma saida p/DOS"}
TIT={" Geral "}
DIG={"TELA CHEIA"}
REL={" Geral "," Tabela "}
XTIT={"Titulos da tabela"}
XDIG={"Digita em tela cheia com todos os Cond“minos"}
XREL={"Imprime todos os apartamentos","Tabela"}

**** VARIAVEIS

SN=" "
PROG=0
OBS="                                              "+SPACE(30)
OPCAO=0
TOTAL1:=TOTAL2:=TOTAL3:=TOTAL4:=TOTAL5:=0

**** A         -   VARIAVEL VETOR ACHOICE
**** XTOTAL    -   VARIAVEL SOMA TITULOS (DIGITACAO P/TODOS)
****
****

MASCARA_NO="@E 999,999.99"
STORE VAL("0000.00") TO XTIT1,XTIT2,XTIT3,XTIT4

DO WHILE .T.
   CLEAR
   SET COLOR TO &cor13

   @ 12,10 SAY"ЫЫЫЫ ЫЫЫЫЫ      Ы ЫЫЫЫ ЫЫЫЫ ЫЫЫЫ ЫЫЫЫ Ы  Ы "
   @ 13,10 SAY"Ы      Ы        Ы Ы  Ы Ы    Ы    Ы  Ы Ы  Ы "
   @ 14,10 SAY"ЫЫЫЫ   Ы        Ы Ы  Ы ЫЫЫЫ ЫЫ   ЫЫЫЫ ЫЫЫЫ "
   @ 15,10 SAY"   Ы   Ы     Ы  Ы Ы  Ы    Ы Ы    Ы    Ы  Ы "
   @ 16,10 SAY"ЫЫЫЫ   Ы  Ы  ЫЫЫЫ ЫЫЫЫ ЫЫЫЫ ЫЫЫЫ Ы    Ы  Ы "

   SET COLOR TO &cor14
   @ 02,02 SAY "   S.I.S.J. - Sistema de Impressao de Relatўrios do Condominio Saint Joseph"
   SET COLOR TO &cor13
   @ 00,00 TO 24,79 DOUBLE
   @ 01,01 TO 03,78
   SET COLOR TO &cor15
   @ 04,18 PROMPT "TITULOS" MESSAGE "TЎtulos das tabelas"
   @ 04,32 PROMPT "DIGITAЂAO" MESSAGE "Digitacao das tabelas"
   @ 04,49 PROMPT "RELATORIOS" MESSAGE "Impressao dos relatorios"
   @ 04,68 PROMPT "SAIR" MESSAGE "Retorno p/ o D.O.S."
   MENU TO OPCAO
   SAVE SCRE TO TELA1
   DO CASE
   CASE OPCAO=1
        CENTRA(23,XTIT[1])
        BORDA(05,19,07,29,setcolor())
        PROG=1
        A=ACHOICE(06,20,06,28,TIT,.T.,"JOFUNCA")
        DO CASE
        CASE A=1
             DO WHILE .NOT. LASTKEY()=27
                
                @ 04,02 CLEAR TO 19,78
                CENTRA(05,"DIGITACAO DOS TITULOS")
                BORDA(04,05,19,75,setcolor())
                
                USE &SHAR31
                GOTO TOP
                IF !eof()
                   XTITULO1=TITULO1
                   XTITULO2=TITULO2
                   XTITULO3=TITULO3
                   XTITULO4=TITULO4
                ELSE
                   appe blan
                   xtitulo1=space(25)
                   xtitulo2=space(25)
                   xtitulo3=space(25)
                   xtitulo4=space(25)
                ENDIF
                
                @ 09,15 SAY "TITULO 1....." GET XTITULO1
                @ 10,15 SAY "TITULO 2....." GET XTITULO2
                @ 11,15 SAY "TITULO 3....." GET XTITULO3
                @ 12,15 SAY "TITULO 4....." GET XTITULO4
                READ
                
                IF LASTKEY()=27
                   EXIT
                ENDIF
                
                @ 17,10 SAY "CONFIRMA....?" GET SN PICT "@!"
                READ
                
                IF ! SN="S"
                   EXIT
                ENDIF
                
                IF LASTKEY()=27
                   EXIT
                   
                ENDIF
                REPLACE TITULO1 WITH XTITULO1
                REPLACE TITULO2 WITH XTITULO2
                REPLACE TITULO3 WITH XTITULO3
                REPLACE TITULO4 WITH XTITULO4
                COMMIT
                ***********************************************
             ENDDO
        ENDCASE
   CASE OPCAO=2
        PROG=2
        CENTRA(23,XDIG[1])
        BORDA(05,33,7,44,setcolor())
        A=ACHOICE(06,34,6,43,DIG,.T.,"JOFUNCA")
        DO CASE
        CASE A=1
             @ 04,02 CLEAR TO 22,78
             CENTRA(05,"DIGITACAO EM TELA CHEIA")
             BORDA(04,02,22,78,setcolor())
             USE &SHAR21 INDEX &SHAR23
             DO WHILE .NOT. LASTKEY()=27
                SOMA()
                BROWSE(07,03,21,77)
                SOMA()
                IF LASTKEY()=27
                   EXIT
                ENDIF
                @ 20,02 CLEAR TO 20,78
             ENDDO
        ENDCASE
   CASE OPCAO=3
        DOC=0
        VENC=CTOD(SPACE(8))
        MESANO="  /    "
        STORE 0 TO TEMP1TIT,TEMP2TIT,TEMP3TIT,TEMP4TIT,TEMPTOTAL
        
        DO WHILE .NOT. LASTKEY()=27
           PROG=3
           CENTRA(23,XREL[1])
           BORDA(05,51,08,61,setcolor())
           A=ACHOICE(06,52,07,60,REL,.T.,"JOFUNCA")
           DO CASE
           CASE A=2
                @ 04,02 CLEAR TO 19,77
                CENTRA(05,"IMPRESSAO TABELA")
                CENTRA(07,"PARA IMPRIMIR A TABELA")
                BORDA(04,02,19,77,setcolor())
                @ 10,10 SAY "MES/ANO....: " GET MESANO
                @ 11,10 SAY "VENCIMENTO.: " GET VENC
                @ 12,10 SAY "OBS........: " GET OBS PICT "@!C"
                READ
                @ 13,10 SAY "CONFIRMA...: " GET SN PICT"@!" VALID(SN="S" .OR. SN="N")
                READ
                IF SN="N"
                   LOOP
                ELSEIF LASTKEY()=27
                   LOOP
                ENDIF
                @ 15,30 CLEAR TO 17,61
                AVISO("LIGUE A IMPRESSORA E TECLE <ENTER>")
                SET DEVICE TO PRINT
                SET CONSOLE OFF
                 USE &SHAR21 INDEX &SHAR23
                GOTO TOP
		@ prow(),row() say chr(15)
                @ PROW()+1,00 SAY REPL("-",127)+"+"
                @ PROW()+1,00 SAY "| CONDOMINIO EDIFICIO ST. JOSEPH"
                @ PROW()+0,96 SAY "           TABELA MES:"
                @ PROW()+0,119 SAY MESANO
                @ PROW()+0,127 SAY "|"
                @ PROW()+1,00 SAY REPL("-",127)+"+"
                @ PROW()+1,00 SAY "|APTO |          CONDOMINO           |  TITULO1  |  TITULO2  |  TITULO3  |  TITULO4  |   TOTAL   |        OBSERVACOES          |"
                @ PROW()+1,00 SAY "------+------------------------------+-----------+-----------+-----------+-----------+-----------+------------------------------"
                DO WHILE .NOT. EOF()
                   @ PROW()+1,00 SAY "|"
                   @ PROW()+0,02 SAY APTO
                   @ PROW()+0,06 SAY "|"
                   @ PROW()+0,07 SAY CONDOMINO
                   @ PROW()+0,37 SAY "|"
                   IF !EMPTY(TIT1)
                      @ PROW()+0,41 SAY TIT1 PICT "@e 9999.99"
                   ENDIF
                   @ PROW()+0,49 SAY "|"
                   IF !EMPTY(TIT2)
                   @ PROW()+0,53 SAY TIT2 PICT "@e 9999.99"
                   ENDIF
                   @ PROW()+0,61 SAY "|"
                   IF !EMPTY(TIT3)
                   @ PROW()+0,65 SAY TIT3 PICT "@e 9999.99"
                   ENDIF
                   @ PROW()+0,73 SAY "|"
                   IF !EMPTY(TIT4)
                   @ PROW()+0,77 SAY TIT4 PICT "@e 9999.99"
                   ENDIF
                   @ PROW()+0,85 SAY "|"
                   IF !EMPTY(TOTAL)
                   @ PROW()+0,89 SAY TOTAL PICT "@e 9999.99"
                   ENDIF
                   @ PROW()+0,97 SAY "|"
                   @ PROW()+0,127 SAY "|"
                   @ PROW()+1,00 SAY "+-----+------------------------------+-----------+-----------+-----------+-----------+-----------+-----------------------------+"
                   TEMP1TIT=TEMP1TIT+TIT1
                   TEMP2TIT=TEMP2TIT+TIT2
                   TEMP3TIT=TEMP3TIT+TIT3
                   TEMP4TIT=TEMP4TIT+TIT4
                   TEMPTOTAL=TEMPTOTAL+TOTAL
                   SKIP +1
                ENDDO
                @ PROW()+1,00 SAY "|TOTAL"
                @ PROW()+0,06 SAY "|"
                @ PROW()+0,15 SAY ""
                @ PROW()+0,37 SAY "|"
                IF !EMPTY(TEMP1TIT)
                   @ PROW()+0,41 SAY TEMP1TIT PICT "@e 9999.99"
                ENDIF
                @ PROW()+0,49 SAY "|"
                IF !EMPTY(TEMP2TIT)
                   @ PROW()+0,53 SAY TEMP2TIT PICT "@e 9999.99"
                ENDIF
                @ PROW()+0,61 SAY "|"
                IF !EMPTY(TEMP3TIT)
                   @ PROW()+0,65 SAY TEMP3TIT PICT "@e 9999.99"
                ENDIF
                @ PROW()+0,73 SAY "|"
                IF !EMPTY(TEMP4TIT)
                   @ PROW()+0,77 SAY TEMP4TIT PICT "@e 9999.99"
                ENDIF
                @ PROW()+0,85 SAY "|"
                   IF !EMPTY(TEMPTOTAL)
                   @ PROW()+0,89 SAY TEMPTOTAL PICT "@e 9999.99"
                   ENDIF
                   @ PROW()+0,97 SAY "|"
                @ PROW()+0,127 SAY "|"
                @ PROW()+1,00 SAY REPL("-",127)+"+"
                @ PROW()+2,00 SAY "Legenda:"
                @ PROW()+0,00 SAY "________"
                USE &SHAR31
                @ PROW()+2,00 SAY "Titulo 1: "+TITULO1
                @ PROW()+2,00 SAY "Titulo 2: "+TITULO2
                @ PROW()+2,00 SAY "Titulo 3: "+TITULO3
                @ PROW()+2,00 SAY "Titulo 4: "+TITULO4
                @ PROW()+3,00 SAY REPL("-",128)
                @ PROW()+1,00 SAY "PROCESSADO POR: ASSESSORIA CONTABIL RIMAX LTDA."
                @ PROW()+1,00 SAY REPL("-",128)

             EJECT
             SET PRINTER OFF
             SET DEVICE TO SCREEN
             SET CONSOLE ON
             CLOSE ALL
                                
        CASE A=1
             @ 04,02 CLEAR TO 19,77
             CENTRA(05,"IMPRESSAO GERAL")
             CENTRA(07,"PARA IMPRIMIR O RELATORIO DE TODOS OS CONDOMINOS")
             BORDA(04,02,19,77,setcolor())
             @ 10,10 SAY "MES/ANO....: " GET MESANO
             @ 11,10 SAY "VENCIMENTO.: " GET VENC
             @ 12,10 SAY "OBS........: " GET OBS PICT "@!C"
             READ
             @ 13,10 SAY "CONFIRMA...: " GET SN PICT"@!" VALID(SN="S" .OR. SN="N")
             READ
             IF SN="N"
                LOOP
             ELSEIF LASTKEY()=27
                LOOP
             ENDIF
             @ 15,30 CLEAR TO 17,61
             AVISO("LIGUE A IMPRESSORA E TECLE <ENTER>")
             SET DEVICE TO PRINT
             SET CONSOLE OFF
             USE &SHAR31
             GOTO TOP
             XTITULO1=TITULO1
             XTITULO2=TITULO2
             XTITULO3=TITULO3
             XTITULO4=TITULO4
              USE &SHAR21 INDEX &SHAR23
             GOTO TOP
             X=0
             DO WHILE .NOT. EOF()
                DOC=DOC+1
                X++
                @ PROW()+1,00 SAY REPL("=",78)
                @ PROW()+1,02 SAY "CONDOMINIO EDIFICIO ST. JOSEPH"
                @ PROW()+0,46 SAY "AVISO DE COBRANCA MES:"
                @ PROW()+0,71 SAY MESANO
                @ PROW()+1,00 SAY REPL("-",78)
                @ PROW()+1,02 SAY "CONDOMINO:"
                @ PROW()+0,13 SAY CONDOMINO
                @ PROW()+0,63 SAY "DATA:"
                @ PROW()+0,68 SAY VENC
                @ PROW()+1,00 SAY REPL("-",78)
                @ PROW()+1,02 SAY "APTO.:"+APTO
                IF .NOT. EMPTY(XTITULO1)
                   @ PROW()+2,02 SAY XTITULO1
                   @ PROW()+0,27 SAY ":   R$ "
                ELSE
                   @ PROW()+2,00 SAY ""
                ENDIF
                IF .NOT. EMPTY(TIT1)
                   @ PROW()+0,35 SAY TIT1 PICT MASCARA_NO
                ENDIF
                IF .NOT. EMPTY(XTITULO2)
                   @ PROW()+1,02 SAY XTITULO2
                   @ PROW()+0,27 SAY ":   R$ "
                ELSE
                   @ PROW()+1,00 SAY ""
                ENDIF
                IF .NOT. EMPTY(TIT2)
                   @ PROW()+0,35 SAY TIT2 PICT MASCARA_NO
                ENDIF
                IF .NOT. EMPTY(XTITULO3)
                   @ PROW()+1,02 SAY XTITULO3
                   @ PROW()+0,27 SAY ":   R$ "
                ELSE
                   @ PROW()+1,00 SAY ""
                ENDIF
                IF .NOT. EMPTY(TIT3)
                   @ PROW()+0,35 SAY TIT3 PICT MASCARA_NO
                ENDIF
                IF .NOT. EMPTY(XTITULO4)
                   @ PROW()+1,02 SAY XTITULO4
                   @ PROW()+0,27 SAY ":   R$ "
                ELSE
                   @ PROW()+1,00 SAY ""
                ENDIF
                IF .NOT. EMPTY(TIT4)
                   @ PROW()+0,35 SAY TIT4 PICT MASCARA_NO
                ENDIF
                @ PROW()+2,02 SAY "T O T A L..."
                @ PROW()+0,14 SAY "............:   R$ "
                @ PROW()+0,35 SAY TOTAL  PICT MASCARA_NO
                @ PROW()+4,00 SAY REPL("-",78)
                @ PROW()+1,00 SAY "PROCESSADO POR: ASSESSORIA CONTABIL RIMAX LTDA."
                @ PROW()+1,00 SAY REPL("-",78)
                
                @ PROW()+4,00 SAY " "
                
                @ PROW()+1,00 SAY REPL("=",78)
                @ PROW()+1,02 SAY "CONDOMINIO EDIFICIO ST. JOSEPH"
                @ PROW()+0,44 SAY "COMPROVANTE DE PGTO MES:"
                @ PROW()+0,71 SAY MESANO
                @ PROW()+1,00 SAY REPL("-",78)
                @ PROW()+1,02 SAY "CONDOMINO:"
                @ PROW()+0,13 SAY CONDOMINO
                @ PROW()+0,63 SAY "DATA:"
                @ PROW()+0,68 SAY VENC
                @ PROW()+1,00 SAY REPL("-",78)
                @ PROW()+1,02 SAY "APTO.:"+APTO
                IF .NOT. EMPTY(XTITULO1)
                   @ PROW()+2,02 SAY XTITULO1
                   @ PROW()+0,27 SAY ":   R$ "
                ELSE
                   @ PROW()+2,00 SAY ""
                ENDIF
                IF .NOT. EMPTY(TIT1)
                   @ PROW()+0,35 SAY TIT1 PICT MASCARA_NO
                ENDIF
                IF .NOT. EMPTY(XTITULO2)
                   @ PROW()+1,02 SAY XTITULO2
                   @ PROW()+0,27 SAY ":   R$ "
                ELSE
                   @ PROW()+1,00 SAY ""
                ENDIF
                IF .NOT. EMPTY(TIT2)
                   @ PROW()+0,35 SAY TIT2 PICT MASCARA_NO
                ENDIF
                IF .NOT. EMPTY(XTITULO3)
                   @ PROW()+1,02 SAY XTITULO3
                   @ PROW()+0,27 SAY ":   R$ "
                ELSE
                   @ PROW()+1,00 SAY ""
                ENDIF
                IF .NOT. EMPTY(TIT3)
                   @ PROW()+0,35 SAY TIT3 PICT MASCARA_NO
                ENDIF
                IF .NOT. EMPTY(XTITULO4)
                   @ PROW()+1,02 SAY XTITULO4
                   @ PROW()+0,27 SAY ":   R$ "
                ELSE
                   @ PROW()+1,00 SAY ""
                ENDIF
                IF .NOT. EMPTY(TIT4)
                   @ PROW()+0,35 SAY TIT4 PICT MASCARA_NO
                ENDIF
                @ PROW()+2,02 SAY "T O T A L..."
                @ PROW()+0,14 SAY "............:   R$ "
                @ PROW()+0,35 SAY TOTAL  PICT MASCARA_NO
                @ PROW()+2,49 SAY "RECEBEMOS EM ____/____/____"
                @ PROW()+4,49 SAY "---------------------------"
                @ PROW()+1,49 SAY "          SINDICO          "
                @ PROW()+1,49 SAY " "
                @ PROW()+1,49 SAY " "
                @ PROW()+4,00 SAY REPL("-",78)
                @ PROW()+1,00 SAY "PROCESSADO POR: ASSESSORIA CONTABIL RIMAX LTDA."
                @ PROW()+1,00 SAY REPL("-",78)
                EJECT
                SKIP +1
             ENDDO
             SET PRINTER OFF
             SET DEVICE TO SCREEN
             SET CONSOLE ON
             CLOSE ALL
        ENDCASE
        EXIT
     ENDDO
     
     
CASE OPCAO=4
     PROG=4
     CENTRA(23,XFIM[1])
     BORDA(05,66,07,75,setcolor())
     A=ACHOICE(06,67,06,74,FIM,.T.,"JOFUNCA")
     IF A=1
        CLOSE ALL
        CLEAR
        RETURN(.T.)
     ENDIF
ENDCASE

ENDDO
**************
FUNCTION SOMA
**************
 USE &SHAR21 INDEX &SHAR23
GOTO TOP
TOTAL1:=TOTAL2:=TOTAL3:=TOTAL4:=TOTAL5:=0
DO WHILE .NOT. EOF()
   REPLACE TOTAL WITH TIT1+TIT2+TIT3+TIT4
   TOTAL1=TOTAL1+TIT1
   TOTAL2=TOTAL2+TIT2
   TOTAL3=TOTAL3+TIT3
   TOTAL4=TOTAL4+TIT4
   TOTAL5=TOTAL5+TOTAL 
   SKIP +1
ENDDO

@ 06,03 SAY TOTAL1 PICT "@E 9,999.99"
@ 06,13 SAY TOTAL2 PICT "@E 9,999.99"
@ 06,23 SAY TOTAL3 PICT "@E 9,999.99"
@ 06,33 SAY TOTAL4 PICT "@E 9,999.99"
@ 06,43 SAY TOTAL5 PICT "@E 9,999.99"

RETURN(.T.)

**********************************
*** FUNCAO "UDF" (ACHOICE)     ***
*** PERMITE FAZER O MENU RODAR ***
**********************************
FUNCTION JOFUNCA(MODO,ELE,POS)

IF PROG=1
   CENTRA(23,XTIT[ELE])
ELSEIF PROG=2
   CENTRA(23,XDIG[ELE])
ELSEIF PROG=3
   CENTRA(23,XREL[ELE])
ELSEIF PROG=4
   CENTRA(23,XFIM[ELE])
ELSEIF PROG=5
   CENTRA(23,XCAD[ELE])
ENDIF
IF MODO=1
   KEYBOARD CHR(30)
ELSEIF MODO=2
   KEYBOARD CHR(31)
ELSEIF MODO=3
   IF LASTKEY()=27
      RETURN 0
   ELSEIF LASTKEY()=19
      KEYBOARD CHR(27)+CHR(19)+CHR(13)
   ELSEIF LASTKEY()=4
      KEYBOARD CHR(27)+CHR(4)+CHR(13)
   ELSEIF LASTKEY()=13
      A=ELE
      RETURN 1
   ENDIF
ENDIF
RETURN 2
******************************************************************





