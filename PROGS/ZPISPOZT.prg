 CLEAR
 CLOSE ALL
 HIDE POPUP ALL
 SET TALK OFF
 SET SAFETY OFF
 SET BELL OFF
 SET PRINTER OFF
 SELECT 4
 USE spr1
 rukovo_d = rukovod
 dolgnos_t = dolgnost
 gl_buh = glbuh
 SELECT 3
 USE z4pr
 INDEX ON tan TO z4pr
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 USE poztsbor
 INDEX ON tan TO poztsbor
 DEFINE WINDOW korr FROM 2, 0 TO 17, 79 TITLE ' СПИСОК  на  ПЕРЕЧИСЛЕНИЕ  АЛИМЕНТОВ  ПОЧТОЙ '
 @ 18, 2 SAY ' F1 ' COLOR N/W 
 @ 18, 6 SAY ' - Подсказка ' COLOR BG+/RB 
 @ 20, 2 SAY ' Esc ' COLOR N/W 
 @ 20, 7 SAY ' --->  Выход  ' COLOR W+/R 
 ON KEY LABEL Ctrl-PgUp go top
 ON KEY LABEL Ctrl-PgDn go bottom
 ON KEY LABEL F1 do prhelp.prg With "(*СПИСОК АЛИМЕНТОВ*)"
 BROWSE FIELDS m, mes :H = 'Мес', pas :H = 'Пач', bri :H = 'Уч', tan :H = 'Таб.', bid :H = 'В/О', smmalim :H = 'СУММА АЛИМЕНТОВ', smm :H = 'СУММА ПОЧТ.СБОРА', adres1 :H = 'Куда пеpечисляется' :F NOMENU NOEDIT WINDOW korr WHEN namefio5() COLOR SCHEME 10
 DEACTIVATE WINDOW korr
 RELEASE WINDOW korr
 CLEAR
 @ 5, 11 SAY ' КАК  БУДЕМ ПЕЧАТАТЬ  СПИСОК  на ПЕРЕЧИСЛЕНИЕ  АЛИМЕНТОВ '
 @ 3, 09 TO 7, 69 DOUBLE
 @ 3, 09 FILL TO 7, 69 COLOR N/BG 
 @ 9, 6 TO 13, 73 DOUBLE
 @ 10, 8 PROMPT ' 1. ПЕЧАТЬ  СПИСКА  АЛИМЕНЬЩИКОВ       на  РУЛОННОЙ  БУМАГЕ     ' MESSAGE ' Hажмите  ENTER '
 @ 11, 8 PROMPT ' 2. ПЕЧАТЬ  СПИСКА  АЛИМЕНЬЩИКОВ      на СТАНД. ЛИСТЕ 210 х 297 ' MESSAGE ' Hажмите  ENTER '
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
 IF warian_t=2
    @ 15, 9 SAY ''
    WAIT '      Вставьте  лист  бумаги   фоpмат  210 х 297  и  Нажмите ===> Enter '
 ENDIF
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 SET PRINTER ON
 ?
 ?? CHR(18)
 ? SPACE(27), 'x1 С П И С О К x0 '
 ?
 ? SPACE(8), ' на  пеpечисление  алиментов  с pаботников ', or__g
 ?
 ? SPACE(27), ' за  ', me__s, 'г.'
 stro_k = 6
 scha_p = 0
 sto_p = 0
 GOTO TOP
 STORE 0 TO n_pp, i_1, i_2, i_3, n_list
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    IF scha_p=0
       scha_p = 1
       n_list = n_list+1
       ? SPACE(57), 'лист - ', ALLTRIM(STR(n_list, 3))
       ? ' -----------------------------------------------------------------------'
       ? '|  N |     К  У  Д  А       |    К О М У     | СУММА  |ПОЧТОВЫЙ|  СУММА |'
       ? '| п/п|                      |                |ПЕРЕВОДА|  СБОР  |  ВСЕГО |'
       ? ' -----------------------------------------------------------------------'
       stro_k = stro_k+5
    ENDIF
    adres_1 = SPACE(22)
    adres_2 = SPACE(22)
    adres_3 = SPACE(22)
    adres_4 = SPACE(22)
    komu_1 = SPACE(15)
    komu_2 = SPACE(15)
    komu_3 = SPACE(15)
    komu_4 = SPACE(15)
    ta_n = tan
    pa_s = pass
    SELECT 3
    SEEK ta_n
    LOCATE REST FOR tan=ta_n .AND. pas=pa_s
    IF FOUND()
       adres_1 = adres1
       adres_2 = adres2
       adres_3 = adres3
       adres_4 = adres4
       komu_1 = komu1
       komu_2 = komu2
       komu_3 = komu3
       komu_4 = komu4
    ENDIF
    SELECT 1
    n_pp = n_pp+1
    ? '', STR(n_pp, 3)+'.', adres_1, komu_1, '', STR(smmalim, 8, _k), STR(smm, 8, _k), STR(smmalim+smm, 8, _k)
    stro_k = stro_k+1
    i_1 = i_1+smmalim
    i_2 = i_2+smm
    i_3 = i_3+(smmalim+smm)
    IF adres_2<>SPACE(22) .OR. komu_2<>SPACE(15)
       ? SPACE(5), adres_2, komu_2
       stro_k = stro_k+1
    ENDIF
    IF adres_3<>SPACE(22) .OR. komu_3<>SPACE(15)
       ? SPACE(5), adres_3, komu_3
       stro_k = stro_k+1
    ENDIF
    IF adres_4<>SPACE(22) .OR. komu_4<>SPACE(15)
       ? SPACE(5), adres_4, komu_4
       stro_k = stro_k+1
    ENDIF
    ?
    stro_k = stro_k+1
    IF stro_k>=60
       zik_l = 0
       DO WHILE zik_l<8
          zik_l = zik_l+1
          ?
       ENDDO
       scha_p = 0
       stro_k = 0
       IF warian_t=2
          WAIT WINDOW ' Вставьте  лист  бумаги   фоpмат  210 х 297  и  Нажмите ===> Enter '
       ENDIF
    ENDIF
    SKIP
 ENDDO
 ? ' -----------------------------------------------------------------------'
 ? SPACE(20), 'ИТОГО :', SPACE(16), STR(i_1, 8, _k), STR(i_2, 8, _k), STR(i_3, 8, _k), '*'
 ? ' -----------------------------------------------------------------------'
 ?
 stro_k = stro_k+4
 a_a = i_3
 d_s = 70
 DO zsumpr
 l_str1 = LEN(stroka(1))
 l_str2 = LEN(stroka(2))
 l_str3 = LEN(stroka(3))
 ? ' (', stroka(1)
 stro_k = stro_k+1
 IF l_str2=0
    ?? ')'
 ELSE
    ? '  ', stroka(2)
    stro_k = stro_k+1
 ENDIF
 IF l_str3=0
    IF l_str2<>0
       ?? ')'
    ENDIF
 ELSE
    ? '  ', stroka(3), ')'
    stro_k = stro_k+1
 ENDIF
 ?
 ?
 ?
 ? SPACE(12), dolgnos_t, '__________________', rukovo_d
 ?
 ?
 ? SPACE(12), 'Гл. бухгалтеp   __________________', gl_buh
 ?
 ?
 ?
 stro_k = stro_k+10
 DO WHILE stro_k<60
    ?
    stro_k = stro_k+1
 ENDDO
 CLOSE ALL
 DELETE FILE z4pr.idx
 DEACTIVATE WINDOW print
 RELEASE WINDOW print
 HIDE POPUP ALL
 SET PRINTER OFF
 ON KEY
 CLEAR
 RETURN
*
PROCEDURE namefio5
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
