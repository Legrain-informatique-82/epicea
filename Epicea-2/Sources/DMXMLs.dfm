object DMXml: TDMXml
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 1407
  Top = 626
  Height = 376
  Width = 513
  object XMLDocument1: TXMLDocument
    AfterOpen = XMLDocument1AfterOpen
    AfterNodeChange = XMLDocument1AfterNodeChange
    Left = 48
    Top = 32
    DOMVendorDesc = 'Open XML'
  end
  object XMLExportDossier: TXMLDocument
    Left = 232
    Top = 32
    DOMVendorDesc = 'MSXML'
  end
  object XMLImportDossier: TXMLDocument
    Left = 232
    Top = 104
    DOMVendorDesc = 'MSXML'
  end
end
