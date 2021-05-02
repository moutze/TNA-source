{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit FMA
  * Class definition of FMA class *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit FMA;

interface

uses
  System.Classes, StdCtrls, TAHParam, ComCtrls, SysUtils;

type
                             // Class for a single comment (5 items)
  tFMAComment                = class( TObject )
  private
    fTID:                    Integer;
    fFID:                    Integer;
    fWho:                    String;
    fDat:                    String;
    fTex:                    String;
  public
    property TID:            Integer read fTID write fTID;
    property FID:            Integer read fFID write fFID;
    property Author:         String read fWho write fWho;
    property When:           String read fDat write fDat;
    property Comment:        String read fTex write fTex;
  end;

  tFMA                       = class( TObject )
  private
    fOcc:                    array of TFMAComment;
    fFln:                    String;
                             // Get number of comments
    function                 GetTotFMA()
                               : Integer;
  public
    property TotFMA:         Integer read GetTotFMA;
    property FileName:       String read fFln write fFln;
                             // Retrieve a single comment
    function                 FMAComment(
                               TID: Integer;
                               FID: Integer )
                               : tFMAComment;
                             // Read the source file
    procedure                ReadFMAFile;
  end;

implementation

uses
  TAHBrowser;

function           tFMA.GetTotFMA
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTotFMA
  * Get the number of FMA comments *
  Description:
  The method retrieves the number of available comments as exported from the
  TAH database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fOcc );
end; // _______________________________________________________________GetTotFMA

procedure          TFMA.ReadFMAFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadFMAFile
  * Read the FMA records from database source file *
  Description:
  This method reads the entire source file as exported from the TAH
  database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotComment:      Integer;
  IOR:             Integer;
  AllocRec:        Integer;
  Posit:           Integer;
  Line:            String;
  Trans:           String;
begin
  // Open input file in text format, splitted or unsplitted
  TotComment := 0;
  AllocRec := 0;
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
        if ( TotComment >= AllocRec ) then
        begin
          Inc( AllocRec, 20 );
          SetLength( FOcc, AllocRec );
        end;

        // Expected format is made of 5 fields:
        // FID¦TID¦Who¦Dat¦Txt
        FOcc[ TotComment ] := TFMAComment.Create;
        with FOcc[ TotComment ] do
        begin
          Posit := Pos( CurSep, Line );
          if ( Posit = 0 ) then
            Continue;
          FID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          TID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Author := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          When := Copy( Line, 1, Posit - 1 );
          Comment := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( cSpace, When );
          When := Copy( When, 1, Posit - 1 );
        end; // with
        Inc( TotComment );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( FOcc, TotComment );
end; // _____________________________________________________________ReadFMAFile

function           tFMA.FMAComment(
  TID:             Integer;
  FID:             Integer )
  :                tFMAComment;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FMAComment
  * Get a single FMA comment *
  Description:
  This method retrieve a single comment record from either the TA or FMA unique
  identifier.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin

  // Check for the presence of a FMA identifier
  if ( FID > 0 ) then
  begin
    for Indx := 0 to TotFMA - 1 do
    begin
      if ( Self.FOcc[ Indx ].FID = FID ) then
      begin
        Result := Self.FOcc[ Indx ];
        Exit;
      end;
    end; // for
  end else

  // Check for the presence of a TA identifier
  if ( TID > 0 ) then
  begin
    for Indx := 0 to TotFMA - 1 do
    begin
      if ( Self.FOcc[ Indx ].TID = TID ) then
      begin
        Result := Self.FOcc[ Indx ];
        Exit;
      end;
    end; // for
  end;

  // No result found
  Result := nil;
end; // ______________________________________________________________FMAComment

end.
