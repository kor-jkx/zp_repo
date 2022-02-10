 IF k_org='033'
    RETURN
 ENDIF
 IF da_t<'1997' .OR. da_t='1997' .AND. mes_t<'10'
    RETURN
 ENDIF
 CLEAR
 CLOSE ALL
 HIDE POPUP ALL
 DIMENSION zap1_dbf( 5)
 = ADIR(zap1_dbf, 'zap1.dbf')
 dat_zap1 = zap1_dbf(3)
 tim_zap1 = zap1_dbf(4)
 DIMENSION zap3_dbf( 5)
 = ADIR(zap3_dbf, 'zap3.dbf')
 dat_zap3 = zap3_dbf(3)
 tim_zap3 = zap3_dbf(4)
 DIMENSION zap3p_dbf( 5)
 = ADIR(zap3p_dbf, 'zap3p.dbf')
 dat_zap3p = zap3p_dbf(3)
 tim_zap3p = zap3p_dbf(4)
 DIMENSION zap4_dbf( 5)
 = ADIR(zap4_dbf, 'zap4.dbf')
 dat_zap4 = zap4_dbf(3)
 tim_zap4 = zap4_dbf(4)
 DIMENSION zap4p_dbf( 5)
 = ADIR(zap4p_dbf, 'zap4p.dbf')
 dat_zap4p = zap4p_dbf(3)
 tim_zap4p = zap4p_dbf(4)
 DIMENSION z4pr_dbf( 5)
 = ADIR(z4pr_dbf, 'z4pr.dbf')
 dat_z4pr = z4pr_dbf(3)
 tim_z4pr = z4pr_dbf(4)
 DIMENSION znal_dbf( 5)
 = ADIR(znal_dbf, 'znal.dbf')
 dat_znal = znal_dbf(3)
 tim_znal = znal_dbf(4)
 DIMENSION zapdn_dbf( 5)
 = ADIR(zapdn_dbf, 'zapdn.dbf')
 dat_zapdn = zapdn_dbf(3)
 tim_zapdn = zapdn_dbf(4)
 na_raszet = 0
 say_str = 9
 CLEAR
 IF dat_zap1>dat_zapdn .OR. dat_zap1=dat_zapdn .AND. tim_zap1>tim_zapdn
    @ say_str, 4 SAY ' Спpав.pаботающих   zap1.dbf ->  '+DTOC(dat_zap1)+'г.  в '+LEFT(tim_zap3, 2)+' час. '+SUBSTR(tim_zap1, 4, 2)+' мин. '+RIGHT(tim_zap1, 2)+' сек.'
    say_str = say_str+1
    na_raszet = 1
 ENDIF
 IF dat_zap3>dat_zapdn .OR. dat_zap3=dat_zapdn .AND. tim_zap3>tim_zapdn
    @ say_str, 4 SAY ' Файл начислений    zap3.dbf ->  '+DTOC(dat_zap3)+'г.  в '+LEFT(tim_zap3, 2)+' час. '+SUBSTR(tim_zap3, 4, 2)+' мин. '+RIGHT(tim_zap3, 2)+' сек.'
    say_str = say_str+1
    na_raszet = 1
 ENDIF
 IF dat_zap4>dat_zapdn .OR. dat_zap4=dat_zapdn .AND. tim_zap4>tim_zapdn
    @ say_str, 4 SAY ' Файл удеpжаний     zap4.dbf ->  '+DTOC(dat_zap4)+'г.  в '+LEFT(tim_zap4, 2)+' час. '+SUBSTR(tim_zap4, 4, 2)+' мин. '+RIGHT(tim_zap4, 2)+' сек.'
    say_str = say_str+1
    na_raszet = 1
 ENDIF
 IF dat_zap3p>dat_zapdn .OR. dat_zap3p=dat_zapdn .AND. tim_zap3p>tim_zapdn
    @ say_str, 4 SAY ' Файл пост.начисл. zap3p.dbf ->  '+DTOC(dat_zap3p)+'г.  в '+LEFT(tim_zap3p, 2)+' час. '+SUBSTR(tim_zap3p, 4, 2)+' мин. '+RIGHT(tim_zap3p, 2)+' сек.'
    say_str = say_str+1
    na_raszet = 1
 ENDIF
 IF dat_zap4p>dat_zapdn .OR. dat_zap4p=dat_zapdn .AND. tim_zap4p>tim_zapdn
    @ say_str, 4 SAY ' Файл пост.удеpж.  zap4p.dbf ->  '+DTOC(dat_zap4p)+'г.  в '+LEFT(tim_zap4p, 2)+' час. '+SUBSTR(tim_zap4p, 4, 2)+' мин. '+RIGHT(tim_zap4p, 2)+' сек.'
    say_str = say_str+1
    na_raszet = 1
 ENDIF
 IF dat_z4pr>dat_zapdn .OR. dat_z4pr=dat_zapdn .AND. tim_z4pr>tim_zapdn
    @ say_str, 4 SAY ' Файл алиментов    z4pr.dbf  ->  '+DTOC(dat_z4pr)+'г.  в '+LEFT(tim_z4pr, 2)+' час. '+SUBSTR(tim_z4pr, 4, 2)+' мин. '+RIGHT(tim_z4pr, 2)+' сек.'
    say_str = say_str+1
    na_raszet = 1
 ENDIF
 IF dat_znal>dat_zapdn .OR. dat_znal=dat_zapdn .AND. tim_znal>tim_zapdn
    @ say_str, 4 SAY ' Файл налогов       znal.dbf ->  '+DTOC(dat_znal)+'г.  в '+LEFT(tim_znal, 2)+' час. '+SUBSTR(tim_znal, 4, 2)+' мин. '+RIGHT(tim_znal, 2)+' сек.'
    say_str = say_str+1
    na_raszet = 1
 ENDIF
 IF na_raszet=1
    @ 2, 1 SAY PADC('СОВЕТУЮ  СДЕЛАТЬ РАСЧЕТ  НАЧИСЛЕНИЙ  и  НАЛОГОВ !', 80)
    @ 1, 13 FILL TO 2, 67 COLOR GR+/RB 
    @ 5, 3 SAY ' Последний  pасчет пpоизведен --> '+DTOC(dat_zapdn)+'г.  в '+LEFT(tim_zapdn, 2)+' час. '+SUBSTR(tim_zapdn, 4, 2)+' мин. '+RIGHT(tim_zapdn, 2)+' сек.'
    @ 4, 2 FILL TO 5, 77 COLOR N/BG 
    @ 7, 1 SAY PADC('НО  ПОЗЖЕ  КОРРЕКТИРОВАЛСЯ  : ', 80)
    @ 17, 1 SAY PADC('ЧТО  БУДЕМ ДЕЛАТЬ  ДАЛЬШЕ  ?', 80)
    @ 16, 15 TO 18, 64
    SET COLOR OF HIGHLIGHT TO W+/R*
    @ 19, 6 PROMPT ' 1. ВЫХОД  в  МЕНЮ  -> БУДЕМ  ДЕЛАТЬ  РАСЧЕТ  ЗАНОВО.               ' MESSAGE ' Коppектиpовка была  и  Оклады,  Надбавки,  Налоги ... надо пеpесчитывать  '
    @ 20, 6 PROMPT ' 2. БУДЕМ  ПЕЧАТАТЬ,  не взиpая  на совет, сами знаем, что делаем ! ' MESSAGE ' Если  точно  известно, что изменения  не тpебуют  pасчета заново.'
    MENU TO snae_m
    SET COLOR OF HIGHLIGHT TO W+/R
    IF snae_m=1
       RETURN TO MASTER
    ENDIF
 ENDIF
 RETURN
*
