******************************************
*****FUNCOES U.D.F. (User Data File)    
*****                Funções de usuario para Dbedit/Achoiche
***** 
***** Outras funcoes com arquivos
*****
***** Reprogramado para modo multiusuario REDE
*****
************************************************
** FUNCTION F_DBE(nMODO,COL)
** FUNCTION UDF_EDIT(MODO,LIN,COL)
** FUNCTION ARQ
** FUNCTION UDF(MODO,ELE,POS)
** function UDF2(MM,CAMPO)
** function UDFHISTO(MM,CAMPO)
** FUNCTION UDFHISTO2(MM,CAMPO)     -  TELAHISTO.PRG
** FUNCTION UDFDECL(MM,CAMPO)
** function UDFCADDECL(MM,CAMPO)
** FUNCTION VAZIO
** FUNCTION UDFACHO(MODO,ELE,POS)
** FUNCTION FUNCA(MODO,ELE,POS)
*******************************************

FUNCTION F_DBE(nMODO,COL)
   IF LASTKEY()=32
     IF TROCA=0
            @ 05,11 SAY CHR(25)
            @ 05,19 SAY " "
            @ 05,32 SAY " "
            BR_DB3={"NUM"+CHR(25),"VENC. ","VALOR","INSTR_3","INSTR_2"}
            INDEX ON R_NUMEMP TO &SHAR15
            TROCA=1
     KEYB CHR(65)
     RETURN 2
     ELSEIF TROCA=1
            @ 05,19 SAY CHR(25)
            @ 05,11 SAY " "
            @ 05,32 SAY " "
            BR_DB3={"NUM","VENC. ","VALOR"+CHR(25),"INSTR_3","INSTR_2"}
            INDEX ON R_VALOR TO &SHAR15
            TROCA=2
            KEYB CHR(65)
     RETURN 2
     ELSEIF TROCA=2
            @ 05,32 SAY CHR(25)
            @ 05,19 SAY " "
            @ 05,11 SAY " "
            BR_DB3={"NUM","VENC."+CHR(25),"VALOR","INSTR_3","INSTR_2"}
            INDEX ON R_VENC TO &SHAR15 DESCENDING
            TROCA=0
            KEYB CHR(65)
     RETURN 2
     ENDIF

   ENDIF


     
IF nMODO=4
   
   IF LASTKEY()=7
        IF RLOCK()
         DELETE
      ELSE
         AVISO("OUTRO USUARIO ATIVO NESTE B.D.")
      ENDIF
      RETURN(2)
   ENDIF
endif
if lastkey()=13 .or. lastkey()=27
   return(0)
ENDIF


*************************************
FUNCTION UDF_EDIT(MODO,LIN,COL)
*******************************
@ 24,45 SAY STR(LIN)+SPACE(2)+STR(COL)+SPACE(2)+STR(MODO)
RETURN(VAL(STR(INKEY())))
*******************************************
FUNCTION ARQ
************
SAVE SCREEN
@ 10,10 CLEAR TO 20,30
@ 10,10 TO 20,30
IF FILE("*.PRG")
DECLARE ARQUIVO[ADIR("*.PRG")]
ADIR("*.PRG",ARQUIVO)
ELSE
DECLARE ARQUIVO[ADIR("*.*")]
ADIR("*.*",ARQUIVO)
ENDIF

OP=ACHOICE(11,11,19,29,ARQUIVO,"FUNCA2")
IF LASTKEY()=27 .OR. LASTKEY()=4 .OR. LASTKEY()=19
OP=1
ENDIF
A=ARQUIVO[OP]+SPACE(20-LEN(ARQUIVO[OP]))
REST SCREEN
RETURN (.T.)

******************************************
FUNCTION UDF(MODO,ELE,POS)
****************************
IF PROG=1
CENTRA(23,xCLI[ELE])
ELSEIF PROG=2
CENTRA(23,xVEI[ELE])
ELSEIF PROG=3
CENTRA(23,xOPC[ELE])
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
**************
function UDF2(MM,CAMPO)
**************
UTP=0

IF CAMPO=1 .AND. LASTKEY()=19 .AND. UTP=19
   KEYB CHR(23)
   RETURN(1)
ENDIF
IF CAMPO=23 .AND. LASTKEY()=4 .AND. UTP=4
   KEYB CHR(29)
   RETURN(1)
ENDIF
IF CAMPO=1 .OR. CAMPO=23
   UTP=LASTKEY()
 ELSE
   UTP=0
ENDIF

IF LASTKEY()=13
   RETURN 1
ELSEIF LASTKEY()=27 
   RETURN 0
ENDIF
IF lastkey()=4
   RETURN 0
ENDIF
IF lastkey()=19
   RETURN 0
ENDIF

IF LASTKEY()=32 .OR. LASTKEY()=9 .OR. LASTKEY()=271
   RETURN 0
ENDIF


IF MM=0
   RETURN 1
ELSEIF MM=1
   KEYB CHR(30)
   RETURN 1
ELSEIF MM=2
   KEYB CHR(31)
   RETURN 1
ELSEIF MM=3
   RETURN 0
ELSEIF MM=4  .AND. LASTKEY()=13
   RETURN 2
ELSEIF LASTKEY()=27
   RETURN 0
ENDIF

RETURN 1
**************
FUNCTION UDFHISTO2(MM,CAMPO)
**************
IF LASTKEY()=13
   RETURN 1
ELSEIF LASTKEY()=27 
   RETURN 0
ENDIF

IF MM=0
   RETURN 1
ELSEIF MM=3
*   RETURN 0
ELSEIF MM=4  .AND. LASTKEY()=13
   RETURN 2
ENDIF

IF LASTKEY()=84 .OR. LASTKEY()=116  && T - texto visualiza
   save screen
   OLDCOR=SETCOLOR()
   SETCOLOR(COR12)
   vh_texto=h_texto
   vh_texto1=substr(vh_texto,1,18)
   vh_texto2=substr(vh_texto,19,18)
   vh_texto3=substr(vh_texto,37,18)
   vh_texto4=substr(vh_texto,55,18)
   vh_texto5=substr(vh_texto,73,18)
   @ 12,49 clear TO 20,70
   @ 12,49 TO 20,70 DOUBLE
   @ 13,57 SAY "TEXTO"
   @ 14,51 GET VH_TEXTO1
   @ 15,51 GET VH_TEXTO2
   @ 16,51 GET VH_TEXTO3
   @ 17,51 GET VH_TEXTO4
   @ 18,51 GET VH_TEXTO5
   READ
   IF !EMPTY(VH_TEXTO1+VH_TEXTO2+VH_TEXTO3+VH_TEXTO4+VH_TEXTO5)
      VH_TEMTEXTO="*"
     ELSE
      VH_TEMTEXTO=" "
   ENDIF
   IF .NOT. LASTKEY()=27 
       AVISO("Gravar? Tecle <Enter>")
       IF LASTKEY()=13
          IF RLOCK()
             REPLACE H_TEXTO WITH VH_TEXTO1+VH_TEXTO2+VH_TEXTO3+VH_TEXTO4+VH_TEXTO5
             REPLACE H_TEMTEXTO WITH VH_TEMTEXTO
             COMMIT
          ELSE
             AVISO("Registro travado Rlock()")
          ENDIF
       ENDIF
   ENDIF
   RESTORE SCREEN
   SETCOLOR(OLDCOR)
ELSEIF LASTKEY()=65 .OR. LASTKEY()=97   && A -- altera
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=H_NUMEMP
   VH_DATA=h_data
   VH_EVENTO=h_evento
   VH_DESCR=h_descr
   VH_OBS=h_obs
   @ 15,01 CLEAR TO 17,80
   @ 15,01 TO 17,79
   CLEAR GETS
   @ 16,02 GET VH_NUMEMP && PICT "9999"
   @ 16,07 GET VH_DATA
   @ 16,17 GET VH_EVENTO
   @ 16,39 GET VH_DESCR
   @ 16,70 GET VH_OBS
   READ
   AVISO("CONFIRMA? <ENTER>")
   IF LASTKEY()=13
     IF RLOCK()
      REPLACE H_NUMEMP WITH VH_NUMEMP
      REPLACE H_DATA   WITH VH_DATA
      REPLACE H_EVENTO WITH VH_EVENTO
      REPLACE H_DESCR  WITH VH_DESCR
      REPLACE H_OBS    WITH VH_OBS
      *COMMIT
      AVISO("  ALTERADO!  ")
     ELSE
      AVISO(" Registro travado por Rlock()")
     ENDIF
ELSE
   AVISO("  NAO ALTERADO!  ")
   ENDIF
   SETCOLOR(OLDCOR)
   REST SCREE
   RETURN 2
ELSEIF LASTKEY()=7 .OR. LASTKEY()=69 .OR. LASTKEY()=101   && E -- exclui
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=VC_NUMERO
   VH_DATA=h_data
   VH_EVENTO=h_evento
   VH_DESCR=h_descr
   VH_OBS=h_obs
   @ 15,01 CLEAR TO 17,80
   @ 15,01 TO 17,79
   CLEAR GETS
   @ 16,02 GET VH_DATA
   @ 16,13 GET VH_EVENTO
   @ 16,36 GET VH_DESCR
   @ 16,69 GET VH_OBS
   CLEAR GETS
   AVISO4("CONFIRMA EXCLUSAO? <DELETE> OU <DEL>",DTOC(VH_DATA),ALLTRIM(SUBSTR(VH_EVENTO,1,10))+"../"+ALLTRIM(SUBSTR(VH_DESCR,1,10))+"..")
   IF LASTKEY()=7
      XFNUM=RECNO()
      USE &SHAR8 exclusive INDEX &SHAR9
      GOTO XFNUM
      IF FLOCK()
         DELETE 
         PACK
         AVISO("  EXCLUIDO!  ")
        ELSE
         AVISO(" REGISTRO TRAVADO POR RLOCK()")
       ENDIF
   ELSE
     AVISO("  NAO EXCLUIDO!  ")
   ENDIF
   OLDCOR=SETCOLOR()
   SETCOLOR(OLDCOR)
 
   REST SCREE
   RETURN 2

ELSEIF LASTKEY()=78 .OR. LASTKEY()=110  && N -- novo
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=VC_NUMERO
   VH_DATA=CTOD(SPACE(8))
   VH_EVENTO=SPACE(20)
   VH_DESCR=SPACE(30)
   VH_OBS=SPACE(10)
   @ 15,01 CLEAR TO 17,80
   @ 15,01 TO 17,79
   CLEAR GETS
   @ 16,02 GET VH_DATA
   @ 16,13 GET VH_EVENTO
   @ 16,36 GET VH_DESCR
   @ 16,69 GET VH_OBS
   READ
   AVISO("CONFIRMA? <ENTER>")
   IF LASTKEY()=13
      APPE BLAN
      REPLACE H_NUMEMP WITH VH_NUMEMP
      REPLACE H_DATA   WITH VH_DATA
      REPLACE H_EVENTO WITH VH_EVENTO
      REPLACE H_DESCR  WITH VH_DESCR
      REPLACE H_OBS    WITH VH_OBS
      COMMIT
     AVISO("  GRAVADO!  ") 
   ENDIF
   SETCOLOR(OLDCOR)
   REST SCREE
   RETURN 2
ENDIF
XA=LASTKEY()
IF XA=-2 .OR. XA=-3 .OR. XA=-4 .OR. XA=-5 .OR. XA=-6 .OR. XA=-7 .OR. XA=-8
   RETURN 0
ENDIF

RETURN 1

**************
FUNCTION UDFDECL(MM,CAMPO)
**************
XCENT=(45-LEN(VETOR3D[CAMPO]))/2
@ 21,01 CLEAR TO 21,47
@ 21,XCENT GET VETOR3D[CAMPO]
@ 23,02 SAY "<Espaco> ou <Enter> : Marca/Desmarca   <ESC> Ordenar"
@ 21,48 SAY "Emp:" GET C_NUMERO
@ 21,58 GET C_FANTASIA
CLEAR GETS

IF LASTKEY()=13 .OR. LASTKEY()=32
   IF RLOCK()
   DO CASE
      CASE CAMPO=2
           IF C_DECL1="X"
              REPLACE C_DECL1 WITH " "
            ELSE
              REPLACE C_DECL1 WITH "X"
           ENDIF
      CASE CAMPO=3
           IF C_DECL2="X"
              REPLACE C_DECL2 WITH " "
            ELSE
              REPLACE C_DECL2 WITH "X"
           ENDIF
      CASE CAMPO=4
           IF C_DECL3="X"
              REPLACE C_DECL3 WITH " "
            ELSE
              REPLACE C_DECL3 WITH "X"
           ENDIF
      CASE CAMPO=5
           IF C_DECL4="X"
              REPLACE C_DECL4 WITH " "
            ELSE
              REPLACE C_DECL4 WITH "X"
           ENDIF
      CASE CAMPO=6
           IF C_DECL5="X"
              REPLACE C_DECL5 WITH " "
            ELSE
              REPLACE C_DECL5 WITH "X"
           ENDIF
      CASE CAMPO=7
           IF C_DECL6="X"
              REPLACE C_DECL6 WITH " "
            ELSE
              REPLACE C_DECL6 WITH "X"
           ENDIF
      CASE CAMPO=8
           IF C_DECL7="X"
              REPLACE C_DECL7 WITH " "
            ELSE
              REPLACE C_DECL7 WITH "X"
           ENDIF
      CASE CAMPO=9
           IF C_DECL8="X"
              REPLACE C_DECL8 WITH " "
            ELSE
              REPLACE C_DECL8 WITH "X"
           ENDIF
      CASE CAMPO=10
           IF C_DECL9="X"
              REPLACE C_DECL9 WITH " "
            ELSE
              REPLACE C_DECL9 WITH "X"
           ENDIF
      CASE CAMPO=11
           IF C_DECL10="X"
              REPLACE C_DECL10 WITH " "
            ELSE
              REPLACE C_DECL10 WITH "X"
           ENDIF
      CASE CAMPO=12
           IF C_DECL11="X"
              REPLACE C_DECL11 WITH " "
            ELSE
              REPLACE C_DECL11 WITH "X"
           ENDIF
      CASE CAMPO=13
           IF C_DECL12="X"
              REPLACE C_DECL12 WITH " "
            ELSE
              REPLACE C_DECL12 WITH "X"
           ENDIF
      CASE CAMPO=14
           IF C_DECL13="X"
              REPLACE C_DECL13 WITH " "
            ELSE
              REPLACE C_DECL13 WITH "X"
           ENDIF
      CASE CAMPO=15
           IF C_DECL14="X"
              REPLACE C_DECL14 WITH " "
            ELSE
              REPLACE C_DECL14 WITH "X"
           ENDIF
      CASE CAMPO=16
           IF C_DECL15="X"
              REPLACE C_DECL15 WITH " "
            ELSE
              REPLACE C_DECL15 WITH "X"
           ENDIF
      CASE CAMPO=17
           IF C_DECL16="X"
              REPLACE C_DECL16 WITH " "
            ELSE
              REPLACE C_DECL16 WITH "X"
           ENDIF
      CASE CAMPO=18
           IF C_DECL17="X"
              REPLACE C_DECL17 WITH " "
            ELSE
              REPLACE C_DECL17 WITH "X"
           ENDIF
      ENDCASE
     ELSE
     AVISO("REGISTRO SENDO USADO POR OUTRO COMPUTADOR")
   ENDIF

   RETURN 1
ELSEIF LASTKEY()=27 
   RETURN 0
ENDIF

IF MM=0
   RETURN 1
ELSEIF MM=3
*   RETURN 0
ELSEIF MM=4  .AND. LASTKEY()=13
   RETURN 2
ENDIF

RETURN 1

**************
function UDFHISTO(MM,CAMPO)
**************
**@ 20,30 SAY "<A,N,E>,<Enter>,<"+chr(25)+"> Seleciona Janela        "
SET CURSOR ON
UTP=0
IF CAMPO=1 .AND. LASTKEY()=19 .AND. UTP=19
   KEYB CHR(23)
   RETURN(1)
ENDIF
IF CAMPO=23 .AND. LASTKEY()=4 .AND. UTP=4
   KEYB CHR(29)
   RETURN(1)
ENDIF
IF CAMPO=1 .OR. CAMPO=23
   UTP=LASTKEY()
 ELSE
   UTP=0
ENDIF

IF LASTKEY()=13
   RETURN 1
ELSEIF LASTKEY()=27 
   RETURN 0
ENDIF
IF lastkey()=4
   RETURN 0
ENDIF
IF lastkey()=19
   RETURN 0
ENDIF

IF LASTKEY()=32 .OR. LASTKEY()=9 .OR. LASTKEY()=271
   RETURN 0
ENDIF


IF MM=0
   RETURN 1
ELSEIF MM=1
   KEYB CHR(30)
   RETURN 1
ELSEIF MM=2
   KEYB CHR(31)
   RETURN 1
ELSEIF MM=3 .AND. .NOT. ( LASTKEY()=78  .OR. LASTKEY()=110 )
   RETURN 0
ELSEIF MM=4  .AND. LASTKEY()=13
   RETURN 2
ELSEIF LASTKEY()=27
   RETURN 0
ELSEIF LASTKEY()=84 .OR. LASTKEY()=116  && T - texto visualiza
   save screen
   OLDCOR=SETCOLOR()
   SETCOLOR(COR12)
   vh_texto=h_texto
   vh_texto1=substr(vh_texto,1,18)
   vh_texto2=substr(vh_texto,19,18)
   vh_texto3=substr(vh_texto,37,18)
   vh_texto4=substr(vh_texto,55,18)
   vh_texto5=substr(vh_texto,73,18)
   @ 12,49 clear TO 20,70
   @ 12,49 TO 20,70 DOUBLE
   @ 13,57 SAY "TEXTO"
   @ 14,51 GET VH_TEXTO1
   @ 15,51 GET VH_TEXTO2
   @ 16,51 GET VH_TEXTO3
   @ 17,51 GET VH_TEXTO4
   @ 18,51 GET VH_TEXTO5
   READ 
   IF !EMPTY(VH_TEXTO1+VH_TEXTO2+VH_TEXTO3+VH_TEXTO4+VH_TEXTO5)
      VH_TEMTEXTO="*"
     ELSE
      VH_TEMTEXTO=" "
   ENDIF

   IF .NOT. LASTKEY()=27
       AVISO("Gravar? Tecle <Enter>")
       IF LASTKEY()=13
          IF RLOCK()
             REPLACE H_TEXTO WITH VH_TEXTO1+VH_TEXTO2+VH_TEXTO3+VH_TEXTO4+VH_TEXTO5
             REPLACE H_TEMTEXTO WITH VH_TEMTEXTO
             COMMIT
          ELSE
             AVISO("Registro travado Rlock()")
          ENDIF
       ENDIF
   ENDIF
   RESTORE SCREEN
   SETCOLOR(OLDCOR)
ELSEIF LASTKEY()=65 .OR. LASTKEY()=97   && A -- altera
   SET CURSOR ON
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=VC_NUMERO
   VH_DATA=h_data
   VH_EVENTO=h_evento
   VH_DESCR=h_descr
   VH_OBS=h_obs
   @ 15,01 CLEAR TO 17,80
   @ 15,01 TO 17,79
   CLEAR GETS
   @ 16,02 GET VH_DATA
   @ 16,13 GET VH_EVENTO
   @ 16,36 GET VH_DESCR
   @ 16,69 GET VH_OBS
   READ
   AVISO("CONFIRMA? <ENTER>")
   IF LASTKEY()=13
     IF RLOCK()
      REPLACE H_NUMEMP WITH VH_NUMEMP
      REPLACE H_DATA   WITH VH_DATA
      REPLACE H_EVENTO WITH VH_EVENTO
      REPLACE H_DESCR  WITH VH_DESCR
      REPLACE H_OBS    WITH VH_OBS
      *COMMIT
      AVISO("  ALTERADO!  ")
     ELSE
      AVISO(" Registro travado por Rlock()")
     ENDIF
ELSE
   AVISO("  NAO ALTERADO!  ")
   ENDIF
   SETCOLOR(OLDCOR)
   REST SCREE
   RETURN 2
ELSEIF LASTKEY()=7 .OR. LASTKEY()=69 .OR. LASTKEY()=101   && E -- exclui
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=VC_NUMERO
   VH_DATA=h_data
   VH_EVENTO=h_evento
   VH_DESCR=h_descr
   VH_OBS=h_obs
   @ 15,01 CLEAR TO 17,80
   @ 15,01 TO 17,79
   CLEAR GETS
   @ 16,02 GET VH_DATA
   @ 16,13 GET VH_EVENTO
   @ 16,36 GET VH_DESCR
   @ 16,69 GET VH_OBS
   CLEAR GETS
   AVISO4("CONFIRMA EXCLUSAO? <DELETE> OU <DEL>",DTOC(VH_DATA),ALLTRIM(SUBSTR(VH_EVENTO,1,10))+"../"+ALLTRIM(SUBSTR(VH_DESCR,1,10))+"..")
   IF LASTKEY()=7
      XFNUM=RECNO()
      USE &SHAR8 exclusive INDEX &SHAR9
      GOTO XFNUM
      IF FLOCK()
         DELETE 
         PACK
         AVISO("  EXCLUIDO!  ")
        ELSE
         AVISO(" REGISTRO TRAVADO POR RLOCK()")
       ENDIF
   ELSE
     AVISO("  NAO EXCLUIDO!  ")
   ENDIF
   OLDCOR=SETCOLOR()
   SETCOLOR(OLDCOR)
 
   REST SCREE
   RETURN 2

ELSEIF LASTKEY()=78 .OR. LASTKEY()=110  && N -- novo
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=VC_NUMERO
   VH_DATA=CTOD(SPACE(8))
   VH_EVENTO=SPACE(20)
   VH_DESCR=SPACE(30)
   VH_OBS=SPACE(10)
   @ 15,01 CLEAR TO 17,80
   @ 15,01 TO 17,79
   CLEAR GETS
   @ 16,02 GET VH_DATA
   @ 16,13 GET VH_EVENTO
   @ 16,36 GET VH_DESCR
   @ 16,69 GET VH_OBS
   READ
   AVISO("CONFIRMA? <ENTER>")
   IF LASTKEY()=13
      APPE BLAN
      REPLACE H_NUMEMP WITH VH_NUMEMP
      REPLACE H_DATA   WITH VH_DATA
      REPLACE H_EVENTO WITH VH_EVENTO
      REPLACE H_DESCR  WITH VH_DESCR
      REPLACE H_OBS    WITH VH_OBS
      COMMIT
     AVISO("  GRAVADO!  ") 
   ENDIF
   SETCOLOR(OLDCOR)
   REST SCREE
   RETURN 2
ENDIF

RETURN 1
**************
function UDFCADDECL(MM,CAMPO)
**************
@ 20,30 SAY "<Enter>,<"+chr(25)+"> Seleciona Janela                  "
SET CURSOR ON
UTP=0
IF CAMPO=1 .AND. LASTKEY()=19 .AND. UTP=19
   KEYB CHR(23)
   RETURN(1)
ENDIF
IF CAMPO=23 .AND. LASTKEY()=4 .AND. UTP=4
   KEYB CHR(29)
   RETURN(1)
ENDIF
IF CAMPO=1 .OR. CAMPO=23
   UTP=LASTKEY()
 ELSE
   UTP=0
ENDIF

IF LASTKEY()=13
   RETURN 1
ELSEIF LASTKEY()=27 
   RETURN 0
ENDIF
IF lastkey()=4
   RETURN 0
ENDIF
IF lastkey()=19
   RETURN 0
ENDIF

IF LASTKEY()=32 .OR. LASTKEY()=9 .OR. LASTKEY()=271
   RETURN 0
ENDIF

@ 20,30 SAY "<A> Altera <N> Incluir Nova  <E>,<del> Excluir" 
IF MM=0
   RETURN 1
ELSEIF MM=1
   KEYB CHR(30)
   RETURN 1
ELSEIF MM=2
   KEYB CHR(31)
   RETURN 1
ELSEIF MM=3 .AND. .NOT. ( LASTKEY()=78  .OR. LASTKEY()=110 )
   RETURN 0
ELSEIF MM=4  .AND. LASTKEY()=13
   RETURN 2
ELSEIF LASTKEY()=27
   RETURN 0
ELSEIF LASTKEY()=65 .OR. LASTKEY()=97   && A -- altera
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=VC_NUMERO
   VH_DATA=h_data
   VH_DESCR=h_descr
   CLEAR GETS
   @ ROW()-1,31 TO ROW()+1,77
   @ ROW(),32 GET VH_DATA
   @ ROW(),43 GET VH_DESCR
   READ
   AVISO("CONFIRMA? <ENTER>")
   IF LASTKEY()=13
      IF RLOCK()
         REPLACE H_NUMEMP WITH VH_NUMEMP
         REPLACE H_DATA   WITH VH_DATA
         REPLACE H_DESCR  WITH VH_DESCR
      ELSE
         AVISO(" Trancado - outro usuario ")
      endif
      *COMMIT?
   AVISO("  ALTERADO!  ")
ELSE
   AVISO("  NAO ALTERADO!  ")
   ENDIF
   SETCOLOR(OLDCOR)
   REST SCREE
   RETURN 2
ELSEIF lastkey()=7 .or. LASTKEY()=69 .OR. LASTKEY()=101   && E -- exclui
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=VC_NUMERO
   VH_DATA=h_data
   VH_DESCR=h_descr
   @ ROW()-1,31 TO ROW()+1,77
   @ ROW(),32 GET VH_DATA
   @ ROW(),43 GET VH_DESCR
   CLEAR GETS
   AVISO4("CONFIRMA EXCLUSAO? <DELETE> OU <DEL>",DTOC(VH_DATA),SUBSTR(VH_DESCR,1,27))
   IF LASTKEY()=7
      IF FLOCK()
         XTEMP=RECNO()
         USE &SHAR18 EXCLUSIVE INDEX &SHAR19
         GOTO XTEMP
         DELETE
         PACK
         AVISO("  EXCLUIDO!  ")
      ELSE
         AVISO(" Trancado - outro usuario ")
      endif
   ELSE
     AVISO("  NAO EXCLUIDO!  ")
   ENDIF
   OLDCOR=SETCOLOR()
   SETCOLOR(OLDCOR)
 
   REST SCREE
   RETURN 2

ELSEIF LASTKEY()=78 .OR. LASTKEY()=110  && N -- novo
   SAVE SCRE
   OLDCOR=SETCOLOR()
   SETCOLOR(COR16)
   VH_NUMEMP=VC_NUMERO
   VH_DATA=CTOD(SPACE(8))
   VH_DESCR=SPACE(30)
   @ 15,01 CLEAR TO 17,80
   @ 15,01 TO 17,79
   CLEAR GETS
   @ 16,02 GET VH_DATA
   @ 16,36 GET VH_DESCR
   READ
   AVISO("CONFIRMA? <ENTER>")
   IF LASTKEY()=13
      APPE BLAN
      REPLACE H_NUMEMP WITH VH_NUMEMP
      REPLACE H_DATA   WITH VH_DATA
      REPLACE H_DESCR  WITH VH_DESCR
      COMMIT
     AVISO("  GRAVADO!  ") 
   ENDIF
   SETCOLOR(OLDCOR)
   REST SCREE
   RETURN 2
ENDIF

RETURN 1


**************
FUNCTION VAZIO
**************
GOTO TOP
SKIP +1
IF EOF()
RETURN(.T.)
ENDIF
RETURN(.F.)

********************************************
FUNCTION UDFACHO(MODO,ELE,POS)
********************************************
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
**********************************
*** FUNCAO "UDF" (ACHOICE)     *** cadastro
*** PERMITE FAZER O MENU RODAR ***
**********************************
FUNCTION FUNCA(MODO,ELE,POS)

IF OPCAO=1
   CENTRA(23,XPRO[ELE])
ELSEIF OPCAO=2
   CENTRA(23,XBAN[ELE])
ELSEIF OPCAO=3
   CENTRA(23,XIMPR[ELE])
ELSEIF OPCAO=4
   CENTRA(23,XFIM[ELE])
ELSEIF OPCAO=5
   CENTRA(23,XOPC[ELE])
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
FUNCTION FUNTA(MODO,ELE,POS)

@ ROW(),02 SAY AAORNUM[ELE]

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
FUNCTION FUNTA2(MODO,ELE,POS)

@ ROW(),42 SAY HHH_LIST1[ELE]
@ ROW(),62 SAY HHH_LIST3[ELE]

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

**************
FUNCTION UDFDBUSER(MM,CAMPO)
**************
IF LASTKEY()=13
   RETURN 1
ELSEIF LASTKEY()=27 
   RETURN 0
ENDIF

IF MM=0
   RETURN 1
ELSEIF MM=3
*   RETURN 0
ELSEIF MM=4  .AND. LASTKEY()=13
   RETURN 2
ENDIF
IF LASTKEY()=69 .OR. LASTKEY()=101
   NUMREG=RECNO()
   GOTO TOP
   SAVE SCREEN
   @ 08,16 CLEAR TO 23,56
   @ 10,20 TO 20,50
   @ 10,21 SAY "Aguarde, gerando estatistica.."
   INDEX ON QNOME TO &SHAR92
   goto top

   XYS=0
   DO WHILE .NOT. EOF()
      x2nome=QNOME
      qvai=0
      
      do while .T. 
            qminen=val(substr(qhoraen,4,2))
            qminsa=val(substr(qhorasa,4,2))
            qhoren=val(substr(qhoraen,1,2))*60
            qhorsa=val(substr(qhorasa,1,2))*60
            qsegen=val(substr(qhoraen,7,2))/60
            qsegsa=val(substr(qhorasa,7,2))/60
            qvai=qvai+qhorsa+qminsa+qsegsa-qhoren-qminen-qsegen

            IF !qdataen=qdatasa
               qvai=qvai+24
            ENDIF

            skip +1

*            INKEY(0.01)
            IF !x2nome=qnome .OR. EOF()
               EXIT
            ENDIF
      enddo
            xys++
            @ 11+xys,21 say qnome
            @ 11+xys,30 say ALLTRIM(str(qvai))+" minutos"

   ENDDO
   INKEY(0)      
ENDIF


RETURN 1




