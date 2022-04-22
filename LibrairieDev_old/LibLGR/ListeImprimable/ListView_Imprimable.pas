unit ListView_Imprimable;

interface

uses
  SysUtils
  ,Classes
  ,ComCtrls
  ,PrintDrv
  ,Printers
  ,Forms
//  ,E2_Decl_Records
  ,ObjetEdition
  ,Windows
  ,Lib_Chaine
  ,Dialogs
  ,Graphics
  ,ExtCtrls
  ;


type

  TEtatFiche = record
   WindowState:TWindowState;
   Position:TPosition;
   Height:Integer;
   Top:Integer;
   Left:Integer;
   Width:Integer;
   end;

  TGestionAffichForm = record
   Affich:Boolean;
   Caption:String;
  end;

  TParamAffichage=Record
   EtatFiche:TEtatFiche;
   GestionAffichForm:TGestionAffichForm;
   Titre:String;
   TitrePetit:String;
   AffichModal:Boolean;
   EventButtonValiderClick:TNotifyEvent;
   EventButtonDetailClick:TNotifyEvent;
   EventListViewDbleClick:TNotifyEvent;
  end;

  TParamEdition=record
   Titre:String;
   TitrePetit:String;
   AffichDefaut:boolean;
  end;

  TEnsembleByte = set of Byte;
  TabString=array of string;
  TabInteger=array of integer;
  TabStringList=array of TStringList;
  TabAlignment=Array of TAlignment;




  TListView_Imprimable = class(TListView)
  private
    { Déclarations privées }
  FParamAffichage_Ecran:TParamAffichage;
  FParamEdition:TParamEdition_;
  FTabTitreColonne_Ecran:Tabstring;
  FLargeurCol_Ecran:TabInteger;
  FTabList_Ecran:TabStringList;
  FAlignement_Ecran:TabAlignment;
  FTabStr_Ecran,
  FTAbCurr_Ecran,
  FTabDate_Ecran:TEnsembleByte;

  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }

        Procedure ImprimerListe;
  published
    { Déclarations publiées }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Epicea', [TListView_Imprimable]);
end;


Procedure TListView_Imprimable.ImprimerListe;
var
	x: integer;
//  //Edition
  TimerPrn:TObjetEdition;//The TimerPrn is used for displaying the image at the top of the form
  Prn: TObjetEdition;	// The Prn object is used to print the examples
  imagelogo:Timage;
//  //Edition
begin
//Showmessage('Non implémenté dans cette version !');
//imagelogo:=timage.Create(self);
//imagelogo.Picture.LoadFromFile(e.RepertoireProgram+'Logo.bmp');
////
TimerPrn := TObjetEdition.Create(nil);
  with TimerPrn do
   begin
    AutomaticPaging := false;
    Name := 'TimerPrn';
    PrintPageNumbers := false;
//    Title := 'Test 2';
  end;
///
  Prn := TObjetEdition.Create(nil);
//Prn.EditionListe(ParamAffichage_Ecran,TabTitreColonne_Ecran,LargeurCol_Ecran,
//              TabList_Ecran,Alignement_Ecran,TabStr_Ecran,TAbCurr_Ecran,TabDate_Ecran,imagelogo);

  //si on veut initialiser nous même l'impression (ex: Portrait ou paysage), il faut mettre false dans
  //AffichDefaut
  FParamEdition.AffichDefaut:=false;
  prn.Orientation:=poPortrait;
Prn.EditionListe(FParamEdition,FTabTitreColonne_Ecran,FLargeurCol_Ecran,
              FTabList_Ecran,FAlignement_Ecran,FTabStr_Ecran,FTAbCurr_Ecran,FTabDate_Ecran,nil);
end;

end.
