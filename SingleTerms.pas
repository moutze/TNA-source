{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit SingleTerms
  * Class definition of processed terms *
  Description:
  A processed term is a class for the follow-up of the different processes
  occuring to any term, from its raw language definition to its exact
  formulation as defined by the authors of the terminology.</p>
  There is a unique class for processed terms, valid for all languages.</P>
  A processed term is attached to an entity specified by its TID.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit SingleTerms;

interface

uses
  TAHParam, Term;

type

                             // Class for a term in any language
  tSingle                    = class( TObject )
  private
    fBas:                    String;
    fIni:                    String;
    fMdt:                    String;
    fSht:                    String;
    fOpt:                    String;
    fBra:                    String;
    fTerm:                   tTerm;
    fCat:                    tSynType;                                     // DB
    fEff:                    tSynType;
    fPerf:                   Boolean;
    fErr:                    Integer;
    fChain:                  String;
    fDone:                   Boolean;
    fMult:                   Boolean;
    fBld:                    tBuild;
    fTID:                    Integer;                                      // DB
    fLID:                    Integer;                                      // DB
    fUID:                    Integer;                                      // DB
    fExp:                    Integer;                                      // DB
    fObl:                    Integer;                                      // DB
    fPrf:                    Integer;                                      // DB
    fAdj:                    Integer;                                      // DB
    fPre:                    Integer;                                      // DB
    fSel:                    String;                                       // DB
    fNom:                    Integer;
    fMdl:                    Boolean;                                     // del
    fFix:                    Boolean;                                     // del
    fUpd:                    String;                                       // DB
    fIsu:                    Boolean;
    fLan:                    tLanguage;
    fPos:                    Integer;
    fSrc:                    String;                                       // DB
    fInt:                    Integer;                                     // del
    fLib:                    String;                                       // DB
    fBiS:                    Boolean;
    fBiQ:                    Boolean;
  public
    procedure                DecodeTerm(
                               Line: String );
                             //
    Property Intrinsic:      String read fBas write fBas;
                             // Base part of term without any expansion
    Property Basic:          String read fIni write fIni;
                             // Full term with optional expansion
    Property Mandat:         String read fMdt write fMdt;
                             // Short term without optional expansion
    Property Short:          String read fSht write fSht;
                             // Optional part
    Property Option:         String read fOpt write fOpt;
                             // Bracket add-on
    Property Bracket:        String read fBra write fBra;
                             // Language term with syntax analysis
    property LgTerm:         tTerm read fTerm write fTerm;
                             // Flag for successful expansion
    property Performed:      Boolean read fPerf write fPerf;
                             // Error number when expansion unsuccessful
    Property ErrNo:          Integer read fErr write fErr;
                             // Error chain
    Property ErrChain:       String read fChain write fChain;
                             // Flag when expansions have been performed
    property Done:           Boolean read fDone write fDone;
                             //
    property Multiple:       Boolean read fMult write fMult;
                             //
    property BuildFrom:      tBuild read fBld write fBld;
                             // TID of related entity (read from DB)
    property TID:            Integer read fTID write fTID;
                             // Language specific internal identifier
    property LID:            Integer read fLID write fLID;
                             // UID of related unit  (read from DB)
    property UID:            Integer read fUID write fUID;
                             // TID of optional expansion
    property Exp:            Integer read fExp write fExp;
                             // TID of mandatory expansion
    property Obl:            Integer read fObl write fObl;
                             // TID of prefix expansion
    property Prefix:         Integer read fPrf write fPrf;
                             // TID of adjective expansion
    property Adjective:      Integer read fAdj write fAdj;
                             // TID of preposition expansion
    property Prepos:         Integer read fPre write fPre;
                             //
    property SelPrep:        String read fSel write fSel;
                             // Number of nominative words
    property NbNom:          Integer read fNom write fNom;
                             // unused
    property IsModel:        Boolean read fMdl write fMdl;
                             // Flag for search of fixed bilateral arguments
    property IsFix:          Boolean read fFix write fFix;
                             // Date of last update (read from DB)
    property Update:         String read fUpd write fUpd;
                             // Type of term (read from DB)
    property Category:       tSynType read fCat write fCat;
                             // Effective type after expansions
    property Effective:      tSynType read fEff write fEff;
                             // Flag for universal term (issued from a formula)
    property IsUniversal:    Boolean read fIsu write fIsu;
                             // Language of the term
    property Language:       tLanguage read fLan write fLan;
                             // Author of last update (read from DB)
    property Source:         String read fSrc write fSrc;
                             // unused
    property IntLgt:         Integer read fInt write fInt;
                             // Base part of term (read from DB)
    property Libelle:        String read fLib write fLib;
                             // Flag for bilateral mandatory expansion
    property IsBilMand:      Boolean read fBiS write fBiS;
                             // Flag for bilateral optional expansion
    property IsBilOpt:       Boolean read fBiQ write fBiQ;
                             // Constructor of the class in specified language
    constructor              Create(
                               Lang: tLanguage );
                               overload;
                             // Make the expansions of a term in any language
    procedure                ExpansionTerm;
                             // Make a base term for a lateral entity
    function                 MakeBasLateral
                               : Boolean;
                             // Make an base term for a pair
    function                 MakeBasPair
                               : Boolean;
                             // Make an base term for a set
    function                 MakeBasSet
                               : Boolean;
                             // Make an base term for a pset
    function                 MakeBasPset
                               : Boolean;
                             // Make an official synonym for a lateral entity
    function                 MakeOffLateral
                               : Boolean;
                             // Make an official synonym for a pair
    function                 MakeOffPair
                               : Boolean;
                             // Make an official synonym for a set
    function                 MakeOffSet
                               : Boolean;
                             // Make an official synonym for a pset
    function                 MakeOffPset
                               : Boolean;
                             // Make an official synonym for base term
    function                 MakeOffBas
                               : Boolean;
                             // Make a display synonym for a pair
    function                 MakeOfdPair
                               : Boolean;
                             // Make a display synonym for a single entity
    function                 MakeOfdSingle
                               : Boolean;
                             // Make a display term for a pair
    function                 MakeDisPair(
                               AType: tSynType )
                               : Boolean;
                             // Make a display term for a lateral set entity
    function                 MakeDisLateralSet
                               : Boolean;
                             // Make a display term for a set
    function                 MakeDisSet
                               : Boolean;
                             // Make a plural term for a set generic entity
    function                 MakePluralGeneric
                               : Boolean;
                             // Make a plural term for a set specific entity
    function                 MakePluralSpecific
                               : Boolean;
                             // Make a plural term for a set lateral entity
    function                 MakePluralLateral
                               : Boolean;
                             // Make FMA term for a pair
    function                 MakeFMAPair
                               : Boolean;
                             // Make a generator term from Latin model
    function                 MakeBasGener
                               : Boolean;
                             // Make a term from a Latin model for a single
    function                 MakeFormulaSingle
                               : Boolean;
                             // Make a term from a Latin model for a pair
    function                 MakeFormulaPair
                               : Boolean;
                             // Make a generic set term from a formula
    function                 MakeFormulaGeneric
                               : Boolean;
                             // Make a specific pset term from a formula
    function                 MakeFormulaSpecific
                               : Boolean;
                             // Make a term from a Latin model for lateral entities
    function                 MakeFormulaLateral
                               : Boolean;
                             // Add an adjective of expansion
    function                 SetAdjective
                               : Boolean;
                             // Make adjective in a specific language
    function                 MakeAdjective(
                               MyAdj: String;
                               MyPref: String )
                               : Boolean;
                             // Set the mandatory expansion of a term
    function                 SetMandat
                               : Boolean;
                             // Make mandatory expansion in a specific language
    function                 MakeMandat(
                               MyTerm: tSingle )
                               : Boolean;
                             // Set the optional expansion of a term
    function                 SetOption
                               : Boolean;
                             // Dispatch to specific languages
    function                 MakeOption(
                               MyTerm: tSingle )
                               : Boolean;
                             // Set the optional expansion of a term: Spanish
    procedure                SetOptionSP(
                               OptionTerm: tSingle );
                             // Set the laterality of a term
    function                 SetBase(
                               IsBil: Boolean )
                               : Boolean;
                             // Dispatch laterality to the specific languages
    function                 MakeBase
                               : Boolean;
                             // Set the base part of a term: Spanish
    procedure                SetBaseSP;
                             // Set a formal pset term
    function                 SetFormalPSet(
                               Term: tSingle )
                               : String;
                             // Set a formal set term
    function                 SetFormalSet(
                               Term: tSingle )
                               : String;
                             // Extract the model from a formula
    function                 GetModelFormula()
                               : String;
                             // Set any expansion error
    function                 SetError(
                               ErrNo: Integer;
                               Past: tSingle = nil )
                               : String;
  end; // class tSingle

  //
  function                   GetLateralValue(
                               MyArg: String )
                               : tLatType;
                             // Calculate the number of words in a term
  function                   NumberOfWords(
                               MyTerm: String ):
                               Integer;

implementation

uses
  SysUtils, TAHBrowser, LAProc, FRProc, ENProc, RUProc, Tetra,
  Entity, ESProc, IBUtils, HTMLSection, TAHInterface;

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tSingle.Create
  * Constructor of the class of single term in a specified language *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
constructor        tSingle.Create(
  Lang:            tLanguage );
begin
  inherited Create;
  Self.BuildFrom := bd_Undef;
  Self.Effective := st_Undef;
  Self.fLan := Lang;
end; // __________________________________________________________________Create

procedure          tSingle.DecodeTerm(
  Line:            String);
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DecodeTerm
  * Decode a line of raw input file *
  Description:
  This procedure decode a raw input line in any language except Latin.</P>
  Expected format is made of 13 fields (12 if lt_Universal):
  UID = Unit identifier
  TID = TID of related entity in unit (absent if lt_universal)
  LID = formula identifier (presently unused)
  Opt = TID of optional expansion
  Obl = TID of mandatory expansion
  Prf = TID of prefix expansion
  Adj = TID of adjective expansion
  Pre = TID of preposition expansion
  Sel = Type of preposition
  Cat = category of formula (mod, md1, md2, md3)
  Dat = date of last change
  Src = author of the formula
  Lib = basic universal formula, as string comma separated</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  Lgt:             Integer;
  Expr:            String;
  IndS:            tSynType;
begin

  // Decode the identifiers
  Lgt := Length( Line );
  Posit := Pos( CurSep, Line );
  Line := Copy( Line, Posit + 1, Lgt );
  if ( Self.Language <> lt_Universal ) then
  begin
    Posit := Pos( CurSep, Line );
    TID := StrToInt( Copy( Line, 1, Posit - 1 ) );
    Line := Copy( Line, Posit + 1, Lgt );
  end;
  Posit := Pos( CurSep, Line );
  LID := StrToInt( Copy( Line, 1, Posit - 1 ) );
  Line := Copy( Line, Posit + 1, Lgt );

  // Decode the expansions
  Posit := Pos( CurSep, Line );
  Exp := 0;
  if Posit > 1 then
    Exp := StrToInt( Copy( Line, 1, Posit - 1 ) );
  Line := Copy( Line, Posit + 1, Lgt );
  Posit := Pos( CurSep, Line );
  Obl := 0;
  if Posit > 1 then
    Obl := StrToInt( Copy( Line, 1, Posit - 1 ) );
  Line := Copy( Line, Posit + 1, Lgt );
  Posit := Pos( CurSep, Line );
  Prefix := 0;
  if Posit > 1 then
    Prefix := StrToInt( Copy( Line, 1, Posit - 1 ) );
  Line := Copy( Line, Posit + 1, Lgt );
  Posit := Pos( CurSep, Line );
  Adjective := 0;
  if Posit > 1 then
    Adjective := StrToInt( Copy( Line, 1, Posit - 1 ) );
  Line := Copy( Line, Posit + 1, Lgt );
  Posit := Pos( CurSep, Line );
  Prepos := 0;
  if Posit > 1 then
    Prepos := StrToInt( Copy( Line, 1, Posit - 1 ) );
  Line := Copy( Line, Posit + 1, Lgt );
  Posit := Pos( CurSep, Line );
  SelPrep := Copy( Line, 1, Posit - 1 );
  Line := Copy( Line, Posit + 1, Lgt );

  // Decode the category
  Posit := Pos( CurSep, Line );
  Expr := Copy( Line, 1, Posit - 1 );
  Category := st_Undef;
  for IndS := low( tSynType ) to Pred( High( tSynType ) ) do
  begin
    if ( cSynType[ IndS ] = Expr ) then
    begin
      Category := IndS;
      Break;
    end;
  end; // for
  Line := Copy( Line, Posit + 1, Lgt );

  // Decode the administrative information
  Posit := Pos( CurSep, Line );
  Update := Copy( Line, 1, Posit - 1 );
  Line := Copy( Line, Posit + 1, Lgt );
  Posit := Pos( CurSep, Line );
  Source := Copy( Line, 1, Posit - 1 );

  // Decode the base information
  Libelle := Copy( Line, Posit + 1, Lgt );
end; // ______________________________________________________________DecodeTerm

function           GetLateralValue(
  MyArg:           String )
  :                tLatType;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetLateralValue
  * Get a lateral adjective *
  Description:
  The two possible adjectives are sinister and dexter. The adjective is
  specified by the first argument.</P>
  Each adjective has 3 x 2 x 2 = 12 possible forms according to gender (3),
  number (2) and case (2). The form is specified by the second argument.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            tLatType;
begin
  Result := lt_undef;
  for Indx := Succ( Low( tLatType ) ) to High( tLatType ) do
  begin
    if ( MyArg = cLatString[ Indx ] ) then
    begin
      Result := Indx;
      Break;
    end
  end; // for
end; // _________________________________________________________GetLateralValue

function           NumberOfWords(
  MyTerm:          String )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NumberOfWords
  * Retrieve the number of words in a term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  Total:           Integer;
begin
  MyTerm := Trim( MyTerm );
  Total := 1;
  Posit := Pos( cSpace, MyTerm );
  while ( Posit > 0 ) do
  begin
    Inc( Total );
    MyTerm := Copy( Myterm, Posit + 1, Length( MyTerm ) );
    Posit := Pos( cSpace, MyTerm );
  end; // while
  Result := Total
end; // ___________________________________________________________NumberOfWords

procedure          tSingle.ExpansionTerm;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ExpansionTerm
  * Handling of expansions of a term in any language *
  Description:
  This procedure makes the specified expansions attached to a term. The
  source of information when building a term is anyone of the following:
  - Specified base term.
  - Previously stored term,
  - Latin modeled term.</P>
  A specified base term is a raw text accompanied by zero, one or two
  expansion entities given by their identifier. The first entity specifies
  an expansion of specification and the second entity specifies an expansion
  of qualification.</P>
  A previously stored term is accompanied by arguments necessary for
  guiding its expansion.</P>
  A modeled term is entirely build from the given model contributions
  according to the modeling rules.</P>

  The expansion process generates full Latin strings, which by adequate
  combinations make the official term, official synonyms, or any other variant
  of them. These four strings are the following:
  - Mandatory part, containing the expansion of specification, always present,
  - Optional part, containing the expansion of qualification, optional,
  - Short part, which is an alternate version of the mandatory part, replacing
  it when the expansion of qualification is not used, if it is different of
  the mandatory part,
  - Bracket part, for simplified presentation of entities with pair or set.</P>
  The expansion process has to take care of the eventual bilaterality of its
  constituting entities. It generates all possible positions and types of the
  bilateral adjectives necessary for specifying bilaterality. This process is
  driven by strict language rules for Latin, documented elsewhere. There are
  a maximum of two generated positions and types for a given term.</P>
  The strings of the four parts plus the two positions and types uniquely
  specifies a term. They are necessarily present in a stored value, or they
  can be inferred from a modeled term.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  IntPos:          Integer;
  IntLgt:          Integer;
  NbMod:           Integer;
  NbCurr:          Integer;
  Posit:           Integer;
  MyWordQ:         Integer;
  MyWordS:         Integer;
  MyTID:           Integer;
  MyUID:           Integer;
  NbPos:           Integer;
  Minus:           Integer;
  IsBil:           Boolean;
  IsBilOpt:        Boolean;
  IsBilMand:       Boolean;
  IsFirst:         Boolean;
  IsMult:          Boolean;
  IsGeneric:       Boolean;
  IsUniv:          Boolean;
  IsAdj:           Boolean;
  IsMand:          Boolean;
  IsBas:           Boolean;
  IsOpt:           Boolean;
  MyArg:           String;
  MandatInit:      String;
  Option:          String;
  Decl:            String;
  Dummy:           String;
  MySyntax:        String;
  PastSyntax:      String;
  Value:           String;
  Explicit:        String;
  MyMandat:        String;
  MyType:          String;
  Genitive:        String;
  MyPlus:          String;
  MyAdj:           String;
  MyPre:           String;
  Lang:            tLanguage;
  EntityS:         tEntity;
  EntityQ:         tEntity;
  LexEntity:       tEntity;
  Actual:          tEntity;
  VocUnit:         tUnit;
  ATerm:           tSingle;
  OptionTerm:      tSingle;
  MandatTerm:      tSingle;
  MyTerm:          tTerm;
  MyModel:         tSingle;
  MyPos:           Array[ 0 .. 2 ] of Integer;
  MyUnit:          tUnit;
  Query:           tSearch;
  AFRTerm:         tFRTerm;
  ARUTerm:         tRUTerm;
  MyGender:        tGender;
begin

  // Initial stuff
  // =============
  Self.Performed := True;
  Self.ErrNo := 0;
  Lang := Self.Language;
  MandatInit := Self.Libelle;
  Self.Basic := MandatInit;
  Self.Mandat := MandatInit;
  if ( Self.Category in [ st_tex, st_Mod, st_val, st_vl2 ] ) then
  begin
    Self.Done := True;
    Exit;
  end;
  if ( Self.TID = 0 ) then
  begin
    Self.Done := True;
    Exit;
  end;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
    Actual.Bilateral := ( ( Actual.TetraTip >= tp_genpair ) and
                          ( Actual.TetraTip <= tp_rightpset ) );
  IsUniv := False;
  if ( IsUniv ) then
    Exit;
  IsUniv := Self.IsUniversal;
  MandatTerm := nil;

  // Generation of non formula terms
  IntPos := 1;             // Position of intrinsic part of term
  IntLgt := Self.IntLgt;   // Length of intrinsic part of term
  if ( Self.LgTerm = nil ) then
    Self.LgTerm := tTerm.Create( Self.Mandat, Lang );

  // Preprocessing: Management of an inherited term
  // ==============================================
  if ( Self.Category in cGroupInherit ) then
  begin

    // Search for the universal formula to inherit from
    Actual.LgCurrent := lt_Universal;
    NbCurr := Actual.NbCurrent;
    MyModel := nil;
    if ( NbCurr >= 1 ) then
    begin
      for Indx := 0 to NbCurr - 1 do
      begin
        case Self.Category of
          st_her, st_hrm, st_h1m, st_h2m, st_h3m:
            if ( Actual.CurrTerm[ Indx ].Category = st_mod ) then
              MyModel := Actual.CurrTerm[ Indx ];
          st_hr1, st_h11, st_h21, st_h31:
            if ( Actual.CurrTerm[ Indx ].Category = st_md1 ) then
              MyModel := Actual.CurrTerm[ Indx ];
          st_hr2, st_h12, st_h22, st_h32:
            if ( Actual.CurrTerm[ Indx ].Category = st_md2 ) then
              MyModel := Actual.CurrTerm[ Indx ];
          st_hr3, st_h13, st_h23, st_h33:
            if ( Actual.CurrTerm[ Indx ].Category = st_md3 ) then
              MyModel := Actual.CurrTerm[ Indx ];
          st_hra, st_h1a, st_h2a, st_h3a:
            if ( Actual.CurrTerm[ Indx ].Category = st_mda ) then
              MyModel := Actual.CurrTerm[ Indx ];
        end; // case
      end; // for on all existing formulae
    end;

    // Search for an inheritance of optional expansion
    if ( MyModel <> nil ) then
    begin
      if ( MyModel.Exp <> 0 ) then
        Self.Exp := MyModel.Exp;

      // Search for inheritance of a mandatory expansion
      if ( ( MyModel.Obl > 0 ) and ( Self.Adjective <> MyModel.Obl ) ) then
        Self.Obl := MyModel.Obl;
      if ( ( MyModel.Adjective > 0 ) and ( Self.Obl = 0 ) ) then
        Self.Adjective := MyModel.Adjective;

      // Search for an inheritance of base part
      if ( Self.Mandat = cEmpty ) then
      begin
        MyTerm := tTerm.Create;
        MyTerm.Language := Lang;
        MyTerm.Formula := MyModel.Libelle;
        Self.LgTerm := MyTerm;
      end;
    end;
  end;

  // Retrieve the language term if absent
  if ( ( Self.LgTerm = nil ) and False ) then
  begin
    ATerm := Actual.GetStructuredTerm( lb_Official, Lang, st_bas );
  end;

  // 1. Presence of an adjective expansion
  // =====================================
  Self.IsBilMand := False;
  IsAdj := True;
  if ( Self.Adjective > 0 ) then
  begin

    // Compute the adjective expansion
    IsAdj := Self.SetAdjective;

    // Treatment of error
    if ( not IsAdj ) then
      Self.SetError( ErMissAdj );
  end;

  // 2. Presence of a mandatory expansion
  // ====================================
  IsMand := True;
  if ( Self.Obl > 0 ) then
  begin

    // Compute the adjective expansion
    IsMand := Self.SetMandat;

    // Treatment of error
    if ( not IsMand ) then
      Self.SetError( ErMissMand );
  end;

  // 3. Presence of an prepositional expansion
  // =========================================
  // (not yet implemented)

  // 4. Presence of an optional expansion
  // ====================================
  IsBilOpt := False;
  IsOpt := True;
  if ( Self.Exp > 0 ) then
  begin

    // Build the expansion at genitive
    IsOpt := Self.SetOption;

    // Treatment of error
    if ( not IsOpt ) then
      Self.SetError( 997 );
  end;

  // 5. Management of traditional terms
  // ==================================
  if ( ( Self.Category = st_RAT ) and
       ( Self.Obl = 0 ) and
       ( Lang = lt_latin ) ) then
  begin
    MyTID := Self.TID;
    for Indx := 0 to NbFixTrad - 1 do
    begin
      if ( FixTrad[ Indx ].TID = MyTID ) then
        Break;
    end;
  end else

  // 6. Treatment of base part for bilaterality
  // ==========================================
  // Define position and syntax for the lateral qualifier for each language
  IsBas := True;
  begin
    IsBil := False;
    if ( Actual <> nil ) then
      IsBil := Actual.Bilateral;
    IsBas := Self.SetBase( IsBil );

    // Treatment of error
    if ( not IsBas ) then
      Self.SetError( 996 );
  end;

  // Return variables
  Self.Performed := IsAdj and IsMand and IsBas and IsOpt;
  Self.Done := True;
  Self.Effective := Self.Category;
end; // ___________________________________________________________ExpansionTerm

function           tSingle.MakeBasLateral
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBasLateral
  * Make a base term for a lateral entity *
  Description:
  This method applies to a lateral entity. The method retrieves the
  base term of its generator and generate the corresponding single term.
  It returns true when successful.</P>
  In case of an irregular base term of the generator entity, the term of the
  lateral entity cannot be generated. For this reason the universal term of
  the generator entity is retrieved and used for generation of the lateral
  entity.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Len:             Integer;
  IsOption:        Boolean;
  IsMand:          Boolean;
  IsSet:           Boolean;
  NewOption:       String;
  NewMandat:       String;
  Actual:          tEntity;
  GenEntity:       tEntity;
  MyTerm:          tSingle;
  Term:            tTerm;
  MyBuild:         tBuild;
  Query:           tSearch;
  MyNumber:        tNumber;
begin

  // Retrieve the entity
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Retrieve the generator of this entity
    GenEntity := TAH.GetEntityByTID( Actual.Generator );
    if ( GenEntity <> nil ) then
    begin

      // Retrieve the base term of generator
      GenEntity.LgCurrent := Actual.LgCurrent;
      GenEntity.Query := tSearch.Create( st_Bas );
      GenEntity.Query.IsUniv := Self.IsUniversal;
      GenEntity.SearchTerm;
      MyTerm := GenEntity.CurrSingle;

      // Retrieve the universal term when the base term is irregular
      if ( ( MyTerm <> nil ) and ( MyTerm.Effective = st_irr ) ) then
      begin
        GenEntity.Query.IsUniv := True;
        GenEntity.Query.MyType := st_for;
        GenEntity.SearchTerm;
        MyTerm := GenEntity.CurrSingle;
      end;
      if ( MyTerm <> nil ) then
      begin

        // Apply laterality on a possible optional part
        IsOption := MyTerm.IsBilOpt;
        if ( IsOption ) then
        begin
          Term := tTerm.Create;
          Term.TermCopy( MyTerm.LgTerm );
          Term.Side := Actual.Link;
          Len := Length( Term.Nominative );
          NewOption := Term.MakeLateral( False );
          NewOption := Copy( NewOption, Len + 2, Length( NewOption ) );
        end;

        // Apply laterality on mandatory part
        MyNumber := nu_sin;
        if ( GenEntity.TetraTip in [ tp_setpset, tp_pset, tp_leftpset,
                                     tp_rightpset, tp_set ] ) then
          MyNumber := nu_plu;
        if ( Self.Language in [ lt_Latin, lt_English, lt_French ] ) then
        begin
          Term := tTerm.Create;
          Term.TermCopy( MyTerm.LgTerm );
        end else
          Term := tTerm.Create( MyTerm.Mandat, Self.Language, MyNumber );
        Term.Side := Actual.Link;
        if ( IsSet ) then
        begin
          NewMandat := Trim( Term.GenLatPlural );
          case Self.Language of
            lt_Latin:   NewMandat := cClassis + cSpace + NewMandat;
            lt_English: NewMandat := cSet + cSpace + NewMandat;
            lt_French:  NewMandat := cEnsemble + cSpace + NewMandat;
            lt_Spanish: NewMandat := cJunto + cSpace + NewMandat;
            lt_Russian: NewMandat := cClassisRU + cSpace + NewMandat;
          end;
        end else
        begin
          IsMand := Self.IsBilMand or IsOption;
          NewMandat := Trim( Term.MakeLateral( IsMand ) );
        end;

        // Create, feed and store the lateral entity
        MyBuild := MyTerm.BuildFrom;
        if ( MyBuild <> bd_model ) then
          MyBuild := tBuild( Min( Integer( bd_auto ), Integer( MyBuild ) ) );
        Self.TID := MyTerm.TID;
        Self.LID := MyTerm.LID;
        Self.IsModel := MyTerm.IsModel;
        Self.Category := st_bas;
        Self.Libelle := MyTerm.Libelle;
        Self.Intrinsic := MyTerm.Intrinsic;
        Self.BuildFrom := MyBuild;
        Self.Exp := MyTerm.Exp;
        Self.Done := True;
        if ( IsOption ) then
        begin
          Self.Mandat := MyTerm.Mandat;
          Self.Short := NewMandat;
          Self.Option := NewOption;
        end else
        begin
          Self.Mandat := Term.Nominative;
          Self.Short := cEmpty;
          Self.Option := cEmpty;
        end;
        Self.Effective := MyTerm.Effective;
        Self.LgTerm := tTerm.Create;
        for Indx := 0 to Term.NbWord - 1 do
          Self.LgTerm.Node[ Indx ] := Term.Node[ Indx ];
        Result := True;
      end;
    end;
  end;
end; // __________________________________________________________MakeBasLateral

function           tSingle.MakeBasPair
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBasPair
  * Make a formal base term for a pair *
  Description:
  This method applies to a pair. The method retrieves the
  base term of its generator and generate the corresponding formal single term.
  It returns true when successful.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NewMandat:       String;
  MyPlural:        String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  Term:            tTerm;
  Query:           tSearch;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Retrieve the base term of the generator
      Generator.Query := tSearch.Create( st_Bas );
      Generator.Query.IsUniv := Self.IsUniversal;
      Generator.LgCurrent := Self.Language;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;

      // Retrieve the universal term when the base term is irregular
      if ( ( ATerm <> nil ) and ( ATerm.Effective = st_irr ) ) then
      begin
        Generator.Query.IsUniv := True;
        Generator.Query.MyType := st_for;
        Generator.SearchTerm;
        ATerm := Generator.CurrSingle;
      end;

      // Apply pair
      if ( ATerm <> nil ) then
      begin

        // Analyze the term
        if ( Self.Language = lt_Latin ) then
        begin
          Term := tTerm.Create;
          Term.Language := lt_Latin;
          Term.TermCopy( ATerm.LgTerm );
        end else
        begin
          Term := tTerm.Create( ATerm.Mandat, Self.Language );
        end;
        if ( Term.IsRegular ) then
        begin
          case Self.Language of
            lt_Latin: NewMandat := cParLA + Term.GenPlural;
            lt_English: NewMandat := cParEN + cSpace + Term.Plural;
            lt_French:
              begin
                MyPlural := Term.Plural;
                NewMandat := cParFR + cSpace;
                if ( IsElisionFR( MyPlural ) ) then
                  NewMandat := cParEllisionFR;
                NewMandat := NewMandat + MyPlural;
              end;
            lt_Spanish: NewMandat := cParES + cSpace + Term.Plural;
            lt_Russian: NewMandat := cParRU + cSpace + Term.Plural;
          end; // case on all languages

          // Create, feed and store the new term
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.IsModel := ATerm.IsModel;
          Self.Category := ATerm.Category;
          Self.Libelle := ATerm.Libelle;
          Self.Mandat := NewMandat;
          Self.Option := ATerm.Option;
          Self.BuildFrom := ATerm.BuildFrom;
          Self.Done := True;
          Self.Effective := ATerm.Effective;
          Result := True;
        end;
      end;
    end;
  end;
end; // _____________________________________________________________MakeBasPair

function           tSingle.MakeBasPset
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBasPset
  * Make a base term for a pset *
  Description:
  This method applies exclusively to a specific pset. The method retrieves the
  base term of its generator and generate the corresponding single term, that
  is a formal term at nominative singular.
  It returns true when successful.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NewTerm:         String;
  Prefix:          String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  Term:            tTerm;
  Query:           tSearch;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Retrieve the base term of the generator
      Generator.Query := tSearch.Create( st_Bas );
      Generator.Query.IsUniv := Self.IsUniversal;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ATerm <> nil ) then
      begin
        NewTerm := Self.SetFormalPSet( ATerm );

        // Feed the new term
        Self.Intrinsic := ATerm.Intrinsic;
        Self.TID := ATerm.TID;
        Self.LID := ATerm.LID;
        Self.IsModel := ATerm.IsModel;
        Self.Category := ATerm.Category;
        Self.Libelle := ATerm.Libelle;
        Self.Mandat := NewTerm;
        Self.Option := ATerm.Option;
        Self.BuildFrom := ATerm.BuildFrom;
        Self.Done := True;
        Self.IsFix := ATerm.IsFix;
        Self.Effective := ATerm.Effective;
        Result := True;
      end;
    end;
  end;
end; // _____________________________________________________________MakeBasPset

function           tSingle.MakeBasSet
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBasSet
  * Make a base term for a set *
  Description:
  This method applies to a set. The method retrieves the
  base term of its generator and generates the corresponding single term.
  It returns true when successful.</P>
  A base term is an explicite representation of the type of the term, using the
  definers set and/or pair when necessary, always resulting in a global
  singular term.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Plus:            Integer;
  NewTerm:         String;
  MyArg:           String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  NewTypeS:        tLatType;
  Term:            tTerm;
  Query:           tSearch;
begin

  // Retrieve the generator of the set
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Retrieve the base term of the generator
      Generator.LgCurrent := Actual.LgCurrent;
      Generator.Query := tSearch.Create( st_Bas );
      Generator.Query.IsUniv := Self.IsUniversal;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ATerm <> nil ) then
      begin

        // Analyze the mandatory part of the base term
        Term := tTerm.Create( ATerm.Mandat, Self.Language );
        if ( Term.IsRegular ) then
        begin
          Term.Side := Generator.Link;
          NewTerm := Term.Nominative;

          // Latin specific stuff
          {if ( Self.Language = lt_Latin ) then
          begin
            NewTerm := cClassis + Term.GenPlural;
            if ( ( ATerm.TypeS <> lt_undef ) and
                 ( cLatString[ ATerm.TypeS, 2 ] = 'n' ) ) then
            begin
              MyArg := Term.Node[ 0 ].Cod[ 3 ] + 'gp';
              NewTypes := GetLateralValue( MyArg );
            end;
            Plus := 1;
          end else

          // English specific stuff
          if ( Self.Language = lt_English ) then
          begin
            NewTerm := cSet + cSpace + cOf + cSpace + Term.Plural;
            Plus := 2;
          end else

          // Spanish specific stuff
          if ( Self.Language = lt_Spanish ) then
          begin
            NewTerm := Term.Plural;
            NewTerm := cJunto + cSpace + cDes + cSpace + NewTerm;
            Plus := 2;
          end else

          // Russian specific stuff
          if ( Self.Language = lt_Russian ) then
          begin
            NewTerm := cClassisRU + cSpace + Term.GenPlural;
            if ( ( ATerm.TypeS <> lt_undef ) and
                 ( cLatString[ ATerm.TypeS, 2 ] = 'n' ) ) then
            begin
              MyArg := Term.Node[ 0 ].Cod[ 3 ] + 'gp';
              NewTypes := GetLateralValue( MyArg );
            end;
            Plus := 1;
          end else

          // French specific stuff
          if ( Self.Language = lt_French ) then
            NewTerm := Self.SetFormalSet( ATerm );}

          // Feed the new term
          Self.Intrinsic := ATerm.Intrinsic;
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.Category := ATerm.Category;
          Self.Libelle := ATerm.Libelle;
          Self.Mandat := NewTerm;
          Self.Option := ATerm.Option;
          Self.BuildFrom := ATerm.BuildFrom;
          Self.Done := True;
          Self.Effective := ATerm.Effective;
          Result := True;
        end;
      end;
    end;
  end;
end; // ______________________________________________________________MakeBasSet

function           tSingle.MakeOffLateral
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOffLateral
  * Make an official synonym for a lateral entity *
  Description:
  This method applies to a lateral entity. Its generator possibly has a number
  of official synonyms which can be propagated. The method retrieves an
  official synonym by the specified position and generate the corresponding
  single term. It returns true when successful.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NewTerm :        String;
  Term:            tTerm;
  Actual:          tEntity;
  TaxAncestor:     tEntity;
  MyTerm:          tSingle;
  Query:           tSearch;
  MyCateg:         tSynType;
begin

  // Retrieve taxonomic ancestor
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    TaxAncestor := TAH.GetEntityByTID( Actual.TaxAnc );
    if ( TaxAncestor <> nil ) then
    begin
      MyCateg := Self.Category;
      TaxAncestor.Query := tSearch.Create( MyCateg );
      TaxAncestor.Query.IsUniv := Self.IsUniversal;
      TaxAncestor.SearchTerm;
      MyTerm := TaxAncestor.CurrSingle;

      // Apply laterality
      if ( MyTerm <> nil ) then
      begin
        Term := tTerm.Create( MyTerm.Mandat, Self.Language );
        if ( Term.IsRegular ) then
        begin
          Term.Side := Actual.Link;
          NewTerm := Term.Lateral;
        end else
          NewTerm := 'ERR' + cSpace + MyTerm.Libelle;

        // Feed the single term
        Self.TID := MyTerm.TID;
        Self.LID := MyTerm.LID;
        Self.Category := MyTerm.Category;
        Self.Libelle := MyTerm.Libelle;
        Self.Mandat := NewTerm;
        Self.Option := MyTerm.Option;
        Self.BuildFrom := MyTerm.BuildFrom;
        Self.Done := True;
        Result := True;
      end;
    end;
  end;
end; // __________________________________________________________MakeOffLateral

function           tSingle.MakeOffPair
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOffPair
  * Make an official synonym for a pair *
  Description:
  This method applies to a paired entity. Its generator possibly has a number
  of official synonyms which can be propagated. The method retrieves an
  official synonym by the specified position and generate the corresponding
  single term. It returns true when successful.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NewMandat:       String;
  Bracket:         String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  Term:            tTerm;
  Query:           tSearch;
  MyCateg:         tSynType;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Retrieve an official synonym by position
      MyCateg := Self.Category;
      Generator.Query := tSearch.Create( MyCateg );
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ATerm <> nil ) then
      begin
        Term := TTerm.Create( Aterm.Mandat, Self.Language );
        Bracket := cSpace;
        if ( Self.Language = lt_Latin ) then
        begin
          NewMandat := ATerm.Mandat;
          Bracket := Bracket + cRoundPar;
        end else
        if ( Self.Language = lt_English ) then
        begin
          NewMandat := ATerm.Mandat;
          Bracket := Bracket + cRoundPair;
        end else
        if ( Self.Language = lt_French ) then
        begin
          NewMandat := ATerm.Mandat;
          Bracket := Bracket + cRoundPaire;
        end else
        if ( Self.Language = lt_Spanish ) then
        begin
          NewMandat := ATerm.Mandat;
          Bracket := Bracket + cRoundPar;
        end else
        if ( Self.Language = lt_Russian ) then
        begin
          NewMandat := ATerm.Mandat;
          Bracket := Bracket + cRoundPara;
        end;

        // Feed the single term
        Self.TID := ATerm.TID;
        Self.LID := ATerm.LID;
        Self.IsModel := ATerm.IsModel;
        Self.Category := ATerm.Category;
        Self.Libelle := ATerm.Libelle;
        Self.Mandat := NewMandat;
        Self.Option := ATerm.Option;
        Self.Bracket := Bracket;
        Self.BuildFrom := ATerm.BuildFrom;
        Self.Done := True;
        Result := True;
      end;
    end;
  end;
end; // _____________________________________________________________MakeOffPair

function           tSingle.MakeOffSet
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOffSet
  * Make an official synonym for a set *
  Description:
  This method applies to a set entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  Term:            tTerm;
  Query:           tSearch;
  MyCateg:         tSynType;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.FTID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Retrieve the base term of the generator
      MyCateg := Self.Category;
      Generator.Query := tSearch.Create( MyCateg );
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ATerm <> nil ) then
      begin

        // Analyze the term
        Term := tTerm.Create( ATerm.Mandat, Self.Language );
        if ( Term.IsRegular ) then
        begin

          // Feed the new term
          Self.Intrinsic := ATerm.Intrinsic;
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.IsModel := ATerm.IsModel;
          Self.Category := ATerm.Category;
          Self.Libelle := ATerm.Libelle;
          Self.Mandat := Term.Plural;
          Self.Option := ATerm.Option;
          Self.Done := True;
          Result := True;
        end;
      end;
    end;
  end;
end; // ______________________________________________________________MakeOffSet

function           tSingle.MakeOffPset
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOffPset
  * Make an official synonym for a pset *
  Description:
  This method applies to a pset entity. Its generator possibly has a number
  of official synonyms which can be propagated. The method retrieves an
  official synonym by the specified position and generate the corresponding
  single term. It returns true when successful.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyPos:           Integer;
  Redir:           String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  Term:            tTerm;
  Query:           tSearch;
  MyCateg:         tSynType;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.FTID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Retrieve the official synonym of the generator
      Generator.Query := tSearch.Create( Self.Category );
      Generator.Query.SynPos := 0;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ATerm <> nil ) then
      begin

        // Analyze the term
        Term := tTerm.Create( ATerm.Mandat, Self.Language );
        if ( Term.IsRegular ) then
        begin

          // Feed the new term
          Self.Intrinsic := ATerm.Intrinsic;
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.IsModel := ATerm.IsModel;
          Self.Category := ATerm.Category;
          Self.Libelle := ATerm.Libelle;
          Self.Mandat := Term.Plural;
          Self.Option := ATerm.Option;
          Self.Bracket := cSpace + cRoundPar;
          Self.Done := True;
          Result := True;
        end;
      end;
    end;
  end;
end; // _____________________________________________________________MakeOffPset

function           tSingle.MakeOfdPair
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOfdPair
  * Make a display official synonym for a pair *
  Description:
  This method applies to a paired entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Bracket:         String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  MyCateg:         tSynType;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( ( Actual <> nil ) and ( Actual.TetraTip = tp_pair ) ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Retrieve an official synonym by position
      MyCateg := Self.Category;
      Generator.Query := tSearch.Create( MyCateg );
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ATerm <> nil ) then
      begin
        if ( Self.Language = lt_Latin ) then
          Bracket := cSpace + cRoundPar
        else
        if ( Self.Language = lt_English ) then
          Bracket := cSpace + cRoundPair
        else
        if ( Self.Language = lt_French ) then
          Bracket := cSpace + cRoundPaire
        else
        if ( Self.Language = lt_Spanish ) then
          Bracket := cSpace + cRoundPar
        else
        if ( Self.Language = lt_Russian ) then
          Bracket := cSpace + cRoundPara;

        // Feed the single term
        Self.TID := ATerm.TID;
        Self.LID := ATerm.LID;
        Self.IsModel := ATerm.IsModel;
        Self.Category := ATerm.Category;
        Self.Libelle := ATerm.Libelle;
        Self.Mandat := ATerm.Mandat;
        Self.Option := ATerm.Option;
        Self.Bracket := Bracket;
        Self.BuildFrom := ATerm.BuildFrom;
        Self.Done := True;
        Result := True;
      end;
    end;
  end;
end; // _____________________________________________________________MakeOfdPair

function           tSingle.MakeOfdSingle
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOfdSingle
  * Make a display official synonym for a single entity *
  Description:
  This method applies to a single entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NewMandat:       String;
  Actual:          tEntity;
  ATerm:           tSingle;
  Term:            tTerm;
  Query:           tSearch;
  MyCateg:         tSynType;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Retrieve an official synonym by position
    MyCateg := Self.Category;
    Actual.Query := tSearch.Create( MyCateg );
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    if ( ATerm <> nil ) then
    begin
      Term := tTerm.Create( Aterm.Mandat, Self.Language );
      NewMandat := ATerm.Mandat;

      // Feed the single term
      Self.TID := ATerm.TID;
      Self.LID := ATerm.LID;
      Self.IsModel := ATerm.IsModel;
      Self.Libelle := ATerm.Libelle;
      Self.Mandat := NewMandat;
      Self.Option := ATerm.Option;
      Self.BuildFrom := bd_Auto;
      Self.Done := True;
      Result := True;
    end;
  end;
end; // ___________________________________________________________MakeOfdSingle

function           tSingle.MakeDisPair(
  AType:           tSynType )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeDisPair
  * Make a display term for a pair *
  Description:
  This method applies to a pair entity only and not to a pset entity. The
  method retrieves the base term and generates the corresponding display
  term. The argument specifies the position as main term or synonym.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  DisText:         String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  MyBuild:         tBuild;
  MyCateg:         tSynType;
  MySection:       tSection;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Define the new category of term
      MyCateg := st_undef;
      case AType of
        st_dis, st_dsm: MyCateg := st_bas;
        st_ds1: MyCateg := st_ofd;
        st_ds2: MyCateg := st_od2;
        st_ds3: MyCateg := st_od3;
      end; // case

      // Search for the generator entity
      Generator.LgCurrent := Actual.LgCurrent;
      Generator.Query := tSearch.Create( MyCateg );
      Generator.Query.IsUniv := Self.IsUniversal;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;

      // Build the display term
      if ( ATerm <> nil ) then
      begin
        DisText := TAH.GetLabel( rePair, False, Self.Language );
        DisText := cSpace + cRol + DisText + cRor;
        MyBuild := ATerm.BuildFrom;

        // Feed the new term
        Self.TID := ATerm.TID;
        Self.LID := ATerm.LID;
        Self.IsModel := ATerm.IsModel;
        Self.Category := AType;
        Self.Libelle := ATerm.Libelle;
        Self.Mandat := ATerm.Mandat;
        Self.Option := ATerm.Option;
        Self.Bracket := DisText;
        Self.BuildFrom := MyBuild;
        Self.Done := True;
        Self.Effective := ATerm.Effective;
        Self.Performed := ATerm.Performed;
        Result := True;
      end;
    end;
  end;
end; // _____________________________________________________________MakeDisPair

function           tSingle.MakeDisLateralSet
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeDisLateralSet
  * Make a display term for a lateral set entity *                *** unused ***
  Description:
  This method applies to a lateral entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsQ:             Boolean;
  IsS:             Boolean;
  MyOption:        String;
  MyShort:         String;
  MyMandat:        String;
  Actual:          tEntity;
  Generator:       tEntity;
  Ancestor:        tEntity;
  ATerm:           tSingle;
  Term:            tTerm;
begin

  // Retrieve the generator of the pair
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    Ancestor := TAH.GetEntityByTID( Actual.PartAnc );
    if ( Ancestor <> nil ) then
    begin
      Generator := TAH.GetEntityByTID( Ancestor.Generator );
      if ( Generator <> nil ) then
      begin

        // Retrieve official term of generator
        Generator.LgCurrent := Actual.LgCurrent;
        Generator.Query := tSearch.Create( st_Bas );
        Generator.Query.IsUniv := Self.IsUniversal;
        Generator.SearchTerm;
        ATerm := Generator.CurrSingle;
        if ( Aterm <> nil ) then
        begin

          // Apply laterality on expansion of qualification
          MyMandat := ATerm.Mandat;
          IsQ := True;
          if ( IsQ ) then
          begin
            Term := tTerm.Create( ATerm.Option, Self.Language );
            Term.Side := Actual.Link;
            MyOption := Term.Lateral;
          end;

          // Apply laterality on expansion of specification
          IsS := True;
          if ( IsS ) then
          begin
            Term := tTerm.Create( MyMandat, Self.Language );
            Term.Side := Actual.Link;
            MyShort := Term.Lateral;
          end;

          // Create, feed and store the new term
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.IsModel := ATerm.IsModel;
          Self.Category := st_Dis;
          Self.Libelle := ATerm.Libelle;
          if ( IsQ ) then
          begin
            Self.Mandat := MyMandat;
            Self.Option := MyOption;
            Self.Short := MyShort;
          end else
          begin
            Self.Mandat := MyShort;
            Self.Option := MyOption;
            Self.Short := cEmpty;
          end;
          Self.Bracket := cSpace + cRol + cClassis + cRor;
          Self.BuildFrom := bd_Auto;
          Self.Done := True;
          Result := True;
        end;
      end;
    end;
  end;
end; // _______________________________________________________MakeDisLateralSet

function           tSingle.MakeDisSet
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeDisSet
  * Make a display term for a set *                               *** unused ***
  Description:
  This method applies to a set entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Plus:            Integer;
  IsPSet:          Boolean;
  NewTerm:         String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
begin

  // Retrieve the generator entity
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin
      Generator.LgCurrent := Actual.LgCurrent;
      Generator.Query := TSearch.Create( st_Bas );
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( Aterm <> nil ) then
      begin

        // Prepare the bracket
        IsPSet := ( ( Actual.Link = pw_PairSetIn ) or
                    ( Actual.Link = pw_PairSubsetIn ) or
                    ( Actual.Link = pw_PairSetOf ) or
                    ( Actual.Link = pw_PairSubsetOf ) or
                    ( Actual.Link = pw_PairSetBranchOf ) or
                    ( Actual.Link = pw_PairSetPairBranchOf ) );
        if ( Self.Language = lt_Latin ) then
        begin
          if ( IsPSet ) then
          begin
            NewTerm := cSpace + cRol + 'par classium' + cRor;
            Plus := 2;
          end else
          begin
            NewTerm := cSpace + cRol + cClassis + cRor;
            Plus := 1;
          end;
        end;
        if ( Self.Language = lt_English ) then
        begin
          if ( IsPSet ) then
          begin
            NewTerm := cSpace + cRol + 'pair set' + cRor;
            Plus := 3;
          end else
          begin
            NewTerm := cSpace + cRol + cSet + cRor;
            Plus := 2;
          end;
        end;
        if ( Self.Language = lt_French ) then
        begin
          if ( IsPSet ) then
          begin
            NewTerm := cSpace + cRol + 'pair d''ensemble' + cRor;
            Plus := 4;
          end else
          begin
            NewTerm := cSpace + cRol + 'ensemble' + cRor;
            Plus := 2;
          end;
        end;

        // Create, feed and store the new term
        Self.TID := ATerm.TID;
        Self.LID := ATerm.LID;
        Self.IsModel := ATerm.IsModel;
        Self.Category := st_Dis;
        Self.Libelle := ATerm.Libelle;
        Self.Mandat := Aterm.Mandat;
        Self.Option := ATerm.Option;
        Self.Bracket := NewTerm;
        Self.BuildFrom := bd_Auto;
        Self.Done := True;
        Result := True;
      end;
    end;
  end;
end; // ______________________________________________________________MakeDisSet

function           tSingle.MakePluralGeneric
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralGeneric
  * Make a plural term for a generic set entity *
  Description:
  This method applies to three different set entities:
  - the generic set of a pset of tTip tp_setpset,
  - the specific set entity of a set of tTip tp_set,
  - the specific set entity of a mset of tTip tp_mset.</P>
  This method retrieves the generator term at singular and transforms a copy
  of it to plural, giving the new term. The making of the plural is performed
  via the language specific procedures.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Plus:            Integer;
  IsPSet:          Boolean;
  IsOpt:           Boolean;
  NewTerm:         String;
  NewValue:        String;
  MyTerm:          String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  Term:            tTerm;
  NewCateg:        tSynType;
begin

  // Define the term category to search for
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  NewCateg := st_undef;
  case Self.Category of
    st_plm: NewCateg := st_bas;
    st_pl1: NewCateg := st_ofd;
    st_pl2: NewCateg := st_od2;
    st_pl3: NewCateg := st_od3;
  end; // case

  // Retrieve the generator entity
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin
      Generator.LgCurrent := Actual.LgCurrent;
      Generator.Query := tSearch.Create( NewCateg );
      Generator.Query.IsUniv := Self.IsUniversal;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ( ATerm <> nil ) and ( ATerm.LgTerm <> nil ) ) then
      begin
        MyTerm := Trim( ATerm.Mandat );

        // Prepare the new term
        if ( Self.Language in [ lt_Latin, lt_French, lt_Russian ] ) then
        begin
          Term := tTerm.Create;
          Term.TermCopy( ATerm.LgTerm );
        end else
        if ( Self.Language in [ lt_English, lt_Spanish ] ) then
        begin // temporary
          Term := tTerm.Create( MyTerm, Self.Language );
        end;

        // Generate the plural calling language specific procedures
        if ( Term.IsRegular ) then
        begin
          Term.IsOption := ATerm.Exp > 0;
          NewValue := Term.Plural;

          // Feed and store the new term
          Self.Intrinsic := ATerm.Intrinsic;
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.IsModel := ATerm.IsModel;
          Self.Libelle := ATerm.Libelle;
          Self.Mandat := NewValue;
          Self.Option := ATerm.Option;
          Self.Bracket := NewTerm;
          Self.BuildFrom := ATerm.BuildFrom;
          Self.Done := True;
          Self.Effective := ATerm.Effective;
          Self.Performed := ATerm.Performed;
          Self.LgTerm := tTerm.Create;
          for Indx  := 0 to Term.NbWordGS - 1 do
            Self.LgTerm.Node[ Indx ] := Term.NodeGS[ Indx ];
          Self.LgTerm.IsRegular := Term.IsRegular;
          Self.Language := Term.Language;
          Result := True;
        end else

        // Error with syntax analysis
        begin
          if ( Self.Category = st_plm ) then
            Self.Mandat := Self.SetError( 940, ATerm );
        end;
      end else

      // Invalid base single, for main term only
      begin
        if ( Self.Category = st_plm ) then
          Self.Mandat := Self.SetError( 941, ATerm );
      end;
    end else

    // Error missing generator
    begin
      if ( Self.Category = st_plm ) then
        Self.Mandat := Self.SetError( 942, ATerm );
    end;
  end;
end; // _______________________________________________________MakePluralGeneric

function           tSingle.MakePluralSpecific
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralSpecific
  * Make a plural term for a specific set entity *
  Description:
  This method applies to a unique set entity:
  - the specific pset of tTip tp_pset.</P>
  This method retrieves the generic set term at plural and transforms a copy
  of it to a pair, giving the new term.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Plus:            Integer;
  IsPSet:          Boolean;
  MyBracket:       String;
  Value:           String;
  NewMandat:       String;
  Actual:          tEntity;
  Generator:       tEntity;
  MyUnit:          tUnit;
  ATerm:           tSingle;
  Term:            tTerm;
  MyCateg:         tSynType;
  IsRule:          Boolean;
  Ident:           Integer;
begin
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    MyUnit := TAH.GetUnitByPos( Actual.Tetra );
    Generator := TAH.GetEntityByTID( MyUnit.ASet );
    Generator.LgCurrent := Actual.LgCurrent;
    Generator.Query := tSearch.Create( Self.Category );
    Generator.SearchTerm;
    ATerm := Generator.CurrSingle;

    // Retrieve the universal term when the base term is irregular
    if ( ( ATerm <> nil ) and ( ATerm.Effective = st_irr ) ) then
    begin
      Generator.Query.IsUniv := True;
      Generator.Query.MyType := st_for;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
    end;
    if ( ( Aterm <> nil ) and ( ATerm.LgTerm <> nil ) ) then
    begin

      // Make the display term of the pset
      NewMandat := cEmpty;
      if ( Actual.LgCurrent in [ lt_Latin, lt_English, lt_French ] ) then
      begin
        Term := tTerm.Create;
        Term.TermCopy( ATerm.LgTerm );
        Term.Language := Self.Language;
      end else
        Term := tTerm.Create( ATerm.Mandat, Self.Language );

      // Create, feed and store the new term
      if ( Term.IsRegular ) then
      begin
        case Self.Language of
          lt_Latin: MyBracket := cSpace + cRoundPar;
          lt_English: MyBracket := cSpace + cRoundPair;
          lt_French: MyBracket := cSpace + cRoundPaire;
          lt_Spanish: MyBracket := cSpace + cRoundPar;
          lt_Russian: MyBracket := cSpace + cRoundPara;
        end;
        Self.Intrinsic := ATerm.Intrinsic;
        Self.TID := ATerm.TID;
        Self.LID := ATerm.LID;
        Self.IsModel := ATerm.IsModel;
        Self.Libelle := ATerm.Libelle;
        Self.Mandat := ATerm.Mandat;
        Self.Bracket := MyBracket;
        Self.BuildFrom := ATerm.BuildFrom;
        Self.Done := True;
        Self.Effective := ATerm.Effective;
        Self.LgTerm := ATerm.LgTerm;
        Self.Performed := ATerm.Performed;
        Result := True;
      end else

      // Error with irregular language term
      begin
        Self.Mandat := Self.SetError( 957, ATerm );
      end; // if ( Term.IsRegular )
    end else

    // Error with missing generator single
    begin
      Self.Mandat := Self.SetError( 956, ATerm );
    end; // if ( Aterm <> nil )
  end else

  // Error with missing entity
  begin
    Self.Mandat := Self.SetError( 955, ATerm );
  end; // if ( Actual <> nil)
end; // ______________________________________________________MakePluralSpecific

function           tSingle.MakePluralLateral
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralLateral
  * Make a plural term for a set lateral entity *
  Description:
  This method applies to two different set entities:
  - the specific left set entity of tTip tp_leftpset,
  - the specific right set entity of tTip tp_rightpset.</P>
  This method retrieves the generic set term at plural and transforms a copy
  of its lateral value, giving the new term. The making of the term is performed
  via the language specific procedures.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~} var
  Plus:            Integer;
  IsPSet:          Boolean;
  IsOption:        Boolean;
  NewTerm:         String;
  Value:           String;
  NewMandat:       String;
  NewShort:        String;
  NewOption:       String;
  Actual:          tEntity;
  Generator:       tEntity;
  MyUnit:          tUnit;
  ATerm:           tSingle;
  Term:            tTerm;
  MyCateg:         tSynType;
  IsRule:          Boolean;
  Ident:           Integer;
begin
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    MyUnit := TAH.GetUnitByPos( Actual.Tetra );
    Generator := TAH.GetEntityByTID( MyUnit.ASet );
    Generator.LgCurrent := Actual.LgCurrent;
    Generator.Query := tSearch.Create( Self.Category );
    Generator.SearchTerm;
    ATerm := Generator.CurrSingle;

    // Retrieve the universal term when the base term is irregular
    if ( ( ATerm <> nil ) and ( ATerm.Effective = st_irr ) ) then
    begin
      Generator.Query.IsUniv := True;
      Generator.Query.MyType := st_for;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
    end;
    if ( ( Aterm <> nil ) and ( ATerm.LgTerm <> nil ) ) then
    begin

      // Make the display term of the pset
      NewMandat := cEmpty;
      if ( Actual.LgCurrent in [ lt_Latin, lt_English, lt_French ] ) then
      begin
        Term := tTerm.Create;
        Term.TermCopy( ATerm.LgTerm );
        Term.Language := Self.Language;
      end else
        Term := tTerm.Create( ATerm.Mandat, Self.Language );
      if ( Term.IsRegular ) then
      begin
        Term.Side := Actual.Link;
        NewMandat := Trim( Term.MakeLateral );

        // Create, feed and store the new term
        if ( NewMandat <> cEmpty ) then
        begin
          Self.Intrinsic := ATerm.Intrinsic;
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.IsModel := ATerm.IsModel;
          Self.Libelle := ATerm.Libelle;
          if ( IsOption ) then
          begin
            Self.Mandat := NewMandat;
            Self.Option := NewOption;
            Self.Short := NewShort;
          end else
          begin
            Self.Mandat := NewMandat;
            Self.Option := NewOption;
            Self.Short := cEmpty;
          end;
          Self.Bracket := NewTerm;
          Self.BuildFrom := ATerm.BuildFrom;
          Self.Done := True;
          Self.Effective := ATerm.Effective;
          Self.LgTerm := Term;
          Self.Performed := ATerm.Performed;
          Result := True;
        end else

        // Error with laterality generation
        begin
          Self.Intrinsic := ATerm.Intrinsic;
          Self.TID := ATerm.TID;
          Self.Mandat := Self.SetError( 966, ATerm );
        end;
      end else

      // Error with syntax analysis
      begin
        Self.Mandat := Self.SetError( 967, ATerm );
      end;
    end else

    // Error with generator
    begin
      Self.Mandat := Self.SetError( 968, ATerm );
    end;
  end;
end; // _______________________________________________________MakePluralLateral

function           tSingle.MakeFMAPair
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFMAPair
  * Make a RAT term for a set *
  Description:
  This method applies to a pair entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
begin
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Retrieve a possible FMA term for the generator
      Generator.Query := tSearch.Create( st_FMA );
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ATerm <> nil ) then
      begin

        // Feed the new term
        Self.TID := Generator.TID;
        Self.LID := ATerm.LID;
        Self.IsModel := ATerm.IsModel;
        Self.Category := st_FMA;
        Self.Libelle := ATerm.Libelle;
        Self.Mandat := ATerm.Mandat;
        Self.Option := cEmpty;
        Self.Bracket := cEmpty;
        Self.BuildFrom := bd_Auto;
        Self.Done := True;
        Result := True;
      end;
    end;
  end;
end;  // ____________________________________________________________MakeFMAPair

function           tSingle.MakeBasGener
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBasGener
  * Make a generator entry *
  Description:
  This method applies to a generator entity. When a bas term is missing for
  a generator entity, it searches to build it from the universal formula.</P>
  This procedure works only under the following conditions:
  1. Missing bas term of a generator entity,
  2. Existence of universal formula for this entity.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  ATerm:           tSingle;
  MyCateg:         tSynType;
  NewCateg:        tSynType;
begin
  MyCateg := Self.Category;
  NewCateg := st_For;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Search for a stored term built from the universal formula
    Actual.LgCurrent := Self.Language;
    Actual.Query := tSearch.Create( NewCateg );
    Actual.Query.IsUniv := Self.IsUniversal;
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    if ( ATerm <> nil ) then
    begin
      Self.TID := ATerm.TID;
      Self.LID := ATerm.LID;
      Self.UID := ATerm.UID;
      Self.IsModel := ATerm.IsModel;
      Self.Category := st_Bas;
      Self.Libelle := ATerm.Libelle;
      Self.Mandat := ATerm.Mandat;
      Self.Option := ATerm.Option;
      Self.Bracket := ATerm.Bracket;
      Self.BuildFrom := bd_Auto;
      Self.Done := True;
      Self.Exp := ATerm.Exp;
      Self.Obl := ATerm.Obl;
      Self.BuildFrom := bd_model;
      Self.Effective := ATerm.Effective;
      Self.LgTerm := ATerm.LgTerm;
      Self.IsBilMand := ATerm.IsBilMand;
      Self.IsBilOpt := ATerm.IsBilOpt;
      Self.Short := ATerm.Short;
      Self.Performed := ATerm.Performed;
      Result := True;
    end else
    begin
      if ( ATerm <> nil ) then
        Self.ErrChain := IntToStr( erMissBasGen ) + cSemi + ATerm.ErrChain;
      Self.Performed := False;
      Result := False;
    end;
  end;
end; // ____________________________________________________________MakeBasGener

function           tSingle.MakeOffBas
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOffBas
  * Make the base term for an official synonym *
  Description:
  This method creates a call to a universal term for an official synonym.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  ATerm:           tSingle;
  MyCateg:         tSynType;
  NewCateg:        tSynType;
begin
  Result := False;
  MyCateg := Self.Category;
  if ( ( MyCateg = st_Off ) or ( MyCateg = st_Ofd ) ) then
    NewCateg := st_Fr1;
  if ( ( MyCateg = st_Of2 ) or ( MyCateg = st_Od2 ) ) then
    NewCateg := st_Fr2;
  if ( ( MyCateg = st_Of3 ) or ( MyCateg = st_Od3 ) ) then
    NewCateg := st_Fr3;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Search for a stored term built from the universal formula
    Actual.Query := tSearch.Create( NewCateg );
    Actual.Query.IsUniv := Self.IsUniversal;
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    if ( ATerm <> nil ) then
    begin
      Self.TID := ATerm.TID;
      Self.LID := ATerm.LID;
      Self.UID := ATerm.UID;
      Self.IsModel := ATerm.IsModel;
      Self.Category := NewCateg;
      Self.Libelle := ATerm.Libelle;
      Self.Mandat := ATerm.Mandat;
      Self.Option := ATerm.Option;
      Self.Bracket := ATerm.Bracket;
      Self.BuildFrom := bd_Auto;
      Self.Done := True;
      Self.Exp := ATerm.Exp;
      Self.Obl := ATerm.Obl;
      Self.BuildFrom := bd_model;
      Self.Effective := NewCateg;
      Self.LgTerm := ATerm.LgTerm;
      Result := True;
    end;
  end;
end; // ______________________________________________________________MakeOffBas

function           tSingle.SetMandat
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetMandat
  * Set the mandatory part of a term after expansion *
  Description:
  This procedure dispatches to the language specific procedures the task of
  preparing a mandatory expansion.</p>
  For each language, the language term is retrieved and its specific procedure
  is call with the TID of the entity onto which the expansion is performed.
  Then the current term is updated by addition of the expansion text.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on genitive words
  Past:            Integer;            // Number of words before expansion
  NbWord:          Integer;            // Number of words after expansion
  MyTID:           Integer;            // TID of mandatory expansion entity
  MyTerm:          tSingle;
  IsDone:          Boolean;            //
  Lang:            tLanguage;          // Applicable language
  MyUnit:          tUnit;
  EntityS:         tEntity;
begin

  // Get entity identifier from unit identifier
  if ( Self.Obl < 25000 ) then
  begin
    MyUnit := TAH.GetUnitByPos( Self.Obl );
    MyTID := Self.Obl;
    if ( ( MyUnit <> nil ) and
      ( MyUnit.TypUnit <> tt_undef ) and
      ( MyUnit.TypUnit <> tt_lex ) ) then
        MyTID := MyUnit.Generator;
  end else
    MyTID := Self.Obl;

  // Check the single for mandatory expansion
  EntityS := TAH.GetEntityByTID( MyTID );
  if ( EntityS <> nil ) then
  begin
    Lang := Self.Language;
    Self.IsBilMand := EntityS.IsBilateral;
    MyTerm := EntityS.GetStructuredTerm( lb_Official, Lang, st_bas );
    if ( MyTerm.LgTerm <> nil ) then
      MyTerm.LgTerm.IsGeneric := EntityS.IsGeneric;

    // Prepare the single term
    IsDone := Self.MakeMandat( MyTerm );
    if ( not IsDone ) then
      Self.SetError( ErMissMand );
  end;
  Result := IsDone;
end; // _______________________________________________________________SetMandat

function           tSingle.MakeMandat(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeMandat
  * Dispatch a mandatory expansion to the specific language *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx: Integer;
  MyTID:           Integer;
  IsPrefix:        Boolean;
  MyExpand:        String;             // Resulting expansion text
  NewTerm:         String;
  MyType:          char;
begin
  MyTID := MyTerm.TID;
  Result := True;
  case Self.Language of
    lt_Latin:   Result := tLatinTerm( Self.LgTerm ).MakeMandatLA( MyTerm );
    lt_English: Result := tENTerm( Self.LgTerm ).MakeMandatEN( MyTerm );
    lt_French:  Result := tFRTerm( Self.LgTerm ).MakeMandatFR( MyTerm );
    lt_Spanish: MyExpand := tESTerm( Self.LgTerm ).MakeMandatES( MyTID );
    lt_Russian: MyExpand := tRUTerm( Self.LgTerm ).MakeMandatRU( MyTID );
  end; // case on all languages
  IsPrefix := False;
  if ( Self.Language in [ lt_Spanish, lt_Russian ] ) then
    Self.Mandat := Self.LgTerm.Nominative + cSpace + MyExpand
  else
  if ( MyTerm.LgTerm <> nil ) then
  begin

    // Build the mandatory term
    {NewTerm := Self.Mandat;
    for Indx := 0 to MyTerm.LgTerm.NbWordGS - 1 do
    begin
      MyType := MyTerm.LgTerm.NodeGS[ Indx ].Cod[ 1 ];
      if ( ( MyType = 'h' ) or ( MyType = 's' ) ) then
        Continue;
      if ( not IsPrefix ) then
        NewTerm := NewTerm + cSpace;
      NewTerm := NewTerm + MyTerm.LgTerm.NodeGS[ Indx ].Lem;
      IsPrefix := MyType = 'p';
    end;}
    Self.Mandat := Self.LgTerm.Nominative;
  end else
    Self.SetError( 988 );
end; // ______________________________________________________________MakeMandat

function           tSingle.SetOption
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetOption
  * Set the option part of a term after expansion *
  Description:
  This procedure dispatches to the language specific procedures the task of
  preparing an optional expansion.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on genitive words
  Past:            Integer;            // Number of words before expansion
  NbWord:          Integer;            // Number of words after expansion
  MyTID:           Integer;            // TID of mandatory expansion entity
  IsDone:          Boolean;            //
  MyExpand:        String;             // Resulting expansion text
  Lang:            tLanguage;          // Applicable language
  NewCell:         WordAnal;
  EntityQ:         tEntity;
  MyUnit:          tUnit;
  MyTerm:          tSingle;
begin

    // Get entity identifier from unit identifier
    MyTID := Self.Exp;
    if ( Self.Exp < 25000 ) then
    begin
      MyUnit := TAH.GetUnitByPos( Self.Exp );
      if ( ( MyUnit <> nil ) and ( MyUnit.TypUnit <> tt_undef ) ) then
        MyTID := MyUnit.Generator;
    end;

    // Retrieve entity for optional expansion
    EntityQ := TAH.GetEntityByTID( MyTID );
    if ( ( EntityQ <> nil ) {and ( not IsUniv )} ) then
    begin
      Lang := Self.Language;
      Self.IsBilOpt := EntityQ.IsBilateral;
      EntityQ.LgCurrent := Lang;
      MyTerm := EntityQ.GetStructuredTerm( lb_Official, Lang, st_bas );
      Past := Self.LgTerm.NbWord;
      Result := Self.MakeOption( MyTerm );

      if ( Lang in [ lt_Latin, lt_English, lt_French ] ) then
      begin

        // Add the second placeholder for short expression
        NbWord := Self.LgTerm.NbWord;
        for Indx := NbWord - 1 downto Past do
        begin
          Self.LgTerm.Node[ Indx + 1 ] := Self.LgTerm.Node[ Indx ];
        end; // for on all genitive words
        NewCell.Lem := 'xter';
        NewCell.Cod := 'sx' + Copy( Self.LgTerm.Node[ Past - 1 ].Cod, 3, 3 );
        Self.LgTerm.Node[ Past ] := NewCell;
        NbWord := NbWord + 1;

        // Prepare the single term
        Self.Short := Self.Mandat;
      end;
    end;
end; //________________________________________________________________SetOption

function           tSingle.MakeOption(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOption
  * Dispatch to specific languages *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbWord:          Integer;
  IsDone:          Boolean;
  IsPrefix:        Boolean;
  MyExpand:        String;
  MyCode:          char;
begin
  case Self.Language of
    lt_Latin:   IsDone := tLatinTerm( Self.LgTerm ).MakeOptionLA( MyTerm );
    lt_English: IsDone := tENTerm( Self.LgTerm ).MakeOptionEN( MyTerm );
    lt_French:  IsDone := tFRTerm( Self.LgTerm ).MakeOptionFR( MyTerm );
    // lt_Spanish: Self.SetOptionSP( MyTerm );
    lt_Russian:  IsDone := tRUTerm( Self.LgTerm ).MakeOptionRU( MyTerm );
  end;

  // Build the text of expansion
  if ( IsDone ) then
  begin
    NbWord := MyTerm.LgTerm.NbWordGS;
    MyExpand := cEmpty;
    IsPrefix := False;
    for Indx := 0 to NbWord - 1 do
    begin
      if ( MyTerm.LgTerm.NodeGS[ Indx ].Cod = cEmpty ) then
        Continue;
      MyCode := MyTerm.LgTerm.NodeGS[ Indx ].Cod[ 1 ];
      if ( ( MyCode = 'h' ) or ( MyCode = 's' ) ) then
        Continue
      else
      if ( not IsPrefix ) then
        MyExpand := MyExpand + cSpace;
      MyExpand := MyExpand + MyTerm.LgTerm.NodeGS[ Indx ].Wrd;
      IsPrefix := MyCode = 'p';
    end;
    Self.Option := Trim( MyExpand );
  end;
  Result := IsDone;
end; //_______________________________________________________________MakeOption

procedure          tSingle.SetOptionSP(
  OptionTerm:      tSingle );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetOptionSP
  * Set the option part of a Spanish term after an expansion *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Genitive:        String;
  MyMandat:        tESTerm;
begin
  MyMandat := tESTerm.Create( OptionTerm.Mandat );
  Genitive := MyMandat.Genitive;
  if ( Copy( Genitive, 1, 6 ) = 'de par' ) then
    Genitive := Copy( Genitive, 9, Length( Genitive ) )
  else
  if ( Copy( Genitive, 1, 10 ) = 'de conjuto' ) then
    Genitive := Copy( Genitive, 8, Length( Genitive ) );
  Self.Option := cSpace + Genitive + OptionTerm.Option;
end; // _____________________________________________________________SetOptionSP

function           tSingle.SetBase(
  IsBil:           Boolean )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetBase
  * Set the laterality in the base of a term *
  Description:
  This procedure dispatches to language specific procedures in charge of
  adding a placeholder word to a bilateral term.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // index on words of the term
  PosWord:         Integer;            // position of lateral adjective
  IsDone:          Boolean;            //
  Lang:            tLanguage;          // language of the term
begin

  // Check for the need of a bilateral action
  Result := True;
  if ( ( not IsBil ) or ( Self.IsBilMand ) or ( Self.IsBilOpt ) ) then
    Exit;

  // Select the language
  IsDone := Self.MakeBase;
  if ( not IsDone ) then
    Self.SetError( 998 );
  Result := IsDone;
end; // _________________________________________________________________SetBase

function           tSingle.MakeBase
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBase
  * Dispatch laterality to specific languages *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  FixTID:          Integer;            // TID to be searched for fixed values
  IsDone:          Boolean;            // result from language procedure
begin
  case Self.Language of
    lt_Latin:
      begin
        FixTID := 0;
        if ( Self.Category = st_RAT ) then
          FixTID := Self.TID;
        IsDone := tLatinTerm( Self.LgTerm ).SetBaseLA( FixTID );
      end;
    lt_English: IsDone := tENTerm( Self.LgTerm ).SetBaseEN;
    lt_French:  IsDone := tFRTerm( Self.LgTerm ).SetBaseFR;
    lt_Spanish: Self.SetBaseSP;
    lt_Russian: IsDone := tRUTerm( Self.LgTerm ).MakeBaseRU;
  end;
  Result := IsDone;
end; // ________________________________________________________________MakeBase

procedure          tSingle.SetBaseSP;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetBaseSP
  * Set the base of a Spanish term after an expansion *
  Description:
  This method defines the values applicable to lateral adjectives for the
  Spanish language.</P>
  In Spanish, the lateral adjective comes in last position after the noun
  it qualifies. It is dependant on this noun in number.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyMandat:        tESTerm;
  MyOption:        tESTerm;
  MyGender:        tGender;
begin

  // Lateral adjective as last word
  MyMandat := tESTerm.Create( Self.Libelle );
  MyGender := MyMandat.GenderES;

  // Presence of a bilateral optional expansion
  if ( IsBilOpt ) then
  begin
    MyOption := tESTerm.Create( Self.Option );
    MyGender := MyOption.GenderES;
  end;
end; // _______________________________________________________________SetBaseSP

function           tSingle.SetFormalPSet(
  Term:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormalPSet
  * Build a formal pset specific term *
  Description:
  Dispatch to the specified language.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Lang:            tLanguage;
begin
  Lang := Term.Language;
  case Lang of
    lt_Latin: Result := SetFormalPSetLA( Term );
    lt_English: Result := SetFormalPSetEN( Term );
    lt_French: Result := SetFormalPSetFR( Term );
    lt_Spanish: Result := SetFormalPSetES( Term );
    lt_Russian: Result := SetFormalPSetRU( Term );
  end;
end; // ___________________________________________________________SetFormalPSet

function           tSingle.SetFormalSet(
  Term:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormalSet
  * Build a formal set specific term *
  Description:
  Dispatch to the specified language.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Lang:            tLanguage;
begin
  Lang := Term.Language;
  case Lang of
    // lt_Latin: Result := SetFormalSetLA( Term );
    // lt_English: Result := SetFormalSetEN( Term );
    lt_French: Result := SetFormalSetFR( Term );
    // lt_Spanish: Result := SetFormalSetES( Term );
    // lt_Russian: Result := SetFormalSetRU( Term );
  end;
end; // ___________________________________________________________SetFormalPSet

function           tSingle.SetAdjective()
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetAdjective
  * Insert an adjective (and a prefix) of expansion in a base term *
  Description:
  This function searches for an adjective and optionally a prefix to be added
  to a base term, whatever is the target language. It returns true when the
  adjective expansion is successful. In case of error, a specific error is
  generated.</p>
  The prefix (if present) is always appended in front of the adjective, making
  a single word. This word is positioned into the base term at a precise
  position dependant on the target language. The syntax analysis of the base
  term is adapted taking into account the added contribution.</p/
  StandardDoc/22.04.2021
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyAdj:           String;             // Found adjective
  MyPref:          String;             // Found prefix
  Lang:            tLanguage;          // Actual language
  LexEntity:       tEntity;            // Referenced entity
  VocUnit:         tUnit;              // Corresponding vocabulary unit
begin

  // Retrieve the adjective
  Lang := Self.Language;
  Result := False;
  VocUnit := TAH.GetUnitByPos( Self.Adjective );
  if ( ( VocUnit <> nil ) and ( VocUnit.Vocabulary > 0 ) ) then
  begin
    LexEntity := TAH.GetEntityByTID( VocUnit.Vocabulary );
    if ( LexEntity <> nil ) then
    begin
      MyAdj := LexEntity.GetVocabulary( Lang, st_Adj );

      // Error: missing specific adjective
      if ( MyAdj = cEmpty ) then
        Self.SetError( ErMissAdjSpec );

      // Search for a possible prefix
      MyPref := cEmpty;
      if ( MyAdj <> cEmpty ) then
      begin

        // Retrieve the prefix
        if ( Self.Prefix > 0 ) then
        begin
          VocUnit := TAH.GetUnitByPos( Self.Prefix );
          if ( ( VocUnit <> nil ) and ( VocUnit.Vocabulary > 0 ) ) then
          begin
            LexEntity := TAH.GetEntityByTID( VocUnit.Vocabulary );
            if ( LexEntity <> nil ) then
            begin
              MyPref := LexEntity.GetVocabulary( Lang, st_Pre );
            end else

              // Error: missing vocabulary entity for prefix
              Self.SetError( ErMissPreVoc );

            // Error: missing specific prefix
            if ( MyPref = cEmpty ) then
              Self.SetError( ErMissPreSpec );
          end else

            // Error: missing referenced unit for prefix
            Self.SetError( ErMissPreUnit );
        end;
      end;

      // Enter adjective (and prefix) in the term
      // ========================================
      if ( MyAdj <> cEmpty ) then
      begin
        Result := Self.MakeAdjective( MyAdj, MyPref );
        Self.Mandat := Self.LgTerm.Nominative;
      end;
    end else

      // Error: missing vocabulary entity for adjective
      Self.SetError( ErMissAdjVoc );
  end else

    // Error: missing referenced unit for adjective
    Self.SetError( ErMissAdjUnit );
end; // ____________________________________________________________SetAdjective

function           tSingle.MakeAdjective(
  MyAdj:           String;
  MyPref:          String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAdjective
  * Make an adjective in specific language *
  Description:
  This procedure being largely language dependant, it delegates its action
  to one of the adequate language-specific procedures written by each language
  coordinator, part of an add-on language package.</p>
  StandardDoc/22.04.2021
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Access to language-specific procedure
  Result := True;
  case Self.Language of
    lt_Latin:
      Result := tLatinTerm( Self.LgTerm ).MakeAdjectiveLA( MyAdj, MyPref );
    lt_English:
      Result := tENTerm( Self.LgTerm ).MakeAdjectiveEN( MyAdj, MyPref );
    lt_French:
      Result := tFRTerm( Self.LgTerm ).MakeAdjectiveFR( MyAdj, MyPref );
    lt_Spanish:
      SetAdjectiveES( MyAdj, MyPref, Self );
    lt_Russian:
      Result := tRUTerm( Self.LgTerm ).MakeAdjectiveRU( MyAdj, MyPref );
  end; // case on all universal languages

  // Error in language procedure
  if ( not Result ) then
    begin
      Self.ErrNo := ErAdjLang;
      Self.ErrChain := Self.ErrChain + cSemi + IntToStr( ErAdjLang );
    end;
end; // ___________________________________________________________MakeAdjective

function           tSingle.MakeFormulaSingle
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFormulaSingle
  * Make a term from the universal model for a single entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyBasic:         String;
  DisText:         String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  MyTerm:          tTerm;
  MyBuild:         tBuild;
  MyCateg:         tSynType;
  NewCateg:        tSynType;
begin
  Result := False;
  MyCateg := Self.Category;
  NewCateg := st_For;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Search for the formula term
    Actual.Query := tSearch.Create( NewCateg );
    Actual.Query.Direct := True; // necessary to prevent loop
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    if ( ATerm <> nil ) then
    begin
      Self.Category := NewCateg;
      Self.Mandat := ATerm.Mandat;
      Self.Option := ATerm.Option;
      Self.Exp := ATerm.Exp;
      Self.Obl := ATerm.Obl;
      Self.Option := ATerm.Option;
      Self.Done := True;
      Self.UID := ATerm.UID;
      Self.Effective := ATerm.Effective;
      Result := True;
    end;
  end;
end; // _______________________________________________________MakeFormulaSingle

function           tSingle.MakeFormulaPair
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFormulaPair
  * Make a term from the universal model for a pair *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyBasic:         String;
  DisText:         String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  MyTerm:          tTerm;
  MyBuild:         tBuild;
  MySynType:       tSynType;
begin
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Search for the generator entity
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Search for the generator entity
      MySynType := st_For;
      Generator.Query := tSearch.Create( MysynType );
      Generator.Query.Direct := True;
      Generator.LgCurrent := Self.Language;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;

      // Build the display term
      if ( ATerm <> nil ) then
      begin
        if ( Self.Language = lt_Latin ) then
        begin
          if ( ( Actual.TypeEntity = to_PstMat ) or
               ( Actual.TypeEntity = to_PstImm ) ) then
            DisText := 'par classium'
          else
            DisText := 'par';
        end else
        if ( Self.Language = lt_English ) then
        begin
          if ( ( Actual.TypeEntity = to_PstMat ) or
               ( Actual.TypeEntity = to_PstImm ) ) then
            DisText := 'pair of sets'
          else
            DisText := 'pair';
        end else
        if ( Self.Language = lt_French ) then
        begin
          if ( ( Actual.TypeEntity = to_PstMat ) or
               ( Actual.TypeEntity = to_PstImm ) ) then
            DisText := 'paire d''ensembles'
          else
            DisText := 'paire';
        end else
        if ( Self.Language = lt_Spanish ) then
        begin
          if ( ( Actual.TypeEntity = to_PstMat ) or
               ( Actual.TypeEntity = to_PstImm ) ) then
            DisText := 'paire d''ensembles'
          else
            DisText := 'par';
        end else
        if ( Self.Language = lt_Russian ) then
        begin
          if ( ( Actual.TypeEntity = to_PstMat ) or
               ( Actual.TypeEntity = to_PstImm ) ) then
            DisText := 'paire d''ensembles'
          else
            DisText := 'пара';
        end;
        DisText := cSpace + cRol + DisText + cRor;
        MyBuild := ATerm.BuildFrom;
        if ( MyBuild <> bd_model ) then
          MyBuild := bd_auto;

        // Feed the new term
        Self.TID := ATerm.TID;
        Self.LID := ATerm.LID;
        Self.IsModel := ATerm.IsModel;
        Self.Category := st_Dis;
        Self.Libelle := ATerm.Libelle;
        Self.Mandat := ATerm.Mandat;
        Self.Option := ATerm.Option;
        Self.Bracket := DisText;
        Self.BuildFrom := MyBuild;
        Self.Done := True;
        Self.Effective := ATerm.Effective;
        Self.LgTerm := ATerm.LgTerm;
        Result := True;
      end;
    end;
  end;
end; // _________________________________________________________MakeFormulaPair

function           tSingle.MakeFormulaGeneric()
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFormulaGeneric
  * Make a generic set term from a formula *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  IsPSet:          Boolean;
  MyBasic:         String;
  DisText:         String;
  NewTerm:         String;
  NewValue:        String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  MyTerm:          String;
  Term:            tTerm;
  MyBuild:         tBuild;
begin
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Search for the generator entity
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Search for the generator entity
      Generator.Query := tSearch.Create( st_for );
      Generator.Query.Direct := True;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;
      if ( ( ATerm <> nil ) and ( ATerm.LgTerm <> nil ) ) then
      begin
        if ( Self.Language in [ lt_Latin, lt_French, lt_Russian ] ) then
        begin
          Term := tTerm.Create;
          Term.TermCopy( ATerm.LgTerm );
        end else
        if ( Self.Language in [ lt_English, lt_Spanish ] ) then
        begin // temporary
          MyTerm := Trim( ATerm.Mandat );
          Term := tTerm.Create( MyTerm, Self.Language );
        end;

        // Generate the plural calling language specific procedures
        if ( Term.IsRegular ) then
        begin
          NewValue := Term.Plural;

      // Build the display term
        {NewTerm := cEmpty;
        if ( Self.Language = lt_Latin ) then
          NewTerm := cSpace + cRoundPar;
        if ( Self.Language = lt_English ) then
          NewTerm := cSpace + cRoundPair;
        if ( Self.Language = lt_French ) then
          NewTerm := cSpace + cRoundPaire;
        if ( Self.Language = lt_Spanish ) then
          NewTerm := cSpace + cRoundPar;
        if ( Self.Language = lt_Russian ) then
          NewTerm := cSpace + cRoundPara;

        // Define the plural form
        MyTerm := tTerm.Create( ATerm.Mandat, Self.Language );
        if ( MyTerm.IsRegular ) then
        begin
          NewValue := MyTerm.Plural;}

          // Create, feed and store the new term
          Self.Intrinsic := ATerm.Intrinsic;
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.IsModel := ATerm.IsModel;
          Self.Libelle := ATerm.Libelle;
          Self.Mandat := NewValue;
          Self.Option := ATerm.Option;
          Self.Bracket := NewTerm;
          Self.BuildFrom := ATerm.BuildFrom;
          Self.Done := True;
          Self.Effective := ATerm.Effective;
          Self.LgTerm := tTerm.Create;
          for Indx  := 0 to Term.NbWordGS - 1 do
            Self.LgTerm.Node[ Indx ] := Term.NodeGS[ Indx ];
          Self.LgTerm.IsRegular := Term.IsRegular;
          Result := True;
        end;
      end;
    end;
  end;
end; // ______________________________________________________MakeFormulaGeneric

function           tSingle.MakeFormulaSpecific
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFormulaSpecific
  * Make a term from the universal model for a pset *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsPSet:          Boolean;
  MyBasic:         String;
  DisText:         String;
  NewValue:        String;
  Actual:          tEntity;
  Generator:       tEntity;
  ATerm:           tSingle;
  MyTerm:          tTerm;
begin
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Search for the generator entity
    Generator := TAH.GetEntityByTID( Actual.Generator );
    if ( Generator <> nil ) then
    begin

      // Search for the generator entity
      Generator.LgCurrent := Actual.LgCurrent;
      Generator.Query := tSearch.Create( st_For );
      Generator.Query.Direct := True;
      Generator.Query.IsUniv := Self.IsUniversal;
      Generator.SearchTerm;
      ATerm := Generator.CurrSingle;

      // Build the display term
      if ( ATerm <> nil ) then
      begin

        // Define the plural form
        MyTerm := tTerm.Create( ATerm.Mandat, Self.Language );
        if ( MyTerm.IsRegular ) then
        begin
          NewValue := MyTerm.Plural;

          // Create, feed and store the new term
          Self.Intrinsic := ATerm.Intrinsic;
          Self.TID := ATerm.TID;
          Self.LID := ATerm.LID;
          Self.IsModel := ATerm.IsModel;
          Self.Libelle := ATerm.Libelle;
          Self.Mandat := NewValue;
          Self.Option := ATerm.Option;
          Self.BuildFrom := ATerm.BuildFrom;
          Self.Done := True;
          Self.Effective := ATerm.Effective;
          Result := True;
        end;
      end;
    end;
  end;
end; // _____________________________________________________MakeFormulaSpecific

function           tSingle.MakeFormulaLateral
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFormulaLateral
  * Make a term from the universal model for lateral entities *
  Description:
  This method is applicable for both pairs and psets. In each situation,
  the generic entity is retrieved and the used for the generation of the
  lateral form. The lateral form is at nominative singular for pairs and at
  nominative plural for psets.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsQ:             Boolean;
  IsSet:           Boolean;
  NewOption:       String;
  NewMandat:       String;
  Actual:          tEntity;
  GenEntity:       tEntity;
  MyTerm:          tSingle;
  MyBuild:         tBuild;
  Term:            tTerm;
  ValN:            tNumber;
begin
  Result := False;
  Actual := TAH.GetEntityByTID( Self.TID );
  if ( Actual <> nil ) then
  begin

    // Search for the generic entity
    GenEntity := TAH.GetEntityByTID( Actual.TaxAnc );
    IsSet := ( Actual.TypeEntity in [ to_SetMat, to_SetImm ] );
    ValN := nu_sin;
    if ( IsSet ) then
      ValN := nu_plu;
    // if ( IsSet ) then
    //   GenEntity := TAH.GetEntityByTID( GenEntity.Generator );
    if ( GenEntity <> nil ) then
    begin

      // Search for the formula term of the taxonomic ancestor
      GenEntity.LgCurrent := Self.Language;
      GenEntity.Query := tSearch.Create( st_For );
      GenEntity.SearchTerm;
      MyTerm := GenEntity.CurrSingle;
      if ( MyTerm <> nil ) then
      begin

        // Apply laterality on optional part
        IsQ := False;
        if ( IsQ ) then
        begin
          Term := tTerm.Create( Trim( MyTerm.Option ), Self.Language, ValN );
          Term.Side := Actual.Link;
          NewOption := cSpace + Term.Lateral;
        end else

        // Apply laterality on mandatory part
        begin
          Term := tTerm.Create( MyTerm.Mandat, Self.Language, ValN );
          Term.Side := Actual.Link;
          if ( IsSet ) then
            NewMandat := Term.LatPlural
          else
            NewMandat := Term.Lateral;
        end;

        // Create, feed and store the lateral term
        MyBuild := MyTerm.BuildFrom;
        if ( MyBuild <> bd_model ) then
          MyBuild := bd_auto;
        Self.TID := MyTerm.TID;
        Self.LID := MyTerm.LID;
        Self.IsModel := MyTerm.IsModel;
        Self.Category := MyTerm.Category;
        Self.Libelle := MyTerm.Libelle;
        Self.Intrinsic := MyTerm.Intrinsic;
        Self.BuildFrom := MyBuild;
        Self.Exp := MyTerm.Exp;
        Self.Done := True;
        Self.Mandat := MyTerm.Mandat;
        Self.Option := MyTerm.Option;
        Self.Short := cEmpty;
        if ( IsQ ) then
        begin
          Self.Option := NewOption;
          Self.Short := NewMandat;
        end else
          Self.Mandat := NewMandat;
        Self.Effective := MyTerm.Effective;
        Result := True;
      end;
    end;
  end;
end; // ______________________________________________________MakeFormulaLateral

function           tSingle.GetModelFormula()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetModelFormula
  * Extract the model of a formula for a universal term *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  IsNoun:          Boolean;
  MyModel:         String;
  MyFormula:       String;
  Next:            String;
begin

  // Extract prefix, adjective and formula
  MyModel := 'N';
  if ( Self.Prefix > 0 ) then
    MyModel := MyModel + 'O';
  if ( Self.Adjective > 0 ) then
    MyModel := MyModel + 'Q';
  Result := cEmpty;
  if ( MyModel = cEmpty ) then
    Exit;
  MyFormula := Self.Basic;

  // Loop on all members of the formula
  IsNoun := False;
  repeat

    // Extract the next member
    Posit := Pos( cComma, MyFormula );
    if ( Posit > 0 ) then
    begin
      Next := Copy( MyFormula, 1, 1 );
      MyFormula := Copy( MyFormula, Posit + 1, Length( MyFormula ) );
    end else
    begin
      Next := Copy( MyFormula, 1, 1 );
      MyFormula := cEmpty;
    end;

    // Add a contribution to the model
    if ( IsNoun ) then
      MyModel := MyModel + Next;
    if ( Next = 'N' ) then
      IsNoun := True;
  until ( MyFormula = cEmpty ); // repeat on all words of the formula

  Result := MyModel;
end; // _________________________________________________________GetModelFormula

function           tSingle.SetError(
  ErrNo:           Integer;
  Past:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetError
  * Create an error in a single term *
  Description:
  This procedure manages an error specified in argument. It generates an
  error message and update the chain of errors with the new error added to
  the already existing chain from the past single.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyError:         String;
begin
  Self.ErrNo := ErrNo;
  Self.ErrChain := IntToStr( ErrNo );
  if ( ( Past <> nil ) and ( Past.ErrChain <> cEmpty ) ) then
    Self.ErrChain := Self.ErrChain + cSemi + Past.ErrChain;
  MyError := TAH.GetLabel( ErrNo );
  Result := 'ERR' + IntToStr( ErrNo ) + cSpace + MyError;
end; // ________________________________________________________________SetError

end.
