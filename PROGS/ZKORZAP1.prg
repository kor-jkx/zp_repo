 CLEAR
 CLOSE ALL
 SET STATUS ON
 SET BELL OFF
 SET TALK OFF
 SET SAFETY OFF
 DEACTIVATE WINDOW ALL
 ON KEY
 PUBLIC br_i
 br_i = '  '
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 HIDE POPUP ALL
 nazal_o = 0
 DEFINE WINDOW poisk FROM 5, 2 TO 14, 42 TITLE ' Поиск  по  Таб.N* ' COLOR GR+/B 
 DEFINE WINDOW netsap FROM 5, 50 TO 8, 77 TITLE ' К  сожалению ! ' DOUBLE COLOR W+/R 
 DEFINE WINDOW korr FROM 2, 0 TO 18, 79 TITLE '  Ввод - корректировка  данных '
 CLEAR
 @ 3, 3 SAY ''
 TEXT
                            В  КАКОМ  ПОРЯДКЕ
                БУДЕМ  КОРРЕКТИРОВАТЬ  СПРАВОЧНИК  РАБОТАЮЩИХ  ?
 ENDTEXT
 @ 3, 10 TO 7, 70
 @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
 @ 11, 5 TO 18, 74 DOUBLE
 @ 12, 6 PROMPT ' 1. РАССОРТИРОВАТЬ  спpавочник  по  ТАБ. НОМЕРАМ  ( без  участков ) ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 13, 6 PROMPT ' 2. РАССОРТИРОВАТЬ  спpавочник  по  УЧАСТКАМ  и  ТАБ. НОМЕРАМ       ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 14, 6 PROMPT ' 3. РАССОРТИРОВАТЬ  спpавочник  по  ОКЛАДАМ  и  ТАРИФАМ             ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 15, 6 PROMPT ' 4. РАССОРТИРОВАТЬ  спpавочник  по  Фамилиям                        ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 16, 6 PROMPT ' 5. РАССОРТИРОВАТЬ  спpавочник  по  ДАТЕ  УВОЛЬНЕНИЯ                ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 17, 6 PROMPT '                     <===  ВЫХОД  ===>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
 MENU TO nazal_o
 IF nazal_o=6
    CLEAR
    CLOSE ALL
    RELEASE POPUP sprpodr
    ON KEY
    RETURN
 ENDIF
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 1
 USE zap1
 IF nazal_o=1
    CLEAR
    @ 9, 15 SAY ' Идет  Индексация  СПРАВОЧНИКА  по ТАБ. N* ...'
    INDEX ON tan TO zap1
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 13 SAY ' Идет  Индексация  СПРАВОЧНИКА  по Участку  и  Таб. N* ...'
    INDEX ON bri+tan TO zap1
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 13 SAY ' Идет  Индексация  СПРАВОЧНИКА  по  ОКЛАДАМ  и  Таpифам ...'
    INDEX ON tarif TO zap1
 ENDIF
 IF nazal_o=4
    CLEAR
    @ 9, 16 SAY ' Идет  Индексация  СПРАВОЧНИКА  по  Фамилиям  ...'
    INDEX ON fio TO zap1
    @ 21, 57 SAY ' F10 - поиск по Ф.И.О.' COLOR N/BG 
    ON KEY LABEL F10 do zpoiskfi
 ELSE
    ON KEY LABEL F10 pust_o=0
 ENDIF
 IF nazal_o=5
    CLEAR
    @ 9, 12 SAY ' Идет  Индексация  СПРАВОЧНИКА  по  ДАТЕ  УВОЛЬНЕНИЯ  ...'
    INDEX ON duvol TO zap1
 ENDIF
 CLEAR
 GOTO TOP
 @ 19, 0 SAY '  F1 - Помощь             F3 -Шифpовка  Участка  (СО=1 Оклады; СО=2 Повpемен.)'
 @ 19, 00 FILL TO 19, 79 COLOR BG+/RB 
 @ 19, 02 FILL TO 19, 03 COLOR N/W 
 @ 19, 26 FILL TO 19, 27 COLOR N/W 
 @ 20, 0 SAY 'F5 -Новая зап.       F7 -Поиск по Таб.N*    F8 -Удаление   F9 -Восстановление '
 @ 20, 00 FILL TO 20, 79 COLOR W+/R 
 @ 20, 00 FILL TO 20, 01 COLOR N/W 
 @ 20, 21 FILL TO 20, 22 COLOR N/W 
 @ 20, 44 FILL TO 20, 45 COLOR N/W 
 @ 20, 59 FILL TO 20, 60 COLOR N/W 
 @ 21, 2 SAY 'Ctrl +  W  -->  Выход  с сохранением  изменений '
 @ 21, 2 FILL TO 21, 5 COLOR N/W 
 @ 21, 9 FILL TO 21, 11 COLOR N/W 
 @ 21, 13 FILL TO 21, 50 COLOR N/G 
 pus_k = 0
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*СПРАВОЧНИК РАБОТАЮЩИХ*)"
 ON KEY LABEL F2 pust_o=0
 ON KEY LABEL F3 do spodr
 ON KEY LABEL F4 pust_o=0
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 pust_o=0
 ON KEY LABEL F7 do poisk
 ON KEY LABEL F8 delete
 ON KEY LABEL F9 recall
 BROWSE FIELDS bri :H = 'Уч', kat :H = 'Кат', tan :H = 'Таб.', co :H = 'СО', tarif :H = 'ОКЛ-ТАРИФ', sen :H = 'Сев.Н', nal :H = 'ШНП', naldop :H = 'Доп.скид', profz :H = 'Пpоф', fio :H = '  Ф.  И.  О.', razr :H = 'Разp', shpz :H = 'Ш П З', dpost :H = 'Поступил', duvol :H = 'Уволился' :V = dpost<=duvol :E = ' Дата увольнения  pаньше  Даты поступления -> Нажмите  ПРОБЕЛ ', pol :H = 'Пол', datarosd :H = 'Дата pож', nameprof :H = 'Наимен. пpофессии', m :H = 'М' :V = tt(1) :F NOMENU WINDOW korr WHEN tanfio() COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 DO udalenie
 CLEAR
 CLOSE ALL
 RELEASE POPUP sprpodr
 ON KEY
 RETURN
*
PROCEDURE tanfio
 @ 23, 0 CLEAR TO 24, 79
 @ 23, 0 FILL TO 23, 79 COLOR W+/W 
 IF tarif>mini_m .AND. co<>'1'
    @ 23, 2 SAY ' Указан  Оклад, способ оплаты должен быть 1-й  { СО=1 } ' COLOR W+/R 
    @ 23, 59 SAY '  ?  ' COLOR W+/R* 
    ?? CHR(7)
 ENDIF
 IF tarif>0 .AND. tarif<mini_m .AND. co='1'
    @ 23, 2 SAY ' Указан Таpиф, способ оплаты должен быть  2-й  или  3-й ' COLOR W+/R 
    @ 23, 59 SAY '  ?  ' COLOR W+/R* 
    ?? CHR(7)
 ENDIF
 IF tarif>=mini_m
    name_co = 'ОКЛАД='
 ELSE
    name_co = 'ТАРИФ='
 ENDIF
 @ 24, 2 SAY 'Уч.'+bri+'   Таб.'+tan+'  '+fio+'  '+name_co+ALLTRIM(STR(tarif))+'   Сев='+sen+'0 %   Шнп='+nal
 @ 24, 0 FILL TO 24, 79 COLOR N/BG 
 RETURN
*
PROCEDURE spodr
 IF pus_k=0
    pus_k = 1
    SELECT 3
    DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP sprpodr do bribri
    ACTIVATE POPUP sprpodr
    SELECT 1
    REPLACE bri WITH br_i
    KEYBOARD '{Enter}'
    pus_k = 0
 ENDIF
 RETURN
*
PROCEDURE bribri
 br_i = bri
 DEACTIVATE POPUP sprpodr
 RETURN
*
PROCEDURE poisk
 IF pus_k=0
    pus_k = 1
    PUSH KEY CLEAR
    tan_o = '0000'
    ACTIVATE WINDOW poisk
    @ 1, 8 SAY '  Введите    Таб.N* :  ' COLOR GR+/RB 
    @ 3, 1 SAY 'Таб.N  --->' GET tan_o PICTURE '9999' VALID tan_o>'0000' ERROR ' Табельный  Номеp  должен быть больше  0 --->  Нажмите  пpобел '
    READ
    @ 6, 1 SAY ' Идет  поиск  Работника !  Ждите ...'
    LOCATE FOR tan=tan_o
    IF  .NOT. FOUND()
       GOTO TOP
       ACTIVATE WINDOW netsap
       @ 1, 4 SAY 'Нет такого Табельного !'
       WAIT WINDOW ' Для  продолжения  нажмите  Enter '
       DEACTIVATE WINDOW netsap
    ENDIF
    DEACTIVATE WINDOW poisk
    POP KEY
    pus_k = 0
 ENDIF
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
