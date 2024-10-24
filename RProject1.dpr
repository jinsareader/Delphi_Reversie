program RProject1;

uses
  Vcl.Forms,
  Rproject2 in 'Rproject2.pas',
  Rproject in 'Rproject.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
