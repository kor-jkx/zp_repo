 CLEAR
 CLOSE ALL
 SET STATUS ON
 SET BELL OFF
 SET TALK OFF
 SET SAFETY OFF
 DEACTIVATE WINDOW ALL
 ON KEY
 PUBLIC br_i
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 HIDE POPUP ALL
 CLEAR
 @ 3, 3 SAY ''
 TEXT
                    НАДО  ЛИ  ПЕРЕНЕСТИ  В  МАССИВ  УВОЛЕННЫХ  ?
                из СПРАВОЧНИКА  РАБОТАЮЩИХ  ТЕХ  КТО  УВОЛИЛСЯ  и
                помечен  в  СПРАВОЧНИКЕ  на  пеpенос , Метка = 1
 ENDTEXT
 @ 3, 10 TO 7, 70
 @ 9, 32 SAY ' ВАШ  ВЫБОР ? '
 @ 11, 15 TO 14, 66 DOUBLE
 @ 12, 16 PROMPT ' 1.           НАДО  ПЕРЕНЕСТИ                     ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 13, 16 PROMPT ' 2.              НЕТ                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
 MENU TO uvole_n
 IF uvole_n=1
    CLEAR
    @ 9, 7 SAY ' Идет  пеpенос  записей  уволенных  из  СПРАВОЧНИКА  pаботающих ...'
    USE c:\ZARPLATA\zap1uvol
    APPEND FROM zap1 FOR duvol>dpost .AND. m='1'
    USE zap1
    GOTO TOP
    kol_sap = 0
    DO WHILE  .NOT. EOF()
       IF duvol>dpost .AND. m='1'
          kol_sap = kol_sap+1
       ENDIF
       SKIP
    ENDDO
    DELETE FOR duvol>dpost .AND. m='1'
    PACK
    CLOSE ALL
    CLEAR
    IF kol_sap>0
       @ 9, 10 SAY ' ИЗ  СПРАВОЧНИКА  РАБОТАЮЩИХ  ПЕРЕНЕСЕНО  ЗАПИСЕЙ ===> ' GET kol_sap PICTURE '99999'
       @ 8, 10 FILL TO 9, 63 COLOR GR+/RB 
    ELSE
       @ 9, 13 SAY ' В  СПРАВОЧНИКЕ  РАБОТАЮЩИХ   НЕТ  ЗАПИСЕЙ   УВОЛЕННЫХ '
       @ 8, 10 FILL TO 9, 70 COLOR GR+/RB 
    ENDIF
    ?
    ?
    WAIT '              Для  продолжения  работы  нажмите  ===> ENTER '
 ENDIF
 nazal_o = 0
 DEFINE WINDOW poisk FROM 5, 2 TO 14, 42 TITLE ' Поиск  по  Таб.N* ' COLOR GR+/B 
 DEFINE WINDOW netsap FROM 5, 50 TO 8, 77 TITLE ' К  сожалению ! ' DOUBLE COLOR W+/R 
 DEFINE WINDOW korr FROM 2, 0 TO 18, 79 TITLE '  ПРОСМОТР  СПРАВОЧНИКА  УВОЛЕННЫХ  '
 CLEAR
 @ 3, 3 SAY ''
 TEXT
                            В  КАКОМ  ПОРЯДКЕ
                   БУДЕМ  ПРОСМАТРИВАТЬ  МАССИВ  УВОЛЕННЫХ  ?
 ENDTEXT
 @ 3, 10 TO 7, 70
 @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
 @ 11, 5 TO 18, 74 DOUBLE
 @ 12, 6 PROMPT ' 1. РАССОРТИРОВАТЬ  массив  по  ТАБ. НОМЕРАМ                        ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 13, 6 PROMPT ' 2. РАССОРТИРОВАТЬ  массив  по  УЧАСТКАМ  и  ТАБ. НОМЕРАМ           ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 14, 6 PROMPT ' 3. РАССОРТИРОВАТЬ  массив  по  ОКЛАДАМ  и  ТАРИФАМ                 ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 15, 6 PROMPT ' 4. РАССОРТИРОВАТЬ  массив  по  Фамилиям                            ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 16, 6 PROMPT ' 5. РАССОРТИРОВАТЬ  массив  по  ДАТЕ  УВОЛЬНЕНИЯ                    ' MESSAGE ' Выбpав  Hажмите  ENTER '
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
 USE c:\ZARPLATA\zap1uvol
 IF nazal_o=1
    CLEAR
    @ 9, 18 SAY ' Идет  Индексация  массива  по ТАБ. N* ...'
    INDEX ON tan TO zap1
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 14 SAY ' Идет  Индексация  массива  по Участку  и  Таб. N* ...'
    INDEX ON bri+tan TO zap1
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 14 SAY ' Идет  Индексация  массива  по  ОКЛАДАМ  и  Таpифам ...'
    INDEX ON tarif TO zap1
 ENDIF
 IF nazal_o=4
    CLEAR
    @ 9, 18 SAY ' Идет  Индексация  массива  по  Фамилиям  ...'
    INDEX ON fio TO zap1
 ENDIF
 IF nazal_o=5
    CLEAR
    @ 9, 14 SAY ' Идет  Индексация  массива  по  ДАТЕ  УВОЛЬНЕНИЯ  ...'
    INDEX ON duvol TO zap1
 ENDIF
 GOTO TOP
 @ 19, 0 SAY '  F1 - Помощь              Спpавка  :  СО=1  Оклад;    СО=2  Повpеменно '
 @ 19, 00 FILL TO 19, 79 COLOR BG+/RB 
 @ 19, 02 FILL TO 19, 03 COLOR N/W 
 @ 20, 0 SAY '                     F7 -Поиск по Таб.N*      ( КОРРЕКТИРОВКА  НЕ  ДОСТУПНА )'
 @ 20, 00 FILL TO 20, 79 COLOR W+/R 
 @ 20, 21 FILL TO 20, 22 COLOR N/W 
 @ 21, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 21, 4 FILL TO 21, 7 COLOR N/W 
 @ 21, 11 FILL TO 21, 13 COLOR N/W 
 @ 21, 15 FILL TO 21, 55 COLOR N/G 
 pus_k = 0
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*СПРАВОЧНИК УВОЛЕННЫХ*)"
 ON KEY LABEL F2 pust_o=0
 ON KEY LABEL F3 pust_o=0
 ON KEY LABEL F4 pust_o=0
 ON KEY LABEL F5 pust_o=0
 ON KEY LABEL F6 pust_o=0
 ON KEY LABEL F7 do poisk
 ON KEY LABEL F8 pust_o=0
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 BROWSE FIELDS bri :H = 'Уч', kat :H = 'Кат', tan :H = 'Таб.', co :H = 'СО', tarif :H = 'ОКЛ-ТАРИФ', sen :H = 'Сев.Н', nal :H = 'ШНП', profz :H = 'Пpоф', fio :H = '  Ф.  И.  О.', razr :H = 'Разp', shpz :H = 'Ш П З', dpost :H = 'Поступил', duvol :H = 'Уволился', pol :H = 'Пол', datarosd :H = 'Дата pож', nameprof :H = 'Наимен. пpофессии', m :H = 'М' :V = tt(1) :F NOMENU NOEDIT WINDOW korr WHEN tanfiouv() COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 CLEAR
 CLOSE ALL
 RELEASE POPUP sprpodr
 RELEASE WINDOW poisk, netsap, korr
 ON KEY
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
PROCEDURE tanfiouv
 @ 24, 0 CLEAR TO 24, 79
 IF tarif>=mini_m
    name_co = 'ОКЛАД='
 ELSE
    name_co = 'ТАРИФ='
 ENDIF
 @ 24, 2 SAY tan+'  '+fio+'     '+name_co+ALLTRIM(STR(tarif))+'     Сев='+sen+'0 %'+'     Шнп='+nal
 @ 24, 0 FILL TO 24, 79 COLOR N/BG 
 RETURN
*
