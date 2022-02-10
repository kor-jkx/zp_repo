 CLEAR
 CLOSE ALL
 @ 8, 12 SAY ' ПОДСОЕДИНЯЮТСЯ  ДАННЫЕ  НАРЯДОВ  в  ФАЙЛ  НАЧИСЛЕНИЙ '
 @ 10, 09 SAY '       из  файла  zap3nar.dbf   в   zap3.dbf   ...'
 SELECT 2
 USE zap3
 DELETE ALL FOR met='nar'
 PACK
 SELECT 1
 USE zap3nar
 GOTO TOP
 DO WHILE  .NOT. EOF()
    pa_s = pas
    me_s = mes
    br_i = bri
    ka_t = kat
    pro_f = prof
    ta_n = tan
    bi_d = bid
    tari_f = tarif
    dn_i = dni
    cha_s = chas
    smm_tarif = smmtarif
    shp_z = shpz
    ku_s = kus
    me_t = met
    bid_1 = bid1
    smm_1 = smm1
    shpz_1 = shpz1
    SELECT 2
    IF VAL(ta_n)>0 .AND. smm_tarif<>0 .OR. VAL(ta_n)>0 .AND. dn_i>0 .OR. VAL(ta_n)>0 .AND. cha_s>0
       APPEND BLANK
       REPLACE pas WITH pa_s, mes WITH me_s, bri WITH br_i, kat WITH ka_t
       REPLACE prof WITH pro_f, tan WITH ta_n, bid WITH bi_d, tarif WITH tari_f
       REPLACE dni WITH dn_i, chas WITH cha_s, smm WITH smm_tarif, shpz WITH shp_z
       REPLACE met WITH me_t
    ENDIF
    IF VAL(ta_n)>0 .AND. smm_1<>0
       APPEND BLANK
       REPLACE pas WITH pa_s, mes WITH me_s, bri WITH br_i, kat WITH ka_t
       REPLACE prof WITH pro_f, tan WITH ta_n, bid WITH bid_1
       REPLACE smm WITH smm_1, shpz WITH shpz_1, kus WITH ku_s
       REPLACE met WITH me_t
    ENDIF
    SELECT 1
    SKIP
 ENDDO
 CLEAR
 @ 9, 20 SAY '       Вливание   Завершено  !!!'
 @ 8, 15 FILL TO 9, 65 COLOR GR+/RB 
 ?
 CLOSE ALL
 CLEAR
 RETURN
*
