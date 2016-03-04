**
** FUNC.PRG
**
******************************************************************************
**                            FUNCOES DE TELA/BORDA/...                     **
******************************************************************************
FUNCTION BOTAOF(blin,bcol,bcor,bmens1,bmens2)
oldcor=setcolor()
setcolor(bcor)
@ blin,bcol clear to blin,bcol+len(bmens1)+1
@ blin,bcol+1 say bmens1
set color to &oldcor
@ blin,bcol+2+len(bmens1) say bmens2
return(.t.)

********************
function reler_cor(mdc)
********************
if mdc=1
   shar1=PASTASERV+"cormasc"
       ELSE
   shar1=PASTASERV+"cormas2"
endif
use &shar1
index on cor_num to &shar6
goto top
cor1=alltrim(cor_masc)
skip +1
cor2=alltrim(cor_masc)
skip +1
cor3=alltrim(cor_masc)
skip +1
cor4=alltrim(cor_masc)
skip +1
cor5=alltrim(cor_masc)
skip +1
cor6=alltrim(cor_masc)
skip +1
cor7=alltrim(cor_masc)
skip +1
cor8=alltrim(cor_masc)
skip +1
cor9=alltrim(cor_masc)
skip +1
cor10=alltrim(cor_masc)
skip +1
cor11=alltrim(cor_masc)
skip +1
cor12=alltrim(cor_masc)
skip +1
cor13=alltrim(cor_masc)
skip +1
cor14=alltrim(cor_masc)
skip +1
cor15=alltrim(cor_masc)
skip +1
cor16=alltrim(cor_masc)
skip +1
cor17=alltrim(cor_masc)
skip +1
cor18=alltrim(cor_masc)
skip +1
cor19=alltrim(cor_masc)
skip +1
cor20=alltrim(cor_masc)
skip +1
cor21=alltrim(cor_masc)
skip +1
cor22=alltrim(cor_masc)
skip +1
cor23=alltrim(cor_masc)
skip +1
cor24=alltrim(cor_masc)
skip +1
cor25=alltrim(cor_masc)
skip +1
cor26=alltrim(cor_masc)
skip +1
cor27=alltrim(cor_masc)
skip +1
cor28=alltrim(cor_masc)

use
return(.t.)


**************
FUNCTIO VIDEO(TIPO)
**************
IF ISCOLOR()
   IF TIPO=24
      CGA80()
   ELSEIF TIPO=28
      VGA28()
   ELSEIF TIPO=43
      EGA43()
   ELSEIF TIPO=50
      VGA50()
   ENDIF
 ELSE
   RETURN(.F.)
ENDIF
RETURN(.T.)
**************
FUNCTION BORDA
**************
KOR=""
OLDCOR=SETCOLOR()
SET CURSOR OFF
PARA XX,YY,ZZ,WW,KOR
IF EMPTY(KOR)
     SET COLOR TO W+/W
  ELSE
     SET COLOR TO &KOR
ENDIF
@ XX,YY TO ZZ,WW

@ ZZ+1,YY+1 SAY REPLICATE(CHR(223),WW-YY+1)
DO WHILE XX<ZZ
   XX=XX+1
   @ XX,WW+1 SAY CHR(219)
ENDDO
SETCOLOR(OLDCOR)
SET CURSOR ON
RETURN(.T.)
******************************************
FUNCTION AVISO(MENSAGEM)
*****************************
SET CURSOR OFF
VAR_COR=SETCOLOR()
SAVE SCREEN
SET COLOR TO &COR24
TAM=LEN(MENSAGEM)
DEMORA=TAM/10
COL1=((80-TAM)/2)-2
COL2=((80-TAM)/2)+TAM+2
COLUNA1=40
FOR COLUNA2=40 TO COL2
    COLUNA1--
    @ 09,COLUNA1+1 CLEAR TO 13,COLUNA2-1
    @ 09,COLUNA1 TO 13,COLUNA2
    MILLISEC(   (COL2-COLUNA2) * 0,4  )
NEXT COLUNA2
@ 10,((80-TAM)/2) SAY MENSAGEM
MENSAGEM=" OK "
SET COLOR TO &COR25
@ 12,38 SAY MENSAGEM
INKEY(0)
SETCOLOR(VAR_COR)
REST SCREEN
SET CURSOR ON
RETURN(.T.)
******************************************
FUNCTION AVISO3(MENS1,MENS2)
*****************************
SET CURSOR OFF
VAR_COR=SETCOLOR()
SAVE SCREEN
SET COLOR TO &COR24
TAM=LEN(MENS1)
COL1=((80-TAM)/2)-2
COL2=((80-TAM)/2)+TAM+2
COLUNA1=40
FOR COLUNA2=40 TO COL2
    COLUNA1--
    @ 09,COLUNA1+1 CLEAR TO 13,COLUNA2-1
    @ 09,COLUNA1 TO 13,COLUNA2
    MILLISEC((COL2-COLUNA2)/20)
NEXT COLUNA1
@ 10,((80-TAM)/2) SAY MENS1
@ 12,((80-TAM)/2) SAY MENS2
INKEY(0)
SETCOLOR(VAR_COR)
REST SCREEN
SET CURSOR ON
RETURN(.T.)
******************************************
FUNCTION AVISO5(MENS1,MENS2)
*****************************
SET CURSOR OFF
VAR_COR=SETCOLOR()
SAVE SCREEN
SET COLOR TO &COR24

TAM=LEN(MENS1)

IF LEN(MENS1) < (LEN(MENS2)+14)
   TAM=LEN(MENS2)+14
ENDIF

COL1=((80-TAM)/2)-2
COL2=((80-TAM)/2)+TAM+2
COLUNA1=40
FOR COLUNA2=40 TO COL2
    COLUNA1--
    @ 09,COLUNA1+1 CLEAR TO 18,COLUNA2-1
    @ 09,COLUNA1 TO 18,COLUNA2
    MILLISEC((COL2-COLUNA2)/20)
NEXT COLUNA1
@ 10,((80-TAM)/2) SAY MENS1
@ 12,((80-TAM)/2) say "Imprimindo em "
SET COLOR TO &COR23
@ 12,14+((80-TAM)/2) SAY MENS2
INKEY(0)
SETCOLOR(VAR_COR)
REST SCREEN
SET CURSOR ON
RETURN(.T.)


***************************************
FUNCTION AVISO2(MENSAGEM,OPCAO1,OPCAO2)
*****************************
SET CURSOR OFF
VAR_COR=SETCOLOR()
SAVE SCREEN
SET COLOR TO &COR24
TAM=LEN(MENSAGEM)
TAM2=LEN(OPCAO1)+LEN(OPCAO2)+3
IF TAM<TAM2
   TAM=TAM2
ENDIF
COL1=((80-TAM)/2)-2
COL2=((80-TAM)/2)+TAM+2
COLUNA1=40
FOR COLUNA2=40 TO COL2
    COLUNA1--
    @ 09,COLUNA1+1 CLEAR TO 13,COLUNA2-1
    @ 09,COLUNA1 TO 13,COLUNA2
    MILLISEC((COL2-COLUNA2)/2)
NEXT COLUNA1
@ 10,((80-TAM)/2) SAY MENSAGEM
MENSAGEM=" OK "
SET COLOR TO &COR26
@ 12,(80-TAM2)/2 PROMPT OPCAO1
@ 12,(80-TAM2)/2+3+LEN(OPCAO2) PROMPT OPCAO2
MENU TO X
SETCOLOR(VAR_COR)
REST SCREEN
SET CURSOR ON
RETURN(X)

******************************************
FUNCTION AVISO4(MENSAGEM,CAMP1,CAMP2)
*****************************
SET CURSOR OFF
VAR_COR=SETCOLOR()
SAVE SCREEN
SET COLOR TO &COR24
TAM=LEN(MENSAGEM)
DEMORA=TAM/10
COL1=((80-TAM)/2)-2
COL2=((80-TAM)/2)+TAM+2
COLUNA1=40
FOR COLUNA2=40 TO COL2
    COLUNA1--
    @ 08,COLUNA1+1 CLEAR TO 14,COLUNA2-1
    @ 08,COLUNA1 TO 14,COLUNA2
    MILLISEC(   (COL2-COLUNA2) * 0,4  )
NEXT COLUNA2
TAMC=LEN(CAMP1)+LEN(CAMP2)
SET COLOR TO &COR23
@ 09,((80-TAMC)/2) SAY CAMP1+"-"+CAMP2
SET COLOR TO &COR24
@ 11,((80-TAM)/2) SAY MENSAGEM
MENSAGEM=" OK "
SET COLOR TO &COR25
@ 13,38 SAY MENSAGEM
INKEY(0)
SETCOLOR(VAR_COR)
REST SCREEN
SET CURSOR ON
RETURN(.T.)



******************************************
FUNCTION TELEVISAO(TIPO)  && PARAMETRO TIPO E' N§ DE LINHAS DO VIDEO
******************************
FOR XX=0 TO 14
    @ XX,00 CLEAR TO XX,80
    @ (TIPO-XX),00 CLEAR TO (TIPO-XX),80
    MILLISEC(5)
NEXT XX
MILLISEC(10)
@ (TIPO/2),00 TO (TIPO/2),80 
MILLISEC(5)
FOR XX=0 TO 40
    @ (TIPO/2),XX SAY SPACE(1)
    @ (TIPO/2),80-XX SAY SPACE(1)
    MILLISEC(10)
NEXT XX
RETURN(.T.)

******************************************
FUNCTION ZOOM(LIN1,COL1,LIN2,COL2)
*****************************
SET CURSOR OFF
COLUNA1=COL1+((COL2-COL1)/2)
FOR COLUNA2=COLUNA1 TO COL2
    COLUNA1--
    @ LIN1,COLUNA1 CLEAR TO LIN2,COLUNA2
    @ LIN1,COLUNA1 TO LIN2,COLUNA2
    MILLISEC((COL2-COLUNA2)*3)
NEXT COLUNA2
SET CURSOR ON
RETURN(.T.)
********************
FUNCTION ClearToMid(nDelay, nTop, nLeft, nBottom, nRight)
********************
DO WHILE nLeft <= nRight
CLEARWIN(nTop, nLeft, nBottom, nLeft)
CLEARWIN(nTop, nRight, nBottom, nRight)
MILLISEC(nDelay)
nLeft  = nLeft  +1
nRight = nRight -1
ENDDO
RETURN("")
******************************************************************************
**                            FUNCOES COM STRING                            **
******************************************************************************
*****************************
FUNCTION CENTRA(LIN,MENSAGEM)
*****************************
@ LIN,02 CLEAR TO LIN,78
CENTRO=(80 - LEN(MENSAGEM) ) / 2
@ LIN,CENTRO SAY MENSAGEM
RETURN(.T.)
******************************
FUNCTION CORRE(LIN,MENS,TEMPO)
******************************
SET CURSOR OFF
L=LEN(MENS)
DO WHILE !LASTKEY()=27
FOR X=0 TO L
    INKEY(TEMPO)
    @ LIN,0 SAY SUBSTR(MENS,L-X,X+1)
    IF LASTKEY()=27
       RETURN(.T.)
    ENDIF
NEXT X
FOR X=1 TO 80-L
    @ LIN,X SAY MENS
    @ LIN,X-1 SAY " "
    INKEY(TEMPO)
    IF LASTKEY()=27
       RETURN(.T.)
    ENDIF
NEXT X
Y=1
FOR X=L-1 TO 0 STEP -1
    @ LIN,(80-L+Y) SAY SUBSTR(MENS,1,X)
    @ LIN,(79-L+Y) SAY " "
    Y=Y+1
    INKEY(TEMPO)
    IF LASTKEY()=27
       RETURN(.T.)
    ENDIF
NEXT X
INKEY(TEMPO*5)
ENDDO
******************************
FUNCTION CORRE_ATE_MEIO(LIN,MENS,TEMPO)
******************************
SET CURSOR OFF
L=LEN(MENS)
FOR X=0 TO L
 MILLISEC(TEMPO)
 @ LIN,0 SAY SUBSTR(MENS,L-X,X+1)
NEXT X
FOR X=1 TO ((80-L)/2)
 @ LIN,X SAY MENS
 @ LIN,X-1 SAY " "
 MILLISEC(TEMPO)
NEXT X
RETURN(.T.)
******************************
FUNCTION LETRA_ATE_MEIO(LIN,MENS,TEMPO)
******************************
SET CURSOR OFF
L=LEN(MENS)
POSICAO=(80-LEN(MENS))/2
FOR XX=L TO 1 STEP -1
 FOR COL=0 TO POSICAO+XX-1
     @ LIN,COL SAY SUBSTR(MENS,XX,1)
     @ LIN,COL-1 SAY " "
     MILLISEC(TEMPO)
 NEXT COL
NEXT XX
RETURN(.T.)
******************************************************
FUNCTION EXTENSO(VALOR)
******************************************************
IF EMPTY(VALOR)
RETURN("Z E R O   R E A I S")
ENDIF
VALOR=STRZERO(VALOR)
IF LEN(VALOR)>12
VALOR=SUBSTR(VALOR,LEN(VALOR)-11,12)
ENDIF
IF LEN(VALOR)<12
VALOR=REPL("0",LEN(VALOR)-11)
ENDIF


STORE .F. TO COMPLETO,SO_MILHAO,MILHAO_E_MIL,MILHAO_E_UNIDADE,MIL_E_UNIDADE,SO_MIL,SO_UNIDADE,SO_CENTAVOS,UM_MILHAO,UM_REAL
TEM_MILHAO := TEM_MIL := TEM_UNIDADE := TEM_CENTAVOS := .F.
XX := V_MILHAO := V_MIL := V_UNIDADE := V_CENTAVOS := SPACE(1)

VET_CENTENA={"CENTO","DUZENTOS","TREZENTOS","QUATROCENTOS","QUINHENTOS","SEISCENTOS","SETECENTOS","OITOCENTOS","NOVECENTOS"}
VET_DEZENA ={"DEZ","VINTE","TRINTA","QUARENTA","CINQUENTA","SESSENTA","SETENTA","OITENTA","NOVENTA"}
VET_UNIDADE={"UM","DOIS","TRES","QUATRO","CINCO","SEIS","SETE","OITO","NOVE"}
VET_DEZ    ={"DEZ","ONZE","DOZE","TREZE","QUATORZE","QUINZE","DEZESSEIS","DEZESSETE","DEZOITO","DEZENOVE"}

IF VAL(SUBSTR(VALOR,1,3)) <> 0
TEM_MILHAO=.T.
ENDIF
IF VAL(SUBSTR(VALOR,4,3)) <> 0
TEM_MIL=.T.
ENDIF
IF VAL(SUBSTR(VALOR,7,3)) <> 0
TEM_UNIDADE=.T.
ENDIF
IF VAL(SUBSTR(VALOR,11,2)) <> 0
TEM_CENTAVOS=.T.
ENDIF
IF VAL(SUBSTR(VALOR,1,3)) = 1
UM_MILHAO=.T.
ENDIF
IF VAL(SUBSTR(VALOR,7,3)) = 1
UM_REAL=.T.
ENDIF

*****************************************************************************
X1=1

IF SUBSTR(VALOR,X1,3)="100"
V_MILHAO=V_MILHAO+" CEM "
ELSE
IF VAL(SUBSTR(VALOR,X1,1)) <> 0
   V_MILHAO=V_MILHAO+VET_CENTENA[VAL(SUBSTR(VALOR,X1,1))]+" E "
ENDIF
ENDIF
IF VAL(SUBSTR(VALOR,X1+1,1))=1
V_MILHAO=V_MILHAO+VET_DEZ[VAL(SUBSTR(VALOR,X1+2,1))+1]

ELSE
IF VAL(SUBSTR(VALOR,X1+1,1))<>0
   V_MILHAO=V_MILHAO+VET_DEZENA[VAL(SUBSTR(VALOR,X1+1,1))] + " E "
ENDIF
IF VAL(SUBSTR(VALOR,X1+2,1))<>0
   V_MILHAO=V_MILHAO+VET_UNIDADE[VAL(SUBSTR(VALOR,X1+2,1))]
ENDIF
ENDIF
****************************************************************
X1=4

IF SUBSTR(VALOR,X1,3)="100"
V_MIL=V_MIL+" CEM "
ELSE
IF VAL(SUBSTR(VALOR,X1,1)) <> 0
   V_MIL=V_MIL+VET_CENTENA[VAL(SUBSTR(VALOR,X1,1))]+" E "
ENDIF
ENDIF
IF VAL(SUBSTR(VALOR,X1+1,1))=1
V_MIL=V_MIL+VET_DEZ[VAL(SUBSTR(VALOR,X1+2,1))+1]

ELSE
IF VAL(SUBSTR(VALOR,X1+1,1))<>0
   V_MIL=V_MIL+VET_DEZENA[VAL(SUBSTR(VALOR,X1+1,1))] + " E "
ENDIF
IF VAL(SUBSTR(VALOR,X1+2,1))<>0
   V_MIL=V_MIL+VET_UNIDADE[VAL(SUBSTR(VALOR,X1+2,1))]
ENDIF
ENDIF
****************************************************************
X1=7

IF SUBSTR(VALOR,X1,3)="100"
V_UNIDADE=V_UNIDADE+" CEM "
ELSE
IF VAL(SUBSTR(VALOR,X1,1)) <> 0
   V_UNIDADE=V_UNIDADE+VET_CENTENA[VAL(SUBSTR(VALOR,X1,1))]+" E "
ENDIF
ENDIF
IF VAL(SUBSTR(VALOR,X1+1,1))=1
V_UNIDADE=V_UNIDADE+VET_DEZ[VAL(SUBSTR(VALOR,X1+2,1))+1]

ELSE
IF VAL(SUBSTR(VALOR,X1+1,1))<>0
   V_UNIDADE=V_UNIDADE+VET_DEZENA[VAL(SUBSTR(VALOR,X1+1,1))] + " E "
ENDIF
IF VAL(SUBSTR(VALOR,X1+2,1))<>0
   V_UNIDADE=V_UNIDADE+VET_UNIDADE[VAL(SUBSTR(VALOR,X1+2,1))]
ENDIF
ENDIF
****************************************************************
X1=11
IF VAL(SUBSTR(VALOR,X1,1))=1
V_CENTAVOS=V_CENTAVOS+VET_DEZ[VAL(SUBSTR(VALOR,X1+1,1))+1]
ELSE
IF VAL(SUBSTR(VALOR,X1,1)) <> 0
   V_CENTAVOS=V_CENTAVOS+VET_DEZENA[VAL(SUBSTR(VALOR,X1,1))] +" E "
ENDIF
IF VAL(SUBSTR(VALOR,X1+1,1)) <> 0
   V_CENTAVOS=V_CENTAVOS+VET_UNIDADE[VAL(SUBSTR(VALOR,X1+1,1))]
ENDIF
ENDIF

****************************************************************


DO WHILE .T.

IF TEM_MILHAO .AND. TEM_MIL .AND. TEM_UNIDADE
   COMPLETO=.T.
   EXIT
ENDIF
IF TEM_MILHAO .AND. TEM_MIL .AND. .NOT. TEM_UNIDADE
   MILHAO_E_MIL=.T.
   EXIT
ENDIF
IF TEM_MILHAO .AND. TEM_UNIDADE .AND. .NOT. TEM_MIL
   MILHAO_E_UNIDADE=.T.
   EXIT
ENDIF

IF TEM_MILHAO .AND. .NOT. TEM_MIL .AND. .NOT. TEM_UNIDADE
   SO_MILHAO=.T.
   EXIT
ENDIF

IF TEM_MIL .AND. TEM_UNIDADE .AND. .NOT. TEM_MILHAO
   MIL_E_UNIDADE=.T.
   EXIT
ENDIF
IF TEM_MIL .AND. .NOT. TEM_UNIDADE .AND. .NOT. TEM_MILHAO
   SO_MIL=.T.
   EXIT
ENDIF
IF TEM_UNIDADE .AND. .NOT. TEM_MIL .AND. .NOT. TEM_MILHAO
   SO_UNIDADE=.T.
   EXIT
ENDIF

IF TEM_CENTAVOS .AND. .NOT. TEM_UNIDADE .AND. .NOT. TEM_MIL .AND. .NOT. TEM_MILHAO
   SO_CENTAVOS=.T.
   EXIT
ENDIF


EXIT
ENDDO


DO CASE
CASE COMPLETO
  IF UM_MILHAO
     XX=XX+V_MILHAO+" MILHAO E "
  ELSE
     XX=XX+V_MILHAO+" MILHOES E "
  ENDIF
  XX=XX+V_MIL+" MIL E "
  XX=XX+V_UNIDADE+" REAIS"
CASE MILHAO_E_MIL
  IF UM_MILHAO
     XX=XX+V_MILHAO+" MILHAO E "
  ELSE
     XX=XX+V_MILHAO+" MILHOES E "
  ENDIF
  XX=XX+V_MIL+" MIL REAIS"
CASE MILHAO_E_UNIDADE
  IF UM_MILHAO
     XX=XX+V_MILHAO+" MILHAO E "
  ELSE
     XX=XX+V_MILHAO+" MILHOES E "
  ENDIF
  XX=XX+V_UNIDADE+" REAIS"
CASE MIL_E_UNIDADE
  XX=XX+V_MIL+" MIL E "
  XX=XX+V_UNIDADE+" REAIS "
CASE SO_MILHAO
  IF UM_MILHAO
     XX=XX+V_MILHAO+" MILHAO DE REAIS "
  ELSE
     XX=XX+V_MILHAO+" MILHOES DE REAIS "
  ENDIF
CASE SO_MIL
  XX=XX+V_MIL+" MIL REAIS "
CASE SO_UNIDADE
  IF UM_REAL
     XX=XX+V_UNIDADE+" REAL "
  ELSE
     XX=XX+V_UNIDADE+" REAIS"
  ENDIF
ENDCASE

IF TEM_CENTAVOS
XX=XX+" E "+V_CENTAVOS+" CENTAVOS."
ELSE
XX=XX+"."
ENDIF

IF SO_CENTAVOS
XX=V_CENTAVOS+" CENTAVOS DE REAL."
ENDIF

RETURN(ALLTRIM(XX))

******************************
FUNCTION ESCREVE(LIN,COL,MENS)
******************************
FOR X=1 TO LEN(MENS)
 @ LIN,COL+X-1 SAY SUBSTR(MENS,X,1)
 MILLISEC(20)
NEXT
RETURN(.T.)
******************************************
FUNCTION CAIR_LETRAS(L1,C1,MENSAGEM,TEMPO)
******************************************
set cursor off
XX=00
YY=00
FOR XX=00 TO L1-1+LEN(MENSAGEM)
 FOR YY=1 TO LEN(MENSAGEM)
     IF !XX-YY>L1
        @ XX-YY,C1-1+YY SAY SUBSTR(MENSAGEM,YY,1)
        @ XX-YY-1,C1-1+YY SAY " "
     ENDIF
     MILLISEC(TEMPO)
 NEXT YY
NEXT XX
@ L1-1,C1-1+LEN(MENSAGEM) SAY " "
@ L1,C1-1+LEN(MENSAGEM) SAY SUBSTR(MENSAGEM,LEN(MENSAGEM),1)
RETURN(.T.)
set cursor on
******************************************
FUNCTION CAIR_STRING(L1,C1,MENSAGEM,TEMPO)
******************************************
FOR XX=00 TO L1
 @ XX,C1 SAY MENSAGEM
 @ XX-1,C1 SAY SPACE(LEN(MENSAGEM))
 MILLISEC(TEMPO)
NEXT XX
RETURN(.T.)
*****************************************************************************
*                     FUNCOES DE OPERACOES/CALCULOS                         *
*****************************************************************************


******************************
FUNCTION PROGRESS(L,C,TOT,EST)
******************************
OLDCOR=SETCOLOR()
SET CURSOR OFF
PRC=EST*50/TOT
PORC=ROUND(PRC,0)
SET COLOR TO W+
@ L-1,C-2 CLEAR TO L+1,C+52
@ L-1,C-2 TO L+1,C+52
SET COLOR TO W+
@ L,C SAY REPL(CHR(219),51)
SET COLOR TO B

IF PORC>50
PORC=50
ENDIF

IF PORC=0
PORC=-1
ENDIF

FOR X=0 TO PORC
 @ L,C+X SAY CHR(219)
 @ L-1,C+25 SAY " "+ALLTRIM(STR(X*2))+" %"
 MILLISEC(80)
NEXT X

@ L-1,C+23 SAY " "+ALLTRIM(STR(PRC*2))+" % "

SETCOLOR(OLDCOR)
SET CURSOR ON

RETURN(.T.)


*****************************************************************************
*                           FUNCOES COM DATAS                               *
*****************************************************************************

***********************
FUNCTION DATA_EXT(DATA)
***********************************************
** Sempre Retorna uma String de tamanho 22.  **
***********************************************
IF EMPTY(DATA)
RETURN(SPACE(22))
ENDIF
DECLARE VETOR_MES[12]

VETOR_MES[01]=" Janeiro "
VETOR_MES[02]="Fevereiro"
VETOR_MES[03]="  Marco  "
VETOR_MES[04]="  Abril  "
VETOR_MES[05]="  Maio   "
VETOR_MES[06]="  Junho  "
VETOR_MES[07]="  Julho  "
VETOR_MES[08]=" Agosto  "
VETOR_MES[09]="Setembro "
VETOR_MES[10]=" Outubro "
VETOR_MES[11]="Novembro "
VETOR_MES[12]="Dezembro "

DATA=DTOC(DATA)

XX=SUBSTR(DATA,1,2)+" de "+VETOR_MES[VAL(SUBSTR(DATA,4,2))]+" de "+SUBSTR(DATA,7,2)+"."

RETURN(XX)

*****************************************************************************
*                           FUNCOES COM CORES                               *
*****************************************************************************

******************************************
FUNCTION CORES(NUM)
*******************
DECLARE vet_cor[20]
vet_cor[1]= "N/W,W/N,N,N/N,W/W"      && PRETO FUNDO BRANCO/BRANCO FUNDO PRETO
vet_cor[2]= "N/W,W/N,N,N"
vet_cor[5]= "BG/N,N/BG,N,N/N,N/W"    && CIANO /PRETO
vet_cor[4]= "W+/N,W+/B,B,N/N,W+/BG"  && BRANCO INT.FUNDO PRETO / BRANCO INT. FUNDO AZUL BORDA AZUL
vet_cor[3]= "w+/r,w+/b"              && branco intenso fundo vermelho/branco int. fundo azul
vet_cor[6]= "w+/B,N/W"               && branco intenso fundo AZUL/PRETO FUNDO BRANCO
vet_cor[7]= "W+/GR,N/W"              && branco intenso fundo MARROM/PRETO FUNDO BRANCO
vet_cor[8]= "BG+/N,N/BG,N,N/N,W/N"   &&
vet_cor[9]= "GN/W,W/N,N,N/N,W/W"     &&
vet_cor[10]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[11]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[12]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[13]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[14]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[15]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[16]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[17]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[18]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[19]= "N/W,W/N,N,N/N,W/W"     &&
vet_cor[20]= "N/W,W/N,N,N/N,W/W"     &&
SETCOLOR(VET_COR[NUM])
RETURN .T.


