object GestSauvegarde: TGestSauvegarde
  Left = 442
  Top = 288
  Width = 746
  Height = 562
  Caption = 'Gestion Sauvegarde'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PaListe: TPanel
    Left = 0
    Top = 249
    Width = 730
    Height = 275
    Align = alClient
    TabOrder = 0
    object ListeSauvegarde: TListView
      Left = 1
      Top = 1
      Width = 728
      Height = 273
      Align = alClient
      Checkboxes = True
      Color = 15399679
      Columns = <
        item
          MaxWidth = 20
          MinWidth = 20
          Width = 20
        end
        item
          Caption = 'Date'
          Width = 100
        end
        item
          Caption = 'Heure'
          Width = 100
        end
        item
          Caption = 'Nom Fichier'
          Width = 350
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu1
      TabOrder = 0
      ViewStyle = vsReport
      OnColumnClick = ListeSauvegardeColumnClick
      OnCompare = ListeSauvegardeCompare
    end
    object BtnRaffraichir: TButton
      Left = 544
      Top = 31
      Width = 185
      Height = 25
      Caption = 'Raffra'#238'chir l'#39'affichage'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = BtnRaffraichirClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 730
    Height = 249
    Align = alTop
    TabOrder = 1
    object PaLeft: TPanel
      Left = 1
      Top = 1
      Width = 185
      Height = 247
      Align = alLeft
      TabOrder = 0
      object RxSBInfoVersion: TRxSpeedButton
        Left = 146
        Top = 202
        Width = 25
        Height = 22
        Cursor = crHandPoint
        Caption = '?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = RxSBInfoVersionClick
      end
      object ChDossierTransmis: TCheckBox
        Left = 8
        Top = 188
        Width = 121
        Height = 53
        Hint = 
          'En cochant cette case (avant de faire votre sauvegarde), vous in' +
          'diquez au'#13#10'programme que le dossier sera transmis '#224' votre compta' +
          'ble (ou une tierce'#13#10'personne) pour '#234'tre contr'#244'l'#233' (corrig'#233'). '#13#10'Ta' +
          'nt que vous n'#39'aurez pas restaur'#233' une sauvegarde renvoy'#233'e par vot' +
          're'#13#10'comptable (ou la tierce personne), un message vous rappeller' +
          'a de ne pas modifier'#13#10'votre dossier.'
        HelpType = htKeyword
        HelpKeyword = 'F1'
        Caption = 'Dossier transmis au        comptable'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        WordWrap = True
        OnClick = ChDossierTransmisClick
      end
      object BtnSauver: TButton
        Left = 0
        Top = 48
        Width = 185
        Height = 52
        Caption = 'Sauvegarde'
        TabOrder = 0
        OnClick = BtnSauverClick
      end
      object BtnSauveEtMail: TButton
        Left = 0
        Top = 124
        Width = 185
        Height = 30
        Caption = 'Sauver et Envoyer par E-Mail'
        TabOrder = 1
        OnClick = BtnSauveEtMailClick
      end
      object BtnDblSauver: TButton
        Left = 0
        Top = 99
        Width = 185
        Height = 27
        Caption = 'Double sauvegarde'
        TabOrder = 2
        OnClick = BtnDblSauverClick
      end
      object BtnPurge: TButton
        Left = 0
        Top = 153
        Width = 185
        Height = 25
        Caption = 'Purger les sauvegardes'
        TabOrder = 3
        OnClick = BtnPurgeClick
      end
    end
    object PaResult: TPanel
      Left = 186
      Top = 1
      Width = 543
      Height = 247
      Align = alClient
      TabOrder = 1
      object LaChoix: TLabel
        Left = 1
        Top = 1
        Width = 541
        Height = 20
        Align = alTop
        Alignment = taCenter
        Caption = 'Vos param'#232'tres de sauvegarde ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VLECHoixUtil: TValueListEditor
        Left = 1
        Top = 21
        Width = 541
        Height = 225
        Align = alClient
        Color = 15399679
        DefaultRowHeight = 25
        Strings.Strings = (
          'R'#233'pertoire du Dossier='
          'R'#233'pertoire de Sauvegarde='
          'R'#233'pertoire de la double Sauvegarde='
          'Adresse E-Mail de votre destinataire=support@legrain.fr'
          'Nombre de sauvegarde '#224' conserver=3')
        TabOrder = 0
        OnEditButtonClick = VLECHoixUtilEditButtonClick
        OnKeyDown = VLECHoixUtilKeyDown
        OnKeyPress = VLECHoixUtilKeyPress
        OnValidate = VLECHoixUtilValidate
        ColWidths = (
          244
          291)
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 357
    Top = 233
    object Renommerlasauvegarde1: TMenuItem
      Caption = 'Renommer la sauvegarde'
      ShortCut = 113
      OnClick = Renommerlasauvegarde1Click
    end
    object Listedessauvegardes1: TMenuItem
      Caption = 'Liste des sauvegardes'
      ShortCut = 119
      OnClick = Listedessauvegardes1Click
    end
    object Raffrachir1: TMenuItem
      Caption = 'Raffra'#238'chir'
      OnClick = Raffrachir1Click
    end
    object EnvoieFTP1: TMenuItem
      Caption = 'Envoie FTP'
      OnClick = EnvoieFTP1Click
    end
    object RinitialiserlesparamtreFTP1: TMenuItem
      Caption = 'Param'#232'tres FTP'
      OnClick = RinitialiserlesparamtreFTP1Click
    end
    object EnvoieFichierlogparEmail1: TMenuItem
      Caption = 'Envoie Fichier log par Email'
      OnClick = EnvoieFichierlogparEmail1Click
    end
    object Ouvrirlefichierdelog1: TMenuItem
      Caption = 'Ouvrir le fichier de log'
      OnClick = Ouvrirlefichierdelog1Click
    end
    object ransfererlefichierdelogdansdossier1: TMenuItem
      Caption = 'Transferer le fichier de log dans dossier'
      OnClick = ransfererlefichierdelogdansdossier1Click
    end
  end
end
