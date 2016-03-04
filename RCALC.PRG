*:*****************************************************************************
*: Procedure file: RCALC.PRG
*:         System: RCALC : Moveable Pop-Up Calculator
*:         Author: Rolf van Gelder
*:                 Copyright (c) 1993-95, Rolf van Gelder
*:                    RvG Clipper Collection (tm)
*:                    All rights reserved
*:  Last modified: 19/10/95
*: Donated to the Public Domain by Rolf van Gelder
*: To create a stand-alone test program : CLIPPER RCALC /n/dTEST
*:*****************************************************************************

#include "Inkey.ch"			// STANDARD CLIPPER HEADER FILES
#include "Setcurs.ch"

#define	D_HEIGHT	12		// HEIGHT OF WINDOW
#define	D_WIDTH		21		// WIDTH  OF WINDOW

#define	D_DECIMALS	6		// NUMBER OF DECIMALS

#define D_MAINCOLOR     COR18            // COLOR FOR CALCULATOR 'GR+/R'
#define D_DISPCOLOR     COR25           // COLOR FOR DISPLAY  'W+/B'

#IFDEF TEST
*!*****************************************************************************
*!
*!       Function: MAIN()
*!
*!      Called by: RCALC.PRG                         
*!
*!*****************************************************************************
	FUNCTION Main ()

		R_Calc ()

	RETURN nil
#ENDIF

*!*****************************************************************************
*!
*!       Function: R_CALC()
*!
*!*****************************************************************************
FUNCTION R_Calc
****
*	File	RCalc5.prg
*	Descr	Moveable Pop-up Calculator
*	Syntax	R_Calc ()
*	Param	None
*	Returns	Nil
****

LOCAL	cOldScrn			// Save screen
LOCAL	nOldRow				// Save cursor row
LOCAL	nOldColumn			// Save cursor column
LOCAL	cOldColor			// Save color
LOCAL	nOldCur				// Save cursor shape

LOCAL	nKey := 255			// INKEY ()
LOCAL	cKey				// CHR (INKEY () )
LOCAL	cScrn				// Screenbuffer
LOCAL	eExpr				// Expression to evaluate

STATIC	rc_a := ''			// A-register
STATIC	rc_b := ''			// B-register
STATIC	rc_o := ' '			// Operator
STATIC	rc_r				// Row    (upper left corner)
STATIC	rc_c				// Column (upper left corner)

*-- SAVE DISPLAY CONTENTS & STATUS
cOldScrn   := SaveScreen ( 0, 0, MaxRow(), MaxCol() )
nOldRow    := Row ()
nOldColumn := Col ()
cOldColor  := SetColor ()
nOldCur    := SetCursor ( SC_NONE )

IF rc_r = NIL
   *-- First time initialization : center the calculator
   rc_r := Int ( ( MaxRow() - D_HEIGHT ) / 2 )
ENDIF

IF rc_c = NIL
   *-- First time initialization : center the calculator
   rc_c := Int ( ( MaxCol() - D_WIDTH ) / 2 )
ENDIF

PRIVATE	nRegA				// Register A (MACRO!)
PRIVATE	nRegB				// Register B (MACRO!)

DO WHILE .T.
   
   SetColor ( D_MAINCOLOR )
   
   IF nKey = 255
      *-- Window moved or first time: draw screen
      Scroll ( MaxRow(), 0 )
      DevPos ( MaxRow(), 18 )
      DevOut ( 'R_Calc() - Calculadora: ' + ;
         CHR(27) + CHR(26) + CHR(24) + CHR(25) + ;
         '=Move, <Esc>=Sair' )
      
      cScrn := SaveScreen ( rc_r, rc_c, rc_r + D_HEIGHT - 1, ;
         rc_c + D_WIDTH - 1 )
      
      Scroll  ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      DispBox ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      
      DevPos ( rc_r   , rc_c ); DevOut ( 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      DevPos ( row()+1, rc_c ); DevOut ( '³                   ³' )
      DevPos ( row()+1, rc_c ); DevOut ( '³                   ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÃÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄ´' )
      DevPos ( row()+1, rc_c ); DevOut ( '³ 7 ³ 8 ³ 9 ³ C ³ * ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´' )
      DevPos ( row()+1, rc_c ); DevOut ( '³ 4 ³ 5 ³ 6 ³ E ³ / ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´' )
      DevPos ( row()+1, rc_c ); DevOut ( '³ 1 ³ 2 ³ 3 ³ ^ ³ - ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´' )
      DevPos ( row()+1, rc_c ); DevOut ( '³ 0 ³ . ³ = ³Esc³ + ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÀÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÙ' )
      
   ENDIF
   
   *-- DISPLAY NUMBERS + OPERATOR
   DevPos ( rc_r + 1, rc_c + 18 )
   DevOut ( rc_o )
   
   DevPos ( rc_r + 1, rc_c + 3 )
   DevOut ( Str ( Val ( rc_a ), 15, D_DECIMALS ) )
   
   DevPos ( rc_r + 2, rc_c + 3 )
   DevOut ( Str ( Val ( rc_b ), 15, D_DECIMALS ), D_DISPCOLOR )
   
   *-- WAIT FOR KEYPRESS
   nKey := InKey ( 0 )
   
   *-- <Return> KEY ACTS THE SAME AS THE "=" KEY
   cKey := IF ( nKey = K_RETURN, '=' , Upper ( Chr ( nKey ) ) )
   
   *-- THE "," KEY ACTS THE SAME AS THE "." KEY
   cKey := IF ( cKey = ',', '.', cKey )
   
   *-- VERWERK GEDRUKTE TOETS
   DO CASE
      
   CASE nKey = K_ESC
      *-- EINDE
      
      EXIT
      
   CASE nKey = K_BS
      *-- BACKSPACE: DELETE LAST CHARACTER
      
      IF Len ( rc_b ) > 0
         *-- TRIM LAST CHARACTER
         rc_b := Left ( rc_b, Len ( rc_b ) - 1 )
      ENDIF
      
      LOOP
      
   CASE nKey = K_LEFT .or. nKey = K_RIGHT .or. ;
         nKey = K_UP   .or. nKey = K_DOWN
      *-- MOVE WINDOW
      
      RestScreen ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1, cScrn )
      
      *-- CLEAR LASTKEY
      __KeyBoard ( Chr ( 1 ) ); Inkey ( 0 )
      
      R_MvWin ( @rc_r, @rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      
      *-- SET <nKey> TO 255 AS A SIGNAL FOR REDRAWING THE SCREEN
      nKey := 255
      
      LOOP
      
   CASE cKey = 'C'
      *-- CLEAR ALL REGISTERS & OPERATOR
      
      rc_a := rc_b := ''
      rc_o := ' '
      
   CASE cKey = 'E'
      *-- CLEAR LAST OPERATION
      
      rc_b := ''
      
   CASE cKey $ '+-*^=/'
      *-- OPERATOR PRESSED
      
      IF rc_o $ '+-*^/' .or. cKey = '='
         
         *-- LOOK OUT FOR ZERO DIVISION !
         IF rc_o != '/' .or. Val ( rc_b ) != 0
            
            IF rc_o $ '+-*^/'
               *-- VALID OPERATOR : EVALUATE EXPRESSION
               M->nRegA := rc_a
               M->nRegB := rc_b
               eExpr := 'VAL(nRegA)' + rc_o + 'VAL(nRegB)'
               
               *-- EVALUATE EXPRESSION
               rc_a  := Str ( &eExpr., 15, D_DECIMALS )
            ENDIF
            
         ENDIF
         
      ELSE
         
         IF !Empty ( rc_b )
            *-- MOVE B-REG TO A-REG
            rc_a := rc_b
         ENDIF
         
      ENDIF
      
      *-- SAVE OPERATOR
      rc_o := IF ( cKey = '=', ' ', cKey )
      rc_b := ''
      
   CASE cKey $ '0123456789.'
      *-- DIGIT PRESSED
      
      rc_b += cKey
      
   ENDCASE
   
ENDDO

*-- CLEAR LASTKEY
__KeyBoard ( Chr ( 1 ) ); Inkey ( 0 )

*-- RESTORE DISPLAY CONTENTS & STATUS
RestScreen ( 0, 0, MaxRow(), MaxCol(), cOldScrn )
SetCursor ( nOldCur )
SetColor ( cOldColor )
DevPos ( nOldRow, nOldColumn )

RETURN nil


*!*****************************************************************************
*!
*!       Function: R_MVWIN()
*!
*!*****************************************************************************
FUNCTION R_MvWin ( nR1, nC1, nR2, nC2 )
****
*	File	RCalc5.prg
*	Descr	Moves a window on the screen
*	Syntax	R_MvWin ( @nR1, @nC1, nR2, nC2 )
*	Param	( nR1, nC1, nR2, nC2 ) : Window coordinates
*		Note: nR1 & nC1 SHOULD BE PASSED BY REFERENCE (@)
*	Returns	Nil
****

#define	MW_MINROW	2
#define	MW_MAXROW	MaxRow() - 2
#define	MW_MINCOL	0
#define	MW_MAXCOL	MaxCol()

#define MW_COLOR       COR9                  //  'W+/G'

LOCAL	nTop      := nR1		// WINDOW COORDINATES
LOCAL	nBottom   := nR2
LOCAL	nLeft     := nC1
LOCAL	nRight    := nC2
LOCAL	nKey      := 0
LOCAL	nMinRow   := MW_MINROW
LOCAL	nMaxRow   := MW_MAXROW
LOCAL	nMinCol   := MW_MINCOL
LOCAL	nMaxCol   := MW_MAXCOL
LOCAL	cScr      := SaveScreen ( nMinRow, nMinCol, nMaxRow, nMaxCol )
LOCAL	cMaxRow   := SaveScreen ( MaxRow(), 0, MaxRow(), MaxCol() )
LOCAL	cOldColor := SetColor ( MW_COLOR )

Scroll ( MaxRow () )
DevPos ( MaxRow(), 3 )
DevOut ( 'MOVER JANELA: Use ' + ;
   CHR(27) + ' ' + CHR(26) + ' ' + CHR(24) + ' ' + CHR(25) + ;
   ' PgUp,PgDn,Home,End        <ÄÙ=Okay <Esc>=Cancela' )

DO WHILE ( nKey != K_ESC .and. nKey != K_RETURN )
   
   RestScreen ( nMinRow, nMinCol, nMaxRow, nMaxCol, cScr )
   
   DispBox ( nTop, nLeft, nBottom, nRight )
   
   DevPos ( nBottom, nLeft + ( nRight - nLeft - 6 ) / 2 )
   DevOut ( '> MOVER <' )
   
   nKey = InKey ( 0 )
   
   IF nKey = K_DOWN
      *-- DOWN ARROW
      IF nBottom < nMaxRow
         nTop++ ; nBottom++
      ENDIF
      
   ELSEIF nKey = K_RIGHT
      *-- RIGHT ARROW
      IF nRight < nMaxCol
         nRight++ ; nLeft++
      ENDIF
      
   ELSEIF nKey = K_LEFT
      *-- LEFT ARROW
      IF nLeft > nMinCol
         nLeft-- ; nRight--
      ENDIF
      
   ELSEIF nKey = K_UP
      *-- UP ARROW
      IF nTop > nMinRow
         nTop-- ; nBottom--
      ENDIF
      
   ELSEIF nKey = K_PGUP
      *-- PGUP KEY
      IF nTop > nMinRow .and. nRight < nMaxCol
         nTop--   ; nBottom--
         nRight++ ; nLeft ++
      ENDIF
      
   ELSEIF nKey = K_PGDN
      *-- PGDN KEY
      IF nBottom < nMaxRow .and. nRight < nMaxCol
         nBottom++; nTop++
         nRight++ ; nLeft ++
      ENDIF
      
   ELSEIF nKey = K_END
      *-- END KEY
      IF nBottom < nMaxRow .and. nLeft > nMinCol
         nBottom++ ; nTop++
         nLeft--   ; nRight--
      ENDIF
      
   ELSEIF nKey = K_HOME
      *-- HOME KEY
      IF nTop > nMinRow .and. nLeft > nMinCol
         nTop--  ; nBottom--
         nLeft-- ; nRight--
      ENDIF
      
   ENDIF
   
ENDDO

RestScreen ( nMinRow, nMinCol, nMaxRow, nMaxCol, cScr )
RestScreen ( MaxRow(), 0, MaxRow(), MaxCol(), cMaxRow )

SetColor ( cOldColor )

IF nKey = K_ENTER
   
   *-- PASS NEW WINDOW POSITION TO CALLER (BY REFERENCE)
   nR1 := nTop
   nC1 := nLeft
   
ENDIF

RETURN nil

*******************************************************************************
* ___________  ________________________________________________________________
*  \_____    \  * * * *   R v G   C l i p p e r   C o l l e c t i o n   * * * *
*   |       _/_  _ ________                    ______               (c) 1993-95
*   \    |   \\ \//  _____/                    \____ \          Rolf van Gelder
*   /____|_  / \//   \  ___                    )  |_> >   Binnenwiertzstraat 27
* _________\/__  \    \_\  \     _THE_         |   __/ost    5615 HG  EINDHOVEN
* \            \__\______  /   ShareWare    ___|__|             The Netherlands
*  \_  ______   \_   ___ \/    Libraries    \____ \ 
*  /   \     \  /    \  \/   for CA-CLIPPER )  | > >             +31-40-2438852
* /     \     \/\     \____                 |   __/hone         (Eve & Weekend)
* \      \_______\______  /               __|__|     
*  \             /      \/               / __ \     Internet: rcrolf@urc.tue.nl
*   \_______    /                       \  ___/mail      Bitnet: rcrolf@heitue5
* _________ \  / _______________________ \_____> ______________________________
*    The RvG \/ Clipper Collection Home Page: http://asterix.urc.tue.nl/~rcrolf
*
*******************************************************************************

*: EOF: RCALC.PRG
