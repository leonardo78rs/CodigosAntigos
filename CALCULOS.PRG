*FUNCOES DE CALCULOS/VERIFICACAO VARIAVEIS**
*
* VCPF(cpf)
* VCGC(cgc)
* V2CGC(cgc)
* TESTACNPJ(x)
* VALICGC(cgc)
*
***************************************
FUNCTION VCPF(cpf)
LOCAL i,ii,soma,controle,digito,num
***************************************
CPF=SUBSTR(CPF,1,3)+SUBSTR(CPF,5,3)+SUBSTR(CPF,9,3)+SUBSTR(CPF,13,2)


cpf = IF(VALTYPE(cpf)="U","",cpf)
IF EMPT(cpf)
    RETURN(.T.)
ELSE
    IF LEN(cpf) < 11
        RETURN(.F.)
    ENDIF
ENDIF
controle=""
num=10
FOR ii=1 TO 2
    soma=0
    FOR i=1 TO 9
        soma+=(VAL(SUBSTR(cpf,i,1))*num)
        num--
    NEXT
    IF ii=2
        soma+=(2*VAL(controle))
    ENDIF
    digito=soma - (INT(soma/11)*11)
    IF digito=0 .OR. digito=1
        controle=controle+"0"
    ELSE
        controle=controle+STR(11-digito,1)
    ENDIF
    num=11
NEXT
IF controle!=SUBST(cpf,10,2) .AND. .NOT. EMPTY(CPF)
    AVISO("CPF "+SUBSTR(CPF,1,9)+" NAO FECHA! DIGITO CERTO = "+CONTROLE)
    RETURN(.F.)
ENDIF
RETURN(.T.)

*************************************
FUNCTION VCGC(cgc)
LOCAL i,ii,soma,controle,digito,num
*************************************
CGC=SUBSTR(CGC,1,2)+SUBSTR(CGC,4,3)+SUBSTR(CGC,8,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)

cgc = IF(VALTYPE(cgc)="U","",cgc)
IF EMPT(cgc)
    RETURN(.T.)
ELSE
    IF LEN(cgc) < 14
        RETURN(.F.)
    ENDIF
ENDIF
controle=""
num=5
FOR ii=1 TO 2
    soma=0
    FOR i=1 TO 12
        soma+=(VAL(SUBSTR(cgc,i,1))*num)
        num--
        IF num=1
            num=9
        ENDIF
    NEXT
    IF ii=2
        soma+=(2*VAL(controle))
    ENDIF
    digito=soma - (INT(soma/11)*11)
    IF digito=0 .OR. digito=1
        controle=controle+"0"
    ELSE
        controle=controle+STR(11-digito,1)
    ENDIF
    num=6
NEXT
IF controle!=SUBST(cgc,13,2) 
    AVISO("CNPJ "+SUBST(CGC,1,8)+"/"+SUBST(CGC,9,4)+" INVALIDO, DIGITO CERTO = "+CONTROLE) 
    RETURN(.F.)
ENDIF
RETURN(.T.)

*************************************
FUNCTION V2CGC(cgc)
LOCAL i,ii,soma,controle,digito,num
*************************************
CGC=SUBSTR(CGC,1,2)+SUBSTR(CGC,4,3)+SUBSTR(CGC,8,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)

cgc = IF(VALTYPE(cgc)="U","",cgc)
IF EMPT(cgc)
    RETURN(.T.)
ELSE
    IF LEN(cgc) < 14
        RETURN(.F.)
    ENDIF
ENDIF
controle=""
num=5
FOR ii=1 TO 2
    soma=0
    FOR i=1 TO 12
        soma+=(VAL(SUBSTR(cgc,i,1))*num)
        num--
        IF num=1
            num=9
        ENDIF
    NEXT
    IF ii=2
        soma+=(2*VAL(controle))
    ENDIF
    digito=soma - (INT(soma/11)*11)
    IF digito=0 .OR. digito=1
        controle=controle+"0"
    ELSE
        controle=controle+STR(11-digito,1)
    ENDIF
    num=6
NEXT
IF controle!=SUBST(cgc,13,2) 
        RETURN(controle)
ENDIF
RETURN(.T.)

************************
FUNCTION testa_cnpj(x)
************************
save screen
*CLEAR
set color to &cor23
@ 05,17 clear to 18,78
VC_CGCMF=SPACE(18)
VETN={1,2,3,4,5,6,7,8,9,0}

do while .not. lastkey()=27
DECLARE VETOR_CNPJ[30,3]

FOR I=1 TO 10
    VETOR_CNPJ[I,1]=SPACE(14)    && CNPJ
    VETOR_CNPJ[I,2]=SPACE(1)     && SEQUENCIA DO CARACTER
    VETOR_CNPJ[I,3]=SPACE(1)     && VALOR DO NUMERO CERTO
NEXT
   @ 08,21 say space(25)
   @ 06,21 SAY "CNPJ.....:"  GET VC_CGCMF PICT "99.999.999/9999-99" 
   READ
   I=1
cgc=vc_cgcmf
CGC=SUBSTR(CGC,1,2)+SUBSTR(CGC,4,3)+SUBSTR(CGC,8,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)

   IF VALICGC(CGC)
      aviso("correto")
      loop
   ENDIF
   IF VALICGC(VC_CGCMF)=.F.
      
      @ 08,21 say "Digito correto = " + v2cgc(VC_CGCMF) + ", Ou.."

      FOR X=1 TO 10
       cgc=vc_cgcmf
       CGC=ALLTRIM(STR(VETN[X]))+SUBSTR(CGC,2,1)+SUBSTR(CGC,4,3)+SUBSTR(CGC,8,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)
       
       IF VALICGC(CGC)
          VETOR_CNPJ[I,1]=CGC
          VETOR_CNPJ[I,2]="1"
          VETOR_CNPJ[I,3]=STR(X)
          I++
          *AVISO(STR(I-1))
       ENDIF

      NEXT X


      FOR X=1 TO 10
cgc=vc_cgcmf
CGC=SUBSTR(CGC,1,1)+ALLTRIM(STR(VETN[X]))+SUBSTR(CGC,4,3)+SUBSTR(CGC,8,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)
       IF VALICGC(CGC)
          VETOR_CNPJ[I,1]=CGC
          VETOR_CNPJ[I,2]="2"
          VETOR_CNPJ[I,3]=STR(X)
          I++
          *AVISO(STR(I-1))
       ENDIF
      NEXT X

      FOR X=1 TO 10
cgc=vc_cgcmf
CGC=SUBSTR(CGC,1,2)+ALLTRIM(STR(VETN[X]))+SUBSTR(CGC,5,3)+SUBSTR(CGC,8,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)
       IF VALICGC(CGC)
          VETOR_CNPJ[I,1]=CGC
          VETOR_CNPJ[I,2]="3"
          VETOR_CNPJ[I,3]=STR(X)
          I++
          *AVISO(STR(I-1))
       ENDIF
      NEXT X

      FOR X=1 TO 10
cgc=vc_cgcmf
CGC=SUBSTR(CGC,1,2)+SUBSTR(CGC,4,1)+ALLTRIM(STR(VETN[X]))+SUBSTR(CGC,6,1)+SUBSTR(CGC,8,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)
       IF VALICGC(CGC)
          VETOR_CNPJ[I,1]=CGC
          VETOR_CNPJ[I,2]="4"
          VETOR_CNPJ[I,3]=STR(X)
          I++
          *AVISO(STR(I-1))
       ENDIF
      NEXT X

      FOR X=1 TO 10
cgc=vc_cgcmf
CGC=SUBSTR(CGC,1,2)+SUBSTR(CGC,4,2)+ALLTRIM(STR(VETN[X]))+SUBSTR(CGC,8,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)
       IF VALICGC(CGC)
          VETOR_CNPJ[I,1]=CGC
          VETOR_CNPJ[I,2]="5"
          VETOR_CNPJ[I,3]=STR(X)
          I++
          *AVISO(STR(I-1))
       ENDIF
      NEXT X

      FOR X=1 TO 10
cgc=vc_cgcmf
CGC=SUBSTR(CGC,1,2)+SUBSTR(CGC,4,3)+ALLTRIM(STR(VETN[X]))+SUBSTR(CGC,9,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)
       IF VALICGC(CGC)
          VETOR_CNPJ[I,1]=CGC
          VETOR_CNPJ[I,2]="6"
          VETOR_CNPJ[I,3]=STR(X)
          I++
          *AVISO(STR(I-1))
       ENDIF
      NEXT X

      FOR X=1 TO 10
cgc=vc_cgcmf
CGC=SUBSTR(CGC,1,2)+SUBSTR(CGC,4,3)+SUBSTR(CGC,8,1)+ALLTRIM(STR(VETN[X]))+SUBSTR(CGC,10,3)+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)
       IF VALICGC(CGC)
          VETOR_CNPJ[I,1]=CGC
          VETOR_CNPJ[I,2]="7"
          VETOR_CNPJ[I,3]=STR(X)
          I++
          *AVISO(STR(I-1))
       ENDIF
      NEXT X

      FOR X=1 TO 10
cgc=vc_cgcmf
CGC=SUBSTR(CGC,1,2)+SUBSTR(CGC,4,3)+SUBSTR(CGC,8,2)+ALLTRIM(STR(VETN[X]))+SUBSTR(CGC,12,4)+SUBSTR(CGC,17,2)
       IF VALICGC(CGC)
          VETOR_CNPJ[I,1]=CGC
          VETOR_CNPJ[I,2]="8"
          VETOR_CNPJ[I,3]=STR(X)
          I++
          *AVISO(STR(I-1))
       ENDIF
      NEXT X

   ENDIF


FOR X=1 TO I
    IF EMPTY(ALLTRIM(VETOR_CNPJ[X,1]))
       AB=X
    ENDIF
NEXT X
        
SAVE SCREEN
@ 08,48 CLEAR TO 12+I,70
@ 08,48  TO 11+I,70 double
    oldcor=setcolor()
    set color to &cor19
    @ 09,49 SAY "SUGESTOES DE MUDANCA:"
    set color to &oldcor
FOR X=1 TO I
    posi=VETOR_CNPJ[X,2]
    numcer=ALLTRIM(VETOR_CNPJ[X,3])
    ngeral=VETOR_CNPJ[X,1]
    @ 10+X,49 SAY ngeral
    oldcor=setcolor()
    set color to &COR19
    @ 10+X,48+VAL(posi) say NUMCER
    setcolor(oldcor)
NEXT X
INKEY(0)

ENDDO


RESTORE SCREEN


RETURN(.T.)
*********************

*************************************
FUNCTION VALICGC(cgc)
LOCAL i,ii,soma,controle,digito,num
*************************************

cgc = IF(VALTYPE(cgc)="U","",cgc)
IF EMPT(cgc)
    RETURN(.T.)
ELSE
    IF LEN(cgc) < 14
        RETURN(.F.)
    ENDIF
ENDIF
controle=""
num=5
FOR ii=1 TO 2
    soma=0
    FOR i=1 TO 12
        soma+=(VAL(SUBSTR(cgc,i,1))*num)
        num--
        IF num=1
            num=9
        ENDIF
    NEXT
    IF ii=2
        soma+=(2*VAL(controle))
    ENDIF
    digito=soma - (INT(soma/11)*11)
    IF digito=0 .OR. digito=1
        controle=controle+"0"
    ELSE
        controle=controle+STR(11-digito,1)
    ENDIF
    num=6
NEXT
IF controle!=SUBST(cgc,13,2) 
**    AVISO("CNPJ "+SUBST(CGC,1,8)+"/"+SUBST(CGC,9,4)+" INVALIDO, DIGITO CERTO = "+CONTROLE+" 1a8 Corrigir") 
     
    RETURN(.F.)
ENDIF
RETURN(.T.)


