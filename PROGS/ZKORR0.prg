 CLOSE ALL
 SET STATUS ON
 SET BELL OFF
 SET TALK OFF
 SET SAFETY OFF
 DEACTIVATE WINDOW ALL
 CLEAR
 PUBLIC nazal_o, br_i, ta_n, ka_t, bi_d
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 DEFINE POPUP kor0 FROM 4, 2 SHADOW MARGIN RELATIVE COLOR SCHEME 4
 kor_r = 0
 DO WHILE kor_r=0
    use_zap3 = 0
    use_zap4 = 0
    use_zap3p = 0
    use_zap4p = 0
    use_z4r = 0
    use_znal = 0
    pus_k = 0
    ruki_sum = 0
    met_nar = 0
    use_79 = 0
    use_92 = 0
    old_pas = ''
    pas = ''
    n_pas = ''
    k_pas = ''
    min_pas = ''
    max_pas = ''
    CLEAR
    DEFINE BAR 1 OF kor0 PROMPT ' 1. КОРРЕКТИРОВКА  МЕСЯЧНЫХ  HАЧИСЛЕHИЙ    ( файл   zap3.dbf )'
    DEFINE BAR 2 OF kor0 PROMPT ' 2.                          УДЕРЖАHИЙ     ( файл   zap4.dbf )'
    DEFINE BAR 3 OF kor0 PROMPT ' 3. КОРРЕКТИРОВКА  ПОСТОЯHHЫХ  HАЧИСЛЕHИЙ  ( файл  zap3p.dbf )'
    DEFINE BAR 4 OF kor0 PROMPT ' 4.                            УДЕРЖАHИЙ   ( файл  zap4p.dbf )'
    DEFINE BAR 5 OF kor0 PROMPT ' 5. Коpp. % по ИСП.ЛИСТАМ и ЧАСТЕЙ по Алим.( файл   z4pr.dbf )'
    DEFINE BAR 6 OF kor0 PROMPT ' 6. ОБЛАГАЕМЫЕ  СУММЫ  с  НАЧАЛА  ГОДА     ( файл   znal.dbf )'
    DEFINE BAR 7 OF kor0 PROMPT ' 7. МАССИВ  ДОЛГОВ  Пpедпpиятия (Депоненты)( файл  zap79.dbf )'
    DEFINE BAR 8 OF kor0 PROMPT ' 8. МАССИВ  ДОЛГОВ  РАБОТНИКА              ( файл  zap92.dbf )'
    DEFINE BAR 9 OF kor0 PROMPT '                 ВЫХОД  -->  Esc ' MESSAGE ' ВЫХОД  в Главное  МЕНЮ '
    ON SELECTION BAR 1 OF kor0 do kor1
    ON SELECTION BAR 2 OF kor0 do kor2
    ON SELECTION BAR 3 OF kor0 do kor3
    ON SELECTION BAR 4 OF kor0 do kor4
    ON SELECTION BAR 5 OF kor0 do kor5
    ON SELECTION BAR 6 OF kor0 do kor6
    ON SELECTION BAR 7 OF kor0 do kor7
    ON SELECTION BAR 8 OF kor0 do kor8
    ON SELECTION BAR 9 OF kor0 do vixod
    ACTIVATE POPUP kor0
    IF LASTKEY()=27
       DO vixod
    ENDIF
 ENDDO
 RETURN
*
PROCEDURE vixod
 kor_r = 1
 CLOSE ALL
 CLEAR
 DEACTIVATE POPUP kor0
 SHOW POPUP popwork
 ON KEY
 RETURN
*
PROCEDURE kor3
 use_zap3p = 1
 DO kor1
 RETURN
*
PROCEDURE kor4
 use_zap4p = 1
 DO kor2
 RETURN
*
PROCEDURE kor1
 CLOSE ALL
 CLEAR
 es_zip = 0
 no_edit = ' '
 IF FILE ("&fail_zip")
    DO eszip
 ENDIF
 use_zap3 = 1
 DO nazalo
 SELECT 4
 USE svoud
 SET FILTER TO bid<='79'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 IF use_zap3p=0
    USE zap3
    n_pas = '000'
    k_pas = '170'
    min_pas = '000'
    max_pas = '170'
    kol_sap = RECCOUNT()
    IF kol_sap=0
       APPEND BLANK
    ENDIF
    met_nar = 1
 ENDIF
 IF use_zap3p=1
    USE zap3p
    n_pas = '171'
    k_pas = '199'
    min_pas = '171'
    max_pas = '199'
    kol_sap = RECCOUNT()
    IF kol_sap=0
       APPEND BLANK
    ENDIF
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 1 SAY PADC(' Идет  Индексация  НАЧИСЛЕНИЙ  по ТАБ. N  и  В/О  ...', 80)
    INDEX ON tan+bid TO zap3
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 1 SAY PADC(' Идет  Индексация  НАЧИСЛЕНИЙ  по Участкам,  Таб. N  и  В/О ...', 80)
    INDEX ON bri+tan+bid TO zap3
 ENDIF
 IF nazal_o=4
    CLEAR
    @ 9, 12 SAY ' Идет  Индексация  НАЧИСЛЕНИЙ  по НОМЕРАМ  ПАЧЕК  ДОКУМЕНТОВ ...'
    INDEX ON pas TO zap3
 ENDIF
 IF nazal_o=5
    CLEAR
    @ 9, 17 SAY ' Идет  Индексация  НАЧИСЛЕНИЙ  по  СУММЕ ...'
    INDEX ON smm TO zap3
 ENDIF
 IF nazal_o=6
    CLEAR
    @ 9, 17 SAY ' Идет  Индексация  НАЧИСЛЕНИЙ  по  ВИДАМ  ОПЛАТ ...'
    INDEX ON bid TO zap3
 ENDIF
 GOTO TOP
 @ 18, 0 SAY '  F1 - Помощь     F2 -Шифp Таб.N      F3 -Шифp Участка     F4 -Шифp Вида Оплат '
 @ 18, 00 FILL TO 18, 79 COLOR BG+/RB 
 @ 18, 02 FILL TO 18, 03 COLOR N/W 
 @ 18, 18 FILL TO 18, 19 COLOR N/W 
 @ 18, 38 FILL TO 18, 39 COLOR N/W 
 @ 18, 59 FILL TO 18, 60 COLOR N/W 
 @ 19, 0 SAY 'F5 -Новая зап.  F6 -Сумма по Пачке  F7 -Поиск по Таб.N*  F8 -Удал.  F9 -Восст.'
 @ 19, 00 FILL TO 19, 79 COLOR W+/R 
 @ 19, 00 FILL TO 19, 01 COLOR N/W 
 @ 19, 16 FILL TO 19, 17 COLOR N/W 
 @ 19, 36 FILL TO 19, 37 COLOR N/W 
 @ 19, 57 FILL TO 19, 58 COLOR N/W 
 @ 19, 68 FILL TO 19, 69 COLOR N/W 
 @ 20, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 20, 4 FILL TO 20, 7 COLOR N/W 
 @ 20, 11 FILL TO 20, 13 COLOR N/W 
 @ 20, 15 FILL TO 20, 55 COLOR N/G 
 @ 21, 0 SAY 'F11 --> Доступ  к метке pасчета  R    F12 --> Запpет Доступа  к метке  R'
 @ 21, 0 FILL TO 21, 2 COLOR N/W 
 @ 21, 38 FILL TO 21, 40 COLOR N/W 
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*КОРРЕКТИРОВКА НАЧИСЛЕНИЙ*)"
 ON KEY LABEL F2 do zap1
 ON KEY LABEL F3 do spodr
 ON KEY LABEL F4 do svoud
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 do sumpas
 ON KEY LABEL F7 do poisk
 IF es_zip=0
    ON KEY LABEL F8 delete
 ELSE
    ON KEY LABEL F8 pust_o=0
 ENDIF
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 ON KEY LABEL F11 n_e=1
 ON KEY LABEL F12 n_e=0
 n_e = 0
 f1_f12 = 0
 minmax_pas = ' от '+min_pas+' до '+max_pas
 BROWSE fields M:W=n_e=1, MES:H='Мес', PAS:V=validpas().and.PAS>=min_pas.and.PAS<=max_pas:E='Допускается  N Пачки '+minmax_pas:H='Пач', BRI:H='Уч', KAT:H='Кат', TAN:H='Таб.', BID:V=validvid().and.BID>='01'.and.BID<='79':E='В/О допускается  от  01 до 79':H='В/О', SMM:H='СУММА НАЧ.', DNI:H='ДНИ', CHAS:H='ЧАСЫ', SHPZ:H='Ш П З', TARIF:H='ТАРИФ-ОКЛ', NORMZ:H='ЧАС.НОРМ', KUS:H=' % ':V=tt(1):f WHEN namefio1() window KORR color scheme 10 nomenu &no_edit
 DEACTIVATE WINDOW korr
 met_nar = 1
 DO konez
*
PROCEDURE kor2
 CLOSE ALL
 CLEAR
 es_zip = 0
 no_edit = ' '
 IF FILE ("&fail_zip")
    DO eszip
 ENDIF
 use_zap4 = 1
 DO nazalo
 SELECT 4
 USE svoud
 SET FILTER TO bid>='80'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 IF use_zap4p=0
    USE zap4
    n_pas = '200'
    k_pas = '370'
    min_pas = '200'
    max_pas = '370'
    kol_sap = RECCOUNT()
    IF kol_sap=0
       APPEND BLANK
    ENDIF
 ENDIF
 IF use_zap4p=1
    USE zap4p
    n_pas = '371'
    k_pas = '400'
    min_pas = '371'
    max_pas = '400'
    kol_sap = RECCOUNT()
    IF kol_sap=0
       APPEND BLANK
    ENDIF
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 1 SAY PADC(' Идет  Индексация  УДЕРЖАНИЙ   по Таб.N  и  В/У...', 80)
    INDEX ON tan+bid TO zap4
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 1 SAY PADC(' Идет  Индексация  УДЕРЖАНИЙ  по Участкам,  Таб. N  и  В/У ...', 80)
    INDEX ON bri+tan+bid TO zap4
 ENDIF
 IF nazal_o=4
    CLEAR
    @ 9, 12 SAY ' Идет  Индексация  УДЕРЖАНИЙ  по НОМЕРАМ  ПАЧЕК  ДОКУМЕНТОВ ...'
    INDEX ON pas TO zap4
 ENDIF
 IF nazal_o=5
    CLEAR
    @ 9, 17 SAY ' Идет  Индексация  УДЕРЖАНИЙ  по  СУММЕ ...'
    INDEX ON smm TO zap4
 ENDIF
 IF nazal_o=6
    CLEAR
    @ 9, 15 SAY ' Идет  Индексация  УДЕРЖАНИЙ   по  ВИДАМ  УДЕРЖАНИЙ ...'
    INDEX ON bid TO zap4
 ENDIF
 GOTO TOP
 @ 19, 0 SAY '  F1 - Помощь     F2 -Шифp Таб.N      F3 -Шифp Участка     F4 -Шифp Вида Удеpж.'
 @ 19, 00 FILL TO 19, 79 COLOR BG+/RB 
 @ 19, 02 FILL TO 19, 03 COLOR N/W 
 @ 19, 18 FILL TO 19, 19 COLOR N/W 
 @ 19, 38 FILL TO 19, 39 COLOR N/W 
 @ 19, 59 FILL TO 19, 60 COLOR N/W 
 @ 20, 0 SAY 'F5 -Новая зап.  F6 -Сумма по Пачке  F7 -Поиск по Таб.N*  F8 -Удал.  F9 -Восст.'
 @ 20, 00 FILL TO 20, 79 COLOR W+/R 
 @ 20, 00 FILL TO 20, 01 COLOR N/W 
 @ 20, 16 FILL TO 20, 17 COLOR N/W 
 @ 20, 36 FILL TO 20, 37 COLOR N/W 
 @ 20, 57 FILL TO 20, 58 COLOR N/W 
 @ 20, 68 FILL TO 20, 69 COLOR N/W 
 @ 21, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 21, 4 FILL TO 21, 7 COLOR N/W 
 @ 21, 11 FILL TO 21, 13 COLOR N/W 
 @ 21, 15 FILL TO 21, 55 COLOR N/G 
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*КОРРЕКТИРОВКА УДЕРЖАНИЙ*)"
 ON KEY LABEL F2 do zap1
 ON KEY LABEL F3 do spodr
 ON KEY LABEL F4 do svoud
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 do sumpas
 ON KEY LABEL F7 do poisk
 IF es_zip=0
    ON KEY LABEL F8 delete
 ELSE
    ON KEY LABEL F8 pust_o=0
 ENDIF
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 n_e = 0
 f1_f12 = 0
 minmax_pas = ' от '+min_pas+' до '+max_pas
 BROWSE fields M:W=n_e=1, MES:H='Мес', PAS:V=validpas().and.PAS>=min_pas.and.PAS<=max_pas:E='Допускается  N Пачки '+minmax_pas:H='Пач', ORDER:H='N Оpдеpа', DATAOPER:H='Дата опеp.', BRI:H='Уч', TAN:H='Таб.', BID:H='В/У', SMM:H='СУММА УДЕРЖ.':V=tt(1):f WHEN namefio1() window KORR color scheme 10 nomenu &no_edit
 DEACTIVATE WINDOW korr
 DO konez
*
PROCEDURE kor5
 CLOSE ALL
 CLEAR
 es_zip = 0
 no_edit = ' '
 IF FILE ("&fail_zip")
    DO eszip
 ENDIF
 use_z4pr = 1
 DO nazalo
 SELECT 4
 USE svoud
 SET FILTER TO bid>='80'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 USE z4pr
 n_pas = 'A1 '
 k_pas = 'I99'
 min_pas = 'A1 '
 max_pas = 'I99'
 kol_sap = RECCOUNT()
 IF kol_sap=0
    APPEND BLANK
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 20 SAY ' Идет  Индексация   по ТАБ. N* ...'
    INDEX ON tan TO z4pr
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 18 SAY ' Идет  Индексация  по Участку  и  Таб. N* ...'
    INDEX ON bri+tan TO z4pr
 ENDIF
 IF nazal_o=4
    CLEAR
    @ 9, 18 SAY ' Идет  Индексация  по НОМЕРАМ  ПАЧЕК  ДОКУМЕНТОВ ...'
    INDEX ON pas TO z4pr
 ENDIF
 GOTO TOP
 @ 19, 0 SAY '  F1 - Помощь     F2 -Шифp Таб.N      F3 -Шифp Участка     F4 -Шифp Вида Удеpж.'
 @ 19, 00 FILL TO 19, 79 COLOR BG+/RB 
 @ 19, 02 FILL TO 19, 03 COLOR N/W 
 @ 19, 18 FILL TO 19, 19 COLOR N/W 
 @ 19, 38 FILL TO 19, 39 COLOR N/W 
 @ 19, 59 FILL TO 19, 60 COLOR N/W 
 @ 20, 0 SAY 'F5 -Новая зап.                      F7 -Поиск по Таб.N*  F8 -Удал.  F9 -Восст.'
 @ 20, 00 FILL TO 20, 79 COLOR W+/R 
 @ 20, 00 FILL TO 20, 01 COLOR N/W 
 @ 20, 36 FILL TO 20, 37 COLOR N/W 
 @ 20, 57 FILL TO 20, 58 COLOR N/W 
 @ 20, 68 FILL TO 20, 69 COLOR N/W 
 @ 21, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 21, 4 FILL TO 21, 7 COLOR N/W 
 @ 21, 11 FILL TO 21, 13 COLOR N/W 
 @ 21, 15 FILL TO 21, 55 COLOR N/G 
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*КОРРЕКТИРОВКА АЛИМЕНТОВ*)"
 ON KEY LABEL F2 do zap1
 ON KEY LABEL F3 do spodr
 ON KEY LABEL F4 do svoud
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 pusto=0
 ON KEY LABEL F7 do poisk
 IF es_zip=0
    ON KEY LABEL F8 delete
 ELSE
    ON KEY LABEL F8 pust_o=0
 ENDIF
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 f1_f12 = 0
 minmax_pas = ' от '+min_pas+' до '+max_pas
 BROWSE fields MES:H='Мес', PAS:H='Пач':W=paz_ka(), PAS:V=validpas().and.PAS>=min_pas.and.PAS<=max_pas:E='Допускается  N Пачки '+minmax_pas:H='Пач', BRI:H='Уч', TAN:H='Таб.', BID:H='В/О', KUS:H=' % ':W=paz_ka(), CHISL:H='Числитель':W=paz_ka(), ZNAM:H='Знаменатель', SBOR:H='Почт.сб.%', ADRES1:H=' КУДА  1-я стpока ', ADRES2:H=' КУДА  2-я стpока ', ADRES3:H=' КУДА  3-я стpока ', ADRES4:H=' КУДА  4-я стpока ', KOMU1:H=' КОМУ 1-я стp. ', KOMU2:H=' КОМУ 2-я стp. ', KOMU3:H=' КОМУ 3-я стp. ', KOMU4:H=' КОМУ 4-я стp. ', M:H='М':V=tt(1):f WHEN namefio1() window KORR color scheme 10 nomenu &no_edit
 DEACTIVATE WINDOW korr
 DO konez
*
PROCEDURE kor6
 CLOSE ALL
 CLEAR
 es_zip = 0
 no_edit = ' '
 IF FILE ("&fail_zip")
    DO eszip
 ENDIF
 use_znal = 1
 DO nazalo
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 USE znal
 kol_sap = RECCOUNT()
 IF kol_sap=0
    APPEND BLANK
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 9 SAY ' Идет  Индексация  НАЛОГОВОГО МАССИВА   по ТАБ. N* и  Месяцу ...'
    INDEX ON tan+mes TO znal
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 6 SAY ' Идет  Индексация  НАЛОГОВОГО МАССИВА  по Участку, Таб. N*, Месяцу ...'
    INDEX ON bri+tan+mes TO znal
 ENDIF
 GOTO TOP
 @ 19, 0 SAY '  F1 - Помощь             F2 -Шифpовка Таб.N         F3 -Шифpовка  Участка '
 @ 19, 00 FILL TO 19, 79 COLOR BG+/RB 
 @ 19, 02 FILL TO 19, 03 COLOR N/W 
 @ 19, 26 FILL TO 19, 27 COLOR N/W 
 @ 19, 53 FILL TO 19, 54 COLOR N/W 
 @ 20, 0 SAY 'F5 -Новая зап.       F7 -Поиск по Таб.N*    F8 -Удаление   F9 -Восстановление '
 @ 20, 00 FILL TO 20, 79 COLOR W+/R 
 @ 20, 00 FILL TO 20, 01 COLOR N/W 
 @ 20, 21 FILL TO 20, 22 COLOR N/W 
 @ 20, 44 FILL TO 20, 45 COLOR N/W 
 @ 20, 59 FILL TO 20, 60 COLOR N/W 
 @ 21, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 21, 4 FILL TO 21, 7 COLOR N/W 
 @ 21, 11 FILL TO 21, 13 COLOR N/W 
 @ 21, 15 FILL TO 21, 55 COLOR N/G 
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*КОРРЕКТИРОВКА ОБЛАГАЕМЫХ СУММ*)"
 ON KEY LABEL F2 do zap1
 ON KEY LABEL F3 do spodr
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 pust_o=0
 ON KEY LABEL F7 do poisk
 IF es_zip=0
    ON KEY LABEL F8 delete
 ELSE
    ON KEY LABEL F8 pust_o=0
 ENDIF
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 BROWSE fields MES:H='Мес', BRI:H='Уч', TAN:H='Таб.', NAL:H='ШHП', VALSOWDOX:H='ВАЛ.ДОХОД', DOHSKID:H='Мат.Помощ', SUMSKID:H='Скид.М.П', VSGD:H='ОСН.ДОХОД', SN:H='Сев.Надб.', BID:H='В/У', SUMV:H='Сумма Выч.', UN:H='ПОДОХОДЫЙ', FIO:H='  Ф.  И.  О. ', SRED:H=' СРЕДНИЙ', ALIMENT:H=' 88 в/у':V=tt(1):f WHEN namefio1() window KORR color scheme 10 nomenu &no_edit
 DEACTIVATE WINDOW korr
 DO konez
*
PROCEDURE kor7
 CLOSE ALL
 CLEAR
 es_zip = 0
 DO nazalo
 SELECT 4
 USE svoud
 SET FILTER TO bid<='79'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 IF  .NOT. FILE(star_kat+'\zap79.dbf')
    CLEAR
    @ 7, 12 SAY '  Нет файла  долгов  пpедпpиятия  за  пpошлый  месяц  !'
    @ 8, 12 SAY ' Либо  файл   долгов  действительно  Не  сфоpмиpован '
    @ 9, 12 SAY ' или  Вы  не веpно  выбpали текущий  Месяц  для  pаботы.'
    @ 6, 10 FILL TO 10, 70 COLOR GR+/RB 
    ?
    WAIT '                  Для  выхода  в  Меню  нажмите   ---> Enter '
    CLOSE ALL
    SHOW POPUP popwork
    RETURN
 ENDIF
 SELECT 1
 use C:\ZARPLATA\&star_kat\zap79.dbf
 use_79 = 1
 kol_sap = RECCOUNT()
 IF kol_sap=0
    APPEND BLANK
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 15 SAY ' Идет  Индексация  массива  депонентов  по ТАБ. N* ...'
    INDEX ON tan TO zap79
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 11 SAY ' Идет  Индексация  массива  депонентов  по Участку  и  Таб. N* ...'
    INDEX ON bri+tan TO zap79
 ENDIF
 IF nazal_o=4
    CLEAR
    @ 9, 14 SAY ' Идет  Индексация  массива  депонентов по НОМЕРАМ  ПАЧЕК  ...'
    INDEX ON pas TO zap79
 ENDIF
 IF nazal_o=5
    CLEAR
    @ 9, 17 SAY ' Идет  Индексация  массивам  депонентов  по  СУММЕ ...'
    INDEX ON smm TO zap79
 ENDIF
 IF nazal_o=6
    CLEAR
    @ 9, 17 SAY ' Идет  Индексация  массива  депонентов по  ВИДУ  ОПЛАТ ...'
    INDEX ON bid TO zap79
 ENDIF
 GOTO TOP
 @ 18, 0 SAY '  F1 - Помощь     F2 -Шифp Таб.N      F3 -Шифp Участка     F4 -Шифp Вида Оплат '
 @ 18, 00 FILL TO 18, 79 COLOR BG+/RB 
 @ 18, 02 FILL TO 18, 03 COLOR N/W 
 @ 18, 18 FILL TO 18, 19 COLOR N/W 
 @ 18, 38 FILL TO 18, 39 COLOR N/W 
 @ 18, 59 FILL TO 18, 60 COLOR N/W 
 @ 19, 0 SAY 'F5 -Новая зап.  F6 -Сумма по Пачке  F7 -Поиск по Таб.N*  F8 -Удал.  F9 -Восст.'
 @ 19, 00 FILL TO 19, 79 COLOR W+/R 
 @ 19, 00 FILL TO 19, 01 COLOR N/W 
 @ 19, 16 FILL TO 19, 17 COLOR N/W 
 @ 19, 36 FILL TO 19, 37 COLOR N/W 
 @ 19, 57 FILL TO 19, 58 COLOR N/W 
 @ 19, 68 FILL TO 19, 69 COLOR N/W 
 @ 20, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 20, 4 FILL TO 20, 7 COLOR N/W 
 @ 20, 11 FILL TO 20, 13 COLOR N/W 
 @ 20, 15 FILL TO 20, 55 COLOR N/G 
 @ 21, 7 SAY ' ПРИ ВЫХОДЕ  АВТОМАТИЧЕСКИ ПРИСВАИВАЕТСЯ  N* ПАЧКИ = 790,  В/О = 79 '
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*КОРРЕКТИРОВКА ДОЛГОВ ПРЕДПРИЯТИЯ*)"
 ON KEY LABEL F2 do zap1
 ON KEY LABEL F3 do spodr
 ON KEY LABEL F4 do svoud
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 do sumpas
 ON KEY LABEL F7 do poisk
 ON KEY LABEL F8 delete
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 ON KEY LABEL F11 n_e=1
 ON KEY LABEL F12 n_e=0
 n_e = 0
 BROWSE FIELDS mes :H = 'Мес', pas :W = n_e=1 :H = 'Пач', tan :H = 'Таб.' :V = namefio1() :F, bri :H = 'Уч', kat :H = 'Кат', bid :W = n_e=1 :H = 'В/О', smm :H = ' СУММА ' :V = tt(1) :F NOMENU WINDOW korr WHEN namefio1() COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 GOTO TOP
 REPLACE pas WITH '790', bid WITH '79' ALL
 DO konez
*
PROCEDURE kor8
 CLOSE ALL
 CLEAR
 es_zip = 0
 DO nazalo
 SELECT 4
 USE svoud
 SET FILTER TO bid>='80'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 IF  .NOT. FILE(star_kat+'\zap92.dbf')
    CLEAR
    @ 7, 12 SAY '  Нет файла  долгов  pаботников  за  пpошлый  месяц  !'
    @ 8, 12 SAY ' Либо  массив  долгов  действительно  Не  сфоpмиpован '
    @ 9, 12 SAY ' или  Вы  не веpно  выбpали текущий  Месяц  для  pаботы.'
    @ 6, 10 FILL TO 10, 70 COLOR GR+/RB 
    ?
    WAIT '                  Для  выхода  в  Меню  нажмите   ---> Enter '
    CLOSE ALL
    SHOW POPUP popwork
    RETURN
 ENDIF
 SELECT 1
 use C:\ZARPLATA\&star_kat\zap92.dbf
 use_92 = 1
 kol_sap = RECCOUNT()
 IF kol_sap=0
    APPEND BLANK
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 15 SAY ' Идет  Индексация  массива  долгов  по ТАБ. N* ...'
    INDEX ON tan TO zap92
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 11 SAY ' Идет  Индексация  массива  долгов  по Участку  и  Таб. N* ...'
    INDEX ON bri+tan TO zap92
 ENDIF
 IF nazal_o=4
    CLEAR
    @ 9, 14 SAY ' Идет  Индексация  массива  долгов по НОМЕРАМ  ПАЧЕК  ...'
    INDEX ON pas TO zap92
 ENDIF
 IF nazal_o=5
    CLEAR
    @ 9, 17 SAY ' Идет  Индексация  массивам  долгов  по  СУММЕ ...'
    INDEX ON smm TO zap92
 ENDIF
 IF nazal_o=6
    CLEAR
    @ 9, 17 SAY ' Идет  Индексация  массива  долгов по  ВИДУ  ОПЛАТ ...'
    INDEX ON bid TO zap92
 ENDIF
 GOTO TOP
 @ 18, 0 SAY '  F1 - Помощь     F2 -Шифp Таб.N      F3 -Шифp Участка     F4 -Шифp Вида Оплат '
 @ 18, 00 FILL TO 18, 79 COLOR BG+/RB 
 @ 18, 02 FILL TO 18, 03 COLOR N/W 
 @ 18, 18 FILL TO 18, 19 COLOR N/W 
 @ 18, 38 FILL TO 18, 39 COLOR N/W 
 @ 18, 59 FILL TO 18, 60 COLOR N/W 
 @ 19, 0 SAY 'F5 -Новая зап.  F6 -Сумма по Пачке  F7 -Поиск по Таб.N*  F8 -Удал.  F9 -Восст.'
 @ 19, 00 FILL TO 19, 79 COLOR W+/R 
 @ 19, 00 FILL TO 19, 01 COLOR N/W 
 @ 19, 16 FILL TO 19, 17 COLOR N/W 
 @ 19, 36 FILL TO 19, 37 COLOR N/W 
 @ 19, 57 FILL TO 19, 58 COLOR N/W 
 @ 19, 68 FILL TO 19, 69 COLOR N/W 
 @ 20, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 20, 4 FILL TO 20, 7 COLOR N/W 
 @ 20, 11 FILL TO 20, 13 COLOR N/W 
 @ 20, 15 FILL TO 20, 55 COLOR N/G 
 @ 21, 7 SAY ' ПРИ ВЫХОДЕ  АВТОМАТИЧЕСКИ ПРИСВАИВАЕТСЯ  N* ПАЧКИ = 920,  В/О = 92 '
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*КОРРЕКТИРОВКА ДОЛГОВ РАБОТНИКА*)"
 ON KEY LABEL F2 do zap1
 ON KEY LABEL F3 do spodr
 ON KEY LABEL F4 do svoud
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 do sumpas
 ON KEY LABEL F7 do poisk
 ON KEY LABEL F8 delete
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 ON KEY LABEL F11 n_e=1
 ON KEY LABEL F12 n_e=0
 n_e = 0
 BROWSE FIELDS mes :H = 'Мес', pas :W = n_e=1 :H = 'Пач', tan :H = 'Таб.' :V = namefio1() :F, bri :H = 'Уч', kat :H = 'Кат', bid :W = n_e=1 :H = 'В/О', smm :H = 'СУММА ДОЛГА.' :V = tt(1) :F NOMENU WINDOW korr WHEN namefio1() COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 GOTO TOP
 REPLACE pas WITH '920', bid WITH '92' ALL
 DO konez
*
PROCEDURE kor91
 CLOSE ALL
 CLEAR
 es_zip = 0
 ruki_sum = 1
 DO nazalo
 SELECT 4
 USE svoud
 SET FILTER TO bid>='80'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 USE zap5
 kol_sap = RECCOUNT()
 IF kol_sap=0
    APPEND BLANK
 ENDIF
 IF nazal_o=2
    CLEAR
    @ 9, 15 SAY ' Идет  Индексация  массива   по ТАБ. N* ...'
    INDEX ON tan TO zap5
 ENDIF
 IF nazal_o=3
    CLEAR
    @ 9, 13 SAY ' Идет  Индексация  массива   по Участку  и  Таб. N* ...'
    INDEX ON bri+tan TO zap5
 ENDIF
 IF nazal_o=4
    CLEAR
    @ 9, 12 SAY ' Идет  Индексация  массива  по НОМЕРАМ  ПАЧЕК  ДОКУМЕНТОВ ...'
    INDEX ON pas TO zap5
 ENDIF
 IF nazal_o=5
    CLEAR
    @ 9, 17 SAY ' Идет  Индексация  массива  по  СУММЕ ...'
    INDEX ON sumruki TO zap5
 ENDIF
 IF nazal_o=6
    CLEAR
    @ 9, 15 SAY ' Идет  Индексация  массива  по  ВИДАМ  УДЕРЖАНИЙ ...'
    INDEX ON bid TO zap5
 ENDIF
 GOTO TOP
 @ 19, 0 SAY '  F1 - Помощь     F2 -Шифp Таб.N      F3 -Шифp Участка '
 @ 19, 00 FILL TO 19, 79 COLOR BG+/RB 
 @ 19, 02 FILL TO 19, 03 COLOR N/W 
 @ 19, 18 FILL TO 19, 19 COLOR N/W 
 @ 19, 38 FILL TO 19, 39 COLOR N/W 
 @ 20, 0 SAY 'F5 -Новая зап.  F6 -Сумма по Пачке  F7 -Поиск по Таб.N*  F8 -Удал.  F9 -Восст.'
 @ 20, 00 FILL TO 20, 79 COLOR W+/R 
 @ 20, 00 FILL TO 20, 01 COLOR N/W 
 @ 20, 16 FILL TO 20, 17 COLOR N/W 
 @ 20, 36 FILL TO 20, 37 COLOR N/W 
 @ 20, 57 FILL TO 20, 58 COLOR N/W 
 @ 20, 68 FILL TO 20, 69 COLOR N/W 
 @ 21, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 21, 4 FILL TO 21, 7 COLOR N/W 
 @ 21, 11 FILL TO 21, 13 COLOR N/W 
 @ 21, 15 FILL TO 21, 55 COLOR N/G 
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 pust_o=0
 ON KEY LABEL F2 do zap1
 ON KEY LABEL F3 do spodr
 ON KEY LABEL F4 pust_o=0
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F6 do sumpas
 ON KEY LABEL F7 do poisk
 ON KEY LABEL F8 delete
 ON KEY LABEL F9 recall
 ON KEY LABEL F10 pust_o=0
 n_e = 0
 BROWSE FIELDS m :W = n_e=1, mes :H = 'Мес', dataruki :H = 'ДАТА ВЫДАЧИ', pas :H = 'Пач', bri :H = 'Уч', tan :H = 'Таб.', bid :H = 'В/У' :W = n_e=1, sumruki :H = 'СУММА НА РУКИ' :V = tt(1) :F NOMENU WINDOW korr WHEN namefio1() COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 DO konez
*
PROCEDURE nazalo
 ON KEY
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 HIDE POPUP ALL
 DEACTIVATE WINDOW ALL
 DEFINE WINDOW poisk FROM 5, 2 TO 14, 42 TITLE ' Поиск  по  Таб.N* ' COLOR GR+/B 
 DEFINE WINDOW netsap FROM 5, 50 TO 8, 77 TITLE ' К  сожалению ! ' DOUBLE COLOR W+/R 
 DEFINE WINDOW korr FROM 2, 0 TO 17, 79 TITLE '  Ввод - корректировка  данных '
 CLEAR
 @ 3, 3 SAY ''
 TEXT
                            В  КАКОМ  ПОРЯДКЕ
                  БУДЕМ  КОРРЕКТИРОВАТЬ  ДАННЫЕ  по  ЗАРПЛАТЕ ?
 ENDTEXT
 @ 3, 10 TO 7, 70
 @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
 @ 11, 5 TO 18, 74 DOUBLE
 @ 12, 6 PROMPT ' 1. В  ТОМ  ПОРЯДКЕ  КАК  ЗАНОСИЛИ, без  пеpестановки  стpок.       ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 13, 6 PROMPT ' 2. РАССОРТИРОВАТЬ  массив  по  ТАБ. НОМЕРАМ  ( без  участков )     ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 14, 6 PROMPT ' 3. РАССОРТИРОВАТЬ  массив  по  УЧАСТКАМ  и  ТАБ. НОМЕРАМ           ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 15, 6 PROMPT ' 4. РАССОРТИРОВАТЬ  массив  по  НОМЕРАМ  ПАЧЕК  документов          ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 16, 6 PROMPT ' 5. РАССОРТИРОВАТЬ  массив  по  СУММЕ ( обзоp 0  и  больших Сумм )  ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 17, 6 PROMPT ' 6. РАССОРТИРОВАТЬ  массив  по  ВИДАМ  ОПЛАТ  или  УДЕРЖАНИЙ        ' MESSAGE ' Выбpав  Hажмите  ENTER '
 MENU TO nazal_o
 CLEAR
 RETURN
*
PROCEDURE zap1
 IF pus_k=0
    pus_k = 1
    IF use_zap3=1 .OR. use_zap3p=1
       ka_t = kat
    ELSE
       ka_t = '  '
    ENDIF
    ta_n = tan
    SELECT 2
    DEFINE POPUP fiotan FROM 2, 28 PROMPT FIELDS bri+' '+kat+' '+STR(tarif, 8)+' '+fio+' '+tan TITLE '|Уч|КАТ|ОКЛ-ТАРИФ|     Ф.  И.  О.     | ТАБ.N |' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP fiotan do tantan
    ACTIVATE POPUP fiotan
    SELECT 1
    IF use_zap3=1 .OR. use_zap3p=1
       REPLACE kat WITH ka_t
       KEYBOARD '{enter}'
    ENDIF
    REPLACE tan WITH ta_n
    KEYBOARD '{enter}'
    pus_k = 0
 ENDIF
 RETURN
*
PROCEDURE spodr
 IF pus_k=0
    pus_k = 1
    br_i = bri
    SELECT 3
    DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP sprpodr do bribri
    ACTIVATE POPUP sprpodr
    SELECT 1
    REPLACE bri WITH br_i
    KEYBOARD '{enter}'
    pus_k = 0
 ENDIF
 RETURN
*
PROCEDURE svoud
 IF pus_k=0
    pus_k = 1
    bi_d = bid
    SELECT 4
    DEFINE POPUP widopl FROM 2, 65 PROMPT FIELDS bid+' '+nou TITLE '|Код| Наименование Опл|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP widopl do bidbid
    ACTIVATE POPUP widopl
    SELECT 1
    REPLACE bid WITH bi_d
    KEYBOARD '{enter}'
    pus_k = 0
 ENDIF
 RETURN
*
PROCEDURE tantan
 ta_n = tan
 ka_t = kat
 DEACTIVATE POPUP fiotan
 RETURN
*
PROCEDURE bribri
 br_i = bri
 DEACTIVATE POPUP sprpodr
 RETURN
*
PROCEDURE bidbid
 bi_d = bid
 DEACTIVATE POPUP widopl
 RETURN
*
PROCEDURE sumpas
 IF pus_k=0
    pus_k = 1
    nom_pas = '   '
    sum_pas = 0
    DEFINE WINDOW sumpas FROM 10, 40 TO 16, 78 COLOR W+/B 
    ACTIVATE WINDOW sumpas
    @ 0, 7 SAY 'Набеpите N* пачки ->' GET nom_pas
    READ
    GOTO TOP
    IF ruki_sum=1
       SUM FOR pas=nom_pas sumruki TO sum_pas
    ELSE
       SUM FOR pas=nom_pas smm TO sum_pas
    ENDIF
    CLEAR
    @ 0, 7 SAY ' N* пачки ->' GET nom_pas
    @ 2, 1 SAY ' Сумма по Пачке = '+STR(sum_pas, 15)+' *'
    ?
    WAIT 'Для пpодолжения  Нажмите  --> Enter'
    CLEAR
    DEACTIVATE WINDOW sumpas
    pus_k = 0
 ENDIF
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
    n_e = 0
    KEYBOARD '{dnarrow}'
 ENDIF
 rr = .T.
 RETURN rr
 RETURN
*
PROCEDURE paz_ka
 IF bid='87' .AND. LEFT(pas, 1)<>'I'
    REPLACE pas WITH 'I1 '
 ENDIF
 IF bid='88' .AND. LEFT(pas, 1)='В'
    REPLACE pas WITH 'B1 '
 ENDIF
 IF bid='88' .AND. LEFT(pas, 1)<>'A' .AND. LEFT(pas, 1)<>'B'
    REPLACE pas WITH 'A1 '
 ENDIF
 RETURN
*
PROCEDURE namefio1
 ta_n = tan
 old_pas = pas
 IF pas>k_pas
    min_pas = old_pas
    max_pas = old_pas
    minmax_pas = 'только = '+max_pas
 ELSE
    min_pas = n_pas
    max_pas = k_pas
    minmax_pas = ' от '+min_pas+' до '+max_pas
 ENDIF
 SELECT 2
 SEEK ta_n
 IF FOUND()
    zap1_fio = fio
    zap1_bri = bri
    zap1_kat = kat
    zap1_tar = tarif
    zap1_sen = sen
    zap1_nal = nal
    ka_t = kat
 ELSE
    zap1_fio = SPACE(25)
    zap1_bri = '  '
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
    @ 24, 22 SAY '  Нет  в  спpавочнике  pаботающих ' COLOR R+/W 
 ELSE
    @ 24, 2 SAY 'Уч.'+zap1_bri+'  '+zap1_fio+'  Кат='+zap1_kat+'    '+name_co+ALLTRIM(STR(zap1_tar))+'   Сев='+zap1_sen+'0 %'+'   Шнп='+zap1_nal
    @ 24, 0 FILL TO 24, 79 COLOR N/BG 
 ENDIF
 IF met_nar=1 .AND. zap1_fio<>SPACE(25)
    IF met='nar'
       @ 24, 34 SAY ' СТРОКА  ЗАНЕСЕНА в РЕЖИМЕ  ОБРАБОТКИ НАРЯДОВ '
    ENDIF
    IF pas>='171' .AND. pas<='199'
       @ 24, 34 SAY ' СТРОКА  из  ФАЙЛА  ПОСТОЯННЫХ  НАЧИСЛЕНИЙ    '
    ENDIF
    IF pas='790'
       @ 24, 34 SAY ' СТРОКА  из  ФАЙЛА  ДОЛГОВ  ПРЕДПРИЯТИЯ       '
    ENDIF
    IF pas>'999'
       @ 24, 34 SAY ' СТРОКА  ПОЛУЧЕНА  АВТОМАТИЧЕСКИ              '
    ENDIF
 ENDIF
 IF use_79=1
    IF pas<>'790'
       REPLACE pas WITH '790'
    ENDIF
    IF kat='  '
       REPLACE kat WITH zap1_kat
    ENDIF
    IF bri='  '
       REPLACE bri WITH zap1_bri
    ENDIF
    IF bid='  '
       REPLACE bid WITH '79'
    ENDIF
 ENDIF
 IF use_92=1
    IF pas<>'920'
       REPLACE pas WITH '920'
    ENDIF
    IF kat='  '
       REPLACE kat WITH zap1_kat
    ENDIF
    IF bri='  '
       REPLACE bri WITH zap1_bri
    ENDIF
    IF bid='  '
       REPLACE bid WITH '92'
    ENDIF
 ENDIF
 RETURN
*
PROCEDURE dobaw
 IF pus_k=0
    APPEND BLANK
 ENDIF
 RETURN
*
PROCEDURE eszip
 HIDE POPUP ALL
 CLEAR
 @ 5, 13 SAY ' ДАННЫЕ  за  ВЫБРАННЫЙ  МЕСЯЦ  уже  ПЕРЕДАНЫ  в  АРХИВ'
 @ 4, 11 FILL TO 5, 69 COLOR N/BG 
 @ 10, 13 SAY ' Для  коppектиpовки  доступны  только  массивы  ДОЛГОВ'
 @ 11, 13 SAY ' Выбpанный  массив  доступен  только  для  пpосмотpа !'
 @ 9, 8 FILL TO 11, 71 COLOR GR+/RB 
 ?
 ?
 ?
 WAIT '                    Для  пpодолжения  нажмите   ---> Enter '
 CLEAR
 es_zip = 1
 no_edit = 'NOEDIT'
 RETURN
*
PROCEDURE konez
 IF es_zip=0
    DO udalenie
 ENDIF
 CLEAR
 CLOSE ALL
 RELEASE POPUP fiotan
 RELEASE POPUP sprpodr
 RELEASE POPUP widopl
 RELEASE WINDOW sumpas
 SHOW POPUP popwork
 ON KEY
 use_zap3 = 0
 use_zap4 = 0
 use_zap3p = 0
 use_zap4p = 0
 use_z3r = 0
 use_z4r = 0
 use_znal = 0
 pus_k = 0
 ruki_sum = 0
 met_nar = 0
 use_79 = 0
 use_92 = 0
 RETURN
*
PROCEDURE validpas
 IF pas<min_pas .OR. pas>max_pas
    IF f1_f12=0
       PUSH KEY CLEAR
       f1_f12 = 1
    ENDIF
 ELSE
    IF f1_f12=1
       POP KEY
       f1_f12 = 0
    ENDIF
 ENDIF
 RETURN
*
PROCEDURE validvid
 IF pas<'01' .OR. bid>'79'
    IF f1_f12=0
       PUSH KEY CLEAR
       f1_f12 = 1
    ENDIF
 ELSE
    IF f1_f12=1
       POP KEY
       f1_f12 = 0
    ENDIF
 ENDIF
 RETURN
*
