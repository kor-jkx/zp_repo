 DO zdattime
 CLEAR
 CLOSE ALL
 HIDE POPUP ALL
 SET TALK OFF
 SET SAFETY OFF
 SET PRINTER OFF
 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    @ 3, 21 TO 5, 60
    @ 4, 28 SAY '  ЧТО  БУДЕМ  ПЕЧАТАТЬ ? '
    @ 7, 11 PROMPT ' 1. Свод  HАЧИСЛЕHИЙ  по  видам  оплат по  ПРЕДПРИЯТИЮ.    ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 8, 11 PROMPT ' 2. Свод  начислений  по КАТЕГОРИЯМ и Видам оплат          ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 9, 11 PROMPT ' 3. Свод  начислений  по  УЧАСТКАМ и Видам оплат           ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 10, 11 PROMPT ' 4. Свод  начислений  по  УЧАСТКАМ, КАТЕГОРИЯМ  и  В/О     ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 11, 11 PROMPT ' 5. Свод  начислений  по ШПЗ  и  Видам оплат               ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 12, 11 PROMPT ' 6. Свод  начислений  по  УЧАСТКАМ, ШПЗ  и  Видам оплат    ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 13, 11 PROMPT ' 7. Свод  УДЕРЖАHИЙ   по видам удержаний по ПРЕДПРИЯТИЮ.   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 14, 11 PROMPT ' 8. Свод  удеpжаний   по  УЧАСТКАМ  и  в/у                 ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 15, 11 PROMPT '                <---  В Ы Х О Д  --->                      ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
    @ 6, 10 TO 16, 70 DOUBLE
    MENU TO svo_d
    IF svo_d=1
       DO svod1
    ENDIF
    IF svo_d=2
       DO svod2
    ENDIF
    IF svo_d=3
       DO svod3
    ENDIF
    IF svo_d=4
       DO svod4
    ENDIF
    IF svo_d=5
       DO svod5
    ENDIF
    IF svo_d=6
       DO svod6
    ENDIF
    IF svo_d=7
       DO svod7
    ENDIF
    IF svo_d=8
       DO svod8
    ENDIF
    IF svo_d=9
       kone_z = 1
       CLOSE ALL
       DEACTIVATE WINDOW print
       RELEASE WINDOW print
       HIDE POPUP ALL
       SET PRINTER OFF
       ON KEY
       CLEAR
       RETURN
    ENDIF
 ENDDO
*
PROCEDURE svod1
 SET TALK OFF
 SET SAFETY OFF
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  20 см.  и  нажмите  Enter ===> '
 SELECT 2
 USE svoud ALIAS z1
 IF svod_1=0
    INDEX ON bid TO svoud
 ELSE
    SET INDEX TO svoud
 ENDIF
 SELECT 1
 USE zap3
 IF svod_1=0
    CLEAR
    @ 9, 12 SAY ' Индексиpуется  массив Начислений  по Видам  Оплат ...'
    INDEX ON bid TO zap3bid
    svod_1 = 1
 ELSE
    SET INDEX TO zap3bid
 ENDIF
 GOTO TOP
 DO printda
 ?
 ? SPACE(10), ' СВОД HАЧИСЛЕHИЙ  З/ПЛАТЫ  ПО ВИДАМ  ОПЛАТ'
 ?
 ?
 ? SPACE(4), or__g, SPACE(7), 'за', me__s, 'г.'
 ?
 stro_k = 6
 scha_p = 0
 sto_p = 0
 STORE 0 TO it_smm, it_dni, it_chas
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    IF scha_p=0
       ? '-----------------------------------------------------------------'
       ? '  НАИМЕНОВАНИЕ    | КОД |   С У М М А  |    ДHИ     |    ЧАСЫ    |'
       ? '   HАЧИСЛЕHИЙ     |     |              |            |            |'
       ? '-----------------------------------------------------------------'
       stro_k = stro_k+4
       scha_p = 1
    ENDIF
    bi_d = bid
    STORE 0 TO i_smm, i_dni, i_chas
    DO WHILE sto_p=0 .AND. bid=bi_d .AND. ( .NOT. EOF())
       i_smm = i_smm+smm
       it_smm = it_smm+smm
       i_dni = i_dni+dni
       it_dni = it_dni+dni
       i_chas = i_chas+chas
       it_chas = it_chas+chas
       SKIP
    ENDDO
    SELECT 2
    SEEK bi_d
    no_u = nou
    SELECT 1
    ?
    ? '', no_u, '   ', bi_d, '', STR(i_smm, 13, _k), ' ', STR(i_dni, 10, 1), ' ', STR(i_chas, 10, 1)
    stro_k = stro_k+2
    IF stro_k>=60
       zik_l = 0
       DO WHILE zik_l<10
          zik_l = zik_l+1
          ?
       ENDDO
       scha_p = 0
       stro_k = 0
    ENDIF
 ENDDO
 ?
 ? '= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ='
 ?
 ? SPACE(10), 'В С Е Г О :  ', STR(it_smm, 13, _k), '*', STR(it_dni, 10, 1), '*', STR(it_chas, 10, 1), '*',
 ?
 stro_k = stro_k+5
 DO WHILE stro_k<=78
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DO printnet
 RETURN
*
PROCEDURE svod2
 SET TALK OFF
 SET SAFETY OFF
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  21 см.  и  нажмите  Enter ===> '
 SELECT 2
 USE svoud ALIAS z1
 IF svod_2=0
    INDEX ON bid TO svoud
 ELSE
    SET INDEX TO svoud
 ENDIF
 SELECT 1
 USE zap3
 IF svod_2=0
    CLEAR
    @ 9, 9 SAY ' Индексиpуется  массив  Начислений  по Категоpиям  и  В/О ...'
    INDEX ON kat+bid TO zap3kat
    svod_2 = 1
 ELSE
    SET INDEX TO zap3kat
 ENDIF
 GOTO TOP
 DO printda
 ?
 ? SPACE(10), ' СВОД HАЧИСЛЕHИЙ  З/ПЛАТЫ  по  КАТЕГОРИЯМ и ВИДАМ  ОПЛАТ'
 ?
 ?
 ? SPACE(4), or__g, SPACE(7), 'за', me__s, 'г.'
 ?
 stro_k = 6
 scha_p = 0
 sto_p = 0
 STORE 0 TO ito_smm, ito_dni, ito_chas
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    ka_t = kat
    STORE 0 TO it_smm, it_dni, it_chas
    DO WHILE sto_p=0 .AND. kat=ka_t .AND. ( .NOT. EOF())
       IF scha_p=0
          ? '----------------------------------------------------------------------'
          ? ' КАТЕ- |  НАИМЕНОВАНИЕ | КОД |  С У М М А   |    ДHИ     |    ЧАСЫ    |'
          ? ' ГОРИЯ |   HАЧИСЛЕHИЙ  |     |              |            |            |'
          ? '----------------------------------------------------------------------'
          stro_k = stro_k+4
          scha_p = 1
       ENDIF
       bi_d = bid
       STORE 0 TO i_smm, i_dni, i_chas
       DO WHILE sto_p=0 .AND. kat=ka_t .AND. bid=bi_d .AND. ( .NOT. EOF())
          i_smm = i_smm+smm
          it_smm = it_smm+smm
          ito_smm = ito_smm+smm
          i_dni = i_dni+dni
          it_dni = it_dni+dni
          ito_dni = ito_dni+dni
          i_chas = i_chas+chas
          it_chas = it_chas+chas
          ito_chas = ito_chas+chas
          SKIP
       ENDDO
       SELECT 2
       SEEK bi_d
       no_u = nou
       SELECT 1
       ? ' ', ka_t, '  ', no_u, '  ', bi_d, STR(i_smm, 13, _k), ' ', STR(i_dni, 10, 1), ' ', STR(i_chas, 10, 1)
       stro_k = stro_k+1
       IF stro_k>=60
          zik_l = 0
          DO WHILE zik_l<10
             zik_l = zik_l+1
             ?
          ENDDO
          scha_p = 0
          stro_k = 0
       ENDIF
    ENDDO
    ? '     ИТОГО  по ', ka_t, ' КАТЕГОРИИ', STR(it_smm, 13, _k), '*', STR(it_dni, 10, 1), '*', STR(it_chas, 10, 1), '*'
    ?
    stro_k = stro_k+2
 ENDDO
 ? '= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = '
 ?
 ? SPACE(15), 'В С Е Г О :  ', STR(ito_smm, 13, _k), '*', STR(ito_dni, 10, 1), '*', STR(ito_chas, 10, 1), '*'
 ?
 stro_k = stro_k+4
 DO WHILE stro_k<=78
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DO printnet
 RETURN
*
PROCEDURE svod3
 SET TALK OFF
 SET SAFETY OFF
 DO zwiborbr
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  21 см.  и  нажмите  Enter ===> '
 SELECT 2
 USE svoud ALIAS z1
 IF svod_3=0
    INDEX ON bid TO svoud
 ELSE
    SET INDEX TO svoud
 ENDIF
 SELECT 1
 USE zap3
 IF svod_3=0
    CLEAR
    @ 9, 9 SAY ' Индексиpуется  массив  Начислений  по  УЧАСТКАМ  и  В/О ...'
    INDEX ON bri+bid TO zap3bri
    svod_3 = 1
 ELSE
    SET INDEX TO zap3bri
 ENDIF
 GOTO TOP
 CLEAR
 @ 9, 18 SAY ' Бегу  искать  начало  печати  ... '
 pois_k = bri_n
 SEEK pois_k
 IF EOF()
    GOTO TOP
    DO WHILE bri<bri_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 IF EOF()
    CLEAR
    @ 9, 20 SAY ' Hет  такого   УЧАСТКА  в  массиве '
    @ 8, 10 FILL TO 9, 70 COLOR GR+/RB 
    ?
    ?
    WAIT '             ДЛЯ  продолжения  нажмите   ---> Enter '
 ENDIF
 DO printda
 ?
 ? SPACE(10), ' СВОД HАЧИСЛЕHИЙ  З/ПЛАТЫ  по  УЧАСТКАМ  и  ВИДАМ  ОПЛАТ'
 ?
 ?
 ? SPACE(4), or__g, SPACE(7), 'за', me__s, 'г.'
 ?
 stro_k = 6
 scha_p = 0
 sto_p = 0
 STORE 0 TO ito_smm, ito_dni, ito_chas
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. ( .NOT. EOF())
    br_i = bri
    STORE 0 TO it_smm, it_dni, it_chas
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. ( .NOT. EOF())
       IF scha_p=0
          ? '----------------------------------------------------------------------'
          ? ' УЧАС- |  НАИМЕНОВАНИЕ | КОД |  С У М М А   |    ДHИ     |    ЧАСЫ    |'
          ? ' ТОК   |   HАЧИСЛЕHИЙ  |     |              |            |            |'
          ? '----------------------------------------------------------------------'
          stro_k = stro_k+4
          scha_p = 1
       ENDIF
       bi_d = bid
       STORE 0 TO i_smm, i_dni, i_chas
       DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. bid=bi_d .AND. ( .NOT. EOF())
          i_smm = i_smm+smm
          it_smm = it_smm+smm
          ito_smm = ito_smm+smm
          i_dni = i_dni+dni
          it_dni = it_dni+dni
          ito_dni = ito_dni+dni
          i_chas = i_chas+chas
          it_chas = it_chas+chas
          ito_chas = ito_chas+chas
          SKIP
       ENDDO
       SELECT 2
       SEEK bi_d
       no_u = nou
       SELECT 1
       ? ' ', br_i, '  ', no_u, '  ', bi_d, STR(i_smm, 13, _k), ' ', STR(i_dni, 10, 1), ' ', STR(i_chas, 10, 1)
       stro_k = stro_k+1
       IF stro_k>=60
          zik_l = 0
          DO WHILE zik_l<10
             zik_l = zik_l+1
             ?
          ENDDO
          scha_p = 0
          stro_k = 0
       ENDIF
    ENDDO
    ?
    ? '     ИТОГО  по ', br_i, ' УЧАСТКУ  ', STR(it_smm, 13, _k), '*', STR(it_dni, 10, 1), '*', STR(it_chas, 10, 1), '*'
    ? '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - '
    ?
    stro_k = stro_k+4
 ENDDO
 ? '= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = '
 ?
 ? SPACE(15), 'В С Е Г О :  ', STR(ito_smm, 13, _k), '*', STR(ito_dni, 10, 1), '*', STR(ito_chas, 10, 1), '*'
 ?
 stro_k = stro_k+4
 DO WHILE stro_k<=78
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DO printnet
 RETURN
*
PROCEDURE svod4
 SET TALK OFF
 SET SAFETY OFF
 DO zwiborbr
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  22 см.  и  нажмите  Enter ===> '
 SELECT 2
 USE svoud ALIAS z1
 IF svod_4=0
    INDEX ON bid TO svoud
 ELSE
    SET INDEX TO svoud
 ENDIF
 SELECT 1
 USE zap3
 IF svod_4=0
    CLEAR
    @ 9, 9 SAY ' Индексиpуется   начисления  по  УЧАСТКАМ, КАТЕГОРИЯМ  и  В/О ...'
    INDEX ON bri+kat+bid TO zap3brkat
    svod_4 = 1
 ELSE
    SET INDEX TO zap3brkat
 ENDIF
 GOTO TOP
 CLEAR
 @ 9, 18 SAY ' Бегу  искать  начало  печати  ... '
 pois_k = bri_n
 SEEK pois_k
 IF EOF()
    GOTO TOP
    DO WHILE bri<bri_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 IF EOF()
    CLEAR
    @ 9, 20 SAY ' Hет  такого   УЧАСТКА  в  массиве '
    @ 8, 10 FILL TO 9, 70 COLOR GR+/RB 
    ?
    ?
    WAIT '             ДЛЯ  продолжения  нажмите   ---> Enter '
 ENDIF
 DO printda
 ?
 ? SPACE(10), ' СВОД HАЧИСЛЕHИЙ  З/ПЛАТЫ  по  УЧАСТКАМ, КАТЕГОРИЯМ  и  В/О'
 ?
 ?
 ? SPACE(4), or__g, SPACE(7), 'за', me__s, 'г.'
 ?
 stro_k = 6
 scha_p = 0
 sto_p = 0
 STORE 0 TO itog_smm, itog_dni, itog_chas
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. ( .NOT. EOF())
    br_i = bri
    STORE 0 TO ito_smm, ito_dni, ito_chas
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. ( .NOT. EOF())
       ka_t = kat
       STORE 0 TO it_smm, it_dni, it_chas
       DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. kat=ka_t .AND. ( .NOT. EOF())
          IF scha_p=0
             ? '------------------------------------------------------------------------------'
             ? ' УЧАС-| КАТЕ- |  НАИМЕНОВАНИЕ | КОД |  С У М М А   |    ДHИ     |    ЧАСЫ     |'
             ? ' ТОК  | ГОРИЯ |   HАЧИСЛЕHИЙ  |     |              |            |             |'
             ? '------------------------------------------------------------------------------'
             stro_k = stro_k+4
             scha_p = 1
          ENDIF
          bi_d = bid
          STORE 0 TO i_smm, i_dni, i_chas
          DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. kat=ka_t .AND. bid=bi_d .AND. ( .NOT. EOF())
             i_smm = i_smm+smm
             it_smm = it_smm+smm
             ito_smm = ito_smm+smm
             itog_smm = itog_smm+smm
             i_dni = i_dni+dni
             it_dni = it_dni+dni
             ito_dni = ito_dni+dni
             itog_dni = itog_dni+dni
             i_chas = i_chas+chas
             it_chas = it_chas+chas
             ito_chas = ito_chas+chas
             itog_chas = itog_chas+chas
             SKIP
          ENDDO
          SELECT 2
          SEEK bi_d
          no_u = nou
          SELECT 1
          ? '  ', br_i, '  ', ka_t, '  ', no_u, '  ', bi_d, STR(i_smm, 13, _k), ' ', STR(i_dni, 10, 1), ' ', STR(i_chas, 10, 1)
          stro_k = stro_k+1
          IF stro_k>=60
             zik_l = 0
             DO WHILE zik_l<10
                zik_l = zik_l+1
                ?
             ENDDO
             scha_p = 0
             stro_k = 0
          ENDIF
       ENDDO
       ? SPACE(11), 'ИТОГО  по ', ka_t, ' КАТЕГОРИИ', STR(it_smm, 13, _k), '*', STR(it_dni, 10, 1), '*', STR(it_chas, 10, 1), '*'
       ?
       stro_k = stro_k+2
    ENDDO
    ? '-----------------------------------------------------------------------------'
    ? SPACE(11), 'ИТОГО  по ', br_i, ' УЧАСТКУ  ', STR(ito_smm, 13, _k), '*', STR(ito_dni, 10, 1), '*', STR(ito_chas, 10, 1), '*'
    ? '-----------------------------------------------------------------------------'
    ?
    stro_k = stro_k+4
 ENDDO
 ? '= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ='
 ?
 ? SPACE(22), 'В С Е Г О :  ', STR(itog_smm, 13, _k), '*', STR(itog_dni, 10, 1), '*', STR(itog_chas, 10, 1), '*'
 ?
 stro_k = stro_k+4
 DO WHILE stro_k<=78
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DO printnet
 RETURN
*
PROCEDURE svod5
 SET TALK OFF
 SET SAFETY OFF
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  21 см.  и  нажмите  Enter ===> '
 SELECT 2
 USE svoud ALIAS z1
 IF svod_5=0
    INDEX ON bid TO svoud
 ELSE
    SET INDEX TO svoud
 ENDIF
 SELECT 1
 USE zap3
 IF svod_5=0
    CLEAR
    @ 9, 13 SAY ' Индексиpуется  массив  Начислений  по Ш П З   и  В/О ...'
    INDEX ON LEFT(shpz, 2)+RIGHT(shpz, 3)+bid TO zap3spz
    svod_5 = 1
 ELSE
    SET INDEX TO zap3spz
 ENDIF
 GOTO TOP
 DO printda
 ?
 ? SPACE(10), ' СВОД HАЧИСЛЕHИЙ  З/ПЛАТЫ  по  Ш П З   и  В/О'
 ?
 ?
 ? SPACE(4), or__g, SPACE(7), 'за', me__s, 'г.'
 ?
 stro_k = 6
 scha_p = 0
 sto_p = 0
 STORE 0 TO itog_smm, itog_dni, itog_chas
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    bal_sz = LEFT(shpz, 2)
    STORE 0 TO ito_smm, ito_dni, ito_chas
    DO WHILE sto_p=0 .AND. bal_sz=LEFT(shpz, 2) .AND. ( .NOT. EOF())
       st_satr = RIGHT(shpz, 3)
       STORE 0 TO it_smm, it_dni, it_chas
       DO WHILE sto_p=0 .AND. bal_sz=LEFT(shpz, 2) .AND. st_satr=RIGHT(shpz, 3) .AND. ( .NOT. EOF())
          IF scha_p=0
             ? '------------------------------------------------------------------------------'
             ? '     Ш П З    |  НАИМЕНОВАНИЕ | КОД |              |            |             |'
             ? '--------------|   HАЧИСЛЕHИЙ  |ОПЛАТ|  С У М М А   |    ДНИ     |    ЧАСЫ     |'
             ? 'Бал.сч.|Ст.зат|               |     |              |            |             |'
             ? '------------------------------------------------------------------------------'
             stro_k = stro_k+5
             scha_p = 1
          ENDIF
          bi_d = bid
          STORE 0 TO i_smm, i_dni, i_chas
          DO WHILE sto_p=0 .AND. bal_sz=LEFT(shpz, 2) .AND. st_satr=RIGHT(shpz, 3) .AND. bid=bi_d .AND. ( .NOT. EOF())
             i_smm = i_smm+smm
             it_smm = it_smm+smm
             ito_smm = ito_smm+smm
             itog_smm = itog_smm+smm
             i_dni = i_dni+dni
             it_dni = it_dni+dni
             ito_dni = ito_dni+dni
             itog_dni = itog_dni+dni
             i_chas = i_chas+chas
             it_chas = it_chas+chas
             ito_chas = ito_chas+chas
             itog_chas = itog_chas+chas
             SKIP
          ENDDO
          SELECT 2
          SEEK bi_d
          no_u = nou
          SELECT 1
          ? '    ', bal_sz, '', st_satr, '  ', no_u, ' ', bi_d, STR(i_smm, 13, _k), ' ', STR(i_dni, 10, 1), ' ', STR(i_chas, 10, 1)
          stro_k = stro_k+1
          IF stro_k>=60
             zik_l = 0
             DO WHILE zik_l<10
                zik_l = zik_l+1
                ?
             ENDDO
             scha_p = 0
             stro_k = 0
          ENDIF
       ENDDO
       ? SPACE(11), 'ИТОГО  по ', st_satr, ' Статье  ', STR(it_smm, 13, _k), '*', STR(it_dni, 10, 1), '*', STR(it_chas, 10, 1), '*'
       ?
       stro_k = stro_k+2
    ENDDO
    ? '-----------------------------------------------------------------------------'
    ? SPACE(11), 'ИТОГО  по ', bal_sz, ' БАЛ.СЧЕТУ', STR(ito_smm, 13, _k), '*', STR(ito_dni, 10, 1), '*', STR(ito_chas, 10, 1), '*'
    ? '-----------------------------------------------------------------------------'
    ?
    stro_k = stro_k+4
 ENDDO
 ? '= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ='
 ?
 ? SPACE(22), 'В С Е Г О :  ', STR(itog_smm, 13, _k), '*', STR(itog_dni, 10, 1), '*', STR(itog_chas, 10, 1), '*'
 ?
 stro_k = stro_k+4
 DO WHILE stro_k<=78
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DO printnet
 RETURN
*
PROCEDURE svod6
 SET TALK OFF
 SET SAFETY OFF
 DO zwiborbr
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  23 см.  и  нажмите  Enter ===> '
 SELECT 2
 USE svoud ALIAS z1
 IF svod_6=0
    INDEX ON bid TO svoud
 ELSE
    SET INDEX TO svoud
 ENDIF
 SELECT 1
 USE zap3
 IF svod_6=0
    CLEAR
    @ 9, 9 SAY ' Индексиpуется  массив  Начислений  по  УЧАСТКАМ,  Ш П З  и  В/О ...'
    INDEX ON bri+LEFT(shpz, 2)+RIGHT(shpz, 3)+bid TO zap3brspz
    svod_6 = 1
 ELSE
    SET INDEX TO zap3brspz
 ENDIF
 GOTO TOP
 CLEAR
 @ 9, 18 SAY ' Бегу  искать  начало  печати  ... '
 pois_k = bri_n
 SEEK pois_k
 IF EOF()
    GOTO TOP
    DO WHILE bri<bri_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 IF EOF()
    CLEAR
    @ 9, 20 SAY ' Hет  такого   УЧАСТКА  в  массиве '
    @ 8, 10 FILL TO 9, 70 COLOR GR+/RB 
    ?
    ?
    WAIT '             ДЛЯ  продолжения  нажмите   ---> Enter '
 ENDIF
 DO printda
 ?
 ? SPACE(10), ' СВОД HАЧИСЛЕHИЙ  З/ПЛАТЫ  УЧАСТКАМ,   Ш П З   и  В/О'
 ?
 ?
 ? SPACE(10), or__g, SPACE(7), 'за', me__s, 'г.'
 ?
 stro_k = 6
 scha_p = 0
 sto_p = 0
 STORE 0 TO itogo_smm, itogo_dni, itogo_chas
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. ( .NOT. EOF())
    br_i = bri
    STORE 0 TO itog_smm, itog_dni, itog_chas
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. ( .NOT. EOF())
       bal_sz = LEFT(shpz, 2)
       STORE 0 TO ito_smm, ito_dni, ito_chas
       DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bal_sz=LEFT(shpz, 2) .AND. ( .NOT. EOF())
          st_satr = RIGHT(shpz, 3)
          STORE 0 TO it_smm, it_dni, it_chas
          DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bal_sz=LEFT(shpz, 2) .AND. st_satr=RIGHT(shpz, 3) .AND. ( .NOT. EOF())
             IF scha_p=0
                ? '-------------------------------------------------------------------------------'
                ? 'УЧАС-|  Ш П З  |  НАИМЕНОВАНИЕ | КОД |              |            |             |'
                ? 'ТОК  |БАЛ.| СТ.|   HАЧИСЛЕHИЙ  |ОПЛАТ|  С У М М А   |    ДНИ     |    ЧАСЫ     |'
                ? '     |СЧЕТ|ЗАТР|               |     |              |            |             |'
                ? '-------------------------------------------------------------------------------'
                stro_k = stro_k+5
                scha_p = 1
             ENDIF
             bi_d = bid
             STORE 0 TO i_smm, i_dni, i_chas
             DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bal_sz=LEFT(shpz, 2) .AND. st_satr=RIGHT(shpz, 3) .AND. bid=bi_d .AND. ( .NOT. EOF())
                i_smm = i_smm+smm
                it_smm = it_smm+smm
                ito_smm = ito_smm+smm
                itog_smm = itog_smm+smm
                itogo_smm = itogo_smm+smm
                i_dni = i_dni+dni
                it_dni = it_dni+dni
                ito_dni = ito_dni+dni
                itog_dni = itog_dni+dni
                itogo_dni = itogo_dni+dni
                i_chas = i_chas+chas
                it_chas = it_chas+chas
                ito_chas = ito_chas+chas
                itog_chas = itog_chas+chas
                itogo_chas = itogo_chas+chas
                SKIP
             ENDDO
             SELECT 2
             SEEK bi_d
             no_u = nou
             SELECT 1
             ? ' ', br_i, ' ', bal_sz, '', st_satr, '', no_u, ' ', bi_d, '', STR(i_smm, 13, _k), ' ', STR(i_dni, 10, 1), ' ', STR(i_chas, 10, 1)
             stro_k = stro_k+1
             IF stro_k>=60
                zik_l = 0
                DO WHILE zik_l<10
                   zik_l = zik_l+1
                   ?
                ENDDO
                scha_p = 0
                stro_k = 0
             ENDIF
          ENDDO
          ? SPACE(13), 'ИТОГО  по ', st_satr, ' Статье ', STR(it_smm, 13, _k), '*', STR(it_dni, 10, 1), '*', STR(it_chas, 10, 1), '*'
          ?
          stro_k = stro_k+2
       ENDDO
       ? SPACE(13), 'ИТОГО  по ', bal_sz, 'БАЛ.СЧЕТУ', STR(ito_smm, 13, _k), '*', STR(ito_dni, 10, 1), '*', STR(ito_chas, 10, 1), '*'
       ? '------------------------------------------------------------------------------'
       ?
       stro_k = stro_k+3
    ENDDO
    ? '------------------------------------------------------------------------------'
    ? SPACE(13), 'ИТОГО  по ', br_i, ' УЧАСТКУ ', STR(itog_smm, 13, _k), '*', STR(itog_dni, 10, 1), '*', STR(itog_chas, 10, 1), '*'
    ? '------------------------------------------------------------------------------'
    ?
    stro_k = stro_k+4
 ENDDO
 ? '= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ='
 ?
 ? SPACE(24), 'В С Е Г О : ', STR(itogo_smm, 13, _k), '*', STR(itogo_dni, 10, 1), '*', STR(itogo_chas, 10, 1), '*'
 ?
 stro_k = stro_k+4
 DO WHILE stro_k<=78
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DO printnet
 RETURN
*
PROCEDURE svod7
 CLEAR
 SET TALK OFF
 SET SAFETY OFF
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  18 см.  и  нажмите  Enter ===> '
 SELECT 2
 USE svoud ALIAS z1
 IF svod_7=0
    INDEX ON bid TO svoud
 ELSE
    SET INDEX TO svoud
 ENDIF
 SELECT 1
 USE zap4
 IF svod_7=0
    CLEAR
    @ 9, 12 SAY ' Индексиpуется  массив  Удеpжаний  по  В/У ...'
    INDEX ON bid TO zap4
    svod_7 = 1
 ELSE
    SET INDEX TO zap4
 ENDIF
 GOTO TOP
 DO printda
 ?
 ? SPACE(10), ' СВОД  УДЕРЖАНИЙ  ЗАРАБОТНОЙ  ПЛАТЫ '
 ?
 ?
 ? SPACE(4), or__g, SPACE(7), 'за', me__s, 'г.'
 ?
 stro_k = 6
 scha_p = 0
 sto_p = 0
 STORE 0 TO it_smm
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    IF scha_p=0
       ? '--------------------------------------------------------'
       ? '  НАИМЕНОВАНИЕ  УДЕРЖАНИЙ        | КОД |   С У М М А    |'
       ? '                                 |     |                |'
       ? '--------------------------------------------------------'
       stro_k = stro_k+4
       scha_p = 1
    ENDIF
    STORE 0 TO i_smm
    bi_d = bid
    DO WHILE sto_p=0 .AND. bid=bi_d .AND. ( .NOT. EOF())
       i_smm = i_smm+smm
       it_smm = it_smm+smm
       SKIP
    ENDDO
    SELECT 2
    SEEK bi_d
    no_u = nou
    SELECT 1
    ?
    ? '', no_u, SPACE(17), bi_d, ' ', STR(i_smm, 14, 0)
    stro_k = stro_k+2
    IF stro_k>=60
       zik_l = 0
       DO WHILE zik_l<10
          zik_l = zik_l+1
          ?
       ENDDO
       scha_p = 0
       stro_k = 0
    ENDIF
 ENDDO
 ?
 ? '- - - - - - - - - - - - - - - - - - - - - - - - - - - -'
 ?
 ? SPACE(26), 'В С Е Г О : ', STR(it_smm, 14, 0), '*'
 ?
 stro_k = stro_k+5
 DO WHILE stro_k<=60
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DO printnet
 RETURN
*
PROCEDURE svod8
 SET TALK OFF
 SET SAFETY OFF
 DO zwiborbr
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  18 см.  и  нажмите  Enter ===> '
 SELECT 2
 USE svoud ALIAS z1
 IF svod_8=0
    INDEX ON bid TO svoud
 ELSE
    SET INDEX TO svoud
 ENDIF
 SELECT 1
 USE zap4
 IF svod_8=0
    CLEAR
    @ 9, 9 SAY ' Индексиpуется  массив  Удеpжаний  по  УЧАСТКАМ  и  В/У ...'
    INDEX ON bri+bid TO zap4bri
    svod_8 = 1
 ELSE
    SET INDEX TO zap4bri
 ENDIF
 GOTO TOP
 CLEAR
 @ 9, 18 SAY ' Бегу  искать  начало  печати  ... '
 pois_k = bri_n
 SEEK pois_k
 IF EOF()
    GOTO TOP
    DO WHILE bri<bri_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 IF EOF()
    CLEAR
    @ 9, 20 SAY ' Hет  такого   УЧАСТКА  в  массиве '
    @ 8, 10 FILL TO 9, 70 COLOR GR+/RB 
    ?
    ?
    WAIT '             ДЛЯ  продолжения  нажмите   ---> Enter '
 ENDIF
 DO printda
 ?
 ? SPACE(4), ' СВОД  УДЕРЖАНИЙ  З/ПЛАТЫ  по  УЧАСТКАМ  и  В/У '
 ?
 ?
 ? SPACE(6), or__g, SPACE(5), 'за', me__s, 'г.'
 ?
 stro_k = 6
 scha_p = 0
 sto_p = 0
 STORE 0 TO ito_smm
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. ( .NOT. EOF())
    br_i = bri
    STORE 0 TO it_smm
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. ( .NOT. EOF())
       IF scha_p=0
          ? '---------------------------------------------------------'
          ? ' УЧАС- |    НАИМЕНОВАНИЕ      | КОД |      С У М М А     |'
          ? ' ТОК   |     УДЕРЖАНИЙ        |     |                    |'
          ? '---------------------------------------------------------'
          stro_k = stro_k+4
          scha_p = 1
       ENDIF
       bi_d = bid
       STORE 0 TO i_smm
       DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. bid=bi_d .AND. ( .NOT. EOF())
          i_smm = i_smm+smm
          it_smm = it_smm+smm
          ito_smm = ito_smm+smm
          SKIP
       ENDDO
       SELECT 2
       SEEK bi_d
       no_u = nou
       SELECT 1
       ? '  ', br_i, '   ', no_u, '      ', bi_d, '     ', STR(i_smm, 13, _k)
       stro_k = stro_k+1
       IF stro_k>=60
          zik_l = 0
          DO WHILE zik_l<10
             zik_l = zik_l+1
             ?
          ENDDO
          scha_p = 0
          stro_k = 0
       ENDIF
    ENDDO
    ?
    ? SPACE(16), 'ИТОГО  по ', br_i, ' УЧАСТКУ  ', STR(it_smm, 13, _k), '*'
    ? '- - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
    ?
    stro_k = stro_k+4
 ENDDO
 ? '= = = = = = = = = = = = = = = = = = = = = = = = = = = = ='
 ?
 ? SPACE(27), 'В С Е Г О :  ', STR(ito_smm, 13, _k), '*'
 ?
 stro_k = stro_k+4
 DO WHILE stro_k<=78
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DO printnet
 RETURN
*
PROCEDURE printda
 SET PRINTER ON
 ?? CHR(18)
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 RETURN
*
PROCEDURE printnet
 DEACTIVATE WINDOW print
 RELEASE WINDOW print
 HIDE POPUP ALL
 SET PRINTER OFF
 ON KEY
 CLEAR
 RETURN
*
