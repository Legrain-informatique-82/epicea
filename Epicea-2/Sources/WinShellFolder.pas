{ WinShellFolder
  parts of Shell32 API, interface unit

  replacement of SHFolder unit by borland.

  Deefaze (cc) 2008
  www.delphifr.com

  Copyright (c) 1985-1999, Microsoft Corporation


simplified functions :
  GetFolderPath                Layer of SHGetFolderPathA
  TryGetFolderPath             Superset of GetFolderPath
  GetFolderPathAndSubDir       Layer of SHGetFolderPathAndSubDirA
  TryGetFolderPathAndSubDir    Superset of GetFolderPathAndSubDir
  GetSpecialFolderPath         Layer of SHGetSpecialFolderPath
  TryGetSpecialFolderPath      Superset of GetSpecialFolderPath

original API functions and alias :
  SHGetFolderPath              Alias of SHGetFolderPathA
  SHGetFolderPathA
  SHGetFolderPathW

  SHGetFolderPathAndSubDir     Alias of SHGetFolderPathAndSubDirA
  SHGetFolderPathAndSubDirA
  SHGetFolderPathAndSubDirW

  SHGetSpecialFolderPath       Alias of SHGetSpecialFolderPathA
  SHGetSpecialFolderPathA
  SHGetSpecialFolderPathW

constantes :
  All FP* constantes are alias of original constante of the Shell32 API,
  and specialy designed for Delphi IDE & Borland code convention.
}
unit WinShellFolder;

interface

uses Windows, SysUtils;

{ SHGetFolderPath

  Takes the CSIDL of a folder and returns the path.

  Parameters :

    hwndOwner [i] Handle to an owner window. This parameter is typically set to NULL. If it is not NULL,
                  and a dial-up connection needs to be made to access the folder, a user interface (UI) prompt
                  will appear in this window.
    nFolder   [i] A CSIDL value that identifies the folder whose path is to be retrieved. Only real folders are valid.
                  If a virtual folder is specified, this function will fail. You can force creation of a folder with
                  SHGetFolderPath by combining the folder's CSIDL with CSIDL_FLAG_CREATE.
    hToken    [i] An access token that can be used to represent a particular user. For systems earlier than
                  Microsoft Windows 2000, it should be set to NULL. For later systems, hToken is usually set to NULL.
                  However, you may need to assign a value to hToken for those folders that can have multiple users but
                  are treated as belonging to a single user. The most commonly used folder of this type is Documents.

                  The caller is responsible for correct impersonation when hToken is non-NULL. It must have appropriate
                  security privileges for the particular user, including TOKEN_QUERY and TOKEN_IMPERSONATE, and the
                  user's registry hive must be currently mounted. See Access Control for further discussion of access
                  control issues.

                  Assigning the hToken parameter a value of -1 indicates the Default User. This allows clients of
                  SHGetFolderPath to find folder locations (such as the Desktop folder) for the Default User. The
                  Default User user profile is duplicated when any new user account is created, and includes special
                  folders such as My Documents and Desktop. Any items added to the Default User folder also appear in
                  any new user account.

    dwFlags   [i] Flags to specify which path is to be returned. It is used for cases where the folder associated with
                  a CSIDL may be moved or renamed by the user.
                      SHGFP_TYPE_CURRENT  Return the folder's current path.
                      SHGFP_TYPE_DEFAULT  Return the folder's default path.
    pszPath   [o] Pointer to a null-terminated string of length MAX_PATH which will receive the path. If an error
                  occurs or S_FALSE is returned, this string will be empty.

  Return Value :
    Returns standard HRESULT codes, including the following:
        S_FALSE        SHGetFolderPathA only. The CSIDL in nFolder is valid, but the folder does not exist.
                       Note : that the failure code is different for the ANSI and Unicode versions of this function.
        E_FAIL         SHGetFolderPathW only. The CSIDL in nFolder is valid, but the folder does not exist.
                       Note : that the failure code is different for the ANSI and Unicode versions of this function.
        E_INVALIDARG   The CSIDL in nFolder is not valid.


  Remarks :
    This function is a superset of SHGetSpecialFolderPath, included with earlier versions of the Shell. On systems
    preceeding those including Shell32.dll version 5.0 (Windows Millennium Edition (Windows Me) and Windows 2000),
    SHGetFolderPath was obtained through SHFolder.dll, distributed with Microsoft Internet Explorer 4.0 and later
    versions. SHFolder.dll always calls the current platform's version of this function. If that fails, it will try to
    simulate the appropriate behavior. SHFolder.dll continues to be included for backward compatibility, though the
    function is now implemented in Shell32.dll.

    Note : On older systems that require the redistributable SHFolder.dll, you must explicitly link to SHFolder.lib
    before you link to Shell32.lib.

CSIDL_WINDOWS ;36;C:\WINDOWS
CSIDL_SYSTEM ;37;C:\WINDOWS\SYSTEM
CSIDL_PROGRAM_FILES ;38;C:\Program Files
CSIDL_MYPICTURES ;39;C:\Mes documents\Mes images
CSIDL_PROGRAM_FILES_COMMON ;43;C:\Program Files\Fichiers communs
CSIDL_COMMON_DOCUMENTS ;46;
CSIDL_DESKTOP ;0;C:\WINDOWS\Bureau
CSIDL_INTERNET ;1;
CSIDL_PROGRAMS ;2;C:\WINDOWS\Menu Démarrer\Programmes
CSIDL_CONTROLS ;3;
CSIDL_PRINTERS ;4;
CSIDL_PERSONAL ;5;C:\Mes documents
CSIDL_FAVORITES ;6;C:\WINDOWS\Favoris
CSIDL_STARTUP ;7;C:\WINDOWS\Menu Démarrer\Programmes\Démarrage
CSIDL_RECENT ;8;C:\WINDOWS\Recent
CSIDL_SENDTO ;9;C:\WINDOWS\SendTo
CSIDL_STARTMENU ;11;C:\WINDOWS\Menu Démarrer
CSIDL_NETWORK ;18;
CSIDL_NETHOOD ;19;C:\WINDOWS\Voisinage réseau
CSIDL_FONTS ;20;C:\WINDOWS\FONTS
CSIDL_COMMON_STARTMENU ;22;
CSIDL_COMMON_PROGRAMS ;23;C:\WINDOWS\All Users\Menu Démarrer\Programmes
CSIDL_COMMON_STARTUP ;24;
CSIDL_COMMON_DESKTOPDIRECTORY ;25;C:\WINDOWS\All users\Bureau
CSIDL_APPDATA ;26;C:\WINDOWS\Application Data
CSIDL_PRINTHOOD ;27;C:\WINDOWS\PrintHood
CSIDL_ALTSTARTUP ;29;
CSIDL_COMMON_ALTSTARTUP ;30;
CSIDL_COMMON_FAVORITES ;31;
CSIDL_TEMPLATES ;
CSIDL_INTERNET_CACHE ;32;C:\WINDOWS\Temporary Internet Files
CSIDL_COOKIES ;33;C:\WINDOWS\Cookies
CSIDL_HISTORY ;34;C:\WINDOWS\Historique


    Only some CSIDLs are supported, including the following:
        CSIDL_ADMINTOOLS
        CSIDL_COMMON_ADMINTOOLS
        CSIDL_APPDATA
        CSIDL_COMMON_APPDATA
        CSIDL_COMMON_DOCUMENTS
        CSIDL_COOKIES
        CSIDL_FLAG_CREATE
        CSIDL_HISTORY
        CSIDL_INTERNET_CACHE
        CSIDL_LOCAL_APPDATA
        CSIDL_MYPICTURES
        CSIDL_PERSONAL
        CSIDL_PROGRAM_FILES
        CSIDL_PROGRAM_FILES_COMMON
        CSIDL_SYSTEM
        CSIDL_WINDOWS
        CSIDL_FLAG_DONT_VERIFY
}
function SHGetFolderPath(hwndOwner: HWND; nFolder: integer; hToken: integer; dwFlags: DWORD;   pszPath: PChar): HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPath}

function SHGetFolderPathA(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: PAnsiChar): HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPathA}

function SHGetFolderPathW(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord;   pszPath: PWideChar): HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPathW}

{ Delphi simplified SHGetFolderPath }
function GetFolderPath(AFolderCSIDL: Integer) : string;
function TryGetFolderPath(AFolderCSIDL: Integer; var Path: string): boolean;

{ SHGetFolderPathAndSubDir

  Accepts the CSIDL of a folder and returns the path to that directory, appending a user-provided subdirectory path.

  Parameters :
    hwnd      [i] Handle to an owner window. This parameter is typically set to NULL. If it is not NULL, and a
                  dial-up connection needs to be made to access the folder, a user interface (UI) prompt appears
                  in this window.
    csidl     [i] A CSIDL value that identifies the folder whose path is to be retrieved. Only real folders are valid.
                  If a virtual folder is specified, this function fails. You can force creation of a folder with
                  SHGetFolderPathAndSubDir by combining the folder's CSIDL with CSIDL_FLAG_CREATE.
    hToken    [i] An access token that you can use to represent a particular user. For systems earlier than
                  Microsoft Windows 2000, set it to NULL. For later systems, hToken is usually, but not always, set
                  to NULL. You might need to assign a value to hToken for those folders that can have multiple users
                  but are treated as belonging to a single user. The most commonly used folder of this type is
                  My Documents.
    dwFlags   [i] A flag to specify whether the path to be returned is the actual path or the default path. It is
                  used in cases where the folder associated with a CSIDL value may be moved or renamed by the user.
                      SHGFP_TYPE_CURRENT  Return the folder's current path.
                      SHGFP_TYPE_DEFAULT  Return the folder's default path.
    pszSubDir [i] Pointer to a null-terminated string of length MAX_PATH that contains the subpath to be appended to
                  the folder's path. If you are not creating a new directory, this must be an existing subdirectory or
                  the function returns an error.
    pszPath   [o] Pointer to a null-terminated string of length MAX_PATH that receives the directory path and appended
                  subpath. This string is empty when the function returns an error code or S_FALSE.

  Return Value :
    Returns a standard OLE-defined error result or one of the following values.
        S_OK          Success.
        S_FALSE       The CSIDL value in csidl is valid, but the folder (including the appended subdirectory)
                      does not exist.
        E_INVALIDARG  The CSIDL value in csidl is not valid.
}
function SHGetFolderPathAndSubDir(hwnd: HWND; csidl: integer; hToken: THandle; dwFlags: DWORD; pszSubDir: PChar;   pszPath: PChar): HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPathAndSubDir}

function SHGetFolderPathAndSubDirA(hwnd: HWND; csidl: integer; hToken: THandle; dwFlags: DWORD; pszSubDir: PAnsiChar;   pszPath: PAnsiChar): HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPathAndSubDir}

function SHGetFolderPathAndSubDirW(hwnd: HWND; csidl: integer; hToken: THandle; dwFlags: DWORD; pszSubDir: PWideChar; pszPath: PWideChar): HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPathAndSubDir}


{ Delphi simplified SHGetFolderPathAndSubDir }
function GetFolderPathAndSubDir(AFolderCSIDL : integer; const ASubDir: string) : string;
function TryGetFolderPathAndSubDir(AFolderCSIDL: Integer; const ASubDir: string; var Path: string): boolean;


{ SHGetSpecialFolderPath

  Retrieves the path of a special folder, identified by its CSIDL.

  Parameters :
    hwndOwner [i] Reserved, Handle to the owner window the client should specify if it displays a dialog box or
                  message box.
    lpszPath  [o] Pointer to a null-terminated string that receives the drive and path of the specified folder. This
                  buffer must be at least MAX_PATH characters in size.
    nFolder   [i] A CSIDL that identifies the folder of interest. If a virtual folder is specified, this function
                  will fail.
    fCreate   [i] Indicates if the folder should be created if it does not already exist. If this value is nonzero,
                  the folder will be created. If this value is zero, the folder will not be created.

  Return Value :
    Returns TRUE if successful, or FALSE otherwise.

  Remarks :
    The Microsoft Internet Explorer 4.0 Desktop Update must be installed for this function to be available.
    With Microsoft Windows 2000, this function is superseded by ShGetFolderPath. You can use this function on
    earlier systems by including the redistributable DLL, ShFolder.dll.
}
function SHGetSpecialFolderPath(hwndOwner: HWND; lpszPath: PChar; nFolder: Integer; fCreate: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHGetSpecialFolderPath}

function SHGetSpecialFolderPathA(hwndOwner: HWND; lpszPath: PAnsiChar; nFolder: Integer; fCreate: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHGetSpecialFolderPathA}

function SHGetSpecialFolderPathW(hwndOwner: HWND; lpszPath: PWideChar; nFolder: Integer; fCreate: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHGetSpecialFolderPathW}

{ Delphi simplified SHGetSpecialFolderPath }
function GetSpecialFolderPath(AFolderCSIDL : integer; ACreateDir: BOOL) : string;
function TryGetSpecialFolderPath(AFolderCSIDL: Integer; ACreateDir: BOOL; var Path: string): boolean;



const
  CSIDL_ADMINTOOLS = $0030;
  {$EXTERNALSYM CSIDL_ADMINTOOLS}
  { Version 5.0. The file system directory that is used to store administrative tools for an individual user.
    The Microsoft Management Console (MMC; will save customized consoles to this directory, and it will roam with
    the user.
  }

  CSIDL_ALTSTARTUP = $001d;
  {$EXTERNALSYM CSIDL_ALTSTARTUP}
  { The file system directory that corresponds to the user's nonlocalized Startup program group.
  }

  CSIDL_APPDATA = $001a;
  {$EXTERNALSYM CSIDL_APPDATA}
  { Version 4.71. The file system directory that serves as a common repository for application-specific data.
    C:\Documents and Settings\username\Application Data.
    This CSIDL is supported by the redistributable Shfolder.dll for systems that do not have the
    Microsoft Internet Explorer 4.0 integrated Shell installed.
  }

  CSIDL_BITBUCKET = $000a;
  {$EXTERNALSYM CSIDL_BITBUCKET}
  { The virtual folder containing the objects in the user's Recycle Bin.
  }

  CSIDL_CDBURN_AREA = $003b;
  {$EXTERNALSYM CSIDL_CDBURN_AREA}
  { Version 6.0. The file system directory acting as a staging area for files waiting to be written to CD.
    C:\Documents and Settings\username\Local Settings\Application Data\Microsoft\CD Burning.
  }

  CSIDL_COMMON_ADMINTOOLS = $002f;
  {$EXTERNALSYM CSIDL_COMMON_ADMINTOOLS}
  { Version 5.0. The file system directory containing administrative tools for all users of the computer.
  }

  CSIDL_COMMON_APPDATA = $0023;
  {$EXTERNALSYM CSIDL_COMMON_APPDATA}
  { Version 5.0. The file system directory containing application data for all users.
    C:\Documents and Settings\All Users\Application Data.
  }

  CSIDL_COMMON_ALTSTARTUP = $001e;
  {$EXTERNALSYM CSIDL_COMMON_ALTSTARTUP}
  { The file system directory that corresponds to the nonlocalized Startup program group for all users.
    Valid only for Microsoft Windows NT systems.
  }

  CSIDL_COMMON_DESKTOPDIRECTORY = $0019;
  {$EXTERNALSYM CSIDL_COMMON_DESKTOPDIRECTORY}
  { The file system directory that contains files and folders that appear on the desktop for all users.
    C:\Documents and Settings\All Users\Desktop.
    Valid only for Windows NT systems.
  }

  CSIDL_COMMON_DOCUMENTS = $002e;
  {$EXTERNALSYM CSIDL_COMMON_DOCUMENTS}
  { The file system directory that contains documents that are common to all users.
    C:\Documents and Settings\All Users\Documents.
    Valid for Windows NT systems and Microsoft Windows 95 and Windows 98 systems with Shfolder.dll installed.
  }

  CSIDL_COMMON_FAVORITES = $001f;
  {$EXTERNALSYM CSIDL_COMMON_FAVORITES}
  { The file system directory that serves as a common repository for favorite items common to all users.
    Valid only for Windows NT systems.
  }

  CSIDL_COMMON_MUSIC = $0035;
  {$EXTERNALSYM CSIDL_COMMON_MUSIC}
  { Version 6.0. The file system directory that serves as a repository for music files common to all users.
    C:\Documents and Settings\All Users\Documents\My Music.
  }

  CSIDL_COMMON_PICTURES = $0036;
  {$EXTERNALSYM CSIDL_COMMON_PICTURES}
  { Version 6.0. The file system directory that serves as a repository for image files common to all users.
    C:\Documents and Settings\All Users\Documents\My Pictures.
  }

  CSIDL_COMMON_PROGRAMS = $0017;
  {$EXTERNALSYM CSIDL_COMMON_PROGRAMS}
  { The file system directory that contains the directories for the common program groups that appear on
    the Start menu for all users.
    C:\Documents and Settings\All Users\Start Menu\Programs.
    Valid only for Windows NT systems.
  }

  CSIDL_COMMON_STARTMENU = $0016;
  {$EXTERNALSYM CSIDL_COMMON_STARTMENU}
  { The file system directory that contains the programs and folders that appear on the Start menu for all users.
    C:\Documents and Settings\All Users\Start Menu.
    Valid only for Windows NT systems.
  }

  CSIDL_COMMON_STARTUP = $0018;
  {$EXTERNALSYM CSIDL_COMMON_STARTUP}
  { The file system directory that contains the programs that appear in the Startup folder for all users.
    C:\Documents and Settings\All Users\Start Menu\Programs\Startup.
    Valid only for Windows NT systems.
  }

  CSIDL_COMMON_TEMPLATES = $002d;
  {$EXTERNALSYM CSIDL_COMMON_TEMPLATES}
  { The file system directory that contains the templates that are available to all users. A typical path is
    C:\Documents and Settings\All Users\Templates.
    Valid only for Windows NT systems.
  }

  CSIDL_COMMON_VIDEO = $0037;
  {$EXTERNALSYM CSIDL_COMMON_VIDEO}
  { Version 6.0. The file system directory that serves as a repository for video files common to all users.
    C:\Documents and Settings\All Users\Documents\My Videos.
  }

  CSIDL_COMPUTERSNEARME = $003d;
  {$EXTERNALSYM CSIDL_COMPUTERSNEARME}
  { The folder representing other machines in your workgroup.
  }

  CSIDL_CONNECTIONS = $0031;
  {$EXTERNALSYM CSIDL_CONNECTIONS}
  { The virtual folder representing Network Connections, containing network and dial-up connections.
  }

  CSIDL_CONTROLS = $0003;
  {$EXTERNALSYM CSIDL_CONTROLS}
  { The virtual folder containing icons for the Control Panel applications.
  }

  CSIDL_COOKIES = $0021;
  {$EXTERNALSYM CSIDL_COOKIES}
  { The file system directory that serves as a common repository for Internet cookies.
    C:\Documents and Settings\username\Cookies.
  }

  CSIDL_DESKTOP = $0000;
  {$EXTERNALSYM CSIDL_DESKTOP}
  { The virtual folder representing the Windows desktop, the root of the namespace.
  }

  CSIDL_DESKTOPDIRECTORY = $0010;
  {$EXTERNALSYM CSIDL_DESKTOPDIRECTORY}
  { The file system directory used to physically store file objects on the desktop (not to be confused with
    the desktop folder itself).
    C:\Documents and Settings\username\Desktop.
  }

  CSIDL_DRIVES = $0011;
  {$EXTERNALSYM CSIDL_DRIVES}
  { The virtual folder representing My Computer, containing everything on the local computer:
    storage devices, printers, and Control Panel. The folder may also contain mapped network drives.
  }

  CSIDL_FAVORITES = $0006;
  {$EXTERNALSYM CSIDL_FAVORITES}
  { The file system directory that serves as a common repository for the user's favorite items.
    C:\Documents and Settings\username\Favorites.
  }

  CSIDL_FLAG_CREATE = $8000;
  {$EXTERNALSYM CSIDL_FLAG_CREATE}
  { Version 5.0. Combine this CSIDL with any of the following CSIDLs to force the creation of the associated folder.
  }

  CSIDL_FLAG_DONT_UNEXPAND = $2000;
  {$EXTERNALSYM CSIDL_FLAG_DONT_UNEXPAND}
  { Combine with another CSIDL constant to ensure expanding of environment variables.
  }

  CSIDL_FLAG_DONT_VERIFY = $4000;
  {$EXTERNALSYM CSIDL_FLAG_DONT_VERIFY}
  { Combine with another CSIDL constant, except for CSIDL_FLAG_CREATE, to return an unverified folder path—with
    no attempt to create or initialize the folder.
  }

  CSIDL_FONTS = $0014;
  {$EXTERNALSYM CSIDL_FONTS}
  { A virtual folder containing fonts. C:\Windows\Fonts.
  }

  CSIDL_HISTORY = $0022;
  {$EXTERNALSYM CSIDL_HISTORY}
  { The file system directory that serves as a common repository for Internet history items.
  }

  CSIDL_INTERNET = $0001;
  {$EXTERNALSYM CSIDL_INTERNET}
  { A viritual folder for Internet Explorer (icon on desktop).
  }

  CSIDL_INTERNET_CACHE = $0020;
  {$EXTERNALSYM CSIDL_INTERNET_CACHE}
  { Version 4.72. The file system directory that serves as a common repository for temporary Internet files.
    C:\Documents and Settings\username\Local Settings\Temporary Internet Files.
  }

  CSIDL_LOCAL_APPDATA = $001c;
  {$EXTERNALSYM CSIDL_LOCAL_APPDATA}
  { Version 5.0. The file system directory that serves as a data repository for local (nonroaming) applications.
    C:\Documents and Settings\username\Local Settings\Application Data.
  }

  CSIDL_MYDOCUMENTS = $000c;
  {$EXTERNALSYM CSIDL_MYDOCUMENTS}
  { Version 6.0. The virtual folder representing the My Documents desktop item.
  }

  CSIDL_MYMUSIC = $000d;
  {$EXTERNALSYM CSIDL_MYMUSIC}
  { The file system directory that serves as a common repository for music files.
    C:\Documents and Settings\User\My Documents\My Music.
  }

  CSIDL_MYPICTURES = $0027;
  {$EXTERNALSYM CSIDL_MYPICTURES}
  { Version 5.0. The file system directory that serves as a common repository for image files.
    C:\Documents and Settings\username\My Documents\My Pictures.
  }

  CSIDL_MYVIDEO = $000e;
  {$EXTERNALSYM CSIDL_MYVIDEO}
  { Version 6.0. The file system directory that serves as a common repository for video files.
    C:\Documents and Settings\username\My Documents\My Videos.
  }

  CSIDL_NETHOOD = $0013;
  {$EXTERNALSYM CSIDL_NETHOOD}
  { A file system directory containing the link objects that may exist in the My Network Places virtual folder.
    It is not the same as CSIDL_NETWORK, which represents the network namespace root.
    C:\Documents and Settings\username\NetHood.
  }

  CSIDL_NETWORK = $0012;
  {$EXTERNALSYM CSIDL_NETWORK}
  { A virtual folder representing Network Neighborhood, the root of the network namespace hierarchy.
  }

  CSIDL_PERSONAL = $0005;
  {$EXTERNALSYM CSIDL_PERSONAL}
  { Version 6.0. The virtual folder representing the My Documents desktop item.
    This is equivalent to CSIDL_MYDOCUMENTS. Previous to Version 6.0. The file system directory used to physically
    store a user's common repository of documents.
    C:\Documents and Settings\username\My Documents.
    This should be distinguished from the virtual My Documents folder in the namespace. To access that virtual folder,
    use SHGetFolderLocation, which returns the ITEMIDLIST for the virtual location, or refer to the technique described
    in Managing the File System.
  }

  CSIDL_PHOTOALBUMS = $0045;
  {$EXTERNALSYM CSIDL_PHOTOALBUMS}
  { Windows Vista. The virtual folder used to store photo albums,
    username\My Pictures\Photo Albums.
  }

  CSIDL_PLAYLISTS = $003f;
  {$EXTERNALSYM CSIDL_PLAYLISTS}
  { Windows Vista. The virtual folder used to store play albums,
    username\My Music\Playlists.
  }

  CSIDL_PRINTERS = $0004;
  {$EXTERNALSYM CSIDL_PRINTERS}
  { The virtual folder containing installed printers.
  }

  CSIDL_PRINTHOOD = $001b;
  {$EXTERNALSYM CSIDL_PRINTHOOD}
  { The file system directory that contains the link objects that can exist in the Printers virtual folder.
    C:\Documents and Settings\username\PrintHood.
  }

  CSIDL_PROFILE = $0028;
  {$EXTERNALSYM CSIDL_PROFILE}
  { Version 5.0. The user's profile folder.
    C:\Documents and Settings\username.
    Applications should not create files or folders at this level; they should put their data under the locations
    referred to by CSIDL_APPDATA or CSIDL_LOCAL_APPDATA.
  }

  CSIDL_PROGRAMS = $0002;
  {$EXTERNALSYM CSIDL_PROGRAMS}
  { The file system directory that contains the user's program groups (which are themselves file system directories).
    C:\Documents and Settings\username\Start Menu\Programs.
  }

  CSIDL_PROGRAM_FILES = $0026;
  {$EXTERNALSYM CSIDL_PROGRAM_FILES}
  { Version 5.0. The Program Files folder.
    C:\Program Files.
  }

  CSIDL_PROGRAM_FILES_COMMON = $002b;
  {$EXTERNALSYM CSIDL_PROGRAM_FILES_COMMON}
  { Version 5.0. A folder for components that are shared across applications.
    C:\Program Files\Common.
    Valid only for Windows NT, Windows 2000, and Windows XP systems. Not valid for Windows ME.
  }

  CSIDL_RECENT = $0008;
  {$EXTERNALSYM CSIDL_RECENT}
  { The file system directory that contains shortcuts to the user's most recently used documents.
    C:\Documents and Settings\username\My Recent Documents.
    To create a shortcut in this folder, use SHAddToRecentDocs. In addition to creating the shortcut, this function
    updates the Shell's list of recent documents and adds the shortcut to the My Recent Documents submenu of
    the Start menu.
  }

  CSIDL_RESOURCES = $0038;
  {$EXTERNALSYM CSIDL_RESOURCES}
  { Windows Vista. The file system directory that contains resource data.
    C:\Windows\Resources.
  }

  CSIDL_SAMPLE_MUSIC = $0040;
  {$EXTERNALSYM CSIDL_SAMPLE_MUSIC}
  { Windows Vista. The file system directory that contains sample music.
    C:\Documents and Settings\username\My Documents\My Music\Sample Music.
  }

  CSIDL_SAMPLE_PLAYLISTS = $0041;
  {$EXTERNALSYM CSIDL_SAMPLE_PLAYLISTS}
  { Windows Vista. The file system directory that contains sample playlists.
    C:\Documents and Settings\username\My Documents\My Music\Sample Playlists.
  }

  CSIDL_SAMPLE_PICTURES = $0042;
  {$EXTERNALSYM CSIDL_SAMPLE_PICTURES}
  { Windows Vista. The file system directory that contains sample pictures.
    C:\Documents and Settings\username\My Documents\My Pictures\Sample Pictures.
  }

  CSIDL_SAMPLE_VIDEOS = $0043;
  {$EXTERNALSYM CSIDL_SAMPLE_VIDEOS}
  { Windows Vista. The file system directory that contains sample videos.
    C:\Documents and Settings\username\My Documents\My Videos\Sample Videos.
  }

  CSIDL_SENDTO = $0009;
  {$EXTERNALSYM CSIDL_SENDTO}
  { The file system directory that contains Send To menu items.
    C:\Documents and Settings\username\SendTo.
  }

  CSIDL_STARTMENU = $000b;
  {$EXTERNALSYM CSIDL_STARTMENU}
  { The file system directory containing Start menu items.
    C:\Documents and Settings\username\Start Menu.
  }

  CSIDL_STARTUP = $0007;
  {$EXTERNALSYM CSIDL_STARTUP}
  { The file system directory that corresponds to the user's Startup program group. The system starts these programs
    whenever any user logs onto Windows NT or starts Windows 95.
    C:\Documents and Settings\username\Start Menu\Programs\Startup.
  }

  CSIDL_SYSTEM = $0025;
  {$EXTERNALSYM CSIDL_SYSTEM}
  { Version 5.0. The Windows System folder.
    C:\Windows\System32.
  }

  CSIDL_TEMPLATES = $0015;
  {$EXTERNALSYM CSIDL_TEMPLATES}
  { The file system directory that serves as a common repository for document templates.
    C:\Documents and Settings\username\Templates.
  }

  CSIDL_WINDOWS = $0024;
  {$EXTERNALSYM CSIDL_WINDOWS}
  { Version 5.0. The Windows directory or SYSROOT. This correpsonds to the %windir% or %SYSTEMROOT%.
    environment variables
    C:\Windows
  }

const
  { simplified CSIDL }

  { All users }
  FPAllUsersAppData      = CSIDL_COMMON_APPDATA;
  FPAllUsersDesktop      = CSIDL_COMMON_DESKTOPDIRECTORY;
  FPAllUsersDocuments    = CSIDL_COMMON_DOCUMENTS;
  FPAllUsersFavorites    = CSIDL_COMMON_FAVORITES;
  FPAllUsersMusic        = CSIDL_COMMON_MUSIC;
  FPAllUsersPictures     = CSIDL_COMMON_PICTURES;
  FPAllUsersProgramsMenu = CSIDL_COMMON_PROGRAMS;
  FPAllUsersStartMenu    = CSIDL_COMMON_STARTMENU;
  FPAllUsersStartupMenu  = CSIDL_COMMON_STARTUP;
  FPAllUsersTemplates    = CSIDL_COMMON_TEMPLATES;
  FPAllUsersVideos       = CSIDL_COMMON_VIDEO;

  { Current user }
  FPCurUser                    = CSIDL_PROFILE;
  FPCurUserAppData             = CSIDL_APPDATA;
  FPCurUserCDBurnAera          = CSIDL_CDBURN_AREA;
  FPCurUserCookies             = CSIDL_COOKIES;
  FPCurUserDesktop             = CSIDL_DESKTOPDIRECTORY;
  FPCurUserDocuments           = CSIDL_PERSONAL;
  FPCurUserFavorites           = CSIDL_FAVORITES;
  FPCurUserInternetCache       = CSIDL_INTERNET_CACHE;
  FPCurUserLocalAppData        = CSIDL_LOCAL_APPDATA;
  FPCurUserMusic               = CSIDL_MYMUSIC;
  FPCurUserMusicPlaylists      = CSIDL_PLAYLISTS;
  FPCurUserMusicSamples        = CSIDL_SAMPLE_PLAYLISTS;
  FPCurUserNethood             = CSIDL_NETHOOD;
  FPCurUserPictures            = CSIDL_MYPICTURES;
  FPCurUserPicturesPhotoAlbums = CSIDL_PHOTOALBUMS;
  FPCurUserPicturesSamples     = CSIDL_SAMPLE_PICTURES;
  FPCurUserPrinthood           = CSIDL_PRINTHOOD;
  FPCurUserProgramsMenu        = CSIDL_PROGRAMS;
  FPCurUserRecentDoc           = CSIDL_RECENT;
  FPCurUserSendTo              = CSIDL_SENDTO;
  FPCurUserStartMenu           = CSIDL_STARTMENU;
  FPCurUserStartupMenu         = CSIDL_STARTUP;
  FPCurUserTemplates           = CSIDL_TEMPLATES;
  FPCurUserVideosSamples       = CSIDL_SAMPLE_VIDEOS;

  { Windows }
  FPWindows             = CSIDL_WINDOWS;
  FPWindowsCommonFiles  = CSIDL_PROGRAM_FILES_COMMON;
  FPWindowsFonts        = CSIDL_FONTS;
  FPWindowsProgramFiles = CSIDL_PROGRAM_FILES;
  FPWindowsResources    = CSIDL_RESOURCES;
  FPWindowsSystem       = CSIDL_SYSTEM;

  FPACAllUsersFolders : array[0..10] of integer = (
    FPAllUsersAppData, FPAllUsersDesktop, FPAllUsersDocuments, FPAllUsersFavorites,
    FPAllUsersMusic, FPAllUsersPictures, FPAllUsersProgramsMenu, FPAllUsersStartMenu,
    FPAllUsersStartupMenu, FPAllUsersTemplates, FPAllUsersVideos
  );

  FPACCurrentUserFolders : array[0..23] of integer = (
    FPCurUser, FPCurUserAppData, FPCurUserCDBurnAera, FPCurUserCookies,
    FPCurUserDesktop, FPCurUserDocuments, FPCurUserFavorites, FPCurUserInternetCache,
    FPCurUserLocalAppData, FPCurUserMusic, FPCurUserMusicPlaylists, FPCurUserMusicSamples,
    FPCurUserNethood, FPCurUserPictures, FPCurUserPicturesPhotoAlbums, FPCurUserPicturesSamples,
    FPCurUserPrinthood, FPCurUserProgramsMenu, FPCurUserRecentDoc, FPCurUserSendTo,
    FPCurUserStartMenu, FPCurUserStartupMenu, FPCurUserTemplates, FPCurUserVideosSamples
  );

  FPACWindowsFolders : array[0..5] of integer = (
    FPWindows, FPWindowsCommonFiles, FPWindowsFonts, FPWindowsProgramFiles,
    FPWindowsResources, FPWindowsSystem
  );

implementation

function GetFolderPath(AFolderCSIDL: Integer) : string;
var
  path   : array [0..MAX_PATH] of char;
begin
  if SUCCEEDED(SHGetFolderPath(0,AFolderCSIDL,0,0,@path[0])) then
    Result := path
  else
    Result := EmptyStr;
end;

function TryGetFolderPath(AFolderCSIDL: Integer; var Path: string): boolean;
var
  RPath : array [0..MAX_PATH] of char;
begin
  result := SUCCEEDED(SHGetFolderPath(0,AFolderCSIDL,0,0,@RPath[0]));
  if result then
    path := RPath
  else
    path := EmptyStr;
end;


function GetFolderPathAndSubDir(AFolderCSIDL : integer; const ASubDir: string) : string;
var
  path: array [0..MAX_PATH] of char;
begin
  if SUCCEEDED(SHGetFolderPathAndSubDir(0,AFolderCSIDL,0,0, PChar(ASubDir),@path[0])) then
    Result := path
  else
    Result := '';
end;

function TryGetFolderPathAndSubDir(AFolderCSIDL: Integer; const ASubDir: string; var path: string): boolean;
var
  RPath: array [0..MAX_PATH] of char;
begin
  result := SUCCEEDED(SHGetFolderPathAndSubDir(0,AFolderCSIDL,0,0, PChar(ASubDir),@RPath[0]));
  if result then
    path := RPath
  else
    path := EmptyStr;
end;

function GetSpecialFolderPath(AFolderCSIDL : integer; ACreateDir: BOOL) : string;
var
  path: array [0..MAX_PATH] of char;
begin
  if SHGetSpecialFolderPath(0,@Path[0],AFolderCSIDL, ACreateDir) then
    Result := path
  else
    Result := '';
end;

function TryGetSpecialFolderPath(AFolderCSIDL: Integer; ACreateDir: BOOL; var Path: string): boolean;
var
  RPath: array [0..MAX_PATH] of char;
begin
  result := SHGetSpecialFolderPath(0,@RPath[0],AFolderCSIDL, ACreateDir);
  if result then
    path := RPath
  else
    path := EmptyStr;
end;


const
  SHell32  = 'Shell32.dll';

function SHGetFolderPath;           external SHell32 name 'SHGetFolderPathA';
function SHGetFolderPathA;          external SHell32 name 'SHGetFolderPathA';
function SHGetFolderPathW;          external SHell32 name 'SHGetFolderPathW';

function SHGetFolderPathAndSubDir;  external SHell32 name 'SHGetFolderPathAndSubDirA';
function SHGetFolderPathAndSubDirA; external SHell32 name 'SHGetFolderPathAndSubDirA';
function SHGetFolderPathAndSubDirW; external SHell32 name 'SHGetFolderPathAndSubDirW';

function SHGetSpecialFolderPath;    external SHell32 name 'SHGetSpecialFolderPathA';
function SHGetSpecialFolderPathA;   external SHell32 name 'SHGetSpecialFolderPathA';
function SHGetSpecialFolderPathW;   external SHell32 name 'SHGetSpecialFolderPathW';


end.

