*
PROCEDURE prhelp
 PARAMETER var_par, var_par_no
 IF  .NOT. (TYPE('Var_Par')=='C')
    var_par = 'All'
 ENDIF
 IF ATC(var_par, 'All')=1
    var_par = 'All'
 ENDIF
 IF  .NOT. (TYPE('Var_Par_Not')=='C')
    var_par_no = ''
 ENDIF
 PRIVATE n_help, f1, f2, x1, x2, x11, _nado, _ne_nado
 f1 = FCREATE('TempHelp.txt')
 f2 = FOPEN('Help.txt')
 DEFINE WINDOW winhelp FROM 1, 0 TO 24, 79 NOGROW FLOAT NOCLOSE SHADOW TITLE ' Справочная система ' FOOTER ' F5 - Печать '+REPLICATE('═', 50)+' Esc - Выход ' DOUBLE COLOR N/W,,B+/W,B+/W,N/W,W+/GR,N/W,W/N,W/N,W/N 
 DO WHILE .T.
    IF (f1=-1 .AND. f2=-1) .OR. (f2=-1)
       WAIT WINDOW NOWAIT 'Помощь не доступна'
       EXIT
    ENDIF
    IF f1=-1
       MODIFY FILE Help.txt NOEDIT WINDOW winhelp
       = FCLOSE(f1)
       = FCLOSE(f2)
       EXIT
    ENDIF
    _nado = .F.
    _ne_nado = .F.
    DO WHILE  .NOT. FEOF(f2)
       s = FGETS(f2)
       IF LEFT(ALLTRIM(s), 2)=='(*' .AND. RIGHT(ALLTRIM(s), 2)='*)'
          _nado = ALLTRIM(s)$var_par
          _ne_nado = ALLTRIM(s)$var_par_no
          LOOP
       ENDIF
       IF (_nado .AND.  .NOT. (var_par=='All')) .OR. ( .NOT. (_ne_nado) .AND. var_par=='All')
          = FPUTS(f1, s)
       ENDIF
    ENDDO
    = FCLOSE(f1)
    = FCLOSE(f2)
    COPY FILE TempHelp.txt TO PrnHelp.txt
    PUSH KEY CLEAR
    ON KEY LABEL F5 Do PrintHelp
    DO WHILE .T.
       MODIFY FILE TempHelp.txt NOEDIT WINDOW winhelp
       IF LASTKEY()=27
          EXIT
       ENDIF
    ENDDO
    POP KEY
    DELETE FILE PrnHelp.txt
    DELETE FILE TempHelp.txt
    EXIT
 ENDDO
 RELEASE WINDOW winhelp
 RETURN
*
FUNCTION printhelp
 IF  .NOT. PRINTSTATUS()
    WAIT WINDOW 'Принтер не готов'
    RETURN .T.
 ENDIF
 PRIVATE f_prn, s_prn
 DEFINE WINDOW winprnhelp FROM 10, 1 TO 18, 78 TITLE ' Печать помощи ' DOUBLE COLOR W+/BG,,GR+/BG,GR+/BG 
 f_prn = FOPEN('PrnHelp.txt')
 ACTIVATE WINDOW winprnhelp
 SET PRINTER ON
 DO WHILE  .NOT. FEOF(f_prn)
    s_prn = FGETS(f_prn, 254)
    ? s_prn
 ENDDO
 ?
 ? CHR(12)
 SET PRINTER OFF
 RELEASE WINDOW winprnhelp
 = FCLOSE(f_prn)
 RETURN .T.
*
