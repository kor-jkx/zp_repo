 PUSH KEY CLEAR
 SET EXACT OFF
 DEFINE WINDOW netfio FROM 5, 20 TO 9, 65 TITLE ' К  сожалению ' DOUBLE COLOR W+/R 
 DEFINE WINDOW poiskfio FROM 6, 40 TO 13, 79 TITLE ' Поиск  по  Фамилии ' COLOR GR+/B 
 fi_o = '       '
 ACTIVATE WINDOW poiskfio
 @ 2, 1 SAY ' Hабеpите  начало '
 @ 3, 1 SAY ' Искомой  ФАМИЛИИ  -->' GET fi_o PICTURE 'XXXXXXX'
 @ 5, 1 SAY '( Все БОЛЬШИЕ буквы  или  Пеpвая )'
 READ
 fi_o = ALLTRIM(fi_o)
 @ 5, 1 SAY ' Идет  поиск  Фамилии !  Ждите ...'
 SEEK fi_o
 IF EOF()
    LOCATE FOR fio=fi_o
 ENDIF
 IF  .NOT. FOUND()
    GOTO TOP
    ACTIVATE WINDOW netfio
    @ 1, 10 SAY ' Hет  такой  фамилии !'
    WAIT WINDOW ' Для продолжения нажмите любую клавишу '
    DEACTIVATE WINDOW netfio
    RELEASE WINDOW netfio
 ENDIF
 DEACTIVATE WINDOW poiskfio
 RELEASE WINDOW poiskfio
 POP KEY
 RETURN
*
