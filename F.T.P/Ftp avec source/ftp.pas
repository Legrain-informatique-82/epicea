unit ftp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient,
  //IdFTP,
  shellapi, UDMFtp, ComCtrls, ExtCtrls,
  IdIntercept, IdAntiFreezeBase, IdAntiFreeze, XPMan, RechercheRep,RechercheRepDest, ShellCtrls,
  Buttons,Aide;

type
  TForm1 = class(TForm)
    ButtonTransfert: TButton;
    ButtonQuitter: TButton;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    StaticText1: TStaticText;
    XPManifest1: TXPManifest;
    IdAntiFreeze1: TIdAntiFreeze;
    LabelServeur: TLabel;
    LabelUtilisateur: TLabel;
    LabelPassWord: TLabel;
    EditServeur: TEdit;
    EditUtilisateur: TEdit;
    EditPassWord: TEdit;
    CheckBoxEffacer: TCheckBox;
    EditSource: TEdit;
    EditDestination: TEdit;
    LabelSource: TLabel;
    LabelDestination: TLabel;
    ButtonChargeParam: TButton;
    ButtonEnregistreParam: TButton;
    GroupBoxFich: TGroupBox;
    GroupBoxTotal: TGroupBox;
    ProgressBarFich: TProgressBar;
    ProgressBarTotal: TProgressBar;
    ButtonChoixRep: TSpeedButton;
    LabelFichEnCours: TStaticText;
    SpeedButtonChoixRepDest: TSpeedButton;
    Button1: TButton;
    procedure ButtonTransfertClick(Sender: TObject);
    procedure ParseParametre;     //Analyse des param�tres
    procedure FormCreate(Sender: TObject);
    procedure ButtonQuitterClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ButtonChargeParamClick(Sender: TObject);      //Chargement des param�tres de tranfert � partir de FTPparam.txt
    procedure ButtonEnregistreParamClick(Sender: TObject);  //Enregistrement des param�tres de tranfert dans FTPparam.txt
    procedure SpeedButtonChoixRepDestClick(Sender: TObject);
    procedure ButtonChoixRepClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure EditServeurChange(Sender: TObject);
    procedure EditUtilisateurChange(Sender: TObject);
    procedure EditPassWordChange(Sender: TObject);
    procedure EditSourceChange(Sender: TObject);
    procedure EditDestinationChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
      InfosFtp:TInfosFtp;

  end;

var
  Form1: TForm1;

  procedure fenetre_vide;
  //supprime toutes les informations inutile s'il y a des param�tres

implementation
{$R *.dfm}

  procedure TForm1.ParseParametre;
  //Analyse les param�tres
  begin
    if ParamCount<>0 then begin
      try
          case ParamCount of
              1: begin // param par d�faut dans le fichier FTPparam.txt
                    if (ParamStr(1)='a') or (ParamStr(1)='A') then begin
                        ButtonTransfert.Visible        :=false;
                        UDMFtp.ControlRetourInfoNbFich := self;
                        UDMFtp.ControlRetourInfoEnCour := StaticText1;
                        UDMFtp.ControlRetourInfo       := Form1.StatusBar1;
                        UDMFtp.ProgressBar             := ProgressBarTotal;
                        UDMFtp.ProgressBarFich         := ProgressBarFich;
                        Init_InfosFtp(InfosFtp,true);
                       // try
                            DMFtp.IdFTP1.Connect;
                            DMFtp.IdFTP1.quit;
                       // except
                       //     showmessage('Erreur lors de la connexion');
                       // end;
                    end
                    else begin
                        showmessage('Param�tre incorrect');
                        Form1.Close;
                    end;
                 end;
              2: begin
                    InfosFtp.FichierParam:=paramStr(1);
                    if (ParamStr(2)='a') or (ParamStr(2)='A')   //execution automatique
                        or (ParamStr(2)='ga') or (ParamStr(2)='GA')then begin //execution automatique
                        ButtonTransfert.Visible        :=false;
                        UDMFtp.ControlRetourInfoNbFich := self;
                        UDMFtp.ControlRetourInfoEnCour := StaticText1;
                        UDMFtp.ControlRetourInfo       := Form1.StatusBar1;
                        UDMFtp.ProgressBar             := ProgressBarTotal;
                        UDMFtp.ProgressBarFich         := ProgressBarFich;
                        if (ParamStr(2)='ga') or (ParamStr(2)='GA') then begin
                        //get - r�ception des fichiers �  partir du serveur FTP
                            InfosFtp.Get:='o';
                        end;
                    Init_InfosFtp(InfosFtp,false);
                        DMFtp.IdFTP1.Connect;
                        DMFtp.IdFTP1.quit;
                    end;
                 end;
              4: begin    // fichier texte contenant les infos de connexion
                          // + source + destination
                    InfosFtp.RepSource   :=ParamStr(1);
                    InfosFtp.RepDest     :=ParamStr(2);
                    InfosFtp.FichierParam:=ParamStr(3);
                    InfosFtp.Effacer     :=ParamStr(4);
                  end;

              5: begin    //fichier texte contenant les infos de connexion
                          // + source + destination et execution automatique
                    InfosFtp.RepSource   :=ParamStr(1);
                    InfosFtp.RepDest     :=ParamStr(2);
                    InfosFtp.FichierParam:=ParamStr(3);
                    InfosFtp.Effacer     :=ParamStr(4);

                    if (ParamStr(5)='a') or (ParamStr(5)='A')
                        or (ParamStr(5)='ga') or (ParamStr(5)='GA')then begin //execution automatique
                        ButtonTransfert.Visible        :=false;
                        UDMFtp.ControlRetourInfoNbFich := self;
                        UDMFtp.ControlRetourInfoEnCour := StaticText1;
                        UDMFtp.ControlRetourInfo       := Form1.StatusBar1;
                        UDMFtp.ProgressBar             := ProgressBarTotal;
                        UDMFtp.ProgressBarFich         := ProgressBarFich;
                        if (ParamStr(5)='ga') or (ParamStr(5)='GA') then begin
                        //get - r�ception des fichiers �  partir du serveur FTP
                            InfosFtp.Get:='o';
                        end;
                        Init_InfosFtp(InfosFtp,false);
                      //  try
                            DMFtp.IdFTP1.Connect;
                            DMFtp.IdFTP1.quit;
                    //    except
                    //        showmessage('Erreur lors de la connexion');
                    //    end;
                    end
                  end;

              6: begin   //param 1 par 1
                    InfosFtp.RepSource  :=ParamStr(1);
                    InfosFtp.RepDest    :=ParamStr(2);
                    InfosFtp.Login      :=ParamStr(3);
                    InfosFtp.PassWord   :=ParamStr(4);
                    InfosFtp.Adresse    :=ParamStr(5);
                    InfosFtp.Effacer    :=ParamStr(6);
                 end;

              7: begin   //param 1 par 1 et execution automatique
                    InfosFtp.RepSource  :=ParamStr(1);
                    InfosFtp.RepDest    :=ParamStr(2);
                    InfosFtp.Login      :=ParamStr(3);
                    InfosFtp.PassWord   :=ParamStr(4);
                    InfosFtp.Adresse    :=ParamStr(5);
                    InfosFtp.Effacer    :=ParamStr(6);

                    if (ParamStr(7)='a') or (ParamStr(7)='A') then begin  //execution automatique
                        ButtonTransfert.Visible        :=false;
                        UDMFtp.ControlRetourInfoNbFich := self;
                        UDMFtp.ControlRetourInfoEnCour := StaticText1;
                        UDMFtp.ControlRetourInfo       := Form1.StatusBar1;
                        UDMFtp.ProgressBar             := ProgressBarTotal;
                        UDMFtp.ProgressBarFich         := ProgressBarFich;
                        Init_InfosFtp(InfosFtp,false);
                 //   try
                        DMFtp.IdFTP1.Connect;
                        DMFtp.IdFTP1.quit;

                //    except
                //        showmessage('Erreur lors de la connexion');
                 //   end;
                    end;
                 end;
           else
              begin
                  showmessage('Nombre de param�tre incorrect');
                  Form1.Close;
              end;
          end;

      except
          on EAbort do
              Form1.Close;
      end;
    end;
  end;

  Procedure TForm1.ButtonTransfertClick(Sender: TObject);
  begin
    if ParamCount<>0 then begin
      try
          UDMFtp.ControlRetourInfoNbFich := self;
          UDMFtp.ControlRetourInfoEnCour := StaticText1;
          UDMFtp.ControlRetourInfo       := Form1.StatusBar1;
          UDMFtp.ProgressBar             := ProgressBarTotal;
          UDMFtp.ProgressBarFich         := ProgressBarFich;
          Init_InfosFtp(InfosFtp,false);
      //    try
              DMFtp.IdFTP1.Connect;
              DMFtp.IdFTP1.quit;
      //    except
      //        showmessage('Erreur lors de la connexion');
      //    end;
      except
          on EAbort do Form1.Close;
      end;
    end
    else begin
        if (Form1.EditServeur.Text<>'') and (Form1.EditUtilisateur.Text<>'') and (Form1.EditPassWord.Text<>'')
            and (Form1.EditSource.Text<>'')
            then begin
            InfosFtp.RepSource  :=Form1.EditSource.Text;
            InfosFtp.RepDest    :=Form1.EditDestination.Text;
            InfosFtp.Login      :=Form1.EditUtilisateur.Text;
            InfosFtp.PassWord   :=Form1.EditPassWord.Text;
            InfosFtp.Adresse    :=Form1.EditServeur.Text;
            if CheckBoxEffacer.Checked then
                InfosFtp.Effacer    :='o'
            else
                InfosFtp.Effacer    :='n';
            //connexion
            UDMFtp.ControlRetourInfoNbFich := self;
            UDMFtp.ControlRetourInfoEnCour := StaticText1;
            UDMFtp.ControlRetourInfo := Form1.StatusBar1;
            UDMFtp.ProgressBar := ProgressBarTotal;
            UDMFtp.ProgressBarFich := ProgressBarFich;
            Init_InfosFtp(InfosFtp,false);
            //try
                DMFtp.IdFTP1.Connect;
                DMFtp.IdFTP1.quit;
            //except
                //showmessage('Erreur lors de la connexion');
            //end;
        end
        else
            showmessage('Veuillez compl�ter tous les champs');
    end;
  end;

  procedure TForm1.FormCreate(Sender: TObject);
  begin
      if ParamCount<>0 then
          fenetre_vide;
      Timer1.Enabled := true;
      Form1.KeyPreview:=true;
      creation_rep:=false;
  end;

  procedure TForm1.ButtonQuitterClick(Sender: TObject);
  //quitter
  begin
      if (DMFtp<>nil) then
          if DMFtp.IdFTP1.Connected then
                DMFtp.IdFTP1.Abort;
      Form1.Close;
  end;

  procedure TForm1.Timer1Timer(Sender: TObject);
  begin
      Timer1.Enabled := false;
      ParseParametre;
  end;

  procedure fenetre_vide;
  //supprime toutes les informations inutile s'il a des param�tres
  begin
      Form1.LabelServeur.Visible            :=false;
      Form1.LabelUtilisateur.Visible        :=false;
      Form1.LabelPassWord.Visible           :=false;
      Form1.LabelSource.Visible             :=false;
      Form1.LabelDestination.Visible        :=false;
      Form1.EditServeur.Visible             :=false;
      Form1.EditUtilisateur.Visible         :=false;
      Form1.EditPassWord.Visible            :=false;
      Form1.EditSource.Visible              :=false;
      Form1.EditDestination.Visible         :=false;
      Form1.CheckBoxEffacer.Visible         :=false;
      Form1.ButtonChargeParam.Visible       :=false;
      Form1.ButtonEnregistreParam.Visible   :=false;
      Form1.ButtonChoixRep.Visible          :=false;
      Form1.SpeedButtonChoixRepDest.Visible :=false;

      Form1.ClientHeight  :=296;
      Form1.ClientWidth   :=492;

      Form1.ButtonTransfert.Height:=25;
      Form1.ButtonTransfert.Width :=97;
      Form1.ButtonTransfert.Left  :=184;
      Form1.ButtonTransfert.Top   :=16;

      Form1.ButtonQuitter.Height:=25;
      Form1.ButtonQuitter.Width :=97;
      Form1.ButtonQuitter.Left  :=192;
      Form1.ButtonQuitter.Top   :=232;

      Form1.LabelFichEnCours.Height :=13;
      Form1.LabelFichEnCours.Left   :=96;
      Form1.LabelFichEnCours.Top    :=96;
      Form1.LabelFichEnCours.Width  :=137;

      Form1.ProgressBarFich.Height:=21;
      Form1.ProgressBarFich.Left  :=80;
      Form1.ProgressBarFich.Top   :=68;
      Form1.ProgressBarFich.Width :=345;

      Form1.ProgressBarTotal.Height :=21;
      Form1.ProgressBarTotal.Left   :=80;
      Form1.ProgressBarTotal.Top    :=168;
      Form1.ProgressBarTotal.Width  :=345;

      Form1.StaticText1.Height  :=4;
      Form1.StaticText1.Left    :=234;
      Form1.StaticText1.Top     :=97;
      Form1.StaticText1.Width   :=4;

      Form1.GroupBoxFich.Height:=73;
      Form1.GroupBoxFich.Left  :=64;
      Form1.GroupBoxFich.Top   :=48;
      Form1.GroupBoxFich.Width :=377;
      
      Form1.GroupBoxTotal.Height:=73;
      Form1.GroupBoxTotal.Left  :=64;
      Form1.GroupBoxTotal.Top   :=144;
      Form1.GroupBoxTotal.Width :=377;
  end;

  procedure TForm1.ButtonChargeParamClick(Sender: TObject);
  //Chargement des param�tres de tranfert � partir de FTPparam.txt
      var ListeParamDefaut : TStringList;
          effacer,cheminFichier:string;
  begin
      ListeParamDefaut:=TStringList.Create;
      try
          ListeParamDefaut.LoadFromFile('ParamFTP.txt');
          if ListeParamDefaut.Count<6 then abort;
          Form1.EditUtilisateur.Text := ListeParamDefaut.Strings[2];
          Form1.EditPassWord.Text    := ListeParamDefaut.Strings[3];
          Form1.EditServeur.Text     := ListeParamDefaut.Strings[4];
          effacer                    := ListeParamDefaut.Strings[5];
          Form1.EditSource.Text      := ListeParamDefaut.Strings[0];
          Form1.EditDestination.Text := ListeParamDefaut.Strings[1];
          if (effacer='o') or (effacer='O')then
              Form1.CheckBoxEffacer.Checked:=true;
          ListeParamDefaut.Free;
      except
          showmessage('Impossible de trouver les param�tres dans le fichier : '
                              + 'FTPparam.txt');
      end;
  end;

  procedure TForm1.ButtonEnregistreParamClick(Sender: TObject);
  //Enregistrement des param�tres de tranfert dans FTPparam.txt
      var ListeParamDefaut : TStringList;
          effacer:string;
  begin
      ListeParamDefaut:=TStringList.Create;
      if (Form1.EditServeur.Text<>'') and (Form1.EditUtilisateur.Text<>'') and (Form1.EditPassWord.Text<>'') and
         (Form1.EditSource.Text<>'') and (Form1.EditDestination.Text<>'') then begin

          ListeParamDefaut.Add(Form1.EditSource.Text);
          ListeParamDefaut.Add(Form1.EditDestination.Text);
          ListeParamDefaut.Add(Form1.EditUtilisateur.Text);
          ListeParamDefaut.Add(Form1.EditPassWord.Text);
          ListeParamDefaut.Add(Form1.EditServeur.Text);
          if Form1.CheckBoxEffacer.Checked then
              effacer:='o'
          else
              effacer:='n';
          ListeParamDefaut.Add(effacer);
          try
              ListeParamDefaut.SaveToFile('paramFTP.txt');
          except
              showmessage('Impossible de cr�er le fichier contenant les param�tres : '
                              + 'paramFTP.txt');
          end;
          ListeParamDefaut.Free;
      end
      else
          showmessage('Veuillez compl�ter tous les champs');
  end;

  procedure TForm1.ButtonChoixRepClick(Sender: TObject);
  begin
      if FormChoixRepSource = nil then FormChoixRepSource := TFormChoixRepSource.Create(nil);
      FormChoixRepSource.Show;
  end;

  procedure TForm1.SpeedButtonChoixRepDestClick(Sender: TObject);
  begin
      if (Form1.EditServeur.Text<>'') and (Form1.EditUtilisateur.Text<>'') and (Form1.EditPassWord.Text<>'') then begin
          InfosFtp.Login      :=Form1.EditUtilisateur.Text;
          InfosFtp.PassWord   :=Form1.EditPassWord.Text;
          InfosFtp.Adresse    :=Form1.EditServeur.Text;
          Init_InfosFtp(InfosFtp,false);
          if FormChoixRepDest = nil then FormChoixRepDest := TFormChoixRepDest.Create(nil);
          FormChoixRepDest.Show;
      end
      else
          showmessage('Veuillez compl�ter les champs : Serveur FTP, Utilisateur et Mot de passe avant.');
  end;

  procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
      if(Key=VK_F1) and (ParamCount=0) then begin
          //'F1' Raccouci clavier pour l'aide
          if FormAide = nil then FormAide := TFormAide.Create(nil);
          try
              FormAide.WebBrowser1.Navigate(GetCurrentDir+'\aide.htm');
              FormAide.Show;
           except
              showmessage('Fichier d''aide introuvable');
          end;
      end;
  end;

  procedure TForm1.FormDestroy(Sender: TObject);
  begin
      if FormAide<>nil then
          FormAide.WebBrowser1.Free;
  end;

  procedure TForm1.EditServeurChange(Sender: TObject);
  begin
      if EditServeur.Text<>'' then
          EditServeur.Hint:=EditServeur.Text
      else
          EditServeur.Hint:='Adresse du serveur FTP';
  end;

  procedure TForm1.EditUtilisateurChange(Sender: TObject);
  begin
      if EditUtilisateur.Text<>'' then
          EditUtilisateur.Hint:=EditUtilisateur.Text
      else
          EditUtilisateur.Hint:='Nom d''utilisateur';
  end;

  procedure TForm1.EditPassWordChange(Sender: TObject);
  begin
      if EditPassWord.Text<>'' then     
          EditPassWord.Hint:=EditPassWord.Text
      else
          EditPassWord.Hint:='Mot de passe';
  end;

  procedure TForm1.EditSourceChange(Sender: TObject);
  begin
      if EditSource.Text<>'' then
          EditSource.Hint:=EditSource.Text
      else
          EditSource.Hint:='Chemin du r�pertoire � envoyer';
  end;

  procedure TForm1.EditDestinationChange(Sender: TObject);
  begin
      if EditDestination.Text<>'' then
          EditDestination.Hint:=EditDestination.Text
      else
          EditDestination.Hint:='Chemin du r�pertoire o� les fichiers doivent �tre envoyer';
  end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  begin
    if ParamCount<>0 then begin
      try
          UDMFtp.ControlRetourInfoNbFich := self;
          UDMFtp.ControlRetourInfoEnCour := StaticText1;
          UDMFtp.ControlRetourInfo       := Form1.StatusBar1;
          UDMFtp.ProgressBar             := ProgressBarTotal;
          UDMFtp.ProgressBarFich         := ProgressBarFich;
          Init_InfosFtp(InfosFtp,false);
      //    try
              DMFtp.IdFTP1.Connect;
              DMFtp.IdFTP1.quit;
      //    except
      //        showmessage('Erreur lors de la connexion');
      //    end;
      except
          on EAbort do Form1.Close;
      end;
    end
    else begin
        if (Form1.EditServeur.Text<>'') and (Form1.EditUtilisateur.Text<>'') and (Form1.EditPassWord.Text<>'')
            and (Form1.EditDestination.Text<>'')
            then begin
            InfosFtp.RepSource  :=Form1.EditSource.Text;
            InfosFtp.RepDest    :=Form1.EditDestination.Text;
            InfosFtp.Login      :=Form1.EditUtilisateur.Text;
            InfosFtp.PassWord   :=Form1.EditPassWord.Text;
            InfosFtp.Adresse    :=Form1.EditServeur.Text;
            InfosFtp.Get        :='o';      
//            if CheckBoxEffacer.Checked then
//                InfosFtp.Effacer    :='o'
//            else
//                InfosFtp.Effacer    :='n';
            //connexion
            UDMFtp.ControlRetourInfoNbFich := self;
            UDMFtp.ControlRetourInfoEnCour := StaticText1;
            UDMFtp.ControlRetourInfo := Form1.StatusBar1;
            UDMFtp.ProgressBar := ProgressBarTotal;
            UDMFtp.ProgressBarFich := ProgressBarFich;
            Init_InfosFtp(InfosFtp,false);
            //try
                DMFtp.IdFTP1.Connect;
                DMFtp.IdFTP1.quit;
            //except
                //showmessage('Erreur lors de la connexion');
            //end;
        end
        else
            showmessage('Veuillez compl�ter tous les champs');
    end;
  end;
end;

end.
