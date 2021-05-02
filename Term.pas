{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit Term
  * Class definition of a term in any language *
   ============================================
  Description:
  The class defines all possible properties of a term, like genitive,
  plural or gender on request. Only the nominative singular (masculine) form
  is stored. The requested properties are computed for the corresponding
  language using awailable knowledge of this language. In any situation, a
  property is computed and returned.</P>
  Execution of the language methods is performed by dispatching the generic
  functions to the specific language classes, which directly inherit from the
  present class. See the following classes:</P>
  - tLatinProc for Latin, based on the Latin dictionary,
  - tXXProc for language XX, without dictionary, using language rules.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit Term;

interface

uses
  System.Classes, StdCtrls, TAHParam;

type
                             // Define the Term object
  tTerm                      = class( TObject )
  private
    fNom:                    String;             // nominative part
    fLg:                     tLanguage;          // term language
    fSid:                    tLink;              // laterality !
    fGnr:                    Boolean;            // flag is generic !
    fPos:                    Integer;            // position of placeholder
    fTyp:                    tLatType;           // type of placeholder !
    fCel:                    tCells;             // syntax of term
    fGen:                    tCells;             // syntax of genitive term
    fOK:                     Boolean;            // flag for regularity
    fAdj:                    Boolean;            // flag forced adjective !
    fFor:                    String;             // universal formula
    fLgt:                    Integer;            // length of nominative
    fNbw:                    Integer;            // number of nominative words
    fNum:                    tNumber;            // number of the term !
    fLat:                    String;             // lateral term
                             // Make the nominative plural form
    function                 MakePlural
                               : String;
                             // Make the nominative plural lateral form
    function                 MakeLatPlural
                               : String;
                             // Make the genitive singular form
    function                 MakeGenitive
                               : String;
                             // Make the genitive plural form
    function                 MakeGenPlural
                               : String;
                             // Make the genitive lateral plural form
    function                 MakeGenLatPlural
                               : String;
                             // Set the initial nominative form
    procedure                SetNominative(
                               Value: String );
                             // Set the nominative form from universal formula
    procedure                SetFormula(
                               Value: String );
                             // Retrieve a single node of a term
    function                 GetNode(
                               Index: Integer )
                               : WordAnal;
                             // Store a single node of a term
    procedure                SetNode(
                               Index: Integer;
                               Value: WordAnal );
                             // Retrieve the number of nodes of a term
    function                 GetNbWord()
                               : Integer;
                             // Define the number of nodes of a term
    procedure                SetNbWord(
                               Value: Integer );
                             // Retrieve a single node of a term GS
    function                 GetNodeGS(
                               Index: Integer )
                               : WordAnal;
                             // Store a single node of a term GS
    procedure                SetNodeGS(
                               Index: Integer;
                               Value: WordAnal );
                             // Retrieve the number of nodes of a term GS
    function                 GetNbWordGS()
                               : Integer;
                             // Define the number of nodes of a term GS
    procedure                SetNbWordGS(
                               Value: Integer );
  public
                             // Copy a term
    procedure                TermCopy(
                               ATerm: tTerm );
                             // Nominative singular form
    property Nominative:     String read fNom write SetNominative;
                             // Nominative singular form
    property NewNom:         String read fNom write fNom;
                             // Formula for the term
    property Formula:        String read fFor write SetFormula;
                             // Language of the term
    property Language:       tLanguage read fLg write fLg;
                             // Laterality of the term
    property Side:           tLink read fSid write fSid;
                             // Nominative plural form
    property Plural:         String read MakePlural;
                             // Nominative singular form with laterality
    property Lateral:        String read fLat write fLat;
                             // Nominative plural form with laterality
    property LatPlural:      String read MakeLatPlural;
                             // Genitive singular form
    property Genitive:       String read MakeGenitive;
                             // Genitive singular form
    property GenPlural:      String read MakeGenPlural;
                             // Genitive singular form
    property GenLatPlural:   String read MakeGenLatPlural;
                             // Flag for a generic term
    property IsGeneric:      Boolean read fGnr write fGnr;
                             // Word position for lateral adjective
    property WordPos:        Integer read fPos write fPos;
                             // Word type for lateral adjective
    property WordType:       tLatType read fTyp write fTyp;
                             // Flag for successful analysis
    property IsRegular:      Boolean read fOK write fOK;
                             // Flag for forced adjective
    property IsAdj:          Boolean read fAdj write fAdj;
                             // Number of words of the nominative singular form
    property NbWord:         Integer read GetNbWord write SetNbWord;
                             // Syntax analysis of nominative singular
    property Node
      [ Index: Integer ]:    WordAnal read GetNode write SetNode;
                             // Number of words of the genitive singular form
    property NbWordGS:       Integer read GetNbWordGS write SetNbWordGS;
                             // Syntax analysis of genitive singular
    property NodeGS
      [ Index: Integer ]:    WordAnal read GetNodeGS write SetNodeGS;
                             // Length of nominative part
    property LengthNom:      Integer read fLgt write fLgt;
                             // Number of words in nominative part
    property WordsNom:       Integer read fNbw write fNbw;
                             // Number of the term: singular or plural
    property Number:         tNumber read fNum write fNum;
                             // Standard constructor with initial values
    constructor              Create();
                               overload;
                             // Constructor with nominative form
    constructor              Create(
                               Nominative: String );
                               overload;
                             // Constructor with nominative form and language
    constructor              Create(
                               Nominative: String;
                               Language: tLanguage;
                               MyNumber: tNumber = nu_sin );
                               overload;
                             //
    procedure                SetCode(
                               Index: Integer;
                               Value: String );
                             // Make the nominative singular lateral form
    function                 MakeLateral(
                               IsShort: Boolean = False )
                               : String;
  end; // class tTerm

                             // Type of a contribution
  function                   TypeOf(
                               MyNode: WordAnal ):
                               tContrib;
                             // Case of a contribution
  function                   CaseOf(
                               MyNode: WordAnal ):
                               tCase;
                             // Lexical type of a contribution
  function                   LexOf(
                               MyText: String ):
                               tLexType;
                             // Syntax of a contribution
  function                   SyntaxOf(
                               MyText: String ):
                               tLatType;
implementation

uses
  FRProc, ENProc, LAProc, ESProc, RUProc;

constructor        tTerm.Create();
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create/0
  * Variant of constructor of a term with no argument *
  Description:
  This constructor create a term with no initial Nominative nor Language
  values, which are mandatory for proper functioning.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited Create;
  Self.Language := lt_none;
  Self.Side := pw_Undef;
  Self.IsGeneric := False;
  Self.Nominative := cEmpty;
end; // ________________________________________________________________Create/0

constructor        tTerm.Create(
  Nominative:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create/1
  * Variant of constructor of a term with one argument *
  Description:
  This constructor initializes a term with an initial nominative singular
  value, but without a language specified.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited Create;
  Self.Nominative := Nominative;
  Self.fNom := Nominative;
end; // ________________________________________________________________Create/1

constructor        tTerm.Create(
  Nominative:      String;
  Language:        tLanguage;
  MyNumber:        tNumber );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create/2
  * Variant of constructor of a term with 2 arguments *
  Description:
  This constructor initializes a term with an initial nominative singular
  value and with the language of the term specified.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Len:             Integer;
begin
  inherited Create;
  Self.Language := Language;
  Self.Number := MyNumber;
  Len := Length( Nominative );
  if ( ( Len > 0 ) and ( Nominative[ Len ] = cUniversal ) ) then
    Self.fNom := Copy( Nominative, 1, Len - 2 )
  else
    Self.fNom := Nominative;
  Self.Nominative := Self.fNom;
end; // ________________________________________________________________Create/2

procedure          tTerm.SetNominative(
  Value:           String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNominative
  * Action when entering a new value for the nominative property *
  Description:
  This procedure retrieves the language of the current term and dispatch to
  the specific procedure valid for this language. A recasting of the object
  class is necessary in order to reach the specific language class.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Reset for all languages
  Self.Side := pw_Undef;
  Self.IsGeneric := False;
  Self.WordPos := 0;
  Self.WordType := lt_Undef;
  Self.fnom := Value;

  // Dispatch for Latin language
  case Self.FLg of
    lt_Latin:   tLatinTerm( Self ).SetNominativeLA( Value );
    lt_English: tENTerm( Self ).SetNominativeEN( Value );
    lt_French:  tFRTerm( Self ).SetNominativeFR;
    lt_Spanish: tESTerm( Self ).SetNominativeES( Value );
    lt_Russian: tRUTerm( Self ).SetNominativeRU;
  end;
end; // ___________________________________________________________SetNominative

procedure          tTerm.TermCopy(
  ATerm:           tTerm );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TermCopy
  * Copy a term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Lgt:             Integer;
begin
  Self.fNom := ATerm.fNom;
  Self.fLg  := ATerm.fLg;
  Self.fSid := ATerm.fSid;
  Self.fGnr := ATerm.fGnr;
  Self.fPos := ATerm.fPos;
  Self.fTyp := ATerm.fTyp;
  Lgt := Length( ATerm.fCel);
  SetLength( Self.fCel, Lgt );
  for Indx := 0 to Lgt - 1 do
    Self.fCel[ Indx ] := ATerm.fCel[ Indx ];
  Lgt := Length( ATerm.fGen);
  SetLength( Self.fGen, Lgt );
  for Indx := 0 to Lgt - 1 do
    Self.fGen[ Indx ] := ATerm.fGen[ Indx ];
  Self.fOK  := ATerm.fOK;
  Self.fAdj := ATerm.fAdj;
  Self.fFor := ATerm.fFor;
  Self.fLgt := ATerm.fLgt;
  Self.fNbw := ATerm.fNbw;
  Self.fNum := ATerm.fNum;
end; // ________________________________________________________________TermCopy

procedure          tTerm.SetFormula(
  Value:           String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormula
  * Action when entering a new value for the Formula property *
  Description:
  This procedure retrieves the language of the current term and dispatch to
  the specific procedure valid for this language. A recasting of the object
  class is necessary in order to reach the specific language class.</P>
  After syntax reconstruction of each word in the formula, the term itself
  must be built from the single contributions separated by spaces (except
  after a prefix).</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NoSpace:         Boolean;
  Indx:            Integer;
  MyNom:           String;
begin
  // Reset for all languages
  Self.Side := pw_Undef;
  Self.IsGeneric := False;
  Self.WordPos := 0;
  Self.WordType := lt_Undef;
  Self.fFor := Value;

  // Dispatch for languages
  case Self.fLg of
    lt_Latin:   tLatinTerm( Self ).SetFormulaLA;
    lt_English: tENTerm( Self ).SetFormulaEN;
    lt_French:  tFRTerm( Self ).SetFormulaFR;
    lt_Spanish: tESTerm( Self ).SetFormulaES;
    lt_Russian: tRUTerm( Self ).SetFormulaRU;
  end;

  // Build the whole term if it does not exist
  NoSpace := False;
  if ( Self.fNom = cEmpty ) then
  begin
    for Indx := 0 to Self.NbWord - 1 do
    begin
      if ( Self.Node[ Indx ].Lem = cEmpty ) then
      begin
        MyNom := cEmpty;
        Break;
      end;
      if ( Indx = 0 ) then
        MyNom := Self.Node[ Indx ].Lem
      else
      if ( NoSpace ) then
        MyNom := MyNom + Self.Node[ Indx ].Lem
      else
        MyNom := MyNom + cSpace + Self.Node[ Indx ].Lem;
      if ( Self.Node[ Indx ].Cod <> cEmpty ) then
      begin
        NoSpace := ( Self.Node[ Indx ].Cod[ 1 ] = 'p' );
        NoSpace := ( NoSpace or ( ( Self.Node[ Indx ].Cod[ 1 ] = 'q' ) and
                                ( Self.Node[ Indx ].Lem = 'd''' ) ) );
      end;
    end; // for on all contributions
    Self.fNom := MyNom;
    Self.fOK := MyNom <> cEmpty;
  end;

  // Finalisation for Latin term only
  // if ( ( Self.fLg = lt_Latin ) and ( Self.fOK ) ) then
    // TLatinTerm( Self ).ProcessATerm;
end; // ______________________________________________________________SetFormula

function           tTerm.GetNode(
  Index:           Integer )
  :                WordAnal;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNode
  * Retrieve a single node of syntax analysis *
  Description:
  This method checks the range of the index value and retrieves the
  corresponding node. The range is defined from 0 to NbWord - 1.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( ( Index < Length( Self.fCel ) ) and ( Index >= 0 ) ) then
    Result := Self.fCel[ Index ];
end; // _________________________________________________________________GetNode

procedure          tTerm.SetNode(
  Index:           Integer;
  Value:           WordAnal );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNode
  * Store a single node of syntax analysis *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( Index >= Length( Self.fCel ) ) then
    SetLength( fCel, Index + 1 );
  Self.fCel[ Index ] := Value;
end; // _________________________________________________________________SetNode

procedure          tTerm.SetCode(
  Index:           Integer;
  Value:           String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetCode
  * Store the code of a single node of syntax analysis *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( ( Index >= Length( Self.fCel ) ) or ( Index < 0 ) ) then
    Exit;
  Self.fCel[ Index ].Cod := Value;
end; // _________________________________________________________________SetCode

function           tTerm.GetNbWord()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbWord
  * Get the number of words *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( fCel );
end; // _______________________________________________________________GetNbWord

procedure          tTerm.SetNbWord(
  Value:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNbWord
  * Store the number of words *
  Description:
  This method sets a new value for property NbWord.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( fCel, Value );
end; // _______________________________________________________________SetNbWord

function           tTerm.GetNodeGS(
  Index:           Integer )
  :                WordAnal;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNodeGS
  * Retrieve a single node of syntax analysis GS *
  Description:
  This method checks the range of the index value and retrieves the
  corresponding node. The range is defined from 0 to NbWord - 1.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( ( Index < Length( Self.fGen ) ) and ( Index >= 0 ) ) then
    Result := Self.fGen[ Index ];
end; // _______________________________________________________________GetNodeGS

procedure          tTerm.SetNodeGS(
  Index:           Integer;
  Value:           WordAnal );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNodeGS
  * Store a single node of syntax analysis GS *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( Index >= Length( Self.fGen ) ) then
    SetLength( fGen, Index + 1 );
  Self.fGen[ Index ] := Value;
end; // _______________________________________________________________SetNodeGS

function           tTerm.GetNbWordGS()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbWordGS
  * Get the number of words GS *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( fGen );
end; // _____________________________________________________________GetNbWordGS

procedure          tTerm.SetNbWordGS(
  Value:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNbWordGS
  * Store the number of words GS *
  Description:
  This method sets a new value for property NbWordGS.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( fGen, Value );
end; // _____________________________________________________________SetNbWordGS

function           tTerm.MakePlural()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePlural
  * Define the property Plural for any language *
  Description:
  This procedure retrieves the language of the current term and dispatch to
  the specific procedure valid for this language. A recasting of the object
  class is necessary in order to reach the specific language class.</P>
  For any language not yet or partially implemented, the return value is the
  nominative stored form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Ident:           Integer;
  IsRule:          Boolean;
begin
  case Self.fLg of
    lt_Latin:   Result := tLatinTerm( Self ).MakePluralLA( IsRule, Ident );
    lt_English: Result := tENTerm( Self ).MakePluralEN( IsRule, Ident );
    lt_French:  Result := tFRTerm( Self ).MakePluralFR( IsRule, Ident );
    lt_Spanish: Result := tESTerm( Self ).MakePluralES( IsRule, Ident );
    lt_Russian: Result := tRUTerm( Self ).MakePluralRU( IsRule, Ident );
    else        Result := Self.fNom;
  end;
end; // ______________________________________________________________MakePlural

function           tTerm.MakeLateral(
  IsShort:         Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLateral
  * Define the property Lateral for any language *
  Description:
  This procedure retrieves the language of the current term and dispatch to
  the specific procedure valid for this language. A recasting of the object
  class is necessary in order to reach the specific language class.</P>
  For any language not yet or partially implemented, the return value is the
  nominative stored form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Dispatch to the specific language
  case Self.fLg of
    lt_Latin:   Result := tLatinTerm( Self ).MakeLateralLA( IsShort );
    lt_English: Result := tENTerm( Self ).MakeLateralEN( IsShort );
    lt_French:  Result := tFRTerm( Self ).MakeLateralFR;
    lt_Spanish: Result := tESTerm( Self ).MakeLateralES;
    lt_Russian: Result := tRUTerm( Self ).MakeLateralRU;
    else        Result := Self.fNom;
  end;
  fLat := Result;
end; // _____________________________________________________________MakeLateral

function           tTerm.MakeLatPlural
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLatPlural
  * Define the property plural lateral for any language *
  Description:
  This procedure retrieves the language of the current term and dispatch to
  the specific procedure valid for this language. A recasting of the object
  class is necessary in order to reach the specific language class.</P>
  For any language not yet or partially implemented, the return value is the
  nominative stored form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  case Self.fLg of
    lt_Latin:   Result := tLatinTerm( Self ).MakeLatPluralLA;
    lt_English: Result := tENTerm( Self ).MakeLatPluralEN;
    lt_French:  Result := tFRTerm( Self ).MakeLatPluralFR;
    lt_Spanish: Result := tESTerm( Self ).MakeLatPluralES;
    lt_Russian: Result := tRUTerm( Self ).MakeLatPluralRU;
    else        Result := Self.fNom;
  end;
end; // ___________________________________________________________MakeLatPlural

function           tTerm.MakeGenitive()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenitive
  * Define the property Genitive for any language *
  Description:
  This procedure retrieves the language of the current term and dispatch to
  the specific procedure valid for this language. A recasting of the object
  class is necessary in order to reach the specific language class.</P>
  For any language not yet or partially implemented, the return value is the
  nominative stored form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  case Self.fLg of
    lt_Latin:   Result := tLatinTerm( Self ).MakeGenitiveLA;
    lt_English: Result := tENTerm( Self ).MakeGenitiveEN;
    lt_French:  Result := tFRTerm( Self ).MakeGenitiveFR;
    lt_Spanish: Result := tESTerm( Self ).MakeGenitiveES;
    lt_Russian: Result := tRUTerm( Self ).MakeGenitiveRU;
    else        Result := Self.fNom;
  end;
end; // ____________________________________________________________MakeGenitive

function           tTerm.MakeGenPlural()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenPlural
  * Define the property GenPlural for any language *
  Description:
  This procedure retrieves the language of the current term and dispatch to
  the specific procedure valid for this language. A recasting of the object
  class is necessary in order to reach the specific language class.</P>
  For any language not yet or partially implemented, the return value is the
  nominative stored form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  case Self.fLg of
    lt_Latin:   Result := tLatinTerm( Self ).MakeGenPluralLA;
    lt_Russian: Result := tRUTerm( Self ).MakeGenPluralRU;
    else        Result := Self.fNom;
  end;
end; // ___________________________________________________________MakeGenPlural

function           tTerm.MakeGenLatPlural
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenLatPlural
  * Define the property GenLatPlural for any language *
  Description:
  This procedure retrieves the language of the current term and dispatch to
  the specific procedure valid for this language. A recasting of the object
  class is necessary in order to reach the specific language class.</P>
  For any language not yet or partially implemented, the return value is the
  nominative stored form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  case Self.fLg of
    lt_Latin:   Result := tLatinTerm( Self ).MakeGenLatPluralLA;
    lt_English: Result := tENTerm( Self ).MakeGenLatPluralEN;
    lt_French:  Result := tFRTerm( Self ).MakeGenLatPluralFR;
    lt_Spanish: Result := tESTerm( Self ).MakeGenLatPluralES;
    lt_Russian: Result := tRUTerm( Self ).MakeGenLatPluralRU;
    else        Result := Self.fNom;
  end;
end; // ________________________________________________________MakeGenLatPlural

function           TypeOf(
  MyNode:          WordAnal )
  :                tContrib;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TypeOf
  * Retrieve the type of a word *
  Description:
  This procedure check for all values of cContrib and set the type according
  to a found matching value, undefined otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            tContrib;
  MyType:          String;
begin
  Result := co_Undefined;
  if ( Length( MyNode.Cod ) > 0 ) then
    MyType := MyNode.Cod[ 1 ]
  else
    Exit;
  for Indx := Low( tContrib ) to High( tContrib ) do
  begin
    if ( cContrib[ Indx ] = MyType ) then
    begin
      Result := Indx;
      Exit;;
    end;
  end; // for on all possible values of cContrib
end; // __________________________________________________________________TypeOf

function           CaseOf(
  MyNode:          WordAnal )
  :                tCase;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CaseOf
  * Retrieve the case of a word *
  Description:
  This procedure check for nominative or genitive and set the case according
  to a found matching value, undefined otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyCase:          String;
begin
  Result := ca_Unspec;
  if ( Length( MyNode.Cod ) > 3 ) then
    MyCase := MyNode.Cod[ 4 ]
  else
    Exit;
  if ( MyCase = 'n' ) then
    Result := Succ( ca_unspec )
  else
  if ( MyCase = 'g' ) then
    Result := Succ( Succ( ca_unspec ) );
end; // __________________________________________________________________CaseOf

function           LexOf(
  MyText:          String )
  :                tLexType;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LexOf
  * Retrieve the lexical type of a contribution in a formula *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            tLexType;
  MyCase:          String;
begin
  Result := lx_Undef;
  if ( Length( MyText ) > 0 ) then
    MyCase := MyText[ 1 ]
  else
    Exit;
  for Indx := Succ( Low( tLexType ) ) to High( tLexType ) do
  begin
    if ( cLexType[ Indx ] = Mycase ) then
    begin
      Result := Indx;
      Exit;;
    end;
  end; // for on all possible types of cLexType
end; // ___________________________________________________________________LexOf

function           SyntaxOf(
  MyText:          String )
  :                tLatType;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SyntaxOf
  * Retrieve the syntax type of a contribution in a formula *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            tLatType;
begin
  Result := lt_Undef;
  if ( MyText = cEmpty ) then
    Exit;
  for Indx := Succ( Low( tLatType ) ) to High( tLatType ) do
  begin
    if ( cLatString[ Indx ] = MyText ) then
    begin
      Result := Indx;
      Exit;;
    end;
  end; // for on all possible values of cLatType
end; // ________________________________________________________________SyntaxOf

end.
