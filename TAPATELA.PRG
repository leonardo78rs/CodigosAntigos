OLDCOR=SETCOLOR()
CLEAR
SET COLOR TO &cor22
@ 12,3 SAY"                                   �       "
@ 13,3 SAY"                                           "
@ 14,3 SAY"������� �����  ����� �����    � ����� �����"
@ 15,3 SAY"   �    �   �  �   � �   �    � �   � �    "
@ 16,3 SAY"   �    �����  ����� �����    � �   � �����"
@ 17,3 SAY"   �    �   �  �     �   � �  � �   �     �"
@ 18,3 SAY"   �    �   �  �     �   � ���� ����� �����"

SET COLOR TO &cor21
IF TROCA_MES="OK"
@ 14,48 SAY"������ �����  ����� ����� ����� � ����� �    "
@ 15,48 SAY"�      �      �   � �     �     � �   � �    "
@ 16,48 SAY"����   �����  ����� ����� �     � ����� �    "
@ 17,48 SAY"�          �  �     �     �     � �   � �    "
@ 18,48 SAY"������ �����  �     ����� ����� � �   � ���  "
ENDIF


SET COLOR TO &cor28
@ 02,02 SAY "   S.I.R.C. - Sistema de Impressao de Relat�rios do Condominio E. Tapaj�s   "
@ 00,00 TO 24,79 DOUBLE
@ 01,01 TO 03,78
SET COLOR TO &cor22
@ 04,18 PROMPT "TITULOS" MESSAGE "T�tulos das tabelas"
@ 04,32 PROMPT "DIGITA�AO" MESSAGE "Digitacao das tabelas"
@ 04,49 PROMPT "RELATORIOS" MESSAGE "Impressao dos relatorios"
@ 04,68 PROMPT "SAIR" MESSAGE "Retorno p/ o D.O.S."
@ 04,03 PROMPT "OPCOES" MESSAGE "Incluir cond�minos, Conferencia de Somas"
MENU TO OPCAO
SET COLOR TO &OLDCOR
