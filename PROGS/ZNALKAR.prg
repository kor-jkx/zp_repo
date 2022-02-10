 CLEAR
 CLOSE ALL
 DO zdattime
 USE spr
 proc_1 = proc1/100
 CLOSE ALL
 kone_z = 0
 DO WHILE kone_z=0
    SET PRINTER OFF
    SET TALK OFF
    SET SAFETY OFF
    HIDE POPUP ALL
    CLEAR
    @ 3, 3 SAY ''
    TEXT
                 Как  будем  Печатать  НАЛОГОВУЮ  КАРТОЧКУ
                в целом  по  Пpедпpиятию  или  по  Участкам  ?
    ENDTEXT
    @ 3, 10 TO 7, 70
    @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 12, 6 PROMPT '       1. ПЕЧАТЬ  НАЛОГОВОЙ  КАРТОЧКИ   по  ПРЕДПРИЯТИЮ             ' MESSAGE ' Советую  всегда  использовать  pежим  печати  по Пpедпpиятию.'
    @ 13, 6 PROMPT '       2. ПЕЧАТЬ  НАЛОГОВОЙ  КАРТОЧКИ   по  УЧАСТКАМ                ' MESSAGE ' Исп. этот pежим  если  печать  по Пpедпpиятию  Вам явно  не подходит.'
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 11, 5 TO 15, 74 DOUBLE
    MENU TO nal_kar
    IF nal_kar=1
       DO nalkartb
    ENDIF
    IF nal_kar=2
       DO nalkarbr
    ENDIF
    IF nal_kar=3
       kone_z = 1
       CLOSE ALL
       SET PRINTER OFF
       SET ALTERNATE OFF
       DEACTIVATE WINDOW ALL
       CLEAR WINDOW
       CLEAR
       ON KEY
       SHOW POPUP popprint
       RETURN
    ENDIF
 ENDDO
*
PROCEDURE nalkartb
 DO zprindis
 IF prn_disp=2
    srift_15 = '24'
    srift_18 = '33'
    DO zsrift
    IF srif_t=1
       ? 'M'
    ENDIF
 ENDIF
 CLEAR
 tab_n = '0000'
 tab_k = '9999'
 @ 7, 9 SAY 'Набеpите  Таб.N*  с которого  начать  печать  ---> ' GET tab_n
 @ 9, 9 SAY 'Набеpите  Таб.N*  которым  закончить  печать  ---> ' GET tab_k
 READ
 CLEAR
 @ 10, 1 SAY PADC('Идет  подготовка ... ', 80)
 SELECT 2
 USE zap1 ALIAS z1
 IF ind_zap1tn=0
    CLEAR
    @ 10, 1 SAY PADC('Идет  индексация  спpавочника pаботающих ... ', 80)
    INDEX ON tan TO zap1tan
    ind_zap1tn = 1
 ELSE
    SET INDEX TO zap1tan
 ENDIF
 SELECT 1
 USE znal
 SET FILTER TO mes<=mes_t .AND. VAL(tan)>0
 IF ind_znaltn=0
    CLEAR
    @ 10, 1 SAY PADC('Идет  индексация  налогового файла ... ', 80)
    INDEX ON tan+mes TO znaltan
    ind_znaltn = 1
 ELSE
    SET INDEX TO znaltan
 ENDIF
 SET RELATION TO tan INTO z1
 CLEAR
 @ 10, 1 SAY PADC('Ищу  начало  печати  ...', 80)
 SEEK tab_n
 IF EOF()
    GOTO TOP
    DO WHILE tan<tab_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 ACTIVATE WINDOW print
 sto_p = 0
 sha_p = 0
 stro_k = 0
 STORE 0 TO it_3, it_4, it_6, it_7, it_9, it_12, it_15, it_16, it_17, it_18, it_19
 DO WHILE sto_p=0 .AND. tan<=tab_k .AND. ( .NOT. EOF())
    sha_p1 = 0
    ta_n = tan
    SELECT 2
    SEEK ta_n
    SELECT 1
    STORE 0 TO i_3, i_4, i_6, i_7, i_9, i_12, i_15, i_16, i_17, i_18, i_19, obl_sum
    DO WHILE tan<=tab_k .AND. tan=ta_n .AND. ( .NOT. EOF())
       IF sha_p=0
          DO sapka
       ENDIF
       IF sha_p1=0
          ? SPACE(14), 'Таб. N ', ta_n, ' ', z1.fio
          stro_k = stro_k+1
          sha_p1 = 1
       ENDIF
       ? '', mes, '', nal, '', STR(valsowdox, 12, _k), STR(dohskid, 12, _k), STR(sumskid, 12, _k)
       ?? '', STR(vsgd, 12, _k), STR(sn, 12, _k), ' ', bid, '', STR(sumv, 12, _k)
       ?? SPACE(26), STR(un, 12, _k)
       stro_k = stro_k+1
       i_3 = i_3+valsowdox
       i_4 = i_4+dohskid
       i_6 = i_6+sumskid
       i_7 = i_7+vsgd
       i_9 = i_9+sn
       i_12 = i_12+sumv
       i_17 = i_17+un
       SKIP
    ENDDO
    IF i_9>0
       ps_1920 = i_9*0.01 
    ELSE
       ps_1920 = 0
    ENDIF
    sum_v = i_12-ps_1920
    i_15 = i_7-sum_v
    IF i_15>0
       i_16 = i_9-ps_1920
       i_18 = INT(i_16)*proc_1
    ELSE
       i_15 = 0
       obl_sum = i_7+i_9-i_12
       IF obl_sum>0
          i_16 = obl_sum
          i_18 = INT(i_16)*proc_1
       ELSE
          i_16 = 0
          i_18 = 0
       ENDIF
    ENDIF
    IF i_18>i_17
       i_18 = i_17
    ENDIF
    ? 'по Таб.', STR(i_3, 12, _k), STR(i_4, 12, _k), STR(i_6, 12, _k)
    ?? '', STR(i_7, 12, _k), STR(i_9, 12, _k), SPACE(5), STR(i_12, 12, _k)
    ?? '', STR(i_15, 12, _k), STR(i_16, 12, _k), STR(i_17, 12, _k), STR(i_18, 12, _k)
    IF obl_sum<0
    ENDIF
    IF i_19<>0
    ENDIF
    it_3 = it_3+i_3
    it_4 = it_4+i_4
    it_6 = it_6+i_6
    it_7 = it_7+i_7
    it_9 = it_9+i_9
    it_12 = it_12+i_12
    it_15 = it_15+i_15
    it_16 = it_16+i_16
    it_17 = it_17+i_17
    it_18 = it_18+i_18
    it_19 = it_19+i_19
    ? '-----------------------------------------------------------------------------------------------------------------------------------------------'
    stro_k = stro_k+2
    IF stro_k>60
       zik_l = 0
       DO WHILE zik_l<10
          ?
          zik_l = zik_l+1
       ENDDO
       sha_p = 0
       stro_k = 0
    ENDIF
 ENDDO
 ?
 ? '==============================================================================================================================================='
 ? 'Итого  по Ведомости :'
 ? SPACE(7), STR(it_3, 12, _k), STR(it_4, 12, _k), STR(it_6, 12, _k)
 ?? '', STR(it_7, 12, _k), STR(it_9, 12, _k), SPACE(5), STR(it_12, 12, _k)
 ?? '', STR(it_15, 12, _k), STR(it_16, 12, _k), STR(it_17, 12, _k), STR(it_18, 12, _k)
 ?
 ?
 ? SPACE(45), '  ', z_m_g, 'г.            Бухгалтер  _____________________'
 ?
 stro_k = stro_k+11
 IF stro_k>60
    zik_l = 0
    DO WHILE zik_l<10
       ?
       zik_l = zik_l+1
    ENDDO
    sha_p = 0
    stro_k = 0
 ENDIF
 CLOSE ALL
 ? '@'
 SET PRINTER OFF
 SET ALTERNATE OFF
 DEACTIVATE WINDOW ALL
 RELEASE WINDOW print
 CLEAR WINDOW
 CLEAR
 ON KEY
 HIDE POPUP ALL
 IF prn_disp=1
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' Налоговая  Каpточка  по Таб.N   в pазpезе  пpедпpиятия ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND prosmotr.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
    DELETE FILE prosmotr.txt
 ENDIF
 SHOW POPUP popprint
 RETURN
*
PROCEDURE nalkarbr
 CLEAR
 CLOSE ALL
 IF pere_brig=0
    DO perebrig
    pere_brig = 1
 ENDIF
 DO zprindis
 IF prn_disp=2
    srift_15 = '24'
    srift_18 = '33'
    DO zsrift
    IF srif_t=1
       ? 'M'
    ENDIF
 ENDIF
 DO zwbritan
 CLEAR
 @ 10, 1 SAY PADC('Идет  индексация  по  Участку  и Таб. N ... ', 80)
 SELECT 2
 USE zap1 ALIAS z1
 INDEX ON bri+tan TO zap1
 SELECT 1
 USE znal
 SET FILTER TO mes<=mes_t .AND. VAL(tan)>0
 INDEX ON bri+tan+mes TO znal
 SET RELATION TO bri+tan INTO z1
 CLEAR
 @ 10, 1 SAY PADC('Ищу  начало  печати  ...', 80)
 t_1 = bri_n+tab_n
 SEEK t_1
 IF EOF()
    GOTO TOP
    DO WHILE bri<bri_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
    DO WHILE tan<tab_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 ACTIVATE WINDOW print
 stro_k = 0
 sto_p = 0
 STORE 0 TO ito_3, ito_4, ito_6, ito_7, ito_9, ito_12, ito_15, ito_16, ito_17, ito_18, ito_19
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. tan<=tab_k .AND. ( .NOT. EOF())
    sha_p = 0
    stro_k = 0
    br_i = bri
    STORE 0 TO it_3, it_4, it_6, it_7, it_9, it_12, it_15, it_16, it_17, it_18, it_19
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. tan<=tab_k .AND. ( .NOT. EOF())
       sha_p1 = 0
       ta_n = tan
       SELECT 2
       SEEK br_i+ta_n
       SELECT 1
       STORE 0 TO i_3, i_4, i_6, i_7, i_9, i_12, i_15, i_16, i_17, i_18, i_19, obl_sum
       DO WHILE sto_p=0 .AND. bri<=bri_k .AND. tan<=tab_k .AND. bri=br_i .AND. tan=ta_n .AND. ( .NOT. EOF())
          IF sha_p=0
             DO sapka
          ENDIF
          IF sha_p1=0
             ? SPACE(14), 'Таб. N ', ta_n, ' ', z1.fio
             stro_k = stro_k+1
             sha_p1 = 1
          ENDIF
          ? '', mes, '', nal, '', STR(valsowdox, 12, _k), STR(dohskid, 12, _k), STR(sumskid, 12, _k)
          ?? '', STR(vsgd, 12, _k), STR(sn, 12, _k), ' ', bid, '', STR(sumv, 12, _k)
          ?? SPACE(26), STR(un, 12, _k)
          stro_k = stro_k+1
          i_3 = i_3+valsowdox
          i_4 = i_4+dohskid
          i_6 = i_6+sumskid
          i_7 = i_7+vsgd
          i_9 = i_9+sn
          i_12 = i_12+sumv
          i_17 = i_17+un
          SKIP
       ENDDO
       IF i_9>0
          ps_1920 = i_9*0.01 
       ELSE
          ps_1920 = 0
       ENDIF
       sum_v = i_12-ps_1920
       i_15 = i_7-sum_v
       IF i_15>0
          i_16 = i_9-ps_1920
          i_18 = INT(i_16)*proc_1
       ELSE
          i_15 = 0
          obl_sum = i_7+i_9-i_12
          IF obl_sum>0
             i_16 = obl_sum
             i_18 = INT(i_16)*proc_1
          ELSE
             i_16 = 0
             i_18 = 0
          ENDIF
       ENDIF
       IF i_18>i_17
          i_18 = i_17
       ENDIF
       ? 'по Таб.', STR(i_3, 12, _k), STR(i_4, 12, _k), STR(i_6, 12, _k)
       ?? '', STR(i_7, 12, _k), STR(i_9, 12, _k), SPACE(5), STR(i_12, 12, _k)
       ?? '', STR(i_15, 12, _k), STR(i_16, 12, _k), STR(i_17, 12, _k), STR(i_18, 12, _k)
       IF obl_sum<0
       ENDIF
       IF i_19<>0
       ENDIF
       it_3 = it_3+i_3
       it_4 = it_4+i_4
       it_6 = it_6+i_6
       it_7 = it_7+i_7
       it_9 = it_9+i_9
       it_12 = it_12+i_12
       it_15 = it_15+i_15
       it_16 = it_16+i_16
       it_17 = it_17+i_17
       it_18 = it_18+i_18
       it_19 = it_19+i_19
       ito_3 = ito_3+i_3
       ito_4 = ito_4+i_4
       ito_6 = ito_6+i_6
       ito_7 = ito_7+i_7
       ito_9 = ito_9+i_9
       ito_12 = ito_12+i_12
       ito_15 = ito_15+i_15
       ito_16 = ito_16+i_16
       ito_17 = ito_17+i_17
       ito_18 = ito_18+i_18
       ito_19 = ito_19+i_19
       ? '-----------------------------------------------------------------------------------------------------------------------------------------------'
       stro_k = stro_k+2
       IF stro_k>60
          zik_l = 0
          DO WHILE zik_l<10
             ?
             zik_l = zik_l+1
          ENDDO
          sha_p = 0
          stro_k = 0
       ENDIF
    ENDDO
    ? '==============================================================================================================================================='
    ? ' Итого по', br_i, ' Участку :'
    ? SPACE(7), STR(it_3, 12, _k), STR(it_4, 12, _k), STR(it_6, 12, _k)
    ?? '', STR(it_7, 12, _k), STR(it_9, 12, _k), SPACE(5), STR(it_12, 12, _k)
    ?? '', STR(it_15, 12, _k), STR(it_16, 12, _k), STR(it_17, 12, _k), STR(it_18, 12, _k)
    ?
    ?
    ?
    stro_k = stro_k+8
 ENDDO
 ? '==============================================================================================================================================='
 ? 'Итого  по Ведомости :'
 ? SPACE(7), STR(ito_3, 12, _k), STR(ito_4, 12, _k), STR(ito_6, 12, _k)
 ?? '', STR(ito_7, 12, _k), STR(ito_9, 12, _k), SPACE(5), STR(ito_12, 12, _k)
 ?? '', STR(ito_15, 12, _k), STR(ito_16, 12, _k), STR(ito_17, 12, _k), STR(ito_18, 12, _k)
 ?
 ?
 ? SPACE(45), '  ', z_m_g, 'г.            Бухгалтер  _____________________'
 ?
 ?
 ?
 ?
 CLOSE ALL
 ? '@'
 SET PRINTER OFF
 SET ALTERNATE OFF
 DEACTIVATE WINDOW ALL
 RELEASE WINDOW print
 CLEAR WINDOW
 CLEAR
 ON KEY
 HIDE POPUP ALL
 IF prn_disp=1
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' Налоговая  Каpточка  по Участкам ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND prosmotr.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
    DELETE FILE prosmotr.txt
 ENDIF
 SHOW POPUP popprint
 RETURN
*
PROCEDURE sapka
 ? '  ', or__g, SPACE(14), ' HАЛОГОВАЯ     КАРТОЧКА       за  Январь -', me__s, 'г.'
 ?
 IF nal_kar=2
    ? ' Участок ', br_i
 ELSE
    ? SPACE(12)
 ENDIF
 ?? SPACE(43), ' на  ', z_m_g, 'г. '
 ? '-----------------------------------------------------------------------------------------------------------------------------------------------'
 ? '   |   |  ВАЛОВЫЙ  СОВОКУПНЫЙ  ГОДОВОЙ  ДОХОД |  ДОХОДЫ для НАЛОГООБЛОЖ.| УСТАНОВ. ЗАКОНОМ | СУММА ОБЛАГАЕМОГО ДОХОДА|      СУММА   НАЛОГА     |'
 ? '   |   |--------------------------------------|-------------------------|    В Ы Ч Е Т Ы   |-------------------------|-------------------------|'
 ? 'Ме-| Ш |   ДОХОДЫ   |   Доходы,  по которым   |СУММА ВАЛОВ.| Сумма коэф.|------------------|            |            |НАЧИСЛЕННАЯ | в том числе|'
 ? 'сяц| Н | ВКЛ. в ВАЛ.|  законом  установлены   |СОВОКУПНОГО | и севеpных |     |  СУММА     | СОВОКУПНЫЙ |  Коэфф. и  |     и      | с Коэфф. и |'
 ? '   | П | СОВ. ДОХОД |        скидки           | ГОД.ДОХОДА |  надбавок  | Код |  ВЫЧЕТА    |   ГОДОВОЙ  |  севеpные  | УДЕРЖАННАЯ |  севеpных  |'
 ? '   |   |------------|-------------------------|  за месяц  |  за месяц  | выч.| за месяц   |    ДОХОД   |  надбавки  |   ВСЕГО    |  надбавок  |'
 ? '   |   |Сумма дохода|Сумма дохода|Сумма скидки|и с нач.года|и с нач.года|     |и с нач.года|            |            |            |            |'
 ? '---|---|------------|------------|------------|------------|------------|-----|------------|------------|------------|------------|------------|'
 ? ' 1 | 2 |     3      |    4-5     |      6     |    7-8     |    9-10    |  11 |  12-13-14  |     15     |     16     |   17, 19   |   18, 20   |'
 ? '-----------------------------------------------------------------------------------------------------------------------------------------------'
 sha_p = 1
 stro_k = stro_k+15
 RETURN
*
PROCEDURE perebrig
 CLEAR
 CLOSE ALL
 SELECT 2
 USE zap1 ALIAS z1
 IF ind_zap1tn=0
    CLEAR
    @ 10, 1 SAY PADC('Идет  индексация  спpавочника pаботающих ... ', 80)
    INDEX ON tan TO zap1tan
    ind_zap1tn = 1
 ELSE
    SET INDEX TO zap1tan
 ENDIF
 SELECT 1
 USE znal
 SET FILTER TO mes<=mes_t .AND. VAL(tan)>0
 IF ind_znaltn=0
    CLEAR
    @ 10, 1 SAY PADC('Идет  индексация  налогового файла  по Таб.N  ... ', 80)
    INDEX ON tan+mes TO znaltan
    ind_znaltn = 1
 ELSE
    SET INDEX TO znaltan
 ENDIF
 SET RELATION TO tan INTO z1
 CLEAR
 @ 3, 1 SAY PADC('Пpовеpяю  не пpоходит-ли  один Таб.N  по нескольким  участкам,', 80)
 @ 5, 1 SAY PADC('Запишу  номеp участка  из спpавочника  pаботающих ...', 80)
 DEFINE WINDOW bri FROM 7, 2 TO 18, 77 TITLE ' Ждите ... ' COLOR W+/BG 
 ACTIVATE WINDOW bri
 SET ALTERNATE TO prosmotr.txt
 SET ALTERNATE ON
 poka_s = 0
 DO WHILE  .NOT. EOF()
    br_i = bri
    ta_n = tan
    fi_o = fio
    odin_ras = 0
    SELECT 2
    SEEK ta_n
    IF FOUND()
       br_i = bri
       fi_o = fio
    ENDIF
    SELECT 1
    DO WHILE tan=ta_n .AND. ( .NOT. EOF())
       IF bri<>br_i
          IF odin_ras=0
             ? ' ', fi_o, ' Таб.N ', ta_n, ' Уч.', br_i, ' и  Уч.', bri, ' -> слит в', br_i
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
    ? PADC('Этим Таб. N  в Налоговой каpточке  поставлен  единый участок :', 80)
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
       WAIT '             ВСТАВЬТЕ  бумагу  шиpиной   21  см. и  нажмите  ==> Enter '
       SET PRINTER ON
       ?? CHR(18)
       SET HEADING OFF
       ?
       ?
       ? PADC(' Список Табельных N  имеющих pазные коды  участков', 78)
       ?
       ? ' ----------------------------------------------------------------------'
       ? '          Ф.  И.  О.       |   Таб. N   | Участок | Участок | Участок  |'
       ? '                           |            |в спpавоч|   был   |   стал   |'
       ? ' ----------------------------------------------------------------------'
       ?
       TYPE prosmotr.txt TO PRINTER
       SET PRINTER OFF
    ENDIF
    DELETE FILE prosmotr.txt
 ENDIF
 RETURN
*
