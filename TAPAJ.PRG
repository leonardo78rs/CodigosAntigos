SET DATE FORMAT TO "dd/mm/yyyy"
*SET DECIMALS TO 6
X="LPT1"
PARA X

      IF MDIMP99=6
         IMPLPT=DIRECPASTIMP(1)
      ELSEIF MDIMP99=7
         IMPLPT=DIRECPASTIMP(2)
      ENDIF


SET EXACT ON
SET PROCEDURE TO TAPAFUNC
**** GERA TODOS NTX
CLEAR
@ 00,00 TO 24,79

USE &SHAR51
INDEX ON BLOCO TO &SHAR52
USE &SHAR41
INDEX ON APTO TO &SHAR42
INDEX ON BLOCO TO &SHAR43
INDEX ON BLOCO+APTO TO &SHAR45
INDEX ON CONDOMINO TO &SHAR44
CLOSE ALL

***** DECLARACAO AMBIENTE
TROCA_MES="NADA"
SET COLOR TO &COR22
CLEAR
SET DATE FRENCH
SET SCORE OFF
SET WRAP ON
SET MESSAGE TO 23 CENTER
SET CURSOR ON
*** DECLARACAO DOS VETORES ACHOICE
FIM={"CONFIRMA"}
XFIM={"Confirma saida p/DOS"}
TIT={"   2368  ","    88   ","    44   ","    64   ","  LOJAS  ","  GARAG  "}
DIG={"TELA CHEIA","  GERAL   ","  BLOCO   ","   AGUA  ","  ----  "}
REL={"  GERAL   ","  BLOCO   ","  APTO.  "," ARRECAD "," ------- "," TABELA  "}
XTIT={"T¡tulos Tabela do Bloco 2368  ","T¡tulos Tabela do Bloco 88  ","T¡tulos Tabela do Bloco 44  ","T¡tulos Tabela do Bloco    64   ","T¡tulos Tabela do Bloco das Lojas  ","T¡tulos Tabela do Bloco  GARAG  "}
XDIG={"Digita em tela cheia com todos os Cond“minos","Digita dados para todos em um registro","Digita dados para determinado bloco em um registro","Agua para todos blocos","----------------"}
XREL={"Imprime todos","Imprime por Bloco","Imprime um unico proprietario","Imprime o Slip de arrecadacao para a Contabilidade","-----------------------------------------------"," Tabela geral dos valores  "}
CAD={"  INCLUI  "," Cf.Bloco "," Cf.Apto. "," COPIA "," RESTAURA ","MES ANT"}
XCAD={"Inclui novo proprietario","Conferencia das Somas das Colunas por Bloco","Conferencia dos Totais de Apartamento","Realiza Copia","Retorna Copia","Consulta meses anteriores"}
XVARIA=" "
**** VARIAVEIS
SN=" "
PROG=0
CODI_DOC=0
CONT=0
OBS="Pagavel em qualquer Agencia da C.Econ.Federal!"+SPACE(30)
OPCAO=0

XBL=SPACE(5)
MESANO="  /    "
XAP=SPACE(4)
VENC=CTOD(SPACE(10))

**** A         -   VARIAVEL VETOR ACHOICE
**** XTOTAL    -   VARIAVEL SOMA TITULOS (DIGITACAO P/TODOS)

MASCARA_NO="@E 9,999.99"
STORE VAL("0000.00") TO XTIT1,XTIT2,XTIT3,XTIT4,XTIT5,XTIT6,XTIT7
KEYB CHR(13)
DO WHILE .T.
   DO TAPATELA.PRG
*   SAVE SCRE TO TELA1
   DO CASE
   CASE OPCAO=1
        DO TAPATIT.PRG
   CASE OPCAO=2
        DO TAPADIG.PRG
   CASE OPCAO=3
        DO TAPAIMP.PRG
   CASE OPCAO=4
        PROG=4
        CENTRA(23,XFIM[1])
        BORDA(05,66,07,75,COR22)
        A=ACHOICE(06,67,06,74,FIM,.T.,"tapaFUNCA")
        IF A=1
           CLOSE ALL
           CLEAR

IF TROCA_MES="OK"
   RUN DEL TABELA.SRC >> NUL
   RUN DEL TITULOS.SRC >> NUL
   RUN REN BACKELA.SRC TABELA.SRC >> NUL
   RUN REN BACKULOS.SRC TITULOS.SRC >> NUL 
ENDIF

MEZANO=DTOC(DATE())

IF VAL(SUBSTR(MEZANO,1,2))<15
   AMES=-1
ELSE
   AMES=0
ENDIF

MEZ=ALLTRIM(STR(  VAL(SUBSTR(MEZANO,4,2))+AMES ) )
ANO=SUBSTR(MEZANO,7,4)
MEZANO=MEZ+ANO
	   T_TIT_COPIA="SEGUR\TI"+MEZANO+".SRC"
	   T_TAB_COPIA="SEGUR\TA"+MEZANO+".SRC"
           ! COPY TABELA.SRC &T_TAB_COPIA
           ! COPY TITULOS.SRC &T_TIT_COPIA
           SET DECIMALS TO 0
	   RETURN(.T.)
        ENDIF
        
   CASE OPCAO=5
        DO TAPAOPC.PRG
   ENDCASE
   
ENDDO
