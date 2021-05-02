{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit List
  * Classs for list management by signatures*
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit List;

interface

uses
  TAHParam;

type
  tSignatures                = class( TObject )
    fSig:                    array of SigRec;
    fFilename:               String;
  public
                             // Filename of list of signatures
    property Filename:       String read fFilename write fFilename;
                             // Retrieve the list of children of a list
    function                 GetChildren(
                               UID: Integer;
                               MyType: tTypeListPage )
                               : String;
    function                 GetSigRec(
                               UID: Integer;
                               TypeList: tTypeListPage )
                               : SigRec;
                             // Read the source file from the database
    procedure                ReadSigSourceFile;
                             // Add a signature to the corpus of signatures
    procedure                AddSignature(
                               ASig: SigRec );
                             // Get a signature by its position
    function                 GetSigByPos(
                               position: Integer )
                               : SigRec;
  end;

implementation

uses
  TAHBrowser, SysUtils, TAH;

function           tSignatures.GetChildren(
  UID:             Integer;
  MyType:          tTypeListPage )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetChildren
  * Retrieve all child lists of a list specified by its UID *
  Description:
  This functions first look if the mentioned list is present. Then, it checks
  if the list of children has already been computed. If not, the list is
  computed, stored and returned, looking at each ancestor of any existing
  list.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbList:          Integer;
  MyPos:           Integer;
  NbFound:         Integer;
  MyList:          String;
  TypeList:        String;
  AnyList:         SigRec;
  AType:           tTypeListPage;
begin

  // Retrieve the current list. Return an empty string if not found.
  MyPos := -1;
  Result := cEmpty;
  NbList := Length( fSig );
  TypeList := Copy( cTypeListPage[ MyType ], 1, 2 );
  for Indx := 0 to NbList - 1 do
  begin
    if ( ( fSig[ Indx ].UID = UID ) and
         ( fSig[ Indx ].Typ = TypeList ) ) then
    begin
      MyPos := Indx;
      Break;
    end;
  end; // for on all lists
  if ( MyPos < 0 ) then
    Exit;

  // Check for the presence of the list (from a previous search)
  if ( FSig[ MyPos ].Son <> cEmpty ) then
    Result := fSig[ MyPos ].Son
  else

  // Compute the list of children
  begin
    MyList := cEmpty;
    NbFound := 0;
    AType := Succ( MyType );
    if ( ( AType = li_Part1f ) or
         ( AType = li_Part2f ) or
         ( AType = li_Part3f ) or
         ( AType = li_Tax1f ) or
         ( AType = li_Tax2f ) or
         ( AType = li_Tax3f ) ) then
      AType := succ( AType );
    for Indx  := 0 to NbList - 1 do
    begin
      if ( ( fSig[ Indx ].Anc = UID ) and
           ( fSig[ Indx ].Typ = cTypeListPage[ AType ] ) ) then
      begin
        if ( MyList <> cEmpty ) then
          MyList := MyList + cSemi + IntToStr( fSig[ Indx ].UID )
        else
          MyList := IntToStr( fSig[ Indx ].UID );
        Inc( NbFound );
      end;
    end; // for on all lists

    // Check for the number of children against declared value
    if ( NbFound <> fSig[ MyPos ].NbSub ) then
    begin
      Result := cEmpty;
    end else
    begin
      fSig[ MyPos ].Son := MyList;
      Result := MyList;
    end;
  end;
end; // _____________________________________________________________GetChildren

function           tSignatures.GetSigRec(
  UID:             Integer;
  TypeList:        tTypeListPage )
  :                SigRec;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSigRec
  * Get a signature by its UID *
  Description:
  The method retrieves the signature of a list as stored when the list has been
  last validated.</P>
  Care should be taken about double signatures for the same head unit of a
  list, for example a partonomic list and a taxonomic list.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbList:          Integer;
  MyType:          String;
  FakeRec:         SigRec;
begin
  FakeRec.UID := 0;
  Result := FakeRec;
  NbList := Length( fSig );
  MyType := Copy( cTypeListPage[ TypeList ], 1, 2 );
  for Indx := 0 to NbList - 1 do
  begin
    if ( ( Self.fSig[ Indx ].UID = UID ) and
         ( Self.fSig[ Indx ].Typ = MyType ) ) then
    begin
      Result := fSig[ Indx ];
      Break;
    end;
  end; // for on all lists
end; // _______________________________________________________________GetSigRec

function           tSignatures.GetSigByPos(
  Position:        Integer )
  :                SigRec;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSigByPos
  * Get a list by its position *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbList:          Integer;
begin
  NbList := Length( FSig );
  if ( ( Position >= 0 ) and ( Position < NbList ) ) then
    Result := Self.FSig[ Position ];
end; // _____________________________________________________________GetSigByPos

procedure          tSignatures.AddSignature(
  ASig:            SigRec );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddSignature
  * Add a signature to the corpus of signatures *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbSig:           Integer;
begin
  NbSig := Length( FSig );
  Inc( NbSig );
  SetLength( FSig, NbSig );
  FSig [ NbSig - 1 ] := ASig;
end; // ____________________________________________________________AddSignature

procedure          tSignatures.ReadSigSourceFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadSigSourceFile
  * Read the list source file *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  AllocRec:        Integer;
  Lgt:             Integer;
  Posit:           Integer;
  Line:            String;
  Temp:            String;
  MyList:          SigRec;
begin
  // Open input file in text format, splitted or unsplitted
  TotSequence := 0;
  AllocRec := 0;
  FileName := Self.FileName;
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

        // Expected format is made of 15 fields:
        // UID¦Typ¦Anc¦Sign¦DateS¦PastS¦PastD¦NbCh¦NbUn¦PrCh¦
        // PrUn¦NbSub¦NbRef¦NbBr¦Descr
        Lgt := Length( Line );
          Posit := Pos( CurSep, Line );
          MyList.UID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          MyList.Typ := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.Anc := StrToInt( Temp )
          else
            MyList.Anc := 0;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.Sign := StrToInt( Temp )
          else
            MyList.Sign := 0;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          MyList.DatS := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          MyList.PastS := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          MyList.PastD := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.NbCh := StrToInt( Temp )
          else
            MyList.NbCh := 0;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.NbUn := StrToInt( Temp )
          else
            MyList.NbUn := 0;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.PrCh := StrToInt( Temp )
          else
            MyList.PrCh := 0;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.PrUn := StrToInt( Temp )
          else
            MyList.PrUn := 0;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.NbSub := StrToInt( Temp )
          else
            MyList.NbSub := 0;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.NbRef := StrToInt( Temp )
          else
            MyList.NbRef := 0;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Temp := Copy( Line, 1, Posit - 1 );
          if ( Length( Temp ) > 0 ) then
            MyList.NbBr := StrToInt( Temp )
          else
            MyList.NbBr := 0;
          MyList.Descr := Copy( Line, Posit + 1, Lgt );
        Self.AddSignature( MyList );
        Inc( TotSequence );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( Sequence, TotSequence );
end; // _______________________________________________________ReadSigSourceFile

end.
