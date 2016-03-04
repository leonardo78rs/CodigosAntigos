BORDA(09,16,12,44,COR5)
A=ACHOICE(10,17,11,43,OPCIMP,.T.,"FUNCA")
IF A=1
   
   DO WHILE .NOT. LASTKEY()=27
      @ 06,01 CLEAR TO 23,78
      mdimp5=alltrim(mdimp5)+space(10)
      
      AMDIMP99=MDIMP99
      ATMP="Escolha o dispositivo padrao e tecle <enter>        "
      @ 08,04 GET ATMP               
      		   CLEAR GETS
      @ 09+AMDIMP99,06 SAY CHR(16)
      @ 10,10 PROMPT  " 1 "+"Impres.1 - Conectada diretamente " + MDIMP1
      @ 11,10 PROMPT  " 2 "+"Impres.2 - Rede  " + MDIMP2
      @ 12,10 PROMPT  " 3 "+"Impres.3 - Rede  " + MDIMP3
      @ 13,10 PROMPT  " 4 "+"Impres.4 - Rede  " + MDIMP4
      @ 14,10 PROMPT  " 5 "+"Imprim.arquivo   " + MDIMP5
      @ 15,10 PROMPT  " 6 "+"Imprim.diretorio " + MDIMP6 
      @ 16,10 PROMPT  " 7 "+"Imprim.diretorio " + MDIMP7
      @ 15,12+len(" 6 "+"Imprim.diretorio "+MDIMP6) SAY "<-- Na Area de trabalho"
      @ 16,12+len(" 7 "+"Imprim.diretorio "+MDIMP7) SAY "<-- Pasta do Cadastro deste PC"
      @ 17,10 say "O dispositivo padrao e' o "+str(MDIMP99)
      MENU TO MDIMP99
      
      VETORTEMP={MDIMP1,MDIMP2,MDIMP3,MDIMP4,MDIMP5,MDIMP6,MDIMP7}
      
      IF LASTKEY()=27
         AVISO("Configurado para: "+vetortemp[amdimp99])
         MDIMP99=AMDIMP99
         exit
         
      ENDIF
      
      @ 18,10 SAY "O DISPOSITIVO PADRAO E' " +VETORTEMP[MDIMP99]
      @ 19,10 SAY "Salvar estas configuracoes" GET SN
      READ
      IF UPPER(SN)="S"
         SAVE ALL LIKE md* TO VARSCONF.MEM
         AVISO("CONFIGURADO!")
         IF !MDIMP99=1 .AND. !MDIMP99=5 .AND. !MDIMP99=6 .AND. !MDIMP99=7
            ! net use lpt1: /delete >> nul
            IF MDIMP99=2
               ! net use lpt1: &MDIMP2 >> nul
            ELSEIF MDIMP99=3
               ! net use lpt1: &MDIMP3 >> nul
            ELSEIF MDIMP99=4
               ! net use lpt1: &MDIMP4 >> nul
            ENDIF
         ELSEIF MDIMP99=5
            IMPLPT=ALLTRIM(MDIMP5)
         ELSEIF MDIMP99=6
            IMPLPT=DIRECPASTIMP(1)
         ELSEIF MDIMP99=7
            IMPLPT=DIRECPASTIMP(2)
         ELSEIF MDIMP99=1
            IMPLPT="LPT1"
         ENDIF
         AVISO("IMPRESSORA DIRECIONADA")
      ENDIF
   ENDDO
   
   		ELSEIF A=2
   		DO WHILE .NOT. LASTKEY()=27
   @ 06,01 CLEAR TO 23,78
   mdimp5=alltrim(mdimp5)+space(10)
   mdimp6=alltrim(mdimp6)+space(10)
   mdimp7=alltrim(mdimp7)+space(10)
   @ 08,04 SAY "Dispositivos de Impressao / Configuracao de Arquivos"
   @ 10,10 say "Impres.1 - Conectada diretamente" GET MDIMP1
   @ 11,10 SAY "Impres.2 - Rede  " GET MDIMP2
   @ 12,10 SAY "Impres.3 - Rede  " GET MDIMP3
   @ 13,10 SAY "Impres.4 - Rede  " GET MDIMP4
   @ 14,10 SAY "Imprim.arquivo   " GET MDIMP5
   @ 15,10 SAY "Imprim.diretorio " GET MDIMP6
   @ 16,10 SAY "Imprim.diretorio " GET MDIMP7
   
   @ 18,10 say "O dispositivo padrao e' o "+str(MDIMP99)
   READ
   AMDIMP99=MDIMP99
   
   IF LASTKEY()=27
      AVISO("Configurado para: "+vetortemp[mdimp99])
      MDIMP99=AMDIMP99
      exit
   ENDIF
   
   VETORTEMP={MDIMP1,MDIMP2,MDIMP3,MDIMP4,MDIMP5,MDIMP6,MDIMP7}
   @ 20,10 SAY "O DISPOSITIVO PADRAO E' " +VETORTEMP[MDIMP99]
   @ 21,10 SAY "Salvar estas configuracoes" GET SN
   READ
   IF UPPER(SN)="S"
      SAVE ALL LIKE md* TO VARSCONF.MEM
      AVISO("CONFIGURADO!")
      IF !MDIMP99=1 .AND. !MDIMP99=5 .AND. !MDIMP99=6 .AND. !MDIMP99=7
         ! net use lpt1: /delete >> nul
         IF MDIMP99=2
            ! net use lpt1: &MDIMP2 >> nul
         ELSEIF MDIMP99=3
            ! net use lpt1: &MDIMP3 >> nul
         ELSEIF MDIMP99=4
            ! net use lpt1: &MDIMP4 >> nul
         ENDIF
      ELSEIF MDIMP99=5
         IMPLPT=ALLTRIM(MDIMP5)
      ELSEIF MDIMP99=6
         IMPLPT=DIRECPASTIMP(1)
      ELSEIF MDIMP99=7
         IMPLPT=DIRECPASTIMP(2)
      ELSEIF MDIMP99=1
         IMPLPT="LPT1"
      ENDIF
      AVISO("IMPRESSORA DIRECIONADA")
   ENDIF
ENDDO
ENDIF
KEYB CHR(13)+CHR(24)+CHR(24)+CHR(24)
