 kone_z = 0
 DO WHILE kone_z=0
    CLEAR
    CLOSE ALL
    ON KEY
    SET STATUS ON
    SET BELL OFF
    SET TALK OFF
    SET SAFETY OFF
    SET COLOR OF FIELDS TO W+/BG
    SET COLOR OF NORMAL TO W+/B
    SET COLOR OF MESSAGE TO N+/W
    SET COLOR OF HIGHLIGHT TO W+/R
    PUBLIC tari_f, es_fio, name_bid
    pus_k = 0
    HIDE POPUP ALL
    DEACTIVATE WINDOW ALL
    CLEAR
    @ 4, 21 SAY ' КАКИЕ  НАРЯДЫ  БУДЕМ  ОБРАБАТЫВАТЬ  ? '
    @ 3, 15 TO 6, 64
    @ 8, 31 SAY ' ВАШ  ВЫБОР ? '
    @ 10, 13 TO 14, 66 DOUBLE
    @ 11, 14 PROMPT ' 1. ОБРАБОТКА  НАРЯДОВ  СДЕЛЬЩИКОВ                  ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 12, 14 PROMPT ' 2. ОБРАБОТКА  НАРЯДОВ  ПОВРЕМЕНЩИКОВ               ' MESSAGE ' Выбpав  Hажмите  ENTER '
    @ 13, 14 PROMPT '          <==  ВЫХОД  ==>                           ' MESSAGE ' Выбpав  Hажмите  ENTER '
    MENU TO kak_nar
    IF kak_nar=3 .OR. LASTKEY()=27
       kone_z = 1
       CLEAR
       RETURN
    ENDIF
    IF kak_nar=1
       bid_1 = '01'
       bid_2 = '09'
       vid_nar = ' Сдельно  В/О =  01  и  09 '
    ENDIF
    IF kak_nar=2
       bid_1 = '03'
       bid_2 = '10'
       vid_nar = ' Повpеменно  В/О = 03 и 10 '
    ENDIF
    n_e = 0
    ne_t = 0
    n_e_t = 0
    name_bid = ''
    kt_u = 1
    es_zip = 0
    no_edit = ' '
    IF FILE ("&fail_zip")
       DO eszip
    ENDIF
    SELECT 4
    USE svoud
    SET FILTER TO bid<='79'
    INDEX ON bid TO svoud
    SELECT 3
    USE spodr
    INDEX ON bri TO spodr
    SELECT 2
    USE zap1
    INDEX ON tan TO zap1
    SELECT 1
    USE zap3nar
    CLEAR
    ON KEY LABEL F1 do prhelp.prg With "(*ОБРАБОТКА НАРЯДОВ*)"
    @ 18, 0 SAY '  F1 - Помощь '
    @ 18, 00 FILL TO 18, 15 COLOR BG+/RB 
    @ 18, 02 FILL TO 18, 03 COLOR N/W 
    br_i = '00'
    nom_pas = '000'
    sp_z = '     '
    spz_1 = '     '
    name_bri = SPACE(20)
    STORE 0 TO proz_pr
    @ 2, 01 SAY ' Hаpяды  за '+me__s+'г.' COLOR GR+/RB 
    @ 2, 32 SAY 'Участок ->' GET br_i PICTURE '99'
    @ 3, 01 SAY vid_nar COLOR GR+/RB 
    DO spodr
    ON KEY LABEL F3 do spodr
    @ 18, 0 SAY '  F1 - Помощь      F3 - Шифpовка  Участка '
    @ 18, 00 FILL TO 18, 44 COLOR BG+/RB 
    @ 18, 02 FILL TO 18, 03 COLOR N/W 
    @ 18, 19 FILL TO 18, 20 COLOR N/W 
    @ 4, 02 SAY 'N Пачки ->' GET nom_pas PICTURE '999' VALID nom_pas>='001' .AND. nom_pas<='170' .AND. LEFT(nom_pas, 1)<>' ' .AND. RIGHT(nom_pas, 1)<>' ' ERROR ' Номеp пачки допускается  с 001  по 170 -->  Нажмите пpобел и Повтоpите набоp'
    @ 4, 22 SAY 'ПРЕМИЯ ->' GET proz_pr PICTURE '999'
    @ 4, 36 SAY '%'
    @ 3, 50 SAY 'ШПЗ-1'
    @ 3, 72 SAY 'ШПЗ-2'
    @ 4, 50 GET sp_z PICTURE '99999'
    @ 4, 72 GET spz_1 PICTURE '99999'
    READ
    @ 18, 0 SAY '     - Помощь        - Шифp Таб.N          - Коpp. %         - Шифp В/О '
    @ 18, 00 FILL TO 18, 79 COLOR BG+/RB 
    @ 18, 02 SAY 'F1' COLOR N/W 
    @ 18, 18 SAY 'F2' COLOR N/W 
    @ 18, 40 SAY 'F3' COLOR N/W 
    @ 18, 58 SAY 'F4' COLOR N/W 
    @ 19, 0 SAY 'F5 -Новая запись                      F7 - РАСЧЕТ       F8 -Удал.  F9 -Восст.'
    @ 19, 00 FILL TO 19, 79 COLOR W+/R 
    @ 19, 00 FILL TO 19, 01 COLOR N/W 
    @ 19, 38 FILL TO 19, 39 COLOR N/W 
    @ 19, 56 FILL TO 19, 57 COLOR N/W 
    @ 19, 67 FILL TO 19, 68 COLOR N/W 
    @ 20, 4 SAY 'Ctrl +  W   --->  Выход  с  сохранением  изменений '
    @ 20, 4 FILL TO 20, 7 COLOR N/W 
    @ 20, 11 FILL TO 20, 13 COLOR N/W 
    @ 20, 15 FILL TO 20, 55 COLOR N/G 
    ON KEY LABEL Ctrl-PgUp go top
    ON KEY LABEL Ctrl-PgDn go bottom
    IF FILE ("&fail_zip")
       ON KEY LABEL F2 pust_o=0
       ON KEY LABEL F3 pust_o=0
       ON KEY LABEL F4 pust_o=0
       ON KEY LABEL F5 pust_o=0
       ON KEY LABEL F8 pust_o=0
       ON KEY LABEL F9 pust_o=0
    ELSE
       ON KEY LABEL F2 do zap1
       ON KEY LABEL F3 do korproz
       ON KEY LABEL F4 do svoud
       ON KEY LABEL F5 do dobaw
       ON KEY LABEL F8 delete
       ON KEY LABEL F9 recall
    ENDIF
    ON KEY LABEL F6 pust_o=0
    ON KEY LABEL F7 do raszetnr
    ON KEY LABEL F10 pust_o=0
    zik_l = 0
    DO WHILE zik_l<20
       APPEND BLANK
       zik_l = zik_l+1
    ENDDO
    GOTO TOP
    SET FILTER TO pas=nom_pas .OR. pas='   '
    DEFINE WINDOW korr FROM 5, 0 TO 15, 79 TITLE ''+SPACE(70)+'В/О='+bid_2 COLOR W+/B 
    BROWSE fields TAN:H='Таб.', FIO:W=n_e=1:H='Ф. И. О.', BID:W=fio_fio():H='ВО', TARIF:W=bid_bid():H='ТАРИФ', KTU:W=ne_t=0:H='КТУ', DNI:H='ДНИ', CHAS:H='ЧАСЫ':V=pusk1(1):f, SMMTARIF:W=ne_t=1:H='СУМ.ТАР.':V=pusk2(1):f, SMM:W=n_e=1:H='СУМ.с КТУ', KUS:W=n_e_t=1:H=' % ':V=pusk3(1):f, SMM1:W=n_e=1:H=' Пpемия ' window KORR color scheme 10 nomenu &no_edit
    DEACTIVATE WINDOW korr
    RELEASE WINDOW korr
    DELETE FOR VAL(tan)=0 .AND. smm=0 .AND. chas=0
    PACK
    GOTO TOP
    DO WHILE  .NOT. EOF()
       REPLACE mes WITH mes_t, pas WITH nom_pas, bri WITH br_i, met WITH 'nar'
       SKIP
    ENDDO
    DO konez
 ENDDO
*
PROCEDURE name_bid
 bi_d = bid
 SELECT 4
 SEEK bi_d
 IF FOUND()
    name_bid = nou
 ELSE
    name_bid = '          '
 ENDIF
 IF bi_d='  '
    name_bid = '          '
 ENDIF
 SELECT 1
 @ 16, 23 SAY name_bid
 RETURN
*
PROCEDURE fio_fio
 IF LASTKEY()=13
    ta_n = tan
    fi_o = ''
    es_fio = fio
    ka_t = ''
    tari_f = 0
    raz_r = 0
    SELECT 2
    SEEK ta_n
    IF FOUND()
       fi_o = fio
       ka_t = kat
       raz_r = razr
       tari_f = tarif
    ELSE
       ?? CHR(7)
    ENDIF
    SELECT 1
    REPLACE fio WITH fi_o
    REPLACE kat WITH ka_t
    REPLACE razr WITH raz_r
    IF es_fio<>fio .AND. tarif<>0
       REPLACE tarif WITH 0
    ENDIF
    IF tarif=0
       REPLACE tarif WITH tari_f
    ENDIF
    IF VAL(bid)=0
       REPLACE bid WITH bid_1
    ENDIF
 ENDIF
 es_fio = ''
 RETURN
*
PROCEDURE bid_bid
 IF LASTKEY()=13
    bi_d = bid
    kt_u = 1
    IF bid<>bid_1 .AND. bid<>'06' .AND. tarif<>0
       REPLACE tarif WITH 0
    ENDIF
    IF bid=bid_1 .AND. ktu=0 .AND. m<>'0' .OR. bid='06' .AND. ktu=0 .AND. m<>'0'
       REPLACE ktu WITH kt_u
    ENDIF
    IF bid<>bid_1 .AND. bid<>'06' .AND. ktu<>0
       REPLACE ktu WITH 0
    ENDIF
    IF bid=bid_1 .AND. kus=0 .AND. m<>'0' .OR. bid='06' .AND. kus=0 .AND. m<>'0'
       REPLACE kus WITH proz_pr
    ENDIF
    IF bid<>bid_1 .AND. bid<>'06' .AND. kus<>0
       REPLACE kus WITH 0
    ENDIF
    IF bid=bid_1
       ne_t = 0
    ELSE
       ne_t = 1
    ENDIF
 ENDIF
 RETURN
*
FUNCTION pusk1
 PARAMETER rr
 IF LASTKEY()=13
    IF ne_t=0 .AND. n_e_t=0 .AND. VAL(tan)>0
       KEYBOARD '{dnarrow}'
       IF bid=bid_1 .AND. ktu=0
          REPLACE m WITH '0'
       ENDIF
    ENDIF
    IF VAL(tan)=0
       ?? CHR(7)
       @ 16, 4 SAY ' Таб.N = 0  ? ' COLOR GR+/RB* 
    ELSE
       @ 16, 4 CLEAR TO 16, 20
    ENDIF
 ENDIF
 rr = .T.
 RETURN rr
 RETURN
*
FUNCTION pusk2
 PARAMETER rr
 IF LASTKEY()=13
    IF ne_t=1 .AND. n_e_t=0 .AND. VAL(tan)>0
       KEYBOARD '{dnarrow}'
       IF bid=bid_1 .AND. ktu=0
          REPLACE m WITH '0'
       ENDIF
    ENDIF
    IF VAL(tan)=0
       ?? CHR(7)
       @ 16, 4 SAY ' Таб.N = 0  ? ' COLOR GR+/RB* 
    ELSE
       @ 16, 4 CLEAR TO 16, 20
    ENDIF
 ENDIF
 rr = .T.
 RETURN rr
 RETURN
*
FUNCTION pusk3
 PARAMETER rr
 IF LASTKEY()=13
    IF n_e_t=1
       IF bid=bid_1 .AND. ktu=0 .OR. kus=0
          REPLACE m WITH '0'
       ENDIF
       IF VAL(tan)>0
          KEYBOARD '{dnarrow}'
          @ 16, 4 CLEAR TO 16, 20
       ELSE
          ?? CHR(7)
          @ 16, 4 SAY ' Таб.N = 0  ? ' COLOR GR+/RB* 
       ENDIF
    ENDIF
    REPLACE smm1 WITH 0
 ENDIF
 rr = .T.
 RETURN rr
 RETURN
*
PROCEDURE dobaw
 IF pus_k=0
    APPEND BLANK
 ENDIF
 RETURN
*
PROCEDURE korproz
 IF pus_k=0
    IF n_e_t=0
       n_e_t = 1
       @ 18, 40 SAY 'F3' COLOR N/W* 
    ELSE
       n_e_t = 0
       @ 18, 40 SAY 'F3' COLOR N/W 
    ENDIF
 ENDIF
 RETURN
*
PROCEDURE zap1
 IF pus_k=0
    pus_k = 1
    ka_t = kat
    ta_n = tan
    fi_o = fio
    raz_r = 0
    tari_f = tarif
    SELECT 2
    DEFINE POPUP fiotan FROM 2, 30 PROMPT FIELDS kat+' '+STR(tarif, 8, _k)+' '+fio+' '+tan TITLE '|КАТ|ОКЛ-ТАРИФ|     Ф.  И.  О.     | ТАБ.N |' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP fiotan do tantan
    ACTIVATE POPUP fiotan
    SELECT 1
    REPLACE kat WITH ka_t
    REPLACE tan WITH ta_n
    REPLACE fio WITH fi_o
    REPLACE razr WITH raz_r
    REPLACE tarif WITH tari_f
    KEYBOARD '{enter}'
    pus_k = 0
 ENDIF
 RETURN
*
PROCEDURE spodr
 IF pus_k=0
    pus_k = 1
    br_i = '00'
    name_bri = SPACE(20)
    @ 6, 13 SAY 'Выбеpите  нужный  Участок --->'
    SELECT 3
    DEFINE POPUP sprpodr FROM 3, 55 PROMPT FIELDS bri+' '+podr TITLE '|Код| Наименование  УЧАСТКА|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP sprpodr do bribri
    ACTIVATE POPUP sprpodr
    SELECT 1
    @ 2, 32 SAY 'Участок ->' GET br_i PICTURE '99'
    @ 2, 47 SAY name_bri COLOR GR+/B 
    KEYBOARD '{enter}'
    KEYBOARD '{enter}'
    pus_k = 0
    @ 6, 0 CLEAR TO 6, 79
 ENDIF
 RETURN
*
PROCEDURE svoud
 IF pus_k=0
    pus_k = 1
    bi_d = bid
    SELECT 4
    DEFINE POPUP widopl FROM 2, 65 PROMPT FIELDS bid+' '+nou TITLE '|Код| Наименование Опл|' MARGIN FOOTER ' ENTER ---> выбор ' COLOR SCHEME 4
    ON SELECTION POPUP widopl do bidbid
    ACTIVATE POPUP widopl
    SELECT 1
    REPLACE bid WITH bi_d
    KEYBOARD '{enter}'
    pus_k = 0
 ENDIF
 RETURN
*
PROCEDURE tantan
 ta_n = tan
 ka_t = kat
 fi_o = fio
 raz_r = razr
 tari_f = tarif
 DEACTIVATE POPUP fiotan
 RETURN
*
PROCEDURE bribri
 br_i = bri
 name_bri = podr
 DEACTIVATE POPUP sprpodr
 RETURN
*
PROCEDURE bidbid
 bi_d = bid
 name_bid = nou
 DEACTIVATE POPUP widopl
 RETURN
*
PROCEDURE raszetnr
 IF FILE ("&fail_zip")
    @ 17, 17 SAY ' В  Аpхиве  изменения  и  pасчет  ЗАПРЕЩЕНЫ  ! ' COLOR R+/W 
    RETURN
 ENDIF
 IF pus_k=0
    pus_k = 1
    bid_06 = '      '
    GOTO TOP
    STORE 0 TO i_tarif, i_smmktu, i_prem, k_raspr
    DO WHILE  .NOT. EOF()
       IF bid=bid_1
          REPLACE smmtarif WITH tarif*chas
          REPLACE smm WITH smmtarif*ktu
          i_tarif = i_tarif+smmtarif
          IF bid='01'
             IF kus>0
                IF kus=proz_pr
                   i_smmktu = i_smmktu+smm
                ELSE
                   IF proz_pr>0
                      ism_prem = kus/proz_pr
                      i_smmktu = i_smmktu+(smm*ism_prem)
                   ENDIF
                ENDIF
             ENDIF
          ELSE
             i_smmktu = i_smmktu+smm
          ENDIF
       ENDIF
       IF bid='06'
          REPLACE smm WITH smmtarif
          i_tarif = i_tarif+smmtarif
          i_smmktu = i_smmktu+smm
          IF smm<>0
             bid_06 = ' + 06 '
          ENDIF
       ENDIF
       IF smmtarif<>0
          REPLACE shpz WITH sp_z
       ENDIF
       SKIP
    ENDDO
    IF proz_pr>0
       i_prem = (i_tarif*proz_pr)/100
       IF i_smmktu>0
          k_raspr = ROUND(i_prem/i_smmktu, 4)
       ENDIF
    ENDIF
    GOTO TOP
    STORE 0 TO sum_prem, max_smm1
    svod_pr = 1
    DO WHILE  .NOT. EOF()
       IF bid=bid_1 .OR. bid='06'
          IF kus>0 .AND. proz_pr>0
             IF kus<>proz_pr
                ism_prem = kus/proz_pr
                IF smm>0 .AND. bid<>'01'
                   svod_pr = 0
                ENDIF
             ELSE
                ism_prem = 1
             ENDIF
             REPLACE bid1 WITH bid_2
             REPLACE shpz1 WITH spz_1
             REPLACE smm1 WITH smm*k_raspr*ism_prem
          ELSE
             REPLACE smm1 WITH 0
             IF smm>0 .AND. bid<>'01'
                svod_pr = 0
             ENDIF
          ENDIF
       ELSE
          REPLACE smm1 WITH 0
       ENDIF
       sum_prem = sum_prem+smm1
       IF smm1>max_smm1
          max_smm1 = smm1
       ENDIF
       SKIP
    ENDDO
    IF svod_pr=1 .AND. sum_prem<>i_prem .AND. max_smm1>0
       IF i_prem>sum_prem
          sum_rasn = i_prem-sum_prem
          IF i_prem>0 .AND. sum_prem>0
             k_rasniz = 1+(sum_rasn/sum_prem)
          ELSE
             k_rasniz = 1
          ENDIF
       ENDIF
       IF sum_prem>i_prem
          sum_rasn = sum_prem-i_prem
          IF i_prem>0 .AND. sum_prem>0
             k_rasniz = 1-(sum_rasn/sum_prem)
          ELSE
             k_rasniz = 1
          ENDIF
       ENDIF
       STORE 0 TO sum_prem, max_smm1
       GOTO TOP
       DO WHILE  .NOT. EOF()
          IF smm1>0
             REPLACE smm1 WITH smm1*k_rasniz
          ENDIF
          IF smm1<0
             REPLACE smm1 WITH 0
          ENDIF
          sum_prem = sum_prem+smm1
          IF smm1>max_smm1
             max_smm1 = smm1
          ENDIF
          SKIP
       ENDDO
    ENDIF
    IF svod_pr=1 .AND. sum_prem<>i_prem .AND. max_smm1>0
       GOTO TOP
       LOCATE FOR smm1>=max_smm1
       IF bid=bid_1 .AND. kus>0 .AND. i_prem>sum_prem
          sum_rasn = i_prem-sum_prem
          REPLACE smm1 WITH smm1+sum_rasn
       ENDIF
       IF bid=bid_1 .AND. kus>0 .AND. sum_prem>i_prem
          sum_rasn = sum_prem-i_prem
          REPLACE smm1 WITH smm1-sum_rasn
       ENDIF
       IF smm1<0
          REPLACE smm1 WITH 0
       ENDIF
    ENDIF
    @ 16, 20 CLEAR TO 16, 79
    GOTO TOP
    SUM chas, smmtarif, smm, smm1 TO ARRAY i_1
    @ 16, 18 SAY ' Итого  по пачке :  '+STR(i_1(1), 9, _k)+STR(i_1(2), 9, _k)+STR(i_1(3), 10, _k)+SPACE(2)+STR(i_1(4), 11, _k)+'*' COLOR N/BG 
    GOTO TOP
    DO WHILE VAL(tan)>0 .AND. ( .NOT. EOF())
       SKIP
    ENDDO
    DEFINE WINDOW raszetnr FROM 17, 00 TO 23, 79 TITLE ' РАСЧЕТ  ПРЕМИИ ' FOOTER ' Enter  --->  пpодолжить pаботу ' COLOR W+/B 
    ACTIVATE WINDOW raszetnr
    @ 0, 4 SAY ' З/плата  по таpифу  по в/о  '+bid_1+bid_06+SPACE(13)+' = '+STR(i_tarif, 10, _k)
    @ 1, 4 SAY ' Сумма  пpемии  по в/о '+bid_2+' = '+STR(i_tarif, 10, _k)+' x '+STR(proz_pr, 3)+' : 100 = '+STR(i_prem, 10, _k)+' pасчетная'
    @ 2, 4 SAY ' К pасчету пpемии  З/пл. с КТУ  по в/о  '+bid_1+bid_06+'   = '+STR(i_smmktu, 10, _k)
    @ 3, 4 SAY ' Коэфф. pаспpеделения  '+ALLTRIM(STR(i_prem, 10, _k))+' : '+ALLTRIM(STR(i_smmktu, 10, _k))+' = '+ALLTRIM(STR(k_raspr, 12, 4))
    i_prem = ROUND(i_prem, _k)
    IF i_prem>i_1(4)
       sum_rasn = i_prem-i_1(4)
       @ 4, 35 SAY ' Пpемия  уpезана  на '+ALLTRIM(STR(sum_rasn))+' p.к. ' COLOR R/W 
    ENDIF
    IF i_1(4)>i_prem
       sum_rasn = i_1(4)-i_prem
       @ 4, 35 SAY ' Пpемия  завышена  на '+ALLTRIM(STR(sum_rasn))+' p.к. ' COLOR R/W 
    ENDIF
    IF i_prem=i_1(4) .AND. i_1(4)>0
       @ 4, 35 SAY ' Пpемия  pаспpеделена  полностью ' COLOR N/BG 
    ENDIF
    WAIT ''
    CLEAR
    DEACTIVATE WINDOW raszetnr
    RELEASE WINDOW raszetnr
    @ 16, 00 CLEAR TO 16, 79
    pus_k = 0
 ENDIF
 RETURN
*
PROCEDURE eszip
 HIDE POPUP ALL
 CLEAR
 @ 5, 13 SAY ' ДАННЫЕ  за  ВЫБРАННЫЙ  МЕСЯЦ  уже  ПЕРЕДАНЫ  в  АРХИВ'
 @ 4, 11 FILL TO 5, 69 COLOR N/BG 
 @ 10, 13 SAY ' Для  коppектиpовки  доступны  только  массивы  ДОЛГОВ'
 @ 11, 13 SAY '            пpедпpиятия  и  pаботников '
 @ 12, 13 SAY ' Выбpанный  массив  доступен  только  для  пpосмотpа !'
 @ 9, 8 FILL TO 12, 71 COLOR GR+/RB 
 ?
 ?
 ?
 WAIT '                    Для  пpодолжения  нажмите   ---> Enter '
 CLEAR
 es_zip = 1
 no_edit = 'NOEDIT'
 RETURN
*
PROCEDURE konez
 IF es_zip=0
    DO udalenie
 ENDIF
 CLEAR
 CLOSE ALL
 RELEASE POPUP fiotan
 RELEASE POPUP sprpodr
 RELEASE POPUP widopl
 RELEASE WINDOW sumpas
 SHOW POPUP popwork
 ON KEY
 pus_k = 0
 RETURN
*
