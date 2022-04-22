unit DMMessagesLGR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  //Dialogs,
  Db, DBTables,LibSQL,Gr_Librairie_Obj,E2_Decl_Records,LibZoneSaisie,E2_LibInfosTable
  ,Lib_Chaine,E2_Librairie_Obj, IBDatabase, IBDatabaseInfo,DialogEx;

type

  TMessageLGR=Class(Tobject)

    private
    FId_Message:integer;
    FEcran:string;
    FComposant:string;
    FCle:string;
    FMessageLGR:String;
    FAfficher:boolean;
    FTitre:string;
    FDivers:string;

  public
    { Déclarations publiques }
    Property Id_Message:integer read Fid_Message write Fid_Message;
    property MessageLGR:String read FMessageLGR write FMessageLGR;
    property Ecran:string read FEcran write FEcran;
    property Composant:string read FComposant write FComposant;
    property Cle:string read FCle write FCle;
    property Afficher:boolean read FAfficher write FAfficher;
    property Titre:string read FTitre write FTitre;
    property Divers:String read FDivers write FDivers;
    constructor Create(AOwner :TComponent);
    destructor Destroy;
  end;




  TDMMessageLGR = class(TDataModule)
    TaMessageLGR: TTable;
    DaMessageLGR: TDataSource;
    procedure TaMessageLGRBeforeDelete(DataSet: TDataSet);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

  end;

var
  DMMessageLGR: TDMMessageLGR;


  Function DM_LitMessageLGR(Ecran,Composant,Cle:string):TMessageLGR;
  Function DM_EcritMessageLGR(MessageLGR:TMessageLGR):TMessageLGR;
function initMessageLGR(Ecran:Tcomponent;Composant,Cle,message_,titre_:string;
         DlgBtn_:TMsgDlgButtonsEx;DefaultBtn_:TMsgDlgBtnEx; var MessageLGR:TMessageLGR):TMsgDlgParams;

implementation



//   *****  Creation objet TDMMessageLGR   *****  ///////////
constructor TMessageLGR.Create(AOwner :TComponent);
Begin
inherited create;
FId_Message:=-1;
FMessageLGR:='';
FEcran:='';
FComposant:='';
FCle:='';
FTitre:='';
FDivers:='';
FAfficher:=true;
End;

destructor TMessageLGR.Destroy;
Begin
inherited Destroy;
End;

//   *****  FIN objet TMessageLGR   *****  ///////////


Function DM_LitMessageLGR(Ecran,Composant,Cle:string):TMessageLGR;
Begin
  try//finally
    try
    result:=nil;
     if (DMMessageLGR = nil) then DMMessageLGR:=TDMMessageLGR.Create(Application.MainForm);
     if composant ='' then
       FiltrageDataSet(DMMessageLGR.TaMessageLGR,'Ecran = '''+Ecran+''' and Composant is null  and Cle ='''+Cle+'''')
     else
       FiltrageDataSet(DMMessageLGR.TaMessageLGR,'Ecran = '''+Ecran+''' and Composant ='''+Composant+'''  and Cle ='''+Cle+'''');
     DMMessageLGR.TaMessageLGR.First;
     if DMMessageLGR.TaMessageLGR.RecordCount>0 then
       begin
           result:=TMessageLGR.Create(application.MainForm);
           result.MessageLGR:=DMMessageLGR.TaMessageLGR.findfield('MessageLGR').AsString;
           result.Titre:=DMMessageLGR.TaMessageLGR.findfield('Titre').AsString;
           result.Afficher:=DMMessageLGR.TaMessageLGR.findfield('Afficher').AsBoolean;
           result.Divers:=DMMessageLGR.TaMessageLGR.findfield('Divers').AsString;
           result.Id_Message:=DMMessageLGR.TaMessageLGR.findfield('Id_Message').AsInteger;
       end;
    except
     MessageDlgEx('Erreur à la récupération du message : '+Ecran+'_'+composant+'_'+cle,mtError,[mbOK],0);
     result:=nil;
     raise;
    end;
  finally
    DeFiltrageDataSet(DMMessageLGR.TaMessageLGR);
  end;
End;
{$R *.dfm}

Function DM_EcritMessageLGR(MessageLGR:TMessageLGR):TMessageLGR;
var requete:Tquery;
Begin
  try//finally
    try
     if (DMMessageLGR = nil) then DMMessageLGR:=TDMMessageLGR.Create(Application.MainForm);
     FiltrageDataSet(DMMessageLGR.TaMessageLGR,'id_message = '+inttostr(MessageLGR.Id_Message));
     DMMessageLGR.TaMessageLGR.First;
     if DMMessageLGR.TaMessageLGR.RecordCount>0 then
       begin
          TableGereEdit(DMMessageLGR.TaMessageLGR);
//          DMMessageLGR.TaMessageLGR.FindField('id_Message').Asinteger:=MessageLGR.Id_Message;
//          DMMessageLGR.TaMessageLGR.FindField('MessageLGR').AsString:=MessageLGR.MessageLGR;
//          DMMessageLGR.TaMessageLGR.FindField('Ecran').AsString:=MessageLGR.Ecran;
//          DMMessageLGR.TaMessageLGR.FindField('Composant').AsString:=MessageLGR.Composant;
//          DMMessageLGR.TaMessageLGR.FindField('Cle').AsString:=MessageLGR.cle;
          DMMessageLGR.TaMessageLGR.FindField('Afficher').AsBoolean:=MessageLGR.Afficher;
//          DMMessageLGR.TaMessageLGR.FindField('Titre').AsString:=MessageLGR.titre;
//          DMMessageLGR.TaMessageLGR.FindField('Divers').AsString:=MessageLGR.Divers;
          TableGerePost(DMMessageLGR.TaMessageLGR);
       end
     else
       begin
          TableGereInsert(DMMessageLGR.TaMessageLGR);
          requete:=TQuery.Create(application.MainForm);
          requete.DatabaseName:=DMMessageLGR.TaMessageLGR.DatabaseName;
          requete.SQL.Add('select (max(id_message))as maxid  from messageLGR.db');
          requete.open;
          MessageLGR.Id_Message:=requete.FindField('maxid').AsInteger+1;
          DMMessageLGR.TaMessageLGR.FindField('id_Message').Asinteger:=MessageLGR.Id_Message;
          DMMessageLGR.TaMessageLGR.FindField('MessageLGR').AsString:=MessageLGR.MessageLGR;
          DMMessageLGR.TaMessageLGR.FindField('Ecran').AsString:=MessageLGR.Ecran;
          DMMessageLGR.TaMessageLGR.FindField('Composant').AsString:=MessageLGR.Composant;
          DMMessageLGR.TaMessageLGR.FindField('Cle').AsString:=MessageLGR.cle;
          DMMessageLGR.TaMessageLGR.FindField('Afficher').AsBoolean:=MessageLGR.Afficher;
          DMMessageLGR.TaMessageLGR.FindField('Titre').AsString:=MessageLGR.titre;
          DMMessageLGR.TaMessageLGR.FindField('Divers').AsString:=MessageLGR.Divers;
          TableGerePost(DMMessageLGR.TaMessageLGR);
          TableGereCommit(DMMessageLGR.TaMessageLGR);
          requete.Close();
          FreeAndNil(requete);
       end
    except
     MessageDlgEx('Erreur à la modification du message ',mtError,[mbOK],0);
     abort;
    end;
  finally
    DeFiltrageDataSet(DMMessageLGR.TaMessageLGR);
  end;
End;



procedure TDMMessageLGR.TaMessageLGRBeforeDelete(DataSet: TDataSet);
begin
if Application.MessageBox(Pchar('Etes-vous sûr de vouloir supprimer le message en cours'),'Attention',MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mrno then
  abort;
end;



function initMessageLGR(Ecran:Tcomponent;Composant,Cle,message_,titre_:string;
         DlgBtn_:TMsgDlgButtonsEx;DefaultBtn_:TMsgDlgBtnEx; var MessageLGR:TMessageLGR):TMsgDlgParams;
var
 db : TMsgDlgParams;
//  MessageLGR:TMessageLGR;
  AfficherCheck:boolean;
begin
   InitMsgDlgParams(db);
   AfficherCheck:=true;
   MessageLGR:=nil;
    try
    MessageLGR:=DM_LitMessageLGR(Ecran.name,Composant,Cle);
    except
    AfficherCheck:=false;
    end;
    if MessageLGR=nil then
      begin //création du message
         MessageLGR:=TMessageLGR.Create(Ecran);
         MessageLGR.MessageLGR:=message_;
         MessageLGR.Ecran:=Ecran.Name;
         MessageLGR.Composant:=Composant;
         MessageLGR.Cle:=Cle;
         MessageLGR.Titre:=titre_;
         try
         if AfficherCheck then DM_EcritMessageLGR(MessageLGR);
         except
         AfficherCheck:=false;
         end;
      end;
   With db Do
   Begin
    CheckBox        := AfficherCheck;
    lpszText        := Pansichar(MessageLGR.MessageLGR);
    lpszCaption     := Pansichar(MessageLGR.Titre);
    DlgBtn          := DlgBtn_;
    DefaultBtn      := DefaultBtn_;
//    CustBtnText[mbCust1] := 'Continuer';
//    //CustBtnText[mbCust2] := 'Modifier paramètres';
   End;
 result:=db;
end;
end.
