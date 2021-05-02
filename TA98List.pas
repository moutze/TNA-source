{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit TA98List
  * Class container for TA98 List *
  Description:
  This class is the container of all TA98 List information.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit TA98List;

interface

uses
  TAHParam;

type

  TTA98List                  = class( TObject )
  private
    FEntity:                 array of TA98Rec;
    FName:                   String;
  public
    function                 GetTotTA98(): Integer;
    property TotTA98:        Integer read GetTotTA98;
    property FileName:       String read FName write FName;

                             // Read the bivalued properties source file
    procedure                ReadTA98ListFile;
                             // Get a single TA98 entry by its TID
    function                 GetTA98(
                               TID: Integer )
                               : TA98Rec;
  end;

implementation

uses
  TAHBrowser, SysUtils;

function           TTA98List.GetTotTA98
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTotTA98
  * Get the number of entities of table TA98 *
  Description:
  The method retrieves the number of available entities as exported from the
  TAH database. It should be 7544.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FEntity );
end; // ______________________________________________________________GetTotTA98

function           TTA98List.GetTA98(
  TID:             Integer )
  :                TA98Rec;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTA98
  * Get a single entity of table TA98 by its TID *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( TID <= Tot98 ) then
    Result := FEntity[ TID - 1 ];
end; // _________________________________________________________________GetTA98

procedure          tTA98List.ReadTA98ListFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadTA98ListFile
  * Read the TA98 records from database source file *
  Description:
  This method reads the entire source file as exported from the TAH
  database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotNotes:        Integer;
  IOR:             Integer;
  AllocRec:        Integer;
  Posit:           Integer;
  Line:            String;
  Trans:           String;
  Filename:        String;
begin
  // Open input file in text format, splitted or unsplitted
  TotNotes := 0;
  AllocRec := 0;
  Filename := Self.FileName;
    AssignFile( Infile, FileName );
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
        if TotNotes >= AllocRec then
        begin
          Inc( AllocRec, 20 );
          SetLength( Self.FEntity, AllocRec );
        end;

        // Expected format is made of 4 fields:
        // TID¦TAcode¦Ind¦List
        with FEntity[ TotNotes ] do
        begin
          Posit := Pos( CurSep, Line );
          if ( Posit = 0 ) then
            Continue;
          TID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          TAcode := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Ind := Copy( Line, 1, Posit - 1 );
          List := StrToInt( Copy( Line, Posit + 1, Length( Line ) ) );
        end;
        Inc( TotNotes );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( FEntity, TotNotes );
end; // ________________________________________________________ReadTA98ListFile

end.
