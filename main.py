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
