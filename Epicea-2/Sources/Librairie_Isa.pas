{***************************************************************
 *
 * Unit Name: Librairie_Isa
 *
 *

 ****************************************************************}
unit Librairie_Isa;

interface


uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls,Db, DBTables,
    dialogs,UString,Forms,Lib_chaine,LibRessourceString,Gr_Librairie_Obj,
    E2_Decl_Records,GrDbGrid,LibSQL;



   procedure InitChampReadOnly(Dataset:Tdataset;NoFields:array of integer;Etat_readonly:boolean);
   Procedure GrDbGridInitColonne(var GrDbGrille:TGrDbGrid;DataSource:TDataSource;DataSet:TDataSet;TitreColonne,NomChamp : array of String;FormatMonnaie,EditFormat:String);

   
implementation


procedure InitChampReadOnly(Dataset:Tdataset;NoFields:array of integer;Etat_readonly:boolean);
var
i:integer;
Begin//si
  try
    if dataset<>nil then
      Begin//si
        if not dataset.Active then dataset.Open;
        for i:=0 to high(NoFields)do
          Begin//si
            if dataset.Fields[NoFields[i]]<>nil then
              dataset.Fields[NoFields[i]].ReadOnly:=Etat_readonly;
          End;//fin si
      End;//fin si
  except
    showmessage('InitChampReadOnly : Erreur lors de l''affectation d''un champ à ReadOnly sur : '+DataSet.Name);
    //abort;
  end;
End;//fin si

// Initialise les colonnes d'une grille
Procedure GrDbGridInitColonne(var GrDbGrille:TGrDbGrid;DataSource:TDataSource;DataSet:TDataSet;TitreColonne,NomChamp : array of String;FormatMonnaie,EditFormat:String);
var
i:integer;
NotifyEvent:TNotifyEvent;
Begin
GrDbGrille.DataSource:=nil;
GrDbGrille.Columns.RebuildColumns;
NotifyEvent:=DataSource.OnStateChange;
DataSource.OnStateChange:=nil;
DataSet.Close;
DataSource.DataSet:=DataSet;
GrDbGrille.DataSource:=DataSource;
case RecupClassTypeComponent(DataSet) of
   GTQuery:Begin
           DataSet.Open;
           FormateMonnaieField(DataSet,FormatMonnaie,EditFormat);
           for i:=0 to high(NomChamp) do
            Begin
            if DataSource.DataSet.FindField(NomChamp[i]) <> nil then
             begin
              GrDbGrille.Columns.Add.Field:=DataSet.FindField(NomChamp[i]);
             end;
            End;

           for i:=0 to high(NomChamp) do
            Begin
            if DataSource.DataSet.FindField(NomChamp[i]) <> nil then
             begin
              GrDbGrille.Columns[i].Title.Caption:=TitreColonne[i];
              case RecupClassTypeComponent(DataSet.FindField(NomChamp[i])) of
                 GTFieldCurr:GrDbGrille.Columns[i].Title.Alignment:=taRightJustify;
//                 : ;
              end;

             end;
            End;
            FormateMonnaieField(DataSet,FormatMonnaie,EditFormat);

           End;

   GTable: Begin
           for i:=0 to high(NomChamp) do
            Begin
            if DataSource.DataSet.FindField(NomChamp[i]) <> nil then
             begin
              GrDbGrille.Columns.Add.Field:=DataSet.FindField(NomChamp[i]);
             end;
            End;

           for i:=0 to high(NomChamp) do
            Begin
            if DataSource.DataSet.FindField(NomChamp[i]) <> nil then
             begin
              GrDbGrille.Columns[i].Title.Caption:=TitreColonne[i];
              case RecupClassTypeComponent(DataSet.FindField(NomChamp[i])) of
                 GTFieldCurr:GrDbGrille.Columns[i].Title.Alignment:=taRightJustify;
//                 : ;
              end;
             end;
            End;
            FormateMonnaieField(DataSet,FormatMonnaie,EditFormat);
           End;

end;
if not DataSet.Active then DataSet.Open;
GrDbGrille.DataSource.Enabled:=true;
DataSource.OnStateChange:=NotifyEvent;
//
End;

end.
