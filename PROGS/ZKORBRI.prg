 CLEAR
 CLOSE ALL
 SET STATUS ON
 SET BELL OFF
 SET TALK OFF
 SET SAFETY OFF
 DEACTIVATE WINDOW ALL
 ON KEY
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 HIDE POPUP ALL
 DEACTIVATE WINDOW ALL
 nazal_o = 0
 DEFINE WINDOW korr FROM 2, 0 TO 18, 79 TITLE '  Ввод - корректировка  данных '
 SELECT 1
 USE spodr
 CLEAR
 @ 9, 18 SAY ' Идет  Индексация  СПРАВОЧНИКА  Участков  ...'
 INDEX ON bri TO spodr
 GOTO TOP
 @ 19, 0 SAY '  F1 - Помощь '
 @ 19, 00 FILL TO 19, 79 COLOR BG+/RB 
 @ 19, 02 FILL TO 19, 03 COLOR N/W 
 @ 20, 0 SAY 'F5 -Новая запись.                           F8 -Удаление   F9 -Восстановление '
 @ 20, 00 FILL TO 20, 79 COLOR W+/R 
 @ 20, 00 FILL TO 20, 01 COLOR N/W 
 @ 20, 44 FILL TO 20, 45 COLOR N/W 
 @ 20, 59 FILL TO 20, 60 COLOR N/W 
 @ 21, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 21, 4 FILL TO 21, 7 COLOR N/W 
 @ 21, 11 FILL TO 21, 13 COLOR N/W 
 @ 21, 15 FILL TO 21, 55 COLOR N/G 
 pus_k = 0
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 hel_p = 'help2.txt'
 ON KEY LABEL F1 do help2
 ON KEY LABEL F2 pust_o=0
 ON KEY LABEL F3 pust_o=0
 ON KEY LABEL F4 pust_o=0
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 pust_o=0
 ON KEY LABEL F7 pust_o=0
 ON KEY LABEL F8 delete
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 BROWSE FIELDS bri :H = 'УЧ', podr :H = '  НАИМЕНОВАНИЕ ' :V = tt(1) :F NOMENU WINDOW korr COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 DO udalenie
 COPY TO sortir
 USE sortir
 COPY TO C:\ZARPLATA\spodr
 CLEAR
 CLOSE ALL
 ON KEY
 DELETE FILE sortir.dbf
 RETURN
*
FUNCTION tt
 PARAMETER rr
 IF LASTKEY()=13
    KEYBOARD '{dnarrow}'
 ENDIF
 rr = .T.
 RETURN rr
 RETURN
*
PROCEDURE dobaw
 IF pus_k=0
    APPEND BLANK
 ENDIF
 RETURN
*
PROCEDURE help2
 IF pus_k=0
    pus_k = 1
    PUSH KEY CLEAR
    DEFINE WINDOW help FROM 1, 0 TO 24, 79 TITLE 'ПОДСКАЗКА ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND &hel_p NOEDIT WINDOW HELP
    DEACTIVATE WINDOW help
    RELEASE WINDOW help
    POP KEY
    pus_k = 0
 ENDIF
 RETURN
*
