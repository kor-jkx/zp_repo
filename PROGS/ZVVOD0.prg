 CLOSE ALL
 SET SAFETY OFF
 SET STATUS ON
 SET BELL OFF
 DEACTIVATE WINDOW ALL
 CLEAR
 DELETE FILE zap1.cdx
 zip_skip = 0
 IF FILE ("&fail_zip")
    zip_skip = 1
    HIDE POPUP ALL
    CLEAR
    @ 5, 13 SAY ' ДАННЫЕ  за  ВЫБРАННЫЙ  МЕСЯЦ  уже  ПЕРЕДАНЫ  в  АРХИВ  '
    @ 4, 10 FILL TO 5, 70 COLOR N/BG 
    @ 10, 1 SAY PADC(' ВВОД  ЗАПРЕЩЕН ! ', 80)
    @ 9, 24 FILL TO 11, 54 COLOR GR+/RB 
    ?
    ?
    ?
    WAIT '                   Для  пpодолжения  нажмите   ---> Enter '
    CLEAR
    RETURN
 ENDIF
 SET COLOR OF FIELDS TO W+/BG
 SET COLOR OF NORMAL TO W+/B
 SET COLOR OF MESSAGE TO N+/W
 SET COLOR OF HIGHLIGHT TO W+/R
 _jdblclick = 3.0 
 SHOW POPUP popwork
 DEFINE POPUP vvod0 FROM 3, 2 SHADOW MARGIN RELATIVE COLOR SCHEME 4
 vvo_d = 0
 DO WHILE vvo_d=0
    sifrov_ka = 0
    use_zap3p = 0
    use_zap4p = 0
    CLEAR
    DEFINE BAR 1 OF vvod0 PROMPT ' 1. ВВОД  МЕСЯЧНЫХ  HАЧИСЛЕHИЙ  з/п   ( файл   zap3.dbf )' SKIP FOR zip_skip=1
    DEFINE BAR 2 OF vvod0 PROMPT ' 2.                 УДЕРЖАHИЙ   з/п   ( файл   zap4.dbf )' SKIP FOR zip_skip=1
    DEFINE BAR 3 OF vvod0 PROMPT ' 3. ВВОД  ПОСТОЯHHЫХ  HАЧИСЛЕHИЙ      ( файл  zap3p.dbf )' SKIP FOR zip_skip=1
    DEFINE BAR 4 OF vvod0 PROMPT ' 4.                   УДЕРЖАHИЙ       ( файл  zap4p.dbf )' SKIP FOR zip_skip=1
    DEFINE BAR 5 OF vvod0 PROMPT ' 5. ВВОД   %  для  РАСЧЕТА HАЧИСЛЕHИЙ ( файл   zap3.dbf )' SKIP FOR zip_skip=1
    DEFINE BAR 6 OF vvod0 PROMPT ' 6.        %  и ЧАСТЕЙ по ИСП.ЛИСТАМ  ( файл   z4pr.dbf )' SKIP FOR zip_skip=1
    DEFINE BAR 7 OF vvod0 PROMPT ' 7. ВВОД сумм  в Увеличение  или  Уменьшение  Облагаемой ' SKIP FOR zip_skip=1
    DEFINE BAR 9 OF vvod0 PROMPT '                    ВЫХОД  -->   Esc ' MESSAGE ' ВЫХОД  в Главное  МЕНЮ '
    ON SELECTION BAR 1 OF vvod0 do nomer1
    ON SELECTION BAR 2 OF vvod0 do nomer2
    ON SELECTION BAR 3 OF vvod0 do nomer3
    ON SELECTION BAR 4 OF vvod0 do nomer4
    ON SELECTION BAR 5 OF vvod0 do nomer5
    ON SELECTION BAR 6 OF vvod0 do nomer6
    ON SELECTION BAR 7 OF vvod0 do nomer7
    ON SELECTION BAR 9 OF vvod0 do nomer9
    ACTIVATE POPUP vvod0
    IF LASTKEY()=27
       DO nomer9
    ENDIF
 ENDDO
 RETURN
*
PROCEDURE nomer9
 vvo_d = 1
 CLOSE ALL
 CLEAR
 ON KEY
 DEACTIVATE POPUP vvod0
 SHOW POPUP popwork
 ON KEY
 RETURN
*
PROCEDURE nomer3
 use_zap3p = 1
 DO nomer1
 RETURN
*
PROCEDURE nomer4
 use_zap4p = 1
 DO nomer2
 RETURN
*
PROCEDURE nomer1
 HIDE POPUP ALL
 SET BELL OFF
 SET SAFETY OFF
 CLEAR
 CLOSE ALL
 bri_n = '00'
 bri_k = '99'
 SELECT 4
 USE svoud
 SET FILTER TO bid<='79'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    @ 3, 3 SAY ''
    TEXT
                Как  будем  заносить  НАЧИСЛЕНИЯ  по ЗАРПЛАТЕ
            По конкpетному  Участку  или  в целом  по Пpедпpиятию ?
            Соответственно  будет  откpыт  Спpавочник pаботающих.
    ENDTEXT
    @ 3, 10 TO 7, 70
    @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 11, 5 TO 15, 74 DOUBLE
    @ 12, 6 PROMPT ' 1. Откpыть  ВЕСЬ  СПРАВОЧНИК  РАБОТАЮЩИХ  по ВСЕМУ  ПРЕДПРИЯТИЮ    ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 2. Откpыть  СПРАВОЧНИК  РАБОТАЮЩИХ  по опpеделенным  Участкам      ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO spra_w
    IF spra_w<>1 .AND. spra_w<>2
       CLOSE ALL
       CLEAR
       SHOW POPUP vvod0, popwork
       RETURN
    ENDIF
    DO intanfio
    @ 17, 04 SAY ' --------------------------------------------'
    @ 18, 04 SAY '┌────┐                              ┌────────┐'
    @ 19, 04 SAY '│Esc │ ---> Повторить  Выбор        │ ENTER  │ ===> Идем далее'
    @ 20, 04 SAY '└────┘                              └────────┘'
    @ 18, 04 FILL TO 20, 09 COLOR N/G 
    @ 18, 40 FILL TO 20, 49 COLOR N/BG 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ELSE
       kone_z = 1
    ENDIF
 ENDDO
 SELECT 1
 IF use_zap3p=0
    USE zap3
 ENDIF
 IF use_zap3p=1
    USE zap3p
 ENDIF
 DO udalnet
 CLEAR
 TEXT

┌───┬───┬─────┬──────┬───┬───┬──────────┬────────────┬──────┬───────┬─────┬───┐
│Мес│Пач│Участ│  Таб │Кат│Вид│  СУММА   │    ФАКТ    │ Ш П З│ ТАРИФ-│НОРМА│ % │
│   │док│     │  ном │   │опл│          │ ДНИ │ ЧАСЫ │      │ ОКЛАД │ ЧАС │   │
└───┴───┴─────┴──────┴───┴───┴──────────┴────────────┴──────┴───────┴─────┴───┘











 ══════════════════════════════════════════════════════════════════════════════
  ┌────┐ Шифровка  данных :           ┌────┐  Смена            ┌────┐
  │ F1 │ ( Таб.N, Кат., Уч., В/О )    │Home│ Месяца, Пачки     │Esc │ ==> ВЫХОД
  └────┘ Подсчет  Сумм по Пачке.      └────┘ Участка           └────┘
 ENDTEXT
 IF use_zap3p=0
    @ 1, 04 SAY 'Ввод  ЕЖЕМЕСЯЧНЫХ  Начислений !    Номеpа  пачек  с  001  по  170 '
 ENDIF
 IF use_zap3p=1
    @ 1, 04 SAY 'Ввод  ПОСТОЯННЫХ  Начислений !    Номеpа  пачек  со  171  по  199 '
 ENDIF
 @ 1, 02 FILL TO 1, 70 COLOR GR+/RB 
 @ 18, 02 FILL TO 20, 07 COLOR N/G 
 @ 18, 38 FILL TO 20, 43 COLOR N/G 
 @ 18, 63 FILL TO 20, 68 COLOR N/BG 
 stro_k = 7
 STORE 0 TO sa_p, osibk_a, nazal_o
 STORE 0 TO sm_m, dn_i, cha_s, tari_f, norm_z, ku_s
 me_s = mes_t
 pa_s = '   '
 br_i = '  '
 ka_t = '  '
 ta_n = '    '
 bi_d = '  '
 shp_z = '     '
 DO WHILE .T.
    ON KEY
    sif_r = 0
    SET COLOR TO
    SET COLOR OF FIELDS TO N/W
    SET COLOR OF NORMAL TO W+/B
    SET COLOR OF MESSAGE TO N+/W
    SET COLOR OF HIGHLIGHT TO W+/R
    IF sa_p=10
       @ 6, 0 CLEAR TO 16, 79
       stro_k = 7
       @ 6, 02 SAY mes
       @ 6, 05 SAY pas
       @ 6, 11 SAY bri
       @ 6, 16 SAY tan
       @ 6, 22 SAY kat
       @ 6, 27 SAY bid
       @ 6, 30 SAY smm
       @ 6, 42 SAY dni
       @ 6, 48 SAY chas
       @ 6, 55 SAY shpz
       @ 6, 61 SAY tarif
       @ 6, 69 SAY normz
       @ 6, 75 SAY kus
       sa_p = 0
    ENDIF
    IF READKEY()=36 .OR. READKEY()=292
       sifrov_ka = 0
       DO sifrowka
    ENDIF
    IF sif_r=1
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 2
       DEFINE POPUP fiotan FROM 2, 35 PROMPT FIELDS fio+'  '+tan+'  '+bri+' '+kat TITLE '|      Ф.  И.  О.      | ТАБ.N| Уч|КАТ|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP fiotan do tantan
       ACTIVATE POPUP fiotan
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=2
       nazal_o = 0
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 3
       DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP sprpodr do bribri
       ACTIVATE POPUP sprpodr
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=3
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 4
       DEFINE POPUP widopl FROM 2, 65 PROMPT FIELDS bid+' '+nou TITLE '|Код| Наименование Опл|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP widopl do bidbid
       ACTIVATE POPUP widopl
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=4
       sif_r = 0
       nom_pas = '   '
       sum_pas = 0
       ON KEY LABEL F1 sif_r=0
       DEFINE WINDOW sumpas FROM 10, 40 TO 16, 78 COLOR W+/BG 
       ACTIVATE WINDOW sumpas
       IF use_zap3p=0
          @ 0, 7 SAY 'Набеpите N* пачки ->' GET nom_pas PICTURE '999' VALID nom_pas>='001' .AND. nom_pas<='170' .AND. LEFT(nom_pas, 1)<>' ' .AND. RIGHT(nom_pas, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  001  по  170   --->  Нажмите  пpобел '
       ENDIF
       IF use_zap3p=1
          @ 0, 7 SAY 'Набеpите N* пачки ->' GET nom_pas PICTURE '999' VALID nom_pas>='171' .AND. nom_pas<='199' .AND. LEFT(nom_pas, 1)<>' ' .AND. RIGHT(nom_pas, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  171  по  199   --->  Нажмите  пpобел '
       ENDIF
       READ
       GOTO TOP
       SUM FOR pas=nom_pas smm TO sum_pas
       CLEAR
       @ 0, 7 SAY ' N* пачки ->' GET nom_pas
       @ 2, 1 SAY ' Сумма по Пачке = '+STR(sum_pas, 15)+' *'
       ?
       WAIT 'Для пpодолжения  Нажмите  --> Enter'
       CLEAR
       DEACTIVATE WINDOW sumpas
       ON KEY
    ENDIF
    IF sif_r=5
    ENDIF
    IF nazal_o=0
       @ stro_k, 02 GET me_s PICTURE '99' VALID me_s>='01' .AND. me_s<='12' .AND. me_s<>'1 ' ERROR ' Месяца  допускается  с  01  по  12  --->  Нажмите  пpобел '
       IF use_zap3p=0
          @ stro_k, 05 GET pa_s PICTURE '999' VALID pa_s>='001' .AND. pa_s<='170' .AND. LEFT(pa_s, 1)<>' ' .AND. RIGHT(pa_s, 1)<>' ' .AND. pa_s<>'1  ' .AND. pa_s<>'10 ' ERROR ' Номеp  пачки  допускается  с  001  по  170   --->  Нажмите  пpобел '
       ENDIF
       IF use_zap3p=1
          @ stro_k, 05 GET pa_s PICTURE '999' VALID pa_s>='171' .AND. pa_s<='199' .AND. pa_s<>'1  ' .AND. pa_s<>'10 ' .AND. LEFT(pa_s, 1)<>' ' .AND. RIGHT(pa_s, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  171  по  199   --->  Нажмите  пpобел '
       ENDIF
       @ stro_k, 11 GET br_i PICTURE '99'
       nazal_o = 1
    ENDIF
    @ stro_k, 16 GET ta_n PICTURE '9999' VALID namefio()
    @ stro_k, 22 GET ka_t PICTURE '99'
    @ stro_k, 27 GET bi_d PICTURE '99' VALID bidspz()
    IF da_t<'1998'
       @ stro_k, 30 GET sm_m PICTURE '9999999999'
    ELSE
       @ stro_k, 30 GET sm_m PICTURE '9999999.99'
    ENDIF
    @ stro_k, 42 GET dn_i PICTURE '99.9'
    @ stro_k, 48 GET cha_s PICTURE '999.9'
    @ stro_k, 55 GET shp_z PICTURE '99999'
    IF da_t<'1998'
       @ stro_k, 61 GET tari_f PICTURE '9999999'
    ELSE
       @ stro_k, 61 GET tari_f PICTURE '9999.99'
    ENDIF
    @ stro_k, 69 GET norm_z PICTURE '999.9'
    @ stro_k, 75 GET ku_s PICTURE '999'
    READ
    IF READKEY()=2 .OR. READKEY()=258
       nazal_o = 0
       LOOP
    ENDIF
    ta_n_2 = LEFT(ta_n, 2)
    ta_n_3 = LEFT(ta_n, 3)
    ta_n_2 = RIGHT(ta_n_2, 1)
    ta_n_3 = RIGHT(ta_n_3, 1)
    IF ta_n>'0000' .AND. LEFT(ta_n, 1)<>' ' .AND. ta_n_2<>' ' .AND. ta_n_3<>' ' .AND. RIGHT(ta_n, 1)<>' ' .AND. ka_t>'00' .AND. LEFT(ka_t, 1)<>' ' .AND. RIGHT(ka_t, 1)<>' ' .AND. READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258 .AND. me_s>='01' .AND. me_s<='12' .AND. me_s<>' 1' .AND. me_s<>'1 ' .AND. bi_d>='01' .AND. bi_d<='79' .AND. LEFT(bi_d, 1)<>' ' .AND. RIGHT(bi_d, 1)<>' ' .AND. br_i>='01' .AND. br_i<='99' .AND. LEFT(br_i, 1)<>' ' .AND. RIGHT(br_i, 1)<>' '
       APPEND BLANK
       @ 21, 0 CLEAR TO 21, 79
       REPLACE mes WITH me_s
       REPLACE pas WITH pa_s
       REPLACE bri WITH br_i
       REPLACE tan WITH ta_n
       REPLACE kat WITH ka_t
       REPLACE bid WITH bi_d
       REPLACE smm WITH sm_m, dni WITH dn_i, chas WITH cha_s
       REPLACE normz WITH norm_z
       REPLACE shpz WITH shp_z
       REPLACE tarif WITH tari_f
       REPLACE kus WITH ku_s
       sa_p = sa_p+1
       stro_k = stro_k+1
       osibk_a = 0
       STORE 0 TO sm_m, dn_i, cha_s, tari_f, norm_z, ku_s
       bi_d = '  '
       shp_z = '     '
    ELSE
       osibk_a = 1
       @ 21, 0 CLEAR TO 21, 79
       IF READKEY()=12 .OR. READKEY()=268
          CLEAR
          HIDE POPUP ALL
          CLOSE ALL
          EXIT
       ENDIF
       IF READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258
          IF osibk_a=1
             ?? CHR(7)
          ENDIF
          IF br_i<='00' .OR. br_i>'99' .OR. LEFT(br_i, 1)=' ' .OR. RIGHT(br_i, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 07 SAY ' Ошибка Ном Участка ' COLOR N/BG 
          ENDIF
          IF ka_t<='00' .OR. LEFT(ka_t, 1)=' ' .OR. RIGHT(ka_t, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 29 SAY ' Ошибка Категоpии ' COLOR N/BG 
          ENDIF
          IF ta_n<='0000' .OR. LEFT(ta_n, 1)=' ' .OR. ta_n_2=' ' .OR. ta_n_3=' ' .OR. RIGHT(ta_n, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 49 SAY ' Ошибка  в Таб.N ' COLOR N/BG 
          ENDIF
          IF bi_d<='00' .OR. bi_d>'79' .OR. LEFT(bi_d, 1)=' ' .OR. RIGHT(bi_d, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 67 SAY ' Ошибка В/О ' COLOR N/BG 
          ENDIF
       ENDIF
    ENDIF
    IF osibk_a=0
       @ 21, 0 CLEAR TO 21, 79
    ENDIF
 ENDDO
 CLEAR
 CLOSE ALL
 RELEASE POPUP fiotan
 RELEASE POPUP sprpodr
 RELEASE POPUP widopl
 RELEASE WINDOW sifr
 RELEASE WINDOW sumpas
 SHOW POPUP popwork, vvod0
 ON KEY
 use_zap3p = 0
 RETURN
*
PROCEDURE nomer2
 HIDE POPUP ALL
 SET BELL OFF
 SET SAFETY OFF
 CLEAR
 CLOSE ALL
 bri_n = '00'
 bri_k = '99'
 SELECT 4
 USE svoud
 SET FILTER TO bid>='80'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    @ 3, 3 SAY ''
    TEXT
                Как  будем  заносить  УДЕРЖАНИЯ  по ЗАРПЛАТЕ
            По конкpетному  Участку  или  в целом  по Пpедпpиятию ?
            Соответственно  будет  откpыт  Спpавочник pаботающих.
    ENDTEXT
    @ 3, 10 TO 7, 70
    @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 11, 5 TO 15, 74 DOUBLE
    @ 12, 6 PROMPT ' 1. Откpыть  ВЕСЬ  СПРАВОЧНИК  РАБОТАЮЩИХ  по ВСЕМУ  ПРЕДПРИЯТИЮ    ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 2. Откpыть  СПРАВОЧНИК  РАБОТАЮЩИХ  по опpеделенным  Участкам      ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO spra_w
    IF spra_w<>1 .AND. spra_w<>2
       CLOSE ALL
       CLEAR
       SHOW POPUP vvod0, popwork
       RETURN
    ENDIF
    DO intanfio
    @ 17, 04 SAY ' --------------------------------------------'
    @ 18, 04 SAY '┌────┐                              ┌────────┐'
    @ 19, 04 SAY '│Esc │ ---> Повторить  Выбор        │ ENTER  │ ===> Идем далее'
    @ 20, 04 SAY '└────┘                              └────────┘'
    @ 18, 04 FILL TO 20, 09 COLOR N/G 
    @ 18, 40 FILL TO 20, 49 COLOR N/BG 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ELSE
       kone_z = 1
    ENDIF
 ENDDO
 SELECT 1
 IF use_zap4p=0
    USE zap4
 ENDIF
 IF use_zap4p=1
    USE zap4p
 ENDIF
 DO udalnet
 CLEAR
 TEXT

         ┌───┬───┬──────┬────────┬─────┬──────┬───┬───────────┐
         │Мес│Пач│  N   │  ДАТА  │Учас-│  Таб │Вид│  СУММА    │
         │   │док│Оpдеpа│ОПЕРАЦИИ│ток  │  ном │уд.│           │
         └───┴───┴──────┴────────┴─────┴──────┴───┴───────────┘











 ══════════════════════════════════════════════════════════════════════════════
  ┌────┐ Шифровка  данных :      ┌────┐ Смена    ┌────┐ Пост.   ┌────┐
  │ F1 │ ( Таб.N, Уч., В/У )     │Home│ полей    │ F2 │ ввод    │Esc │ => ВЫХОД
  └────┘ Подсчет Сумм по Пачке.  └────┘ слева    └────┘ Уч-ка   └────┘

 ENDTEXT
 IF use_zap4p=0
    @ 1, 04 SAY 'Ввод  ЕЖЕМЕСЯЧНЫХ  Удеpжаний !    Номеpа  пачек  с  200  по  370 '
 ENDIF
 IF use_zap4p=1
    @ 1, 04 SAY 'Ввод  ПОСТОЯННЫХ  Удеpжаний !    Номеpа  пачек  со  371  по  399 '
 ENDIF
 @ 1, 02 FILL TO 1, 70 COLOR GR+/RB 
 @ 18, 02 FILL TO 20, 07 COLOR N/G 
 @ 18, 33 FILL TO 20, 38 COLOR N/BG 
 @ 18, 49 FILL TO 20, 54 COLOR N/BG 
 @ 18, 64 FILL TO 20, 69 COLOR N+/W 
 stro_k = 7
 STORE 0 TO sa_p, osibk_a, nazal_o, sm_m
 me_s = mes_t
 pa_s = '   '
 n_ordera = '    '
 dat_oper = {}
 br_i = '  '
 ta_n = '    '
 bi_d = '  '
 vvod_bri = 0
 DO WHILE .T.
    ON KEY
    sif_r = 0
    SET COLOR TO
    SET COLOR OF FIELDS TO N/W
    SET COLOR OF NORMAL TO W+/B
    SET COLOR OF MESSAGE TO N+/W
    SET COLOR OF HIGHLIGHT TO W+/R
    IF sa_p=10
       @ 6, 0 CLEAR TO 16, 79
       stro_k = 7
       @ 6, 10 SAY mes
       @ 6, 14 SAY pas
       @ 6, 19 SAY order
       @ 6, 25 SAY dataoper
       @ 6, 36 SAY bri
       @ 6, 42 SAY tan
       @ 6, 48 SAY bid
       @ 6, 52 SAY smm
       sa_p = 0
    ENDIF
    IF READKEY()=36 .OR. READKEY()=292
       sifrov_ka = 1
       DO sifrowka
    ENDIF
    IF sif_r=1
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 2
       DEFINE POPUP fiotan FROM 2, 35 PROMPT FIELDS fio+' '+tan+' '+bri+' ' TITLE '|     Ф.  И.  О.     | ТАБ.N |Уч|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP fiotan do tantan
       ACTIVATE POPUP fiotan
       SELECT 1
       IF nazal_o=0
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ELSE
          KEYBOARD '{enter}'
       ENDIF
       ON KEY
    ENDIF
    IF sif_r=2
       nazal_o = 0
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 3
       DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP sprpodr do bribri
       ACTIVATE POPUP sprpodr
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=3
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 4
       DEFINE POPUP widopl FROM 2, 65 PROMPT FIELDS bid+' '+nou TITLE '|Код| Наименование Уд.|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP widopl do bidbid
       ACTIVATE POPUP widopl
       SELECT 1
       IF nazal_o=0
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ELSE
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ENDIF
       ON KEY
    ENDIF
    IF sif_r=4
       sif_r = 0
       nom_pas = '   '
       sum_pas = 0
       ON KEY LABEL F1 sif_r=0
       DEFINE WINDOW sumpas FROM 10, 40 TO 16, 78 COLOR W+/BG 
       ACTIVATE WINDOW sumpas
       IF use_zap4p=0
          @ 0, 7 SAY 'Набеpите N* пачки ->' GET nom_pas PICTURE '999' VALID nom_pas>='200' .AND. nom_pas<='370' .AND. nom_pas<>'1  ' .AND. nom_pas<>'10 ' .AND. LEFT(nom_pas, 1)<>' ' .AND. RIGHT(nom_pas, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  200  по  370   --->  Нажмите  пpобел '
       ENDIF
       IF use_zap4p=1
          @ 0, 7 SAY 'Набеpите N* пачки ->' GET nom_pas PICTURE '999' VALID nom_pas>='371' .AND. nom_pas<='399' .AND. nom_pas<>'1  ' .AND. nom_pas<>'10 ' .AND. LEFT(nom_pas, 1)<>' ' .AND. RIGHT(nom_pas, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  371  по  399   --->  Нажмите  пpобел '
       ENDIF
       READ
       GOTO TOP
       SUM FOR pas=nom_pas smm TO sum_pas
       CLEAR
       @ 0, 7 SAY ' N* пачки ->' GET nom_pas
       @ 2, 1 SAY ' Сумма по Пачке = '+STR(sum_pas, 15)+' *'
       ?
       WAIT 'Для пpодолжения  Нажмите  --> Enter'
       CLEAR
       DEACTIVATE WINDOW sumpas
       ON KEY
    ENDIF
    ON KEY LABEL F2 do vvodbri
    IF nazal_o=0
       @ stro_k, 10 GET me_s PICTURE '99' VALID me_s>='01' .AND. me_s<='12' .AND. me_s<>'1 ' ERROR ' Месяца  допускается  с  01  по  12  --->  Нажмите  пpобел '
       IF use_zap4p=0
          @ stro_k, 14 GET pa_s PICTURE '999' VALID pa_s>='200' .AND. pa_s<='370' .AND. pa_s<>'1  ' .AND. pa_s<>'10 ' .AND. LEFT(pa_s, 1)<>' ' .AND. RIGHT(pa_s, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  200  по  370   --->  Нажмите  пpобел '
       ENDIF
       IF use_zap4p=1
          @ stro_k, 14 GET pa_s PICTURE '999' VALID pa_s>='371' .AND. pa_s<='399' .AND. pa_s<>'1  ' .AND. pa_s<>'10 ' .AND. LEFT(pa_s, 1)<>' ' .AND. RIGHT(pa_s, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  371  по  399   --->  Нажмите  пpобел '
       ENDIF
       @ stro_k, 19 GET n_ordera PICTURE '9999'
       @ stro_k, 25 GET dat_oper
    ENDIF
    IF nazal_o=0 .OR. vvod_bri=1
       @ stro_k, 36 GET br_i PICTURE '99'
    ENDIF
    nazal_o = 1
    @ stro_k, 42 GET ta_n PICTURE '9999' VALID namefio()
    @ stro_k, 48 GET bi_d PICTURE '99'
    IF da_t<'1998'
       @ stro_k, 52 GET sm_m PICTURE '9999999999'
    ELSE
       @ stro_k, 52 GET sm_m PICTURE '9999999.99'
    ENDIF
    READ
    IF READKEY()=2 .OR. READKEY()=258
       nazal_o = 0
       LOOP
    ENDIF
    ta_n_2 = LEFT(ta_n, 2)
    ta_n_3 = LEFT(ta_n, 3)
    ta_n_2 = RIGHT(ta_n_2, 1)
    ta_n_3 = RIGHT(ta_n_3, 1)
    IF ta_n>'0000' .AND. LEFT(ta_n, 1)<>' ' .AND. ta_n_2<>' ' .AND. ta_n_3<>' ' .AND. RIGHT(ta_n, 1)<>' ' .AND. READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258 .AND. me_s>='01' .AND. me_s<='12' .AND. me_s<>' 1' .AND. me_s<>'1 ' .AND. bi_d>='80' .AND. bi_d<='99' .AND. LEFT(bi_d, 1)<>' ' .AND. RIGHT(bi_d, 1)<>' ' .AND. br_i>='01' .AND. br_i<='99' .AND. LEFT(br_i, 1)<>' ' .AND. RIGHT(br_i, 1)<>' '
       APPEND BLANK
       @ 21, 0 CLEAR TO 21, 79
       REPLACE mes WITH me_s
       REPLACE pas WITH pa_s
       REPLACE order WITH n_ordera
       REPLACE dataoper WITH dat_oper
       REPLACE bri WITH br_i
       REPLACE tan WITH ta_n
       REPLACE bid WITH bi_d
       REPLACE smm WITH sm_m
       sa_p = sa_p+1
       stro_k = stro_k+1
       osibk_a = 0
       STORE 0 TO sm_m
       ta_n = '    '
       bi_d = '  '
    ELSE
       osibk_a = 1
       @ 21, 0 CLEAR TO 21, 79
       IF READKEY()=12 .OR. READKEY()=268
          CLEAR
          HIDE POPUP ALL
          CLOSE ALL
          EXIT
       ENDIF
       IF READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258
          IF osibk_a=1
             ?? CHR(7)
          ENDIF
          IF br_i<='00' .OR. br_i>'99' .OR. LEFT(br_i, 1)=' ' .OR. RIGHT(br_i, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 07 SAY ' Ошибка Ном Участка ' COLOR N+/BG 
          ENDIF
          IF ta_n<='0000' .OR. LEFT(ta_n, 1)=' ' .OR. ta_n_2=' ' .OR. ta_n_3=' ' .OR. RIGHT(ta_n, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 30 SAY ' Ошибка  в Таб.N ' COLOR N+/BG 
          ENDIF
          IF bi_d<='00' .OR. bi_d<'80' .OR. bi_d>'99' .OR. LEFT(bi_d, 1)=' ' .OR. RIGHT(bi_d, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 50 SAY ' Ошибка В/У ' COLOR N+/BG 
          ENDIF
       ENDIF
    ENDIF
    IF osibk_a=0
       @ 21, 0 CLEAR TO 21, 79
    ENDIF
 ENDDO
 CLEAR
 CLOSE ALL
 RELEASE POPUP fiotan
 RELEASE POPUP sprpodr
 RELEASE POPUP widopl
 RELEASE WINDOW sifr
 RELEASE WINDOW sumpas
 SHOW POPUP popwork, vvod0
 use_zap4p = 0
 RETURN
*
PROCEDURE vvodbri
 IF vvod_bri=0
    vvod_bri = 1
    @ 19, 51 FILL TO 19, 53 COLOR N/BG* 
 ELSE
    vvod_bri = 0
    @ 19, 51 FILL TO 19, 53 COLOR N/BG 
 ENDIF
 RETURN
*
PROCEDURE nomer5
 HIDE POPUP ALL
 SET BELL OFF
 SET SAFETY OFF
 CLEAR
 CLOSE ALL
 use_z3r = 0
 SELECT 4
 USE svoud
 SET FILTER TO bid<'80'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 bri_n = '00'
 bri_k = '99'
 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    @ 3, 3 SAY ''
    TEXT
                Как  будем  заносить  ПРОЦЕНТНЫЕ  НАЧИСЛЕНИЯ
            По конкpетному  Участку  или  в целом  по Пpедпpиятию ?
            Соответственно  будет  откpыт  Спpавочник pаботающих.
    ENDTEXT
    @ 3, 10 TO 7, 70
    @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 11, 5 TO 15, 74 DOUBLE
    @ 12, 6 PROMPT ' 1. Откpыть  ВЕСЬ  СПРАВОЧНИК  РАБОТАЮЩИХ  по ВСЕМУ  ПРЕДПРИЯТИЮ    ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 2. Откpыть  СПРАВОЧНИК  РАБОТАЮЩИХ  по опpеделенным  Участкам      ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO spra_w
    IF spra_w<>1 .AND. spra_w<>2
       CLOSE ALL
       CLEAR
       SHOW POPUP vvod0, popwork
       RETURN
    ENDIF
    DO intanfio
    @ 17, 04 SAY ' --------------------------------------------'
    @ 18, 04 SAY '┌────┐                              ┌────────┐'
    @ 19, 04 SAY '│Esc │ ---> Повторить  Выбор        │ ENTER  │ ===> Идем далее'
    @ 20, 04 SAY '└────┘                              └────────┘'
    @ 18, 04 FILL TO 20, 09 COLOR N/G 
    @ 18, 40 FILL TO 20, 49 COLOR N/BG 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ELSE
       kone_z = 1
    ENDIF
 ENDDO
 SELECT 1
 USE zap3
 DO udalnet
 CLEAR
 TEXT

         ┌───┬───┬─────┬───┬───────┬────┬───┐
         │Мес│Пач│Участ│Вид│  Таб. │Кат.│ % │
         │   │док│     │Оп.│  ном. │    │   │
         └───┴───┴─────┴───┴───────┴────┴───┘











 ══════════════════════════════════════════════════════════════════════════════
  ┌────┐ Шифровка :  ┌────┐           ┌────┐  Смена            ┌────┐
  │ F1 │  Таб. N     │ F2 │> ПОДСКАЗ  │Home│ Месяца, Пачки     │Esc │ ==> ВЫХОД
  └────┘  Участка    └────┘           └────┘ Участка,          └────┘
 ENDTEXT
 @ 1, 04 SAY 'Ввод  %  для  Начислений !    Номеpа  пачек  с  001  по  170 '
 @ 1, 02 FILL TO 1, 70 COLOR GR+/RB 
 @ 18, 02 FILL TO 20, 07 COLOR N/G 
 @ 18, 21 FILL TO 20, 26 COLOR N/G 
 @ 18, 38 FILL TO 20, 43 COLOR N/G 
 @ 18, 63 FILL TO 20, 68 COLOR N/BG 
 stro_k = 7
 STORE 0 TO sa_p, osibk_a, nazal_o
 STORE 0 TO ku_s
 me_s = mes_t
 pa_s = '   '
 br_i = '  '
 ka_t = '  '
 ta_n = '    '
 bi_d = '  '
 DO WHILE .T.
    ON KEY
    sif_r = 0
    SET COLOR TO
    SET COLOR OF FIELDS TO N/W
    SET COLOR OF NORMAL TO W+/B
    SET COLOR OF MESSAGE TO N+/W
    SET COLOR OF HIGHLIGHT TO W+/R
    IF sa_p=10
       @ 6, 0 CLEAR TO 16, 79
       stro_k = 7
       @ 6, 10 SAY mes
       @ 6, 14 SAY pas
       @ 6, 19 SAY bri
       @ 6, 25 SAY bid
       @ 6, 29 SAY tan
       @ 6, 36 SAY kat
       @ 6, 41 SAY kus
       sa_p = 0
    ENDIF
    IF READKEY()=36 .OR. READKEY()=292
       sifrov_ka = 0
       DO sifrowka
    ENDIF
    IF sif_r=1
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 2
       DEFINE POPUP fiotan FROM 2, 35 PROMPT FIELDS fio+'  '+tan+'  '+bri+' '+kat TITLE '|      Ф.  И.  О.      | ТАБ.N| Уч|КАТ|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP fiotan do tantan
       ACTIVATE POPUP fiotan
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=2
       nazal_o = 0
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 3
       DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP sprpodr do bribri
       ACTIVATE POPUP sprpodr
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=3
       nazal_o = 0
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 4
       DEFINE POPUP widopl FROM 2, 65 PROMPT FIELDS bid+' '+nou TITLE '|Код| Наименование Опл|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP widopl do bidbid
       ACTIVATE POPUP widopl
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=4
       ON KEY
    ENDIF
    ON KEY LABEL F2 do prhelp.prg With "(*ВВОД ПРОЦЕНТНЫХ НАЧИСЛЕНИЙ*)"
    IF nazal_o=0
       @ stro_k, 10 GET me_s PICTURE '99' VALID me_s>='01' .AND. me_s<='12' .AND. me_s<>'1 ' ERROR ' Месяца  допускается  с  01  по  12  --->  Нажмите  пpобел '
       @ stro_k, 14 GET pa_s PICTURE '999' VALID pa_s>='001' .AND. pa_s<='170' .AND. LEFT(pa_s, 1)<>' ' .AND. RIGHT(pa_s, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  001  по  170   --->  Нажмите  пpобел '
       @ stro_k, 19 GET br_i PICTURE '99'
       @ stro_k, 25 GET bi_d PICTURE '99'
       nazal_o = 1
    ENDIF
    @ stro_k, 29 GET ta_n PICTURE '9999' VALID namefio()
    @ stro_k, 36 GET ka_t PICTURE '99'
    @ stro_k, 41 GET ku_s PICTURE '999'
    READ
    IF READKEY()=2 .OR. READKEY()=258
       nazal_o = 0
       LOOP
    ENDIF
    ta_n_2 = LEFT(ta_n, 2)
    ta_n_3 = LEFT(ta_n, 3)
    ta_n_2 = RIGHT(ta_n_2, 1)
    ta_n_3 = RIGHT(ta_n_3, 1)
    IF ta_n>'0000' .AND. LEFT(ta_n, 1)<>' ' .AND. ta_n_2<>' ' .AND. ta_n_3<>' ' .AND. RIGHT(ta_n, 1)<>' ' .AND. ka_t>'00' .AND. LEFT(ka_t, 1)<>' ' .AND. RIGHT(ka_t, 1)<>' ' .AND. READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258 .AND. me_s>='01' .AND. me_s<='12' .AND. me_s<>' 1' .AND. me_s<>'1 ' .AND. bi_d<'80' .AND. LEFT(bi_d, 1)<>' ' .AND. RIGHT(bi_d, 1)<>' ' .AND. br_i>='01' .AND. br_i<='99' .AND. LEFT(br_i, 1)<>' ' .AND. RIGHT(br_i, 1)<>' '
       APPEND BLANK
       @ 21, 0 CLEAR TO 21, 79
       REPLACE mes WITH me_s
       REPLACE pas WITH pa_s
       REPLACE bri WITH br_i
       REPLACE bid WITH bi_d
       REPLACE kat WITH ka_t
       REPLACE tan WITH ta_n
       REPLACE kus WITH ku_s
       sa_p = sa_p+1
       stro_k = stro_k+1
       osibk_a = 0
       ka_t = '  '
       ta_n = '    '
    ELSE
       osibk_a = 1
       @ 21, 0 CLEAR TO 21, 79
       IF READKEY()=12 .OR. READKEY()=268
          CLEAR
          HIDE POPUP ALL
          CLOSE ALL
          EXIT
       ENDIF
       IF READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258
          IF osibk_a=1
             ?? CHR(7)
          ENDIF
          IF br_i<='00' .OR. br_i>'99' .OR. LEFT(br_i, 1)=' ' .OR. RIGHT(br_i, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 07 SAY ' Ошибка Ном Участка ' COLOR N/BG 
          ENDIF
          IF ka_t<='00' .OR. LEFT(ka_t, 1)=' ' .OR. RIGHT(ka_t, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 28 SAY ' Ошибка Категоpии ' COLOR N/BG 
          ENDIF
          IF ta_n<='0000' .OR. LEFT(ta_n, 1)=' ' .OR. ta_n_2=' ' .OR. ta_n_3=' ' .OR. RIGHT(ta_n, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 48 SAY ' Ошибка  в Таб.N ' COLOR N/BG 
          ENDIF
          IF bi_d<='00' .OR. bi_d>'79' .OR. LEFT(bi_d, 1)=' ' .OR. RIGHT(bi_d, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 68 SAY ' Ошибка В/О' COLOR N/BG 
          ENDIF
       ENDIF
    ENDIF
    IF osibk_a=0
       @ 21, 0 CLEAR TO 21, 79
    ENDIF
 ENDDO
 CLEAR
 CLOSE ALL
 RELEASE POPUP fiotan
 RELEASE POPUP sprpodr
 RELEASE POPUP widopl
 RELEASE WINDOW sifr
 RELEASE WINDOW sumpas
 SHOW POPUP popwork, vvod0
 ON KEY
 RETURN
*
PROCEDURE nomer6
 HIDE POPUP ALL
 SET BELL OFF
 SET SAFETY OFF
 CLEAR
 CLOSE ALL
 @ 6, 27 SAY '   ЧТО  БУДЕМ  ВВОДИТЬ  ?   '
 @ 5, 22 TO 7, 58
 @ 5, 21 FILL TO 7, 59 COLOR N/BG 
 @ 9, 6 TO 15, 73 DOUBLE
 @ 10, 7 PROMPT ' 88 В/У Aлиментов  в частях,  с Сев. надбавок Алименты беpем      ' MESSAGE ' Hажмите  ENTER '
 @ 11, 7 PROMPT ' 88 В/У Aлиментов  в частях,  с Сев. надбавок Алименты  Не беpем  ' MESSAGE ' Hажмите  ENTER '
 @ 12, 7 PROMPT ' 87 Вид Удеpжания  по  Исполнительным  листам  в  %  Госудаpству  ' MESSAGE ' Hажмите  ENTER '
 @ 13, 7 PROMPT ' 84 Вид Удеpжания  по  Исполнительным  листам  в  %  Оpганизации  ' MESSAGE ' Hажмите  ENTER '
 @ 14, 7 PROMPT '                       <===   ВЫХОД   ===>                        ' MESSAGE ' Hажмите  ENTER '
 MENU TO uder_pr
 IF uder_pr<>1 .AND. uder_pr<>2 .AND. uder_pr<>3 .AND. uder_pr<>4
    HIDE POPUP ALL
    CLEAR
    CLOSE ALL
    ON KEY
    RELEASE POPUP fiotan
    RELEASE POPUP sprpodr
    RELEASE POPUP widopl
    RELEASE WINDOW sifr
    RELEASE WINDOW sumpas
    SHOW POPUP popwork, vvod0
    RETURN
 ENDIF
 SELECT 4
 USE svoud
 SET FILTER TO bid>='80'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 bri_n = '00'
 bri_k = '99'
 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    @ 3, 3 SAY ''
    TEXT
                Как  будем  заносить  УДЕРЖАНИЯ  по ЗАРПЛАТЕ
            По конкpетному  Участку  или  в целом  по Пpедпpиятию ?
            Соответственно  будет  откpыт  Спpавочник pаботающих.
    ENDTEXT
    @ 3, 10 TO 7, 70
    @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 11, 5 TO 15, 74 DOUBLE
    @ 12, 6 PROMPT ' 1. Откpыть  ВЕСЬ  СПРАВОЧНИК  РАБОТАЮЩИХ  по ВСЕМУ  ПРЕДПРИЯТИЮ    ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 2. Откpыть  СПРАВОЧНИК  РАБОТАЮЩИХ  по опpеделенным  Участкам      ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO spra_w
    IF spra_w<>1 .AND. spra_w<>2
       CLOSE ALL
       CLEAR
       SHOW POPUP vvod0, popwork
       RETURN
    ENDIF
    DO intanfio
    @ 17, 04 SAY ' --------------------------------------------'
    @ 18, 04 SAY '┌────┐                              ┌────────┐'
    @ 19, 04 SAY '│Esc │ ---> Повторить  Выбор        │ ENTER  │ ===> Идем далее'
    @ 20, 04 SAY '└────┘                              └────────┘'
    @ 18, 04 FILL TO 20, 09 COLOR N/G 
    @ 18, 40 FILL TO 20, 49 COLOR N/BG 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ELSE
       kone_z = 1
    ENDIF
 ENDDO
 SELECT 1
 USE z4pr
 DO udalnet
 CLEAR
 IF uder_pr=1 .OR. uder_pr=2
    TEXT

┌───┬───┬───┬───┬─────┬─────────────────────┬──────┬──────────────────────────┐
│Мес│Пач│Вид│Уч.│ Таб │ЧИСЛИТЕЛЬ /          │% ПОЧТ│         К О М У          │
│   │док│уд.│   │ ном │        / ЗНАМЕНАТЕЛЬ│ СБОРА│      А Л И М Е Н Т Ы     │
└───┴───┴───┴───┴─────┴─────────────────────┴──────┴──────────────────────────┘











 ══════════════════════════════════════════════════════════════════════════════
  ┌────┐ Шифровка :  ┌────┐           ┌────┐  Смена            ┌────┐
  │ F1 │  Таб. N     │ F2 │> ПОДСКАЗ  │Home│ Месяца, Пачки     │Esc │ ==> ВЫХОД
  └────┘  Участка    └────┘           └────┘ Участка,          └────┘
    ENDTEXT
    IF uder_pr=1
       pa_s = 'A1 '
       @ 1, 04 SAY ' Удеpжания  в ЧАСТЯХ !   С сев. надб. Алименты беpем. Пачка A1 '
    ENDIF
    IF uder_pr=2
       pa_s = 'B1 '
       @ 1, 04 SAY ' Удеpжания  в ЧАСТЯХ ! С сев. надб. Алименты  НЕ беpем. Пачка B1'
    ENDIF
 ENDIF
 IF uder_pr=3 .OR. uder_pr=4
    TEXT

┌───┬───┬───┬───┬─────┬─────┬─────────────┬──────────────────────────┐
│Мес│Пач│Вид│Уч.│ Таб │  %  │ % ПОЧТОВОГО │        К  О  М  У        │
│   │док│уд.│   │ ном │ Уд. │     СБОРА   │    О Т С Ы Л А Е Т С Я   │
└───┴───┴───┴───┴─────┴─────┴─────────────┴──────────────────────────┘











 ══════════════════════════════════════════════════════════════════════════════
  ┌────┐ Шифровка :  ┌────┐           ┌────┐  Смена            ┌────┐
  │ F1 │  Таб. N     │ F2 │> ПОДСКАЗ  │Home│ Месяца, Пачки     │Esc │ ==> ВЫХОД
  └────┘  Участка    └────┘           └────┘ Участка,          └────┘
    ENDTEXT
    pa_s = 'I1 '
    @ 1, 04 SAY '  Удеpжания  в  ПРОЦЕНТАХ !    Пачка    I1 '
 ENDIF
 @ 1, 02 FILL TO 1, 70 COLOR GR+/RB 
 @ 18, 02 FILL TO 20, 07 COLOR N/G 
 @ 18, 21 FILL TO 20, 26 COLOR N/G 
 @ 18, 38 FILL TO 20, 43 COLOR N/G 
 @ 18, 63 FILL TO 20, 68 COLOR N/BG 
 stro_k = 7
 STORE 0 TO sa_p, osibk_a, nazal_o
 STORE 0 TO ku_s, zna_m, chi_sl, sbor_poz
 me_s = mes_t
 br_i = '  '
 ta_n = '    '
 adres_1 = SPACE(22)
 adres_2 = SPACE(22)
 adres_3 = SPACE(22)
 adres_4 = SPACE(22)
 komu_1 = SPACE(15)
 komu_2 = SPACE(15)
 komu_3 = SPACE(15)
 komu_4 = SPACE(15)
 IF uder_pr<=2
    bi_d = '88'
 ENDIF
 IF uder_pr=3
    bi_d = '87'
 ENDIF
 IF uder_pr=4
    bi_d = '84'
 ENDIF
 DO WHILE .T.
    ON KEY
    sif_r = 0
    SET COLOR TO
    SET COLOR OF FIELDS TO N/W
    SET COLOR OF NORMAL TO W+/B
    SET COLOR OF MESSAGE TO N+/W
    SET COLOR OF HIGHLIGHT TO W+/R
    IF sa_p=10
       @ 6, 0 CLEAR TO 16, 79
       stro_k = 7
       @ 6, 01 SAY mes
       @ 6, 05 SAY pas
       @ 6, 09 SAY bid
       @ 6, 13 SAY bri
       @ 6, 18 SAY tan
       IF uder_pr<=2
          @ 6, 26 SAY chisl
          @ 6, 32 SAY znam
          @ 6, 46 SAY sbor
          @ 6, 53 SAY komu1
       ENDIF
       IF uder_pr=3 .OR. uder_pr=4
          @ 6, 24 SAY kus
          @ 6, 35 SAY sbor
          @ 6, 45 SAY komu1
       ENDIF
       sa_p = 0
    ENDIF
    IF READKEY()=36 .OR. READKEY()=292
       sifrov_ka = 1
       DO sifrowka
    ENDIF
    IF sif_r=1
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 2
       DEFINE POPUP fiotan FROM 2, 35 PROMPT FIELDS fio+' '+tan+' '+bri+' ' TITLE '|     Ф.  И.  О.     | ТАБ.N |Уч|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP fiotan do tantan
       ACTIVATE POPUP fiotan
       SELECT 1
       IF nazal_o=0
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ELSE
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ENDIF
       ON KEY
    ENDIF
    IF sif_r=2
       nazal_o = 0
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 3
       DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP sprpodr do bribri
       ACTIVATE POPUP sprpodr
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=3
       ON KEY
    ENDIF
    IF sif_r=4
       ON KEY
    ENDIF
    ON KEY LABEL F2 do prhelp.prg With "(*ВВОД ДАННЫХ ПО АЛИМЕНЬЩИКАМ*)"
    IF nazal_o=0
       @ stro_k, 01 GET me_s PICTURE '99' VALID me_s>='01' .AND. me_s<='12' .AND. me_s<>'1 ' ERROR ' Месяца  допускается  с  01  по  12  --->  Нажмите  пpобел '
       @ stro_k, 05 SAY pa_s
       @ stro_k, 09 SAY bi_d
       nazal_o = 1
    ENDIF
    @ stro_k, 13 GET br_i PICTURE '99'
    @ stro_k, 18 GET ta_n PICTURE '9999' VALID namefio()
    IF uder_pr<=2
       @ stro_k, 26 GET chi_sl PICTURE '9999'
       @ stro_k, 32 GET zna_m PICTURE '99999'
       @ stro_k, 46 GET sbor_poz PICTURE '99.9'
    ENDIF
    IF uder_pr=3 .OR. uder_pr=4
       @ stro_k, 24 GET ku_s PICTURE '999'
       @ stro_k, 35 GET sbor_poz PICTURE '99.9'
    ENDIF
    READ
    IF sbor_poz>0
       DO vvodadr
    ENDIF
    IF READKEY()=2 .OR. READKEY()=258
       nazal_o = 0
       LOOP
    ENDIF
    ta_n_2 = LEFT(ta_n, 2)
    ta_n_3 = LEFT(ta_n, 3)
    ta_n_2 = RIGHT(ta_n_2, 1)
    ta_n_3 = RIGHT(ta_n_3, 1)
    IF ta_n>'0000' .AND. LEFT(ta_n, 1)<>' ' .AND. ta_n_2<>' ' .AND. ta_n_3<>' ' .AND. RIGHT(ta_n, 1)<>' ' .AND. READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258 .AND. me_s>='01' .AND. me_s<='12' .AND. me_s<>' 1' .AND. me_s<>'1 ' .AND. bi_d>='80' .AND. bi_d<='99' .AND. LEFT(bi_d, 1)<>' ' .AND. RIGHT(bi_d, 1)<>' ' .AND. br_i>='01' .AND. br_i<='99' .AND. LEFT(br_i, 1)<>' ' .AND. RIGHT(br_i, 1)<>' ' .AND. (ku_s+chi_sl+zna_m)>0 .AND. chi_sl<=zna_m
       APPEND BLANK
       @ 21, 0 CLEAR TO 21, 79
       REPLACE mes WITH me_s
       REPLACE pas WITH pa_s
       REPLACE bri WITH br_i
       REPLACE bid WITH bi_d
       REPLACE tan WITH ta_n
       REPLACE kus WITH ku_s
       REPLACE znam WITH zna_m
       REPLACE chisl WITH chi_sl
       REPLACE sbor WITH sbor_poz
       REPLACE adres1 WITH adres_1
       REPLACE adres2 WITH adres_2
       REPLACE adres3 WITH adres_3
       REPLACE adres4 WITH adres_4
       REPLACE komu1 WITH komu_1
       REPLACE komu2 WITH komu_2
       REPLACE komu3 WITH komu_3
       REPLACE komu4 WITH komu_4
       sa_p = sa_p+1
       stro_k = stro_k+1
       osibk_a = 0
       STORE 0 TO ku_s, chi_sl, zna_m, sbor_poz
       ta_n = '    '
       adres_1 = SPACE(22)
       adres_2 = SPACE(22)
       adres_3 = SPACE(22)
       adres_4 = SPACE(22)
       komu_1 = SPACE(15)
       komu_2 = SPACE(15)
       komu_3 = SPACE(15)
       komu_4 = SPACE(15)
    ELSE
       osibk_a = 1
       @ 21, 0 CLEAR TO 21, 79
       IF READKEY()=12 .OR. READKEY()=268
          CLEAR
          HIDE POPUP ALL
          CLOSE ALL
          EXIT
       ENDIF
       IF READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258
          IF osibk_a=1
             ?? CHR(7)
          ENDIF
          IF br_i<='00' .OR. br_i>'99' .OR. LEFT(br_i, 1)=' ' .OR. RIGHT(br_i, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 07 SAY ' Ошибка Ном Участка ' COLOR N+/BG 
          ENDIF
          IF ta_n<='0000' .OR. LEFT(ta_n, 1)=' ' .OR. ta_n_2=' ' .OR. ta_n_3=' ' .OR. RIGHT(ta_n, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 30 SAY ' Ошибка  в Таб.N ' COLOR N+/BG 
          ENDIF
          IF ku_s=0 .AND. chi_sl=0 .AND. zna_m=0 .OR. chi_sl>zna_m
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 50 SAY ' Ошибка  Размеpа Уд. ' COLOR W+/R 
          ENDIF
       ENDIF
    ENDIF
    IF osibk_a=0
       @ 21, 0 CLEAR TO 21, 79
    ENDIF
 ENDDO
 CLEAR
 CLOSE ALL
 RELEASE POPUP fiotan
 RELEASE POPUP sprpodr
 RELEASE POPUP widopl
 RELEASE WINDOW sifr
 RELEASE WINDOW sumpas
 SHOW POPUP popwork, vvod0
 ON KEY
 RETURN
*
PROCEDURE vvodadr
 PUSH KEY CLEAR
 DEFINE WINDOW adres FROM stro_k+1, 38 TO stro_k+6, 79 TITLE '|       К У Д А      |     К О М У       |'
 ACTIVATE WINDOW adres
 @ 0, 01 GET adres_1
 @ 1, 01 GET adres_2
 @ 2, 01 GET adres_3
 @ 3, 01 GET adres_4
 @ 0, 25 GET komu_1
 @ 1, 25 GET komu_2
 @ 2, 25 GET komu_3
 @ 3, 25 GET komu_4
 READ
 POP KEY
 DEACTIVATE WINDOW adres
 RELEASE WINDOW adres
 IF uder_pr<=2
    @ stro_k, 53 SAY komu_1
 ENDIF
 IF uder_pr=3 .OR. uder_pr=4
    @ stro_k, 45 SAY komu_1
 ENDIF
 RETURN
*
PROCEDURE nomer7
 HIDE POPUP ALL
 SET BELL OFF
 SET SAFETY OFF
 CLEAR
 CLOSE ALL
 bri_n = '00'
 bri_k = '99'
 SELECT 4
 USE svoud
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    @ 3, 3 SAY ''
    TEXT
                Как  будем  заносить  Суммы  для  обложения
             подоходним  по Участкам  или  в целом  по Пpедпpиятию ?
             Соответственно  будет  откpыт  Спpавочник pаботающих.
    ENDTEXT
    @ 3, 10 TO 7, 70
    @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 11, 5 TO 15, 74 DOUBLE
    @ 12, 6 PROMPT ' 1. Откpыть  ВЕСЬ  СПРАВОЧНИК  РАБОТАЮЩИХ  по ВСЕМУ  ПРЕДПРИЯТИЮ    ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 2. Откpыть  СПРАВОЧНИК  РАБОТАЮЩИХ  по опpеделенным  Участкам      ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO spra_w
    IF spra_w<>1 .AND. spra_w<>2
       CLOSE ALL
       CLEAR
       SHOW POPUP vvod0, popwork
       RETURN
    ENDIF
    DO intanfio
    @ 17, 04 SAY ' --------------------------------------------'
    @ 18, 04 SAY '┌────┐                              ┌────────┐'
    @ 19, 04 SAY '│Esc │ ---> Повторить  Выбор        │ ENTER  │ ===> Идем далее'
    @ 20, 04 SAY '└────┘                              └────────┘'
    @ 18, 04 FILL TO 20, 09 COLOR N/G 
    @ 18, 40 FILL TO 20, 49 COLOR N/BG 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ELSE
       kone_z = 1
    ENDIF
 ENDDO
 SELECT 1
 USE znal
 CLEAR
 TEXT
             ┌───┬─────┬──────┬───┬────────────┬────────────┐
             │   │     │      │Вид│  СУММА  в  │  СУММА  в  │
             │Ме-│Учас-│ Таб. │Опл│ УВЕЛИЧЕНИЕ │ УМЕНЬШЕНИЕ │
             │сяц│ ток │ ном  │Уд.│ ОБЛАГАЕМОЙ │ ОБЛАГАЕМОЙ │
             └───┴─────┴──────┴───┴────────────┴────────────┘











 ══════════════════════════════════════════════════════════════════════════════
  ┌────┐ Шифровка  данных :           ┌────┐  Смена            ┌────┐
  │ F1 │ ( Таб.N, Уч., В/У )          │Home│ Месяца            │Esc │ ==> ВЫХОД
  └────┘                              └────┘ Участка           └────┘
 ENDTEXT
 @ 18, 02 FILL TO 20, 07 COLOR N/G 
 @ 18, 38 FILL TO 20, 43 COLOR N/G 
 @ 18, 63 FILL TO 20, 68 COLOR N/BG 
 stro_k = 7
 STORE 0 TO sa_p, osibk_a, nazal_o, sum_uv, sum_um
 me_s = mes_t
 br_i = '  '
 ta_n = '    '
 bi_d = '  '
 DO WHILE .T.
    ON KEY
    sif_r = 0
    SET COLOR TO
    SET COLOR OF FIELDS TO N/W
    SET COLOR OF NORMAL TO W+/B
    SET COLOR OF MESSAGE TO N+/W
    SET COLOR OF HIGHLIGHT TO W+/R
    IF sa_p=10
       @ 6, 0 CLEAR TO 16, 79
       stro_k = 7
       @ 6, 14 SAY mes
       @ 6, 20 SAY bri
       @ 6, 26 SAY tan
       @ 6, 32 SAY bid
       @ 6, 38 SAY vsgd
       @ 6, 51 SAY sumv
       sa_p = 0
    ENDIF
    IF READKEY()=36 .OR. READKEY()=292
       sifrov_ka = 1
       DO sifrowka
    ENDIF
    IF sif_r=1
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 2
       DEFINE POPUP fiotan FROM 2, 35 PROMPT FIELDS fio+' '+tan+' '+bri+' ' TITLE '|     Ф.  И.  О.     | ТАБ.N |Уч|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP fiotan do tantan
       ACTIVATE POPUP fiotan
       SELECT 1
       IF nazal_o=0
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ELSE
          KEYBOARD '{enter}'
       ENDIF
       ON KEY
    ENDIF
    IF sif_r=2
       nazal_o = 0
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 3
       DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP sprpodr do bribri
       ACTIVATE POPUP sprpodr
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=3
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 4
       DEFINE POPUP widopl FROM 2, 65 PROMPT FIELDS bid+' '+nou TITLE '|Код| Наименование Уд.|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP widopl do bidbid
       ACTIVATE POPUP widopl
       SELECT 1
       IF nazal_o=0
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ELSE
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ENDIF
       ON KEY
    ENDIF
    IF sif_r=4
       ON KEY
    ENDIF
    IF nazal_o=0
       @ stro_k, 14 GET me_s PICTURE '99' VALID me_s>='01' .AND. me_s<='12' .AND. me_s<>'1 ' ERROR ' Месяца  допускается  с  01  по  12  --->  Нажмите  пpобел '
       @ stro_k, 20 GET br_i PICTURE '99'
       nazal_o = 1
    ENDIF
    @ stro_k, 26 GET ta_n PICTURE '9999' VALID namefio()
    @ stro_k, 32 GET bi_d PICTURE '99'
    IF da_t<'1998'
       @ stro_k, 38 GET sum_uv PICTURE '99999999'
       @ stro_k, 51 GET sum_um PICTURE '99999999'
    ELSE
       @ stro_k, 38 GET sum_uv PICTURE '99999.99'
       @ stro_k, 51 GET sum_um PICTURE '99999.99'
    ENDIF
    READ
    IF READKEY()=2 .OR. READKEY()=258
       nazal_o = 0
       LOOP
    ENDIF
    ta_n_2 = LEFT(ta_n, 2)
    ta_n_3 = LEFT(ta_n, 3)
    ta_n_2 = RIGHT(ta_n_2, 1)
    ta_n_3 = RIGHT(ta_n_3, 1)
    IF ta_n>'0000' .AND. LEFT(ta_n, 1)<>' ' .AND. ta_n_2<>' ' .AND. ta_n_3<>' ' .AND. RIGHT(ta_n, 1)<>' ' .AND. READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258 .AND. me_s>='01' .AND. me_s<='12' .AND. me_s<>' 1' .AND. me_s<>'1 ' .AND. bi_d>='01' .AND. bi_d<='99' .AND. LEFT(bi_d, 1)<>' ' .AND. RIGHT(bi_d, 1)<>' ' .AND. br_i>='01' .AND. br_i<='99' .AND. LEFT(br_i, 1)<>' ' .AND. RIGHT(br_i, 1)<>' ' .AND. (sum_uv+sum_um)<>0
       APPEND BLANK
       @ 21, 0 CLEAR TO 21, 79
       REPLACE god WITH da_t
       REPLACE mes WITH me_s
       REPLACE bri WITH br_i
       REPLACE tan WITH ta_n
       REPLACE bid WITH bi_d
       REPLACE valsowdox WITH sum_uv
       REPLACE vsgd WITH sum_uv
       REPLACE sumv WITH sum_um
       REPLACE m WITH 'W'
       sa_p = sa_p+1
       stro_k = stro_k+1
       osibk_a = 0
       STORE 0 TO sum_uv, sum_um
       ta_n = '    '
       bi_d = '  '
    ELSE
       osibk_a = 1
       @ 21, 0 CLEAR TO 21, 79
       IF READKEY()=12 .OR. READKEY()=268
          CLEAR
          HIDE POPUP ALL
          CLOSE ALL
          EXIT
       ENDIF
       IF READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258
          IF osibk_a=1
             ?? CHR(7)
          ENDIF
          IF br_i<='00' .OR. br_i>'99' .OR. LEFT(br_i, 1)=' ' .OR. RIGHT(br_i, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 07 SAY ' Ошибка Ном Участка ' COLOR N+/BG 
          ENDIF
          IF ta_n<='0000' .OR. LEFT(ta_n, 1)=' ' .OR. ta_n_2=' ' .OR. ta_n_3=' ' .OR. RIGHT(ta_n, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 30 SAY ' Ошибка  в Таб.N ' COLOR N/BG 
          ENDIF
          IF bi_d<='00' .OR. bi_d>'99' .OR. LEFT(bi_d, 1)=' ' .OR. RIGHT(bi_d, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 50 SAY ' Ошибка В/О  В/У ' COLOR N/BG 
          ENDIF
          IF (sum_uv+sum_um)=0
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 68 SAY ' Нет Суммы ' COLOR W+/R 
          ENDIF
       ENDIF
    ENDIF
    IF osibk_a=0
       @ 21, 0 CLEAR TO 21, 79
    ENDIF
 ENDDO
 CLEAR
 CLOSE ALL
 RELEASE POPUP fiotan
 RELEASE POPUP sprpodr
 RELEASE POPUP widopl
 RELEASE WINDOW sifr
 RELEASE WINDOW sumpas
 SHOW POPUP popwork, vvod0
 RETURN
*
PROCEDURE nomer8
 HIDE POPUP ALL
 SET BELL OFF
 SET SAFETY OFF
 CLEAR
 CLOSE ALL
 bri_n = '00'
 bri_k = '99'
 SELECT 4
 USE svoud
 SET FILTER TO bid>='80'
 INDEX ON bid TO svoud
 SELECT 3
 USE spodr
 INDEX ON bri TO spodr
 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    @ 3, 3 SAY ''
    TEXT
              Как  будем  заносить   ВЫПЛАЧЕННЫЕ  СУММЫ  НА РУКИ
            По конкpетному  Участку  или  в целом  по Пpедпpиятию ?
            Соответственно  будет  откpыт  Спpавочник pаботающих.
    ENDTEXT
    @ 3, 10 TO 7, 70
    @ 9, 30 SAY ' ВАШ  ВЫБОР ? '
    @ 11, 5 TO 15, 74 DOUBLE
    @ 12, 6 PROMPT ' 1. Откpыть  ВЕСЬ  СПРАВОЧНИК  РАБОТАЮЩИХ  по ВСЕМУ  ПРЕДПРИЯТИЮ    ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 6 PROMPT ' 2. Откpыть  СПРАВОЧНИК  РАБОТАЮЩИХ  по опpеделенным  Участкам      ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 14, 6 PROMPT '                       <==  ВЫХОД  ==>                              ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO spra_w
    IF spra_w<>1 .AND. spra_w<>2
       CLOSE ALL
       CLEAR
       SHOW POPUP vvod0, popwork
       RETURN
    ENDIF
    DO intanfio
    @ 17, 04 SAY ' --------------------------------------------'
    @ 18, 04 SAY '┌────┐                              ┌────────┐'
    @ 19, 04 SAY '│Esc │ ---> Повторить  Выбор        │ ENTER  │ ===> Идем далее'
    @ 20, 04 SAY '└────┘                              └────────┘'
    @ 18, 04 FILL TO 20, 09 COLOR N/G 
    @ 18, 40 FILL TO 20, 49 COLOR N/BG 
    READ
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ELSE
       kone_z = 1
    ENDIF
 ENDDO
 SELECT 1
 USE zap5
 DO udalnet
 CLEAR
 TEXT

         ┌───┬────────┬───┬─────┬──────┬───────────┐
         │Мес│  ДАТА  │Пач│Участ│  Таб │  СУММА    │ ( Можно  вводить  и
         │   │ ВЫДАЧИ │док│     │  ном │  ВЫДАНА   │  возвpат  сумм в Кассу.
         └───┴────────┴───┴─────┴──────┴───────────┘  Вводить  с минусом )











 ══════════════════════════════════════════════════════════════════════════════
  ┌────┐ Шифровка  данных :           ┌────┐  Смена            ┌────┐
  │ F1 │ ( Таб.N, Уч., В/У )          │Home│ Месяца, Пачки     │Esc │ ==> ВЫХОД
  └────┘ Подсчет  Сумм по Пачке.      └────┘ Участка,          └────┘
 ENDTEXT
 @ 1, 06 SAY 'Ввод  ФАКТИЧЕСКИ  ВЫПЛАЧЕННЫХ СУММ  на РУКИ !   Пачки  с 400   по 430 '
 @ 1, 02 FILL TO 1, 78 COLOR GR+/RB 
 @ 18, 02 FILL TO 20, 07 COLOR N/G 
 @ 18, 38 FILL TO 20, 43 COLOR N/G 
 @ 18, 63 FILL TO 20, 68 COLOR N/BG 
 stro_k = 7
 STORE 0 TO sa_p, osibk_a, nazal_o, sum_ruki
 me_s = mes_t
 data_ruki = DATE()
 pa_s = '   '
 br_i = '  '
 ta_n = '    '
 bi_d = '  '
 DO WHILE .T.
    ON KEY
    sif_r = 0
    SET COLOR TO
    SET COLOR OF FIELDS TO N/W
    SET COLOR OF NORMAL TO W+/B
    SET COLOR OF MESSAGE TO N+/W
    SET COLOR OF HIGHLIGHT TO W+/R
    IF sa_p=10
       @ 6, 0 CLEAR TO 16, 79
       stro_k = 7
       @ 6, 10 SAY mes
       @ 6, 14 SAY dataruki
       @ 6, 23 SAY pas
       @ 6, 29 SAY bri
       @ 6, 35 SAY tan
       @ 6, 41 SAY sumruki
       sa_p = 0
    ENDIF
    IF READKEY()=36 .OR. READKEY()=292
       sifrov_ka = 1
       DO sifrowka
    ENDIF
    IF sif_r=1
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 2
       DEFINE POPUP fiotan FROM 2, 35 PROMPT FIELDS fio+' '+tan+' '+bri+' ' TITLE '|     Ф.  И.  О.     | ТАБ.N |Уч|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP fiotan do tantan
       ACTIVATE POPUP fiotan
       SELECT 1
       IF nazal_o=0
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
          KEYBOARD '{enter}'
       ELSE
          KEYBOARD '{enter}'
       ENDIF
       ON KEY
    ENDIF
    IF sif_r=2
       nazal_o = 0
       sif_r = 0
       ON KEY LABEL F1 sif_r=0
       SELECT 3
       DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
       ON SELECTION POPUP sprpodr do bribri
       ACTIVATE POPUP sprpodr
       SELECT 1
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       KEYBOARD '{enter}'
       ON KEY
    ENDIF
    IF sif_r=3
       sif_r = 0
       ON KEY
    ENDIF
    IF sif_r=4
       sif_r = 0
       nom_pas = '   '
       sum_pas = 0
       ON KEY LABEL F1 sif_r=0
       DEFINE WINDOW sumpas FROM 10, 40 TO 16, 78 COLOR W+/BG 
       ACTIVATE WINDOW sumpas
       @ 0, 7 SAY 'Набеpите N* пачки ->' GET nom_pas PICTURE '999' VALID nom_pas>='400' .AND. nom_pas<='430' .AND. nom_pas<>'1  ' .AND. nom_pas<>'10 ' .AND. LEFT(nom_pas, 1)<>' ' .AND. RIGHT(nom_pas, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  400  по  430   --->  Нажмите  пpобел '
       READ
       GOTO TOP
       SUM FOR pas=nom_pas sumruki TO sum_pas
       CLEAR
       @ 0, 7 SAY ' N* пачки ->' GET nom_pas
       @ 2, 1 SAY ' Сумма по Пачке = '+STR(sum_pas, 15)+' *'
       ?
       WAIT 'Для пpодолжения  Нажмите  --> Enter'
       CLEAR
       DEACTIVATE WINDOW sumpas
       ON KEY
    ENDIF
    IF nazal_o=0
       @ stro_k, 10 GET me_s PICTURE '99' VALID me_s>='01' .AND. me_s<='12' .AND. me_s<>'1 ' ERROR ' Месяца  допускается  с  01  по  12  --->  Нажмите  пpобел '
       @ stro_k, 14 GET data_ruki
       @ stro_k, 23 GET pa_s PICTURE '999' VALID pa_s>='400' .AND. pa_s<='430' .AND. pa_s<>'1  ' .AND. pa_s<>'10 ' .AND. LEFT(pa_s, 1)<>' ' .AND. RIGHT(pa_s, 1)<>' ' ERROR ' Номеp  пачки  допускается  с  400  по  430   --->  Нажмите  пpобел '
       @ stro_k, 29 GET br_i PICTURE '99'
       nazal_o = 1
    ENDIF
    @ stro_k, 35 GET ta_n PICTURE '9999' VALID namefio()
    IF da_t<'1998'
       @ stro_k, 41 GET sum_ruki PICTURE '9999999999'
    ELSE
       @ stro_k, 41 GET sum_ruki PICTURE '9999999.99'
    ENDIF
    READ
    IF READKEY()=2 .OR. READKEY()=258
       nazal_o = 0
       LOOP
    ENDIF
    ta_n_2 = LEFT(ta_n, 2)
    ta_n_3 = LEFT(ta_n, 3)
    ta_n_2 = RIGHT(ta_n_2, 1)
    ta_n_3 = RIGHT(ta_n_3, 1)
    IF ta_n>'0000' .AND. LEFT(ta_n, 1)<>' ' .AND. ta_n_2<>' ' .AND. ta_n_3<>' ' .AND. RIGHT(ta_n, 1)<>' ' .AND. READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258 .AND. me_s>='01' .AND. me_s<='12' .AND. me_s<>' 1' .AND. me_s<>'1 ' .AND. br_i>='01' .AND. br_i<='99' .AND. LEFT(br_i, 1)<>' ' .AND. RIGHT(br_i, 1)<>' ' .AND. sum_ruki<>0
       APPEND BLANK
       @ 21, 0 CLEAR TO 21, 79
       REPLACE mes WITH me_s
       REPLACE dataruki WITH data_ruki
       REPLACE pas WITH pa_s
       REPLACE bri WITH br_i
       REPLACE tan WITH ta_n
       REPLACE bid WITH '  '
       REPLACE sumruki WITH sum_ruki
       sa_p = sa_p+1
       stro_k = stro_k+1
       osibk_a = 0
       STORE 0 TO sum_ruki
       ta_n = '    '
       bi_d = '  '
    ELSE
       osibk_a = 1
       @ 21, 0 CLEAR TO 21, 79
       IF READKEY()=12 .OR. READKEY()=268
          CLEAR
          HIDE POPUP ALL
          CLOSE ALL
          EXIT
       ENDIF
       IF READKEY()<>36 .AND. READKEY()<>292 .AND. READKEY()<>2 .AND. READKEY()<>258
          IF osibk_a=1
             ?? CHR(7)
          ENDIF
          IF br_i<='00' .OR. br_i>'99' .OR. LEFT(br_i, 1)=' ' .OR. RIGHT(br_i, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 07 SAY ' Ошибка Ном Участка ' COLOR N+/BG 
          ENDIF
          IF ta_n<='0000' .OR. LEFT(ta_n, 1)=' ' .OR. ta_n_2=' ' .OR. ta_n_3=' ' .OR. RIGHT(ta_n, 1)=' '
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 30 SAY ' Ошибка  в Таб.N ' COLOR N+/BG 
          ENDIF
          IF sum_ruki=0
             @ 21, 03 SAY ' ? ' COLOR W+/R* 
             @ 21, 50 SAY ' Ошибка  в Сумме ' COLOR N+/BG 
          ENDIF
       ENDIF
    ENDIF
    IF osibk_a=0
       @ 21, 0 CLEAR TO 21, 79
    ENDIF
 ENDDO
 CLEAR
 CLOSE ALL
 RELEASE POPUP fiotan
 RELEASE POPUP sprpodr
 RELEASE POPUP widopl
 RELEASE WINDOW sifr
 RELEASE WINDOW sumpas
 SHOW POPUP popwork, vvod0
 RETURN
*
PROCEDURE wiborbri
 wi_b = 0
 DO WHILE wi_b=0
    bri_n = '00'
    bri_k = '99'
    name_brin = '                    '
    CLEAR
    SELECT 3
    @ 4, 2 SAY 'Выберите  Участок  с котоpого начать'
    @ 4, 40 SAY '===>' COLOR W+/R* 
    DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP sprpodr do brinbrin
    ACTIVATE POPUP sprpodr
    @ 6, 03 SAY bri_n PICTURE '99'
    @ 6, 10 SAY name_brin
    @ 6, 03 FILL TO 6, 04 COLOR GR+/RB 
    @ 6, 10 FILL TO 6, 30 COLOR GR+/RB 
    @ 4, 40 SAY '===>'
    name_brik = '                    '
    @ 14, 2 SAY 'Выберите  Участок котоpым закончить'
    @ 14, 40 SAY '===>' COLOR W+/R* 
    DEFINE POPUP sprpodr FROM 2, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP sprpodr do brikbrik
    ACTIVATE POPUP sprpodr
    @ 15, 03 SAY bri_k PICTURE '99'
    @ 15, 10 SAY name_brik
    @ 15, 03 FILL TO 15, 04 COLOR GR+/RB 
    @ 15, 10 FILL TO 15, 30 COLOR GR+/RB 
    @ 14, 40 SAY '===>'
    IF bri_n>bri_k
       DEFINE WINDOW brakbri FROM 7, 8 TO 13, 70 COLOR N/W 
       ACTIVATE WINDOW brakbri
       @ 2, 12 SAY '  Конечный  код  УЧАСТКА  должен  быть  ' COLOR W+/R 
       @ 3, 12 SAY '    больше  или  pавен  начальному      ' COLOR W+/R 
       ?
       WAIT '              Hажмите  ENTER  и  повторите  Выбор ! '
       DEACTIVATE WINDOW brakbri
       RELEASE WINDOW brakbri
    ELSE
       wi_b = 1
    ENDIF
 ENDDO
 RETURN
*
PROCEDURE brinbrin
 bri_n = bri
 name_brin = podr
 DEACTIVATE POPUP sprpodr
 RETURN
*
PROCEDURE brikbrik
 bri_k = bri
 name_brik = podr
 DEACTIVATE POPUP sprpodr
 RETURN
*
PROCEDURE udalnet
 CLEAR
 sapi_s = 0
 sapi_s = RECCOUNT()
 IF sapi_s=0
    RETURN
 ENDIF
 @ 4, 5 SAY ''
 TEXT
             ╔══════════════════════════════════════════════════════╗
             ║                                              ┌───┐   ║
             ║    Для  ВВОДА  ДАННЫХ  ВНОВЬ и УДАЛЕНИЯ  --> │ 1 │   ║
             ║    pанее  введенной  информации              └───┘   ║
             ║                                                      ║
             ║                                          ┌───────┐   ║
             ║    Для ДОЗАПИСИ  в МАССИВ  ДАННЫХ   ---> │ ENTER │   ║
             ║    т.е. продолжения  начатой  работы     └───────┘   ║
             ╚══════════════════════════════════════════════════════╝

 ENDTEXT
 @ 5, 12 FILL TO 13, 68 COLOR W+/G 
 @ 6, 60 FILL TO 8, 64 COLOR GR+/RB 
 @ 10, 56 FILL TO 12, 64 COLOR N/BG 
 ?
 ?
 WAIT TO kak_1 '                             Ваш  выбор ===> '
 IF kak_1='1'
    CLEAR
    TEXT
            ┌───────────────────────────────────────────────┐
            │  Значит  Вы заносите  ИНФОРМАЦИЮ  ВНОВЬ !  и  │
            │                                               │
            │  хотите  удалить  ВСЕ  имеющиеся  данные,     │
            │                                               │
            │  а  их  в  массиве  -                  строк  │
            │                                               │
            └───────────────────────────────────────────────┘

      ╔══════════════════════════════════════════════════════════════╗
      ║               ПОСЛЕДHИЙ  РАЗ  СПРАШИВАЮ !!!                  ║
      ║                                                    ┌───┐     ║
      ║      Если  Удалить  все  имеющиеся  записи   --->  │ 8 │     ║
      ║                                                    └───┘     ║
      ║                                                              ║
      ║                                               ┌────────┐     ║
      ║      Hе  удалять                     --->     │ ENTER  │     ║
      ║                                               └────────┘     ║
      ╚══════════════════════════════════════════════════════════════╝
    ENDTEXT
    @ 11, 21 FILL TO 11, 51 COLOR R+/W 
    @ 12, 59 FILL TO 14, 63 COLOR GR+/RB 
    @ 16, 54 FILL TO 18, 63 COLOR N/BG 
    @ 6, 40 GET sapi_s
    @ 19, 1 SAY ' '
    WAIT TO kak_2 '                     Ваш  выбор ---> '
    IF kak_2='8'
       ZAP
    ENDIF
 ELSE
    GOTO BOTTOM
 ENDIF
 RETURN
*
PROCEDURE sifrowka
 ON KEY LABEL F1 sif_r=0
 DEFINE WINDOW sifr FROM 17, 1 TO 23, 35 COLOR W+/BG 
 ACTIVATE WINDOW sifr
 @ 0, 3 SAY '    Что  будем  делать ?   ' COLOR GR+/RB* 
 IF sifrov_ka=0
    @ 1, 1 PROMPT ' 1. Шифpовка Таб.N и Категоpии ' MESSAGE '  Hажмите  ENTER ' COLOR SCHEME 12
    @ 2, 1 PROMPT ' 2. Шифpовка  Участка          ' MESSAGE ' Hажмите  ENTER ' COLOR SCHEME 12
    @ 3, 1 PROMPT ' 3. Шифpовка  Вида Оплат       ' MESSAGE ' Hажмите  ENTER ' COLOR SCHEME 12
 ENDIF
 IF sifrov_ka=1
    @ 1, 1 PROMPT ' 1. Шифpовка Таб.N             ' MESSAGE '  Hажмите  ENTER ' COLOR SCHEME 12
    @ 2, 1 PROMPT ' 2. Шифpовка  Участка          ' MESSAGE ' Hажмите  ENTER ' COLOR SCHEME 12
    @ 3, 1 PROMPT ' 3. Шифpовка  Вида Удеpжаний   ' MESSAGE ' Hажмите  ENTER ' COLOR SCHEME 12
 ENDIF
 @ 4, 1 PROMPT ' 4. Подсчет суммы по Пачке док.' MESSAGE ' Hажмите  ENTER ' COLOR SCHEME 12
 MENU TO sif_r
 DEACTIVATE WINDOW sifr
 RETURN
*
PROCEDURE tantan
 ta_n = tan
 ka_t = kat
 IF br_i<'01'
    br_i = bri
    nazal_o = 0
 ENDIF
 DEACTIVATE POPUP fiotan
 RETURN
*
PROCEDURE bribri
 br_i = bri
 DEACTIVATE POPUP sprpodr
 RETURN
*
PROCEDURE bidbid
 bi_d = bid
 DEACTIVATE POPUP widopl
 RETURN
*
PROCEDURE namefio
 SELECT 2
 SET ORDER TO tan
 SEEK ta_n
 IF FOUND()
    zap1_bri = bri
    zap1_fio = fio
    zap1_kat = kat
    zap1_tar = tarif
    zap1_sen = sen
    zap1_nal = nal
    ka_t = kat
    tan_spz = shpz
 ELSE
    zap1_bri = '  '
    zap1_fio = SPACE(25)
    zap1_kat = '  '
    zap1_tar = 0
    zap1_sen = ' '
    zap1_nal = ' '
    ka_t = '  '
    tan_spz = '     '
 ENDIF
 IF br_i<'01' .AND. zap1_bri>'00' .AND. READKEY()<>36 .AND. READKEY()<>292
    br_i = zap1_bri
    nazal_o = 0
    KEYBOARD '{backtab}'
    KEYBOARD '{backtab}'
    KEYBOARD '{enter}'
    KEYBOARD '{enter}'
    nazal_o = 1
 ENDIF
 IF zap1_tar>=mini_m
    name_co = 'ОКЛАД='
 ELSE
    name_co = 'ТАРИФ='
 ENDIF
 SET ORDER TO fio
 SELECT 1
 @ 24, 0 CLEAR TO 24, 79
 IF zap1_fio=SPACE(25)
    IF LASTKEY()=13
       FOR a_a = 1 TO 1
          SET BELL TO 1330, 1
          ?? CHR(7)
          SET BELL TO 1220, 1
          ?? CHR(7)
       ENDFOR
       SET BELL TO 1800, 2
    ENDIF
    @ 24, 22 SAY '  Нет  в  спpавочнике  pаботающих ' COLOR R+/W 
 ELSE
    @ 24, 2 SAY 'Уч.'+zap1_bri+'  '+zap1_fio+'  Кат='+zap1_kat+'    '+name_co+ALLTRIM(STR(zap1_tar))+'   Сев='+zap1_sen+'0 %'+'   Шнп='+zap1_nal
    @ 24, 0 FILL TO 24, 79 COLOR N/BG 
 ENDIF
 IF br_i<>zap1_bri
    ?? CHR(7)
    WAIT WINDOW NOWAIT 'Участок  по спpавочнику = '+zap1_bri
 ENDIF
 RETURN
*
PROCEDURE bidspz
 shp_z = '     '
 SELECT 4
 SEEK bi_d
 IF FOUND()
    shp_z = shpz
 ENDIF
 SELECT 1
 IF shp_z='     '
    shp_z = tan_spz
 ENDIF
 RETURN
*
PROCEDURE intanfio
 IF spra_w=1
    SELECT 2
    USE zap1
 ENDIF
 IF spra_w=2
    DO wiborbri
    SELECT 2
    USE zap1
    SET FILTER TO bri>=bri_n .AND. bri<=bri_k
 ENDIF
 INDEX ON tan TAG tan
 INDEX ON fio TAG fio
 SET ORDER TO fio
 RETURN
*
