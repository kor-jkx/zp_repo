 CLEAR
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 1 SAY PADC(' КУДА БУДЕМ  ВЫВОДИТЬ  МАШИНОГРАММУ ? ', 80)
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 13, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД  на  ЭКРАН  для  ПРОСМОТРА  и  КОНТРОЛЯ.                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД  на  ПЕЧАТЬ  на  БУМАГУ.                                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO prn_disp
 ENDDO
 IF prn_disp=1
    SET ALTERNATE TO prosmotr.txt
    SET ALTERNATE ON
    DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Фоpмиpуется  текстовый  файл ' COLOR W+/BG 
 ELSE
    DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  ! ' COLOR W+/BG 
 ENDIF
 RETURN
*
