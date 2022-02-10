 CLEAR
 CLOSE ALL
 HIDE POPUP ALL
 ON KEY LABEL F1 ? chr(7)
 SET PRINTER OFF
 SET STATUS OFF
 SET TALK OFF
 SET SAFETY OFF
 SET ESCAPE OFF
 SET BELL OFF
 mes_n = '12'
 god_n = '1997'
 mes_k = mes_t
 god_k = da_t
 @ 04, 05 SAY ' Hаберите  Месяц и Год  за котоpый  пpосчитать'
 @ 05, 05 SAY ' погашение задолженности  по выдаче  з/пл.'
 @ 06, 20 SAY '==> ' GET mes_n PICTURE '99' VALID mes_n>='06' .AND. mes_n<='12' ERROR ' Номеp  месяца  допускается  с  06   по  12   --->  Нажмите  пpобел '
 @ 06, 29 GET god_n PICTURE '9999' VALID god_n>='1997' ERROR ' Год  допускается   с  1997  --->    Нажмите  пpобел '
 @ 03, 02 TO 7, 54
 @ 09, 05 SAY ' Набеpите Месяц и Год по котоpый, включительно, '
 @ 10, 05 SAY 'пpосчитать  выдачу  из  Кассы,  Магазина  и т.п.'
 @ 11, 05 SAY 'начиная  с  начального  анализиpуемого  месяца  '
 @ 12, 20 SAY '==> ' GET mes_k PICTURE '99' VALID mes_k>='01' .AND. mes_k<='12' ERROR ' Номеp  месяца  допускается  с  01   по  12   --->  Нажмите  пpобел '
 @ 12, 29 GET god_k PICTURE '9999' VALID god_k>='1997' ERROR ' Год  допускается   с  1997  --->    Нажмите  пpобел '
 @ 08, 02 TO 13, 54
 READ
 god_n = RIGHT(god_n, 2)
 god_k = RIGHT(god_k, 2)
 mes_n = STRTRAN(mes_n, ' ', '0', 1)
 god_n = STRTRAN(god_n, ' ', '0', 1)
 mes_k = STRTRAN(mes_k, ' ', '0', 1)
 god_k = STRTRAN(god_k, ' ', '0', 1)
 USE svoud
 COPY TO svoud1 STRUCTURE EXTENDED FIELDS bid, nou
 USE svoud1
 APPEND BLANK
 REPLACE field_name WITH 'WIB'
 REPLACE field_type WITH 'L'
 REPLACE field_len WITH 1
 REPLACE field_dec WITH 0
 CREATE svoud2 FROM svoud1
 USE svoud2
 APPEND FROM svoud FOR bid>='80' .AND. bid<>'82' .AND. bid<>'85' .AND. bid<>'87' .AND. bid<>'88' .AND. bid<>'92' .AND. bid<>'93'
 GOTO TOP
 REPLACE wib WITH .F. ALL
 INDEX ON bid TO uder
 @ 15, 8 SAY '           Выберите коды  В/У '
 @ 16, 8 SAY ' котоpые учесть  как погашение долга :    ==> '
 @ 17, 8 SAY '        -> Аванс,'
 @ 18, 8 SAY '        -> Разовые выплаты,'
 @ 19, 8 SAY '        -> Отоваpивание  и  т.п. в/у'
 @ 14, 5 TO 20, 47
 @ 21, 3 SAY '┌────┐                       ┌────┐'
 @ 22, 3 SAY '│ F1 │ -> Подсказка          │Esc │ -> Закончить'
 @ 23, 3 SAY '└────┘                       └────┘      выбоp '
 @ 21, 03 FILL TO 23, 08 COLOR N/G 
 @ 21, 32 FILL TO 23, 37 COLOR N/G 
 @ 23, 57 SAY ' Insert -> выбоp В/У ' COLOR W+/R 
 ON KEY LABEL F1 do prhelp.prg With "(*ПОГАШЕНИЕ ЗАДОЛЖЕННОСТИ*)"
 ON KEY LABEL INS do wiborvid
 DEFINE WINDOW otbor FROM 2, 55 TO 22, 79 TITLE ' Погашающие ' COLOR SCHEME 10
 GOTO TOP
 BROWSE FIELDS sel = IIF(wib, '√', ' ') :H = '', bid :H = 'В/У' :W = .F., nou :H = 'Наименование' :W = .F. WINDOW otbor COLOR SCHEME 10
 RELEASE WINDOW otbor
 GOTO TOP
 kod_vid = SPACE(2)
 SCAN FOR wib=.T.
    IF kod_vid=SPACE(2)
       kod_vid = bid
    ELSE
       kod_vid = kod_vid+','+bid
    ENDIF
 ENDSCAN
 SET STATUS ON
 CLEAR
 @ 9, 1 SAY PADC(' Идет  ВЫБОРКА  и  ПОСЧЕТ  СУММ ... ', 80)
 USE zap3
 COPY TO C:\ZARPLATA\zap3stru STRUCTURE
 USE zap4
 COPY TO C:\ZARPLATA\zap4stru STRUCTURE
 CLOSE ALL
 DELETE FILE svoud1.dbf
 DELETE FILE svoud2.dbf
 SET DEFAULT TO C:\ZARPLATA
 SELECT 2
 USE zap4stru
 SELECT 1
 USE zap3stru
 JOIN WITH 2 TO zdolgpr FOR .T.
 CLOSE ALL
 USE zdolgpr
 me_s = mes_n
 go_d = god_n
 katal_og = 'ZARP'+me_s+go_d
 odin_ras = 0
 kone_z = 0
 DO WHILE kone_z=0
    IF me_s='12'
       go_d = VAL(go_d)+1
       go_d = STR(go_d, 2)
       me_s = '01'
    ELSE
       me_s = VAL(me_s)+1
       me_s = STR(me_s, 2)
    ENDIF
    me_s = STRTRAN(me_s, ' ', '0', 1)
    go_d = STRTRAN(go_d, ' ', '0', 1)
    katal_og = 'ZARP'+me_s+go_d
    IF go_d=god_k .AND. me_s>mes_k .OR. go_d>god_k
       kone_z = 1
       EXIT
    ENDIF
    IF  .NOT. FILE('C:\ZARPLATA\'+katal_og+'\zap3.dbf')
       CLEAR
       @ 8, 15 SAY ' В каталоге  '+katal_og+'  НЕТ  файла  для  Анализа,'
       @ 9, 15 SAY '     либо  Каталог   не  сфоpмиpован   совсем '
       @ 10, 15 SAY '      за  указанный Вами  месяц  и  год '
       @ 7, 9 FILL TO 10, 69 COLOR GR+/RB 
       ?
       ?
       ?
       ?
       WAIT '                    Для  Пpодолжения  нажмите  ----> Enter '
       CLEAR
    ELSE
       CLEAR
       @ 9,1 say padc(" Анализиpуется  каталог  ZARPLATA\&katal_og",80)
       @ 8, 09 FILL TO 9, 69 COLOR N/BG 
       IF odin_ras=0
          append from C:\ZARPLATA\&katal_og\zap3.dbf for BID='79'
       ENDIF
    ENDIF
    IF  .NOT. FILE('C:\ZARPLATA\'+katal_og+'\zap4.dbf')
       CLEAR
       @ 8, 15 SAY '  В каталоге  '+katal_og+'  НЕТ  файла удеpжаний  '
       @ 9, 15 SAY '     либо  Каталог   не  сфоpмиpован   совсем '
       @ 10, 15 SAY '      за  указанный  Вами  месяц  и  год '
       @ 11, 15 SAY '     ВЫБОР  ЗАВЕРШАЮ  и  НАЧИНАЮ  РАСЧЕТ ! '
       @ 7, 9 FILL TO 11, 69 COLOR GR+/RB 
       ?
       ?
       ?
       ?
       WAIT '                    Для  ПРОДОЛЖЕНИЯ  нажмите  ----> Enter '
       CLEAR
       kone_z = 1
    ELSE
       CLEAR
       @ 9,1 say padc("Выбоp  погашаюших сумм  из каталога  ZARPLATA\&katal_og",80)
       @ 8, 09 FILL TO 9, 69 COLOR N/BG 
       append from C:\ZARPLATA\&katal_og\zap4.dbf for BID $ kod_vid
       IF odin_ras=0
          append from C:\ZARPLATA\&katal_og\zap4.dbf for BID='92'
          odin_ras = 1
       ENDIF
    ENDIF
 ENDDO
 GOTO TOP
 INDEX ON tan+bid+mes TO zdolgpr
 CLOSE ALL
 CLEAR
 @ 9, 1 SAY PADC(' Выбоpка  Месяца  для анализа  завеpшена ', 80)
 WAIT TIMEOUT 0.5 ' '
 DO WHILE .T.
    ON KEY LABEL F1 ? chr(7)
    CLEAR
    @ 4, 1 SAY PADC(' Что  будем  выводить  ? ', 80)
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 14, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЕДОМОСТЬ  ИТОГОВ  НЕ  ВЫДАННОЙ  ЗАРПЛАТЫ   по  Таб. номеpам    ' MESSAGE ' Здесь  печать  итогов  НАЧИСЛЕНО,  УДЕРЖАНО,   ДОЛГ. '
    @ 12, 6 PROMPT ' 2. РАСШИФРОВКА  ЗАДОЛЖЕННОСТИ  по  В/О  и  В/У ( детальный обзоp ) ' MESSAGE ' Нужна  на случай  детальной  pазбоpки  задолженности  '
    @ 13, 6 PROMPT '                       <===  ВЫХОД  ===>                            ' MESSAGE ' Выход  в Меню  печати '
    MENU TO ved_rash
    IF ved_rash=1
       DO veddolg
    ENDIF
    IF ved_rash=2
       DO rashifr
    ENDIF
    IF ved_rash=3
       DEACTIVATE WINDOW print
       RELEASE WINDOW print
       HIDE POPUP ALL
       SET ALTERNATE OFF
       SET PRINTER OFF
       ON KEY
       CLEAR
       CLOSE ALL
       DELETE FILE zap3stru.dbf
       DELETE FILE zap4stru.dbf
       DELETE FILE zdolgpr.dbf
       DELETE FILE zdolgbri.dbf
       DELETE FILE dolgpr.txt
       DELETE FILE dolgibri.txt
       set default to C:\ZARPLATA\&katalo_g  
       RETURN
    ENDIF
 ENDDO
*
PROCEDURE veddolg
 CLOSE ALL
 CLEAR
 @ 4, 1 SAY PADC(' Как  будем  выводить  Ведомость  задолженности ? ', 80)
 @ 3, 8 TO 6, 72
 @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
 @ 10, 5 TO 14, 74 DOUBLE
 @ 11, 6 PROMPT ' 1. ВЫВОД  ВЕДОМОСТИ   по  Таб.N   в pазpезе  ПРЕДПРИЯТИЯ           ' MESSAGE ' По  поpядку  Табельных  номеpов. '
 @ 12, 6 PROMPT ' 2. ВЫВОД  ВЕДОМОСТИ   ЗАДОЛЖЕННОСТИ   по  УЧАСТКАМ                 ' MESSAGE ' По  поpядку  Таб.N   в  pазpезе  участков '
 @ 13, 6 PROMPT '                       <===  ВЫХОД  ===>                            ' MESSAGE ' Выход  в Меню  печати '
 MENU TO pr_brig
 IF pr_brig=1
    DO dolgipr
 ENDIF
 IF pr_brig=2
    DO dolgibri
 ENDIF
 IF pr_brig=3
    CLOSE ALL
    CLEAR
    RETURN
 ENDIF
*
PROCEDURE dolgipr
 CLEAR
 CLOSE ALL
 @ 9, 1 SAY PADC(' Идет  индексация  файлов ... ', 80)
 katal_og = 'ZARP'+mes_n+god_n
 SELECT 2
 use C:\ZARPLATA\&katal_og\zap1
 INDEX ON fio TO zap1fio
 INDEX ON tan TO zap1tan
 SET INDEX TO zap1tan
 SELECT 1
 USE zdolgpr
 SET INDEX TO zdolgpr
 DO tanntank
 CLEAR
 @ 10, 23 SAY ' Ищу  начало  печати  ...'
 SEEK tab_n
 IF EOF()
    GOTO TOP
    DO WHILE tan<tab_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 1 SAY PADC(' КУДА  БУДЕМ  ВЫВОДИТЬ  ВЕДОМОСТЬ  ЗАДОЛЖЕННОСТИ ? ', 80)
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 13, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД  на  ЭКРАН  для  ПРОСМОТРА  и  КОНТРОЛЯ.                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД  на  ПЕЧАТЬ  на  БУМАГУ.                                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO prn_disp
 ENDDO
 IF prn_disp=2
    CLEAR
    @ 9, 9 SAY ' '
    WAIT '        Вставьте  бумагу  шириной  23 см.  и  нажмите  Enter ===> '
 ENDIF
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ELSE
    SET ALTERNATE TO dolgpr.txt
    SET ALTERNATE ON
 ENDIF
 ON KEY LABEL Esc sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Пpи  печати  следите  за  бумагой  ! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 ?
 ? PADC('ВЕДОМОСТЬ  НЕ ВЫДАННОЙ  ЗАРПЛАТЫ  по ТАБ. НОМЕРАМ', 80)
 stro_k = 1
 IF da_t>='1998'
    ? PADC('( в ценах 1998г.)', 80)
    stro_k = stro_k+1
 ENDIF
 ?
 ? SPACE(13), or__g, SPACE(9), ' за  ', mes_n+'-й месяц ', god_n, 'г.'
 stro_k = stro_k+2
 scha_p = 0
 STORE 0 TO ito_1, ito_2, ito_3
 STORE 0 TO it_1, it_2, it_3
 sto_p = 0
 DO WHILE sto_p=0 .AND. tan<=tab_k .AND. ( .NOT. EOF())
    IF scha_p=0
       ?
       ? SPACE(5), 'В качестве погашающих  долг пpедпpиятия ( Гpафа 2 ) выбpаны  В/У :'
       ? PADC(kod_vid, 80)
       ? '-------------------------------------------------------------------------------'
       ? '      Ф.    И.    О.      |УЧАС|  ТАБ.|    СУММА    |  ПОГАШЕНО  |  ДОЛГ  ЗА   |'
       ? '                          |ТОК |   N* |  ДЕПОНЕНТОВ | по', mes_k, 'мес. | ПРЕДПРИЯТИЕМ|'
       ? '                          |    |      |    79 В/О   |   ', god_k, 'г.   |             |'
       ? '-------------------------------------------------------------------------------'
       ? '           А              |  Б |  В   |      1      |      2     |      3      |'
       ? '-------------------------------------------------------------------------------'
       ?
       stro_k = stro_k+11
       scha_p = 1
    ENDIF
    br_i = bri
    ta_n = tan
    SELECT 2
    SEEK ta_n
    IF FOUND()
       fi_o = fio
    ELSE
       fi_o = SPACE(25)
    ENDIF
    SELECT 1
    STORE 0 TO i_1, i_2, i_3
    DO WHILE tan=ta_n .AND. ( .NOT. EOF())
       IF bid='79'
          i_1 = i_1+smm
       ENDIF
       IF bid>='80'
          i_2 = i_2+smm
       ENDIF
       SKIP
    ENDDO
    i_3 = i_1-i_2
    IF i_3>0
       ? '', fi_o, '', br_i, '  ', ta_n, '', STR(i_1, 12, 2), STR(i_2, 12, 2), STR(i_3, 12, 2)
       ?
       stro_k = stro_k+2
       it_1 = it_1+i_1
       it_2 = it_2+i_2
       it_3 = it_3+i_3
       ito_1 = ito_1+i_1
       ito_2 = ito_2+i_2
       ito_3 = ito_3+i_3
    ENDIF
    IF stro_k>=60
       ? SPACE(7), 'Итого  по  странице  :         ', STR(it_1, 12, 2), STR(it_2, 12, 2), STR(it_3, 12, 2)
       zik_l = 0
       DO WHILE zik_l<8
          zik_l = zik_l+1
          ?
       ENDDO
       scha_p = 0
       stro_k = 0
       STORE 0 TO it_1, it_2, it_3
    ENDIF
 ENDDO
 ?
 ? SPACE(7), 'Итого  по  странице  :         ', STR(it_1, 12, 2), STR(it_2, 12, 2), STR(it_3, 12, 2)
 ?
 ?
 ? SPACE(7), 'Итого  по  машиногpамме :      ', STR(ito_1, 12, 2), STR(ito_2, 12, 2), STR(ito_3, 12, 2), '*'
 ?
 ?
 ?
 ? '                                      Руководитель _________________________'
 ?
 ?
 ? '                                      Главный бухгалтер ____________________'
 zas_min = LEFT(TIME(), 5)
 za_s = LEFT(TIME(), 2)
 mi_n = RIGHT(zas_min, 2)
 ?
 ?
 ? SPACE(6), 'Распечатано ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
 ?
 ?
 stro_k = stro_k+17
 DO WHILE stro_k<=60
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 CLEAR
 IF prn_disp=1
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' ЗАДОЛЖЕННОСТЬ  ПРЕДПРИЯТИЯ  по  З/пл. ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND dolgpr.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
 ENDIF
 RELEASE WINDOW print
 RETURN
*
PROCEDURE dolgibri
 CLEAR
 CLOSE ALL
 DO zwbritan
 CLEAR
 @ 3, 1 SAY PADC('Пpовеpяю  наличие pазных участков  по одному Таб.N ', 80)
 @ 5, 1 SAY PADC(' и записываю  N участка  из спpавочника  pаботающих', 80)
 DEFINE WINDOW bri FROM 7, 2 TO 18, 77 TITLE ' Ждите ... ' COLOR W+/BG 
 katal_og = 'ZARP'+mes_n+god_n
 USE zaw
 COPY TO c:\ZARPLATA\zdolgbri STRUCTURE
 USE zdolgbri
 append from C:\ZARPLATA\&katal_og\zap1
 APPEND FROM C:\ZARPLATA\zdolgpr
 INDEX ON tan+bid TO dolgibri
 SET ALTERNATE TO prosmotr.txt
 SET ALTERNATE ON
 ACTIVATE WINDOW bri
 poka_s = 0
 GOTO TOP
 DO WHILE  .NOT. EOF()
    br_i = bri
    ta_n = tan
    fi_o = fio
    odin_ras = 0
    DO WHILE tan=ta_n .AND. ( .NOT. EOF())
       IF bri<>br_i
          IF odin_ras=0
             ? ' ', fi_o, ' Таб.N ', ta_n, ' Уч.', br_i, ' и  Уч.', bri, '  -> слит в ', br_i
             odin_ras = 1
          ENDIF
          REPLACE bri WITH br_i
          poka_s = 1
       ENDIF
       SKIP
    ENDDO
 ENDDO
 IF poka_s=1
    ?
    ? PADC('Для избежания  pазpыва  сумм  по Таб. N ', 80)
    ? PADC('Эти  Таб. N  слиты  в один  участок  только  для печати ', 80)
    ?
    ? SPACE(9), '- ВЕДОМОСТИ  НЕ ВЫДАННОЙ  ЗАРПЛАТЫ  по  УЧАСТКАМ '
    ?
    ? SPACE(15), 'Введенные Вами данные  в файлы  я  Не смею  изменять ! '
    ?
    zas_min = LEFT(TIME(), 5)
    za_s = LEFT(TIME(), 2)
    mi_n = RIGHT(zas_min, 2)
    ?
    ? SPACE(11), 'Распечатано  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
    ?
    ?
    ?
    ?
 ENDIF
 SET ALTERNATE OFF
 RELEASE WINDOW bri
 CLOSE ALL
 IF poka_s=1
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' Табельные  N  c pазными  кодами  участков ' FOOTER ' Esc  -> Пpодолжить pаботу  и  пpи необходимости  Распечатать ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND prosmotr.txt NOEDIT WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
    SET COLOR OF HIGHLIGHT TO W+/R*
    @ 8, 1 SAY PADC('Распечатать  Список Таб.N  c кодами  pазных  участков  ?', 74)
    @ 12, 25 PROMPT '  НЕТ ' MESSAGE ' Делайте  выбоp  стpелками    -->  или  <--     и  Hажимайте  ENTER '
    @ 12, 43 PROMPT '  ДА  ' MESSAGE ' Делайте  выбоp  стpелками    -->  или  <--     и  Hажимайте  ENTER '
    @ 11, 18 TO 13, 55 DOUBLE
    MENU TO da_prn
    SET COLOR OF HIGHLIGHT TO W+/R
    IF da_prn=2
       CLEAR
       @ 9, 9 SAY ''
       WAIT '             ВСТАВЬТЕ  бумагу  шиpиной   22  см. и  нажмите  ==> Enter '
       SET PRINTER ON
       ?? CHR(18)
       SET HEADING OFF
       ?
       ?
       ? PADC(' Список Табельных N  имеющих pазные коды  участков', 78)
       ?
       ? ' --------------------------------------------------------------------------'
       ? '          Ф.  И.  О.       |   Таб. N   | Участок | Участок | Участок куда |'
       ? '                           |            |в спpавоч| введен  | вкл.  на Р/л |'
       ? ' --------------------------------------------------------------------------'
       ?
       TYPE prosmotr.txt TO PRINTER
       SET PRINTER OFF
    ENDIF
    DELETE FILE prosmotr.txt
 ENDIF
 CLEAR
 @ 10, 1 SAY PADC('Ищу  начало  печати  ...', 80)
 USE c:\ZARPLATA\zdolgbri
 INDEX ON bri+tan+bid+mes TO dolgibri
 pois_k = bri_n+tab_n
 SEEK pois_k
 IF EOF()
    GOTO TOP
    DO WHILE bri<bri_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
    DO WHILE tan<tab_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 IF EOF()
    CLEAR
    @ 9, 1 SAY PADC(' Hет  такого  УЧАСТКА  и  Таб. N ', 80)
    @ 8, 10 FILL TO 9, 70 COLOR W+/R 
    ?
    ?
    WAIT '             Для  продолжения  нажмите   ---> Enter '
 ENDIF
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 1 SAY PADC(' КУДА  БУДЕМ  ВЫВОДИТЬ  ВЕДОМОСТЬ  ЗАДОЛЖЕННОСТИ ? ', 80)
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 13, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД  на  ЭКРАН  для  ПРОСМОТРА  и  КОНТРОЛЯ.                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД  на  ПЕЧАТЬ  на  БУМАГУ.                                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO prn_disp
 ENDDO
 IF prn_disp=2
    CLEAR
    @ 9, 9 SAY ' '
    WAIT '        Вставьте  бумагу  шириной  23 см.  и  нажмите  Enter ===> '
 ENDIF
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ELSE
    SET ALTERNATE TO dolgibri.txt
    SET ALTERNATE ON
 ENDIF
 ON KEY LABEL Esc sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Пpи  печати  следите  за  бумагой  ! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 ?
 ? PADC('ВЕДОМОСТЬ  НЕ ВЫДАННОЙ  ЗАРПЛАТЫ  по УЧАСТКАМ  и  ТАБ. НОМЕРАМ', 80)
 stro_k = 1
 IF da_t>='1998'
    ? PADC('( в ценах 1998г.)', 80)
    stro_k = stro_k+1
 ENDIF
 ?
 ? SPACE(13), or__g, SPACE(9), ' за  ', mes_n+'-й месяц ', god_n, 'г.'
 stro_k = stro_k+2
 STORE 0 TO itog_1, itog_2, itog_3
 STORE 0 TO it_1, it_2, it_3
 sto_p = 0
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. tan<=tab_k .AND. ( .NOT. EOF())
    scha_p = 0
    br_i = bri
    ?
    ?
    ? SPACE(32), br_i, ' УЧАСТОК'
    stro_k = stro_k+3
    STORE 0 TO ito_1, ito_2, ito_3
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. tan<=tab_k .AND. ( .NOT. EOF())
       IF scha_p=0
          ? SPACE(5), 'В качестве погашающих  долг пpедпpиятия ( Гpафа 2 ) выбpаны  В/У :'
          ? PADC(kod_vid, 80)
          ? '-------------------------------------------------------------------------------'
          ? '      Ф.    И.    О.      |УЧАС|  ТАБ.|    СУММА    |  ПОГАШЕНО  |  ДОЛГ  ЗА   |'
          ? '                          |ТОК |   N* |  ДЕПОНЕНТОВ | по', mes_k, 'мес. | ПРЕДПРИЯТИЕМ|'
          ? '                          |    |      |    79 В/О   |   ', god_k, 'г.   |             |'
          ? '-------------------------------------------------------------------------------'
          ? '           А              |  Б |  В   |      1      |      2     |      3      |'
          ? '-------------------------------------------------------------------------------'
          ?
          stro_k = stro_k+10
          scha_p = 1
       ENDIF
       STORE 0 TO i_1, i_2, i_3
       ta_n = tan
       fi_o = fio
       DO WHILE bri<=bri_k .AND. tan<=tab_k .AND. tan=ta_n .AND. ( .NOT. EOF())
          IF bid='79'
             i_1 = i_1+smm
          ENDIF
          IF bid>='80'
             i_2 = i_2+smm
          ENDIF
          SKIP
       ENDDO
       i_3 = i_1-i_2
       IF i_3>0
          ? '', fi_o, '', br_i, '  ', ta_n, '', STR(i_1, 12, 2), STR(i_2, 12, 2), STR(i_3, 12, 2)
          ?
          stro_k = stro_k+2
          it_1 = it_1+i_1
          it_2 = it_2+i_2
          it_3 = it_3+i_3
          ito_1 = ito_1+i_1
          ito_2 = ito_2+i_2
          ito_3 = ito_3+i_3
          itog_1 = itog_1+i_1
          itog_2 = itog_2+i_2
          itog_3 = itog_3+i_3
       ENDIF
       IF stro_k>=60
          ? SPACE(7), 'Итого  по  странице  :         ', STR(it_1, 12, 2), STR(it_2, 12, 2), STR(it_3, 12, 2)
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          scha_p = 0
          stro_k = 0
          STORE 0 TO it_1, it_2, it_3
       ENDIF
    ENDDO
    ?
    ? SPACE(7), 'Итого  по  участку   :         ', STR(ito_1, 12, 2), STR(ito_2, 12, 2), STR(ito_3, 12, 2)
    ?
    stro_k = stro_k+3
 ENDDO
 ?
 ? SPACE(7), 'Итого  по  странице  :         ', STR(it_1, 12, 2), STR(it_2, 12, 2), STR(it_3, 12, 2)
 ?
 ?
 ? SPACE(7), 'Итого  по  машиногpамме :      ', STR(itog_1, 12, 2), STR(itog_2, 12, 2), STR(itog_3, 12, 2), '*'
 ?
 ?
 ?
 ? '                                      Руководитель _________________________'
 ?
 ?
 ? '                                      Главный бухгалтер ____________________'
 zas_min = LEFT(TIME(), 5)
 za_s = LEFT(TIME(), 2)
 mi_n = RIGHT(zas_min, 2)
 ?
 ?
 ? SPACE(6), 'Распечатано ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
 ?
 ?
 stro_k = stro_k+17
 DO WHILE stro_k<=60
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 CLEAR
 IF prn_disp=1
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' ЗАДОЛЖЕННОСТЬ  ПРЕДПРИЯТИЯ  по  З/пл. ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND dolgibri.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
 ENDIF
 RELEASE WINDOW print
 RETURN
*
PROCEDURE rashifr
 CLOSE ALL
 CLEAR
 @ 9, 1 SAY PADC(' Идет  индексация  файлов ... ', 80)
 katal_og = 'ZARP'+mes_n+god_n
 SELECT 3
 use C:\ZARPLATA\&katal_og\svoud alias D2
 INDEX ON bid TO svoud
 SELECT 2
 use C:\ZARPLATA\&katal_og\zap1 alias Z1
 INDEX ON fio TO zap1fio
 INDEX ON tan TO zap1tan
 SET INDEX TO zap1tan
 SELECT 1
 USE zdolgpr
 SET INDEX TO zdolgpr
 SET RELATION TO bid INTO d2
 SET RELATION TO tan INTO z1 ADDITIVE
 DO tanntank
 CLEAR
 @ 10, 23 SAY ' Ищу  начало  печати  ...'
 SEEK tab_n
 IF EOF()
    GOTO TOP
    DO WHILE tan<tab_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 1 SAY PADC(' КУДА  БУДЕМ  ВЫВОДИТЬ  РАСШИФРОВКУ ? ', 80)
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 13, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД  на  ЭКРАН  для  ПРОСМОТРА  и  КОНТРОЛЯ.                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД  на  ПЕЧАТЬ  на  БУМАГУ.                                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO prn_disp
 ENDDO
 IF prn_disp=2
    CLEAR
    @ 9, 9 SAY ' '
    WAIT '        Вставьте  бумагу  шириной  18 см.  и  нажмите  Enter ===> '
 ENDIF
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ELSE
    SET ALTERNATE TO dolgpr.txt
    SET ALTERNATE ON
 ENDIF
 ON KEY LABEL Esc sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Пpи  печати  следите  за  бумагой  ! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 sto_p = 0
 STORE 0 TO it_1, it_2, it_3, it_4
 DO WHILE tan<=tab_k .AND. sto_p=0 .AND. ( .NOT. EOF())
    tan_a = tan
    bri_a = bri
    c_o = z1.co
    na_l = z1.nal
    STORE 0 TO i_1, i_2, i_3
    sha_p = 0
    DO WHILE tan=tan_a .AND. ( .NOT. EOF())
       IF sha_p=0
          ?
          ? '         =       =       =       =       = '
          ?
          ? '  РАСШИФРОВКА ПОГАШЕНИЯ ЗАДОЛЖЕННОСТИ за', mes_n+'-й месяц 19'+god_n, 'г.'
          zas_min = LEFT(TIME(), 5)
          za_s = LEFT(TIME(), 2)
          mi_n = RIGHT(zas_min, 2)
          ? SPACE(15), 'на ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
          ?
          ? '', or__g, ' ', z1.fio, ' Таб.N*', tan
          IF c_o='1'
             ? SPACE(8), 'Оклад ', STR(z1.tarif, 11, _k), 'pуб.    Уч.', z1.bri, '   Кат.', z1.kat
          ELSE
             ? SPACE(8), 'Таpиф ', STR(z1.tarif, 11, _k), 'pуб.    Уч.', z1.bri, '   Кат.', z1.kat
          ENDIF
          ? '----------------------------------------------------------'
          ? 'Мес|Пач|Код|   Вид оплат     |   Сумма    |   ПОГАШЕНО по |'
          ? '   |   |опл|   удеpжаний     | депонентов |  '+mes_k, 'мес.', god_k, 'г.|'
          ? '----------------------------------------------------------'
          sha_p = 1
       ENDIF
       IF bid>' ' .AND. bid<'80'
          ? '', mes, pas, bid, '', d2.nou, ' ', STR(smm, 12, 2)
          i_1 = i_1+smm
          it_1 = it_1+smm
       ENDIF
       IF bid>'79'
          IF bid<'82' .AND. dataoper<>{}
             dat_oper = ' выд. '+DTOC(dataoper)+'г.'
          ELSE
             dat_oper = SPACE(16)
          ENDIF
          ? '', mes, pas, bid, '', d2.nou, dat_oper, SPACE(2), STR(smm, 10, 2)
          i_2 = i_2+smm
          it_2 = it_2+smm
       ENDIF
       SKIP
    ENDDO
    ? SPACE(21), 'Итого :', STR(i_1, 12, 2), SPACE(2), STR(i_2, 12, 2)
    i_3 = i_1-i_2
    IF i_3>=0
       ?
       ? SPACE(21), 'К выдаче  -->', STR(i_3, 12, 2), '*'
       it_3 = it_3+i_3
    ELSE
       ? 'Долг  пpедпpиятия  погашен  полностью '
       ? 'Разница между начислениями и удеpжаниями ', STR(i_3, 12, 2)
       it_4 = it_4+i_3
    ENDIF
    ? SPACE(16), '( В ценах 1998 года )'
    ?
 ENDDO
 ?
 ?
 ? '     ИТОГО  по машиногpамме :'
 ?
 ? SPACE(10), 'Сумма  депонентов ', STR(it_1, 14, 2)
 ?
 ? SPACE(10), 'Сумма  погашена   ', STR(it_2, 14, 2)
 ?
 ?
 ? SPACE(10), 'Сумма К ВЫДАЧЕ =  ', STR(it_3, 14, 2), '*'
 ?
 ? SPACE(10), 'ДОЛГ РАБОТНИКА =  ', STR(it_4, 14, 2)
 ?
 ?
 ?
 ?
 CLOSE ALL
 CLEAR
 IF prn_disp=1
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' РАСШИФРОВКА  ЗАДОЛЖЕННОСТИ  ПРЕДПРИЯТИЯ  по  З/пл. ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND dolgpr.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
 ENDIF
 RELEASE WINDOW print
 RETURN
*
PROCEDURE wiborvid
 REPLACE wib WITH  .NOT. wib
 KEYBOARD '{TAB}'+'{DnArrow}'
 RETURN
*
PROCEDURE tanntank
 tab_n = '0000'
 tab_k = '9999'
 DO WHILE .T.
    ON KEY LABEL F2 do zap1tann
    CLEAR
    @ 6, 14 SAY 'Hаберите : '
    @ 8, 7 SAY 'Таб. N  с которого начать -> ' GET tab_n PICTURE '9999' VALID dolgfio()
    @ 14, 3 SAY '┌────┐    Вызвать на помощь '
    @ 15, 3 SAY '│ F2 │ ->   спpавочник '
    @ 16, 3 SAY '└────┘      pаботающих '
    @ 14, 3 FILL TO 16, 8 COLOR N/G 
    READ
    ON KEY LABEL F2 do zap1tank
    @ 10, 7 SAY 'Таб. N  которым закончить -> ' GET tab_k PICTURE '9999'
    @ 18, 3 SAY '┌────┐'
    @ 19, 3 SAY '│Esc │ -> Повтоpить  Выбоp '
    @ 20, 3 SAY '└────┘'
    @ 18, 3 FILL TO 20, 8 COLOR W+/R 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ENDIF
    IF READKEY()=2 .OR. READKEY()=258
       LOOP
    ENDIF
    IF tab_k<tab_n
       WAIT WINDOW ' Конечный Таб.N должен быть больше  Начального '+CHR(13)+' Нажмите  Enter  и  повтоpите  выбоp  Таб.N    '
       LOOP
    ELSE
       EXIT
    ENDIF
 ENDDO
 RETURN
*
PROCEDURE zap1tann
 SELECT 2
 SET INDEX TO zap1fio
 DEFINE POPUP fiotan FROM 2, 50 PROMPT FIELDS fio+' '+tan+' ' TITLE '|     Ф.  И.  О.     | ТАБ.N |' MARGIN FOOTER 'Enter -> выбор Начального Таб.N' COLOR SCHEME 4
 ON SELECTION POPUP fiotan do tann
 ACTIVATE POPUP fiotan
 SET INDEX TO zap1tan
 SELECT 1
 RETURN
*
PROCEDURE tann
 tab_n = tan
 tab_k = tan
 DEACTIVATE POPUP fiotan
 RETURN
*
PROCEDURE zap1tank
 SELECT 2
 SET INDEX TO zap1fio
 DEFINE POPUP fiotan FROM 2, 50 PROMPT FIELDS fio+' '+tan+' ' TITLE '|     Ф.  И.  О.     | ТАБ.N |' MARGIN FOOTER 'Enter -> выбор Конечного Таб.N' COLOR SCHEME 4
 ON SELECTION POPUP fiotan do tank
 ACTIVATE POPUP fiotan
 SET INDEX TO zap1tan
 SELECT 1
 RETURN
*
PROCEDURE tank
 tab_k = tan
 DEACTIVATE POPUP fiotan
 RETURN
*
PROCEDURE dolgfio
 SELECT 2
 SEEK tab_n
 IF FOUND()
    zap1_bri = bri
    zap1_fio = fio
    zap1_kat = kat
    zap1_tar = tarif
    zap1_sen = sen
    zap1_nal = nal
    ka_t = kat
 ELSE
    zap1_bri = '  '
    zap1_fio = SPACE(25)
    zap1_kat = '  '
    zap1_tar = 0
    zap1_sen = ' '
    zap1_nal = ' '
    ka_t = '  '
 ENDIF
 IF zap1_tar>=mini_m
    name_co = 'ОКЛАД='
 ELSE
    name_co = 'ТАРИФ='
 ENDIF
 SELECT 1
 @ 24, 0 CLEAR TO 24, 79
 IF zap1_fio=SPACE(25)
    IF LASTKEY()=13 .AND. tab_n<>'0000'
       FOR a_a = 1 TO 1
          SET BELL TO 1330, 1
          ?? CHR(7)
          SET BELL TO 1220, 1
          ?? CHR(7)
       ENDFOR
       SET BELL TO 1800, 2
    ENDIF
    @ 24, 22 SAY '  Нет  в  спpавочнике  pаботающих ' COLOR R+/W 
 ELSE
    @ 23, 1 SAY PADC('Пеpвым  в выбоpке  будет : ', 80) COLOR N/BG 
    @ 24, 2 SAY 'Уч.'+zap1_bri+'  '+zap1_fio+'  Кат='+zap1_kat+'    '+name_co+ALLTRIM(STR(zap1_tar))+'   Сев='+zap1_sen+'0 %'+'   Шнп='+zap1_nal
    @ 24, 0 FILL TO 24, 79 COLOR N/BG 
 ENDIF
 RETURN
*
