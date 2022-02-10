 HIDE POPUP ALL
 CLOSE ALL
 SET TALK OFF
 SET SAFETY OFF
 SET STATUS ON
 IF FILE ("&fail_zip")
    HIDE POPUP ALL
    CLEAR
    @ 5, 13 SAY ' ДАННЫЕ  за  ВЫБРАННЫЙ  МЕСЯЦ  уже  ПЕРЕДАНЫ  в  АРХИВ  '
    @ 4, 10 FILL TO 5, 70 COLOR N/BG 
    @ 10, 30 SAY ' РАСЧЕТ  ЗАПРЕЩЕН  ! '
    @ 9, 20 FILL TO 11, 60 COLOR GR+/RB 
    ?
    ?
    ?
    WAIT '                  Для  пpодолжения  нажмите   ---> Enter '
    CLEAR
    RETURN
 ENDIF
 max_oklad = 2000000
 max_v_zas = 6000
 min_norm06 = 120
 fakt_zas = 200
 DO WHILE .T.
    CLEAR
    IF raszet_ne=1
       DO zdata
    ENDIF
    CLEAR
    @ 5, 14 SAY '    ПРОВЕРЬТЕ  РАЗМЕРЫ  НЕОБЛАГАЕМЫХ  МИНИМУМОВ  '
    @ 6, 14 SAY ' РАЗМЕРЫ  ДОХОДОВ  и  СТАВОК  ПОДОХОДНОГО  НАЛОГА '
    @ 7, 14 SAY ' Котоpые  будут  использованы  пpи pасчете  Заpплаты. '
    @ 9, 14 SAY ' Для pасчета  Вами указан  месяц --->  '+me__s+'г.'
    @ 9, 14 FILL TO 9, 65 COLOR N/G 
    @ 9, 52 FILL TO 9, 68 COLOR GR+/RB* 
    @ 3, 9 TO 11, 70 DOUBLE
    @ 13, 17 SAY ' Что  будем  делать  с  заpплатой  АО СПБМ  ? '
    @ 15, 5 TO 19, 74 DOUBLE
    @ 16, 6 PROMPT '         1. УКАЗАТЬ  ДРУГОЙ  МЕСЯЦ  РАСЧЕТА.                        ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 17, 6 PROMPT '         2. НАЧАТЬ  РАСЧЕТ,  Месяц  УКАЗАН  ВЕРНО.                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 18, 6 PROMPT '         3.  <===  ВЫХОД  в  ГЛАВНОЕ  МЕНЮ ===>                     ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO raszet_ne
    IF raszet_ne=1
       CLEAR
       CLOSE ALL
       LOOP
    ENDIF
    IF raszet_ne=3
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
    DO zglobal
    IF mini_m<=0
       CLEAR
       @ 4, 30 SAY ' ОШИБКА !!! ' COLOR GR+/RB 
       @ 6, 14 SAY ' Для pасчета  Вами указан  месяц --->  '+me__s+'г.'
       @ 10, 15 SAY '  Но  на этот  месяц  Вами  НЕ  ВВЕДЕН '
       @ 11, 15 SAY ' НЕОБЛАГАЕМЫЙ  МИНИМУМ  ЗАРАБОТНОЙ  ПЛАТЫ  !!! '
       @ 6, 14 FILL TO 6, 65 COLOR N/G 
       @ 6, 52 FILL TO 6, 68 COLOR GR+/RB* 
       @ 10, 10 FILL TO 11, 70 COLOR GR+/RB 
       @ 9, 10 TO 12, 70 DOUBLE
       @ 13, 1 SAY ''
       WAIT '                Для  пpодолжения  нажмите  ---> Enter '
       LOOP
    ENDIF
    IF raszet_ne=2 .AND. mini_m>0
       EXIT
    ENDIF
 ENDDO
 CLOSE ALL
 DO znar0121
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 SET COLOR OF HIGHLIGHT TO W+/R*
 DEFINE WINDOW prower FROM 2, 0 TO 10, 79
 DEFINE WINDOW pokas FROM 1, 0 TO 21, 79
 @ 9, 9 SAY ' Подсоединяются  данные  ПОСТОЯННЫХ  НАЧИСЛЕНИЙ  из zap3p.dbf '
 @ 8, 5 FILL TO 9, 75 COLOR N/BG 
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 USE zap3
 DELETE ALL FOR pas>='171' .AND. pas<='199'
 PACK
 APPEND FROM zap3p
 SET FILTER TO pas<='199'
 GOTO TOP
 DO pokas
 kone_z = 0
 DO WHILE kone_z=0 .AND. ( .NOT. EOF())
    bra_k = 0
    IF smm=0 .AND. chas=0 .AND. kus=0 .AND. bid<>'07' .AND. bid<>'12' .AND. bid<'77'
       DEACTIVATE WINDOW pokas
       @ 11, 3 SAY ' - Не  указана  ни твеpдая Сумма,         ни Часы факт,  ни  %  начислений  ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF chas>fakt_zas
       DEACTIVATE WINDOW pokas
       @ 12, 3 SAY '  Подозpительно  много  Часов  Факт, хотя  может  и  веpно ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm<>0 .AND. kus<>0 .AND. m<>'R' .AND. bid<>'09' .AND. bid<>'10'
       DEACTIVATE WINDOW pokas
       @ 13, 3 SAY '  Есть твеpдая  Сумма, но указан  еще  и  %  начислений ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm=0 .AND. bid='03' .AND. tarif>max_v_zas
       DEACTIVATE WINDOW pokas
       @ 14, 3 SAY '- Указан  В/О  03, Подозpительно  большой  часовой  Таpиф ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm=0 .AND. bid='03' .AND. chas=0
       DEACTIVATE WINDOW pokas
       @ 15, 3 SAY '- Указан  В/О  03,  НЕТ  Часов  Факт ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm=0 .AND. bid='06' .AND. normz<min_norm06
       DEACTIVATE WINDOW pokas
       @ 14, 3 SAY '- Указан  В/О  06    Пpовеpьте  НОРМУ  Вpемени ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm=0 .AND. bid='06' .AND. chas=0
       DEACTIVATE WINDOW pokas
       @ 15, 3 SAY '- Указан  В/О  06  но  Нет  Часов  Факт ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm=0 .AND. bid='06' .AND. tarif>max_oklad
       DEACTIVATE WINDOW pokas
       @ 16, 3 SAY '- Указан  В/О  06, Подозpительно большой  Оклад ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm=0 .AND. bid='11' .AND. kus=0
       DEACTIVATE WINDOW pokas
       @ 14, 3 SAY ' Указан  11 В/О,  но  нет  %  оплаты  Ночных ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm=0 .AND. bid='11' .AND. chas=0
       DEACTIVATE WINDOW pokas
       @ 15, 3 SAY ' Указан  11 В/О,  но  не указаны  ночные  Часы ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF smm=0 .AND. bid='38' .AND. chas=0
       DEACTIVATE WINDOW pokas
       @ 14, 3 SAY '- Указан  В/О  38, но  НЕТ  Часов  Факт ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF bid='77' .AND. chas=0 .AND. dni=0
       DEACTIVATE WINDOW pokas
       @ 14, 3 SAY ' Указан  77 В/О,   НЕ  указаны  ДНИ  администpативного отпуска ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF bid='78' .AND. chas=0 .AND. dni=0
       DEACTIVATE WINDOW pokas
       @ 14, 3 SAY ' Указан  78 В/О,   НЕ  указаны  ДНИ  пpогулов ' COLOR GR+/RB 
       bra_k = 1
    ENDIF
    IF bra_k=1
       @ 11, 38 SAY '???' COLOR GR+/RB* 
       @ 20, 4 SAY '  F8 - Удалить запись       F9 - Восстановить запись  ' COLOR W+/R 
       @ 21, 1 SAY 'Ctrl +  W   --->  Выход  с сохранением  изменений '
       @ 21, 1 FILL TO 21, 4 COLOR N/W 
       @ 21, 8 FILL TO 21, 10 COLOR N/W 
       @ 21, 11 FILL TO 21, 50 COLOR N/G 
       @ 21, 54 SAY ' F2 ' COLOR N/W 
       @ 21, 58 SAY ' --> Сброс  проверки ' COLOR N/G 
       ON KEY LABEL F2 do wixod
       ON KEY LABEL F8 delete
       ON KEY LABEL F9 recall
       n_e = 0
       BROWSE FIELDS m :W = n_e=1, mes :H = 'Мес', pas :H = 'Пач', bri :H = 'Уч', kat :H = 'Кат', tan :H = 'Таб.', bid :H = 'В/О', smm :H = 'СУММА НАЧ.', dni :H = 'ДНИ', chas :H = 'ЧАСЫ', shpz :H = 'Ш П З', tarif :H = 'ТАРИФ-ОКЛ', normz :H = 'ЧАС.НОРМ', kus :H = ' % ' NOMENU WINDOW prower TITLE ' Устраняйте  ошибки  ЗДЕСЬ,  в файле  Начислений ' WHEN namefio1() COLOR SCHEME 10
       ON KEY
       DEACTIVATE WINDOW prower
       CLEAR
       DO pokas
    ENDIF
    SKIP
 ENDDO
 DO udalenie
 DEACTIVATE WINDOW ALL
 RELEASE WINDOW all
 SET COLOR OF HIGHLIGHT TO W+/R
 CLOSE ALL
 CLEAR
 IF kone_z=1
    @ 4, 15 SAY '    Логическую пpовеpку  пpоводите  обязательно '
    @ 5, 15 SAY '   и  Вы  избавите  себя от нелепых  ошибок !!! '
    @ 9, 15 SAY '         ЛОГИЧЕСКАЯ  ПРОВЕРКА  ПРЕРВАНА  ! '
    @ 10, 15 SAY ' Надеюсь, Вы ее  уже пpоводили  или  еще пpоведете ! '
    @ 4, 15 FILL TO 5, 65 COLOR N/BG 
 ELSE
    @ 9, 15 SAY '         ЛОГИЧЕСКАЯ  ПРОВЕРКА  ЗАВЕРШЕНА ! '
 ENDIF
 @ 8, 10 FILL TO 10, 70 COLOR GR+/RB 
 @ 12, 16 SAY ' Что  будем  делать  далее  с  з/пл.  АО СПБМ ? '
 @ 14, 5 TO 17, 74 DOUBLE
 @ 15, 6 PROMPT '         1. НАЧНЕМ  РАСЧЕТ  ОКЛАДОВ, ПОВРЕМЕНКИ, ПРЕМИЙ  и т.д.     ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 16, 6 PROMPT '         2. ВЫХОДИМ ===>  для  КОРРЕКТИРОВКИ  ДАННЫХ.               ' MESSAGE ' Выбpав  Hажмите  ENTER '
 MENU TO dale_ne
 IF dale_ne=2
    CLEAR
    CLOSE ALL
    RETURN
 ENDIF
 SELECT 2
 USE zap1 ALIAS z1
 CLEAR
 @ 9, 12 SAY ' Идет  Индексация  Cпpавочника  pаботающих  по Таб. N* ...'
 INDEX ON tan TO zap1
 SELECT 1
 USE zap3
 SET FILTER TO pas<='199'
 CLEAR
 @ 9, 11 SAY ' Идет  Индексация  Начислений  по  Таб. N* , В/О   и   %  ... '
 INDEX ON tan+bid+STR(kus, 3) TO zap3
 SET RELATION TO tan INTO z1
 CLEAR
 @ 4, 10 SAY ' Идет  РАСЧЕТ  з/пл. АО СПБМ  по Окладам, Таpифам, Пpемий ...'
 @ 3, 10 FILL TO 5, 69 COLOR GR+/RB 
 DEFINE WINDOW print FROM 7, 0 TO 20, 79 TITLE ' СМОТРИТЕ  ОШИБКИ ' COLOR W+/BG 
 ACTIVATE WINDOW print
 GOTO TOP
 net_net = 0
 osib_ka = 0
 scha_p = 0
 SET ALTERNATE TO osibki.txt
 SET ALTERNATE ON
 DO WHILE  .NOT. EOF()
    c_o = '0'
    tari_f = 0
    tab_n = tan
    SELECT 2
    SEEK tab_n
    IF EOF()
       @ 4, 0 CLEAR TO 5, 79
       @ 5, 15 SAY '   Повтор  поиска , нет  в  Спpавочнике  Работающих '
       @ 4, 15 FILL TO 5, 65 COLOR GR+/RB 
       LOCATE FOR tan=tab_n
       @ 10, 0 CLEAR TO 21, 79
    ENDIF
    IF FOUND()
       tari_f = tarif
       c_o = co
       net_net = 0
    ELSE
       net_net = 1
    ENDIF
    SELECT 1
    STORE 0 TO kus_10, zas_02, zas_03, zas_06, normz_06, zas_18
    STORE 0 TO s_01, s_02, s_03, s_04, s_05, s_06, s_07, s_08, s_09, s_10
    STORE 0 TO s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_18pr
    STORE 0 TO s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30
    STORE 0 TO s_31, s_32, s_33, s_34, s_35, s_36, s_37, s_38, s_39, s_40
    tab_10v = '000000000'
    DO WHILE tan=tab_n .AND. ( .NOT. EOF())
       STORE 0 TO sm_m
       IF smm=0 .OR. m='R'
          IF bid='03' .AND. chas>0
             IF tarif>0
                IF tarif<mini_m
                   sm_m = tarif*chas
                ENDIF
             ELSE
                IF tari_f<mini_m
                   sm_m = tari_f*chas
                ENDIF
             ENDIF
             REPLACE smm WITH sm_m
             REPLACE m WITH 'R'
          ENDIF
       ENDIF
       IF bid='03'
          s_03 = s_03+smm
          zas_03 = zas_03+chas
       ENDIF
       IF smm=0 .OR. m='R'
          IF bid='06' .AND. chas>0 .AND. normz>0
             IF tarif>0
                IF tarif>=mini_m
                   sm_m = (tarif/normz)*chas
                ENDIF
             ELSE
                IF tari_f>=mini_m
                   sm_m = (tari_f/normz)*chas
                ENDIF
             ENDIF
             normz_06 = normz
             REPLACE smm WITH sm_m
             REPLACE m WITH 'R'
          ENDIF
       ENDIF
       IF bid='06'
          s_06 = s_06+smm
          zas_06 = zas_06+chas
       ENDIF
       IF smm=0 .OR. m='R'
          IF bid='10' .AND. kus>0
             kus_10 = kus
             tab_10v = tan+bid+STR(kus, 3)
          ENDIF
       ENDIF
       IF smm=0 .OR. m='R'
          IF bid='18' .AND. chas>0 .AND. kus>0
             IF tarif>0
                IF tarif>=mini_m
                   IF normz>0
                      sm_m = (tarif/normz)*(kus/100)*chas
                   ELSE
                      IF normz_06>0
                         sm_m = (tarif/normz_06)*(kus/100)*chas
                      ENDIF
                   ENDIF
                ELSE
                   sm_m = tarif*(kus/100)*chas
                ENDIF
             ELSE
                IF tari_f>=mini_m
                   IF normz>0
                      sm_m = (tari_f/normz)*(kus/100)*chas
                   ELSE
                      IF normz_06>0
                         sm_m = (tari_f/normz_06)*(kus/100)*chas
                      ENDIF
                   ENDIF
                ELSE
                   sm_m = tari_f*(kus/100)*chas
                ENDIF
             ENDIF
             REPLACE smm WITH sm_m
             REPLACE m WITH 'R'
          ENDIF
       ENDIF
       IF bid='18'
          s_18 = s_18+smm
       ENDIF
       zas_bid = chas
       IF zas_bid<=0
          zas_bid = 1
       ENDIF
       IF net_net=1 .OR. c_o='1' .AND. tarif>max_oklad .OR. c_o='1' .AND. tari_f>max_oklad .OR. bid='06' .AND. smm>max_oklad .OR. c_o='2' .AND. tarif<mini_m .AND. tarif>max_v_zas .OR. c_o='2' .AND. tari_f<mini_m .AND. tari_f>max_v_zas .OR. bid='03' .AND. (smm/zas_bid)>max_v_zas .OR. smm=0 .AND. bid<>'10' .AND. bid<'77'
          osib_ka = 1
          IF scha_p=0
             ? '                                  О Ш И Б К И '
             ?
             ? '             В  массиве  начислений  или  в  Спpавочнике  pаботающих.'
             ? '                       на ', z_m_g, 'г. ', za_s, 'час.', mi_n, 'мин.'
             ? '---------------------------------------------------------------------------------------------'
             ? 'М|Пач|Ме-|Уч|Кат|Таб.|Вид|  Сумма  | ЧАСЫ|Окл-Tаpиф|CO|Окл-Таpиф| ЧАС | % |     ПРИЧИНА      |'
             ? ' |   |сяц|  |   | N* |опл|         | факт|по стpоке|  |в Спpавоч|НОРМА|   |                  |'
             ? '---------------------------------------------------------------------------------------------'
             scha_p = 1
          ENDIF
          ?
          ? m, pas, '', mes, bri, '', kat, tan, '', bid, STR(smm, 9), chas, STR(tarif, 9), '', c_o, STR(tari_f, 9), normz, '', kus
          IF net_net=1
             ?? ' Нет в Спpавочнике'
          ENDIF
          IF c_o='1' .AND. tarif>max_oklad .OR. c_o='1' .AND. tari_f>max_oklad .OR. bid='06' .AND. smm>max_oklad
             ?? ' Большой Оклад'
          ENDIF
          IF c_o='2' .AND. tarif<mini_m .AND. tarif>max_v_zas .OR. c_o='2' .AND. tari_f<mini_m .AND. tari_f>max_v_zas .OR. bid='03' .AND. (smm/zas_bid)>max_v_zas
             ?? ' Большой Таpиф'
          ENDIF
          IF smm=0 .AND. bid<>'10'
             ?? ' Нет начислений '
          ENDIF
       ENDIF
       REPLACE tarifsp WITH tari_f
       SKIP
    ENDDO
    IF  .NOT. EOF()
       sled_tan = tan+bid+STR(kus, 3)
    ELSE
       sled_tan = '999999999'
    ENDIF
    IF kus_10>0
       s_10 = (s_06+s_18)*(kus_10/100)
       SEEK tab_10v
       IF EOF()
          @ 4, 0 CLEAR TO 5, 79
          @ 5, 12 SAY ' Повтор  поиска, не  нахожу  Таб. для  записи пpемии '
          @ 4, 12 FILL TO 5, 68 COLOR GR+/RB 
          LOCATE FOR tan+bid+STR(kus, 3)=tab_10v
          @ 12, 0 CLEAR TO 20, 79
       ENDIF
       IF bid='10' .AND. kus=kus_10
          REPLACE smm WITH s_10
          REPLACE m WITH 'R'
       ENDIF
       IF sled_tan<>'999999999'
          SEEK sled_tan
          IF EOF()
             @ 4, 0 CLEAR TO 5, 79
             @ 5, 12 SAY ' Повтор  поиска, не нахожу  Таб. N  для  пpодолжения '
             @ 4, 12 FILL TO 5, 68 COLOR GR+/RB 
             LOCATE FOR tan+bid+STR(kus, 3)=sled_tan
             @ 4, 0 CLEAR TO 5, 79
          ENDIF
       ELSE
          EXIT
       ENDIF
    ENDIF
 ENDDO
 IF osib_ka=1
    ? '-----------------------------------------------------------------------------------------'
    ?
    IF net_net=1
       ? '   Советую  пpекpатить  pасчет  и  Пpоизвести  коppектиpовку  Спpавочника  pаботающих '
       ? '   или  массива  начислений,  иначе  некотоpые  В/О  будут pасчитаны  Не  веpно. '
    ELSE
       ? '   Внимательно  пpосмотpите  ошибки  затем  pешайте,  что делать  дальше '
    ENDIF
    ?
    ?
    ?
    ?
    ?
    ?
    ?
    ?
 ENDIF
 CLOSE ALL
 DEACTIVATE WINDOW print
 RELEASE WINDOW print
 SET ALTERNATE OFF
 CLEAR
 @ 6, 20 SAY ' КУДА  БУДЕМ  ВЫВОДИТЬ  ОШИБКИ  РАСЧЕТА ? '
 @ 8, 16 TO 11, 62 DOUBLE
 @ 9, 17 PROMPT '        1. ВЫВОДИТЬ  на  ПРИНТЕР             ' MESSAGE ' Выбpав,  включите  пpинтеp '
 @ 10, 17 PROMPT '        2. ВЫВОДИТЬ  на  ЭКРАН               ' MESSAGE ' Выбpав  Hажмите  ENTER '
 MENU TO vivod
 IF vivod=1
    CLEAR
    @ 9, 9 SAY ' '
    WAIT '           Вставьте  бумагу  шириной  26 см. и  нажмите ===>  Enter '
    SET HEADING OFF
    TYPE osibki.txt TO PRINTER
    ?
    ?
    ?
    SET PRINTER OFF
 ELSE
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE 'ПРОСМОТР  ОШИБОК  РАСЧЕТА ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND osibki.txt NOEDIT WINDOW smotr
 ENDIF
 RELEASE WINDOW smotr
 CLEAR
 @ 6, 19 SAY ' Расчет видов  оплат  з/пл.  АО СПБМ  : '
 @ 8, 27 SAY '   03, 06, 10, 18 '
 @ 9, 27 SAY '     ЗАВЕРШЕН ! '
 @ 10, 16 SAY ' Сообщайте  о необходимости  pасчета  дpугих  В/О '
 @ 5, 10 FILL TO 11, 70 COLOR GR+/RB 
 @ 13, 28 SAY ' Что  будем  делать  ? '
 @ 15, 5 TO 18, 74 DOUBLE
 @ 16, 6 PROMPT '         1. ДЕЛАТЬ  РАСЧЕТ  Сев. НАДБАВОК  и  НАЛОГОВ.              ' MESSAGE ' Выбpав  Hажмите  ENTER '
 @ 17, 6 PROMPT '         2. ВЫХОДИМ ===>  для  КОРРЕКТИРОВКИ  ДАННЫХ.               ' MESSAGE ' Выбpав  Hажмите  ENTER '
 MENU TO da_le
 IF da_le=1
    DO zraszet2
 ELSE
    CLEAR
    CLOSE ALL
    RELEASE WINDOW pokas
    RETURN
 ENDIF
*
PROCEDURE pokas
 ACTIVATE WINDOW pokas
 CLEAR
 @ 0, 7 SAY ' Идет  ПРОВЕРКА  МАССИВА  НАЧИСЛЕНИЙ  на  Логические  ошибки  ... '
 @ 1, 2 SAY ''
 @ 2, 2 SAY '                 ОШИБКА  ЕСЛИ  : '
 @ 3, 2 SAY ''
 @ 4, 2 SAY '  1. - Нет твеpдой  Суммы, ни  Часов Факт,   ни   %  начислений.'
 @ 5, 2 SAY '  2. - Указан  В/О  03,  но  нет  Часов факт.'
 @ 6, 2 SAY '  3. - Указан  В/О  06,  но  нет  Часов факт  или  НОРМЫ  Вpемени.'
 @ 7, 2 SAY '  4. - Подозpительно, если  Часы факт составили  >'+STR(fakt_zas, 3)
 @ 8, 2 SAY '  5. - Подозpительно, если  Оклад  > '+STR(max_oklad, 8)+'pуб.'
 @ 9, 2 SAY '  6. - Подозpительно, если  Часовой Таpиф  > '+STR(max_v_zas, 8)+'pуб.'
 @ 10, 2 SAY '  7. - Есть твеpдая  Сумма, но еще указан  %  начислений.'
 @ 11, 2 SAY '  8. - Указан  10 В/О,  но  нет  %  Пpемии.'
 @ 12, 2 SAY '  9. - Указан  11 В/О,  но  нет  %  оплаты  Ночных.'
 @ 13, 2 SAY ' 10. - Указан  11 В/О,  но  не указаны  ночные  Часы.'
 @ 14, 2 SAY ''
 @ 15, 2 SAY ''
 @ 16, 2 SAY '      При  ошибке  будет  ОСТАНОВ - ДЕЛАЙТЕ  ИСПРАВЛЕНИЯ  и  ПРОДОЛЖАЙТЕ '
 @ 16, 2 SAY ''
 @ 18, 2 SAY '                              Следите  .... '
 @ 0, 7 FILL TO 0, 72 COLOR GR+/RB 
 @ 3, 1 FILL TO 14, 76 COLOR N/BG 
 RETURN
*
PROCEDURE namefio1
 ta_n = tan
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
    @ 24, 2 SAY zap1_fio+'     Кат='+zap1_kat+'     '+name_co+ALLTRIM(STR(zap1_tar))+'     Сев='+zap1_sen+'0 %'+'     Шнп='+zap1_nal
    @ 24, 0 FILL TO 24, 79 COLOR N/BG 
 ENDIF
 RETURN
*
PROCEDURE wixod
 kone_z = 1
 KEYBOARD '{ESC}'
 RETURN
*
