unit DMConstAnalytique;

interface

uses
  SysUtils, Classes,Controls, DB, DBTables,E2_LibInfosTable,E2_VisuListe,
  Dialogs,
  //Librairie_Isa,
  LibZoneSaisie,
  DMAnalytique,
  E2_Librairie_Obj,
  LibSQL,
  lib_chaine;

type
  TDMConstAnal = class(TDataModule)
    TaAtelierDefaut: TTable;
    DaAtelierDefaut: TDataSource;
    TaAtelierDefautCode_Atelier: TStringField;
    TaAtelierDefautlibelle_Atelier: TStringField;
    TaAtelierDefautCode_Activite: TStringField;
    TaAtelierDefautDivers: TStringField;
    QuAtelierDefaut: TQuery;
    DaQuAtelierDefaut: TDataSource;
    TaAtelierDefaut2: TTable;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    Function ExisteDansCodeAtelierDefaut(Code_Atelier:string):boolean;
    Procedure InitTableAtelierDefaut;

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  DMConstAnal: TDMConstAnal;

  Function AffichAteliersParDefaut(Requete:TDataset;Datasource:Tdatasource;Atelier:string=''):TInfosTA_Atelier;

implementation



{$R *.dfm}

Function AffichAteliersParDefaut(Requete:TDataset;Datasource:Tdatasource;Atelier:string):TInfosTA_Atelier;
Begin
  try
    Initialise_TInfosTA_Atelier(result);
    if VisuListe = nil then VisuListe:=TVisuListe.Create(nil);
    if DMAnalytiques = nil then DMAnalytiques:=TDMAnalytiques.Create(nil);
    if DMConstAnal = nil then DMConstAnal:=TDMConstAnal.Create(nil);
//    DMConstAnal.InitTableAtelierDefaut;
    VisuListe.BtnDetail.OnClick:=nil;
    VisuListe.PaGrille.OnResize:=DMAnalytiques.PaGrilleResize_VisuListe;
    VisuListe.BtnEnregistrer.OnClick:=VisuListe.BtnEnregistrerClick;
    VisuListe.GrDBVisu.OnDblClick:=VisuListe.BtnEnregistrerClick;
    VisuListe.Enregister1.OnClick:=VisuListe.BtnEnregistrerClick;

    VisuListe.OnKeyDown:=DMAnalytiques.FormKeyDown_VisuListe;
    VisuListe.BtnEnregistrer.visible:=true;
    VisuListe.Enregister1.visible:=true;

    VisuListe.RxLabTitre.Caption:='Liste des ateliers � utiliser';
    VisuListe.PaTitrePetit.Caption:='Ateliers � utiliser';

    VisuListe.GrDBVisu.DefaultDrawing:=False;
    GrDbGridInitColonne(VisuListe.GrDBVisu,Datasource,Requete,
                       ['Code Atelier','Libell� de l''atelier','Code activit�'],
                       ['Code_Atelier','Libelle_Atelier','Code_activite'],E.FormatMonnaie,E.EditFormat);
    if Atelier<>'' then VisuListe.GrDBVisu.DataSource.DataSet.Locate('Code_Atelier',Atelier,[loCaseInsensitive,loPartialKey]);
    if VisuListe.Showmodal=mrok then
     begin
       result.Code_Atelier:=Requete.findfield('Code_Atelier').AsString;
       result.Libelle_Atelier:=Requete.findfield('Libelle_Atelier').AsString;
       result.Code_Activite:=Requete.findfield('Code_activite').AsString;
       result.Unite_Atelier:=str_avant(Requete.findfield('divers').AsString,';');
     end
    else
     result.ResultInfos:=false;
  except
    Result.ResultInfos:=false;
  end;//fin du try finally
End;


Function TDMConstAnal.ExisteDansCodeAtelierDefaut(Code_Atelier:string):boolean;
begin
  try//except
    defiltrageDataset(TaAtelierDefaut2);
    if TaAtelierDefaut2.active=false then TaAtelierDefaut2.open;
    result:=TaAtelierDefaut2.Locate('Code_Atelier',uppercase(Code_atelier),[]);
  except
    result:=false;
  end;//fin except
end;

Procedure TDMConstAnal.InitTableAtelierDefaut;
Begin
showmessage('DMConstAnal.InitTableAtelierDefaut est en commentaire !'); 
//TaAtelierDefaut.EmptyTable;
//Query1.Open;
//TaAtelierDefaut.Open;
//Query1.First;
//while not Query1.Eof do
//begin
// TaAtelierDefaut.insert;
// TaAtelierDefaut.FindField('ID').AsInteger := MaxId_Query(TaAtelierDefaut,'ID');
// TaAtelierDefaut.FindField('Code_Atelier').AsString :=Query1F1.AsString;
// TaAtelierDefaut.FindField('Libelle_Atelier').AsString :=Query1F2.AsString;
// TaAtelierDefaut.Post;
// Query1.Next;
//end;
//TaAtelierDefaut.FlushBuffers;
End;


end.
