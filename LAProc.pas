{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit LAProc
  * Package for Latin language management *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit LAProc;

interface

uses
  TAHParam, Term, SingleTerms;

const
  CurSep           = '¦';
  cBreak           = '|';
  cSpace           = ' ';
  cEmpty           = '';
  cAster           = '*';
  cRol             = '(';
  cRor             = ')';
  cSql             = '[';
  cSqr             = ']';
  cCul             = '{';
  cCur             = '}';
  cAnl             = '<';
  cAnr             = '>';
  cPeriod          = '.';
  cSemi            = ';';
  cColumn          = ':';
  cDash            = '-';
  cQuote           = #39;      // Single quote
  cDQuote          = '"';      // Double quote
  cSlash           = '/';
  cComma           = ',';

  NbPrefix         = 13;
  cClassis         = 'classis';
  cInvalidEntry    = 'Invalid entry';
  cMissingWord     = 'Missing word';
  cDeclension      = 'declension';

  NbFemAdj         = 2;
  NbNeuAdj         = 2;
  NbFemAdjExcept   = 6;
  NbNeuAdjExcept   = 6;
  NbNounChGenderLA = 1;
  NbAdjChGenderLA  = 1;
  NbNounChPluralLA = 27;
  NbAdjChPluralLA  = 1;
  NbNounChGenSinLA = 12;
  NbAdjChGenSinLA  = 1;
  NbNounChGenPluLA = 1;
  NbAdjChGenPluLA  = 1;
  NbNoChExpLA      = 13;
  NbAdjChExpLA     = 9;
  NbMandChExpLA    = 4;
  NbLatChExpLA     = 7;
  NbOptChExpLA     = 2;

type
                   { Rules for transition of adjectives from masculine to
                     feminine at nominative singular }
  tFemAdj          = Array[ 1 .. NbFemAdj, 1 .. 2 ] of String;
                   { Rules for transition of adjectives from masculine to
                     neuter at nominative singular }
  tNeuAdj          = Array[ 1 .. NbNeuAdj, 1 .. 2 ] of String;
                   { Exceptions to feminine rule }
  tFemAdjExcept    = Array[ 1 .. NbFemAdjExcept, 1 .. 2 ] of String;
                   { Exceptions to neuter rule }
  tNeuAdjExcept    = Array[ 1 .. NbNeuAdjExcept, 1 .. 2 ] of String;
                   // Tests for nominative plural nouns
  tNounChGenderLA  = Array[ 1 .. NbNounChGenderLA,
                       va_word .. va_1 ] of String;
                   // Tests for nominative plural nouns
  tAdjChGenderLA   = Array[ 1 .. NbAdjChGenderLA,
                      ge_masculine .. ge_neuter ] of String;
                   // Tests for nominative plural nouns
  tNounChPluralLA  = Array[ 1 .. NbNounChPluralLA, nu_sin .. nu_plu ] of String;
                   // Tests for nominative plural nouns
  tAdjChPluralLA   = Array[ 1 .. NbAdjChPluralLA, nu_sin .. nu_pln ] of String;
                   // Tests for nominative plural nouns
  tNounChGenSinLA  = Array[ 1 .. NbNounChGenSinLA, nu_sin .. nu_plu ] of String;
                   // Tests for nominative plural nouns
  tAdjChGenSinLA   = Array[ 1 .. NbAdjChGenSinLA, nu_sin .. nu_pln ] of String;
                   // Tests for nominative plural nouns
  tNounChGenPluLA  = Array[ 1 .. NbNounChGenPluLA, nu_sin .. nu_plu ] of String;
                   // Tests for nominative plural nouns
  tAdjChGenPluLA   = Array[ 1 .. NbAdjChGenPluLA, nu_sin .. nu_pln ] of String;
                   // Tests for adjective expansions
  tNoChExpLA       = Array[ 1 .. NbNoChExpLA, nu_sin .. nu_plu ] of Integer;
                   // Tests for adjective expansions
  tAdjChExpLA      = Array[ 1 .. NbAdjChExpLA, nu_sin .. nu_plu ] of Integer;
                   // Tests for mandatory expansions
  tMandChExpLA     = Array[ 1 .. NbMandChExpLA, nu_sin .. nu_plu ] of Integer;
                   // Tests for lateral expansions
  tLatChExpLA      = Array[ 1 .. NbLatChExpLA, nu_sin .. nu_plu ] of Integer;
                   // Tests for optional expansions
  tOptChExpLA      = Array[ 1 .. NbOptChExpLA, nu_sin .. nu_plu ] of Integer;

                   { * Enumeration type for code TCN: Type, Case, Number * }
  tTCN             = (
                   tcn_nul,            // nothing
                   tcn_sns,            // substantive, nominative, singular
                   tcn_sgs,            // substantive, genitive, singular
                   tcn_snp,            // substantive, nominative, plural
                   tcn_sgp,            // substantive, genitive, plural
                   tcn_ans,            // adjective, nominative, singular
                   tcn_ags,            // adjective, genitive, singular
                   tcn_anp,            // adjective, nominative, plural
                   tcn_agp,            // adjective, genitive, plural
                   tcn_cla );          // classis

                   { * Single row of transition matrix }
  tTransit         = Array[ tTCN ] of Boolean;

                   { * Transition matrix * }
  tMatrix          = Array[ tTCN ] of TTransit;

                   // 4 forms of a noun plus gender
  tNounCase        = Array[ 1 .. 5 ] of String;

                   // 12 forms of an adjective + LID
  tAdjCase         = Array[ 1 .. 13 ] of String;

                   { * Storage of term file *
                   Description:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   Cod        TA code
                   TID        TID unique identifier of TA
                   Ter        Base Latin term
                   Exp        Expanded Latin term
                   </TABLE> }
  TermRec          = record
    Cod:           String;
    TID:           Integer;
    Ter:           String;
    Exp:           String;
  end;
                   { * Storage of Latin dictionary *
                   Description:
                   The Latin dictionary is made of 5 entries per record, as
                   described in the following table:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   LID        LID unique identifier of Latin dictionary
                   Cas        Latin case in declension
                   Cod        Code for type, declension, gender, case and number
                   Sub        Full Latin term
                   Cla        Class to which the present word belongs
                   </TABLE> }
  LatinRec         = record
    LID:           Integer;
    Adj:           Integer;
    Pre:           Integer;
    Cas:           String;
    Cod:           String;
    Sub:           String;
    Cla:           String;
  end;

                   { Array for storage of integers }
  tListInt         = Array of Integer;

                   { Enumeration type for Latin word categories }
  tWordCateg       = (
                   wt_sub,                 // substantive
                   wt_adj,                 // adjective
                   wt_com,                 // comparative adjective
                   wt_ord,                 // ordinal adjective
                   wt_mod,                 // modal prefix
                   wt_mor,                 // morpheme
                   wt_ppr,                 // present participle
                   wt_inv,                 // invariant acronym
                   wt_hol,                 // main placeholder
                   wt_sec );               // second placeholder

                   { Enumeration type for Latin genders }
  tWordGender      = (
                   gd_mas,                 // masculine
                   gd_fem,                 // feminine
                   gd_neu );               // neutral

                   { Enumeration type for Latin numbers }
  tWordNumber      = (
                   nb_sing,                // singular
                   nb_plur );              // plural

                   { Enumeration type for Latin cases }
  tWordCase        = (
                   wa_nom,                 // nominative
                   wa_gen );               // genitive

                             // Define the Latin Term object
  tLatinTerm                 = class( tTerm )
  public
                             // Enter the nominative singular of the term
    procedure                SetNominativeLA(
                               Value: String );
                             // Enter the formula of the term
    procedure                SetFormulaLA;
                             // Find the gender of a term
    function                 GenderLA
                               : tGender;
                             // Set the gender for an adjective
    procedure                SetGenderLA(
                               MyGender: tWordGender );
                             // Get the gender (of first word)
    function                 GetGenderLA
                               : tWordGender;
                             // Define the Genitive property
    function                 MakeGenitiveLA
                               : String;
                             // Define the Plural property
    function                 MakePluralLA(
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Define the GenPlural property
    function                 MakeGenPluralLA
                               : String;
                             // Define the Lateral property
    function                 MakeLateralLA(
                               IsShort: Boolean )
                               : String;
                             // Define the Lateral plural property
    function                 MakeLatPluralLA
                               : String;
                             // Define the genitive lateral plural property
    function                 MakeGenLatPluralLA
                               : String;
                             // Constructor with setting of Nominative property
    constructor              Create(
                               Nominative: String );
                             // Constructor as above with forced adjective
    constructor              CreateAdj(
                               Nominative: String;
                               Dummy: Integer = 1 );
                             // Define a feminine adjective
    function                 FemAdjectiveLA(
                               AWord: String )
                               : String;
                             // Define a neuter adjective
    function                 NeuAdjectiveLA(
                               AWord: String )
                               : String;
                             // Latin parser of a single term
    procedure                ProcessATerm();
                             // Make the mandatory expansion of a term
    function                 MakeMandatLA(
                               MyTerm: tSingle )
                               : Boolean;
                             // Make the optional expansion of a term
    function                 MakeOptionLA(
                               MyTerm: tSingle )
                               : Boolean;
                             // Add an adjective expansion of a term
    function                 MakeAdjectiveLA(
                               Adj: String;
                               Pre: String )
                               : Boolean;
                             // Prepare the base part with a placeholder
    function                 SetBaseLA(
                               TID: Integer )
                               : Boolean;
  end; // Class tLatinTerm

const
                   // Rules for feminine singular adjectives
  cFemAdj:         tFemAdj = (
                   ( 'us', 'a' ),
                   ( 'is', 'is' ) );
                   // Rules for neuter singular adjectives
  cNeuAdj:         tFemAdj = (
                   ( 'us', 'um' ),
                   ( 'is', 'e' ) );
                   // Exceptions for feminine singular adjectives
  cFemAdjExcept:   tFemAdjExcept = (
                   ( 'posterior', 'posterior' ),
                   ( 'superior', 'superior' ),
                   ( 'anterior', 'anterior' ),
                   ( 'inferior', 'inferior' ),
                   ( 'dexter', 'dextra' ),
                   ( 'sinister', 'sinistra' ) );
                   // Exceptions for neuter singular adjectives
  cNeuAdjExcept:   tFemAdjExcept = (
                   ( 'posterius', 'posterius' ),
                   ( 'superius', 'superius' ),
                   ( 'anterius', 'anterius' ),
                   ( 'inferius', 'inferius' ),
                   ( 'dexter', 'dextrum' ),
                   ( 'sinister', 'sinistrum' ) );
                   // Test values for gender of nouns
  cNounChGenderLA: tNounChGenderLA = (
                   ( 'arteria', 'f' ) );
                   // Test values for gender of adjective
  cAdjChGenderLA:  tAdjChGenderLA = (
                   ( 'arteriosus', 'arteriosa', 'arteriosum' ) );
                   // Test values for nominative plural nouns
  cNounChPluralLA: tNounChPluralLA = (
                   ( 'actio', 'actiones' ),
                   ( 'ala', 'alae' ),
                   ( 'angulus', 'anguli' ),
                   ( 'centrum', 'centra' ),
                   ( 'falx', 'falces' ),
                   ( 'femur', 'femora' ),
                   ( 'forceps', 'forcipes' ),
                   ( 'incus', 'incudes' ),
                   ( 'lens', 'lentes' ),
                   ( 'pterion', 'pteria' ),
                   ( 'neuron', 'neura' ),
                   ( 'obex', 'obices' ),
                   ( 'os', 'ora' ),
                   ( 'par', 'paria' ),
                   ( 'paries', 'parietes' ),
                   ( 'pharynx', 'pharynges' ),
                   ( 'radius', 'radii' ),
                   ( 'pyramis', 'pyramides' ),
                   ( 'ren', 'renes' ),
                   ( 'res', 'res' ),
                   ( 'rete', 'retia' ),
                   ( 'sinus', 'sinus' ),
                   ( 'sipho', 'siphones' ),
                   ( 'soma', 'somata' ),
                   ( 'stapes', 'stapedes' ),
                   ( 'tractus', 'tractus' ),
                   ( 'venter', 'ventres' ) );

                   // Test values for nominative plural adjectives
  cAdjChPluralLA:  tAdjChPluralLA = (
                   ( 'arteriosus', 'arteriosi', 'arteriosae', 'arteriosa' ) );
                   // Test values for genitive singular nouns
  cNounChGenSinLA: tNounChGenSinLA = (
                   ( 'abdomen', 'abdominis' ),
                   ( 'appendix', 'appendicis' ),
                   ( 'circulus', 'circuli' ),
                   ( 'cutis', 'cutis' ),
                   ( 'dens', 'dentis' ),
                   ( 'folium', 'folii' ),
                   ( 'inguen', 'inguinis' ),
                   ( 'junctio', 'junctionis' ),
                   ( 'macula', 'maculae' ),
                   ( 'paries', 'parietis' ),
                   ( 'punctum', 'puncti' ),
                   ( 'vas', 'vasis' ) );
                   // Test values for genitive singular adjectives
  cAdjChGenSinLA:  tAdjChGenSinLA = (
                   ( 'clarus', 'clari', 'clarae', 'clari' ) );
                   // Test values for genitive plural nouns
  cNounChGenPluLA: tNounChGenPluLA = (
                   ( 'circulus', 'circulorum' ) );
                   // Test values for genitive plural adjectives
  cAdjChGenPluLA:  tAdjChGenPluLA = (
                   ( 'clarus', 'clarorum', 'clararum', 'clarorum' ) );

                   // Test of terms without expansion
  cNoChExpLA:      tNoChExpLA = (
                   ( 28827, 28827 ),   // gyri interlobares (par)
                   ( 5264, 5264 ),     // telencephalon (generic)
                   ( 29947, 29947 ),   // palpebra (generic)
                   ( 7053, 7053 ),     // palpebrae
                   ( 6005, 6005 ),     // gyrus angularis
                   ( 5973, 5973 ),     // gyrus cerebri
                   ( 7816, 7816 ),     // compartiment infratentoriel
                   ( 7670, 7670 ),     // neurone ganglionaire nain
                   ( 7044, 7044 ),     // anneau tendineux commun
                   ( 8088, 8088 ),     // méat acoustique externe osseux
                   ( 6274, 6274 ),     // fibres d'association courtes
                   ( 28553, 28553 ),   // fibre d'association courte
                   ( 0, 0 ) );

                   // Test of adjective expansion
                   // First TID: st_for; second TID: st_val
  cAdjChExpLA:     tAdjChExpLA = (
                   ( 33461, 33461 ),   // segmenta cervicalia medullae spinalis
                   ( 5792, 5792 ),     // commissura habenularis
                   ( 4155, 4155 ),     // arteria ulnaris
                   ( 8415, 8415 ),     // tractus hypothalamospinalis
                   ( 7986, 7986 ),     // segmentum cervicale 1
                   ( 6985, 6985 ),     // arteriola retinalis temporalis sup
                   ( 6281, 6281 ),     // fasciculi occipitales horizontales
                   ( 11830, 11830 ),   // fasciculus temporoparietalis vertic
                   ( 0, 0 ) );

                   // Test of mandatory expansion
  cMandChExpLA:    tMandChExpLA = (
                   ( 6085, 6085 ),     // radiatio corporis callosi
                   ( 12294, 12294 ),   // fasc prosencephali medialis ascendens
                   ( 5142, 5142 ),     // pars spinalis fili terminalis
                   ( 13172, 13172 ) ); // tractus commissuralis hippocampi

                   // Test of lateral expansion
  cLatChExpLA:     tLatChExpLA = (
                   ( 38443, 38443 ),   // lobus temporalis dexter
                   ( 28635, 28635 ),   // radiatio sinistra corporis callosi
                   ( 28935, 28935 ),   // cellulae cholinergicae cruris ...
                   ( 32446, 32446 ),   // tractus commissurales hippocampi ...
                   ( 28074, 28074 ),   // fibrae periventriculares thalami ...
                   ( 38488, 38488 ),   // facies superolateralis sinistra ...
                   ( 0, 0 ) );

                   // Test of optional expansion
  cOptChExpLA:     tOptChExpLA = (
                   ( 5304, 5304 ),     // pars rhombencephalica caudalis ...
                   ( 7985, 7985 ) );   // segmentum cervicale medullae spinalis
const
                   { Short description for word categories }
  cWordShort:      Array[ tWordCateg ] of string = (
                   'n',
                   'a',
                   'c',
                   'o',
                   'k',
                   'm',
                   'p',
                   'i',
                   'h',
                   's' );

                   { Long description for word categories }
  cWordDescr:      Array[ tWordCateg ] of string = (
                   'noun',
                   'adjective',
                   'comparative adjective',
                   'ordinal adjective',
                   'modal prefix',
                   'prefix',
                   'present participle',
                   'invariant acronym',
                   'main placeholder',
                   'second placeholder' );

                   { Link texts for word categories }
  cLinkDescr:      Array[ tWordCateg ] of string = (
                   'Cpl',
                   'Adj',
                   'Comp',
                   'Ord',
                   'Modal',
                   'Morpho',
                   'PPres',
                   'Inv',
                   'Holder',
                   'MoreH' );

                   { Short description for word gender }
  cGenderShort:    Array[ tWordGender ] of String = (
                   'm',
                   'f',
                   'n' );

                   { Long description for word gender }
  cGenderDescr:    Array[ tWordGender ] of String = (
                   'masculine',
                   'feminine',
                   'neutral' );

                   { Short description for word number }
  cNumberShort:    Array[ tWordNumber ] of String = (
                   's',
                   'p' );

                   { Long description for word number }
  cNumberDescr:    Array[ tWordNumber ] of String = (
                   'singular',
                   'plural' );

                   { Short description for word case }
  cCaseShort:      Array[ tWordCase ] of String = (
                   'n',
                   'g' );

                   { Long description for word case }
  cCaseDescr:      Array[ tWordCase ] of String = (
                   'nominative',
                   'genitive' );

                   { *  * }
  cModalList:      Array[ 1 .. NbPrefix ] of String = (
                   'sub', 'para', 'peri', 'pre', 'supra',
                   'hemi', 'semi', 'post', 'epi', 'extra',
                   'inter', 'intra', 'juxta' );

                   { * Values for tripple word type - case - number * }
  cTTCNValue:      Array[ tTCN ] of String = (
                   'nul', 'nns', 'ngs', 'nnp', 'ngp',
                   'ans', 'ags', 'anp', 'agp', 'cla' );

                   // Lateral values
  cLatSin:         Array[ tLatType ] of String = (
                   '',                       // undefined value
                   'sinister',               // left masc nom sing
                   'sinistri',               // left masc gen sing
                   'sinistri',               // left masc nom plur
                   'sinistrorum',            // left masc gen plur
                   'sinistra',               // left fem nom sing
                   'sinistrae',              // left fem gen sing
                   'sinistrae',              // left fem nom plur
                   'sinistrarum',            // left fem gen plur
                   'sinistrum',              // left neuter nom sing
                   'sinistri',               // left neuter gen sing
                   'sinistra',               // left neuter nom plur
                   'sinistrorum' );          // left neuter gen plur
  cLatDex:         Array[ tLatType ] of String = (
                   '',                       // undefined value
                   'dexter',                 // right masc nom sing
                   'dextri',                 // right masc gen sing
                   'dextri',                 // right masc nom plur
                   'dextrorum',              // right masc gen plur
                   'dextra',                 // right fem nom sing
                   'dextrae',                // right fem gen sing
                   'dextrae',                // right fem nom plur
                   'dextrarum',              // right fem gen plur
                   'dextrum',                // right neuter nom sing
                   'dextri',                 // right neuter gen sing
                   'dextra',                 // right neuter nom plur
                   'dextrorum' );            // right neuter gen plur

                   { * Transition matrix *
                   Description:
                   This matrix allows transitions from any state TCN to another
                   state, this regulating the well-formed terms in Latin TA.<P>
                   Matrix[ x, y ] is true if a transition from state x to
                   state y is allowed, x and y being of type TTCN.<P>
                   The transition sns to sns is for juxtaposition of two
                   substantives like musculus sphincter.<P> }
  cMatrix:         TMatrix = (
{  nul    sns    sgs    snp    sgp    ans    ags    anp    agp    cla  }
( False, True,  True,  True,  True,  True,  False, False, False, True  ), // nul
( False, True,  True,  False, True,  True,  False, False, False, False ), // sns
( False, False, True,  False, True,  False, True,  False, False, True  ), // sgs
( False, False, True,  True,  True,  False, False, True,  False, False ), // snp
( False, False, True,  False, True,  False, False, False, True,  False ), // sgp
( False, False, True,  False, True,  True,  False, False, False, False ), // ans
( False, False, True,  False, True,  False, True,  False, False, False ), // ags
( False, False, True,  False, True,  False, False, True,  False, False ), // anp
( False, False, True,  False, True,  False, False, False, True,  False ), // agp
( False, False, False, False, True,  False, False, False, False, False ) );//cla

                   { * Recursive handling of the next word of a term * }
function           NextWord(
                     Term: String;
                     ACode: String;
                     PastState: TTCN;
                     MainState: TTCN;
                     PastGender: String;
                     MainGender: String;
                     PastNumber: String;
                     MainNumber: String;
                     IsAdj: Boolean;
                     var IsMain: Boolean;
                     var NbLine: Integer;
                     var Cells: TCells )
                     : Boolean;
                   { * Search for word form in dictionary * }
function           WordExists(
                     Word: String;
                     var NbLoc: Integer;
                     var Loc: tListInt )
                     : Boolean;
                   { * Retrieve de present state * }
function           GetState(
                     Cod: String )
                     : tTCN;
                   { * Read the Latin dictionnary * }
procedure          ReadLatinFile(
                     FileName: String );
                   { *  * }
procedure          LatinDeclension(
                     LID: Integer;
                     Erase: Integer;
                     var Declension: String;
                     var Cpt: String );
                   { *  * }
procedure          DecodeDeclension(
                     Decl: String;
                     var Decoded: String );
                   { *  * }
function           MakeNode(
                     Cpt: String;
                     Decl: String )
                     : String;
                   { *  * }
function           MakeLink(
                     Decl: String )
                     : String;
                   { *  * }
function           TypeGender(
                     WordType: String;
                     Gender: String )
                     : String;
                   { *  * }
procedure          MakeSingleLACase(
                     LID: Integer;
                     Decl: String;
                     var AWord: String );
                   { *  * }
function           GetPositionByLID(
                     MyLID: Integer;
                     MyCase: String )
                     : Integer;
                   //
procedure          GetAdjectiveLA(
                     Base: String;
                     var AdjCase: tAdjCase );
                   //
procedure          GetNounLA(
                     Base: String;
                     var NounCase: tNounCase );
                   // Set a formal pset term
function           SetFormalPSetLA(
                     Term: tSingle )
                     : String;
                   // Test for plural of nouns
function           TestNounPluralLA(
                     ANoun: String;
                     var IsRule: Boolean;
                     var Ident: Integer )
                     : String;

var
                   { * Total number of entries in Latin dictionary * }
  TotCas:          Integer;
                   { * Dynamic array for storage of Latin dictionary * }
  Latin:           Array of LatinRec;

implementation

uses
  SysUtils, TAHBrowser, Tetra, Entity;

function           NextWord(
  Term:            String;
  ACode:           String;
  PastState:       tTCN;
  MainState:       tTCN;
  PastGender:      String;
  MainGender:      String;
  PastNumber:      String;
  MainNumber:      String;
  IsAdj:           Boolean;
  var IsMain:      Boolean;
  var NbLine:      Integer;
  var Cells:       tCells )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NextWord
  * Recursive handling of next word of a term *
  Description:
  This recursive procedure works in conjunction with procedure ProcessTerm.
  See this procedure for further description.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Posit:           Integer;
  PosCla:          Integer;
  PosPar:          Integer;
  PosLoc:          Integer;
  LID:             Integer;
  NbMorpho:        Integer;
  PosLine:         Integer;
  MyLoc:           Integer;
  NbLoc:           Integer;
  Temp:            Integer;
  MaxPerm:         Integer;
  PosAct:          Integer;
  Valid:           Boolean;
  IsModal:         Boolean;
  Limited:         Boolean;
  Deja:            Boolean;
  Lem:             String;
  Cla:             String;
  Par:             String;
  ResCla:          String;
  ResPar:          String;
  MyWord:          String;
  MyCod:           String;
  ActCod:          String;
  SubstCod:        String;
  Gender:          String;
  Number:          String;
  MyDecl:          String;
  Morpho:          String;
  Reste:           String;
  ResteWord:       String;
  Separ:           String;
  MyShort:         String;
  State:           tTCN;
  Loc:             tListInt;
  TempLoc:         tListInt;
begin
  // Separation of first word from the rest of the term
  Result := False;
  Posit := Pos( cSpace, Term );
  if Posit > 0 then
  begin
    MyWord := Copy( Term, 1, Posit - 1 );
    Term := Copy( Term, Posit + 1, Length( Term ) );

    // Remove the conjunction 'et'
    if MyWord = 'et' then
    begin
      Posit := Pos( cSpace, Term );
      if Posit > 0 then
      begin
        MyWord := Copy( Term, 1, Posit - 1 );
        Term := Copy( Term, Posit + 1, Length( Term ) );
      end else
      begin
        MyWord := Term;
        Term := cEmpty;
      end;
    end;

    // Remove a last comma
    Posit := Pos( cComma, MyWord );
    if Posit > 0 then
      MyWord := Copy( MyWord, 1, Posit - 1 );
  end else
  begin
    MyWord := Term;
    Term := cEmpty;
  end;

  // Search for the word in dictionnary
  Cells[ NbLine ].Wrd := MyWord;
  if ( WordExists( MyWord, NbLoc, Loc ) ) then
  begin
    Valid := False;
    PosLine := 0;
    LID := 0;

    // Loop on multiple occurences of the same word
    NbLoc := Length( Loc );
    PosLoc := 0;
    Deja := False;
    MaxPerm := NbLoc;
    repeat

      // Exclude all words but adjectives
      MyLoc := Loc[ PosLoc ];
      MyCod := Latin[ MyLoc ].Cod;
      if ( ( IsAdj ) and
           ( MyCod[ 1 ] <> cWordShort[ wt_adj ] ) and
           ( MyCod[ 1 ] <> cWordShort[ wt_ppr ] ) and
           ( MyCod[ 1 ] <> cWordShort[ wt_com ] ) and
           ( MyCod[ 1 ] <> cWordShort[ wt_ord ] ) ) then
        Continue;

      // Make preference for initial substantive as first word
      if ( ( NbLine = 0 ) and
           ( MyCod[ 1 ] = cWordShort[ wt_adj ] ) and
           ( not IsAdj ) ) then
      begin
        Temp := Loc[ 0 ];
        Loc[ 0 ] := Loc[ NbLoc - 1 ];
        Loc[ NbLoc - 1 ] := Temp;
        Dec( MaxPerm );
        if MaxPerm > 0 then
          Continue;
      end;

      // Make preference for substantive at genitive after the first word
      // This favors noun complement instead of noun apposition
      if ( NbLine > 0 ) and
         ( MyCod[ 1 ] = cWordShort[ wt_sub ] ) and
         ( MyCod[ 4 ] <> cCaseShort[ wa_gen ] ) and
         ( not Deja ) and
         ( PosLoc = 0 ) then
      begin
        Deja := True;
        SetLength( TempLoc, NbLoc );
        for Indx := 0 to NbLoc - 1 do
          TempLoc[ Indx ] := Loc[ Indx ];
        PosAct := 0;
        for Indx := 0 to NbLoc - 1 do
        begin
          ActCod := Latin[ TempLoc[ Indx ] ].Cod;
          if ActCod[ 4 ] = cCaseShort[ wa_gen ] then
          begin
            Loc[ PosAct ] := TempLoc[ Indx ];
            Inc( PosAct );
          end;
        end;
        for Indx := 0 to NbLoc - 1 do
        begin
          ActCod := Latin[ TempLoc[ Indx ] ].Cod;
          if ActCod[ 4 ] = cCaseShort[ wa_nom ] then
          begin
            Loc[ PosAct ] := TempLoc[ Indx ];
            Inc( PosAct );
          end;
        end;
        Continue;
      end;

      // Make preference for adjective at genitive after the first word
      // This favors the attachment of an adjective to a noun complement
      // instead of attachment to an initial noun
      if ( NbLine > 0 ) and
         ( MyCod[ 1 ] = cWordShort[ wt_adj ] ) and
         ( MyCod[ 4 ] <> cCaseShort[ wa_gen ] ) and
         ( not Deja ) and
         ( PosLoc = 0 ) then
      begin
        Deja := True;
        SetLength( TempLoc, NbLoc );
        for Indx := 0 to NbLoc - 1 do
          TempLoc[ Indx ] := Loc[ Indx ];
        PosAct := 0;
        for Indx := 0 to NbLoc - 1 do
        begin
          ActCod := Latin[ TempLoc[ Indx ] ].Cod;
          if ActCod[ 4 ] = cCaseShort[ wa_gen ] then
          begin
            Loc[ PosAct ] := TempLoc[ Indx ];
            Inc( PosAct );
          end;
        end;
        for Indx := 0 to NbLoc - 1 do
        begin
          ActCod := Latin[ TempLoc[ Indx ] ].Cod;
          if ActCod[ 4 ] = cCaseShort[ wa_nom ] then
          begin
            Loc[ PosAct ] := TempLoc[ Indx ];
            Inc( PosAct );
          end;
        end;
        Continue;
      end;

      // Retrieve features of the word
      Inc( PosLoc );
      SubstCod := Latin[ MyLoc ].Cod;
      if SubstCod = 'inv' then
        SubstCod := SubstCod + 'ns';
      if ( SubstCod[ 1 ] = cWordShort[ wt_ppr ] ) or
         ( SubstCod[ 1 ] = cWordShort[ wt_inv ] ) or
         ( SubstCod[ 1 ] = cWordShort[ wt_com ] ) or
         ( SubstCod[ 1 ] = cWordShort[ wt_ord ] ) then
        SubstCod := cWordShort[ wt_adj ] + Copy( SubstCod, 2, 4 );
      LID := Latin[ MyLoc ].LID;
      Lem := Latin[ MyLoc ].Sub;
      Cla := Latin[ MyLoc ].Cla;

      // Define current gender, number and state
      Gender := MyCod[ 3 ];
      Number := SubstCod[ 5 ];
      if MyWord = cClassis then
        State := tcn_cla
      else
        State := GetState( SubstCod );

      // Content specific selection of certains solutions:
      // Limit os-oris to chapter 01, 04, 05 and 15
      // All other are os-ossis
      Limited := False;
      if ( LID = 22 ) and
         ( Copy( ACode, 2, 2 ) <> '01' ) and
         ( Copy( ACode, 2, 2 ) <> '04' ) and
         ( Copy( ACode, 2, 2 ) <> '05' ) and
         ( Copy( ACode, 2, 2 ) <> '15' ) then
      begin
        Limited := True;
      end else
      // Limit axis as linea
      if ( ( LID = 4520 ) or
           ( LID = 6113 ) or
           ( LID = 6114 ) or
           ( LID = 6115 ) ) and
         ( ( ACode = 'a02.5.02.010' ) or
           ( ACode = 'a02.5.02.010' ) ) then
      begin
        Limited := True;
      end else
      if ( LID = 4520 ) and
         ( Copy( ACode, 2, 2 ) = '15' ) then
      begin
        Limited := True;
      end else
      // Limit axis as vertebra
      if ( ( LID = 6109 ) or
           ( LID = 4473 ) or
           ( LID = 4474 ) or
           ( LID = 4475 ) ) and
         ( ( ACode = 'a02.2.02.201' ) or
           ( ACode = 'a01.0.00.029' ) or
           ( ACode = 'a02.0.00.009' ) or
           ( ACode = 'a02.2.02.202' ) ) then
      begin
        Limited := True;
      end else
      // Limit the use of the noun pulvinar as first word
      if ( ( LID = 3740 ) {and ( NbLine > 1 )} ) then
      begin
        Limited := True;
      end;

      // Check for standard transitions according to transition matrix of Latin
      Valid := False;
      if ( not Limited ) then
      begin

        // Check for ordinary transitions
        // All transitions to a substantive are accepted
        // Transitions to an adjective are checked in gender and number
        Valid := cMatrix[ PastState, State ] and
                 ( ( ( SubstCod[ 1 ] = cWordShort[ wt_sub ] ) ) or
                   ( ( PastState = tcn_nul ) and
                     ( SubstCod[ 1 ] = cWordShort[ wt_adj ] ) ) or
                   ( ( SubstCod[ 1 ] = cWordShort[ wt_adj ] ) and
                     ( PastGender = Gender ) and
                     ( PastNumber = Number ) ) );

        // Check for case match of adjective to the first entry (non RAT terms)
        // Transitions are checked in gender and number
        Valid := Valid or
                 ( cMatrix[ MainState, State ] and
                   ( MainGender = Gender ) and
                   ( MainNumber = Number ) );

        // Ckeck for acronyms: always allowed
        Valid := Valid or ( SubstCod[ 3 ] = 'v' );
      end;

      // Set main state
      if ( IsMain and Valid ) then
      begin
        MainState := State;
        MainGender := Gender;
        MainNumber := Number;
        if ( State <> tcn_cla ) then
          IsMain := False;
      end;

      // Valid transition when the term is not exhausted
      PosLine := NbLine;
      if ( Valid ) then
      begin
        Inc( NbLine );
        if ( Term = cEmpty ) then
        begin
          Result := True;
        end else
        begin

          // Recursive call on the rest of the term if not yet exhausted
          Result := NextWord( Term, ACode, State, MainState, Gender, MainGender,
                              Number, MainNumber, False,
                              IsMain, NbLine, Cells );
          if ( not Result ) then
          begin
            Dec( NbLine );
            IsMain := NbLine = 0;
            Valid := False;
          end;
        end;
      end else

      // Exhausted term or invalid transition
      begin
        Result := False;
        Cells[ NbLine ].LID := cInvalidEntry;
      end;
    until ( ( PosLoc = NbLoc ) or Result ); // repeat loop

    // Collect word information
    if ( Valid ) then
    begin

      // Handling of morphosemantems
      Reste := Lem;
      ResteWord := MyWord;
      Posit := Pos( cSemi, Reste );
      if ( Posit > 0 ) then
      begin
        Par := cEmpty;
        Separ := cEmpty;
        while ( Posit > 0 ) do
        begin
          Par := Par + Separ + Copy( ResteWord, 1, Posit - 1 );
          Reste := Copy( Reste, Posit + 1, Length( Reste ) );
          ResteWord := Copy( ResteWord, Posit, Length( ResteWord ) );
          Posit := Pos( cSemi, Reste );
          Separ := cSemi;
        end; // while
        Par := Par + Separ + ResteWord;
      end else
        Par := MyWord;

      // Store information on the word
      Cells[ PosLine ].LID := IntToStr( LID );
      Cells[ PosLine ].Cod := MyCod;
      Posit := Pos( cSemi, Lem );
      PosCla := Pos( cSemi, Cla );
      PosPar := Pos( cSemi, Par );
      if ( Posit = 0 ) then
      begin
        Cells[ PosLine ].Cla := Lem;
        Cells[ PosLine ].Lem := Lem;
        if ( Length( Cla ) > 0 ) then
          Cells[ PosLine ].Cla := Cla;
      end else

      // Handling of morphosemantems
      begin
        Cells[ PosLine ].Wrd := Copy( Par, 1, Posit - 1 );
        Cells[ PosLine ].Lem := Copy( Lem, 1, Posit - 1 );
        Cells[ PosLine ].Cla := Copy( Lem, 1, Posit - 1 );
        MyShort := Copy( Cla, 1, PosCla - 1 );
        if ( Length( MyShort ) > 0 ) then
          Cells[ PosLine ].Cla := MyShort;
        Reste := Copy( Lem, Posit + 1, Length( Lem ) );
        ResCla := Copy( Cla, PosCla + 1, Length( Cla ) );
        ResPar := Copy( Par, PosPar + 1, Length( Par ) );
        MyDecl := Cells[ PosLine ].Cod;

        // Loop on all morphosemantems
        NbMorpho := 0;
        repeat
          Inc( NbMorpho );
          Posit := Pos( cSemi, Reste );
          PosCla := Pos( cSemi, ResCla );
          PosPar := Pos( cSemi, ResPar );
          if Posit > 0 then
          begin
            Lem := Copy( Reste, 1, Posit - 1 );
            Cla := Copy( ResCla, 1, PosCla - 1 );
            Par := Copy( ResPar, 1, PosPar - 1 );
            Reste := Copy( Reste, Posit + 1, Length( Reste ) );
            ResCla := Copy( ResCla, PosCla + 1, Length( ResCla ) );
            ResPar := Copy( ResPar, PosPar + 1, Length( ResPar ) );
          end else
          begin
            Lem := Reste;
            Cla := ResCla;
            Par := ResPar;
            Reste := cEmpty;
          end;
          Morpho := Cells[ PosLine - 1 + NbMorpho ].Wrd;
          IsModal := False;

          // Move cells before insertion of morphem
          for Indx  := NbLine downto PosLine + NbMorpho do
          begin
            Cells[ Indx ].Wrd := Cells[ Indx - 1 ].Wrd;
            Cells[ Indx ].LID := Cells[ Indx - 1 ].LID;
            Cells[ Indx ].Cod := Cells[ Indx - 1 ].Cod;
            Cells[ Indx ].Cla := Cells[ Indx - 1 ].Cla;
            Cells[ Indx ].Lem := Cells[ Indx - 1 ].Lem;
          end; // for

          // Search for modal prefix in a predefined list
          for Indx := 1 to NbPrefix do
          begin
            IsModal := IsModal or ( Morpho = cModalList[ Indx ] );
          end; // for

          // Define the cells of the current morphem
          if ( IsModal ) then
            Cells[ PosLine - 1 + NbMorpho ].Cod :=
              cWordShort[ wt_mod ] + Copy( MyDecl, 2, 4 )
          else
            Cells[ PosLine - 1 + NbMorpho ].Cod :=
              cWordShort[ wt_mor ] + Copy( MyDecl, 2, 4 );
          Cells[ PosLine + NbMorpho ].Cla := Cla;
          Cells[ PosLine + NbMorpho ].Lem := Lem;
          Cells[ PosLine + NbMorpho ].Wrd := Par;
          Inc( NbLine );
        until ( Length( Reste ) = 0 ); // repeat loop
        Cells[ PosLine + NbMorpho ].Cod := MyDecl;
      end;
    end else
    begin
      Cells[ PosLine ].LID := cMissingWord;
      Result := False;
    end;
  end; // if WordExists
end; // ________________________________________________________________NextWord

function           WordExists(
  Word:            String;
  var NbLoc:       Integer;
  var Loc:         tListInt )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WordExists
  * Search for a word case in Latin case dictionary *
  Description:
  This procedure scans all allowed forms of words in the different declensions
  in source Latin file in order to retrieve the present form of a word.<P>
  Multiple forms of one or many words may be found for a given request. They
  are all retrieved and sorted before being sent back to the caller.<P>
  The sort of the matching cases is based on the following criterias:
  1. Adjectives before nouns,
  2. Singular before plural,
  3. Nominative before genitive.
  The idea is to favour the more frequent solutions, when more than one
  solution could be accepted in an ambiguous term.<P>
  Actually, the scan is purely sequential and has to be optimized.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  LgtInit          = 20;
var
  Indx:            Integer;
  Indy:            Integer;
  Indz:            Integer;
  NbForm:          Integer;
  Count:           Integer;
  Lgt:             Integer;
  MyCod:           String;
  Codes:           Array of String;
  Locs:            tListInt;
  Indw:            tTCN;
begin

  // Loop on all Latin forms (linear search, not optimized)
  Lgt := LgtInit;
  NbForm := 0;
  Count := 0;
  SetLength( Locs, LgtInit );
  SetLength( Codes, LgtInit );
  for Indx := 0 to TotCas - 1 do
  begin
    if Word = Latin[ Indx ].Cas then
    begin
      Locs[ NbForm ] := Indx;
      MyCod := Latin[ Indx ].Cod;
      if Length( MyCod ) = 3 then
        MyCod := MyCod + 'ns';
      Codes[ NbForm ] := MyCod[ 1 ] + MyCod[ 4 ] + MyCod[ 5 ];
      if ( MyCod[ 1 ] = cWordShort[ wt_ppr ] ) or
         ( MyCod[ 1 ] = cWordShort[ wt_ord ] ) or
         ( MyCod[ 1 ] = cWordShort[ wt_mor ] ) or
         ( MyCod[ 1 ] = cWordShort[ wt_com ] ) or
         ( MyCod[ 1 ] = cWordShort[ wt_inv ] ) then
        Codes[ NbForm ] := cWordShort[ wt_adj ] + MyCod[ 4 ] + MyCod[ 5 ];
      NbForm := 1;

      // Sequential search for additional identical forms
      Indy := Indx + 1;
      if Indy < TotCas then
      begin
        while Latin[ Indy ].Cas = Word do
        begin
          Locs[ NbForm ] := Indy ;
          MyCod := Latin[ Indy ].Cod;
          Codes[ NbForm ] := MyCod[ 1 ] + MyCod[ 4 ] + MyCod[ 5 ];
          if ( MyCod[ 1 ] = cWordShort[ wt_ppr ] ) or
             ( MyCod[ 1 ] = cWordShort[ wt_ord ] ) or
             ( MyCod[ 1 ] = cWordShort[ wt_mor ] ) or
             ( MyCod[ 1 ] = cWordShort[ wt_com ] ) or
             ( MyCod[ 1 ] = cWordShort[ wt_inv ] ) then
            Codes[ NbForm ] := cWordShort[ wt_adj ] + MyCod[ 4 ] + MyCod[ 5 ];
          if Indy = TotCas - 1 then
            break;
          Inc( NbForm );
          if ( NbForm >= Lgt ) then
          begin
            Inc( Lgt, 5 );
            SetLength( Loc, Lgt );
            SetLength( Locs, Lgt );
            SetLength( Codes, Lgt );
          end;
          Inc( Indy );
        end; // while
      end;

      // Sort identical forms on adjective/noun, sing/plur, nominative/genitive
      Count := 0;
      SetLength( Loc, LgtInit );
      for Indw := tcn_ans to tcn_agp do
      begin
        for Indz  := 0 to NbForm - 1 do
        begin
          MyCod := Codes[ Indz ];
          if ( MyCod[ 1 ] = cWordShort[ wt_adj ] ) and
             ( Codes[ Indz ] = cTTCNValue[ Indw ] ) then
          begin
            Loc[ Count ] := Locs[ Indz ];
            Inc( Count );
          end;
        end; // for
      end;
      for Indw := tcn_sns to tcn_sgp do
      begin
        for Indz := 0 to NbForm - 1 do
        begin
          MyCod := Codes[ Indz ];
          if ( MyCod[ 1 ] = cWordShort[ wt_sub ] ) and
             ( Codes[ Indz ] = cTTCNValue[ Indw ] ) then
          begin
            Loc[ Count ] := Locs[ Indz ];
            Inc( Count );
          end;
        end; // for
      end; // for

      Break;
    end;
  end; // for
  SetLength( Loc, Count );
  NbLoc := Count;
  Result := Count > 0;
end; // ______________________________________________________________WordExists

function           GetState(
  Cod:             String )
  :                tTCN;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetState
  * Extract a state from a 5-digit coded value *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyCod:           String;
  Indx:            tTCN;
begin
  // Search for litteral state value (3-digit code)
  Result := tcn_nul;
  if ( Cod[ 1 ] = cWordShort[ wt_adj ] ) or
     ( Cod[ 1 ] = cWordShort[ wt_ppr ] ) or
     ( Cod[ 1 ] = cWordShort[ wt_inv ] ) or
     ( Cod[ 1 ] = cWordShort[ wt_ord ] ) then
    MyCod := cWordShort[ wt_adj ] + Cod[ 4 ] + Cod[ 5 ]
  else
    MyCod := cWordShort[ wt_sub ] + Cod[ 4 ] + Cod[ 5 ];

  // Retrieve the encoded state
  for Indx := Low( tTCN ) to High( tTCN ) do
  begin
    if ctTCNValue[ Indx ] = MyCod then
    begin
      Result := Indx;
      Break;
    end;
  end; // for
end; // ________________________________________________________________GetState

procedure          ReadLatinFile(
  FileName:        String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadLatinFile
  * Read the Latin case dictionary *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  AllocRec:        Integer;
  Posit:           Integer;
  Line:            String;
  Trans:           String;
  MyFile:          String;
  InFile:          TextFile;
begin
  // Open input file in text format, splitted or unsplitted
  TotCas := 0;
  AllocRec := 0;
  MyFile := FileName;
    AssignFile( Infile, MyFile );
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
        if TotCas >= AllocRec then
        begin
          Inc( AllocRec, 20 );
          SetLength( Latin, AllocRec );
        end;

        // Expected format is made of 7 fields:
        // LID¦Adj¦Pre¦Cas¦Cod¦Sub¦Cla
        with Latin[ TotCas ] do
        begin
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          LID := 0;
          if Length( Trans ) > 0 then
            LID := StrToInt( Trans );

          if ( LID = 7827 ) then
            LID := LID;

          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          Adj := 0;
          if Length( Trans ) > 0 then
            Adj := StrToInt( Trans );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          Pre := 0;
          if Length( Trans ) > 0 then
            Pre := StrToInt( Trans );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Cas := Copy( Line, 1, Posit - 1 ) ;
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Cod := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Length( Line ) );
          Posit := Pos( CurSep, Line );
          Sub := Copy( Line, 1, Posit - 1 );
          Cla := Copy( Line, Posit + 1, Length( Line ) );
        end; // with

        Inc( TotCas );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( Latin, TotCas );
end; // ___________________________________________________________ReadLatinFile

procedure          LatinDeclension(
  LID:             Integer;
  Erase:           Integer;
  var Declension:  String;
  var Cpt:         String  );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LatinDeclension
  * Retrieve full declension by LID *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Start:           Integer;
  MyInd:           Integer;
  MyCod:           String;
  Store:           Array[ 1 .. 4 ] of String;
begin
  // Loop on all 4 forms of declension: ns, gs, np, gp
  Start := 0;
  for Indx := 1 to 4 do
  begin

    // Loop on case dictionary
    for Indy := Start to TotCas - 1 do
    begin
      if LID = Latin[ Indy ].LID then
      begin
        if Indx = 1 then
          Cpt := Latin[ Indy ].Cla;
        MyCod := Latin[ Indy ].Cod;
        MyInd := 1;
        if Copy( MyCod, 4, 2 ) = 'ns' then
          MyInd := 1;
        if Copy( MyCod, 4, 2 ) = 'gs' then
          MyInd := 2;
        if Copy( MyCod, 4, 2 ) = 'np' then
          MyInd := 3;
        if Copy( MyCod, 4, 2 ) = 'gp' then
          MyInd := 4;
        Store[ MyInd ] := Copy( Latin[ Indy ].Cas, Erase + 1,
                          Length( Latin[ Indy ].Cas ) );
        Start := Indy + 1;
        Break;
      end;
    end; // for
  end; // for

  // Make the return string
  Declension := cEmpty;
  for Indx := 1 to 4 do
  begin
    if Indx > 1 then
      Declension := Declension + cSpace + cDash + cSpace;
    Declension := Declension + Store[ Indx ];
  end;
end; // _________________________________________________________LatinDeclension

procedure          DecodeDeclension(
  Decl:            String;
  var Decoded:     String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DecodeDeclension
  * Decode declension argument *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            tWordCateg;
  Indc:            tWordCase;
  Indg:            tWordGender;
  Indn:            tWordNumber;
  AWord:           String;
  ADecl:           String;
  ACase:           String;
  AGender:         String;
  ANumber:         String;
begin
  // Initialisation
  AWord := cEmpty;
  ADecl := cEmpty;
  ACase := cEmpty;
  AGender := cEmpty;
  ANumber := cEmpty;

  // Decode the word type
  for Indx := Low( tWordCateg ) to High( tWordCateg ) do
  begin
    if Decl[ 1 ] = cWordShort[ Indx ] then
    begin
      AWord := cWordDescr[ Indx ];
      Break;
    end;
  end; // for

  // Decode the declension
  Decoded := AWord;
  if ( Decl[ 1 ] <> cWordShort[ wt_mor ] ) and
     ( Decl[ 1 ] <> cWordShort[ wt_mod ] ) and
     ( Decl[ 1 ] <> cWordShort[ wt_inv ] ) then
  begin
    ADecl := cDeclension + cSpace + Decl[ 2 ];

    // Decode the case
    for Indc := Low( TWordCase ) to High( TWordCase ) do
    begin
      if Decl[ 4 ] = cCaseShort[ Indc ] then
      begin
        ACase := cCaseDescr[ Indc ];
        Break;
      end;
    end; // for

    // Decode the gender
    for Indg := Low( TWordGender ) to High( TWordGender ) do
    begin
      if Decl[ 3 ] = cGenderShort[ Indg ] then
      begin
        AGender := cGenderDescr[ Indg ];
        Break;
      end;
    end; // for

    // Decode the number
    for Indn := Low( TWordNumber ) to High( TWordNumber ) do
    begin
      if Decl[ 5 ] = cNumberShort[ Indn ] then
      begin
        ANumber := cNumberDescr[ Indn ];
        Break;
      end;
    end; // for

    // Build the result string
    Decoded := AWord + cComma + cSpace +
               ADecl + cComma + cSpace +
               ACase + cComma + cSpace +
               AGender + cComma + cSpace +
               ANumber;
  end;
end; // ________________________________________________________DecodeDeclension

function           MakeNode(
  Cpt:             String;
  Decl:            String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeNode
  * Make a node for conceptual graph *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := cSql + cSpace + Cpt + cSpace + cSqr;
end; // ________________________________________________________________MakeNode

function           MakeLink(
  Decl:            String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLink
  * Make a link for conceptual graph *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            tWordCateg;
  MyTerm:          String;
  MyType:          String;
begin
  // Special call for apposition of two nouns
  if Decl = 'appos' then
  begin
    MyTerm := 'App';
  end else

  // Regular call
  begin
    MyType := Decl[ 1 ];
    for Indx := Low( TWordCateg ) to High( TWordCateg ) do
    begin
      if MyType = cWordShort[ Indx ] then
      begin
        MyTerm := cLinkDescr[ Indx ];
        Break;
      end;
    end;
  end;

  // Return formatted value
  Result := cDash + cAnr + cSpace + cRol + cSpace + MyTerm +
            cSpace + cRor + cSpace + cDash + cAnr;
end; // ________________________________________________________________MakeLink

function           TypeGender(
  WordType:        String;
  Gender:          String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TypeGender
  * Explicite text for type of word and gender *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            tWordCateg;
  Indg:            tWordGender;
  Word:            String;
  Gdr:             String;
begin
  // Decode type of word
  Word := cEmpty;
  for Indx := Low( tWordCateg ) to High( tWordCateg ) do
  begin
    if WordType = cWordShort[ Indx ] then
    begin
      Word := cWordDescr[ Indx ];
      Break;
    end;
  end;

  // Decode gender
  Gdr := cEmpty;
  for Indg := Low( tWordGender ) to High( tWordGender ) do
  begin
    if Gender = cGenderShort[ Indg ] then
    begin
      Gdr := cGenderDescr[ Indg ];
      Break;
    end;
  end;

  // Return result
  if WordType = cWordShort[ wt_mor ] then
    Result := Word
  else
    Result := Gdr + cSpace + Word;
end; // ______________________________________________________________TypeGender

procedure          MakeSingleLACase(
  LID:             Integer;
  Decl:            String;
  var AWord:       String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSingleLACase
  * Generate a single case in the Latin declension *
  Description:
  Each entry with of the case dictionary a specific LID is present 4 times:
  at nominative singular, genitive singular, nominative plural and genitive
  plural; there is one entry for all words except adjectives with 3 entries,
  one for each gender.</p>
  Currently, sequential search on the Latin case file of nearly 28000 items !!!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  Posit:           Integer;
  MyCod:           String;
  MySub:           String;
begin

  // Loop on case dictionary, search for the specified LID
  for Indy := 0 to TotCas - 1 do
  begin
    if ( LID = Latin[ Indy ].LID ) then
    begin

      // Search for the specified declension
      MyCod := Latin[ Indy ].Cod;
      if ( Copy( MyCod, 4, 2 ) = Decl ) then
      begin

        // Extract the word and terminate the search
        AWord := Latin[ Indy ].Cas;
        Posit := Pos( cSemi, Latin[ Indy ].Sub );
        if ( Posit > 0 ) then
        begin
          AWord := Copy( AWord, Posit, Length( Latin[ Indy ].Sub ) );
          MySub :=
            Copy( Latin[ Indy ].Sub, Posit + 1, Length( Latin[ Indy ].Sub ) );
          Posit := Pos( cSemi, MySub );
          if ( Posit > 0 ) then
            AWord := Copy( AWord, Posit, Length( Latin[ Indy ].Sub ) );
        end;
        Break;
      end;
    end;
  end; // for on all Latin cases
end; // ________________________________________________________MakeSingleLACase

function           GetPositionByLID(
  MyLID:           Integer;
  MyCase:          String )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetPositionByLID
  * Retrieve the position of a Latin entry by LID *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  Result := -1;
  for Indx := 0 to TotCas - 1 do
  begin
    if ( Latin[ Indx ].LID = MyLID ) and
       ( Copy( Latin[ Indx ].Cod, 3, 3 ) = MyCase ) then
    begin
      Result := Indx;
      Break;
    end;
  end; // for
end; // ________________________________________________________GetPositionByLID

constructor        tLatinTerm.Create(
  Nominative:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create/1
  * Variant of constructor of a Latin term *
  Description:
  This constructor sets the value of the nominative property.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.Language := lt_Latin;
  inherited Create( Nominative );
end; // ________________________________________________________________Create/1

constructor        tLatinTerm.CreateAdj(
  Nominative:      String;
  Dummy:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CreateAdj
  * Variant of constructor of a Latin term as an adjective *
  Description:
  This constructor sets the value of the nominative property and forces the
  first word of the term to be an adjective.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.Language := lt_Latin;
  Self.IsAdj := True;
  inherited Create( Nominative );
end; // _______________________________________________________________CreateAdj

function           tLatinTerm.FemAdjectiveLA(
  AWord:           String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FemAdjectiveLA
  * Define a feminine adjective from its lem *
  Description:
  This method first applies the list of exceptions and if none is found applies
  the list of rules for feminine adjectives. The input value is supposed to
  be an adjective in masculine singular form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Len:             Integer;
  Termin:          String;
begin
  Result := AWord;

  // Apply the exceptions for feminine adjectives
  for Indx := 1 to NbFemAdjExcept do
  begin
    if ( cFemAdjExcept[ Indx, 1 ] = AWord ) then
    begin
      Result := cFemAdjExcept[ Indx, 2 ];
      Exit;
    end;
  end;

  // Apply the rules for feminine adjectives
  for Indx := 1 to NbFemAdj do
  begin
    Len := Length( cFemAdj[ Indx, 1 ] );
    Termin := Copy( AWord, Length( AWord ) - Len + 1, Len );
    if ( cFemAdj[ Indx, 1 ] = Termin ) then
    begin
      Result := Copy( AWord, 1, Length( AWord ) - Len ) + cFemAdj[ Indx, 2 ];
      Exit;
    end;
  end;
end; // __________________________________________________________FemAdjectiveLA

function           tLatinTerm.NeuAdjectiveLA(
  AWord:           String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NeuAdjectiveLA
  * Define a neuter adjective from its lem *
  Description:
  This method first applies the list of exceptions and if none is found applies
  the list of rules for neuter adjectives. The input value is supposed to
  be an adjective in masculine singular form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Len:             Integer;
  Termin:          String;
begin
  Result := AWord;

  // Apply the exceptions for feminine adjectives
  for Indx := 1 to NbNeuAdjExcept do
  begin
    if ( cNeuAdjExcept[ Indx, 1 ] = AWord ) then
    begin
      Result := cNeuAdjExcept[ Indx, 2 ];
      Exit;
    end;
  end;

  // Apply the rules for feminine adjectives
  for Indx := 1 to NbNeuAdj do
  begin
    Len := Length( cNeuAdj[ Indx, 1 ] );
    Termin := Copy( AWord, Length( AWord ) - Len + 1, Len );
    if ( cNeuAdj[ Indx, 1 ] = Termin ) then
    begin
      Result := Copy( AWord, 1, Length( AWord ) - Len ) + cNeuAdj[ Indx, 2 ];
      Exit;
    end;
  end;
end; // __________________________________________________________NeuAdjectiveLA

procedure          tLatinTerm.SetNominativeLA(
  Value:           String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNominativeLA
  * Action when entering a new value for Nominative property *
  Description:
  This method enters a new value for the property Nominative and reset the
  properties of this object.</P>
  In addition, the term is syntactically analyzed using the Latin dictionary
  and the result is stored for further needs.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Analyze the term
  Self.ProcessATerm;
end; // _________________________________________________________SetNominativeLA

procedure          tLatinTerm.SetFormulaLA;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormulaLA
  * Extraction of the Latin term from its universal formula *
  Description:
  The formula represent only the basic part of the term. This methods builds
  a new nominative term in Latin language from the universal formula.</P>
  The order of the contributions in the formula is the natural order for the
  Latin language. No adjustment is necessary.</P>
  A global loop scans the formula and handle every single contributions in
  turn, preparing the term at nominative form.</P>
  In a first step, the Unit identifier of the lexical entity corresponding to
  the contribution is extracted. From this UID, the lexical entity is
  retrieved, supposed to be not null.</P>
  In a second step, the vocabulary item is extracted from the lexical entity
  and is subject to a proper treatment.</p>
  After all extractions, a final treatement is necessary to adjust the gender
  of adjectives in concordance with the main noun of the term.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Posit:           Integer;
  UID:             Integer;
  LID:             Integer;
  NbList:          Integer;
  Plus:            Integer;
  PosList:         Integer;
  MyFormula:       String;
  MyPart:          String;
  MyType:          String;
  GenWord:         String;
  MyWord:          String;
  MyCode:          String;
  NounGender:      String;
  LexUnit:         tUnit;
  LexEntity:       tEntity;
  ANode:           WordAnal;
  Truc:            WordAnal;
  ListInt:         tListInt;
  MyLex:           tLexType;
begin

  // Loop on all contributions of the formula
  NounGender := 'm';
  MyFormula := Self.Formula;
  Indx := 0;
  repeat

    // Extract the next single contribution from the formula
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

    // Retrieve the Unit identifier of the contributing lexical entity
    Posit := Pos( cRol, MyPart );
    UID := 0;
    MyLex := lx_Undef;
    if ( Posit > 0 ) then
    begin
      MyType := Copy( MyPart, 1, Posit - 1 );
      MyLex := LexOf( MyType );
      MyPart := Copy( Mypart, Posit + 1, Length( MyPart ) );
      Posit := Pos( cRor, MyPart );
      if ( Posit > 0 ) then
      begin
        MyPart := Copy( Mypart, 1, Posit - 1 );
        if ( Length( MyPart ) > 0 ) then
          UID := StrToInt( MyPart );
      end;
    end;

    // Retrieve the lexical entry (may be accidentally nil!)
    LexEntity := nil;
    if ( UID > 0 ) then
    begin
      LexUnit := TAH.GetUnitByPos( UID );
      if ( LexUnit <> nil ) then
        LexEntity := TAH.GetEntityByPos( LexUnit.Generator );
    end;

    // Retrieve and dispatch the contributions
    if ( LexEntity <> nil ) then
    begin
      case MyLex of

      // Handling of a noun
      lx_Noun:
        begin
          MyWord := LexEntity.GetVocabulary( lt_Latin, st_Nou );
          MyCode := 'nxxxx';
        end;

      // Retrieval of a noun complement
      lx_Compl:
        begin
          MyWord := LexEntity.GetVocabulary( lt_Latin, st_Nou );
          MyCode := 'nxxxx';
        end;

      // Retrieval of an adjective
      lx_Adj:
        begin
          MyWord := LexEntity.GetVocabulary( lt_Latin, st_Adj );
          MyCode := 'axxxx'
        end;

      // Retrieval of a prefix
      lx_Pref:
        begin
          MyWord := LexEntity.GetVocabulary( lt_Latin, st_Pre );
          MyCode := 'pxxxx';
        end;

      // Retrieval of an invariant
      lx_Invar:
        begin
          MyWord := LexEntity.GetVocabulary( lt_Latin, st_Inv );
          MyCode := 'ixxxx';
        end;

      // Retrieval of an apposition
      lx_Appos:
        begin
          MyWord := LexEntity.GetVocabulary( lt_Latin, st_Nou );
          if ( MyWord = cEmpty ) then
          begin
            MyWord := LexEntity.GetVocabulary( lt_Latin, st_Adj );
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
          MyCode := 'ixxxx';
        end;
      end; // case on all lexical types of the contributions

      // Management of the found vocabulary
      Truc := Self.Node[ Indx ];
      ANode := Truc;
      ANode.Cod := MyCode;
      if ( MyWord <> cEmpty ) then
      begin
        Self.NbWord := Indx + 1;

        // Management of a noun complement
        if ( MyType = 'C' ) then
        begin
          NbList := 0;
          if ( (WordExists( MyWord, NbList, ListInt ) ) and
               ( NbList > 0 ) ) then
          begin
            LID := Latin[ ListInt[ 0 ] ].LID;
            MakeSingleLACase( LID, 'gs', GenWord );
            ANode.Lem := GenWord;
            ANode.Cod := Copy( Latin[ ListInt[ 0 ] ].Cod, 1, 3 ) + 'gs';
          end else
            ANode.Lem := MyWord;
        end else

        // Management of an adjective: find the expected gender
        if ( MyType = 'A' ) then
        begin
          NbList := 0;
          if ( (WordExists( MyWord, NbList, ListInt ) ) and
               ( NbList > 0 ) ) then
          begin
            Plus := 0;
            if ( NounGender = 'f' ) then
              Plus := 1
            else
            if ( NounGender = 'n' ) then
              Plus := 2;
            PosList := 0;
            for Indy := 0 to NbList do
            begin
              if ( Copy( Latin[ ListInt[ Indy ] ].Cod, 3, 3 ) = 'mns' ) then
              begin
                PosList := Indy;
                Break;
              end;
            end; // for
            LID := Latin[ ListInt[ PosList ] ].LID + Plus;
            MakeSingleLACase( LID, 'ns', GenWord );
            ANode.Lem := GenWord;
            ANode.Cod := 'a' + Latin[ ListInt[ PosList ] + Plus ].Cod[ 2 ] +
                         NounGender + 'ns';
          end else
            ANode.Lem := MyWord;
        end else

        // Management of a noun
        if ( MyType = 'N' ) then
        begin
          NbList := 0;
          if ( ( WordExists( MyWord, NbList, ListInt ) ) and
               ( NbList > 0 ) ) then
          begin
            LID := Latin[ ListInt[ 0 ] ].LID;
            if ( Latin[ ListInt[ 0 ] ].Cod[ 1 ] <> 'n' ) then
              NounGender := Latin[ ListInt[ 1 ] ].Cod[ 3 ]
            else
              NounGender := Latin[ ListInt[ 0 ] ].Cod[ 3 ]
          end;
          ANode.Lem := MyWord;
        end else

        // Management of a prefix
          ANode.Lem := MyWord;
        ANode.LID := IntToStr( LID );
        Self.Node[ Indx ] := ANode;
      end else

      // Non existent vocabulary (empty contribution)
      begin
        ANode.Lem := LexEntity.InternalTex;
        Self.Node[ Indx ] := ANode;
      end;
    end;

    // Move to the next contribution of the formula
    Inc( Indx );
  until ( MyFormula = cEmpty ); // on all contributions of a formula

  // Validate the term
  Self.GenderLA;
end; // ____________________________________________________________SetFormulaLA

function           tLatinTerm.GenderLA
  :                tGender;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GenderLA
  * Search for gender of the nominative noun of a term in Latin *
  Description:
  This procedure handles a Latin nominative singular term and determines
  its gender, using the Latin case dictionary.</P>
  Usually a Latin terms start with a noun and is followed by a variable number
  of adjectives. The gender of adjectives is adjusted to the gender of the
  noun.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbList:          Integer;
  NbWord:          Integer;
  PosNom:          Integer;
  MyNoun:          String;
  MyAdj:           String;
  MyCode:          String;
  GenAdj:          String;
  MyNode:          WordAnal;
  MyList:          tListInt;
  MyLatinRec:      LatinRec;
begin

  // Retrieve the first word that must be a noun at nominative singular (skip
  // one or two initial prefixes)
  MyNode := Self.Node[ 0 ];
  PosNom := 0;
  if ( ( MyNode.Cod <> cEmpty ) and ( MyNode.Cod[ 1 ] = 'p' ) ) then
  begin
    MyNode := Self.Node[ 1 ];
    PosNom := 1;
    if ( ( MyNode.Cod <> cEmpty ) and ( MyNode.Cod[ 1 ] = 'p' ) ) then
    begin
      MyNode := Self.Node[ 2 ];
      PosNom := 2;
    end;
  end;
  MyNoun := MyNode.Lem;
  MyCode := 'xxx';
  Result := ge_unspec;

  // Retrieve the first noun and its gender
  if ( WordExists( MyNoun, NbList, MyList ) ) then
  begin
    for Indx := 0 to NbList - 1 do
    begin
      if ( Latin[ MyList[ Indx ] ].Cod[ 1 ] = 'n') then
      begin
        MyLatinRec := Latin[ MyList[ Indx ] ];
        Break;
      end;
    end;
    MyCode := Copy( MyLatinRec.Cod, 3, 3 );
    MyNode.Cod := MyLatinRec.Cod;
    Self.Node[ PosNom ] := MyNode;
  end;

  // Adjust all present adjectives to the gender of the noun
  NbWord := Self.NbWord;
  if ( MyCode = cEmpty ) then
    Exit;
  for Indx := PosNom + 1 to NbWord - 1 do
  begin
    MyNode := Self.Node[ Indx ];
    if ( ( MyNode.Cod <> cEmpty ) and ( MyNode.Cod[ 1 ] <> 'a' ) or
         ( MyNode.Cod = cEmpty ) ) then
      Continue;
    MyAdj := MyNode.Lem;
    if ( MyCode[ 1 ] = 'f' ) then
    begin
      GenAdj := FemAdjectiveLA( MyAdj );
      Result := ge_feminine;
    end else
    if ( MyCode[ 1 ] = 'n' ) then
    begin
      GenAdj := NeuAdjectiveLA( MyAdj );
      Result := ge_neuter;
    end else
    if ( MyCode[ 1 ] = 'm' ) then
    begin
      GenAdj := MyAdj;
      Result := ge_masculine;
    end;
    MyNode.Lem := GenAdj;
    MyNode.Cod := 'ax' + MyCode;
    Self.Node[ Indx ] := MyNode;
  end; // for on all adjectives
end; // ________________________________________________________________GenderLA

procedure          tLatinTerm.SetGenderLA(
  MyGender:        tWordGender );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetGenderLA
  * Set the gender of an adjective Latin term *
  Description:
  This methods sets the gender of an adjective term at nominative. It is
  presently limited to a single adjective.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  LID:             Integer;
  Posit:           Integer;
  ActualNode:      Integer;
  MyDecl:          String;
  Cpt:             String;
  MyCode:          String;
  MyWrd:           String;
  MyNode:          WordAnal;
  ActualGender:    tWordGender;
begin

  // Do nothing if not an adjective or not nominative
  MyNode := Self.Node[ 0 ];
  MyCode := MyNode.Cod;
  ActualNode := 0;
  if ( MyCode = cEmpty ) then
    Exit;
  if ( ( MyCode[ 1 ] <> 'a' ) and ( MyCode[ 1 ] <> 'o' ) ) then
  begin
    if ( MyCode[ 1 ] = 'm' ) then
    begin
      MyNode := Self.Node[ 1 ];
      MyCode := MyNode.Cod;
      ActualNode := 1;
      if ( ( MyCode[ 1 ] <> 'a' ) and ( MyCode[ 1 ] <> 'o' ) ) then
        Exit;
    end;
  end;
  if ( MyCode[ 4 ] <> 'n' ) then
    Exit;

  // Set the actual gender
  ActualGender := gd_mas;
  case ( MyCode[ 3 ] ) of
    'm': ActualGender := gd_mas;
    'f': ActualGender := gd_fem;
    'n': ActualGender := gd_neu;
  end;

  // Rebuild the node with the specified gender
  LID := StrToInt( MyNode.LID ) + Integer( MyGender ) - Integer( ActualGender );
  LatinDeclension( LID, 0, MyDecl, Cpt );
  Posit := Pos( cDash, MyDecl );
  MyWrd := Copy( MyDecl, 1, Posit - 2 );
  MyNode.Wrd := MyWrd;
  MyNode.LID := IntToStr( LID );
  MyNode.Cod := Copy( MyCode, 1, 2 ) + cGenderShort[ MyGender ] +
                Copy( MyCode, 4, 2 );
  Self.Nominative := MyWrd;
  Self.Node[ ActualNode ] := MyNode;
end; // _____________________________________________________________SetGenderLA

function           tLatinTerm.GetGenderLA()
  :                tWordGender;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetGenderLA
  * Retrieve the gender of first word in a term *
  Description:
  This function check the declension argument of the first word of the term,
  then it extracts the gender.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyNode:          WordAnal;
  MyCode:          String;
begin
  MyNode := Self.Node[ 0 ];
  MyCode := MyNode.Cod;
  if ( ( MyCode[ 1 ] = 'h' ) or ( MyCode[ 1 ] = 's' ) ) then
  begin
    MyNode := Self.Node[ 1 ];
    MyCode := MyNode.Cod;
  end;

  // Retrieve gender
  Result := gd_mas;
  if ( MyCode[ 3 ] = 'f' ) then
    Result := gd_fem
  else
  if ( MyCode[ 3 ] = 'n' ) then
    Result := gd_neu;
end; // _____________________________________________________________GetGenderLA

function           tLatinTerm.MakeGenitiveLA()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenitiveLA
  * Construction of a genitive singular Latin term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbAnal:          Integer;
  IsPrefix:        Boolean;
  IsNom:           Boolean;
  Decl:            String;
  NewTerm:         String;
  GenWord:         String;
  MyCell:          WordAnal;
begin

  // Loop on all words to generate the genitive form
  // NewTerm := Self.Nominative;
  // Self.Nominative := NewTerm;
  if ( Self.IsRegular ) then
  begin
    Decl := 'gs';
    NewTerm := cEmpty;
    IsPrefix := False;
    NbAnal := Self.NbWord;
    for Indx := 0 to NbAnal - 1 do
    begin

      // Discard the place holders
      if ( ( Self.Node[ Indx ].Cod[ 1 ] = 'h' ) or
           ( Self.Node[ Indx ].Cod[ 1 ] = 's' ) ) then
      begin
        MyCell := Self.Node[ Indx ];
        MyCell.Cod := Copy( MyCell.Cod, 1, 3 ) + 'g' + Copy( MyCell.Cod, 5, 1 );
        Self.NodeGS[ Indx ] := MyCell;
        Continue;
      end;

      // Check for prefixes
      if ( ( Self.Node[ Indx ].Cod[ 1 ] = 'm' ) or
           ( Self.Node[ Indx ].Cod[ 1 ] = 'k' ) or
           ( Self.Node[ Indx ].Cod[ 1 ] = 'p' ) ) then
      begin
        if ( not IsPrefix ) then
          NewTerm := NewTerm + cSpace;
        NewTerm := NewTerm + Self.Node[ Indx ].Lem;
        Self.NodeGS[ Indx ] := Self.Node[ Indx ];
        IsPrefix := True;
        Continue;
      end;

      // Handling of nominative part
      IsNom := ( Self.Node[ Indx ].Cod[ 4 ] = 'n' );
      if ( IsNom ) then
      begin
        MakeSingleLACase( StrToInt( Self.Node[ Indx ].LID ), Decl, GenWord );
        if ( not IsPrefix ) then
          NewTerm := NewTerm + cSpace;
        NewTerm := NewTerm + GenWord;
        MyCell.Cod := Copy( Self.Node[ Indx ].Cod, 1, 3 ) + 'g' +
                      Copy( Self.Node[ Indx ].Cod, 5, 1 );
        MyCell.Lem := GenWord;
        MyCell.LID := Self.Node[ Indx ].LID;
        Self.NodeGS[ Indx ] := MyCell;
      end else

      // Handling of genitive part
      begin
        if ( not IsPrefix ) then
          NewTerm := NewTerm + cSpace;
        NewTerm := NewTerm + Self.Node[ Indx ].Wrd;
        Self.NodeGS[ Indx ] := Self.Node[ Indx ];
      end;
      IsPrefix := False;
    end; // for
  end;
  Result := Trim( NewTerm );
end; // __________________________________________________________MakeGenitiveLA

function           tLatinTerm.MakePluralLA(
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralLA
  * Construction of a plural nominative Latin term *
  Description:
  This function makes plural the nominative part of a Latin term and left as it
  is any possible other parts like a genitive. Only regular terms are
  processed.</p>
  The initial term is scanned from left to right.
  - If the word is a prefix, it is left unchanged;
  - If not a prefix:
    - If the word is at nominative, it is transformed to plural by consultation
      of the Latin case dictionary;
    - If the word is not at nominative, it is left unchanged.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbAnal:          Integer;
  Plus:            Integer;
  IsPrefix:        Boolean;
  IsNom:           Boolean;
  Decl:            String;
  NewTerm:         String;
  GenWord:         String;
  MyNodeType:      char;
  Gender:          tWordGender;
begin

  // Loop on all words to generate the plural form
  NewTerm := Self.Nominative;
  if ( Self.IsRegular ) then
  begin
    Gender := Self.GetGenderLA;
    Decl := 'np';
    NewTerm := cEmpty;
    IsPrefix := False;
    NbAnal := Self.NbWord;
    for Indx := 0 to NbAnal - 1 do
    begin
      MyNodeType := Self.Node[ Indx ].Cod[ 1 ];

      // Check for prefixes
      if ( ( MyNodeType = 'm' ) or
           ( MyNodeType = 'k' ) or
           ( MyNodeType = 'p' ) ) then
      begin
        if ( not IsPrefix ) then
          NewTerm := NewTerm + cSpace;
        NewTerm := NewTerm + Self.Node[ Indx ].Lem;
        IsPrefix := True;
        Continue;
      end else

      // Skip lateral adjectives
      if ( ( MyNodeType = 'h' ) or ( MyNodeType = 's' ) ) then
      begin
        Continue
      end else

      // Ckeck other words
      begin

        // Nominative part becomes plural
        IsNom := ( Self.Node[ Indx ].Cod[ 4 ] = 'n' );
        if ( IsNom ) then
        begin
          Plus := 0;
          if ( MyNodeType = 'a' ) then
          begin
            if ( Gender = gd_fem ) then
              Plus := 1
            else
            if ( Gender = gd_neu ) then
              Plus := 2;
          end;
          MakeSingleLACase( StrToInt( Self.Node[ Indx ].LID ) + Plus,
                            Decl, GenWord );
          if ( not IsPrefix ) then
            NewTerm := NewTerm + cSpace;
          NewTerm := NewTerm + GenWord;
        end else

        // Genitive part remains unchanged
        begin
          if ( not IsPrefix ) then
            NewTerm := NewTerm + cSpace;
          NewTerm := NewTerm + Self.Node[ Indx ].Lem;
        end;
      end;
      IsPrefix := False;
    end; // for on all words of a term
  end;
  Result := Trim( NewTerm );
end; // ____________________________________________________________MakePluralLA

function           tLatinTerm.MakeGenPluralLA()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenPluralLA
  * Construction of a genitive plural Latin term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbAnal:          Integer;
  IsPrefix:        Boolean;
  IsNom:           Boolean;
  Nominative:      String;
  Decl:            String;
  NewTerm:         String;
  GenWord:         String;
begin

  // Loop on all words to generate the genitive form
  NewTerm := Nominative;
  if ( Self.IsRegular ) then
  begin
    Decl := 'gp';
    NewTerm := cEmpty;
    NbAnal := Self.NbWord;
    IsPrefix := False;
    for Indx := 0 to NbAnal - 1 do
    begin

      // Check for prefixes
      if ( ( Self.Node[ Indx ].Cod[ 1 ] = 'm' ) or
           ( Self.Node[ Indx ].Cod[ 1 ] = 'k' ) ) then
      begin
        GenWord := Self.Node[ Indx ].Wrd;
        if ( not IsPrefix ) then
          NewTerm := NewTerm + cSpace;
        NewTerm := NewTerm + GenWord;
        IsPrefix := True;
        Continue;
      end else

      // Define the next word
      begin
        IsNom := ( Self.Node[ Indx ].Cod[ 4 ] = 'n' );
        if ( IsNom ) then
          MakeSingleLACase( StrToInt( Self.Node[ Indx ].LID ), Decl, GenWord )
        else
          GenWord := Self.Node[ Indx ].Wrd;
      end;

      // Handling of genitive part
      if ( not IsPrefix ) then
        NewTerm := NewTerm + cSpace;
      NewTerm := NewTerm + GenWord;
      IsPrefix := False;
    end; // for
  end;
  Result := NewTerm;
end; // _________________________________________________________MakeGenPluralLA

function           tLatinTerm.MakeLateralLA(
  IsShort:         Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLateralLA
  * Construction of a lateral Latin term *
  Description:
  This method builds a lateral nominative term by addition of the adequate
  lateral adjective to the nominative term. Two situations are possible
  according to the IsShort parameter: standard placeholeder ans short
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
  IsPrefix:        Boolean;  // flag for presence of a prefix
  LatValue:        String;   // value for lateral adjective
  NewTerm:         String;   // reconstructed term with laterality
  Argument:        String;   // 3-letter syntax argument: gender, case, number
  Later:           tLink;    // side value
  MySyntax:        tLatType; // syntax value, received or computed
  MyCell:          WordAnal; // local transitory node
  CompType:        Char;     // type of component
begin

  // Get the syntax of lateral value from the short placeholder
  NbAnal := Self.NbWord;
  if ( IsShort ) then
  begin
    MySyntax := lt_undef;
    for Indx := 0 to NbAnal - 1 do
    begin
      if ( Self.Node[ Indx ].Cod[ 1 ] = 's' ) then
      begin
        Argument := Copy( Self.Node[ Indx ].Cod, 3, 3 );
        MySyntax := SyntaxOf( Argument );
        Break;
      end;
    end;
  end else

  // Get the syntax of lateral value from the standard placeholder
  begin
    MySyntax := lt_undef;
    for Indx := 0 to NbAnal - 1 do
    begin
      if ( Self.Node[ Indx ].Cod[ 1 ] = 'h' ) then
      begin
        Argument := Copy( Self.Node[ Indx ].Cod, 3, 5 );
        MySyntax := SyntaxOf( Argument );
        Break;
      end;
    end;
  end;
  if ( MySyntax = lt_undef ) then
    Exit;

  // Define the laterality value
  LatValue := cEmpty;
  Later := Self.Side;
  if ( Later in [ pw_MemberR, pw_SMemberR, pw_IMemberR,  pw_TMemberR ] ) then
    LatValue := cLatDex[ MySyntax ]
  else
  if ( Later in [ pw_MemberL, pw_SMemberL, pw_IMemberL,  pw_TMemberL ] ) then
    LatValue := cLatSin[ MySyntax ];

  // Loop on all words
  NewTerm := cEmpty;
  IsPrefix := False;
  for Indx := 0 to NbAnal - 1 do
  begin
    CompType := Self.Node[ Indx ].Cod[ 1 ];
    if ( ( Self.Node[ Indx ].Cod[ 4 ] = 'g' ) and ( IsShort ) ) then
      Break;

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
    if ( ( ( CompType = 'h' ) and ( not IsShort ) ) or
         ( ( CompType = 's' ) and ( IsShort ) ) ) then
    begin
      NewTerm := NewTerm + cSpace + LatValue;
      MyCell := Self.Node[ Indx ];
      MyCell.Cod[ 1 ] := 'a';
      MyCell.Lem := LatValue;
      Self.Node[ Indx ] := MyCell;
    end else

    // Append each word to the new term
    if ( ( CompType <> 's' ) and ( CompType <> 'h' ) ) then
    begin
      if ( not IsPrefix ) then
        NewTerm := NewTerm + cSpace
      else
        IsPrefix := False;
      NewTerm := NewTerm + Self.Node[ Indx ].Lem;
    end;
  end; // for on all words of the initial term
  Result := Trim( NewTerm );
  Self.Nominative := Result;
end; // ___________________________________________________________MakeLateralLA

function           tLatinTerm.MakeLatPluralLA
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLatPluralLA
  * Construction of a lateral plural Latin term *
  Description:
  This method builds a lateral plural nominative term by addition of the
  adequate lateral adjective at its correct position. Each word of the
  initial singular term is examined: a nominative noun or adjective is
  changed to nominative plural.</P>
  To do that, two properties are used: the WordPos specifying the position
  of the lateral adjective and the WordType specifying the form of the
  adjective. WordPos is computed without taking into account the prefixes.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;  // index on components of the term
  NbAnal:          Integer;  // number of components of the term
  IsPrefix:        Boolean;  // flag for presence of a prefix
  LatValue:        String;
  NewTerm:         String;
  MyWord:          String;
  Argument:        String;   // 3-letter syntax argument: gender, case, number
  Later:           tLink;
  MyCell:          WordAnal; // local transitory node
  MySyntax:        tLatType; // syntax value, received or computed
  CompType:        Char;     // type of component
begin

  // Get the syntax of lateral value from placeholder
  MySyntax := lt_undef;
  NbAnal := Self.NbWord;
  for Indx := 0 to NbAnal - 1 do
  begin
    if ( Self.Node[ Indx ].Cod[ 1 ] = 'h' ) then
    begin
      Argument := Copy( Self.Node[ Indx ].Cod, 3, 5 );
      MySyntax := SyntaxOf( Argument );
      Break;
    end;
  end;
  if ( MySyntax = lt_undef ) then
    Exit;

  // Search for applicable laterality value
  LatValue := cEmpty;
  Later := Self.Side;
  if ( ( Later = pw_MemberR ) or
       ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or
       ( Later = pw_TMemberR ) ) then
    LatValue := cLatDex[ MySyntax ]
  else
  if ( ( Later = pw_MemberL ) or
       ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or
       ( Later = pw_TMemberL ) ) then
    LatValue := cLatSin[ MySyntax ];

  // Loop on all words of the term
  NewTerm := cEmpty;
  IsPrefix := False;
  NbAnal := Self.NbWord;
  for Indx := 0 to NbAnal - 1 do
  begin
    CompType := Self.Node[ Indx ].Cod[ 1 ];

    // Check for prefixes
    if ( ( CompType = 'm' ) or ( CompType = 'k' ) or ( CompType = 'p' ) ) then
    begin
      if ( not IsPrefix ) then
        NewTerm := NewTerm + cSpace;
      NewTerm := NewTerm + Self.Node[ Indx ].Lem;
      IsPrefix := True;
      Continue;
    end else

    // Change nominative word to plural
    if ( ( CompType = 'n' ) or ( CompType = 'a' ) ) then
    begin
      if ( Self.Node[ Indx ].Cod[ 4 ] = 'n' ) then
        MakeSingleLACase( StrToInt( Self.Node[ Indx ].LID ), 'np', MyWord )
      else
        MyWord := Self.Node[ Indx ].Lem;

      // Append each word
      if ( not IsPrefix ) then
        NewTerm := NewTerm + cSpace
      else
        IsPrefix := False;
      NewTerm := NewTerm + MyWord;
    end else

    // Append the laterality value in the placeholder
    if ( CompType = 'h' ) then
    begin
      NewTerm := NewTerm + cSpace + LatValue;
      MyCell := Self.Node[ Indx ];
      MyCell.Cod[ 1 ] := 'a';
      MyCell.Lem := LatValue;
      Self.Node[ Indx ] := MyCell;
    end;
  end; // for on all words of the term
  Result := Trim( NewTerm );
end; // _________________________________________________________MakeLatPluralLA

function           tLatinTerm.MakeGenLatPluralLA
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenLatPluralLA
  * Construction of a genitive lateral plural Latin term *
  Description:
  This method builds a lateral plural genitive term by addition of the
  adequate lateral adjective at its correct position. Each word of the
  initial singular term is examined: a nominative noun or adjective is
  changed to genitive plural.</P>
  To do that, two properties are used: the WordPos specifying the position
  of the lateral adjective and the WordType specifying the form of the
  adjective. WordPos is computed without taking into account the prefixes.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbAnal:          Integer;
  IsPrefix:        Boolean;
  LatValue:        String;
  NewTerm:         String;
  MyWord:          String;
  Later:           tLink;
  MyLatType:       tLatType;
begin

  // Search for applicable laterality value
  LatValue := cEmpty;
  Later := Self.Side;
  MyLatType := Succ( Succ( Succ( Self.WordType ) ) );
  if ( ( Later = pw_MemberR ) or
       ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or
       ( Later = pw_TMemberR ) ) then
    LatValue := cLatDex[ MyLatType ]
  else
  if ( ( Later = pw_MemberL ) or
       ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or
       ( Later = pw_TMemberL ) ) then
    LatValue := cLatSin[ MyLatType ];

  // Loop on all words of the term
  NewTerm := cEmpty;
  IsPrefix := False;
  NbAnal := Self.NbWord;
  for Indx := 0 to NbAnal - 1 do
  begin

    // Check for prefixes
    if ( ( Self.Node[ Indx ].Cod[ 1 ] = 'm' ) or
         ( Self.Node[ Indx ].Cod[ 1 ] = 'k' ) ) then
    begin
      if ( not IsPrefix ) then
        NewTerm := NewTerm + cSpace;
      NewTerm := NewTerm + Self.Node[ Indx ].Wrd;
      IsPrefix := True;
      Continue;
    end;

    // Change nominative word to genitive plural
    if ( Self.Node[ Indx ].Cod[ 4 ] = 'n' ) then
      MakeSingleLACase( StrToInt( Self.Node[ Indx ].LID ), 'gp', MyWord )
    else
      MyWord := Self.Node[ Indx ].Wrd;

    // Append each word
    if ( not IsPrefix ) then
      NewTerm := NewTerm + cSpace
    else
      IsPrefix := False;
    NewTerm := NewTerm + MyWord;

    // Adjunction of laterality adjective
    if ( Self.WordPos = Indx + 1 ) then
      NewTerm := NewTerm + cSpace + LatValue;
  end; // for on all words of the term
  Result := Trim( NewTerm );
end; // ______________________________________________________MakeGenLatPluralLA

procedure          tLatinTerm.ProcessATerm();
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ProcessATerm
  * Process a single Latin term *
  Description:
  This procedure analyses a Latin term made of several words and prepares a
  syntactic tree, verifying the regularity of the term in respect of a
  transition matrix. Such a matrix limits the terms to noun sentences with a
  nominative noun followed by any number of genitive noun, each noun being
  possibly accompanied by one or more adjectives. Regular terms follows the
  Latin rules for case, gender and number.<P>
  There are three situations for which the analysis fails:<P>
  - missing word form in the Latin dictionnary,
  - non agreement to the transition matrix (check for number and case),
  - non agreement to the gender rule between adjective and noun.
  In all cases the result flag is set to false.<P>
  The analysis is performed by recursive call on procedure NextWord until
  the term is exhausted.<P>
  The elected solution is necessarily the first found solution. It may happen
  that more than one valid solution exist. They are ignored in the present
  implementation. Avoiding such a problem is complex and therefore not yet
  undertaken.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbLine:          Integer;
  OK:              Boolean;
  IsMain:          Boolean;
  ATerm:           String;
  MyCells:         tCells;
begin
  // Recursive processing of the next word of a term
  NbLine := 0;
  IsMain := True;
  SetLength( MyCells, 20 );
  ATerm := Trim( Self.Nominative );
  // The second argument should be a 11-digit TA98 code. To be redesigned.
  OK := NextWord( ATerm, 'xxxxx', tcn_nul, tcn_nul, cGenderShort[ gd_mas ],
        cEmpty, cNumberShort[ nb_sing ], cEmpty, Self.IsAdj,
        IsMain, NbLine, MyCells );

  // Store the result of analysis
  if ( OK ) then
  begin
    Self.NbWord := NbLine;
    Self.IsRegular := True;
    for Indx := 0 to Self.NbWord - 1 do
      Self.Node[ Indx ] := MyCells[ Indx ];
  end else
  begin
    Self.NbWord := 0;
    Self.IsRegular := False;
  end;
end; // ____________________________________________________________ProcessATerm

procedure          GetAdjectiveLA(
  Base:            String;
  var AdjCase:     tAdjCase );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetAdjectiveLA
  * Construction of all forms of an adjective *
  Description:
  Any Latin adjective has 12 different forms: 2 cases (nominative and genitive)
  times 2 numbers (singular and plural) times 3 genders (masculine, feminine
  and neuter).</p>
  This procedures build all the 11 missing forms starting from the given
  nominative masculine singular form. The missing forms are extracted from
  the Latin dictionary.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Indw:            Integer;
  MyInd:           Integer;
  MyLID:           Integer;
  Start:           Integer;
  MySkip:          Integer;
  MyCod:           String;
begin
  AdjCase[ 1 ] := Base;
  MyLID := 0;

  // Retrieve the given adjective in dictionary
  for Indx := 0 to TotCas - 1 do
  begin
    MyCod := Copy( Latin[ Indx ].Cod, 3, 3 );
    if ( ( Latin[ Indx ].Cas = Base ) and ( MyCod = 'mns' ) ) then
    begin
      MyLID := Latin[ Indx ].LID;
      Break;
    end;
  end; // for on all cases of Latin dictionary
  if ( MyLID = 0 ) then
  begin
    AdjCase[ 1 ] := cEmpty;
    Exit;
  end;

  // Loop on 3 values of gender
  for Indw := MyLID to MyLID + 2 do
  begin

    // Loop on 4 cases of case and number
    Start := 0;
    for Indy := 1 to 4 do
    begin

      // Loop on case dictionary
      for Indx := Start to TotCas - 1 do
      begin
        if Indw = Latin[ Indx ].LID then
        begin
          MyCod := Copy( Latin[ Indx ].Cod, 4, 2 );
          MyInd := 0;
          MySkip := ( Indw - MyLID ) * 4;
          if ( MyCod = 'ns' ) then
            MyInd := MySkip + 1
          else
          if ( MyCod = 'gs' ) then
            MyInd := MySkip + 2
          else
          if ( MyCod = 'np' ) then
            MyInd := MySkip + 3
          else
          if ( MyCod = 'gp' ) then
            MyInd := MySkip + 4;
          if ( MyInd > 0 ) then
            AdjCase[ MyInd ] := Latin[ Indx ].Cas;
          Start := Indx + 1;
          Break;
        end;
      end; // for on all cases of Latin dictionary
    end; // for on 4 cases of a dictionary entry
  end; // for on 3 values of gender
  AdjCase[ 13 ] := IntToStr( MyLID );
end; // __________________________________________________________GetAdjectiveLA

procedure          GetNounLA(
  Base:            String;
  var NounCase:    tNounCase );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNounLA
  * Construction of all forms of a noun *
  Description:
  Any Latin noun has 4 different forms: 2 cases (nominative and genitive) times
  2 numbers (singular and plural).</p>
  This procedures build all the 3 missing forms starting from the given
  nominative masculine singular form. The missing forms are extracted from
  the Latin dictionary.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  MyInd:           Integer;
  MyLID:           Integer;
  Start:           Integer;
  MyCod:           String;
  MyGender:        String;
begin
  NounCase[ 1 ] := Base;

  // Retrieve the given noun in dictionary
  MyLID := 0;
  for Indx := 0 to TotCas - 1 do
  begin
    MyCod := Copy( Latin[ Indx ].Cod, 4, 2 );
    if ( ( Latin[ Indx ].Cas = Base ) and ( MyCod = 'ns' ) ) then
    begin
      MyLID := Latin[ Indx ].LID;
      MyGender := Latin[ Indx ].Cod[ 3 ];
      Break;
    end;
  end; // for on all cases of Latin dictionary
  if ( MyLID = 0 ) then
  begin
    NounCase[ 1 ] := cEmpty;
    Exit;
  end;

  // Loop on 4 cases of case and number
  Start := 0;
  for Indy := 1 to 4 do
  begin

    // Loop on case dictionary
    for Indx := Start to TotCas - 1 do
    begin
      if MyLID = Latin[ Indx ].LID then
      begin
        MyCod := Copy( Latin[ Indx ].Cod, 4, 2 );
        MyInd := 0;
        if ( MyCod = 'gs' ) then
          MyInd := 2
        else
        if ( MyCod = 'np' ) then
          MyInd := 3
        else
        if ( MyCod = 'gp' ) then
          MyInd := 4;
        if ( MyInd > 0 ) then
          NounCase[ MyInd ] := Latin[ Indx ].Cas;
        Start := Indx + 1;
        Break;
      end;
    end; // for on all cases of Latin dictionary
  end; // for on 4 cases of a dictionary entry
  NounCase[ 5 ] := MyGender;
end; // _______________________________________________________________GetNounLA

function           tLatinTerm.MakeMandatLA(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeMandatLA
  * Make the mandatory part of a Latin term *
  Description:
  This procedure defines the mandatory part specified by the TID argument.</p>
  The part to be added is a Latin term at nominative that is supposed to be
  regular.The genitive is computed and then added at the right of the
  initial term.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  NbSingle:        Integer;            // Number of singles in generating entity
  MyGenitive:      String;             //
  MyLATerm:        tLatinTerm;         // Applicable term
begin

  // Build the genitive
  Past := Self.NbWord;
  MyLATerm := tLatinTerm( MyTerm.LgTerm );
  if ( MyLATerm = nil ) then
  begin
    Result := False;
    MyTerm.SetError( 999 );
    Exit;
  end;
  MyGenitive := Trim( MyLATerm.Genitive );

  // Adjust the syntax of owner French term
  NbWordGS := MyLATerm.NbWord;
  for Indx := 0 to NbWordGS - 1 do
  begin
    Self.Node[ Indx + Past ] := MyLATerm.NodeGS[ Indx ];
  end; // for on all genitive words
  MyTerm.Mandat := MyGenitive;
  Result := True;
end; // ____________________________________________________________MakeMandatLA

function           tLatinTerm.MakeOptionLA(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOptionLA
  * Make the mandatory part of a Latin term *
  Description:
  This procedure defines the mandatory part specified by the TID argument.</p>
  The part to be added is a Latin term at nominative that is supposed to be
  regular.The genitive is computed and then added at the right of the
  initial term.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  NbSingle:        Integer;            // Number of singles in generating entity
  MyGenitive:      String;             //
  MandatEntity:    tEntity;            // Generating entity of expansion
  MyLATerm:        tLatinTerm;         // Applicable term
begin

  // Build the genitive
  Past := Self.NbWord;
  MyLATerm := tLatinTerm( MyTerm.LgTerm );
  if ( MyLATerm = nil ) then
    Exit;
  MyGenitive := Trim( MyLATerm.Genitive );

  // Adjust the syntax of owner French term
  NbWordGS := MyLATerm.NbWord;
  for Indx := 0 to NbWordGS - 1 do
  begin
    Self.Node[ Indx + Past ] := MyLATerm.NodeGS[ Indx ];
  end; // for on all genitive words
  MyTerm.Mandat := MyGenitive;
  Result := True;
end; // ____________________________________________________________MakeOptionLA

function           tLatinTerm.MakeAdjectiveLA(
  Adj:             String;
  Pre:             String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAdjectiveLA
  * Insert an adjective of expansion in base term *
  Description:
  This procedure works on the base part of an entity and adds the adjective
  resulting from its adjective expansion. The new cell of the adjective is
  computed, then the new cell is inserted immediately before the noun. Finally
  the term is rebuilt as a single string.</p>
  The adjective may be accompanied by a prefix, to be added in front of the
  adjective.<P>
  About local variables:
  - Nounpos: position of the noun (first by default)
  - NbPlus: number of additional words after the noun
  - NbShift: 1 for adjective only, 2 for prefix and adjective.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbWord:          Integer;
  NounPos:         Integer;
  AdjPos:          Integer;
  NbShift:         Integer;
  NbPlus:          Integer;            // Number of words before the noun
  MyWord:          String;
  MyTerm:          String;
  SyntaxNoun:      String;
  MyGender:        String;
  AGender:         tWordGender;
  MyNode:          WordAnal;
  NewWord:         WordAnal;
  NewPref:         WordAnal;
  MyMandat:        tLatinTerm;
  AdjCase:         tAdjCase;
begin

  // Find the position of the noun
  NbWord := Self.NbWord;
  NounPos := 0;
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
  NewWord.Lem := Adj;
  NewWord.Wrd := Adj;
  SyntaxNoun := Copy( Self.Node[ NounPos ].Cod, 3, 3 );
  NewWord.Cod := 'ax' + SyntaxNoun;

  // Compute the new cell for the prefix if present
  if ( Pre <> cEmpty ) then
  begin
    NewPref.Wrd := Pre;
    NewPref.Lem := Pre;
    NewPref.Cod := 'pxxxx';
  end;

  // Create the new nodes for the adjective (and prefix) after the noun
  NbShift := 1;
  Inc( NbWord );
  if ( Pre <> cEmpty ) then
  begin
    NbShift := 2;
    Inc( NbWord );
  end;
  Self.NbWord := NbWord;
  if ( NbWord - 1 > NounPos + 1 ) then
    for Indx := NbWord - 1 downto NbWord - NbPlus do
      Self.Node[ Indx ] := Self.Node[ Indx - NbShift ];

  // Adjust the gender of adjective
  MyGender := Self.Node[ 0 ].Cod[ 3 ];
  GetAdjectiveLA( Adj, AdjCase );
  if ( AdjCase[ 1 ] = cEmpty ) then
  begin
    Result := False;
    Exit;
  end;
  if ( MyGender = 'f' ) then
    NewWord.Wrd := AdjCase[ 5 ]
  else
  if ( MyGender = 'n' ) then
    NewWord.Lem := AdjCase[ 9 ];
  NewWord.LID := AdjCase[ 13 ];

  // Move the new adjective (and prefix)
  if ( Pre <> cEmpty ) then
  begin
    Self.Node[ NounPos + 1 ] := NewPref;
    Self.Node[ NounPos + 2 ] := NewWord;
  end else
    Self.Node[ NounPos + 1 ] := NewWord;

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
end; // _________________________________________________________MakeAdjectiveLA

function           tLatinTerm.SetBaseLA(
  TID:             Integer )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetBaseLA
  * Set a base term after expansion *
  Description:
  This procedure adds a bilateral placeholder to a bilateral Latin term.</p>
  At first the position and applied syntax of the placeholder is defined. In
  Latin the placehiolder is always the rightmost position of the term. The
  syntax is the syntax of the leftmost noun of the term. When a non-zero TID
  is specified, a search for externally specified position and syntax is
  performed. If successful, the found values are applied.</p>
  At second, the placeholder is built and inserted in its place.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index
  PosWord:         Integer;            // Position of bilateral placeholder
  Syntax:          String;             // Syntax for placeholder
  MyCell:          WordAnal;           // Placeholder cell
begin

  // Determine the syntax and position of the lateral placeholder
  // Last position of nominative part by default
  Syntax := 'mns';
  PosWord := Self.NbWord;
  for Indx := 0 to Self.NbWord - 1 do
  begin
    if ( ( Self.Node[ Indx ].Cod[ 1 ] = 'n' ) and
         ( Self.Node[ Indx ].Cod[ 4 ] = 'n' ) ) then
    begin
      Syntax := Self.Node[ 0 ].Cod[ 3 ] + 'n' + Self.Node[ 0 ].Cod[ 5 ];
    end else
    if ( Self.Node[ Indx ].Cod[ 4 ] <> 'n' ) then
    begin
      PosWord := Indx;
      Break;
    end;
  end; // for on all words

  // Check for a fixed value for the traditional terms
  if ( TID > 0 ) then
  begin
    for Indx := 0 to NbFixTrad - 1 do
    begin
      if ( FixTrad[ Indx ].TID = TID ) then
      begin
        Posword := FixTrad[ Indx ].Pos;
        Syntax := FixTrad[ Indx ].Syntax;
        Break;
      end;
    end; // for on all exceptions
  end;

  // Add the bilateral place holder: xter stands for dexter or sinister
  MyCell.Lem := 'xter';
  MyCell.Cod := 'hx' + Syntax;
  for Indx := Self.NbWord downto 0 do
    if ( Indx > PosWord  ) then
      Self.Node[ Indx ] := Self.Node[ Indx - 1 ];
  Self.Node[ PosWord ] := MyCell;
  Result := True;
end; // _______________________________________________________________SetBaseLA

function           SetFormalPSetLA(
  Term:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormalPSetLA
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
  MyTerm := tTerm.Create( Term.Mandat, lt_Latin );
  NewTerm := MyTerm.GenPlural;
  Result := cEmpty;
  if ( MyTerm.IsRegular ) then
  begin
    Prefix := 'par classium';
    Result := Prefix + cSpace + NewTerm;
  end;
end; // _________________________________________________________SetFormalPSetLA

function           TestNounPluralLA(
  ANoun:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestNounPluralFR
  * Test for plural of French nouns *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyNoun:          tLatinTerm;
begin
  MyNoun := tLatinTerm.Create( ANoun );
  Result := MyNoun.MakePluralLA( IsRule, Ident );
end; // ________________________________________________________TestNounPluralFR

end.
