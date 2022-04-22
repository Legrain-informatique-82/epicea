unit GR_MultiExo;

interface
Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
	Controls, Dialogs, Forms, Registry, Db, DBTables, Math,stdctrls,
   FileCtrl,Gr_Librairie,E2_Librairie,Menus,E2_CreatDos,RxMemDS;
//
//type
//TChangtExo=record
//   CheminBase:string;
//   NomBase:string;
//   ExoBase:string;
//   ExoSaisie:string;
//   ExoDebut:TDate;
//   ExoFin:TDate;
//   Cloture:boolean;
//end;



//var ChangementExo:TChangtExo;
//procedure RetourNouvelExo;
//Procedure ReecritureDesTablesPourNouvelExo;


implementation
uses E2_Main,DMDepenses,DMProvision,DMChargesRepartir,DMChargesAPayer,DMChargesCA,DMBalances;



//Procedure ReecritureDesTablesPourNouvelExo;
//var
//tableMem:TRxMemoryData;
//EffaceTable:tquery;
//begin
//RetourNouvelExo;//Récupère tous les paramètres suite au changement d'exercice
//
//Main.DbParcours.DatabaseName:=ChangementExo.NomBase;
//Main.DbParcours.Params.Add('PATH='+ChangementExo.CheminBase);
//Main.DbParcours.Params.Add('ENABLE BCD=FALSE');
//Main.DbParcours.Params.Add('DEFAULT DRIVER=PARADOX');
//Main.DbParcours.DriverName:='Standard';
//main.TaParcours.DatabaseName:=Main.DbParcours.DatabaseName;
//main.DbParcours.Connected:=true;
//main.DbParcours.Open;
//EffaceTable:=tquery.Create(application);
//effacetable.DatabaseName:=Main.DbParcours.DatabaseName;
//
//if main.DbParcours.InTransaction=false then
//main.DbParcours.StartTransaction;
//   try
//   
//   TableMem:=TRxMemoryData.Create(Application);
//   DMDepenseEnt.Filtrage_EcriturePourNouvelExo(TableMem);
//   if tableMem.RecordCount<>0 then
//     begin
//     main.TaParcours.TableName:=DMDepenseEnt.TaDepense.TableName;
//     EffaceTable.SQL.Clear;
//     Effacetable.SQL.Add('Delete from '+main.TaParcours.tableName);
//     effacetable.ExecSQL;
//     TableMem.SaveToDataSet(Main.TaParcours,0);
//     end;
//   TableMem.Free;
//
//
//   TableMem:=TRxMemoryData.Create(Application);
//   DMChargeAPayer.Filtrage_EcriturePourNouvelExo(TableMem);
//   if tableMem.RecordCount<>0 then
//     begin
//     main.TaParcours.TableName:=DMChargeAPayer.TaChAPayer.TableName;
//     EffaceTable.SQL.Clear;
//     Effacetable.SQL.Add('Delete from '+main.TaParcours.tableName);
//     effacetable.ExecSQL;
//     TableMem.SaveToDataSet(Main.TaParcours,0);
//     main.TaParcours.Close;
//     end;
//   TableMem.Free;
//     
//
//   TableMem:=TRxMemoryData.Create(Application);
//   DMChargeCA.Filtrage_EcriturePourNouvelExo(TableMem);
//   if tableMem.RecordCount<>0 then
//     begin
//     main.TaParcours.TableName:=DMChargeCA.TaPCA.TableName;
//     EffaceTable.SQL.Clear;
//     Effacetable.SQL.Add('Delete from '+main.TaParcours.tableName);
//     effacetable.ExecSQL;
//     TableMem.SaveToDataSet(Main.TaParcours,0);
//     main.TaParcours.Close;
//     end;
//   TableMem.Free;
//
//
//   TableMem:=TRxMemoryData.Create(Application);
//   DMChargeRepartir.Filtrage_EcriturePourNouvelExo(tableMem);
//   if tableMem.RecordCount<>0 then
//     begin
//     main.TaParcours.TableName:=DMChargeRepartir.TaCar.TableName;
//     EffaceTable.SQL.Clear;
//     Effacetable.SQL.Add('Delete from '+main.TaParcours.tableName);
//     effacetable.ExecSQL;
//     TableMem.SaveToDataSet(Main.TaParcours,0);
//     main.TaParcours.close;
//     end;
//   TableMem.Free;
//
//
//   TableMem:=TRxMemoryData.Create(Application);
//   DMProvisions.Filtrage_EcriturePourNouvelExo(TableMem);
//   if tableMem.RecordCount<>0 then
//     begin
//     main.TaParcours.TableName:=DMProvisions.TaProvision.TableName;
//     EffaceTable.SQL.Clear;
//     Effacetable.SQL.Add('Delete from '+main.TaParcours.tableName);
//     effacetable.ExecSQL;
//     TableMem.SaveToDataSet(Main.TaParcours,0);
//     main.TaParcours.close;
//     end;
//   TableMem.Free;
//
//   main.TaParcours.TableName:=DMBalance.TaBalance.TableName;
//   DMBalance.FiltrageBalancePourChangementExo(DMBalance.QueryRecup);
//   if DMBalance.QueryRecup.RecordCount<>0 then
//      Main.TaParcours.Open;
//      while not(DMBalance.QueryRecup.EOF) do
//      begin
//      //Si le compte existe déjà dans la nouvelle balance
//        if Main.TaParcours.Locate('Compte',DMBalance.QueryRecupCompte.AsString,[])then
//        Main.TaParcours.Edit
//        else
//        Main.TaParcours.Insert;
//      Main.TaParcours.FindField('Compte').AsString:=DMBalance.QueryRecupCompte.AsString;
//         if DMBalance.QueryRecupTotal.AsFloat > 0 then
//         begin
//         Main.TaParcours.FindField('Debit_Report').AsFloat:=DMBalance.QueryRecupTotal.AsFloat;
//         Main.TaParcours.FindField('Qt1_Report').AsFloat:=DMBalance.QueryRecupQtTotal.AsFloat;
//         end;
//         if DMBalance.QueryRecupTotal.AsFloat < 0 then
//         begin
//         Main.TaParcours.FindField('Credit_Report').AsFloat:=DMBalance.QueryRecupTotal.AsFloat;
//         Main.TaParcours.FindField('Qt2_Report').AsFloat:=DMBalance.QueryRecupQtTotal.AsFloat;
//         end;
//      Main.TaParcours.Post;
//      Main.TaParcours.Next;
//      DMBalance.QueryRecup.Next;
//      end;
//   Main.DbParcours.Commit;
////****************************** rajouter stock et Immos ************************************
//   except
//    Main.DbParcours.Rollback;
//    main.TaParcours.Close;
//    Main.DbParcours.close;
//    main.TaParcours.DatabaseName:='';
//    main.TaParcours.tableName:='';
//    Main.DbParcours.DatabaseName:='';
//    Main.DbParcours.Params.clear;
//    main.TaParcours.TableName:='';
//    effaceTable.Free;
//   abort;
//   end;//fin du try
//    main.TaParcours.Close;
//    Main.DbParcours.close;
//    main.TaParcours.DatabaseName:='';
//    main.TaParcours.tableName:='';
//    Main.DbParcours.DatabaseName:='';
//    Main.DbParcours.Params.clear;
//    main.TaParcours.TableName:='';
//    effaceTable.Free;
//end;
//
//procedure RetourNouvelExo;
//var
//TableDossier:Ttable;
//begin
//    try
//    TableDossier:=ttable.Create(Main);
//    tableDossier.DatabaseName:=Main.GestDos.DatabaseName;
//    TableDossier.TableName:=Main.GestDos.TableName;
//    tabledossier.Open;
//    tabledossier.Filtered:=false;
//    TableDossier.filter:=('ID_Dossier ='''+main.IDDos+''' and Dir_Exo <>'''+main.DirExo+''' and Cloture = ''false''');
//    tabledossier.Filtered:=true;
//       if TableDossier.RecordCount<>0 then
//          begin
//          tabledossier.First;
//          ChangementExo.CheminBase:=tabledossier.findfield('Dir_Exo').asstring;
//          ChangementExo.NomBase:= tabledossier.findfield('Nom_Exo').asstring;
//          ChangementExo.ExoBase:=tabledossier.findfield('EXO_BASE').AsString;
//          ChangementExo.ExoSaisie:=tabledossier.findfield('EXO_SAISIE').AsString;
//          ChangementExo.ExoDebut:=tabledossier.findfield('DATE_DEB_EXO').AsDateTime;
//          ChangementExo.ExoFin:=tabledossier.findfield('DATE_FIN_EXO').AsDateTime;
//          ChangementExo.Cloture:=tabledossier.findfield('Cloture').AsBoolean;
//          end
//       else
//          begin
//          showmessage('Il n''y a pas d''autre exercice de créé, la réécriture ne pourra pas s''effectuer !!!');
//          abort;
//          end;
//    finally
//    tabledossier.Free;
//    end;//fin du try
//end;


end.
