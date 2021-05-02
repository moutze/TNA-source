{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit ESProc
  * Package for Spanish language management *
  Description:
  This package handles all aspects of the Spanish language in order to
  manipulate and generate Spanish terms. It is sufficient for the domain of
  anatomy when the RAT rules are applied. There is no need of a dictionary.</P>

  RAT rules for SPANISH:
  - Terms are made of words of the following types: noun, adjective or
    assimilated, prefix and invariant.
  - Cases are exclusively nominative and genitive. The only accepted
    preposition is de (del) for genitive.
  - A noun is necessarily unique and may be followed by any other type of
    word in any number. A prefix cannot be in last position. An invariant
    is expected as unique in the last position. A noun cannot be followed by
    another noun.
  - An adjective necessarily qualifies the noun that it follows.
  - Terms are made of blank separated words, except for prefixes followed by an
    adjective or another prefix.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit ESProc;

interface

uses
  TAHParam, Term, ComCtrls, SingleTerms;

const
  NbFrontES        = 12;
  NbWordRuPluralES = 12;
  NbNounExPluralES = 4;
  NbNounChPluralES = 1;
  NbBinomeES       = 4;
  NbNounRuGenderES = 7;
  NbNounExGenderES = 11;
  NbNounChGenderES = 1;
  NbAdjExGenderES  = 12;
  NbAdjRuGenderES  = 10;
  NbAdjChGenderES  = 16;
  NbAdjChExpES     = 9;
  NbMandChExpES    = 1;
  NbOptChExpES     = 1;

type
  tFrontES         = Array[ 1 .. NbFrontES ] of String;
                   // Rules for plural of nouns and adjectives
  tWordRuPluralES  = Array[ 1 .. NbWordRuPluralES, nu_sin .. nu_plu ] of String;
                   // Exceptions for plural of nouns
  tNounExPluralES  = Array[ 1 .. NbNounExPluralES, nu_sin .. nu_plu ] of String;
                   // Test values for plural of nouns
  tNounChPluralES  = Array[ 1 .. NbNounChPluralES, nu_sin .. nu_plu ] of String;
                   //
  tBinomeES        = Array[ 1 .. NbBinomeES, 1 .. 2 ] of String;
                   // Rules for feminine nouns
  tNounRuGenderES  = Array[ 1 .. NbNounRuGenderES,
                            va_word .. va_1 ] of String;
                   // Exceptions for feminine nouns
  tNounExGenderES  = Array[ 1 .. NbNounExGenderES,
                            va_word .. va_1 ] of String;
                   // Controlled tests for feminine nouns
  tNounChGenderES  = Array[ 1 .. NbNounChGenderES,
                            va_word .. va_1 ] of String;
                   // Exceptions for gender of adjectives
  tAdjExGenderES   = Array[ 1 .. NbAdjExGenderES,
                            ge_masculine .. ge_feminine ] of String;
                   // Rules for gender of adjectives
  tAdjRuGenderES   = Array[ 1 .. NbAdjRuGenderES,
                            ge_masculine .. ge_feminine ] of String;
                   // Test values for gender of adjective
  tAdjChGenderES   = Array[ 1 .. NbAdjChGenderES,
                            ge_masculine .. ge_feminine ] of String;
                   // Tests for adjective expansions
  tAdjChExpES      = Array[ 1 .. NbAdjChExpES, nu_sin .. nu_plu ] of Integer;
                   // Tests for mandatory expansions
  tMandChExpES     = Array[ 1 .. NbMandChExpES, nu_sin .. nu_plu ] of Integer;
                   // Tests for optional expansions
  tOptChExpES      = Array[ 1 .. NbOptChExpES, nu_sin .. nu_plu ] of Integer;

                             // Define the Spanish Term object
  tESTerm                    = class( tTerm )
    public
                             // Constructor of the class
      constructor            Create(
                               Nominative: String );
                             // Make the nominative plural of the term
      function               MakePluralES(
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Make the lateral form of the term
      function               MakeLateralES
                               : String;
                             // Make the lateral plural form of the term
      function               MakeLatPluralES
                               : String;
                             // Make the genitive singular of the term
      function               MakeGenitiveES
                               : String;
                             // Make the genitive lateral plural of the term
      function               MakeGenLatPluralES
                               : String;
                             // Enter the nominative singular of the term
      procedure              SetNominativeES(
                               Value: String );
                             // Compile the syntax of a term
      procedure              SetSyntaxES;
                             // Enter the formula of the term
      procedure              SetFormulaES;
                             // Find the gender of a word
      function               GenderES
                               : tGender;
                             // Make a feminine adjective from a masculine form
      function               MakeGenderES(
                             Syntax: tGender;
                             AWord: String;
                             var IsRule: Boolean;
                             var Ident: Integer )
                             : String;
                             // Make the mandatory expansion of a term
      function               MakeMandatES(
                               TID: Integer )
                               : String;
  end; // type tESTerm

                             // Create the front adjective flag
  function                   IsFrontES(
                               Text: String )
                               : Boolean;
                             // Add an adjective to a term
  procedure                  SetAdjectiveES(
                               Adj: String;
                               Pre: String;
                               var MySelf: tSingle );
                             // Set a formal pset term
  function                   SetFormalPSetES(
                               Term: tSingle )
                               : String;
                             // Test for plural of nouns
  function                   TestNounPluralES(
                               ANoun: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Test for gender of adjectives
  function                   TestAdjectiveGenderES(
                               AGender: tGender;
                               AnAdj: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
const
                   // Rules for plural: substitute left ending by the right one
                   // The order of rules is important
                   // Rules are valid for nouns and adjectives
  cWordRuPluralES: tWordRuPluralES = (
                   ( 'ión', 'iones' ),   // región, circunvolunción
                   ( 'or', 'ores' ),     // superior, posterior, motor
                   ( 'ar', 'ares' ),     // polar
                   ( 'al', 'ales' ),     // medial, vertical
                   ( 'il', 'iles' ),     // gracil
                   ( 'aíz', 'aíces' ),   // raiz
                   ( 'az', 'aces' ),     // haz
                   ( 'z', 'z' ),         // nariz, matriz
                   ( 's', 'ses' ),       // pubis, vermis, anastomosis, dermis
                   ( 't', 'tes' ),       // islot
                   ( 'x', 'x' ),         // antihélix, córtex, fórnix, vortex
                   ( '', 's' ) );        // default vomer

                   // Plural exceptions: applied before using the rules
  cNounExPluralES: tNounExPluralES = (
                   ( 'Ib', 'Ib' ),
                   ( 'alfa', 'alfa' ),
                   ( 'beta', 'beta' ),
                   ( 'gamma', 'gamma' ) );

                   // Test values for plural of nouns
  cNounChPluralES: tNounChPluralES = (
                   ( 'vomer', 'vomers' ) );

                   // Frontal adjectives: those positioned before the noun
  cFrontES:        tFrontES = (
                   'primero',
                   'segundo',
                   'tercero',
                   'cuarto',
                   'quinto',
                   'secto',
                   'séptimo',
                   'octavo',
                   'noveno',
                   'décimo',
                   'undécimo',
                   'duodécimo' );

                   // Exceptions for gender of wordss.
  cNounExGenderES: tNounExGenderES = (
                   ( 'foto', 'f' ),
                   ( 'hoz', 'f' ),
                   ( 'labor', 'f' ),
                   ( 'mano', 'f' ),
                   ( 'parte', 'f' ),
                   ( 'radio', 'f' ),
                   ( 'sor', 'f' ),
                   ( 'dia', 'm' ),
                   ( 'corazon', 'm' ),
                   ( 'seno', 'm' ),
                   ( 'sistema', 'm' ) );

                   // Gender rules for nouns
  cNounRuGenderES: tNounRuGenderES = (
                   ( 'o', 'm' ),            // cavité, entité, unité
                   ( 'a', 'f' ),
                   ( 'on', 'f' ),           // division
                   ( 'ale', 'm' ),          // encéphale
                   ( 'ule', 'm' ),          // ventricule, pédoncule
                   ( 'yte', 'm' ),          // astrocyte
                   ( 'e', 'f' ) );          // bulle, veine, cellule

                   // Test values for gender of nouns
  cNounChGenderES: tNounChGenderES = (
                   ( 'vomer', 'm' ) );

                   // Exceptions for gender of adjectives
  cAdjExGenderES:  tAdjExGenderES = (
                   ( 'azygos', 'azygos' ),
                   ( 'ambiens', 'ambiens' ),
                   ( 'común', 'común' ),
                   ( 'grácil', 'grácil' ),
                   ( 'gris', 'gris' ),
                   ( 'hamate', 'hamate' ),
                   ( 'haploide', 'haploide' ),
                   ( 'trapezoide', 'trapezoide' ),
                   ( 'marrón', 'marrón' ),
                   ( 'oriens', 'oriens' ),
                   ( 'proyectable', 'proyectable' ),
                   ( 'reuniens', 'reuniens' ) );

                   // Rules for gender of adjectives
  cAdjRuGenderES:  tAdjRuGenderES = (
                   ( 'o', 'a' ),       // blanco
                   ( 'al', 'al' ),     // abdominal, arterial
                   ( 'an', 'an' ),     // iridian
                   ( 'ante', 'ante' ), // disecante, gigante
                   ( 'ar', 'ar' ),     // ampular, ciliar, cóclear
                   ( 'ente', 'ente' ), // abducente
                   ( 'er', 'er' ),     // bacillifer
                   ( 'oides', 'oides' ), // cricoides, escafoides
                   ( 'or', 'or' ),     // anterior, excretor, flexor, inferior
                   ( 'orme', 'orme' ) ); // ansiforme, fusiforme

                   // Controlled test for gender of adjectives
  cAdjChGenderES:  tAdjChGenderES = (
                   ( 'abdominal', 'abdominal' ),      // abdominal
                   ( 'abducente', 'abducente' ),      // abducente
                   ( 'ampular', 'ampular' ),          // ampulary
                   ( 'anterior', 'anterior' ),        // anterior
                   ( 'blanco', 'blanca' ),            // white
                   ( 'común', 'común' ),              // common
                   ( 'cricoides', 'cricoides' ),      // cricoide
                   ( 'escafoides', 'escafoides' ),    // scaphoide
                   ( 'fusiforme', 'fusiforme' ),      // fusiforme
                   ( 'grácil', 'grácil' ),            // gracile
                   ( 'gris', 'gris' ),                // gray
                   ( 'hamate', 'hamate' ),            // hamate
                   ( 'marrón', 'marrón' ),            //
                   ( 'rojo', 'roja' ),                // red
                   ( 'oriens', 'oriens' ),            //
                   ( 'proyectable', 'proyectable' ) );//

                   // Test of adjective expansion
                   // First TID: st_mod; second TID: st_val
  cAdjChExpES:     tAdjChExpES = (
                   ( 33461, 7985 ),    // segmentos cervicales de la m. espinal
                   ( 7986, 7986 ),     // segmento cervical 1
                   ( 6985, 6985 ),     // arteriola retiniana temporal superior
                   ( 8415, 8415 ),     // haz hipotálamoespinal
                   ( 5792, 5792 ),     // comisura habénular
                   ( 4155, 4155 ),     // arteria ulnar
                   ( 6281, 6281 ),     // fascículos occipitales transversos
                   ( 11830, 11830 ),   // fascículo temporoparietal vertical
                   ( 10691, 10691 ) ); // cuarta vértebra cervical

                   // Test of mandatory expansion
  cMandChExpES:    tMandChExpES = (
                   ( 7985, 7985 ) );
                   // Test of optional expansion
  cOptChExpES:     tOptChExpES = (
                   ( 7985, 7985 ) );

                   // Binomes Latin-Spanish
  LASPEquiv:       tBinomeES = (
                   ( 'cornu', 'corne' ),
                   ( 'lamina', 'lame' ),
                   ( 'posterior', 'postérieur' ),
                   ( 'spinalis', 'spinal' ) );

implementation

uses
  SysUtils, Entity, TAHBrowser, LAProc, Tetra;

constructor        tESTerm.Create(
  Nominative:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create
  * Variant of constructor of a Spanish term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited Create( Nominative, lt_Spanish );
end; // __________________________________________________________________Create

function           tESTerm.MakePluralES(
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralES
  * Construction of a plural Spanish term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  Indx:            Integer;
  Lgt:             Integer;
  IsGen:           Boolean;
  IsExcept:        Boolean;
  Word:            String;
  Plural:          String;
  SingVal:         String;
  ATerm:           String;
begin

  // Loop on all words of the term
  ATerm := Self.Lateral;
  Plural := cEmpty;
  IsGen := False;
  while ( ATerm <> cEmpty ) do
  begin

    // Search for the next word (blank separated)
    Posit := Pos( cSpace, ATerm );
    if ( Posit > 0 ) then
    begin
      Word := Copy( ATerm, 1, Posit - 1 );
      ATerm := Copy( ATerm, Posit + 1, Length( ATerm ) );
    end else
    begin
      Word := ATerm;
      ATerm := cEmpty;
    end;

    // Check for the end of nominative part of the term
    if ( not IsGen ) then
    begin
      IsGen := ( Word = 'de' ) or ( Word = 'del' ) or ( Word = 'en' );
    end;

    // Append words at genitive, left unchanged
    if ( IsGen ) then
    begin
      Plural := Plural + cSpace + Word
    end else
    begin

      // Define plural from exceptions
      IsExcept := False;
      for Indx := 1 to NbNounExPluralES do
      begin
        if ( Word = cNounExPluralES[ Indx, nu_sin ] )  then
        begin
          Word := cNounExPluralES[ Indx, nu_plu ];
          Plural := Plural + cSpace + Word;
          IsExcept := True;
          Break;
        end;
      end; // for
      if ( IsExcept ) then
        Continue;

      // Loop on all Spanish plural rules if no exception matches
      Plural := Plural + cSpace + Word;
      IsRule := False;
      Ident := 0;
      for Indx := 1 to NbWordRuPluralES do
      begin
        SingVal := cWordRuPluralES[ Indx, nu_sin ];
        Lgt := Length( SingVal );
        if ( Lgt > 0 ) then
        begin
          if ( Copy( Word, Length( Word ) - Lgt + 1, Lgt ) = SingVal ) then
          begin
            Plural := Copy( Plural, 1, Length( Plural ) - Lgt ) +
                      cWordRuPluralES[ Indx, nu_plu ];
            IsRule := True;
            Ident := Indx;
            Break;
          end;
        end else
        if ( Lgt = 0 ) then
        begin
          Plural := Plural + cWordRuPluralES[ Indx, nu_plu ];
          Ident := Indx;
        end;
      end; // for
    end;
  end; // while

  // Return plural term
  Result := Copy( Plural, 2, Length( Plural ) );
end; // ____________________________________________________________MakePluralES

function           tESTerm.GenderES
  :                TGender;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GenderES
  * Search for gender of a noun in Spanish *
  Description:
  This procedure receives a string, from which the first word is extracted and
  analyzed for its gender. The return value is either masculine or feminine.</P>
  Lists of exceptions are first considered. If no match is obtained, rules
  are examined and they define the gender.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Posit:           Integer;
  CellPos:         Integer;
  Noun:            String;
  Last:            String;
  Last2:           String;
  Last3:           String;
  Last4:           String;
  MyNode:          WordAnal;
begin
  // Look for the first noun of the term
  CellPos := 0;
  MyNode := Self.Node[ 0 ];
  Noun := MyNode.Lem;
  if ( ( MyNode.Cod <> cEmpty ) and
       ( ( MyNode.Cod[ 1 ] = 'p' ) or ( MyNode.Cod[ 1 ] = 'a' ) ) ) then
  begin
    MyNode := Self.Node[ 1 ];
    Noun := MyNode.Lem;
  end;

  // Set to masculine by list of exceptions
  Result := ge_unspec;
  for Indx := 1 to NbNounExGenderES do
  begin
    if ( ( Noun = cNounExGenderES[ Indx, va_word ] ) and
         ( cNounExGenderES[ Indx, va_1 ] = 'm' ) ) then
    begin
      Result := ge_masculine;
      Break;
    end;
  end; // for

  // Set to feminine by list of exception
  if ( Result = ge_unspec ) then
  begin
    for Indx := 1 to NbNounExGenderES do
    begin
      if ( ( Noun = cNounExGenderES[ Indx, va_word ] ) and
           ( cNounExGenderES[ Indx, va_1 ] = 'f' ) ) then
      begin
        Result := ge_feminine;
        Break;
      end;
    end; // for
  end;

  // Set to masculine by rules
  if ( Result = ge_unspec ) then
  begin
    Last := Copy( Noun, Length( Noun ), 1 );
    Last2 := Copy( Noun, Length( Noun ) - 1, 2 );
    Last3 := Copy( Noun, Length( Noun ) - 2, 3 );
    Last4 := Copy( Noun, Length( Noun ) - 3, 4 );

    // Set to masculine by rules (not necessary because masculine is the default)
    {if ( ( Last = 'e' ) or
         ( Last = 'o' ) or
         ( Last2 = 'án' ) or
         ( Last2 = 'és' ) or
         ( Last2 = 'ón' ) or
         ( Last2 = 'or' ) or
         ( Last3 = 'aje' ) ) then
    begin
      Result := ge_masculine;
      Exit;
    end else}

    // Set to feminine by rules
    Result := ge_masculine;
    if ( ( Last = 'a' ) or
         ( Last2 = 'ez' ) or
         ( Last2 = 'al' ) or
         ( Last3 = 'zón' ) or
         ( Last3 = 'dad' ) or
         ( Last3 = 'tad' ) or
         ( Last3 = 'tud' ) or
         ( Last3 = 'sis' ) or
         ( Last4 = 'ción' ) or
         ( Last4 = 'sión' ) or
         ( Last4 = 'gión' ) or
         ( Last4 = 'triz' ) ) then
    begin
      Result := ge_feminine;
    end;
  end;

  // Default value
  if ( Result = ge_unspec ) then
    Result := ge_masculine;
end; // ________________________________________________________________GenderES

function           tESTerm.MakeGenitiveES()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenitiveES
  * Construction of a genitive singular Spanish term *
  Description:
  This procedure handles a Spanish nominative singular term and transform it
  to the genitive singular form.</P>
  The genitive is different according to genericity in Spanish. The genitive
  is without definite article for generic term and with definite article for
  specific terms. The selection is done from the given parameter.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  IsElud:          Boolean;
  IsGen:           Boolean;
  Gender:          tGender;
  DeForm:          String;
  ATerm:           String;
  MyCell:          WordAnal;
begin
  // Search for the gender
  ATerm := Self.Nominative;
  Gender := Self.GenderES;
  IsGen := Self.IsGeneric;

  // Set the genitive form
  if ( Gender = ge_masculine ) then
  begin
    if ( IsGen ) then
      DeForm := 'de' + cSpace
    else
      DeForm := 'del' + cSpace;
  end else
  if ( Gender = ge_feminine ) then
  begin
    if ( IsGen ) then
    begin
      DeForm := 'de' + cSpace;
    end else
    begin
      DeForm := 'de la' + cSpace;
    end;
  end;
  Result := DeForm + ATerm;

  // Adjust the syntax
  NbWord := Self.NbWord;
  NbWordGS := NbWord + 2;
  for Indx := 0 to NbWord - 1 do
  begin
    MyCell := Self.Node[ Indx ];
    MyCell.Cod := Copy( MyCell.Cod, 1, 3 ) + 'g' + MyCell.Cod[ 5 ];
    Self.NodeGS[ Indx + 2 ] := MyCell;
  end;
  MyCell.Lem := 'de';
  MyCell.Cod := 'rxxxx';
  Self.NodeGS[ 0 ] := MyCell;
  if ( Gender = ge_masculine ) then
  begin
    MyCell.Lem := 'el';
    MyCell.Cod := 'dxmxs';
  end else
  begin
    MyCell.Lem := 'la';
    MyCell.Cod := 'dxfxs';
  end;
  Self.NodeGS[ 1 ] := MyCell;
end; // __________________________________________________________MakeGenitiveES

function           tESTerm.MakeLateralES()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLateralES
  * Construction of a lateral Spanish term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  LatForm:         String;
  NewTerm:         String;
  ATerm:           String;
  Gender:          TGender;
  Later:           TLink;
  MyTermES:        TESTerm;
begin

  // Find the adjective of laterality
  ATerm := Self.Nominative;
  Later := Self.Side;
  LatForm := cEmpty;
  MyTermES := tESTerm.Create( ATerm );
  Gender := MyTermES.GenderES;
  if ( ( Later = pw_MemberL ) or ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or ( Later = pw_TMemberL ) ) then
  begin
    if ( Gender = ge_masculine ) then
      LatForm := 'izquierdo'
    else
      LatForm := 'izquierda';
  end else
  if ( ( Later = pw_MemberR ) or ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or ( Later = pw_TMemberR ) ) then
  begin
    if ( Gender = ge_masculine ) then
      LatForm := 'derecho'
    else
      LatForm := 'derecha';
  end;
  if ( LatForm = cEmpty ) then
  begin
    Result := ATerm;
    Exit;
  end;

  // Last word by default in Spanish
  if ( Self.WordType = lt_undef ) then
  begin
    Self.WordPos := Self.NbWord;
  end;

  // Position the lateral modifier
  if ( Self.WordPos < Self.NbWord ) then
  begin
    NewTerm := cEmpty;
    for Indx := 0 to Self.NbWord - 1 do
    begin
      if ( Indx = Self.WordPos ) then
        NewTerm := NewTerm + cSpace + LatForm;
      NewTerm := NewTerm + cSpace + Self.Node[ Indx ].Lem;
    end; // for
    NewTerm := Copy( NewTerm, 2, Length( NewTerm ) );
  end else
    NewTerm := ATerm + cSpace + LatForm;
  Result := NewTerm;
end; // ___________________________________________________________MakeLateralES

function           tESTerm.MakeLatPluralES
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLatPluralES
  * Construction of a nominative lateral plural Spanish term *
  Description:
  This procedure handles a Spanish singular term and transform it to the
  equivalent nominative lateral plural form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Lgt:             Integer;
  IsExcept:        Boolean;
  LatForm:         String;
  NewTerm:         String;
  ATerm:           String;
  MyNumber:        String;
  SingVal:         String;
  MyWord:          String;
  MyPlural:        String;
  MyCode:          String;
  Gender:          tGender;
  Later:           tLink;
begin

  // Generate the adjective of laterality
  ATerm := Self.Nominative;
  Later := Self.Side;
  LatForm := cEmpty;
  Gender := Self.GenderES;
  if ( ( Later = pw_MemberL ) or ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or ( Later = pw_TMemberL ) ) then
  begin
    if ( Gender = ge_masculine ) then
      LatForm := 'izquierdos'
    else
      LatForm := 'izquierdas';
  end else
  if ( ( Later = pw_MemberR ) or ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or ( Later = pw_TMemberR ) ) then
  begin
    if ( Gender = ge_masculine ) then
      LatForm := 'derechos'
    else
      LatForm := 'derechas';
  end;
  if ( LatForm = cEmpty ) then
  begin
    Result := ATerm;
    Exit;
  end;

  // Loop on all words of the term
  NewTerm := cEmpty;
  for Indy := 0 to Self.NbWord - 1 do
  begin
    MyWord := Self.Node[ Indy ].Lem;
    MyPlural := MyWord;
    MyCode := Self.Node[ Indy ].Cod;
    if ( ( Length( MyCode ) >= 4 ) and
         ( MyCode[ 4 ] = 'n' ) ) then
    begin

      // Make the plural of the word at nominative
      // Define plural from exceptions
      IsExcept := False;
      MyPlural := cEmpty;
      for Indx := 1 to NbNounExPluralES do
      begin
        if ( MyWord = cNounExPluralES[ Indx, nu_sin ] )  then
        begin
          MyWord := cNounExPluralES[ Indx, nu_plu ];
          MyPlural := MyPlural + cSpace + MyWord;
          IsExcept := True;
          Break;
        end;
      end; // for on all exceptions for plural
      if ( IsExcept ) then
        Break;

      // Loop on all Spanish plural rules if no exception matches
      MyPlural := MyPlural + cSpace + MyWord;
      for Indx := 1 to NbWordRuPluralES do
      begin
        SingVal := cWordRuPluralES[ Indx, nu_sin ];
        Lgt := Length( SingVal );
        if ( Lgt > 0 ) then
        begin
          if ( Copy( MyWord, Length( MyWord ) - Lgt + 1, Lgt ) = SingVal ) then
          begin
            MyPlural := Copy( MyPlural, 1, Length( MyPlural ) - Lgt ) +
                      cWordRuPluralES[ Indx, nu_plu ];
            Break;
          end;
        end else
        begin
          MyPlural := MyPlural + cWordRuPluralES[ Indx, nu_plu ];
        end;
      end; // for on all rules for plural
    end;

    // Build the new term
    NewTerm := NewTerm + cSpace + MyPlural;
    if ( Indy = Self.WordPos - 1 ) then
      NewTerm := NewTerm + cSpace + LatForm;
  end; // for on all words of the term
  NewTerm := Copy( NewTerm, 2, Length( NewTerm ) );
  // if ( Self.WordPos = Self.NbWord ) then
  //   NewTerm := NewTerm + cSpace + LatForm;
  Result := NewTerm;
end; // _________________________________________________________MakeLatPluralES

function           tESTerm.MakeGenLatPluralES
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenLatPluralES
  * Construction of a genitive lateral plural Spanish term *
  Description:
  This procedure handles a Spanish singular term and transform it to the
  equivalent lateral plural form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NewTerm:         String;
begin
  NewTerm := Self.MakeLatPluralES;
  Result := 'de' + cSpace + NewTerm;
end; // ______________________________________________________MakeGenLatPluralES

procedure          tESTerm.SetNominativeES(
  Value:           String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNominativeES
  * Action when entering a new value for Nominative property *
  Description:
  This method enters a new value for the property Nominative and reset the
  properties of this object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  NbWord:          Integer;
  IsGen:           Boolean;
  MyTerm:          String;
  MyCell:          WordAnal;
begin
  // Store the words (blank separated)
  MyTerm := Self.Nominative;
  NbWord := 0;
  if ( Length( MyTerm ) = 0 ) then
    Exit;
  IsGen := False;
  repeat

    // Retrieve each word
    Posit := Pos( cSpace, MyTerm );
    if ( Posit = 0 ) then
    begin
      MyCell.Lem := MyTerm;
    end else
    begin
      MyCell.Lem := Copy( MyTerm, 1, Posit - 1 );
      MyTerm := Copy( MyTerm, Posit + 1, Length( MyTerm ) );
    end;

    // Set the partial syntactic codes with case
    MyCell.Cod := 'xxxnx';
    IsGen := ( ( IsGen ) or
               ( MyCell.Lem = 'de' ) or ( MyCell.Lem = 'des' ) or
               ( MyCell.Lem = 'del' ) );
    if ( IsGen ) then
      MyCell.Cod := 'xxxgx';
    Self.Node[ NbWord ] := MyCell;
    Inc( NbWord );
  until ( Posit = 0 );
  Self.IsRegular := True;

  // Validate the syntax information
  Self.SetSyntaxES;
end; // _________________________________________________________SetNominativeES

procedure          tESTerm.SetSyntaxES;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetSyntaxES
  * Compile the syntax of a term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  CellPos:         Integer;
  FirstGen:        Integer;
  Posit:           Integer;
  Ident:           Integer;
  IsRule:          Boolean;
  MyWord:          String;
  MyLem:           String;
  MyCode:          String;
  NewWord:         String;
  FemAdj:          String;
  MyGender:        tGender;
  MyNode:          WordAnal;
begin
  // Get the gender of nominative noun
  MyGender := Self.GenderES;

  // Check for a possible adjective before the noun
  CellPos := 0;
  MyNode := Self.Node[ 0 ];
  MyWord := MyNode.Lem;
  if ( IsFrontES( MyWord ) ) then
    CellPos := 1;

  // Update the nominative cells
  if ( MyGender <> ge_unspec ) then
  begin
    MyNode := Self.Node[ CellPos ];
    MyCode := MyNode.Cod;

    // Update the front cell if any
    if ( CellPos = 1 ) then
    begin
      MyNode := Self.Node[ 0 ];
      if ( MyGender = ge_masculine ) then
        MyNode.Cod := 'fxmns'
      else
      begin
        MyNode.Cod := 'fxfns';
        FemAdj := MakeGenderES( MyGender, MyWord, IsRule, Ident );
        MyNode.Lem := FemAdj;
      end;
      Self.Node[ 0 ] := MyNode;
    end;

    // Update the prefix cell
    if ( ( MyCode <> cEmpty ) and ( MyCode[ 1 ] = 'p' ) ) then
    begin
      Inc( CellPos );
      MyCode := Self.Node[ CellPos ].Cod;
    end;

    // Update the noun cell
    if ( ( MyCode <> cEmpty ) and ( MyCode[ 1 ] = 'n' ) ) then
    begin
      if ( MyGender = ge_masculine ) then
        Self.SetCode( CellPos, 'nxmns' )
      else
        Self.SetCode( CellPos, 'nxfns' );
    end;

    // Update the adjective cells if any
    FirstGen := Self.NbWord;
    if ( Self.NbWord > CellPos ) then
    begin
      for Indx := CellPos + 1 to Self.NbWord - 1 do
      begin
        MyNode := Self.Node[ Indx ];
        if ( ( MyNode.Lem = 'de' ) or
             ( MyNode.Lem = 'del' ) ) then
        begin
          FirstGen := Indx;
          Break;
        end;
        if ( ( Length( MyNode.Cod ) > 0 ) and ( MyNode.Cod[ 1 ] = 'a' ) ) then
        begin
          if ( MyGender = ge_masculine ) then
            Self.SetCode( Indx, 'axmns' )
          else
            Self.SetCode( Indx, 'axfns' );
          NewWord := MakeGenderES( ge_feminine, MyNode.Lem, IsRule, Ident );
          MyNode.Lem := NewWord;
          Self.Node[ Indx ] := MyNode;
        end;
      end; // on all adjectives after the head noun at nominative
    end;

    // Update the genitive words if any
    for Indx := FirstGen to Self.NbWord - 1 do
    begin
      MyLem := Self.Node[ Indx ].Lem;
      if ( ( MyLem = 'de' ) or ( MyLem = 'del' ) ) then
        Self.SetCode( Indx, 'dxxgx' )
      else
        Self.SetCode( Indx, 'nxxgx' );
    end; // for on all non nominative words
  end;
  Self.IsRegular := True;
end; // _____________________________________________________________SetSyntaxES

procedure          tESTerm.SetFormulaES;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormulaES
  * Action when entering a new value for Formula property in Spanish *
  Description:
  This methods aims at building a new nominative term in the specified
  language from a universal formula.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  Lang:            tLanguage = lt_Spanish;
var
  Indx:            Integer;
  Indy:            Integer;
  Posit:           Integer;
  UID:             Integer;
  IsFront:         Boolean;
  MyFormula:       String;
  MyPart:          String;
  MyType:          String;
  MyCode:          String;
  MyWord:          String;
  LexUnit:         TUnit;
  LexEntity:       TEntity;
  Query:           TSearch;
  MySingle:        TSingle;
  ANode:           WordAnal;
  TempNode:        WordAnal;
  MyGender:        tGender;
begin

  // Loop on all contributions of the formula
  MyFormula := Self.Formula;
  Indx := 0;
  repeat

    // Retrieve an single contribution
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

    // Retrieve the contribution
    if ( LexEntity <> nil ) then
    begin
      if ( MyType = 'N' ) then
      begin
        MyWord := LexEntity.GetVocabulary( Lang, st_Nou );
        MyCode := 'nxxxx';
      end else
      if ( MyType = 'C' ) then
      begin
        ANode.Lem := 'de';
        ANode.Cod := 'qxxgx';
        Self.Node[ Indx ] := ANode;
        Inc( Indx );
        MyWord := LexEntity.GetVocabulary( Lang, st_Nou );
        MyCode := 'nxxgx';
      end else
      if ( MyType = 'A' ) then
      begin
        MyWord := LexEntity.GetVocabulary( Lang, st_Adj );
        MyCode := 'axxxx';
        IsFront := IsFrontES( MyWord );
      end else
      if ( MyType = 'P' ) then
      begin
        MyWord := LexEntity.GetVocabulary( Lang, st_Pre );
        MyCode := 'pxxxx';
      end else
      if ( MyType = 'I' ) then
      begin
        MyWord := LexEntity.GetVocabulary( Lang, st_Inv );
        MyCode := 'ixxxx';
      end else
      if ( MyType = 'M' ) then
      begin
        begin
          MyWord := LexEntity.GetVocabulary( Lang, st_Nou );
          if ( MyWord = cEmpty ) then
          begin
            MyWord := LexEntity.GetVocabulary( Lang, st_Adj );
            if ( MyWord = cEmpty ) then
            begin
              MyWord := LexEntity.GetVocabulary( Lang, st_Pre );
              if ( MyWord = cEmpty ) then
              begin
                MyWord := LexEntity.GetVocabulary( Lang, st_Inv );
                if ( MyWord = cEmpty ) then
                  MyWord := 'ERR';
              end;
            end;
          end;
          MyCode := 'ixxxx';
        end;
      end;
      if ( MyWord <> cEmpty ) then
      begin
        Self.NbWord := Indx + 1;
        ANode := Self.Node[ Indx ];
        ANode.Lem := MyWord;
        ANode.Cod := MyCode;
        Self.Node[ Indx ] := ANode;
      end else
      begin
        if ( UID = 0 ) then
          MyCode := MyCode;
        ANode.Cod := MyCode;
        ANode.Lem := LexEntity.InternalTex;
        Self.Node[ Indx ] := ANode;
      end;

      // Reposition a front adjective at the first place
      if ( IsFront ) then
      begin
        TempNode := Self.Node[ Indx ];
        for Indy := Indx downto 1 do
          Self.Node[ Indy ] := Self.Node[ Indy - 1 ];
        Self.Node[ 0 ] := TempNode;
      end;
    end;

    // Move to next contribution
    Inc( Indx );
  until ( MyFormula = cEmpty ); // on all contributions of a formula
  Self.SetSyntaxES;
end; // ____________________________________________________________SetFormulaES

function           tESTerm.MakeGenderES(
  Syntax:          tGender;
  AWord:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenderES
  * Make an adjective at a specified gender in Spanish *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Lgt:             Integer;
  MyMasc:          String;
  MyFem:           String;
  Last:            String;
begin

  // Scan the exceptions
  for Indx := 1 to NbAdjExGenderES do
  begin
    if ( AWord = cAdjExGenderES[ Indx, ge_masculine ] ) then
    begin
      Result := cAdjExGenderES[ Indx, ge_feminine ];
      Exit;
    end;
  end; // for

  // Apply successive rules for feminine adjective in Spanish
  IsRule := True;
  Ident := 0;
  for Indx := 1 to NbAdjRuGenderES do
  begin
    MyMasc := cAdjRuGenderES[ Indx, ge_masculine ];
    Lgt := Length( MyMasc );
    Last :=  Copy( AWord, Length( AWord ) - Lgt + 1, Lgt );
    if ( Last = MyMasc ) then
    begin
      Result := Copy( AWord, 1, Length( AWord ) - Lgt ) +
                cAdjRuGenderES[ Indx, ge_feminine ];
      Ident := Indx;
      Exit;
    end;
  end;
  IsRule := False;
  Result := cEmpty;
end; // ____________________________________________________________MakeGenderES

function           IsFrontES(
  Text:            String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsFrontES
  * Find if an adjective is a front adjective *
  Description:
  In Spanish, adjectives are positioned after the noun they are qualifying. But
  a number of exceptions are possible. This routine checks if a specified
  adjective is a front adjective, according to a preset list.</P>
  The specified adjective may be given at masculine or feminine.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  Result := False;
  for Indx := 1 to NbFrontES do
  begin
    if ( Text = cFrontES[ Indx ] ) then
    begin
      Result := True;
      Exit;
    end;
  end; // for on all front adjectives
end; // _______________________________________________________________IsFrontES

procedure          SetAdjectiveES(
  Adj:             String;
  Pre:             String;
  var MySelf:      tSingle );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetAdjectiveES
  * Insert an adjective of expansion in base part of a term *
  Description:
  This procedure receives an adjective and inserts it in the base part of the
  term given as argument. The position of this adjective is defined with
  strict syntactic rules specific to the language. The adjective is first
  modified in gender and number before being inserted.</p>
  The possibility of a genitive noun complement immediatly following the main
  nominative noun is not compatible with an adjective expansion and must not
  occur here.</p>
  The adjective may be accompanied by a prefix, to be added in front of the
  adjective.<p>
  About local variables:
  - Nounpos: position of the noun (last by default)
  - NbPlus: number of additional words after the noun
  - NbShift: 1 for adjective only, 2 for prefix and adjective.</p>
  In French, it is necessary to take care of possible frontal adjectives.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbWord:          Integer;
  NounPos:         Integer;
  AdjPos:          Integer;
  NbShift:         Integer;
  NbPlus:          Integer;
  Ident:           Integer;
  IsRule:          Boolean;
  MyWord:          String;
  MyTerm:          String;
  MyAdj:           tESTerm;
begin

  // Check for a possible frontal adjective before the noun
  {NounPos := 0;
  MyNode := MySelf.Node[ 0 ];
  MyWord := MyNode.Wrd;
  if ( MyNode.Cod[ 1 ] = 'f' ) then
  begin
    MyWord := MySelf.Node[ 1 ].Wrd;
    NounPos := 1;
  end;
  AdjPos := NounPos + 1;
  NbWord := MySelf.NbWord;
  NbPlus := NbWord - 1 - NounPos;

  // Prepare a new node for the adjective
  MyNode := MySelf.Node[ NounPos ];
  NewWord.Cod := 'axmns';
  if ( MyNode.Cod[ 3 ] = 'f' ) then
  begin
    MyAdj := tESTerm.Create( Adj );
    Adj := MyAdj.MakeGenderES( ge_masculine, Adj, IsRule, Ident );
    NewWord.Cod := 'axfns';
  end;
  NewWord.Wrd := Adj;

  // Prepare a new node for the adjective
  if ( Pre <> cEmpty ) then
  begin
    NewPref.Wrd := Pre;
    NewPref.Cod := 'pxxxx';
  end;

  // Create the new nodes for the adjective (and prefix) after the noun
  Inc( NbWord );
  NbShift := 1;
  if ( Pre <> cEmpty ) then
  begin
    Inc( NbWord );
    NbShift := 2
  end;
  MySelf.NbWord := NbWord;
  if ( NbPlus > 0 ) then
  begin
    for Indx := NbWord - 1 downto NbWord - NbPlus do
      MySelf.Node[ Indx ] := MySelf.Node[ Indx - NbShift ];
  end;

  // Add the new nodes
  if ( Pre <> cEmpty ) then
  begin
    MySelf.Node[ AdjPos ] := NewPref;
    MySelf.Node[ AdjPos + 1 ] := NewWord;
  end else
    MySelf.Node[ AdjPos ] := NewWord;

  // Rebuild the term
  MyTerm := cEmpty;
  for Indx := 0 to NbWord - 1 do
  begin
    MyWord := MySelf.Node[ Indx ].Wrd;
    if ( MySelf.Node[ Indx ].Cod[ 1 ] = 'p' ) then
      MyTerm := MyTerm + MyWord
    else
      MyTerm := MyTerm + MyWord + cSpace;
  end;
  MySelf.Mandat := Trim( MyTerm );}
end; // __________________________________________________________SetAdjectiveES

function           tESTerm.MakeMandatES(
  TID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeMandatES
  * Make the mandatory part of a Spanish term *
  Description:
  This procedure defines the mandatory part specified by the TID argument.</p>
  The part to be added is retrieved as a Spanish term at nominative that is
  expected to be regular. The genitive is computed and then returned. The
  syntax analysis of term is updated.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  NbSingle:        Integer;            // Number of singles in generating entity
  MandatEntity:    tEntity;            // Generating entity of expansion
  MyTerm:          tSingle;            // Applicable single
  MyESTerm:        tESTerm;            // Applicable term
begin

  // Build the genitive
  Past := Self.NbWord;
  MandatEntity := TAH.GetEntityByTID( TID );
  NbSingle := MandatEntity.NbCurrent;
  for Indx := 0 to NbSingle - 1 do
  begin
    MyTerm := MandatEntity.CurrTerm[ Indx ];
    if ( MyTerm.Category in cGroupBase ) then
      Break;
  end; // for on all singles of the current language
  if ( MyTerm <> nil ) then
  begin
    MyESTerm := tESTerm( MyTerm.LgTerm );
    Result := Trim( MyESTerm.Genitive );
  end;

  // Adjust the syntax of owner French term
  NbWordGS := MyESTerm.NbWordGS;
  for Indx := 0 to NbWordGS - 1 do
  begin
    Self.Node[ Indx + Past ] := MyESTerm.NodeGS[ Indx ];
  end; // for on all genitive words
end; // ____________________________________________________________MakeMandatES

function           SetFormalPSetES(
  Term:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormalPSetES
  * Define the formal term for a pset *
  Description:
  The formal term for a specific pset is created, with its nominative part at
  singular because plurals are not accepted in the formal terms. The head part
  is followed by the genitive plural form of the generic term.</p>
  In Spanish, it is necessary to take care of a possible ellision.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTerm:          tTerm;
  NewTerm:         String;
  Prefix:          String;
begin
  MyTerm := tTerm.Create( Term.Mandat, lt_Spanish );
  NewTerm := MyTerm.Plural;
  Result := cEmpty;
  if ( MyTerm.IsRegular ) then
  begin
    Prefix := 'par de juntos de';
    Result := Prefix + cSpace + NewTerm;
  end;
end; // _________________________________________________________SetFormalPSetES

function           TestAdjectiveGenderES(
  AGender:         tGender;
  AnAdj:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestAdjectiveGenderES
  * Test for feminine of a Spanish adjective *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyAdj:           tESTerm;
begin
  MyAdj := tESTerm.Create( AnAdj );
  Result := MyAdj.MakeGenderES( AGender, AnAdj, IsRule, Ident );
end; // ___________________________________________________TestAdjectiveGenderES

function           TestNounPluralES(
  ANoun:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestNounPluralES
  * Test for plural of a Spanish noun *
  Description:
  This function defines the plural of a noun. The plural is computed on a
  rules and exceptions basis.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyNoun:          tESTerm;
  MyNumber:        tNumber;
begin
  MyNoun := tESTerm.Create( ANoun );
  Result := MyNoun.MakePluralES( IsRule, Ident );
end; // ________________________________________________________TestNounPluralES

end.
