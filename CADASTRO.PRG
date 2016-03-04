*** Cadastro.prg
*** por Leonardo Mendes de Oliveira
***
*** 21 Arquivos PRG
*** 12 Arquivos DBF {4 de configuracao / 7 de sistema / 1 externo (maladir)}
*** xx Arquivos Ntx
*** 03 Diretorios   {Central     -> Copia Seguranca e Instalacao }
***                 {Por usuario -> Copia para Off-Line          }
***
***
***
***
****************************************************************************
***   Set's de declaracao de ambiente.
*** 
SET DATE FRENCH
SET DATE FORMAT TO "dd/mm/yy"
SET EXCLUSIVE OFF
SET PROCEDURE TO FUNC
SET PROCEDURE TO VGA
SET PROCEDURE TO CALCULOS
SET PROCEDURE TO FUNCUDFS
SET PROCEDURE TO CAD
SET PROCEDURE TO CADIMPR
SET PROCEDURE TO RCALC
SET PROCEDURE TO HISTOR
SET PROCEDURE TO matrizes\matrizes
SET EXACT ON
SET SCORE OFF
SET WRAP ON
SET MESSAGE TO 23 CENTER
SET CURSOR ON
VIDEO(24)

OFFLINE="ON"
PARA OFFLINE
IF OFFLINE="OFF" .OR. OFFLINE="off"
   OFFLINE=1
  ELSE
   OFFLINE=0
ENDIF

MUDIN=1
MDULTTELA=0

SET KEY -41 TO R_CALC()

***************************************************************************
********       CONFIGURACAO DE IMPRESSORAS        *********
mdimp1="LPT1"
mdimp2="\\contabil\epson            "
mdimp3="\\fiscal\epson300           "
mdimp4="\\pessoal\citzen            " 
mdimp5="c:\docume~1\user\desktop\ImprCad.txt        "
mdimp6="\docume~1\user\desktop\cdstr\             "
mdimp99=1

IF FILE("VARSCONF.MEM")
   RESTORE FROM VARSCONF.MEM ADDITIVE
ELSE
   AVISO("VarsConf.Mem nao encontrado - Assumir  valores padrao")
   mdc=1
   mdt=0
   mdimp1="LPT1"
   mdimp2="\\contabil\epson            "
   mdimp3="\\fiscal\epson300           "
   mdimp4="\\pessoal\citzen            " 
   mdimp5="c:\docume~1\user\desktop\ImprCad.txt        "
   mdimp6="c:\docume~1\user\desktop\cdstr\             "
   mdimp7="c:\rimax\impress\           "
   mdimp99=1
   SAVE ALL LIKE md* TO VARSCONF.MEM
ENDIF

VETORTEMP={MDIMP1,MDIMP2,MDIMP3,MDIMP4,MDIMP5,MDIMP6,mdimp7}
   IMPLPT="LPT1"
IF !MDIMP99=1 .AND. !MDIMP99=5 .AND. !MDIMP99=6 .AND. !MDIMP99=7
   IMPLPT="LPT1"
   ! net use lpt1: /delete >> nul
   IF MDIMP99=2
      ! net use lpt1: &MDIMP2 >> nul
   ELSEIF MDIMP99=3
      ! net use lpt1: &MDIMP3 >> nul
   ELSEIF MDIMP99=4
      ! net use lpt1: &MDIMP4 >> nul
   ENDIF
   IF MDIMP99=5
      IMPLPT=ALLTRIM(MDIMP5)
   ELSEIF MDIMP99=6
      IMPLPT=DIRECPASTIMP(1)
   ELSEIF MDIMP99=7
      IMPLPT=DIRECPASTIMP(2)
   ELSEIF MDIMP99=1
      IMPLPT="LPT1"
   ENDIF
ENDIF   

SET PRINTER TO &IMPLPT


******************************************************************************
**************   SERVIDOR E SEUS ARQUIVOS   ***************
PASTASERV="\\Contabil\C\RIMAX\"

SHAR2 =PASTASERV+"PROCONTA.DBF"
SHAR3 =PASTASERV+"PROCONTA.NTX"

IF (.NOT. FILE(SHAR2)) .AND. ( .NOT. NETNAME()="Contabil") .or. OFFLINE=1
   AVISO("Nao estou encontrando o SERVIDOR - Utilizar OFF-LINE? Digite <*>")
   IF chr(lastkey())="*" 
      AVISO("Operando OFF LINE - Vai mudar a cor quando off-line")
      AVISO("Use para consulta - as alteracoes nao serao gravadas no servidor!")
      PASTASERV="OFFLINE\"
   ELSE
      AVISO("Saindo")
      QUIT
   ENDIF
ENDIF

        SHAR2 =PASTASERV+"PROCONTA.DBF"
        SHAR3 =PASTASERV+"PROCONTA.NTX"
        
        SHAR4 =PASTASERV+"CORRGB.DBF"
        SHAR5 =PASTASERV+"CORRGB1.DBF"
        SHAR6 =PASTASERV+"arqcor.ntx"
        SHAR7 =PASTASERV+"cor.ntx"
        
        SHAR8 =PASTASERV+"histor.dbf"
        SHAR9 =PASTASERV+"histo0.ntx"
        SHAR10=PASTASERV+"histo1.ntx"
        SHAR11=PASTASERV+"histo2.ntx"
        SHAR12=PASTASERV+"procont1.ntx"
        SHAR13=PASTASERV+"proindif.ntx"
        SHAR14=PASTASERV+"brs.dbf"
        SHAR15=PASTASERV+"brsescol.ntx"
        SHAR16=PASTASERV+"brsgrava.ntx"
        SHAR18 =PASTASERV+"histdecl.dbf"
        SHAR19 =PASTASERV+"histdecl.ntx"
        
        SHAR21=PASTASERV+"TABELA.DBF"
        SHAR22=PASTASERV+"TABELA.NTX"
        SHAR23=PASTASERV+"JOTABAPTO.NTX"
        SHAR24=PASTASERV+"JOTABNOME.NTX"
        SHAR31=PASTASERV+"TITULOS.DBF"
        
        SHAR41=PASTASERV+"TABELA.SRC"
        SHAR42=PASTASERV+"TAB_APTO.NTX"
        SHAR43=PASTASERV+"TAB_BLOC.NTX"
        SHAR44=PASTASERV+"TAB_NOME.NTX"
        SHAR45=PASTASERV+"APTO_BLO.NTX"
        SHAR46=PASTASERV+"BLOCO.NTX"
        SHAR47=PASTASERV+"APTO.NTX"
        SHAR51=PASTASERV+"TITULOS.SRC"
        SHAR52=PASTASERV+"TITULOS.NTX"
        
        SHAR90=PASTASERV+"QualUser.dbf"
        SHAR91=PASTASERV+"QualUser.ntx"
        SHAR92=PASTASERV+"QUsEstat.ntx"


***************************************************************************
******** REGISTRO DE ENTRADA DE USUARIO      
***************************************************************************
IF FILE(SHAR91)
   USE &SHAR90 index &SHAR91
ELSE
   USE &SHAR90
   INDEX ON QNUM TO &SHAR91
ENDIF
GOTO LASTREC()
VQNUM=QNUM+1
GOTO TOP
APPEND BLANK
IF RLOCK()
   REPLACE QNUM    WITH VQNUM
   REPLACE Qnome   WITH alltrim(netname())
   REPLACE Qdataen WITH date()
   REPLACE Qhoraen WITH time()
   REPLACE Qcoment WITH space(30)
   COMMIT
ENDIF
***************************************************************************


*** DECLARACAO DOS VETORES ACHOICE *
************************************
FIM={"CONFIRMA"}
XFIM={"Confirma saida p/DOS"}

DECLARE PRO[5]
DECLARE XPRO[5]
        PRO[1]="Tapajos"
        PRO[2]="St.Joseph"
        PRO[3]="----"
        PRO[4]="Cobranca"
        PRO[5]="Renumera"
        XPRO[1]="CONDOMINIO TAPAJOS"
        XPRO[2]="CONDOMINIO ST.JOSEPH"
        XPRO[3]="----------"
        XPRO[4]="Impressao Cobranca Banrisul"
        XPRO[5]="Renumeracao total clientes rimax"

DECLARE BAN[9]
DECLARE XBAN[9]
        BAN[1]="Consulta"
        BAN[2]="Altera No."
        BAN[3]="Exclui"
        BAN[4]="--------"
        BAN[5]="Historico"
        BAN[6]="--------"
        BAN[7]="Declaracoes"
        BAN[8]="Grava Decl"
        BAN[9]="Quadro Decl"
        XBAN[1]="DIGITA/ALTERA CADASTRO RIMAX"
        XBAN[2]="CONSULTA HISTORICOS / EVENTOS "
        XBAN[3]="         "
        XBAN[4]="Altera no. empresa"
        XBAN[5]="Exclui empresa do cadastro"
        XBAN[6]="Declaracoes/Outros"
        XBAN[7]="Grava Evento de Entrega de Declara‡oes no Historico"
        XBAN[8]="Grava Evento de Entrega de Declara‡oes no Historico"
        XBAN[9]="Grava Evento de Entrega de Declara‡oes no Historico"

DECLARE IMPR[6]
DECLARE XIMPR[6]
        IMPR[1]="Listas"
        IMPR[2]="Fichas"
        IMPR[3]="Especial"
        IMPR[4]="Etiquetas"
        IMPR[5]="---------"
        IMPR[6]="Matrizes"
        XIMPR[1]="Imprime listas das empresas"
        XIMPR[2]="Imprime fichas (uma por empresa)"
        XIMPR[3]="Impressao Configurada"
        XIMPR[4]="Imprime etiquetas para colar em mala direta"
        XIMPR[5]=space(30)
        XIMPR[6]="Impressao de Matrizes"

DECLARE OPC[9]
DECLARE XOPC[9]
        OPC[1]="R.G.B."
        OPC[2]="Cores"
        OPC[3]="Usuarios"
        OPC[4]="Impressora"
        OPC[5]="-----------"
        OPC[6]="Calculadora"
        OPC[7]="Testa CNPJ"
        OPC[8]="Testa CPF"
        OPC[9]="Testa PIS"
        XOPC[1]="Configuracao e direcionamento de impressora"
        XOPC[2]="Codigo das cores dos programas - Para todos usuarios"
        XOPC[3]="Controle de entrada de usuario"
        XOPC[4]="Configuracao de impressora (direta, por rede, para arquivo, ou pasta)"
        XOPC[5]=" --------- "
        XOPC[6]="Calculadora" 
        XOPC[7]="Testa Codigo do CNPJ, digito-controle ou erro em algum digito"
        XOPC[8]="Nao disponivel"
        XOPC[9]="Nao disponivel"


OPCIMP={"Define Dispositivo Padrao","Troca nome dos dispositivos"}
xopcimp={"Define em qual dos dispositivos ira' direcionar a impressao","Define o nome dos arquivos/dispositivos de saida de impressao"}
XVARIA=" "

*** Vetores para udf do dbedit ref.Qualuser
*******************************************
vet_user={"QNUM","QNOME","QDATAEN","QDATASA","QHORAEN","QHORASA","QCOMENT"}
vet2user={"N§","Comput","DataEnt","DataSai","HoraEn","HoraSai","Coment"}

**********************************
**** VARIAVEIS DE COR, MENU, 
**********************************
OPCAO=0

IF mdc=1
   shar1=PASTASERV+"cormasc.dbf"
ELSE
   shar1=PASTASERV+"cormas2.dbf"
ENDIF
USE &shar1 SHARED
INDEX ON cor_num TO &shar6
goto top



COR1:=COR2:=COR3:=COR4:=COR5:=COR6:=COR7:=COR8:=COR9:=COR10:=" "
COR11:=COR12:=COR13:=COR14:=COR15:=COR16:=COR17:=COR18:=COR19:=COR20:=" "
COR21:=COR22:=COR23:=COR24:=COR25:=COR26:=COR27:=COR28:=COR29:=COR30:=" "

INICIA_COR()  && As variaveis acima vao assumir o padrao gravado
              && nos arquivos acima (cormasc, cormas2)

USE
*********************
* VARIAVEIS CADASTRO
********************
VC_NUMERO    =  VAL(SPACE(4))
VC_NOVONUM   =  VAL(SPACE(4))
VC_INATIVA   =  "N"
vc_paga      =  "N"
V2_NUMERO    =  VAL(SPACE(4))
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
VC_CNAE2     =  SPACE(10)
VC_CAERS     =  SPACE(11)
VC_FONE      =  SPACE(15)
VC_FAX       =  SPACE(15)
VC_TIPO      =  VAL("1")
VC_ATIVID    =  VAL("1")
VC_FEDERAL   =  VAL("1")
VC_ESTADUAL  =  VAL("1")
VC_MUNICIP   =  VAL("1")
VC_CPF1      =  SPACE(14)
VC_NOME1     =  SPACE(40)
VC_CPF2      =  SPACE(14)
VC_NOME2     =  SPACE(40)
VC_CPF3      =  SPACE(14)
VC_NOME3     =  SPACE(40)
VC_CPF4      =  SPACE(14)
VC_NOME4     =  SPACE(40)
VC_CPF5      =  SPACE(14)
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
VC_dataorg   =  CTOD(SPACE(8))
VC_NAT       =  SPACE(5)
VC_ATUALIZA  =  CTOD(SPACE(8))
ESC_COL1     =  0
SN           =  "S"

STORE SPACE(1) TO vc_decl1,vc_decl2,vc_decl3,vc_decl4,vc_decl5 
STORE SPACE(1) TO vc_decl6,vc_decl7,vc_decl8,vc_decl9,vc_decl10
STORE SPACE(1) TO vc_decl11,vc_decl12,vc_decl13,vc_decl14,vc_decl15
STORE SPACE(1) TO vc_decl16,vc_decl17,vc_decl18,vc_decl19,vc_decl20,vc_decl21,vc_decl22


**********
* VETORES
**********
V_ESC_PESQ={"N"+CHR(167),"D.I.R.","Atualiz.","N.Fantasia","Nome","Endereco","Cidade","UF","Bairro","Cep","Fone","Fax","CNPJ","CGC/T.E.","CGC/P.M.","N.Jur","CNAE","CAE/RS","N.I.R.C.","U.A.Contr.","Org clas","E-mail","Novo Num","pago"}
v_ESC_TAM={3,5,8,20,50,50,20,2,20,10,15,15,18,11,15,5,10,11,14,12,13,30,4,1}
DECLARE V_ESC_NUM[8]
DECLARE V_CAMPO_PESQ[26]
declare V_CPO_PQ[26]

*******************
** O PROGRAMA
*******************
set key -6 to mododetela()
set key -7 to mododecor()
VIDEO(24)
RGBPALETA(1,mdt)








KEYB CHR(4)+CHR(13)
DO WHILE .T.
   TELAPRI()
   SET COLOR TO &COR11
   @ 04,18 PROMPT "PROGRAMAS" MESSAGE "Titulos das tabelas"
   @ 04,34 PROMPT "BANCO DE DADOS" MESSAGE "Digitacao das tabelas"
   @ 04,55 PROMPT "RELATORIOS" MESSAGE "Impressao dos relatorios"
   @ 04,72 PROMPT "SAIR" MESSAGE "Retorno p/ o D.O.S."
   @ 04,03 PROMPT "OPCOES" MESSAGE "Opcoes"
   MENU TO OPCAO
   DO CASE

   ****** MENU PROGRAMAS *********
   CASE OPCAO=1
        CENTRA(23,XPRO[1])
        BORDA(05,19,11,29,COR5)
   	PROG=1
        A=ACHOICE(06,20,10,28,PRO,.T.,"FUNCA")
   	DO CASE
        CASE A=1
             set key -6 to
             set key -7 to 
             DO TAPAJ
             set key -6 to mododetela()
             set key -7 to mododecor()
             keyb chr(19)+chr(19)+chr(19)+chr(13)
        CASE A=2
             set key -6 to 
             set key -7 to 
             DO JO
             set key -6 to mododetela()
             set key -7 to mododecor()
             keyb chr(13)+chr(24)
        CASE A=3 
             keyb chr(13)+CHR(24)+CHR(24)
        CASE A=4
             SAVE SCREE
             @ 11,32 SAY "Prot..:" 
             inkey(0)
             IF LASTKEY()=36
                set key -6 to
                set key -7 to
                DO BRS.PRG
                set key -6 to mododetela()
                set key -7 to mododecor()
             ENDIF
             keyb chr(13)+CHR(5)
        CASE A=5
             RENUMERA_TOTAL()
   	ENDCASE
   
   ****** MENU BANCO DE DADOS *********   
   CASE OPCAO=2
   	PROG=2
   	CENTRA(23,XBAN[1])
        BORDA(05,35,15,47,COR5)
        A=ACHOICE(06,36,14,46,BAN,.T.,"FUNCA")
   	DO CASE
           CASE A=1
                set key -6 to
   		set key -7 to
                IF FILE(SHAR3)=.T.
                   USE &SHAR2 INDEX &SHAR3 SHARED
                ELSE
                   USE &SHAR2 SHARED
                   INDEX ON C_NUMERO TO &SHAR3
                ENDIF
                TELACAD()
   		set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)
           CASE A=2
   		set key -6 to
   		set key -7 to
   		ALTERA_NUM()
   		set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)+CHR(24)
           CASE A=3
   		set key -6 to 
   		set key -7 to 
   		EXCLUI_EMP()
   		set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)+CHR(24)+CHR(24)
           CASE A=4
                clear
   		set key -6 to 
   		set key -7 to
                IF FLOCK()
                   BROWSE()
                ELSE
                   AVISO("Arquivo travado pelo F_lock()")
                ENDIF
   		set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)
           CASE A=5
                set key -6 to
                set key -7 to
                TELAHISTORICO()
   		set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
           CASE A=7
                set key -6 to
   		set key -7 to
                CONSULTADH()
                set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)

           CASE A=8
                set key -6 to
   		set key -7 to
                DECLHISTO()
                set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
           CASE A=9
   		set key -6 to
   		set key -7 to
                TELADECL()
                set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
        ENDCASE

   ****** MENU RELATORIOS *********
   CASE OPCAO=3
   	DO WHILE .NOT. LASTKEY()=27
   	   PROG=3
   	   CENTRA(23,XIMPR[1])
   	   BORDA(05,56,12,66,COR5)
           A=ACHOICE(06,57,11,65,IMPR,.T.,"FUNCA") 
           DO CASE
   	      CASE A=1 .OR. A=2 .OR. A=3
   		set key -6 to
   		set key -7 to
                USE &SHAR2 index &SHAR3 SHARED
       		@ 04,02 CLEAR TO 23,78
                
       		IF A=1 
                    LISTAS_IMPR()
                    KEYB CHR(13)
   		ELSEIF A=2
                    IMPR_TIPOS(A)
   		    KEYB CHR(13)+CHR(24)
   		ELSEIF A=3
                    IMPR_TIPOS(A)
   		    KEYB CHR(13)+CHR(24)+CHR(24)
   		ENDIF
   		set key -6 to mododetela()
   		set key -7 to mododecor()
       	   CASE A=4
   		set key -6 to 
   		set key -7 to 
       	        ETIQ()
   		set key -6 to mododetela()
   		set key -7 to mododecor()
       		KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)
           CASE A=6
		set key -6 to 
		set key -7 to
                imprmatr()
                set key -6 to mododetela()
                set key -7 to mododecor()
    		KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)
           ENDCASE
           EXIT
   	ENDDO

   ****** MENU SAIR  *********
   
   CASE OPCAO=4
        PROG=4
        CENTRA(23,XFIM[1])
        BORDA(05,68,07,77,COR5)
        A=ACHOICE(06,69,06,76,FIM,.T.,"FUNCA")
        IF A=1
           BACKUP_OFFLINE_E_MEM()
           ! net use lpt1: /delete
           QUIT
        ENDIF

   ****** MENU OPCOES / OUTROS  *********
  
   CASE OPCAO=5
   	CENTRA(23,XOPC[1])
        BORDA(05,04,16,17,COR5)
   	PROG=5
        A=ACHOICE(06,05,15,16,OPC,.T.,"FUNCA")
   	DO CASE
   	   CASE A=1
   		set key -6 to 
   		set key -7 to 
                RGBPALETA(0,mdt)
   		set key -6 to mododetela()
   		set key -7 to mododecor()
                KEYB CHR(13)
   	   CASE A=2
   		set key -6 to 
   		set key -7 to 
                PALHET(MDT)
                IF mdc=1
                   shar1=PASTASERV+"cormasc.dbf"
                ELSE
                   shar1=PASTASERV+"cormas2.dbf"
                ENDIF
                USE &shar1 EXCLUSIVE
                INDEX ON cor_apli TO &shar7
                browse()
                RELER_COR(mdc)
   		set key -6 to mododetela()
   		set key -7 to mododecor()
   		KEYB CHR(13)+CHR(24)
   	   CASE A=3
                USE &SHAR90 INDEX &SHAR91
                CLEAR 
                DBEDIT(02,00,20,80,vet_user,"UDFDBUSER",,vet2user,"Í")
                IF FLOCK()
                    *BROWSE()
                ENDIF
                USE
                KEYB CHR(13)+CHR(24)+CHR(24)
           CASE A=4
                do configim.prg
           CASE A=5
		KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
	   CASE A=6
                R_CALC()
		KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
	   case a=7
                testa_cnpj(1)
		KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
           case a=8
                KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
           case a=9
                KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)+CHR(24)
        ENDCASE
ENDCASE


ENDDO
