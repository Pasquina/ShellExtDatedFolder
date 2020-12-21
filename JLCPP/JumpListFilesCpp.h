//---------------------------------------------------------------------------

#ifndef JumpListFilesCppH
#define JumpListFilesCppH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <ShellAPI.hpp>
#include <Vcl.JumpList.hpp>
//---------------------------------------------------------------------------
class TForm2 : public TForm
{
__published:	// IDE-managed Components
	TListBox *ListBox1;
	TJumpList *JumpList1;
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
   bool CmdLineOpenFiles(bool AMultipleFiles);
public:		// User declarations
	__fastcall TForm2(TComponent* Owner);
	void OpenFile (UnicodeString filename);

   void __fastcall WMDropFiles(TWMDropFiles &Message);
   BEGIN_MESSAGE_MAP
	 MESSAGE_HANDLER(WM_DROPFILES, TWMDropFiles, WMDropFiles)
   END_MESSAGE_MAP(TControl)


};
//---------------------------------------------------------------------------
extern PACKAGE TForm2 *Form2;
//---------------------------------------------------------------------------
#endif
