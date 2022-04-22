object DMFtp: TDMFtp
  OldCreateOrder = False
  Left = 531
  Top = 342
  Height = 133
  Width = 139
  object IdFTP1: TIdFTP
    OnStatus = IdFTP1Status
    MaxLineAction = maSplit
    ReadTimeout = 0
    OnDisconnected = IdFTP1Disconnected
    OnWork = IdFTP1Work
    OnWorkBegin = IdFTP1WorkBegin
    Passive = True
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    OnAfterClientLogin = IdFTP1AfterClientLogin
    Left = 40
    Top = 16
  end
end
