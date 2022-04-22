unit Gr_MiseAJourBalance;

interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
     Controls, Dialogs, Forms, Registry, Db, DBTables, Math,stdctrls,Variants;

Procedure MiseAJourBalanceInsertionOuverture(Table: TTable;Compte: String;Montant,Qte: Currency;Debit: Boolean);
Procedure MiseAJourBalanceSuppressionOuvertureSansOD(Table: TTable; Compte: String; Montant,Qte: Currency; Debit: Boolean);
Procedure MiseAJourBalanceSuppressionOuvertureAvecOD(Table: TTable; Compte,Compte2: String; Montant,Qte: Currency; Debit,Debit2: Boolean);
Procedure MAJBalanceModifOuvertureSansOD(Table: TTable; Compte: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit: Boolean);
Procedure MAJBalanceModifOuvertureCpModifAvecOD(Table: TTable; Compte,Compte2,CompteTmp: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit:Boolean);
Procedure MAJBalanceModifOuvertureAvecOD(Table: TTable; Compte,Compte2: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit,Debit2: Boolean);

Procedure MAJBalanceInsertionCloture(Table: TTable;Compte: String;Montant,Qte: Currency; Debit: Boolean);
Procedure MAJBalanceSuppressionClotureSansOD(Table: TTable; Compte: String; Montant,Qte: Currency; Debit: Boolean);
Procedure MAJBalanceSuppressionClotureAvecOD(Table: TTable; Compte,Compte2: String; Montant,Qte: Currency; Debit,Debit2: Boolean);
Procedure MAJBalanceModifClotureSansOD(Table: TTable; Compte: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit: Boolean);
Procedure MAJBalanceModifClotureAvecOD(Table: TTable; Compte,Compte2: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit,Debit2: Boolean);
Procedure MAJBalanceModifClotureCpModifAvecOD(Table: TTable; Compte,Compte2,CompteTmp: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit:Boolean);

implementation

uses //E2_Main,
E2_Librairie_obj,GR_Librairie_obj;


//****************************************************************************//
// Procedure qui met à jour la Balance apès une Insertion dans l'Ouverture.   //
//****************************************************************************//
procedure MiseAJourBalanceInsertionOuverture(Table: TTable;Compte: String;Montant,Qte: Currency; Debit: Boolean);
begin
     Table.Open;
     If TaBle.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               TaBle.FieldByName('Debit_Report').AsCurrency := TaBle.FieldByName('Debit_Report').AsCurrency + Montant;
               TaBle.FieldByName('Qt1_Report').AsCurrency := TaBle.FieldByName('Qt1_Report').AsCurrency + Qte;
          End
          Else
          Begin
               TaBle.FieldByName('Credit_Report').AsCurrency := TaBle.FieldByName('Credit_Report').AsCurrency + Montant;
               TaBle.FieldByName('Qt2_Report').AsCurrency := TaBle.FieldByName('Qt2_Report').AsCurrency + Qte;
          End;
          TaBle.Post;
          TaBle.FlushBuffers;
     End
     Else
     Begin
          If Debit Then
             TaBle.AppendRecord([Compte,Null,Montant,Null,Null,Null,Null,Null,Qte,Null,Null,Null,Null,Null])
          Else
             TaBle.AppendRecord([Compte,Null,Null,Montant,Null,Null,Null,Null,Null,Qte,Null,Null,Null,Null]);
     End;
     TaBle.FlushBuffers;
     TaBle.Close;
end;
//****************************************************************************//



//****************************************************************************//
// Procedure qui met à jour la balance lors de la suppression d'un enreg dans //
// l'ouverture qui ne possède pas d'OD.                                       //
//****************************************************************************//
Procedure MiseAJourBalanceSuppressionOuvertureSansOD(Table: TTable; Compte: String; Montant,Qte: Currency; Debit: Boolean);
begin
     Table.Open;
     If Table.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Report').AsCurrency := Table.FieldByName('Debit_Report').AsCurrency - Montant;
               Table.FieldByName('Qt1_Report').AsCurrency := Table.FieldByName('Qt1_Report').AsCurrency - Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Report').AsCurrency := Table.FieldByName('Credit_Report').AsCurrency - Montant;
               Table.FieldByName('Qt2_Report').AsCurrency := Table.FieldByName('Qt2_Report').AsCurrency - Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MiseAJourBalanceSuppressionOuvertureSansOD !!!',MtWarning,[mbok],0);
     Table.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Procedure qui met à jour la balance lors de la suppression d'un enreg dans //
// l'ouverture qui possède une OD.                                            //
//****************************************************************************//
Procedure MiseAJourBalanceSuppressionOuvertureAvecOD(Table: TTable; Compte,Compte2: String; Montant,Qte: Currency; Debit,Debit2: Boolean);
Begin
     Table.Open;
     // Mise à jour dans la balance du compte de reprise
     If Table.Locate('Compte',Compte2,[]) Then
     Begin
          Table.Edit;
          If Debit2 Then
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MiseAJourBalanceSuppressionOuvertureAvecOD !!!',MtWarning,[mbok],0);

     // Mise à jour de la balance pour le compte de charge ou le compte de produit
     If Table.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Report').AsCurrency := Table.FieldByName('Debit_Report').AsCurrency - Montant;
               Table.FieldByName('Qt1_Report').AsCurrency := Table.FieldByName('Qt1_Report').AsCurrency - Qte;
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Report').AsCurrency := Table.FieldByName('Credit_Report').AsCurrency - Montant;
               Table.FieldByName('Qt2_Report').AsCurrency := Table.FieldByName('Qt2_Report').AsCurrency - Qte;
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MiseAJourBalanceSuppressionOuvertureAvecOD !!!',MtWarning,[mbok],0);

     Table.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Procedure qui met à jour la balance lors de la modification d'un enreg ds  //
// l'ouverture sans compte modifié et sans OD.                                //
//****************************************************************************//
Procedure MAJBalanceModifOuvertureSansOD(Table: TTable; Compte: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit: Boolean);
Begin
     Table.Open;
     If TaBle.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               TaBle.FieldByName('Debit_Report').AsCurrency := TaBle.FieldByName('Debit_Report').AsCurrency - MontantTmp + Montant;
               TaBle.FieldByName('Qt1_Report').AsCurrency := TaBle.FieldByName('Qt1_Report').AsCurrency - QteTmp + Qte;
          End
          Else
          Begin
               TaBle.FieldByName('Credit_Report').AsCurrency := TaBle.FieldByName('Credit_Report').AsCurrency - MontantTmp + Montant;
               TaBle.FieldByName('Qt2_Report').AsCurrency := TaBle.FieldByName('Qt2_Report').AsCurrency - QteTmp + Qte;
          End;
          TaBle.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifOuvertureSansOD !!!',MtWarning,[mbok],0);
     TaBle.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Procedure qui met à jour la balance lors de la modification d'un enreg ds  //
// l'ouverture sans compte modifié et avec OD.                                //
//****************************************************************************//
Procedure MAJBalanceModifOuvertureAvecOD(Table: TTable; Compte,Compte2: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit,Debit2: Boolean);
Begin
     Table.Open;
     // Mise à jour dans la balance du compte de reprise
     If Table.Locate('Compte',Compte2,[]) Then
     Begin
          Table.Edit;
          If Debit2 Then
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - QteTmp + Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - QteTmp + Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifOuvertureAvecOD !!!',MtWarning,[mbok],0);

     // Mise à jour de la balance pour le compte de charge ou le compte de produit
     If Table.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Report').AsCurrency := Table.FieldByName('Debit_Report').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt1_Report').AsCurrency := Table.FieldByName('Qt1_Report').AsCurrency - QteTmp + Qte;
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - QteTmp + Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Report').AsCurrency := Table.FieldByName('Credit_Report').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt2_Report').AsCurrency := Table.FieldByName('Qt2_Report').AsCurrency - QteTmp + Qte;
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - QteTmp + Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifOuvertureAvecOD !!!',MtWarning,[mbok],0);

     Table.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Procedure qui met à jour la balance lors de la modification d'un enreg ds  //
// l'ouverture avec compte modifié et avec OD.                                //
//****************************************************************************//
Procedure MAJBalanceModifOuvertureCpModifAvecOD(Table: TTable; Compte,Compte2,CompteTmp: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit:Boolean);
Begin
     Table.Open;
     // Mise à jour de l'ancien compte de reprise
     If Table.Locate('Compte',CompteTmp,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - MontantTmp;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - QteTmp;
          End
          Else
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - MontantTmp;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - QteTmp;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifOuvertureCpModifAvecOD !!!',MtWarning,[mbok],0);

     // Mise à jour du nouveau compte de reprise
     If Table.Locate('Compte',Compte2,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency + Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency + Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency + Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency + Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
     Begin
          If Debit Then
             Table.AppendRecord([Compte2,Null,Null,Null,Montant,Null,Null,Null,Null,Null,Qte,Null,Null,Null])
          Else
             Table.AppendRecord([Compte2,Null,Null,Null,Null,Montant,Null,Null,Null,Null,Null,Qte,Null,Null]);
      TaBle.FlushBuffers;
     End;

     // Mise à jour de la balance pour le compte de charge ou le compte de produit
     If Table.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Report').AsCurrency := Table.FieldByName('Debit_Report').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt1_Report').AsCurrency := Table.FieldByName('Qt1_Report').AsCurrency - QteTmp + Qte;
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - QteTmp + Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Report').AsCurrency := Table.FieldByName('Credit_Report').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt2_Report').AsCurrency := Table.FieldByName('Qt2_Report').AsCurrency - QteTmp + Qte;
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - QteTmp + Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifOuvertureCpModifAvecOD !!!',MtWarning,[mbok],0);

     Table.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Mise à jour de l balance après l'insertion d'une charge ou d'un produit    //
// dans la clôture.                                                           //
//****************************************************************************//
Procedure MAJBalanceInsertionCloture(Table: TTable;Compte: String;Montant,Qte: Currency; Debit: Boolean);
Begin
     Table.Open;
     If TaBle.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               TaBle.FieldByName('Debit_Base').AsCurrency := TaBle.FieldByName('Debit_Base').AsCurrency + Montant;
               TaBle.FieldByName('Qt1_Base').AsCurrency := TaBle.FieldByName('Qt1_Base').AsCurrency + Qte;
          End
          Else
          Begin
               TaBle.FieldByName('Credit_Base').AsCurrency := TaBle.FieldByName('Credit_Base').AsCurrency + Montant;
               TaBle.FieldByName('Qt2_Base').AsCurrency := TaBle.FieldByName('Qt2_Base').AsCurrency + Qte;
          End;
          TaBle.Post;
          TaBle.FlushBuffers;
     End
     Else
     Begin
          If Debit Then
             TaBle.AppendRecord([Compte,Null,Null,Null,Montant,Null,Null,Null,Null,Null,Qte,Null,Null,Null])
          Else
             TaBle.AppendRecord([Compte,Null,Null,Null,Null,Montant,Null,Null,Null,Null,Null,Qte,Null,Null]);
     End;
     TaBle.FlushBuffers;
     TaBle.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Mise à jour de la balance lors de la suppression d'un enreg sans OD dans   //
// la clôture.                                                                //
//****************************************************************************//
Procedure MAJBalanceSuppressionClotureSansOD(Table: TTable; Compte: String; Montant,Qte: Currency; Debit: Boolean);
Begin
     Table.Open;
     If Table.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceSuppressionClotureSansOD !!!',MtWarning,[mbok],0);
     Table.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Mise à jour de la balance lors de la suppression d'un enreg avec OD dans   //
// la clôture.                                                                //
//****************************************************************************//
Procedure MAJBalanceSuppressionClotureAvecOD(Table: TTable; Compte,Compte2: String; Montant,Qte: Currency; Debit,Debit2: Boolean);
Begin
     Table.Open;
     // Mise à jour dans la balance du compte de reprise
     If Table.Locate('Compte',Compte2,[]) Then
     Begin
          Table.Edit;
          If Debit2 Then
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - Qte;
          End
          Else
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceSuppressionClotureAvecOD !!!',MtWarning,[mbok],0);

     // Mise à jour de la balance pour le compte de charge ou le compte de produit
     If Table.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceSuppressionClotureAvecOD !!!',MtWarning,[mbok],0);

     Table.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Mise à jour de la balance lors de la modif dans la cloture d'un enreg qui  //
// n'a pas d'OD et avec un numéro de compte non modifié.                      //
//****************************************************************************//
Procedure MAJBalanceModifClotureSansOD(Table: TTable; Compte: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit: Boolean);
Begin
     Table.Open;
     If TaBle.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               TaBle.FieldByName('Debit_Base').AsCurrency := TaBle.FieldByName('Debit_Base').AsCurrency - MontantTmp + Montant;
               TaBle.FieldByName('Qt1_Base').AsCurrency := TaBle.FieldByName('Qt1_Base').AsCurrency - QteTmp + Qte;
          End
          Else
          Begin
               TaBle.FieldByName('Credit_Base').AsCurrency := TaBle.FieldByName('Credit_Base').AsCurrency - MontantTmp + Montant;
               TaBle.FieldByName('Qt2_Base').AsCurrency := TaBle.FieldByName('Qt2_Base').AsCurrency - QteTmp + Qte;
          End;
          TaBle.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifClotureSansOD !!!',MtWarning,[mbok],0);
     TaBle.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Mise à jour de la balance lors de la modif d'un enreg dans la cloture qui  //
// possède une OD sans numéro de compte modifié.                              //
//****************************************************************************//
Procedure MAJBalanceModifClotureAvecOD(Table: TTable; Compte,Compte2: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit,Debit2: Boolean);
Begin
     Table.Open;
     // Mise à jour dans la balance du compte de reprise
     If Table.Locate('Compte',Compte2,[]) Then
     Begin
          Table.Edit;
          If Debit2 Then
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - QteTmp + Qte;
          End
          Else
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - QteTmp + Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifClotureAvecOD !!!',MtWarning,[mbok],0);

     // Mise à jour de la balance pour le compte de charge ou le compte de produit
     If Table.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - QteTmp + Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - QteTmp + Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifClotureAvecOD !!!',MtWarning,[mbok],0);

     Table.Close;
End;
//****************************************************************************//


//****************************************************************************//
// Mise à jour de la balance après la modification d'un enreg dans la cloture //
// qui a une OD et dont le compte a été modifié.                              //
//****************************************************************************//
Procedure MAJBalanceModifClotureCpModifAvecOD(Table: TTable; Compte,Compte2,CompteTmp: String; Montant,MontantTmp,Qte,QteTmp: Currency; Debit:Boolean);
Begin
     Table.Open;
     // Mise à jour de l'ancien compte de reprise
     If Table.Locate('Compte',CompteTmp,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - MontantTmp;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - QteTmp;
          End
          Else
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - MontantTmp;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - QteTmp;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifClotureCpModifAvecOD !!!',MtWarning,[mbok],0);

     // Mise à jour du nouveau compte de reprise
     If Table.Locate('Compte',Compte2,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency + Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency + Qte;
          End
          Else
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency + Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency + Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
     Begin
          If Debit Then
             Table.AppendRecord([Compte2,Null,Null,Null,Null,Montant,Null,Null,Null,Null,Null,Qte,Null,Null])
          Else
             Table.AppendRecord([Compte2,Null,Null,Null,Montant,Null,Null,Null,Null,Null,Qte,Null,Null,Null]);
     TaBle.FlushBuffers;
     End;

     // Mise à jour de la balance pour le compte de charge ou le compte de produit
     If Table.Locate('Compte',Compte,[]) Then
     Begin
          Table.Edit;
          If Debit Then
          Begin
               Table.FieldByName('Debit_Base').AsCurrency := Table.FieldByName('Debit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt1_Base').AsCurrency := Table.FieldByName('Qt1_Base').AsCurrency - QteTmp + Qte;
          End
          Else
          Begin
               Table.FieldByName('Credit_Base').AsCurrency := Table.FieldByName('Credit_Base').AsCurrency - MontantTmp + Montant;
               Table.FieldByName('Qt2_Base').AsCurrency := Table.FieldByName('Qt2_Base').AsCurrency - QteTmp + Qte;
          End;
          Table.Post;
          TaBle.FlushBuffers;
     End
     Else
         Messagedlg('Problème dans MAJBalanceModifClotureCpModifAvecOD !!!',MtWarning,[mbok],0);

     Table.Close;
End;
//****************************************************************************//


end.
