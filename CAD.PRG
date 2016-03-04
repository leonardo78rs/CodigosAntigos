*****  EXCLUIR CAE/RS,N FILIAIS
****** 
*******************************************************************************
*** FUNCOES ESPECIFICAS DESTE SISTEMA --> CADASTRO
***  
***  telahistorico()
***  teladecl()
***  telacad()
***  excluiemp()
***  altera_num()
***  lecad()
***  gravacad()
***  zeracad()
***  organizapesq()
***  RENUMERA_TOTAL()  -- temporario para renumeracao empresa
*******************************************************************************

****************
FUNCTION TELAHISTORICO()
****************
USE &SHAR8
INDEX ON H_NUMEMP TO &SHAR9

XEMP1:=XEMP2:=VAL(SPACE(4))
XDAT1:=XDAT2:=CTOD(SPACE(8))
VETOR_H={"H_NUMEMP","H_DATA","H_TEMTEXTO+H_EVENTO","H_DESCR","H_OBS"}
VETOR2H={"N§ "+CHR(25),"DATA","EVENTO","DESCRICAO","OBS"}

SET COLOR TO &COR10

@ 00,00 CLEAR TO 25,80
CENTRA(00,"CONSULTA EVENTOS / HISTORICOS DAS EMPRESAS")

SET COLOR TO &cor11

@ 02,00 clear to 20,80

DO WHILE .T.
   set color to &cor10
   botaof(22,02,cor7,"F3","Por n§")
   botaof(22,13,cor7,"F4","Por Data")
   botaof(22,26,cor7,"F5","Por Evento")
   botaof(22,41,cor7,"F6","Por Descri‡Æo")
   botaof(22,59,cor7,"F7","Por Obs")

   botaof(23,02,cor8,"F8","Intervalo de Empresas")
   botaof(23,26,cor8,"F9","Intervalo de Datas")
   set color to &cor11

   DBEDIT(02,00,19,80,VETOR_H,"UDFHISTO2",,VETOR2H,"Í")

   XA=LASTKEY()

   IF XA=27
      EXIT
   ENDIF

   IF XA=-2 .OR. XA=-3 .OR. XA=-4 .OR. XA=-5 .OR. XA=-6 .OR. XA=-7 .OR. XA=-8
      DO CASE
         CASE XA=-2
              INDEX ON H_NUMEMP TO &SHAR10
              VETOR2H={"N§ "+CHR(25),"DATA","EVENTO","DESCRICAO","OBS"}
         CASE XA=-3
              INDEX ON H_DATA   TO &SHAR10
              VETOR2H={"N§ ","DATA  "+CHR(25),"EVENTO","DESCRICAO","OBS"}
         CASE XA=-4
              INDEX ON H_EVENTO TO &SHAR10
              VETOR2H={"N§ ","DATA","EVENTO "+CHR(25),"DESCRICAO","OBS"}
         CASE XA=-5
                    INDEX ON H_DESCR  TO &SHAR10
              VETOR2H={"N§ ","DATA","EVENTO","DESCRICAO "+CHR(25),"OBS"}
         CASE XA=-6
              INDEX ON H_OBS    TO &SHAR10
              VETOR2H={"N§ ","DATA","EVENTO","DESCRICAO","OBS "+CHR(25)}
         CASE XA=-7
              @ 22,63 SAY "DA EMPR." GET XEMP1 PICT "9999"
              @ 23,63 SAY "ATE EMPR" GET XEMP2 PICT "9999"
              READ
              VETOR2H={"N§ "+CHR(25),"DATA","EVENTO","DESCRICAO","OBS"}
              INDEX ON H_NUMEMP TO &SHAR11 FOR H_NUMEMP>=XEMP1 .AND. H_NUMEMP<=XEMP2
         CASE XA=-8
              @ 22,63 SAY "DE " GET XDAT1
              @ 23,63 SAY "ATE" GET XDAT2 
              VETOR2H={"N§ ","DATA  "+CHR(25),"EVENTO","DESCRICAO","OBS"}
              READ
              INDEX ON H_DATA TO &SHAR11 FOR H_DATA>=XDAT1 .AND. H_DATA<=XDAT2
      ENDCASE
      LOOP
   ENDIF
ENDDO
RETURN(.T.)


****************
FUNCTION TELACAD()
****************
oldcor=setcolor()

DO WHILE .T.
   DO WHILE .T.
      SET COLOR TO &COR10
      CLEAR                                       
      @ 00,00 TO 24,79 DOUBLE
      @ 00,23 clear to 02,56
      SET COLOR TO &COR19
        IF OFFLINE=1
           SET COLOR TO &COR2
           @ 00,25 SAY "     OPERANDO EM OFF-LINE     "
           SET COLOR TO &COR11
        ELSE
        @ 00,25 SAY "Assessoria Contabil Rimax Ltda"
        ENDIF

      @ 01,30 say "Cadastro de Clientes"

      SET COLOR TO &COR10

      @ 00,23 say "¹"
      @ 00,56 say "Ì"
      @ 01,23 say chr(186)
      @ 01,56 say chr(186)
      @ 02,23 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
FICHA=MDULTTELA

CABETELA(FICHA)
   DO CASE
      CASE FICHA=2
           KEYB CHR(32)
      CASE FICHA=3
           KEYB CHR(32)+CHR(32)
      CASE FICHA=4
           KEYB CHR(32)+CHR(32)+CHR(32)+CHR(24)
   ENDCASE

       @ 03,02 SAY "NUMERO...:"  GET VC_NUMERO PICT ("9999")
       READ
       IF LASTKEY()=27
         setcolor(oldcor)
         RETURN(.T.)
      ENDIF
      FIND &VC_NUMERO
      IF .NOT. FOUND() .AND. .NOT. EMPTY(VC_NUMERO)
         SN=AVISO2("EMPRESA NOVA, INCLUIR?","SIM","NAO")
         IF RLOCK()
         IF SN=1
            APPE BLAN
            NUMTEMP=VC_NUMERO
            ZERACAD()
            VC_NUMERO=NUMTEMP
            GRAVACAD()
            TELACAD()
          ELSE
            loop
         ENDIF
         ELSE
         AVISO("FLOCK - OUTRO USUARIO ATIVO")
         ENDIF
      ELSEIF EMPTY(VC_NUMERO)
         GOTO TOP
         LECAD()
         CODIGO="EXISTE"
      ELSE
         LECAD()
         CODIGO="EXISTE"
      ENDIF
      EXIT
   ENDDO

   DO WHILE .T.
      LECAD()

    DO CASE
      CASE FICHA=1
      @ 03,02 SAY "NUMERO...:"  GET VC_NUMERO PICT ("9999")
     * CLEAR GETS  
      @ 03,19 SAY "FANTASIA:"   GET VC_FANTASIA
      @ 03,54 SAY "ATUALIZADO EM: " + DTOC(VC_ATUALIZA)
      oldicor=setcolor()
      set color to  &cor10
      @ 04,02 SAY "RENUMERAR:"  GET VC_NOVONUM PICT ("9999")
      @ 04,19 SAY "INATIVA :"   GET VC_INATIVA
      @ 04,32 say "PAGA (S,N,Atraso):" get vc_paga
      setcolor(oldicor)
      @ 08,02 SAY "NOME.....:"  GET VC_NOME
      @ 09,02 SAY "ENDERECO.:"  GET VC_ENDER
      @ 09,69 SAY "DIR:"  GET VC_DIR  PICT "99/99"

      @ 10,02 SAY "CIDADE...:"  GET VC_CIDADE valid(ciudad(VC_CIDADE))
      @ 10,34 SAY "UF:"         GET VC_UF
      @ 11,02 SAY "BAIRRO...:"  GET VC_BAIRRO
      @ 11,34 SAY "C.E.P.:"     GET VC_CEP PICT "99.999-999"
      
      @ 10,53 SAY "FONE.....:"  GET VC_FONE PICT"(99)99.99.99.99"
      @ 11,53 SAY "FAX......:"  GET VC_FAX  PICT"(99)99.99.99.99"

      @ 13,02 SAY "CNPJ.....:"  GET VC_CGCMF PICT "99.999.999/9999-99" VALID(VCGC(VC_CGCMF))
      @ 13,32 SAY "CGC/TE:"     GET VC_CGCTE PICT "999/9999999"
      @ 13,52 SAY "CGC/PM:"     GET VC_CGCPM PICT "@9"
      
      @ 15,02 SAY "C.N.A.E. :"  GET VC_CNAE PICT  "99.99-9/99"
      @ 16,02 SAY "C.N.A.E. :"  GET VC_CNAE2 PICT "99.99-9/99" 
      @ 15,24 SAY "Nat.Jur"     GET VC_NAT PICT "999-9" 
      @ 15,38 SAY "NIRE/ICRE:"  GET VC_NIRC  PICT "@9"
      @ 15,64 SAY "DATA:"       GET VC_DATA

      @ 17,02 SAY "Org.Classe" GET VC_ORG
      @ 17,30 SAY "Data" GET VC_DATAORG

      @ 19,02 SAY "E-Mail (Correio)" GET VC_EMAIL
      @ 20,02 SAY "H.Page  (Sitio) " GET VC_HP

      CASE FICHA=2

      @ 03,02 SAY "NUMERO...:"  GET VC_NUMERO PICT ("9999")
      @ 03,19 SAY "FANTASIA:"   GET VC_FANTASIA
      @ 03,54 SAY "ATUALIZADO EM: " + DTOC(VC_ATUALIZA)
      CLEAR GETS

      @ 08,72 SAY "1.Resp."
      @ 09,72 SAY "2.Ger. "
      @ 10,72 SAY "3.Quot."
      @ 11,72 SAY "4.Menor"

      @ 08,02 GET VC_CPF1   PICT "999.999.999-99" VALID(VCPF(VC_CPF1))
      @ 08,17 GET VC_tipo1  PICT "9"
      @ 08,19 GET VC_NOME1  
      @ 08,61 GET VC_CAPIT1 PICT "@e 999,999.99"
     
      @ 09,02 GET VC_CPF2   PICT "999.999.999-99" VALID(VCPF(VC_CPF2))
      @ 09,17 GET VC_tipo2  PICT "9"
      @ 09,19 GET VC_NOME2  
      @ 09,61 GET VC_CAPIT2 PICT "@e 999,999.99"
      
      @ 10,02 GET VC_CPF3   PICT "999.999.999-99" VALID(VCPF(VC_CPF3))
      @ 10,17 GET VC_tipo3  PICT "9"
      @ 10,19 GET VC_NOME3  
      @ 10,61 GET VC_CAPIT3 PICT "@e 999,999.99"
      
      @ 11,02 GET VC_CPF4   PICT "999.999.999-99" VALID(VCPF(VC_CPF4))
      @ 11,17 GET VC_tipo4  PICT "9"
      @ 11,19 GET VC_NOME4  
      @ 11,61 GET VC_CAPIT4 PICT "@e 999,999.99" 

      @ 12,02 GET VC_CPF5   PICT "999.999.999-99" VALID(VCPF(VC_CPF5))
      @ 12,17 GET VC_tipo5  PICT "9"
      @ 12,19 GET VC_NOME5  
      @ 12,61 GET VC_CAPIT5 PICT "@e 999,999.99"
      set color to &cor16
      @ 13,61 SAY VC_CAPIT1+VC_CAPIT2+VC_CAPIT3+VC_CAPIT4+VC_CAPIT5 PICT "@e 999,999.99"
      set color to &cor9
      @ 14,02 SAY "U.A.C....:"  GET VC_UAC  PICT "@9"
      @ 14,27 SAY "DATA:"       GET VC_DATA_UAC
      @ 14,43 SAY "N§ ORDEM:"   GET VC_ORD_UAC PICT "99"
       
      @ 16,02 GET VC_OBJETO1
      @ 17,02 GET VC_OBJETO2
      @ 18,02 GET VC_OBJETO3
      @ 19,02 GET VC_OBJETO4
      @ 20,02 GET VC_OBJETO5
      

      case FICHA=3

      @ 03,02 SAY "NUMERO...:"  GET VC_NUMERO PICT ("9999")
      @ 03,19 SAY "FANTASIA:"   GET VC_FANTASIA
      @ 03,54 SAY "ATUALIZADO EM: " + DTOC(VC_ATUALIZA)
      CLEAR GETS  
      REG_PROC=RECNO()
          USE &SHAR8
          INDEX ON H_DATA TO &SHAR9 FOR H_NUMEMP=VC_NUMERO DESCENDING
          set color to &cor16
          @ 21,00 SAY " <N>Incluir Nova Linha <A>Alterar  <DEL>/<E>Excluir  <T>Ver/Alterar Texto "
          VETORCAMPO={"H_DATA","H_TEMTEXTO+H_EVENTO","H_DESCR","H_OBS"}
          vetornome={"Data","Evento","Descricao","Obs"}
          DBEDIT(08,00,20,80,VETORCAMPO,"UDFHISTO",,VETORNOME,"Í")
          USE &SHAR2 INDEX &SHAR3
      GOTO REG_PROC

      case FICHA=4

      @ 03,02 SAY "NUMERO...:"  GET VC_NUMERO PICT ("9999")
      @ 03,19 SAY "FANTASIA:"   GET VC_FANTASIA
      @ 03,54 SAY "ATUALIZADO EM: " + DTOC(VC_ATUALIZA)
      CLEAR GETS  
      @ 08,02 SAY "D I P J   " GET VC_DECL1
      @ 09,02 SAY "D C T F   " GET VC_DECL2
      @ 10,02 SAY "D A C O M " GET VC_DECL3
      @ 11,02 SAY "D I R F   " GET VC_DECL4
      @ 12,02 SAY "PJ-Simples" GET VC_DECL5
      @ 13,02 SAY "PJ-Inativa" GET VC_DECL6
      @ 14,02 SAY "I T R     " GET VC_DECL7
      @ 15,02 SAY "DIRPF SOC." GET VC_DECL8
      @ 08,17 SAY "G I S     " GET VC_DECL9
      @ 09,17 SAY "GIA MOD 2 " GET VC_DECL10
      @ 10,17 SAY "MODELO B  " GET VC_DECL11
      @ 11,17 SAY "SINTEGRA  " GET VC_DECL12
      @ 12,17 SAY "DECL.MUNIC" GET VC_DECL13 
      @ 14,17 SAY "R A I S   " GET VC_DECL14 
      @ 15,17 SAY "SEFIP/GFIP" GET VC_DECL15
      @ 17,02 SAY "Sit.Irreg. Rimax (Honor.)" GET VC_DECL16
      @ 18,02 SAY "Sit.Irreg. Rimax (Serv. )" GET VC_DECL17

      REG_PROC=RECNO()
          USE &SHAR18
          INDEX ON H_DATA TO &SHAR19 FOR H_NUMEMP=VC_NUMERO DESCENDING

          VETORCAMPO={"H_DATA","H_DESCR"}
          vetornome={"Data","Descricao"}
          SET COLOR TO &COR16
       
          DBEDIT(08,30,20,79,VETORCAMPO,"UDFCADDECL",,VETORNOME,"Í")
          USE &SHAR2 INDEX &SHAR3
      GOTO REG_PROC

    ENDCASE

      SET COLOR TO &COR12
      @ 22,02 SAY " <a> Altera empresa  <i> indice " 
      @ 23,02 SAY "Setas: <- Anterior    -> Proximo"
      @ 22,39 SAY "<home> primeiro     <end> ultimo"
      @ 23,39 SAY "<Pg Up> volta 10    <Pg Dn> avanca 10"
      SET COLOR TO &COR9

      INKEY(0)
      
      IF (lastkey()=65 .or. LASTKEY()=97) .AND. (.NOT. FICHA=3)
         
            READ
            AVISO("Digite <N> para cancelar")
            IF !LASTKEY()=78 .and. !LASTKEY()=110
               IF RLOCK()
		GRAVACAD()
                AVISO("Gravado")
               ELSE
                AVISO("FLOCK - OUTRO USUARIO ATIVO - NAO PODE GRAVAR")
               ENDIF
	    ENDIF
         ELSE
            CLEAR GETS
      ENDIF
                        
      IF FICHA=2 .AND. LASTKEY()=275
         aviso("Ainda em construcao")
         LOOP
      ENDIF

      IF LASTKEY()=271
         DO CASE
            CASE FICHA=1
                 FICHA=3
            CASE FICHA=2
                 FICHA=4
            CASE FICHA=3
                 FICHA=1
            CASE FICHA=4
                 FICHA=2
          ENDCASE
          set color to &cor10
          @ 05,03 TO 07,23 DOUBLE
          @ 06,04 SAY " DADOS CADASTRAIS  "
          @ 05,57 TO 07,78 DOUBLE
          @ 06,58 SAY " Declara‡oes/Outros "
          @ 05,43 TO 07,55 DOUBLE
          @ 06,44 SAY " Historico "
          @ 05,26 TO 07,41 DOUBLE
          @ 06,27 SAY " SOCIOS/JUNTA "
          set color to &cor9
          ENDIF
      DO CASE 
         CASE LASTKEY()=32 .OR. LASTKEY()=9 .OR. LASTKEY()=271
               FICHA=FICHA+1
               IF FICHA=5
                  FICHA=1
               ENDIF
               CABETELA(FICHA)
         CASE LASTKEY()=1
              GOTO TOP
         CASE LASTKEY()=19
                 SKIP -1
         CASE LASTKEY()=4 
                 SKIP +1
                 IF EOF()
                    SKIP -1
                 ENDIF
         CASE LASTKEY()=6
              GOTO BOTTOM
                 IF EOF()
                    SKIP -1
                 ENDIF
         CASE LASTKEY()=18
              skip -10
         CASE LASTKEY()=3
              skip +10
                 IF EOF()
                    SKIP -1
                 ENDIF
         CASE LASTKEY()=27
              MDULTTELA=FICHA
              *@ 08,00 CLEAR TO 20,80
              CABETELA(FICHA)
              EXIT
         CASE LASTKEY()=105 .OR. LASTKEY()=73
              
	      VAR=ESCOLHA_PESQUISA(04,15,1)
	      IF !LASTKEY()=27
                 ORGANIZAPESQ(var)
	      ENDIF	
      ENDCASE
           LOOP
   ENDDO
ENDDO
RETURN(.T.)
*********************
FUNCTION CIUDAD(XXXCIDA)

IF XXXCIDA="PA"
   KEYB CHR(5)+"Porto Alegre"+CHR(13)+"RS"+CHR(13)
ELSEIF XXXCIDA="CA"
   KEYB CHR(5)+"Cachoeirinha"+CHR(13)+"RS"+CHR(13)
ELSEIF XXXCIDA="G"
   KEYB CHR(5)+"Guaiba"+CHR(13)+"RS"+CHR(13)
ELSEIF XXXCIDA="GR"
   KEYB CHR(5)+"Gravatai"+CHR(13)+"RS"+CHR(13)
  
ENDIF
RETURN(.T.)


**********************
FUNCTION EXCLUI_EMP()
**********************
USE &SHAR2 INDEX &SHAR3 EXCLUSIVE
DO WHILE .NOT. LASTKEY()=27
   oldcore=setcolor()
   SET COLOR TO COR10
   @ 06,02 CLEAR TO 19,58
   BORDA(06,02,19,58,"6/N")
   VC_NUMERO=0
   @ 07,03 SAY "NUMERO...:"  GET VC_NUMERO PICT ("9999") VALID .NOT.  EMPTY(VC_NUMERO)
   READ
   IF LASTKEY()=27
      LOOP
   ENDIF
   FIND &VC_NUMERO
   IF .NOT. FOUND()
      AVISO("EMPRESA "+alltrim(str(vc_numero))+" NAO ENCONTRADA!")
      LOOP
   ENDIF
   LECAD()
   SET COLOR TO "7/n"
   @ 09,03 SAY ALLTRIM(VC_FANTASIA)
   @ 11,03 SAY ALLTRIM(VC_NOME)
   @ 13,03 SAY ALLTRIM(VC_ENDER)
   @ 14,03 SAY ALLTRIM(VC_BAIRRO)+", "+ALLTRIM(VC_CIDADE)+"/"+VC_UF
   @ 16,03 SAY VC_CGCMF+", "+VC_CGCTE+", "+VC_CGCPM
   SN="N"
   SET COLOR TO "7/6"
   @ 18,03 SAY "DESEJA EXCLUIR..? " GET SN PICT "@!" VALID SN$"SN"
   READ
   IF SN="N"
      LOOP
   ENDIF
   set EXCLUSIVE ON
   IF FLOCK()
      DELETE
      PACK
      AVISO("EMPRESA"+ALLTRIM(VC_FANTASIA)+" EXCLUIDA!")
   ELSE
      AVISO("Registro em uso - nao foi possivel excluir - funcao Lock!")
   ENDIF
   set exclusive oFF
   LOOP
ENDDO
SETCOLOR(oldcore)
**********************
FUNCTION ALTERA_NUM()
**********************
DO WHILE .NOT. LASTKEY()=27
   @ 04,02 CLEAR TO 23,78
   *BORDA(06,02,12,48,cor6)
   VC_NUMERO=0
   centra(05,"Altera‡ao do n§ da empresa")
   @ 06,03 SAY "Esta alteracao influencia em mais de um arquivo"

   @ 08,03 SAY "NUMERO...:"  GET VC_NUMERO PICT ("9999") VALID .NOT. EMPTY(VC_NUMERO)
   READ
   IF LASTKEY()=27
      LOOP
   ENDIF
   FIND &VC_NUMERO
   IF .NOT. FOUND()
      AVISO("EMPRESA NAO ENCONTRADA!")
      LOOP
   ENDIF
   LECAD()
   @ 109,03 SAY "FANTASIA..: "  + ALLTRIM(VC_FANTASIA)
   @ 11,03 SAY ALLTRIM(VC_NOME)
   @ 13,03 SAY "NOVO N§..:"  GET V2_NUMERO PICT ("9999") VALID .NOT. EMPTY(V2_NUMERO)
   READ
   IF LASTKEY()=27
      LOOP
   ENDIF     
   FIND &V2_NUMERO
   IF FOUND()
      AVISO("EMPRESA ENCONTRADA, NAO E POSSIVEL DUAS EMPRESAS COM MESMO NUMERO")
      LOOP
   ENDIF
   FIND &VC_NUMERO
   IF RLOCK()
      REPLACE C_NUMERO WITH V2_NUMERO
      REPLACE C_ATUALIZA WITH DATE()
      @ 15,03 SAY "N§ DA EMPRESA ALTERADO! - Alterar arquivos Auxiliares"
   ELSE
      AVISO("FLOCK - OUTRO USUARIO")
      LOOP
   ENDIF
   ********ALTERA NO HISTOR
   USE &SHAR8 EXCLUSIVE
   INDEX ON H_NUMEMP TO &SHAR9
   COUNT TO VARIAVEL FOR H_NUMEMP=VC_NUMERO
   @ 17,03 SAY "Voce tem "+str(variavel)+" historico(s) a alterar"
*   SET FILTER TO H_NUMEMP=VC_NUMERO
   GOTO TOP
   XI=1
   XYX=0
   DO WHILE .NOT. EOF()
     
      IF H_NUMEMP=VC_NUMERO
         XYX++
         Replace H_NUMEMP WITH V2_NUMERO
         @ 17,40 SAY STR(XYX)+"§) "+H_DESCR+"-"+H_EVENTO
         INKEY(0.1)
         GOTO TOP
      ENDIF
      SKIP +1
      XI++
   ENDDO
   ********ALTERA NO HISTORDECL
   use
   USE &SHAR18 EXCLUSIVE
   goto top
   INDEX ON H_NUMEMP TO &SHAR19
   COUNT TO VARIAVEL FOR H_NUMEMP=VC_NUMERO
   @ 19,03 SAY "Voce tem "+str(variavel)+" listagem(s) de declaracoes a alterar"
   SET FILTER TO H_NUMEMP=VC_NUMERO
   GOTO TOP
*   browse()
   XI=1
   XYX=0
   DO WHILE .T. 
*      IF H_NUMEMP=VC_NUMERO
         XYX++
         Replace H_NUMEMP WITH V2_NUMERO
         @ 19,40 SAY STR(XYX)+"§) "+DTOC(H_DATA)+"-"+H_DESCR
         INKEY(0.1)
         *GOTO TOP
*      ENDIF
      XI++
      if eof()
         exit
      endif
      SKIP +1

   ENDDO
   ********ALTERA NO BRS
   USE &SHAR14 EXCLUSIVE
   INDEX ON R_NUMEMP TO &SHAR15
   COUNT TO TOTALREG
   COUNT TO VARIAVEL FOR R_NUMEMP=VC_NUMERO
   @ 21,03 SAY "Voce tem "+str(variavel)+" doc(s) do Brs a alterar"
   SET FILTER TO R_NUMEMP=VC_NUMERO
   GOTO TOP
   XI=1
   XYX=0
   DO WHILE .NOT. EOF()
      XI++
      
      *AVISO(STR(R_NUMEMP)+" - "+STR(VC_NUMERO))
      IF R_NUMEMP=VC_NUMERO
         XYX++
         Replace R_NUMEMP WITH VAL(ALLTRIM(STR(V2_NUMERO)))
         @ 21,40 SAY STR(XYX)+"§) "+SUBSTR(R_NOME,1,18)+"-"+DTOC(R_DATADO)
         INKEY(0.1)
         GOTO TOP
      ENDIF
      SKIP +1
   ENDDO
   AVISO("FIM O")

   LOOP

ENDDO
RETURN(.t.)

****************
FUNCTION LECAD()
****************
VC_NUMERO    =  C_NUMERO
VC_NOVONUM   =  C_NOVONUM
VC_INATIVA   =  C_INATIVA
VC_PAGA      =  C_PAGA
VC_FANTASIA  =  C_FANTASIA
VC_DIR       =  C_DIR
VC_NOME      =  C_NOME
VC_ENDER     =  C_ENDER
VC_CIDADE    =  C_CIDADE
VC_UF        =  C_UF
VC_BAIRRO    =  C_BAIRRO
VC_CEP       =  C_CEP
VC_CGCMF     =  C_CGCMF
VC_CGCTE     =  C_CGCTE
VC_CGCPM     =  C_CGCPM
VC_NIRC      =  C_NIRC
VC_DATA      =  C_DATA
VC_UAC       =  C_UAC
VC_ORD_UAC   =  C_ORD_UAC
VC_DATA_UAC  =  C_DATA_UAC
VC_FILIAL    =  C_FILIAL
VC_CNAE      =  C_CNAE
VC_CAERS     =  C_CAERS
VC_FONE      =  C_FONE
VC_FAX       =  C_FAX
VC_CPF1      =  C_CPF1
VC_CPF2      =  C_CPF2
VC_CPF3      =  C_CPF3
VC_CPF4      =  C_CPF4
VC_CPF5      =  C_CPF5
VC_NOME1     =  C_NOME1
VC_NOME2     =  C_NOME2
VC_NOME3     =  C_NOME3
VC_NOME4     =  C_NOME4
VC_NOME5     =  C_NOME5
VC_CAPIT1    =  C_CAPIT1
VC_CAPIT2    =  C_CAPIT2
VC_CAPIT3    =  C_CAPIT3
VC_CAPIT4    =  C_CAPIT4
VC_CAPIT5    =  C_CAPIT5
VC_OBJETO1   =  C_OBJETO1
VC_OBJETO2   =  C_OBJETO2
VC_OBJETO3   =  C_OBJETO3
VC_OBJETO4   =  C_OBJETO4
VC_OBJETO5   =  C_OBJETO5
VC_TIPO1     =  C_TIPO1
VC_TIPO2     =  C_TIPO2
VC_TIPO3     =  C_TIPO3
VC_TIPO4     =  C_TIPO4
VC_TIPO5     =  C_TIPO5
VC_EMAIL     =  C_EMAIL
VC_HP        =  C_HP
VC_ORG       =  C_ORG
VC_dataorg   =  C_DATAORG
VC_NAT       =  C_NAT
VC_ATUALIZA  = C_ATUALIZA
VC_DECL1     = C_DECL1
VC_DECL2     = C_DECL2
VC_DECL3     = C_DECL3
VC_DECL4     = C_DECL4
VC_DECL5     = C_DECL5
VC_DECL6     = C_DECL6
VC_DECL7     = C_DECL7
VC_DECL8     = C_DECL8
VC_DECL9     = C_DECL9
VC_DECL10    = C_DECL10
VC_DECL11    = C_DECL11
VC_DECL12    = C_DECL12
VC_DECL13    = C_DECL13
VC_DECL14    = C_DECL14
VC_DECL15    = C_DECL15
VC_DECL16    = C_DECL16
VC_DECL17    = C_DECL17
VC_DECL18    = C_DECL18
VC_DECL19    = C_DECL19
VC_DECL20    = C_DECL20
VC_DECL21    = C_DECL21
VC_DECL22    = C_DECL22


RETURN(.T.)


*******************
FUNCTION GRAVACAD()
*******************
REPLACE C_NUMERO     WITH VC_NUMERO
REPLACE C_NOVONUM    WITH VC_NOVONUM
REPLACE C_INATIVA    WITH VC_INATIVA
REPLACE C_PAGA       WITH VC_PAGA
REPLACE C_FANTASIA   WITH VC_FANTASIA
REPLACE C_DIR        WITH VC_DIR
REPLACE C_NOME       WITH VC_NOME
REPLACE C_ENDER      WITH VC_ENDER
REPLACE C_CIDADE     WITH VC_CIDADE
REPLACE C_UF         WITH VC_UF
REPLACE C_BAIRRO     WITH VC_BAIRRO
REPLACE C_CEP        WITH VC_CEP
REPLACE C_CGCMF      WITH VC_CGCMF
REPLACE C_CGCTE      WITH VC_CGCTE
REPLACE C_CGCPM      WITH VC_CGCPM
REPLACE C_NIRC       WITH VC_NIRC
REPLACE C_DATA       WITH VC_DATA
REPLACE C_UAC        WITH VC_UAC
REPLACE C_ORD_UAC    WITH VC_ORD_UAC
REPLACE C_DATA_UAC   WITH VC_DATA_UAC
REPLACE C_FILIAL     WITH VC_FILIAL
REPLACE C_CNAE       WITH VC_CNAE
REPLACE C_CAERS      WITH VC_CAERS
REPLACE C_FONE       WITH VC_FONE
REPLACE C_FAX        WITH VC_FAX
REPLACE C_CPF1       WITH VC_CPF1
REPLACE C_CPF2       WITH VC_CPF2
REPLACE C_CPF3       WITH VC_CPF3
REPLACE C_CPF4       WITH VC_CPF4
REPLACE C_CPF5       WITH VC_CPF5

REPLACE C_NOME1      WITH VC_NOME1
REPLACE C_NOME2      WITH VC_NOME2
REPLACE C_NOME3      WITH VC_NOME3
REPLACE C_NOME4      WITH VC_NOME4
REPLACE C_NOME5      WITH VC_NOME5
REPLACE C_CAPIT1     WITH VC_CAPIT1
REPLACE C_CAPIT2     WITH VC_CAPIT2
REPLACE C_CAPIT3     WITH VC_CAPIT3
REPLACE C_CAPIT4     WITH VC_CAPIT4
REPLACE C_CAPIT5     WITH VC_CAPIT5
REPLACE C_OBJETO1    WITH VC_OBJETO1
REPLACE C_OBJETO2    WITH VC_OBJETO2
REPLACE C_OBJETO3    WITH VC_OBJETO3
REPLACE C_OBJETO4    WITH VC_OBJETO4
REPLACE C_OBJETO5    WITH VC_OBJETO5
REPLACE C_TIPO1      WITH VC_TIPO1
REPLACE C_TIPO2      WITH VC_TIPO2
REPLACE C_TIPO3      WITH VC_TIPO3
REPLACE C_TIPO4      WITH VC_TIPO4
REPLACE C_TIPO5      WITH VC_TIPO5
REPLACE C_EMAIL      WITH  VC_EMAIL
REPLACE C_HP         WITH  VC_HP
REPLACE C_ORG        WITH  VC_ORG
REPLACE C_DATAORG    WITH  VC_DATAORG
REPLACE C_NAT        WITH  VC_NAT
REPLACE C_ATUALIZA   WITH  DATE()
REPLACE C_DECL1         WITH  VC_DECL1
REPLACE C_DECL2         WITH  VC_DECL2
REPLACE C_DECL3         WITH  VC_DECL3
REPLACE C_DECL4         WITH  VC_DECL4
REPLACE C_DECL5         WITH  VC_DECL5
REPLACE C_DECL6         WITH  VC_DECL6
REPLACE C_DECL7         WITH  VC_DECL7
REPLACE C_DECL8         WITH  VC_DECL8
REPLACE C_DECL9         WITH  VC_DECL9
REPLACE C_DECL10        WITH  VC_DECL10
REPLACE C_DECL11         WITH  VC_DECL11
REPLACE C_DECL12         WITH  VC_DECL12
REPLACE C_DECL13         WITH  VC_DECL13
REPLACE C_DECL14         WITH  VC_DECL14
REPLACE C_DECL15         WITH  VC_DECL15
REPLACE C_DECL16         WITH  VC_DECL16
REPLACE C_DECL17         WITH  VC_DECL17
REPLACE C_DECL18         WITH  VC_DECL18
REPLACE C_DECL19         WITH  VC_DECL19
REPLACE C_DECL20        WITH  VC_DECL20
REPLACE C_DECL21        WITH  VC_DECL21
REPLACE C_DECL22        WITH  VC_DECL22


RETURN(.T.)



******************
FUNCTION ZERACAD()
******************
VC_NUMERO    =  VAL(SPACE(4))
VC_NOVONUM   =  VAL(SPACE(4))
VC_INATIVA   =  "N"
VC_PAGA      =  " "
VC_FANTASIA  =  SPACE(20)
VC_DIR       =  SPACE(5)
VC_NOME      =  SPACE(50)
VC_ENDER     =  SPACE(50)
VC_CIDADE    =  SPACE(20)
VC_UF        =  SPACE(2)
VC_BAIRRO    =  SPACE(20)
VC_CEP       =  SPACE(10)
VC_CGCMF     =  SPACE(18)
VC_CGCTE     =  SPACE(11)
VC_CGCPM     =  SPACE(15)
VC_NIRC      =  SPACE(14)
VC_DATA      =  CTOD(SPACE(8))
VC_UAC       =  SPACE(12)
VC_ORD_UAC   =  VAL(SPACE(2))
VC_DATA_UAC  =  CTOD(SPACE(8))
VC_FILIAL    =  VAL(" ")
VC_CNAE      =  SPACE(10)
VC_CAERS     =  SPACE(11)
VC_FONE      =  SPACE(15)
VC_FAX       =  SPACE(15)
VC_CPF1      =  SPACE(14)
VC_CPF2      =  SPACE(14)
VC_CPF3      =  SPACE(14)
VC_CPF4      =  SPACE(14)
VC_CPF5      =  SPACE(14)
VC_NOME1     =  SPACE(40)
VC_NOME2     =  SPACE(40)
VC_NOME3     =  SPACE(40)
VC_NOME4     =  SPACE(40)
VC_NOME5     =  SPACE(40)
VC_CAPIT1    =  VAL(SPACE(17))
VC_CAPIT2    =  VAL(SPACE(17))
VC_CAPIT3    =  VAL(SPACE(17))
VC_CAPIT4    =  VAL(SPACE(17))
VC_CAPIT5    =  VAL(SPACE(17))
VC_OBJETO1   =  SPACE(76)
VC_OBJETO2   =  SPACE(76)
VC_OBJETO3   =  SPACE(76)
VC_OBJETO4   =  SPACE(76)
VC_OBJETO5   =  SPACE(76)
VC_TIPO1     =  SPACE(1)
VC_TIPO2     =  SPACE(1)
VC_TIPO3     =  SPACE(1)
VC_TIPO4     =  SPACE(1)
VC_TIPO5     =  SPACE(1)
VC_EMAIL     =  SPACE(40)
VC_HP        =  SPACE(40)
VC_ORG       =  SPACE(13)
VC_dataorg   =  SPACE(8)
VC_NAT       =  SPACE(5)
VC_ATUALIZA  =  CTOD(SPACE(8))

vc_decl1     = space(1)
vc_decl2     = space(1)
vc_decl3     = space(1)
vc_decl4     = space(1)
vc_decl5     = space(1)
vc_decl6     = space(1)
vc_decl7     = space(1)
vc_decl8     = space(1)
vc_decl9     = space(1)
vc_decl10    = space(1)
vc_decl11    = space(1)
vc_decl12    = space(1)
vc_decl13    = space(1)
vc_decl14    = space(1)
vc_decl15    = space(1)
vc_decl16    = space(1)
vc_decl17    = space(1)
vc_decl18    = space(1)
vc_decl19    = space(1)
vc_decl20    = space(1)
vc_decl21    = space(1)
vc_decl22    = space(1)
RETURN(.T.)

******************************
FUNCTION ORGANIZAPESQ(var)
*******************************
if var=1
        index on C_NUMERO to &SHAR13
elseif var=2
        index on C_DIR to &SHAR13
elseif var=3
        index on c_atualiza to &SHAR13
elseif var=4
        index on C_FANTASIA to &SHAR13
elseif var=5
        index on C_NOME to &SHAR13
elseif var=6
        index on C_ENDER to &SHAR13
elseif var=7
        index on C_CIDADE to &SHAR13
elseif var=8
        index on C_UF to &SHAR13
elseif var=9
        index on C_BAIRRO to &SHAR13
elseif var=10
        index on C_CEP to &SHAR13
elseif var=11
        index on C_FONE to &SHAR13
elseif var=12
        index on C_FAX to &SHAR13
elseif var=13
        index on C_CGCMF to &SHAR13
elseif var=14
        index on C_CGCTE to &SHAR13
elseif var=15
        index on C_CGCPM to &SHAR13
elseif var=16
        index on C_NAT to &SHAR13
elseif var=17
        index on C_CNAE to &SHAR13
elseif var=18
        index on C_CAERS to &SHAR13
elseif var=19
        index on C_NIRC to &SHAR13
elseif var=20
        index on C_UAC to &SHAR13
elseif var=21
        index on FILIAL to &SHAR13
elseif var=22
        index on C_ORG to &SHAR13
elseif var=23
        index on C_CPF1 to &SHAR13
elseif var=24
        index on C_OBJETO1 to &SHAR13
elseif var=25
        index on C_EMAIL to &SHAR13
elseif var=26
        index on C_HP to &SHAR13
elseif var=27
        index on C_NOVONUM to &SHAR13
elseif var=28
        index on C_PAGA to &SHAR13

endif
RETURN(.T.)



FUNCTION CABETELA(FICHA)
OLDCOR=SETCOLOR()
      SET COLOR TO &cor9
      @ 07,00 clear TO 21,79
      @ 07,00 TO 21,79 
      @ 05,03 TO 07,23
      @ 07,01 CLEAR TO 07,79
SET COLOR TO &COR10 
@ 05,03 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 05,26 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 05,43 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 05,57 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"

@ 06,03 SAY    "³"
@ 06,23 SAY    "³"
@ 06,26 SAY    "³"
@ 06,41 SAY    "³"
@ 06,43 SAY    "³"
@ 06,55 SAY    "³"
@ 06,57 SAY    "³"
@ 06,77 SAY    "³"
@ 06,04 SAY " Dados Cadastrais  "
@ 06,27 SAY " Socios/Junta "
@ 06,44 SAY " Historico "
@ 06,58 SAY " Declara‡oes/Outros"

IF FICHA=1
SET COLOR TO &COR9 
@ 06,03 SAY    "³"
@ 06,23 SAY    "³"
@ 05,03 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 07,00 SAY "ÚÄÄÙ"
@ 07,23 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
SET COLOR TO &COR16
@ 06,04 SAY " Dados Cadastrais  "

ELSEIF FICHA=2
SET COLOR TO &COR9
@ 06,26 SAY    "³"
@ 06,41 SAY    "³"
@ 05,26 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 07,00 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
@ 07,41 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
SET COLOR TO &COR16
@ 06,27 SAY " Socios/Junta "

ELSEIF FICHA=3
SET COLOR TO &COR9
@ 06,43 SAY    "³"
@ 06,55 SAY    "³"
@ 05,43 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 07,00 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
@ 07,55 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
SET COLOR TO &COR16
@ 06,44 SAY " Historico "

ELSEIF FICHA=4
SET COLOR TO &COR9
@ 06,57 SAY    "³"
@ 06,77 SAY    "³"
@ 05,57 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
@ 07,00 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
@ 07,77 SAY "ÀÄ¿"
SET COLOR TO &COR16
@ 06,58 SAY " Declara‡oes/Outros"
ENDIF
SET COLOR TO &COR9
RETURN(FICHA)


*************************************************************************************************
*** MODELO PARA NAO SE `QUEBRAR' NA TELA PRINCIPAL
**                     1         2         3         4         5         6         7         8
**              345678901234567890123456789012345678901234567890123456789012345678901234567890
**05,03 SAY    "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄÄÄÄÄÄ¿ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  "
**06,03 SAY    "³ Dados Cadastrais  ³  ³ Socios/Junta ³ ³ Historico ³ ³ Declaracoes/Outros³  "
*************************************************************************************************


**********************
FUNCTION RENUMERA_TOTAL()
**********************
**
** COLOCAR PICT() NOS SAYS DAS COLUNAS, POIS ESTA´APAGANDO A COLUNA ANTERIOR
** COLOCAR COLUNA  OK!  NAS QUE FORAM CONCLUIDAS
**
**
**

@ 04,02 CLEAR TO 23,78
USE &SHAR2 INDEX &SHAR3
RENUM_POSICAO=0
mostralinha=7

   centra(05,"Alteracao do n da empresa")
   @ 06,03 SAY "Esta alteracao influencia em mais de um arquivo"
   @ 07,03 SAY "Fazer cópia de segurança antes.         ++ TECLE <ALGO> PARA CONTINUAR ++ "
   AVISONAOPARA("ESTÁ DESABILITADO!")
   INKEY(0)
 RETURN(.t.)

DO WHILE .NOT. LASTKEY()=27
   USE &SHAR2 INDEX &SHAR3
   RENUM_POSICAO++
   MOSTRALINHA++
   GOTO RENUM_POSICAO    

   LECAD()
   @ 07,03 SAY "Nº"  
   @ 07,08 SAY "NOME"
   @ 07,28 SAY "NOVO N§"
   @ 07,33 SAY "Historicos"
   @ 07,43 SAY "H.Declar."
   @ 07,52 SAY "Docs cobrança"

   if mostralinha>22
      mostralinha=8
   endif  
   @ mostralinha,03 GET VC_NUMERO PICT ("9999") 
   @ mostralinha,08 SAY SUBSTR(VC_NOME,1,18)     && AQUI LINHA 1029
   @ mostralinha,28 GET VC_NOVONUM
   CLEAR GETS
   INKEY(0.1)
   IF LASTKEY()=27
      LOOP
   ENDIF 
   V2_NUMERO=VC_NOVONUM
   FIND &V2_NUMERO
   IF FOUND() 
      AVISONAOPARA("NUMERO JÁ EXISTE, NAO E POSSIVEL DUAS EMPRESAS COM MESMO NUMERO")
      LOOP
   ELSEIF V2_NUMERO=0
      AVISONAOPARA("EMPRESA COM NOVO NUMERO = 0!, NAO FOI MODIFICADA")
      LOOP
   ENDIF
   FIND &VC_NUMERO
   IF RLOCK()
      REPLACE C_NUMERO WITH V2_NUMERO
      REPLACE C_NOVONUM WITH VC_NUMERO
      REPLACE C_ATUALIZA WITH DATE()
   ELSE
      AVISO("FLOCK - OUTRO USUARIO")
      LOOP
   ENDIF
   USE &SHAR8 EXCLUSIVE
   INDEX ON H_NUMEMP TO &SHAR9
   COUNT TO VARIAVEL FOR H_NUMEMP=VC_NUMERO
   @ 24,03 SAY "Voce tem "+str(variavel)+" historico(s) a alterar"
   GOTO TOP
   XI=1
   XYX=0
   DO WHILE .NOT. EOF()
      IF H_NUMEMP=VC_NUMERO
         XYX++
         Replace H_NUMEMP WITH V2_NUMERO
         @ 24,40 SAY STR(XYX)+"§) "+H_DESCR+"-"+H_EVENTO
         @ mostralinha,33 say xyx 
         INKEY(0.1)
         GOTO TOP
      ENDIF
      SKIP +1
      XI++
   ENDDO
   USE &SHAR18 EXCLUSIVE
   goto top
   INDEX ON H_NUMEMP TO &SHAR19
   COUNT TO VARIAVEL FOR H_NUMEMP=VC_NUMERO
   @ 24,03 SAY "Voce tem "+str(variavel)+" listagem(s) de declaracoes a alterar"
   SET FILTER TO H_NUMEMP=VC_NUMERO
   GOTO TOP
   XI=1
   XYX=0
   DO WHILE .T. 
*      IF H_NUMEMP=VC_NUMERO
         XYX++
         Replace H_NUMEMP WITH V2_NUMERO
         @ 24,40 SAY STR(XYX)+"§) "+DTOC(H_DATA)+"-"+H_DESCR
         @ mostralinha,43 say xyx  
         INKEY(0.1)
         *GOTO TOP
*      ENDIF
      XI++
      if eof()
         exit
      endif
      SKIP +1

   ENDDO
   ********ALTERA NO BRS
   USE &SHAR14 EXCLUSIVE
   INDEX ON R_NUMEMP TO &SHAR15
   COUNT TO TOTALREG
   COUNT TO VARIAVEL FOR R_NUMEMP=VC_NUMERO
   @ 24,03 SAY "Voce tem "+str(variavel)+" doc(s) do Brs a alterar"
   SET FILTER TO R_NUMEMP=VC_NUMERO
   GOTO TOP
   XI=1
   XYX=0
   DO WHILE .NOT. EOF()
      XI++  
      IF R_NUMEMP=VC_NUMERO
         XYX++
         Replace R_NUMEMP WITH VAL(ALLTRIM(STR(V2_NUMERO)))
         @ 24,40 SAY STR(XYX)+"§) "+SUBSTR(R_NOME,1,18)+"-"+DTOC(R_DATADO)
         @ mostralinha,52 say xyx
         INKEY(0.1)
         GOTO TOP
      ENDIF
      SKIP +1
   ENDDO
   INKEY(0.1)
   LOOP

ENDDO
RETURN(.t.)

