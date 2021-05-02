{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit BiProps
  * Class definition of the bivalued properties *
  Description:
  This class is the container of all specified bivalued properties
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit BiProps;

interface

uses
  TAHParam;

type

  TLinkage                  = class( TObject )
  private
    FProps:                 array of PROPSrec;
    FName:                  String;
  public
    function                GetTotProps(): Integer;
    property TotProps:      Integer read GetTotProps;
    property FileName:      String read FName write FName;

                            // Read the bivalued properties source file
    procedure               ReadPROPSSourceFile;
                            // Get a PROPS position from TID
    function                PROPSGetPositionByTID(
                              TID: Integer )
                              : Integer;
                            // Get a single bivalued property
    function                BiProp(
                              Index: Integer )
                              : PropsRec;
  end;

implementation

uses
  TAHBrowser, SysUtils;

function           TLinkage.GetTotProps()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTotProps
  * Get the number of bivalued properties *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FProps );
end; // _____________________________________________________________GetTotProps

procedure          TLinkage.ReadPROPSSourceFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadPROPSSourceFile
  * Read the bivalued properties source file *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  AllocRec:        Integer;
  Lgt:             Integer;
  Posit:           Integer;
  TotRec:          Integer;
  Line:            String;
begin
  // Open input file in text format, splitted or unsplitted
  TotRec := 0;
  AllocRec := 0;
    AssignFile( Infile, Self.FileName );
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
        if TotRec >= AllocRec then
        begin
          Inc( AllocRec, 20 );
          SetLength( FProps, AllocRec );
        end;

        // Expected format is made of 3 fields:
        // Left¦RID¦Right
        Lgt := Length( Line );
        with FProps[ TotRec ] do
        begin
          // if TotPROPS = 2149 then
          //  TotPROPS := 2149;
          Posit := Pos( CurSep, Line );
          Left := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          RID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Right := StrToInt( Copy( Line, Posit + 1, Lgt ) );
        end; // with

        Inc( TotRec );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( FProps, TotRec );
end; // _____________________________________________________ReadPROPSSourceFile

function           TLinkage.PROPSGetPositionByTID(
  TID:             Integer )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ PROPSGetPositionByTID
  * Get a PROPS position from TID *
  Description:
  This method searches the entire set of properties and finds the first
  property in the list which left TID is given as argument.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  Result := -1;
  for Indx := 0 to Self.TotPROPS - 1 do
  begin
    if TID = Self.FProps[ Indx ].Left then
    begin
      Result := Indx;
      Break;
    end else
    if TID < Self.FProps[ Indx ].Left then
      Break;
  end; // for
end; // ___________________________________________________PROPSGetPositionByTID

function           TLinkage.BiProp(
  Index:           Integer )
  :                PropsRec;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BiProp
  * Get a single bivalued property *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( ( Index >= 0 ) and ( Index < Self.TotProps ) ) then
    Result := Self.FProps[ Index ];
end; // __________________________________________________________________BiProp

end.
