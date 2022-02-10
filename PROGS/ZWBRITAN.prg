 SELECT 3
 USE spodr
 wi_b = 0
 DO WHILE wi_b=0
    CLEAR
    bri_n = '00'
    bri_k = '99'
    tab_n = '0000'
    tab_k = '9999'
    name_brin = '                    '
    @ 3, 02 SAY ' Выберите :'
    @ 4, 02 SAY ' Участок  с котоpого начать  Печать'
    @ 4, 40 SAY '===>' COLOR W+/R* 
    DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP sprpodr do brinbrin
    ACTIVATE POPUP sprpodr
    @ 5, 20 SAY name_brin
    @ 5, 20 FILL TO 5, 40 COLOR GR+/RB 
    @ 5, 43 SAY bri_n PICTURE '99'
    @ 5, 43 FILL TO 5, 44 COLOR GR+/RB 
    @ 4, 40 SAY '===>'
    @ 7, 02 SAY ' Табельный N*  котоpым  начать    --->' GET tab_n
    READ
    name_brik = '                    '
    @ 13, 02 SAY ' Выберите :'
    @ 14, 02 SAY ' Участок котоpым закончить  Печать'
    @ 14, 40 SAY '===>' COLOR W+/R* 
    DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP sprpodr do brikbrik
    ACTIVATE POPUP sprpodr
    @ 15, 20 SAY name_brik
    @ 15, 20 FILL TO 15, 40 COLOR GR+/RB 
    @ 15, 43 SAY bri_k PICTURE '99'
    @ 15, 43 FILL TO 15, 44 COLOR GR+/RB 
    @ 14, 40 SAY '===>'
    @ 17, 02 SAY ' Табельный N*  котоpым  закончить --->' GET tab_k
    @ 19, 04 SAY '┌────┐                              ┌────────┐'
    @ 20, 04 SAY '│Esc │ ---> Повторить  Выбор        │ ENTER  │ ===> Идем далее'
    @ 21, 04 SAY '└────┘                              └────────┘'
    @ 19, 04 FILL TO 21, 09 COLOR N+/G 
    @ 19, 40 FILL TO 21, 49 COLOR N/BG 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ELSE
       IF bri_n>bri_k
          DEFINE WINDOW brakbri FROM 7, 8 TO 13, 70 COLOR N/W 
          ACTIVATE WINDOW brakbri
          @ 2, 12 SAY '  Конечный  код  УЧАСТКА  должен  быть  ' COLOR W+/R 
          @ 3, 12 SAY '    больше  или  pавен  начальному      ' COLOR W+/R 
          ?
          WAIT '              Hажмите  ENTER  и  повторите  Выбор ! '
          DEACTIVATE WINDOW brakbri
          RELEASE WINDOW brakbri
       ELSE
          wi_b = 1
       ENDIF
    ENDIF
 ENDDO
 RETURN
*
PROCEDURE brinbrin
 bri_n = bri
 name_brin = podr
 DEACTIVATE POPUP sprpodr
 RETURN
*
PROCEDURE brikbrik
 bri_k = bri
 name_brik = podr
 DEACTIVATE POPUP sprpodr
 RETURN
*
