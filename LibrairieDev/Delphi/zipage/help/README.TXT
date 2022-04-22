                      DELPHI 2 HELP INSTALLATION
                   
1) Make sure Delphi is NOT running now.

2) Copy the .kwf file from \zip\help to Delphi's HELP directory.

3) Copy the .hlp file from \zip\help to Delphi's BIN directory.
   Make a backup copy of the .HDX file in the BIN directory.

4) Run HelpInst.exe from BIN subdir.

5) Open the .HDX file from HelpInst menu 
   (which is also in the BIN directory).

6) Press + to add the .kwf file
   (which is now in Delphi's HELP directory)

7) Save the new .HDX file from HelpInst menu.

8) Exit from HelpInst.


                      DELPHI 3 HELP INSTALLATION

1) Make sure Delphi is NOT running now.

2) Copy ZipMstr.hlp and ZipMstr.cnt from \zip\help
   to Delphi 3's help subdirectory.

3) In Delphi 3's Help subdirectory, edit Delphi3.cnt and 
   add the following two lines (add each one to the appropriate
   section in that small file):
:Index ZipMaster Component Help=ZipMstr.hlp
:include ZipMstr.cnt

4) In Delphi 3's Help subdirectory, delete the old 
   DELPHI3.GID and DELPHI3.FTS files.  This can be done easily 
   from Explorer.  Make sure Delphi is NOT running when you do 
   this. If you want to do it from an MS-DOS prompt, 
   you may need to un-hide them first:
C>attrib -r -h -s delphi3.gid 
C>del delphi3.gid
C>attrib -r -h -s delphi3.fts 
C>del delphi3.fts

5) The next time you use Delphi's Help feature, it'll say
   "preparing help file for first use".  This is when it is
   rebuilding the .GID file to include the new Help topics.
   The next time you do a full text search in Help, it'll 
   rebuild DELPHI3.FTS.  
