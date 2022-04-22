//---------------------------------------------------------------------------
#include <vcl\vcl.h>

#pragma hdrstop

//---------------------------------------------------------------------------
USEFORM("Message.cpp", MsgForm);
USEFORM("SFX.cpp", MakeSFX);
USEFORM("ExtractFiles.cpp", Extract);
USEFORM("Main.cpp", MainForm);
USEFORM("AddFiles.cpp", AddFile);
USERES("Demo1.res");
//---------------------------------------------------------------------------
WINAPI WinMain( HINSTANCE, HINSTANCE, LPSTR, int ) {
	try {
		Application->Initialize();
		Application->CreateForm(__classid(TMainForm), &MainForm);
		Application->CreateForm(__classid(TMsgForm), &MsgForm);
		Application->CreateForm(__classid(TMakeSFX), &MakeSFX);
		Application->CreateForm(__classid(TExtract), &Extract);
		Application->CreateForm(__classid(TAddFile), &AddFile);
		Application->Run();
	}
	catch (Exception &exception) {
		Application->ShowException(&exception);
	}
	return 0;
}
//---------------------------------------------------------------------------

