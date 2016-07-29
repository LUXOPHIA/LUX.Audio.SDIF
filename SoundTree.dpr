program SoundTree;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  TUX.Asset.SDIF in '_LIBRARY\TUX.Asset.SDIF.pas',
  LUX.FMX in '_LIBRARY\LUXOPHIA\LUX\LUX.FMX.pas',
  LUX in '_LIBRARY\LUXOPHIA\LUX\LUX.pas',
  LUX.D1 in '_LIBRARY\LUXOPHIA\LUX\LUX.D1.pas',
  LUX.D2 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.pas',
  LUX.D3 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.pas',
  LUX.Graph in '_LIBRARY\LUXOPHIA\LUX.Graph\LUX.Graph.pas',
  LUX.Graph.Tree in '_LIBRARY\LUXOPHIA\LUX.Graph\LUX.Graph.Tree.pas',
  TUX.Asset.SDIF.Matrixs in '_LIBRARY\TUX.Asset.SDIF.Matrixs.pas',
  TUX.Asset.SDIF.Frames in '_LIBRARY\TUX.Asset.SDIF.Frames.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
