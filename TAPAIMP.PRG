TTMES=ALLTRIM(STR(VAL(   SUBSTR(  DTOC(DATE()),4,2  )   )+1))
TTANO=SUBSTR(DTOC(DATE()),7,4)
IF SUBSTR(  DTOC(DATE()),4,2  )="12"
   TTMES="01"
   TTANO=ALLTRIM(STR(VAL(SUBSTR(DTOC(DATE()),7,4))+1))
ENDIF

DEVOLVER="NAO RECEBER APOS 25/"+TTMES+"/"+TTANO
DEVOLMULTA="APOS VENCIMENTO MULTA DE 2% + COM.PERM.DA CEF"
**  
DOC=0

DO WHILE .NOT. LASTKEY()=27
   PROG=3
   CENTRA(23,XREL[1])
   BORDA(05,51,12,61,COR22)
   A=ACHOICE(06,52,11,60,REL,.T.,"tapaFUNCA")
   DO CASE
   CASE A=6
        DO TABE.PRG
        KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
   CASE A=1
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"IMPRESSAO GERAL")
        CENTRA(07,"PARA IMPRIMIR O RELATORIO DE TODOS OS PROPRIETARIOS")
        BORDA(04,02,19,77,setcolor())
        @ 09,10 SAY "DATA DE HOJE " + dtoc(date())
        @ 10,10 SAY "MES/ANO....: " GET MESANO
        @ 11,10 SAY "VENCIMENTO.: " GET VENC
        *@ 12,10 SAY "OBS.......: " GET OBS PICT "@!C"
        @ 12,10 SAY "OBS........: " GET DEVOLVER
        @ 13,10 SAY "OBS........: " GET DEVOLMULTA
        READ
        @ 14,10 SAY "CONFIRMA...: " GET SN PICT"@!" VALID(SN="S" .OR. SN="N")
        READ
        IF SN="N"
           LOOP
        ELSEIF LASTKEY()=27
           LOOP
        ENDIF
        @ 15,30 CLEAR TO 17,61
        AVISO("LIGUE A IMPRESSORA E TECLE <ENTER>")
        SET PRINTER TO &IMPLPT
        SET DEVICE TO PRINT
        SET CONSOLE OFF
        USE &SHAR51 INDEX &SHAR52
        DECLARE VTITULO[6,7]
        LIN=0
        DO WHILE LIN<6
           LIN=LIN+1
           VTITULO[LIN,1]=TITULO1
           VTITULO[LIN,2]=TITULO2
           VTITULO[LIN,3]=TITULO3
           VTITULO[LIN,4]=TITULO4
           VTITULO[LIN,5]=TITULO5
           VTITULO[LIN,6]=TITULO6
           VTITULO[LIN,7]=TITULO7
           SKIP +1
        ENDDO
        
        USE &SHAR41 INDEX &SHAR45
        GOTO TOP
        DO WHILE .NOT. EOF()
           DO CASE
           CASE BLOCO="2368 "
                X=1
           CASE BLOCO="44   "
                X=2
           CASE BLOCO="64   "
                X=3
           CASE BLOCO="88   "
                X=4
           CASE BLOCO="GARAG"
                X=5
           CASE BLOCO="LOJAS"
                X=6
           ENDCASE
           DOC=DOC+1
              @ PROW()+1,02 SAY " "
              @ PROW()+0,95 SAY VENC
              @ PROW()+3,02 SAY DATE()
              @ PROW()+1,97 SAY TOTAL PICT MASCARA_NO
              
              IF .NOT. EMPTY(TIT1)
                 @ PROW()+2,03 SAY VTITULO[X,1]
                 @ PROW()+0,27 SAY TIT1 PICT MASCARA_NO
              ELSE
                 @ PROW()+2,00 SAY ""
              ENDIF
              
              IF .NOT. EMPTY(TIT2)
                 @ PROW()+0,40 SAY VTITULO[X,2]
                 @ PROW()+0,64 SAY TIT2 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT3)
                 @ PROW()+1,03 SAY VTITULO[X,3]
                 @ PROW()+0,27 SAY TIT3 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF
              
              IF .NOT. EMPTY(TIT4)
                 @ PROW()+0,40 SAY VTITULO[X,4]
                 @ PROW()+0,64 SAY TIT4 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT5)
                 @ PROW()+1,03 SAY VTITULO[X,5]   
                 @ PROW()+0,27 SAY TIT5 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF

              IF .NOT. EMPTY(TIT6)
                 @ PROW()+0,40 SAY VTITULO[X,6]
                 @ PROW()+0,64 SAY TIT6 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT7)
                 @ PROW()+1,03 SAY VTITULO[X,7]
                 @ PROW()+0,27 SAY TIT7 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF

              @ PROW()+1,102 SAY " "                
              @ PROW()+1,02 SAY  DEVOLVER
              @ PROW()+1,02 SAY  DEVOLMULTA 
              @ PROW()+2,02 SAY "PROPRIETARIO:"
              @ PROW()+0,16 SAY CONDOMINO
              @ PROW()+0,64 SAY "MES:"  
              @ PROW()+0,69 SAY MESANO
              @ PROW()+1,02 SAY "BLOCO/APTO.:"
              @ PROW()+0,15 SAY BLOCO+"/"+APTO
              @ PROW()+8,00 SAY "    "
              SET PRINTER TO
              SET PRINTER OFF
              SET DEVICE TO SCREEN
AVISO3("<R> Retorna Imp p/ "+BLOCO+"/"+APTO+" ³(P) Ret ao Prim. da lista","<Enter> Prox cond“mino        ³ <Esc> Cancela Impressao")
              SET PRINTER TO &IMPLPT
              SET PRINTER ON
              SET DEVICE TO PRINT
              IF LASTKEY()=82 .OR. LASTKEY()=114
                 SKIP -1
              ELSEIF LASTKEY()=80 .OR. LASTKEY()=112
                 GOTO TOP
              ELSEIF LASTKEY()=27
                 exit
              ELSE
                 SKIP +1
              ENDIF
              
        ENDDO
        SET PRINTER TO
        SET PRINTER OFF
        SET DEVICE TO SCREEN
        SET CONSOLE ON
        CLOSE ALL
        
   CASE A=2
        DOC=0
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"IMPRESSAO POR BLOCO")
        CENTRA(07,"PARA IMPRIMIR O RELATORIO DE UM BLOCO INTEIRO")
        BORDA(04,02,19,77,setcolor())
        @ 09,10 SAY "BLOCO......: " GET XBL
        @ 10,10 SAY "MES/ANO....: " GET MESANO
        @ 11,10 SAY "VENCIMENTO.: " GET VENC
        *@ 12,10 SAY "OBS.......: " GET OBS PICT "@!C"
        @ 12,10 SAY "OBS........: " GET DEVOLVER
        @ 13,10 SAY "OBS........: " GET DEVOLMULTA
        READ
        @ 14,10 SAY "CONFIRMA...: " GET SN PICT"@!" VALID(SN="S" .OR. SN="N")
        READ
        IF SN="N"
           LOOP
        ELSEIF LASTKEY()=27
           LOOP
        ENDIF
        @ 15,30 CLEAR TO 17,61
        AVISO("LIGUE A IMPRESSORA E TECLE <ENTER>")
              SET PRINTER TO &IMPLPT
              SET PRINTER ON
              SET DEVICE TO PRINT

        
        SET CONSOLE OFF
        USE &SHAR51 INDEX &SHAR52
        DECLARE VTITULO[6,7]
        LIN=0
        DO WHILE LIN<6
           LIN=LIN+1
           VTITULO[LIN,1]=TITULO1
           VTITULO[LIN,2]=TITULO2
           VTITULO[LIN,3]=TITULO3
           VTITULO[LIN,4]=TITULO4
           VTITULO[LIN,5]=TITULO5
           VTITULO[LIN,6]=TITULO6
           VTITULO[LIN,7]=TITULO7
           SKIP +1
        ENDDO
        
        USE &SHAR41 INDEX &SHAR45
        GOTO TOP
        DO WHILE .NOT. EOF()
           DO CASE
           CASE BLOCO="2368 "
                X=1
           CASE BLOCO="44   "
                X=2
           CASE BLOCO="64   "
                X=3
           CASE BLOCO="88   "
                X=4
           CASE BLOCO="GARAG"
                X=5
           CASE BLOCO="LOJAS"
                X=6
           ENDCASE
           IF XBL=BLOCO
              DOC=DOC+1
              @ PROW()+1,02 SAY " "
              @ PROW()+0,95 SAY VENC
              @ PROW()+3,02 SAY DATE()
              @ PROW()+1,97 SAY TOTAL PICT MASCARA_NO
              
              IF .NOT. EMPTY(TIT1)
                 @ PROW()+2,03 SAY VTITULO[X,1]
                 @ PROW()+0,27 SAY TIT1 PICT MASCARA_NO
              ELSE
                 @ PROW()+2,00 SAY ""
              ENDIF
              
              IF .NOT. EMPTY(TIT2)
                 @ PROW()+0,40 SAY VTITULO[X,2]
                 @ PROW()+0,64 SAY TIT2 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT3)
                 @ PROW()+1,03 SAY VTITULO[X,3]
                 @ PROW()+0,27 SAY TIT3 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF
              
              IF .NOT. EMPTY(TIT4)
                 @ PROW()+0,40 SAY VTITULO[X,4]
                 @ PROW()+0,64 SAY TIT4 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT5)
                 @ PROW()+1,03 SAY VTITULO[X,5]   
                 @ PROW()+0,27 SAY TIT5 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF

              IF .NOT. EMPTY(TIT6)
                 @ PROW()+0,40 SAY VTITULO[X,6]
                 @ PROW()+0,64 SAY TIT6 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT7)
                 @ PROW()+1,03 SAY VTITULO[X,7]
                 @ PROW()+0,27 SAY TIT7 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF
              @ PROW()+1,102 SAY " "                
              @ PROW()+1,02 SAY DEVOLVER
              @ PROW()+1,02 SAY  DEVOLMULTA 
              @ PROW()+2,02 SAY "PROPRIETARIO:"
              @ PROW()+0,16 SAY CONDOMINO
              @ PROW()+0,64 SAY "MES:"  
              @ PROW()+0,69 SAY MESANO
              @ PROW()+1,02 SAY "BLOCO/APTO.:"
              @ PROW()+0,15 SAY BLOCO+"/"+APTO
              @ PROW()+8,00 SAY "    "
              SET PRINTER TO
              SET PRINTER OFF
              SET DEVICE TO SCREEN
              AVISO3("<R> Retorna Impressao para "+BLOCO+"/"+APTO+"  ³  (P)  Retorna ao Primeiro da lista","<Enter> Proximo cond“mino               ³  <Esc> Cancela Impressao")
              SET PRINTER TO &IMPLPT
              SET PRINTER ON
              SET DEVICE TO PRINT
              IF LASTKEY()=82 .OR. LASTKEY()=114
                 SKIP -1
              ELSEIF LASTKEY()=80 .OR. LASTKEY()=112
                 GOTO TOP
              ELSEIF LASTKEY()=27
                 exit
              ELSE
                 SKIP +1
              ENDIF


              SET PRINTER TO
              SET PRINTER ON
              SET DEVICE TO PRINT
            ELSE
              SKIP +1
           ENDIF


        ENDDO
        SET PRINTER TO
        SET PRINTER OFF
        SET DEVICE TO SCREEN
        SET CONSOLE ON
        CLOSE ALL
   CASE A=3
        DOC=0
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"IMPRESSAO POR APTO")
        CENTRA(07,"PARA IMPRIMIR APENAS UM PROPRIETARIO")
        BORDA(04,02,19,77,setcolor())
        @ 10,10 SAY "APARTAMENTO: " GET XAP 
        @ 11,10 SAY "MES/ANO....: " GET MESANO
        @ 12,10 SAY "VENCIMENTO.: " GET VENC
        *@ 13,10 SAY "OBS........: " GET OBS PICT "@!C"
        @ 13,10 SAY "OBS........: " GET DEVOLVER
        @ 14,10 SAY "OBS........: " GET DEVOLMULTA
        READ
        @ 15,10 SAY "CONFIRMA...: " GET SN PICT"@!" VALID(SN="S" .OR. SN="N")
        READ
        IF SN="N"
           LOOP
        ELSEIF LASTKEY()=27
           LOOP
        ENDIF
        @ 15,30 CLEAR TO 17,61
        AVISO("LIGUE A IMPRESSORA E TECLE <ENTER>")
              SET PRINTER TO &IMPLPT
              SET PRINTER ON
              SET DEVICE TO PRINT
        SET CONSOLE OFF
        USE &SHAR51 INDEX &SHAR52
        DECLARE VTITULO[6,7]
        LIN=0
        DO WHILE LIN<6
           LIN=LIN+1
           VTITULO[LIN,1]=TITULO1
           VTITULO[LIN,2]=TITULO2
           VTITULO[LIN,3]=TITULO3
           VTITULO[LIN,4]=TITULO4
           VTITULO[LIN,5]=TITULO5
           VTITULO[LIN,6]=TITULO6
           VTITULO[LIN,7]=TITULO7
           SKIP +1
        ENDDO
        
        USE &SHAR41 INDEX &SHAR42
        GOTO TOP
        DO WHILE .NOT. EOF()
           DO CASE
           CASE BLOCO="2368 "
                X=1
           CASE BLOCO="44   "
                X=2
           CASE BLOCO="64   "
                X=3
           CASE BLOCO="88   "
                X=4
           CASE BLOCO="GARAG"
                X=5
           CASE BLOCO="LOJAS"
                X=6
           ENDCASE
           IF XAP=APTO
              DOC=DOC+1
              @ PROW()+1,02 SAY "  "
              @ PROW()+0,95 SAY VENC
              @ PROW()+3,02 SAY DATE()
              @ PROW()+1,97 SAY TOTAL PICT MASCARA_NO
              
              IF .NOT. EMPTY(TIT1)
                 @ PROW()+2,03 SAY VTITULO[X,1]
                 @ PROW()+0,27 SAY TIT1 PICT MASCARA_NO
              ELSE
                 @ PROW()+2,00 SAY ""
              ENDIF
              
              IF .NOT. EMPTY(TIT2)
                 @ PROW()+0,40 SAY VTITULO[X,2]
                 @ PROW()+0,64 SAY TIT2 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT3)
                 @ PROW()+1,03 SAY VTITULO[X,3]
                 @ PROW()+0,27 SAY TIT3 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF
              
              IF .NOT. EMPTY(TIT4)
                 @ PROW()+0,40 SAY VTITULO[X,4]
                 @ PROW()+0,64 SAY TIT4 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT5)
                 @ PROW()+1,03 SAY VTITULO[X,5]   
                 @ PROW()+0,27 SAY TIT5 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF

              IF .NOT. EMPTY(TIT6)
                 @ PROW()+0,40 SAY VTITULO[X,6]
                 @ PROW()+0,64 SAY TIT6 PICT MASCARA_NO
              ENDIF
              
              IF .NOT. EMPTY(TIT7)
                 @ PROW()+1,03 SAY VTITULO[X,7]
                 @ PROW()+0,27 SAY TIT7 PICT MASCARA_NO
              ELSE
                 @ PROW()+1,00 SAY ""
              ENDIF
              @ PROW()+1,102 SAY " "                
              @ PROW()+1,02 SAY  DEVOLVER 
              @ PROW()+1,02 SAY  DEVOLMULTA 
              @ PROW()+2,02 SAY "PROPRIETARIO:"
              @ PROW()+0,16 SAY CONDOMINO
              @ PROW()+0,64 SAY "MES:"  
              @ PROW()+0,69 SAY MESANO
              @ PROW()+1,02 SAY "BLOCO/APTO.:"
              @ PROW()+0,15 SAY BLOCO+"/"+APTO
              @ PROW()+8,00 SAY "    "
           ENDIF

           SKIP +1
        ENDDO
        SET PRINTER TO
        SET PRINTER OFF
        SET DEVICE TO SCREEN
        SET CONSOLE ON
        CLOSE ALL
   CASE A=4
        qual_bloco="2368 " 
        somat_bloco=0
        MESANO=SPACE(7)
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"IMPRESSAO DO SLIP DO FATURAMENTO")
        @ 10,10 SAY "MES/ANO....: " GET MESANO PICT "XXX/99"
        READ
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"IMPRESSAO DO SLIP DO FATURAMENTO")
        CENTRA(07,"TECLE <ENTER> PARA IMPRIMIR OU <ESC> PARA CANCELAR")
        BORDA(04,02,19,77,setcolor())
        INKEY(0)
        IF LASTKEY()=27
           MESANO="  /    "
           EXIT
        ENDIF
        PAGINA=0
        USE &SHAR41 INDEX &SHAR45
        GOTO TOP
              SET PRINTER TO &IMPLPT
              SET PRINTER ON
              SET DEVICE TO PRINT
        FATUR_TOTAL=0
        CONTADOR=0

        DO WHILE .NOT. EOF()
           PAGINA++
           CABECALHO( ALLTRIM(STR(PAGINA))+"/3",1)
           DO WHILE PROW()<56
                
                CONTADOR++
                SET DEVICE TO SCREEN
                @ 10,10 SAY "Imprimindo n§..: " + str(contador) +"/"+str(lastrec())
                SET DEVICE TO PRINT
              DO CASE
                 CASE QUAL_BLOCO="2368 "
                      contra_partida="399.9"
                 CASE QUAL_BLOCO="44   "
                      contra_partida="400.6"
                 CASE QUAL_BLOCO="64   "
                      contra_partida="401.4"
                 CASE QUAL_BLOCO="88   "
                      contra_partida="402.2"
                 CASE QUAL_BLOCO="GARAG"
                      contra_partida="403.1"
                 CASE QUAL_BLOCO="LOJAS"
                      contra_partida="404.9"
                 OTHERWISE
                      contra_partida="*ERRO"
              ENDCASE
              if !qual_bloco=bloco
                  @ PROW()+1,00 SAY " Faturam.Total "+qual_bloco+"| "+contra_part+"|  602 | "+MESANO+"  |              |"
                  @ PROW()+0,67 SAY somat_bloco PICT "@e 999,999.99"
                  @ PROW()+0,78 SAY "|"
                  @ PROW()+1,00 SAY REPLICATE("-",79)

                  qual_bloco=bloco
                  somat_bloco=0
              endif
              somat_bloco=somat_bloco+total
              IF EOF()
                 MESANO="  /    "
                 EXIT
              ENDIF
              FATUR_TOTAL=FATUR_TOTAL+TOTAL
              @ PROW()+1,00 SAY BLOCO+"-"+APTO+"-"+SUBSTR(CONDOMINO,1,8)+" | "+CTA+" |  601 | "+MESANO+"  |"
              @ PROW()+0,49 SAY TOTAL PICT "@e 999,999.99"
              @ PROW()+0,60 SAY "|                 |"
              @ PROW()+1,00 SAY REPLICATE("-",79)
              SKIP +1
           ENDDO
        ENDDO
        @ PROW()+2,01 SAY REPLICATE("=",79)
        @ PROW()+1,01 SAY " TOTAL PLANILHA     |      |      |          |                |"
        @ PROW()+0,50 SAY FATUR_TOTAL PICT "@e 999,999.99"
        @ PROW()+0,68 SAY FATUR_TOTAL PICT "@e 999,999.99"
        @ PROW()+0,79 SAY "|"
        @ PROW()+1,01 SAY REPLICATE("=",79)
        
        SET PRINTER OFF
        SET DEVICE TO SCREEN
        MESANO="  /    "
   CASE A=50
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"IMPRESSAO DO SLIP DE COBRANCA")
        @ 10,10 SAY "MES/ANO....: " GET MESANO
        READ
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"IMPRESSAO DO SLIP DE COBRANCA")
        CENTRA(07,"TECLE <ENTER> PARA IMPRIMIR OU <ESC> PARA CANCELAR")
        BORDA(04,02,19,77,setcolor())
        INKEY(0)
        IF LASTKEY()=27
           EXIT
        ENDIF
        PAGINA=0
        USE &SHAR41 INDEX &SHAR45
        GOTO TOP
        SET PRINTER ON
        SET DEVICE TO PRINT
        CONTADOR=0

        DO WHILE .NOT. EOF()
           PAGINA++
           CABECALHO( ALLTRIM(STR(PAGINA))+"/2",2)
           DO WHILE PROW()<56
                
                CONTADOR++
                SET DEVICE TO SCREEN
                @ 10,10 SAY "Imprimindo n§..: " + str(contador) +"/"+str(lastrec())
                SET DEVICE TO PRINT
              
              @ PROW()+1,01 SAY BLOCO+"-"+APTO+"-"+SUBSTR(CONDOMINO,1,8)+" | "+STR(CTA)+" |  603 | "+MESANO+"  |                |"
              @ PROW()+0,68 SAY TOTAL PICT "@e 999,999.99"
              @ PROW()+0,79 SAY "|"
              @ PROW()+1,01 SAY REPLICATE("-",79)
              SKIP +1
              IF EOF()
                 EXIT
              ENDIF
           ENDDO
        ENDDO
        @ PROW()+1,01 SAY " Caixa Ec.Federal   |  7.8 | 604  |        |                |"
        @ PROW()+0,79 SAY "|"
        @ PROW()+1,01 SAY REPLICATE("-",79)
        
        SET PRINTER OFF
        SET DEVICE TO SCREEN
        
   ENDCASE
   EXIT
ENDDO

*********************************************
FUNCTION CABECALHO(PAGINA,TIPO)
*********************************************
@ 01,00 SAY REPLICATE("-",79)

@ 02,00 SAY "| Assessoria Contabil Rimax |"
@ 02,00 SAY "  Assessoria Contabil Rimax" 
@ 02,35 SAY "N§ SLIP:____________"
@ 02,60 SAY "DATA: ___/___/___"




@ 03,00 SAY REPLICATE("-",79)


@ 04,00 SAY "EMPRESA: 603 - CONDOMINIO EDIFICIO TAPAJOS"
@ 04,48 SAY "PAGINA "+PAGINA
IF TIPO=1
   @ 04,58 SAY "-SLIP DE ARRECADACAO"
ELSEIF TIPO=2
   @ 04,58 SAY "-SLIP DE COBRANCA  "
ENDIF



@ 05,00 SAY REPLICATE("-",79)

@ 06,00 SAY "   PROPRIETARIO     |  CTA |  HP  |COMPL.H.  |    DEBITO    |     CREDITO     |"
@ 07,00 SAY REPLICATE("-",79)

RETURN(.T.)
