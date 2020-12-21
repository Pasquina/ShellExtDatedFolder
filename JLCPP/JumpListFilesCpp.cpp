//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "JumpListFilesCpp.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm2 *Form2;
//---------------------------------------------------------------------------
__fastcall TForm2::TForm2(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm2::FormCreate(TObject *Sender)
{
  CmdLineOpenFiles(TRUE);
  // accept dragging to the form
  DragAcceptFiles(Handle, TRUE);
}
//---------------------------------------------------------------------------
bool TForm2::CmdLineOpenFiles(bool AMultipleFiles)
{
  int Cnt = ParamCount();
  if (Cnt > 0) {
	if (!AMultipleFiles && (Cnt > 1)) {
	  Cnt = 1;
	}
	for (int i=1; i<=Cnt; ++i) {
	  OpenFile (ParamStr(i));
	}
	return TRUE;
  }
  else {
	return FALSE;
  }
}
//---------------------------------------------------------------------------
void TForm2::OpenFile (UnicodeString filename)
 {
   // this is just a placeholder
   ListBox1->Items->Add (filename);
 }
 //---------------------------------------------------------------------------
void __fastcall TForm2::WMDropFiles(TWMDropFiles &Message)
{
   WideChar FileName[MAX_PATH];
   HDROP hDrop = (HDROP)Message.Drop;

   // get the number of dropped files
   int nFiles = DragQueryFile(hDrop, -1, NULL, NULL);

   // for each file
   for (int i=0; i < nFiles; i++) {
	  DragQueryFile(hDrop, i, FileName, sizeof(FileName));
	  // open the file
	  OpenFile(FileName);
	  // add file to Jump List
	  TJumpListItem* jumpItem = dynamic_cast <TJumpListItem*> (JumpList1->CustomCategories->Items[0]->Items->Add());
	  jumpItem->FriendlyName = ExtractFileName (FileName);
	  jumpItem->Arguments = FileName; // full path
   }
   DragFinish(hDrop);
}

