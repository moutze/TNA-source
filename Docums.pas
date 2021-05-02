{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit Docums
  * Class definition of the documentation paragraph *
  Description:
  This class is the container of all specified documentations.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit Docums;

interface

uses
  TAHParam;

type

  tDocum                     = class( TObject )
  private
    fDocum:                  array of DOCUMRec;
    fName:                   String;
  public
    function                 GetTotDocum(): Integer;
    property TotDocum:       Integer read GetTotDocum;
    property FileName:       String read fName write fName;

                             // Read the bivalued properties source file
    procedure                ReadDocumSourceFile;
                             // Get a documentation position from TID
    function                 DocumExist(
                               TID: Integer;
                               var MyDocum: DocumRec )
                               : Boolean;
  end;

implementation

uses
  TAHBrowser, SysUtils;

function           tDocum.GetTotDocum()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTotDocum
  * Get the number of documentation paragraphs *
  Description:
  The method retrieves the number of available docums as exported from the
  TAH database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fDocum );
end; // _____________________________________________________________GetTotDocum

procedure          tDocum.ReadDocumSourceFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadDocumSourceFile
  * Read documentation source file *
  Description:
  This method reads all documentation records available from the TAH
  database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  AllocRec:        Integer;
  Lgt:             Integer;
  Posit:           Integer;
  TotDocum:        Integer;
  Line:            String;
begin
  // Open input file in text format, splitted or unsplitted
  TotDocum := 0;
  AllocRec := 0;
    AssignFile( Infile, Self.fName );
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
        if TotDocum >= AllocRec then
        begin
          Inc( AllocRec, 20 );
          SetLength( fDocum, AllocRec );
        end;

        // Expected format is made of 4 fields:
        // TID¦Dat¦Aut¦Des
        Lgt := Length( Line );
        with fDocum[ TotDocum ] do
        begin
          // if TotDOCUM = 2149 then
          //  TotDOCUM := 2149;
          Posit := Pos( CurSep, Line );
          TID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Dat := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Aut := Copy( Line, 1, Posit - 1 );
          Des := Copy( Line, Posit + 1, Lgt );
        end; // with

        Inc( TotDocum );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( fDocum, TotDocum );
end; // _____________________________________________________ReadDocumSourceFile

function           tDocum.DocumExist(
  TID:             Integer;
  var MyDocum:     DocumRec )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DocumExist
  * Check for existence of a documentation for a specified entity *
  Description:
  This procedure scans sequentially the documentation records and looks for
  a specified TID entity. If this TID exists, the found record is
  transferred back to the calling procedure and the search is a success.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  Result := False;
  for Indx := 0 to Self.TotDocum - 1 do
  begin
    if ( fDocum[ Indx ].TID = TID ) then
    begin
      MyDocum := fDocum[ Indx ];
      Result := True;
      Break;
    end else
    if ( fDocum[ Indx ].TID > TID ) then
      Break;
  end; // for
end; // ______________________________________________________________DocumExist

end.
