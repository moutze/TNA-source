{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit ENProc
  * Formal management of the English language *
   ===========================================
  Description:
  This package handles all aspects of the English language in order to
  manipulate and generate English terms. This package is defined in conformity
  to the language specifications for the universal terminology. It is sufficient
  for the domain of anatomy when the RAT rules are applied. There is no need
  of a dictionary.</p>
  For testing purpose, rules, exceptions and check data are made available and
  are uniquely defined in the present package.</P>

  Specifications for anatomical English:
  - English has no gender for nouns and adjectives, to the syntax point of view.
  - Genitive is built with a preposition, without declension, similar to the
    nominative form.
  - Articles may be necessary for the genitive.
  - Prepositions are possible, without declension, as for the genitive form.
  - Adjectives are invariable in number and gender.
  - The order of words issued from the universal formula is based on the
    inverse of the Latin order.</p>
  The ground treatment of English terms is realized by basic procedures
  belonging to the class for English terms tENTerm. They are the following:
  - Create: makes an English term at nominative singular.
  - MakePluralEN: gives the nominative plural of a term.
  - MakeLateralEN: gives the lateral term at nominative singular.
  - MakeLatPluralEN: gives the lateral term at nominative plural.
  - MakeGenLatPluralEN: gives the lateral term at genitive plural.
  - MakeGenitiveEN: gives the genitive singular of a term.
  - MakeMandatEN: build a mandatory expansion as the genitive form of the entity
    defined for the mandatory expansion.
  - SetNominativeEN: makes an English term at nominative singular.
  - SetSyntaxEN: verify and adjust the syntax of a term.
  - SetFormulaEN: create the base part of a universal formula in English.
  Several procedures are needed for the realization of expansions of the
  English terms. They are independant procedures, external to the class of
  English terms. They are the followings:
  - SetBaseEN: build the base part of a term.
  - SetOptionEN: build an optional expansion as the genitive form of the entity
    defined for the oprional expansion.
  - SetAdjectiveEN: add a (prefixed) adjective to the base part of a
    term, resulting from an adjective expansion.
  - SetFormalPSetEN: build a formal pset term.</p>
  In addition, a number of independant utilities are provided. Test procedures
  have been developed. They are the followings:
  - TestNounPluralEN: for a given singular noun, it gives its plural.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit ENProc;

interface
uses
  TAHParam, Term, SingleTerms;

const
  NbNounRuPluralEN = 14;
  NbNounChPluralEN = 20;
  NbNounExPluralEN = 24;
  NbNoChExpEN      = 12;
  NbAdjChExpEN     = 9;
  NbMandChExpEN    = 6;
  NbOptChExpEN     = 3;
  NbLatChExpEN     = 7;

type
                   // Rules for plural of English nouns
  tNounRuPluralEN  = Array[ 1 .. NbNounRuPluralEN, nu_sin .. nu_plu ] of String;
                   // Tests for plural of English nouns
  tNounChPluralEN  = Array[ 1 .. NbNounChPluralEN, nu_sin .. nu_plu ] of String;
                   // Exceptions for plural of English nouns
  tNounExPluralEN  = Array[ 1 .. NbNounExPluralEN, nu_sin .. nu_plu ] of String;
                   // Tests for terms without expansion
  tNoChExpEN       = Array[ 1 .. NbNoChExpEN, nu_sin .. nu_plu ] of Integer;
                   // Tests for adjective expansions
  tAdjChExpEN      = Array[ 1 .. NbAdjChExpEN, nu_sin .. nu_plu ] of Integer;
                   // Tests for mandatory expansions
  tMandChExpEN     = Array[ 1 .. NbMandChExpEN, nu_sin .. nu_plu ] of Integer;
                   // Tests for optional expansions
  tOptChExpEN      = Array[ 1 .. NbOptChExpEN, nu_sin .. nu_plu ] of Integer;
                   // Tests for lateral expansions
  tLatChExpEN      = Array[ 1 .. NbLatChExpEN, nu_sin .. nu_plu ] of Integer;

                             // Define the English Term object
  tENTerm                    = class( tTerm )
    public
                             // Constructor of the class
      constructor            Create(
                               Nominative: String );
                             // Make the nominative plural of the term
      function               MakePluralEN(
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Make the lateral singular form of the term
      function               MakeLateralEN(
                               IsShort: Boolean )
                               : String;
                             // Make the lateral plural form of the term
      function               MakeLatPluralEN
                               : String;
                             // Make the genitive singular of the term
      function               MakeGenitiveEN
                               : String;
                             // Make the genitive lateral plural of the term
      function               MakeGenLatPluralEN
                               : String;
                             // Enter the nominative singular of the term
      procedure              SetNominativeEN(
                               Value: String );
                             // Compile the syntax of a term
      procedure              SetSyntaxEN;
                             // Enter the formula of the term
      procedure              SetFormulaEN;
                             // Find the plural of a word
      function               PluralOfEN(
                               AWord: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Make the mandatory expansion of a term
      function               MakeMandatEN(
                               MyTerm: tSingle )
                               : Boolean;
                             // Set the optional expansion of a term
      function               MakeOptionEN(
                               MyTerm: tSingle )
                               : Boolean;
                             // Make an adjective expansionto a term
      function               MakeAdjectiveEN(
                               Adj: String;
                               Pre: String )
                               : Boolean;
                             // Set the base term
      function               SetBaseEN
                               : Boolean;
  end; // type tENTerm
                             // Set a formal pset term
  function                   SetFormalPSetEN(
                               Term: tSingle )
                               : String;
                             // Test for plural of nouns
  function                   TestNounPluralEN(
                               ANoun: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;

const
                   // Rules for plural, including mixed Latin nouns
  cNounRuPluralEN: tNounRuPluralEN = (
                   ( 'ay', 'ays' ),    // pathway
                   ( 'ey', 'eys' ),    // kidney
                   ( 'y', 'ies' ),     // memory
                   ( 'f', 'ves' ),     // leaf
                   ( 'x', 'xes' ),     // complex, apex, calyx
                   ( 'a', 'ae' ),      // ala, fossa, lamina
                   ( 'ss', 'sses' ),
                   ( 'ch', 'ches' ),   // branch
                   ( 'sh', 'shes' ),   // eyelash
                   ( 'is', 'es' ),     // anastomosis, axis
                   ( 'us', 'i' ),      // nucleus, funiculus
                   ( 'um', 'a' ),      // ligamentum, cilium
                   ( 's', 's' ),       // biceps
                   ( '', 's' ) );      // normal ending

                   // Tests for plural, including mixed Latin nouns
  cNounChPluralEN: tNounChPluralEN = (
                   ( 'area', 'areas' ),
                   ( 'apex', 'apexes' ),
                   ( 'canal', 'canals' ),
                   ( 'cortex', 'cortices' ),
                   ( 'crus', 'crura' ),
                   ( 'foot', 'feet' ),
                   ( 'ganglion', 'ganglia' ),
                   ( 'glios', 'glia' ),
                   ( 'face', 'faces' ),
                   ( 'humerus', 'humeri' ),
                   ( 'leptomeninx', 'leptomeninges' ),
                   ( 'nucleus', 'nuclei' ),
                   ( 'paraganglion', 'paraganglia' ),
                   ( 'perikaryon', 'perikarya' ),
                   ( 'pes', 'pedes' ),
                   ( 'plexus', 'plexuses' ),
                   ( 'pubis', 'pubis' ),
                   ( 'roof', 'roofs' ),
                   ( 'sinus', 'sinuses' ),
                   ( 'tooth', 'teeth' ) );

                   // Plural exceptions
  cNounExPluralEN: tNounExPluralEN = (
                   ( 'area', 'areas' ),
                   ( 'canal', 'canals' ),
                   ( 'calyx', 'calices' ),
                   ( 'coccyx', 'coccyges' ),
                   ( 'cortex', 'cortices' ),
                   ( 'crus', 'crura' ),
                   ( 'foot', 'feet' ),
                   ( 'fornix', 'fornices' ),
                   ( 'fustis', 'fustis' ),
                   ( 'ganglion', 'ganglia' ),
                   ( 'glios', 'glia' ),
                   ( 'iris', 'iris' ),
                   ( 'leptomeninx', 'leptomeninges' ),
                   ( 'life', 'lives' ),
                   ( 'neocortex', 'neocortices' ),
                   ( 'paraganglion', 'paraganglia' ),
                   ( 'perikaryon', 'perikarya' ),
                   ( 'pes', 'pedes' ),
                   ( 'plexus', 'plexuses' ),
                   ( 'pubis', 'pubis' ),
                   ( 'roof', 'roofs' ),
                   ( 'sinus', 'sinuses' ),
                   ( 'tooth', 'teeth' ),
                   ( 'vertex', 'vertices' ) );

                   // Test of terms without expansion
  cNoChExpEN:      tNoChExpEN = (
                   ( 5264, 5264 ),     // telencephalon (generic)
                   ( 29947, 29947 ),   // eyelid (generic)
                   ( 7053, 7053 ),     // eyelids
                   ( 6005, 6005 ),     // angular gyrus
                   ( 5973, 5973 ),     // cerebral gyrus
                   ( 7816, 7816 ),     // infratentorial compartment
                   ( 7670, 7670 ),     // midget ganglion neuron
                   ( 7044, 7044 ),     // common tendinous ring
                   ( 8088, 8088 ),     // osseous external acoustic meatus
                   ( 28553, 28553 ),   // short association fibre
                   ( 6274, 6274 ),     // short association fibres
                   ( 0, 0 ) );

                   // Test of adjective expansion
  cAdjChExpEN:     tAdjChExpEN = (
                   ( 7985, 33461 ),    // cervical segments of spinal cord
                   ( 4155, 4155 ),     // ulnar artery
                   ( 5792, 5792 ),     // habenular commissure
                   ( 7986, 7986 ),     // cervical segment 1
                   ( 6985, 6985 ),     // superior temporal retinal arteriole
                   ( 8415, 8415 ),     // hypothalamospinal tract
                   ( 6281, 6281 ),     // horizontal occipital fasciculi
                   ( 11830, 11830 ),   // vertical temporoparietal fasciculus
                   ( 0, 0 ) );

                   // Test of mandatory expansion
  cMandChExpEN:    tMandChExpEN = (
                   ( 28957, 28957 ),   // nucleus of diagonal band (pair)
                   ( 5142, 5142 ),     // spinal part of filum terminale
                   ( 6085, 6085 ),     // radiation of corpus callosum
                   ( 12294, 12294 ),   // ascending medial fas of prosencephalon
                   ( 13172, 13172 ),   // commissural tract of hippocampus
                   ( 0, 0 ) );

                   // Test of optional expansion
  cOptChExpEN:     tOptChExpEN = (
                   ( 7985, 7985 ),     // cervical segments of spinal cord
                   ( 8658, 8658 ),     // superolateral surface of frontal lobe
                   ( 0, 0 ) );

                   // Test of lateral expansion
  cLatChExpEN:     tLatChExpEN = (
                   ( 38443, 38443 ),   // right temporal lobe
                   ( 28635, 28635 ),   // left radiation of corpus callosum
                   ( 32446, 32446 ),   // commissural tracts of left hippocampus
                   ( 38488, 38488 ),   // superolateral surface of left frontal
                                       // lobe + left superolateral surface
                   ( 28074, 28074 ),   // periventricular fibres of right
                                       // thalamus
                   ( 28935, 28935 ),   // cholinergic cells of vertical limb
                                       // of diagonal band
                   ( 0, 0 ) );
implementation

uses
  SysUtils, StrUtils, LAProc, Tetra, Entity, TAHBrowser;

constructor        tENTerm.Create(
  Nominative:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create
  * Variant of constructor of an English term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.Language := lt_English;
  inherited Create( Nominative );
end; // __________________________________________________________________Create

function           tENTerm.PluralOfEN(
  AWord:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ PluralOfEN
  * Find the plural of a word *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Lgt:             Integer;
  IsExcept:        Boolean;
  MyPlural:        String;
  Subst:           String;
  SingVal:         String;
begin

  // Define plural from the list of exceptions
  Subst := AWord;
  IsExcept := False;
  MyPlural := cEmpty;
  IsRule := False;
  Ident := 0;
  for Indx := 1 to NbNounExPluralEN do
  begin
    if ( Subst = cNounExPluralEN[ Indx, nu_sin ] ) then
    begin
      Subst := cNounExPluralEN[ Indx, nu_plu ];
      MyPlural := MyPlural + cSpace + Subst;
      IsExcept := True;
      Break;
    end;
  end; // for on all exceptions for plural

  // Loop on all plural rules if no exception matches
  if ( not IsExcept ) then
  begin
    MyPlural := MyPlural + cSpace + Subst;
    for Indx := 1 to NbNounRuPluralEN do
    begin
      SingVal := cNounRuPluralEN[ Indx, nu_sin ];
      Lgt := Length( SingVal );
      if ( Lgt > 0 ) then
      begin
        if ( Copy( Subst, Length( Subst ) - Lgt + 1, Lgt ) = SingVal ) then
        begin
          MyPlural := Copy( MyPlural, 1, Length( MyPlural ) - Lgt ) +
                    cNounRuPluralEN[ Indx, nu_plu ];
          IsRule := True;
          Ident := Indx;
          Break;
        end;
      end else
      begin
        MyPlural := MyPlural + cNounRuPluralEN[ Indx, nu_plu ];
        IsRule := True;
      end;
    end; // for on all rules for plural
  end;
  Result := Trim( MyPlural );
end; // ______________________________________________________________PluralOfEN

function           tENTerm.MakePluralEN(
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralEN
  * Construction of a plural English term *
  Description:
  This procedure handles an English singular term and transform it to the
  plural form. It takes care of possible noun complements or invariants in
  the term which are left unchanged. A single nominative noun is converted to
  the plural form, then inserted at its place.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  LgtFront:        Integer;
  LgtEnd:          Integer;
  LgtNom:          Integer;
  ATerm:           String;
  MyPlural:        String;
  MySingular:      String;
begin

  // Find the plural of the nominative noun
  MySingular := Self.Node[ Self.WordsNom - 1 ].Lem;
  MyPlural := PluralOfEN( MySingular, IsRule, Ident );

  // Insert the plural noun in place
  ATerm := Self.Nominative;
  LgtNom := Self.LengthNom;
  LgtFront := LgtNom - Length( MySingular ) - 1;
  LgtEnd := LgtNom + 1;
  if ( LgtFront > 0 ) then
    Result := Copy( ATerm, 1, LgtFront + 1 ) + MyPlural
  else
    Result := Trim( MyPlural );
  Result := Result + Copy( ATerm, LgtEnd, Length( ATerm ) );
end; // ____________________________________________________________MakePluralEN

function           tENTerm.MakeLateralEN(
  IsShort:         Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLateralEN
  * Construction of a lateral English term *
  Description:
  This method builds a lateral nominative term by addition of the adequate
  lateral adjective to the nominative term. Two situations are possible
  according to the IsShort parameter: standard placeholder and short
  placeholder.</p>
  At first, a place holder for the lateral adjective is searched. When found,
  the syntax of lateral adjective is computed and used to build the value of
  this lateral adjective to be inserted in the actual term.</p>
  At second, the term is scanned with two tasks:
  - reconstruction of the new term,
  - insertion of the lateral adjective in the placeholder.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;  // index on components of the term
  NbAnal:          Integer;  // number of components of the term
  Len:             Integer;  // length of nominative part
  IsPrefix:        Boolean;  // flag for presence of a prefix
  First:           Boolean;  // flag for first preposition after nominative part
  LatValue:        String;   // value for lateral adjective
  NewTerm:         String;   // reconstructed term with laterality
  Argument:        String;   // 3-letter syntax argument: gender, case, number
  Later:           tLink;    // side value
  MyCell:          WordAnal; // local transitory node
  CompType:        Char;     // type of component
begin

  // Define the laterality value
  LatValue := cEmpty;
  Later := Self.Side;
  if ( Later in [ pw_MemberR, pw_SMemberR, pw_IMemberR,  pw_TMemberR ] ) then
    LatValue := 'right'
  else
  if ( Later in [ pw_MemberL, pw_SMemberL, pw_IMemberL,  pw_TMemberL ] ) then
    LatValue := 'left';

  // Loop on all words
  NewTerm := cEmpty;
  IsPrefix := False;
  NbAnal := Self.NbWord;
  First := False;
  for Indx := 0 to NbAnal - 1 do
  begin
    CompType := Self.Node[ Indx ].Cod[ 1 ];

    // Check fength of nominative part
    if ( ( CompType = 'r' ) and ( not First ) ) then
    begin
      Len := Length( NewTerm ) + 1;
      First := True;
      if ( IsShort ) then
        Break;
    end;

    // Specific treatment of prefixes
    if ( ( CompType = 'm' ) or ( CompType = 'k' ) or ( CompType = 'p' )) then
    begin
      if ( not IsPrefix ) then
        NewTerm := NewTerm + cSpace;
      NewTerm := NewTerm + Self.Node[ Indx ].Lem;
      IsPrefix := True;
      Continue;
    end else

    // Append the laterality value in the placeholder
    if ( ( CompType = 'h' ) or
         ( ( CompType = 's' ) and ( IsShort ) ) ) then
    begin
      NewTerm := NewTerm + cSpace + LatValue;
      MyCell := Self.Node[ Indx ];
      MyCell.Cod[ 1 ] := 'a';
      MyCell.Lem := LatValue;
      Self.Node[ Indx ] := MyCell;
    end else

    // Append each word to the new term
    if ( ( CompType <> 'h' ) and ( CompType <> 's' ) ) then
    begin
      if ( not IsPrefix ) then
        NewTerm := NewTerm + cSpace
      else
        IsPrefix := False;
      NewTerm := NewTerm + Self.Node[ Indx ].Lem;
    end;
  end; // for on all words of the initial term
  if ( IsShort ) then
    Result := Trim( NewTerm )
  else
    Result := Copy( NewTerm, Len + 1, Length( NewTerm ) );
  Self.NewNom := Trim( NewTerm );
end; // ___________________________________________________________MakeLateralEN

function           tENTerm.MakeLatPluralEN
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLatPluralEN
  * Construction of a lateral plural English term *
  Description:
  This procedure handles an English term and transform it to the equivalent
  plural lateral form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;  // Index on all cells of the term
  GenPos:          Integer;  // position of first genitive word
  Ident:           Integer;  // number of applicable rule for plural
  IsRule:          Boolean;  // flag for plural by rule
  LatForm:         String;   // lateral adjective to be inserted
  NewTerm:         String;   // new generated term
  MyWord:          String;   // current word at singular
  MyPlural:        String;   // current word at plural
  WordType:        char;     // type of cell
  Later:           tLink;    // lateral side
  MyCell:          WordAnal; // local transitory node
begin

  // Find the adjective of laterality
  Later := Self.Side;
  LatForm := cEmpty;
  if ( ( Later = pw_MemberL ) or ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or ( Later = pw_TMemberL ) ) then
    LatForm := cLeft
  else
  if ( ( Later = pw_MemberR ) or ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or ( Later = pw_TMemberR ) ) then
  begin
    LatForm := cRight;
  end;
  if ( LatForm = cEmpty ) then
  begin
    Result := Self.Nominative;
    Exit;
  end;

  // Loop on all nominative words with plural for nominative nouns
  NewTerm := cEmpty;
  GenPos := Self.NbWord;
  for Indx := 0 to Self.NbWord - 1 do
  begin
    WordType := Self.Node[ Indx ].Cod[ 1 ];
    if ( WordType = 'n' ) then
    begin
      MyWord := Self.Node[ Indx ].Lem;
      MyPlural := PluralOfEN( MyWord, IsRule, Ident );
    end else
    if ( WordType = 'r' ) then
    begin
      MyWord := Self.Node[ Indx ].Lem;
      if ( ( MyWord = 'of' ) or ( MyWord = 'to' ) or ( MyWord = 'in' ) ) then
      begin
        GenPos := Indx;
        Break;
      end;
    end else
    begin
      MyPlural := Self.Node[ Indx ].Lem;;
    end;
    NewTerm := NewTerm + cSpace + MyPlural;
  end; // for on all nominative words
  NewTerm := Copy( NewTerm, 2, Length( NewTerm ) );

  // Loop on the genitive part of term
  for Indx := GenPos to Self.NbWord - 1 do
  begin
    WordType := Self.Node[ Indx ].Cod[ 1 ];
    MyWord := Self.Node[ Indx ].Lem;
    if ( WordType = 'h' ) then
    begin
      MyWord := LatForm;
      MyCell := Self.Node[ Indx ];
      MyCell.Cod[ 1 ] := 'a';
      MyCell.Lem := LatForm;
      Self.Node[ Indx ] := MyCell;
    end;
    NewTerm := NewTerm + cSpace + MyWord;
    if ( ( MyWord = 'of' ) or ( MyWord = 'to' ) or ( MyWord = 'in' ) ) then
      Self.SetCode( Indx, 'pxxgx' );
  end; // for on all non nominative words

  // Return the transformed term
  Result := NewTerm;
end; // _________________________________________________________MakeLatPluralEN

function           tENTerm.MakeGenLatPluralEN()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenLatPluralEN
  * Construction of a genitive lateral plural English term *
  Description:
  This procedure takes the nominative lateral plural term and transform it to
  the genitive lateral plural form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NewTerm:         String;
begin
  NewTerm := Self.MakeLatPluralEN;
  Result := 'of' + cSpace + NewTerm;
end; // ______________________________________________________MakeGenLatPluralEN


function           tENTerm.MakeGenitiveEN()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenitiveEN
  * Construction of a genitive English term *
  Description:
  This procedure handles a English singular term and transform it to the
  genitive singular form.</P>
  When a laterality is specified for the term, the genitive is built with the
  corresponding lateral adjective.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  MyCell:          WordAnal;
begin
  Result := 'of' + cSpace + Self.Nominative;

  // Adjust the syntax
  NbWord := Self.NbWord;
  NbWordGS := NbWord + 1;
  for Indx := 1 to NbWord do
  begin
    MyCell := Self.Node[ Indx - 1 ];
    MyCell.Cod := Copy( MyCell.Cod, 1, 3 ) + 'g' + MyCell.Cod[ 5 ];
    MyCell.Wrd := MyCell.Lem;
    Self.NodeGS[ Indx ] := MyCell;
  end;
  MyCell.Lem := 'of';
  MyCell.Wrd := 'of';
  MyCell.Cod := 'rxxxx';
  Self.NodeGS[ 0 ] := MyCell;
end; // __________________________________________________________MakeGenitiveEN

procedure          tENTerm.SetNominativeEN(
  Value:           String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNominativeEN
  * Action when entering a new value for Nominative property *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  NbWord:          Integer;
  MyTerm:          String;
  MyCell:          WordAnal;
begin
  // Store the words (blank separated)
  MyTerm := Trim( Self.Nominative );
  NbWord := 0;
  if ( Length( MyTerm ) = 0 ) then
    Exit;
  repeat
    Posit := Pos( cSpace, MyTerm );
    if ( Posit = 0 ) then
    begin
      MyCell.Lem := MyTerm;
    end else
    begin
      MyCell.Lem := Copy( MyTerm, 1, Posit - 1 );
      MyTerm := Copy( MyTerm, Posit + 1, Length( MyTerm ) );
    end;
    Self.Node[ NbWord ] := MyCell;
    Inc( NbWord );
  until ( Posit = 0 );
  Self.IsRegular := True;

  // Validate the syntax information
  Self.SetSyntaxEN;
end; // _________________________________________________________SetNominativeEN

procedure          tENTerm.SetSyntaxEN;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetSyntaxEN
  * Compile the syntax of a term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
                   // List of invariants in set or pset
  Invar            : Array[ 1 .. 36 ] of String
                   = ( 'A2', 'A3', 'A4', 'A5', 'A6',
                       'A7', 'A8', 'A9', 'A10', 'A11',
                       'A12', 'A13', 'A14', 'A15', 'A16',
                       'Ch1', 'Ch2', 'Ch3', 'Ch4', 'Ch7',
                       'B4', 'B5', 'B6', 'B7', 'B8',
                       'B1', 'B2', 'B3', 'A1', '6',
                       'C1-C2', 'A1-A2', 'HVIIA', '1', '2',
                       'Ib' );
var
  Indx:            Integer;

  Indy:            Integer;
  CellPos:         Integer;
  Posit:           Integer;
  Positof:         Integer;
  Positto:         Integer;
  PositInv:        Integer;
  Split:           Boolean;
  MyWord:          String;
  MyLem:           String;
  ATerm:           String;
  Front:           String;
  Subst:           String;
  Rest:            String;
  MyGender:        tGender;
  MyNode:          WordAnal;
begin

  // Search for the presence of an invariant
  ATerm := Self.Nominative;
  PositInv := 0;
  for Indy := 1 to Length( Invar ) do
  begin
    PositInv := Pos( cSpace + Invar[ Indy ], ATerm );
    if ( PositInv > 0 ) then
    begin
      Self.LengthNom := PositInv - 1;
      Break;
    end;
  end; // for on all invariants

  // Find the split position. Accept the prepositions of and to only.
  Positof := Pos( ' of ', ATerm );
  Positto := Pos( ' to ', ATerm );
  Split := ( Positof > 0 ) or ( Positto > 0 ) or ( PositInv > 0 );
  Posit := Positof;
  if ( Split ) then
  begin
    if ( ( Positto > 0 ) and ( Positof > 0 ) and ( Positto < Positof ) ) then
      Posit := Positto
    else
    if ( ( Positof = 0 ) and ( Positto > 0 ) ) then
      Posit := Positto;
    if ( PositInv > 0 ) and ( ( PositInv < Posit ) or ( Posit = 0 ) ) then
      Posit := PositInv;

    // Set the split
    Front := Copy( ATerm, 1, Posit - 1 );
    Rest := Copy( ATerm, Posit, Length( ATerm ) );
    Self.LengthNom := Posit - 1
  end else
  begin
    Front := ATerm;
    Rest := cEmpty;
    Self.LengthNom := Length( ATerm );
  end;

  // Find the last word of nominative part (supposed to be a noun)
  CellPos := 1;
  Subst := Front;
  repeat
    Posit := Pos( cSpace, Subst );
    Subst := Copy( Subst, Posit + 1, Length( Subst ) );
    Inc( CellPos );
  until ( Posit = 0 );
  Self.SetCode( CellPos - 2, 'nxxns' );
  if ( Self.NbWord > CellPos - 1 ) then
    Self.SetCode( CellPos - 1, 'rxxxs' );
  if ( Self.NbWord > CellPos ) then
    Self.SetCode( CellPos, 'nxxxs' );
  Self.WordsNom := CellPos - 1;

  // Update the adjective cells if any
  if ( CellPos - 2 > 0 ) then
  begin
    for Indx := 0 to CellPos - 3 do
    begin
      Self.SetCode( Indx, 'axxns' );
    end; // for on all adjectives before the head noun at nominative
  end;

  // Update the genitive words if any
  if ( ( Positto > 0 ) and ( Positof > 0 ) ) then
    CellPos := CellPos + 2;
  if ( PositInv > 0 ) then
  begin
    Self.SetCode( Self.NbWord - 1, 'ixxnx' )
  end else
  begin
    for Indx := CellPos - 1 to Self.NbWord - 1 do
    begin
      MyLem := Self.Node[ Indx ].Lem;
      if ( ( MyLem = 'of' ) or ( MyLem = 'to' ) ) then
        Self.SetCode( Indx, 'rxxgx' )
      else
        Self.SetCode( Indx, 'xxxgx' );
    end; // for on all non nominative words after the head noun
  end;
  Self.IsRegular := True;
end; // _____________________________________________________________SetSyntaxEN

procedure          tENTerm.SetFormulaEN;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormulaEN
  * Action when entering a new value of formula in English *
  Description:
  This methods aims at building a new nominative base part of an English term
  from a universal formula. In English, the order of words is partially
  inverted from the natural order of the model with adjectives preceeding the
  nouns. The exceptions are the following:
  - Adjective prefix: spinofastigial tract,
  - Adjective double prefix: sternocleidomastoid muscle,
  - Noun prefix: vestibulocerebellum,
  - Noun complement: neuron of projection, tract of origin.
  Both prefixes and noun complements are not inverted.</P>
  Formulas are limited to the base part of a term, not including any number
  of expansions, which are managed as references to other entities. A formal
  syntax of base parts has been defined as a subset of the general English
  rules of syntax. In particular the inverted genitive is not accepted due
  to the ambiguities it would generate!</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  MyPos:           Integer;
  PastPos:         Integer;
  Posit:           Integer;
  UID:             Integer;
  NbContrib:       Integer;
  Shift:           Integer;
  Nb:              Integer;
  Len:             Integer;
  DoPref:          Boolean;
  DoBiPref:        Boolean;
  IsPref1:         Boolean;
  IsPref2:         Boolean;
  IsCompl:         Boolean;
  IsInv:           Boolean;
  MyFormula:       String;
  MyContrib:       String;
  MyPart:          String;
  MyType:          String;
  MyCode:          String;
  MyWord:          String;
  LexUnit:         tUnit;
  LexEntity:       tEntity;
  Query:           tSearch;
  MySingle:        tSingle;
  ANode:           WordAnal;
  MyGender:        tGender;
begin

  // Retrieve a single contribution
  MyFormula := Self.Formula;
  if ( MyFormula = cEmpty ) then
    Exit;
  NbContrib := 0;
  IsPref1 := False;
  IsPref2 := False;
  IsCompl := False;
  IsInv := False;
  repeat
    Posit := Pos( ',', MyFormula );
    if ( Posit > 0 ) then
    begin
      MyContrib := Copy( MyFormula, 1, Posit - 1 );
      MyFormula := Copy( MyFormula, Posit + 1, Length( MyFormula ) );
    end else
    begin
      MyContrib := MyFormula;
      MyFormula := cEmpty;
    end;
    if ( not IsPref1 ) then
      IsPref1 := ( MyContrib[ 1 ] = 'P' )
    else
    if ( IsPref1 and ( not IsPref2 ) ) then
      IsPref2 := ( MyContrib[ 1 ] = 'P' );
    IsCompl := IsCompl or ( MyContrib[ 1 ] = 'C' );
    IsInv := IsInv or ( MyContrib[ 1 ] = 'I' );
    Inc( NbContrib );
  until ( Posit = 0 ); // on all contributions of a formula
  if ( IsPref2 ) then
    IsPref1 := False;

  // Loop on all contributions of the formula
  MyFormula := Self.Formula;
  MyPos := NbContrib - 1;
  DoPref := False;
  if ( ( IsCompl ) ) then
    Dec( MyPos );
  Self.NbWord := NbContrib;
  repeat

    // Retrieve a single contribution
    Posit := Pos( ',', MyFormula );
    if ( Posit > 0 ) then
    begin
      MyPart := Copy( MyFormula, 1, Posit - 1 );
      MyFormula := Copy( MyFormula, Posit + 1, Length( MyFormula ) );
    end else
    begin
      MyPart := MyFormula;
      MyFormula := cEmpty;
    end;

    // Retrieve the contributing lexical entity
    Posit := Pos( cRol, MyPart );
    UID := 0;
    if ( Posit > 0 ) then
    begin
      MyType := Copy( MyPart, 1, Posit - 1 );
      MyPart := Copy( Mypart, Posit + 1, Length( MyPart ) );
      Posit := Pos( cRor, MyPart );
      if ( Posit > 0 ) then
      begin
        MyPart := Copy( Mypart, 1, Posit - 1 );
        UID := StrToInt( MyPart );
      end;
    end;
    if ( UID > 0 ) then
    begin
      LexUnit := TAH.GetUnitByPos( UID );
      LexEntity := nil;
      if ( LexUnit <> nil ) then
        LexEntity := TAH.GetEntityByPos( LexUnit.Generator );
    end;

    // Retrieve the contribution and store them in pseudo inverted order.
    if ( LexEntity <> nil ) then
    begin

      // Noun contribution: must be unique at nominative
      if ( MyType = 'N' ) then
      begin
        MyWord := LexEntity.GetVocabulary( lt_English, st_Nou );
        Shift := 0;
        if ( DoBiPref ) then
          Shift := 2
        else
        if ( DoPref ) then
          Shift := 1;
        MyCode := 'nxxnx';
        DoPref := False;
      end else

      // Adjective contribution: multiple adjectives are allowed
      if ( MyType = 'A' ) then
      begin
        MyWord := LexEntity.GetVocabulary( lt_English, st_Adj );
        Shift := 0;
        if ( DoBiPref and DoPref) then
          Shift := 2
        else
        if ( DoPref ) then

          Shift := 1;
        MyCode := 'axxnx';
        DoPref := False;
      end else

      // Prefix contribution: possibly multiple occurences
      if ( MyType = 'P' ) then
      begin
        MyWord := LexEntity.GetVocabulary( lt_English, st_Pre );
        MyCode := 'pxxxx';
        if ( DoPref ) then
        begin
          DoBiPref := True;
          Shift := 0;
          Self.Node[ MyPos + Shift - 1 ] := Self.Node[ MyPos + Shift ];
        end else
        begin
          DoPref := True;
          Shift := -1;
        end;
      end else

      // Noun complement contribution: at genitive
      if ( MyType = 'C' ) then
      begin
        ANode.Lem := 'of';
        ANode.Cod := 'dxxgx';
        PastPos := MyPos;
        MyPos := NbContrib - 1;
        Self.Node[ MyPos ] := ANode;
        Inc( MyPos );
        MyWord := LexEntity.GetVocabulary( lt_English, st_Nou );
        Shift := 0;
        MyCode := 'nxxgx';
      end else

      // Invariant contribution: must be the last one
      if ( MyType = 'I' ) then
      begin
        MyWord := LexEntity.GetVocabulary( lt_English, st_Inv);
        MyCode := 'ixxxx';
        Shift := 0;
        MyPos := 0;
      end else

      // Retrieval of an apposition
      if ( MyType = 'M' ) then
      begin
        MyWord := LexEntity.GetVocabulary( lt_English, st_Nou );
        if ( MyWord = cEmpty ) then
        begin
          MyWord := LexEntity.GetVocabulary( lt_English, st_Adj );
          if ( MyWord = cEmpty ) then
          begin
            MyWord := LexEntity.GetVocabulary( lt_Latin, st_Pre );
            if ( MyWord = cEmpty ) then
            begin
              MyWord := LexEntity.GetVocabulary( lt_Latin, st_Inv );
              if ( MyWord = cEmpty ) then
                MyWord := 'ERR';
            end;
          end;
        end;
        Shift := 1;
        Self.Node[ MyPos + Shift - 1 ] := Self.Node[ MyPos + Shift ];
        MyCode := 'ixxxx';
      end;

      // Build the new contribution;
      if ( MyWord <> cEmpty ) then
      begin
        ANode := Self.Node[ MyPos + Shift ];
        ANode.Lem := MyWord;
        ANode.Cod := MyCode;
        Self.Node[ MyPos + Shift ] := ANode;
      end;
    end;

    // Move to next contribution
    if ( MyType = 'C' ) then
      MyPos := PastPos + 1;
    if ( MyType = 'I' ) then
      Break;
    Dec( MyPos );
  until ( MyFormula = cEmpty ); // on all contributions of a formula

  // Move an invariant to the last position
  ANode := Self.Node[ 0 ];
  if ( Length( ANode.Cod ) > 0 ) then
  begin
    if ( ANode.Cod[ 1 ] = 'i' ) then
    begin
      Nb := NbContrib;
      for Indx := 1 to Nb - 1 do
        Self.Node[ Indx - 1 ]:= Self.Node[ Indx ];
      Self.Node[ Nb - 1 ]:= ANode;
    end;
  end;
end; // ____________________________________________________________SetFormulaEN

function           tENTerm.MakeAdjectiveEN(
  Adj :            String;
  Pre:             String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAdjectiveEN
  * Insert an adjective of expansion in base term *
  Description:
  This procedure works on the base part of an entity and adds the adjective
  resulting from its adjective expansion. The new cell of the adjective is
  computed, then the new cell is inserted immediately before the noun. Finally
  the term is rebuilt as a single string.</p>
  The adjective may be accompanied by a prefix, to be added in front of the
  adjective.<P>
  About local variables:
  - Nounpos: position of the noun (last by default)
  - NbPlus: number of additional words after the noun
  - NbShift: 1 for adjective only, 2 for prefix and adjective.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbWord:          Integer;
  NounPos:         Integer;
  NbShift:         Integer;
  NbPlus:          Integer;
  MyWord:          String;
  MyTerm:          String;
  SyntaxNoun:      String;
  NewAdj:          WordAnal;
  NewPref:         WordAnal;
begin

  // Find the position of the noun
  // Normally a noun is in last position, except when an invariant is present
  NbWord := Self.NbWord;
  NounPos := NbWord - 1;
  for Indx := 0 to NbWord - 1 do
  begin
    if ( Self.Node[ Indx ].Cod[ 1 ] = 'n' ) then
    begin
      NounPos := Indx;
      Break;
    end;
  end; // for on all words
  NbPlus := NbWord - 1 - NounPos;

  // Compute the new cell for the adjective
  NewAdj.Wrd := Adj;
  NewAdj.Lem := Adj;
  SyntaxNoun := Copy( Self.Node[ NounPos ].Cod, 3, 3 );
  NewAdj.Cod := 'ax' + SyntaxNoun;

  // Compute the new cell for the prefix
  if ( Pre <> cEmpty ) then
  begin
    NewPref.Wrd := Pre;
    NewPref.Lem := Pre;
    NewPref.Cod := 'pxxxx';
  end;

  // Create the new nodes directly before the noun
  NbShift := 1;
  Inc( NounPos );
  Inc( NbWord );
  if ( Pre <> cEmpty ) then
  begin
    Inc( NbWord );
    Inc( NounPos );
    NbShift := 2;
  end;
  Self.NbWord := NbWord;
  for Indx := NbWord - 1 downto NbWord - 1 - NbPlus do
    Self.Node[ Indx ] := Self.Node[ Indx - NbShift ];

  // Move the new adjective (and prefix)
  if ( Pre <> cEmpty ) then
  begin
    Self.Node[ NounPos - 1 ] := NewAdj;
    Self.Node[ NounPos - 2 ] := NewPref;
  end else
    Self.Node[ NounPos - 1 ] := NewAdj;

  // Rebuild the term
  MyTerm := cEmpty;
  for Indx := 0 to NbWord - 1 do
  begin
    MyWord := Self.Node[ Indx ].Lem;
    if ( Self.Node[ Indx ].Cod[ 1 ] = 'p' ) then
      MyTerm := MyTerm + MyWord
    else
      MyTerm := MyTerm + MyWord + cSpace;
  end;
  Result := True;
  Self.NewNom := Trim( MyTerm );
end; // _________________________________________________________MakeAdjectiveEN

function           SetFormalPSetEN(
  Term:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormalPSetEN
  * Define the formal term for a pset *
  Description:
  The formal term for a specific pset is created, with its nominative part at
  singular because plurals are not accepted in the formal terms. The head part
  is followed by the genitive plural form of the generic term.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTerm:          tTerm;
  NewTerm:         String;
  Prefix:          String;
begin
  MyTerm := tTerm.Create( Term.Mandat, lt_English );
  NewTerm := MyTerm.Plural;
  Result := cEmpty;
  if ( MyTerm.IsRegular ) then
  begin
    Prefix := 'pair of set of';
    Result := Prefix + cSpace + NewTerm;
  end;
end; // _________________________________________________________SetFormalPSetEN

function           tENTerm.MakeMandatEN(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeMandatEN
  * Make the mandatory part of an English term *
  Description:
  This procedure defines the mandatory part specified by the TID argument.</p>
  The part to be added is retrieved as an English term at nominative that is
  expected to be regular. The genitive is computed and then returned. The
  syntax analysis of term is updated.</p>
  Care is also taken for defining the position of a lateral adjective, if any is
  possible.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  NbSingle:        Integer;            // Number of singles in generating entity
  MyExpand:        String;             // New expansion as string
  MandatEntity:    tEntity;            // Generating entity of expansion
  MyENTerm:        tENTerm;            // Applicable term
begin

  // Retrieve the single and build the genitive
  Result := False;
  Past := Self.NbWord;
  MyENTerm := tENTerm( MyTerm.LgTerm );
  if ( MyENTerm = nil ) then
  begin
    MyTerm.SetError( 999 );
    Exit;
  end;
  MyEXpand := Trim( MyENTerm.Genitive );

  // Adjust the syntax of owner English term
  NbWordGS := MyENTerm.NbWordGS;
  for Indx := 0 to NbWordGS - 1 do
  begin
    Self.Node[ Indx + Past ] := MyENTerm.NodeGS[ Indx ];
  end; // for on all genitive words
  Self.NewNom := Self.NewNom + cSpace + MyExpand;
  Result := True;
end; // ____________________________________________________________MakeMandatEN

function           tENTerm.SetBaseEN
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetBaseEN
  * Set the base part of an English term after an expansion *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index
  PosWord:         Integer;            // Position of bilateral placeholder
  Syntax:          String;             // Syntax for placeholder
  MyCell:          WordAnal;           // Placeholder cell
begin

  // Determine the syntax and position of the lateral placeholder
  // First position in English
  Posword := 0;
  Syntax := 'mns';
  for Indx := 0 to Self.NbWord - 1 do
  if ( Self.Node[ Indx ].Cod[ 1 ] = 'n' ) then
  begin
    Syntax := Self.Node[ NbWord - 1 ].Cod[ 3 ] + 'n' +
              Self.Node[ NbWord - 1 ].Cod[ 5 ];
    Break;
  end; // for

  // Add the bilateral place holder: xter stands for dexter or sinister
  MyCell.Lem := 'xter';
  MyCell.Cod := 'hx' + Syntax;
  for Indx := Self.NbWord downto 0 do
    if ( Indx > PosWord  ) then
      Self.Node[ Indx ] := Self.Node[ Indx - 1 ];
  Self.Node[ PosWord ] := MyCell;
  Result := True;
end; // _______________________________________________________________SetBaseEN

function           tENTerm.MakeOptionEN(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOptionEN
  * Make the optional part of an English term *
  Description:
  This procedure defines the optional part specified by the argument.</p>
  The part to be added is retrieved as an English term at nominative that is
  expected to be regular. The genitive is computed and then returned. The
  syntax analysis of term is updated.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  NbSingle:        Integer;            // Number of singles in generating entity
  MyExpand:        String;             // New expansion as string
  MandatEntity:    tEntity;            // Generating entity of expansion
  MyENTerm:        tENTerm;            // Applicable term
begin

  // Retrieve the single and build the genitive
  Past := Self.NbWord;
  MyENTerm := tENTerm( MyTerm.LgTerm );
  if ( MyENTerm = nil ) then
  begin
    MyTerm.SetError( 999 );
    Result := False;
    Exit;
  end;
  MyEXpand := Trim( MyENTerm.Genitive );

  // Adjust the syntax of owner English term
  NbWordGS := MyENTerm.NbWordGS;
  for Indx := 0 to NbWordGS - 1 do
  begin
    Self.Node[ Indx + Past ] := MyENTerm.NodeGS[ Indx ];
  end; // for on all genitive words
  Self.NewNom := Self.NewNom + cSpace + MyExpand;
  Result := True;
end; // ____________________________________________________________MakeOptionEN

function           TestNounPluralEN(
  ANoun:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestNounPluralEN
  * Test for plural of English nouns *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyNoun:          tENTerm;
  MyNumber:        tNumber;
begin
  MyNoun := tENTerm.Create( ANoun );
  Result := MyNoun.MakePluralEN( IsRule, Ident );
end; // ________________________________________________________TestNounPluralEN

end.
