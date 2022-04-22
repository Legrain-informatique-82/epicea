unit E2_SuprCptGen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXCtrls, ExtCtrls, gr_Librairie_obj,DB,E2_Librairie_Obj,
  E2_Decl_Records,LibSQL,LibGestionParamXML, DMConstantes;

type
  TSuprCptGen = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    ChBoxGenerateur: TCheckBox;
    Panel3: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  SuprCptGen: TSuprCptGen;

function SuprCptAffiche(Cpt:string;Generateur:boolean;DataSet:TDataSet):boolean;

implementation

{$R *.DFM}

uses DMPlanCpt,DMEcriture;

function SuprCptAffiche(Cpt:string;Generateur:boolean;DataSet:TDataSet):boolean;
var
ChBoxGenere:TCheckBox;
i:integer;
FinCpt,CptRac1,CptRac2:string;
RetoutErreur:TErreurSaisie;
Suppressionpossible:boolean;
begin
Suppressionpossible:=true;
   // Création Feuille
   if SuprCptGen = Nil then SuprCptGen:= TSuprCptGen.Create(Application.MainForm);
   // Récupération de l'extension du compte créé
   if Generateur
    then FinCpt:=copy(Cpt,length(DMPlan.TaParamCpt.findField('Rac1').AsString)+1,length(Cpt))
    else FinCpt:=copy(Cpt,length(DMPlan.TaParamCpt.findField('Rac2').AsString)+1,length(Cpt));
   DMPlan.TaParamCpt.First;

   CptRac1 := DMPlan.TaParamCpt.findField('Rac1').AsString+FinCpt;
   if length(CptRac1) > 8 then delete(CptRac1,9,length(CptRac1)-8);

   // Gestion de la case à cocher du compte générateur
   SuprCptGen.ChBoxGenerateur.Caption:=CptRac1;
   // Vérifie si le compte générateur à supprimer existe
   if DMPlan.CompteExistePCU(CptRac1) then
     begin
     SuprCptGen.ChBoxGenerateur.Enabled:=true;
     SuprCptGen.ChBoxGenerateur.State:=cbChecked;
     // Vérifie si le compte générateur à supprimer ne possède pas d'écriture
     RetoutErreur:=DMPlan.SuppressionCpt(CptRac1,dataset,False);
     // Si le compte n'est pas supprimable
     if RetoutErreur.Retour = false then
      begin
       // on verifie que ce ne soit pas a cause du fait que c'est un compte généré ou générateur
       if ((RetoutErreur.CodeErreur = 2003) or (RetoutErreur.CodeErreur = 2004)) then
        begin
          SuprCptGen.ChBoxGenerateur.Enabled:=true;
          SuprCptGen.ChBoxGenerateur.State:=cbChecked;
        end
         else
        begin
          SuprCptGen.ChBoxGenerateur.Enabled:=false;
          SuprCptGen.ChBoxGenerateur.State:=cbUnchecked;
          end;
        end
        else
        begin
        SuprCptGen.ChBoxGenerateur.Enabled:=true;
        SuprCptGen.ChBoxGenerateur.State:=cbChecked;
        end;
     end
     else
     begin
     SuprCptGen.ChBoxGenerateur.Enabled:=false;
     SuprCptGen.ChBoxGenerateur.State:=cbUnchecked;
     end;
Suppressionpossible:=SuprCptGen.ChBoxGenerateur.State=cbChecked;
//if not Suppressionpossible then
// begin
//  Messagedlg(PChar('Impossible de supprimer le compte : '+cpt+' - '+DMPlan.LibelleDuNumCptPCU(cpt)+#13#10#13#10+'Ce compte ou l''un de ses comptes associé est utilisé .'),MtWarning,[mbok],0);
//  result:=false;
//  abort;
// end;

     // Gestion et création dynamique des cases à cocher des comptes générés
     i:=1;
//     ChBoxGenere:=TCheckBox.Create(SuprCptGen);
//     ChBoxGenere.Parent:=SuprCptGen.Panel2;
//     ChBoxGenere.Alignment:=taLeftJustify;
//     SuprCptGen.Panel2.Height:=SuprCptGen.Panel2.Height+20;
////     SuprCptGen.Height:=SuprCptGen.Height;
//     ChBoxGenere.Top:=50*i;
//     ChBoxGenere.left:=156;
//
//     CptRac2 := DMPlan.TaParamCpt.findField('Rac2').AsString+FinCpt;
//     if length(CptRac2) > 8 then delete(CptRac2,9,length(CptRac2)-8);
//
//     ChBoxGenere.Caption:=CptRac2;
//     if DMPlan.CompteExistePCU(CptRac2) then
//     begin
//     ChBoxGenere.Enabled:=true;
//     ChBoxGenere.State:=cbChecked;
//     RetoutErreur:=DMPlan.SuppressionCpt(CptRac2,dataset,False);
//     // Si le compte n'est pas supprimable
//     if RetoutErreur.Retour = false then
//      begin
//       // on verifie que ce ne soit pas a cause du fait que c'est un compte généré ou générateur
//       if ((RetoutErreur.CodeErreur = 2003) or (RetoutErreur.CodeErreur = 2004)) then
//        begin
//          ChBoxGenere.Enabled:=true;
//          ChBoxGenere.State:=cbChecked;
//        end
//         else
//        begin
//          ChBoxGenere.Enabled:=false;
//          ChBoxGenere.State:=cbUnchecked;
//          end;
//       end
//       else
//       begin
//       ChBoxGenere.Enabled:=true;
//       ChBoxGenere.State:=cbChecked;
//       end;
//     end
//     else
//     begin
//     ChBoxGenere.Enabled:=false;
//     ChBoxGenere.State:=cbUnchecked;
//     end;
//
//     Suppressionpossible:=ChBoxGenere.State=cbChecked;
//     if not Suppressionpossible then
//      begin
//       Messagedlg(PChar('Impossible de supprimer le compte : '+cpt+' - '+DMPlan.LibelleDuNumCptPCU(cpt)+#13#10#13#10+'Ce compte ou l''un de ses comptes associé est utilisé .'),MtWarning,[mbok],0);
//       result:=false;
//       abort;
//      end;

     while not DMPlan.TaParamCpt.EOF do
      begin
       ChBoxGenere:=TCheckBox.Create(SuprCptGen);
       ChBoxGenere.Parent:=SuprCptGen.Panel2;
       ChBoxGenere.Alignment:=taLeftJustify;
       ChBoxGenere.State:=cbChecked;
       SuprCptGen.Panel2.Height:=SuprCptGen.Panel2.Height+50;
       SuprCptGen.Height:=SuprCptGen.Height+50;
       ChBoxGenere.Top:=50*i;
       ChBoxGenere.left:=156;

       CptRac2 := DMPlan.TaParamCpt.findField('Rac2').AsString+FinCpt;
       if length(CptRac2) > 8 then delete(CptRac2,9,length(CptRac2)-8);

       ChBoxGenere.Caption:=CptRac2;
       ChBoxGenere.Tag:=0;
        if DMPlan.CompteExistePCU(CptRac2) then
        begin
        ChBoxGenere.Enabled:=true;
        ChBoxGenere.State:=cbChecked;
        ChBoxGenere.Tag:=1;
        RetoutErreur:=DMPlan.SuppressionCpt(CptRac2,dataset,False);
        if RetoutErreur.Retour then
          begin
          ChBoxGenere.Enabled:=false;
          ChBoxGenere.State:=cbUnchecked;
          ChBoxGenere.Tag:=0;
          end
          else
          begin
          if ((RetoutErreur.CodeErreur = 2003) or (RetoutErreur.CodeErreur = 2004)) then
           begin
            ChBoxGenere.Enabled:=true;
            ChBoxGenere.State:=cbChecked;
            ChBoxGenere.Tag:=1;
           end
           else
           Begin
            ChBoxGenere.Enabled:=False;
            ChBoxGenere.State:=cbUnChecked;
            ChBoxGenere.Tag:=0;
           End;

          end;
        end
        else
        begin
        ChBoxGenere.Enabled:=false;
        ChBoxGenere.State:=cbUnchecked;
        ChBoxGenere.Tag:=0;
        end;
//
//        Suppressionpossible:=ChBoxGenere.State=cbChecked;
//        if not Suppressionpossible then
//         begin
//          Messagedlg(PChar('Impossible de supprimer le compte : '+cpt+' - '+DMPlan.LibelleDuNumCptPCU(cpt)+#13#10#13#10+'Ce compte ou l''un de ses comptes associé est utilisé .'),MtWarning,[mbok],0);
//          result:=false;
//          abort;
//         end;
//
       DMPlan.TaParamCpt.Next;
       inc(i);
      end;
result:= (SuprCptGen.showmodal = mrOk);
if result then
   begin
    DataSet.BeforeDelete:=nil;
    if ((SuprCptGen.ChBoxGenerateur.Checked = true) and (SuprCptGen.ChBoxGenerateur.Enabled = true)) then
       begin
          DataSet.Locate('Compte',SuprCptGen.ChBoxGenerateur.Caption,[]);
          TableGeredelete(DataSet);
       end;
     for i:=0 to SuprCptGen.Panel2.ControlCount-1 do
         begin
          if (SuprCptGen.Panel2.Controls[i] is TCheckBox) then
           begin
            if  (SuprCptGen.Panel2.Controls[i] as TCheckBox).tag=1 then
//            if (((SuprCptGen.Panel2.Controls[i] as TCheckBox).Enabled = true) and ((SuprCptGen.Panel2.Controls[i] as TCheckBox).Checked = true)) then
             begin
              if DataSet.Locate('Compte',(SuprCptGen.Panel2.Controls[i] as TCheckBox).Caption,[]) then
               begin
//                showmessage(inttostr((SuprCptGen.Panel2.Controls[i] as TCheckBox).tag));
//                showmessage((SuprCptGen.Panel2.Controls[i] as TCheckBox).Caption);
                TableGeredelete(DataSet);
               end;
             end;
           end;
         end;
    DataSet.BeforeDelete:=DMPlan.TaPlanCptBeforeDelete;
   end;
end;

procedure TSuprCptGen.FormCreate(Sender: TObject);
begin
    try
	LibGestionParamXML.InitialiseForm(E.User,Self);
    except
        Position:=poScreenCenter;
        InitialiseFormPosDefaut(self);
    end;
end;

procedure TSuprCptGen.FormDestroy(Sender: TObject);
begin
 LibGestionParamXML.DestroyForm(Self,E.USer);
 SuprCptGen:=nil;
end;

procedure TSuprCptGen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
panel2.Height:=75;
self.Height:=250;
end;

procedure TSuprCptGen.FormShow(Sender: TObject);
begin
Button1.SetFocus;
end;

procedure TSuprCptGen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then Button2.Click;
end;

end.
