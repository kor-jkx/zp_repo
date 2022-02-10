 = setidle(354,time_keep*60,.T.)
 PRIVATE x, y, j, text_keep
 text_keep = ' ДЕНЬГИ  ДАВАЙ ...'
 DEFINE WINDOW winkeeper FROM 0, 0 TO 24, 79 NONE COLOR N 
 ACTIVATE WINDOW winkeeper
 j = 79-LEN(text_keep)
 CLEAR TYPEAHEAD
 STORE 0 TO x, y
 DO WHILE INKEY(1, 'H')=0
    @ y, x SAY text_keep COLOR N 
    x = INT((j-1+1)*RAND()+1)
    y = INT(-0022*RAND()+24)
    @ y, x SAY text_keep COLOR GR+/N 
 ENDDO
 RELEASE WINDOW winkeeper
 = setidle(354,time_keep*60)
 RETURN
*
