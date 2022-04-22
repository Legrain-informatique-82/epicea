//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "Main.h"

//---------------------------------------------------------------------------
#pragma link "Grids"
#pragma link "ZIPBuilder"
#pragma link "SortGrid"

#pragma resource "*.dfm"

TMainForm *MainForm;

System::AnsiString ExtractDir;
bool ExpandDirs, OverWr, AllFiles, Canceled, MemoFull;

//---------------------------------------------------------------------------
System::AnsiString TMainForm::ShowLTime( long s, long f ) {
	System::AnsiString smin, ssec;	// ,smil

	int st = f - s;
   //int mil = st % 1000;
   //mil %= 60;
	int sec = st / 1000;
	int min = sec / 60;
	sec %= 60;
	//if (mil > 9) smil = inttostr(mil); else smil = "0" + IntToStr(mil);
	ssec = ( sec > 9 ) ? IntToStr( sec ) : "0" + IntToStr( sec );
	smin = ( min > 9 ) ? IntToStr( min ) : "0" + IntToStr( min );
	return smin + ":" + ssec;
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::FillGrid( void ) {
	// Remove everything from grid except col titles.
	StringGrid1->RowCount = 2;
	StringGrid1->Rows[1]->Clear();
	if ( !ZipBuilder1->Count ) return;

	StringGrid1->RowCount = ZipBuilder1->Count + 1;
	for ( int i = 1; i <= ZipBuilder1->Count; i++ ) {
		ZipDirEntry *zde = (ZipDirEntry *)ZipBuilder1->ZipContents->Items[i - 1];
		StringGrid1->Cells[0][i] = zde->FileName;
		StringGrid1->Cells[1][i] = IntToStr( zde->CompressedSize );
		StringGrid1->Cells[2][i] = IntToStr( zde->UncompressedSize );
		StringGrid1->Cells[3][i] = FormatDateTime( "ddddd  t", FileDateToDateTime( zde->DateTime ) );
	}
	StringGrid1->SortByColumn( GSortCol, GSortOptions );
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::CloseButClick( TObject *Sender ) {
	Close();
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::ZipOpenButClick( TObject *Sender ) {
	OpenDialog1->Title = "Open Existing ZIP File";
	OpenDialog1->Options << ofHideReadOnly << ofShareAware << ofPathMustExist << ofFileMustExist;
	OpenDialog1->Filter = "ZIP Files (*.ZIP, *.EXE)|*.zip;*.exe";
	if ( OpenDialog1->Execute() ) {
		try {
			Screen->Cursor = crHourGlass;
			// Assigning the filename will cause the table of contents to be read.
			ZipBuilder1->ZipFilename = OpenDialog1->FileName;
		} catch ( ... ) { }
		Screen->Cursor = crDefault;
		/* Set the caption after assigning the filename. This
		   way, the filename will be null if the open failed. */
		SetZipFName( ZipBuilder1->ZipFilename );
	}
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::NewZipButClick( TObject *Sender ) {
	TMsgDlgButtons mdb;

	OpenDialog1->Title = "Create New ZIP File";
	OpenDialog1->Options << ofHideReadOnly << ofShareAware;
	OpenDialog1->Options >> ofPathMustExist >> ofFileMustExist;
	OpenDialog1->FileName = "";
	OpenDialog1->Filter   = "ZIP Files (*.ZIP)|*.zip";
	if ( OpenDialog1->Execute() ) {
		if ( UpperCase( ExtractFileExt( OpenDialog1->FileName ) ) == ".EXE" ) {
			// User probably wants to create an SFX .EXE.
			ShowMessage( "Error: you must create a .ZIP file, then convert to .EXE" );
			return;
		}
		if ( !OpenDialog1->FileName.Pos( "." ) )
			// User did not specify extension.
			OpenDialog1->FileName += ".zip";
		else if ( UpperCase( ExtractFileExt( OpenDialog1->FileName ) ) != ".ZIP" ) {
			ShowMessage( "Error: your new archive must end in .ZIP" );
			return;
		}
		if ( FileExists( OpenDialog1->FileName ) ) {
			mdb.Clear();
			mdb << mbYes << mbNo;
			bool Ans = MessageDlg( "Overwrite Existing File: " + OpenDialog1->FileName + "?",
                          mtConfirmation, mdb, 0 ) == mrYes;
			if ( Ans )
				::DeleteFile( OpenDialog1->FileName.c_str() );
			else return;  // Don't use the new name.
		}
		SetZipFName( OpenDialog1->FileName );
		ZipBuilder1->ZipFilename = OpenDialog1->FileName; // Updates the zip dir.
	}
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::DeleteZipButClick( TObject *Sender ) {
	TMsgDlgButtons mdb;

	if ( FileExists( ZipFName->Caption ) ) {
		mdb.Clear();
		mdb << mbYes << mbNo;
		bool Ans = MessageDlg( "Are you sure you want to delete: " + ZipFName->Caption
            + "?", mtConfirmation, mdb, 0 ) == mrYes;
		if ( Ans ) {
			::DeleteFile( ZipFName->Caption.c_str() );
			SetZipFName( "<none>" );
			StringGrid1->RowCount	 = 2; // Empty.
			StringGrid1->Rows[1]->Clear();
			ZipBuilder1->ZipFilename = "";
			FilesLabel->Caption		 = "0";
		} else return;  // Don't use the new name.
	} else
		ShowMessage( "Zip file not found: " + ZipFName->Caption );
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::ExtractButClick( TObject *Sender ) {
	long s, f;

   if ( !FileExists( ZipFName->Caption ) ) {
		ShowMessage( "Error: file not found: " + ZipFName->Caption );
		return;
	}
	Extract->ShowModal();
	if ( ( ExtractDir == "" ) || Canceled ) return;

	if ( ZipBuilder1->Count < 1 ) {
		ShowMessage( "Error - no files to extract" );
		return;
	}
	ZipBuilder1->FSpecArgs->Clear();
	// Get fspecs of selected files, unless user wants all files extracted.
	if ( !AllFiles ) {
		for ( int i = StringGrid1->Selection.Top; i <= StringGrid1->Selection.Bottom; i++ ) {
			ZipBuilder1->FSpecArgs->Add( StringGrid1->Cells[0][i] );
			//ShowMessage( "Selecting " + StringGrid1->Cells[0][i] );  // For debugging.
		} // end for
		if ( ZipBuilder1->FSpecArgs->Count < 1 ) {
			ShowMessage( "Error - no files selected" );
			return;
		}
	}
	MsgForm->Memo1->Clear();
	MemoFull = false;
	MsgForm->Show();
	// Put this message into the message form's memo.
	ZipBuilder1Message( this, 0, "Beginning Extract from " + ZipBuilder1->ZipFilename );

	ZipBuilder1->ExtrBaseDir = ExtractDir;
	ZipBuilder1->Verbose     = VerboseCB->Checked;
	ZipBuilder1->Trace       = TraceCB->Checked;
	ZipBuilder1->ExtrOptions.Clear();
	if ( ExpandDirs )
		ZipBuilder1->ExtrOptions << ExtrDirNames;
	if ( OverWr )
		ZipBuilder1->ExtrOptions << ExtrOverWrite;
	s = ::GetTickCount();
	try {
		ZipBuilder1->Extract();
	} catch ( ... ) {
		ShowMessage( "Error in Extract; Fatal DLL Exception in mainunit" );
		return;
	}
	f = ::GetTickCount();
	TimeLabel->Caption = ShowLTime( s, f );
	System::AnsiString IsOne = (ZipBuilder1->SuccessCnt == 1) ? " was" : "s were";
	ShowMessage( IntToStr( ZipBuilder1->SuccessCnt ) + " file" + IsOne + " extracted" );
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::ZipBuilder1DirUpdate( TObject *Sender ) {
	FillGrid();
	FilesLabel->Caption = IntToStr( ZipBuilder1->Count );
	SetZipFName( ZipBuilder1->ZipFilename );
	if ( UpperCase( ExtractFileExt( ZipBuilder1->ZipFilename ) ) == ".EXE" )
		ConvertBut->Caption = "Convert to ZIP";
	else
		ConvertBut->Caption = "Convert to EXE";
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::FormCreate( TObject *Sender ) {
	/* Make sure "goColMoving" is false in object inspector. This lets the
      TSortGrid use Mouse Clicks on the col headers. */
	StringGrid1->RowCount     =   2;  // First row is fixed, and used for column headers.
	StringGrid1->Cells[0][0]  = "File Name";
	StringGrid1->Cells[1][0]  = "Compr Size";
	StringGrid1->Cells[2][0]  = "Uncmpr Size";
	StringGrid1->Cells[3][0]  = "Dte/Time";
        StringGrid1->ColWidths[0] = 316;
	StringGrid1->ColWidths[1] =  84;
	StringGrid1->ColWidths[2] =  94;
	StringGrid1->ColWidths[3] = 120;

	VerboseCB->Checked = false;
	TraceCB->Checked   = false;
	ZipBuilder1->Load_Zip_Dll();
	ZipBuilder1->Load_Unz_Dll();
	/* If we had args on the cmd line, then try to open the first one
		as a zip/exe file.  This is most useful in case user has an association
		to ".zip" that causes this program to run when user dble clicks on a zip
		file in Explorer. */
	if ( ParamCount > 0 ) ZipBuilder1->ZipFilename = ParamStr( 1 );

	GSortOptions.SortDirection	= sdAscending;
	GSortOptions.SortStyle		= ssAutomatic;
	GSortOptions.SortCaseSensitive = false;
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::AddButClick( TObject *Sender ) {
	long s, f;

	if ( ZipBuilder1->ZipFilename == "" ) {
		ShowMessage( "Error - open a zip file first" );
		return;
	}
	AddFile->Left   = Left;
	AddFile->Top    = Top;
	AddFile->Width  = Width;
	AddFile->Height = Height;
	Canceled = false;
	AddFile->ShowModal();  // Let user pick filenames to add.
	if ( Canceled ) return;

	if ( !AddFile->SelectedList->Items->Count ) {
		ShowMessage( "No files selected" );
		return;
	}
	MsgForm->Memo1->Clear();
	MemoFull = false;
	MsgForm->Show();
	// Put this message into the message form's memo.
	ZipBuilder1Message( this, 0, "Beginning Add to " + ZipBuilder1->ZipFilename );

	/* We want any DLL error messages to show over the top
		of the message form. */
	ZipBuilder1->Verbose = VerboseCB->Checked;
	ZipBuilder1->Trace   = TraceCB->Checked;
	ZipBuilder1->AddOptions.Clear();
	if ( AddFile->RecurseCB->Checked )
		ZipBuilder1->AddOptions << AddRecurseDirs; 	// We want recursion.
	if ( AddFile->DirNameCB->Checked )
		ZipBuilder1->AddOptions << AddDirNames; 		// We want dirnames.
	if ( AddFile->EncryptCB->Checked ) {
		ZipBuilder1->AddOptions << AddEncrypt;			// We want a password.
		// GetAddPassword;
		// if ( Password == "" )
			// The 2 password's entered by user didn't match.
			/* We'll give him one more try; if he still messes it
				up, the DLL itself will prompt him one final time. */
      //   GetAddPassword;
	} else
		ZipBuilder1->AddOptions >> AddEncrypt; // Don't forget to turn this off!
	ZipBuilder1->FSpecArgs->Clear();
	ZipBuilder1->FSpecArgs->Assign( AddFile->SelectedList->Items ); // Specify filenames.
	AddFile->SelectedList->Clear();
	s = ::GetTickCount();
	try {
		ZipBuilder1->Add();
	} catch ( ... ) {
		ShowMessage( "Error in Add; Fatal DLL Exception in Main" );
		return;
	}
	f = ::GetTickCount();
	TimeLabel->Caption = ShowLTime( s, f );
	System::AnsiString IsOne = (ZipBuilder1->SuccessCnt == 1) ? " was" : "s were";
	ShowMessage( IntToStr( ZipBuilder1->SuccessCnt ) + " file" + IsOne + " added" );
}

//---------------------------------------------------------------------------
// This is the "OnMessage" event handler.
void __fastcall TMainForm::ZipBuilder1Message( TObject *Sender, int ErrCode, AnsiString Message ) {
   try {
		MsgForm->Memo1->Lines->Add( Message );
	} catch ( ... ) {
      ShowMessage( "Memo Full - Updating Stopped, but your operation is continuing..." );
	}
	if ( ErrCode > 0 )
		ShowMessage( "Error Msg from DLL: " + Message );
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::ZipBuilder1Progress( TObject *Sender, ProgressType ProgrType, AnsiString Filename, long FileSize ) {
	if ( ProgrType == NewFile ) {
		// ShowMessage( "in OnProgress type 1, size= " + IntToStr( FileSize ) );
		MsgForm->FileBeingZipped->Caption = Filename;
		TProgressBar *mgfPB = MsgForm->ProgressBar1;
		mgfPB->Min  =  1;	// First step.
		mgfPB->Max  = 10;	// Reasonable value for now ...
		mgfPB->Step =  1;	// No. of steps for each "StepIt".
		mgfPB->Position = mgfPB->Min;				// Current position of bar.

		// Max is assigned the approximate # of callbacks
		if ( FileSize / 32768  > 1 )
			mgfPB->Max = (WORD)(FileSize / 32768);		// Total no of steps.
		else
			mgfPB->Max = 1;
		if ( FileSize < 32768 )
			mgfPB->StepIt();				// Max out progress for small files.
	}

	if ( ProgrType == ProgressUpdate ) {
		// ShowMessage('in OnProgress type 2');
		TProgressBar *mgfPB = MsgForm->ProgressBar1;
		if ( mgfPB->Position < mgfPB->Max )	mgfPB->StepIt();
	}

	if ( ProgrType == EndOfBatch ) {
		// Reset the progress bar and filename.
		// ShowMessage( "In OnProgress type 3" );
		MsgForm->FileBeingZipped->Caption = "";
		TProgressBar *mgfPB = MsgForm->ProgressBar1;
		mgfPB->Min  =  1;
		mgfPB->Max  = 10;
		mgfPB->Step =  1;
		mgfPB->Position = mgfPB->Min;
	}
   Application->ProcessMessages();
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::DeleteButClick( TObject *Sender ) {
	TMsgDlgButtons mdb;
	long           s, f;

	if ( ZipBuilder1->Count < 1 ) {
		ShowMessage( "Error - no files to delete" );
		return;
	}
	mdb.Clear();
	mdb << mbYes << mbNo;
	bool Ans = MessageDlg( "Delete selected files from: " +
		 ZipBuilder1->ZipFilename + "?", mtConfirmation, mdb, 0 ) == mrYes;
	if ( !Ans ) return;

	ZipBuilder1->FSpecArgs->Clear();
	for ( int i = StringGrid1->Selection.Top; i <= StringGrid1->Selection.Bottom; i++ ) {
		ZipBuilder1->FSpecArgs->Add( StringGrid1->Cells[0][i] );
		// ShowMessage( "Selecting " + StringGrid1->Cells[0][i]); // for debugging
	}
	if ( ZipBuilder1->FSpecArgs->Count < 1 ) {
		ShowMessage( "Error - no files selected" );
		return;
	}

	MsgForm->Memo1->Clear();
	MemoFull = false;
	MsgForm->Show();
	// Put this message into the message form's memo.
	ZipBuilder1Message( this, 0, "Beginning delete from " + ZipBuilder1->ZipFilename );

	ZipBuilder1->Verbose = VerboseCB->Checked;
	ZipBuilder1->Trace   = TraceCB->Checked;
	s = ::GetTickCount();
	try {
		ZipBuilder1->Delete();
	} catch ( ... ) {
		ShowMessage( "Fatal error trying to delete" );
		return;
	}
	f = ::GetTickCount();
	TimeLabel->Caption = ShowLTime( s, f );
	System::AnsiString IsOne = (ZipBuilder1->SuccessCnt == 1) ? " was" : "s were";
	ShowMessage( IntToStr( ZipBuilder1->SuccessCnt ) + " file" + IsOne + " deleted" );
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::FormDestroy( TObject *Sender ) {
	ZipBuilder1->Unload_Zip_Dll();
	ZipBuilder1->Unload_Unz_Dll();
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::TestButClick( TObject *Sender ) {
	long s, f;

	if ( ZipBuilder1->Count < 1 ) {
		ShowMessage( "Error - nothing to Test" );
		return;
	}
	if ( ZipBuilder1->ZipFilename == "" ) return;
	ZipBuilder1->Verbose = VerboseCB->Checked;
	ZipBuilder1->Trace   = TraceCB->Checked;
	MsgForm->Memo1->Clear();
	MemoFull = false;
	MsgForm->Show();
	ZipBuilder1Message( this, 0, "Beginning test of " + ZipBuilder1->ZipFilename );

	ZipBuilder1->FSpecArgs->Clear();
	ZipBuilder1->ExtrOptions << ExtrTest;
	ZipBuilder1->FSpecArgs->Add( "*.*" ); // Test all the files in the .zip.
	// IMPORTANT: In this release, you must test all files.
	s = ::GetTickCount();
	ZipBuilder1->Extract();  // This will really do a test.

	f = ::GetTickCount();
	TimeLabel->Caption = ShowLTime( s, f );
	if ( ZipBuilder1->Count == ZipBuilder1->SuccessCnt )
		ShowMessage( "All " + IntToStr( ZipBuilder1->Count ) + " files tested OK" );
	else
		ShowMessage( "ERROR: " + IntToStr( ZipBuilder1->Count - ZipBuilder1->SuccessCnt ) +
                     " files tested BAD, or skipped!" );
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::MsgButClick( TObject *Sender ) {
	MsgForm->Show();
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::ConvertButClick( TObject *Sender ) {
	int ConvertErr;

	if ( !ZipBuilder1->Count ) {
		ShowMessage( "Error: no files in archive" );
		return;
	}
	// Determine which conversion is to be done.
	if ( UpperCase( ExtractFileExt( ZipBuilder1->ZipFilename ) ) == ".EXE" ) {
		// Convert .EXE to .ZIP
		if ( (ConvertErr = ZipBuilder1->ConvertZIP()) == 0 )
			ShowMessage( "Filename is now: " + ZipBuilder1->ZipFilename );
		else
			ShowMessage( "Error " + IntToStr( ConvertErr ) + " occured in making .ZIP file" );
	} else {
		// Convert .ZIP to .EXE
		/* NOTE: If you put the ZIPSFX.BIN file into the WINDOWS
			or WINDOWS SYSTEM dir, then you don't need to set the
			SFXPath property below: */
		// ZipBuilder1->SFXPath = "c:\\windows\\system\\zipsfx.bin";
		MakeSFX->ShowModal();
		if ( DoIt == false ) return;
		if ( (ConvertErr = ZipBuilder1->ConvertSFX()) == 0 )
			ShowMessage( "Filename is now: " + ZipBuilder1->ZipFilename );
		else
			ShowMessage( "Error " + IntToStr( ConvertErr ) + " occured in making .EXE file" );
	}
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::StringGrid1ClickSort( TObject *Sender, long Col, long Row, TSortOptions &SortOptions ) {
	GSortOptions.SortDirection = ( GSortOptions.SortDirection == sdAscending ) ? sdDescending : sdAscending;
	GSortCol    = Col;
	SortOptions = GSortOptions;
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::StringGrid1DrawCell( TObject *Sender, long Col, long Row, TRect &Rect, TGridDrawState State ) {
	if ( !Row && Col == GSortCol )
		ImageList1->Draw( StringGrid1->Canvas, Rect.Right - 18, 0, (GSortOptions.SortDirection == sdAscending) ? 0 : 1 );
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::SetZipFName( System::AnsiString aCaption ) {
	ZipFName->Caption = aCaption;
	Font->Assign( ZipFName->Font );
   if ( Canvas->TextWidth( aCaption ) > ZipFName->Width ) {
		ZipFName->Hint = aCaption;
		ZipFName->ShowHint = true;
	} else ZipFName->ShowHint = false;
}

