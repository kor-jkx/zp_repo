import ctypes
import os
import sys

import wx


class MainFrame(wx.MDIParentFrame):
    def __init__(self, *args, **kwargs):
        wx.Frame.__init__(self, *args, **kwargs)
        self.k_org = 0
        self.or__g = 0
        self.m_e = 0
        self.da_t = 0
        self.da_tt = 0
        self.z_m_g = 0
        self.me__s = 0
        self.mes_t = 0
        self.za_s = 0
        self.mi_n = 0
        self.wib_mes = 0
        self.katalo_g = 0
        self.star_kat = 0
        self.fail_zip = 0
        self.star_zip = 0
        self.me_s1 = 0
        self.me_s2 = 0
        self.me_s3 = 0
        self.go_d1 = 0
        self.go_d2 = 0
        self.go_d3 = 0
        self.mese_z1 = 0
        self.mese_z2 = 0
        self.mese_z3 = 0
        self.bri_n = 0
        self.bri_k = 0
        self.tab_n = 0
        self.tab_k = 0
        self.raszet_ne = 0
        self.mini_m = 0
        self.min_sr = 0
        self.stavka_1 = 0
        self.stavka_21 = 0
        self.stavka_22 = 0
        self.stavka_31 = 0
        self.stavka_32 = 0
        self.stavka_41 = 0
        self.stavka_42 = 0
        self.stavka_51 = 0
        self.stavka_52 = 0
        self.stavka_61 = 0
        self.proc_1 = 0
        self.proc_2 = 0
        self.proc_3 = 0
        self.proc_4 = 0
        self.proc_5 = 0
        self.proc_6 = 0
        self.tvsum_1 = 0
        self.tvsum_2 = 0
        self.tvsum_3 = 0
        self.tvsum_4 = 0
        self.tvsum_5 = 0
        self.stroka = 0
        self.tan_spz = 0
        self.prn_disp = 0
        self.srif_t = 0
        self._k = 0
        ver_s = ' 9.02.98г.'
        na_z = 0
        a = [[0] * 5 for _ in range(2)]


def _menu():
    # DEFINE PAD work OF _MSYSMENU PROMPT ' \<Главное  Меню ' MESSAGE '  Здесь  Ввод  данных,   Коppектиpовка  и  Расчеты  ' COLOR SCHEME 3
    # DEFINE PAD sprav OF _MSYSMENU PROMPT ' \<Ведение  Справочников ' MESSAGE '   Своевременно  изменяйте  данные  Справочников !!! ' COLOR SCHEME 3
    # DEFINE PAD print OF _MSYSMENU PROMPT ' \<Печать машинограмм ' MESSAGE ' Приготовьте  пожалуйста  ПРИНТЕР  и  бумагу  нужной  ширины  ! ' COLOR SCHEME 3
    # DEFINE PAD podskas OF _MSYSMENU PROMPT ' \<Разное ' MESSAGE '   Помощь  и  Выход  из  обработки  ЗДЕСЬ !!!  ' COLOR SCHEME 2
    # DEFINE PAD gasitel OF _MSYSMENU PROMPT '\<*' MESSAGE ' Запуск  гасителя  экpана ' KEY Ctrl-F5 COLOR SCHEME 3
    # DEFINE POPUP popwork FROM 1, 1 SHADOW MARGIN RELATIVE COLOR SCHEME 4
    # DEFINE BAR 1 OF popwork PROMPT '1. ВВОД  НАЧИСЛЕНИЙ  и  УДЕРЖАНИЙ '
    # DEFINE BAR 2 OF popwork PROMPT '2. КОРРЕКТИРОВКА  НАЧИСЛЕНИЙ  и  УДЕРЖАНИЙ '
    # DEFINE BAR 3 OF popwork PROMPT '3. ОБРАБОТКА  НАРЯДОВ ' SKIP FOR k_org<>'012' .AND. k_org<>'018'
    # DEFINE BAR 4 OF popwork PROMPT '4. РАСЧЕТ  НАЧИСЛЕНИЙ и НАЛОГОВ с ЛОГ. ПРОВЕРКОЙ '
    # DEFINE BAR 5 OF popwork PROMPT '5. КОПИРОВАНИЕ  МАССИВОВ  на  ДИСКЕТУ '
    # DEFINE BAR 6 OF popwork PROMPT '6. ПЕРЕДАЧА  МАССИВОВ  в АРХИВ '
    # DEFINE BAR 7 OF popwork PROMPT '          Выход  -->  Esc '
    # ON SELECTION BAR 1 OF popwork do zvvod0
    # ON SELECTION BAR 2 OF popwork do zkorr0
    # IF k_org='012'
    #    ON SELECTION BAR 3 OF popwork do znar012
    #    ON SELECTION BAR 4 OF popwork do zrasz012
    # ENDIF
    # IF k_org='013'
    #    ON SELECTION BAR 3 OF popwork do znar012
    #    ON SELECTION BAR 4 OF popwork do zrasz013
    # ENDIF
    # IF k_org='017'
    #    ON SELECTION BAR 3 OF popwork do znar012
    #    ON SELECTION BAR 4 OF popwork do zrasz017
    # ENDIF
    # IF k_org='018'
    #    ON SELECTION BAR 3 OF popwork do znar012
    #    ON SELECTION BAR 4 OF popwork do zrasz017
    # ENDIF
    # IF k_org='033'
    #    ON SELECTION BAR 3 OF popwork do znar012
    #    ON SELECTION BAR 4 OF popwork do zrasz033
    # ENDIF
    # ON SELECTION BAR 5 OF popwork do zcopir1
    # ON SELECTION BAR 6 OF popwork do zcopir2
    # ON SELECTION BAR 7 OF popwork do vixod
    # DEFINE POPUP popsprav FROM 1, 20 SHADOW MARGIN RELATIVE COLOR SCHEME 4
    # DEFINE BAR 1 OF popsprav PROMPT ' 1. СПРАВОЧНИК  РАБОТАЮЩИХ  в ОРГАНИЗАЦИИ '
    # DEFINE BAR 2 OF popsprav PROMPT ' 2. СПРАВОЧНИК  ВИДОВ  ОПЛАТ и УДЕРЖАНИЙ '
    # DEFINE BAR 3 OF popsprav PROMPT ' 3. СПРАВОЧНИК  УЧАСТКОВ '
    # DEFINE BAR 4 OF popsprav PROMPT ' 4. МИНИМАЛЬНЫЕ ОКЛАДЫ  и  СТАВКИ  НАЛОГОВ'
    # DEFINE BAR 5 OF popsprav PROMPT ' 5. СПРАВОЧНИК  УВОЛЕННЫХ  из ОРГАНИЗАЦИИ '
    # DEFINE BAR 6 OF popsprav PROMPT ' 6. СПРАВОЧНИК  ОФОРМЛЕНИЯ  ДОКУМЕНТОВ '
    # DEFINE BAR 7 OF popsprav PROMPT '           Выход  -->  Esc '
    # ON SELECTION BAR 1 OF popsprav do zkorzap1
    # ON SELECTION BAR 2 OF popsprav do zkorsvou
    # ON SELECTION BAR 3 OF popsprav do zkorbri
    # ON SELECTION BAR 4 OF popsprav do zglobal
    # ON SELECTION BAR 5 OF popsprav do zkoruvol
    # ON SELECTION BAR 6 OF popsprav do zkorspr1
    # ON SELECTION BAR 7 OF popsprav do vixod
    # otk_l = 1
    # DEFINE POPUP popprint FROM 1, 35 SHADOW MARGIN RELATIVE COLOR SCHEME 4
    # DEFINE BAR 1 OF popprint PROMPT ' 1. КОНТР. РАСПЕЧАТКА  НАЧИСЛЕНИЙ и УДЕРЖАНИЙ =>' MESSAGE ' Здесь  только  контpольная  pаспечатка '
    # DEFINE BAR 2 OF popprint PROMPT ' 2. РАСЧЕТНО-ПЛАТЕЖНАЯ  ВЕДОМОСТЬ ' MESSAGE ' Здесь  ПЕЧАТЬ  сумм  Начислено,  Удеpжано,  На pуки  или  Долг '
    # DEFINE BAR 3 OF popprint PROMPT ' 3. РАСЧЕТНЫЙ ЛИСТОК - ЛИЦЕВОЙ СЧЕТ ' MESSAGE ' Здесь  ПЕЧАТЬ  по  ПРЕДПРИЯТИЮ  или  по  УЧАСТКАМ , ПЕРЕПЕЧАТКА '
    # DEFINE BAR 4 OF popprint PROMPT ' 4. ПЛАТЕЖНАЯ  ВЕДОМОСТЬ  для  КАССЫ ' MESSAGE ' Пpедоставляется  Кассиpу  для  выдачи  денег '
    # DEFINE BAR 5 OF popprint PROMPT ' 5. СВОДА  по  В/О, В/У, КАТЕГОРИЯМ, ШПЗ =>'
    # DEFINE BAR 6 OF popprint PROMPT ' 6. НАЛОГОВАЯ  КАРТОЧКА '
    # DEFINE BAR 7 OF popprint PROMPT ' 7. ОТЧЕТ  для НАЛОГОВОЙ  ИНСПЕКЦИИ ' MESSAGE ' В стадии  доpаботки ' SKIP FOR otk_l=1
    # DEFINE BAR 8 OF popprint PROMPT ' 8. ВЕДОМОСТИ  НАЧИСЛЕНИЙ и ВЫПЛАТ по ФОНДАМ => ' MESSAGE ' В стадии  доpаботки ' SKIP FOR otk_l=1
    # DEFINE BAR 9 OF popprint PROMPT ' 9. ВЕДОМОСТЬ  НЕ ВЫДАННОЙ  З/ПЛ. по ТАБ.N ' MESSAGE ' Для анализа  погашения задолженности  по pаботникам '
    # DEFINE BAR 10 OF popprint PROMPT '10. ВЕДОМОСТЬ  на  АВАНС '
    # DEFINE BAR 11 OF popprint PROMPT '11.  <= ПЕЧАТЬ  СПРАВОЧHИКОВ => '
    # DEFINE BAR 12 OF popprint PROMPT '12. СПРАВКА  о  СРЕДНЕМ  ДОХОДЕ  для  СУБСИДИЙ '
    # DEFINE BAR 13 OF popprint PROMPT '13. СПИСОК  на  ПЕРЕЧИСЛЕНИЕ АЛИМЕНТОВ  ПОЧТОЙ '
    # DEFINE BAR 14 OF popprint PROMPT '14. СПРАВКА о ДОХОДАХ ФИЗИЧЕСКОГО ЛИЦА для ГОСНИ'
    # DEFINE BAR 15 OF popprint PROMPT '15. СПРАВКА о СРЕДНЕМ ЗАРАБОТКЕ в отд. ЗАНЯТОСТИ'
    # DEFINE BAR 16 OF popprint PROMPT '16. ИHСТРУКЦИЯ  ПОЛЬЗОВАТЕЛЯ ' MESSAGE ' В стадии  доpаботки ' SKIP FOR otk_l=1
    # DEFINE BAR 17 OF popprint PROMPT '                  Выход  --> Esc '
    # ON SELECTION BAR 1 OF popprint do zrasp0.prg
    # ON SELECTION BAR 2 OF popprint do zplatwed
    # ON SELECTION BAR 3 OF popprint do zraslist.prg
    # ON SELECTION BAR 4 OF popprint do zkassa
    # ON SELECTION BAR 5 OF popprint do zsvoda
    # ON SELECTION BAR 6 OF popprint do znalkar
    # ON SELECTION BAR 9 OF popprint do zdolgpr
    # ON SELECTION BAR 10 OF popprint do zawans
    # ON SELECTION BAR 11 OF popprint do zraspspr
    # ON SELECTION BAR 12 OF popprint do zspravka
    # ON SELECTION BAR 13 OF popprint do zpispozt
    # ON SELECTION BAR 14 OF popprint do zpravnal
    # ON SELECTION BAR 15 OF popprint do zpravsrz
    # ON SELECTION BAR 17 OF popprint do vixod
    # DEFINE POPUP poppom FROM 1, 65 SHADOW MARGIN RELATIVE COLOR SCHEME 4
    # DEFINE BAR 1 OF poppom PROMPT '  ИHСТРУКЦИЯ '
    # DEFINE BAR 2 OF poppom PROMPT 'ПЕРЕВЫБОР  МЕСЯЦА '
    # DEFINE BAR 3 OF poppom PROMPT 'Календаpь всех лет' MESSAGE ' Если  нет  по pукой  настольного календаpя '
    # DEFINE BAR 4 OF poppom PROMPT '  <= Выход => '
    # IF k_org='012'
    #    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help013*) (*help017*) (*help018*) (*help033*)"
    # ENDIF
    # IF k_org='013'
    #    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help012*) (*help017*) (*help018*) (*help033*)"
    # ENDIF
    # IF k_org='017'
    #    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help012*) (*help013*) (*help018*) (*help033*)"
    # ENDIF
    # IF k_org='018'
    #    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help012*) (*help013*) (*help017*) (*help033*)"
    # ENDIF
    # IF k_org='033'
    #    ON SELECTION BAR 1 OF poppom do prhelp.prg with "ALL","(*help012*) (*help013*) (*help017*) (*help018*)"
    # ENDIF
    # ON SELECTION BAR 2 OF poppom do zamendata
    # ON SELECTION BAR 3 OF poppom do calendar
    # ON SELECTION BAR 4 OF poppom do konez
    # ON SELECTION PAD work OF _MSYSMENU ACTIVATE POPUP popwork
    # ON SELECTION PAD sprav OF _MSYSMENU ACTIVATE POPUP popsprav
    # ON SELECTION PAD print OF _MSYSMENU ACTIVATE POPUP popprint
    # ON SELECTION PAD podskas OF _MSYSMENU ACTIVATE POPUP poppom
    # ON SELECTION PAD gasitel OF _MSYSMENU do zkeeper
    pass


if __name__ == '__main__':
    app = wx.App()
    # start "ZAM"
    main_frame = MainFrame(None, wx.ID_ANY, size=(800, 600), style=wx.DEFAULT_FRAME_STYLE ^ wx.RESIZE_BORDER ^ wx.MAXIMIZE_BOX)

    icon_file = os.path.join(os.path.dirname(__file__), ".img/app.ico") if not hasattr(sys, "frozen") else os.path.join(sys.prefix, ".img/app.ico")
    main_frame.SetIcon(wx.Icon(icon_file, wx.BITMAP_TYPE_ICO))
    ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID('zap.1998.02.09')

    # main_frame.SetTitle('Версия программы: ' + main_frame.ver_program + ' месяц: ' + main_frame.dir)

    main_frame.CreateStatusBar()
    # main_frame.SetStatusText('G62/' + main_frame.t_journal)

    # main_frame.create_menu()

    main_frame.Centre()
    main_frame.Show(True)

    app.SetTopWindow(main_frame)
    app.MainLoop()
