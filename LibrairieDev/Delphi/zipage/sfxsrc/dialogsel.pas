(******************************************************************)
(* Copyright 1997,1998, Merkes' Pages (Markus Stephany)           *)
(* Email: mirbir.st@t-online.de/mirbir.st@saargate.de             *)
(* Web-page: http://home.t-online.de/home/mirbir.st/              *)
(*                                                                *)
(* This program was written in Borland Delphi 3 (and should be    *)
(* fully compatible with Delphi 2 (I hope it !).                  *)
(*                                                                *)
(******************************************************************)

{ this is a part of the modified version of ZipSfx.
  initially, zipsfx has been written by :

(******************************************************************)
(* ZipSFX                                                         *)
(* Copyright 1997, Carl Bunton                                    *)
(* Home of ZipTV compression components for Delphi                *)
(* Email: Twojags@cris.com                                        *)
(* Web-page: http://www.concentric.net/~twojags                   *)
(******************************************************************)

the first modifications came from Eric W. Engler englere@swcp.com

he is the creator of the powerful freeware zip-vcl delzip for delphi 2? and 3.

now i am trying to make the code a bit more sfx-creator- and sfx-user- friendly,
and i must say, eric is a very hard beta-tester :).
}

UNIT Dialogsel;

INTERFACE

USES
    Messages,
    Windows,sfxmisc,shellapi;

FUNCTION seldialogProc(dlgsel     : hWnd;   // the dialog-proc for directory-selection
                         DlgMessage : UINT;
                         DlgWParam  : WPARAM;
                         DlgLParam  : LPARAM) : BOOL; STDCALL;

FUNCTION newdirProc(dlgnew     : hWnd;     // the dialog-proc for create-subdirectory
                         DlgMessage : UINT;
                         DlgWParam  : WPARAM;
                         DlgLParam  : LPARAM) : BOOL; STDCALL;

procedure getdefaultparams; // reads the special header (s.b.), if any and sets some variables
procedure executecmd(int:integer); // execute the command-line read from the special header, if any
function getarg(index:integer):string; // splits the command line in application / parameters, if possible


var  seldir       : pchar;    // the selected directory for the select-dir-dialog (in / out)
     storedpath   : pchar;    // the default-directory stored in the special header (out)
     usesp        : boolean;  // if true, then there is a stored path rather than the current directory
     commandline  : pchar;    // the command line read from the special header
     usecl        : boolean;  // if true, the there is such a command line to execute after extraction
     allowdcl     : boolean;  // if true, then the end-user can disable running the command ''
     allowsel     : boolean;  // if true, the end-user can choose what files to extract from the archive
     hideovm      : boolean;  // if true, then hide the radiobuttons to select whether to overwrite existing files or not
     defovm       : integer;  // the default overwrite-mode (overwrite, confirm or skip)
     caption      : pchar;    // the definable caption for the main dialog
     usecap       : boolean;  // if true, then there is such a caption
const
     cm_browse  = 775;        // the item-id for the "browse dir"-buutin in the main dialog
     cm_runapp  = 1007;       // for the "run xxx after extraction"-checkbox
     cm_lbshow  = 302;        // for the single-selection listbox that the user sees if he is not allowed to select what files to extract
     cm_group   = 509;        // for the "existing file(s)" -groupbox (just to hide it if necessary)

IMPLEMENTATION

uses sfxgbls;

(* the structure of a zipsfx-file :
- zipsfx-executable code (0-38911)
- signature "MPU"                        or                           zip-archive
-                |_ rest of the special header
-                                             |_ zip-archive

the structure of the special-header :
Byte 0..2   : signature "MPU"

Byte    3   : Bit 0 (val  1) : if set, user can disable running the command line after extraction (if any)
              Bit 1 (val  2) : if set, user can choose what files to extract
              Bit 2 (val  4) : if set, user can change the overwrite-mode (confirm, overwrite, skip)
              Bit3-4(val 8,16) : default-overwrite mode
                     0 : confirm overwriting existing files
                     8 : overwrite existing files
                    16 : skip existing files

Byte    4   : length of user-defined caption / 0=default caption
        5   : length of default-extraction-path / 0=current directory
        6   : length of command line to start after extraction / 0=none

Byte 7..m   : the dialog's caption, if byte 4 <> 0 ( without terminating zero)
     m+1..n : the default-extraction-path, if byte 5 <> 0 (dito)

              ++++added  march 01,98 if set to "><", then use  temp-dir

     n+1..x : the command line to execute after successfull extraction, if byte 6 <> 0 (dito)
              format : the command line has a special format
              if the string "><" (greater than+less than) is somewhere in the command line,
              it will be replaced with the path where the archive has been extracted to.
              (e.g. "><readme\test.txt" after an extraction to the path "C:\Program files\unpacked" means :
              "c:\progra~1\unpacked\readme\test.txt") <- the short path will be created by zipsfx.
              if the pipe "|" is in the command-line, the part to the left will get the application to run
              and the part to the right will be it's argument;
              if the archive is extracted to e.g. "d:\unpack", then we will get the following :
              "><setup\setup.exe|><install.inf" will parse to :
              run "d:\unpack\setup\setup.exe" with parameters "d:\unpack\install.inf".
              "c:\windows\notepad.exe|><readme.txt" will parse to :
              run "c:\windows\notepad.exe" with parameters "d:\unpack\readme.txt".
              "><readme.txt" will parse to :
              open "d:\unpack\readme.txt" with its associated program, if there is any.
              "><setup.exe" will run "d:\unpack\setup.exe" without special parameters.
              ...

since the special header always has a size of 256 bytes, it must be filled to fit (and if the three strings are too long,
there will occur some problems)

*)

var iconheight : integer; // the height of a small shell-icon (to calc the item-height of the directory-listbox)
    shlv : integer;       // handle of the shell's small-image-list
const
     ci_listbox = 2003;   // itemID of the directory-listbox in the select-dir dialog
     ci_label   = 2001;   // the directory-display - static text
     ci_net     = 2002;   // to connect a network-drive (not yet tested !!!)
     ci_new     = 2004;   // to show the create-dir dialog

     cn_path    = 3001;   // itemID of the current-path - display in the create-subdir dialog
     cn_edit    = 3002;   // of the enter-new-subdir edit

function ImageList_Draw(ImageList: integer; Index: Integer; // to draw a imagelist-image on a hdc
  Dest: HDC; X, Y: Integer; Style: UINT): Bool; stdcall; external 'comctl32.dll' name 'ImageList_Draw';

function getarg(index:integer):string; // gets an argument from the stored command line
//                1 : the part before the pipe (if there's no pipe, returns the whole command line)
//                2 : the part after the pipe (if no pipe, returns "")
//                all "><" will be replaced by the ectraction path
var pip:integer;
begin
     appenddirtail(extpath);
     result := pchartostr(commandline,strlen(commandline));
     pip := pos('|',result);
     if pip = 0 then begin
        if index = 2 then result := ''
     end else begin
         if index = 1 then result := copy(result,1,pip-1)
         else result := copy(result,pip+1,maxint);
     end;
     repeat
           pip := pos('><',result);
           if pip = 0 then break;
           result := copy(result,1,pip-1)+extpath+copy(result,pip+2,maxint);
     until false;
     // get the short (8+3)-filename (it seems that shellexecute has some problems with lfn)
     getshortpathname(pchar(result),pchar(result),length(result));

end;


procedure executecmd; // parses and shell-executes the stored command line after extraction
var sr1,sr2 : string;
begin
          if (int =1) and usecl then begin
             sr1 := getarg(1);
             sr2 := getarg(2);
             shellexecute(0,'open',pchar(sr1),pchar(sr2),'',sw_show);
             //messagebox(0,pchar(sr2),pchar(sr1),0);
          end;
end;

procedure getdefaultparams; // reads the values from the special header, if any
var sig : array [0..2] of char;
    br : dword;
    spl,cll,cal:byte;
begin

     startoffile := 38912; // this is the size of the original sfx-executable

     usecl := false;    // no cammand line
     usesp := false;    // no stored path
     usecap := false;   // no stored caption
     allowsel := true;  // user can choose files to extract
     allowdcl := true;  // user can disable execution of the command line
     hideovm := false;  // user can change the overwrite-mode
     defovm := cm_confirm; // by default : confirm
     fseek(startoffile,file_begin); // let us look for a special-header signature directly after the sfx-code
     ReadFile(InFile, sig[0], 3, br, NIL);
     if br = 3 then if sig = 'MPU' then begin   // okay, found
        startoffile := startoffile+256;         // the arcihive will start 256 bytes behind the spec header
        readfile(infile,cll,1,br,nil);          // read and evaluate the flags-byte
        if (cll and 1) = 0 then allowdcl := false;
        if (cll and 2) = 0 then allowsel := false;
        if (cll and 4) = 4 then hideovm  := true;
        case (cll and 24) of
             8 : defovm := cm_overwrite;
            16 : defovm := cm_skip;
        end;

        readfile(infile,cal,1,br,nil);          // read length opf caption
        if cal > 0 then usecap := true;
        readfile(infile,spl,1,br,nil);          // read length of stored path
        if spl > 0 then usesp := true;
        readfile(infile,cll,1,br,nil);          // read length of command line
        if cll > 0 then usecl := true;
        // read the caption;
        if usecap then readfile(infile,caption^,cal,br,nil);
        caption[cal] := #0;
        // read the stored path;
        if usesp then begin
           readfile(infile,storedpath^,spl,br,nil);
           storedpath[spl] := #0;

           //+++++ added march 01,98 : if the def path = "><", then use temporary directory
           if storedpath = '><' then
              gettemppath(max_path,storedpath);
        end;
        // read the command line;
        if usecl then readfile(infile,commandline^,cll,br,nil);
        commandline[cll] := #0;
     end;
end;

procedure addseldir; // add a termianting backslash to the seldir, if there is none
begin
     appenddirtail(seldir);
end;

function forcedirs(path1,path2:pchar):boolean; // check whether all directories can be created
var sr : string;
begin
     result := false;
     sr := pchartostr(path2,strlen(path2));
     if pos(':',sr) > 0 then exit;
     while (sr <> '') and (sr[1] = '\') do delete(sr,1,1);
     if sr = '' then exit;
     forcedirectories(pchartostr(path1,strlen(path1))+sr);
     if fileexists(pchar(sr+'\')) then begin
        setcurrentdirectory(pchar(sr));
        result := true;
     end;
end;

function getshicon(sr:string;var i:integer):string; // get the shell's small icon and displayname for a given file/folder
var sfi : pshfileinfo;
begin
     getmem(sfi,sizeof(tshfileinfo));
     shlv:=shgetfileinfo(pchar(sr),0,sfi^,sizeof(tshfileinfo),shgfi_sysiconindex or shgfi_icon or shgfi_smallicon
           or shgfi_displayname);
     result := sfi.szdisplayname;
     i := sfi.iicon;
     freemem(sfi);
end;

// returns the complete long file name for a given path/filename
procedure getlongpath(var pch:pchar);
var sr,sr1,sr2 : string;
    hand : integer;
    data : pwin32finddata;
    i : integer;
begin
     getmem(data,sizeof(twin32finddata));
     try
     if strlen(pch) < 4 then exit;
     // jedes einzelne teil suchen
     i := strlen(pch);
     if pch[i-1]<>'\' then begin
        pch[i]:='\';
        pch[i+1]:=#0;
     end;
     sr := pch;
     sr1 := pch;
     sr[3] := ':';
     sr2 := copy(sr1,1,3);
     repeat
           i := pos('\',sr);
           if i = 0 then break;
           sr[i]:=':';
           hand :=findfirstfile(pchar(copy(sr1,1,i-1)),data^);
           findclose(hand);
           sr2:=sr2+data.cfilename+'\';
     until false;
     move(sr2[1],pch[0],min(fsmaxpath,length(sr2)+1));
     finally
     freemem(data);
     end;
end;


(*--------------------------------------------------------------------------*)
(*     selDialogProc --- Handle messages for select dir dialog.           *)
(*--------------------------------------------------------------------------*)
FUNCTION selDialogProc(dlgsel     : hWnd ;
                         DlgMessage : UINT;
                         DlgWParam  : WPARAM ;
                         DlgLParam  : LPARAM) : BOOL; STDCALL;

  procedure setit; // fills the dialog with the directory-contents
  var cmd1,cmd2:integer;
  const    pp : array [0..4] of char = '[..]'#0;
  begin
     cmd1 := getdlgitem(dlgsel,ci_label);
     cmd2 := getdlgitem(dlgsel,ci_listbox);
     DlgDirList(dlgsel,seldir,ci_listbox,ci_label,ddl_drives or ddl_directory or ddl_exclusive);
     sendmessage(cmd1,wm_gettext,max_path,integer(seldir));
     getlongpath(seldir);
     sendmessage(cmd1,wm_settext,0,integer(seldir));
     // now try to find the '..'-directory to set it to the first (0-) position in the listbox
     cmd1 := sendmessage(cmd2,lb_findstringexact,0,integer(@pp));
     if cmd1 <> lb_err then begin
        sendmessage(cmd2,lb_deletestring,cmd1,0);
        sendmessage(cmd2,lb_insertstring,0,integer(@pp));
     end;
     setfocus(cmd2);
     sendmessage(cmd2,lb_setcursel,0,0);
  end;

  procedure drawlistbox; // draws a listbox-item in a win95-alike style (almost) with icon and lfn
  var sr : shortstring;
    kind : integer;
    icon : integer;

  begin
     if dlgwparam = ci_listbox then with pdrawitemstruct(dlglparam)^ do begin
        // get the item's text;
        setlength(sr,sendmessage(hwnditem,lb_gettext,itemid,integer(@sr[1])));

        // get the kind of item
        kind := 0;
        sr:=copy(sr,2,length(sr)-2);
        if length(sr) = 3 then begin
           if sr[1] = '-' then
              if sr [3] = '-' then  begin
                 sr := sr[2]+':\';
                 kind := 1; // for [-x-] - items (these are drives)
              end;
        end else if sr = '..' then kind := 2; // for the "up to parent"-directory ([..])
        if (itemState and ods_focus) <> 0 then begin
           // set the listbox' colors to selected state
           settextcolor(hdc,getsyscolor(color_highlighttext));
           setbkcolor(hdc,getsyscolor(color_highlight));
           fillrect(hdc,rcitem, color_highlight+1);
        end else begin
            // set the listbox-colors to unselected state
            settextcolor(hdc,getsyscolor(color_windowtext));
            setbkcolor(hdc,getsyscolor(color_window));
            fillrect(hdc,rcitem, color_window+1);
        end;

        if kind <> 2 then sr := getshicon(sr,icon) else icon := 3; // for [..] dir, this should be the folder-icon

        // now set the indent of the item
        case kind of
             0 : kind := iconheight div 2 //about 8 pixels to the right for subdirectories
        else kind := 0;
        end ;
        imagelist_draw(shlv,icon,hDC,rcItem.left+kind+3,rcitem.top+1,1); // draws the icon
        TextOut(hDC,rcItem.left+iconheight+kind+8,   // draw either the shell's displayname or ".."
          rcitem.top+2,@sr[1],length(sr));

     end;
  end;


BEGIN (* selDialogProc *)

   RESULT := TRUE;
   CASE DlgMessage OF
      wm_drawitem   : drawlistbox; // draws a listbox entry
      WM_INITDIALOG : BEGIN
                      addseldir; // adds a '\' to seldir
                      if not fileexists(seldir) then
                         getcurrentdirectory(fsmaxpath,seldir); // to prevent from showing senseless pathes

                     // calculate the listbox' item-height (shell-small-icon-height+2)
                     iconheight := getsystemmetrics(sm_cysmicon);
                     sendmessage(getdlgitem(dlgsel,ci_listbox),lb_setitemheight,0,iconheight+2);
                     (* Center dialog on screen.       *)
                     CenterDialog(dlgsel);
                     // fill the dialog with the directory-contents
                     setit;
                  END;
                 (* Handle button presses, etc. *)

         WM_COMMAND    : CASE LOWORD(DlgWParam) OF
                            ci_listbox : case hiword(dlgwparam) of
                                        lbn_dblclk : begin  // a diff. path has been dblckicked on the listbox
                               DlgDirSelectEx(dlgsel,seldir,fsmaxpath,ci_listbox); // get the chosen path
                               addseldir; // add a '\'
                               setit;     // fill the dialog
                                                     end;
                                        // repaint the listbox if its focus-stae has been changed
                                        lbn_killfocus,lbn_setfocus : invalidaterect(getdlgitem(dlgsel,ci_listbox),nil,true);
                            end;
                            // allow to connect a network-drive
                            ci_net    : if wnetconnectiondialog(dlgsel,resourcetype_disk) = no_error then setit;
                            // okay, the current directory has been choosen, end this dialog
                            CM_OK     : BEGIN
                               addseldir;
                               EndDialog(dlgsel, LOWORD(DlgWParam));
                               EXIT;
                            END;
                            // open the create-subdir dialog
                           ci_new:
                                if DialogBox( hInstance, 'DLGNEW', dlgsel, @newdirProc ) = idok then begin
                                   setit;
                               end;
                           CM_CANCEL : BEGIN
                               EndDialog(dlgsel, LOWORD(DlgWParam));
                               EXIT;
                            END;
                         ELSE      ;
                         END (* CASE *);
         ELSE          ;
     END (* CASE *);
     RESULT := FALSE;
END   (* selDialogProc *);
(*--------------------------------------------------------------------------*)

(*--------------------------------------------------------------------------*)
(*     newdirProc --- Handle messages for add subdir dialog.           *)
(*--------------------------------------------------------------------------*)
FUNCTION newdirProc(dlgnew     : hWnd ;
                         DlgMessage : UINT;
                         DlgWParam  : WPARAM ;
                         DlgLParam  : LPARAM) : BOOL; STDCALL;

var buffer : pchar;
BEGIN (* selDialogProc *)

   RESULT := TRUE;
   CASE DlgMessage OF
      WM_INITDIALOG : BEGIN
                      addseldir;
                     (* Center dialog on screen.       *)
                     CenterDialog(dlgnew);
                     setdlgitemtext(dlgnew,cn_path,seldir);
                     setfocus(getdlgitem(dlgnew,cn_edit));
                  END;
                 (* Handle button presses, etc. *)

         WM_COMMAND    : CASE LOWORD(DlgWParam) OF
                            CM_OK     : BEGIN

                               // make subdirs;
                               getmem(buffer,max_path+1);
                               getdlgitemtext(dlgnew,cn_edit,buffer,max_path);
                               if strlen(buffer) <> 0 then
                                  if not forcedirs(seldir,buffer) then
                                     messagebox(dlgnew,'Couldn''t create directory','Error',
                                     mb_iconerror) else begin
                                     if strlen(seldir)+strlen(buffer)+1 < fsmaxpath then
                                        move(buffer[0],seldir[strlen(seldir)],strlen(buffer)+1);
                                     freemem(buffer);

                                     EndDialog(dlgnew, LOWORD(DlgWParam));
                                     //EXIT;

                                 end;
                            END;
                           CM_CANCEL : BEGIN
                               EndDialog(dlgnew, LOWORD(DlgWParam));
                               //EXIT;
                            END;
                         ELSE      ;
                         END (* CASE *);
         ELSE          ;
     END (* CASE *);
     RESULT := FALSE;
END   (* newdirProc *);
(*--------------------------------------------------------------------------*)





initialization
              getmem(seldir,max_path+1);
              getmem(storedpath,max_path+1);
              getmem(commandline,max_path+1);
              getmem(caption,max_path+1);
finalization
            freemem(seldir);
            freemem(storedpath);
            freemem(commandline);
            freemem(caption);

END.
