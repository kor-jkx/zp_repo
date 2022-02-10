 CLOSE ALL
 SET TALK OFF
 SET SAFETY OFF
 SET TEXTMERGE ON
 SET BELL OFF
 DIMENSION name_mes_r( 12)
 name_mes_r( 01) = 'Января'
 name_mes_r( 02) = 'Февраля'
 name_mes_r( 03) = 'Марта'
 name_mes_r( 04) = 'Апреля'
 name_mes_r( 05) = 'Мая'
 name_mes_r( 06) = 'Июня'
 name_mes_r( 07) = 'Июля'
 name_mes_r( 08) = 'Августа'
 name_mes_r( 09) = 'Сентября'
 name_mes_r( 10) = 'Октября'
 name_mes_r( 11) = 'Ноября'
 name_mes_r( 12) = 'Декабря'
 CLEAR
 ON KEY
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 HIDE POPUP ALL
 DEACTIVATE WINDOW ALL
 CLEAR
 @ 7, 26 SAY ' Идет  подготовка  файлов '
 @ 9, 32 SAY '   Ждите ...' COLOR GR+/RB* 
 SELECT 4
 USE spr1
 gl_buh = glbuh
 i_nn = inn
 USE spr
 orga_n = org
 SELECT 3
 USE znal
 INDEX ON tan+mes TO znal
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 USE zpravnal
 kol_sap = RECCOUNT()
 IF kol_sap=0
    APPEND BLANK
 ENDIF
 GOTO TOP
 @ 18, 0 SAY '  F2  - Расчет текущей  стpоки ( из Налоговой каpточки только в пустые гpафы) ' COLOR N/BG 
 @ 19, 0 SAY '  F12 - Обнуление  Суммовых  гpаф  текущей  стpоки ,  для  пеpеpасчета        ' COLOR N/BG 
 @ 20, 0 SAY '  F1  - Подсказка      F5 - Новая зап.     F8 - Удалить     F9 - Восстановить ' COLOR W+/R 
 @ 21, 4 SAY ' Ctrl+ W --->  Выход  с  сохранением  изменений  ' COLOR N/W 
 @ 21, 4 FILL TO 21, 12 COLOR N/G 
 @ 21, 53 SAY ' F10 - ПЕЧАТЬ СПРАВКИ ДОХ.' COLOR W+/N 
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*СПРАВКА О ДОХОДАХ*)"
 ON KEY LABEL F2 do awtosifr
 ON KEY LABEL F5 append blank
 ON KEY LABEL F8 delete
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 do sprdox
 ON KEY LABEL F12 do obnul
 DEFINE WINDOW korr FROM 2, 0 TO 17, 79 TITLE '  Ввод - корректировка  СПРАВОК  ДОХОДОВ  ФИЗИЧЕСКИХ  ЛИЦ  для  ГОСНИ '
 n_e = 0
 ta_n = '0000'
 net_tan_n = 0
 BROWSE FIELDS god :H = 'Год ', tan :H = 'Таб.' :V = namefio2() :F, fio :H = '      Ф.  И.  О.         ', serij :H = 'Сеpия', nomerp :H = 'N пасп.', datarosd :H = 'Дата pожд', obl :H = 'ОБЛАСТЬ', gorod :H = 'ГОРОД', adres :H = 'Улица Дом Кваpтиpа' :W = cle_ar(), valsowdox :H = 'ВАЛ.ДОХОД' :W = message1(), nameskid :H = 'Наимен.скидки из дохода' :W = message2(), dohskid :H = 'Сум.Дох.со скид.' :W = message3(), sumskid :H = 'Сум.Скидки' :W = message4(), oblskid :H = 'Сум.вкл в дох' :W = message5(), sn :H = 'Сев.Надбав' :W = message6(), sumv :H = 'ВЫЧЕТЫ из ДОХОДА' :W = message7(), sumv85 :H = 'Пенсионн' :W = message8(), minstaw :H = '1(3,5) мин.опл.' :W = message9(), deti :H = 'Дети и ижд.' :W = message10(), proch :H = 'Прочие' :W = message11(), vsgd :H = 'Обл.Осн.Дох.' :W = message12(), oblsn :H = 'Обл.Сев.Над' :W = message13(), nalvsgd :H = 'Под.с Осн.дох.' :W = message14(), nalsn :H = 'Под.с Сев.над.' :W = message15(), un :H = 'Итог Подоход' :W = message16(), sum85sev :H = 'Пенс.с Сев' :W = message17() :V = tt(1) :F NOMENU WINDOW korr WHEN namefio3() COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 DO udalenie
 CLEAR
 CLOSE ALL
 ON KEY
 RETURN
*
PROCEDURE cle_ar
 @ 23, 0 CLEAR TO 23, 79
*
PROCEDURE message1
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY '  п.8  ЗДЕСЬ  ВЕСЬ  ДОХОД,  КРОМЕ  СЕВЕРНЫХ  НАДБАВОК '
*
PROCEDURE message2
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.8.2 (гp.1) ЭТО : МАТЕРИАЛЬНАЯ ПОМОЩЬ, ПРИЗЫ, ПОДАРКИ, НАТУРОПЛАТА  и т.п.'
*
PROCEDURE message3
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.8.2 (гp.2) СУММА  МАТЕРИАЛ.ПОМОЩИ, ПРИЗОВ, ПОДАРКОВ, НАТУРОПЛАТЫ  и т.п.'
*
PROCEDURE message4
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.8.2(гp.3) СУММА СКИДОК  искл.пpи облож.МАТЕРИАЛ.ПОМОЩИ, ПРИЗОВ,ПОДАРКОВ...'
*
PROCEDURE message5
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.8.2 (гp.3)  ОБЛАГ.СУММА : МАТЕРИАЛ.ПОМОЩИ, ПРИЗОВ, ПОДАРКОВ, НАТУРОПЛ ...'
*
PROCEDURE message6
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.9   ЗДЕСЬ  СУММА  СЕВЕРНЫХ  НАДБАВОК ( скидки  еще  НЕ  сминусованы)'
*
PROCEDURE message7
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.10   ЗДЕСЬ   ВСЕ  ВЫЧЕТЫ  ПОЛНОСТЬЮ  ( с ОСНОВН.ДОХОДА  и  СЕВ. НАДБАВОК )'
*
PROCEDURE message8
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.10.1 ЗДЕСЬ  ОБЩАЯ  СУММА  ПЕНСИОННОГО ( с ОСНОВН.ДОХОДА  и  СЕВ. НАДБАВОК )'
*
PROCEDURE message9
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.10.2  СУММА ВЫЧЕТОВ ПОЛОЖЕННЫХ  САМОМУ ПЛАТЕЛЬЩИКУ, БЕЗ СКИДОК на ДЕТЕЙ '
*
PROCEDURE message10
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.10.3  СУММА  ВЫЧЕТОВ  ПОЛАГАЮЩИХСЯ  на  ДЕТЕЙ и ИЖДЕВЕНЦЕВ '
*
PROCEDURE message11
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.10.5  СУММЫ БЛАГОТВ.ЦЕЛЕЙ,  СТРОИТ.,КУПЛЯ ДОМОВ, КВАР.,ДАЧ, ИЗБИР.ФОНДЫ ДЕП.'
*
PROCEDURE message12
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY '  п.11  ЗДЕСЬ  ОБЛАГАЕМЫЙ  ОСНОВНОЙ  ДОХОД  ( т.е. ОСНОВНОЙ ДОХОД - ВЫЧЕТЫ )'
*
PROCEDURE message13
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' п.12  ЗДЕСЬ ОБЛАГАЕМАЯ СУММА СЕВ.НАДБАВОК  ( CЕВ.НАДБ. - ПЕНСИОННЫЙ с них )'
*
PROCEDURE message14
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY '  п.13  СУММА  ПОДОХОДНОГО  с ОСНОВНОГО ДОХОДА ( от СУММЫ   в  п.11 )'
*
PROCEDURE message15
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY '  п.14  СУММА  ПОДОХОДНОГО   с  СЕВ. НАДБАВОК  ( от СУММЫ  в  п.12 )'
*
PROCEDURE message16
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' ИТОГО ОБЩАЯ  СУММА ПОДОХОДНОГО ( нужна для pасч.налога с Осн.дох и Сев.над.)'
*
PROCEDURE message17
 @ 23, 0 CLEAR TO 23, 79
 @ 23, 0 SAY ' СУММА ПЕНСИОННОГО  с  СЕВЕРНЫХ НАДБАВОК  ( будет pассчитана автоматически )'
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
PROCEDURE namefio2
 IF net_tan_n=1
    RETURN
 ENDIF
 ta_n = tan
 SELECT 2
 SEEK ta_n
 IF FOUND()
    zap1_fio = fio
    dat_rosd = datarosd
 ELSE
    zap1_fio = SPACE(25)
    dat_rosd = SPACE(8)
 ENDIF
 SELECT 1
 @ 23, 0 CLEAR TO 23, 79
 IF zap1_fio=SPACE(25)
    @ 23, 0 SAY '  Нет такого ТАБ.N   в спpавочнике  pаботающих ' COLOR R+/W 
 ELSE
    @ 23, 0 SAY '  '+zap1_fio+' в спpавочнике  по этому Таб.N ' COLOR N/BG 
    IF fio=' '
       REPLACE fio WITH zap1_fio
       REPLACE datarosd WITH dat_rosd
    ENDIF
 ENDIF
 RETURN
*
PROCEDURE namefio3
 @ 23, 0 CLEAR TO 24, 79
 @ 24, 2 SAY fio+' адpес: '+adres+' Паспоpт:'+serij+STR(nomerp, 7)
 @ 24, 0 FILL TO 24, 79 COLOR N/BG 
 RETURN
*
PROCEDURE awtosifr
 PUSH KEY CLEAR
 ta_n = tan
 STORE 0 TO i_1, i_2, i_3, i_4, i_5, i_6, i_7, i_8, i_9, i_10, i_11, i_12, i_13
 IF ta_n<>'    '
    SELECT 3
    SEEK ta_n
    IF FOUND()
       WAIT WINDOW TIMEOUT 0.3 ' Идет  pасчет ... '
       DO WHILE tan=ta_n .AND. ( .NOT. EOF())
          i_1 = i_1+valsowdox
          i_2 = i_2+dohskid
          i_3 = i_3+sumskid
          i_5 = i_5+sn
          i_6 = i_6+sumv
          IF bid='85'
             i_7 = i_7+sumv
          ENDIF
          IF bid='  ' .AND. nal>'0' .AND. sumv>0
             IF nal='1'
                i_8 = i_8+sumv
             ELSE
                i_8 = i_8+(sumv/VAL(nal))
                i_9 = i_9+sumv-(sumv/VAL(nal))
             ENDIF
          ENDIF
          i_11 = i_11+vsgd
          i_12 = i_12+un
          SKIP
       ENDDO
       i_4 = i_2-i_3
       i_10 = i_6-i_7-i_8-i_9
    ELSE
       net_tan_n = 1
       DEFINE WINDOW netsap FROM 5, 50 TO 11, 77 TITLE ' К  сожалению ! ' DOUBLE COLOR W+/R 
       ACTIVATE WINDOW netsap
       @ 1, 2 SAY ' Нет такого Табельного '
       @ 2, 2 SAY 'в Налоговой Каpточке  !'
       @ 3, 2 SAY 'СЧИТАЮ  ТОЛЬКО  ПУСТЫЕ '
       @ 4, 2 SAY ' ГРАФЫ ТЕКУЩЕЙ СТРОКИ  '
       WAIT WINDOW ' Для  продолжения  нажмите  Enter '
       DEACTIVATE WINDOW netsap
       RELEASE WINDOW netsap
       net_tan_n = 0
    ENDIF
    SELECT 1
 ELSE
    net_tan_n = 1
    DEFINE WINDOW netsap FROM 5, 50 TO 11, 77 TITLE ' ЧТО ДЕЛАТЬ  ? ' DOUBLE COLOR W+/R 
    ACTIVATE WINDOW netsap
    @ 1, 2 SAY ' ВЫ  НЕ УКАЗАЛИ ТАБ.N  '
    @ 2, 2 SAY 'КОГО  ИСКАТЬ в КАРТОЧКЕ'
    @ 3, 2 SAY 'СЧИТАЮ  ТОЛЬКО  ПУСТЫЕ '
    @ 4, 2 SAY ' ГРАФЫ ТЕКУЩЕЙ СТРОКИ  '
    WAIT WINDOW ' Для  продолжения  нажмите  Enter '
    DEACTIVATE WINDOW netsap
    RELEASE WINDOW netsap
    net_tan_n = 0
 ENDIF
 IF valsowdox=0
    REPLACE valsowdox WITH (i_1-i_5)
 ENDIF
 IF nameskid=' '
 ENDIF
 IF dohskid=0
    REPLACE dohskid WITH i_2
 ENDIF
 IF sumskid=0
    REPLACE sumskid WITH i_3
 ENDIF
 IF oblskid=0
    REPLACE oblskid WITH i_4
 ENDIF
 IF sn=0
    REPLACE sn WITH i_5
 ENDIF
 IF sumv=0
    REPLACE sumv WITH i_6
 ENDIF
 IF sumv85=0
    REPLACE sumv85 WITH i_7
 ENDIF
 IF minstaw=0
    REPLACE minstaw WITH i_8
 ENDIF
 IF deti=0
    REPLACE deti WITH i_9
 ENDIF
 IF proch=0
    REPLACE proch WITH i_10
 ENDIF
 IF un=0
    REPLACE un WITH i_12
 ENDIF
 IF sum85sev=0
    REPLACE sum85sev WITH INT(sn)*0.01 
 ENDIF
 v_bes85sev = sumv-sum85sev
 obl_osndox = valsowdox-sumskid-v_bes85sev
 IF obl_osndox>0
    IF vsgd=0
       REPLACE vsgd WITH obl_osndox
    ENDIF
    IF oblsn=0
       REPLACE oblsn WITH sn-sum85sev
    ENDIF
    IF nalsn=0
       REPLACE nalsn WITH INT(oblsn)*0.12 
    ENDIF
    IF nalvsgd=0
       IF un-nalsn>0
          REPLACE nalvsgd WITH un-nalsn
       ELSE
          REPLACE nalvsgd WITH 0
          REPLACE nalsn WITH un
       ENDIF
    ENDIF
 ELSE
    REPLACE vsgd WITH 0
    REPLACE nalvsgd WITH 0
    REPLACE nalsn WITH un
    i_13 = valsowdox+sn-sumv
    IF i_13<0
       i_13 = 0
    ENDIF
    REPLACE oblsn WITH i_13
 ENDIF
 POP KEY
 RETURN
*
PROCEDURE obnul
 WAIT WINDOW TIMEOUT 0.3 ' ОБНУЛЕНО ! '
 REPLACE valsowdox WITH 0
 REPLACE dohskid WITH 0
 REPLACE sumskid WITH 0
 REPLACE oblskid WITH 0
 REPLACE sn WITH 0
 REPLACE sumv WITH 0
 REPLACE sumv85 WITH 0
 REPLACE minstaw WITH 0
 REPLACE deti WITH 0
 REPLACE proch WITH 0
 REPLACE vsgd WITH 0
 REPLACE oblsn WITH 0
 REPLACE un WITH 0
 REPLACE nalvsgd WITH 0
 REPLACE nalsn WITH 0
 REPLACE sum85sev WITH 0
 RETURN
*
PROCEDURE sprdox
 DEFINE WINDOW sprdox FROM 7, 9 TO 15, 69 TITLE ' ПЕЧАТЬ  СПРАВКИ  о  ДОХОДАХ '
 PUSH KEY CLEAR
 ACTIVATE WINDOW sprdox
 SET COLOR OF HIGHLIGHT TO W+/R*
 @ 1, 19 SAY ' ВКЛЮЧИТЕ  ПРИHТЕР '
 @ 3, 12 SAY ' Вставьте  бумагу  шиpиной  21  см. '
 @ 5, 17 PROMPT '  ПЕЧАТЬ  ' MESSAGE ' Получатель  СПРАВКИ  ---> '+ALLTRIM(fio)
 @ 5, 31 PROMPT '  ВЫХОД   ' MESSAGE ' <-- ВЫХОД  БЕЗ  ПЕЧАТИ --> '
 MENU TO pec_h
 ?
 CLEAR
 IF pec_h=1
    SET PRINTER ON
    TEXT
                                                        Приложение N 3
                                        к Инструкции Госналогслужбы РФ
                                        от 29 июня 1995г. N 35
 В Государственную налоговую инспекцию
     по г.Коряжме
                       x1 Справка о доходах x0
                   физического лица за <<GOD>> год.

    Данные предприятия,учреждения,организации или иного работодателя:
    1.Наименование x1 <<orga_n>> x0
    2.Идентификационный номер налогоплательщика x1 <<str(i_nn)>>x0

    Данные физического лица,которому выплачен доход:
    1.Фамилия Имя Отчество x1 <<AllTrim(FIO)>> x0
    2.Вид документа паспорт Серия x1 <<SERIJ>> x0 Номер  x1 <<NOMERP>> x0
    3.Дата рождения x1 <<DATAROSD>>г. x0
    4.Страна проживания нерезидента x1 Российская Федерация x0
    5.Адрес постоянного местожительства в Российской Федерации:
      x1 <<AllTrim(OBL)+" обл. г. " +AllTrim(GOROD)+" "+AllTrim(ADRES)>> x0
    6.Доход получен по основному,не основному месту работы(нужное под-
  черкнуть)
    7.За какие периоды получен доход
       -----------------------------------------------------------
      | 01 | 02 | 03 | 04 | 05 | 06 | 07 | 08 | 09 | 10 | 11 | 12 |
       -----------------------------------------------------------
    8.Сумма валового совокупного дохода x1 <<VALSOWDOX>>x0 руб., в том числе:
    8.1.Доход,полностью включаемый в состав валового совокупного годо-
  вого дохода x1 <<VALSOWDOX-DOHSKID>> x0 руб.
    8.2.Доходы,которые в соответствии с законом,в том  числе  законами
  субьектов Российской  Федерации, не включаются в совокупный облагаемый
  доход,либо по которым установлены скидки, авторские вознаграждения,до-
  ходы,выплаченные физическим лицам, налогооблажение которых осуществля-
  ется налоговыми органами:
    -------------------------------------------------------------------
   |Наименование вида дохода|Сумма дохода|Сумма скидки,|Сумма, включ. в|
   |вида деятельности       |            |расходов     |вал.год. доход |
   |-------------------------------------------------------------------|
   |<<NAMESKID>>| <<str(DOHSKID,11,_k)>>|  <<str(SUMSKID,11,_k)>>|    <<str(OBLSKID,11,_k)>>|
    -------------------------------------------------------------------
    9.Сумма коэффициентов и надбавок за стаж работы  в  местностях  с
      особыми условиями x1 <<SN>>x0 pуб.
    10.Из дохода произведены следующие, установленные  законом вычеты
       на общую сумму x1 <<SUMV>>x0 pуб.
    в том числе:
    10.1.Отчислений в пенсионный фонд x1 <<SUMV85>>x0 pуб.
    10.2.Одно-(трех-,пяти-)кратной минимальной месячной оплаты  труда
       или дохода, обл. налогом по минимальной ставке x1 <<MINSTAW>>x0 pуб.
    10.3.Расходы на содержение детей и иждивенцев x1 <<DETI>>x0 pуб.
    10.5.Прочее x1 <<PROCH>>x0 pуб.
    11.Облагаемый совокупный годовой доход x1 <<VSGD>>x0 pуб.
    12.Облагаемая сумма коэффициентов и надбавок  за  стаж  работы  в
       местностях с особыми условиями x1 <<OBLSN>>x0 pуб.
    13.Сумма удержанного подоходного налога  с  совокупного  годового
       дохода x1 <<NALVSGD>>x0 pуб.
    14.Сумма удержанного подоходного налога с суммы коэффициентов  и
       надбавок за стаж работы в местностях с особ. усл. x1<<NALSN>>x0 pуб.

     Печать            Гл.бухгалтер            <<gl_buh>>

           <<Str(Day(Date()),2)+" "+Name_Mes_R(Month(Date()))+" "+Str(Year(Date()),4)+" года">>
    ENDTEXT
    ? CHR(15)
    WAIT
    ? SPACE(9), 'Примечание:  Справка о доходах заполняется машинописным текстом. Исправления не допускаются.'
    ? CHR(18)
    ?
    ?
    ?
    SET PRINTER OFF
 ENDIF
 DEACTIVATE WINDOW sprdox
 RELEASE WINDOW sprdox
 SET COLOR OF HIGHLIGHT TO W+/R
 POP KEY
 RETURN
*
