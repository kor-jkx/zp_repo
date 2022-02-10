 set_blink = SET('Blink')
 set_date = SET('Date')
 SET BLINK OFF
 SET DATE German
 DEFINE WINDOW wincalenda FROM 1, 0 TO 16, 31 SHADOW NONE COLOR N/W*,W/B,B/W*,GR+/B* 
 DEFINE WINDOW wmescalend FROM 24, 0 TO 24, 79 NONE COLOR N/W 
 ACTIVATE WINDOW wmescalend
 @ 0, 1 SAY 'Shift+М/М Смена месяца  Shift+Г/Г Смена года  С Сегодняшнее число  Esc Выход'
 @ 0, 1 SAY 'Shift+М/М' COLOR R/W 
 @ 0, 25 SAY 'Shift+Г/Г' COLOR R/W 
 @ 0, 47 SAY 'С' COLOR R/W 
 @ 0, 68 SAY 'Esc' COLOR R/W 
 ACTIVATE WINDOW wincalenda
 DIMENSION tablday( 6, 7)
 max_y = 0
 max_day = 0
 DO gokurspoda
 RELEASE WINDOW wincalenda, wmescalend
 Set Blink &Set_Blink
 Set Date  &Set_Date
 RETURN
*
FUNCTION newtabl
 PARAMETER _new_date
 PRIVATE first_day, i, j, _day
 first_day = '{01.'+STR(MONTH(_new_date))+'.'+STR(YEAR(_new_date))+'}'
 First_Day = &First_Day
 STORE '  ' TO tablday
 _day = 1
 _f_i = DOW(first_day)-1
 _f_i = IIF(_f_i=0, 7, _f_i)
 FOR i = _f_i TO 7
    tablday( 1, i) = STR(_day, 2)
    _day = _day+1
 ENDFOR
 count_day = '31,28,31,30,31,30,31,31,30,31,30,31'
 max_day = VAL(SUBSTR(count_day, MONTH(_new_date)*3-2, 3))
 IF MONTH(_new_date)=2 .AND. (MOD(YEAR(_new_date), 4)=0 .AND. MOD(YEAR(_new_date), 100)<>0 .OR. MOD(YEAR(_new_date), 400)=0)
    max_day = 29
 ENDIF
 FOR j = 2 TO 6
    FOR i = 1 TO 7
       tablday( j, i) = IIF(max_day>=_day, STR(_day, 2), '  ')
       _day = _day+1
    ENDFOR
 ENDFOR
 name_month = 'Январь  ,Февраль ,Март    ,Апрель  ,Май     ,Июнь    ,'+'Июль    ,Август  ,Сентябрь,Октябрь ,Ноябрь  ,Декабрь '
 @ 0, 0 SAY PADL('  '+ALLTRIM(SUBSTR(name_month, (MONTH(_new_date))*9-8, 8))+' '+STR(YEAR(_new_date), 4)+' г. ', WCOLS()) COLOR B+/GR* 
 DO setka
 j = 1
 max_y = 6
 FOR j = 1 TO 6
    FOR i = 1 TO 7
       @ j*2+2, i*4 SAY tablday(j,i) COLOR (IIF(i>5, 'r+/w*', 'n/w*'))
    ENDFOR
 ENDFOR
 RETURN .T.
*
FUNCTION gokurspoda
 = newtabl(DATE())
 PRIVATE _d_, _m_, _g_
 STORE 0 TO y_d, x_d, _d_, _m_, _g_
 PUSH KEY CLEAR
 DO today
 = showkursor(y_d,x_d,'n/rb*')
 DO WHILE LASTKEY()<>27
    = INKEY(0, 'H')
    old_y_d = y_d
    old_x_d = x_d
    DO CASE
       CASE LASTKEY()=4
          x_d = x_d+1
       CASE LASTKEY()=19
          x_d = x_d-1
       CASE LASTKEY()=5
          y_d = y_d-1
       CASE LASTKEY()=24
          y_d = y_d+1
       CASE LASTKEY()=117 .OR. LASTKEY()=163
          DO newdate WITH 1
       CASE LASTKEY()=131 .OR. LASTKEY()=85
          DO newdate WITH 2
       CASE LASTKEY()=118 .OR. LASTKEY()=172
          DO newdate WITH 3
       CASE LASTKEY()=140 .OR. LASTKEY()=86
          DO newdate WITH 4
       CASE LASTKEY()=99 .OR. LASTKEY()=67 .OR. LASTKEY()=225 .OR. LASTKEY()=145
          = newtabl(DATE())
          DO today
       CASE LASTKEY()=28
          DO PrHelp.prg WITH '(*Календарь*)'
    ENDCASE
    DO CASE
       CASE x_d>7
          x_d = 1
          y_d = y_d+1
       CASE x_d<1
          x_d = 7
          y_d = y_d-1
    ENDCASE
    DO CASE
       CASE y_d>max_y
          y_d = 1
       CASE y_d<1
          y_d = max_y
    ENDCASE
    = showkursor(old_y_d,old_x_d,IIF(old_x_d>5, 'r+/w*', 'n/w*'))
    = showkursor(y_d,x_d,'n/rb*')
 ENDDO
 POP KEY
 RETURN .T.
*
FUNCTION showkursor
 PARAMETER y_s_k, x_s_k, cw_s_k
 @ y_s_k*2+2, x_s_k*4-1 SAY PADL(tablday(y_s_k,x_s_k), 3) COLOR (cw_s_k)
 RETURN .T.
*
FUNCTION today
 PRIVATE i_d, i_j
 FOR i_d = 1 TO ALEN(tablday, 1)
    FOR j_d = 1 TO ALEN(tablday, 2)
       IF DAY(DATE())=VAL('0'+ALLTRIM(tablday(i_d,j_d)))
          y_d = i_d
          x_d = j_d
       ENDIF
    ENDFOR
 ENDFOR
 _d_ = DAY(DATE())
 _m_ = MONTH(DATE())
 _g_ = YEAR(DATE())
 RETURN .T.
*
FUNCTION newdate
 PARAMETER var_date_n
 DO CASE
    CASE var_date_n=1
       _g_ = _g_+1
    CASE var_date_n=2
       _g_ = _g_-1
    CASE var_date_n=3
       _m_ = _m_+1
       IF _m_=13
          _m_ = 1
          _g_ = _g_+1
       ENDIF
    CASE var_date_n=4
       _m_ = _m_-1
       IF _m_=0
          _m_ = 12
          _g_ = _g_-1
       ENDIF
 ENDCASE
 s_d = ' = NewTabl({01.'+STR(_m_)+'.'+STR(_g_)+'})'
 &S_D
 STORE 1 TO y_d, x_d
 DO WHILE tablday(y_d,x_d)=='  '
    x_d = x_d+1
 ENDDO
 RETURN .T.
*
FUNCTION setka
 @ 02, 2 SAY '  Пн  Вт  Ср  Чт  Пт  Сб  Вс '
 @ 03, 2 SAY '┌───┬───┬───┬───┬───┬───┬───┐'
 @ 04, 2 SAY '│   │   │   │   │   │   │   │'
 @ 05, 2 SAY '├───┼───┼───┼───┼───┼───┼───┤'
 @ 06, 2 SAY '│   │   │   │   │   │   │   │'
 @ 07, 2 SAY '├───┼───┼───┼───┼───┼───┼───┤'
 @ 08, 2 SAY '│   │   │   │   │   │   │   │'
 @ 09, 2 SAY '├───┼───┼───┼───┼───┼───┼───┤'
 @ 10, 2 SAY '│   │   │   │   │   │   │   │'
 @ 11, 2 SAY '├───┼───┼───┼───┼───┼───┼───┤'
 @ 12, 2 SAY '│   │   │   │   │   │   │   │'
 @ 13, 2 SAY '├───┼───┼───┼───┼───┼───┼───┤'
 @ 14, 2 SAY '│   │   │   │   │   │   │   │'
 @ 15, 2 SAY '└───┴───┴───┴───┴───┴───┴───┘'
 RETURN .T.
*
