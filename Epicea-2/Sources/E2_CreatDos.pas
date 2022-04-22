{***************************************************************
 *
 * Unit Name: E2_CreatDos
 * Purpose  :
 * Author   : BP
 * History  :
 *
 ****************************************************************}
unit E2_CreatDos;

interface

uses
{  sharemem,}Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, Grids, Outline, DirOutln,  ComCtrls, Menus,Db,
  DBTables, ExtCtrls, DBGrids, RXCtrls,Gr_Librairie_obj, Mask, ToolEdit,E2_Librairie_Obj,LibFichRep
  ,DMProgramme,CreationPlanAGri,ScruteFichiers,Lib_chaine,LibSQL,DMConstantes,LibZoneSaisie,LibRessourceString,
  ImgList,
  LibGestionParamXML,
  FileUtil,
  jpeg;

type
  TCreatDos = class(TForm)
    PopupMenu1: TPopupMenu;
    Crerunrpertoire1: TMenuItem;
    ImageList1: TImageList;
    GestDos: TTable;
    Panel2: TPanel;
    Label2: TLabel;
    RxLabel1: TRxLabel;
    Label6: TLabel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaLecteurs: TPanel;
    RGDDur: TRadioGroup;
    PaCreat: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    PaInfoDos: TPanel;
    MemoInfDof: TRichEdit;
    Panel1: TPanel;
    TreeView1: TTreeView;
    RxLabel2: TRxLabel;
    PaTitreLecteur: TPanel;
    RGLectRes: TRadioGroup;
    PaTitreRep: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    RxSBGraphe: TRxSpeedButton;
    RxSBRepDefaut: TRxSpeedButton;
    PaLegende: TPanel;
    Label5: TLabel;
    Image1: TImage;
    Image4: TImage;
    Label7: TLabel;
    Label1: TLabel;
    Image3: TImage;
    PaTVRep: TPanel;
    TreeView2: TTreeView;
    RxSBAutreRep: TRxSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure RGDDurClick(Sender: TObject);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeView1Collapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Crerunrpertoire1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function StrContains(Str1, Str2: string): Boolean;
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RxLabel1Click(Sender: TObject);
    procedure RxLabel1MouseEnter(Sender: TObject);
    procedure RxLabel1MouseLeave(Sender: TObject);
    procedure RGLectResClick(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure RxSBRepDefautClick(Sender: TObject);
    procedure TreeView2Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure TreeView2Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxSBAutreRepClick(Sender: TObject);
  private
    { Déclarations privées }
  Bimap:TBitmap;
  Function Chemin(Node:TTreeNode):String;
  Function CheminTreeView(Node:TTreeNode):String;

  public
    { Déclarations publiques }
   LecteurEnCours:string;
  end;

Const
//  CreTable = 'CreTable.dll';
  InvalidDOSChars = ' -\*?/="<>|:,;+^.';
var
  CreatDos: TCreatDos;
//  Chemin:string;
  OldIdDos:Integer;
  NodeCourantEx:TTreeNode;
  ListeRepDossier,ListeRepExo:TStringList;

Procedure RempliTreeView(Nom:String;objet:Tobject);
//Function CreLesTables(Table: string; BaseSource:Ttable ;Chemin: string;ExerciceOuDossier:Char):integer ;stdcall;external CreTable ;
//Function PlanAux(TablePlanCpt:string;Chemin:string;PlanAuxOuiNon:char):integer;stdcall;external CreTable ;
//Function CreTablePlanComptable(Table:string;Chemin:string;TypePlanCpt:char):integer;stdcall;external CreTable ;
//Procedure CreationDossier;stdcall;external CreTable ;
//
//procedure MessageGost(Textetitre:string;Textemess:string ;Valeur:integer);stdcall;external CreTable ;

implementation
{$R *.DFM}
uses Gr_MultDos, E2_ParamEnt, DMRecherche, E2_Main, DiversProjets;

Procedure RempliTreeView(Nom:String;objet:Tobject);
var
NodeCourant:TTreenode;
NomChemin:string;
begin
  NomChemin:=Nom;
  Nom:=str_Suppr_N_Car_AGauche(Nom,LastDelimiter('\',Nom));
  NodeCourant:=CreatDos.TreeView2.Items.Addchild(NodeCourantEx,Nom);
  NodeCourant.ImageIndex:=0;
  NodeCourant.SelectedIndex:=2;
  CreatDos.TreeView2.Items.AddChild(NodeCourant,'');
  // Gestion de l'icone Dossier
  if ListeRepDossier.IndexOf(NomChemin) <> -1 then
   begin
    NodeCourant.ImageIndex:=3;
    NodeCourant.SelectedIndex:=3;
   end;
   // Gestion de l'icone Exercice
  if ListeRepExo.IndexOf(NomChemin) <> -1 then
   begin
    NodeCourant.ImageIndex:=5;
    NodeCourant.SelectedIndex:=5;
   end;
  // Gestion de l'icone Programme
  if str_commence_par(UpperCase(E.RepertoireProgram),UpperCase(NomChemin)) then
   begin
    NodeCourant.ImageIndex:=6;
    NodeCourant.SelectedIndex:=4;
   end;
//  ListeRepDossier:=ChampTableVersListe('Dir_Dossier',DMRech.TaGestDossierRech);
//  ListeRepExo:=ChampTableVersListe('Dir_Exo',DMRech.TaGestDossierRech);

end;

procedure TCreatDos.FormShow(Sender: TObject);
begin
  Left:=(Screen.Width div 2)-(Width div 2);
  Top:=(Screen.Height div 2)-(Height div 2);

  if self.tag = 1 then
    begin
    self.Caption := 'Première utilisation : Création de votre dossier et de votre premier exercice !';
    end;
  if not gestDos.Active then gestDos.open;
  RGDDur.Items.Clear;
  RGDDur.Items:=ListTypeLecteur(DRIVE_FIXED);
  RGDDur.Height:=40 + RGDDur.Items.Count * 12;
  RGLectRes.Items.Clear;
  RGLectRes.Items:=ListTypeLecteur(DRIVE_REMOTE);
  RGLectRes.Visible:=not (RGLectRes.Items.Count=0);
  RGLectRes.Top:=RGDDur.Top+RGDDur.Height+20;
  RGLectRes.Height:=40 + RGLectRes.Items.Count * 12;
  if RGDDur.Items.Count > 1 then RGDDur.Caption:= 'Disques Dur'
   else RGDDur.Caption:= 'Disque Dur';
  RGDDur.itemIndex:=0;
  RxSBRepDefaut.Click;
  Edit1.SetFocus;
end;

procedure TCreatDos.RGDDurClick(Sender: TObject);
var
Noeud,Pere:TTreenode;
i:integer;
aux:string;
begin
   RGLectRes.ItemIndex:=-1;
   RGDDur.Cursor:=crHourGlass;
   TreeView1.Items.Clear;
//   Chemin:=RGDDur.items[RGDDur.itemIndex];
   LecteurEnCours:=RGDDur.items[RGDDur.itemIndex];
   Chemin(nil);
   NodeCourantEx:=nil;
   CreatDos.TreeView2.Items.Clear;
   ScruteDossier(RGDDur.items[RGDDur.itemIndex],'*',FaDirectory,false);
   CreatDos.TreeView2.AlphaSort;

//     Pere:=Treeview1.Items.Add(Noeud,RGDDur.items[RGDDur.itemIndex]);
//
//     Noeud:=TreeView1.Items.AddChild(Pere,'');
//     Pere.Expand(false);
////     TreeView1.Items.Delete(Noeud);
//
//     TreeView1.Visible:=true;
     RGDDur.Cursor:=crDefault;
end;

procedure TCreatDos.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
var
Lect:TWin32FindData;
Noeud,Pere,Tmp:TTreenode;
i:LongInt;
aux,CheminDos:string;
begin

//if not gestDos.Active then gestDos.open;
//
////TreeView1.Cursor:=crHourGlass;
//Noeud:=node;
//Tmp:=node.GetFirstChild;
//Chemin:='';
//while Noeud.Level>0 do begin
//	Chemin:=Noeud.Text+'\'+Chemin;
//   Noeud:=Noeud.Parent;
//end;
//Chemin:=LecteurEnCours + chemin;
//CheminDos:=Chemin;
//delete(cheminDos,length(cheminDos),1);
//  if GestDos.Locate('Nom_Dossier;Dir_Dossier',VarArrayOf([node.Text,cheminDos]),[loCaseInsensitive]) then
//  begin
////    AllowExpansion:=false;
////    beep;
//    Noeud:=node.Parent;
//    Chemin:='';
//    while Noeud.Level>0 do
//          begin
//          Chemin:=Noeud.Text+'\'+Chemin;
//          Noeud:=Noeud.Parent;
//          end;
//    Chemin:=LecteurEnCours + chemin;
//  end;
//// else
//  if GestDos.Locate('Nom_Exo;Dir_Exo',VarArrayOf([node.Text,cheminDos]),[loCaseInsensitive]) then
//  begin
//    AllowExpansion:=false;
//    beep;
//    Noeud:=node.Parent;
//    Chemin:='';
//    while Noeud.Level>0 do
//          begin
//          Chemin:=Noeud.Text+'\'+Chemin;
//          Noeud:=Noeud.Parent;
//          end;
//    Chemin:=LecteurEnCours + chemin;
//  end;
//// else
////  begin
////      if node.SelectedIndex <> 2 then node.SelectedIndex:=4;
//      node.ImageIndex:=0;
//      node.SelectedIndex:=2;
//      if pos(uppercase(copy(Chemin+node.Text,4,length(Chemin+node.Text))),uppercase(copy(E.RepertoireProgram,4,length(E.RepertoireProgram))))>0 then
//      begin
//      node.imageIndex:=6;
//      node.SelectedIndex:=4;
//      end;
//      If Tmp.Text='' then
//      begin
//         node.DeleteChildren;
//         i:=FindFirstFile(PChar(Chemin+'*'),Lect);
//	      while FindnextFile(i,Lect) do
//               begin
//     	         if Lect.dwFileAttributes=FILE_ATTRIBUTE_DIRECTORY then
//                  begin
//     	           if Lect.cFileName <> '..' then
//                    begin
//                     pere:=TreeView1.Items.AddChild(Node,Lect.cFileName);
//                     if GestDos.Locate('Nom_Dossier;Dir_Dossier',VarArrayOf([pere.Text,chemin+pere.Text]),[loCaseInsensitive]) then
//     	               begin
//     			Pere.ImageIndex:=3;
//                        Pere.SelectedIndex:=3;
//                       end;
//                     if GestDos.Locate('Nom_Exo;Dir_Exo',VarArrayOf([pere.Text,chemin+pere.Text]),[loCaseInsensitive]) then
//     	               begin
//     			Pere.ImageIndex:=5;
//                        Pere.SelectedIndex:=5;
//                       end;
////                             showmessage(copy(Chemin+pere.Text,4,length(Chemin+pere.Text)));
////                             showmessage(copy(ExtractFilePath(Application.ExeName),4,length(ExtractFilePath(Application.ExeName))));
//                        tmp:=TreeView1.Items.AddChild(Pere,'');
//                             if pos(uppercase(copy(Chemin+pere.Text,4,length(Chemin+pere.Text))),uppercase(copy(E.RepertoireProgram,4,length(E.RepertoireProgram))))>0 then
//                             begin
////                             showmessage(copy(Chemin+pere.Text,4,length(Chemin+pere.Text)));
//                             pere.ImageIndex:=6;
//                             pere.SelectedIndex:=4;
//                             end;
//                        TreeView1.Invalidate;
//         	    end;
//                  end;
//         end;
//         TreeView1.AlphaSort;
//      end;
////  end;
//Node.Selected:=true;
//TreeView1.Cursor:=crDefault;
end;

procedure TCreatDos.TreeView1Changing(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
var
CheminRep:string;
NodeAux:TTreeNode;
begin
//CheminRep:='';
//NodeAux:=Node;
//while NodeAux.Level > 0 do begin
//   CheminRep:=NodeAux.Text+'\'+CheminRep;
//   NodeAux:=NodeAux.Parent;
//   end;
//CheminRep:=LecteurEnCours + CheminRep;
//delete(CheminRep,length(cheminRep),1);
////if GestDos.Locate('Nom_Dossier',Noeud.Text,[loCaseInsensitive]) then
//if not gestDos.Active then gestDos.open;
////if not GestDos.Locate('Nom_Dossier',node.Text,[loCaseInsensitive]) then
//if not GestDos.Locate('Dir_Dossier',CheminRep,[loCaseInsensitive]) then
//		begin
//		Chemin:='';
//		while Node.Level>0 do begin
//		Chemin:=Node.Text+'\'+Chemin;
//   		Node:=Node.Parent;
//		end;
//		Chemin:=LecteurEnCours + chemin;
//		Label2.Caption:=Chemin;
//                Label2.Hint:=Chemin;
//end else AllowChange:=false;
end;

procedure TCreatDos.TreeView1Collapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
node.SelectedIndex:=0;
end;

procedure TCreatDos.Button1Click(Sender: TObject);
var
Tmp:TTreeNode;
aux,CreationOK:boolean;
IDTable,IDExo,NewIDDossier:integer;
DateCreation:TDateTime;
IdDosExo:string;
Nomdos:string;
nomexo:string;
ETmp:TEntreprise;
begin
  if MessageDlg('Vous Êtes sur le point de créer :'+
                 #13+#10+''+#13+#10+
                 'le DOSSIER : '+
                 Edit1.text+
                 #13+#10+''+#13+#10+
                 'l''EXERCICE : '+
                 Edit2.text+
                 #13+#10+''+#13+#10+
                 'dans le répertoire :'+
                 #13+#10+''+#13+#10+
                 Chemin(TreeView2.Selected)
                 ,mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
      try
        Button1.Cursor:=crHourGlass;
        DMProg.TaGestDosModif.Insert;
        InitChampAfterInsert([nil,1,Edit1.text,Chemin(TreeView2.Selected) + '\' + Edit1.text,Edit2.text,
                              Chemin(TreeView2.Selected) + '\' + Edit1.text+'\'+Edit2.text,DAte,Now,False],DMProg.TaGestDosModif);
        TableGerePost(DMProg.TaGestDosModif);
        // Ici, mettre la description de l'entrise, mais pour l'instant ça marche pas !!!!!!!!
        // Debut desc entreprise
      //  if Application.MessageBox('Voulez-vous faire la description de l''entreprise maintenant?','Création Dossier + Exercice',4)=IDYES then
      //     begin
      //     if (ParamEnt = nil) then ParamEnt:=TParamEnt.Create(Application);
      //         begin
      //        ETmp:=TEntreprise.Create(nil);
      //        ETmp:= E;
      //        E.InitTEntreprise(E);
      //        ParamEnt.Label1.Caption:=Edit1.text;
      //        ParamEnt.Tag:=1;
      //        ParamEnt.DirNewDos:=Chemin + '\'  + Edit1.text;
      //        ParamEnt.showModal;
      //        E:= ETmp;
      //        ETmp.Free;
      //        end;
      //     end;
        // Fin desc entreprise
        Edit1.text:='';
        Edit2.text:='';
        Button1.Enabled:=false;
        Button1.Cursor:=crDefault;
        GestDos.Refresh;
        DeFiltrageDataSet(DMRech.TaGestDossierRech);
        ListeRepDossier:=ChampTableVersListe('Dir_Dossier',DMRech.TaGestDossierRech);
        ListeRepDossier.Add(E.RepertoireProgram+'Demo');
        ListeRepExo:=ChampTableVersListe('Dir_Exo',DMRech.TaGestDossierRech);
        ListeRepExo.Add(E.RepertoireProgram+'Demo\ExoDemo');
        Showmessage('Fin de la création de votre dossier !');
      except
        Edit1.SetFocus;
        Button1.Cursor:=crDefault;;
        GestDos.Refresh;
        DeFiltrageDataSet(DMRech.TaGestDossierRech);
        ListeRepDossier:=ChampTableVersListe('Dir_Dossier',DMRech.TaGestDossierRech);
        ListeRepDossier.Add(E.RepertoireProgram+'Demo');
        ListeRepExo:=ChampTableVersListe('Dir_Exo',DMRech.TaGestDossierRech);
        ListeRepExo.Add(E.RepertoireProgram+'Demo\ExoDemo');
      end;
  end;
  // Ancien traitement de création dossier + exo
// A conserver jusqu'a nouveau triatement ok !!!
{if not empty(Edit1.text) then
 begin
  if DossierExiste(Edit1.text,chemin + '\' + Edit1.text) then
   begin
     Application.MessageBox('Ce dossier existe déjà','Attention',MB_OK+MB_ICONSTOP);
   end
   else
   begin
    if not empty(Edit2.text) then
     begin
      if ExoExiste(Edit2.text,Chemin + '\' + Edit1.text+'\'+Edit2.text) then
       begin
         Application.MessageBox('Cet exercice existe déjà dans un autre dossier','Attention',MB_OK+MB_ICONSTOP);
       end
       else
       begin  // Ni le dossier, ni l'exercice existe dans la table GestDossier, donc on les créés
         //if Edit2.text ='' then IDTable:=0 else IDTable:=1;
         IDTable:=1;
         CreationOK:=false;
          if CreeNouveauDossier(Chemin + '\' + Edit1.text,true) then
                       CreationOK:=CreeNouveauExo(Chemin + '\' + Edit1.text+'\'+Edit2.text,true);
               if CreationOK then
               begin
                try
                DMProg.taGestDossierConsult.IndexName:='';
                DMProg.TaGestDossierConsult.Last;
                NewIDDossier:=DMProg.TaGestDossierConsult.FindField('ID_Dossier').asInteger+1;
                DateCreation:=now;//StrToDateTime('01/01/1980 00:00:00');
                DMProg.TaGestDossierConsult.AppendRecord([NewIDDossier,IDTable,Edit1.text,Chemin + '\'  + Edit1.text,Edit2.text,Chemin + '\'  + Edit1.text+'\'+Edit2.text,Null,DateCreation,False]);
                DMProg.TaGestDossierConsult.FlushBuffers;
//                IdDosExo:=IntToStr(NewIDDossier)+IntTostr(IDTable);
//                NomDos:=Edit1.text;
//                NomExo:=Edit2.text;
                DMProg.TaGestDossierConsult.refresh;
//      //          MaJDateDossier(Edit1.text);
//                Tmp:=TreeView1.Selected;
//                Tmp.DeleteChildren;
//                TreeView1.Items.AddChild(Tmp,'');
//                Tmp.Expand(false);
//        //                       Menu.Items[0].delete(0);
//      //                         Menu.Items[0].Insert(0,NewItem('',0,false,true,nil,0,'DosCourant'));
//      //			 Menu.Items[0].Delete(Menu.Items[0].Count-1);
//      //			 Menu.Items[0].Delete(Main.Menu.Items[0].Count-1);
//      //			 AjoutMenu(true);
//      ////
//               CreateTablePlanAgri(Chemin + Edit1.text);
               if Application.MessageBox('Voulez-vous faire la description de l''entreprise maintenant?','Création Dossier + Exercice',4)=IDYES then
                  begin
                  if (ParamEnt = nil) then ParamEnt:=TParamEnt.Create(self);
                      begin
                     ParamEnt.Label1.Caption:=Edit1.text;
                     ParamEnt.Tag:=1;
                     ParamEnt.DirNewDos:=Chemin + '\'  + Edit1.text;
                     ParamEnt.showModal;
                     end;
                  end
               else
                       exit;
                except
                  Application.MessageBox('Erreur à la création','Attention',MB_OK+MB_ICONSTOP);
//                  RemoveDir(Chemin + Edit1.text+'\'+Edit2.text);
//                  RemoveDir(Chemin + Edit1.text);
                end;
              end
              else // Creation non Ok
              begin
                  Application.MessageBox('Erreur à la création','Attention',MB_OK+MB_ICONSTOP);
//                  RemoveDir(Chemin + Edit1.text+'\'+Edit2.text);
//                  RemoveDir(Chemin + Edit1.text);
              end;

       end;//
      end
      else
      begin
       // Ici prevu le traitement pour import de dossier, car nom d'exercice est vide !!!!!!
        CreationOK:=CreeNouveauDossier(Chemin  + '\' + Edit1.text,true);
      end;
   end;
 end
 else
 Begin
   Application.MessageBox('Le nom du dossier n''est pas correct','Attention',MB_OK+MB_ICONSTOP);
 End;}

//if Edit1.text<>'' then
//begin
//  with GestDos do
//  begin
//  if not active then open;
//  if ((not locate('Nom_Dossier',Edit1.text,[loCaseInsensitive])) and
//      	(not locate('Dir_Dossier',Chemin + Edit1.text,[loCaseInsensitive]))) then
//         begin
//	   if Edit2.text ='' then IDTable:=0 else IDTable:=1;
//             CreationOK:=false;
//          case IDTable of
//               0:CreationOK:=CreeNouveauDossier(Chemin + Edit1.text);
//               1:if CreeNouveauDossier(Chemin + Edit1.text) then
//                 CreationOK:=CreeNouveauExo(Chemin + Edit1.text+'\'+Edit2.text);
//         end;
//         if CreationOK then begin
//          try
//          Last;
//      	  NewIDDossier:=FindField('ID_Dossier').asInteger+1;
//          DateCreation:=StrToDateTime('01/01/1980 00:00:00');
//      	  AppendRecord([NewIDDossier,IDTable,Edit1.text,Chemin + Edit1.text,Edit2.text,Chemin + Edit1.text+'\'+Edit2.text,Null,DateCreation]);
//          FlushBuffers;
//          IdDosExo:=IntToStr(NewIDDossier)+IntTostr(IDTable);
//          NomDos:=Edit1.text;
//          NomExo:=Edit2.text;
//      	 refresh;
////          MaJDateDossier(Edit1.text);
//       	 Tmp:=TreeView1.Selected;
//       	 Tmp.DeleteChildren;
//       	 TreeView1.Items.AddChild(Tmp,'');
//       	 Tmp.Expand(false);
//  //                       Menu.Items[0].delete(0);
////                         Menu.Items[0].Insert(0,NewItem('',0,false,true,nil,0,'DosCourant'));
////			 Menu.Items[0].Delete(Menu.Items[0].Count-1);
////			 Menu.Items[0].Delete(Main.Menu.Items[0].Count-1);
////			 AjoutMenu(true);
//////
//         if Application.MessageBox('Voulez-vous faire la description de l''entreprise maintenant?','Création Dossier + Exercice',4)=IDYES then
//            begin
//            if (ParamEnt = nil) then ParamEnt:=TParamEnt.Create(self);
//                begin
//               ParamEnt.Label1.Caption:=Edit1.text;
//               ParamEnt.Tag:=1;
//               ParamEnt.DirNewDos:=Chemin + Edit1.text;
//               ParamEnt.showModal;
//               end;
//            end
//         else
//                 exit;
//          except
//            Application.MessageBox('Erreur à la création','Attention',MB_OK+MB_ICONSTOP);
//            RemoveDir(Chemin + Edit1.text+'\'+Edit2.text);
//            RemoveDir(Chemin + Edit1.text);
//          end;
//         end else
//             Application.MessageBox('Erreur à la création','Attention',MB_OK+MB_ICONSTOP);
//         end else
//	     Application.MessageBox('Ce dossier existe déjà','Attention',MB_OK+MB_ICONSTOP);
//         end;
//   end
//   else Edit1.SetFocus;
end;

//******************* TCreatDos.TreeView1MouseMove *************************
procedure TCreatDos.TreeView1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
Noeud,NodeAux:TTreeNode;
C:TPoint;
rec:TRect;
Aide : THintWindow;
CheminRep:string;
i:integer;
begin

Noeud:=(sender as TTreeView).GetNodeAt(X,Y);
if Noeud <> nil then
 begin
i:=0;
NodeAux:=Noeud;
CheminRep:=NodeAux.Text;
while NodeAux.Parent <> nil do
 begin
   NodeAux:=NodeAux.Parent;
   CheminRep:=NodeAux.Text+'\'+CheminRep;
 end;
CheminRep:=LecteurEnCours + cheminRep;

//CheminRep:='';
//   while NodeAux.Level > 0 do begin
//   CheminRep:=NodeAux.Text+'\'+CheminRep;
//   NodeAux:=NodeAux.Parent;
//   end;

//CheminRep:=LecteurEnCours + CheminRep;
//delete(CheminRep,length(cheminRep),1);
if GestDos.Locate('Dir_Dossier',CheminRep,[loCaseInsensitive]) then
 begin
   if OldIdDos<>GestDos.FieldByName('ID_Dossier').AsInteger then
	begin
         MemoInfDof.Clear;
         MemoInfDof.Lines.Add('Dossier Comptable : ' +
                              RetourChariotDouble +
                              Noeud.text +
                              RetourChariotSimple +
                              'Dernière utilisation le : '+
                              RetourChariotSimple +
                              DateToStr(GestDos.FieldByName('DateUtil').asdateTime)+
                              ' à '+
                              TimeToStr(GestDos.FieldByName('DateUtil').asdateTime));
         OldIdDos:=GestDos.FieldByName('ID_Dossier').AsInteger;
         MemoInfDof.SelStart:=0;
         MemoInfDof.SelLength:=19;
         MemoInfDof.SelAttributes.Color:=clRed;
         MemoInfDof.SelAttributes.Style:=[fsbold,fsunderline];
         MemoInfDof.SelLength:=0;
         MemoInfDof.SelAttributes.Color:=clWindowText;
         MemoInfDof.SelAttributes.Style:=[];
       end;
   end
    else
   if GestDos.Locate('Dir_Exo',CheminRep,[loCaseInsensitive]) then
    begin
            MemoInfDof.Clear;
            MemoInfDof.Lines.Add('Dossier Comptable : ' +
                                  #13#10#13#10 +
                                  GestDos.FieldByName('Nom_Dossier').AsString +
                                  #13#10 +
                                  'Dernière utilisation le : '+
                                  #13#10 +
                                  DateToStr(GestDos.FieldByName('DateUtil').asdateTime)+
                                  ' à '+
                                  TimeToStr(GestDos.FieldByName('DateUtil').asdateTime)+
                                  #13#10 +
                                  'Cloturé ? : '+
                                  str_bool2str_LGR(GestDos.FieldByName('Cloture').AsBoolean,'Oui','Non'));
            MemoInfDof.Lines.Add('');
            MemoInfDof.Lines.Add('Exercice : '+ Noeud.text);
            MemoInfDof.SelStart:=0;
            MemoInfDof.SelLength:=19;
            MemoInfDof.SelAttributes.Color:=clRed;
            MemoInfDof.SelAttributes.Style:=[fsbold,fsunderline];
            MemoInfDof.SelLength:=0;
            MemoInfDof.SelAttributes.Color:=clWindowText;
            MemoInfDof.SelAttributes.Style:=[];
      end
       else
   begin
   MemoInfDof.Clear;
   CheminRep:='';

   NodeAux:=Noeud;
   CheminRep:=NodeAux.Text;
   while NodeAux.Parent <> nil do
    begin
      NodeAux:=NodeAux.Parent;
      CheminRep:=NodeAux.Text+'\'+CheminRep;
    end;
//   Chemin:=LecteurEnCours + chemin;

//   while Noeud.Level > 0 do begin
//   CheminRep:=Noeud.Text+'\'+CheminRep;
//   Noeud:=Noeud.Parent;
//   end;
   CheminRep:=LecteurEnCours + CheminRep;
   MemoInfDof.Lines.Add('Répertoire : ' + Noeud.Text);
  if ListeRepDossier.IndexOf(CheminRep) <> -1 then
   begin
         MemoInfDof.Clear;
         MemoInfDof.Lines.Add('Dossier Comptable : ' + #13#10 + Noeud.text);
         MemoInfDof.SelStart:=0;
         MemoInfDof.SelLength:=19;
         MemoInfDof.SelAttributes.Color:=clRed;
         MemoInfDof.SelAttributes.Style:=[fsbold,fsunderline];
         MemoInfDof.SelLength:=0;
         MemoInfDof.SelAttributes.Color:=clWindowText;
         MemoInfDof.SelAttributes.Style:=[];
   end;
   // Gestion de l'icone Exercice
  if ListeRepExo.IndexOf(CheminRep) <> -1 then
   begin
         MemoInfDof.Clear;
         MemoInfDof.Lines.Add('Dossier Comptable : ' + #13#10 + 'Demo' + #13#10 + 'Exercice : '+ #13#10+ Noeud.text);
         MemoInfDof.SelStart:=0;
         MemoInfDof.SelLength:=19;
         MemoInfDof.SelAttributes.Color:=clRed;
         MemoInfDof.SelAttributes.Style:=[fsbold,fsunderline];
         MemoInfDof.SelLength:=0;
         MemoInfDof.SelAttributes.Color:=clWindowText;
         MemoInfDof.SelAttributes.Style:=[];
   end;
//   repeat
//     MemoInfDof.Lines.Add(StringOfChar(' ', i*5)+copy(CheminRep,1,pos('\',CheminRep)));
//     delete(CheminRep,1,pos('\',CheminRep));
//     inc(i);
//   until length(CheminRep)<=0;
   OldIdDos:=-1;
   end;
  end;
end;

procedure TCreatDos.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in [#8,#48..#57,#65..#90,#97..#122]) then
 Begin
   Key:=#0;
   abort;
 End;
if ((Length(Edit1.Text) = Edit1.MaxLength) and (key <> #8)) then
 showmessage('Le nom des Dossiers ou d''Exercices ne peuvent dépasser 10 caractères !');
// if  (StrContains(InvalidDosChars, Key)) then Key:=#0;
// if (sender as TEdit).SelStart = 0 then  Key:=UpCase(Key);
end;

procedure TCreatDos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//DetruitBulle(self);
 Main.Menu.Items[0].delete(0);
 Main.Menu.Items[0].Insert(0,NewItem('Nouveau Dossier ...',0,false,true,Main.CreationNewDossierClick,0,'DosCourant'));
 AjoutMenu(Main.Multidossier);

gestDos.close;
end;

procedure TCreatDos.Crerunrpertoire1Click(Sender: TObject);
var
TmpNode:TTreeNode;
begin
     TreeView1.ReadOnly:=false;
     TmpNode:=TreeView1.Selected;
     TmpNode:=TreeView1.Items.AddChild(TmpNode,'');
     TmpNode.Selected:=true;
     TmpNode.EditText;
end;

procedure TCreatDos.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.destroyForm(CreatDos,E.USer);
ListeRepDossier.Free;
ListeRepExo.Free;
CreatDos:=Nil;
end;

//******************* StrContains *************************
function TCreatDos.StrContains(Str1, Str2: string): Boolean;
var
  i: Integer;
begin
  for i := 1 to Length(Str1) do
    if Pos(Str1[i], Str2) <> 0 then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;
procedure TCreatDos.Edit2Change(Sender: TObject);
begin
 Button1.Enabled:=((not empty(Edit1.text)) and (not empty(Edit2.text)));
end;

procedure TCreatDos.FormCreate(Sender: TObject);
begin
  OldIdDos:=-1;
  DeFiltrageDataSet(DMRech.TaGestDossierRech);
  ListeRepDossier:=ChampTableVersListe('Dir_Dossier',DMRech.TaGestDossierRech);
  ListeRepDossier.Add(E.RepertoireProgram+'Demo');
  ListeRepExo:=ChampTableVersListe('Dir_Exo',DMRech.TaGestDossierRech);
  ListeRepExo.Add(E.RepertoireProgram+'Demo\ExoDemo');

//i:=GetWindowLong(PaInfoDos.Handle,GWL_STYLE );
//SetWindowLong (PaInfoDos.Handle,GWL_STYLE , i or BS_MULTILINE );
//SetWindowLong (button1.Handle,GWL_STYLE , i or BS_TOP);
//i:=GetWindowLong(CheckBox1.Handle,GWL_STYLE );
//SetWindowLong (button1.Handle,GWL_STYLE , i or BS_MULTILINE);
//SetWindowLong (CheckBox1.Handle,GWL_STYLE , i or BS_PUSHLIKE);
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;

end;

procedure TCreatDos.RxLabel1Click(Sender: TObject);
begin
PaLegende.Visible:= not PaLegende.Visible;
if PaLegende.visible then
   begin
    if CreatDos.Height < 595 then CreatDos.Height:=595;
    if CreatDos.Width < 580 then CreatDos.Width:=580;
   end
   else
   begin
    if CreatDos.Height >= 595 then CreatDos.Height:=487;
    if CreatDos.Width > 580 then CreatDos.Width:=580;
   end;

end;

procedure TCreatDos.RxLabel1MouseEnter(Sender: TObject);
begin
(sender as TRxLabel).Font.Style:=(sender as TRxLabel).Font.Style + [fsBold];
(sender as TRxLabel).Cursor:=crHandPoint;
end;

procedure TCreatDos.RxLabel1MouseLeave(Sender: TObject);
begin
(sender as TRxLabel).Font.Style:=(sender as TRxLabel).Font.Style - [fsBold];
(sender as TRxLabel).Cursor:=crDefault;
end;

procedure TCreatDos.RGLectResClick(Sender: TObject);
var
Noeud,Pere:TTreenode;
//i:integer;
//aux:string;
begin
   RGDDur.ItemIndex:=-1;
   RGLectRes.Cursor:=crHourGlass;
//   TreeView1.Items.Clear;
//   Chemin:=RGLectRes.items[RGLectRes.itemIndex];
   LecteurEnCours:=RGLectRes.items[RGLectRes.itemIndex];
   Chemin(nil);
   NodeCourantEx:=nil;
   CreatDos.TreeView2.Items.Clear;
   ScruteDossier(RGLectRes.items[RGLectRes.itemIndex],'*',FaDirectory,false);
   CreatDos.TreeView2.AlphaSort;

//     Pere:=Treeview1.Items.Add(Noeud,RGLectRes.items[RGLectRes.itemIndex]);
//     TreeView1.Items.AddChild(Pere,'');
//     Pere.Expand(false);
//     TreeView1.Visible:=true;
     RGLectRes.Cursor:=crDefault;
end;

procedure TCreatDos.Panel5Click(Sender: TObject);
begin
PaLegende.Visible:=not PaLegende.Visible;
if PaLegende.Visible then CreatDos.Height:=CreatDos.Height+PaLegende.Height
 else CreatDos.Height:=CreatDos.Height-PaLegende.Height;

end;

procedure TCreatDos.RxSBRepDefautClick(Sender: TObject);
var
i:integer;
NodeAux,NodePere:TTreeNode;
NomChemin:string;
begin
TreeView2.SetFocus;
RGDDur.ItemIndex:=RGDDur.Items.IndexOf(Copy(ParamUtil.RepertoireCreationDossier,1,3));
NodeAux:=TreeView2.Items.GetFirstNode;
NodeAux.Selected:=true;
NomChemin:=RGDDur.Items[RGDDur.ItemIndex]+TreeView2.Selected.Text;
//while  str_commence_par(UpperCase(E.RepertoireProgram),UpperCase(NomChemin)) and (length(NomChemin+'\') < length(E.RepertoireProgram)) do
while not str_commence_par(UpperCase(ParamUtil.RepertoireCreationDossier),UpperCase(NomChemin+'\')) do
 begin
   NodeAux:=NodeAux.GetNextSibling;

   ProtectObjetNil([NodeAux]);

   NodeAux.Selected:=true;
   if NodeAux.Level = 0 then
   NomChemin:=RGDDur.Items[RGDDur.ItemIndex]+TreeView2.Selected.Text
   else
   begin
    NomChemin:=str_Suppr_N_Car_ADroite(NomChemin,length(NomChemin)-lastDelimiter('\',NomChemin)+1);
    NomChemin:=NomChemin+'\'+NodeAux.Text;
   end;
   if str_commence_par(UpperCase(ParamUtil.RepertoireCreationDossier),UpperCase(NomChemin)) and (length(NomChemin+'\') < length(ParamUtil.RepertoireCreationDossier)) then
    begin
      NodeAux.Expand(false);
      NodeAux:=NodeAux.GetFirstChild;
      NomChemin:=NomChemin+'\'+NodeAux.Text;
       NodeAux.Selected:=true;
    end;
 end;

//TreeView2.SetFocus;
//RGDDur.ItemIndex:=RGDDur.Items.IndexOf(Copy(E.RepertoireProgram,1,3));
//NodeAux:=TreeView2.Items.GetFirstNode;
//NodeAux.Selected:=true;
//NomChemin:=RGDDur.Items[RGDDur.ItemIndex]+TreeView2.Selected.Text;
////while  str_commence_par(UpperCase(E.RepertoireProgram),UpperCase(NomChemin)) and (length(NomChemin+'\') < length(E.RepertoireProgram)) do
//while not str_commence_par(UpperCase(E.RepertoireProgram),UpperCase(NomChemin+'\')) do
// begin
//   NodeAux:=NodeAux.GetNextSibling;
//   NodeAux.Selected:=true;
//   if NodeAux.Level = 0 then
//   NomChemin:=RGDDur.Items[RGDDur.ItemIndex]+TreeView2.Selected.Text
//   else
//   begin
//    NomChemin:=str_Suppr_N_Car_ADroite(NomChemin,length(NomChemin)-lastDelimiter('\',NomChemin)+1);
//    NomChemin:=NomChemin+'\'+NodeAux.Text;
//   end;
//   if str_commence_par(UpperCase(E.RepertoireProgram),UpperCase(NomChemin)) and (length(NomChemin+'\') < length(E.RepertoireProgram)) then
//    begin
//      NodeAux.Expand(false);
//      NodeAux:=NodeAux.GetFirstChild;
//      NomChemin:=NomChemin+'\'+NodeAux.Text;
//    end;
// end;
end;

procedure TCreatDos.TreeView2Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
var
Noeud:TTreeNode;
CheminAux:String;
begin
  CheminAux:='';
  node.DeleteChildren;
  NodeCourantEx:=node;
  ScruteDossier(CheminTreeView(Node),'*',FaDirectory,false);
  CreatDos.TreeView2.AlphaSort;
end;

procedure TCreatDos.TreeView2Changing(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
var
Noeud:TTreeNode;
begin
 if node.ImageIndex in [3,5] then
  begin
    AllowChange:=false;
    exit;
  end;
 if node.Parent <> nil then
  begin
   if node.Parent.ImageIndex in [3,5] then
    begin
      AllowChange:=false;
      exit;
    end;
  end;

 Chemin(Node);
 Label2.Caption := CheminTreeView(Node);
end;

procedure TCreatDos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[nil]);
if Key = VK_ESCAPE then
    begin
      Key:= 0;
      ModalResult := MrCancel
//      Self.Close;
   end;
end;

Function TCreatDos.Chemin(Node:TTreeNode):String;
Var
Noeud:TTreeNode;
Begin
try
 try
  result:='';
  if Node <> nil then
   begin
    if Node.Selected then
     begin
      Noeud:=Node;
      Result:=Noeud.Text;
      while Noeud.Parent <> nil do
       begin
         Noeud:=Noeud.Parent;
         Result:=Noeud.Text+'\'+Result;
       end;
      Result:=LecteurEnCours + Result;
//      Label2.Caption:=Result;
     end
    else
     begin
      Result:=LecteurEnCours + Result;
//      Label2.Caption:=Result;
     end;
//    str_Suppr_Repetition(Result,'\');
   end
   else
   begin
    Result:=LecteurEnCours + Result;
  //  result:='';
   end;
 except
  showmessage(ErrInterne+'TCreatDos.Chemin');
 end;
finally
  str_Suppr_Repetition(Result,'\');
  if str_fini_par(result,'\') then
   result:=str_Suppr_N_Car_ADroite(result,1);
  Label2.Caption:=Result;
end;
End;

Function TCreatDos.CheminTreeView(Node:TTreeNode):String;
Var
Noeud:TTreeNode;
Begin
if Node <> nil then
 begin
    Noeud:=Node;
    Result:=Noeud.Text;
    while Noeud.Parent <> nil do
     begin
       Noeud:=Noeud.Parent;
       Result:=Noeud.Text+'\'+Result;
     end;
    Result:=LecteurEnCours + Result;
    result:=str_Suppr_Repetition(Result,'\');
 end
 else
 begin
  result:='';
 end;
End;

procedure TCreatDos.RxSBAutreRepClick(Sender: TObject);
begin
 if BrowseDirectory(ParamUtil.RepertoireCreationDossier,'Répertoire par défaut',0) then
  begin
   if not str_fini_par(ParamUtil.RepertoireCreationDossier,'\') then
     ParamUtil.RepertoireCreationDossier := ParamUtil.RepertoireCreationDossier + '\';
   RxSBRepDefaut.Click;  
  end;
end;

end.
