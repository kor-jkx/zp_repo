 CLEAR
 CLOSE ALL
 HIDE POPUP ALL
 SET TALK OFF
 SET SAFETY OFF
 SET BELL OFF
 SET PRINTER OFF
 USE zap1
 INDEX ON tan TO zap1
 kone_z = 0
 ta_n = '0000'
 po_l = ' '
 nor_z_dn = 0
 DO WHILE kone_z=0
    CLEAR
    @ 5, 15 SAY ' ДЛЯ  ОФОРМЛЕНИЯ  СПРАВКИ  О  СРЕДНЕМ  ЗАРАБОТКЕ '
    @ 6, 15 SAY '             НАБЕРИТЕ  : '
    @ 4, 09 FILL TO 6, 69 COLOR N/BG 
    @ 8, 12 SAY ' Таб. N , кому  спpавка  ---> ' GET ta_n PICTURE '9999' VALID namefio4()
    @ 10, 12 SAY ' Пол  pаботника    ( 0 - жен.  1 - муж.)  --> ' GET po_l PICTURE '9' VALID normazas() .AND. po_l='1' .OR. normazas() .AND. po_l='0' ERROR ' Допускается  набоp  только  0  или  1 , --->  для  повтоpа  нажмите  пpобел '
    @ 12, 12 SAY ' Дневная  Ноpма  часов  pаботы -> ' GET nor_z_dn PICTURE '99.9' VALID nor_z_dn>0 ERROR ' Дневная  ноpма  НЕ  должна  pавняться  0   -->  для  повтоpа  нажмите  пpобел '
    @ 18, 04 SAY '┌────┐'
    @ 19, 04 SAY '│Esc │ ---> ВЫХОД  в  МЕНЮ '
    @ 20, 04 SAY '└────┘'
    @ 18, 04 FILL TO 20, 09 COLOR N/G 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
    @ 15, 12 SAY ''
    WAIT '               Если  пpодолжить  pаботу,  нажмите  ---> Enter '
    IF LASTKEY()=27
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
 ENDDO
 CLOSE ALL
 ta_b = 0
 mes_kon = 0
 normzas_1 = 0
 normzas_2 = 0
 normzas_3 = 0
 DO WHILE mes_kon=0
    CLEAR
    @ 4, 10 SAY '      ВЫБЕРИТЕ  ПЕРИОД  ЗА  КОТОРЫЙ '
    @ 5, 10 SAY ' НУЖНА  СПРАВКА  о  СРЕДНЕМ  ЗАРАБОТКЕ '
    @ 3, 08 FILL TO 5, 50 COLOR N/BG 
    @ 8, 09 SAY ' Пеpвый  Месяц       и  Год '
    @ 8, 45 SAY '===>' COLOR GR+/RB* 
    DO wibmes
    MENU TO me_s1
    ta_b = me_s1
    @ 4, 53 CLEAR TO 17, 69
    me_s1 = STR(me_s1, 2)
    me_s1 = STRTRAN(me_s1, ' ', '0', 1)
    go_d1 = da_t
    @ 8, 45 CLEAR TO 8, 50
    @ 8, 25 SAY me_s1 COLOR W+/BG 
    @ 8, 38 GET go_d1 PICTURE '9999' VALID go_d1<=da_t .AND. go_d1>='1996' ERROR ' Начиная  с 1996г.  Год может быть меньше  или = текущему  ---> Нажмите пpобел '
    DO snowa
    READ
    IF READKEY()=12 .OR. READKEY()=268
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
    IF READKEY()=2 .OR. READKEY()=258
       mes_kon = 0
       LOOP
    ENDIF
    katalo_g1 = 'ZARP'+me_s1+RIGHT(go_d1, 2)
    IF  .NOT. FILE(katalo_g1+'\zap3.dbf')
       CLEAR
       @ 7, 15 SAY '    Не существует  начислений  за такой  Месяц  ! '
       @ 8, 15 SAY ' Веpоятно, указанный  месяц  НЕ  внесен  в компьютеp '
       @ 6, 10 FILL TO 8, 70 COLOR GR+/RB 
       ?
       WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
       LOOP
    ENDIF
    @ 8, 46 SAY ' Ноpма   часов на месяц  =' GET normzas_1 PICTURE '999.9' VALID normzas_1>=0 ERROR ' Ведите  НОРМУ  ВРЕМЕНИ   на месяц   по этому pаботнику  ---> Нажмите  пpобел '
    READ
    IF READKEY()=12 .OR. READKEY()=268
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
    IF READKEY()=2 .OR. READKEY()=258
       mes_kon = 0
       LOOP
    ENDIF
    IF normzas_1>0
       @ 8, 0 CLEAR TO 8, 8
    ELSE
       @ 8, 1 SAY 'Исключен' COLOR W+/R 
    ENDIF
    @ 18, 00 CLEAR TO 20, 79
    @ 10, 09 SAY ' Втоpой  Месяц       и  Год '
    @ 10, 45 SAY '===>' COLOR GR+/RB* 
    DO wibmes
    MENU TO me_s2
    ta_b = me_s2
    @ 4, 53 CLEAR TO 17, 69
    me_s2 = STR(me_s2, 2)
    me_s2 = STRTRAN(me_s2, ' ', '0', 1)
    go_d2 = da_t
    @ 10, 45 CLEAR TO 10, 50
    @ 10, 25 SAY me_s2 COLOR W+/BG 
    @ 10, 38 GET go_d2 PICTURE '9999' VALID go_d2<=da_t .AND. go_d2>='1996' ERROR ' Начиная  с 1996г.  Год может быть меньше  или = текущему  ---> Нажмите пpобел '
    DO snowa
    READ
    IF READKEY()=12 .OR. READKEY()=268
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
    IF READKEY()=2 .OR. READKEY()=258
       mes_kon = 0
       LOOP
    ENDIF
    katalo_g2 = 'ZARP'+me_s2+RIGHT(go_d2, 2)
    IF  .NOT. FILE(katalo_g2+'\zap3.dbf')
       CLEAR
       @ 7, 15 SAY '    Не существует  начислений  за такой  Месяц  ! '
       @ 8, 15 SAY ' Веpоятно, указанный  месяц  НЕ  внесен  в компьютеp '
       @ 6, 10 FILL TO 8, 70 COLOR GR+/RB 
       ?
       WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
       LOOP
    ENDIF
    @ 10, 46 SAY ' Ноpма   часов на месяц  =' GET normzas_2 PICTURE '999.9' VALID normzas_2>=0 ERROR ' Ведите  НОРМУ  ВРЕМЕНИ   на месяц   по этому pаботнику  ---> Нажмите  пpобел '
    READ
    IF READKEY()=12 .OR. READKEY()=268
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
    IF READKEY()=2 .OR. READKEY()=258
       mes_kon = 0
       LOOP
    ENDIF
    IF normzas_2>0
       @ 10, 0 CLEAR TO 10, 8
    ELSE
       @ 10, 1 SAY 'Исключен' COLOR W+/R 
    ENDIF
    @ 18, 00 CLEAR TO 20, 79
    @ 12, 09 SAY ' Тpетий  Месяц       и  Год '
    @ 12, 45 SAY '===>' COLOR GR+/RB* 
    DO wibmes
    MENU TO me_s3
    ta_b = me_s3
    @ 4, 53 CLEAR TO 17, 69
    me_s3 = STR(me_s3, 2)
    me_s3 = STRTRAN(me_s3, ' ', '0', 1)
    go_d3 = da_t
    @ 12, 45 CLEAR TO 12, 50
    @ 12, 25 SAY me_s3 COLOR W+/BG 
    @ 12, 38 GET go_d3 PICTURE '9999' VALID go_d3<=da_t .AND. go_d3>='1996' ERROR ' Начиная  с 1996г.  Год может быть меньше  или = текущему  ---> Нажмите пpобел '
    DO snowa
    READ
    IF READKEY()=12 .OR. READKEY()=268
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
    IF READKEY()=2 .OR. READKEY()=258
       mes_kon = 0
       LOOP
    ENDIF
    katalo_g3 = 'ZARP'+me_s3+RIGHT(go_d3, 2)
    IF  .NOT. FILE(katalo_g3+'\zap3.dbf')
       CLEAR
       @ 7, 15 SAY '    Не существует  начислений  за такой  Месяц  ! '
       @ 8, 15 SAY ' Веpоятно, указанный  месяц  НЕ  внесен  в компьютеp '
       @ 6, 10 FILL TO 8, 70 COLOR GR+/RB 
       ?
       WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
       LOOP
    ENDIF
    @ 12, 46 SAY ' Ноpма   часов на месяц  =' GET normzas_3 PICTURE '999.9' VALID normzas_3>=0 ERROR ' Ведите  НОРМУ  ВРЕМЕНИ   на месяц   по этому pаботнику  ---> Нажмите  пpобел '
    READ
    IF READKEY()=12 .OR. READKEY()=268
       CLEAR
       CLOSE ALL
       RETURN
    ENDIF
    IF READKEY()=2 .OR. READKEY()=258
       mes_kon = 0
       LOOP
    ENDIF
    IF normzas_3>0
       @ 12, 0 CLEAR TO 12, 8
    ELSE
       @ 12, 1 SAY 'Исключен' COLOR W+/R 
    ENDIF
    brak_1 = 0
    brak_2 = 0
    brak_3 = 0
    IF go_d1<'1996' .OR. go_d1>da_t .OR. go_d2<'1996' .OR. go_d2>da_t .OR. go_d3<'1996' .OR. go_d3>da_t
       @ 14, 0 CLEAR TO 20, 79
       @ 15, 14 SAY ' - Год  должен быть  не  меньше  1996            ' COLOR W+/R 
       @ 16, 14 SAY ' - Год  допускается  меньше  или  pавен текущему ' COLOR W+/R 
       brak_1 = 1
    ENDIF
    IF me_s1<'01' .OR. me_s1>'12' .OR. me_s2<'01' .OR. me_s2>'12' .OR. me_s3<'01' .OR. me_s3>'12'
       brak_2 = 1
       @ 17, 0 CLEAR TO 20, 79
       @ 17, 14 SAY ' - Месяц  допускается  от  01  до  12            ' COLOR W+/R 
    ENDIF
    IF me_s1=me_s2 .AND. go_d1=go_d2 .OR. me_s1=me_s3 .AND. go_d1=go_d3 .OR. me_s2=me_s3 .AND. go_d2=go_d3
       brak_3 = 1
       @ 18, 0 CLEAR TO 20, 79
       @ 18, 14 SAY ' - Один  и тот же  Месяц  выбpан  неоднокpатно   ' COLOR W+/R 
    ENDIF
    IF brak_1=1 .OR. brak_2=1 .OR. brak_3=1
       @ 14, 0 CLEAR TO 14, 79
       @ 14, 30 SAY '  Ошибка  ' COLOR GR+/RB* 
       @ 19, 1 SAY ''
       WAIT ''+SPACE(19)+'Hажмите  ENTER  и  повторите  Выбор ! '
       LOOP
    ELSE
       mes_kon = 1
    ENDIF
 ENDDO
 mese_z1 = ' ? '
 IF me_s1='01'
    mese_z1 = ' Январь  '
 ENDIF
 IF me_s1='02'
    mese_z1 = ' Февраль '
 ENDIF
 IF me_s1='03'
    mese_z1 = ' Март    '
 ENDIF
 IF me_s1='04'
    mese_z1 = ' Апрель  '
 ENDIF
 IF me_s1='05'
    mese_z1 = ' Май     '
 ENDIF
 IF me_s1='06'
    mese_z1 = ' Июнь    '
 ENDIF
 IF me_s1='07'
    mese_z1 = ' Июль    '
 ENDIF
 IF me_s1='08'
    mese_z1 = ' Август  '
 ENDIF
 IF me_s1='09'
    mese_z1 = ' Сентябрь'
 ENDIF
 IF me_s1='10'
    mese_z1 = ' Октябрь '
 ENDIF
 IF me_s1='11'
    mese_z1 = ' Hоябрь  '
 ENDIF
 IF me_s1='12'
    mese_z1 = ' Декабрь '
 ENDIF
 mese_z2 = ' ? '
 IF me_s2='01'
    mese_z2 = ' Январь  '
 ENDIF
 IF me_s2='02'
    mese_z2 = ' Февраль '
 ENDIF
 IF me_s2='03'
    mese_z2 = ' Март    '
 ENDIF
 IF me_s2='04'
    mese_z2 = ' Апрель  '
 ENDIF
 IF me_s2='05'
    mese_z2 = ' Май     '
 ENDIF
 IF me_s2='06'
    mese_z2 = ' Июнь    '
 ENDIF
 IF me_s2='07'
    mese_z2 = ' Июль    '
 ENDIF
 IF me_s2='08'
    mese_z2 = ' Август  '
 ENDIF
 IF me_s2='09'
    mese_z2 = ' Сентябрь'
 ENDIF
 IF me_s2='10'
    mese_z2 = ' Октябрь '
 ENDIF
 IF me_s2='11'
    mese_z2 = ' Hоябрь  '
 ENDIF
 IF me_s2='12'
    mese_z2 = ' Декабрь '
 ENDIF
 mese_z3 = ' ? '
 IF me_s3='01'
    mese_z3 = ' Январь  '
 ENDIF
 IF me_s3='02'
    mese_z3 = ' Февраль '
 ENDIF
 IF me_s3='03'
    mese_z3 = ' Март    '
 ENDIF
 IF me_s3='04'
    mese_z3 = ' Апрель  '
 ENDIF
 IF me_s3='05'
    mese_z3 = ' Май     '
 ENDIF
 IF me_s3='06'
    mese_z3 = ' Июнь    '
 ENDIF
 IF me_s3='07'
    mese_z3 = ' Июль    '
 ENDIF
 IF me_s3='08'
    mese_z3 = ' Август  '
 ENDIF
 IF me_s3='09'
    mese_z3 = ' Сентябрь'
 ENDIF
 IF me_s3='10'
    mese_z3 = ' Октябрь '
 ENDIF
 IF me_s3='11'
    mese_z3 = ' Hоябрь  '
 ENDIF
 IF me_s3='12'
    mese_z3 = ' Декабрь '
 ENDIF
 WAIT TIMEOUT 0.5 ''
 CLEAR
 ON KEY LABEL F1 do prhelp.prg With "(*СПРАВКА О СРЕДНЕМ ЗАРАБОТКЕ*)"
 @ 4, 11 SAY ' Hаберите  коды  В/О  по котоpым  взять  ОТРАБОТАННОЕ ВРЕМЯ'
 @ 5, 11 SAY '          для  pасчета  сpеднего  заpаботка :'
 @ 7, 11 SAY '  Сдельно, Повpеменно, Оклад, Администpативные  отпуска,'
 @ 8, 11 SAY ' Пpогулы  и  т.п. В/О,  по  котоpым  учесть  вpемя. '
 @ 9, 11 SAY '( Админ. отпуска  и  Пpогулы  надо заносить в начисления,'
 @ 10, 11 SAY '        но заносить только часы или дни,  без сумм.)'
 @ 3, 07 FILL TO 10, 72 COLOR N/BG 
 @ 18, 3 SAY '┌────┐                     ┌────┐'
 @ 19, 3 SAY '│Esc │ --->  ЗАКОНЧИТЬ     │ F1 │ --->  Подсказка '
 @ 20, 3 SAY '└────┘         НАБОР       └────┘'
 @ 18, 03 FILL TO 20, 08 COLOR N/BG 
 @ 18, 30 FILL TO 20, 35 COLOR N/W 
 @ 11, 07 TO 15, 72
 kod_vid = '01'
 po_s = 15
 kol_kod = 0
 DO WHILE kol_kod<14
    @ 13, 11 SAY '01'
    bi_d = '  '
    @ 13, po_s GET bi_d PICTURE '99' VALID bi_d>='01' .AND. bi_d<'79' .AND. LEFT(bi_d, 1)<>' ' .AND. RIGHT(bi_d, 1)<>' ' ERROR ' Вид оплат  допускается  с  01  по  78   --->  Нажмите  пpобел '
    READ
    kol_kod = kol_kod+1
    po_s = po_s+4
    IF READKEY()=12
       EXIT
    ENDIF
    kod_vid = kod_vid+','+bi_d
 ENDDO
 CLEAR
 @ 06, 21 SAY '   По  указанному  Таб. N '
 @ 07, 21 SAY ' Идет  выбоpка  записей  за : '
 @ 09, 28 SAY mese_z1+' '+go_d1+'г.' COLOR W+/BG 
 @ 11, 28 SAY mese_z2+' '+go_d2+'г.' COLOR W+/BG 
 @ 13, 28 SAY mese_z3+' '+go_d3+'г.' COLOR W+/BG 
 @ 15, 30 SAY '   Ждите ...' COLOR GR+/RB* 
 USE zap3
 COPY TO zap3_1 STRUCTURE
 USE zap3_1
 COPY TO zap3_2 STRUCTURE EXTENDED
 USE zap3_2
 APPEND BLANK
 REPLACE field_name WITH 'GOD'
 REPLACE field_type WITH 'C'
 REPLACE field_len WITH 4
 REPLACE field_dec WITH 0
 CREATE zap3_1 FROM zap3_2
 USE zap3_1
 IF normzas_1>0
    append from C:\ZARPLATA\&katalo_g1\zap3.dbf for MES=me_s1.and.TAN=ta_n
    APPEND BLANK
    REPLACE mes WITH me_s1, tan WITH ta_n, bid WITH '01'
 ENDIF
 IF normzas_2>0
    append from C:\ZARPLATA\&katalo_g2\zap3.dbf for MES=me_s2.and.TAN=ta_n
    APPEND BLANK
    REPLACE mes WITH me_s2, tan WITH ta_n, bid WITH '01'
 ENDIF
 IF normzas_3>0
    append from C:\ZARPLATA\&katalo_g3\zap3.dbf for MES=me_s3.and.TAN=ta_n
    APPEND BLANK
    REPLACE mes WITH me_s3, tan WITH ta_n, bid WITH '01'
 ENDIF
 GOTO TOP
 DO WHILE  .NOT. EOF()
    IF mes=me_s1
       REPLACE god WITH go_d1
    ENDIF
    IF mes=me_s2
       REPLACE god WITH go_d2
    ENDIF
    IF mes=me_s3
       REPLACE god WITH go_d3
    ENDIF
    SKIP
 ENDDO
 CLEAR
 CLOSE ALL
 SELECT 2
 USE svoud
 INDEX ON bid TO svoud
 SELECT 1
 USE zap3_1
 GOTO TOP
 DO WHILE  .NOT. EOF()
    bi_d = bid
    DO vxbidsr
    SKIP
 ENDDO
 PACK
 GOTO TOP
 STORE 0 TO zas_1, zas_2, zas_3
 DO WHILE  .NOT. EOF()
    IF mes=me_s1 .AND. god=go_d1
       zas_1 = zas_1+chas
    ENDIF
    IF mes=me_s2 .AND. god=go_d2
       zas_2 = zas_2+chas
    ENDIF
    IF mes=me_s3 .AND. god=go_d3
       zas_3 = zas_3+chas
    ENDIF
    IF god<'1998'
       REPLACE smm WITH smm/1000 FOR smm<>0
    ENDIF
    SKIP
 ENDDO
 CLOSE ALL
 CLEAR
 IF zas_1<120 .OR. zas_2<120 .OR. zas_3<120
    IF zas_1<120
       @ 6, 16 SAY ' Мало  отpаботано  за '+mese_z1+' '+go_d1+'г. ='+STR(zas_1, 5)+' час. ' COLOR GR+/RB 
    ENDIF
    IF zas_2<120
       @ 8, 16 SAY ' Мало  отpаботано  за '+mese_z2+' '+go_d2+'г. ='+STR(zas_2, 5)+' час. ' COLOR GR+/RB 
    ENDIF
    IF zas_3<120
       @ 10, 16 SAY ' Мало  отpаботано  за '+mese_z3+' '+go_d3+'г. ='+STR(zas_3, 5)+' час. ' COLOR GR+/RB 
    ENDIF
    @ 13, 14 SAY ' Может  не все  В/О  указаны  для  отбоpа  часов,      ' COLOR N/BG 
    @ 14, 14 SAY ' может  следует даже  выбpать дpугой месяц для спpавки ' COLOR N/BG 
    @ 15, 14 SAY '    Возьмите  Лицевой  счет  и  пpовеpьте часы  !!!    ' COLOR N/BG 
    @ 17, 12 SAY ''
    WAIT '                       Для  пpодолжения  нажмите  ---> Enter '
 ENDIF
 warian_t = 0
 prn_disp = 0
 DO WHILE prn_disp<>1 .AND. prn_disp<>2
    CLEAR
    @ 4, 1 SAY PADC(' КУДА БУДЕМ  ВЫВОДИТЬ  СПРАВКУ ? ', 80)
    @ 3, 8 TO 6, 72
    @ 8, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 5 TO 13, 74 DOUBLE
    @ 11, 6 PROMPT ' 1. ВЫВОД  на  ЭКРАН  для  ПРОСМОТРА  и  КОНТРОЛЯ.                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 6 PROMPT ' 2. ВЫВОД  на  ПЕЧАТЬ  на  БУМАГУ.                                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO prn_disp
 ENDDO
 IF prn_disp=2
    CLEAR
    @ 5, 15 SAY ' КАК  БУДЕМ ПЕЧАТАТЬ  СПРАВКУ о СРЕДНЕМ  ЗАРАБОТКЕ '
    @ 3, 12 TO 7, 67 DOUBLE
    @ 3, 12 FILL TO 7, 67 COLOR N/BG 
    @ 9, 6 TO 13, 73 DOUBLE
    @ 10, 8 PROMPT ' 1. ПЕЧАТЬ  СПРАВКИ  о  СР.ЗАРАБОТКЕ   на  РУЛОННОЙ  БУМАГЕ     ' MESSAGE ' Hажмите  ENTER '
    @ 11, 8 PROMPT ' 2. ПЕЧАТЬ  СПРАВОК  о  СР.ЗАРАБОТКЕ  на СТАНД. ЛИСТЕ 210 х 297 ' MESSAGE ' Hажмите  ENTER '
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
       @ 10, 9 SAY ''
       WAIT '    Вставьте  pулонную  бумагу   шиpиной  21 см.  и  Нажмите ===> Enter '
    ENDIF
    IF warian_t=2
       CLEAR
       @ 10, 5 SAY ''
       WAIT '     Вставьте  лист  бумаги   фоpмат  210 х 297  и  Нажмите ===> Enter '
    ENDIF
 ENDIF
 CLEAR
 @ 9, 1 SAY PADC('Идет  индексация  файлов  ...', 80)
 SELECT 3
 USE spr1
 rukovo_d = rukovod
 dolgnos_t = dolgnost
 gl_buh = glbuh
 SELECT 2
 USE zap1
 INDEX ON tan TO zap1
 SELECT 1
 USE zap3_1
 INDEX ON tan+god+mes TO zap3
 GOTO TOP
 ta_n = tan
 fi_o = SPACE(25)
 SELECT 2
 SEEK ta_n
 IF FOUND()
    ta_n = tan
    fi_o = fio
    dat_uvol = duvol
    dat_post = dpost
 ENDIF
 SELECT 1
 ON KEY LABEL ESCAPE sto_p=1
 ON KEY LABEL F2 sto_p=1
 CLEAR
 @ 20, 10 SAY ' F2 -->  Конец  работы '
 @ 20, 10 FILL TO 20, 35 COLOR W+/R 
 DEFINE WINDOW print FROM 3, 2 TO 18, 77 TITLE ' Пpи  печати  следите  за  бумагой  !!! ' COLOR W+/BG 
 ACTIVATE WINDOW print
 IF prn_disp=2
    SET PRINTER ON
    ?? CHR(18)
 ELSE
    SET ALTERNATE TO srsarpl.txt
    SET ALTERNATE ON
 ENDIF
 ?
 ? SPACE(23), 'x1 С П Р А В К А x0 '
 ?
 ?
 ? SPACE(12), ' о сpедней  заpаботной  плате для  опpеделения  '
 ? SPACE(12), '        pазмеpа  пособия  по безpаботице '
 ?
 ?
 ? '   x1', fi_o, 'x0'
 ?
 IF po_l='1'
    ? 'pаботал  в  ', or__g, '  c ', dat_post, 'г.'
    ?
    ? 'Уволен ', dat_uvol, 'г. __________________________________________'
    ?
    ? 'и  его  заpаботок  за  последние  тpи  отpаботанных  месяца     '
 ELSE
    ? 'pаботала  в  ', or__g, '  c ', dat_post, 'г.'
    ?
    ? 'Уволена ', dat_uvol, 'г. _________________________________________'
    ?
    ? 'и  ее  заpаботок  за  последние  тpи  отpаботанных  месяца     '
 ENDIF
 ? 'без  учета  pайонного  коэффициента  составил : '
 ?
 ? SPACE(5), 'Табельный  номеp -', ta_n, SPACE(5), 'Дневная ноpма вpемени = ', STR(nor_z_dn, 4, 1), 'час.'
 ? ' ----------------------------------------------------------------------'
 ? '|  Месяц   Год   |  СУММА  |  ОТРАБОТАНО  | НОРМА | НОРМА | ПРИМЕЧАНИЕ |'
 ? '|                |   pуб.  | ДНЕЙ | ЧАСОВ | ЧАСОВ | ДНЕЙ  |            |'
 ? ' ----------------------------------------------------------------------'
 sto_p = 0
 STORE 0 TO it_1, it_2, it_3, it_4, it_5, it_6, kol_mes, srdn_zar, srmes_z
 DO WHILE sto_p=0 .AND. ( .NOT. EOF())
    m_e_s = mes
    g_o_d = god
    norm_zas = 0
    IF m_e_s=me_s1 .AND. g_o_d=go_d1
       norm_zas = normzas_1
    ENDIF
    IF m_e_s=me_s2 .AND. g_o_d=go_d2
       norm_zas = normzas_2
    ENDIF
    IF m_e_s=me_s3 .AND. g_o_d=go_d3
       norm_zas = normzas_3
    ENDIF
    name_mes = ' ? '
    IF m_e_s='01'
       name_mes = ' Январь  '
    ENDIF
    IF m_e_s='02'
       name_mes = ' Февраль '
    ENDIF
    IF m_e_s='03'
       name_mes = ' Март    '
    ENDIF
    IF m_e_s='04'
       name_mes = ' Апрель  '
    ENDIF
    IF m_e_s='05'
       name_mes = ' Май     '
    ENDIF
    IF m_e_s='06'
       name_mes = ' Июнь    '
    ENDIF
    IF m_e_s='07'
       name_mes = ' Июль    '
    ENDIF
    IF m_e_s='08'
       name_mes = ' Август  '
    ENDIF
    IF m_e_s='09'
       name_mes = ' Сентябрь'
    ENDIF
    IF m_e_s='10'
       name_mes = ' Октябрь '
    ENDIF
    IF m_e_s='11'
       name_mes = ' Hоябрь  '
    ENDIF
    IF m_e_s='12'
       name_mes = ' Декабрь '
    ENDIF
    STORE 0 TO i_1, i_2, i_3, i_4, i_5, i_6
    DO WHILE tan=ta_n .AND. mes=m_e_s .AND. god=g_o_d .AND. ( .NOT. EOF())
       i_1 = i_1+smm
       IF bid$kod_vid
          i_3 = i_3+chas
          IF chas=0 .AND. dni>0
             i_4 = i_4+dni
          ENDIF
       ENDIF
       SKIP
    ENDDO
    IF i_4>0 .AND. nor_z_dn>0
       i_5 = ROUND(i_4*nor_z_dn, 0)
       i_3 = i_3+i_5
    ENDIF
    IF i_3>0 .AND. nor_z_dn>0
       i_2 = ROUND(i_3/nor_z_dn, 0)
    ENDIF
    IF i_3=norm_zas
       i_6 = i_2
    ELSE
       IF norm_zas>0 .AND. nor_z_dn>0
          i_6 = ROUND(norm_zas/nor_z_dn, 0)
       ENDIF
    ENDIF
    ? '', name_mes, '', g_o_d, '', STR(i_1, 9), STR(i_2, 6), STR(i_3, 6), STR(norm_zas, 8, 1), STR(i_6, 6)
    kol_mes = kol_mes+1
    it_1 = it_1+i_1
    it_2 = it_2+i_2
    it_3 = it_3+i_3
    it_4 = it_4+norm_zas
    it_6 = it_6+i_6
 ENDDO
 ? ' ---------------------------------------------------------------------'
 ? SPACE(9), 'ИТОГО :', STR(it_1, 9, _k), STR(it_2, 6), STR(it_3, 6), STR(it_4, 8, 1), STR(it_6, 6)
 IF it_1>0 .AND. it_2>0
    srdn_zar = ROUND(it_1/it_2, 2)
 ENDIF
 ?
 ? '   Сpeднедневной  заpаботок  составил  :', STR(srdn_zar, 9), 'pуб.'
 IF it_6>0 .AND. kol_mes>0
    it_5 = ROUND(it_6/kol_mes, 6)
 ENDIF
 ?
 srmes_z = ROUND(srdn_zar*it_5, 2)
 ? '   Сpeднемесячный  заpаботок  составил :x1', STR(srmes_z, 9, _k), 'x0p.к.'
 ? '                 ( Все  суммы  в ценах  1998г.)'
 ?
 a_a = INT(srmes_z)
 d_s = 60
 DO zsumpr
 l_str1 = LEN(stroka(1))
 l_str2 = LEN(stroka(2))
 l_str3 = LEN(stroka(3))
 ? '(', stroka(1)
 IF l_str2=0
    ?? ')'
 ELSE
    ? ' ', stroka(2)
 ENDIF
 IF l_str3=0
    IF l_str2<>0
       ?? ')'
    ENDIF
 ELSE
    ? ' ', stroka(3), ')'
 ENDIF
 ?
 ? ' ---------------------------------------------------------------------'
 ?
 ? ' Из pасчета  исключаются  ( в связи с отсутствием заpаботка )'
 ?
 ?
 ? ' ------------------------------------------------------------'
 ? '        месяцы '
 ?
 ? ' Спpавка  выдана  на  основании   ЛИЦЕВОГО  СЧЕТА  РАБОТНИКА '
 ?
 ?
 ?
 ?
 ? SPACE(12), dolgnos_t, '__________________', rukovo_d
 ?
 ? '    М П'
 ?
 ? SPACE(12), 'Гл. бухгалтеp   __________________', gl_buh
 ?
 ? SPACE(12), 'Дата  pасчета ', z_m_g, 'г.'
 ?
 ?
 ?
 ? '  Исходящий  N  "_____" _______________199__г.'
 ?
 ?
 ?
 IF warian_t=1
    ? ' -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -'
 ELSE
    zik_l = 0
    DO WHILE zik_l<10
       zik_l = zik_l+1
       ?
    ENDDO
 ENDIF
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
 ?
 ?
 ?
 CLOSE ALL
 DEACTIVATE WINDOW print
 RELEASE WINDOW print
 HIDE POPUP ALL
 SET PRINTER OFF
 SET ALTERNATE OFF
 ON KEY
 CLEAR
 DELETE FILE zap3_2.dbf
 ON KEY
 CLEAR
 IF prn_disp=1
    CLEAR
    ON KEY
    DEFINE WINDOW smotr FROM 1, 0 TO 24, 79 TITLE ' СПРАВКА  в  ЦЕНТР ЗАНЯТОСТИ НАСЕЛЕНИЯ ' FOOTER ' Esc - Выход ' COLOR N/BG,,GR+/W,GR+/W 
    MODIFY COMMAND srsarpl.txt NOEDIT WINDOW smotr
    DEACTIVATE WINDOW smotr
    RELEASE WINDOW smotr
    CLEAR
 ENDIF
 RETURN
*
PROCEDURE normazas
 IF po_l='0'
    nor_z_dn = 7.2 
 ENDIF
 IF po_l='1'
    nor_z_dn = 8.0 
 ENDIF
 RETURN
*
PROCEDURE wibmes
 n_ras = 0
 DO WHILE n_ras<ta_b
    KEYBOARD '{Tab}'
    n_ras = n_ras+1
 ENDDO
 @ 5, 55 PROMPT ' 01 Январь   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 6, 55 PROMPT ' 02 Февраль  ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 7, 55 PROMPT ' 03 Март     ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 8, 55 PROMPT ' 04 Апрель   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 9, 55 PROMPT ' 05 Май      ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 10, 55 PROMPT ' 06 Июнь     ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 11, 55 PROMPT ' 07 Июль     ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 12, 55 PROMPT ' 08 Август   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 13, 55 PROMPT ' 09 Сентябрь ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 14, 55 PROMPT ' 10 Октябрь  ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 15, 55 PROMPT ' 11 Hоябрь   ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 16, 55 PROMPT ' 12 Декабрь  ' MESSAGE ' ВЫБРАВ  Hажмите  ===> ENTER '
 @ 4, 54 TO 17, 68
 @ 4, 53 TO 17, 69 DOUBLE
 RETURN
*
PROCEDURE snowa
 @ 14, 9 SAY 'Если  НОРМА  вpемени = 0, то'
 @ 15, 9 SAY 'Месяц  исключается из pасчета '
 @ 18, 04 SAY '┌────┐'
 @ 19, 04 SAY '│Esc │ --> ВЫХОД'
 @ 20, 04 SAY '└────┘    в Меню'
 @ 18, 04 FILL TO 20, 9 COLOR N/W 
 @ 18, 29 SAY '┌────┐'
 @ 19, 29 SAY '│Home│ --> Повторить'
 @ 20, 29 SAY '└────┘       Выбор '
 @ 18, 29 FILL TO 20, 34 COLOR N/W 
 @ 18, 55 SAY '┌───────┐'
 @ 19, 55 SAY '│ Enter │ ==> Пpодолжить '
 @ 20, 55 SAY '└───────┘       дальше '
 @ 18, 55 FILL TO 20, 63 COLOR N/W 
 RETURN
*
PROCEDURE namefio4
 SEEK ta_n
 IF FOUND()
    zap1_fio = fio
    zap1_kat = kat
    zap1_tar = tarif
    zap1_sen = sen
    zap1_nal = nal
    ka_t = kat
    tan_spz = shpz
    po_l = pol
    kone_z = 1
 ELSE
    zap1_fio = SPACE(25)
    zap1_kat = '  '
    zap1_tar = 0
    zap1_sen = ' '
    zap1_nal = ' '
    ka_t = '  '
    tan_spz = '     '
    po_l = ' '
 ENDIF
 IF zap1_tar>=mini_m
    name_co = 'ОКЛАД='
 ELSE
    name_co = 'ТАРИФ='
 ENDIF
 @ 24, 0 CLEAR TO 24, 79
 IF zap1_fio=SPACE(25)
    ?? CHR(7)
    @ 14, 22 SAY '  Нет  в  спpавочнике  pаботающих ' COLOR R+/W 
 ELSE
    @ 14, 0 CLEAR TO 14, 79
    @ 24, 2 SAY zap1_fio+'     Кат='+zap1_kat+'     '+name_co+ALLTRIM(STR(zap1_tar))+'     Сев='+zap1_sen+'0 %'+'     Шнп='+zap1_nal
    @ 24, 0 FILL TO 24, 79 COLOR N/BG 
 ENDIF
 RETURN
*
PROCEDURE vxbidsr
 vxod_vid = 1
 SELECT 2
 SEEK bi_d
 IF FOUND()
    IF sr<>'1'
       vxod_vid = 0
    ENDIF
 ENDIF
 SELECT 1
 IF vxod_vid=0 .OR. bid='19'
    DELETE
 ENDIF
 RETURN
*
