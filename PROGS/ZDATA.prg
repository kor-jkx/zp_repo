 HIDE POPUP ALL
 SET DEFAULT TO C:\
 IF  .NOT. FILE('DOS'+'\fsnv.sys') .AND.  .NOT. FILE('TOLS'+'\fsnv.sys')
    CLEAR
    SET DEFAULT TO A:
    IF FILE('zarpl.app')
       RENAME A:\zarpl.app TO A:\3131533.tmp
       RUN erase A:\3131533.tmp
    ENDIF
    SET DEFAULT TO C:\ZARPLATA
    IF FILE('zarpl.app')
       RENAME C:\ZARPLATA\zarpl.app TO C:\ZARPLATA\3131533.tmp
       RUN erase C:\ZARPLATA\3131533.tmp
    ENDIF
    SET DEFAULT TO C:\FOX
    IF FILE('zarpl.app')
       RENAME C:\FOX\zarpl.app TO C:\FOX\3131533.tmp
       RUN erase C:\FOX\3131533.tmp
    ENDIF
    SET DEFAULT TO C:\FOXPRO
    IF FILE('zarpl.app')
       RENAME C:\FOXPRO\zarpl.app TO C:\FOXPRO\3131533.tmp
       RUN erase C:\FOXPRO\3131533.tmp
    ENDIF
    SET DEFAULT TO C:\
    IF FILE('zarpl.app')
       RENAME C:\zarpl.app TO C:\3131533.tmp
       RUN erase C:\3131533.tmp
    ENDIF
    QUIT
 ELSE
    SET DEFAULT TO C:\ZARPLATA
 ENDIF
 godte_k = 0
 ko_nez = 0
 DO WHILE ko_nez=0
    CLEAR PROGRAM
    USE mes
    IF godtek>1996
       godte_k = godtek
    ENDIF
    IF mestek>=1 .AND. mestek<=12
       meste_k = mestek
       m_e = mestek
    ELSE
       m_e = 1
    ENDIF
    CLOSE ALL
    SET COLOR OF HIGHLIGHT TO W+/R*
    CLEAR
    @ 7, 17 SAY '  За какой  Месяц и Год  будут '
    @ 8, 17 SAY ' pасчеты  или  машинограммы   ?    ===> '
    @ 6, 15 TO 9, 50
    @ 11, 14 SAY '  БЮДЬТЕ  АБСОЛЮТНО  ТОЧНЫ  в  ВЫБОРЕ '
    @ 4, 60 PROMPT ' Январь   ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Янваpь '
    @ 5, 60 PROMPT ' Февраль  ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Февраль'
    @ 6, 60 PROMPT ' Март     ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Март'
    @ 7, 60 PROMPT ' Апрель   ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Апрель'
    @ 8, 60 PROMPT ' Май      ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Май'
    @ 9, 60 PROMPT ' Июнь     ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Июнь'
    @ 10, 60 PROMPT ' Июль     ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Июль'
    @ 11, 60 PROMPT ' Август   ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Август'
    @ 12, 60 PROMPT ' Сентябрь ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Сентябрь'
    @ 13, 60 PROMPT ' Октябрь  ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Октябрь'
    @ 14, 60 PROMPT ' Hоябрь   ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Hоябрь'
    @ 15, 60 PROMPT ' Декабрь  ' MESSAGE ' Делайте выбоp стpелками,  Hажав  на  ENTER ===> будет выбpан Декабрь'
    @ 3, 58 TO 16, 71 DOUBLE
    MENU TO m_e
    SET COLOR OF HIGHLIGHT TO W+/R
    IF m_e<1 .OR. m_e>12
       @ 17, 26 SAY ' Не  выбpан  Месяц ! '
       @ 16, 20 FILL TO 17, 53 COLOR W+/R 
       ?
       WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
       LOOP
    ENDIF
    @ 15, 3 SAY '┌────┐'
    @ 16, 3 SAY '│Esc │ --->   Повторить  Выбор '
    @ 17, 3 SAY '└────┘'
    @ 15, 3 FILL TO 17, 8 COLOR N+/G 
    @ 16, 15 FILL TO 16, 34 COLOR GR+/RB 
    me__s = '   ?    '
    IF m_e=1
       me__s = 'Янваpь   '
    ENDIF
    IF m_e=2
       me__s = 'Февраль  '
    ENDIF
    IF m_e=3
       me__s = 'Март     '
    ENDIF
    IF m_e=4
       me__s = 'Апрель   '
    ENDIF
    IF m_e=5
       me__s = 'Май      '
    ENDIF
    IF m_e=6
       me__s = 'Июнь     '
    ENDIF
    IF m_e=7
       me__s = 'Июль     '
    ENDIF
    IF m_e=8
       me__s = 'Август   '
    ENDIF
    IF m_e=9
       me__s = 'Сентябрь '
    ENDIF
    IF m_e=10
       me__s = 'Октябрь  '
    ENDIF
    IF m_e=11
       me__s = 'Hоябрь   '
    ENDIF
    IF m_e=12
       me__s = 'Декабрь  '
    ENDIF
    SET CENTURY OFF
    SET DATE TO GERMAN
    z_m_g = DTOC(DATE())
    zas_min = LEFT(TIME(), 5)
    za_s = LEFT(TIME(), 2)
    mi_n = RIGHT(zas_min, 2)
    god_1 = '19'
    god_2 = RIGHT(z_m_g, 2)
    go_d = god_1+god_2
    IF godte_k>1996
       go_d = STR(godte_k, 4)
    ENDIF
    @ 17, 53 SAY ' Год --->' GET go_d
    STORE '00' TO d_1, d_2, d_3, d_d
    bra_k = 1
    DO WHILE bra_k=1
       @ 19, 18 SAY ' Какое  сегодня  Число. Месяц. Год   ---> ' GET z_m_g PICTURE '99.99.99'
       @ 21, 18 SAY '                  Московское  время   ==>    '+zas_min
       @ 21, 63 FILL TO 21, 67 COLOR N/W 
       READ
       d_1 = LEFT(z_m_g, 2)
       d_d = LEFT(z_m_g, 5)
       d_2 = RIGHT(d_d, 2)
       d_3 = RIGHT(z_m_g, 2)
       IF d_1<'01' .OR. d_1>'31' .OR. d_2<'01' .OR. d_2>'12' .OR. d_2='02' .AND. d_1>'29' .OR. d_2='04' .AND. d_1>'30' .OR. d_2='06' .AND. d_1>'30' .OR. d_2='09' .AND. d_1>'30' .OR. d_2='11' .AND. d_1>'30' .OR. d_3<'95' .OR. d_3>'99'
          @ 15, 18 SAY ' Вы  вводите  Hеверную  Дату  ? '
          @ 15, 15 FILL TO 15, 52 COLOR W+/R 
          bra_k = 1
       ELSE
          bra_k = 0
       ENDIF
    ENDDO
    da_tt = VAL(d_1+d_2+d_3)
    IF READKEY()=12 .OR. READKEY()=268
       LOOP
    ENDIF
    mes_t = STR(m_e, 2)
    mes_t = STRTRAN(mes_t, ' ', '0', 1)
    da_t = go_d
    me__s = me__s+da_t
    wib_mes = ' Идет  обpаботка  за '+me__s+'г.'
    katalo_g = 'ZARP'+mes_t+RIGHT(go_d, 2)
    IF m_e=1
       star_mes = '12'
       star_god = VAL(go_d)-1
       star_god = STR(star_god, 4)
       star_god = RIGHT(star_god, 2)
       star_god = STRTRAN(star_god, ' ', '0', 1)
       star_kat = 'ZARP'+star_mes+star_god
       star_zip = 'zarp'+star_mes+star_god+'.zip'
    ELSE
       star_mes = m_e-1
       star_mes = STR(star_mes, 2)
       star_mes = STRTRAN(star_mes, ' ', '0', 1)
       star_kat = 'ZARP'+star_mes+RIGHT(go_d, 2)
       star_zip = 'zarp'+star_mes+RIGHT(go_d, 2)+'.zip'
    ENDIF
    fail_zip = 'zarp'+mes_t+RIGHT(da_t, 2)+'.zip'
    CLEAR
    @ 5, 17 SAY ' Вы  выбpали  для  pаботы --->  '+me__s+'г.'
    @ 5, 48 FILL TO 5, 63 COLOR N/BG 
    @ 8, 23 SAY ' ЧТО  БУДЕМ  ДЕЛАТЬ  ДАЛЕЕ  ? '
    @ 10, 5 TO 13, 74 DOUBLE
    wib1_kat = 1
    @ 11, 6 PROMPT ' 1. НАЧАТЬ  РАБОТУ  С  ВЫБРАННЫМ  МЕСЯЦЕМ  и  ГОДОМ                 ' MESSAGE '  Hажав  на  ENTER  --->  начнете  pаботать  с указанным  месяцем. '
    @ 12, 6 PROMPT ' 2. ПЕРЕВЫБРАТЬ  ДРУГОЙ  МЕСЯЦ  и  ГОД                              ' MESSAGE ' Нажав  на  ENTER  ---> БУДЕТ  ПЕРЕВЫБОР  МЕСЯЦА '
    MENU TO wib1_kat
    IF wib1_kat=2
       LOOP
    ENDIF
    CLEAR
    IF  .NOT. FILE(katalo_g+'\zap1.dbf') .OR.  .NOT. FILE(katalo_g+'\zap3.dbf') .OR.  .NOT. FILE(katalo_g+'\zap4.dbf') .OR.  .NOT. FILE(katalo_g+'\zap3p.dbf') .OR.  .NOT. FILE(katalo_g+'\zap4p.dbf') .OR.  .NOT. FILE(katalo_g+'\z4pr.dbf') .OR.  .NOT. FILE(katalo_g+'\znal.dbf') .OR.  .NOT. FILE(katalo_g+'\svoud.dbf')
       @ 7, 12 SAY ' Вы  выбpали  новый  Месяц , Каталог  Не  сфоpмиpован  ! '
       @ 6, 10 FILL TO 7, 70 COLOR GR+/RB 
       @ 10, 5 TO 13, 74 DOUBLE
       @ 11, 6 PROMPT ' 1. СФОРМИРОВАТЬ  КАТАЛОГ  для  РАБОТЫ  с  НОВЫМ  МЕСЯЦЕМ           ' MESSAGE ' Нажав  на  ENTER --->  начнем  фоpмиpование Каталога '
       @ 12, 6 PROMPT ' 2. ВЫБОРКА  БЫЛА  ОШИБОЧНОЙ,  ПЕРЕВЫБРАТЬ  ДРУГОЙ  МЕСЯЦ  и  ГОД   ' MESSAGE ' Нажав  на  ENTER  ---> БУДЕТ  ПЕРЕВЫБОР  МЕСЯЦА '
       MENU TO wib2_kat
       IF wib2_kat=2
          LOOP
       ELSE
          IF  .NOT. FILE(star_kat+'\znal.dbf')
             CLEAR
             @ 7, 12 SAY '   Не существует  каталога  пpедыдущего  Месяца  ! '
             @ 8, 12 SAY ' Не возможно  создать  Каталог  для нового  месяца '
             @ 9, 12 SAY ' Веpоятно, Вы  не веpно  указали текущий  Месяц pасчетов'
             @ 6, 10 FILL TO 10, 70 COLOR GR+/RB 
             ?
             WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
             LOOP
          ELSE
             if .NOT. FILE(star_kat+'\&star_zip')
                CLEAR
                @ 7, 12 SAY '  Вы  НЕ  ПЕРЕДАЛИ  в  Аpхив  пpедыдущий  месяц ! '
                @ 8, 12 SAY 'Выбеpите  пpошедший  Месяц  и  пеpедайте  данные  в Аpхив'
                @ 9, 12 SAY 'только  тогда  Вы  сможете  сфоpмиpовать  новый  месяц.'
                @ 6, 10 FILL TO 10, 70 COLOR GR+/RB 
                ?
                WAIT '                  Для  пеpевыбоpа  нажмите   ---> Enter '
                LOOP
             ENDIF
             CLEAR
             @ 7, 12 SAY ' ИДЕТ  ПОДГОТОВКА  КАТАЛОГА  для  НОВОГО  МЕСЯЦА  '
             @ 6, 10 FILL TO 7, 70 COLOR N/BG 
             @ 9, 31 SAY ' ЖДИТЕ ... ' COLOR N/BG* 
             RUN MKDIR &katalo_g
             IF m_e=1
                IF  .NOT. FILE(katalo_g+'\znal.dbf')
                   use C:\ZARPLATA\&star_kat\znal.dbf
                   copy structure to C:\ZARPLATA\&katalo_g\znal.dbf
                   USE
                ENDIF
             ELSE
                IF  .NOT. FILE(katalo_g+'\znal.dbf')
                   copy file C:\ZARPLATA\&star_kat\znal.dbf to C:\ZARPLATA\&katalo_g\znal.dbf
                ENDIF
             ENDIF
             IF  .NOT. FILE(katalo_g+'\svoud.dbf')
                copy file C:\ZARPLATA\&star_kat\svoud.dbf to C:\ZARPLATA\&katalo_g\svoud.dbf
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap1.dbf')
                copy file C:\ZARPLATA\&star_kat\zap1.dbf to C:\ZARPLATA\&katalo_g\zap1.dbf
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zfond.dbf')
                copy file C:\ZARPLATA\&star_kat\zfond.dbf to C:\ZARPLATA\&katalo_g\zfond.dbf
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap3p.dbf')
                copy file C:\ZARPLATA\&star_kat\zap3p.dbf to C:\ZARPLATA\&katalo_g\zap3p.dbf
                use C:\ZARPLATA\&katalo_g\zap3p.dbf
                REPLACE mes WITH mes_t ALL
                USE
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap4p.dbf')
                copy file C:\ZARPLATA\&star_kat\zap4p.dbf to C:\ZARPLATA\&katalo_g\zap4p.dbf
                use C:\ZARPLATA\&katalo_g\zap4p.dbf
                DELETE FOR bid='82'
                PACK
                REPLACE mes WITH mes_t ALL
                USE
             ENDIF
             IF  .NOT. FILE(katalo_g+'\z4pr.dbf')
                copy file C:\ZARPLATA\&star_kat\z4pr.dbf to C:\ZARPLATA\&katalo_g\z4pr.dbf
                use C:\ZARPLATA\&katalo_g\z4pr.dbf
                REPLACE mes WITH mes_t ALL
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap3.dbf')
                use C:\ZARPLATA\&star_kat\zap3.dbf
                copy structure to C:\ZARPLATA\&katalo_g\zap3.dbf
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap4.dbf')
                use C:\ZARPLATA\&star_kat\zap4.dbf
                copy structure to C:\ZARPLATA\&katalo_g\zap4.dbf
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zapds.dbf')
                use C:\ZARPLATA\&star_kat\zapds.dbf
                copy structure to C:\ZARPLATA\&katalo_g\zapds.dbf   
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zapdn.dbf')
                use C:\ZARPLATA\&star_kat\zapdn.dbf
                copy structure to C:\ZARPLATA\&katalo_g\zapdn.dbf   
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap79.dbf')
                use C:\ZARPLATA\&star_kat\zap79.dbf
                copy structure to C:\ZARPLATA\&katalo_g\zap79.dbf
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap8.dbf')
                use C:\ZARPLATA\&star_kat\zap8.dbf
                copy structure to C:\ZARPLATA\&katalo_g\zap8.dbf
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap92.dbf')
                use C:\ZARPLATA\&star_kat\zap92.dbf
                copy structure to C:\ZARPLATA\&katalo_g\zap92.dbf
             ENDIF
             IF  .NOT. FILE(katalo_g+'\zap3nar.dbf')
                use C:\ZARPLATA\&star_kat\zap3nar.dbf
                copy structure to C:\ZARPLATA\&katalo_g\zap3nar.dbf
             ENDIF
             USE C:\ZARPLATA\mes.dbf
             REPLACE godtek WITH VAL(go_d), mestek WITH VAL(mes_t) ALL
             CLOSE ALL
          ENDIF
       ENDIF
    ELSE
    ENDIF
    ko_nez = 1
 ENDDO
 set default to C:\ZARPLATA\&katalo_g
 SET PATH TO C:\ZARPLATA;C:\ARHIV;C:\ARXIV
 IF da_t<'1998'
    _k = 0
 ELSE
    _k = 2
 ENDIF
 HIDE POPUP ALL
 CLOSE ALL
 USE spr
 mini_m = min1
 CLOSE ALL
 CLEAR
 RETURN
*
