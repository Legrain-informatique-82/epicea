unit DMTVA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Gr_Librairie_obj, E2_Librairie_obj,LibSQL,
  E2_GenerCpt_PM,
  DMEcriture,DMPlanCpt,LibZoneSaisie,E2_Decl_Records,DMREcherche,DMConstantes;
type
  TRecupMiniMaxTva=record
    Taux_Inf:currency;
    Taux_Supp:currency;
    TvaCode:string;
    Compte:string;
    Libelle:string;
    CodeRetour:integer;
  end;

//    TErreurCodeTVA=record
//      CodeErreur:integer;
//      Retour:boolean;
//    end;

type
  TDMTVACode = class(TDataModule)
    TaTvaCode: TTable;
    DataTvaCode: TDataSource;
    TaTvaCodeRec: TTable;
    TaTVAClasse: TTable;
    TaTvaReference: TTable;
    DaTvaReference: TDataSource;
    DaTVAClasse: TDataSource;
    QuCode_Edition: TQuery;
    QuJournaux_Edition: TQuery;
    procedure DMTVACodeCreate(Sender: TObject);
    procedure DMTVACodeDestroy(Sender: TObject);
    procedure TaTvaCodeBeforeOpen(DataSet: TDataSet);
    Function CtrlSaisieCodeTva(CCourant:Tfield):TErreurSaisie;
    procedure TaTvaCodeBeforePost(DataSet: TDataSet);
    procedure TaTvaCodeBeforeInsert(DataSet: TDataSet);
    procedure TaTvaCodeBeforeEdit(DataSet: TDataSet);
    procedure TaTvaCodeBeforeDelete(DataSet: TDataSet);
    procedure TaTvaCodeAfterInsert(DataSet: TDataSet);
    procedure QuCode_EditionFilterRecord(DataSet: TDataSet;
     var Accept: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
     ClasseTVA :TStringlist;
     ListeFilterRecordJournaux:Tstringlist;
     Procedure ImportCodeTVA(Valeurs:array of const;DataSet:TDataSet);
  end;

var
  DMTVACode: TDMTVACode;


  function FTvaRecupMiniMaxTva(CodeTva:string):TRecupMiniMaxTva;
  Function FTvaRecupCodeTva(CompteTVA:string):string;
  Function FTvaRecupCodeTva_SurClasse(Classe:string;TauxTva:string):string;
  Function FTvaRecupCompteTva(CodeTVA:string):string;
  Function FTvaCompteDeTva(Compte:String):boolean;
  Function FTvaTypeTva(Compte:String):string;
  Function FTvaTauxTva(CodeTva:string):real;
  Function FTvaCodeIntracommunautaire(ListeClasses:Tstringlist=nil):Tstringlist;
  procedure Initialise_RecupMiniMaxTva(Var RecupMiniMaxTva:TRecupMiniMaxTva);
  Function FCodeTvaExist(CodeTVA:string):boolean;

  Function EditionDesJournauxDeTvaSansCalcul(TypeEdition : integer; DemandePeriode:Boolean; Journal:TStringList;DataSet:TDataSet;Synthese : boolean = false):Boolean;overload ;
  Function EditionDesJournauxDeTvaSansCalcul(TypeEdition : integer; DemandePeriode:Boolean; Journal:String;DataSet:TDataSet;Synthese : boolean = false):Boolean;overload;
  Function EditionDesJournauxSansTvaSansCalcul(TypeEdition : integer; DemandePeriode:Boolean; Journal:TStringList;DataSet:TDataSet;Synthese : boolean = false):Boolean;overload ;
  Function EditionDesJournauxSansTvaSansCalcul(TypeEdition : integer; DemandePeriode:Boolean; Journal:String;DataSet:TDataSet;Synthese : boolean = false):Boolean;overload;


implementation

uses ChoixPeriode, ObjetEdition,  lib_chaine, DMExports, LibDates;

{$R *.DFM}


function FTvaRecupMiniMaxTva(CodeTva:string):TRecupMiniMaxTva;
begin     { isa  le  30/07/04 vu avec phil}
 if DMRech=nil then DMRech:=TDMRech.Create(application.MainForm);
 Initialise_RecupMiniMaxTva(result);
 DeFiltrageDataSet(DMRech.TaTvaCodeRech);
 if DMRech.TaTvaCodeRech.Locate('TvaCode',CodeTva,[]) then
     begin //si enregistrement trouvé
     result.Compte:=DMRech.TaTvaCodeRech.findfield('Compte').asstring;
     result.TvaCode:=DMRech.TaTvaCodeRech.findfield('TvaCode').asstring;
     result.Libelle:=DMRech.TaTvaCodeRech.findfield('Libelle').asstring;
       If not VerifFNumeric(DMRech.TaTvaCodeRech.findfield('Taux_Inf')).VideOUZero then
//       IF (not(empty(DMTVACode.TaTvaCode.findfield('Taux_Inf').asstring))) and(DMTVACode.TaTvaCode.findfield('Taux_Inf').AsCurrency<>0) then
       begin
       result.Taux_Inf:=DMRech.TaTvaCodeRech.findfield('Taux_Inf').ascurrency;
       result.CodeRetour:=1;
       end
       else
       result.Taux_Inf:=0;

       If not VerifFNumeric(DMRech.TaTvaCodeRech.findfield('Taux_Supp')).VideOUZero then
//       IF (not(empty(DMTVACode.TaTvaCode.findfield('Taux_Supp').asstring))) and(DMTVACode.TaTvaCode.findfield('Taux_Supp').AsCurrency<>0) then
       begin
         result.Taux_Supp:=DMRech.TaTvaCodeRech.findfield('Taux_Supp').AsCurrency;
         if result.CodeRetour=1 then
          begin
           if Result.Taux_Inf <> Result.Taux_Supp then
             result.CodeRetour:=12
          else result.CodeRetour:=2;  // SI les deux codes TVA sont égaux et non (vide ou egale=0) alors
         end;                        // On retour recoit 2 car on prends le taux Supp par défaut
       end
       else
       result.Taux_Supp:=0;
       if Result.Taux_Inf <> Result.Taux_Supp then result.CodeRetour:=12;
     end;
end;

Function FTvaTypeTva(Compte:String):string;
// Retourne le type TVA ( Vrai= D ou False=E) / TvaCode
var
TvaCodePourCompte:TTvaCodePourCompte;
Begin
if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
if FTvaCompteDeTva(compte) then
 begin
//  if ((FTvaRecupCodeTva(compte) = 'I') or (FTvaRecupCodeTva(compte) = 'A') or (FTvaRecupCodeTva(compte) = 'C') or (FTvaRecupCodeTva(compte) = 'N'))
//     then result:='E'
//     else
//      if ((FTvaRecupCodeTva(compte) = 'V') or (FTvaRecupCodeTva(compte) = 'L') or (FTvaRecupCodeTva(compte) = 'I'))
//         then result:='E'
//         else result:='D';
  if ((FTvaRecupCodeTva(compte) = 'A') or (FTvaRecupCodeTva(compte) = 'M') or (FTvaRecupCodeTva(compte) = 'C') or (FTvaRecupCodeTva(compte) = 'N'))
     then result:='E'
     else
      if ((FTvaRecupCodeTva(compte) = 'V') or (FTvaRecupCodeTva(compte) = 'L'))
         then result:='E'
         else result:='D';
 end
 else
 Begin
//   if varisnull(DmPlanRecupPartieEnregistrement(Compte,'TvaType').Partie) then
   if not DmPlanRecupPartieEnregistrement(Compte,'TvaType').codeRetour then
    begin
     // Affecter ici le type de tva par défaut
     TvaCodePourCompte:=DMPlan.TvaCodePourCompte(31,E.Regime,Compte);
     if TvaCodePourCompte.Retour then
       Begin
//        if TvaCodePourCompte.ListeCode.Strings[0]='I'
//         then result:='E'  //E=Encaissement
//         else
          if TvaCodePourCompte.ListeCode.Strings[0]='A'
           then result:='E' //E=Encaissement
           else result:='D';  //D=Livraison
       end
     else result:=''; // Affectation d'un type par défaut
     Initialise_TStringlist(TvaCodePourCompte.ListeClasse);
     Initialise_TStringlist(TvaCodePourCompte.ListeCode);
     Initialise_TStringlist(TvaCodePourCompte.ListeCompteTVA);
    end else result:=DmPlanRecupPartieEnregistrement(Compte,'TvaType').Partie;
 End;

End;

procedure TDMTVACode.DMTVACodeCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
TaTvaCode.FindField('Classe').ValidChars:=(['A','C','I','V','E','L','M','f','N','T','a','c','i','v','e','l','n','m','f','t']);
TaTvaCode.FindField('Compte').ValidChars:=(['0'..'9']);
ClasseTVA:=TStringlist.Create;
if ListeFilterRecordJournaux = nil then ListeFilterRecordJournaux:=Tstringlist.Create;
ClasseTVA.Add('A');
ClasseTVA.Add('C');
ClasseTVA.Add('I');
ClasseTVA.Add('V');
ClasseTVA.Add('E');
ClasseTVA.Add('F');
ClasseTVA.Add('L');
ClasseTVA.Add('M');
ClasseTVA.Add('N');
ClasseTVA.Add('T');
end;

procedure TDMTVACode.DMTVACodeDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
if ListeFilterRecordJournaux <> nil then ListeFilterRecordJournaux.Free;
ClasseTVA.Free;
DMTVACode:=nil;
end;

Function FTvaRecupCompteTva(CodeTVA:string):string;
Begin
if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
result:='';
//DMTVACode.TaTvaCodeRec.Open;
//DMTVACode.TaTvaCodeRec.Filter:='';
//DMTVACode.TaTvaCodeRec.Filtered:=false;
DeFiltrageDataSet(DMTVACode.TaTvaCodeRec);
if DMTVACode.TaTvaCodeRec.Locate('TvaCode',CodeTVA,[]) then
   result:=DMTVACode.TaTvaCodeRec.findfield('Compte').AsString;
End;

Function FCodeTvaExist(CodeTVA:string):boolean;
Begin
if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
result:=false;
DeFiltrageDataSet(DMTVACode.TaTvaCodeRec);
if DMTVACode.TaTvaCodeRec.Locate('tvacode',CodeTVA,[loPartialKey]) then
   result:=(DMTVACode.TaTvaCodeRec.RecordCount>0) and (DMTVACode.TaTvaCodeRec.FindField('tvacode')<>nil);
End;

Function FTvaRecupCodeTva(CompteTVA:string):string;
Begin
if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
result:='';
DeFiltrageDataSet(DMTVACode.TaTvaCodeRec);
//DMTVACode.TaTvaCodeRec.Open;
//DMTVACode.TaTvaCodeRec.Filter:='';
//DMTVACode.TaTvaCodeRec.Filtered:=false;
if DMTVACode.TaTvaCodeRec.Locate('Compte',CompteTva,[]) then
   result:=DMTVACode.TaTvaCodeRec.findfield('TvaCode').AsString;
End;

Function FTvaCompteDeTva(Compte:String):boolean;
Begin
if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
DeFiltrageDataSet(DMTVACode.TaTvaCodeRec);
result:=DMTVACode.TaTvaCodeRec.Locate('Compte',Compte,[]);
End;

procedure TDMTVACode.TaTvaCodeBeforeOpen(DataSet: TDataSet);
begin
//if not TaTVAClasse.Active then TaTVAClasse.Open;
//TaTvaCode.FindField('Classe').ValidChars:=(['A','C','I','V','E','L','N']);
end;

Function TDMTVACode.CtrlSaisieCodeTva(CCourant:Tfield):TErreurSaisie;
var
i:integer;
ParamGenerCptAffiche:TParamGenerCptAffiche;
begin // initialisation des variables de retour de fonction
//
case CCourant.DataSet.State of
   dsInsert:Begin
             case CCourant.Index of
                1:Begin //Classe
                      if TaTVAClasse.Locate('Classe',uppercase(CCourant.AsString),[])  then
                      begin
                       CCourant.AsString:=uppercase(CCourant.AsString);
                       CtrlSaisieCodeTva(CCourant.DataSet.findfield('TvaCode'));
                       CtrlSaisieCodeTva(CCourant.DataSet.findfield('Libelle'));
                       result.Retour:=true;
                       result.CodeErreur:=0;
                      end
                       else
                      begin
                       result.Retour:=False;
                       If Empty(CCourant.AsString) then
                       result.CodeErreur:=1000 else
                       result.CodeErreur:=1001;
                      end;
                  End;
                0:Begin // TvaCode
                   case length(CCourant.AsString) of // Si TVACode est vide
                     0:Begin
                         result.Retour:=true;
                         Result.CodeErreur:=0;
                         TaTvaCodeRec.Open;
                         TaTvaCodeRec.Filter:=CreeFiltreET(['Classe'],[uppercase(CCourant.DataSet.findfield('Classe').AsString)]);
                         TaTvaCodeRec.Filtered:=true;
                         //Affectation d'une valeur par defaut en fonction de la dernire valeur trouvé
                         if TaTvaCodeRec.RecordCount > 0 then
                            begin
                              TaTvaCodeRec.Last;
                              i:=ord(TaTvaCodeRec.findfield('TvaCode').AsString[2])+1;
                              case i of
                                 48..57:CCourant.DataSet.findfield('TvaCode').AsString:=
                                        uppercase(CCourant.DataSet.findfield('Classe').AsString) + uppercase(chr(i));
                                 58:CCourant.DataSet.findfield('TvaCode').AsString:=
                                        uppercase(CCourant.DataSet.findfield('Classe').AsString) + 'A';
                                 65..90:CCourant.DataSet.findfield('TvaCode').AsString:=
                                        uppercase(CCourant.DataSet.findfield('Classe').AsString) + uppercase(chr(i));
                                 97..122:CCourant.DataSet.findfield('TvaCode').AsString:=
                                        uppercase(CCourant.DataSet.findfield('Classe').AsString) + uppercase(chr(i));
                                 else
                                 begin  // Si dernier Code est <CodeTVA>Z alors demande de saisie d'un code par l'utilisateur
                                  result.Retour:=false;
                                  Result.CodeErreur:=100;
                                 end;
                              end;
                            end
                            else
                            begin // Si pas de code alors tvacode = <CodeTVA>1
                              CCourant.DataSet.findfield('TvaCode').AsString:=uppercase(CCourant.DataSet.findfield('Classe').AsString) + '1';
                            end;
                       End;
                     1:Begin
                         TaTvaCodeRec.Filter:='';
                         TaTvaCodeRec.Filtered:=false;
                         TaTvaCodeRec.Open;
                         if TaTVAClasse.Locate('Classe',uppercase(CCourant.DataSet.findfield('TvaCode').AsString),[])=false then
                            begin // La première lettre du <CodeTVA> ne correspond pas a la classe
                             result.Retour:=false;
                             Result.CodeErreur:=101;
                            end
                            else
                            begin
                              TaTvaCodeRec.Filter:=CreeFiltreET(['Classe'],[uppercase(CCourant.DataSet.findfield('Classe').AsString)]);
                              TaTvaCodeRec.Filtered:=true;
                              //Affectation d'une valeur par defaut en fonction de la dernire valeur trouvé
                              if TaTvaCodeRec.RecordCount > 0 then
                                 begin
                                   TaTvaCodeRec.Last;
                                   i:=ord(TaTvaCodeRec.findfield('TvaCode').AsString[2])+1;
                                   case i of
                                      48..57:CCourant.DataSet.findfield('TvaCode').AsString:=
                                             uppercase(CCourant.DataSet.findfield('Classe').AsString) + uppercase(chr(i));
                                      58:CCourant.DataSet.findfield('TvaCode').AsString:=
                                             uppercase(CCourant.DataSet.findfield('Classe').AsString) + 'A';
                                      65..90:CCourant.DataSet.findfield('TvaCode').AsString:=
                                             uppercase(CCourant.DataSet.findfield('Classe').AsString) + uppercase(chr(i));
                                      97..122:CCourant.DataSet.findfield('TvaCode').AsString:=
                                             uppercase(CCourant.DataSet.findfield('Classe').AsString) + uppercase(chr(i));
                                      else
                                      begin // Si dernier Code est <CodeTVA>Z alors demande de saisie d'un code par l'utilisateur
                                       result.Retour:=false;
                                       Result.CodeErreur:=100;
                                      end;
                                   end
                                 end
                                 else
                                 begin // Si pas de code alors tvacode = <CodeTVA>1
                                   CCourant.DataSet.findfield('TvaCode').AsString:=uppercase(CCourant.DataSet.findfield('Classe').AsString) + '1';
                                 end;
                           end;
                       End;
                     2:Begin
                         TaTvaCodeRec.Filter:='';
                         TaTvaCodeRec.Filtered:=false;
                         TaTvaCodeRec.Open; // Si TvaCode existe
                         CCourant.AsString:=uppercase(CCourant.AsString);
                         if TaTvaCodeRec.Locate('TvaCode',uppercase(CCourant.DataSet.findfield('TvaCode').AsString),[])=true then
                            begin
                             result.Retour:=false;
                             Result.CodeErreur:=102;
                            end
                            else
                            begin //sinon si la <CodeTVA>[1] <> Classe
                            if CCourant.DataSet.findfield('TvaCode').AsString[1]<>CCourant.DataSet.findfield('Classe').AsString then
                             begin
                              result.Retour:=false;
                              Result.CodeErreur:=101;
                             end;
                            end;
                       End;
                   end;
                  End; // Fin de tvaCode
                3:Begin //Compte
                   case ord(CCourant.DataSet.findfield('Classe').AsString[1]) of
                   {A}65:Begin
                           //44566
                         TaTvaCodeRec.Filter:='';
                         TaTvaCodeRec.Filtered:=false;
                         TaTvaCodeRec.Open;
                         result.Retour:=true;
                         Result.CodeErreur:=0;
                          if VerifFNumeric(CCourant).VideOUZero then
                             Begin
                              Messagedlg('Un compte de TVA est nécessaire pour ce code de Tva ',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3002;
                             End
                             else
                             if length(CCourant.AsString) < 5 then
                             begin
                              Messagedlg('Ce numéro de compte n''est pas valide dans le contexte',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3003;
                             end
                             else
                             if (copy(CCourant.AsString,1,5) <> DM_C_CompteTVAAutreBiensServices_A1)and( copy(CCourant.AsString,1,5) <> DM_C_CompteTVAAutreBiensServices_A2) then
                             begin
                              Messagedlg('Ce numéro de compte n''est pas valide dans le contexte',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3003;
                             end
                             else
                             if TaTvaCodeRec.Locate('Compte',CCourant.AsString,[])=true then
                             begin // Si le compte est déjà utilisé
                              Messagedlg('Ce numéro de compte est déjà utilisé.',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3004;
                             end
                             else
                             begin
                             if not DMPlan.CompteExistePCU(CCourant.AsString) then
                                Begin
                                  if not DMPlan.TaCompte.Active then DMPlan.TaCompte.Open;
                                  DMPlan.TaCompte.InsertRecord([CCourant.AsString,DMPlan.LibelleDuNumCpt(CCourant.AsString)]);
                                  DMPlan.TaCompte.FlushBuffers;
                                  ParamGenerCptAffiche.Affiche:=True;
                                  DMPlan.CreationAuto(CCourant.AsString,ParamGenerCptAffiche);
                                End;
                             end;
                         End;
                   {C}67:Begin
                          //pas de compte tva
                          if not VerifFNumeric(CCourant).VideOUZero then
                             Begin
                              Messagedlg('Il n''y a pas de compte de TVA pour ce code de Tva ',MtWarning,[mbok],0);
                              CCourant.AsString:='';
                              result.Retour:=false;
                              Result.CodeErreur:=3001;
                             End;
                         End;
                   {I}73:Begin
                          //44562
                         TaTvaCodeRec.Filter:='';
                         TaTvaCodeRec.Filtered:=false;
                         TaTvaCodeRec.Open;
                         result.Retour:=true;
                         Result.CodeErreur:=0;
                          if VerifFNumeric(CCourant).VideOUZero then
                             Begin
                              Messagedlg('Un compte de TVA est nécessaire pour ce code de Tva ',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3002;
                             End
                             else
                             if length(CCourant.AsString) < 5 then
                             begin
                              Messagedlg('Ce numéro de compte n''est pas valide dans le contexte',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3003;
                             end
                             else
                             if copy(CCourant.AsString,1,5) <> DM_C_CompteTVAAchatImmo_I1 then
                             begin
                              Messagedlg('Ce numéro de compte n''est pas valide dans le contexte',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3003;
                             end
                             else
                             if TaTvaCodeRec.Locate('Compte',CCourant.AsString,[])=true then
                             begin // Si le compte est déjà utilisé
                              Messagedlg('Ce numéro de compte est déjà utilisé.',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3004;
                             end
                             else
                             begin
                             if not DMPlan.CompteExistePCU(CCourant.AsString) then
                                Begin
                                  if not DMPlan.TaCompte.Active then DMPlan.TaCompte.Open;
                                  DMPlan.TaCompte.InsertRecord([CCourant.AsString,DMPlan.LibelleDuNumCpt(CCourant.AsString)]);
                                  DMPlan.TaCompte.FlushBuffers;
                                  ParamGenerCptAffiche.Affiche:=True;
                                  DMPlan.CreationAuto(CCourant.AsString,ParamGenerCptAffiche);
                                End;
                             end;
                         End;
                   {V}86:Begin
                          //44571
                         TaTvaCodeRec.Filter:='';
                         TaTvaCodeRec.Filtered:=false;
                         TaTvaCodeRec.Open;
                         result.Retour:=true;
                         Result.CodeErreur:=0;
                          if VerifFNumeric(CCourant).VideOUZero then
                             Begin
                              Messagedlg('Un compte de TVA est nécessaire pour ce code de Tva ',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3002;
                             End
                             else
                             if length(CCourant.AsString) < 5 then
                             begin
                              Messagedlg('Ce numéro de compte n''est pas valide dans le contexte',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3003;
                             end
                             else
                             if copy(CCourant.AsString,1,5) <> DM_C_CompteTVACollectee then
                             begin
                              Messagedlg('Ce numéro de compte n''est pas valide dans le contexte',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3003;
                             end
                             else
                             if TaTvaCodeRec.Locate('Compte',CCourant.AsString,[])=true then
                             begin // Si le compte est déjà utilisé
                              Messagedlg('Ce numéro de compte est déjà utilisé.',MtWarning,[mbok],0);
                              result.Retour:=false;
                              Result.CodeErreur:=3004;
                             end
                             else
                             begin
                             if not DMPlan.CompteExistePCU(CCourant.AsString) then
                                Begin
                                  if not DMPlan.TaCompte.Active then DMPlan.TaCompte.Open;
                                  DMPlan.TaCompte.InsertRecord([CCourant.AsString,DMPlan.LibelleDuNumCpt(CCourant.AsString)]);
                                  DMPlan.TaCompte.FlushBuffers;
                                  ParamGenerCptAffiche.Affiche := true;
                                  DMPlan.CreationAuto(CCourant.AsString,ParamGenerCptAffiche);
                                End;
                             end;
                         End;
                   {E}69:Begin
                          //pas de compte tva
                          if not VerifFNumeric(CCourant).VideOUZero then
                             Begin
                              Messagedlg('Il n''y a pas de compte de TVA pour ce code de Tva ',MtWarning,[mbok],0);
                              CCourant.AsString:='';
                              result.Retour:=false;
                              Result.CodeErreur:=3001;
                             End;
                         End;
                   {L}76:Begin
                          //pas de compte tva
                          if not VerifFNumeric(CCourant).VideOUZero then
                             Begin
                              Messagedlg('Il n''y a pas de compte de TVA pour ce code de Tva ',MtWarning,[mbok],0);
                              CCourant.AsString:='';
                              result.Retour:=false;
                              Result.CodeErreur:=3001;
                             End;
                         End;
                   {N}78:Begin
                          //pas de compte tva
                          if not VerifFNumeric(CCourant).VideOUZero then
                             Begin
                              Messagedlg('Il n''y a pas de compte de TVA pour ce code de Tva ',MtWarning,[mbok],0);
                              CCourant.AsString:='';
                              result.Retour:=false;
                              Result.CodeErreur:=3001;
                             End;
                         End;
                   end;
                  End;
                2:Begin //Libelle
                   if empty(CCourant.AsString) then
                      Begin
                         if TaTVAClasse.Locate('Classe',uppercase(CCourant.DataSet.findfield('Classe').AsString),[])=true then
                            CCourant.AsString:=TaTVAClasse.findfield('Libelle').AsString;
                      End;
                  End;
                4:Begin //Taux Inf
                   if VerifFNumeric(CCourant).Vide then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=4001;
                      End
                      else
                      if VerifFNumeric(CCourant.DataSet.FindField('Taux_Supp')).Vide then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=4002;
                      End
                      else
                      if CCourant.AsString > CCourant.DataSet['Taux_Supp'] then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=4003;
                      End
                  End;
                5:Begin // Taux Supp
                   if VerifFNumeric(CCourant).Vide then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=5001;
                      End
                      else
                      if VerifFNumeric(CCourant.DataSet.FindField('Taux_Inf')).Vide then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=5002;
                      End
                      else
                      if CCourant.AsString < CCourant.DataSet['Taux_Supp'] then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=5003;
                      End
                  End;
             end; // Fin du case Index
            End; // Fin du dsInsert
   dsEdit:Begin
             case CCourant.Index of
                2:Begin //Libelle
                   if empty(CCourant.AsString) then
                      Begin
                         if TaTVAClasse.Locate('Classe',uppercase(CCourant.DataSet.findfield('Classe').AsString),[])=true then
                            CCourant.AsString:=TaTVAClasse.findfield('Libelle').AsString;
                      End;
                  End;
                4:Begin //Taux Inf
                   if VerifFNumeric(CCourant).Vide then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=4001;
                      End
                      else
                      if VerifFNumeric(CCourant.DataSet.FindField('Taux_Supp')).Vide then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=4002;
                      End
                      else
                      if CCourant.AsString > CCourant.DataSet['Taux_Supp'] then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=4003;
                      End
                  End;
                5:Begin // Taux Supp
                   if VerifFNumeric(CCourant).Vide then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=5001;
                      End
                      else
                      if VerifFNumeric(CCourant.DataSet.FindField('Taux_Inf')).Vide then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=5002;
                      End
                      else
                      if CCourant.AsString < CCourant.DataSet['Taux_Supp'] then
                      Begin
                        result.Retour:=false;
                        Result.CodeErreur:=5003;
                      End
                  End;
             end; // Fin du case Index
          End; // Fin du dsEdit
end; // Fin cu Case State

end;
procedure TDMTVACode.TaTvaCodeBeforePost(DataSet: TDataSet);
var
i:integer;
ErreurCodeTVA:TErreurSaisie;
begin
// Verification et affectation pour obtenir un taux unique ds taux inf et taux Supp
// Ce cas se produit si un des deux taux = 0
if VerifFNumeric(DataSet.FindField('Taux_Supp')).VideouZero and not VerifFNumeric(DataSet.FindField('Taux_INf')).VideouZero
 then
  begin
   DataSet.FindField('Taux_Supp').AsCurrency := DataSet.FindField('Taux_Inf').AsCurrency;
  end
 else
  if VerifFNumeric(DataSet.FindField('Taux_Inf')).VideouZero and not VerifFNumeric(DataSet.FindField('Taux_Supp')).VideouZero
  then
    Begin
     DataSet.FindField('Taux_Inf').AsCurrency := DataSet.FindField('Taux_Supp').AsCurrency;
    End;

// Affectation d'un 0 si l'un des taux est vide
if VerifFNumeric(DataSet.FindField('Taux_Inf')).Vide then DataSet.FindField('Taux_Inf').AsCurrency:=0;
if VerifFNumeric(DataSet.FindField('Taux_Supp')).Vide then DataSet.FindField('Taux_Supp').AsCurrency:=0;

for i:= 0 to Dataset.FieldCount-1 do
case Dataset.State of
   dsInsert:Begin
            ErreurCodeTVA:=DMTVACode.CtrlSaisieCodeTva(Dataset.Fields[i]);
            if ErreurCodeTVA.Retour= false then
               begin
                case ErreurCodeTVA.CodeErreur of
                   1000:Begin
                        messagedlg('LA classe de TVA est obligatoire.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;

                   1001:Begin
                        messagedlg('Cette classe de TVA n''existe pas.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
                   100:Begin
                        messagedlg('Veuillez saisir un code de TVA valide.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
                   101:Begin
                        messagedlg('Ce code de Tva ne correspond à la classe de TVA choisie.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
                   102:Begin
                        messagedlg('Ce code de TVA existe déjà.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
                   3002:Begin
                        abort;
                        End;
                   3003:Begin
                        abort;
                        End;
                   3004:Begin
                        abort;
                        End;
                   4003:Begin
                        messagedlg('Le taux inférieur ne peut être supérieur au taux supérieur.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
                   5003:Begin
                        messagedlg('Le taux supérieur ne peut être inférieur au taux inférieur.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
                end;
               end;
            End;
   dsEdit:Begin
            ErreurCodeTVA:=DMTVACode.CtrlSaisieCodeTva(Dataset.Fields[i]);
            if ErreurCodeTVA.Retour= false then
               begin
                case ErreurCodeTVA.CodeErreur of
                   1000,1001:abort;
                   100:abort;
                   101:abort;
                   102:abort;
                   103:abort;
                   4003:Begin
                        messagedlg('Le taux inférieur ne peut être supérieur au taux supérieur.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
                   5003:Begin
                        messagedlg('Le taux supérieur ne peut être inférieur au taux inférieur.',MtWarning,[mbok],0);
                        Dataset.Fields[i].FocusControl;
                        abort;
                        End;
                end;
               end;
            End;
//            End;
end;

end;

procedure TDMTVACode.TaTvaCodeBeforeInsert(DataSet: TDataSet);
begin
Dataset.Fields[1].FocusControl;
end;

procedure TDMTVACode.TaTvaCodeBeforeEdit(DataSet: TDataSet);
begin
//Dataset.Fields[4].FocusControl;
end;

procedure TDMTVACode.TaTvaCodeBeforeDelete(DataSet: TDataSet);
begin
try
DeFiltrageDataSet(DMRech.TaPlanCptRech);
if DMRech.TaPlanCptRech.Locate('TvaCode',DMTVACode.TaTvaCode.FindField('TvaCode').AsString,[]) then
 begin
    Messagedlg('Ce code de Tva est utilisé dans le plan comptable.'+#10#13+'Il est impossible de le supprimer.',MtWarning,[mbok],0);
    abort;
 end
 else
if DetailEcritureCompteTVA(DMTVACode.TaTvaCode.FindField('Compte').AsString,DMTVACode.TaTvaCode.FindField('TvaCode').AsString,false) then
   Begin
    Messagedlg('Ce code de Tva est utilisé dans les écritures.'+#10#13+'Il est impossible de le supprimer.',MtWarning,[mbok],0);
    abort;
   End;
Case E.TypeEtatExercice of
 ET_Importation:begin

                end;
  ET_Normal:    begin
                  if Application.MessageBox(PChar('Voulez-Vous supprimer le code : '+DMTVACode.TaTvaCode.FindField('TvaCode').AsString),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
                     abort;
                end;
end;//fin du case E.TypeEtatExercice
except
raise;
end;
end;

procedure TDMTVACode.TaTvaCodeAfterInsert(DataSet: TDataSet);
begin
DataSet['Taux_inf']:='0';
DataSet['Taux_supp']:='0';
end;


Function FTvaTauxTva(CodeTva:string):real;
Begin
if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
result:=0;
DeFiltrageDataSet(DMTVACode.TaTvaCodeRec);
if DMTVACode.TaTvaCodeRec.Locate('TvaCode',CodeTva,[]) then
   result:=DMTVACode.TaTvaCodeRec.findfield('Taux_Inf').AsFloat;
End;

Procedure TDMTVACode.ImportCodeTVA(Valeurs:array of const;DataSet:TDataSet);
Begin
  try
   ImportTable(Valeurs,DataSet);
  except
   abort;
  end;
End;


Function FTvaCodeIntracommunautaire(ListeClasses:Tstringlist):Tstringlist;
var
TvaCodeIntraCom:TTvaCodePourCompte;
Begin
try//finally
  try//except
  TvaCodeIntraCom.ListeClasse:=TStringList.Create;
  TvaCodeIntraCom.ListeCode:=TStringList.Create;
  TvaCodeIntraCom.ListeCompteTVA:=TStringList.Create;
  TvaCodeIntraCom.Retour:=true;

  if ((ListeClasses=nil)or(ListeClasses.count=0))then
    Begin
      TvaCodeIntraCom.ListeClasse:=DM_C_ListeCTVAIntracommunautaire;
//      TvaCodeIntraCom.ListeClasse.Add('C');
//      TvaCodeIntraCom.ListeClasse.Add('L');
//      TvaCodeIntraCom.ListeClasse.Add('E');
//      TvaCodeIntraCom.ListeClasse.Add('N');
    End
  else
    Begin
      TvaCodeIntraCom.ListeClasse:=ListeClasses;
    End;

  if (DMTVACode = nil) then DMTVACode:=TDMTVACode.Create(application.MainForm);
  DMTVACode.TaTvaCodeRec.Filter:=CreeFiltreOU('Classe',[TvaCodeIntraCom.ListeClasse]);
  DMTVACode.TaTvaCodeRec.Filtered:=true;
  DMTVACode.TaTvaCodeRec.Open;
  DMTVACode.TaTvaCodeRec.first;
  while not DMTVACode.TaTvaCodeRec.EOF do
        Begin
         TvaCodeIntraCom.ListeCode.Add(UpperCase(DMTVACode.TaTvaCodeRec.findfield('TvaCode').AsString));
         TvaCodeIntraCom.ListeCompteTVA.Add(UpperCase(DMTVACode.TaTvaCodeRec.findfield('Compte').AsString));
         DMTVACode.TaTvaCodeRec.Next;
        End;
  result:=TvaCodeIntraCom.ListeCode;
  except
     result:=nil;
     TvaCodeIntraCom.ListeCode:=nil;
  end;//fin du try except
finally
  DMTVACode.TaTvaCodeRec.Filter:='';
  DMTVACode.TaTvaCodeRec.Filtered:=false;
  DMTVACode.TaTvaCodeRec.Close;
  TvaCodeIntraCom.ListeClasse:=nil;
  TvaCodeIntraCom.ListeCompteTVA:=nil;
end;
End;


Function FTvaRecupCodeTva_SurClasse(Classe:string;TauxTva:string):string;
var
requete:TQuery;
ConstCompteTva:string;
filtre,classeTemp:string;
Begin
try //finally
try
if DMTVACode = nil then DMTVACode:=TDMTVACode.Create(application.MainForm);
result:='';
requete:=TQuery.Create(DMTVACode);
ConstCompteTva:='%';
classeTemp:=Classe[1];
if(Classe='A')then ConstCompteTva:=DM_C_CompteTVAAutreBiensServices_A1+'%';
if(Classe='I')then ConstCompteTva:=DM_C_CompteTVAAchatImmo_I1+'%';
filtre:=CreeFiltreET(['Classe'],[classeTemp]);
FiltrageDataSet(DMTVACode.TaTvaCodeRec,filtre);
DMTVACode.TaTvaCodeRec.First;
if DMTVACode.TaTvaCodeRec.recordcount<>0 then
  begin
      if ((not empty(TauxTva))and(DM_C_ListeCTVAIntracommunautaire.IndexOf(classe[1])=-1))then
        Begin
//            if DMTVACode.TaTvaCodeRec.Locate('Taux_Inf',TauxTva,[]) then
//               result:=DMTVACode.TaTvaCodeRec.findfield('TvaCode').AsString
//            else
//              if DMTVACode.TaTvaCodeRec.Locate('Taux_Supp',TauxTva,[]) then  { isa  le  18/05/04 }
//                 result:=DMTVACode.TaTvaCodeRec.findfield('TvaCode').AsString;
              requete.SQL.clear;
              requete.DatabaseName:=DM_C_NomAliasDossier;
              requete.SQL.Add(' select * from tvacode where classe like '''+classeTemp+''' and (Taux_Inf = '+TauxTva+' or Taux_Supp='+TauxTva+')''');
              requete.SQL.Add(' order by tvacode');
              requete.Open;
              requete.First;
              if(requete.RecordCount<>0)then
              begin
                 result:=requete.findfield('TvaCode').AsString;
              end;

            if(result='')and((Classe='A')or(Classe='I'))then
            begin
              requete.SQL.clear;
              requete.DatabaseName:=DM_C_NomAliasDossier;
              requete.SQL.Add(' select * from tvacode where classe like '''+classeTemp+''' and compte like '''+ConstCompteTva+'''');
              requete.SQL.Add(' order by tvacode');
              requete.Open;
              requete.First;
              if(requete.RecordCount<>0)then
              begin
                 result:=requete.findfield('TvaCode').AsString;
              end;
            end;
        end
      else
        begin
             result:=DMTVACode.TaTvaCodeRec.findfield('TvaCode').AsString;
        end;
  end;
except
  result:='';
  abort;
end;
finally
  requete.close;
  requete:=nil;
end;
End;

procedure Initialise_RecupMiniMaxTva(Var RecupMiniMaxTva:TRecupMiniMaxTva);
begin
RecupMiniMaxTva.Taux_Inf:=0;
RecupMiniMaxTva.Taux_Supp:=0;
RecupMiniMaxTva.TvaCode:='';
RecupMiniMaxTva.Compte:='';
RecupMiniMaxTva.Libelle:='';
RecupMiniMaxTva.CodeRetour:=0;
end;


Function EditionDesJournauxDeTvaSansCalcul(TypeEdition : integer; DemandePeriode:Boolean; Journal:TStringList;DataSet:TDataSet;Synthese : boolean = false):Boolean;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
i,NbPieceMois,TotalNbPiece,NbPieceJournal:integer;
NbEcritureMois,TotalNbEcriture,NbEcritureJournal:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeEdition:TStringList;
TotalMoisDebit,TotalMoisCredit,TotalPeriodeDebit,TotalPeriodeCredit,
TotalTVAPeriodeDebit,TotalTVADebit,TotalTVAPeriodeCredit,TotalTVACredit:Currency;
TotalGPeriodeDebit,TotalGPeriodeCredit,TotalGTVAPeriodeDebit,TotalGTVAPeriodeCredit:currency;
Mois,annee,Reference,ReferenceTmp,DateTmp,Date,JournalTmp:string;
LibelleCorrect:string;
TitreCompte:string;
MTTVADebit,MTTVACredit:currency;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalMoisDebit:=0;
TotalMoisCredit:=0;
TotalTVADebit:=0;
TotalTVACredit:=0;
TotalPeriodeDebit:=0;
TotalPeriodeCredit:=0;
TotalTVAPeriodeDebit:=0;
TotalTVAPeriodeCredit:=0;

TotalGPeriodeDebit:=0;
TotalGPeriodeCredit:=0;
TotalGTVAPeriodeDebit:=0;
TotalGTVAPeriodeCredit:=0;

NbEcritureMois:=0;
TotalNbEcriture:=0;
NbEcritureJournal:=0;
NbPieceMois:=0;
NbPieceJournal:=0;
TotalNbPiece:=0;
Mois:='';
annee:='';
reference:='';
ReferenceTmp:='';
DateTmp:='';
Date:='';
JournalTmp:='';
  if DemandePeriode then
  begin
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;
    if DMTVACode=nil then DMTVACode:=TDMTVACode.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMTVACode.ListeFilterRecordJournaux.clear;
        if Journal<>nil then      // Tous les Journaux
         begin
          TitreCompte:='Du Code Tva :'+Journal.Strings[0]+' au code Tva :'+Journal.Strings[Journal.count-1];
          DMTVACode.ListeFilterRecordJournaux.Assign(Journal);
          DMTVACode.QuCode_Edition.OnFilterRecord:=DMTVACode.QuCode_EditionFilterRecord;
         end
        else
          begin
          DMTVACode.QuCode_Edition.OnFilterRecord:=nil;
          TitreCompte:='Tous les codes tva';
          end;

      DMTVACode.QuCode_Edition.CLose;
      DMTVACode.QuCode_Edition.ParamByName('DAteDeb').AsDate := E.DatExoDebut;
      DMTVACode.QuCode_Edition.ParamByName('DAteFin').AsDate := E.DatExoFin;
      DMTVACode.QuCode_Edition.filtered:=true;
      DMTVACode.QuCode_Edition.Open;

      if DMTVACode.QuCode_Edition.recordcount<>0 then
      begin
      ListeEdition.Add('tvaCode;date;référence;Tiers;Compte;Libelle;Débit;Crédit;TvaType;Tva debit;Tva credit');
      While not DMTVACode.QuCode_Edition.Eof do
       begin
          TotalPeriodeDebit:=0;
          TotalPeriodeCredit:=0;
          TotalTVAPeriodeDebit:=0;
          TotalTVAPeriodeCredit:=0;
          NbEcritureMois:=0;
          NbEcritureJournal:=0;
          NbPieceJournal:=0;
          NbPieceMois:=0;
          journalTmp:=DMTVACode.QuCode_Edition.findfield('tvaCode').AsString;

          ListeValeur.Add('9; Code TVA : '+journalTmp+' - '+FTvaRecupCompteTva( journalTmp) );
          DMTVACode.QuJournaux_Edition.Close;
          DMTVACode.QuJournaux_Edition.ParamByName('journal').AsString := journalTmp;
          DMTVACode.QuJournaux_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMTVACode.QuJournaux_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMTVACode.QuJournaux_Edition.Open;
          DMTVACode.QuJournaux_Edition.First;
          while not DMTVACode.QuJournaux_Edition.Eof do
            begin
              //remplir totaux mois en cours avant changement de mois et d'annee

              //ensuite passer à un autre mois
              NbPieceMois:=0;
              NbEcritureMois:=0;
              Mois:=dateinfos(DMTVACode.QuJournaux_Edition.FindField('datePiece').AsDateTime).MoisStr;
              annee:=dateinfos(DMTVACode.QuJournaux_Edition.FindField('datePiece').AsDateTime).AnStr;
              TotalMoisDebit:=0;
              TotalMoisCredit:=0;
              TotalTVADebit:=0;
              TotalTVACredit:=0;
              MTTVADebit:=0;
              MTTVACredit:=0;
               while ((dateinfos(DMTVACode.QuJournaux_Edition.FindField('datePiece').AsDateTime).AnStr=annee)
                 and(not DMTVACode.QuJournaux_Edition.Eof)
                 and(mois=dateinfos(DMTVACode.QuJournaux_Edition.FindField('datePiece').AsDateTime).MoisStr)) do
                  begin
                  if(DMTVACode.QuJournaux_Edition.FindField('Journal').AsString='3')then
                  begin
                      if(DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency<>0)then
                         MTTVADebit:=DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency
                      else
                         MTTVACredit:=DMTVACode.QuJournaux_Edition.FindField('CreditSaisie').AsCurrency;
                      TotalMoisDebit:=0;
                      TotalMoisCredit:=0;
                  end
                  else
                  begin
                      if(DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency<>0)then
                         MTTVADebit:=DMTVACode.QuJournaux_Edition.FindField('Montant_tva').AsCurrency
                      else
                         MTTVACredit:=DMTVACode.QuJournaux_Edition.FindField('Montant_tva').AsCurrency;
                      TotalMoisDebit:=TotalMoisDebit+DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency;
                      TotalMoisCredit:=TotalMoisCredit+DMTVACode.QuJournaux_Edition.FindField('CreditSaisie').AsCurrency;
                  end;
                  TotalTVADebit:=TotalTVADebit+MTTVADebit;
                  TotalTVACredit:=TotalTVACredit+MTTVACredit;
                  if ReferenceTmp<>DMTVACode.QuJournaux_Edition.FindField('reference').AsString then
                    begin
                      inc(NbPieceMois);
                      reference:=DMTVACode.QuJournaux_Edition.FindField('reference').AsString;
                      ReferenceTmp:=reference;
                    end;
                    LibelleCorrect:=str_remplacesouschaine(DMTVACode.QuJournaux_Edition.FindField('Libelle').AsString,';',',');
                    inc(NbEcritureMois);
                  if not Synthese then
                  begin
                   if(DMTVACode.QuJournaux_Edition.FindField('Journal').AsString='3')then
                   begin
                      ListeEdition.Add(journalTmp+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('datePiece').AsString+
                                   ';'+
                                   reference+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('tiers').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('Compte').AsString+
//                                   ';'+
//                                   GereLibelle(DMTVACode.QuJournaux_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   '0'+
                                   ';'+
                                   '0'+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('TvaType').AsString +
                                   ';'+
                                   CurrToStr_Lgr(MTTVADebit)+
                                    ';'+
                                    CurrToStr_Lgr(MTTVACredit)
                                   );
                      ListeValeur.Add('0'+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('datePiece').AsString+
                                   ';'+
                                   reference+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('tiers').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('Compte').AsString+
//                                   ';'+
//                                   GereLibelle(DMTVACode.QuJournaux_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   E.FormatCurrSansDevise(0)+
                                   ';'+
                                   E.FormatCurrSansDevise(0)+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('TvaType').AsString +
                                   ';'+
                                   CurrToStr_Lgr(MTTVADebit)+
                                    ';'+
                                   CurrToStr_Lgr(MTTVACredit)
                                   );
                   end
                   else
                   begin
                      ListeEdition.Add(journalTmp+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('datePiece').AsString+
                                   ';'+
                                   reference+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('tiers').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('Compte').AsString+
//                                   ';'+
//                                   GereLibelle(DMTVACode.QuJournaux_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('CreditSaisie').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('TvaType').AsString +
                                   ';'+
                                   CurrToStr_Lgr(MTTVADebit)+
                                    ';'+
                                    CurrToStr_Lgr(MTTVACredit)
                                   );
                      ListeValeur.Add('0'+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('datePiece').AsString+
                                   ';'+
                                   reference+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('tiers').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('Compte').AsString+
//                                   ';'+
//                                   GereLibelle(DMTVACode.QuJournaux_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   E.FormatCurrSansDevise(DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency)+
                                   ';'+
                                   E.FormatCurrSansDevise(DMTVACode.QuJournaux_Edition.FindField('CreditSaisie').AsCurrency)+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('TvaType').AsString +
                                   ';'+
                                   CurrToStr_Lgr(MTTVADebit)+
                                    ';'+
                                   CurrToStr_Lgr(MTTVACredit)
                                   );

                   end;

                   end;
                   MTTVADebit:=0;
                   MTTVACredit:=0;
                   DMTVACode.QuJournaux_Edition.Next;
                   //reference:='';
               end;//fin du while
                   TotalPeriodeDebit:=TotalPeriodeDebit+TotalMoisDebit;
                   TotalPeriodeCredit:=TotalPeriodeCredit+TotalMoisCredit;
                   TotalTVAPeriodeDebit:=TotalTVAPeriodeDebit+TotalTVADebit;
                   TotalTVAPeriodeCredit:=TotalTVAPeriodeCredit+TotalTVACredit;
                   NbEcritureJournal:=NbEcritureJournal+NbEcritureMois;
                   NbPieceJournal:=NbPieceJournal+NbPieceMois;
                   ListeValeur.Add('4;;;;; @TOTAL DU MOIS DE - '+Mois+'/'+annee+' - '+IntToStr_Lgr(NbPieceMois)+
                   ' pièces - '+IntToStr_Lgr(NbEcritureMois)+' Ecritures : ;'+E.FormatCurrSansDevise(TotalMoisDebit) +';'+
                   E.FormatCurrSansDevise(TotalMoisCredit)+';;'+E.FormatCurrSansDevise(TotalTVADebit)+';'+E.FormatCurrSansDevise(TotalTVACredit));
                   DetermineSolde(TotalMoisDebit,TotalMoisCredit);
                   DetermineSolde(TotalTVADebit,TotalTVACredit);
                   ListeValeur.Add('4;;;;; @SOLDE DU MOIS DE - '+Mois+'/'+annee+ ';'+E.FormatCurrSansDevise(TotalMoisDebit) +';'+
                   E.FormatCurrSansDevise(TotalMoisCredit)+';;'+E.FormatCurrSansDevise(TotalTVADebit)+';'+E.FormatCurrSansDevise(TotalTVACredit));
            end;//fin du while not QuJournaux_Edition.eof
          ListeValeur.Add('1;;;;; @TOTAL DU CODE TVA '+journalTmp+' - '+IntToStr_Lgr(NbPieceJournal)+' pièces - '+
          IntToStr_Lgr(NbEcritureJournal)+' Ecritures : ;'+E.FormatCurrSansDevise(TotalPeriodeDebit) +';'+E.FormatCurrSansDevise(TotalPeriodeCredit)+
          ';;'+E.FormatCurrSansDevise(TotalTVAPeriodeDebit)+';'+E.FormatCurrSansDevise(TotalTVAPeriodeCredit));

          DetermineSolde(TotalPeriodeDebit,TotalPeriodeCredit);
          DetermineSolde(TotalTVAPeriodeDebit,TotalTVAPeriodeCredit);
          ListeValeur.Add('1;;;;; @SOLDE DU CODE TVA '+journalTmp+ ';'+E.FormatCurrSansDevise(TotalPeriodeDebit) +';'+E.FormatCurrSansDevise(TotalPeriodeCredit)+
          ';;'+E.FormatCurrSansDevise(TotalTVAPeriodeDebit)+';'+E.FormatCurrSansDevise(TotalTVAPeriodeCredit));
          TotalGPeriodeDebit:=TotalGPeriodeDebit+TotalPeriodeDebit;
          TotalGPeriodeCredit:=TotalGPeriodeCredit+TotalPeriodeCredit;
          TotalGTVAPeriodeDebit:=TotalGTVAPeriodeDebit+TotalTVAPeriodeDebit;
          TotalGTVAPeriodeCredit:=TotalGTVAPeriodeCredit+TotalTVAPeriodeCredit;

          DMTVACode.QuCode_Edition.Next;
          TotalNbPiece:=TotalNbPiece+NbPieceJournal;
          TotalNbEcriture:=TotalNbEcriture+NbEcritureJournal;
       end;//fin du while not QuCode_Edition.eof
//                  tvaCode;date;référence;Compte;Libelle;Débit;Crédit;TvaType;TvaDate;Montant_tva
          ListeValeur.Add('1;;;;; @TOTAL DE TOUS LES CODES TVA - '+IntToStr_Lgr(TotalNbPiece)+' pièces - '+IntToStr_Lgr(TotalNbEcriture)
          +' Ecritures : ;'+E.FormatCurrSansDevise(TotalGPeriodeDebit) +';'+
          E.FormatCurrSansDevise(TotalGPeriodeCredit)+';;'+E.FormatCurrSansDevise(TotalGTVAPeriodeDebit)+';'+
          E.FormatCurrSansDevise(TotalGTVAPeriodeCredit));

          DetermineSolde(TotalGPeriodeDebit,TotalGPeriodeCredit);
          DetermineSolde(TotalGTVAPeriodeDebit,TotalGTVAPeriodeCredit);
          ListeValeur.Add('1;;;;; @SOLDE DE TOUS LES CODES TVA ;'+E.FormatCurrSansDevise(TotalGPeriodeDebit) +';'+
          E.FormatCurrSansDevise(TotalGPeriodeCredit)+';;'+E.FormatCurrSansDevise(TotalGTVAPeriodeDebit)+';'+
          E.FormatCurrSansDevise(TotalGTVAPeriodeCredit));

         ObjPrn.FTitreEdition := 'EDITION DES ECRITURES AVEC TVA - '+TitreCompte;
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
         ListeValeur.Insert(0,' Date pièce ;Réf. Pièce ; Tiers ; Compte ; Désignation ; HT Débit ; HT Crédit ; T ; Tva débit ; Tva crédit ');
         ListeValeur.Insert(1,'0.7;0.7;0.7;0.6;1.8;0.8;0.8;0.2;0.7;0.7');
         ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr;texte;curr;curr');
      end;
     case TypeEdition of
       C_Exportation: ExportDonnees(ListeEdition,E.RepertoireExportDossier,'CodesTvaEcritures_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;//fin du case TypeEdition
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
//   ObjPrn.destroy;
end;
end;


Function EditionDesJournauxDeTvaSansCalcul(TypeEdition : integer; DemandePeriode:Boolean; Journal:String;DataSet:TDataSet;Synthese : boolean):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (journal)then
     Maliste.Add(journal)
   else
     raise ExceptLGR.Create('Aucun journal n''est defini !',1000,true,mtError,Retour);
   EditionDesJournauxDeTvaSansCalcul(TypeEdition,DemandePeriode,Maliste,DataSet,Synthese);
  except
     abort;
  end;
end;



Function EditionDesJournauxSansTvaSansCalcul(TypeEdition : integer; DemandePeriode:Boolean; Journal:TStringList;DataSet:TDataSet;Synthese : boolean = false):Boolean;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
i,NbPieceMois,TotalNbPiece,NbPieceJournal:integer;
NbEcritureMois,TotalNbEcriture,NbEcritureJournal:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeEdition:TStringList;
TotalMoisDebit,TotalMoisCredit,TotalPeriodeDebit,TotalPeriodeCredit,
TotalTVAPeriodeDebit,TotalTVADebit,TotalTVAPeriodeCredit,TotalTVACredit:Currency;
TotalGPeriodeDebit,TotalGPeriodeCredit,TotalGTVAPeriodeDebit,TotalGTVAPeriodeCredit:currency;
Mois,annee,Reference,ReferenceTmp,DateTmp,Date,JournalTmp:string;
LibelleCorrect:string;
TitreCompte:string;
MTTVADebit,MTTVACredit:currency;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalMoisDebit:=0;
TotalMoisCredit:=0;
TotalTVADebit:=0;
TotalTVACredit:=0;
TotalPeriodeDebit:=0;
TotalPeriodeCredit:=0;
TotalTVAPeriodeDebit:=0;
TotalTVAPeriodeCredit:=0;

TotalGPeriodeDebit:=0;
TotalGPeriodeCredit:=0;
TotalGTVAPeriodeDebit:=0;
TotalGTVAPeriodeCredit:=0;

NbEcritureMois:=0;
TotalNbEcriture:=0;
NbEcritureJournal:=0;
NbPieceMois:=0;
NbPieceJournal:=0;
TotalNbPiece:=0;
Mois:='';
annee:='';
reference:='';
ReferenceTmp:='';
DateTmp:='';
Date:='';
JournalTmp:='';
  if DemandePeriode then
  begin
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;
    if DMTVACode=nil then DMTVACode:=TDMTVACode.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMTVACode.ListeFilterRecordJournaux.clear;
        if Journal<>nil then      // Tous les Journaux
         begin
          TitreCompte:='Du Code Tva :'+Journal.Strings[0]+' au code Tva :'+Journal.Strings[Journal.count-1];
          DMTVACode.ListeFilterRecordJournaux.Assign(Journal);
          DMTVACode.QuCode_Edition.OnFilterRecord:=DMTVACode.QuCode_EditionFilterRecord;
         end
        else
          begin
          DMTVACode.QuCode_Edition.OnFilterRecord:=nil;
          TitreCompte:='Tous les codes tva';
          end;

      DMTVACode.QuCode_Edition.CLose;
      DMTVACode.QuCode_Edition.ParamByName('DAteDeb').AsDate := E.DatExoDebut;
      DMTVACode.QuCode_Edition.ParamByName('DAteFin').AsDate := E.DatExoFin;
      DMTVACode.QuCode_Edition.filtered:=true;
      DMTVACode.QuCode_Edition.Open;

      if DMTVACode.QuCode_Edition.recordcount<>0 then
      begin
      ListeEdition.Add('tvaCode;date;référence;Tiers;Compte;Libelle;Débit;Crédit;TvaType;Tva debit;Tva credit');
      While not DMTVACode.QuCode_Edition.Eof do
       begin
          TotalPeriodeDebit:=0;
          TotalPeriodeCredit:=0;
          TotalTVAPeriodeDebit:=0;
          TotalTVAPeriodeCredit:=0;
          NbEcritureMois:=0;
          NbEcritureJournal:=0;
          NbPieceJournal:=0;
          NbPieceMois:=0;
          journalTmp:=DMTVACode.QuCode_Edition.findfield('tvaCode').AsString;

          ListeValeur.Add('9; Code TVA : '+journalTmp+' - '+FTvaRecupCompteTva( journalTmp) );
          DMTVACode.QuJournaux_Edition.Close;
          DMTVACode.QuJournaux_Edition.ParamByName('journal').AsString := journalTmp;
          DMTVACode.QuJournaux_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMTVACode.QuJournaux_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMTVACode.QuJournaux_Edition.Open;
          DMTVACode.QuJournaux_Edition.First;
          while not DMTVACode.QuJournaux_Edition.Eof do
            begin
              //remplir totaux mois en cours avant changement de mois et d'annee

              //ensuite passer à un autre mois
              NbPieceMois:=0;
              NbEcritureMois:=0;
              Mois:=dateinfos(DMTVACode.QuJournaux_Edition.FindField('datePiece').AsDateTime).MoisStr;
              annee:=dateinfos(DMTVACode.QuJournaux_Edition.FindField('datePiece').AsDateTime).AnStr;
              TotalMoisDebit:=0;
              TotalMoisCredit:=0;
              TotalTVADebit:=0;
              TotalTVACredit:=0;
              MTTVADebit:=0;
              MTTVACredit:=0;
               while ((dateinfos(DMTVACode.QuJournaux_Edition.FindField('datePiece').AsDateTime).AnStr=annee)
                 and(not DMTVACode.QuJournaux_Edition.Eof)
                 and(mois=dateinfos(DMTVACode.QuJournaux_Edition.FindField('datePiece').AsDateTime).MoisStr)) do
                  begin
                  if(DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency<>0)then
                     MTTVADebit:=DMTVACode.QuJournaux_Edition.FindField('Montant_tva').AsCurrency
                  else
                     MTTVACredit:=DMTVACode.QuJournaux_Edition.FindField('Montant_tva').AsCurrency;
                  TotalMoisDebit:=TotalMoisDebit+DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency;
                  TotalMoisCredit:=TotalMoisCredit+DMTVACode.QuJournaux_Edition.FindField('CreditSaisie').AsCurrency;
                  TotalTVADebit:=TotalTVADebit+MTTVADebit;
                  TotalTVACredit:=TotalTVACredit+MTTVACredit;
                  if ReferenceTmp<>DMTVACode.QuJournaux_Edition.FindField('reference').AsString then
                    begin
                      inc(NbPieceMois);
                      reference:=DMTVACode.QuJournaux_Edition.FindField('reference').AsString;
                      ReferenceTmp:=reference;
                    end;
                    LibelleCorrect:=str_remplacesouschaine(DMTVACode.QuJournaux_Edition.FindField('Libelle').AsString,';',',');
                    inc(NbEcritureMois);
                  if not Synthese then
                  begin
                  ListeEdition.Add(journalTmp+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('datePiece').AsString+
                                   ';'+
                                   reference+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('tiers').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('Compte').AsString+
//                                   ';'+
//                                   GereLibelle(DMTVACode.QuJournaux_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('CreditSaisie').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('TvaType').AsString +
                                   ';'+
                                   CurrToStr_Lgr(MTTVADebit)+
                                    ';'+
                                    CurrToStr_Lgr(MTTVACredit)
                                   );
                  ListeValeur.Add('0'+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('datePiece').AsString+
                                   ';'+
                                   reference+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('tiers').AsString+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('Compte').AsString+
//                                   ';'+
//                                   GereLibelle(DMTVACode.QuJournaux_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   E.FormatCurrSansDevise(DMTVACode.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency)+
                                   ';'+
                                   E.FormatCurrSansDevise(DMTVACode.QuJournaux_Edition.FindField('CreditSaisie').AsCurrency)+
                                   ';'+
                                   DMTVACode.QuJournaux_Edition.FindField('TvaType').AsString +
                                   ';'+
                                   CurrToStr_Lgr(MTTVADebit)+
                                    ';'+
                                   CurrToStr_Lgr(MTTVACredit)
                                   );
                   end;
                   MTTVADebit:=0;
                   MTTVACredit:=0;
                   DMTVACode.QuJournaux_Edition.Next;
                   //reference:='';
               end;//fin du while
                   TotalPeriodeDebit:=TotalPeriodeDebit+TotalMoisDebit;
                   TotalPeriodeCredit:=TotalPeriodeCredit+TotalMoisCredit;
                   TotalTVAPeriodeDebit:=TotalTVAPeriodeDebit+TotalTVADebit;
                   TotalTVAPeriodeCredit:=TotalTVAPeriodeCredit+TotalTVACredit;
                   NbEcritureJournal:=NbEcritureJournal+NbEcritureMois;
                   NbPieceJournal:=NbPieceJournal+NbPieceMois;
                   ListeValeur.Add('4;;;;; @TOTAL DU MOIS DE - '+Mois+'/'+annee+' - '+IntToStr_Lgr(NbPieceMois)+
                   ' pièces - '+IntToStr_Lgr(NbEcritureMois)+' Ecritures : ;'+E.FormatCurrSansDevise(TotalMoisDebit) +';'+
                   E.FormatCurrSansDevise(TotalMoisCredit)+';;'+E.FormatCurrSansDevise(TotalTVADebit)+';'+E.FormatCurrSansDevise(TotalTVACredit));
                   DetermineSolde(TotalMoisDebit,TotalMoisCredit);
                   DetermineSolde(TotalTVADebit,TotalTVACredit);
                   ListeValeur.Add('4;;;;; @SOLDE DU MOIS DE - '+Mois+'/'+annee+ ';'+E.FormatCurrSansDevise(TotalMoisDebit) +';'+
                   E.FormatCurrSansDevise(TotalMoisCredit)+';;'+E.FormatCurrSansDevise(TotalTVADebit)+';'+E.FormatCurrSansDevise(TotalTVACredit));
            end;//fin du while not QuJournaux_Edition.eof
          ListeValeur.Add('1;;;;; @TOTAL DU CODE TVA '+journalTmp+' - '+IntToStr_Lgr(NbPieceJournal)+' pièces - '+
          IntToStr_Lgr(NbEcritureJournal)+' Ecritures : ;'+E.FormatCurrSansDevise(TotalPeriodeDebit) +';'+E.FormatCurrSansDevise(TotalPeriodeCredit)+
          ';;'+E.FormatCurrSansDevise(TotalTVAPeriodeDebit)+';'+E.FormatCurrSansDevise(TotalTVAPeriodeCredit));

          DetermineSolde(TotalPeriodeDebit,TotalPeriodeCredit);
          DetermineSolde(TotalTVAPeriodeDebit,TotalTVAPeriodeCredit);
          ListeValeur.Add('1;;;;; @SOLDE DU CODE TVA '+journalTmp+ ';'+E.FormatCurrSansDevise(TotalPeriodeDebit) +';'+E.FormatCurrSansDevise(TotalPeriodeCredit)+
          ';;'+E.FormatCurrSansDevise(TotalTVAPeriodeDebit)+';'+E.FormatCurrSansDevise(TotalTVAPeriodeCredit));
          TotalGPeriodeDebit:=TotalGPeriodeDebit+TotalPeriodeDebit;
          TotalGPeriodeCredit:=TotalGPeriodeCredit+TotalPeriodeCredit;
          TotalGTVAPeriodeDebit:=TotalGTVAPeriodeDebit+TotalTVAPeriodeDebit;
          TotalGTVAPeriodeCredit:=TotalGTVAPeriodeCredit+TotalTVAPeriodeCredit;

          DMTVACode.QuCode_Edition.Next;
          TotalNbPiece:=TotalNbPiece+NbPieceJournal;
          TotalNbEcriture:=TotalNbEcriture+NbEcritureJournal;
       end;//fin du while not QuCode_Edition.eof
//                  tvaCode;date;référence;Compte;Libelle;Débit;Crédit;TvaType;TvaDate;Montant_tva
          ListeValeur.Add('1;;;;; @TOTAL DE TOUS LES CODES TVA - '+IntToStr_Lgr(TotalNbPiece)+' pièces - '+IntToStr_Lgr(TotalNbEcriture)
          +' Ecritures : ;'+E.FormatCurrSansDevise(TotalGPeriodeDebit) +';'+
          E.FormatCurrSansDevise(TotalGPeriodeCredit)+';;'+E.FormatCurrSansDevise(TotalGTVAPeriodeDebit)+';'+
          E.FormatCurrSansDevise(TotalGTVAPeriodeCredit));

          DetermineSolde(TotalGPeriodeDebit,TotalGPeriodeCredit);
          DetermineSolde(TotalGTVAPeriodeDebit,TotalGTVAPeriodeCredit);
          ListeValeur.Add('1;;;;; @SOLDE DE TOUS LES CODES TVA ;'+E.FormatCurrSansDevise(TotalGPeriodeDebit) +';'+
          E.FormatCurrSansDevise(TotalGPeriodeCredit)+';;'+E.FormatCurrSansDevise(TotalGTVAPeriodeDebit)+';'+
          E.FormatCurrSansDevise(TotalGTVAPeriodeCredit));

         ObjPrn.FTitreEdition := 'EDITION DES ECRITURES AVEC TVA - '+TitreCompte;
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
         ListeValeur.Insert(0,' Date pièce ;Réf. Pièce ; Tiers ; Compte ; Désignation ; HT Débit ; HT Crédit ; T ; Tva débit ; Tva crédit ');
         ListeValeur.Insert(1,'0.7;0.7;0.7;0.6;1.8;0.8;0.8;0.2;0.7;0.7');
         ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr;texte;curr;curr');
      end;
     case TypeEdition of
       C_Exportation: ExportDonnees(ListeEdition,E.RepertoireExportDossier,'CodesTvaEcritures_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;//fin du case TypeEdition
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
//   ObjPrn.destroy;
end;
end;


Function EditionDesJournauxSansTvaSansCalcul(TypeEdition : integer; DemandePeriode:Boolean; Journal:String;DataSet:TDataSet;Synthese : boolean):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (journal)then
     Maliste.Add(journal)
   else
     raise ExceptLGR.Create('Aucun journal n''est defini !',1000,true,mtError,Retour);
   EditionDesJournauxSansTvaSansCalcul(TypeEdition,DemandePeriode,Maliste,DataSet,Synthese);
  except
     abort;
  end;
end;



procedure TDMTVACode.QuCode_EditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListeFilterRecordJournaux.IndexOf(DataSet.FindField('tvaCode').AsString) <> -1;
  end;
end;

end.
