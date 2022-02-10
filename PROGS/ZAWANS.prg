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
    @ 3, 1 SAY PADC(' Ведомость  на Аванс  печатается  из файла  удеpжаний,', 80)
    @ 4, 1 SAY PADC(' выбиpается  только  80 шифp,  кому  занесен  аванс.', 80)
    @ 7, 1 SAY PADC('КАК  БУДЕМ  ВЫВОДИТЬ  ПЛАТЕЖНУЮ ВЕДОМОСТЬ  на  АВАНС  ?', 80)
    @ 6, 8 TO 8, 72
    @ 10, 5 TO 14, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД   ПЛАТЕЖНОЙ  ВЕДОМОСТИ  на  АВАНС   по  ПРЕДПРИЯТИЮ       ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД   ПЛАТЕЖНОЙ  ВЕДОМОСТИ  на  АВАНС   по  УЧАСТКАМ          ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO awan_s
    IF awan_s=1
       DO awanpred
    ENDIF
    IF awan_s=2
       DO awansbri
    ENDIF
    IF awan_s=3
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
PROCEDURE awanpred
 CLEAR
 @ 4, 1 SAY PADC('На печать включаются  только  те записи', 80)
 @ 5, 1 SAY PADC('которые находятся  в диаппазоне указанных Дат', 80)
 @ 4, 15 FILL TO 5, 65 COLOR GR+/RB 
 dat_oper1 = {}
 dat_oper2 = {12/31/1998}
 @ 8, 10 SAY '             H а б е р и т е : '
 @ 10, 10 SAY 'С какой Даты  выдачи  начать выборку   ---> ' GET dat_oper1
 @ 12, 10 SAY 'Какой  Датой  выдачи  закончить        ---> ' GET dat_oper2
 tab_n = '0000'
 tab_k = '9999'
 @ 15, 15 SAY 'Таб. N*  с которого начать печать  ---> ' GET tab_n
 @ 17, 15 SAY 'Таб. N*  которым  закончить печать ---> ' GET tab_k
 READ
 DO prindisp
 SELECT 2
 USE zap1 ALIAS z1
 INDEX ON tan TO zap1
 SELECT 1
 USE zap4
 SET FILTER TO bid='80' .AND. dataoper>=dat_oper1 .AND. dataoper<=dat_oper2
 INDEX ON tan TO awanpred
 SET RELATION TO tan INTO z1
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
 SET ALTERNATE TO awanspr.txt
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
 STORE 0 TO it_1, ito_1
 DO WHILE sto_p=0 .AND. tan<=tab_k .AND. ( .NOT. EOF())
    IF scha_p=0
       DO sapka
    ENDIF
    fi_o = z1.fio
    br_i = bri
    ta_n = tan
    STORE 0 TO i_1
    DO WHILE sto_p=0 .AND. tan=ta_n .AND. tan<=tab_k .AND. ( .NOT. EOF())
       i_1 = i_1+smm
       it_1 = it_1+smm
       ito_1 = ito_1+smm
       SKIP
    ENDDO
    ? '', fi_o, '  ', br_i, ' ', ta_n, STR(i_1, 11, 2), '  ______________'
    ?
    stro_k = stro_k+2
    IF stro_k>=60
       ? '           Итого  по  странице  :     ', STR(it_1, 12, 2), '*'
       zik_l = 0
       DO WHILE zik_l<8
          zik_l = zik_l+1
          ?
       ENDDO
       scha_p = 0
       stro_k = 0
       STORE 0 TO it_1
    ENDIF
 ENDDO
 ?
 ? '           Итого  по  странице  :     ', STR(it_1, 12, 2), '*'
 ?
 ?
 ? '           Итого  по  машиногpамме :  ', STR(ito_1, 12, 2), '**'
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
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' ПЛАТЕЖНАЯ  ВЕДОМОСТЬ  на АВАНС  по  ПРЕДПРИЯТИЮ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND awanspr.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    DELETE FILE awanspr.txt
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE awansbri
 CLEAR
 DO zwbritan
 CLEAR
 @ 4, 1 SAY PADC('На печать включаются  только  те записи', 80)
 @ 5, 1 SAY PADC('которые находятся  в диаппазоне указанных Дат', 80)
 @ 4, 15 FILL TO 5, 65 COLOR GR+/RB 
 dat_oper1 = {}
 dat_oper2 = {12/31/1998}
 @ 8, 10 SAY '             H а б е р и т е : '
 @ 10, 10 SAY 'С какой Даты  выдачи  начать выборку   ---> ' GET dat_oper1
 @ 12, 10 SAY 'Какой  Датой  выдачи  закончить        ---> ' GET dat_oper2
 READ
 DO prindisp
 SELECT 2
 USE zap1 ALIAS z1
 INDEX ON tan TO zap1
 SELECT 1
 USE zap4
 SET FILTER TO bid='80' .AND. dataoper>=dat_oper1 .AND. dataoper<=dat_oper2
 INDEX ON bri+tan TO awansbri
 SET RELATION TO tan INTO z1
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
 SET ALTERNATE TO awansbri.txt
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
 STORE 0 TO it_1, itog_1
 DO WHILE sto_p=0 .AND. bri<=bri_k .AND. tan<=tab_k .AND. ( .NOT. EOF())
    br_i = bri
    scha_p = 0
    stro_k = 0
    DO golowa
    STORE 0 TO ito_1
    DO WHILE sto_p=0 .AND. bri=br_i .AND. tan<=tab_k .AND. ( .NOT. EOF())
       IF scha_p=0
          ? '           ', br_i, ' УЧАСТОК'
          stro_k = stro_k+1
          DO sapka
       ENDIF
       fi_o = z1.fio
       ta_n = tan
       STORE 0 TO i_1
       DO WHILE sto_p=0 .AND. bri<=bri_k .AND. tan<=tab_k .AND. tan=ta_n .AND. ( .NOT. EOF())
          i_1 = i_1+smm
          it_1 = it_1+smm
          ito_1 = ito_1+smm
          itog_1 = itog_1+smm
          SKIP
       ENDDO
       ? '', fi_o, '  ', br_i, ' ', ta_n, STR(i_1, 11, 2), '  ______________'
       ?
       stro_k = stro_k+2
       IF stro_k>=60
          ? '           Итого  по  странице  :     ', STR(it_1, 12, 2), '*'
          zik_l = 0
          DO WHILE zik_l<8
             zik_l = zik_l+1
             ?
          ENDDO
          scha_p = 0
          stro_k = 0
          STORE 0 TO i_1
       ENDIF
    ENDDO
    ? '           Итого  по  странице  :     ', STR(it_1, 12, 2), '*'
    ?
    ?
    ? '            Итого  по  Участку  :     ', STR(ito_1, 12, 2), '**'
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
 ? '         Итого   по  машиногpамме :   ', STR(itog_1, 12, 2), '***'
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
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' ПЛАТЕЖНАЯ  ВЕДОМОСТЬ  на АВАНС  по  УЧАСТКАМ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND awansbri.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
    DELETE FILE awansbri.txt
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
 ? '            на выдачу  аванса  _______________________'
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
    @ 4, 12 SAY ' КУДА БУДЕМ  ВЫВОДИТЬ  ПЛАТЕЖНУЮ ВЕДОМОСТЬ  на  АВАНС ? '
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
