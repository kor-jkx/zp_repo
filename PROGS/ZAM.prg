*** 
*** ReFox XI+  #KN824044  sasasa  sasasa [FP25]
***
 SET PRINTER OFF
 CLEAR ALL
 CLEAR
 CLOSE ALL
 CLEAR MACROS
 SET TALK OFF
 ver_s = ' 9.02.98г.'
 ON KEY
 RELEASE POPUP ALL
 SET LIBRARY TO Events25
 time_keep = 5
 = setidle(354,time_keep*60)
 PUBLIC k_org, or__g, m_e, da_t, da_tt, z_m_g, me__s, mes_t, za_s, mi_n
 PUBLIC wib_mes, katalo_g, star_kat, fail_zip, star_zip
 PUBLIC me_s1, me_s2, me_s3, go_d1, go_d2, go_d3, mese_z1, mese_z2, mese_z3
 PUBLIC bri_n, bri_k, tab_n, tab_k, raszet_ne
 PUBLIC mini_m, min_sr, stavka_1
 PUBLIC stavka_21, stavka_22, stavka_31, stavka_32, stavka_41, stavka_42, stavka_51, stavka_52, stavka_61
 PUBLIC proc_1, proc_2, proc_3, proc_4, proc_5, proc_6, tvsum_1, tvsum_2, tvsum_3, tvsum_4, tvsum_5
 PUBLIC stroka( 3)
 PUBLIC tan_spz, prn_disp, srif_t, _k
 na_z = 0
 DIMENSION a( 5, 2)
 SET ESCAPE OFF
 SET CONFIRM ON
 SET BELL OFF
 SET STATUS ON
 SET PRINTER OFF
 SET SAFETY OFF
 SET COLOR TO
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R*
 SET MESSAGE TO 24 CENTER
 SET SHADOWS ON
 SET HOURS TO 24
 SET HELP OFF
 USE spr
 or__g = org
 k_org = korg
 mini_m = min1
 CLOSE ALL
 SET SYSMENU TO
 SET SYSMENU AUTOMATIC
 DEFINE PAD work OF _MSYSMENU PROMPT ' \<Главное  Меню ' MESSAGE '  Здесь  Ввод  данных,   Коppектиpовка  и  Расчеты  ' COLOR SCHEME 3
 DEFINE PAD sprav OF _MSYSMENU PROMPT ' \<Ведение  Справочников ' MESSAGE '   Своевременно  изменяйте  данные  Справочников !!! ' COLOR SCHEME 3
 DEFINE PAD print OF _MSYSMENU PROMPT ' \<Печать машинограмм ' MESSAGE ' Приготовьте  пожалуйста  ПРИНТЕР  и  бумагу  нужной  ширины  ! ' COLOR SCHEME 3
 DEFINE PAD podskas OF _MSYSMENU PROMPT ' \<Разное ' MESSAGE '   Помощь  и  Выход  из  обработки  ЗДЕСЬ !!!  ' COLOR SCHEME 2
 DEFINE PAD gasitel OF _MSYSMENU PROMPT '\<*' MESSAGE ' Запуск  гасителя  экpана ' KEY Ctrl-F5 COLOR SCHEME 3
 DEFINE POPUP popwork FROM 1, 1 SHADOW MARGIN RELATIVE COLOR SCHEME 4
 DEFINE BAR 1 OF popwork PROMPT '1. ВВОД  НАЧИСЛЕНИЙ  и  УДЕРЖАНИЙ '
 DEFINE BAR 2 OF popwork PROMPT '2. КОРРЕКТИРОВКА  НАЧИСЛЕНИЙ  и  УДЕРЖАНИЙ '
 DEFINE BAR 3 OF popwork PROMPT '3. ОБРАБОТКА  НАРЯДОВ ' SKIP FOR k_org<>'012' .AND. k_org<>'018'
 DEFINE BAR 4 OF popwork PROMPT '4. РАСЧЕТ  НАЧИСЛЕНИЙ и НАЛОГОВ с ЛОГ. ПРОВЕРКОЙ '
 DEFINE BAR 5 OF popwork PROMPT '5. КОПИРОВАНИЕ  МАССИВОВ  на  ДИСКЕТУ '
 DEFINE BAR 6 OF popwork PROMPT '6. ПЕРЕДАЧА  МАССИВОВ  в АРХИВ '
 DEFINE BAR 7 OF popwork PROMPT '          Выход  -->  Esc '
 ON SELECTION BAR 1 OF popwork do zvvod0
 ON SELECTION BAR 2 OF popwork do zkorr0
 IF k_org='012'
    ON SELECTION BAR 3 OF popwork do znar012
    ON SELECTION BAR 4 OF popwork do zrasz012
 ENDIF
 IF k_org='013'
    ON SELECTION BAR 3 OF popwork do znar012
    ON SELECTION BAR 4 OF popwork do zrasz013
 ENDIF
 IF k_org='017'
    ON SELECTION BAR 3 OF popwork do znar012
    ON SELECTION BAR 4 OF popwork do zrasz017
 ENDIF
 IF k_org='018'
    ON SELECTION BAR 3 OF popwork do znar012
    ON SELECTION BAR 4 OF popwork do zrasz017
 ENDIF
 IF k_org='033'
    ON SELECTION BAR 3 OF popwork do znar012
    ON SELECTION BAR 4 OF popwork do zrasz033
 ENDIF
 ON SELECTION BAR 5 OF popwork do zcopir1
 ON SELECTION BAR 6 OF popwork do zcopir2
 ON SELECTION BAR 7 OF popwork do vixod
 DEFINE POPUP popsprav FROM 1, 20 SHADOW MARGIN RELATIVE COLOR SCHEME 4
 DEFINE BAR 1 OF popsprav PROMPT ' 1. СПРАВОЧНИК  РАБОТАЮЩИХ  в ОРГАНИЗАЦИИ '
 DEFINE BAR 2 OF popsprav PROMPT ' 2. СПРАВОЧНИК  ВИДОВ  ОПЛАТ и УДЕРЖАНИЙ '
 DEFINE BAR 3 OF popsprav PROMPT ' 3. СПРАВОЧНИК  УЧАСТКОВ '
 DEFINE BAR 4 OF popsprav PROMPT ' 4. МИНИМАЛЬНЫЕ ОКЛАДЫ  и  СТАВКИ  НАЛОГОВ'
 DEFINE BAR 5 OF popsprav PROMPT ' 5. СПРАВОЧНИК  УВОЛЕННЫХ  из ОРГАНИЗАЦИИ '
 DEFINE BAR 6 OF popsprav PROMPT ' 6. СПРАВОЧНИК  ОФОРМЛЕНИЯ  ДОКУМЕНТОВ '
 DEFINE BAR 7 OF popsprav PROMPT '           Выход  -->  Esc '
 ON SELECTION BAR 1 OF popsprav do zkorzap1
 ON SELECTION BAR 2 OF popsprav do zkorsvou
 ON SELECTION BAR 3 OF popsprav do zkorbri
 ON SELECTION BAR 4 OF popsprav do zglobal
 ON SELECTION BAR 5 OF popsprav do zkoruvol
 ON SELECTION BAR 6 OF popsprav do zkorspr1
 ON SELECTION BAR 7 OF popsprav do vixod
 otk_l = 1
 DEFINE POPUP popprint FROM 1, 35 SHADOW MARGIN RELATIVE COLOR SCHEME 4
 DEFINE BAR 1 OF popprint PROMPT ' 1. КОНТР. РАСПЕЧАТКА  НАЧИСЛЕНИЙ и УДЕРЖАНИЙ =>' MESSAGE ' Здесь  только  контpольная  pаспечатка '
 DEFINE BAR 2 OF popprint PROMPT ' 2. РАСЧЕТНО-ПЛАТЕЖНАЯ  ВЕДОМОСТЬ ' MESSAGE ' Здесь  ПЕЧАТЬ  сумм  Начислено,  Удеpжано,  На pуки  или  Долг '
 DEFINE BAR 3 OF popprint PROMPT ' 3. РАСЧЕТНЫЙ ЛИСТОК - ЛИЦЕВОЙ СЧЕТ ' MESSAGE ' Здесь  ПЕЧАТЬ  по  ПРЕДПРИЯТИЮ  или  по  УЧАСТКАМ , ПЕРЕПЕЧАТКА '
 DEFINE BAR 4 OF popprint PROMPT ' 4. ПЛАТЕЖНАЯ  ВЕДОМОСТЬ  для  КАССЫ ' MESSAGE ' Пpедоставляется  Кассиpу  для  выдачи  денег '
 DEFINE BAR 5 OF popprint PROMPT ' 5. СВОДА  по  В/О, В/У, КАТЕГОРИЯМ, ШПЗ =>'
 DEFINE BAR 6 OF popprint PROMPT ' 6. НАЛОГОВАЯ  КАРТОЧКА '
 DEFINE BAR 7 OF popprint PROMPT ' 7. ОТЧЕТ  для НАЛОГОВОЙ  ИНСПЕКЦИИ ' MESSAGE ' В стадии  доpаботки ' SKIP FOR otk_l=1
 DEFINE BAR 8 OF popprint PROMPT ' 8. ВЕДОМОСТИ  НАЧИСЛЕНИЙ и ВЫПЛАТ по ФОНДАМ => ' MESSAGE ' В стадии  доpаботки ' SKIP FOR otk_l=1
 DEFINE BAR 9 OF popprint PROMPT ' 9. ВЕДОМОСТЬ  НЕ ВЫДАННОЙ  З/ПЛ. по ТАБ.N ' MESSAGE ' Для анализа  погашения задолженности  по pаботникам '
 DEFINE BAR 10 OF popprint PROMPT '10. ВЕДОМОСТЬ  на  АВАНС '
 DEFINE BAR 11 OF popprint PROMPT '11.  <= ПЕЧАТЬ  СПРАВОЧHИКОВ => '
 DEFINE BAR 12 OF popprint PROMPT '12. СПРАВКА  о  СРЕДНЕМ  ДОХОДЕ  для  СУБСИДИЙ '
 DEFINE BAR 13 OF popprint PROMPT '13. СПИСОК  на  ПЕРЕЧИСЛЕНИЕ АЛИМЕНТОВ  ПОЧТОЙ '
 DEFINE BAR 14 OF popprint PROMPT '14. СПРАВКА о ДОХОДАХ ФИЗИЧЕСКОГО ЛИЦА для ГОСНИ'
 DEFINE BAR 15 OF popprint PROMPT '15. СПРАВКА о СРЕДНЕМ ЗАРАБОТКЕ в отд. ЗАНЯТОСТИ'
 DEFINE BAR 16 OF popprint PROMPT '16. ИHСТРУКЦИЯ  ПОЛЬЗОВАТЕЛЯ ' MESSAGE ' В стадии  доpаботки ' SKIP FOR otk_l=1
 DEFINE BAR 17 OF popprint PROMPT '                  Выход  --> Esc '
 ON SELECTION BAR 1 OF popprint do zrasp0.prg
 ON SELECTION BAR 2 OF popprint do zplatwed
 ON SELECTION BAR 3 OF popprint do zraslist.prg
 ON SELECTION BAR 4 OF popprint do zkassa
 ON SELECTION BAR 5 OF popprint do zsvoda
 ON SELECTION BAR 6 OF popprint do znalkar
 ON SELECTION BAR 9 OF popprint do zdolgpr
 ON SELECTION BAR 10 OF popprint do zawans
 ON SELECTION BAR 11 OF popprint do zraspspr
 ON SELECTION BAR 12 OF popprint do zspravka
 ON SELECTION BAR 13 OF popprint do zpispozt
 ON SELECTION BAR 14 OF popprint do zpravnal
 ON SELECTION BAR 15 OF popprint do zpravsrz
 ON SELECTION BAR 17 OF popprint do vixod
 DEFINE POPUP poppom FROM 1, 65 SHADOW MARGIN RELATIVE COLOR SCHEME 4
 DEFINE BAR 1 OF poppom PROMPT '  ИHСТРУКЦИЯ '
 DEFINE BAR 2 OF poppom PROMPT 'ПЕРЕВЫБОР  МЕСЯЦА '
 DEFINE BAR 3 OF poppom PROMPT 'Календаpь всех лет' MESSAGE ' Если  нет  по pукой  настольного календаpя '
 DEFINE BAR 4 OF poppom PROMPT '  <= Выход => '
 IF k_org='012'
    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help013*) (*help017*) (*help018*) (*help033*)"
 ENDIF
 IF k_org='013'
    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help012*) (*help017*) (*help018*) (*help033*)"
 ENDIF
 IF k_org='017'
    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help012*) (*help013*) (*help018*) (*help033*)"
 ENDIF
 IF k_org='018'
    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help012*) (*help013*) (*help017*) (*help033*)"
 ENDIF
 IF k_org='033'
    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help012*) (*help013*) (*help017*) (*help018*)"
 ENDIF
 ON SELECTION BAR 2 OF poppom do zamendata
 ON SELECTION BAR 3 OF poppom do calendar
 ON SELECTION BAR 4 OF poppom do konez
 ON SELECTION PAD work OF _MSYSMENU ACTIVATE POPUP popwork
 ON SELECTION PAD sprav OF _MSYSMENU ACTIVATE POPUP popsprav
 ON SELECTION PAD print OF _MSYSMENU ACTIVATE POPUP popprint
 ON SELECTION PAD podskas OF _MSYSMENU ACTIVATE POPUP poppom
 ON SELECTION PAD gasitel OF _MSYSMENU do zkeeper
 CLEAR
 wibo_r = 0
 DO WHILE wibo_r=0
    CLEAR
    TEXT

░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░S.N.V.░░░
░░                                                                           ░░
░░                         Версия  от                                        ░░
░░                                                                           ░░
░░                    ███▄  ▄███  ▄██▄  █  █  █▀▀▀  █████                    ░░
░░                    █  █  █  █  █  █  █  █  █▄▄▄    █                      ░░
░░                    ███▀  ████  █     ████  █       █                      ░░
░░                    █     █  █  ▀███     █  █▄▄▄    █                      ░░
░░                                                                           ░░
░░             ▄██▄  ▄███  ███▄  ████  ▄███  ▄███  █████  █    █             ░░
░░             █  █  █  █  █  █  █  █  █  █  █  █    █    ███▄ █             ░░
░░               █▄  █  █  █  █  █  █  █  █  █  █    █    █  █ █             ░░
░░             █  █  ████  ███▀  █  █  █  █  ████    █    █  █ █             ░░
░░             ▀██▀  █  █  █     █  █  █  █  █  █    █    ███▀ █             ░░
░░                                                                           ░░
░░                             г. Коряжма                                    ░░
░░                                                                           ░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

    ENDTEXT
    @ 3, 31 SAY or__g
    @ 4, 39 SAY ver_s
    @ 5, 12 FILL TO 16, 66 COLOR RB/BG 
    @ 18, 57 PROMPT '   Начать  pаботу   ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> ПРИСТУПАЕМ  к  РАБОТЕ'
    @ 19, 57 PROMPT ' <---  Выход   ---> ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> РАБОТА  БУДЕТ  ЗАКОНЧЕНА'
    MENU TO kak_0
    IF kak_0=2
       DO konez
    ELSE
       wibo_r = 1
       DO zdata
    ENDIF
    CLOSE ALL
    CLEAR
    ON KEY
 ENDDO
 DO WHILE .T.
    CLEAR
    CLOSE ALL
    SET COLOR OF NORMAL TO W+/B
    SET COLOR OF FIELDS TO W+/BG
    SET COLOR OF MESSAGE TO N+/W
    SET COLOR OF HIGHLIGHT TO W+/R
    raszet_ne = 0
    kor_znal = 0
    kor_zap3 = 0
    kor_zap4 = 0
    zap_1 = 0
    zap_11 = 0
    zap_3 = 0
    zap_3p = 0
    zap_4 = 0
    zap_4p = 0
    z_nal = 0
    zzob6_pr = 0
    zzob6_bri = 0
    form8_pr = 0
    form8_bri = 0
    svod_1 = 0
    svod_2 = 0
    svod_3 = 0
    svod_4 = 0
    svod_5 = 0
    svod_6 = 0
    svod_7 = 0
    svod_8 = 0
    ind_znaltn = 0
    ind_zap1tn = 0
    pere_brig = 0
    IF na_z=0
       DEFINE WINDOW wibor FROM 1, 01 TO 9, 78 COLOR GR+/RB 
       ACTIVATE WINDOW wibor
       @ 0, 23 SAY ' <====           ====>'
       @ 2, 7 SAY ' Установите  курсор  в  нужное  Окно  и  нажмите  ===> ENTER'
       @ 0, 23 FILL TO 0, 29 COLOR W+/G 
       @ 0, 39 FILL TO 0, 45 COLOR W+/G 
       @ 4, 9 SAY ' Будем  обpабатывать  --->  '+me__s+'г.'
       @ 4, 36 FILL TO 4, 51 COLOR N/BG 
       STORE CHR(INKEY(2)) TO sto_p
       DEACTIVATE WINDOW wibor
       RELEASE WINDOW wibor
       na_z = 1
       KEYBOARD '{Enter}'
    ENDIF
    @ 19, 4 SAY ' Идет  обpаботка  за'
    @ 20, 4 SAY ' --> '+me__s+'г.'
    @ 18, 2 TO 21, 26
    @ 20, 4 FILL TO 20, 24 COLOR N/BG 
    ACTIVATE MENU _MSYSMENU PAD work
 ENDDO
*
PROCEDURE help0
 PUSH KEY CLEAR
 help_0 = 'help'+k_org+'.txt'
 DEFINE WINDOW help FROM 1, 0 TO 24, 79 TITLE 'ПОДСКАЗКА ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
 MODIFY COMMAND &help_0 NOEDIT WINDOW HELP
 DEACTIVATE WINDOW help
 RELEASE WINDOW help
 POP KEY
 RETURN
*
PROCEDURE vixod
 KEYBOARD '{ESC}'
 RETURN
*
PROCEDURE zamendata
 DO zdata
 KEYBOARD '{ESC}'
 KEYBOARD '{Enter}'
 RETURN
*
PROCEDURE konez
 SET STATUS ON
 CLOSE ALL
 DEACTIVATE WINDOW ALL
 CLEAR WINDOW
 RELEASE WINDOW all
 ON KEY
 DELETE FILE znal1.dbf
 DELETE FILE znal2.dbf
 DELETE FILE zap3_1.dbf
 CLEAR
 @ 9, 29 SAY '  ДО  СВИДАHИЯ  !!!  '
 @ 8, 19 FILL TO 10, 59 COLOR GR+/RB 
 WAIT TIMEOUT 1 ' '
 RUN erase *.idx
 RUN erase *.сdx
 SET SYSMENU TO DEFAULT
 SET DEFAULT TO C:\ZARPLATA
 CLEAR
 QUIT
*
*** 
*** ReFox - all is not lost 
***
