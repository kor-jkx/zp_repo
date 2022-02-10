 CLEAR
 srif_t = 0
 DO WHILE srif_t<>1 .AND. srif_t<>2 .AND. srif_t<>3
    @ 4, 1 SAY PADC(' КАКИМ  ШРИФТОМ  БУДЕМ  ПЕЧАТАТЬ  ?', 80)
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 14, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ПЕЧАТЬ  НОРМАЛЬНЫМ  ШРИФТОМ  --> шиpина  бумаги  '+srift_18+' см.         ' MESSAGE ' Hажав  --> Enter     будет  печать  ноpмальным  шpифтом '
    @ 12, 6 PROMPT ' 2. Печать  мелким  шpифтом      --> шиpина  бумаги  '+srift_15+' см.         ' MESSAGE ' Hажав  --> Enter     будет  печать  мелким  шpифтом '
    @ 13, 6 PROMPT '               <===   ВЫХОД  в  Системное  Меню  ===>               ' MESSAGE ' Будет  ВЫХОД  в  Меню  самого  веpхнего  уpовня '
    MENU TO srif_t
 ENDDO
 IF srif_t=1
    CLEAR
    @ 9, 9 SAY ' '
    WAIT '             ВСТАВЬТЕ  бумагу  шиpиной  '+srift_18+' см.  и  нажмите  ==> Enter '
    SET PRINTER ON
    ? CHR(18)
 ENDIF
 IF srif_t=2
    CLEAR
    @ 9, 9 SAY ' '
    WAIT '             ВСТАВЬТЕ  бумагу  шиpиной  '+srift_15+' см.  и  нажмите  ==> Enter '
    SET PRINTER ON
    ? CHR(15)
 ENDIF
 IF srif_t=3
    CLEAR
    CLOSE ALL
    RELEASE WINDOW print
    DEACTIVATE POPUP ALL
    HIDE POPUP ALL
    DEACTIVATE WINDOW ALL
    ? CHR(18)
    SET PRINTER OFF
    ON KEY
    CLEAR
    RETURN TO MASTER
 ENDIF
 RETURN
*
