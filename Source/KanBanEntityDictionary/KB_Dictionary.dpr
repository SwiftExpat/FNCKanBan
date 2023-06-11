program KB_Dictionary;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, KanBanEntityTypes, Aurelius.Dictionary.Generator, System.IOUtils;

begin
  try
    { C:\Users\Coder\Documents\Embarcadero\Studio\Projects\DRMS\KanBan\KanBanEntityDictionary\Win32\Debug }
    var
    ed := TPath.GetDirectoryName(ParamStr(0));
    var
    pdir := TDirectory.GetParent(TDirectory.GetParent(TDirectory.GetParent(ed)));
    Writeln(' Project dir = ' + pdir);
    var
    kbedir := TPath.combine(pdir, 'KanBanEntities');
    Writeln(' Entity dir = ' + kbedir);
    TDictionaryGenerator.GenerateFile(TPath.combine(kbedir, 'KanBanEntityDictionary.pas'));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
