
                           Delphi Demo 4 

NOTE: This is ONLY for Delphi 3+.  It requires the ShlObj object
which is not included with Delphi 2.


This is a simple little "viewzip" application, but it supports
automatic install features.

If this were being distributed in a Delphi Zip Self-Extracting Archive,
you would tell it to run this command line after extraction:
'><viewzip /install'.


Ways to test this program from a DOS box:

C>viewzip /install       Automatically bring up the install menu

C>viewzip test.zip       Run it with a zip file parameter
 
C>start test.zip         Check the File Extension assoc. in Registry

C>start viewzip          Check the Application Path in Registry
 
C>viewzip /uninstall     Automatically perform uninstall and quit


The uninstall can also be performed from the Control Panel.
Select Start, Settings, Control Panel, Add/Remove Programs.
