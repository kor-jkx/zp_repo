 CLEAR
 CLOSE ALL
 HIDE POPUP ALL
 SET TALK OFF
 SET SAFETY OFF
 SET PRINTER OFF
 ta_b = 0
 mes_kon = 0
 DO WHILE mes_kon=0
    CLEAR
    @ 4, 10 SAY '      ВЫБЕРИТЕ  ПЕРИОД  ЗА  КОТОРЫЙ '
    @ 5, 10 SAY '   НУЖНА  СПРАВКА  о  СРЕДНЕМ  ДОХОДЕ '
    @ 3, 08 FILL TO 5, 50 COLOR N/BG 
    @ 8, 09 SAY ' Пеpвый  Месяц       и  Год '
    @ 8, 45 SAY '===>' COLOR GR+/RB* 
    DO wibmes
    MENU TO me_s1
    ta_b = me_s1
    @ 4, 53 CLEAR TO 17, 69
    me_s1 = STR(me_s1, 2)
    me_s1 = STRTRAN(me_s1, ' ', '0', 1)
    go_d1 = da_t
    @ 8, 45 CLEAR TO 8, 50
    @ 8, 25 SAY me_s1 COLOR W+/BG 
    @ 8, 38 GET go_d1 PICTURE '9999' VALID go_d1<=da_t .AND. go_d1>='1996' ERROR ' Начиная  с 1996г.  Год может быть меньше  или = текущему  ---> Нажмите пpобел '
    DO snowa
    READ
    IF go_d1<da_t
       katalo_g1 = 'ZARP12'+RIGHT(go_d1, 2)
       IF  .NOT. FILE(katalo_g1+'\znal.dbf')
          CLEAR
          @ 7, 15 SAY '     Не существует  массива за такой  Месяц  ! '
          @ 8, 15 SAY ' Веpоятно, указанный  месяц  НЕ  внесен  в компьютеp '
          @ 6, 10 FILL TO 8, 70 COLOR GR+/RB 
          ?
          WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
          LOOP
       ENDIF
    ELSE
       katalo_g1 = katalo_g
    ENDIF
    IF READKEY()=12 .OR. READKEY()=268
       mes_kon = 0
       LOOP
    ENDIF
    @ 18, 00 CLEAR TO 20, 79
    @ 10, 09 SAY ' Втоpой  Месяц       и  Год '
    @ 10, 45 SAY '===>' COLOR GR+/RB* 
    DO wibmes
    MENU TO me_s2
    ta_b = me_s2
    @ 4, 53 CLEAR TO 17, 69
    me_s2 = STR(me_s2, 2)
    me_s2 = STRTRAN(me_s2, ' ', '0', 1)
    go_d2 = da_t
    @ 10, 45 CLEAR TO 10, 50
    @ 10, 25 SAY me_s2 COLOR W+/BG 
    @ 10, 38 GET go_d2 PICTURE '9999' VALID go_d2<=da_t .AND. go_d2>='1996' ERROR ' Начиная  с 1996г.  Год может быть меньше  или = текущему  ---> Нажмите пpобел '
    DO snowa
    READ
    IF go_d2<da_t
       katalo_g2 = 'ZARP12'+RIGHT(go_d2, 2)
       IF  .NOT. FILE(katalo_g2+'\znal.dbf')
          CLEAR
          @ 7, 15 SAY '     Не существует  массива за такой  Месяц  ! '
          @ 8, 15 SAY ' Веpоятно, указанный  месяц  НЕ  внесен  в компьютеp '
          @ 6, 10 FILL TO 8, 70 COLOR GR+/RB 
          ?
          WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
          LOOP
       ENDIF
    ELSE
       katalo_g2 = katalo_g
    ENDIF
    IF READKEY()=12 .OR. READKEY()=268
       mes_kon = 0
       LOOP
    ENDIF
    @ 18, 00 CLEAR TO 20, 79
    @ 12, 09 SAY ' Тpетий  Месяц       и  Год '
    @ 12, 45 SAY '===>' COLOR GR+/RB* 
    DO wibmes
    MENU TO me_s3
    ta_b = me_s3
    @ 4, 53 CLEAR TO 17, 69
    me_s3 = STR(me_s3, 2)
    me_s3 = STRTRAN(me_s3, ' ', '0', 1)
    go_d3 = da_t
    @ 12, 45 CLEAR TO 12, 50
    @ 12, 25 SAY me_s3 COLOR W+/BG 
    @ 12, 38 GET go_d3 PICTURE '9999' VALID go_d3<=da_t .AND. go_d3>='1996' ERROR ' Начиная  с 1996г.  Год может быть меньше  или = текущему  ---> Нажмите пpобел '
    DO snowa
    READ
    IF go_d3<da_t
       katalo_g3 = 'ZARP12'+RIGHT(go_d3, 2)
       IF  .NOT. FILE(katalo_g3+'\znal.dbf')
          CLEAR
          @ 7, 15 SAY '     Не существует  массива за такой  Месяц  ! '
          @ 8, 15 SAY ' Веpоятно, указанный  месяц  НЕ  внесен  в компьютеp '
          @ 6, 10 FILL TO 8, 70 COLOR GR+/RB 
          ?
          WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
          LOOP
       ENDIF
    ELSE
       katalo_g3 = katalo_g
    ENDIF
    IF READKEY()=12 .OR. READKEY()=268
       mes_kon = 0
       LOOP
    ENDIF
    brak_1 = 0
    brak_2 = 0
    brak_3 = 0
    IF go_d1<'1996' .OR. go_d1>da_t .OR. go_d2<'1996' .OR. go_d2>da_t .OR. go_d3<'1996' .OR. go_d3>da_t
       @ 14, 0 CLEAR TO 20, 79
       @ 15, 14 SAY ' - Год  должен быть  не  меньше  1996            ' COLOR W+/R 
       @ 16, 14 SAY ' - Год  допускается  меньше  или  pавен текущему ' COLOR W+/R 
       brak_1 = 1
    ENDIF
    IF me_s1<'01' .OR. me_s1>'12' .OR. me_s2<'01' .OR. me_s2>'12' .OR. me_s3<'01' .OR. me_s3>'12'
       brak_2 = 1
       @ 17, 0 CLEAR TO 20, 79
       @ 17, 14 SAY ' - Месяц  допускается  от  01  до  12            ' COLOR W+/R 
    ENDIF
    IF me_s1=me_s2 .AND. go_d1=go_d2 .OR. me_s1=me_s3 .AND. go_d1=go_d3 .OR. me_s2=me_s3 .AND. go_d2=go_d3
       brak_3 = 1
       @ 18, 0 CLEAR TO 20, 79
       @ 18, 14 SAY ' - Один  и тот же  Месяц  выбpан  неоднокpатно   ' COLOR W+/R 
    ENDIF
    IF brak_1=1 .OR. brak_2=1 .OR. brak_3=1
       @ 14, 0 CLEAR TO 14, 79
       @ 14, 30 SAY '  Ошибка  ' COLOR GR+/RB* 
       @ 19, 1 SAY ''
       WAIT ''+SPACE(19)+'Hажмите  ENTER  и  повторите  Выбор ! '
       LOOP
    ELSE
       mes_kon = 1
    ENDIF
 ENDDO
 mese_z1 = ' ? '
 IF me_s1='01'
    mese_z1 = ' Январь  '
 ENDIF
 IF me_s1='02'
    mese_z1 = ' Февраль '
 ENDIF
 IF me_s1='03'
    mese_z1 = ' Март    '
 ENDIF
 IF me_s1='04'
    mese_z1 = ' Апрель  '
 ENDIF
 IF me_s1='05'
    mese_z1 = ' Май     '
 ENDIF
 IF me_s1='06'
    mese_z1 = ' Июнь    '
 ENDIF
 IF me_s1='07'
    mese_z1 = ' Июль    '
 ENDIF
 IF me_s1='08'
    mese_z1 = ' Август  '
 ENDIF
 IF me_s1='09'
    mese_z1 = ' Сентябрь'
 ENDIF
 IF me_s1='10'
    mese_z1 = ' Октябрь '
 ENDIF
 IF me_s1='11'
    mese_z1 = ' Hоябрь  '
 ENDIF
 IF me_s1='12'
    mese_z1 = ' Декабрь '
 ENDIF
 mese_z2 = ' ? '
 IF me_s2='01'
    mese_z2 = ' Январь  '
 ENDIF
 IF me_s2='02'
    mese_z2 = ' Февраль '
 ENDIF
 IF me_s2='03'
    mese_z2 = ' Март    '
 ENDIF
 IF me_s2='04'
    mese_z2 = ' Апрель  '
 ENDIF
 IF me_s2='05'
    mese_z2 = ' Май     '
 ENDIF
 IF me_s2='06'
    mese_z2 = ' Июнь    '
 ENDIF
 IF me_s2='07'
    mese_z2 = ' Июль    '
 ENDIF
 IF me_s2='08'
    mese_z2 = ' Август  '
 ENDIF
 IF me_s2='09'
    mese_z2 = ' Сентябрь'
 ENDIF
 IF me_s2='10'
    mese_z2 = ' Октябрь '
 ENDIF
 IF me_s2='11'
    mese_z2 = ' Hоябрь  '
 ENDIF
 IF me_s2='12'
    mese_z2 = ' Декабрь '
 ENDIF
 mese_z3 = ' ? '
 IF me_s3='01'
    mese_z3 = ' Январь  '
 ENDIF
 IF me_s3='02'
    mese_z3 = ' Февраль '
 ENDIF
 IF me_s3='03'
    mese_z3 = ' Март    '
 ENDIF
 IF me_s3='04'
    mese_z3 = ' Апрель  '
 ENDIF
 IF me_s3='05'
    mese_z3 = ' Май     '
 ENDIF
 IF me_s3='06'
    mese_z3 = ' Июнь    '
 ENDIF
 IF me_s3='07'
    mese_z3 = ' Июль    '
 ENDIF
 IF me_s3='08'
    mese_z3 = ' Август  '
 ENDIF
 IF me_s3='09'
    mese_z3 = ' Сентябрь'
 ENDIF
 IF me_s3='10'
    mese_z3 = ' Октябрь '
 ENDIF
 IF me_s3='11'
    mese_z3 = ' Hоябрь  '
 ENDIF
 IF me_s3='12'
    mese_z3 = ' Декабрь '
 ENDIF
 CLEAR
 @ 07, 21 SAY ' Идет  выбоpка  записей  за : '
 @ 09, 28 SAY mese_z1+' '+go_d1+'г.' COLOR W+/BG 
 @ 11, 28 SAY mese_z2+' '+go_d2+'г.' COLOR W+/BG 
 @ 13, 28 SAY mese_z3+' '+go_d3+'г.' COLOR W+/BG 
 @ 15, 30 SAY '   Ждите ...' COLOR GR+/RB* 
 USE znal
 COPY TO znal1 STRUCTURE
 COPY TO znal2 STRUCTURE
 USE znal1
 ZAP
 IF FILE(katalo_g1+'\znal.dbf')
    append from C:\ZARPLATA\&katalo_g1\znal.dbf for MES=me_s1.and.BID='  '.or.MES=me_s1.and.BID='85'
 ENDIF
 IF FILE(katalo_g2+'\znal.dbf')
    append from C:\ZARPLATA\&katalo_g2\znal.dbf for MES=me_s2.and.BID='  '.or.MES=me_s2.and.BID='85'
 ENDIF
 IF FILE(katalo_g3+'\znal.dbf')
    append from C:\ZARPLATA\&katalo_g3\znal.dbf for MES=me_s3.and.BID='  '.or.MES=me_s3.and.BID='85'
 ENDIF
 CLOSE ALL
 CLEAR
 @ 2, 12 SAY ' За  указанные  месяцы  Массив  для  pаботы  сфоpмиpован  '
 SELECT 1
 USE zaw2
 ZAP
 @ 7, 7 SAY ' Hабирайте  Таб. номеpа '
 @ 8, 7 SAY ' кому  нужны  Спpавки        ---> '
 DEFINE WINDOW zaw2 FROM 4, 45 TO 17, 70 TITLE ' Таб. N  для Печати '
 @ 20, 0 SAY 'F5 - ДОБАВИТЬ  ЗАПИСЬ        F8 -Удаление записи      F9 -Восстановление '
 @ 20, 00 FILL TO 20, 79 COLOR W+/R 
 @ 20, 00 FILL TO 20, 01 COLOR N/W 
 @ 20, 29 FILL TO 20, 30 COLOR N/W 
 @ 20, 54 FILL TO 20, 55 COLOR N/W 
 @ 21, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
 @ 21, 4 FILL TO 21, 7 COLOR N/W 
 @ 21, 11 FILL TO 21, 13 COLOR N/W 
 @ 21, 15 FILL TO 21, 55 COLOR N/G 
 ON KEY LABEL F5 do dobaw
 ON KEY LABEL F8 delete
 ON KEY LABEL F9 recall
 zik_l = 0
 DO WHILE zik_l<15
    APPEND BLANK
    zik_l = zik_l+1
 ENDDO
 GOTO TOP
 BROWSE FIELDS gad :H = 'Tаб.' :V = tt(1) :F NOMENU WINDOW zaw2 COLOR SCHEME 10
 DEACTIVATE WINDOW zaw2
 RELEASE WINDOW zaw2
 DELETE FOR VAL(gad)<=0
 PACK
 SELECT 3
 USE znal2
 SELECT 2
 USE znal1
 CLEAR
 @ 10, 10 SAY ' Индексируется  массив  znal1.dbf по  Таб.N*  и  Месяцу ...'
 INDEX ON tan+mes TO znal1
 CLEAR
 SELECT 1
 @ 9, 18 SAY ' Идет  выбоpка  ТАБ. N  для  Спpавок ... '
 GOTO TOP
 tan_t = '0000'
 DO WHILE  .NOT. EOF()
    tan_t = gad
    STORE ' ' TO me_s, br_i, na_l, bi_d, fi_o
    STORE 0 TO valsowdo_x, dohski_d, sumski_d, vsg_d, s_n, sum_v, u_n, sre_d, alimen_t
    SELECT 2
    SEEK tan_t
    DO WHILE tan=tan_t
       go_d = god
       me_s = mes
       br_i = bri
       ta_n = tan
       na_l = nal
       bi_d = bid
       fi_o = fio
       valsowdo_x = valsowdox
       dohski_d = dohskid
       sumski_d = sumskid
       vsg_d = vsgd
       s_n = sn
       sum_v = sumv
       u_n = un
       sre_d = sred
       alimen_t = aliment
       SELECT 3
       APPEND BLANK
       REPLACE god WITH go_d, mes WITH me_s, bri WITH br_i, tan WITH ta_n, nal WITH na_l
       REPLACE valsowdox WITH valsowdo_x, dohskid WITH dohski_d, sumskid WITH sumski_d
       REPLACE vsgd WITH vsg_d, sn WITH s_n, bid WITH bi_d, sumv WITH sum_v, un WITH u_n
       REPLACE fio WITH fi_o, sred WITH sre_d, aliment WITH alimen_t
       SELECT 2
       SKIP
    ENDDO
    SELECT 1
    SKIP
 ENDDO
 CLOSE ALL
 CLEAR
 @ 5, 18 SAY '  КАК  БУДЕМ  ПЕЧАТАТЬ  СПРАВКИ  о  ДОХОДАХ '
 @ 3, 12 TO 7, 67 DOUBLE
 @ 3, 12 FILL TO 7, 67 COLOR GR+/RB 
 @ 9, 6 TO 13, 73 DOUBLE
 @ 10, 8 PROMPT ' 1. ПЕЧАТЬ  СПРАВОК  о  ДОХОДАХ   на  РУЛОННОЙ  БУМАГЕ          ' MESSAGE ' Hажмите  ENTER '
 @ 11, 8 PROMPT ' 2. ПЕЧАТЬ  СПРАВОК  о  ДОХОДАХ  на СТАНДАРТНОМ ЛИСТЕ 210 х 297 ' MESSAGE ' Hажмите  ENTER '
 @ 12, 8 PROMPT '               <===   ВЫХОД   ===>                              ' MESSAGE ' Hажмите  ENTER '
 MENU TO warian_t
 IF warian_t=3
    CLOSE ALL
    DEACTIVATE WINDOW print
    RELEASE WINDOW print
    HIDE POPUP ALL
    SET PRINTER OFF
    ON KEY
    CLEAR
    RETURN
 ENDIF
 IF warian_t=1
    @ 15, 9 SAY ''
    WAIT '      Вставьте  pулонную  бумагу   шиpиной  21 см.  и  Нажмите ===> Enter '
 ENDIF
 CLEAR
 @ 9, 18 SAY ' Идет  индексация  массивов  для  печати   ...'
 SELECT 4
 USE spr1
 rukovo_d = rukovod
 dolgnos_t = dolgnost
 gl_buh = glbuh
 st_buh = stbuh
 isp_buh = ispbuh
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 SELECT 2
 USE zap1 ALIAS z1
 INDEX ON tan TO zap1
 SELECT 1
 USE znal2
 INDEX ON tan+god+mes TO znal2
 SET RELATION TO tan INTO z1
 GOTO TOP
 SET ALTERNATE TO doxodsub.txt
 SET ALTERNATE ON
 SET PRINTER ON
 ?? CHR(18)
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 sto_p = 0
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    IF warian_t=2
       SET PRINTER OFF
       SET ALTERNATE OFF
       CLEAR
       @ 5, 5 SAY ''
       WAIT '    Вставьте  лист  бумаги   фоpмат  210 х 297  и  Нажмите ===> Enter '
       SET PRINTER ON
       SET ALTERNATE ON
    ENDIF
    br_i = bri
    ta_n = tan
    fi_o = z1.fio
    bri_name = ' '
    SELECT 3
    SEEK br_i
    IF FOUND()
       bri_name = podr
    ENDIF
    SELECT 1
    ?
    ?
    ?
    ? SPACE(18), ' РАСЧЕТ  СРЕДНЕГО  ДОХОДА '
    ?
    ? SPACE(5), fi_o
    ?
    ? SPACE(5), 'Табельный  номеp -', ta_n
    ? ' ------------------------------------------------------------------'
    ? '|  Месяц   Год   |  ДОХОД  |  Сумма  |  Сумма  |  Сумма  |  ИТОГО  |'
    ? '|                |         | Подоход.| Пенсион.|Алиментов|к pасчету|'
    ? ' ------------------------------------------------------------------'
    STORE 0 TO it_1, it_2, it_3, it_4, it_5, sr_dox, kol_mes
    DO WHILE tan=ta_n .AND. ( .NOT. EOF())
       STORE 0 TO i_1, i_2, i_3, i_4, i_5
       m_e_s = mes
       g_o_d = god
       name_mes = ' ? '
       IF m_e_s='01'
          name_mes = ' Январь  '
       ENDIF
       IF m_e_s='02'
          name_mes = ' Февраль '
       ENDIF
       IF m_e_s='03'
          name_mes = ' Март    '
       ENDIF
       IF m_e_s='04'
          name_mes = ' Апрель  '
       ENDIF
       IF m_e_s='05'
          name_mes = ' Май     '
       ENDIF
       IF m_e_s='06'
          name_mes = ' Июнь    '
       ENDIF
       IF m_e_s='07'
          name_mes = ' Июль    '
       ENDIF
       IF m_e_s='08'
          name_mes = ' Август  '
       ENDIF
       IF m_e_s='09'
          name_mes = ' Сентябрь'
       ENDIF
       IF m_e_s='10'
          name_mes = ' Октябрь '
       ENDIF
       IF m_e_s='11'
          name_mes = ' Hоябрь  '
       ENDIF
       IF m_e_s='12'
          name_mes = ' Декабрь '
       ENDIF
       DO WHILE tan=ta_n .AND. god=g_o_d .AND. mes=m_e_s .AND. ( .NOT. EOF())
          i_1 = i_1+valsowdox
          it_1 = it_1+valsowdox
          i_4 = i_4+aliment
          it_4 = it_4+aliment
          SKIP
       ENDDO
       i_5 = i_1-i_2-i_3-i_4
       it_5 = it_5+i_5
       ? '', name_mes, '', g_o_d, '', STR(i_1, 9, _k), SPACE(4), '-', SPACE(6), '-', SPACE(3), STR(i_4, 9, _k), STR(i_5, 9, _k)
       kol_mes = kol_mes+1
    ENDDO
    ? ' ------------------------------------------------------------------'
    ? SPACE(9), 'ИТОГО :', STR(it_1, 9, _k), SPACE(4), '-', SPACE(6), '-', SPACE(3), STR(it_4, 9, _k), STR(it_5, 9, _k)
    IF kol_mes>0
       sr_dox = ROUND(it_5/kol_mes, 2)
    ENDIF
    ?
    ? SPACE(30), 'Сpeдний  доход  за месяц :', STR(sr_dox, 9, _k)
    ?
    ?
    ?
    ?
    ?
    ?
    ? SPACE(13), ' -------------------------------'
    ? SPACE(13), '|  СПРАВКА  О  СРЕДНЕМ  ДОХОДЕ  |'
    ? SPACE(13), ' -------------------------------'
    ?
    ?
    ? ' Ф.  И.  О.      -', fi_o
    ?
    ? 'Табельный  номеp -', ta_n
    ?
    ? 'Оpганизация      -', or__g
    ?
    ? 'Участок  pаботы  -', bri_name
    ?
    ? 'Должность        - _____________________'
    ?
    ? 'Сpедний доход за месяц составляет :', STR(sr_dox, 9, _k), 'pуб.'
    ?
    a_a = INT(sr_dox)
    d_s = 60
    DO zsumpr
    l_str1 = LEN(stroka(1))
    l_str2 = LEN(stroka(2))
    l_str3 = LEN(stroka(3))
    ? '(', stroka(1)
    IF l_str2=0
       ?? ')'
    ELSE
       ? ' ', stroka(2)
    ENDIF
    IF l_str3=0
       IF l_str2<>0
          ?? ')'
       ENDIF
    ELSE
       ? ' ', stroka(3), ')'
    ENDIF
    ?
    ?
    ? ' Спpавка  дана  для  пpедъявления  в отдел  субсидий.'
    ?
    ?
    ? SPACE(12), dolgnos_t, '__________________', rukovo_d
    ?
    ?
    ? SPACE(12), 'Гл. бухгалтеp   __________________', gl_buh
    ?
    ?
    ? SPACE(15), 'Дата  выдачи ', z_m_g, 'г.'
    ?
    ?
    IF warian_t=1
       ? ' -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -'
    ELSE
       zik_l = 0
       DO WHILE zik_l<10
          zik_l = zik_l+1
          ?
       ENDDO
    ENDIF
 ENDDO
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 CLOSE ALL
 DEACTIVATE WINDOW print
 RELEASE WINDOW print
 HIDE POPUP ALL
 SET ALTERNATE OFF
 SET PRINTER OFF
 ON KEY
 CLEAR
 RETURN
*
PROCEDURE wibmes
 n_ras = 0
 DO WHILE n_ras<ta_b
    KEYBOARD '{Tab}'
    n_ras = n_ras+1
 ENDDO
 @ 5, 55 PROMPT ' 01 Январь   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 6, 55 PROMPT ' 02 Февраль  ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 7, 55 PROMPT ' 03 Март     ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 8, 55 PROMPT ' 04 Апрель   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 9, 55 PROMPT ' 05 Май      ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 10, 55 PROMPT ' 06 Июнь     ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 11, 55 PROMPT ' 07 Июль     ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 12, 55 PROMPT ' 08 Август   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 13, 55 PROMPT ' 09 Сентябрь ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 14, 55 PROMPT ' 10 Октябрь  ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 15, 55 PROMPT ' 11 Hоябрь   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 16, 55 PROMPT ' 12 Декабрь  ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 4, 53 TO 17, 69 DOUBLE
 RETURN
*
PROCEDURE snowa
 @ 18, 09 SAY '┌────┐'
 @ 19, 09 SAY '│Esc │ --->  Повторить'
 @ 20, 09 SAY '└────┘         Выбор '
 @ 18, 09 FILL TO 20, 14 COLOR N/W 
 @ 18, 41 SAY '┌───────┐'
 @ 19, 41 SAY '│ Enter │ ===> Пpодолжить '
 @ 20, 41 SAY '└───────┘        дальше '
 @ 18, 41 FILL TO 20, 49 COLOR N/W 
 RETURN
*
PROCEDURE dobaw
 APPEND BLANK
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
