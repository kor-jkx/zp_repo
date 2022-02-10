 CLEAR
 ON KEY
 SET DELETED OFF
 COUNT FOR DELETED() TO k_del_s
 SET DELETED ON
 IF k_del_s=0
    RETURN
 ENDIF
 DEFINE WINDOW okno FROM 4, 14 TO 10, 65 TITLE ' Внимание !!!' COLOR W+/W 
 CLEAR
 SET COLOR OF HIGHLIGHT TO W+/R*
 ACTIVATE WINDOW okno
 @ 1, 7 SAY ' Помечено  для  Удаления '+STR(k_del_s, 6)+' зап. ' COLOR R/W 
 @ 3, 10 PROMPT ' Hе  удалять ' MESSAGE '  Будет  выход  БЕЗ  удаления  помеченных  записей '
 @ 3, 27 PROMPT ' Удалить     ' MESSAGE ' Помеченные  записи  будут  УДАЛЕНЫ  '
 MENU TO uda_l
 DEACTIVATE WINDOW okno
 IF uda_l=2
    GOTO TOP
    CLEAR
    @ 9, 19 SAY ' Идет  удаление  помеченных  записей .....'
    PACK
 ELSE
    CLEAR
    @ 9, 10 SAY ' Снимаются  метки  удаления  записей  во  всем  массиве ...'
    RECALL ALL
 ENDIF
 SET COLOR OF HIGHLIGHT TO W+/R
 RETURN
*
