{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit Notes
  * Class container for notes *
  Description:
  This class is the container of all TAH notes. It includes the methods for
  the reading of the exported database file of notes and different retrieval
  methods.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit Notes;

interface

uses
  TAHParam;

type

  tNote                      = class( TObject )
  private
    fNotes:                  array of NoteRec;
    fName:                   String;
    function                 GetTotNotes
                               : Integer;
  public
    property TotNotes:       Integer read GetTotNotes;
    property FileName:       String read fName write fName;

                             // Read the bivalued properties source file
    procedure                ReadNotesSourceFile;
                             // Get a note position from TID
    function                 NoteGetPositionByTID(
                              TID: Integer )
                              : Integer;
                             // Retrieve all notes for an entity
    function                 GetNotes(
                               TID: Integer;
                               var NbNote: Integer;
                               var MyNote: Array of NoteRec )
                               : Boolean;
                             // Get a single note
    function                 Note(
                               Index: Integer )
                               : NoteRec;
  end;

implementation

uses
  TAHBrowser, SysUtils;

function           tNote.GetTotNotes
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTotNotes
  * Get the number of notes *
  Description:
  The method retrieves the number of available notes as exported from the
  TAH database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fNotes );
end; // _____________________________________________________________GetTotNotes

procedure          tNote.ReadNotesSourceFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadNotesFile
  * Read the notes records from database source file *
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
  MyTyp:           String;
  Trans:           String;
  Indnt:           tNoteType;
begin
  // Open input file in text format, splitted or unsplitted
  TotNotes := 0;
  AllocRec := 0;
    AssignFile( Infile, fName );
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
          SetLength( fNotes, AllocRec );
        end;

        // Expected format is made of 6 fields:
        // TID¦UID¦Typ¦Who¦Dat¦Txt
        with fNotes[ TotNotes ] do
        begin
          Posit := Pos( CurSep, Line );
          if ( Posit = 0 ) then
            Continue;
          TID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          UID := 0;
          if ( Length( Trans ) > 0 ) then
            UID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          MyTyp := Copy( Line, 1, Posit - 1 );
          for Indnt := Low( tNoteType ) to High( tNoteType ) do
            if MyTyp = cNoteValue[ Indnt ] then
              Typ := Indnt;
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Who := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Dat := Copy( Line, 1, Posit - 1 );
          Txt := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( cSpace, Dat );
          Dat := Copy( Dat, 1, Posit - 1 );
        end;
        Inc( TotNotes );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( fNotes, TotNotes );
end; // ___________________________________________________________ReadNotesFile

function           tNote.NoteGetPositionByTID(
  TID:             Integer )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NoteGetPositionByTID
  * Get the first note position from TID *
  Description:
  This method retrieves the first note position for a specified entity,
  knowing that all notes for this entity are consecutive records in the
  collection of notes. A negative value for the position is given when no
  note is available for the specified entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  Result := -1;
  for Indx := 0 to Self.TotNotes - 1 do
  begin
    if ( TID = Self.fNotes[ Indx ].TID ) then
    begin
      Result := Indx;
      Break;
    end else
    if ( TID < Self.fNotes[ Indx ].TID ) then
      Break;
  end; // for
end; // ____________________________________________________NoteGetPositionByTID

function           tNote.GetNotes(
  TID:             Integer;
  var NbNote:      Integer;
  var MyNote:      Array of NoteRec )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNotes
  * Collect all notes relative to the specified entity *
  Description:
  This method is based on the fact that the note file is sorted on ascending
  TID values. It scans the notes and skip all entries until if find the
  first entry for the specified TID (TAH internal identifier). Then, it looks
  for all possible types of notes. Any type of note can have multiple
  occurences in the note file. Finally, it stops reading the file as soon
  as the TID value is higher than the one specified.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
begin

  // Loop on all existing notes
  Result := False;
  for Indy := 0 to Self.TotNotes - 1 do
  begin

    // Select the current index
    if ( TID < fNotes[ Indy ].TID ) then
      Break;
    if ( TID > fNotes[ Indy ].TID ) then
      Continue;

    // Grab all the notes for current index
    if ( TID = fNotes[ Indy ].TID ) then
    begin
      MyNote[ NbNote ] := fNotes[ Indy ];
      Inc( NbNote );
      Result := True;
    end;
  end; // for
end; // ________________________________________________________________GetNotes

function           tNote.Note(
  Index:           Integer )
  :                NoteRec;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Note
  * Get a single note *
  Description:
  This method retrieve a single note record from its position.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( ( Index >= 0 ) and ( Index < Self.TotNotes ) ) then
    Result := Self.fNotes[ Index ];
end; // ____________________________________________________________________Note

end.
