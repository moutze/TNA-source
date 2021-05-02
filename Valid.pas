{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit Valid
  * Package for Validation information *
   ====================================
  This unit takes care of inquiries and actions which together make the
  validation information. It includes the definition of the ValidSection for
  the Validation Page.</P>
  The validation process is organized as the posting of inquiries about
  units or collection of units, when any problem is pending or any action is
  required. Then a time sequence of actions about each inquiry is setup until
  it is closed. All inquiries and actions are timestamped and collected with
  appropriate description.</P>
  The status of an inquiry is updated with each action, and the last
  status is displayed. It has three possible values according to the light
  traffic paradigm:
  - red for requiring a necessary update,
  - orange for an acceptable solution, but having a potential of improvement,
  - green for an accepted solution.
  In principle, an inquiry can be closed only when it has reached a green
  or orange status.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit Valid;

interface

uses
  TAHParam, HTMLSection;

type
                             // Definition of an inquiry
  tInquiry                   = class( TObject )
  private
    fInq:                    array of InquiryRec;
    fName:                   String;
    function                 GetTotInquiry()
                               : Integer;
  public
    property TotIn:          Integer read GetTotInquiry;
    property FileName:       String read fName write fName;

                             // Read the inquiry source file
    procedure                ReadInquiryFile;
                             // Get a inquiry from TID
    function                 InquiryExist(
                               TID: Integer;
                               var MyInquiry: tInquiries )
                               : Boolean;
  end;
                            // Definition of an action within an inquiry
  tAction                   = class( TObject )
  private
    fAct:                    array of ActionRec;
    fName:                   String;
    function                 GetTotAction(): Integer;
  public
    property TotAct:         Integer read GetTotAction;
    property FileName:       String read fName write fName;

                             // Read the bivalued properties source file
    procedure                ReadActionFile;
                             // List of actions by inquery
    function                 ListActions(
                               IID: Integer )
                               : String;
                             // Get an action from IID
    function                 ActionExist(
                               AID: Integer;
                               var MyAction: ActionRec )
                               : Boolean;
  end;

implementation

uses
  SingleTerms, SysUtils, TAHBrowser, TAHUtilities, Classes, Definitions,
  Tetra, Entity;

function           tInquiry.GetTotInquiry()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTotInquiry
  * Get number of inquiries *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FInq );
end; // ___________________________________________________________GetTotInquiry

function           tAction.GetTotAction()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTotAction
  * Get number of actions *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FAct );
end; // ____________________________________________________________GetTotAction

procedure          tInquiry.ReadInquiryFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadInquiryFile
  * Read the inquiries *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  AllocRec:        Integer;
  Posit:           Integer;
  TotIn:           Integer;
  Line:            String;
  Trans:           String;
  MyFile:          String;
  InFile:          TextFile;
begin
  // Open input file in text format, splitted or unsplitted
  TotIn := 0;
  AllocRec := 0;
  MyFile := Self.FileName;
    AssignFile( Infile, MyFile );
    Reset( InFile );

    // Loop on all lines of input file and prepare splitting
    while not EOF( InFile ) do
    begin

      // Read the next line of text
      {$I-}
      Readln( InFile, Line );
      IOR := IOResult;
      {$I+}
      if ( IOR = 0 ) then
      begin

        // Allocate dynamic memory
        if TotIn >= AllocRec then
        begin
          Inc( AllocRec, 20 );
          SetLength( FInq, AllocRec );
        end;

        // Expected format is made of 8 fields:
        // IID¦TID¦Lis¦Who¦Dat¦Lib¦Open¦Clos
        with FInq[ TotIn ] do
        begin
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          IID := 0;
          if Length( Trans ) > 0 then
            IID := StrToInt( Trans );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          TID := 0;
          if Length( Trans ) > 0 then
            TID := StrToInt( Trans );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Lis := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Who := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Dat := Copy( Line, 1, Posit - 1 ) ;
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Lib := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          Open := Trans = '1';
          Clos := Copy( Line, Posit + 1, Length( Line ) );
        end; // with

        Inc( TotIn );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( fInq, TotIn );
end; // _________________________________________________________ReadInquiryFile

procedure          tAction.ReadActionFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadActionFile
  * Read the actions *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  AllocRec:        Integer;
  Posit:           Integer;
  TotAct:          Integer;
  Line:            String;
  Trans:           String;
  MyFile:          String;
  InFile:          TextFile;
begin
  // Open input file in text format, splitted or unsplitted
  TotAct := 0;
  AllocRec := 0;
  MyFile := Self.FileName;
    AssignFile( Infile, MyFile );
    Reset( InFile );

    // Loop on all lines of input file and prepare splitting
    while not EOF( InFile ) do
    begin

      // Read the next line of text
      {$I-}
      Readln( InFile, Line );
      IOR := IOResult;
      {$I+}
      if ( IOR = 0 ) then
      begin

        // Allocate dynamic memory
        if TotAct >= AllocRec then
        begin
          Inc( AllocRec, 20 );
          SetLength( Self.FAct, AllocRec );
        end;

        // Expected format is made of 7 fields:
        // AID¦IID¦Typ¦Dat¦Aut¦Status¦Descr
        with Self.FAct[ TotAct ] do
        begin
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          AID := 0;
          if Length( Trans ) > 0 then
            AID := StrToInt( Trans );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          IID := 0;
          if Length( Trans ) > 0 then
            IID := StrToInt( Trans );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Typ := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Dat := Copy( Line, 1, Posit - 1 ) ;
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Aut := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Status := Copy( Line, 1, Posit - 1 );
          Descr := Copy( Line, Posit + 1, Length( Line ) );
        end; // with

        Inc( TotAct );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( Self.FAct, TotAct );
end; // __________________________________________________________ReadActionFile

function           tInquiry.InquiryExist(
  TID:             Integer;
  var MyInquiry:   tInquiries )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ InquiryExist
  * Retrieve all inquiries for a specified TID *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Count:           Integer;
begin
  SetLength( MyInquiry, 20 );
  Result := False;
  Count := 0;
  for Indx := 0 to Self.TotIn - 1 do
  begin
    if ( Self.FInq[ Indx ].TID = TID ) then
    begin
      MyInquiry[ Count ] := Self.FInq[ Indx ];
      Result := True;
      Inc( Count );
    end;
  end; // for
  SetLength( MyInquiry, Count );
end; // ____________________________________________________________InquiryExist

function           tAction.ListActions(
  IID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ListActions
  * Retrieve a list of all actions by inquiry *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbAction:        Integer;
  Liste:           String;
begin
  Liste := cEmpty;
  NbAction := Self.TotAct;
  for Indx := 0 to NbAction - 1 do
  begin
    if ( Self.FAct[ Indx ].IID = IID ) then
    begin
      Liste := Liste + cSemi + IntToStr( Self.FAct[ Indx ].AID );
    end;
  end; // for
  Result := Copy( Liste, 2, Length( Liste ) );
end; // _____________________________________________________________ListActions

function           tAction.ActionExist(
  AID:             Integer;
  var MyAction:    ActionRec )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ActionExist
  * Retrieve a single action from its AID *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  Result := False;
  for Indx := 0 to Self.TotAct - 1 do
  begin
    if ( Self.fAct[ Indx ].AID = AID ) then
    begin
      MyAction := Self.fAct[ Indx ];
      Result := True;
      Break;
    end;
  end; // for
end; // _____________________________________________________________ActionExist

end.
