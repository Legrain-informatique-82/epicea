{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y-,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
unit AideMontant2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, StdCtrls, ExtCtrls, Buttons,Gr_Librairie_obj, Db, DBTables, Grids,
  DBGrids,
  CurrEdit,
  Mask,
  ToolEdit,
  LibZoneSaisie,
  E2_Librairie_Obj,
  DMConstantes,
  Variants,
  lib_chaine,
  LibGestionParamXML;

type
       TAideMontantTTC2RetFunction = record
//       Taux:real;
       Taux,HT,TTC,TVA:CURRENCY;
       Retour:Boolean;
end;



type
  TAideMontantTTC2 = class(TForm)

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function RetourVerification(varEdit:array of TCurrencyEdit):string;
    procedure ExitChamp(sender:TObject);
    procedure EnterChamp(sender:TObject);
    procedure RaccordementProcedures(sender:TObject);
    procedure CreationPanel(Incr1,Incr2,nb:integer);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyDown(sender:Tobject; var Key: Word;
      Shift: TShiftState);
    procedure BitbtnOKClick(sender:TObject);
    procedure BitbtnOKEnter(sender:TObject);
    procedure BitbtnCancelClick(sender:TObject);
    function VerifChangementValeur(valeur,ValeurTmp:TAideMontantTTC2RetFunction):boolean;
    procedure CorrectionEditVide;
    procedure CurrencyEditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    PanelCourant:Tpanel;
    

  end;

var
  AideMontantTTC2: TAideMontantTTC2;
  LabelTaux:TLabel;
  LabelTTC:tlabel;
  labelHT:tlabel;
  labelTVA:tlabel;
  EditTaux:TCurrencyEdit;
  EditTTC:TCurrencyEdit;
  EditHT:TCurrencyEdit;
  EditTVA:TCurrencyEdit;
  BitbtnAnnuler:TBitBtn;
  BitbtnOK:TBitBtn;
  MonPanel:TPanel;
  Valider:integer;
  resultatTmp:TAideMontantTTC2RetFunction;
  Taux:Extended;
  TTC,HT,TVA:currency;
  Function  AideMontantAffiche(const Montant:array of extended;Position:integer;MaJour:boolean;Controls:array of const;NumChamp:array of integer;Devise:String;Journal:integer=3):TAideMontantTTC2RetFunction;
  FUNCTION CalculTVA(Taux:Extended;TTC,HT,TVA:currency;Formule:integer):TAideMontantTTC2RetFunction;
  function retour(Var1:TVarRec):currency;
  procedure InitialiseAideMontantTTC2RetFunction(var retour:TAideMontantTTC2RetFunction);
  Procedure RecupResultPanel(var resultat:TAideMontantTTC2RetFunction;Objet:tPanel);
  Procedure RecupResultPourAffichage(resultat:TAideMontantTTC2RetFunction;TabValeurs:array of const;TabChamp:array of integer);
implementation

{$R *.DFM}
//function retour(var1:TVarRec;rang:integer;var2:array of const):currency;
function retour(var1:TVarRec):currency;
begin
result:=0;
  case var1.VType of
                  vtInteger: begin
                             if varisnull(var1.VInteger) then
                             result:=0
                             else
                             result:= var1.VInteger;
                             end;
                  vtExtended:begin
                             if varisnull(var1.VExtended^) then
                             result:=0
                             else
                             result:=var1.VExtended^;
                             end;
                  vtString: if varisnull(var1.VString^) then
                             result:=0
                             else
                             result:= StrToCurr_lgr(var1.VString^);
                  vtAnsiString:if varisnull(string(var1.VAnsiString)) then
                             result:=0
                             else
                             try
                             result:= StrToCurr_lgr(string(var1.VAnsiString));
                             except
                             result:=0;
                             end;
                  vtPChar:   if varisnull(string(var1.VPChar)) then
                             result:=0
                             else
                             result:= StrToCurr_lgr(var1.VPChar);
                  vtCurrency:if varisnull(var1.VCurrency^) then
                             result:=0
                             else
                             result:= var1.VCurrency^;
                  vtVariant: if varisnull(var1.VVariant^) then
                             result:=0
                             else
                             Result := StrToCurr_lgr(string(var1.VVariant^));
                  vtObject:  begin
                                if var1.VObject is TField then
                                result:=StrToCurr_lgr((var1.VObject as TField).text);
                                if var1.VObject is TInplaceEdit then
                                result:=StrToCurr_lgr((var1.VObject as TInplaceEdit).Text);
                                end ;

                end;//fin du case VTYPE
end;




procedure TAideMontantTTC2.EditKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
 begin
  BitbtnOK.Kind:=bkOK;
  ExitChamp(sender);
  EnterChamp(sender);
  (sender as TCustomEdit).SelectAll;
  inc(Valider);
 end;
  if not(key in [#48..#57,#8,decimalseparator])  then
  key:=#0;
end;



procedure TAideMontantTTC2.EditKeyDown(sender:Tobject; var Key: Word;
  Shift: TShiftState);
begin
//  if key=vk_return then
//  BitbtnOK.OnClick(BitbtnOK);

end;




//******************* CreationPanel *******************************************
// procedure de cr�ation des panels
//***************************************************************************
procedure TAideMontantTTC2.CreationPanel(Incr1,Incr2,nb:integer);
//var
//MonPanel:TPanel;
begin
  MonPanel:=TPanel.Create(AideMontantTTC2);
  MonPanel.Name:='MonPanel'+inttostr(nb);
//  MonPanel.OnEnter:=RaccordementProcedures;
  monpanel.Caption:='';
  MonPanel.Height:=220;
  MonPanel.Width:=240;
  monPanel.Top:=220*(Incr1 div 8);
  monPanel.Left:=240*(Incr2 mod 2);
  MonPanel.Parent:=AideMontantTTC2;
  AideMontantTTC2.Height:=MonPanel.Top+MonPanel.Height+20;
//  AideMontantTTC2.Width:=monPanel.Left+MonPanel.Width;
end;

//******************* TAideMontantTTC.RetourVerification *************************

//***************************************************************************
function TAideMontantTTC2.RetourVerification(varEdit:array of TCurrencyEdit):string;
var
i:integer;
begin
result:='';
  for i:=0 to high(varEdit)do
  begin
   if (not(empty(varedit[i].Text))) and (StrToFloat_Lgr(varedit[i].Text)>0) then
   result:=result+inttostr(i+1);
  end;
if result='' then result:='0';

end;


//******************* CalculTVA *********************************************
//r�cup des valeurs et calcul la TVA en fonction
//***************************************************************************
FUNCTION CalculTVA(Taux:Extended;TTC,HT,TVA:currency;Formule:integer):TAideMontantTTC2RetFunction;
var
TTCTmp,HTTmp,TVATmp:extended;
begin
result.Retour:=true;
TTCTmp:=TTC;
HTTmp:=HT;
TVATmp:=TVA;
//   case formule of
//   1234,123,134,13:begin
//                            TTC:=HT+(ht*taux/100);
//                            TVA:=ht*taux/100;
//                           end;
//                234,34:begin
//                            TTC:=HT+TVA;
//                            TAUX:=tva*100/ht;
//                           end;
//                      14:begin
//                            HT:=TVA*100/TAUX;
//                            TTC:=ht+(ht*taux/100);
//                           end;
//                      23:begin
//                            TVA:=ttc-ht;
//                            taux:=tva*100/ht;
//                           end;
//                      24:begin
//                            HT:=ttc-tva;
//                            taux:=tva*100/ht;
//                           end;
//                      12,124:begin
//                            HT:=(100*ttc)/(100+taux);
//                            tva:=ttc-ht;
//                            end;
   case formule of
   1234,123,134,13:begin
                            TTCTmp:=HTTmp+(htTmp*taux/100);
                            TVATmp:=htTmp*taux/100;
                           end;
                234,34:begin
                            TTCTmp:=HTTmp+TVATmp;
                            TAUX:=tvaTmp*100/htTmp;
                           end;
                      14:begin
                            HTTmp:=arrondi(TVATmp*100/TAUX,2);
                            TTCTmp:=htTmp+(htTmp*taux/100);
                           end;
                      23:begin
                            TVATmp:=arrondi(ttcTmp-htTmp,2);
                            taux:=tvaTmp*100/htTmp;
                           end;
                      24:begin
                            HTTmp:=ttcTmp-tvaTmp;
                            taux:=tvaTmp*100/htTmp;
                           end;
                      12,124:begin
                            HTTmp:=(100*ttcTmp)/(100+taux);
                            tvatmp:=ttctmp-httmp;
                            end;
   else
   result.Retour:=false;
   end;//fin du case
   result.Taux:=arrondi(taux,2);
   result.TTC:=arrondi(TTCTmp,2);
   result.HT:=arrondi(htTmp,2);
   result.TVA:=arrondi(tvaTmp,2);
end;

//******************* AideMontantTTCAffiche *************************
//Les param�tres doivent �tre pass�s par paquet de 4 dans l'ordre suivant
//Taux,TTC,HT,TVA,
//**************************************************************************
Function  AideMontantAffiche(const Montant:array of extended;Position:integer;MaJour:boolean;Controls:array of const;NumChamp:array of integer;Devise:String;Journal:integer):TAideMontantTTC2RetFunction;
var
i,k,j,l,NbPanel:integer;
retourVerif,IndicePanel:string;
RetourCalcul:TAideMontantTTC2RetFunction;
ObjPanel:tpanel;
ControlDest:tobject;
Changement,c:boolean;
begin 

    if AideMontantTTC2=nil then
    AideMontantTTC2:=TAideMontantTTC2.Create(Application.MainForm);
    if MonPanel=nil then
    begin
    NbPanel:=0;
    j:=0;
    Valider:=0;
    Changement:=false;
//    AideMontantTTC2.ModalResult:=mrOK;
    InitialiseAideMontantTTC2RetFunction(resultattmp);

    InitialiseAideMontantTTC2RetFunction(result);
      for i:=0 to high(montant) do
        begin //d�but de boucle sur la longueur du tableau pass� en param�tre
          if (i mod 4)=0 then
          begin //si i =0 ou i est un multiple de 4
             if i=0 then
             begin
             AideMontantTTC2.Height:=245;
             AideMontantTTC2.Width:=247;
             end
             else
                begin
                if i=4 then
                AideMontantTTC2.Width:=AideMontantTTC2.Width+247
                else
                  begin
                  if (i mod 2)=0 then
                  AideMontantTTC2.Height:=AideMontantTTC2.Height+250;
                  end;
                end;
           NbPanel:=NbPanel+1;
           retourVerif:='';
           AideMontantTTC2.CreationPanel(i,j,NbPanel);
           j:=j+1;
           LabelTaux:=TLabel.Create(AideMontantTTC2);
           labelHT:=TLabel.Create(AideMontantTTC2);
           LabelTTC:=TLabel.Create(AideMontantTTC2);
           labelTVA:=TLabel.Create(AideMontantTTC2);
           EditHT:=TCurrencyEdit.Create(AideMontantTTC2);
           EditTaux:=TCurrencyEdit.Create(AideMontantTTC2);
           EditTTC:=TCurrencyEdit.Create(AideMontantTTC2);
           EditTVA:=TCurrencyEdit.Create(AideMontantTTC2);
            end;//fin i =0 ou i est un multiple de 4
             case (i mod 4 ) of // suivant si le reste de i/4 =0,1,2, ou 3
              0:begin //i mod 4 =0
                 LabelTaux.Caption:='Taux � ';
                 LabelTaux.Height:=13;
                 LabelTaux.Top:=8;
                 labeltaux.Width:=60;
                 labeltaux.Left:=10;
                 labeltaux.Color:=clYellow;
                 LabelTaux.Parent:=(AideMontantTTC2.FindComponent('MonPanel'+inttostr(NbPanel)) as tpanel);
                 EditTaux.Name:='EditTaux'+inttostr(NbPanel);
                 edittaux.OnKeyPress:=AideMontantTTC2.EditKeyPress;
                 edittaux.OnKeyDown:=AideMontantTTC2.EditKeyDown;
//                 edittaux.Value:=retour(montant[i].VType,i,montant);
                 edittaux.Value:=montant[i];
                 edittaux.Height:=21;
                 edittaux.Width:=80;
                 edittaux.Top:=8;
                 edittaux.Left:=120;
                 edittaux.DisplayFormat:=',0.00 %';
                 edittaux.Color:=clSilver;
                 edittaux.Parent:=(AideMontantTTC2.FindComponent('MonPanel'+inttostr(NbPanel)) as tpanel);
                 edittaux.OnEnter:=AideMontantTTC2.EnterChamp;
                 Edittaux.OnExit:=AideMontantTTC2.ExitChamp;
                 //if ((j=1) and (position =1)) then //isa le 26-06-03
                 if position =1 then
                 AideMontantTTC2.ActiveControl :=edittaux;
                end; //fin i mod 4 =0
              1:begin //i mod 4 =1
                 LabelTTC.Caption:='Montant TTC ';
                 LabelTTC.Height:=13;
                 LabelTTC.Top:=48;
                 LabelTTC.Width:=100;
                 LabelTTC.Left:=10;
                 LabelTTC.Parent:=(AideMontantTTC2.FindComponent('MonPanel'+inttostr(NbPanel)) as tpanel);
                 EditTTC.Name:='EditTTC'+inttostr(NbPanel);
                 EditTTC.OnKeyPress:=AideMontantTTC2.EditKeyPress;
                 EditTTC.OnKeyDown:=AideMontantTTC2.EditKeyDown;
                 EditTTC.Value :=montant[i];
                 EditTTC.Height:=21;
                 EditTTC.Width:=80;
                 EditTTC.Top:=48;
                 EditTTC.Left:=120;
                 EditTTC.DisplayFormat:=',0.00 '+Devise+';-,0.00 '+Devise;
                 EditTTC.Parent:=(AideMontantTTC2.FindComponent('MonPanel'+inttostr(NbPanel)) as tpanel);
                 editttc.OnEnter:=AideMontantTTC2.EnterChamp;
                 Editttc.OnExit:=AideMontantTTC2.ExitChamp;
                 //if ((j=1) and (position =2)) then //isa le 26-06-03
                 if position =2 then
                 AideMontantTTC2.ActiveControl :=Editttc;
                end; //fin i mod 4 =1
              2:begin //i mod 4 =3
                 LabelHT.Caption:='Montant HT ';
                 LabelHT.Height:=13;
                 LabelHT.Top:=88;
                 LabelHT.Width:=100;
                 LabelHT.Left:=10;
                 labelHT.Parent:=(AideMontantTTC2.FindComponent('MonPanel'+inttostr(NbPanel)) as tpanel);
                 EditHT.Name:='EditHT'+inttostr(NbPanel);
                 EditHT.OnKeyPress:=AideMontantTTC2.EditKeyPress;
                 EditHT.OnKeyDown:=AideMontantTTC2.EditKeyDown;
                 EditHT.Value :=montant[i];
                 EditHT.Height:=21;
                 EditHT.Width:=80;
                 EditHT.Top:=88;
                 EditHT.Left:=120;
                 EditHT.DisplayFormat:=',0.00 '+Devise+';-,0.00 '+Devise;
                 EditHT.Parent:=(AideMontantTTC2.FindComponent('MonPanel'+inttostr(NbPanel)) as tpanel);
                 editht.OnEnter:=AideMontantTTC2.EnterChamp;
                 EditHT.OnExit:=AideMontantTTC2.ExitChamp;
                 //if ((j=1) and (position =3)) then //isa le 29-06-03
                 if position =3 then
                 AideMontantTTC2.ActiveControl:=EditHT;
                end;//fin i mod 4 =2
              3:begin//i mod 4 =3
                 LabelTVA.Caption:='Montant TVA ';
                 LabelTVA.Height:=13;
                 LabelTVA.Top:=128;
                 LabelTVA.Width:=100;
                 LabelTVA.Left:=10;
                 LabelTVA.Parent:=(AideMontantTTC2.FindComponent('MonPanel'+inttostr(NbPanel)) as tpanel);
                 EditTVA.Name:='EditTVA'+inttostr(NbPanel);
                 EditTVA.OnKeyPress:=AideMontantTTC2.EditKeyPress;
                 EditTVA.OnKeyDown:=AideMontantTTC2.EditKeyDown;
                 EditTVA.Value :=montant[i];
                 EditTVA.Height:=21;
                 EditTVA.Width:=80;
                 EditTVA.Top:=128;
                 EditTVA.Left:=120;
                 EditTVA.DisplayFormat:=',0.00 '+Devise+';-,0.00 '+Devise;
                 EditTVA.Parent:=(AideMontantTTC2.FindComponent('MonPanel'+inttostr(NbPanel)) as tpanel);
                 edittva.OnEnter:=AideMontantTTC2.EnterChamp;
                 Edittva.OnExit:=AideMontantTTC2.ExitChamp;
                 //if ((j=1) and (position =4)) then //isa le 26-06-03
                 if position =4 then
                 AideMontantTTC2.ActiveControl :=Edittva;
                 retourVerif:=AideMontantTTC2.RetourVerification([EditTaux,EditTTC,EditHT,EditTVA]);
                 InitialiseAideMontantTTC2RetFunction(RetourCalcul);
//                 AideMontantTTC2.CorrectionEditVide;
                 RetourCalcul:=CalculTVA(edittaux.Value,editttc.Value,editht.Value,edittva.Value,StrToInt_Lgr(retourVerif));
                 MonPanel.OnEnter:=AideMontantTTC2.RaccordementProcedures;
                 if RetourCalcul.Retour then
                    begin
                     edittaux.Value:=RetourCalcul.Taux;
                     editttc.Value:=RetourCalcul.TTC;
                     editht.Value:=RetourCalcul.HT;
                     edittva.Value:=RetourCalcul.TVA;
                      if journal=2 then
                        Begin
                          edittaux.Enabled:=false;
                          EditTVA.Enabled:=false;
                        end;
//                     edittaux.Text:=floattostr(RetourCalcul.Taux);
//                     editttc.Text:=currtostr(RetourCalcul.TTC);
//                     editht.Text:=currtostr(RetourCalcul.HT);
//                     edittva.Text:=currtostr(RetourCalcul.TVA);
                    end;
                end;//fin i mod 4 =3
             end; // fin du case suivant si le reste de i/4 =0,1,2, ou 3
      end;//fin de boucle du tableau pass� en param�tre
      for l:=1 to NbPanel do
      for i:=0 to (AideMontantTTC2.FindComponent('MonPanel'+inttostr(l)) as tpanel).ControlCount-1 do
          if (AideMontantTTC2.FindComponent('MonPanel'+inttostr(l)) as tpanel).Controls[i].ClassNameIs('TCurrencyEdit') then
           ((AideMontantTTC2.FindComponent('MonPanel'+inttostr(l)) as tpanel).Controls[i] as TCurrencyEdit).OnChange:=AideMontantTTC2.CurrencyEditChange;
//         edittaux.OnChange:=AideMontantTTC2.CurrencyEditChange;
//         EditTTC.OnChange:=AideMontantTTC2.CurrencyEditChange;
//         EditHT.OnChange:=AideMontantTTC2.CurrencyEditChange;
//         EditTVA.OnChange:=AideMontantTTC2.CurrencyEditChange;

           BitbtnAnnuler:=TBitBtn.Create(AideMontantTTC2);
           BitbtnAnnuler.Name:='BitbtnAnnuler'+inttostr(NbPanel);
           BitbtnAnnuler.Height:=30;
           BitbtnAnnuler.Top:=180;
           BitbtnAnnuler.Width:=75;
           BitbtnAnnuler.Left:=30;
           BitbtnAnnuler.Caption:='Annuler';
           BitbtnAnnuler.Kind:=bkCancel;
           BitbtnAnnuler.ModalResult:=mrCancel;
           BitbtnAnnuler.OnClick:=AideMontantTTC2.BitbtnCancelClick;
           BitbtnOK:=TBitBtn.Create(AideMontantTTC2);
           BitbtnOK.Name:='BitbtnOK'+inttostr(NbPanel);
           BitbtnOK.Height:=30;
           BitbtnOK.Top:=180;
           BitbtnOK.Width:=75;
           BitbtnOK.Left:=135;
           BitbtnOK.Caption:='OK';
           BitbtnOK.Kind:=bkOK;
           BitbtnOK.OnClick:=AideMontantTTC2.BitbtnOKClick;
           BitbtnOK.OnEnter:=AideMontantTTC2.BitbtnOKEnter;
    end;//if MonPanel=nil
    if valider<1 then
    BitbtnOK.Caption:='OK'
    else
    BitbtnOK.Caption:='Valider';
    if AideMontantTTC2.ModalResult<>2 then
    AideMontantTTC2.ShowModal
    else
      Begin
         valider:=0;
//         AideMontantTTC2.FormDestroy(AideMontantTTC2) ;
AideMontantTTC2.Free;
         abort;
      End;

       try
            begin
               ObjPanel:=BitbtnOK.Parent as tpanel;
               if AideMontantTTC2.ActiveControl is TCurrencyEdit then
               AideMontantTTC2.ExitChamp(AideMontantTTC2.activecontrol);
               RecupResultPanel(result,ObjPanel);
               result.retour:=retourCalcul.retour;
               if (result.HT=0) and (result.TTC=0) then
               begin
               result.Taux:=0;
               result.TVA:=0;
               end;
               Changement:=false;
               Changement:=AideMontantTTC2.VerifChangementValeur(resultatTmp,result);
               if ((Changement=true)and (valider<=1)) then
               Changement:=false;
               resultatTmp.Retour:=result.Retour;
               resultatTmp.Taux:=result.Taux;
               resultatTmp.HT:=result.HT;
               resultatTmp.TTC:=result.TTC;
               resultatTmp.TVA:=result.TVA;
            end;
       except
       showmessage('Une erreur s''est produite au renvoie des valeurs !!!');
       valider:=0;
//       AideMontantTTC2.FormDestroy(AideMontantTTC2) ;
AideMontantTTC2.Free;
       end;//fin du try

   if ((valider>=1) and (not changement)) then
   begin
   //remplir les champs de destination si MaJour=true
      if MaJour then
      RecupResultPourAffichage(result,controls,NumChamp);
      valider:=0;
//      AideMontantTTC2.FormDestroy(AideMontantTTC2) ;
AideMontantTTC2.Free;
   end
   else
   begin
      if ((valider>=1) and (AideMontantTTC2.ModalResult<>mrcancel)) then
      begin
         if AideMontantTTC2.modalresult<>MrCancel then
         Begin
         RecupResultPanel(result,ObjPanel);
         if MaJour then
         RecupResultPourAffichage(result,controls,NumChamp);
         valider:=0;
//         AideMontantTTC2.FormDestroy(AideMontantTTC2) ;
AideMontantTTC2.Free;
         End
         else
         begin
         valider:=0;
//         AideMontantTTC2.FormDestroy(AideMontantTTC2) ;
AideMontantTTC2.Free;
         end;
      end;
   end;
if AideMontantTTC2<>nil then
//AideMontantTTC2.FormDestroy(AideMontantTTC2);
AideMontantTTC2.Free;
end;



//******************* TAideMontantTTC.ExitChamp *************************

//**************************************************************************
procedure TAideMontantTTC2.ExitChamp(sender:TObject);
var
resultat:TAideMontantTTC2RetFunction;
OPanel:TPanel;
IndicePanel:string;
EditHT_0,editttc_0,EditTaux_0,edittva_0:Currency;
EditHT0,editttc0,EditTaux0,edittva0:integer;
j:integer;
begin
if trim((sender as TCurrencyEdit).Text)='' then
(sender as TCurrencyEdit).Text:='0';
OPanel:=((sender as TCurrencyEdit).Parent as TPanel);
IndicePanel:=copy(OPanel.Name,length(OPanel.Name),1);
   for j:=0 to ((sender as TCurrencyEdit).Parent as TPanel).ControlCount-1 do
    begin
      if OPanel.controls[j] is TCurrencyEdit then
      begin
      if OPanel.controls[j].Name=('EditHT'+IndicePanel) then
                  EditHT0:=j;
      if OPanel.controls[j].Name=('EditTTC'+IndicePanel) then
                  editttc0:=j;
      if OPanel.controls[j].Name=('EditTaux'+IndicePanel) then
                  EditTaux0:=j;
      if OPanel.controls[j].Name=('EditTVA'+IndicePanel) then
                  edittva0:=j;
      end;
     end;
EditTaux_0:=(OPanel.controls[EditTaux0]as TCurrencyEdit).Value;
editttc_0:=(OPanel.controls[editttc0]as TCurrencyEdit).Value;
EditHT_0:=(OPanel.controls[EditHT0]as TCurrencyEdit).Value;
edittva_0:=(OPanel.controls[edittva0]as TCurrencyEdit).Value;
try   //si le taux � chang� ou le TTC on ex�cute la formule correspondante
     if (EditTaux_0<>taux)or (EditTTC_0<>ttc) then
      begin
      resultat:=CalculTVA(edittaux_0,editttc_0,
      editht_0,edittva_0,12);
      edittva_0:=resultat.TVA;
      editht_0:=resultat.HT;
      end
      else
       //si le ht � chang� ou la tva on ex�cute la formule correspondante
         if (editht_0<>ht) then
              begin
              resultat:=CalculTVA(edittaux_0,editttc_0,
              editht_0,edittva_0,13);
              edittaux_0:=resultat.Taux;
              editttc_0:=resultat.TTC;
              edittva_0:=resultat.TVA;
              end
              else
         if (edittva_0<>tva) then
              begin
              resultat:=CalculTVA(edittaux_0,editttc_0,
              editht_0,edittva_0,14);
              edittaux_0:=resultat.Taux;
              editttc_0:=resultat.TTC;
              editht_0:=resultat.HT;
              end;
(OPanel.controls[EditTaux0]as TCurrencyEdit).Value:=EditTaux_0;
(OPanel.controls[editttc0]as TCurrencyEdit).Value:=editttc_0;
(OPanel.controls[EditHT0]as TCurrencyEdit).Value:=EditHT_0;
(OPanel.controls[edittva0]as TCurrencyEdit).Value:=edittva_0;

 except
 end;
end;



procedure TAideMontantTTC2.BitbtnOKClick(sender:TObject);
Begin
if valider<1 then
 begin
 BitbtnOK.ModalResult:=mrno;
 ModalResult:=mrno;
 valider:=valider+1;
 end
 else
 begin
 BitbtnOK.ModalResult:=mrOk;
 ModalResult:=mrOk;
// valider:=0;
 end;
End;


procedure TAideMontantTTC2.BitbtnCancelClick(sender:TObject);
Begin
 BitbtnAnnuler.ModalResult:=mrCancel;
 ModalResult:=mrCancel;
End;


//******************* TAideMontantTTC.EnterChamp *************************

//**************************************************************************
procedure TAideMontantTTC2.EnterChamp(sender:TObject);
var
OPanel:TPanel;
IndicePanel:string;
//EditHT0,editttc0,EditTaux0,edittva0:TCurrencyEdit;
EditHT0,editttc0,EditTaux0,edittva0:integer;
j:integer;
begin
OPanel:=((sender as TCurrencyEdit).Parent as TPanel);
IndicePanel:=copy(OPanel.Name,length(OPanel.Name),1);
   for j:=0 to OPanel.ControlCount-1 do
    begin
      if OPanel.controls[j] is TCurrencyEdit then
      begin
      if (OPanel.controls[j] as TCurrencyEdit).Name=('EditHT'+IndicePanel) then
                  EditHT0:=j;
      if (OPanel.controls[j] as TCurrencyEdit).Name=('EditTTC'+IndicePanel) then
                  editttc0:=j;
      if (OPanel.controls[j] as TCurrencyEdit).Name=('EditTaux'+IndicePanel) then
                  EditTaux0:=j;
      if (OPanel.controls[j] as TCurrencyEdit).Name=('EditTVA'+IndicePanel) then
                  edittva0:=j;
      end;
     end;
Taux:=0;
TTC:=0;
ht:=0;
tva:=0;
try

taux:=(OPanel.controls[EditTaux0] as TCurrencyEdit).Value;
ttc:=(OPanel.controls[editttc0] as TCurrencyEdit).Value;
ht:=(OPanel.controls[EditHT0] as TCurrencyEdit).Value;
tva:=(OPanel.controls[edittva0] as TCurrencyEdit).Value;

//taux:=EditTaux0.value;
//ttc:=EditTTC0.value;
//ht:=editht0.value;
//tva:=edittva0.value;
except
taux:=0;
ttc:=0;
ht:=0;
tva:=0;
end;
end;


//******************* RaccordementProcedures *************************

//**************************************************************************
procedure TAideMontantTTC2.RaccordementProcedures(sender:TObject);
var
objPanel:tpanel;
begin
BitbtnAnnuler.Parent:=(sender as tpanel);
BitbtnOK.Parent:= (sender as tpanel);
end;


//******************* TAideMontantTTC.FormCreate *************************
procedure TAideMontantTTC2.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
      
  except
     Position:=poScreenCenter;
     //InitialiseFormPosDefaut(self);
  end;
end;



procedure TAideMontantTTC2.FormDestroy(Sender: TObject);
begin
if AideMontantTTC2<>nil then
  begin
  libereobjet(Tobject(MonPanel),Self);
//  if MonPanel <> nil then
//   MonPanel.Free;
//   MonPanel:=nil;
   LibGestionParamXML.DestroyForm(AideMontantTTC2,E.user);
   AideMontantTTC2:=nil;
  end;
end;

function TAideMontantTTC2.VerifChangementValeur(valeur,ValeurTmp:TAideMontantTTC2RetFunction):boolean;
var
i:integer;
Begin
result:=false;
i:=0;
while ((result=false) and (i<=4)) do
   begin
      case i of
      0:result:=((booltostr(valeur.Retour)) <> (booltostr( ValeurTmp.Retour)));
      1:result:=((valeur.Taux)<>(ValeurTmp.Taux));
      2:result:=((valeur.HT)<>(ValeurTmp.HT));
      3:result:=((valeur.TTC)<>(ValeurTmp.TTC));
      4:result:=((valeur.TVA)<>(ValeurTmp.TVA));
      end;//fin du case
   inc(i);
   end;
End;


procedure InitialiseAideMontantTTC2RetFunction(var retour:TAideMontantTTC2RetFunction);
Begin
retour.Retour:=false;
retour.HT:=0;
retour.TTC:=0;
retour.TVA:=0;
retour.TVA:=0;
End;


Procedure RecupResultPanel(var resultat:TAideMontantTTC2RetFunction;Objet:tPanel);
var
K:integer;
IndicePanel:string;
Begin
IndicePanel:='';
 for k:=0 to Objet.ControlCount-1 do
     begin
       if Objet.controls[k] is TCurrencyEdit then
       begin
       IndicePanel:=copy(Objet.Name,length(Objet.Name),1);
       if Objet.controls[k].Name=('EditHT'+IndicePanel) then
                   resultat.HT:=(Objet.controls[k] as TCurrencyEdit).value;
       if Objet.controls[k].Name=('EditTTC'+IndicePanel) then
                   resultat.TTC:=(Objet.controls[k] as TCurrencyEdit).value;
       if Objet.controls[k].Name=('EditTaux'+IndicePanel) then
                   resultat.Taux:=(Objet.controls[k] as TCurrencyEdit).value;
       if Objet.controls[k].Name=('EditTVA'+IndicePanel) then
                   resultat.TVA:=(Objet.controls[k] as TCurrencyEdit).value;
       end;
     end;
//resultat.Taux:=ArrondiCentieme(resultat.Taux);
//resultat.HT:=ArrondiCentieme(resultat.HT);
//resultat.TTC:=ArrondiCentieme(resultat.TTC);
//resultat.TVA:=ArrondiCentieme(resultat.TVA);
End;


Procedure RecupResultPourAffichage(resultat:TAideMontantTTC2RetFunction;TabValeurs:array of const;TabChamp:array of integer);
var
ControlDest:TObject;
i:integer;
begin
 for i:=0 to high(TabValeurs)do
  Begin
  ControlDest:=(TabValeurs[i].Vobject);
  case RecupClassTypeComponent(ControlDest as tcomponent)of
           GTEdit:case (TabChamp[i])of
                   1:TCustomEdit(ControlDest as tcomponent).Text:=FormatCurr('0.00',resultat.Taux);
                   2:TCustomEdit(ControlDest as tcomponent).Text:=FormatCurr('0.00',resultat.HT);
                   3:TCustomEdit(ControlDest as tcomponent).Text:=FormatCurr('0.00',resultat.TTC);
                   4:TCustomEdit(ControlDest as tcomponent).Text:=FormatCurr('0.00',resultat.TVA);
                  end;//fin du case n� champ
     GTGrInplaceEdit,GTInplaceEdit:case (TabChamp[i])of
            1:TCustomEdit(ControlDest as tcomponent).Text:=currtostr(resultat.Taux);
            2:TCustomEdit(ControlDest as tcomponent).Text:=currtostr(resultat.HT);
            3:TCustomEdit(ControlDest as tcomponent).Text:=currtostr(resultat.TTC);
            4:TCustomEdit(ControlDest as tcomponent).Text:=currtostr(resultat.TVA);
            end;//fin du case N�du champ � r�cup�rer
     GTStringGrid,GTGrid,GTGrGrid:with TStringGrid(ControlDest as tcomponent) do
            begin
               case (TabChamp[i])of
               1:TStringGrid(ControlDest as tcomponent).Cells[Col, Row]:=FormatCurr('0.00',resultat.Taux);
               2:TStringGrid(ControlDest as tcomponent).Cells[Col, Row]:=FormatCurr('0.00',resultat.HT);
               3:TStringGrid(ControlDest as tcomponent).Cells[Col, Row]:=FormatCurr('0.00',resultat.TTC);
               4:TStringGrid(ControlDest as tcomponent).Cells[Col, Row]:=FormatCurr('0.00',resultat.TVA);
               end;//fin du case N�du champ � r�cup�rer
            end;
     GTDBGrid,GTGrDBGrid:if TCustomdbgrid(ControlDest as tcomponent).SelectedField.DataSet.State in [dsedit,dsinsert] then
              begin
                 case (TabChamp[i])of
                 1:TCustomdbgrid(ControlDest as tcomponent).selectedfield.asstring:=currtostr(resultat.Taux);
                 2:TCustomdbgrid(ControlDest as tcomponent).selectedfield.asstring:=currtostr(resultat.HT);
                 3:TCustomdbgrid(ControlDest as tcomponent).selectedfield.asstring:=currtostr(resultat.TTC);
                 4:TCustomdbgrid(ControlDest as tcomponent).selectedfield.asstring:=currtostr(resultat.TVA);
                 end;//fin du case N�du champ � r�cup�rer
              end;
     GTFieldString:if TField(ControlDest as tcomponent).DataSet.State in [dsedit,dsinsert] then
                   begin
                     case (TabChamp[i])of
                     1:TField(ControlDest as tcomponent).asstring:=currtostr(resultat.Taux);
                     2:TField(ControlDest as tcomponent).asstring:=currtostr(resultat.HT);
                     3:TField(ControlDest as tcomponent).asstring:=currtostr(resultat.TTC);
                     4:TField(ControlDest as tcomponent).asstring:=currtostr(resultat.TVA);
                     end;//fin du case N�du champ � r�cup�rer
                  end;
     GTFieldCurr:if TField(ControlDest as tcomponent).DataSet.State in [dsedit,dsinsert] then
                   begin
                     case (TabChamp[i])of
                     1:TField(ControlDest as tcomponent).asstring:=currtostr(resultat.Taux);
                     2:TField(ControlDest as tcomponent).asstring:=currtostr(resultat.HT);
                     3:TField(ControlDest as tcomponent).asstring:=currtostr(resultat.TTC);
                     4:TField(ControlDest as tcomponent).asstring:=currtostr(resultat.TVA);
                     end;//fin du case N�du champ � r�cup�rer
                  end;
     end;//fin du case
  End;
end;


procedure TAideMontantTTC2.CorrectionEditVide;
Begin
//if empty(EditTaux.Text) then
//EditTaux.Text:='0';
//if empty(EditTTC.Text) then
//EditTTC.Text:='0';
//if empty(EditHT.Text) then
//EditHT.Text:='0';
//if empty(EditTVA.Text) then
//EditTVA.Text:='0';

//if EditTaux. then
//EditTaux.Text:='0';
//if empty(EditTTC.Text) then
//EditTTC.Text:='0';
//if empty(EditHT.Text) then
//EditHT.Text:='0';
//if empty(EditTVA.Text) then
//EditTVA.Text:='0';
End;


procedure TAideMontantTTC2.CurrencyEditChange(Sender: TObject);
begin
if BitbtnOK <> nil then
 if (sender as TWincontrol)= ActiveControl then
 begin
  BitbtnOK.Caption:='Valider';
  BitbtnOK.Kind:=bkCustom;
  BitbtnOK.Default:=false;
  BitbtnOK.Glyph.FreeImage;
  BitbtnOK.Refresh;
 end;
end;

procedure TAideMontantTTC2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key <> VK_RETURN then WinSuivPrec(Handle,key,[nil]);
end;

procedure TAideMontantTTC2.BitbtnOKEnter(sender:TObject);
Begin
  valider:=valider+1;
  BitbtnOK.Caption:='OK';
  BitbtnOK.ModalResult:=mrOk;
//  ModalResult:=mrOk;
  BitbtnOK.Kind:=bkOK;
  BitbtnOK.Default:=true;
//  BitbtnOK.Glyph.FreeImage;
//  BitbtnOK.Refresh;
End;

end.