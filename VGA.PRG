FUNCTION BACKUP_OFFLINE_E_MEM()

      CLOSE ALL
      USE &SHAR90 INDEX &SHAR91
      GOTO TOP
      FIND &VQNUM
      qminen=val(substr(qhoraen,4,2))
      qminsa=val(substr(time(),4,2))
      qhoren=val(substr(qhoraen,1,2))*60
      qhorsa=val(substr(time(),1,2))*60
      qsegen=val(substr(qhoraen,7,2))/60
      qsegsa=val(substr(time(),7,2))/60
      qvai=qhorsa+qminsa+qsegsa-qhoren-qminen-qsegen
      if qvai<1
         qvai=qvai/60
      endif
      IF RLOCK() 
         REPLACE Qdatasa WITH date()
         REPLACE Qhorasa WITH time()
         REPLACE Qcoment WITH "["+str(qvai)+"min >"+space(24-len(str(qvai)))
         COMMIT
      ELSE
         AVISO("ERROR LOCK")
      ENDIF
      CLOSE ALL
      CLEAR
      	   SET DATE FORMAT TO "dd/mm/yyyy"
      MEZANO=DTOC(DATE())
      MEZANO=SUBSTR(MEZANO,4,2)+SUBSTR(MEZANO,7,4)
      
      COP_TAB_JOSEPH=PASTASERV+"SEGUR\JO"+MEZANO+".DBF"
      COP_TIT_JOSEPH=PASTASERV+"SEGUR\JI"+MEZANO+".DBF"
   *   COP_TAB_TAPAJO=PASTASERV+"SEGUR\TO"+MEZANO+".DBF"
   *   COP_TIT_TAPAJO=PASTASERV+"SEGUR\TI"+MEZANO+".DBF"

      COP_CADASTRO  =PASTASERV+"SEGUR\CA"+MEZANO+".DBF"
      COP_BRS       =PASTASERV+"SEGUR\BR"+MEZANO+".DBF"

      IF OFFLINE=0                             
         COPY FILE  &shar21 TO &COP_TAB_JOSEPH           
         COPY FILE  &shar31 TO &COP_TIT_JOSEPH           
         COPY FILE  &shar2  TO &COP_CADASTRO       
         COPY FILE  &shar14 TO &COP_BRS

         COPY FILE  &shar14 TO OFFLINE\BRS.DBF       
         COPY FILE  &shar8  TO OFFLINE\HISTOR.DBF   
         COPY FILE  &shar18 TO OFFLINE\HISTDECL.DBF   
         COPY FILE  &shar2  TO OFFLINE\PROCONTA.DBF  
         COPY FILE  &shar90 TO OFFLINE\QUALUSER.DBF   
         COPY FILE  &shar21 TO OFFLINE\TABELA.DBF    
         COPY FILE  &shar31 TO OFFLINE\TITULOS.DBF 
         COPY FILE  &shar41 TO OFFLINE\TABELA.SRC       
         COPY FILE  &shar51 TO OFFLINE\TITULOS.NTX

      ENDIF

      SAVE ALL LIKE md* TO VARSCONF.MEM

*********************
FUNCTION TELAPRI()
*********************
SET COLOR TO &COR11
CLEAR
IF OFFLINE=1
   SET COLOR TO &COR2
   @ 02,02 SAY "        OPERANDO EM OFF-LINE       "
   SET COLOR TO &COR11
ELSE
   @ 02,02 SAY "   Assessoria Contabil Rimax Ltda  "
ENDIF
@ 02,62 say DTOC(DATE())+" "+substr(time(),1,5)

@ 00,00 TO 24,79 DOUBLE                
@ 01,01 TO 03,78    
SET COLOR TO &COR21
@ 17,02 SAY "‹‹‹‹"
@ 18,02 SAY "€  €"
@ 19,02 SAY "€‹ﬂ "
@ 20,02 SAY "€ € "
@ 21,02 SAY "ﬂ  ﬂ"
@ 17,07 SAY "‹"
@ 18,07 SAY "‹"
@ 19,07 SAY "€"
@ 20,07 SAY "€"
@ 21,07 SAY "ﬂ"
@ 17,09 SAY "‹   ‹"
@ 18,09 SAY "€€ €€"
@ 19,09 SAY "€ € €"
@ 20,09 SAY "€   €"
@ 21,09 SAY "ﬂ   ﬂ"   
@ 17,15 SAY "‹‹‹"
@ 18,15 SAY "€ €"
@ 19,15 SAY "€€€"
@ 20,15 SAY "€ €"
@ 21,15 SAY "ﬂ ﬂ"   
@ 17,19 SAY "‹   ‹"
@ 18,19 SAY " € € "
@ 19,19 SAY "  ˛  "
@ 20,19 SAY " € € "
@ 21,19 SAY "ﬂ   ﬂ"   
@ 22,02 SAY "Assessoria Contabil"

IF mdt=1
   @ 17,26 SAY "RGB Marrom - <F7> muda"
ELSE
   @ 17,26 SAY "RGB Colorido  - <F7> muda"
ENDIF

IF mdc=1
   @ 18,26 SAY "Tela DOS - <F8> muda"
ELSE
   @ 18,26 SAY "Tela WIN - <F8> muda"
ENDIF
@ 19,26 SAY "Acessando em  "+PASTASERV

VETORTEMP={MDIMP1,MDIMP2,MDIMP3,MDIMP4,MDIMP5,MDIMP6,mdimp7}
@ 20,26 SAY "Imprimindo em "
IF MDIMP99=1
   @ 20,40 SAY MDIMP1
 ELSEIF MDIMP99=2
   @ 20,40 SAY MDIMP2
 ELSEIF MDIMP99=3
   @ 20,40 SAY MDIMP3
 ELSEIF MDIMP99=4
   @ 20,40 SAY MDIMP4
 ELSEIF MDIMP99=5
   @ 20,40 SAY MDIMP5
 ELSEIF MDIMP99=6
   @ 20,40 SAY MDIMP6
 ELSEIF MDIMP99=7
   @ 20,40 SAY MDIMP7
ENDIF
@ 21,26 SAY "<F12> Calculadora"
RETURN(.T.)

*****************
FUNCTION PALHET(MDT)
*****************
CLEAR
IF MDT=0
USE &SHAR4 SHARED
ELSE
USE &SHAR5 SHARED
ENDIF
DECLARE VET_CORES_PAL[15,4]
GOTO TOP
FOR WWW=1 TO 15
VET_CORES_PAL[WWW,1]=COR_N
VET_CORES_PAL[WWW,2]=CORR
VET_CORES_PAL[WWW,3]=CORG
VET_CORES_PAL[WWW,4]=CORB
VGAPALETTE(COR_N,CORR,CORG,CORB)
CORA=STR(COR_N)+"/L"
SETCOLOR(CORA)
@ 00,01+(WWW*5)-5 SAY alltrim(str(WWW)) +repl(chr(219),4-len(alltrim(str(www))))
*    @ 00,01+(WWW*5)-5 SAY CHR(219)+CHR(219)+CHR(219)+CHR(219)
@ 01,01+(WWW*5)-5 SAY CHR(219)+CHR(219)+CHR(219)+CHR(219)
@ 02,01+(WWW*5)-5 SAY CHR(219)+CHR(219)+CHR(219)+CHR(219)
SKIP +1
NEXT WWW    
INKEY(0)
RETURN(.T.)

**********************
FUNCTION RGBPALETA()
**********************
AS=0
PARA AS,MDT

DO WHILE .T.

CORPADR={"N","B","G","BG","R","RB","GR","W","N+","B+","G+","BG+","R+","RB+","GR+","W+"}

SET COLOR TO
CLEAR 
IF MDT=0
USE &SHAR4 SHARED
ELSE
USE &SHAR5 SHARED
ENDIF
DECLARE VET_CORES_PAL[15,4]
GOTO TOP
FOR WWW=1 TO 15
VET_CORES_PAL[WWW,1]=COR_N
VET_CORES_PAL[WWW,2]=CORR
VET_CORES_PAL[WWW,3]=CORG
VET_CORES_PAL[WWW,4]=CORB
VGAPALETTE(COR_N,CORR,CORG,CORB)
CORA=STR(COR_N)+"/L"
SETCOLOR(CORA)
if as=0
@ 00,01+(WWW*5)-4 SAY CORPADR[WWW]
@ 01,01+(WWW*5)-4 SAY ALLTRIM(STR(WWW))
@ 02,01+(WWW*5)-5 SAY CHR(219)+CHR(219)+CHR(219)+CHR(219)
@ 03,01+(WWW*5)-5 SAY CHR(219)+CHR(219)+CHR(219)+CHR(219)
endif
SKIP +1

NEXT WWW    
IF AS=0
SET COLOR TO "1/2,,3/4"
FOR WWW=1 TO 8
@ 04+WWW,01 say VET_CORES_PAL[WWW,1]
@ 04+WWW,08 GET VET_CORES_PAL[WWW,2]
@ 04+WWW,14 GET VET_CORES_PAL[WWW,3]
@ 04+WWW,20 GET VET_CORES_PAL[WWW,4]
NEXT WWW
FOR  WWW=9 TO 15
@ 06+WWW-10,41 say VET_CORES_PAL[WWW,1]
@ 06+WWW-10,48 GET VET_CORES_PAL[WWW,2]
@ 06+WWW-10,54 GET VET_CORES_PAL[WWW,3]
@ 06+WWW-10,60 GET VET_CORES_PAL[WWW,4]
NEXT WWW

READ
IF MDT=0
USE &SHAR4 SHARED
ELSE
USE &SHAR5 SHARED
ENDIF
GOTO TOP
FOR WWW=1 TO 15
IF FLOCK()
   REPLACE COR_N WITH VET_CORES_PAL[WWW,1]    
   REPLACE CORR  WITH VET_CORES_PAL[WWW,2]    
   REPLACE CORG  WITH VET_CORES_PAL[WWW,3]
   REPLACE CORB  WITH VET_CORES_PAL[WWW,4]
   SKIP +1
ELSE
   AVISO("FLOCK ATIVADO - NAO FOI POSSIVEL GRAVAR")
ENDIF
NEXT WWW
USE
SET COLOR TO

?? "Teclar <ESPACO> reiniciar"
INKEY(0)
if lastkey()=32
LOOP
ENDIF
ENDIF
RELER_COR(MDC)
EXIT
ENDDO
*********************
function mododetela()
*********************
if mdt=1
mdt=0
else
mdt=1
endif
RGBPALETA(1,mdt)
KEYB CHR(27)+CHR(27)+CHR(27)
reler_cor(mdc)
return(.t.)
*********************
function mododecor()
*********************
IF mdc=1
   mdc=0
ELSE
   mdc=1
ENDIF
RGBPALETA(1,MDT)
RELER_COR(mdc)
KEYB CHR(27)+CHR(27)+CHR(27)
RETURN(.t.)
**********************
FUNCTION INICIA_COR()
**********************
cor1=alltrim(cor_masc)
skip +1
cor2=alltrim(cor_masc)
skip +1
Cor3=alltrim(cor_masc)
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
RETURN(.T.)
