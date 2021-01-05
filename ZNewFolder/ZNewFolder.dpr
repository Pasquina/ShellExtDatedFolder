library ZNewFolder;

uses
  ComServ,
  ZNewFolder_TLB in 'ZNewFolder_TLB.pas',
  pZNewFolderExt in 'pZNewFolderExt.pas' {ZNewFolderExt: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;



{$R *.TLB}

{$R *.RES}

begin
end.
