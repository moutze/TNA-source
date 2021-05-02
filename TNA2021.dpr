program TNA2021;

uses
  Vcl.Forms,
  TAHBrowser in 'TAHBrowser.pas' {THAHierarForm},
  AccessXml in 'AccessXml.pas',
  BiProps in 'BiProps.pas',
  Docums in 'Docums.pas',
  HTMLSection in 'HTMLSection.pas',
  LAProc in 'LAProc.pas',
  Notes in 'Notes.pas',
  SingleTerms in 'SingleTerms.pas',
  TAH in 'TAH.pas',
  TAHPage in 'TAHPage.pas',
  TAInOut in 'TAInOut.pas',
  TAHAlphaPage in 'TAHAlphaPage.pas',
  Valid in 'Valid.pas',
  TA98List in 'TA98List.pas',
  FMA in 'FMA.pas',
  TAHUtilities in 'TAHUtilities.pas',
  ESProc in 'ESProc.pas',
  Stat in 'Stat.pas',
  List in 'List.pas',
  Definitions in 'Definitions.pas',
  TAHParam in 'TAHParam.pas',
  Term in 'Term.pas',
  FRProc in 'FRProc.pas',
  ENProc in 'ENProc.pas',
  Entity in 'Entity.pas',
  Tetra in 'Tetra.pas',
  RUProc in 'RUProc.pas',
  ITProc in 'ITProc.pas',
  WList in 'WList.pas',
  TAHInterface in 'TAHInterface.pas',
  Comments in 'Comments.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTHAHierarForm, THAHierarForm);
  Application.Run;
end.
