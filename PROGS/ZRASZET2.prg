 CLOSE ALL
 SET TALK OFF
 SET SAFETY OFF
 SET STATUS ON
 CLEAR
 @ 8, 1 SAY PADC('Идет  подготовка  файлов   к  pасчету', 80)
 @ 9, 1 SAY PADC('Севеpных  надбавок  и  Налогов   ...', 80)
 @ 7, 15 FILL TO 10, 65 COLOR N/BG 
 USE zap4
 DELETE ALL FOR pas>'370'
 PACK
 COPY TO zapdn STRUCTURE
 USE znal
 DELETE ALL FOR mes>=mes_t .AND. m<>'W'
 PACK
 USE zap3
 DELETE ALL FOR pas>'199'
 PACK
 COPY TO zapds STRUCTURE
 APPEND FROM zap1 FIELDS bri, kat, tan
 CLOSE ALL
 SELECT 8
 USE z4pr
 SET FILTER TO kus>0 .OR. chisl>0 .AND. znam>0
 INDEX ON tan TO z4pr
 SELECT 7
 USE znal
 INDEX ON tan+mes TO znal
 SELECT 6
 USE svoud
 INDEX ON bid TO svoud
 SELECT 5
 USE zap1
 INDEX ON tan TO zap1
 SELECT 4
 USE zap4
 INDEX ON tan+bid TO zap4
 SELECT 3
 USE zapdn
 ZAP
 SELECT 2
 USE zapds
 ZAP
 SELECT 1
 USE zap3
 INDEX ON tan+shpz+bid TO zap3
 SET STATUS OFF
 CLEAR
 @ 4, 30 GET or__g
 @ 7, 15 SAY ' Идет  Расчет  Севеpных  Надбавок  и  Налогов ...'
 @ 6, 10 FILL TO 7, 70 COLOR GR+/RB 
 @ 9, 16 TO 11, 59
 @ 9, 16 FILL TO 11, 59 COLOR N+/G 
 @ 10, 18 SAY REPLICATE(CHR(177), 40)
 a_a = 0
 IF RECCOUNT()<>0
    b_b = INT(RECCOUNT()/40)
    c_c = 18
    GOTO TOP
    DO WHILE  .NOT. EOF()
       tan_mes_t = '000000'
       tan_1 = tan
       ka_t = kat
       pro_f = prof
       SELECT 5
       SEEK tan_1
       se_n = sen
       na_l = nal
       IF da_t>'1997'
          nal_dop = naldop
          IF na_l<'9'
             na_l = VAL(na_l)*2+VAL(nal_dop)
             na_l = STR(na_l, 1)
          ENDIF
       ELSE
          nal_dop = ''
       ENDIF
       br_i = bri
       br_i1 = bri
       prof_z = profz
       fi_o = fio
       SELECT 1
       a_8 = 0
       IF br_i='  '
          a_8 = 1
       ENDIF
       sum_v = mini_m*VAL(na_l)
       tan_mes_t = '000000'
       STORE 0 TO doh_sk, sum_sk, vsg_d, s_n, s_pf, s_al, s_is, s_sr, smm_1, wosvrat_pn
       STORE 0 TO pk_1, sn_1, pf_1, pod_osnd, pod_1920, pod_nal, nal_82, al_1, sow_dox
       STORE 0 TO sn_tekmes
       STORE 0 TO s_ps_osd
       STORE 0 TO s_ps_nad
       STORE 0 TO ps_osdox
       STORE 0 TO ps_1920
       DO WHILE tan_1=tan .AND.  .NOT. EOF()
          shp_z = shpz
          STORE 0 TO s_pk, s_sn, pk_11, sn_11
          DO WHILE shpz=shp_z .AND. tan=tan_1 .AND.  .NOT. EOF()
             IF smm>smm_1
                smm_1 = smm
                IF kat>'00'
                   ka_t = kat
                ENDIF
                IF prof>'000'
                   pro_f = prof
                ENDIF
                IF a_8=1
                   IF bri>'00'
                      br_i = bri
                   ENDIF
                ENDIF
             ENDIF
             me_s = mes
             bi_d = bid
             sm_m = smm
             SELECT 6
             SEEK bi_d
             IF FOUND()
                IF vsd='1' .AND. bi_d<'79'
                   sow_dox = sow_dox+sm_m
                ENDIF
                IF pk='1'
                   s_pk = s_pk+sm_m
                ENDIF
                IF sn='1'
                   s_sn = s_sn+sm_m
                ENDIF
                IF pf='1'
                   IF prof_z='1'
                      s_pf = s_pf+sm_m
                   ENDIF
                ENDIF
                IF ps='1'
                   IF bi_d='19' .OR. bi_d='20'
                      s_ps_nad = s_ps_nad+sm_m
                   ELSE
                      s_ps_osd = s_ps_osd+sm_m
                   ENDIF
                ENDIF
                IF al='1'
                   s_al = s_al+sm_m
                ENDIF
                IF is='1'
                   s_is = s_is+sm_m
                ENDIF
                IF sr='1'
                   s_sr = s_sr+sm_m
                ENDIF
                IF pn='1'
                   IF bi_d='19' .OR. bi_d='20'
                      s_n = s_n+sm_m
                   ELSE
                      IF ksk>0
                         doh_sk = sm_m
                         sum_sk = min_sr*ksk
                      ELSE
                         vsg_d = vsg_d+sm_m
                      ENDIF
                   ENDIF
                ENDIF
                IF pn='0' .AND. bi_d<'79'
                   vsg_d = vsg_d+sm_m
                   sum_v = sum_v+sm_m
                   SELECT 7
                   APPEND BLANK
                   REPLACE god WITH da_t
                   REPLACE mes WITH mes_t, tan WITH tan_1, bri WITH br_i
                   REPLACE bid WITH bi_d, sumv WITH sm_m
                ENDIF
             ENDIF
             SELECT 1
             SKIP
             a_a = a_a+1
             IF a_a>b_b
                @ 10, c_c SAY CHR(219)
                c_c = c_c+1
                a_a = 0
             ENDIF
             IF EOF()
                DO WHILE c_c<58
                   @ 10, c_c SAY CHR(219)
                   c_c = c_c+1
                ENDDO
             ENDIF
          ENDDO
          SELECT 2
          IF s_pk<>0
             pk_11 = ROUND(s_pk*0.2 , 2)
             pk_1 = pk_1+pk_11
             sow_dox = sow_dox+pk_11
             APPEND BLANK
             REPLACE mes WITH mes_t, pas WITH 'pk', kat WITH ka_t, tan WITH tan_1
             REPLACE prof WITH pro_f, smm WITH pk_11, bri WITH br_i, bid WITH '19'
             REPLACE shpz WITH shp_z, m WITH 'R'
          ENDIF
          IF s_sn<>0
             sn_11 = ROUND(s_sn*VAL(se_n)/10, 2)
             sn_1 = sn_1+sn_11
             sow_dox = sow_dox+sn_11
             APPEND BLANK
             REPLACE mes WITH mes_t, pas WITH 'sn', kat WITH ka_t, tan WITH tan_1
             REPLACE prof WITH pro_f, smm WITH sn_11, bri WITH br_i, bid WITH '20'
             REPLACE shpz WITH shp_z, m WITH 'R'
          ENDIF
          SELECT 1
       ENDDO
       s_n = s_n+pk_1+sn_1
       sn_tekmes = s_n
       s_ps_nad = s_ps_nad+pk_1+sn_1
       IF s_sr>0
          s_sr = s_sr+pk_1+sn_1
       ENDIF
       IF prof_z='1'
          s_pf = s_pf+pk_1+sn_1
       ENDIF
       SELECT 3
       IF s_pf>0
          pf_1 = ROUND(s_pf*0.01 , 2)
          APPEND BLANK
          REPLACE mes WITH mes_t, pas WITH 'pf', tan WITH tan_1, bid WITH '93'
          REPLACE smm WITH pf_1, bri WITH br_i, m WITH 'R'
       ENDIF
       IF s_ps_osd>0
          ps_osdox = ROUND(s_ps_osd*0.01 , 2)
          APPEND BLANK
          REPLACE mes WITH mes_t, pas WITH 'ps', tan WITH tan_1, bid WITH '85'
          REPLACE smm WITH ps_osdox, bri WITH br_i, m WITH 'R'
       ENDIF
       IF s_ps_nad>0
          ps_1920 = ROUND(s_ps_nad*0.01 , 2)
          APPEND BLANK
          REPLACE mes WITH mes_t, pas WITH 'ps', tan WITH tan_1, bid WITH '85'
          REPLACE smm WITH ps_1920, bri WITH br_i, m WITH 'R'
       ENDIF
       SELECT 7
       IF s_ps_osd>0
          APPEND BLANK
          REPLACE god WITH da_t
          REPLACE mes WITH mes_t, tan WITH tan_1, bri WITH br_i, m WITH '1'
          REPLACE bid WITH '85', sumv WITH ps_osdox
       ENDIF
       IF s_ps_nad>0
          APPEND BLANK
          REPLACE god WITH da_t
          REPLACE mes WITH mes_t, tan WITH tan_1, bri WITH br_i, m WITH '2'
          REPLACE bid WITH '85', sumv WITH ps_1920
       ENDIF
       sum_v = sum_v+ps_osdox+ps_1920
       SELECT 4
       SEEK tan_1
       STORE 0 TO sum_pn
       DO WHILE tan=tan_1 .AND. ( .NOT. EOF())
          IF bid='82'
             sum_pn = sum_pn+smm
          ENDIF
          SKIP
       ENDDO
       SELECT 7
       SEEK tan_1
       STORE 0 TO u_n, sk_znal, skid_ost, i_ps1920
       vs_mes = vsg_d
       DO WHILE tan=tan_1 .AND. mes<mes_t .AND. ( .NOT. EOF()) .OR. tan=tan_1 .AND. mes=mes_t .AND. m='W' .AND. ( .NOT. EOF())
          vsg_d = vsg_d+vsgd
          sk_znal = sk_znal+sumskid
          s_n = s_n+sn
          sum_v = sum_v+sumv
          u_n = u_n+un
          SKIP
       ENDDO
       IF u_n<0
          u_n = 0
       ENDIF
       IF sum_sk>0
          skid_ost = sum_sk-sk_znal
          IF skid_ost<0
             skid_ost = 0
          ENDIF
          IF skid_ost>doh_sk
             skid_ost = doh_sk
          ENDIF
          IF doh_sk>skid_ost
             vsg_d = vsg_d+(doh_sk-skid_ost)
             vs_mes = vs_mes+(doh_sk-skid_ost)
          ENDIF
       ENDIF
       IF na_l='9'
          STORE 0 TO pod_osnd, pod_1920, pod_nal
       ELSE
          IF vsg_d-sum_v>0
             IF s_n>0
                i_ps1920 = ROUND(s_n*0.01 , 2)
                sum_v = sum_v-i_ps1920
             ENDIF
             IF vsg_d-sum_v>=stavka_51
                pod_osnd = tvsum_4+ROUND(vsg_d-sum_v-stavka_42, 0)*proc_5
             ENDIF
             IF vsg_d-sum_v>=stavka_41 .AND. vsg_d-sum_v<=stavka_42
                pod_osnd = tvsum_3+ROUND(vsg_d-sum_v-stavka_32, 0)*proc_4
             ENDIF
             IF vsg_d-sum_v>=stavka_31 .AND. vsg_d-sum_v<=stavka_32
                pod_osnd = tvsum_2+ROUND(vsg_d-sum_v-stavka_22, 0)*proc_3
             ENDIF
             IF vsg_d-sum_v>=stavka_21 .AND. vsg_d-sum_v<=stavka_22
                pod_osnd = tvsum_1+ROUND(vsg_d-sum_v-stavka_1, 0)*proc_2
             ENDIF
             IF vsg_d-sum_v<=stavka_1
                pod_osnd = ROUND(vsg_d-sum_v, 0)*proc_1
             ENDIF
             pod_1920 = ROUND(s_n-i_ps1920, 0)*proc_1
             pod_nal = ROUND(pod_osnd+pod_1920-u_n, 0)
          ELSE
             pod_nal = ROUND(ROUND(vsg_d-sum_v+s_n, 0)*proc_1-u_n, 0)
          ENDIF
          IF pod_nal<0
             pod_nal = 0
             wosvrat_pn = 0
          ENDIF
       ENDIF
       APPEND BLANK
       REPLACE god WITH da_t
       REPLACE mes WITH mes_t
       REPLACE tan WITH tan_1
       REPLACE bri WITH br_i
       REPLACE nal WITH na_l
       REPLACE naldop WITH nal_dop
       REPLACE valsowdox WITH sow_dox
       REPLACE vsgd WITH vs_mes
       REPLACE dohskid WITH doh_sk
       REPLACE sumskid WITH skid_ost
       REPLACE sn WITH sn_tekmes
       REPLACE un WITH pod_nal
       REPLACE sred WITH s_sr
       REPLACE fio WITH fi_o
       tan_mes_t = tan+mes
       IF na_l='9'
          REPLACE sumv WITH sow_dox
       ELSE
          REPLACE sumv WITH VAL(na_l)*mini_m
       ENDIF
       SELECT 3
       IF pod_nal<>0
          nal_82 = pod_nal-sum_pn
          APPEND BLANK
          REPLACE pas WITH 'pn', tan WITH tan_1, bri WITH br_i, bid WITH '82'
          REPLACE mes WITH mes_t, smm WITH nal_82, m WITH 'R'
       ENDIF
       SELECT 8
       SEEK tan_1
       IF FOUND()
          DO WHILE tan=tan_1 .AND.  .NOT. EOF()
             IF LEFT(pas, 1)='A'
                IF kus<>0
                   al_1 = ROUND((s_al+sn_1+pk_1-nal_82)*kus/100, 2)
                ELSE
                   al_1 = ROUND((s_al+sn_1+pk_1-nal_82)*chisl/znam, 2)
                ENDIF
                b_d = '88'
             ENDIF
             IF LEFT(pas, 1)='B'
                IF kus<>0
                   al_1 = ROUND((s_al-nal_82)*kus/100, 2)
                ELSE
                   al_1 = ROUND((s_al-nal_82)*chisl/znam, 2)
                ENDIF
                b_d = '88'
             ENDIF
             IF LEFT(pas, 1)='I'
                IF kus<>0
                   al_1 = ROUND((s_is+sn_1+pk_1)*kus/100, 2)
                ELSE
                   al_1 = ROUND((s_is+sn_1+pk_1)*chisl/znam, 2)
                ENDIF
                IF bid='87'
                   b_d = '87'
                ELSE
                   b_d = '84'
                ENDIF
             ENDIF
             pa_ss = pas
             SELECT 3
             IF al_1>0
                APPEND BLANK
                REPLACE mes WITH mes_t, pas WITH pa_ss, tan WITH tan_1, bid WITH b_d
                REPLACE smm WITH al_1, bri WITH br_i, m WITH 'R'
                IF b_d='88'
                   SELECT 7
                   SEEK tan_mes_t
                   LOCATE REST FOR tan=tan_1 .AND. mes=mes_t .AND. bid='  '
                   IF FOUND()
                      REPLACE aliment WITH al_1
                   ENDIF
                ENDIF
             ENDIF
             SELECT 8
             SKIP
          ENDDO
       ENDIF
       SELECT 1
    ENDDO
 ENDIF
 SELECT 3
 USE
 SELECT 2
 USE
 SELECT 1
 CLEAR
 @ 7, 21 SAY ' К начислениям  в массив  zap3.dbf '
 @ 8, 21 SAY 'подсоединяюся  pасчетные  суммы  ...'
 @ 7, 15 FILL TO 8, 63 COLOR N/BG 
 APPEND FROM zapds
 CLEAR
 @ 7, 14 SAY '       К начислениям  в массив  zap3.dbf '
 @ 8, 14 SAY ' подсоединяюся " копейки "  из  пpошлого  месяца  ...'
 @ 9, 14 SAY '   ( это  остатки  pублей  до сотни  zap79.dbf ) '
 @ 6, 10 FILL TO 10, 70 COLOR N/BG 
 append from C:\ZARPLATA\&star_kat\zap79.dbf
 CLEAR
 @ 9, 9 SAY ' Идет  удаление  Пустых  записей  в  начислениях   zap3.dbf  ....'
 @ 8, 5 FILL TO 9, 75 COLOR GR+/RB 
 DELETE FOR smm=0 .AND. dni=0 .AND. chas=0 .AND. kus=0 .AND. bid='  '
 PACK
 SELECT 4
 CLEAR
 @ 7, 17 SAY 'К удеpжаниям  в массив  zap4.dbf  подсоединяются :'
 @ 8, 1 SAY ''
 @ 9, 18 SAY '- pасчетные  суммы'
 @ 10, 18 SAY '- постоянные  удеpжания  из  zap4p.dbf'
 @ 11, 18 SAY '- долги pаботников  из пpошлого месяца  zap92.dbf'
 @ 6, 10 FILL TO 12, 70 COLOR N/BG 
 APPEND FROM zapdn
 APPEND FROM zap4p
 append from C:\ZARPLATA\&star_kat\zap92.dbf
 CLEAR
 @ 9, 9 SAY ' Идет  удаление  Нулевых  записей  в  удержаниях   zap4.dbf  ....'
 @ 8, 5 FILL TO 9, 75 COLOR GR+/RB 
 DELETE FOR smm=0
 PACK
 CLOSE ALL
 DO zraszet4
 USE zapdn
 REPLACE dataoper WITH CTOD(z_m_g)
 WAIT TIMEOUT 0.2 ''
 CLOSE ALL
 SET STATUS ON
 RETURN
*
