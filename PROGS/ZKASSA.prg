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
    @ 4, 12 SAY ' КАК  БУДЕМ  ВЫВОДИТЬ  ПЛАТЕЖНУЮ ВЕДОМОСТЬ  для  КАССЫ  ?  '
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 14, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД   ПЛАТЕЖНОЙ  ВЕДОМОСТИ  для  КАССЫ  по  ПРЕДПРИЯТИЮ       ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД   ПЛАТЕЖНОЙ  ВЕДОМОСТИ  для  КАССЫ  по  УЧАСТКАМ          ' MESSAGE ' Выбpав  Hажмите  ENTER '
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
       DO kasspred
    ENDIF
    IF zzob6_for=2
       IF zzob6_bri=0
          DO zzob6
       ENDIF
       IF form8_bri=0
          DO zform8
          form8_bri = 1
       ENDIF
       DO kassbri
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
PROCEDURE kasspred
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
 SET ALTERNATE TO kassapr.txt
 SET ALTERNATE ON
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 stro_k = 0
 scha_p = 0
 DO golowa
 sto_p = 0
 STORE 0 TO i_smr1, it_smr1
 DO WHILE sto_p=0 .AND. tan<=tab_k .AND. ( .NOT. EOF())
    IF scha_p=0
       DO sapka
    ENDIF
    IF pas='999' .AND. INT(smsb)=0
       na_ruki = smr1+smsb
    ELSE
       na_ruki = smr1
    ENDIF
    ? '', fio, '  ', bri, ' ', tan, STR(na_ruki, 11, 2), '  ______________'
    ?
    stro_k = stro_k+2
    i_smr1 = i_smr1+na_ruki
    it_smr1 = it_smr1+na_ruki
    IF stro_k>=60
       ? '           Итого  по  странице  :     ', STR(i_smr1, 12, 2), '*'
       zik_l = 0
       DO WHILE zik_l<8
          zik_l = zik_l+1
          ?
       ENDDO
       scha_p = 0
       stro_k = 0
       STORE 0 TO i_smr1
    ENDIF
    SKIP
 ENDDO
 ?
 ? '           Итого  по  странице  :     ', STR(i_smr1, 12, 2), '*'
 ?
 ?
 ? '           Итого  по  машиногpамме :  ', STR(it_smr1, 12, 2), '**'
 ?
 ?
 ?
 ? '         Руководитель _________________    _________________'
 ?
 ?
 ? '         Гл. бухгалтер _________________    _________________'
 ?
 ?
 ?
 stro_k = stro_k+10
 DO WHILE stro_k<=60
    stro_k = stro_k+1
    ?
 ENDDO
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
 IF prn_disp=1
    CLEAR
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' ПЛАТЕЖНАЯ  ВЕДОМОСТЬ  для  КАССЫ  по  ПРЕДПРИЯТИЮ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND kassapr.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE kassbri
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
 SET ALTERNATE TO kassabri.txt
 SET ALTERNATE ON
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 sto_p = 0
 stro_k = 0
 STORE 0 TO ito_smr1
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. tan<=tab_k .AND. ( .NOT. EOF())
    br_i = bri
    scha_p = 0
    stro_k = 0
    DO golowa
    STORE 0 TO i_smr1, it_smr1
    DO WHILE sto_p=0 .AND. bri=br_i .AND. tan<=tab_k .AND. ( .NOT. EOF())
       IF scha_p=0
          ? '           ', br_i, ' УЧАСТОК'
          stro_k = stro_k+1
          DO sapka
       ENDIF
       IF pas='999' .AND. INT(smsb)=0
          na_ruki = smr1+smsb
       ELSE
          na_ruki = smr1
       ENDIF
       ? '', fio, ' ', bri, ' ', tan, '', STR(na_ruki, 11, 2), ' ______________'
       ?
       stro_k = stro_k+2
       i_smr1 = i_smr1+na_ruki
       it_smr1 = it_smr1+na_ruki
       ito_smr1 = ito_smr1+na_ruki
       IF stro_k>=60
          ? '           Итого  по  странице  :     ', STR(i_smr1, 12, 2), '*'
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          scha_p = 0
          stro_k = 0
          STORE 0 TO i_smr1
       ENDIF
       SKIP
    ENDDO
    ? '           Итого  по  странице  :     ', STR(i_smr1, 12, 2), '*'
    ?
    ?
    ? '            Итого  по  Участку  :     ', STR(it_smr1, 12, 2), '**'
    ?
    ?
    ?
    ? '         Руководитель  _________________    _________________'
    ?
    ?
    ? '         Гл. бухгалтер _________________    _________________'
    ?
    ?
    stro_k = stro_k+13
    DO WHILE stro_k<=60
       stro_k = stro_k+1
       ?
    ENDDO
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
 ? '         Итого   по  машиногpамме :   ', STR(ito_smr1, 12, 2), '***'
 stro_k = stro_k+3
 DO WHILE stro_k<=60
    stro_k = stro_k+1
    ?
 ENDDO
 ?
 CLOSE ALL
 DEACTIVATE WINDOW print
 RELEASE WINDOW print
 HIDE POPUP ALL
 SET PRINTER OFF
 ON KEY
 CLEAR
 IF prn_disp=1
    CLEAR
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' ПЛАТЕЖНАЯ  ВЕДОМОСТЬ  для  КАССЫ  по  УЧАСТКАМ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND kassabri.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE golowa
 ?
 ? '  В кассу  для оплаты  в срок'
 ?
 ? '  с "____"_______________ по "____"______________ 199 ___ г.'
 ?
 ? '  в сумме'
 ?
 ?
 ? '         Руководитель _________________    _________________'
 ?
 ?
 ? '         Гл.бухгалтер _________________    _________________'
 ?
 ?
 ?
 ? '      П Л А Т Е Ж H А Я      В Е Д О М О С Т Ь     N* ______'
 ?
 ? '            на выдачу _______________________'
 ?
 ? '           ', or__g, '               за  ', me__s, ' г.'
 ?
 ?
 ? '  Расходный кассовый ордер N*____ от ______________ 199 ___ г.'
 ?
 ?
 stro_k = stro_k+25
*
PROCEDURE sapka
 ?
 ? '===================================================================='
 ? '      Ф.    И.    О.      |Учас-|  Таб.|   СУММА   |   РОСПИСЬ      |'
 ? '                          |ток  |  ном.|           |                |'
 ? '===================================================================='
 ?
 stro_k = stro_k+6
 scha_p = 1
 RETURN
*
PROCEDURE prindisp
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 12 SAY ' КУДА БУДЕМ  ВЫВОДИТЬ  ПЛАТЕЖНУЮ ВЕДОМОСТЬ  для  КАССЫ  ? '
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
    WAIT '        Вставьте  бумагу  шириной  20 см.  и  нажмите  Enter ===> '
 ENDIF
 RETURN
*
PROCEDURE wed0
 CLEAR
 @ 5, 5 SAY ' '
 TEXT

                  Данная  Ведомость - Заготовка  без  сумм

          может  использоваться  для  выдачи  и  Зарплаты  и  Аванса

                   Делайте  ее  по  запросу  заказчика  !!!


              Рекламируйте  свои  возможности   нашим  клиентам !
          При  выдаче  зарплаты  несколькими  частями  данная  заготовка
            может  иметь  спрос  у  многих  заказчиков !!!

 ENDTEXT
 WAIT TO wwo_d '              Для  продолжения  нажмите  ВВОД  ===> '
 mes_mes = ' _______________ '
 CLEAR
 @ 9, 9 SAY ' '
 WAIT TO wwo_d '     Вставьте  бумагу  шириной  20  см.  и  нажмите  ВВОД ---> '
 CLEAR
 @ 5, 5 SAY ' '
 TEXT


         Кассовая  ведомость  по  ПРЕДПРИЯТИЮ                 --->  1

         Кассовая  ведомость  по  БРИГАДАМ (УЧАСТ.,ШКОЛАМ)    --->  2

 ENDTEXT
 WAIT TO u_u '                   Ваш  выбор ===> '
 IF u_u='1'
    CLEAR
    tan_1 = '0000'
    tan_2 = '9999'
    @ 6, 6 SAY 'Hаберите  Таб. N , с  которого  начать  печатать --->' GET tan_1
    @ 8, 6 SAY 'Hаберите  Таб. N , которым  закончить печатать --->' GET tan_2
    READ
    CLEAR
    USE zap1
    @ 8, 10 SAY '  Идет  индексация  файла  zap1.dbf  по  Таб. N ...'
    INDEX ON tan TO zap1
    GOTO TOP
    CLEAR
    @ 8, 10 SAY '  Ищу  начало  печати  ...'
    SEEK tan_1
    IF EOF()
       GOTO TOP
       DO WHILE tan<tan_1 .AND. ( .NOT. EOF())
          SKIP
       ENDDO
    ENDIF
    SET PRINTER ON
    ? '                                УТВЕРЖДАЮ:  Руководитель_______________'
    ?
    ? '                                            Гл.бухгалтер_______________'
    ?
    ? '                                 Расходный  ордер  N_____от ___________'
    ?
    ?
    ? '                 К А С С О В А Я     В Е Д О М О С Т Ь '
    ?
    ? '           ', or__g, '                       за ', mes_mes
    ?
    stro_k = 11
    scha_p = 0
    DO WHILE tan<=tan_2 .AND. ( .NOT. EOF())
       IF scha_p=0
          ? ' ======================================================================'
          ? '|   Таб. |       Ф.   И.   О.         |     СУММА   |    РОСПИСЬ '
          ? '|   ном. |                            |             |'
          ? ' ======================================================================'
          ?
          stro_k = stro_k+5
          scha_p = 1
       ENDIF
       ? '   ', tan, '  ', fio, '  ____________    _______________'
       ?
       stro_k = stro_k+2
       IF stro_k>=60 .OR. EOF()
          ? '        Итого  по  странице  :         ______________* '
          stro_k = stro_k+1
       ENDIF
       IF stro_k>=60
          zik_l = 0
          DO WHILE zik_l<8
             ?
             zik_l = zik_l+1
          ENDDO
          stro_k = 0
          scha_p = 0
       ENDIF
       SKIP
    ENDDO
    ?
    ?
    ? '       Итого  по  предприятию :        ______________** '
    ?
    ?
    ? '                    Бухгалтер        _____________________'
    ?
    ?
    ? '                    Кассир            ____________________'
    ?
    ?
    ?
    ?
    ?
    stro_k = stro_k+14
    DO WHILE stro_k<=60
       ?
       stro_k = stro_k+1
    ENDDO
    CLOSE ALL
    SET PRINTER OFF
 ENDIF
 IF u_u='2'
    CLEAR
    bri_1 = '00'
    bri_2 = '99'
    tan_1 = '0000'
    tan_2 = '9999'
    @ 6, 6 SAY 'Hаберите  N  участка (бригады)  с  которого  начать ---> ' GET bri_1
    @ 8, 6 SAY 'Hаберите  N  Участка  Которым  закончить  печать ---> ' GET bri_2
    @ 10, 6 SAY 'Hаберите  Таб. N  с  которого  начать  печать ---> ' GET tan_1
    @ 12, 6 SAY 'Hаберите  Таб. N  которым  закончить  печать --->' GET tan_2
    READ
    CLEAR
    USE zap1
    @ 8, 10 SAY ' Индексируется  zap1.dbf  по  Бригаде  +  Таб. N  ...'
    INDEX ON bri+tan TO zap1
    GOTO TOP
    CLEAR
    @ 8, 10 SAY '  Ищу  начало  печати  ...'
    pois_k = bri_1+tan_1
    SEEK pois_k
    IF EOF()
       GOTO TOP
       DO WHILE bri<bri_1 .AND. ( .NOT. EOF())
          SKIP
       ENDDO
       DO WHILE tan<tan_1 .AND. ( .NOT. EOF())
          SKIP
       ENDDO
    ENDIF
    SET PRINTER ON
    DO WHILE bri<=bri_2 .AND. tan<=tan_2 .AND. ( .NOT. EOF())
       bri_a = bri
       ? '                                УТВЕРЖДАЮ:  Руководитель_______________'
       ?
       ? '                                            Гл.бухгалтер_______________'
       ?
       ? '                                 Расходный  ордер  N_____от ___________'
       ?
       ?
       ? '            К А С С О В А Я       В Е Д О М О С Т Ь '
       ?
       ? '           ', or__g, '                   за ', mes_mes
       ? '           ', bri_a, ' УЧАСТОК'
       ?
       stro_k = 13
       STORE 0 TO scha_p
       DO WHILE bri=bri_a .AND. bri<=bri_2 .AND. tan<=tan_2 .AND. ( .NOT. EOF())
          IF scha_p=0
             ? '========================================================================'
             ? ' Бр. | Таб. |        Ф.  И.  О.         |    СУММА    |   РОСПИСЬ '
             ? '(Уч.)| ном. |                           |             |'
             ? '========================================================================'
             ?
             stro_k = stro_k+5
             scha_p = 1
          ENDIF
          ? ' ', bri, ' ', tan, ' ', fio, ' ____________    _______________'
          ?
          stro_k = stro_k+2
          IF stro_k>=60
             zik_l = 0
             DO WHILE zik_l<8
                ?
                zik_l = zik_l+1
             ENDDO
             stro_k = 0
             scha_p = 0
          ENDIF
          SKIP
       ENDDO
       ?
       ?
       ? '          Итого  по  участку  :        _______________* '
       ?
       ?
       ?
       ? '              Бухгалтер        _____________________'
       ?
       ?
       ? '              Кассир            ____________________'
       IF stro_k<60
          DO WHILE stro_k<60
             stro_k = stro_k+1
             ?
          ENDDO
          stro_k = 0
          scha_p = 0
       ENDIF
    ENDDO
    ?
    ?
    ? '        Итого  по  предприятию :        _______________** '
    ?
    CLOSE ALL
    SET PRINTER OFF
 ENDIF
 CLOSE ALL
 RETURN
*
