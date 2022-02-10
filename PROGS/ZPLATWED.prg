 DO zdattime
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
    @ 4, 12 SAY ' КАК  БУДЕМ  ВЫВОДИТЬ  РАСЧЕТНО - ПЛАТЕЖНУЮ  ВЕДОМОСТЬ  ? '
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 14, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД   РАСЧЕТНО - ПЛАТЕЖНОЙ  ВЕДОМОСТИ  по  ПРЕДПРИЯТИЮ        ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД   РАСЧЕТНО - ПЛАТЕЖНОЙ  ВЕДОМОСТИ  по  УЧАСТКАМ           ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO zzob6_for
    IF zzob6_for=1
       IF zzob6_pr=0
          DO zzob6
       ENDIF
       IF form8_pr=0
          DO zform8
          form8_pr = 1
       ENDIF
       DO platpred
    ENDIF
    IF zzob6_for=2
       IF zzob6_bri=0
          DO zzob6
       ENDIF
       IF form8_bri=0
          DO zform8
          form8_bri = 1
       ENDIF
       DO platbri
    ENDIF
    IF zzob6_for=3
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
PROCEDURE platpred
 DO prindisp
 SELECT 1
 USE zap8
 SET INDEX TO zap8pr
 CLEAR
 tab_n = '0000'
 tab_k = '9999'
 @ 0, 6 SAY 'Hаберите : '
 @ 9, 15 SAY 'Таб. N*  с которого начать печать  ---> ' GET tab_n
 @ 11, 15 SAY 'Таб. N*  которым  закончить печать ---> ' GET tab_k
 READ
 CLEAR
 @ 10, 23 SAY ' Ищу  начало  печати  ...'
 SEEK tab_n
 IF EOF()
    GOTO TOP
    DO WHILE tan<tab_n .AND. ( .NOT. EOF())
       SKIP
    ENDDO
 ENDIF
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ENDIF
 SET ALTERNATE TO plwedpr.txt
 SET ALTERNATE ON
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 CLEAR
 ?
 ? SPACE(20), ' РАСЧЕТHО  -  ПЛАТЕЖHАЯ  ВЕДОМОСТЬ  по  ЗАРПЛАТЕ '
 ?
 ? SPACE(9), or__g, SPACE(9), ' за  ', me__s, 'г.'
 stro_k = 4
 scha_p = 0
 STORE 0 TO i_1, i_2, i_3, i_4
 STORE 0 TO it_1, it_2, it_3, it_4
 sto_p = 0
 DO WHILE sto_p=0 .AND. tan<=tab_k .AND. ( .NOT. EOF())
    IF scha_p=0
       DO sapka
    ENDIF
    ? '', fio, '', bri, '  ', tan, '', STR(smn, 12, 2), '', STR(smu, 12, 2), '', STR(smr, 12, 2), '', STR(smd, 12, 2)
    ?
    stro_k = stro_k+2
    i_1 = i_1+smn
    it_1 = it_1+smn
    i_2 = i_2+smu
    it_2 = it_2+smu
    i_3 = i_3+smr
    it_3 = it_3+smr
    i_4 = i_4+smd
    it_4 = it_4+smd
    IF stro_k>=60
       ? '       Итого  по  странице  :         ', STR(i_1, 13, 2), STR(i_2, 13, 2), STR(i_3, 13, 2), STR(i_4, 13, 2), '*'
       zik_l = 0
       DO WHILE zik_l<8
          zik_l = zik_l+1
          ?
       ENDDO
       scha_p = 0
       stro_k = 0
       STORE 0 TO i_1, i_2, i_3, i_4
    ENDIF
    SKIP
 ENDDO
 ?
 ? '       Итого  по  странице  :         ', STR(i_1, 13, 2), STR(i_2, 13, 2), STR(i_3, 13, 2), STR(i_4, 13, 2), '*'
 ?
 ?
 ? '       Итого  по  машиногpамме :      ', STR(it_1, 13, 2), STR(it_2, 13, 2), STR(it_3, 13, 2), STR(it_4, 13, 2), '**'
 ?
 ?
 ?
 ? '                                      Руководитель _________________________'
 ?
 ?
 ? '                                      Главный бухгалтер ____________________'
 stro_k = stro_k+12
 DO WHILE stro_k<=60
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DEACTIVATE WINDOW print
 RELEASE WINDOW print
 HIDE POPUP ALL
 SET ALTERNATE OFF
 SET PRINTER OFF
 ON KEY
 CLEAR
 IF prn_disp=1
    CLEAR
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' РАСЧЕТНО - ПЛАТЕЖНАЯ  ВЕДОМОСТЬ  по  ПРЕДПРИЯТИЮ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND plwedpr.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    DELETE FILE plwedpr.txt
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE platbri
 DO prindisp
 CLEAR
 DO zwbritan
 SELECT 1
 USE zap8
 SET INDEX TO zap8bri
 CLEAR
 @ 9, 18 SAY ' Бегу  искать  начало  печати  ... '
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
    @ 9, 18 SAY ' Hет  такого   УЧАСТКА  и  Таб. N  '
    @ 8, 10 FILL TO 9, 70 COLOR GR+/RB 
    ?
    ?
    WAIT '             ДЛЯ  продолжения  нажмите   ---> Enter '
 ENDIF
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ENDIF
 SET ALTERNATE TO plwedbri.txt
 SET ALTERNATE ON
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 a_a = 0
 stro_k = 0
 sto_p = 0
 STORE 0 TO ito_1, ito_2, ito_3, ito_4
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. tan<=tab_k .AND. ( .NOT. EOF())
    scha_p = 0
    ?
    ? SPACE(20), ' РАСЧЕТHО  -  ПЛАТЕЖHАЯ  ВЕДОМОСТЬ  по  ЗАРПЛАТЕ '
    ?
    ? SPACE(9), or__g, SPACE(9), ' за  ', me__s, 'г.'
    stro_k = 4
    br_i = bri
    STORE 0 TO i_1, i_2, i_3, i_4
    STORE 0 TO it_1, it_2, it_3, it_4
    DO WHILE sto_p=0 .AND. bri<=bri_k .AND. bri=br_i .AND. tan<=tab_k .AND. ( .NOT. EOF())
       IF scha_p=0
          ?
          ? SPACE(9), ' УЧАСТОК -', br_i
          stro_k = stro_k+2
          DO sapka
       ENDIF
       ? '', fio, '', bri, '  ', tan, '', STR(smn, 12, 2), '', STR(smu, 12, 2), '', STR(smr, 12, 2), '', STR(smd, 12, 2)
       ?
       stro_k = stro_k+2
       i_1 = i_1+smn
       it_1 = it_1+smn
       ito_1 = ito_1+smn
       i_2 = i_2+smu
       it_2 = it_2+smu
       ito_2 = ito_2+smu
       i_3 = i_3+smr
       it_3 = it_3+smr
       ito_3 = ito_3+smr
       i_4 = i_4+smd
       it_4 = it_4+smd
       ito_4 = ito_4+smd
       IF stro_k>=60
          ? '       Итого  по  странице  :         ', STR(i_1, 13, 2), STR(i_2, 13, 2), STR(i_3, 13, 2), STR(i_4, 13, 2), '*'
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          scha_p = 0
          stro_k = 0
          STORE 0 TO i_1, i_2, i_3, i_4
       ENDIF
       SKIP
    ENDDO
    ?
    ? '       Итого  по  странице  :         ', STR(i_1, 13, 2), STR(i_2, 13, 2), STR(i_3, 13, 2), STR(i_4, 13, 2), '*'
    ?
    ?
    ? '       Итого  по  Участку   :         ', STR(it_1, 13, 2), STR(it_2, 13, 2), STR(it_3, 13, 2), STR(it_4, 13, 2), '**'
    ?
    ?
    ?
    ? '                                      Руководитель _________________________'
    ?
    ?
    ? '                                      Главный бухгалтер ____________________'
    stro_k = stro_k+12
    IF sto_p=0 .AND. bri<=bri_k .AND. tan<=tab_k .AND. ( .NOT. EOF())
       DO WHILE stro_k<=60
          stro_k = stro_k+1
          ?
       ENDDO
    ENDIF
    IF stro_k>=60 .AND. ( .NOT. EOF())
       zik_l = 0
       DO WHILE zik_l<9
          zik_l = zik_l+1
          ?
       ENDDO
    ENDIF
 ENDDO
 ?
 ?
 ?
 ?
 ? '       Итого  по  машиногpамме        ', STR(ito_1, 13, 2), STR(ito_2, 13, 2), STR(ito_3, 13, 2), STR(ito_4, 13, 2), '***'
 ?
 stro_k = stro_k+6
 DO WHILE stro_k<=60
    stro_k = stro_k+1
    ?
 ENDDO
 CLOSE ALL
 DEACTIVATE WINDOW print
 RELEASE WINDOW print
 HIDE POPUP ALL
 SET ALTERNATE OFF
 SET PRINTER OFF
 ON KEY
 CLEAR
 IF prn_disp=1
    CLEAR
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' РАСЧЕТНО - ПЛАТЕЖНАЯ  ВЕДОМОСТЬ  по  УЧАСТКАМ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND plwedbri.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    DELETE FILE plwedbri.txt
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE sapka
 ?
 ? '----------------------------------------------------------------------------------------------'
 ? '      Ф.    И.    О.      |УЧАС|  ТАБ.|  HАЧИСЛЕНО  |  УДЕРЖАНО   |   СУММА     |  ДОЛГ  ЗА   |'
 ? '                          |ТОК |   N* |             |             |  к  ВЫДАЧЕ  | РАБОТНИКОМ  |'
 ? '----------------------------------------------------------------------------------------------'
 ? '           А              |  Б |  В   |      1      |      2      |       3     |      4      |'
 ? '----------------------------------------------------------------------------------------------'
 ?
 stro_k = stro_k+8
 scha_p = 1
 RETURN
*
PROCEDURE prindisp
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 12 SAY ' КУДА БУДЕМ  ВЫВОДИТЬ  РАСЧЕТНО - ПЛАТЕЖНУЮ  ВЕДОМОСТЬ  ? '
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
    WAIT '        Вставьте  бумагу  шириной  27 см.  и  нажмите  Enter ===> '
 ENDIF
 RETURN
*
