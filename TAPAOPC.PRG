MESCOPIA=SPACE(5)

CENTRA(23,XCAD[1])
BORDA(05,04,12,14,COR22)
PROG=5
A=ACHOICE(06,05,11,13,CAD,.T.,"tapaFUNCA")
DO CASE
CASE A=6
     DO WHILE .NOT. LASTKEY()=27
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"CONSULTA MESES ANTERIORES")
        BORDA(04,02,19,77,setcolor())
	RUN CD SEGUR
	QUANT=ADIR("TA*.SRC")
	DECLARE VET_ARQUIVOS[QUANT]
	ADIR("TA*.SRC", VET_ARQUIVOS)        
	RUN CD ..
	FOR X=1 TO QUANT
	    @ 05+X,10 PROMPT VET_ARQUIVOS[X]
	NEXT X
	MENU TO VET_TROCA
	@ 3+QUANT,30 SAY "QUER CONSULTAR ESTE ARQUIVO?" GET SN
	READ
	IF LASTKEY()=27
           EXIT	
	ELSEIF UPPER(SN)="S"
	  CLOSE ALL
	  IF TROCA_MES="OK" 
	     RUN DEL TABELA.SRC   >> NUL
	     RUN DEL TITULOS.SRC  >> NUL
           ELSE
             RUN REN TABELA.SRC BACKELA.SRC  >> NUL
	     RUN REN TITULOS.SRC BACKULOS.SRC  >> NUL
   	  ENDIF

	   ARQ1="SEGUR\"+VET_ARQUIVOS[VET_TROCA]
	   ARQ2="SEGUR\TI"+SUBSTR(VET_ARQUIVOS[VET_TROCA],3,10)

	   RUN COPY &ARQ1 TABELA.SRC >> NUL
	   RUN COPY &ARQ2 TITULOS.SRC >> NUL

	   TROCA_MES="OK"
	   @ 12+QUANT,10 SAY "ESTE ARQUIVO E TEMPORARIO E SERA DESATIVADO QUANDO SAIRES DO PROGRAMA TAPAJOS" 
	   @ 13+QUANT,10 SAY "Pressione uma tecla para continuar..."
	   INKEY(0)
           USE &SHAR51
           INDEX ON BLOCO TO &SHAR52
           USE &SHAR41
           INDEX ON APTO TO &SHAR42
           INDEX ON BLOCO TO &SHAR43
           INDEX ON BLOCO+APTO TO &SHAR45
           INDEX ON CONDOMINO TO &SHAR44
	   CLOSE ALL
	   EXIT
        ENDIF
ENDDO

CASE A=4
     DO WHILE .NOT. LASTKEY()=27
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"COPIA DE SEGURANCA")
        BORDA(04,02,19,77,setcolor())
        @ 07,10 SAY "MES DA COPIA..:" GET MESCOPIA PICT "99-99"
        READ
        IF LASTKEY()=27
           EXIT
        ENDIF
        NOMEARQ1="A:\TAB"+MESCOPIA
        NOMEARQ2="A:\TIT"+MESCOPIA
        IF FILE(NOMEARQ1) .OR. FILE(NOMEARQ2)
           AVISO("Ja existe arquivo com este nome no disquete")
        ENDIF   
        
        @ 09,10 SAY "CONFIRMA COPIA:" GET SN PICT "@!" VALID (SN$"SN")
        READ
        IF LASTKEY()=27
           EXIT
        ENDIF
        
        IF SN="N"
           LOOP
        ENDIF
        
        COPY FILE TABELA.SRC TO &NOMEARQ1
        COPY FILE TITULOS.SRC TO &NOMEARQ2
        AVISO("ARQUIVOS COPIADOS")
     ENDDO
CASE A=5
     DO WHILE .NOT. LASTKEY()=27
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"RETORNA COPIA DE SEGURANCA")
        CENTRA(06,"ESTE PROCEDIMENTO APAGARA' OS DADOS DO MICRO, COLOCANDO OS DO DISQUETE")
        BORDA(04,02,19,77,setcolor())
        @ 07,10 SAY "MES DA COPIA..:" GET MESCOPIA PICT "99-99"
        READ
        IF LASTKEY()=27
           EXIT
        ENDIF
        NOMEARQ1="A:\TAB"+MESCOPIA
        NOMEARQ2="A:\TIT"+MESCOPIA
        *DESTINO1="C:\SIRC\TABELA.SRC"
        *DESTINO2="C:\SIRC\TITULOS.SRC"
        IF FILE(NOMEARQ1) 
           AVISO("Retorno do arquivo da Tabela")
           @ 09,10 SAY "CONFIRMA COPIA:" GET SN PICT "@!" VALID (SN$"SN")
           READ
           IF LASTKEY()=27
              EXIT
           ELSEIF SN="N"
              LOOP
           ENDIF
           COPY FILE &NOMEARQ1 TO C:\SIRC\TABELA.SRC
           AVISO("ARQUIVO DA TABELA RETORNADO")
         else
           AVISO("Arquivo da tabela nao existente")
        ENDIF   
        
        IF FILE(NOMEARQ2) 
           AVISO("Retorno do arquivo dos Titulos")
           @ 09,10 SAY "CONFIRMA COPIA:" GET SN PICT "@!" VALID (SN$"SN")
           READ
           IF LASTKEY()=27
              EXIT
           ELSEIF SN="N"
              LOOP
           ENDIF
           COPY FILE &NOMEARQ2 TO C:\SIRC\Titulos.SRC
           AVISO("ARQUIVO DE TITULOS RETORNADO")
         else
           AVISO("Arquivo de titulos nao existente")
        ENDIF   
        
     enddo
CASE A=3
     DO WHILE .NOT. LASTKEY()=27
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"Conferencias de Somas por apartamento")
        BORDA(04,02,19,77,setcolor())
        USE &SHAR41
        INDEX ON apto TO &SHAR47
        GOTO TOP
        DO WHILE .NOT. EOF()
           IF EOF()
              EXIT
           ENDIF
           SOMA=VAL("99999.99")
           SOMA=TIT1+TIT2+TIT3+TIT4+TIT5+TIT6+TIT7
           @ 09,10 SAY "APARTAMENTO.: " + APTO
           @ 10,10 SAY "TITULO 1....: " + STR(TIT1)
           @ 11,10 SAY "TITULO 2....: " + STR(TIT2)
           @ 12,10 SAY "TITULO 3....: " + STR(TIT3)
           @ 13,10 SAY "TITULO 4....: " + STR(TIT4)
           @ 14,10 SAY "TITULO 5....: " + STR(TIT5)
           @ 15,10 SAY "TITULO 6....: " + STR(TIT6)
           @ 16,10 SAY "TITULO 7....: " + STR(TIT7)
           @ 17,10 SAY "TOTAL.......: " + STR(TOTAL)
           @ 18,10 SAY "TOTAL GERAL.: " + STR(SOMA)
           INKEY(0.01)
           IF ! ROUND(TOTAL,2)=ROUND(SOMA,2)
              AVISO("SOMA DO "+APTO+":"+STR(SOMA)+" , INFORMADO :"+STR(TOTAL))
           ENDIF
           SKIP +1
        ENDDO
        IF EOF()
           EXIT
        ENDIF
        
     ENDDO
CASE A=2
     Conf_somat_blocos()
CASE A=1
     DO WHILE .NOT. LASTKEY()=27
        @ 04,02 CLEAR TO 19,77
        CENTRA(05,"INCLUSAO DE APTO")
        BORDA(04,02,19,77,setcolor())
        XBLOCO=SPACE(5)
        XCONDOM=SPACE(30)
        XAPTO=SPACE(4)
        SN="N"
        @ 10,10 SAY "Bloco a incluir..." GET XBLOCO PICT"@!" VALID TESTABLOCO(XBLOCO)
        @ 12,10 SAY "Apto a incluir...." GET XAPTO PICT "@!" VALID !EMPTY(XAPTO)
        @ 14,10 SAY "Condomino........." GET XCONDOM PICT "@!" VALID !EMPTY(XCONDOM)
        READ
        IF LASTKEY()=27
           EXIT
        ENDIF
        @ 16,10 SAY "Confirma inclusao?" GET SN PICT "@!" VALID(SN="S" .OR. SN="N")
        READ
        IF LASTKEY()=27
           EXIT
        ENDIF
        IF !NOVOAPTO(XAPTO)
           *SET COLOR TO I*
           @ 17,10 SAY "APTO EXISTENTE"
           INKEY(2)
           *SET COLOR TO
           LOOP
        ENDIF
        USE &SHAR41 INDEX &SHAR42
        GOTO TOP
        IF FLOCK()
        APPE BLAN
        REPLACE APTO  WITH XAPTO
        REPLACE BLOCO WITH XBLOCO
        REPLACE CONDOMINO WITH XCONDOM
        COMMIT
        ELSE
           AVISO("FLOCK - OUTRO USUARIO ATIVO")
        ENDIF
        CLOSE ALL
     ENDDO
ENDCASE


*****************************
FUNCTION Conf_somat_blocos()
*****************************
oldcor=setcolor()
     DO WHILE .NOT. LASTKEY()=27
        @ 04,02 CLEAR TO 19,77
        xxxBLOCO={"2368","44","64","88","GARAG","LOJAS"," " }
        xxxCONT=1
        CENTRA(05,"Conferencias de Somas por Bloco")

     DO WHILE .T.
        if lastkey()=27 .OR. XXXCONT=7
            exit
        endif
        USE &SHAR41
        INDEX ON BLOCO TO &SHAR46 FOR BLOCO=XXXBLOCO[XXXCONT]
        GOTO TOP
        STORE 0 TO XTIT1,XTIT2,XTIT3,XTIT4,XTIT5,XTIT6,XTIT7
        DO WHILE .NOT. EOF()
           XTIT1=XTIT1+TIT1
           XTIT2=XTIT2+TIT2
           XTIT3=XTIT3+TIT3
           XTIT4=XTIT4+TIT4
           XTIT5=XTIT5+TIT5
           XTIT6=XTIT6+TIT6
           XTIT7=XTIT7+TIT7
           SKIP +1
        ENDDO
        SET COLOR TO &cor19
        @ 6+(XXXCONT*2),02 SAY XXXBLOCO[XXXCONT]
        SET COLOR TO
        @ 6+(XXXCONT*2),08 SAY XTIT1 PICT "@e 9,999.99"
        SET COLOR TO &cor20
        @ 6+(XXXCONT*2),16 SAY XTIT2 PICT "@e 9,999.99"
        SET COLOR TO  
        @ 6+(XXXCONT*2),24 SAY XTIT3 PICT "@e 9,999.99"
        SET COLOR TO &cor20
        @ 6+(XXXCONT*2),32 SAY XTIT4 PICT "@e 9,999.99"
        SET COLOR TO  
        @ 6+(XXXCONT*2),40 SAY XTIT5 PICT "@e 9,999.99"
        SET COLOR TO &cor20

        @ 6+(XXXCONT*2),48 SAY XTIT6 PICT "@e 9,999.99"
        SET COLOR TO  
        @ 6+(XXXCONT*2),56 SAY XTIT7 PICT "@e 9,999.99"
        SET COLOR TO &cor21
        @ 6+(XXXCONT*2),67 SAY (XTIT1+XTIT2+XTIT3+XTIT4+XTIT5+XTIT6+XTIT7) PICT "@e 9,999.99"
        SET COLOR TO &cor19
        @ 7+(XXXCONT*2),02 TO 7+(XXXCONT*2),78
      
     XXXCONT++
     IF XXXCONT=7
        INKEY(0)
        EXIT
     ENDIF
     ENDDO
     IF XXXCONT=7
        EXIT
     ENDIF
    
    ENDDO
setcolor(oldcor)
RETURN(.T.)
