 CLOSE ALL
 CLEAR
 @ 7, 18 SAY '  Идет  pасчет  Сумм  почтового  сбоpа '
 @ 8, 18 SAY ' на  пеpечисление  Алиментов  почтой  ...'
 @ 7, 15 FILL TO 8, 63 COLOR N/BG 
 SET TALK OFF
 USE zap4
 COPY TO poztsbor STRUCTURE
 USE poztsbor
 COPY TO poztsb STRUCTURE EXTENDED
 USE poztsb
 APPEND BLANK
 REPLACE field_name WITH 'SMMALIM'
 REPLACE field_type WITH 'N'
 REPLACE field_len WITH 8
 REPLACE field_dec WITH 2
 APPEND BLANK
 REPLACE field_name WITH 'PASS'
 REPLACE field_type WITH 'C'
 REPLACE field_len WITH 3
 REPLACE field_dec WITH 0
 APPEND BLANK
 REPLACE field_name WITH 'ADRES1'
 REPLACE field_type WITH 'C'
 REPLACE field_len WITH 22
 REPLACE field_dec WITH 0
 CREATE poztsbor FROM poztsb
 CLOSE ALL
 SELECT 3
 USE poztsbor
 SELECT 2
 USE z4pr
 SET FILTER TO sbor>0
 INDEX ON tan TO z4pr
 SELECT 1
 USE zap4
 SET FILTER TO bid='88' .AND. LEFT(pas, 1)='A' .OR. bid='88' .AND. LEFT(pas, 1)='B'
 INDEX ON tan TO poztsbor
 DO WHILE  .NOT. EOF()
    STORE 0 TO proz_sb, sum_sbor
    bi_d = bid
    br_i = bri
    ta_n = tan
    pa_s = pas
    smm_alim = smm
    SELECT 2
    SEEK ta_n
    LOCATE REST FOR tan=ta_n .AND. pas=pa_s
    IF FOUND()
       proz_sb = sbor
       adres_1 = adres1
    ENDIF
    SELECT 1
    IF proz_sb>0 .AND. smm>0
       sum_sbor = ROUND((smm*proz_sb)/100, 2)
    ENDIF
    IF sum_sbor>0
       SELECT 3
       APPEND BLANK
       REPLACE mes WITH mes_t, pas WITH 'psb', bri WITH br_i, bid WITH bi_d
       REPLACE tan WITH ta_n, smm WITH sum_sbor, m WITH 'R'
       REPLACE smmalim WITH smm_alim, adres1 WITH adres_1, pass WITH pa_s
    ENDIF
    SELECT 1
    SKIP
 ENDDO
 CLOSE ALL
 USE zap4
 APPEND FROM poztsbor
 CLOSE ALL
 CLEAR
 DELETE FILE poztsbor.idx
 DELETE FILE poztsb.dbf
 RETURN
*
