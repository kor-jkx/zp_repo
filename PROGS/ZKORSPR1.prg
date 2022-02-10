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
 DEFINE WINDOW korr FROM 2, 0 TO 18, 79 TITLE ' Корректировка  СПРАВОЧНИКА  ОФОРМЛЕНИЯ  ДОКУМЕНТОВ '
 SELECT 1
 USE spr1
 @ 19, 0 SAY '  F1 - Помощь '
 @ 19, 00 FILL TO 19, 79 COLOR BG+/RB 
 @ 19, 02 FILL TO 19, 03 COLOR N/W 
 @ 21, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 21, 4 FILL TO 21, 7 COLOR N/W 
 @ 21, 11 FILL TO 21, 13 COLOR N/W 
 @ 21, 15 FILL TO 21, 55 COLOR N/G 
 pus_k = 0
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*СПРАВОЧНИК ОФОРМЛЕНИЯ ДОКУМЕНТОВ*)"
 ON KEY LABEL F2 pust_o=0
 ON KEY LABEL F3 pust_o=0
 ON KEY LABEL F4 pust_o=0
 ON KEY LABEL F5 pust_o=0
 ON KEY LABEL F6 pust_o=0
 ON KEY LABEL F7 pust_o=0
 ON KEY LABEL F8 pust_o=0
 ON KEY LABEL F9 pust_o=0
 ON KEY LABEL F10 pust_o=0
 EDIT FIELDS rukovod :H = 'Ф.И.О. pуководителя', dolgnost :H = 'Должность pуководителя', glbuh :H = 'Ф.И.О. Гл. бухгалтеpа', stbuh :H = 'Ф.И.О. Ст. бухгалтеpа', ispbuh :H = 'Ф.И.О. Бух.по З/пл.', inn :H = 'Код  И Н Н' NOMENU WINDOW korr COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 RELEASE WINDOW korr
 CLEAR
 CLOSE ALL
 ON KEY
 RETURN
*
