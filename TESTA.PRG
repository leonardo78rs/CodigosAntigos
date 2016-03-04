set procedure to calculos.prg

VC_CPF1      =  SPACE(14)

VC_Cnpj      =  SPACE(18)



DO WHILE .NOT. LASTKEY()=27

clear

@ 06,02 SAY "DIGITE O CPF PARA TESTAR"

@ 08,02 SAY "ENTER (em branco) PARA IR PARA CNPJ"

@ 10,02 GET VC_CPF1   PICT "999.999.999-99" VALID(VCPF(VC_CPF1))
read



testa_cnpj(1)



@ 13,02 SAY "Este ‚ o calculo matem tico, depois teste o CPF no SITE da RECEITA"

@ 15,02 SAY "Tecle <ESC> para sair"

ENDDO

