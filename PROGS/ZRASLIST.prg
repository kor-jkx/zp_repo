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
    @ 4, 18 SAY ' КАК  БУДЕМ  ПЕЧАТАТЬ  РАСЧЕТНЫЕ  ЛИСТКИ  ? '
    @ 3, 10 TO 6, 70
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 15, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ПЕЧАТЬ  РАСЧЕТНЫХ  ЛИСТКОВ - ЛИЦЕВЫХ  СЧЕТОВ  по  ПРЕДПРИЯТИЮ   ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ПЕЧАТЬ  РАСЧЕТНЫХ  ЛИСТКОВ - ЛИЦЕВЫХ  СЧЕТОВ  по  УЧАСТКАМ      ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 3. ВЫБОРОЧНАЯ  ПЕЧАТЬ ( ПЕРЕДЕЛКА ) РАСЧЕТНЫХ  ЛИСТКОВ             ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO zzob6_for
    IF zzob6_for=1
       IF zzob6_pr=0
          DO zzob6
       ENDIF
       DO kwitpred
    ENDIF
    IF zzob6_for=2
       IF zzob6_bri=0
          DO zzob6
       ENDIF
       DO kwitbri
    ENDIF
    IF zzob6_for=3
       IF zzob6_pr=0 .AND. zzob6_bri=0
          zzob6_for = 1
          DO zzob6
       ENDIF
       DO kwitpere
    ENDIF
    IF zzob6_for=4
       kone_z = 1
       CLOSE ALL
       DEACTIVATE WINDOW print
       RELEASE WINDOW print
       HIDE POPUP ALL
       SET PRINTER OFF
       ON KEY
       DELETE FILE rlist1.txt
       DELETE FILE rlist2.txt
       DELETE FILE rlist3.txt
       CLEAR
       RETURN
    ENDIF
 ENDDO
*
PROCEDURE kwitpred
 DO prindisp
 CLEAR
 tab_n = '0000'
 tab_k = '9999'
 @ 0, 6 SAY 'Hаберите : '
 @ 9, 15 SAY 'Таб. N*  с которого начать печать  ---> ' GET tab_n
 @ 11, 15 SAY 'Таб. N*  которым  закончить печать ---> ' GET tab_k
 READ
 CLEAR
 @ 10, 11 SAY ' Извините  за  задержку,   идет  подготовка  к  печати ...'
 SELECT 3
 USE znal ALIAS zn1
 SET INDEX TO znal
 SELECT 2
 USE svoud ALIAS d2
 SET INDEX TO svoud
 SELECT 1
 USE zaw
 SET INDEX TO zaw
 SET RELATION TO bid INTO d2
 SET RELATION TO tan INTO zn1 ADDITIVE
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
 ELSE
    SET ALTERNATE TO rlist1.txt
    SET ALTERNATE ON
 ENDIF
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 CLEAR
 STORE 0 TO nav_b, udv_b, svv_b, ssv_b, sdv_b, sov_b
 sto_p = 0
 STORE 0 TO nl_a, nav_a, udv_a, svv_a, sdv_a, sov_a, ssv_a
 DO WHILE tan<=tab_k .AND. sto_p=0 .AND. ( .NOT. EOF())
    tan_a = tan
    bri_a = bri
    c_o = co
    nl_a = nl_a+1
    STORE 0 TO bid_a, nat_a, udt_a, smt_a, sot_a, per_a, sst_a, s_sr, s_pn
    odin_ras = 0
    DO WHILE tan=tan_a .AND. ( .NOT. EOF())
       IF bid_a=0
          na_l = nal
       ENDIF
       DO rlistok1
    ENDDO
    DO rlistok2
    ?
 ENDDO
 ?
 ? ' * * * * * * * * * * * * * * * * * * * * * * * * * * '
 ?
 ? ' В С Е Г О  по  машиногpамме :'
 ?
 ? '    H а ч и с л е н о =', nav_a
 ?
 ? '             У д е р ж а н о -', udv_a
 ?
 ?
 ? '       К выдаче ===>', svv_a
 ?
 ? '          Д О Л Г -------->', sdv_a
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
 IF prn_disp=1
    CLEAR
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' РАСЧЕТНЫЕ  ЛИСТКИ  по  ПРЕДПРИЯТИЮ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND rlist1.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE kwitbri
 DO prindisp
 CLEAR
 bri_n = '00'
 bri_k = '99'
 tab_n = '0000'
 tab_k = '9999'
 DO zwbritan
 CLEAR
 @ 10, 23 SAY ' Ищу  начало  печати  ...'
 SELECT 3
 USE znal ALIAS zn1
 SET INDEX TO znal
 SELECT 2
 USE svoud ALIAS d2
 SET INDEX TO svoud
 SELECT 1
 USE zaw
 SET INDEX TO zaw
 SET RELATION TO bid INTO d2
 SET RELATION TO bri+tan INTO zn1 ADDITIVE
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
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ELSE
    SET ALTERNATE TO rlist2.txt
    SET ALTERNATE ON
 ENDIF
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 sto_p = 0
 STORE 0 TO nav_b, udv_b, svv_b, ssv_b, sdv_b, sov_b
 DO WHILE bri<=bri_k .AND. tan<=tab_k .AND. sto_p=0 .AND. ( .NOT. EOF())
    bri_a = bri
    STORE 0 TO nl_a, nav_a, udv_a, svv_a, sdv_a, sov_a, ssv_a
    DO WHILE bri<=bri_k .AND. bri=bri_a .AND. tan<=tab_k .AND. sto_p=0 .AND. ( .NOT. EOF())
       tan_a = tan
       c_o = co
       nl_a = nl_a+1
       STORE 0 TO bid_a, nat_a, udt_a, smt_a, sot_a, sst_a, s_sr, s_pn
       odin_ras = 0
       DO WHILE bri<=bri_k .AND. bri=bri_a .AND. tan<=tab_k .AND. tan=tan_a .AND. ( .NOT. EOF())
          IF bid_a=0
             na_l = nal
          ENDIF
          DO rlistok1
       ENDDO
       DO rlistok2
       ?
    ENDDO
    ?
    ? '* * * * * * * * * * * * * * * * * * * * * * * * * * '
    ?
    ? ' В С Е Г О  по ', bri_a, ' УЧАСТКУ '
    ?
    ? '     H а ч и с л е н о =', nav_a
    ?
    ? '             У д е р ж а н о -', udv_a
    ?
    ?
    ? '        К выдаче ===> ', svv_a
    ?
    ? '          Д О Л Г -------> ', sdv_a
    ?
    ?
    ?
 ENDDO
 ?
 ? '***************************************************'
 ?
 ? ' В С Е Г О  по  машиногpамме :'
 ?
 ? '          H а ч и с л е н о = ', nav_b
 ?
 ? '             У д е р ж а н о -', udv_b
 ?
 ?
 ? '       К выдаче ===> ', svv_b
 ?
 ? '         Д О Л Г --------> ', sdv_b
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
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' РАСЧЕТНЫЕ  ЛИСТКИ  по  УЧАСТКАМ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND rlist2.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE kwitpere
 DO prindisp
 SET TALK OFF
 SET SAFETY OFF
 CLEAR
 CLOSE ALL
 HIDE POPUP ALL
 SET TALK OFF
 SET SAFETY OFF
 SET PRINTER OFF
 USE zaw
 COPY TO zaw1 STRUCTURE
 SELECT 1
 USE zaw1
 ZAP
 SELECT 2
 USE zaw2
 ZAP
 SELECT 3
 USE zaw
 SELECT 2
 CLEAR
 @ 7, 7 SAY ' Hабирайте  Таб. номеpа '
 @ 8, 7 SAY ' котоpые  надо  пеpепечатать ---> '
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
 CLEAR
 @ 10, 10 SAY ' Индексируется  массив  ZAW  по  Таб.N*  и  виду  оплат ...'
 INDEX ON tan+bid TO zaw1
 CLEAR
 SELECT 2
 @ 9, 18 SAY ' Идет  выбоpка  ТАБ. N  для  пеpепечатки ... '
 GOTO TOP
 tan_t = '0000'
 DO WHILE  .NOT. EOF()
    tan_t = gad
    STORE ' ' TO p_a, br_a, k_a, t_a, s_a, n_a, b_a
    STORE 0 TO sm_a, dn_i, cha_s
    me_s = '  '
    ba_a = ' '
    l_a = ' '
    f_a = ' '
    SELECT 3
    SEEK tan_t
    DO WHILE tan=tan_t
       p_a = pas
       br_a = bri
       k_a = kat
       t_a = tan
       s_a = sen
       n_a = nal
       b_a = bid
       sm_a = smm
       dn_i = dni
       cha_s = chas
       ba_a = ban
       me_s = mes
       l_a = lic
       f_a = fio
       tari_f = tarif
       dat_oper = dataoper
       SELECT 1
       APPEND BLANK
       REPLACE pas WITH p_a, bri WITH br_a, kat WITH k_a, tan WITH t_a, dni WITH dn_i
       REPLACE sen WITH s_a, nal WITH n_a, bid WITH b_a, smm WITH sm_a, chas WITH cha_s
       REPLACE ban WITH ba_a, lic WITH l_a, fio WITH f_a, mes WITH me_s
       REPLACE tarif WITH tari_f
       REPLACE dataoper WITH dat_oper
       SELECT 3
       SKIP
    ENDDO
    SELECT 2
    SKIP
 ENDDO
 CLOSE ALL
 CLEAR
 @ 9, 20 SAY ' ИДЕТ  ПОДГОТОВКА  к  ПЕЧАТИ ...'
 SELECT 3
 USE znal ALIAS zn1
 INDEX ON tan TO znal2
 SET INDEX TO znal2
 SELECT 2
 USE svoud ALIAS d2
 INDEX ON bid TO svoud
 SET INDEX TO svoud
 SELECT 1
 USE zaw1
 INDEX ON tan+bid TO zaw1
 SET RELATION TO bid INTO d2
 SET RELATION TO tan INTO zn1 ADDITIVE
 GOTO TOP
 STORE 0 TO nl_a, nav_a, udv_a, svv_a, sdv_a, sov_a, ssv_a
 STORE 0 TO nav_b, udv_b, svv_b, ssv_b, sdv_b, sov_b
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ELSE
    SET ALTERNATE TO rlist3.txt
    SET ALTERNATE ON
 ENDIF
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 sto_p = 0
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    bri_a = bri
    tan_a = tan
    c_o = co
    nl_a = nl_a+1
    STORE 0 TO bid_a, nat_a, udt_a, smt_a, sot_a, sst_a
    STORE 0 TO s_sr, s_pn
    odin_ras = 0
    DO WHILE tan=tan_a .AND. ( .NOT. EOF())
       IF bid_a=0
          na_l = nal
       ENDIF
       DO rlistok1
    ENDDO
    DO rlistok2
    ?
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
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' ПЕРЕДЕЛКА  РАСЧЕТНЫХ  ЛИСТКОВ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND rlist3.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE dobaw
 APPEND BLANK
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
PROCEDURE rlistok1
 IF bid_a=0
    ?
    ? '= = = = = = = = = = = = = = = = = = = = = = = = = = = = = : : = = = = = = = = = = = = = = = = = = = = = = = = = = = = ='
    ? nl_a
    ? '   Лиц/сч.  ', fio
    dlin_a = LEN(fio)
    IF dlin_a<40
       ?? '               '
    ENDIF
    ?? '           Расч/лист  ', fio
    ? or__g, me__s, '     Таб.N*', tan, '                 ', or__g, '', me__s, '     Таб.N*', tan
    IF c_o='1'
       ? ' Оклад ', STR(tarif, 8, _k), 'pуб.    Уч.', bri, '   Кат.', kat, '                     Оклад', STR(tarif, 8, _k), 'pуб.      Уч.', bri, '   Кат.', kat
    ELSE
       ? ' Таpиф ', STR(tarif, 8, _k), 'pуб.    Уч.', bri, '   Кат.', kat, '                     Таpиф', STR(tarif, 8, _k), 'pуб.      Уч.', bri, '   Кат.', kat
    ENDIF
    ? '----- Профсоюз=', profz, '---------- Сев=', sen, '----------- Шнп=', nal, '-- : : ----- Профсоюз=', profz, '---------- Сев=', sen, '----------- Шнп=', nal, '--'
    ? 'Мес:Пач:  Вид оплат      : Hачислено: Дни :Часы :Удержано : : Мес:Пач: Вид оплат       : Hачислено: Дни :Часы :Удержано'
    ? '--------------------------------------------------------- : : ---------------------------------------------------------'
    bid_a = 1
 ENDIF
 IF bid>' ' .AND. bid<'80'
    IF bid='79' .AND. odin_ras=0
       ? SPACE(11), 'Начислено :', STR(nat_a, 12, 2), '*'
       ?? SPACE(35), 'Начислено :', STR(nat_a, 12, 2), '*'
       odin_ras = 1
    ENDIF
    bid_dni = SPACE(4)
    bid_chas = SPACE(5)
    IF dni<>0
       bid_dni = STR(dni, 4, 1)
    ENDIF
    IF chas<>0
       bid_chas = STR(chas, 5, 1)
    ENDIF
    ? mes, pas, bid, d2.nou, STR(smm, 10, 2), '', bid_dni, bid_chas, SPACE(13)
    ?? mes, pas, bid, d2.nou, STR(smm, 10, 2), '', bid_dni, bid_chas
    STORE nat_a+smm TO nat_a
    STORE nav_a+smm TO nav_a
    STORE nav_b+smm TO nav_b
 ENDIF
 IF bid>'79'
    IF bid<'82' .AND. dataoper<>{}
       dat_oper = ' выд. '+DTOC(dataoper)+'г.'
    ELSE
       dat_oper = SPACE(16)
    ENDIF
    ? mes, pas, bid, d2.nou, dat_oper, SPACE(2), STR(smm, 10, 2), SPACE(5)
    ?? mes, pas, bid, d2.nou, dat_oper, SPACE(2), STR(smm, 10, 2)
    STORE udt_a+smm TO udt_a
    STORE udv_a+smm TO udv_a
    STORE udv_b+smm TO udv_b
 ENDIF
 SKIP
 RETURN
*
PROCEDURE rlistok2
 ?
 ? SPACE(15), 'Итого :', STR(nat_a, 12, 2), SPACE(6), STR(udt_a, 12, 2)
 ?? SPACE(21), 'Итого :', STR(nat_a, 12, 2), SPACE(6), STR(udt_a, 12, 2)
 STORE nat_a-udt_a TO smt_a
 IF smt_a>0
    ? SPACE(21), 'К выдаче -->', STR(smt_a, 12, 2), '*'
    ?? SPACE(34), 'К выдаче -->', STR(smt_a, 12, 2), '*'
    STORE svv_a+smt_a TO svv_a
    STORE svv_b+smt_a TO svv_b
 ENDIF
 IF smt_a<0
    ? SPACE(24), 'Д о л г ', STR(smt_a, 12, 2)
    ?? SPACE(40), 'Д о л г ', STR(smt_a, 12, 2)
    STORE sdv_a+smt_a TO sdv_a
    STORE sdv_b+smt_a TO sdv_b
 ENDIF
 t_1 = tan_a
 SELECT 3
 SEEK t_1
 STORE 0 TO o_s, n_n, u_n, s_sr
 IF FOUND()
    DO WHILE tan=tan_a .AND.  .NOT. EOF()
       o_s = o_s+vsgd+sn
       n_n = n_n+sumv
       IF mes<mes_t
          u_n = u_n+un
       ENDIF
       IF mes=mes_t
          s_sr = sred
       ENDIF
       SKIP
    ENDDO
 ENDIF
 SELECT 1
 ? ' Средний =', STR(s_sr, 12, 2), SPACE(39)
 ?? 'Средний =', STR(s_sr, 12, 2)
 ? ' Доход с нач.года для подоходного', SPACE(2), STR(o_s, 12, _k), SPACE(13)
 ?? 'Доход с нач.года для подоходного', SPACE(2), STR(o_s, 12, _k)
 IF na_l='9'
    ? ' Освобожден  от  подоходного  налога', SPACE(26)
    ?? 'Освобожден  от  подоходного  налога'
 ELSE
    ? ' из него  вычеты  -                 ', STR(n_n, 12, _k), SPACE(13)
    ?? 'из него  вычеты  -                 ', STR(n_n, 12, _k)
 ENDIF
 ? ' Удержано подоходного ранее   ', SPACE(5), STR(u_n, 12, _k), SPACE(13)
 ?? 'Удержано подоходного ранее   ', SPACE(5), STR(u_n, 12, _k)
 ?
 RETURN
*
PROCEDURE prindisp
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 1 SAY PADC(' КУДА БУДЕМ  ВЫВОДИТЬ  РАСЧЕТНЫЕ ЛИСТКИ ? ', 80)
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
    WAIT '        Вставьте  бумагу  шириной  32 см.  и  нажмите  Enter ===> '
 ENDIF
 RETURN
*
