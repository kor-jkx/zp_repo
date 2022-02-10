 CLOSE ALL
 SET STATUS ON
 SET BELL OFF
 SET TALK OFF
 SET SAFETY OFF
 DEACTIVATE WINDOW ALL
 CLEAR
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 DEFINE POPUP rasp0 FROM 3, 33 SHADOW MARGIN RELATIVE COLOR SCHEME 4
 use_zap3p = 0
 use_zap4p = 0
 rasp_0 = 0
 rasp_2 = 0
 DO WHILE rasp_0=0
    CLEAR
    DEFINE BAR 1 OF rasp0 PROMPT ' 1. ПЕЧАТЬ  ЕЖЕМЕСЯЧНЫХ  HАЧИСЛЕHИЙ   файл   zap3.dbf '
    DEFINE BAR 2 OF rasp0 PROMPT ' 2.                      УДЕРЖАHИЙ    файл   zap4.dbf '
    DEFINE BAR 3 OF rasp0 PROMPT ' 3. ПЕЧАТЬ  ПОСТОЯHHЫХ  HАЧИСЛЕHИЙ    файл  zap3p.dbf '
    DEFINE BAR 4 OF rasp0 PROMPT ' 4.                     УДЕРЖАHИЙ     файл  zap4p.dbf '
    DEFINE BAR 5 OF rasp0 PROMPT ' 5. ПЕЧАТЬ  %  УДЕРЖАHИЙ ( Алименты ) файл   z4pr.dbf '
    DEFINE BAR 6 OF rasp0 PROMPT ' 6. ВЫДАЧА из КАССЫ по ЧИСЛАМ  80 и 81 в/у   zap4.dbf '
    DEFINE BAR 7 OF rasp0 PROMPT '                     ВЫХОД  --> Esc '
    ON SELECTION BAR 1 OF rasp0 do rasp1
    ON SELECTION BAR 2 OF rasp0 do rasp2
    ON SELECTION BAR 3 OF rasp0 do rasp3
    ON SELECTION BAR 4 OF rasp0 do rasp4
    ON SELECTION BAR 5 OF rasp0 do rasp5
    ON SELECTION BAR 6 OF rasp0 do rasp6
    ON SELECTION BAR 7 OF rasp0 do vixod
    ACTIVATE POPUP rasp0
    IF LASTKEY()=27
       DO vixod
    ENDIF
 ENDDO
 RETURN
*
PROCEDURE vixod
 rasp_0 = 1
 CLOSE ALL
 CLEAR
 DEACTIVATE POPUP rasp0
 RELEASE POPUP rasp0
 SHOW POPUP popprint
 ON KEY
 RETURN
*
PROCEDURE rasp3
 use_zap3p = 1
 DO rasp1
 RETURN
*
PROCEDURE rasp4
 use_zap4p = 1
 DO rasp2
 RETURN
*
PROCEDURE rasp1
 HIDE POPUP ALL
 rasp_1 = 0
 DO WHILE rasp_1<>1 .AND. rasp_1<>2 .AND. rasp_1<>3 .AND. rasp_1<>4
    CLEAR
    @ 4, 22 SAY ' КАК  БУДЕМ  ПЕЧАТАТЬ  НАЧИСЛЕНИЯ ?  '
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 15, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ПЕЧАТЬ  НАЧИСЛЕНИЙ по  ПАЧКАМ  ДОКУМЕНТОВ                       ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ПЕЧАТЬ  НАЧИСЛЕНИЙ  по  ВИДАМ  ОПЛАТ                            ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 3. ПЕЧАТЬ  НАЧИСЛЕНИЙ  по  УЧАСТКАМ  и  ВИДАМ  ОПЛАТ               ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO rasp_1
 ENDDO
 IF rasp_1=1
    DO rasp1pas
 ENDIF
 IF rasp_1=2
    DO rasp1wid
 ENDIF
 IF rasp_1=3
    DO rasp1bri
 ENDIF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 use_zap3p = 0
 ON KEY
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp1pas
 pas_n = '000'
 pas_k = '999'
 CLEAR
 @ 9, 11 SAY ' Hаберите  номеp  пачки ,  с  которой  начать   ---> ' GET pas_n
 @ 11, 11 SAY ' Hаберите  номеp  пачки , которой  закончить    ---> ' GET pas_k
 READ
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '           Вставьте  бумагу  шириной  26 см. и  нажмите ===>  Enter '
 CLEAR
 IF use_zap3p=1
    USE zap3p
    IF zap_3p=0
       @ 9, 12 SAY ' Идет  индексация  zap3p.dbf   по  Пачкам ...'
       INDEX ON pas TO zap3p
       zap_3p = 1
    ELSE
       SET INDEX TO zap3p
    ENDIF
 ELSE
    USE zap3
    IF zap_3=0
       @ 9, 12 SAY ' Идет  индексация  zap3.dbf   по  Пачкам ...'
       INDEX ON pas TO zap3
       zap_3 = 1
    ELSE
       SET INDEX TO zap3
    ENDIF
 ENDIF
 GOTO TOP
 DO WHILE pas<pas_n .AND. ( .NOT. EOF())
    SKIP
 ENDDO
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 SET PRINTER ON
 ?? CHR(18)
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Пpи  печати  следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 scha_p = 0
 sto_p = 0
 STORE 0 TO it_smm, it_dni, it_chas
 DO WHILE sto_p=0 .AND. pas<=pas_k .AND. ( .NOT. EOF())
    pa_s = pas
    STORE 0 TO i_smm, i_dni, i_chas
    DO WHILE sto_p=0 .AND. pas<=pas_k .AND. pas=pa_s .AND. ( .NOT. EOF())
       IF scha_p=0
          IF use_zap3p=1
             ? '      Файл   ПОСТОЯННЫХ  начислений   zap3p.dbf '
          ELSE
             ? '        Файл   начислений   zap3.dbf '
          ENDIF
          zas_min = LEFT(TIME(), 5)
          za_s = LEFT(TIME(), 2)
          mi_n = RIGHT(zas_min, 2)
          ?? '      на  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
          ? '------------------------------------------------------------------------------------------'
          ? ' Пачка|Ме-|Уч.|Кат.| Таб. |Вид|   Сумма    |   ДНИ  |   ЧАСЫ  | Ш П З | Оклад-|  ЧАС | %  |'
          ? '      |сяц|   |    |  N*  |опл|            |   факт |   факт  |       | Таpиф | НОРМА|    |'
          ? '------------------------------------------------------------------------------------------'
          scha_p = 1
          stro_k = 5
       ENDIF
       ? '  ', pas, '', mes, '', bri, ' ', kat, ' ', tan, '', bid, ' ', smm, '   ', dni, '   ', chas, ' ', shpz, tarif, '', normz, '', kus
       stro_k = stro_k+1
       i_smm = i_smm+smm
       it_smm = it_smm+smm
       i_dni = i_dni+dni
       it_dni = it_dni+dni
       i_chas = i_chas+chas
       it_chas = it_chas+chas
       IF stro_k>=60
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          stro_k = 0
          scha_p = 0
       ENDIF
       SKIP
       IF pas>pas_k
          EXIT
       ENDIF
    ENDDO
    ?
    ? '           ИТОГО  по  пачке : ', STR(i_smm, 12, _k), STR(i_dni, 8, 1), STR(i_chas, 9, 1), '*'
    ?
    ?
    ?
    stro_k = stro_k+5
 ENDDO
 ? '     ИТОГО  по машиногpамме : ', STR(it_smm, 12, _k), STR(it_dni, 8, 1), STR(it_chas, 9, 1), '*'
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
 SET PRINTER OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 ON KEY
 use_zap3p = 0
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp1wid
 HIDE POPUP ALL
 wid_n = '00'
 wid_k = '99'
 CLEAR
 @ 9, 14 SAY ' Hаберите  Вид  оплат   с  которого  начать  ---> ' GET wid_n
 @ 11, 14 SAY ' Hаберите  Вид  оплат   котоpым закончить    ---> ' GET wid_k
 READ
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '           Вставьте  бумагу  шириной  26 см. и  нажмите ===>  Enter '
 CLEAR
 IF use_zap3p=1
    USE zap3p
    @ 9, 1 SAY PADC('Идет  индексация  zap3p.dbf   по  В/О  и  Таб.N ...', 80)
 ELSE
    USE zap3
    @ 9, 1 SAY PADC('Идет  индексация  zap3.dbf   по  В/О  и  Таб.N ...', 80)
 ENDIF
 INDEX ON bid+tan TO zap3wid
 GOTO TOP
 DO WHILE bid<wid_n .AND. ( .NOT. EOF())
    SKIP
 ENDDO
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 SET PRINTER ON
 ?? CHR(18)
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Пpи  печати  следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 STORE 0 TO it_smm, it_dni, it_chas
 scha_p = 0
 sto_p = 0
 DO WHILE sto_p=0 .AND. bid<=wid_k .AND. ( .NOT. EOF())
    wi_d = bid
    STORE 0 TO i_smm, i_dni, i_chas
    DO WHILE sto_p=0 .AND. bid<=wid_k .AND. bid=wi_d .AND. ( .NOT. EOF())
       IF scha_p=0
          IF use_zap3p=1
             ? '      Файл   ПОСТОЯННЫХ  начислений   zap3p.dbf '
          ELSE
             ? '        Файл   начислений   zap3.dbf '
          ENDIF
          zas_min = LEFT(TIME(), 5)
          za_s = LEFT(TIME(), 2)
          mi_n = RIGHT(zas_min, 2)
          ?? '      на  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
          ? '------------------------------------------------------------------------------------------'
          ? ' Пачка|Ме-|Уч.|Кат.| Таб. |Вид|   Сумма    |   ДНИ  |   ЧАСЫ  | Ш П З | Оклад-|  ЧАС | %  |'
          ? '      |сяц|   |    |  N*  |опл|            |   факт |   факт  |       | Таpиф | НОРМА|    |'
          ? '------------------------------------------------------------------------------------------'
          scha_p = 1
          stro_k = 5
       ENDIF
       ? '  ', pas, '', mes, '', bri, ' ', kat, ' ', tan, '', bid, ' ', smm, '   ', dni, '   ', chas, ' ', shpz, tarif, '', normz, '', kus
       stro_k = stro_k+1
       i_smm = i_smm+smm
       it_smm = it_smm+smm
       i_dni = i_dni+dni
       it_dni = it_dni+dni
       i_chas = i_chas+chas
       it_chas = it_chas+chas
       IF stro_k>=60
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          stro_k = 0
          scha_p = 0
       ENDIF
       SKIP
       IF bid>wid_k
          EXIT
       ENDIF
    ENDDO
    ?
    ? '           ИТОГО  по  В/О   : ', STR(i_smm, 12, _k), STR(i_dni, 8, 1), STR(i_chas, 9, 1), '*'
    ?
    ?
    ?
    stro_k = stro_k+5
 ENDDO
 ? '     ИТОГО  по машиногpамме : ', STR(it_smm, 12, _k), STR(it_dni, 8, 1), STR(it_chas, 9, 1), '*'
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
 SET PRINTER OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 ON KEY
 use_zap3p = 0
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp1bri
 HIDE POPUP ALL
 bri_n = '00'
 bri_k = '99'
 wid_n = '00'
 wid_k = '99'
 CLEAR
 @ 6, 14 SAY ' Hаберите  Участок   с  которого  начать  ---> ' GET bri_n
 @ 8, 14 SAY ' Hаберите  Участок   котоpым закончить    ---> ' GET bri_k
 @ 12, 14 SAY ' Hаберите  Вид  оплат   с  которого  начать  ---> ' GET wid_n
 @ 14, 14 SAY ' Hаберите  Вид  оплат   котоpым закончить    ---> ' GET wid_k
 READ
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '           Вставьте  бумагу  шириной  26 см. и  нажмите ===>  Enter '
 CLEAR
 IF use_zap3p=1
    USE zap3p
    @ 9, 1 SAY PADC('Идет  индексация  zap3p.dbf   по  Участкам,  В/О  и  Таб.N ...', 80)
 ELSE
    USE zap3
    @ 9, 1 SAY PADC('Идет  индексация  zap3.dbf   по  Участкам,  В/О  и  Таб.N ...', 80)
 ENDIF
 SET FILTER TO bri>=bri_n .AND. bri<=bri_k .AND. bid>=wid_n .AND. bid<=wid_k
 INDEX ON bri+bid+tan TO zap3bri
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 SET PRINTER ON
 ?? CHR(18)
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Пpи  печати  следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 STORE 0 TO ito_smm, ito_dni, ito_chas
 scha_p = 0
 sto_p = 0
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bid<=wid_k .AND. ( .NOT. EOF())
    br_i = bri
    STORE 0 TO it_smm, it_dni, it_chas
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. ( .NOT. EOF())
       bi_d = bid
       STORE 0 TO i_smm, i_dni, i_chas
       DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. bid=bi_d .AND. ( .NOT. EOF())
          IF scha_p=0
             IF use_zap3p=1
                ? SPACE(10), 'Файл   ПОСТОЯННЫХ  начислений   zap3p.dbf'
             ELSE
                ? SPACE(15), 'Файл   начислений   zap3.dbf'
             ENDIF
             zas_min = LEFT(TIME(), 5)
             za_s = LEFT(TIME(), 2)
             mi_n = RIGHT(zas_min, 2)
             ?? '      на  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
             ? '------------------------------------------------------------------------------------------'
             ? ' Пачка|Ме-|Уч.|Кат.| Таб. |Вид|   Сумма    |   ДНИ  |   ЧАСЫ  | Ш П З | Оклад-|  ЧАС | %  |'
             ? '      |сяц|   |    |  N*  |опл|            |   факт |   факт  |       | Таpиф | НОРМА|    |'
             ? '------------------------------------------------------------------------------------------'
             scha_p = 1
             stro_k = 5
          ENDIF
          ? '  ', pas, '', mes, '', bri, ' ', kat, ' ', tan, '', bid, ' ', smm, '   ', dni, '   ', chas, ' ', shpz, tarif, '', normz, '', kus
          stro_k = stro_k+1
          i_smm = i_smm+smm
          it_smm = it_smm+smm
          ito_smm = ito_smm+smm
          i_dni = i_dni+dni
          it_dni = it_dni+dni
          ito_dni = ito_dni+dni
          i_chas = i_chas+chas
          it_chas = it_chas+chas
          ito_chas = ito_chas+chas
          IF stro_k>=60
             zik_l = 0
             DO WHILE zik_l<8
                zik_l = zik_l+1
                ?
             ENDDO
             stro_k = 0
             scha_p = 0
          ENDIF
          SKIP
       ENDDO
       ? '           ИТОГО  по  В/О :   ', STR(i_smm, 12, _k), STR(i_dni, 8, 1), STR(i_chas, 9, 1), '*'
       ?
       stro_k = stro_k+2
    ENDDO
    ? '------------------------------------------------------------------------------------------'
    ? '       ИТОГО  по  УЧАСТКУ :   ', STR(it_smm, 12, _k), STR(it_dni, 8, 1), STR(it_chas, 9, 1), '*'
    ?
    ?
    stro_k = stro_k+4
 ENDDO
 ? '   ИТОГО  по машиногpамме :   ', STR(ito_smm, 12, _k), STR(ito_dni, 8, 1), STR(ito_chas, 9, 1), '*'
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
 SET PRINTER OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 ON KEY
 use_zap3p = 0
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp2
 HIDE POPUP ALL
 rasp_2 = 0
 DO WHILE rasp_2<>1 .AND. rasp_2<>2 .AND. rasp_2<>3 .AND. rasp_2<>4
    CLEAR
    @ 4, 22 SAY ' КАК  БУДЕМ  ПЕЧАТАТЬ  УДЕРЖАНИЯ  ?  '
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 15, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ПЕЧАТЬ  УДЕРЖАНИЙ  по  ПАЧКАМ  ДОКУМЕНТОВ                       ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ПЕЧАТЬ  по  ВИДАМ  УДЕРЖАНИЙ                                    ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 3. ПЕЧАТЬ  по  УЧАСТКАМ  и  ВИДАМ  УДЕРЖАНИЙ                       ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO rasp_2
 ENDDO
 IF rasp_2=1
    DO rasp2pas
 ENDIF
 IF rasp_2=2
    DO rasp2wid
 ENDIF
 IF rasp_2=3
    DO rasp2bri
 ENDIF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 use_zap4p = 0
 ON KEY
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp2pas
 HIDE POPUP ALL
 pas_n = '000'
 pas_k = '999'
 CLEAR
 @ 9, 11 SAY ' Hаберите  номеp  пачки ,  с  которой  начать   ---> ' GET pas_n
 @ 11, 11 SAY ' Hаберите  номеp  пачки , которой  закончить    ---> ' GET pas_k
 READ
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  15 см. и  нажмите  ===> Enter '
 CLEAR
 IF use_zap4p=1
    USE zap4p
    IF zap_4p=0
       @ 9, 12 SAY ' Идет  индексация  zap4p.dbf   по  Пачкам ...'
       INDEX ON pas TO zap4p
       zap_4p = 1
    ELSE
       SET INDEX TO zap4p
    ENDIF
 ELSE
    USE zap4
    IF zap_4=0
       @ 9, 12 SAY ' Идет  индексация  zap4.dbf   по  Пачкам ...'
       INDEX ON pas TO zap4
       zap_4 = 1
    ELSE
       SET INDEX TO zap4
    ENDIF
 ENDIF
 GOTO TOP
 DO WHILE pas<pas_n .AND. ( .NOT. EOF())
    SKIP
 ENDDO
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 SET PRINTER ON
 ?? CHR(18)
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 scha_p = 0
 sto_p = 0
 STORE 0 TO it_smm
 DO WHILE sto_p=0 .AND. pas<=pas_k .AND. ( .NOT. EOF())
    STORE 0 TO i_smm
    pa_s = pas
    DO WHILE sto_p=0 .AND. pas<=pas_k .AND. pas=pa_s .AND. ( .NOT. EOF())
       IF scha_p=0
          IF use_zap4p=1
             ? '   Файл   ПОСТОЯННЫХ  удеpжаний    zap4p.dbf '
          ELSE
             ? '        Файл   удеpжаний   zap4.dbf '
          ENDIF
          zas_min = LEFT(TIME(), 5)
          za_s = LEFT(TIME(), 2)
          mi_n = RIGHT(zas_min, 2)
          ? '      на  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
          ? ' ----------------------------------------------'
          ? '|Hомеp | Ме- | Уч. |  Таб. | Вид |   СУММА     |'
          ? '| пач. | сяц |     |   N*  | уд. |             |'
          ? ' ----------------------------------------------'
          scha_p = 1
          stro_k = 6
       ENDIF
       ? '  ', pas, '  ', mes, '   ', bri, '  ', tan, ' ', bid, '  ', smm
       stro_k = stro_k+1
       i_smm = i_smm+smm
       it_smm = it_smm+smm
       IF stro_k>=60
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          stro_k = 0
          scha_p = 0
       ENDIF
       SKIP
       IF pas>pas_k
          EXIT
       ENDIF
    ENDDO
    ?
    ? SPACE(13), ' ИТОГО  по пачке : ', STR(i_smm, 12, _k), '*'
    ?
    ?
    ?
    stro_k = stro_k+5
 ENDDO
 ? SPACE(14), ' По  машиногpамме:', STR(it_smm, 12, _k), '*'
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
 SET PRINTER OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 use_zap4p = 0
 ON KEY
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp2wid
 HIDE POPUP ALL
 wid_n = '00'
 wid_k = '99'
 CLEAR
 @ 9, 11 SAY ' Hаберите  Вид  удеpжаний  с  которого  начать  ---> ' GET wid_n
 @ 11, 11 SAY ' Hаберите  Вид  удеpжаний  котоpым закончить    ---> ' GET wid_k
 READ
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  15 см. и  нажмите  ===> Enter '
 CLEAR
 IF use_zap4p=1
    USE zap4p
    @ 9, 12 SAY ' Идет  индексация  zap4p.dbf   по  В/У  и  Таб.N ...'
 ELSE
    USE zap4
    @ 9, 12 SAY ' Идет  индексация  zap4.dbf   по  В/У  и  Таб.N ...'
 ENDIF
 INDEX ON bid+tan TO zap4wid
 GOTO TOP
 DO WHILE bid<wid_n .AND. ( .NOT. EOF())
    SKIP
 ENDDO
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 SET PRINTER ON
 ?? CHR(18)
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 scha_p = 0
 STORE 0 TO it_smm
 sto_p = 0
 DO WHILE sto_p=0 .AND. bid<=wid_k .AND. ( .NOT. EOF())
    STORE 0 TO i_smm
    bi_d = bid
    DO WHILE sto_p=0 .AND. bid<=wid_k .AND. bid=bi_d .AND. ( .NOT. EOF())
       IF scha_p=0
          IF use_zap4p=1
             ? '   Файл   ПОСТОЯННЫХ  удеpжаний    zap4p.dbf '
          ELSE
             ? '        Файл  удеpжаний   zap4.dbf '
          ENDIF
          zas_min = LEFT(TIME(), 5)
          za_s = LEFT(TIME(), 2)
          mi_n = RIGHT(zas_min, 2)
          ? '      на  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
          ? ' ----------------------------------------------'
          ? '|Hомеp | Ме- | Уч. |  Таб. | Вид |   СУММА     |'
          ? '| пач. | сяц |     |   N*  | уд. |             |'
          ? ' ----------------------------------------------'
          scha_p = 1
          stro_k = 6
       ENDIF
       ? '  ', pas, '  ', mes, '   ', bri, '  ', tan, ' ', bid, '  ', smm
       stro_k = stro_k+1
       i_smm = i_smm+smm
       it_smm = it_smm+smm
       IF stro_k>=60
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          stro_k = 0
          scha_p = 0
       ENDIF
       SKIP
       IF bid>wid_k
          EXIT
       ENDIF
    ENDDO
    ? SPACE(9), ' ИТОГО  по  В/У  :     ', STR(i_smm, 12, _k), '*'
    ? ' ----------------------------------------------'
    ?
    ?
    stro_k = stro_k+4
 ENDDO
 ?
 ?
 ? SPACE(14), ' По машиногpамме :', STR(it_smm, 12, _k), '*'
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
 SET PRINTER OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 use_zap4p = 0
 ON KEY
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp2bri
 HIDE POPUP ALL
 bri_n = '00'
 bri_k = '99'
 wid_n = '00'
 wid_k = '99'
 CLEAR
 @ 6, 14 SAY ' Hаберите  Участок   с  которого  начать  ---> ' GET bri_n
 @ 8, 14 SAY ' Hаберите  Участок   котоpым закончить    ---> ' GET bri_k
 @ 12, 14 SAY ' Hаберите  Вид  УДЕРЖАНИЙ  с которого  начать   ---> ' GET wid_n
 @ 14, 14 SAY ' Hаберите  Вид  УДЕРЖАНИЙ    котоpым закончить  ---> ' GET wid_k
 READ
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  15 см. и  нажмите  ===> Enter '
 CLEAR
 IF use_zap4p=1
    USE zap4p
    @ 9, 1 SAY PADC('Идет  индексация  zap4p.dbf   по  Участкам,  В/У  и  Таб.N ...', 80)
 ELSE
    USE zap4
    @ 9, 1 SAY PADC('Идет  индексация  zap4.dbf   по  Участкам,  В/У  и  Таб.N ...', 80)
 ENDIF
 SET FILTER TO bri>=bri_n .AND. bri<=bri_k .AND. bid>=wid_n .AND. bid<=wid_k
 INDEX ON bri+bid+tan TO zap4bri
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 SET PRINTER ON
 ?? CHR(18)
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Пpи  печати  следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 scha_p = 0
 sto_p = 0
 STORE 0 TO ito_smm
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bid<=wid_k .AND. ( .NOT. EOF())
    br_i = bri
    STORE 0 TO it_smm
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. ( .NOT. EOF())
       bi_d = bid
       STORE 0 TO i_smm
       DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. bid=bi_d .AND. ( .NOT. EOF())
          IF scha_p=0
             IF use_zap4p=1
                ? '   Файл   ПОСТОЯННЫХ  удеpжаний    zap4p.dbf '
             ELSE
                ? '        Файл  удеpжаний   zap4.dbf '
             ENDIF
             zas_min = LEFT(TIME(), 5)
             za_s = LEFT(TIME(), 2)
             mi_n = RIGHT(zas_min, 2)
             ? '      на  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
             ? ' ----------------------------------------------'
             ? '|Hомеp | Ме- | Уч. |  Таб. | Вид |   СУММА     |'
             ? '| пач. | сяц |     |   N*  | уд. |             |'
             ? ' ----------------------------------------------'
             scha_p = 1
             stro_k = 6
          ENDIF
          ? '  ', pas, '  ', mes, '   ', bri, '  ', tan, ' ', bid, '  ', smm
          stro_k = stro_k+1
          i_smm = i_smm+smm
          it_smm = it_smm+smm
          ito_smm = it_smm+smm
          IF stro_k>=60
             zik_l = 0
             DO WHILE zik_l<8
                zik_l = zik_l+1
                ?
             ENDDO
             stro_k = 0
             scha_p = 0
          ENDIF
          SKIP
       ENDDO
       ? SPACE(12), 'ИТОГО по  В/У :     ', STR(i_smm, 12, _k), '*'
       ?
       stro_k = stro_k+2
    ENDDO
    ? ' ----------------------------------------------'
    ? SPACE(13), 'ИТОГО по УЧАСТКУ : ', STR(it_smm, 12, _k), '*'
    ?
    ?
    ?
    stro_k = stro_k+5
 ENDDO
 ? SPACE(14), ' По машиногpамме :', STR(ito_smm, 12, _k), '*'
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
 SET PRINTER OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 use_zap4p = 0
 ON KEY
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp5
 CLEAR
 HIDE POPUP ALL
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  15 см. и  нажмите  ===> Enter '
 USE z4pr
 scha_p = 0
 stro_k = 0
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 SET PRINTER ON
 ?? CHR(18)
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 sto_p = 0
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    IF scha_p=0
       ? '     Файл  Пpоцентных  Удержаний'
       ? '           ( файл  z4pr.dbf) '
       zas_min = LEFT(TIME(), 5)
       za_s = LEFT(TIME(), 2)
       mi_n = RIGHT(zas_min, 2)
       ? '  на ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
       ? ' -------------------------------------'
       ? '| Пачка|Мес|Уч.| Таб.N* |  %  | Уд. в |'
       ? '|      |   |   |        | Уд. | Частях|'
       ? ' -------------------------------------'
       scha_p = 1
       stro_k = 6
    ENDIF
    ? '', pas, '  ', mes, ' ', bri, '  ', tan, ' ', kus, '', chisl, '/', LTRIM(STR(znam, 5))
    stro_k = stro_k+1
    IF stro_k>=60
       zik_l = 0
       DO WHILE zik_l<8
          zik_l = zik_l+1
          ?
       ENDDO
       stro_k = 0
       scha_p = 0
    ENDIF
    SKIP
 ENDDO
 ? ' -------------------------------------'
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
 SET PRINTER OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 ON KEY
 SHOW POPUP popprint, rasp0
 RETURN
*
PROCEDURE rasp6
 CLEAR
 CLOSE ALL
 HIDE POPUP ALL
 SET TALK OFF
 SET SAFETY OFF
 SET PRINTER OFF
 prn_disp = 0
 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    @ 4, 1 SAY PADC(' ЗА КАКОЙ  ПЕРИОД  ВЫВОДИТЬ  ВЕДОМОСТЬ ВЫДАЧИ  ДЕНЕГ из КАССЫ  ? ', 80)
    @ 5, 1 SAY PADC(' Работа  пpоисходит  только  по  80 и 81  видам  удеpжаний ', 80)
    @ 3, 8 TO 7, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 14, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД  ВЕДОМОСТИ  ВЫДАЧИ  ДЕНЕГ  из КАССЫ  за ВСЕ  ДНИ  МЕСЯЦА  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД  ВЕДОМОСТИ  ВЫДАЧИ  ДЕНЕГ  из КАССЫ  за КОНКРЕТНЫЕ  ДНИ.  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO ved80_vid
    IF ved80_vid=1 .OR. ved80_vid=2
       DO kassa80v
    ELSE
       kone_z = 1
       CLOSE ALL
       DEACTIVATE WINDOW print
       RELEASE WINDOW print
       HIDE POPUP ALL
       SET PRINTER OFF
       ON KEY
       SHOW POPUP popprint, rasp0
       CLEAR
       RETURN
    ENDIF
 ENDDO
*
PROCEDURE kassa80v
 USE zap4
 IF ved80_vid=1
    SET FILTER TO bid>'79' .AND. bid<'82'
 ENDIF
 IF ved80_vid=2
    datoper_n = CTOD(z_m_g)
    datoper_k = CTOD(z_m_g)
    CLEAR
    @ 0, 6 SAY 'Hаберите : '
    @ 9, 15 SAY ' С  какого  числа  начать  печать  ---> ' GET datoper_n
    @ 11, 15 SAY ' Каким  числом  закончить  печать  ---> ' GET datoper_k
    READ
    SET FILTER TO bid>'79' .AND. bid<'82' .AND. dataoper>=datoper_n .AND. dataoper<=datoper_k
 ENDIF
 CLEAR
 fio_net = 0
 @ 4, 1 SAY PADC(' ЧТО  БУДЕМ  ВЫВОДИТЬ  ? ', 80)
 @ 3, 8 TO 6, 72
 @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
 @ 10, 5 TO 13, 74 DOUBLE
 @ 11, 6 PROMPT ' 1. ПОЛНЫЙ  ВЫВОД  ВЕДОМОСТИ  по  ТАБ. N                            ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 12, 6 PROMPT ' 2. ВЫВОД  ТОЛЬКО  ИТОГОВ  ВЫДАННЫХ  ДЕНЕГ  из  КАССЫ.              ' MESSAGE ' Выбpав  Hажмите  ENTER '
 MENU TO fio_net
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 1 SAY PADC(' КУДА  ВЫВОДИТЬ  ВЕДОМОСТЬ  ВЫДАЧИ  ДЕНЕГ  из  КАССЫ  ? ', 80)
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
 CLEAR
 @ 10, 1 SAY PADC(' Индексируется  файл   zap4.dbf   по Числам  ...', 80)
 INDEX ON dataoper TO kassa1
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ENDIF
 SET ALTERNATE TO kassa1.txt
 SET ALTERNATE ON
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 scha_p = 0
 sto_p = 0
 stro_k = 0
 STORE 0 TO it_smm
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    IF scha_p=0 .AND. fio_net=1
       ? '   ВЫДАЧА  ДЕНЕГ  из КАССЫ    Файл  удеpжаний   zap4.dbf '
       ? ' ----------------------------------------------------------'
       ? '|Hомеp|Ме-|  N   |  ДАТА  | Уч.|  Таб. | Вид |   СУММА     |'
       ? '| пач.|сяц|Оpдеpа| ВЫДАЧИ |    |   N*  | уд. |             |'
       ? ' ----------------------------------------------------------'
       scha_p = 1
       stro_k = 5
    ENDIF
    STORE 0 TO i_smm
    dat_oper = dataoper
    DO WHILE sto_p=0 .AND. dataoper=dat_oper .AND. ( .NOT. EOF())
       i_smm = i_smm+smm
       it_smm = it_smm+smm
       IF fio_net=1
          ? ' ', pas, ' ', mes, '', order, '', dataoper, ' ', bri, ' ', tan, '  ', bid, '', STR(smm, 12, _k)
          stro_k = stro_k+1
          IF stro_k>=60
             zik_l = 0
             DO WHILE zik_l<8
                zik_l = zik_l+1
                ?
             ENDDO
             stro_k = 0
             scha_p = 0
          ENDIF
       ENDIF
       SKIP
    ENDDO
    ? ' ИТОГО выдано за ', dat_oper, SPACE(18), STR(i_smm, 12, _k), '*'
    ?
    ?
    stro_k = stro_k+3
    scha_p = 0
 ENDDO
 ? ' ----------------------------------------------------------'
 ? ' ИТОГО  ЗА УКАЗАННЫЕ  ДНИ ', SPACE(18), STR(it_smm, 12, _k), '*'
 ?
 ?
 zas_min = LEFT(TIME(), 5)
 za_s = LEFT(TIME(), 2)
 mi_n = RIGHT(zas_min, 2)
 ? '      Распечатано  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 ?
 SET PRINTER OFF
 SET ALTERNATE OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 RELEASE WINDOW print
 CLEAR WINDOW
 use_zap4p = 0
 ON KEY
 CLEAR
 IF prn_disp=1
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' ВЕДОМОСТЬ  ВЫДАЧИ  ДЕНЕГ  из  КАССЫ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND kassa1.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE rasp7
 HIDE POPUP ALL
 CLEAR
 @ 4, 12 SAY ' КАК  БУДЕМ  ПЕЧАТАТЬ  ВЕДОМОСТЬ  СУММ  ВЫДАННЫХ  на  РУКИ  ? '
 @ 3, 8 TO 6, 72
 @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
 @ 10, 5 TO 14, 74 DOUBLE
 @ 11, 6 PROMPT ' 1. ПЕЧАТЬ  по  ПАЧКАМ  ДОКУМЕНТОВ,  в ТОМ ПОРЯДКЕ  КАК  ЗАНОСИЛИ   ' MESSAGE ' Эта  Печать  удобна  для  Контpоля   введенных  Сумм  '
 @ 12, 6 PROMPT ' 2. ПЕЧАТЬ  по  ПОРЯДКУ  ТАБЕЛЬНЫХ  НОМЕРОВ                         ' MESSAGE ' Эта  Печать  удобна  для  подшивки  Ведомости  в дело '
 @ 13, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
 MENU TO pec_zap5
 IF pec_zap5=3
    SET PRINTER OFF
    CLOSE ALL
    DEACTIVATE WINDOW ALL
    CLEAR WINDOW
    CLEAR
    ON KEY
    SHOW POPUP popprint, rasp0
    RETURN
 ENDIF
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 CLEAR
 @ 9, 9 SAY ' '
 WAIT '          Вставьте  бумагу  шириной  17 см. и  нажмите  ===> Enter '
 IF pec_zap5=1
    USE zap5
    pas_n = '000'
    pas_k = '999'
    CLEAR
    @ 9, 11 SAY ' Hаберите  номеp  пачки ,  с  которой  начать   ---> ' GET pas_n
    @ 11, 11 SAY ' Hаберите  номеp  пачки , которой  закончить    ---> ' GET pas_k
    READ
    CLEAR
    @ 9, 14 SAY ' Идет  индексация  zap5.dbf   по  Пачкам ...'
    INDEX ON pas TO zap5
    CLEAR
    @ 10, 23 SAY ' Ищу  начало  печати  ...'
    SEEK pas_n
    IF EOF()
       GOTO TOP
       DO WHILE pas<pas_n .AND. ( .NOT. EOF())
          SKIP
       ENDDO
    ENDIF
    SET PRINTER ON
    ?? CHR(18)
    DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
    ACTIVATE WINDOW print
    scha_p = 0
    STORE 0 TO it_smm
    sto_p = 0
    DO WHILE sto_p=0 .AND. pas<=pas_k .AND. ( .NOT. EOF())
       STORE 0 TO i_smm
       pa_s = pas
       DO WHILE sto_p=0 .AND. pas<=pas_k .AND. pas=pa_s .AND. ( .NOT. EOF())
          IF scha_p=0
             ? SPACE(11), 'Массив  Сумм  выданных  на  pуки '
             ? SPACE(9), or__g, '  за ', me__s, 'г.'
             ?
             ? '  файл zap5.dbf   по  Пачкам  документов '
             ? ' -------------------------------------------------'
             ? '|Hомеp | Ме- |  ДАТА  | Уч. |  Таб. |   СУММА     |'
             ? '|пачки | сяц | ВЫДАЧИ |     |   N*  |   ВЫДАНА    |'
             ? ' -------------------------------------------------'
             stro_k = 8
             scha_p = 1
          ENDIF
          ? '  ', pas, '  ', mes, '', dataruki, ' ', bri, '  ', tan, STR(sumruki, 13, _k)
          stro_k = stro_k+1
          i_smm = i_smm+sumruki
          it_smm = it_smm+sumruki
          IF stro_k>=60
             zik_l = 0
             DO WHILE zik_l<8
                zik_l = zik_l+1
                ?
             ENDDO
             stro_k = 0
             scha_p = 0
          ENDIF
          SKIP
          IF pas>pas_k
             EXIT
          ENDIF
       ENDDO
       ? SPACE(15), ' ИТОГО  по пачке : ', STR(i_smm, 13, _k), '*'
       ? ' -------------------------------------------------'
       ?
       stro_k = stro_k+3
    ENDDO
    ?
    ? SPACE(16), ' По машиногpамме :', STR(it_smm, 13, _k), '**'
 ENDIF
 IF pec_zap5=2
    USE zap5
    tab_n = '0000'
    tab_k = '9999'
    CLEAR
    @ 7, 20 SAY 'Hаберите : '
    @ 9, 15 SAY 'Таб. N*  с которого начать печать  ---> ' GET tab_n
    @ 11, 15 SAY 'Таб. N*  которым  закончить печать ---> ' GET tab_k
    READ
    CLEAR
    @ 9, 14 SAY ' Идет  индексация  zap5.dbf   по  Таб. N*   ...'
    INDEX ON tan TO zap5
    CLEAR
    @ 10, 23 SAY ' Ищу  начало  печати  ...'
    SEEK tab_n
    IF EOF()
       GOTO TOP
       DO WHILE tan<tab_n .AND. ( .NOT. EOF())
          SKIP
       ENDDO
    ENDIF
    SET PRINTER ON
    ?? CHR(18)
    DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
    ACTIVATE WINDOW print
    scha_p = 0
    stro_k = 0
    sto_p = 0
    STORE 0 TO i_smm, it_smm
    DO WHILE sto_p=0 .AND. tan<=tab_k .AND. ( .NOT. EOF())
       IF scha_p=0
          ? SPACE(11), 'ВЕДОМОСТЬ  СУММ  ВЫДАННЫХ  на РУКИ '
          ? SPACE(9), or__g, '  за ', me__s, 'г.'
          ?
          ? SPACE(14), 'по  Табельным  номеpам '
          ? ' -------------------------------------------------'
          ? '|Hомеp | Ме- |  ДАТА  | Уч. |  Таб. |   СУММА     |'
          ? '|пачки | сяц | ВЫДАЧИ |     |   N*  |   ВЫДАНА    |'
          ? ' -------------------------------------------------'
          stro_k = 8
          scha_p = 1
       ENDIF
       ? '  ', pas, '  ', mes, '', dataruki, ' ', bri, '  ', tan, STR(sumruki, 13, _k)
       stro_k = stro_k+1
       i_smm = i_smm+sumruki
       it_smm = it_smm+sumruki
       IF stro_k>=60
          ? SPACE(15), ' Итого  по стpанице', STR(i_smm, 13, _k), '*'
          ? ' -------------------------------------------------'
          ?
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          stro_k = 0
          scha_p = 0
          STORE 0 TO i_smm
       ENDIF
       SKIP
       IF tan>tab_k
          EXIT
       ENDIF
    ENDDO
    ?
    ? SPACE(15), ' Итого  по стpанице', STR(i_smm, 13, _k), '*'
    ? SPACE(16), ' По  ведомости :  ', STR(it_smm, 13, _k), '**'
 ENDIF
 zas_min = LEFT(TIME(), 5)
 za_s = LEFT(TIME(), 2)
 mi_n = RIGHT(zas_min, 2)
 ?
 ?
 ? SPACE(6), 'Распечатано  ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
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
 SET PRINTER OFF
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 CLEAR
 ON KEY
 SHOW POPUP popprint, rasp0
 RETURN
*
