object DMBD: TDMBD
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DMBDDestroy
  Left = 464
  Top = 227
  Height = 436
  Width = 518
  object dbNameProg: TDatabase
    Connected = True
    DatabaseName = 'Program'
    DriverName = 'STANDARD'
    Params.Strings = (
      'PATH=C:\Program Files\Lgr\Epicea'
      'ENABLE BCD=FALSE'
      'DEFAULT DRIVER=PARADOX')
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 42
    Top = 29
  end
  object dbNameDossier: TDatabase
    DatabaseName = 'Dossier'
    DriverName = 'STANDARD'
    HandleShared = True
    Params.Strings = (
      'PATH=C:\Program Files\Lgr\Epicea\Demo'
      'ENABLE BCD=FALSE'
      'DEFAULT DRIVER=PARADOX')
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 134
    Top = 33
  end
  object dbNameExo: TDatabase
    DatabaseName = 'Exercice'
    DriverName = 'STANDARD'
    HandleShared = True
    Params.Strings = (
      'PATH=C:\Program Files\Lgr\Epicea\Demo\exoDemo'
      'ENABLE BCD=FALSE'
      'DEFAULT DRIVER=PARADOX')
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 224
    Top = 35
  end
  object DbNameExoN1: TDatabase
    DatabaseName = 'ExoN1'
    LoginPrompt = False
    Params.Strings = (
      'PATH=C:\Program Files\Lgr\Epicea\Demo\ExoDemo'
      'ENABLE BCD=FALSE'
      'DEFAULT DRIVER=PARADOX'
      'ALIASNAME=ExerciceN1')
    SessionName = 'Default'
    Left = 232
    Top = 120
  end
  object TaGestDosRecherche: TTable
    DatabaseName = 'Program'
    TableName = 'GestDossier.DB'
    Left = 136
    Top = 144
    object TaGestDosRechercheID_Dossier: TIntegerField
      FieldName = 'ID_Dossier'
    end
    object TaGestDosRechercheID_Table: TIntegerField
      FieldName = 'ID_Table'
    end
    object TaGestDosRechercheNom_Dossier: TStringField
      FieldName = 'Nom_Dossier'
      Size = 255
    end
    object TaGestDosRechercheDir_Dossier: TStringField
      FieldName = 'Dir_Dossier'
      Size = 255
    end
    object TaGestDosRechercheNom_Exo: TStringField
      FieldName = 'Nom_Exo'
      Size = 255
    end
    object TaGestDosRechercheDir_Exo: TStringField
      FieldName = 'Dir_Exo'
      Size = 255
    end
    object TaGestDosRechercheAnnee_Dossier: TDateTimeField
      FieldName = 'Annee_Dossier'
    end
    object TaGestDosRechercheDateUtil: TDateTimeField
      FieldName = 'DateUtil'
    end
    object TaGestDosRechercheCloture: TBooleanField
      FieldName = 'Cloture'
    end
    object TaGestDosRechercheEXO_BASE: TStringField
      FieldName = 'EXO_BASE'
      Size = 2
    end
    object TaGestDosRechercheEXO_SAISIE: TStringField
      FieldName = 'EXO_SAISIE'
      Size = 2
    end
    object TaGestDosRechercheDATE_DEB_EXO: TDateField
      FieldName = 'DATE_DEB_EXO'
    end
    object TaGestDosRechercheDATE_FIN_EXO: TDateField
      FieldName = 'DATE_FIN_EXO'
    end
  end
  object TaParcours: TTable
    DatabaseName = 'Program'
    TableName = 'GestDossier.DB'
    Left = 152
    Top = 248
  end
end
