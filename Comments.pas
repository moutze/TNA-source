{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit Comments
  * Class definition of the comments *
  Description:
  This class is the container of all comments.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit Comments;

interface

uses
  TAHParam;

type
  tComment                   = class( TObject )
  private
    fTID:                    Integer;
    fUID:                    Integer;
    fSect:                   tSectionType;
    fLg:                     tLanguage;
    fWho:                    String;
    fDat:                    String;
    fTex:                    String;
  public
    property TID:            Integer read fTID;
    property UID:            Integer read fUID;
    property Section:        tSectionType read fSect;
    property Lang:           tLanguage read fLg;
    property Who:            String read fWho;
    property Dat:            String read fDat;
    property Comment:        String read fTex;
                             // Resolve hyperlinks in comments
    function                 MakeHyperlinks(
                               Mydef: String;
                               Lang: tLanguage;
                               Refer: Boolean = False;
                               IsNo: Boolean = False )
                               : String;
  end; // class tComment

  tComments                  = class( TObject )
  private
    fComm:                   Array of tComment;
    fName:                   String;
    function                 GetNbComments()
                               : Integer;
    procedure                Read;
  public
                             // Number of available comments
    property NbComments:     Integer read GetNbComments;
                             // File for comments
    property FileName:       String read fName write fName;
                             // Read the comments file
    procedure                ReadCommFile;
                             // Search for a specific comment
    function                 GetCommentByTID(
                               TID: Integer;
                               Lang: tLanguage;
                               Section: tSectionType )
                               : tComment;
  end; // class tComments

implementation

uses
  TAHBrowser, SysUtils, Entity;

function           tComments.GetNbComments()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbComments
  * Get the number of comments *
  Description:
  The method retrieves the number of comments as exported from the
  TAH database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fComm );
end; // ___________________________________________________________GetNbComments

function           tComments.GetCommentByTID(
  TID:             Integer;
  Lang:            tLanguage;
  Section:         tSectionType )
  :                tComment;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetCommentByTID
  * Get a comment according to TID, language and section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbRec:           Integer;
  MyComment:       tComment;
begin
  Result := nil;
  NbRec := Self.NbComments;
  for Indx := 0 to NbRec - 1 do
  begin
    MyComment := fComm[ Indx ];
    if ( ( MyComment.TID = TID ) and
         ( MyComment.Lang = Lang ) and
         ( MyComment.Section = Section ) ) then
    begin
      Result := MyComment;
      Break;
    end;
  end; // for on all comments
end; // _________________________________________________________GetCommentByTID

function           tComment.MakeHyperlinks(
  Mydef:           String;
  Lang:            tLanguage;
  Refer:           Boolean;
  IsNo:            Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHyperlinks
  * Resolve hyperlinks in the specified language *
  Description:
  This method scans the raw text of a definition as issued from the database
  in HTML format. It searches for any number of pairs of curled brackets, each
  of them specifying an hyperlink to be created.</P>
  The interior of each bracket pair is made of two strings separated by a
  comma. The first string is any text representing an entity, that is to be
  left unchanged in the textual stream. The second string represents an
  entity identifier, specifying an Entity page where the hyperlink has to
  move. The hyperlink is positionned on the first string.</P>
  This procedure is valid for all languages. However, the hyperlink has to
  adress a Unit page with the same main and display languages.</P>
  The parameter Refer, if true (false by default), commands the addition of a
  pair of square brackets immediately after the hyperlink, containing the
  Latin short official term of the specified entity.</P>
  The parameter IsNo, if true (false by default), asks for the suppression of
  all reference in the text.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  Start:           Integer;
  Stop:            Integer;
  Lgt:             Integer;
  MyTID:           Integer;
  MyUID:           Integer;
  DefText:         String;
  Bracket:         String;
  Before:          String;
  After:           String;
  Atext:           String;
  AnID:            String;
  ARef:            String;
  LAText:          String;
  LangDir:         String;
  MyEntity:        tEntity;
begin
  // Initial stuff
  DefText := Mydef;
  Result := MyDef;
  Lgt := Length( MyDef );

  // Define the language path
  LangDir := cLgShort[ TAH.MainLang ];
  if ( TAH.MainLang = lt_Latin ) then
    LangDir := LangDir + cLgShort[ TAH.SubstLang ];
  LangDir := LangDir + cSlash;

  // Loop on several possible texts in curled brackets
  Start := Pos( cCul, DefText );
  while ( Start > 0 ) do
  begin

    // Extract the next text in curled brackets
    Before := Copy( DefText, 1, Start - 1 );
    DefText := Copy( DefText, Start + 1, Lgt );
    Stop := Pos( cCur, DefText );
    if ( Stop = 0 ) then
      Exit;
    Bracket := Copy( DefText, 1, Stop - 1 );
    After := Copy( DefText, Stop + 1, Lgt );

    // Transform the text in curled brackets
    Posit := Pos( cComma, Bracket );
    if ( Posit = 0 ) then
      Exit;
    AText := Copy( Bracket, 1, Posit - 1 );
    AnID := Copy( Bracket, Posit + 2, Length( Bracket ) );
    AnID := Trim( AnID );
    MyTID := StrToInt( AnID );
    MyEntity := TAH.GetEntityByPos( MyTID );
    MyUID := MyEntity.Tetra;
    if ( ( not Refer ) and ( not IsNo ) ) then
      Bracket := AOTAG + cHrefEmpty + cRetroDir2x + cUnit + cSlash + LangDir +
                 cTAH + IntToStr( MyUID ) + cSpace + cUnit + cSpace +
                 cLgShort[ TAH.DisLanguage ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + AText + AETAG
    else
      Bracket := AText;

    // Add the Latin text and reference in square brackets
    ARef := cEmpty;
    if ( Refer and ( AnID <> cEmpty ) ) then
    begin
      LAText := cEmpty;
      if ( MyEntity <> nil ) then
      begin
        LAText := MyEntity.GetLibelle( lb_Base, lt_Latin );
        LAText := AOTAG + cHrefEmpty + cRetroDir + LangDir +
                  cTAH + AnID + cSpace + cLgShort[ TAH.DisLanguage ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + LAText + AETAG;
      end;
      ARef := cSpace + cSql + LAText + cSqr;
    end;

    // Rebuild the plain text of definition
    DefText := Before + Bracket + ARef + After;
    Result := DefText;
    Start := Pos( cCul, DefText );
  end; // while on all pairs of curled brackets
end; // __________________________________________________________MakeHyperlinks

procedure          tComments.ReadCommFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadCommFile
  * Read the file of comments of test cases *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.Read;
end; // ____________________________________________________________ReadCommFile

procedure          tComments.Read;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Read
  * Read the file of comments of test cases *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  AllocRec:        Integer;
  NbRec:           Integer;
  Line:            String;
  Filename:        String;
  LgShort:         String;
  InFile:          TextFile;
  Indx:            tLanguage;
  MyComment:       tComment;
begin
  // Open input file in text format, splitted or unsplitted
  Filename := Self.FileName;
  AssignFile( Infile, FileName );
  Reset( InFile );
  NbRec := 0;
  AllocRec := 0;

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
      if NbRec >= AllocRec then
      begin
        Inc( AllocRec, 20 );
        SetLength( fComm, AllocRec );
      end;

      // Prepare all variables of a comment
      MyComment := tComment.Create;
      Posit := Pos( CurSep, Line );
      MyComment.fTID := StrToInt( Copy( Line, 1, Posit - 1 ) );
      Lgt := Length( Line );
      Line := Copy( Line, Posit + 1, Lgt );
      Posit := Pos( CurSep, Line );
      MyComment.fUID := StrToInt( Copy( Line, 1, Posit - 1 ) );
      Lgt := Length( Line );
      Line := Copy( Line, Posit + 1, Lgt );
      Posit := Pos( CurSep, Line );
      MyComment.fSect :=
        tSectionType( StrToInt( Copy( Line, 1, Posit - 1 ) ) );
      Lgt := Length( Line );
      Line := Copy( Line, Posit + 1, Lgt );
      Posit := Pos( CurSep, Line );
      LgShort := Copy( Line, 1, Posit - 1 );
      for Indx := lt_Latin to lt_Russian do
        if ( cLgShort[ Indx ] = LgShort ) then
          MyComment.fLg := Indx;
      Lgt := Length( Line );
      Line := Copy( Line, Posit + 1, Lgt );
      Posit := Pos( CurSep, Line );
      MyComment.fWho := Copy( Line, 1, Posit - 1 );
      Lgt := Length( Line );
      Line := Copy( Line, Posit + 1, Lgt );
      Posit := Pos( CurSep, Line );
      MyComment.fDat := Copy( Line, 1, Posit - 1 );
      MyComment.fTex := Copy( Line, Posit + 1, Length( Line ) );
      fComm[ NbRec ] := MyComment;
      Inc( NbRec );
    end;
  end; // while on all comments
  SetLength( fComm, NbRec );

  // Close the reading of source file
  CloseFile( InFile );
end; // ____________________________________________________________________Read

end.
