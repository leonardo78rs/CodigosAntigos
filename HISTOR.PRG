*  TELADECL()
*  DECLHISTO()
************************
FUNCTION CONSULTADH()
************************
DO WHILE .NOT. LASTKEY()=27
USE &SHAR18 EXCLUSIVE
INDEX ON DTOC(H_DATA)+H_DESCR TO TEMP_CONS
GOTO TOP
IF EOF()
   AVISO("Nao existe historicos de declaracoes digitados")
   exit
endif
@ 04,01 CLEAR TO 23,78 
HHH_LIST1 := {}
HHH_LIST2 := {}
HHH_LIST3 := {}
HHH_CONTA  = 0

@ 04,01 SAY "NUMERO DE REGISTROS:" +STR(LASTREC())

DO WHILE .T.
   HHH_CONTA++ 
   VH_NUMEMP=H_NUMEMP
   VH_DATA=H_DATA
   VH_DESCR=H_DESCR
   SKIP +1

   IF VH_DATA=H_DATA .AND. VH_DESCR=H_DESCR

     ELSE
      AADD(HHH_LIST1,VH_DATA)
      AADD(HHH_LIST2,VH_DESCR)
      AADD(HHH_LIST3,HHH_CONTA)
      HHH_CONTA=0

   ENDIF
   IF EOF()
      EXIT
   ENDIF
   
ENDDO

EA=ACHOICE(05,02,22,37,HHH_LIST2,.T.,"FUNTA2")
IF LASTKEY()=27
   EXIT
ENDIF
@ 20,02 SAY HHH_LIST2[EA]
@ 20,42 SAY HHH_LIST1[EA]
@ 20,62 SAY HHH_LIST3[EA]

@ 22,02 SAY "E-EXCLUI      A-ALTERA "
INKEY(0)

IF LASTKEY()=27
   EXIT
ELSEIF LASTKEY()=69 .OR. LASTKEY()=101  && LETRA Ee
   GOTO TOP
   DO WHILE .NOT. EOF()
      IF VH_DATA=H_DATA .AND. VH_DESCR=H_DESCR
         DELETE
      ENDIF
      SKIP +1
   ENDDO
   PACK
ELSEIF LASTKEY()=65 .OR. LASTKEY()=97  && LETRA Aa
   VH_DESCR := VH2_DESCR := HHH_LIST2[EA]
   VH_DATA  := VH2_DATA  := HHH_LIST1[EA]
   @ 20,02 GET VH2_DESCR
   @ 20,42 GET VH2_DATA
   READ
   GOTO TOP
   DO WHILE .NOT. EOF()
      IF VH_DATA=H_DATA .AND. VH_DESCR=H_DESCR
         REPLACE H_DESCR WITH VH2_DESCR
         REPLACE H_DATA  WITH VH2_DATA
      ENDIF
      SKIP +1
   ENDDO
ENDIF
ENDDO

RETURN(.T.)

*******************
FUNCTION TELADECL()
*******************
V_IND1=1
V_IND0=V_IND1
USE &SHAR2 INDEX &SHAR3
VETOR_D={"C_NUMERO","C_DECL1","C_DECL2","C_DECL3","C_DECL4","C_DECL5","C_DECL6","C_DECL7","C_DECL8","C_DECL9","C_DECL10","C_DECL11","C_DECL12","C_DECL13","C_DECL14","C_DECL15","C_DECL16","C_DECL17"}
*VETOR2D={"N§","DIPJ","DC","DA","IRF","Si","Ina","ITR","PF","GIS","M2","MB","SINT.","D.MUN.","RAIS","SFP","SIR-h","SIR-r"}
VETOR2D={"N§","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8"}

VETOR3D={"Numero da Empresa","Declaracao Pessoa Juridica (Geral)","D.C.T.F."," D A C O M ","D.I.R.F.","Declaracao PJ - Simples","Declaracao PJ - Inativas","Declaracao do I.T.R.","Declaracao IRPF do socios da empresa","Guia Informativa Simplificada Mensal - ICMS","Gia Modelo 2 Mensal - ICMS","Guia Modelo B - Anual"," SINTEGRA ","Declaracao Municipal","RAIS","SEFIP / GFIP","Situacao Irregular com Rimax - Honorarios","Situacao Irregular com Rimax - Servicos","Numero da Empresa"}

DO WHILE .T.
   IF .NOT. V_IND0=V_IND1
       VETOR2D[V_IND0]=SUBSTR(VETOR2D[V_IND0],1,LEN(VETOR2D[V_IND0])-1)
   ENDIF
   VETOR2D[V_IND1]=VETOR2D[V_IND1]+" "+CHR(25)
   SET COLOR TO &COR12
   @ 00,00 CLEAR TO 25,80
   @ 00,00 TO 24,79 DOUBLE
   SET COLOR TO &COR14
   CENTRA(00,"TELA DECLARACOES / OUTROS")
      SET COLOR TO &COR12
   DBEDIT(01,02,20,78,VETOR_D,"UDFDECL",,VETOR2D,"Í",,"Í")

   V_IND0=V_IND1
   @ 22,02 SAY "Indexar por coluna (1 - 18)" GET V_IND1 PICT "99" VALID(V_IND1<19 .AND. V_IND1>0)
   READ
DO CASE
   CASE LASTKEY()=27
        EXIT
   CASE V_IND1=1
        INDEX ON C_NUMERO to &SHAR12
   CASE V_IND1=2
        INDEX ON C_DECL1 to &SHAR12 DESCENDING
   CASE V_IND1=3
        INDEX ON C_DECL2 to &SHAR12 DESCENDING
   CASE V_IND1=4
        INDEX ON C_DECL3 to &SHAR12 DESCENDING
   CASE V_IND1=5
        INDEX ON C_DECL4 to &SHAR12 DESCENDING
   CASE V_IND1=6
        INDEX ON C_DECL5 to &SHAR12 DESCENDING
   CASE V_IND1=7
        INDEX ON C_DECL6 to &SHAR12 DESCENDING
   CASE V_IND1=8
        INDEX ON C_DECL7 to &SHAR12 DESCENDING
   CASE V_IND1=9
        INDEX ON C_DECL8 to &SHAR12 DESCENDING
   CASE V_IND1=10
        INDEX ON C_DECL9 to &SHAR12 DESCENDING
   CASE V_IND1=11
        INDEX ON C_DECL10 to &SHAR12 DESCENDING
   CASE V_IND1=12
        INDEX ON C_DECL11 to &SHAR12 DESCENDING
   CASE V_IND1=13
        INDEX ON C_DECL12 to &SHAR12 DESCENDING
   CASE V_IND1=14                   
        INDEX ON C_DECL13 to &SHAR12 DESCENDING
   CASE V_IND1=15
        INDEX ON C_DECL14 to &SHAR12 DESCENDING
   CASE V_IND1=16
        INDEX ON C_DECL15 to &SHAR12 DESCENDING
   CASE V_IND1=17
        INDEX ON C_DECL16 to &SHAR12 DESCENDING
   CASE V_IND1=18
        INDEX ON C_DECL17 to &SHAR12 DESCENDING
ENDCASE

ENDDO
RETURN(.T.)
****************
FUNCTION DECLHISTO()
****************
USE &SHAR2
@ 04,01 CLEAR TO 23,78 
VETOR_D={"C_NUMERO","C_DECL1","C_DECL2","C_DECL3","C_DECL4","C_DECL5","C_DECL6","C_DECL7","C_DECL8","C_DECL9","C_DECL10","C_DECL11","C_DECL12","C_DECL13","C_DECL14","C_DECL15","C_DECL16","C_DECL17"}
*VETOR2D={"N§","DIPJ","DC","DA","IRF","Si","Ina","ITR","PF","GIS","M2","MB","SINT.","D.MUN.","RAIS","SFP","SIR-h","SIR-r"}
VETOR2D={"N§","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8"}
VETOR3D={"Numero da Empresa","Declaracao P.J.(Geral)","D.C.T.F.","DACOM ","D.I.R.F.","Declaracao PJ - Simples","Declaracao PJ - Inativas","Decl.do I.T.R.","Decl.IRPF do socios da empresa","Guia Inform.Simplif.Mensal - ICMS","Gia Modelo 2 Mensal - ICMS","Guia Modelo B - Anual","SINTEGRA","Declaracao Municipal","RAIS","SEFIP / GFIP","Situacao Irreg.c/Rimax - Honorarios","Situacao Irreg.c/Rimax - Servicos","Numero da Empresa"}


DO WHILE .T.

@ 04,45 SAY "Opcoes de Declaracao"
@ 05,45 prompt "Consultar lista de empresas"
@ 06,45 prompt "Gravar p/ lista de empresas"
menu to OPDECL
IF LASTKEY()=27
   EXIT
ENDIF

        @ 04,01 TO 22,37 DOUBLE
        @ 04,08 SAY "Escolha a declaracao"
        FOR X=2 TO 17
            @ 03+X,02 PROMPT VETOR3D[X]
        NEXT X
        MENU TO DH

        DO CASE
           CASE OPDECL=1
           CASE OPDECL=2
 
                DH_DATA=DATE()
                DH_EVENTO="Entrega Declaracao  "
                DH_DESCR=vetor3d[dh+1]+space(30-len(vetor3d[dh+1]))
                dh_obs=space(10)
                @ 06,40 CLEAR TO 08,76
                @ 06,40 say "Data  :" get dh_data
                @ 08,40 say "Descr :" get dh_descr
                READ
                IF LASTKEY()=27
                   LOOP
                ENDIF
                USE &SHAR2
                GOTO TOP
                AAORNUM  := {}
                AAORNOME := {}
                X1CONTA=0
                X2CONTA=0
                DO WHILE .NOT. EOF()
                   X1CONTA++
                   @ 22,30 SAY X1CONTA
                   LECAD()
                   LOGICAL1=(DH=1 .AND. C_DECL1="X") .OR. (DH=2 .AND. C_DECL2="X") .OR. (DH=3 .AND. C_DECL3="X") .OR. (DH=4 .AND. C_DECL4="X") .OR. (DH=5 .AND. C_DECL5="X") 
                   LOGICAL2=(DH=6 .AND. C_DECL6="X") .OR. (DH=7 .AND. C_DECL7="X") .OR. (DH=8 .AND. C_DECL8="X") .OR. (DH=9 .AND. C_DECL9="X") .OR. (DH=10 .AND. C_DECL10="X") 
                   LOGICAL3=(DH=11 .AND. C_DECL11="X") .OR. (DH=12 .AND. C_DECL12="X") .OR. (DH=13 .AND. C_DECL13="X") .OR. (DH=14 .AND. C_DECL14="X") .OR. (DH=15 .AND. C_DECL15="X") 
                   LOGICAL4=(DH=16 .AND. C_DECL16="X") .OR. (DH=17 .AND. C_DECL17="X")

                   IF LOGICAL1 .OR. LOGICAL2 .OR. LOGICAL3 .OR. LOGICAL4
                      LECAD()
                      AADD(AAORNUM,VC_NUMERO)
                      AADD(AAORNOME,VC_NOME)
                      X2CONTA++
                      SKIP +1
                     ELSE
                      SKIP +1
                      LOOP
                   ENDIF
                   
                   IF EOF()
                      EXIT
                   ENDIF
                ENDDO

                USE &SHAR18 INDEX &SHAR19
                FOR X=1 TO X2CONTA
                   IF RLOCK()
                      APPE BLAN
                      REPLACE H_NUMEMP WITH AAORNUM[X]
                      REPLACE H_DATA   WITH DH_DATA
                      REPLACE H_DESCR  WITH DH_DESCR
                      @ 22,45 SAY X2CONTA
                   ELSE
                      AVISO("Historico de Decl nao gravado - outro usuario")
                   ENDIF
               NEXT X

                AVISO("Passou por "+str(X1CONTA)+" Registros e Gravou "+str(X2CONTA))
                
AADD(AAORNUM,987654321)
AADD(AAORNOME,"-----------")
@ 04,01 CLEAR TO 22,37

EA=ACHOICE(05,06,22,37,AAORNOME,.T.,"FUNTA")

ENDCASE
ENDDO
RETURN(.T.)
