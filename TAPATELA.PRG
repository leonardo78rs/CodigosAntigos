OLDCOR=SETCOLOR()
CLEAR
SET COLOR TO &cor22
@ 12,3 SAY"                                   Ы       "
@ 13,3 SAY"                                           "
@ 14,3 SAY"ЫЫЫЫЫЫЫ ЫЫЫЫЫ  ЫЫЫЫЫ ЫЫЫЫЫ    Ы ЫЫЫЫЫ ЫЫЫЫЫ"
@ 15,3 SAY"   Ы    Ы   Ы  Ы   Ы Ы   Ы    Ы Ы   Ы Ы    "
@ 16,3 SAY"   Ы    ЫЫЫЫЫ  ЫЫЫЫЫ ЫЫЫЫЫ    Ы Ы   Ы ЫЫЫЫЫ"
@ 17,3 SAY"   Ы    Ы   Ы  Ы     Ы   Ы Ы  Ы Ы   Ы     Ы"
@ 18,3 SAY"   Ы    Ы   Ы  Ы     Ы   Ы ЫЫЫЫ ЫЫЫЫЫ ЫЫЫЫЫ"

SET COLOR TO &cor21
IF TROCA_MES="OK"
@ 14,48 SAY"ЫЫЫЫЫЫ ЫЫЫЫЫ  ЫЫЫЫЫ ЫЫЫЫЫ ЫЫЫЫЫ Ы ЫЫЫЫЫ Ы    "
@ 15,48 SAY"Ы      Ы      Ы   Ы Ы     Ы     Ы Ы   Ы Ы    "
@ 16,48 SAY"ЫЫЫЫ   ЫЫЫЫЫ  ЫЫЫЫЫ ЫЫЫЫЫ Ы     Ы ЫЫЫЫЫ Ы    "
@ 17,48 SAY"Ы          Ы  Ы     Ы     Ы     Ы Ы   Ы Ы    "
@ 18,48 SAY"ЫЫЫЫЫЫ ЫЫЫЫЫ  Ы     ЫЫЫЫЫ ЫЫЫЫЫ Ы Ы   Ы ЫЫЫ  "
ENDIF


SET COLOR TO &cor28
@ 02,02 SAY "   S.I.R.C. - Sistema de Impressao de Relatўrios do Condominio E. Tapajўs   "
@ 00,00 TO 24,79 DOUBLE
@ 01,01 TO 03,78
SET COLOR TO &cor22
@ 04,18 PROMPT "TITULOS" MESSAGE "TЎtulos das tabelas"
@ 04,32 PROMPT "DIGITAЂAO" MESSAGE "Digitacao das tabelas"
@ 04,49 PROMPT "RELATORIOS" MESSAGE "Impressao dos relatorios"
@ 04,68 PROMPT "SAIR" MESSAGE "Retorno p/ o D.O.S."
@ 04,03 PROMPT "OPCOES" MESSAGE "Incluir cond“minos, Conferencia de Somas"
MENU TO OPCAO
SET COLOR TO &OLDCOR
