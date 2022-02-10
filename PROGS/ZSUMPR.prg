 STORE 1 TO d, l
 STORE 0 TO v_21, v_22, v_23, v_24, v_25, v_26, v_27, v_28, v_29, v_30, v_31, v_32, v_33, v_34, v_35, v_36, v_37, v_38, v_39, v_40, v_41, v_42, v_43, v_44, v_45, v_46, v_47, v_50, v_51, v_52, v_53, v_54, v_55, v_56, v_57, v_58, k_1, k_2, k_3, k_4, k_5, k_6, k_7, z_1, z_2, z_3
 STORE '' TO s_1, s_2, s_3, s_4, s_5, s_6, s_7, a, b, c, d, z, t, pro_pis
 si_m = LTRIM(STR(a_a))
 po_r = LEN(si_m)
 DO CASE
    CASE po_r<=3
       STORE 1 TO zi_k, p_r
       a = si_m
    CASE po_r>3 .AND. po_r<=6
       STORE 2 TO zi_k, p_r
       a = RIGHT(si_m, 3)
       b = LEFT(si_m, po_r-3)
    CASE po_r>6 .AND. po_r<=9
       STORE 3 TO zi_k, p_r
       a = RIGHT(si_m, 3)
       b = LEFT(RIGHT(si_m, 6), 3)
       c = LEFT(si_m, po_r-6)
    CASE po_r>9 .AND. po_r<=12
       STORE 4 TO zi_k, p_r
       a = RIGHT(si_m, 3)
       b = LEFT(RIGHT(si_m, 6), 3)
       c = LEFT(RIGHT(si_m, 9), 3)
       d = LEFT(si_m, po_r-9)
 ENDCASE
 DO WHILE zi_k<>0
    DO CASE
       CASE zi_k=4
          x = d
       CASE zi_k=3
          x = c
       CASE zi_k=2
          x = b
       CASE zi_k=1
          x = a
    ENDCASE
    po_r = LEN(x)
    IF po_r=3
       z_1 = VAL(LEFT(x, 1))
       y = RIGHT(x, 2)
       z_2 = VAL(LEFT(y, 1))
       z_3 = VAL(RIGHT(x, 1))
    ENDIF
    IF po_r=2
       z_1 = VAL(LEFT(x, 1))
       z_2 = VAL(RIGHT(x, 1))
    ENDIF
    IF po_r=1
       z_1 = VAL(x)
    ENDIF
    DO CASE
       CASE zi_k=4 .AND. z_1=1
          t = ' миллиард'
       CASE zi_k=4 .AND. (z_1=2 .OR. z_1=3 .OR. z_1=4)
          t = ' миллиарда'
       CASE zi_k=4 .AND. (z_1=5 .OR. z_1=6 .OR. z_1=7 .OR. z_1=8 .OR. z_1=9)
          t = ' миллиардoв'
       CASE zi_k=3 .AND. (po_r=1 .AND. z_1=1 .OR. po_r=2 .AND. z_2=1 .OR. po_r=3 .AND. z_3=1)
          t = ' миллион'
       CASE zi_k=3 .AND. (po_r=1 .AND. (z_1=2 .OR. z_1=3 .OR. z_1=4) .OR. po_r=2 .AND. (z_2=2 .OR. z_2=3 .OR. z_2=4) .OR. po_r=3 .AND. (z_3=2 .OR. z_3=3 .OR. z_3=4))
          t = ' миллиона'
       CASE zi_k=3 .AND. (po_r=1 .AND. (z_1=5 .OR. z_1=6 .OR. z_1=7 .OR. z_1=8 .OR. z_1=9) .OR. po_r=2 .AND. (z_2=5 .OR. z_2=6 .OR. z_2=7 .OR. z_2=8 .OR. z_2=9 .OR. z_2=0) .OR. po_r=3 .AND. z_1+z_2+z_3<>0 .AND. (z_3=5 .OR. z_3=6 .OR. z_3=7 .OR. z_3=8 .OR. z_3=9 .OR. z_3=0))
          t = ' миллионов'
       CASE zi_k=2 .AND. (po_r=1 .AND. z_1=1 .OR. po_r=2 .AND. z_2=1 .OR. po_r=3 .AND. z_3=1)
          t = ' тысяча'
       CASE zi_k=2 .AND. (po_r=1 .AND. (z_1=2 .OR. z_1=3 .OR. z_1=4) .OR. po_r=2 .AND. (z_2=2 .OR. z_2=3 .OR. z_2=4) .OR. po_r=3 .AND. (z_3=2 .OR. z_3=3 .OR. z_3=4))
          t = ' тысячи'
       CASE zi_k=2 .AND. (po_r=1 .AND. (z_1=5 .OR. z_1=6 .OR. z_1=7 .OR. z_1=8 .OR. z_1=9 .OR. z_1=0) .OR. po_r=3 .AND. z_1+z_2+z_3<>0 .AND. (z_3=5 .OR. z_3=6 .OR. z_3=7 .OR. z_3=8 .OR. z_3=9 .OR. z_3=0) .OR. po_r=2 .AND. (z_2=5 .OR. z_2=6 .OR. z_2=7 .OR. z_2=8 .OR. z_2=9 .OR. z_2=0))
          t = ' тысяч'
       CASE zi_k=1 .AND. (po_r=1 .AND. (z_1=5 .OR. z_1=6 .OR. z_1=7 .OR. z_1=8 .OR. z_1=9) .OR. po_r=2 .AND. (z_2=5 .OR. z_2=6 .OR. z_2=7 .OR. z_2=8 .OR. z_2=9 .OR. z_2=0) .OR. po_r=3 .AND. (z_3=5 .OR. z_3=6 .OR. z_3=7 .OR. z_3=8 .OR. z_3=9 .OR. z_3=0)) .OR. (po_r=2 .AND. z_1=1 .OR. po_r=3 .AND. z_2=1)
          t = ' рублей.'
       CASE zi_k=1 .AND. (po_r=1 .AND. z_1=1 .OR. po_r=2 .AND. z_2=1 .OR. po_r=3 .AND. z_3=1)
          t = ' рубль.'
       CASE zi_k=1 .AND. (po_r=1 .AND. (z_1=2 .OR. z_1=3 .OR. z_1=4) .OR. po_r=2 .AND. (z_2=2 .OR. z_2=3 .OR. z_2=4) .OR. po_r=3 .AND. (z_3=2 .OR. z_3=3 .OR. z_3=4))
          t = ' рубля.'
    ENDCASE
    IF zi_k=2 .AND. po_r=2 .AND. z_1=1 .AND. (z_2=0 .OR. z_2=1 .OR. z_2=2 .OR. z_2=3 .OR. z_2=4 .OR. z_2=5 .OR. z_2=6 .OR. z_2=7 .OR. z_2=8 .OR. z_2=9)
       t = ' тысяч'
    ENDIF
    IF zi_k=2 .AND. po_r=3 .AND. z_2=1 .AND. (z_3=0 .OR. z_3=1 .OR. z_3=2 .OR. z_3=3 .OR. z_3=4 .OR. z_3=5 .OR. z_3=6 .OR. z_3=7 .OR. z_3=8 .OR. z_3=9)
       t = ' тысяч'
    ENDIF
    IF po_r=3
       DO CASE
          CASE z_1=1
             STORE 1 TO k_5, v_50
          CASE z_1=2
             STORE 1 TO k_5, v_51
          CASE z_1=3
             STORE 1 TO k_5, v_52
          CASE z_1=4
             STORE 1 TO k_5, v_53
          CASE z_1=5
             STORE 1 TO k_5, v_54
          CASE z_1=6
             STORE 1 TO k_5, v_55
          CASE z_1=7
             STORE 1 TO k_5, v_56
          CASE z_1=8
             STORE 1 TO k_5, v_57
          CASE z_1=9
             STORE 1 TO k_5, v_58
       ENDCASE
       z_1 = z_2
       z_2 = z_3
       po_r = 2
       DO propis
    ENDIF
    IF po_r=2
       DO CASE
          CASE z_1=1 .AND. z_2=0
             STORE 1 TO k_3, v_30
          CASE z_1=1 .AND. z_2=1
             STORE 1 TO k_3, v_31
          CASE z_1=1 .AND. z_2=2
             STORE 1 TO k_3, v_32
          CASE z_1=1 .AND. z_2=3
             STORE 1 TO k_3, v_33
          CASE z_1=1 .AND. z_2=4
             STORE 1 TO k_3, v_34
          CASE z_1=1 .AND. z_2=5
             STORE 1 TO k_3, v_35
          CASE z_1=1 .AND. z_2=6
             STORE 1 TO k_3, v_36
          CASE z_1=1 .AND. z_2=7
             STORE 1 TO k_3, v_37
          CASE z_1=1 .AND. z_2=8
             STORE 1 TO k_3, v_38
          CASE z_1=1 .AND. z_2=9
             STORE 1 TO k_3, v_39
          CASE z_1=2 .AND. z_2=0
             STORE 1 TO k_4, v_40
          CASE z_1=3 .AND. z_2=0
             STORE 1 TO k_4, v_41
          CASE z_1=4 .AND. z_2=0
             STORE 1 TO k_4, v_42
          CASE z_1=5 .AND. z_2=0
             STORE 1 TO k_4, v_43
          CASE z_1=6 .AND. z_2=0
             STORE 1 TO k_4, v_44
          CASE z_1=7 .AND. z_2=0
             STORE 1 TO k_4, v_45
          CASE z_1=8 .AND. z_2=0
             STORE 1 TO k_4, v_46
          CASE z_1=9 .AND. z_2=0
             STORE 1 TO k_4, v_47
          CASE z_1=2 .AND. z_2=1
             STORE 1 TO k_4, v_40, k_2, v_21
          CASE z_1=2 .AND. z_2=2
             STORE 1 TO k_4, v_40, k_2, v_22
          CASE z_1=2 .AND. z_2=3
             STORE 1 TO k_4, v_40, k_2, v_23
          CASE z_1=2 .AND. z_2=4
             STORE 1 TO k_4, v_40, k_2, v_24
          CASE z_1=2 .AND. z_2=5
             STORE 1 TO k_4, v_40, k_2, v_25
          CASE z_1=2 .AND. z_2=6
             STORE 1 TO k_4, v_40, k_2, v_26
          CASE z_1=2 .AND. z_2=7
             STORE 1 TO k_4, v_40, k_2, v_27
          CASE z_1=2 .AND. z_2=8
             STORE 1 TO k_4, v_40, k_2, v_28
          CASE z_1=2 .AND. z_2=9
             STORE 1 TO k_4, v_40, k_2, v_29
          CASE z_1=3 .AND. z_2=1
             STORE 1 TO k_4, v_41, k_2, v_21
          CASE z_1=3 .AND. z_2=2
             STORE 1 TO k_4, v_41, k_2, v_22
          CASE z_1=3 .AND. z_2=3
             STORE 1 TO k_4, v_41, k_2, v_23
          CASE z_1=3 .AND. z_2=4
             STORE 1 TO k_4, v_41, k_2, v_24
          CASE z_1=3 .AND. z_2=5
             STORE 1 TO k_4, v_41, k_2, v_25
          CASE z_1=3 .AND. z_2=6
             STORE 1 TO k_4, v_41, k_2, v_26
          CASE z_1=3 .AND. z_2=7
             STORE 1 TO k_4, v_41, k_2, v_27
          CASE z_1=3 .AND. z_2=8
             STORE 1 TO k_4, v_41, k_2, v_28
          CASE z_1=3 .AND. z_2=9
             STORE 1 TO k_4, v_41, k_2, v_29
          CASE z_1=4 .AND. z_2=1
             STORE 1 TO k_4, v_42, k_2, v_21
          CASE z_1=4 .AND. z_2=2
             STORE 1 TO k_4, v_42, k_2, v_22
          CASE z_1=4 .AND. z_2=3
             STORE 1 TO k_4, v_42, k_2, v_23
          CASE z_1=4 .AND. z_2=4
             STORE 1 TO k_4, v_42, k_2, v_24
          CASE z_1=4 .AND. z_2=5
             STORE 1 TO k_4, v_42, k_2, v_25
          CASE z_1=4 .AND. z_2=6
             STORE 1 TO k_4, v_42, k_2, v_26
          CASE z_1=4 .AND. z_2=7
             STORE 1 TO k_4, v_42, k_2, v_27
          CASE z_1=4 .AND. z_2=8
             STORE 1 TO k_4, v_42, k_2, v_28
          CASE z_1=4 .AND. z_2=9
             STORE 1 TO k_4, v_42, k_2, v_29
          CASE z_1=5 .AND. z_2=1
             STORE 1 TO k_4, v_43, k_2, v_21
          CASE z_1=5 .AND. z_2=2
             STORE 1 TO k_4, v_43, k_2, v_22
          CASE z_1=5 .AND. z_2=3
             STORE 1 TO k_4, v_43, k_2, v_23
          CASE z_1=5 .AND. z_2=4
             STORE 1 TO k_4, v_43, k_2, v_24
          CASE z_1=5 .AND. z_2=5
             STORE 1 TO k_4, v_43, k_2, v_25
          CASE z_1=5 .AND. z_2=6
             STORE 1 TO k_4, v_43, k_2, v_26
          CASE z_1=5 .AND. z_2=7
             STORE 1 TO k_4, v_43, k_2, v_27
          CASE z_1=5 .AND. z_2=8
             STORE 1 TO k_4, v_43, k_2, v_28
          CASE z_1=5 .AND. z_2=9
             STORE 1 TO k_4, v_43, k_2, v_29
          CASE z_1=6 .AND. z_2=1
             STORE 1 TO k_4, v_44, k_2, v_21
          CASE z_1=6 .AND. z_2=2
             STORE 1 TO k_4, v_44, k_2, v_22
          CASE z_1=6 .AND. z_2=3
             STORE 1 TO k_4, v_44, k_2, v_23
          CASE z_1=6 .AND. z_2=4
             STORE 1 TO k_4, v_44, k_2, v_24
          CASE z_1=6 .AND. z_2=5
             STORE 1 TO k_4, v_44, k_2, v_25
          CASE z_1=6 .AND. z_2=6
             STORE 1 TO k_4, v_44, k_2, v_26
          CASE z_1=6 .AND. z_2=7
             STORE 1 TO k_4, v_44, k_2, v_27
          CASE z_1=6 .AND. z_2=8
             STORE 1 TO k_4, v_44, k_2, v_28
          CASE z_1=6 .AND. z_2=9
             STORE 1 TO k_4, v_44, k_2, v_29
          CASE z_1=7 .AND. z_2=1
             STORE 1 TO k_4, v_45, k_2, v_21
          CASE z_1=7 .AND. z_2=2
             STORE 1 TO k_4, v_45, k_2, v_22
          CASE z_1=7 .AND. z_2=3
             STORE 1 TO k_4, v_45, k_2, v_23
          CASE z_1=7 .AND. z_2=4
             STORE 1 TO k_4, v_45, k_2, v_24
          CASE z_1=7 .AND. z_2=5
             STORE 1 TO k_4, v_45, k_2, v_25
          CASE z_1=7 .AND. z_2=6
             STORE 1 TO k_4, v_45, k_2, v_26
          CASE z_1=7 .AND. z_2=7
             STORE 1 TO k_4, v_45, k_2, v_27
          CASE z_1=7 .AND. z_2=8
             STORE 1 TO k_4, v_45, k_2, v_28
          CASE z_1=7 .AND. z_2=9
             STORE 1 TO k_4, v_45, k_2, v_29
          CASE z_1=8 .AND. z_2=1
             STORE 1 TO k_4, v_46, k_2, v_21
          CASE z_1=8 .AND. z_2=2
             STORE 1 TO k_4, v_46, k_2, v_22
          CASE z_1=8 .AND. z_2=3
             STORE 1 TO k_4, v_46, k_2, v_23
          CASE z_1=8 .AND. z_2=4
             STORE 1 TO k_4, v_46, k_2, v_24
          CASE z_1=8 .AND. z_2=5
             STORE 1 TO k_4, v_46, k_2, v_25
          CASE z_1=8 .AND. z_2=6
             STORE 1 TO k_4, v_46, k_2, v_26
          CASE z_1=8 .AND. z_2=7
             STORE 1 TO k_4, v_46, k_2, v_27
          CASE z_1=8 .AND. z_2=8
             STORE 1 TO k_4, v_46, k_2, v_28
          CASE z_1=8 .AND. z_2=9
             STORE 1 TO k_4, v_46, k_2, v_29
          CASE z_1=9 .AND. z_2=1
             STORE 1 TO k_4, v_47, k_2, v_21
          CASE z_1=9 .AND. z_2=2
             STORE 1 TO k_4, v_47, k_2, v_22
          CASE z_1=9 .AND. z_2=3
             STORE 1 TO k_4, v_47, k_2, v_23
          CASE z_1=9 .AND. z_2=4
             STORE 1 TO k_4, v_47, k_2, v_24
          CASE z_1=9 .AND. z_2=5
             STORE 1 TO k_4, v_47, k_2, v_25
          CASE z_1=9 .AND. z_2=6
             STORE 1 TO k_4, v_47, k_2, v_26
          CASE z_1=9 .AND. z_2=7
             STORE 1 TO k_4, v_47, k_2, v_27
          CASE z_1=9 .AND. z_2=8
             STORE 1 TO k_4, v_47, k_2, v_28
          CASE z_1=9 .AND. z_2=9
             STORE 1 TO k_4, v_47, k_2, v_29
       ENDCASE
       z_1 = z_2
       po_r = 1
       IF k_3=1
          l = 0
       ENDIF
       DO propis
    ENDIF
    IF po_r=1 .AND. l=1
       DO CASE
          CASE z_1=0 .AND. p_r=0
             STORE 1 TO k_1
          CASE z_1=1 .AND. (zi_k=1 .OR. zi_k=3 .OR. zi_k=4)
             STORE 1 TO k_2, v_21
          CASE z_1=1 .AND. zi_k=2
             STORE 1 TO k_6
          CASE z_1=2 .AND. zi_k=2
             STORE 1 TO k_7
          CASE z_1=2 .AND. (zi_k=1 .OR. zi_k=3 .OR. zi_k=4)
             STORE 1 TO k_2, v_22
          CASE z_1=3
             STORE 1 TO k_2, v_23
          CASE z_1=4
             STORE 1 TO k_2, v_24
          CASE z_1=5
             STORE 1 TO k_2, v_25
          CASE z_1=6
             STORE 1 TO k_2, v_26
          CASE z_1=7
             STORE 1 TO k_2, v_27
          CASE z_1=8
             STORE 1 TO k_2, v_28
          CASE z_1=9
             STORE 1 TO k_2, v_29
       ENDCASE
       DO propis
    ENDIF
    IF  .NOT. EMPTY(s_5+s_4+s_3+s_2+s_7+s_6+s_1)
       pro_pis = pro_pis+s_5+s_4+s_3+s_2+s_7+s_6+s_1
    ENDIF
    IF  .NOT. EMPTY(t)
       pro_pis = pro_pis+t
    ENDIF
    STORE '' TO pi_1, pi_2, pi_3, pi_4
    IF zi_k=1
       pi_1 = pro_pis
    ENDIF
    IF zi_k=2
       pi_2 = pro_pis
    ENDIF
    IF zi_k=3
       pi_3 = pro_pis
    ENDIF
    IF zi_k=4
       pi_4 = pro_pis
    ENDIF
    pro_pis = pi_1+pi_2+pi_3+pi_4
    zi_k = zi_k-1
    l = 1
    STORE '' TO s_7, s_6, s_5, s_4, s_3, s_2, s_1, t
    STORE 0 TO z_1, z_2, z_3
 ENDDO
 IF a_a=0
    pro_pis = 'ноль рублей.'
 ENDIF
 za_g = LEFT(ALLTRIM(pro_pis), 1)
 DO CASE
    CASE za_g='н'
       za_g = 'Н'
    CASE za_g='в'
       za_g = 'В'
    CASE za_g='д'
       za_g = 'Д'
    CASE za_g='о'
       za_g = 'О'
    CASE za_g='п'
       za_g = 'П'
    CASE za_g='с'
       za_g = 'С'
    CASE za_g='т'
       za_g = 'Т'
    CASE za_g='ч'
       za_g = 'Ч'
    CASE za_g='ш'
       za_g = 'Ш'
 ENDCASE
 pro_pis = za_g+RIGHT(ALLTRIM(pro_pis), LEN(ALLTRIM(pro_pis))-1)
 pro_pis = ALLTRIM(pro_pis)
 DO perenos
 RETURN
*
PROCEDURE propis
 IF k_1=1
    s_1 = ' ноль'
 ENDIF
 IF k_2=1
    DO CASE
       CASE v_21=1
          s_2 = ' один'
       CASE v_22=1
          s_2 = ' два'
       CASE v_23=1
          s_2 = ' три'
       CASE v_24=1
          s_2 = ' четыре'
       CASE v_25=1
          s_2 = ' пять'
       CASE v_26=1
          s_2 = ' шесть'
       CASE v_27=1
          s_2 = ' семь'
       CASE v_28=1
          s_2 = ' восемь'
       CASE v_29=1
          s_2 = ' девять'
    ENDCASE
 ENDIF
 IF k_3=1
    DO CASE
       CASE v_30=1
          s_3 = ' десять'
       CASE v_31=1
          s_3 = ' одиннадцать'
       CASE v_32=1
          s_3 = ' двенадцать'
       CASE v_33=1
          s_3 = ' тринадцать'
       CASE v_34=1
          s_3 = ' четырнадцать'
       CASE v_35=1
          s_3 = ' пятнадцать'
       CASE v_36=1
          s_3 = ' шестнадцать'
       CASE v_37=1
          s_3 = ' семнадцать'
       CASE v_38=1
          s_3 = ' восемнадцать'
       CASE v_39=1
          s_3 = ' девятнадцать'
    ENDCASE
 ENDIF
 IF k_4=1
    DO CASE
       CASE v_40=1
          s_4 = ' двадцать'
       CASE v_41=1
          s_4 = ' тридцать'
       CASE v_42=1
          s_4 = ' сорок'
       CASE v_43=1
          s_4 = ' пятьдесят'
       CASE v_44=1
          s_4 = ' шестьдесят'
       CASE v_45=1
          s_4 = ' семьдесят'
       CASE v_46=1
          s_4 = ' восемьдесят'
       CASE v_47=1
          s_4 = ' девяносто'
    ENDCASE
 ENDIF
 IF k_5=1
    DO CASE
       CASE v_50=1
          s_5 = ' сто'
       CASE v_51=1
          s_5 = ' двести'
       CASE v_52=1
          s_5 = ' триста'
       CASE v_53=1
          s_5 = ' четыреста'
       CASE v_54=1
          s_5 = ' пятьсот'
       CASE v_55=1
          s_5 = ' шестьсот'
       CASE v_56=1
          s_5 = ' семьсот'
       CASE v_57=1
          s_5 = ' восемьсот'
       CASE v_58=1
          s_5 = ' девятьсот'
    ENDCASE
 ENDIF
 IF k_6=1
    s_6 = ' одна'
 ENDIF
 IF k_7=1
    s_7 = ' две'
 ENDIF
 IF zi_k=2 .AND. (s_2=' один' .OR. s_2=' два')
    s_2 = ''
 ENDIF
 STORE 0 TO v_21, v_22, v_23, v_24, v_25, v_26, v_27, v_28, v_29, v_30, v_31, v_32, v_33, v_34, v_35, v_36, v_37, v_38, v_39, v_40, v_41, v_42, v_43, v_44, v_45, v_46, v_47, v_50, v_51, v_52, v_53, v_54, v_55, v_56, v_57, v_58, k_1, k_2, k_3, k_4, k_5, k_6, k_7
 RETURN
*
PROCEDURE perenos
 DIMENSION stroka( 10)
 STORE '' TO stroka
 ch_s = 0
 DO WHILE .T.
    ch_s = ch_s+1
    no_r = LTRIM(STR(ch_s))
    pro_pis = ALLTRIM(pro_pis)
    IF LEN(pro_pis)>d_s
       fra_g = ALLTRIM(LEFT(pro_pis, AT(' ', LEFT(pro_pis, d_s), OCCURS(' ', LEFT(pro_pis, d_s)))))
       pro_pis = ALLTRIM(RIGHT(pro_pis, LEN(pro_pis)-LEN(fra_g)))
       stroka(&no_r)=fra_g
    ELSE
       stroka(&no_r)=pro_pis
       EXIT
    ENDIF
 ENDDO
 RETURN
*
