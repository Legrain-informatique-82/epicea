unit GestPlan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,dbtables;

type
  TGestPlan = class(TComponent)
  private
    { Déclarations privées }
  protected
    { Déclarations protégées }
    FPlanBase:TTable;
    FPlanBaseAux:TTable;
    FIndexChComptePlanBase:integer;
    FIndexChLibPlanBase:integer;

    FParamPlan:TTable;
    FParamPlanAux:TTable;
    FIndexChCompteParamPlan:integer;
//    FIndexChLibParamPlan:integer;

    FPlanSource:TTable;
    FPlanSourceAux:TTable;
    FListeListeChampS:TStringList;
    FTableListeChampS:TTable;
    FIndexChComptePlanSource:integer;
    FIndexChLibPlanSource:integer;

    FPlanContexte:TTable;
    FPlanContexteAux:TTable;
    FListeListeChampD:TStringList;
    FTableListeChampD:TTable;
    FIndexChCompteContexte:integer;
    FIndexChLibContexte:integer;

    FTableParamContext:TTable;
    FListePAramContex:TStringList;

    FGenereCompteParent:Boolean;
    FListeCompteParent:TStringList;
    FTableCompteParent:TTable;

    FGenereCompteAssocies:Boolean;
    FListeCompteAssocies:TStringList;
    FTableCompteAssocies:TTable;


    FPlanAux:Boolean;
    FCompteCollectif:boolean;
    FCompteGenere0000:boolean;

    FCompte:string;

    FPossedePere:boolean;
    FPereCompte:string;
//    FPossedeFils:Boolean;
    FFilsCompte:string;
    FlibelleComteDefaut:string;
    FLibelleComptePUtil:string;

//    FWindowContexte:TCustomControl;
//    FWindowCptParent:TCustomForm;
    procedure OuvreTable;

  public
    { Déclarations publiques }
    Constructor Create(AOwner :TComponent); override;
    Destructor Destroy;override;
//    procedure loaded;virtual;
    Function CompteExiste(Compte:string;NumPlan:integer):boolean;
    Function possedeFils(compte:string;NumPlan:integer):boolean;
    Function possedePere(compte:string;NumPlan:integer):boolean;
    Function PereCompte(compte:string;NumPlan:integer):String;
    Function LibelleDefaut(Compte:string):String;
    Function LibelleUtilisateur(Compte:string):String;
    Function ListeCompteAssocie(Compte:string):TStringList;
    Function ListeCompteParent(Compte:string;NumPlan:integer):TStringList;
    Function NumCompteValide(Compte: String) : String;
    Function CompteGenere(Compte:string):boolean;
    function CompteGenerateur(Compte:string):boolean;
  published
    { Déclarations publiées }
    Property PlanBase:TTable Read FPlanBase write FPlanBase;
    Property IndexChComptePlanBase:integer Read FIndexChComptePlanBase write FIndexChComptePlanBase;
    Property IndexChLibPlanBase:integer Read FIndexChLibPlanBase write FIndexChLibPlanBase;
    Property ParamPlan:TTable Read FParamPlan write FParamPlan;
    Property IndexChCompteParamPlan:integer Read FIndexChCompteParamPlan write FIndexChCompteParamPlan;
//    Property IndexChLibParamPlan:integer Read FIndexChLibParamPlan write FIndexChLibParamPlan;
    Property PlanSource:TTable Read FPlanSource write FPlanSource;
    Property IndexChComptePlanSource:integer Read FIndexChComptePlanSource write FIndexChComptePlanSource;
    Property IndexChLibPlanSource:integer Read FIndexChLibPlanSource write FIndexChLibPlanSource;
    Property PlanContexte:TTable Read FPlanContexte write FPlanContexte;
    Property IndexChCompteContexte:integer Read FIndexChCompteContexte write FIndexChCompteContexte;
    Property IndexChLibContexte:integer Read FIndexChLibContexte write FIndexChLibContexte;
    Property GenereCompteParent:Boolean read FGenereCompteParent write FGenereCompteParent;
    Property GenereCompteAssocies:Boolean read FGenereCompteAssocies write FGenereCompteAssocies;
//    Property WindowContexte:TCustomControl read FWindowContexte write FWindowContexte;
//    Property WindowCptParent: TCustomForm read FWindowCptParent write FWindowCptParent;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('essai', [TGestPlan]);
end;

Constructor TGestPlan.Create(AOwner :TComponent);
begin
inherited create(AOwner);
FPlanBaseAux:=TTable.Create(self);
FPlanSourceAux:=TTable.Create(self);
FPlanContexteAux:=TTable.Create(self);

FParamPlanAux:=TTable.create(self);
end;


//procedure TGestPlan.loaded;
//Begin
//inherited;
//End;

Destructor TGestPlan.Destroy;
begin
inherited destroy;
end;

procedure TGestPlan.OuvreTable;
begin
if FPlanBase <> nil then
               begin
               FPlanBaseAux.Close;
               FPlanBaseAux.DatabaseName:=FPlanBase.DatabaseName;
               FPlanBaseAux.TableName:=FPlanBase.TableName;
               FPlanBaseAux.Open;
               end;
if FPlanSource <> nil then
               begin
               FPlanSourceAux.Close;
               FPlanSourceAux.DatabaseName:=FPlanSource.DatabaseName;
               FPlanSourceAux.TableName:=FPlanSource.TableName;
               FPlanSourceAux.Open;
               end;
if FPlanContexte <> nil then
               begin
               FPlanContexteAux.Close;
               FPlanContexteAux.DatabaseName:=FPlanContexte.DatabaseName;
               FPlanContexteAux.TableName:=FPlanContexte.TableName;
               FPlanContexteAux.Open;
               end;
end;
//****************************************************************************//
//******************Verifie l'existence d'un comte dans n(importe quel plan **//
//******* 1 : Plan de base ; 2 : Plan Util ; 3 : Plan Contexte ***************//
//****************************************************************************//
Function TGestPlan.CompteExiste(Compte:string;NumPlan:integer):boolean;
var
ChCompte:string;
Begin
OuvreTable;
 result:=false;
 case NumPlan of
    1:if FPlanBase <> nil then
                Begin
                   ChCompte:=FPlanBaseAux.Fields[FIndexChComptePlanBase].FieldName;
                   result:=FPlanBaseAux.Locate(ChCompte,Compte,[]);
                End;
    2: if FPlanSource <> nil then
                Begin
                  ChCompte:=FPlanSourceAux.Fields[FIndexChComptePlanSource].FieldName;
                  result:=FPlanSourceAux.Locate(ChCompte,Compte,[]);
                End;
    3:if FPlanContexte <> nil then
                Begin
                  ChCompte:=FPlanContexteAux.Fields[FIndexChCompteContexte].FieldName;
                  result:=FPlanContexteAux.Locate(ChCompte,Compte,[]);
                End;
 end;
End;

//****************************************************************************//
//************Vrai si compte possede un fils**********************************//
//****************************************************************************//

Function TGestPlan.possedeFils(compte:string;NumPlan:integer):boolean;
var
i:integer;
Begin
result:=false;
i:=0;
repeat
 Compte:=copy(Compte,1,length(Compte)-1)+inttostr(i);
 result:=CompteExiste(Compte,NumPlan);
 inc(i);
until ((i<10) and (result=true));
End;

//****************************************************************************//
//************Vrai si compte possede un pere**********************************//
//****************************************************************************//

Function TGestPlan.possedePere(compte:string;NumPlan:integer):boolean;
Begin
result:=false;
delete(Compte,(length(Compte)-1),1);
result:=CompteExiste(Compte,NumPlan);
End;

//****************************************************************************//
//************Retourne le pere de compte *************************************//
//****************************************************************************//

Function TGestPlan.PereCompte(compte:string;NumPlan:integer):String;
//var
//i:integer;
Begin
result:='';
if length(trim(compte)) > 0 then
  Begin
   delete(Compte,(length(Compte)-1),1);
   result:=Compte;
  end;
end;


//****************************************************************************//
//************Retourne le libelle par defaut de compte (plan de base)*********//
//****************************************************************************//

Function TGestPlan.LibelleDefaut(Compte:string):String;
Begin
OuvreTable;
result:='';
if FPlanBase <> nil then
   if FPlanBaseAux.Locate(FPlanBaseAux.Fields[FIndexChComptePlanBase].FieldName,Compte,[]) then
      result:=FPlanBaseAux.findfield(FPlanBaseAux.Fields[FIndexChLibPlanBase].FieldName).asstring;
End;

//****************************************************************************//
//************Retourne le libelle de compte dans le plan utilisateur**********//
//****************************************************************************//

Function TGestPlan.LibelleUtilisateur(Compte:string):String;
Begin
OuvreTable;
result:='';
if FPlanSource <> nil then
   if FPlanSourceAux.Locate(FPlanBaseAux.Fields[FIndexChComptePlanBase].FieldName,Compte,[]) then
        result:=FPlanSourceAux.findfield(FPlanBaseAux.Fields[FIndexChLibPlanBase].FieldName).asstring;
End;

Function TGestPlan.ListeCompteAssocie(Compte:string):TStringList;
Begin
//
End;

Function TGestPlan.ListeCompteParent(Compte:string;NumPlan:integer):TStringList;
Begin
if FGenereCompteParent=true then
   begin
    try
      result:=TStringList.Create;
      while not possedePere(Compte,NumPlan) do begin
                result.Add(PereCompte(Compte,NumPlan));
                Compte:=PereCompte(Compte,NumPlan);
                end;
                result.Add(PereCompte(Compte,NumPlan));
    except
      result.Free;
    end;
end;

End;

//****************************************************************************//
//                  Retourne un numéro de compte valide                       //
//****************************************************************************//
Function TGestPlan.NumCompteValide(Compte: String) : String;
Var i :Integer;
Begin
Result:= '';
   if trim(Compte)<>'' then
   For i:= 1 to Length(Compte) do begin
      case i of
         1:begin
            case ord(Compte[i]) of
           {0}48:begin
                 messagebox(0,Pchar('Vous avez saisi : '+Compte+' .'+#10#13#10#13+'Les numéros du plan comptable ne peuvent pas commencer par 0.'),'Erreur de saisie',0);
                 abort;
                end ;
      {8,9}56,57:begin
                 messagebox(0,Pchar('Vous avez saisi : '+Compte+' .'+#10#13#10#13+'Ces numéros du plan comptable ne sont pas encore prévu.'),'Erreur de saisie',0);
                 abort;
                end  ;
            else if (Compte[i] in ['0'..'9']) then Result:= Result + Compte[i];
            end;
           end;
      else
   	  if (Compte[i] in ['0'..'9']) then Result:= Result + Compte[i];
      end;
   end;
End;

//****************************************************************************//
// Crée les comptes à générer en fonction de Cpt                              //
//****************************************************************************//
function TGestPlan.CompteGenerateur(Compte:string):boolean;
var
CptRech:string;
i:integer;
begin
//   CptRech:=Compte;
//   TaParamCpt.Filter:=('Famille=''100'' and Rac1='''+ CptRech +''' and Regime='''+ E.Regime +'''');
//   TaParamCpt.Filtered:=true;
//   if not TaParamCpt.active then TaParamCpt.Open;
//   while ((TaParamCpt.recordcount = 0) and (length(CptRech)>0)) do
//         begin
//            delete(CptRech,length(CptRech),1);
//            TaParamCpt.Filter:=('Famille=''100'' and Rac1='''+ CptRech +''' and Regime='''+ E.Regime +'''');
//            TaParamCpt.Filtered:=true;
//         end;
//   result:=(TaParamCpt.locate('Rac1',CptRech,[]) and (length(CptRech)=length(TaParamCpt.FindField('Rac1').AsString)));
//   if copy(Compte,1,3)='139' then result:=false;
end;
//****************************************************************************//
Function TGestPlan.CompteGenere(Compte:string):boolean;
var
CptRech:string;
i:integer;
begin
//   CptRech:=cpt;
//   TaParamCpt.Filter:=('Famille=''100'' and Rac2='''+ CptRech +''' and Regime='''+ E.Regime +'''');
//   TaParamCpt.Filtered:=true;
//   if not TaParamCpt.active then TaParamCpt.Open;
//   while ((TaParamCpt.recordcount = 0) and (length(CptRech)>0)) do
//         begin
//            delete(CptRech,length(CptRech),1);
//            TaParamCpt.Filter:=('Famille=''100'' and Rac2='''+ CptRech +''' and Regime='''+ E.Regime +'''');
//            TaParamCpt.Filtered:=true;
//         end;
//   TaParamCpt.Filter:=('Famille=''100'' and Rac1='''+ TaParamCpt.findField('Rac1').AsString +''' and Regime='''+ E.Regime +'''');
//   result:=(TaParamCpt.locate('Rac2',CptRech,[]) and (length(CptRech)=length(TaParamCpt.FindField('Rac2').AsString)));
//   if copy(Compte,1,3)='13' then result:=false;
end;
//****************************************************************************//
end.
