program frameGrid;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FormMain},
  RecordUtils in 'RecordUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
