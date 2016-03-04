***************************
FUNCTION LISTAS_IMPR()
***************************
EMP1:=VAL("0000")
EMP2:=VAL("9999")

DECLARE VETIMPR1[8],VETIMPR2[3],VETIMPR3[3],VETIMPR4[3]
VETIMPR1[1]="Campos Adicionais:"
VETIMPR1[2]=" Nenhum                 "
VETIMPR1[3]=" Endereco Completo      "
VETIMPR1[4]=" Fone / Fax             "
VETIMPR1[5]=" CNPJ  , CGC/TE, CGC/PM "
VETIMPR1[6]=" E-mail e HP            "
VETIMPR1[7]=" CNPJ+CPF Socio Respons."
VETIMPR1[8]=" Lista Decl.Anuais SRF  "
VETIMPR2[1]="Tipo de Espacamento"
VETIMPR2[2]=" Duplo (com linha divisoria) "
VETIMPR2[3]=" Simples (sem linha)         "
VETIMPR3[1]="Cabecalho"
VETIMPR3[2]=" Imprime     "
VETIMPR3[3]=" Nao Imprime "
VETIMPR4[1]="Separador"
VETIMPR4[2]=" Nao (normal)"
VETIMPR4[3]=" Sim (Excel) "

DO WHILE .T.
   ***** esta parte so pra impressao de listas
      borda(05,02,13,27,cor21)
      DO WHILE .T.
         @ 05,06 SAY    VETIMPR1[1]
         @ 06,03 PROMPT VETIMPR1[2]
         @ 07,03 PROMPT VETIMPR1[3]
         @ 08,03 PROMPT VETIMPR1[4]
         @ 09,03 PROMPT VETIMPR1[5]
         @ 10,03 PROMPT VETIMPR1[6]
         @ 11,03 PROMPT VETIMPR1[7]
         @ 12,03 PROMPT VETIMPR1[8]
         MENU TO TIPO5
         IF LASTKEY()=27
            RETURN(.T.)
         ENDIF
         SET COLOR TO &COR10
         @ 05+TIPO5,03 SAY VETIMPR1[TIPO5+1]
         SET COLOR TO &COR11
         DO WHILE .T.
            borda(05,38,08,68,cor21)
            @ 05,44 SAY    VETIMPR2[1]
            @ 06,39 PROMPT VETIMPR2[2]
            @ 07,39 PROMPT VETIMPR2[3]
            MENU TO TIPO9
            IF LASTKEY()=27
               @ 06,39 SAY VETIMPR2[2]
               @ 07,39 SAY VETIMPR2[3]
               EXIT
            ENDIF
            SET COLOR TO &COR10
            @ 05+TIPO9,39 SAY VETIMPR2[TIPO9+1]
            SET COLOR TO &COR11
            
            DO WHILE .T.
               borda(10,38,13,52,cor21)
               @ 10,42 SAY    VETIMPR3[1]
               @ 11,39 PROMPT VETIMPR3[2]
               @ 12,39 PROMPT VETIMPR3[3]
               MENU TO TIPO10
               IF LASTKEY()=27
                  @ 11,39 SAY VETIMPR3[2]
                  @ 12,39 SAY VETIMPR3[3]
                  EXIT
               ENDIF
               SET COLOR TO &COR10
               @ 10+TIPO10,39 SAY VETIMPR3[TIPO10+1]
               SET COLOR TO &COR11
               
               DO WHILE .T.
                  borda(10,56,13,70,cor21)
                  @ 10,60 SAY    VETIMPR4[1]
                  @ 11,57 PROMPT VETIMPR4[2]
                  @ 12,57 PROMPT VETIMPR4[3]
                  MENU TO TIPO11
                  IF !LASTKEY()=27
                     SET COLOR TO &COR10
                     @ 10+TIPO11,57 SAY VETIMPR4[TIPO11+1]
                     SET COLOR TO &COR11
                    ELSE
                     SET COLOR TO &COR11
                     @ 11,57 SAY VETIMPR4[2]
                     @ 12,57 SAY VETIMPR4[3]
                  ENDIF 
                  EXIT
               ENDDO
               IF LASTKEY()=13
                  EXIT
               ENDIF
            ENDDO
            IF LASTKEY()=13
               EXIT
            ENDIF
         ENDDO
         IF LASTKEY()=13
            EXIT
         ENDIF
      ENDDO

   DO CASE
      CASE TIPO5=1 .AND. TIPO11=1
         QUAL="Num. Nome da Empresa"
      CASE TIPO5=2 .AND. TIPO11=1
         QUAL="Num. Nome da Empressa"+space(39)+"Endereco"
      CASE TIPO5=3 .AND. TIPO11=1
         QUAL="Num. Nome da Empressa"+space(42)+"Telefone"+space(14)+"Fone/Fax"
      CASE TIPO5=4 .AND. TIPO11=1
         QUAL="Num. Nome da Empresa"+space(48)+"C.N.P.J."+space(15)+"Insc.Estadual   Insc.Municipal"
      CASE TIPO5=5 .AND. TIPO11=1
         QUAL="Num. Nome da Empresa"+space(29)+"E-Mail"+space(35)+"Home Page (Sitio) ou E-mail"
      CASE TIPO5=6 .AND. TIPO11=1
         QUAL="Num. Nome da Empresa"+space(40)+"    CNPJ            CPF      Socio Responsavel"
      CASE TIPO5=7 .AND. TIPO11=1
         QUAL="Num. Nome da Empresa"+space(40)+"    DIPJ           DSPJ      PJ-Inativa"
      CASE TIPO5=1 .AND. TIPO11=2
         QUAL="Num.;Nome da Empresa"
      CASE TIPO5=2 .AND. TIPO11=2
         QUAL= "Num.;Nome da Empresa;Endereco;Bairro;Cidade;UF;C.E.P."
      CASE TIPO5=3 .AND. TIPO11=2
         QUAL= "Num.;Nome da Empressa;Telefone;Fone/Fax"
      CASE TIPO5=4 .AND. TIPO11=2
         QUAL="Num.;Nome da Empresa;C.N.P.J.;Insc.Estadual;Insc.Municipal"
      CASE TIPO5=5 .AND. TIPO11=2
         QUAL="Num.;Nome da Empresa;E-mail;Home Page (Sitio) ou E-mail"
      CASE TIPO5=6 .AND. TIPO11=2
         QUAL="Num.;Nome da Empresa;CNPJ;CPF;Socio"
      CASE TIPO5=7 .AND. TIPO11=2
         QUAL="Num.;Nome da Empresa;DIPJ;DSPJ;PJ-Inativa"
         
   ENDCASE
   BORDA(19,38,22,62,cor21)
   @ 20,40 SAY "DA EMPRESA....: " GET EMP1
   @ 21,40 SAY "ATE A EMPRESA.: " GET EMP2
   READ
   IF LASTKEY()=27
      @ 04,02 CLEAR TO 23,78
      KEYB CHR(13)+CHR(13)+CHR(13)
      LOOP
   ENDIF

      IF MDIMP99=6
         IMPLPT=DIRECPASTIMP(1)
      ELSEIF MDIMP99=7
         IMPLPT=DIRECPASTIMP(2)
      ENDIF
   DO WHILE .T.
      AVISO5("LIGUE A IMPRESSORA - <ENTER> IMPRIME   <ESC> RETORNA",implpt)
      IF LASTKEY()=4 .OR. LASTKEY()=5 
         IF MDIMP99=7
            MDIMP99=1
         ELSE
            MDIMP99++
         ENDIF
         IF MDIMP99=1 
	    IMPLPT=ALLTRIM(MDIMP1)
         ELSEIF MDIMP99=2 
	    IMPLPT=ALLTRIM(MDIMP2)
         ELSEIF MDIMP99=3 
	    IMPLPT=ALLTRIM(MDIMP3)
         ELSEIF MDIMP99=4 
	    IMPLPT=ALLTRIM(MDIMP4)
         ELSEIF MDIMP99=5 
	    IMPLPT=ALLTRIM(MDIMP5)
	 ELSEIF MDIMP99=6
            IMPLPT=DIRECPASTIMP(1)
         ELSEIF MDIMP99=7
            IMPLPT=DIRECPASTIMP(2)
         ENDIF
         LOOP
      ELSEIF LASTKEY()=19 .OR. LASTKEY()=24
         IF MDIMP99=1
            MDIMP99=7
         ELSE
            MDIMP99--
         ENDIF
         IF MDIMP99=1 
	    IMPLPT=ALLTRIM(MDIMP1)
         ELSEIF MDIMP99=2 
	    IMPLPT=ALLTRIM(MDIMP2)
         ELSEIF MDIMP99=3 
	    IMPLPT=ALLTRIM(MDIMP3)
         ELSEIF MDIMP99=4 
	    IMPLPT=ALLTRIM(MDIMP4)
         ELSEIF MDIMP99=5 
	    IMPLPT=ALLTRIM(MDIMP5)
	 ELSEIF MDIMP99=6
            IMPLPT=DIRECPASTIMP(1)
         ELSEIF MDIMP99=7
            IMPLPT=DIRECPASTIMP(2)
         ENDIF
         LOOP
      ENDIF
       EXIT
   ENDDO   


   IF LASTKEY()=27
      @ 04,02 CLEAR TO 23,78
      LOOP
   ENDIF
      SET PRINTER TO &IMPLPT
      SET PRINTER ON
      SET DEVICE TO PRINT
      
      USE &shar2 INDEX &shar3

      IF TIPO11=1
         @ PROW(),PCOL() SAY CHR(15)
      ENDIF

      GOTO TOP
      LOCATE FOR C_NUMERO>=EMP1
      I=5

      IF TIPO11=2
         I=1 
      ENDIF

      IF TIPO10=1
         IMPR_CABEC1(1,1,QUAL,132)
        ELSE 
         IMPR_CABEC1(0,0,QUAL,132)
      ENDIF

      DO WHILE !EOF() .AND. C_NUMERO<=EMP2
         I++
         IF TIPO9=1 
            I++
         ENDIF
         imprime_linha(i,tipo5,tipo9,132)
         SKIP+1
         IF PROW() > 56
            IF TIPO10=1
               IMPR_CABEC1(1,1,QUAL,132)
               I=5
            ENDIF
         ENDIF
      ENDDO
      IF TIPO11=1
         EJECT
      ENDIF
      SET PRINTER TO
      SET PRINTER OFF
      SET DEVICE TO SCREEN
      AVISO("Relatorio impresso em "+implpt)

      @ 04,02 CLEAR TO 23,78
ENDDO

RETURN(.T.)



***************************
FUNCTION IMPR_TIPOS(TIPO1)
***************************
DO WHILE .T. 
******** esta parte so para impressao configurada
IF TIPO1=3
   DO While .t.
      @ 05,02 TO 08,34 
      @ 06,03 prompt "Impressao normal (80 col.)"
      @ 07,03 prompt "Impressao comprimida (132 col.)"
      MENU TO IMPR1
      IF LASTKEY()=27
         @ 10,45 CLEAR TO 13,77
         RETURN(.T.)
      ENDIF
      IF IMPR1=1
         TOTCOL=80
      ELSE
         TOTCOL=132
      ENDIF      
      @ 10,30 SAY "Escolher as colunas "
      somat=2
      DECLARE vetor_do_for[8]
      FOR n=1 to 8
          V_ESC_NUM[N]=NIL
      NEXT n
      FOR n=1 to 8
          @ 11+n,30 SAY "Col "+ alltrim(STR(N)) + chr(175)
          ESC_COL1=ESCOLHA_PESQUISA(10,04,0)
          IF LASTKEY()=27
             @ 10,04 CLEAR TO 23,78
             EXIT
          ENDIF
          Somat=somat+V_ESC_TAM[ESC_COL1]+2
          IF somat>TOTCOL
             exit
          ENDIF
          vetor_do_for[n]=V_ESC_PESQ[ESC_COL1]
          V_ESC_NUM[N]=ESC_COL1
          @ 11+n,37 SAY V_ESC_PESQ[ESC_COL1]
      NEXT
      IF lastkey()=27
         *loop
      ENDIF
      FOR n=1 to 8
          IF !vetor_do_for[n]=NIL
             @ 11+n,37 say vetor_do_for[n]
          ELSE
             @ 11+n,37 say space(10)
          ENDIF
      NEXT N
      EXIT
   ENDDO
   IF LASTKEY()=27
   *   loop
   ENDIF
   @ 22,47 say "continuar... ou <ESC> voltar"
   inkey(0)
   IF lastkey()=27
      IF IMPR1=1
         keyb CHR(13)+"T"+chr(13)
      ELSE
         keyb CHR(13)+"T"+chr(5)+chr(13)
      ENDIF 
      LOOP
   ENDIF
   borda(05,38,08,68,cor21)
   @ 05,44 SAY    "Tipo de Espacamento"
   @ 06,39 PROMPT " Duplo (com linha divisoria) "
   @ 07,39 PROMPT " Simples (sem linha)         "
   MENU TO TIPO9
         
   borda(10,38,13,52,cor21)
   @ 10,42 SAY    "Cabecalho"
   @ 11,39 PROMPT " Imprime     "
   @ 12,39 PROMPT " Nao Imprime "
   MENU TO TIPO10
   ENDIF
         
   IMPRESSAO(TIPO1)
   IF LASTKEY()=27 .AND. TIPO1=2
      RETURN(.T.)       
   ENDIF
    LOOP
ENDDO
RETURN(.T.)
      
**************************
FUNCTION IMPRESSAO(TIPO1)
**************************
EMP1:=VAL("0000")
EMP2:=VAL("9999")
Borda(19,38,22,62,cor21)
@ 20,40 SAY "DA EMPRESA....: " GET EMP1
@ 21,40 SAY "ATE A EMPRESA.: " GET EMP2
READ
AVISO("LIGUE A IMPRESSORA - <ENTER> IMPRIME   <ESC> RETORNA")
IF LASTKEY()=27
   @ 04,02 CLEAR TO 23,78   
   RETURN(.T.) 
ENDIF
USE &shar2 INDEX &shar3
*     VAR=ESCOLHA_PESQUISA(02,15,0)
*      IF !LASTKEY()=27
*         ORGANIZAPESQ(var)
*      ENDIF 
IF MDIMP99=6
         IMPLPT=DIRECPASTIMP(1)
      ELSEIF MDIMP99=7
         IMPLPT=DIRECPASTIMP(2)
      ENDIF
      SET PRINTER TO &IMPLPT
      SET PRINTER ON
      SET DEVICE TO PRINT
      
      @ PROW(),PCOL() SAY CHR(15)
      GOTO TOP
      LOCATE FOR C_NUMERO>=EMP1
      IF TIPO1=1
         I=5
         IF TIPO10=1
            IMPR_CABEC1(1,0,QUAL,132)
         ENDIF
         DO WHILE !EOF() .AND. C_NUMERO<=EMP2
            I++
            IF TIPO9=1 
               I++
            ENDIF
            	    imprime_linha(i,tipo5,tipo9,132)
            SKIP+1
            IF PROW() > 56
               IMPR_CABEC1(1,1,QUAL,132)
               I=5
            ENDIF
         ENDDO
      ELSEIF TIPO1=2
         DO WHILE !EOF() .AND. C_NUMERO<=EMP2
            IMPRIME_REGISTRO()
            SKIP+1
         ENDDO
      ELSEIF TIPO1=3
         @ PROW(),PCOL() SAY CHR(15)
         INDEX ON C_NUMERO TO &shar3
         GOTO TOP
         LOCATE FOR C_NUMERO>=EMP1
         I=5
         IF TIPO10=1
            
            IF IMPR1=2
               IMPR_CABEC(1,0,QUAL,132)
            ELSEIF IMPR1=1
               IMPR_CABEC1(1,1,QUAL,80)
            ENDIF
         ENDIF
         cont_col=0
         FOR N=1 TO 8
         IF !v_esc_num[n]=NIL 
            @ 00+i,02+CONT_COL SAY V_ESC_PESQ[V_ESC_NUM[N]]
                    CONT_COL=CONT_COL+V_ESC_TAM[V_ESC_NUM[N]]+2
         	        ENDIF
      NEXT N
      	        DO WHILE !EOF() .AND. C_NUMERO<=EMP2
      	            I++
      	            IF TIPO9=1 
      	               I++
      	            ENDIF
      		ALIMENTA_VETOR_PESQ()
      	CONT_COL=0
      	        FOR N=1 TO 8
      	IF !v_esc_num[n]=NIL 
      	           @ 00+i,02+CONT_COL SAY V_CAMPO_PESQ[V_ESC_NUM[N]]
      		   CONT_COL=CONT_COL+V_ESC_TAM[V_ESC_NUM[N]]+2
      	        ENDIF
      		NEXT N
      	            SKIP+1
      	            IF PROW() > 56
      	               EJECT
      	               @ 01,01 SAY REPL("-",130)
      	               @ 02,23 SAY "CADASTRO DE CLIENTES DA RIMAX"
      	               @ 02,122 SAY DATE()
      	               @ 03,01 SAY REPL("-",130)
      	               I=5
      		    ENDIF
      	         ENDDO
      	      ENDIF
      eject
      SET PRINTER TO
      SET PRINTER OFF
      SET DEVICE TO SCREEN
      @ 04,02 CLEAR TO 23,78
      
      RETURN(.T.)
      
      *************************************
      FUNCTION IMPR_CABEC1(XX1,XX2,QUAL,LARGURA)
      *************************************
      **
      **   XX1  => IMPRIME O CABECALHO {0,1}
      **   XX2  => SALTO DE PAGINA     {0,1}
      **   QUAL => Tipo de cabecalho   {   }
      
      
       IF XX1=1
         *IF XX2=1
         *   EJECT
         *ENDIF
         
         @ 01,00 SAY REPL("-",LARGURA-1)+"+"
         @ 02,23 SAY "CADASTRO DE CLIENTES DA RIMAX"
         @ 02,LARGURA-16 SAY "|"+DTOC(DATE())+" "+SUBSTR(TIME(),1,5)+"|"
         @ 03,21 SAY " +-------------------------------+ "
         @ 03,LARGURA-16 SAY "+--------------+"
         **** IMPRIMIR A PARTE DOS TITULOS
         IF !EMPTY(QUAL)
            @ 05,01 SAY QUAL
            @ 06,00 SAY REPL("-",LARGURA)
            @ 07,00 SAY " "
         ENDIF
       ELSE
         IF !EMPTY(QUAL) 
            @ 00,01 SAY QUAL
         ENDIF
       ENDIF

     RETURN(.T.)
      
      
      ******************************
      FUNCTION IMPRIME_LINHA(XX,YY,ZZ,LARGURA) && XX E' LINHA, YY E' TIPO , ZZ E' A LINHA SEPARADORA
      ******************************   && TIPO11 E' REF.AO SEPARADOR EXCEL (;)
      IF TIPO11=1
         SEPARA=" "
      ELSEIF TIPO11=2
         SEPARA=";"
      ENDIF
      
      IF YY=1                               && So' Numero e nome
         @ XX+0,00 SAY C_NUMERO
         @ XX+0,05 SAY SEPARA+alltrim(C_NOME)
         IF ZZ=1
            @ XX+1,00 SAY REPL("-",LARGURA)
         ENDIF
      ELSEIF YY=2                          && Numero, nome e endereco completo   
         IF TIPO11=1                       
            @ XX+0,00 SAY C_NUMERO
            @ XX+0,06 SAY alltrim(C_NOME)
            @ XX+0,61 SAY C_ENDER
            @ XX+1,61 SAY "Bairro:"+C_BAIRRO+"  -  "+alltrim(C_CIDADE)+"/"+alltrim(C_UF)+"  -  CEP:"+C_CEP
            IF ZZ=1
               @ XX+2,00 SAY REPL("-",LARGURA)
            ENDIF
         ELSE
            @ XX+0,00 SAY ALLTRIM(STR(C_NUMERO))+SEPARA+alltrim(C_NOME)+SEPARA+C_ENDER+SEPARA+C_BAIRRO+SEPARA+alltrim(C_CIDADE)+"/"+alltrim(C_UF)+SEPARA+C_CEP
            IF ZZ=1
               @ XX+1,00 SAY REPL("-",LARGURA)
            ENDIF
         ENDIF
         I++
      ELSEIF YY=3
         @ XX+0,00 SAY C_NUMERO
         @ XX+0,05 SAY SEPARA+alltrim(C_NOME)
         @ XX+0,63 SAY SEPARA+C_Fone+SEPARA+space(5)+SEPARA+C_fax
         IF ZZ=1
            @ XX+1,00 SAY REPL("-",LARGURA)
         ENDIF
      ELSEIF YY=4
         @ XX+0,00 SAY C_NUMERO
         @ XX+0,05 SAY SEPARA+alltrim(C_NOME)
         @ XX+0,66 SAY SEPARA+C_CGCMF+space(4)+SEPARA+C_CGCTE+space(4)+SEPARA+C_CGCPM
         IF ZZ=1
            @ XX+1,00 SAY REPL("-",LARGURA)
         ENDIF
      ELSEIF YY=5
         @ XX+0,00 SAY C_NUMERO
         @ XX+0,05 SAY SEPARA+substr(alltrim(C_NOME),1,40)
         @ XX+0,49 SAY SEPARA+C_EMAIL+SEPARA+C_HP
         IF ZZ=1
            @ XX+1,00 SAY REPL("-",LARGURA)
         ENDIF
      ELSEIF YY=6
         @ XX+0,00 SAY C_NUMERO
         DO CASE
         CASE C_TIPO1="1"
            @ XX+0,05 SAY SEPARA+substr(alltrim(C_NOME),1,50)+separa
            @ XX+0,59 SAY C_CGCMF+SEPARA+C_CPF1+SEPARA+C_nome1
         CASE C_TIPO1="2"
            @ XX+0,05 SAY SEPARA+substr(alltrim(C_NOME),1,50)+separa
            @ XX+0,59 SAY C_CGCMF+SEPARA+C_CPF2+SEPARA+C_nome2
         CASE C_TIPO1="3"
            @ XX+0,05 SAY SEPARA+substr(alltrim(C_NOME),1,50)+separa
            @ XX+0,59 SAY C_CGCMF+SEPARA+C_CPF3+SEPARA+C_nome3
         CASE C_TIPO1="4"
            @ XX+0,05 SAY SEPARA+substr(alltrim(C_NOME),1,50)+separa
            @ XX+0,59 SAY C_CGCMF+SEPARA+C_CPF4+SEPARA+C_nome4
         CASE C_TIPO1="5"
            @ XX+0,05 SAY SEPARA+substr(alltrim(C_NOME),1,50)+separa
            @ XX+0,59 SAY C_CGCMF+SEPARA+C_CPF5+SEPARA+C_nome5
            OTHERWISE
            @ XX+0,05 SAY SEPARA+substr(alltrim(C_NOME),1,50)+separa
            @ XX+0,59 SAY C_CGCMF+SEPARA+SEPARA
         ENDCASE 
         IF ZZ=1
            @ XX+1,00 SAY REPL("-",LARGURA)
         ENDIF
      ELSEIF YY=7
         @ XX+0,00 SAY C_NUMERO
         @ XX+0,05 SAY SEPARA+substr(alltrim(C_NOME),1,40)
         @ XX+0,67 SAY c_DECL1
         @ XX+0,82 SAY c_DECL5
         @ XX+0,95 SAY c_DECL6

         IF ZZ=1
            @ XX+1,00 SAY REPL("-",LARGURA)
         ENDIF

      ENDIF
      RETURN(.T.)
      
      ***************************
      FUNCTION IMPRIME_REGISTRO()
      ***************************
      @ 01,01 SAY CHR(18)+REPL("-",79)
      @ 02,23 SAY "CADASTRO DE CLIENTES DA RIMAX"
      @ 02,71 SAY date()
      @ 03,01 SAY REPL("-",79)
      @ 04,02 SAY "NUMERO...:"  + STR(C_NUMERO) GET C_NUMERO
      @ 04,02 SAY "          "  + STR(C_NUMERO)
      @ 04,19 SAY "FANTASIA:"  + C_FANTASIA
      @ 04,19 SAY "         "  + C_FANTASIA
      @ 04,50 SAY "INGRESSO NA RIMAX (DIR):" + C_DIR
      @ 04,74 SAY C_DIR
      @ 06,02 SAY "NOME.....:" + C_NOME
      @ 06,02 SAY "          " + C_NOME
      @ 07,02 SAY "ENDERECO.:" + C_ENDER
      @ 07,02 SAY "          " + C_ENDER
      @ 08,02 SAY "CIDADE...:" + C_CIDADE
      @ 08,02 SAY "          " + C_CIDADE
      @ 08,36 SAY "UF:"        + C_UF
      @ 08,36 SAY "   "        + C_UF
      @ 08,59 SAY "FONE:"      + C_FONE
      @ 08,59 SAY "     "      + C_FONE
      @ 09,02 SAY "BAIRRO...:" + C_BAIRRO
      @ 09,02 SAY "          " + C_BAIRRO
      @ 09,36 SAY "C.E.P.:"    + C_CEP
      @ 09,36 SAY "       "    + C_CEP
      @ 09,59 SAY "FAX.:"      + C_FAX
      @ 09,59 SAY "     "      + C_FAX
      
      @ 11,02 SAY "C.Eletr:" + C_EMAIL
      @ 11,02 SAY "        " + C_EMAIL
      @ 11,54 SAY "H.P.:"  + C_HP
      @ 11,54 SAY "     "  + C_HP
      
      @ 13,10 SAY REPL("--",31)
      
      @ 15,02 SAY "CNPJ.....:" + C_CGCMF
      @ 15,02 SAY "          " + C_CGCMF
      @ 15,36 SAY "CGC/TE:"    + C_CGCTE
      @ 15,36 SAY "       "    + C_CGCTE
      @ 15,59 SAY "CGC/PM:"    + C_CGCPM
      @ 15,59 SAY "       "    + C_CGCPM
      
      
      @ 17,02 SAY "NIRC/ICRE:" + C_NIRC
      @ 17,02 SAY "          " + C_NIRC
      @ 17,34 SAY "DATA:"      + DTOC(C_DATA)
      @ 17,34 SAY "     "      + DTOC(C_DATA)
      @ 17,61 SAY "CAE/RS:"    + C_CAERS
      @ 17,61 SAY "       "    + C_CAERS
      
      
      @ 19,02 SAY "CNAE:"      + C_CNAE
      @ 19,02 SAY "     "      + C_CNAE
      @ 19,20 SAY "Nat.Juridica:" + C_NAT
      @ 19,20 SAY "             " + C_NAT
      @ 19,41 SAY "Org.Classe:" + C_ORG
      @ 19,41 SAY "           " + C_ORG
      @ 19,66 SAY "Data:" + C_DATAORG
      @ 19,66 SAY "     " + C_DATAORG
      
      @ 21,02 SAY "U.A.C....:" + C_UAC
      @ 21,02 SAY "          " + C_UAC
      @ 21,27 SAY "DATA:"      + DTOC(C_DATA_UAC)
      @ 21,27 SAY "     "      + DTOC(C_DATA_UAC)
      @ 21,42 SAY "N§ ORDEM: " + alltrim(STR(C_ORD_UAC))
      @ 21,42 SAY "        : " + alltrim(STR(C_ORD_UAC))
      @ 21,63 SAY "N§ FILIAIS: " + STR(C_FILIAL)
      @ 21,63 SAY "          : " + STR(C_FILIAL)
      
      @ 23,10 SAY REPL("--",31)
      
      *****************************************************
      VC_TOTAL=C_CAPIT1+C_CAPIT2+C_CAPIT3+C_CAPIT4
      VC_PERC1=C_CAPIT1*100/VC_TOTAL
      VC_PERC2=C_CAPIT2*100/VC_TOTAL
      VC_PERC3=C_CAPIT3*100/VC_TOTAL
      VC_PERC4=C_CAPIT4*100/VC_TOTAL
      VC_PERC5=100
      VC_NOME5="T O T A L"+REPL(".",37)+":"
      VC_PERC6="%"
      COMPOSICAO={"           ","Responsavel","Gerente    ","Quotista   ","Quotista Menor"}
      *****************************************************
      @ 25,01 SAY CHR(15)
      @ 25,03 SAY "Socio "+COMPOSICAO[VAL(c_tipo1)+1] 
      @ 25,24 SAY C_CPF1   PICT "999.999.999-99"
      @ 25,41 SAY C_NOME1  PICT "@!"
      @ 25,86 SAY C_CAPIT1 PICT "@e 999,999.99"
      @ 25,102 SAY VC_PERC1 PICT "@e 99.99%"
      
      @ 26,03 SAY "Socio "+COMPOSICAO[VAL(c_tipo2)+1] 
      @ 26,24 SAY C_CPF2   PICT "999.999.999-99"
      @ 26,41 SAY C_NOME2  PICT "@!"
      @ 26,86 SAY C_CAPIT2 PICT "@e 999,999.99"
      @ 26,102 SAY VC_PERC2 PICT "@e 99.99%"
      
      @ 27,03 SAY "Socio "+COMPOSICAO[VAL(c_tipo3)+1] 
      @ 27,24 SAY C_CPF3   PICT "999.999.999-99"
      @ 27,41 SAY C_NOME3  PICT "@!"
      @ 27,86 SAY C_CAPIT3 PICT "@e 999,999.99"
      @ 27,102 SAY VC_PERC3 PICT "@e 99.99%"
      
      
      @ 28,03 SAY "Socio "+COMPOSICAO[VAL(c_tipo4)+1] 
      @ 28,24 SAY C_CPF4   PICT "999.999.999-99"
      @ 28,41 SAY C_NOME4  PICT "@!"
      @ 28,86 SAY C_CAPIT4 PICT "@e 999,999.99"
      @ 28,102 SAY VC_PERC4 PICT "@e 99.99%"
      
      @ 28,84 SAY REPL("_",27)
      
      @ 29,24 SAY VC_NOME5  PICT "@!"
      @ 29,84 SAY VC_TOTAL PICT "@e 9,999,999.99"
      @ 29,101 SAY VC_PERC5 PICT "@e 999.99%"
      
      @ 30,01 SAY CHR(18)
      @ 31,10 SAY REPL("--",31)
      
      @ 33,02 SAY "OBJETO SOCIAL:"
      @ 33,02 SAY "______________"
      @ 34,02 SAY C_OBJETO1
      @ 35,02 SAY C_OBJETO2
      @ 36,02 SAY C_OBJETO3
      @ 37,02 SAY C_OBJETO4
      @ 38,02 SAY C_OBJETO5
      @ 40,47 SAY "Ultima atualizacao em " + dtoc(c_atualiza)
      
      @ 42,02 SAY REPL("_",76)
      @ 45,02 SAY REPL("_",76)
      @ 48,02 SAY REPL("_",76)
      @ 51,02 SAY REPL("_",76)
      @ 54,02 SAY REPL("_",76)
      @ 57,02 SAY REPL("_",76)
      
      
      
      EJECT
      
      RETURN(.T.)
      
      
      
      
      *****************************************************************************
      
      
      **************
      FUNC ETIQ()
      **************
      DO WHILE .T.
         USE &shar2 INDEX &shar3 exclusive
         CLEAR
         @ 00,00 TO 42,79 DOUBLE
         @ 02,01 TO 02,78 DOUBLE
         OLDCOR=SETCOLOR()
         CENTRA(01,"CADASTRO ---> CLIENTES RIMAX")
         SET COLOR TO &COR27
         CENTRA(03,"MODIFICACAO DAS EMPRESAS A IMPRIMIR - CAMPO LIST=01")
         SET COLOR TO &OLDCOR
         BROWSE(04,02,23,77)
         set key -1 to
         set key -2 to 
         
         CLEAR
         @ 00,00 TO 23,79 DOUBLE
         @ 02,01 TO 02,78 DOUBLE
         *   SET COLOR TO &COR1
         CENTRA(01,"CADASTRO ---> CLIENTES RIMAX")
         *   SET COLOR TO &COR2
         
         EMP1:=VAL("0000")
         EMP2:=VAL("9999")
         @ 08,02 SAY "LISTAGEM DE ETIQUETAS PARA MALA DIRETA"
         @ 10,02 SAY "DA EMPRESA....: " GET EMP1
         @ 11,02 SAY "ATE A EMPRESA.: " GET EMP2
         READ
         IF LASTKEY()=27
            EXIT
         ENDIF
         AVISO("LIGUE A IMPRESSORA - <ENTER> IMPRIME   <ESC> RETORNA")
         IF LASTKEY()=27
            EXIT
         ENDIF
         
         USE &shar2 exclusive
         INDEX ON C_NUMERO TO &shar3 FOR C_LIST="1 " .AND. C_NUMERO>=EMP1 .AND. C_NUMERO<=EMP2
         COUNT TO TAMANHO FOR C_NUMERO>=EMP1 .AND. C_NUMERO<=EMP2
         GOTO TOP
         IF MDIMP99=6
            IMPLPT=DIRECPASTIMP(1)
         ELSEIF MDIMP99=7
            IMPLPT=DIRECPASTIMP(2)
         ENDIF
         
         SET PRINTER TO &IMPLPT
         SET DEVICE TO PRINT
         SET PRINTER ON
         
         DECLARE MATRIZ_ETIQ[ TAMANHO , 6 ]
         
         FOR X=1 TO TAMANHO
            
            MATRIZ_ETIQ[ X , 1 ] := C_NOME      && 50
            MATRIZ_ETIQ[ X , 2 ] := C_ENDER     && 50
            MATRIZ_ETIQ[ X , 3 ] := C_BAIRRO    && 20
            MATRIZ_ETIQ[ X , 4 ] := C_CEP       && 10
            
            VAR_TEMP=ALLTRIM(C_CIDADE)+"/"+ALLTRIM(C_UF)
            MATRIZ_ETIQ[ X , 5 ] := VAR_TEMP+SPACE( 23-LEN(VAR_TEMP) )
            SKIP +1
         NEXT X
         
         FOR X=1 TO TAMANHO-1 STEP 2
            @ PROW()+01,00 SAY MATRIZ_ETIQ[ X+0 , 1]
            @ PROW()+00,60 SAY MATRIZ_ETIQ[ X+1 , 1]
            
            @ PROW()+01,00 SAY MATRIZ_ETIQ[ X+0 , 2]
            @ PROW()+00,60 SAY MATRIZ_ETIQ[ X+1 , 2]
            
            @ PROW()+01,00 SAY "BAIRRO: "+MATRIZ_ETIQ[ X+0 , 3]
            @ PROW()+00,60 SAY "BAIRRO: "+MATRIZ_ETIQ[ X+1 , 3]
            
            @ PROW()+01,00 SAY MATRIZ_ETIQ[ X+0 , 5]
            @ PROW()+00,25 SAY MATRIZ_ETIQ[ X+0 , 4]
            @ PROW()+00,60 SAY MATRIZ_ETIQ[ X+1 , 5]
            @ PROW()+00,85 SAY MATRIZ_ETIQ[ X+1 , 4]
            
            @ PROW()+02,00 SAY ""
         NEXT X
         SET DEVICE TO SCREEN
         SET PRINTER OFF
      ENDDO
      RETURN(.T.)
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      *************************
      FUNCTION ESCOLHA_PESQUISA()
      *************************
      AS=0
      PARA LINHA,COLUNA,AS
      SAVE SCREEN
      OLDCOR=SETCOLOR()
      SET COLOR TO &COR27
      IF AS=0
         @ 23,30 say "LARGURA:"
      ENDIF
      @ LINHA-1,COLUNA-1 clear TO LINHA+12,COLUNA+22
      @ LINHA-1,COLUNA-1 TO LINHA+12,COLUNA+22 DOUBLE
      IF AS=0
         FOR X=1 TO 12
            @ linha+X-1,coluna   PROMPT V_ESC_PESQ[X] MESSAGE alltrim(STR(V_ESC_TAM[X]))
         NEXT X
         FOR X=13 TO 23
            @ linha+X-13,coluna+12   PROMPT V_ESC_PESQ[X] MESSAGE alltrim(STR(V_ESC_TAM[X]))
         NEXT X
      ELSE
         FOR X=1 TO 12
            @ linha+X-1,coluna   PROMPT V_ESC_PESQ[X] 
         NEXT X
         FOR X=13 TO 24
            @ linha+X-13,coluna+12   PROMPT V_ESC_PESQ[X]
         NEXT X
         
      ENDIF
      MENU TO esc_pesq
      
      SET COLOR TO &OLDCOR
      
      RESTORE SCREEN
      IF LASTKEY()=27
         RETURN(1)
      ENDIF
      return(esc_pesq)
      ******************************
      FUNCTION ALIMENTA_VETOR_PESQ()
      *******************************
      V_CAMPO_PESQ[01]=C_NUMERO
      V_CAMPO_PESQ[02]=C_DIR
      V_CAMPO_PESQ[03]=c_atualiza
      V_CAMPO_PESQ[04]=C_FANTASIA
      V_CAMPO_PESQ[05]=C_NOME
      V_CAMPO_PESQ[06]=C_ENDER
      V_CAMPO_PESQ[07]=C_CIDADE
      V_CAMPO_PESQ[08]=C_UF
      V_CAMPO_PESQ[09]=C_BAIRRO
      V_CAMPO_PESQ[10]=C_CEP
      V_CAMPO_PESQ[11]=C_FONE
      V_CAMPO_PESQ[12]=C_FAX
      V_CAMPO_PESQ[13]=C_CGCMF
      V_CAMPO_PESQ[14]=C_CGCTE
      V_CAMPO_PESQ[15]=C_CGCPM
      V_CAMPO_PESQ[16]=C_NAT
      V_CAMPO_PESQ[17]=C_CNAE
      V_CAMPO_PESQ[18]=C_CAERS
      V_CAMPO_PESQ[19]=C_NIRC
      V_CAMPO_PESQ[20]=C_UAC
      V_CAMPO_PESQ[21]=C_FILIAL
      V_CAMPO_PESQ[22]=C_ORG
      V_CAMPO_PESQ[23]=C_EMAIL
      V_CAMPO_PESQ[23]=C_INATIVA
      V_CAMPO_PESQ[23]=C_PAGA

      RETURN(.T.)
      
      
      **************************
      function dataddmmm
      xxames={"jan","fev","mar","abr","mai","jun","jul","ago","set","out","nov","dez"}
      return(  substr(dtoc(date()),1,2) + xxames[val(substr( dtoc(date()),4,2) ) ] )
      
      ****************************
      
      ***********************
      FUNCTION DIRECPASTIMP()
      **********************
      PARA ITIPO
      IF ITIPO=1
         PASTINHA=MDIMP6
      ELSEIF ITIPO=2
         PASTINHA=MDIMP7
      ENDIF
      
      ei=0
      DO WHILE .T.
         EI++
         IMPLPT=ALLTRIM(PASTINHA)+dataddmmm()+"-"+REPL("0",2-LEN(ALLTRIM(STR(EI))))+ALLTRIM(STR(EI))+".TXT"
         IF FILE(implpt)
            IF EI=999
               AVISO("Cancelado: TEM ARQUIVOS DEMAIS NA PASTA")
               EXIT
            ELSEIF ei=998
               AVISO("Quase-Cancelado: Este e' o ultimo arquivo q cabe na pasta")
            ENDIF
            LOOP
         ELSE
            EXIT
         ENDIF
      ENDDO
      RETURN(IMPLPT)
