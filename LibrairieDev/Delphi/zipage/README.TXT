 
                         Delphi Zip, v1.40
              For Delphi 2 and 3, and C++ Builder v1.0


Quick summary of changes in this version:

   - Addition of many new Self-Extracting Archive properties
     (make it easy for you to distribute programs).  Demo1
     has been enhanced to demonstrate the new properties.

   - A new Demo program (number 4) to show how to make an 
     application self-installing.  It has a separate installation
     menu, and can be un-installed from the Control Panel.

   - A new native port of TZipMaster to C++ Builder!  The new
     BCB code is very good, and includes ports of demos 1 and 4.
    
   - New Delphi and C++ Builder Help files - you now get 
     context-sensitive help from within Delphi 3 and C++ Builder!
  

See \ZIP\DOC\CHANGES.TXT for details on changes and bug fixes.


Quick start:  Stop reading this file, and follow the 
instructions in file INST-VCL.TXT.


This release contains:

DELZIP14.EXE  - overall Freeware Delphi Zip v1.40 package.
                This is a setup program made with demo1,
                included in this package!

The main setup directory defaults to C:\ZIP.
The rest of this document assumes you selected that
directory for the install.

Files in Main directory:

  \ZIP\README.TXT   - this file

  \ZIP\INST-VCL.TXT - info. about how to install the VCLs and
                      run the demos
 
Delphi and General Subdirectories:

  \ZIP\DOC      - documentation about this release

  \ZIP\DLL      - the ZIPDLL and UNZDLL DLL's (require Win32)
                  Put these into C:\WINDOWS\SYSTEM

  \ZIP\VCL      - Essential support files.  Includes the very
                  useful TZipMaster VCL, as well as the DLL import
                  specifications and callback files.  Put these
                  into a directory in your VCL search path.

  \ZIP\HELP     - The new Help file and Contents file

  \ZIP\SFX      - Contains ZIPSFX.BIN, used to make self-extracting 
                  archives
  \ZIP\SFXSRC   - Contains Delphi source for ZIPSFX.BIN 

  \ZIP\DEMO1    - Delphi demo program #1.
  \ZIP\DEMO2    - Delphi demo program #2.
  \ZIP\DEMO3    - Delphi demo program #3.
  \ZIP\DEMO4    - Delphi demo program #4 (only for Delphi v3+).

  \ZIP\MYBACKUP - Two Freeware VCLs that help you copy large zip files
                  to floppy disks.  These are unsupported examples that
                  may help you.

C++ Builder Subdirectories:

  \ZIP\BCB\INST-BCB.TXT - Installation instructions for C++ Builder.

  \ZIP\BCB\VCL      - The C++ Builder port called TZipBuilder, and
                      the PASCAL versions of TZipDir and TSortGrid
                      (which weren't ported to C++ yet)

  \ZIP\BCB\HELP     - The C++ Help file and Contents file

  \ZIP\BCB\DEMO1    - C++ demo program #1 (port of Delphi demo1).
  \ZIP\BCB\DEMO2    - C++ demo program #2.
  \ZIP\BCB\DEMO3    - C++ demo program #3.
  \ZIP\BCB\DEMO4    - C++ demo program #4 (port of Delphi demo4).
 

NOTE: These subdirs will also be of interest to C++ Users:
  \ZIP\DOC
  \ZIP\DLL
  \ZIP\SFX
  \ZIP\SFXSRC

         
                Files you need to Redistribute

All of the demos require the 2 DLLs:  ZIPDLL.DLL and UNZDLL.DLL.
In Addition, you need ZIPSFX.BIN if you want to support the
creation of new self-extracting archives.  All of these can
be installed into the user's WINDOWS or WINDOWS SYSTEM
directory.



                 Special "Thank-you" Notes for 
                         this Release

  Several people helped me a great deal while making this release.
I like to encourage users to send me ideas and code, because
that helps me to make the best software for everyone to use.

  Thanks to Markus Stephany (mirbir.st@t-online.de) for his very
useful additions to the SFX module. He added the new SFX options,
and gave us lots of new functionality in that small package!

  Thanks to Chris Vleghert (cvleghrt@worldonline.nl) for the great
C++ port of TZipMaster!  This is quite an accomplishment.  Chris
also ported demo1 and demo4 from Delphi.  His work has also helped
me fix some bugs in TZipMaster, since he was in touch with me during
his work.  He also created the Help projects for this release.

  Thanks to the authors of the 2 VCLs in \zip\mybackup:
TCopyFile was made by Lars Nielsen, Lars_Nielsen@dk-online.dk
TMyBackup was made by Morgan Martinet, mmm@imaginet.fr

  And, thanks to all those who have e-mailed me with comments
and suggestions!


                      Distribution Policy
              Guidelines for Legal Re-distribution

  1) This applies to both end-users and developers.  The meat of
     this package is the .DLL files, and they are needed by all
     of your end-users if you use this ZIP package in your 
     program.
    
  2) You must not charge money for any part of the ZIP package.
     Warning:  The primary concern here is if you will market a
     new package that is only slightly more than a verbatim copy 
     of this package, or one of it's demos.  ANY release you sell
     is OK as long as you charge ONLY for the changes you make.

  3) You MUST either distribute the source code for this ZIP
     package, or give a WWW site where it can be obtained
     freely. This can be on a Help...About screen, in printed
     documentation, or in text files distributed with your 
     package.  Yes, it does seem odd to have this requirement
     for end-users who aren't programmers, but there is no
     mistake.  After all, it isn't hard to give them a URL
     and a few words explaining what it is for.

  4) You must document the Info-Zip's WWW home page URL, but 
     don't expect any help from the Info-Zip group, since my 
     release is only a derrivitive of their work.  They are 
     very busy doing support for their "official" releases.
     Since much of the DLL source code comes from them, they
     deserve to be mentioned.
        Info-Zip:   http://www.cdrom.com/pub/infozip/

  5) You must handle product support with your own end-users.
     This is imperative, because I don't have enough time to
     do support for end-users.

  6) I will handle support issues with programmers using this 
     package on a time-available basis. Since this is being
     distributed as freeware, you can't expect the kind of 
     support you'd get from a commercial vendor.  Please limit
     your questions to those that directly pertain to this
     ZIP package.

  7) You may NOT distribute executable versions of my demo
     programs to end-users without my approval.  These are 
     only example applications to teach you how to use
     this package. 


                    DLL Source Code in C
       
   The DLL source code is distributed separately due to it's
size, and the fact that most Delphi users of this package
probably don't want the C source for the DLL's.  The DLL 
source is also freeware, and will remain that way. 
The filename of the DLL source code is DZDLLSR4.ZIP, and 
it comes complete with VC++, v4.0 makefiles.



                    Updates to this Software

   Future updates to this software will be announced on the 
Borland "VCL users" newsgroups for C++ Builder and Delphi. 

   For at least a few more months I'll post frequently asked
questions and new releases on my own web site:

   http://www-afsc.saia.af.mil/~englere/


I will also upload new releases to these Web sites (if possible):

    http://carbohyd.siobc.ras.ru/torry/
      Torry's Delphi Pages is an excellent site in Russia.
      Torry is the shaggy dog!

    http://sunsite.icm.edu.pl/delphi/
      Delphi Super Page - DSP.  This is also one of the first
      and best.  It's home country is Poland, but has mirror
      sites in many other countries.  This is the Poland URL.

    http://www.cdrom.com/pub/delphi/
      Delphi Super Page - DSP.  This is the US URL.

    http://www.objectlessons.com/~ol/
      Object Lessons - a Delphi training company.  


    Other sites are welcome to carry copies of the official
distribution archives without contacting me first.

    Please DO NOT ask me to e-mail you when this software 
is updated.  There are hundreds of users of this package, and
I can't maintain such a long list in my free time! 

    You may e-mail me with your bug notices and proposed
changes to this package.  If your message comes with suggested
changes to source code, they WILL be evaluated, and, if used,
you will get the appropriate credit in the next release.


    *******************************************************
    *                                                     *
    * I'll be getting out of the Air Force in June 98. If *
    * you need a new Delphi programmer to start around    *
    * July 7, 98, then please send me e-mail!             *
    * I have 16 years of programming experience.          *
    * My Delphi specialties:                              *
    *    - Oracle Client/Server (prior Oracle DBA)        *
    *    - Internet protocols                             *
    *    - Interfacing with Unix (and the C language)     *
    *                                                     *
    *******************************************************


Eric W. Engler
Internet: englere@swcp.com
March 5, 1998


                      LEGAL DISCLAIMER

This entire freeware release is provided free, "as-is".
Like anything else that's free, these software modules
come with no warranty of any kind, either expressed or
implied.  In no event will the copyright holders be liable
for any damages resulting from the proper or improper
use of this software.
