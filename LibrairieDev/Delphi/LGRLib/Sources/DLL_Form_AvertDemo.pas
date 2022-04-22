unit DLL_Form_AvertDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  //ObjetEdition,
  Dialogs, StdCtrls, ComCtrls;

type
  TAvertDemo = class(TForm)
    REAvertissement: TRichEdit;
    BtnValider: TButton;
    BtnImprimer: TButton;
    BtnAnnuler: TButton;
    procedure BtnValiderClick(Sender: TObject);
    procedure REAvertissementKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    NomDuFichier,Titre2Edition,Titre3Edition:String;
  end;

var
  AvertDemo: TAvertDemo;

implementation

{$R *.dfm}

procedure TAvertDemo.BtnValiderClick(Sender: TObject);
begin
//self.Close;
end;

procedure TAvertDemo.REAvertissementKeyPress(Sender: TObject;
  var Key: Char);
begin
if key = #13 then modalResult := mrCancel;
//self.Close;
end;

procedure TAvertDemo.FormShow(Sender: TObject);
begin
//NomDuFichier:='Demo.rtf';
try
REAvertissement.Lines.LoadFromFile(NomDuFichier);
//REAvertissement.Lines.LoadFromFile(IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName))+NomDuFichier);
except
MessageDlg('Erreur � l''ouverture du fichier !', mtError, [mbOK], 0);
abort;
end;
end;

procedure TAvertDemo.BtnImprimerClick(Sender: TObject);
//var
//ListeLigne:TStringList;
//i:integer;
//ObjEdition:TObjetEdition;
begin
//ListeLigne:=TStringList.Create;
//ListeLigne.Clear;
//ListeLigne.Assign(REAvertissement.Lines);
//ObjEdition:=TObjetEdition.Create(nil);
//for i:=0 to ListeLigne.Count-1 do
//  begin
//   ListeLigne.Strings[i]:='7;'+ListeLigne.Strings[i];
//  end;
////if ListeLigne.Count > 0 then
////    showmessage(IntToStr(ListeLigne.Count));
//ListeLigne.Insert(0,'');
//ListeLigne.Insert(1,'');
//ListeLigne.Insert(2,'');
//
//ObjEdition.Title := Self.Caption;
//ObjEdition.FTitreEdition := Self.Caption;
//ObjEdition.FTitre2Edition :=Titre2Edition;
//ObjEdition.FTitre3Edition := Titre3Edition;
//
//ObjEdition.AffichageImp(ListeLigne);
//ObjEdition.Free;
//ListeLigne.Free;
end;

end.