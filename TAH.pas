{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit TAH
  * Class definition of the TAH terminology *
  Description:
  This class corresponds to the recipient of the entire TAH. It includes all
  TAH units which themselves include several other classes participating
  to the definition of these entities.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit TAH;

interface

uses
  Entity, TAHParam, BiProps, Notes, Docums, Definitions, ComCtrls, Classes,
  Valid, TA98List, Tetra, FMA, HTMLSection, List, SingleTerms, Comments ;

type

                             // Container class for the entire TAH terminology
  tTAH                       = class( TObject )
  private
    fMainLang:               tLanguage;
    fSubstLang:              tLanguage;
    fDisLanguage:            tLanguage;
    fUnitFileName:           String;
    fLAFileName:             String;
    fENFileName:             String;
    fFRFileName:             String;
    fESFileName:             String;
    fRUFileName:             String;
    fITFileName:             String;
    fGEFileName:             String;
    fPTFileName:             String;
    fMDFileName:             String;
    fListFilename:           String;
    fDefENFilename:          String;
    fDefFRFilename:          String;
    fDefESFilename:          String;
    fDefRUFilename:          String;
    fLADicoFilename:         String;
    fFixTradFilename:        String;
    fTA98ListFilename:       String;
    fTAFMAFileName:          String;
    fCommFileName:           String;
    fEntity:                 array of tEntity;
    fUnit:                   array of tUnit;
    fFormula:                array of tSingle;
    fLAPlus:                 array of tSingle;
    fTotTAH:                 Integer;
    fTotUnit:                Integer;
    fBiProperties:           tLinkage;
    fNotes:                  tNote;
    fDocums:                 tDocum;
    fComments:               tComments;
    fDefinitions:            tDefinition;
    fSignatures:             tSignatures;
    fInquiries:              tInquiry;
    fActions:                tAction;
    fTA98List:               tTA98List;
    fFMA:                    tFMA;
    function                 GetNbLAPlus()
                               : Integer;
  public
                             // Retrieve the number of entities in memory
    function                 GetNbEntity(): Integer;
                             // Main language for HTML pages
    property MainLang:       tLanguage read fMainLang write fMainLang;
                             // Substitution language for HTML pages
    property SubstLang:      tLanguage read fSubstLang write fSubstLang;
                             // Display language for HTML pages
    property DisLanguage:    tLanguage read fDisLanguage write fDisLanguage;
                             // Filename of MASTER file of entity records
    property UnitFileName:   String read fUnitFileName;
                             // Filename of Latin terms
    property LAFileName:     String read fLAFileName;
                             // Filename of English terms
    property ENFileName:     String read fENFileName;
                             // Filename of French terms
    property FRFileName:     String read fFRFileName;
                             // Filename of Spanish terms
    property ESFileName:     String read fESFileName;
                             // Filename of Russian terms
    property RUFileName:     String read fRUFileName;
                             // Filename of Italian terms
    property ITFileName:     String read fITFileName;
                             // Filename of German terms
    property GEFileName:     String read fGEFileName;
                             // Filename of Portugese terms
    property PTFileName:     String read fPTFileName;
                             // Filename of Universal terms
    property MDFileName:     String read fMDFileName;
                             // Filename of list signatures
    property ListFileName:   String read fListFileName;
                             // Filename of English definitions
    property DefENFileName:  String read fDefENFileName;
                             // Filename of French definitions
    property DefFRFileName:  String read fDefFRFileName;
                             // Filename of Spanish definitions
    property DefESFileName:  String read fDefESFileName;
                             // Filename of Russian definitions
    property DefRUFileName:  String read fDefRUFileName;
                             // Filename of Latin dictionary
    property LADicoFilename: String read fLADicoFilename;
                             // Filename for irregular RAT terms
    property FixTradFilename:String read fFixTradFilename;
                             // Filename to TA98 lists
    property TA98ListFilename:String read fTA98ListFilename;
                             // Filename for TA-FMA comments
    property TAFMAFilename:  String read fTAFMAFilename;
                             // Filename for comments
    property CommFilename:   String read fCommFilename;
                             // Total number of entries for entities
    property TotTAH:         Integer read fTotTAH;
                             // Total number of entries for units
    property TotUnit:        Integer read fTotUnit;
                             // Total number of entities
    property NbEntity:       Integer read GetNbEntity;
                             // Number of complementary Latin terms
    property NbLAPlus:       Integer read GetNbLAPlus;
                             // Corpus of bivalued properties
    property BiProperties:   tLinkage read fBiProperties write fBiProperties;
                             // Corpus of notes
    property Notes:          tNote read fNotes write fNotes;
                             // Corpus of documents
    property Docums:         tDocum read fDocums write fDocums;
                             // Corpus of comments
    property Comments:       tComments read fComments write fComments;
                             // Corpus of all definitions in English and French
    property Definitions:    tDefinition read fDefinitions write fDefinitions;
                             // Corpus of all signatures for lists
    property Signatures:     tSignatures read fSignatures write fSignatures;
                             // Corpus of inqueries
    property Inquiries:      tInquiry read fInquiries write fInquiries;
                             // Corpus of actions
    property Actions:        tAction read fActions write fActions;
                             // Corpus of TA98 Lists
    property TA98List:       tTA98List read fTA98List write fTA98List;
                             // Corpus of FMA notes
    property FMAs:           tFMA read fFMA write fFMA;

    // ===================== Access functions to entities ======================
                             // Get a single entity from its TID
    function                 GetEntityByTID(
                               TID: Integer ):
                               tEntity;
                             // Get a tetrahedron from its TID
    function                 GetTetrahedronByTID(
                               TID: Integer ):
                               tTetrahedron;
                             // Get a tetrahedron from its UID
    function                 GetTetrahedronByUID(
                               UID: Integer ):
                               tTetrahedron;
                             // Get the generator entity of a unit from its UID
    function                 GetUnitGenerator(
                               UID: Integer ):
                               tEntity;
                             // Get type of tetrahedron
    function                 TetraTypeOf(
                               TetSeq: tTip )
                               : tTetra;
                             // Get a single entity from its position
    function                 GetEntityByPos(
                               Position: Integer ):
                               tEntity;
                             // Get a TA98 entity from specified TID
    function                 GetTA98EntityByTID(
                               TID: Integer ):
                               tEntity;
                             // Get a single unit from its position
    function                 GetUnitByPos(
                               Position: Integer ):
                               tUnit;
                             // Get a single formula from its UID
    function                 GetFormula(
                               UID: Integer ):
                               tSingle;
                             // Get a Latin complementary term
    function                 GetLAPlus(
                               UID: Integer ):
                               tSingle;
                             // Get a list of entities having a P4 flag
    function                 GetListEntityByP4(
                               TID: Integer)
                               : String;
                             // Get a list of entities having a P3 flag
    function                 GetListEntityByP3(
                               TID: Integer)
                               : String;
                             // Get a list of entities having a T4 flag
    function                 GetListEntityByT4(
                               TID: Integer)
                               : String;
                             // Get a list of entities having a T3 flag
    function                 GetListEntityByT3(
                               TID: Integer)
                               : String;
                             // Retrieve a label of presentation
    function                 GetLabel(
                               TID: Integer;
                               IsUpper: Boolean = True;
                               ForcedLg: TLanguage = lt_None )
                               : String;
                             // Retrieve a bubble text of presentation
    function                 GetBubble(
                               TID: Integer;
                               IsUpper: Boolean = True;
                               ForcedLg: tLanguage = lt_None )
                               : String;
                             // Retrieve a text value
    function                 GetTextValue(
                               TID: Integer;
                               IsUpper: Boolean = True;
                               ForcedLg: tLanguage = lt_None;
                               IsSecond: Boolean = False )
                               : String;
                             // Retrieve all generated entities
    procedure                GetPositionsByGen(
                               MyTID: Integer;
                               var NbPos: Integer;
                               var MyPos: Array of Integer );
                             // Decode the combination the languages
    procedure                LgCombination(
                               LgComb: tLgComb );

    // ===================== Build of data structures ==========================
                             // Initialize all filenames
    procedure                InitFilenames;
                             // Read export database file of units
    procedure                BuildUnit;
                             // Build the entities from the units
    procedure                BuildEntity;
                             // Read export database file of Latin terms
    procedure                BuildTermsLA;
                             // Read export database file of English terms
    procedure                BuildTermsEN;
                             // Read export database file of French terms
    procedure                BuildTermsFR;
                             // Read export database file of Spanish terms
    procedure                BuildTermsES;
                             // Read export database file of Russian terms
    procedure                BuildTermsRU;
                             // Read export database file of Italian terms
    procedure                BuildTermsIT;
                             // Read export database file of German terms
    procedure                BuildTermsGE;
                             // Read export database file of Portugese terms
    procedure                BuildTermsPT;
                             // Read export database file of Universal terms
    procedure                BuildTermsMD;

    // ===================== Build of Entity-related Pages =====================
                             // Build a single Tetra Page
    procedure                MakeUnitPage(
                               TID: Integer );
                             // Build an Tetra section
    procedure                MakeBatchUnit(
                               TID: Integer );
                             // Search for a sector of Entity Pages
    procedure                MakeBatchEntity(
                               TID: Integer );
                             // Build all Entity Pages belonging to a sector
    procedure                MakeEntitySector(
                               TID: Integer;
                               StopLevel: String );
                             // Make a single Entity Page
    procedure                MakeEntityPage(
                               MyEntity: tEntity );
                             // Build a range of Universal Pages
    procedure                MakeUniversalBatch(
                               TID: Integer;
                               StartSection: tDisplay );
                             // Build a Latin section
    procedure                MakeUniversalPage(
                               TID: Integer;
                               StopSection: tDisplay );
                             // Build a Test Page
    procedure                MakeTestPage(
                               MyTest: tTypeTest );
                             // Build and write a Property Page
    procedure                MakePropertyPage(
                               TID: Integer );
                             // Build and write a RAT Page
    procedure                MakeRATPage(
                               TID: Integer );
                             // Build and write a Definition Page
    procedure                MakeDefinPage(
                               TID: Integer );

    // ===================== Build of Segmentation Pages =======================
                             // Build a group of Segmentation Pages
    procedure                MakeGroupSegmentPage(
                               TID: Integer );
                             // Build and write a Segmentation Page
    procedure                MakeSegmentPage(
                               TID: Integer;
                               Level: Integer );
                             // Build and write a Level 4 Excel file
    procedure                MakeSegmentExcel(
                               TID: Integer );
                             // Build and write a 6-column format Excel file
    procedure                MakeSegment6Columns(
                               TID: Integer );

    // ===================== Build of Validation Pages =========================
                             // Build and write a Validation Page
    procedure                MakeValidPage(
                               TID: Integer;
                               MyCateg: tCategPage = ca_ListPart );
                             // Build and write all level 5 pages
    procedure                MakeValidL5Pages(
                               TID: Integer );

    // ===================== Build of Partonomy Pages ==========================
                             // Prepare any Partonomy Page
    procedure                MakeAnyPartonomyPage(
                               TID: Integer;
                               AType: tTypeListPage );
                             // Prepare any Part98 Page
    procedure                MakeAnyPart98Page(
                               TID: Integer;
                               AType: tTypeListPage );
                             // Prepare a single Partonomy Page
    procedure                MakePartonomyPage(
                               TID: Integer;
                               AType: tTypeListPage );
                             // Prepare a single Part98 Page
    procedure                MakePart98Page(
                               TID: Integer;
                               AType: tTypeListPage );
                             // Prepare a generic Partonomy Page
    procedure                MakeGenericPartonomyPage(
                               TID: Integer );

    // ===================== Build of Taxonomy Pages ===========================
                             // Prepare any Partonomy Page
    procedure                MakeAnyTaxonomyPage(
                               TID: Integer;
                               AType: tTypeListPage );

    // ===================== Build of List Pages ===============================
                             // Prepare a Taxonomy Page
    procedure                MakeTaxonomyPage(
                               TID: Integer;
                               AType: tTypeListPage );
                             // Prepare a Interface Page
    procedure                MakeInterfacePage(
                               TID: Integer;
                               AType: tTypeListPage );
                             // Build and write a Hierarchy Page at top level
    procedure                MakeHierarchyPage(
                               TID: Integer;
                               StartSection: tDisplay );
                             // Build and write a FMA List Page
    procedure                MakeFMAList(
                               TID: Integer );

    // ===================== Build of XML Pages ================================
                             // Build a single letter Page
    procedure                MakeSingleLetterPage;
                             // Build the set of three letters Page
    procedure                MakeThreeLettersPage;
                             // Build a subset of three letters Page by letter
    procedure                MakeThreePage(
                               ALetter: Char );

    // ===================== Build of TA98 Pages ===============================
                             // Build a TA98 Page for a chapter
    procedure                MakeTA98chapterPage(
                               TID: Integer );
                             // Build a TA98 Page for a subchapter
    procedure                MakeTA98subchapterPage(
                               TID: Integer );
                             // Build a TA98 Page for a section
    procedure                MakeTA98sectionPage(
                               TID: Integer );
                             // Build all subsections TA98 Page for a section
    procedure                MakeTA98ShortPage(
                               TID: Integer );
                             // Build a TA98 Page for a subsection
    procedure                MakeTA98subsectionPage(
                               TID: Integer );
    // ===================== Other stuff =======================================
                             // Make the children list for all entities
    procedure                InvertedHierarchy;
                             // Define the type of hierarchy
    function                 IsTaxonomy(
                               TID: Integer )
                               : Boolean;
                             // Prepare a list at level 3
    function                 GetListLevel3(
                               TetValue: Integer;
                               var MyList: tList )
                               : Integer;
                             // Prepare a list at level 4
    function                 GetListLevel4(
                               TetValue: Integer;
                               var MyList: tList )
                               : Integer;
                             // Prepare a segmentation list of units at level 5
    function                 GetListTetra(
                               TetValue: Integer;
                               var MyList: tList )
                               : Integer;
                             // Prepare a taxonomix list of units at level 5
    function                 GetTaxListTetra(
                               TetValue: Integer;
                               var MyList: tList )
                               : Integer;
                             // Prepare a partonomic list of units at level 5
    function                 GetPartListTetra(
                               TetValue: Integer;
                               var MyList: tList )
                               : Integer;
                             // Extract first two chidren according to sortlist
    procedure                ExtractFirstTwoChildren(
                               Children: String;
                               SortList: String;
                               var LeftPos: Integer;
                               var RightPos: Integer );
                             // Read exceptions for traditional terms
    procedure                ReadFixTradFile;
                             // Retrieve all four positions of partonomy lists
    function                 GetPartListPosition(
                               TID: Integer;
                               var FourList: tFourList )
                               : Boolean;
                             // Retrieve all four positions of taxonomy lists
    function                 GetTaxListPosition(
                               TID: Integer;
                               var FourList: tFourList )
                               : Boolean;
                             // Define an entity as part of TA98
    function                 DoTA98(
                               TID: Integer ):
                               Boolean;
  end; // class tTAH

  Tetra = record
    UID: Integer;
    Seq: Integer;
  end;
  PTetra                     = ^Tetra;
  function                   CompareIntegers(
                               Item1, Item2: Pointer)
                               : Integer;

implementation

uses
  TAHPage, TAHBrowser, SysUtils, TAHInterface;

function           tTAH.GetLabel(
  TID:             Integer;
  IsUpper:         Boolean;
  ForcedLg:        tLanguage )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetLabel
  * Retrieve a label of presentation in the specified language *
  Description:
  The label to be retrieved is specified by the TID of its representation
  entity (unit). This entity is loaded; if nil, an empty label is returned.
  Then the language term for the current display language is retrieved
  (variable TAH.DisLanguage). When this term is empty, the English corresponding
  term is retrieved as default. Finally, the first letter is made upper case,
  unless this option has been cancelled.</P>
  It is possible to force the language to a value different from the
  current display language.</p>
  Warning: this function is also defined in tSection. The present implementation
  is the good one, the other should be deleted.
  StandardDoc/21.02.2021
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Etiq:            tEntity;
  MyLabel:         String;
  MyLanguage:      tLanguage;
begin

  // Retrieve the representation entity
  Result := cEmpty;
  Etiq := GetEntityByTID( TID );
  if ( Etiq <> nil ) then
  begin

    // Define the language (display language by default)
    MyLanguage := DisLanguage;
    if ( ForcedLg <> lt_None ) then
      MyLanguage := ForcedLg;

    // Retrieve the representation text (English by default)
    MyLabel := Etiq.GetLibelle( lb_Text, MyLanguage, st_undef, False );
    if ( MyLabel = cEmpty ) then
      MyLabel := Etiq.GetLibelle( lb_Text, lt_English, st_undef, False );

    // Make upper case the first character
    if ( ( MyLabel <> cEmpty ) and IsUpper ) then
      MyLabel := SysUtils.UpperCase( MyLabel[ 1 ] )
                + Copy( MyLabel, 2 , Length( MyLabel ) );

    Result := MyLabel;
  end;
end; // ________________________________________________________________GetLabel

function           tTAH.GetBubble(
  TID:             Integer;
  IsUpper:         Boolean;
  ForcedLg:        tLanguage )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetBubble
  * Retrieve a bubble text of presentation in the specified language *
  Description:
  The label to be retrieved is specified by the TID of its representation
  entity (unit). This entity is loaded; if nil, an empty text is returned.
  Then the language term for the current display language is retrieved
  (variable TAH.DisLanguage). When this term is empty, the English corresponding
  term is retrieved as default. Finally, the first letter is made upper case,
  unless this option has been cancelled.</P>
  It is possible to force the language to a value different from the
  current display language.</p>
  StandardDoc/21.02.2021
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Etiq:            tEntity;
  MyLabel:         String;
  MyLanguage:      tLanguage;
begin

  // Retrieve the representation entity
  Result := cEmpty;
  Etiq := GetEntityByTID( TID );
  if ( Etiq <> nil ) then
  begin

    // Define the language (display language by default)
    MyLanguage := DisLanguage;
    if ( ForcedLg <> lt_None ) then
      MyLanguage := ForcedLg;

    // Retrieve the representation text (English by default)
    MyLabel := Etiq.GetLibelle( lb_Bubble, MyLanguage, st_undef, False );
    if ( MyLabel = cEmpty ) then
      MyLabel := Etiq.GetLibelle( lb_Bubble, lt_English, st_undef, False );

    // Make upper case the first character
    if ( ( MyLabel <> cEmpty ) and IsUpper ) then
      MyLabel := SysUtils.UpperCase( MyLabel[ 1 ] )
                + Copy( MyLabel, 2 , Length( MyLabel ) );

    Result := MyLabel;
  end;
end; // _______________________________________________________________GetBubble

function           tTAH.GetTextValue(
  TID:             Integer;
  IsUpper:         Boolean;
  ForcedLg:        tLanguage;
  IsSecond:        Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTextValue
  * Retrieve a text value in the specified language *
  Description:
  A text value is the expected term of an entity in a specific language,
  denoted by the type st_val. It is exclusively used for testing purpose and
  does not directly belongs to the terminology per se.</p>
  The label to be retrieved is specified by its identifier (variable TID)
  of its representation entity (unit). This entity is loaded, then the
  language term for the current display language is retrieved (global variable
  TAH.DisLanguage), unless another language is specified (variable ForcedLg,
  default lt_None). When this term is empty, the English corresponding term
  is retrieved as default. Finally, the first letter is made upper case,
  unless this option has been cancelled (variable IsUpper, default True).</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyLabel:         String;
  MyLanguage:      tLanguage;
  Etiq:            tEntity;
begin

  // Retrieve the representation entity
  Result := cEmpty;
  Etiq := Self.GetEntityByTID( TID );
  if ( Etiq <> nil ) then
  begin

    // Define the language (display language by default)
    MyLanguage := Self.DisLanguage;
    if ( ForcedLg <> lt_None ) then
      MyLanguage := ForcedLg;

    // Retrieve the representation text (English by default)
    if ( not IsSecond ) then
    begin
      MyLabel := Etiq.GetLibelle( lb_Value, MyLanguage, st_Val, False );
      if ( MyLabel = cEmpty ) then
        MyLabel := Etiq.GetLibelle( lb_Value, lt_English, st_Val, False );
    end else
    begin
      MyLabel := Etiq.GetLibelle( lb_Value, MyLanguage, st_vl2, False );
      if ( MyLabel = cEmpty ) then
        MyLabel := Etiq.GetLibelle( lb_Value, lt_English, st_vl2, False );
    end;

    // Make upper case the first character
    if ( ( MyLabel <> cEmpty ) and IsUpper ) then
      MyLabel := SysUtils.UpperCase( MyLabel[ 1 ] ) +
                 Copy( MyLabel, 2 , Length( MyLabel ) );

    Result := MyLabel;
  end;
end; // ____________________________________________________________GetTextValue

function           tTAH.GetNbEntity()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbEntity
  * Get the number of entities in memory *
  Description:
  The method retrieves the number of available entities as exported from the
  TAH database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FEntity );
end; // _____________________________________________________________GetNbEntity

function           tTAH.GetNbLAPlus()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbLAPlus
  * Get the number of Latin complementary terms *
  Description:
  The method retrieves the number of Latin complementary terms as exported
  from the TAH database.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FLAPlus );
end; // _____________________________________________________________GetNbLAPlus

function           TTAH.GetFormula(
  UID:             Integer )
  :                TSingle;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetFormula
  * Retrieve a formula by its UID *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbFor:           Integer;
begin
  Result := nil;
  NbFor := Length( Self.FFormula );
  if ( ( UID < 0 ) and ( UID >= NbFor ) ) then
    Exit;
  Result := Self.FFormula[ UID ];
end; // ______________________________________________________________GetFormula

function           TTAH.GetLAPlus(
  UID:             Integer )
  :                TSingle;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetLAPlus
  * Retrieve a Latin complementary term *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbLAPlus:        Integer;
begin
  Result := nil;
  NbLAPlus := Length( Self.FLAPlus );
  if ( ( UID < 0 ) and ( UID >= NbLAPlus ) ) then
    Exit;
  Result := Self.FLAPlus[ UID ];
end; // _______________________________________________________________GetLAPlus

function           tTAH.GetEntityByTID(
  TID:             Integer )
  :                tEntity;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetEntityByTID
  * Retrieve an entity by its TID *
  Description:
  This method retrieves the entity with the specified TID. If
  this entity does not exist, a nil value is returned.</P>
  In the actual implementation the TID is equal to the position of the
  entity in the array of all TAH entities. There are roughly no missing
  ID numbers of entities, due  to the sequential increasing allocation of new
  values. In this setting, the retrieval of any entity is faster
  than any other solution!</P>
  This method is not really necessary in the actual implementation. But it may
  be preferable to use it rather than to bypass it, in case a future different
  implementation is realized for optimisation purpose.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  // Check the range of valid TID
  Result := nil;
  if ( ( TID = 0 ) or ( TID > Self.TotTAH ) ) then
    Exit;

  // Return the requested entity, may be nil if it does not exist
  Result := Self.FEntity[ TID ];
end; // __________________________________________________________GetEntityByTID

function           TTAH.GetUnitGenerator(
  UID:             Integer )
  :                TEntity;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetUnitGenerator
  * Retrieve the generator of a Unit by its UID *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyUnit:          TUnit;
begin
  // Check the range of valid TID
  Result := nil;
  if ( ( UID < 0 ) or ( UID > Self.TotUnit ) ) then
    Exit;

  // Retrieve the generator entity of the unit
  MyUnit := GetUnitByPos( UID );
  if ( ( MyUnit <> nil ) and ( MyUnit.Generator > 0 ) ) then
    Result := GetEntityByTID( MyUnit.Generator )
  else
  if ( ( MyUnit <> nil ) and ( MyUnit.Main > 0 ) ) then
    Result := GetEntityByTID( MyUnit.Main );
end; // ________________________________________________________GetUnitGenerator

function           TTAH.GetTetrahedronByTID(
  TID:             Integer )
  :                TTetrahedron;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTetrahedronByTID
  * Retrieve a Unit by any of its TID *
  Description:
  This method retrieves the Unit containing the specified TID. If
  this tetrahedron does not exist, a nil value is returned.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Generator:       Integer;
  SetGenerator:    Integer;
  LeftPos:         Integer;
  RightPos:        Integer;
  PosUnit:         Integer;
  TIDUnit:         Array[ 1 .. 5 ] of Integer;
  Children:        String;
  SortList:        String;
  Tetra:           TTetrahedron;
  MyUnit:          TUnit;
  MyEntity:        TEntity;
  TetSeq:          tTip;
begin
  // Check the range of valid TID
  Result := nil;
  if ( ( TID < 0 ) or ( TID > Self.TotTAH ) ) then
    Exit;

  // Create a new tetrahedron
  MyEntity := GetEntityByPos( TID );
  MyUnit := nil;
  if ( MyEntity <> nil ) then
    MyUnit := GetUnitByPos( MyEntity.Tetra );

  // Treatment for units
  Tetra := tTetrahedron.Create;
  if ( ( MyUnit <> nil ) and ( MyUnit.Generator > 0 ) ) then
  begin
    Tetra.Genr := GetEntityByTID( MyUnit.Generator );
    Tetra.ASet := GetEntityByTID( MyUnit.ASet );
    Tetra.Main := GetEntityByTID( MyUnit.Main );
    Tetra.ASin := GetEntityByTID( MyUnit.Left );
    Tetra.ADex := GetEntityByTID( MyUnit.Right );
    Tetra.TetraType := MyUnit.TypUnit;
    Tetra.TetraID := MyUnit.UID;
  end else

  // Treatment for taxonomic entities (transitory no Unit!)
  if ( ( MyUnit = nil ) and ( MyEntity <> nil ) and
       ( MyEntity.TetraTip = tp_tax ) ) then
  begin
    Tetra.Genr := MyEntity;
    Tetra.ASet := nil;
    Tetra.Main := nil;
    Tetra.ASin := nil;
    Tetra.ADex := nil;
    Tetra.TetraType := tt_tax;
  end else

  // Treatment for entities (past treatment)
  begin

    // Retrieve all entities of the tetrahedron
    PosUnit := 0;
    for Indx := 0 to Self.TotTAH do
    begin
      if ( Self.FEntity[ Indx ] = nil ) then
        Continue;
      if ( Self.FEntity[ Indx ].Tetra = MyEntity.Tetra ) then
      begin
        if ( Self.FEntity[ Indx ].TetraTip in [ tp_single, tp_genpair,
             tp_genpset, tp_genset, tp_ref, tp_tax, tp_voc ] ) then
          PosUnit := 1;
        if ( Self.FEntity[ Indx ].TetraTip in [ tp_pair, tp_pset ] ) then
          PosUnit := 2;
        if ( Self.FEntity[ Indx ].TetraTip in [ tp_leftpair, tp_leftpset ] ) then
          PosUnit := 3;
        if ( Self.FEntity[ Indx ].TetraTip in [ tp_rightpair, tp_rightpset ] ) then
          PosUnit := 4;
        if ( Self.FEntity[ Indx ].TetraTip in [ tp_setpset, tp_set ] ) then
          PosUnit := 5;
        if ( ( PosUnit > 0 ) and ( PosUnit >= 5 ) ) then
          TIDUnit[ PosUnit ] := Self.FEntity[ Indx ].TID;
      end;
    end;

    // Retrieve the main entity and type of tetrahedron
    Tetra.Main := Self.FEntity[ TID ];
    TetSeq := Tetra.Main.TetraTip;
    if ( TetSeq in [ tp_genpair, tp_genpset, tp_genset, tp_leftpset,
                     tp_rightpset, tp_tax ] ) then
    begin
      Tetra.Main := GetEntityByTID( Tetra.Main.Tetra );
      TetSeq := Tetra.Main.TetraTip;
    end;
    Tetra.TetraType := TetraTypeOf( TetSeq );
    Tetra.TetraID := Tetra.Main.Tetra;
    Tetra.Level5ID := Tetra.Main.Niveau5;

    // Handling of single tetrahedron
    if ( Tetra.TetraType = tt_single ) then
    begin
      Tetra.Genr := GetEntityByTID( TIDUnit[ 1 ] ); // Tetra.Main;
      Tetra.Main := nil;
      Tetra.ASet := nil;
      Tetra.ASin := nil;
      Tetra.ADex := nil;
    end else

    // Handling of pair tetrahedron
    if ( Tetra.TetraType = tt_pair ) then
    begin
      // Generator := Tetra.Main.Generator;
      Tetra.Genr := GetEntityByTID( TIDUnit[ 1 ] ); // Self.FEntity[ Generator ];
      Tetra.ASet := nil;
      Tetra.Main := GetEntityByTID( TIDUnit[ 2 ] );
      // Children := Tetra.Genr.TaxCh;
      // SortList := Tetra.Genr.TaxPos;
      // ExtractFirstTwoChildren( Children, SortList, LeftPos, RightPos );
      Tetra.ASin := GetEntityByTID( TIDUnit[ 3 ] ); // Self.FEntity[ LeftPos ];
      Tetra.ADex := GetEntityByTID( TIDUnit[ 4 ] ); // Self.FEntity[ RightPos ];
    end else

    // Handling of pset tetrahedron
    if ( Tetra.TetraType = tt_pset ) then
    begin
      // Generator := Tetra.Main.Generator;
      Tetra.Genr := GetEntityByTID( TIDUnit[ 1 ] ); // Self.FEntity[ Generator ];
      // Children := Tetra.Main.PartCh;
      // SortList := Tetra.Main.PartPos;
      // ExtractFirstTwoChildren( Children, SortList, LeftPos, RightPos );
      Tetra.ASin := GetEntityByTID( TIDUnit[ 3 ] ); // Self.FEntity[ LeftPos ];
      Tetra.ADex := GetEntityByTID( TIDUnit[ 4 ] ); // Self.FEntity[ RightPos ];
      // SetGenerator := Tetra.ASin.TaxAnc;
      Tetra.ASet := GetEntityByTID( TIDUnit[ 5 ] ); // Self.FEntity[ SetGenerator ];
    end else

    // Handling of set tetrahedron
    if ( Tetra.TetraType = tt_set ) then
    begin
      // Generator := Tetra.Main.Generator;
      Tetra.Genr := GetEntityByTID( TIDUnit[ 1 ] ); // Self.FEntity[ Generator ];
      Tetra.ASet := GetEntityByTID( TIDUnit[ 5 ] ); // nil;
      Tetra.ASin := nil;
      Tetra.ADex := nil;
    end else

    // Handling of taxonomic tetrahedron
    if ( Tetra.TetraType = tt_tax ) then
    begin
      // Generator := Tetra.Main.Generator;
      // if ( Generator <> 0 ) then
        Tetra.Genr := GetEntityByTID( TIDUnit[ 1 ] ); // Self.FEntity[ Generator ];
      Tetra.ASet := nil;
      Tetra.ASin := nil;
      Tetra.ADex := nil;
    end else

    // Handling of reference tetrahedron
    if ( Tetra.TetraType = tt_ref ) then
    begin
      // Generator := Tetra.Main.Reference;
      Tetra.Genr := GetEntityByTID( TIDUnit[ 1 ] ); // Self.FEntity[ Generator ];
      Tetra.ASet := nil;
      Tetra.ASin := nil;
      Tetra.ADex := nil;
    end ;

  // Return the requested entity, may be nil if it does not exist
  end;
  Result := Tetra;
end; // _____________________________________________________GetTetrahedronByTID

function           TTAH.GetTetrahedronByUID(
  UID:             Integer )
  :                TTetrahedron;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTetrahedronByUID
  * Retrieve a Unit by its UID *
  Description:
  This method retrieves the Unit containing the specified TID. If
  this tetrahedron does not exist, a nil value is returned.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Generator:       Integer;
  SetGenerator:    Integer;
  LeftPos:         Integer;
  RightPos:        Integer;
  PosUnit:         Integer;
  TIDUnit:         Array[ 1 .. 5 ] of Integer;
  Children:        String;
  SortList:        String;
  Tetra:           TTetrahedron;
  MyUnit:          TUnit;
  MyEntity:        TEntity;
  TetSeq:          tTip;
begin
  // Check the range of valid TID
  Result := nil;
  if ( ( UID < 0 ) or ( UID > Self.TotUnit ) ) then
    Exit;

  // Create a new unit
  MyUnit := GetUnitByPos( UID );

  // Treatment for units
  Tetra := TTetrahedron.Create;
  if ( ( MyUnit <> nil ) and ( MyUnit.Generator > 0 ) ) then
  begin
    Tetra.Genr := GetEntityByTID( MyUnit.Generator );
    Tetra.ASet := GetEntityByTID( MyUnit.ASet );
    Tetra.Main := GetEntityByTID( MyUnit.Main );
    Tetra.ASin := GetEntityByTID( MyUnit.Left );
    Tetra.ADex := GetEntityByTID( MyUnit.Right );
    Tetra.TetraType := MyUnit.TypUnit;
    Tetra.TetraID := MyUnit.UID;
  end; // else

  // Treatment for taxonomic entities (transitory no Unit!)
  {if ( ( MyUnit = nil ) and ( MyEntity <> nil ) and
       ( MyEntity.TetraTip = tp_tax ) ) then
  begin
    Tetra.Genr := MyEntity;
    Tetra.ASet := nil;
    Tetra.Main := nil;
    Tetra.ASin := nil;
    Tetra.ADex := nil;
    Tetra.TetraType := tt_tax;
    Tetra.TetraID := UID;
  end;}
  Result := Tetra;
end; // _____________________________________________________GetTetrahedronByUID

procedure          TTAH.ExtractFirstTwoChildren(
  Children:        String;
  SortList:        String;
  var LeftPos:     Integer;
  var RightPos:    Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ExtractFirstTwoChildren
  * Extract first two children according to sortlist *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbItem:          Integer;
  Posit:           Integer;
  SmallPos:        Integer;
  ValPos:          Integer;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
begin
  // Extract the children
  NbItem := 0;
  repeat
    Posit := Pos( cSemi, Children );
    Inc( NbItem );
    if ( Posit > 0 ) then
    begin
      Child[ NbItem ] := StrToInt( Copy( Children, 1, Posit - 1 ) );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      Child[ NbItem ] := StrToInt( Children );
      Children := cEmpty;
    end;
  until ( Children = cEmpty );

  // Extract the order positions
  NbItem := 0;
  repeat
    Posit := Pos( cSemi, SortList );
    Inc( NbItem );
    if ( Posit > 0 ) then
    begin
      Order[ NbItem ] := StrToInt( Copy( SortList, 1, Posit - 1 ) );
      SortList := Copy( SortList, Posit + 1, Length( SortList ) );
    end else
    begin
      Order[ NbItem ] := StrToInt( SortList );
      SortList := cEmpty;
    end;
  until ( SortList = cEmpty );

  // Search the first position
  ValPos := 10000;
  SmallPos := 0;
  for Indx := 1 to NbItem do
  begin
    if ( Order[ Indx ] < ValPos ) then
    begin
      ValPos := Order[ Indx ];
      SmallPos := Indx;
    end;
  end; // for
  LeftPos := Child[ SmallPos ];

  // Search the second position
  Order[ SmallPos ] := 10000;
  ValPos := 10000;
  SmallPos := 0;
  for Indx := 1 to NbItem do
  begin
    if ( Order[ Indx ] < ValPos ) then
    begin
      ValPos := Order[ Indx ];
      SmallPos := Indx;
    end;
  end; // for
  RightPos := Child[ SmallPos ];
end; // _________________________________________________ExtractFirstTwoChildren

function           TTAH.TetraTypeOf(
  TetSeq:          tTip )
  :                TTetra;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TetraTypeOf
  * Retrieve the type of a tetrahedron *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := tt_undef;
  if ( TetSeq = tp_single ) then
    Result := tt_single
  else
  if ( TetSeq = tp_genpair ) then
    Result := tt_pair
  else
  if ( TetSeq = tp_pair ) then
    Result := tt_pair
  else
  if ( TetSeq = tp_pset ) then
    Result := tt_pset
  else
  if ( TetSeq = tp_set ) then
    Result := tt_set
  else
  if ( TetSeq = tp_ref ) then
    Result := tt_ref
  else
  if ( TetSeq = tp_lex ) then
    Result := tt_lex
  else
  if ( TetSeq = tp_del ) then
    Result := tt_del
  else
  if ( TetSeq = tp_tax ) then
    Result := tt_tax
  else;
end; // _____________________________________________________________TetraTypeOf

function           TTAH.GetEntityByPos(
  Position:        Integer )
  :                TEntity;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetEntityByPos
  * Retrieve an entity by its position *
  Description:
  This method retrieves the entity. If this entity does not exist, a nil
  value is returned.</P>
  This method is not really necessary in the actual implementation. But it may
  be preferable to use it rather than to bypass it, in case a future different
  implementation is realized for optimisation purpose.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := nil;
  if ( Position < 1 ) or ( Position > FTotTAH ) then
    Exit;

  // Return the requested entity, may be nil il it does not exist
  Result := Self.FEntity[ Position ];
end; // __________________________________________________________GetEntityByPos

function           TTAH.DoTA98(
  TID:             Integer ):
                   Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DoTA98
  * Define an entity as member of TA98 *
  Description:
  Entities below or equal to 7444 are the source entities of TA98. Some of them
  appearing multiple times in the source version, they have been duplicated
  using identifiers above 7444. These identifiers are listed and recognized as
  being part of TA98.</P>
  This function returns true when the given TID identifier defines a TA98
  entity, false otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  NbTA98           = 223;
  cTA98TID:        Array[ 1 .. NbTA98 ] of Integer =
                   ( 99,    887,   1433,  3139,  3140,
                     5068,  6322,  6367,  6559,  7360,
                     8154,  8158,  8529,  8907,  8946,
                     9115,  9133,  9601,  9602,  9460,
                     10421, 11201, 11296, 11341, 11342,              // 25
                     11345, 11348, 11349, 11427, 12454,
                     12456, 12457, 12458, 12459, 12460,
                     12461, 12462, 12463, 12464, 12465,
                     12466, 12467, 12468, 12469, 12470,
                     12471, 12472, 12473, 12474, 12475,              // 50
                     12476, 12477, 12478, 12479, 12480,
                     12481, 12482, 12483, 12486, 12487,
                     12488, 12489, 12490, 12491, 12492,
                     12493, 12494, 12495, 12496, 12497,
                     12498, 12499, 12500, 12501, 12502,              // 75
                     12503, 12504, 12505, 12506, 12507,
                     12508, 12509, 12510, 12511, 12512,
                     12513, 12514, 12515, 12516, 12517,
                     12518, 12519, 12523, 12524, 12528,
                     12529, 12530, 12532, 12533, 12534,              // 100
                     12535, 12536, 12537, 12538, 12540,
                     12544, 12545, 12546, 12548, 12549,
                     12550, 12551, 12552, 12553, 12559,
                     12561, 12562, 12563, 12564, 12565,
                     12566, 12567, 12568, 12569, 12570,              // 125
                     12571, 12572, 12573, 12586, 12587,
                     12589, 12590, 12591, 12592, 12593,
                     12594, 12595, 12596, 12597, 12598,
                     12599, 12600, 12601, 13111, 13112,
                     13113, 13114, 13115, 13116, 13117,              // 150
                     13118, 13119, 13120, 13121, 13122,
                     13123, 13124, 13125, 13126, 13127,
                     13128, 13130, 13131, 13134, 13136,
                     13143, 13144, 13146, 13147, 13148,
                     13150, 13151, 13152, 13154, 13155,              // 175
                     13156, 13158, 13159, 13160, 13162,
                     13163, 13164, 13166, 13167, 13168,
                     12170, 13171, 13177, 13613, 13614,
                     13615, 13616, 13617, 13618, 13619,
                     13620, 13621, 13622, 13623, 13624,              // 200
                     13625, 13626, 13627, 13628, 13629,
                     13630, 13631, 13632, 13633, 13634,
                     13635, 13636, 13637, 13638, 13639,
                     13640, 13641, 13642, 13643, 13644,
                     13645, 13646, 13648 );                                 // 225
var
  Indx: Integer;
begin
  Result := True;
  if ( ( TID > 0 ) and ( TID <= Tot98 ) ) then
    Exit;
  for Indx := 1 to NbTA98 do
  begin
    if ( TID = cTA98TID[ Indx ] ) then
      Exit;
  end; // for on all TA98 entities above Tot98 = 7444
  Result := False;
end; // __________________________________________________________________DoTA98

function           TTAH.GetTA98EntityByTID(
  TID:             Integer )
  :                TEntity;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTA98EntityByTID
  * Retrieve a TA98 entity from the pair owning the specified TID *
  Description:
  This method considers the unit owning the specified entity and examines
  all its member entities, one of them being possibly a TA98 entity. If this
  happens, this entity is returned, unless it is a duplicate then the source
  entity is returned. The level of the duplicate always prevails against the
  level of the entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTID:           Integer;
  Actual:          TEntity;
  MyUnit:          TUnit;
  AltUnit:         TUnit;
begin
  Result := nil;
  Actual := GetEntityByTID( TID );
  MyUnit := GetUnitByPos( Actual.Tetra );
  if ( MyUnit <> nil ) then
  begin
    MyTID := MyUnit.Generator;
    if ( DoTA98( MyTID ) ) then
    begin
      if ( Actual.TetraTip = tp_dup ) then
      begin
        Result := Actual; //GetEntityByTID( Actual.Reference );    Temporary
        if ( Result <> nil ) then
          Result.Level := MyUnit.Indent;
      end else
        Result := GetEntityByTID( MyTID );
      Exit;
    end;
    MyTID := MyUnit.Main;
    if ( DoTA98( MyTID ) ) then
    begin
      if ( Actual.TetraTip = tp_dup ) then
      begin
        Result := GetEntityByTID( Actual.Reference );
        Result.Level := MyUnit.Indent;
      end else
        Result := GetEntityByTID( MyTID );
      Exit;
    end;
    MyTID := MyUnit.ASet;
    if ( DoTA98( MyTID ) ) then
    begin
      if ( Actual.TetraTip = tp_dup ) then
      begin
        Result := GetEntityByTID( Actual.Reference );
        Result.Level := MyUnit.Indent;
      end else
        Result := GetEntityByTID( MyTID );
      Exit;
    end;
  end;
end; // ______________________________________________________GetTA98EntityByTID

function           tTAH.GetUnitByPos(
  Position:        Integer )
  :                TUnit;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetUnitByPos
  * Retrieve a unit by its position *
  Description:
  This method retrieves the unit. If this unit does not exist, a nil
  value is returned.</P>
  This method is not really necessary in the actual implementation. But it may
  be preferable to use it rather than to bypass it, in case a future different
  implementation is realized for optimisation purpose.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := nil;
  if ( Position < 1 ) or ( Position > FTotUnit ) then
    Exit;

  // Return the requested entity, may be nil if it does not exist
  Result := Self.FUnit[ Position ];
end; // ____________________________________________________________GetUnitByPos

function           TTAH.GetListEntityByP4(
  TID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListEntityByP4
  * Get a list of entities by P4 flag under a specified entity *
  Description:
  This method builds a semi-column separated string of all TID of the entities
  located below in the partonomy under the specified entity, presenting
  a P4 flag.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotChildren:     Integer;
  Posit:           Integer;
  MyTID:           Integer;
  Children:        String;
  Child:           String;
  MyList:          String;
  Actual:          TEntity;
begin

  // Check actual entity for the P4 flag, exit if present
  Result := cEmpty;
  Actual := Self.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;
  if ( Actual.ListPart = cTypeListPage[ li_part4 ] ) then
  begin
    Result := IntToStr( TID );
    Exit;
  end;

  // Get children and their number
  TotChildren := Actual.NbPartC;
  Children := Actual.PartCh;
  while ( Children <> cEmpty ) do
  begin

    // Search the identifier of the next child
    Posit := Pos( cSemi, Children );
    if Posit > 0 then
    begin
      Child := Copy( Children, 1, Posit - 1 );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      Child := Children;
      Children := cEmpty;
    end;
    MyTID := StrToInt( Child );

    // Recursively search for P4 flag
    if ( MyTID > 0 ) then
      MyList := GetListEntityByP4( MyTID );
      if ( MyList <> cEmpty ) then
        if ( Result <> cEmpty ) then
          Result := Result + cSemi + MyList
        else
          Result := MyList;

  end; // while ( Children <> cEmpty )
end; // _______________________________________________________GetListEntityByP4

function           TTAH.GetListEntityByP3(
  TID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListEntityByP3
  * Get a list of entities by P3 flag under a specified entity *
  Description:
  This method builds a semi-column separated string of all TID of the entities
  located below in the partonomy under the specified entity, presenting
  a P3 flag.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotChildren:     Integer;
  Posit:           Integer;
  MyTID:           Integer;
  Children:        String;
  Child:           String;
  MyList:          String;
  Actual:          TEntity;
begin

  // Check actual entity for the P3 flag, exit if present
  Result := cEmpty;
  Actual := Self.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;
  if ( Actual.ListPart = cTypeListPage[ li_part3 ] ) then
  begin
    Result := IntToStr( TID );
    Exit;
  end;

  // Get children and their number
  TotChildren := Actual.NbPartC;
  Children := Actual.PartCh;
  while ( Children <> cEmpty ) do
  begin

    // Search the identifier of the next child
    Posit := Pos( cSemi, Children );
    if Posit > 0 then
    begin
      Child := Copy( Children, 1, Posit - 1 );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      Child := Children;
      Children := cEmpty;
    end;
    MyTID := StrToInt( Child );

    // Recursively search for P3 flag
    if ( MyTID > 0 ) then
      MyList := GetListEntityByP3( MyTID );
      if ( MyList <> cEmpty ) then
        if ( Result <> cEmpty ) then
          Result := Result + cSemi + MyList
        else
          Result := MyList;

  end; // while ( Children <> cEmpty )
end; // _______________________________________________________GetListEntityByP3

function           TTAH.GetListEntityByT4(
  TID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListEntityByT4
  * Get a list of entities by T4 flag for taxonomy *
  Description:
  This method builds a semi-column separated string of all TID of the entities
  located below in the taxonomy under the specified entity, presenting
  a T4 flag.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotChildren:     Integer;
  Posit:           Integer;
  MyTID:           Integer;
  Children:        String;
  Child:           String;
  MyList:          String;
  Actual:          TEntity;
begin

  // Check actual entity for the T4 flag, exit if present
  Result := cEmpty;
  Actual := Self.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;
  if ( Actual.ListTax = cTypeListPage[ li_tax4 ] ) then
  begin
    Result := IntToStr( TID );
    Exit;
  end;

  // Get children and their number
  TotChildren := Actual.NbTaxC;
  Children := Actual.TaxCh;
  while ( Children <> cEmpty ) do
  begin

    // Search the next child
    Posit := Pos( cSemi, Children );
    if Posit > 0 then
    begin
      Child := Copy( Children, 1, Posit - 1 );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      Child := Children;
      Children := cEmpty;
    end;
    MyTID := StrToInt( Child );

    // Recursively search for T4 flag
    if ( MyTID > 0 ) then
      MyList := GetListEntityByT4( MyTID );
      if ( MyList <> cEmpty ) then
        if ( Result <> cEmpty ) then
          Result := Result + cSemi + MyList
        else
          Result := MyList;

  end; // while
end; // _______________________________________________________GetListEntityByT4

function           TTAH.GetListEntityByT3(
  TID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListEntityByT3
  * Get a list of entities by T3 flag for taxonomy *
  Description:
  This method builds a semi-column separated string of all TID of the entities
  located below in the taxonomy under the specified entity, presenting
  a T3 flag.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotChildren:     Integer;
  Posit:           Integer;
  MyTID:           Integer;
  Children:        String;
  Child:           String;
  MyList:          String;
  Actual:          TEntity;
begin

  // Check actual entity for the T3 flag, exit if present
  Result := cEmpty;
  Actual := Self.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;
  if ( Actual.ListTax = cTypeListPage[ li_tax3 ] ) then
  begin
    Result := IntToStr( TID );
    Exit;
  end;

  // Get children and their number
  TotChildren := Actual.NbTaxC;
  Children := Actual.TaxCh;
  while ( Children <> cEmpty ) do
  begin

    // Search the next child
    Posit := Pos( cSemi, Children );
    if Posit > 0 then
    begin
      Child := Copy( Children, 1, Posit - 1 );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      Child := Children;
      Children := cEmpty;
    end;
    MyTID := StrToInt( Child );

    // Recursively search for T3 flag
    if ( MyTID > 0 ) then
      MyList := GetListEntityByT3( MyTID );
      if ( MyList <> cEmpty ) then
        if ( Result <> cEmpty ) then
          Result := Result + cSemi + MyList
        else
          Result := MyList;
  end; // while
end; // _______________________________________________________GetListEntityByT3

procedure          TTAH.GetPositionsByGen(
  MyTID:           Integer;
  var NbPos:       Integer;
  var MyPos:       Array of Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetPositionsByGen
  * Retrieve all generated entities for a specified generator *
  Description:
  This method searches for all entities for which the present entity acts as
  a generator. A sequential scan of all TAH entities is necessary in order
  to guaranty a definitive solutions. In principle, no more than 2 entities
  may have a common generator!</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  MyUnit:          TUnit;
begin
  NbPos := 0;
  for Indx := 1 to Self.TotUnit do
  begin
    MyUnit := Self.GetUnitByPos( Indx );
    if ( MyUnit <> nil ) then
    begin
      case MyUnit.TypUnit of
        tt_set, tt_pset:
          begin
            if ( MyUnit.ASet = MyTID ) then
            begin
              MyPos[ NbPos ] := Indx;
              Inc( NbPos );
            end else
            if ( MyUnit.Generator = MyTID ) then
            begin
              MyPos[ NbPos ] := Indx;
              Inc( NbPos );
            end;
          end;
        tt_pair:
          begin
            if ( MyUnit.Generator = MyTID ) then
            begin
              MyPos[ NbPos ] := Indx;
              Inc( NbPos );
            end;
          end;
      end; // case on certain unit types
    end;
  end; // for
end; // _______________________________________________________GetPositionsByGen

procedure          tTAH.LgCombination(
  LgComb:          tLgComb );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LgCombination
  * Decode the languages *   )
  Description:
  Depending on the value of the argument, this procedure defines the TAH
  variables for the languages, applicable to all pages of the website:
  - Main language or left colunmn (MainLang),
  - Subsidiary language or right column (SubstLang),
  - Display language for presentation (DisLanguage).</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  // Decode the applicable languages
  case LgComb of
    cb_LAENEN:
      begin
        Self.MainLang := lt_Latin;
        Self.SubstLang := lt_English;
        Self.DisLanguage := lt_English;
      end;
    cb_LAFREN:
      begin
        Self.MainLang := lt_Latin;
        Self.SubstLang := lt_French;
        Self.DisLanguage := lt_English;
      end;
    cb_LAESEN:
      begin
        Self.MainLang := lt_Latin;
        Self.SubstLang := lt_Spanish;
        Self.DisLanguage := lt_English;
      end;
    cb_LARUEN:
      begin
        Self.MainLang := lt_Latin;
        Self.SubstLang := lt_Russian;
        Self.DisLanguage := lt_English;
      end;
    cb_ENLAEN:
      begin
        Self.MainLang := lt_English;
        Self.SubstLang := lt_Latin;
        Self.DisLanguage := lt_English;
      end;
    cb_FRLAFR:
      begin
        Self.MainLang := lt_French;
        Self.SubstLang := lt_Latin;
        Self.DisLanguage := lt_French;
      end;
    cb_ESLAES:
      begin
        Self.MainLang := lt_Spanish;
        Self.SubstLang := lt_Latin;
        Self.DisLanguage := lt_Spanish;
      end;
    cb_RULARU:
      begin
        Self.MainLang := lt_Russian;
        Self.SubstLang := lt_Latin;
        Self.DisLanguage := lt_Russian;
      end;
    cb_FRENFR:
      begin
        Self.MainLang := lt_French;
        Self.SubstLang := lt_English;
        Self.DisLanguage := lt_French;
      end;
    cb_ESENES:
      begin
        Self.MainLang := lt_Spanish;
        Self.DisLanguage := lt_English;
        Self.MainLang := lt_Spanish;
      end;
    cb_RUENRU:
      begin
        Self.MainLang := lt_Russian;
        Self.SubstLang := lt_English;
        Self.DisLanguage := lt_Russian;
      end;
    cb_FRESFR:
      begin
        Self.MainLang := lt_French;
        Self.SubstLang := lt_Spanish;
        Self.DisLanguage := lt_French;
      end;
    cb_FRRUFR:
      begin
        Self.MainLang := lt_French;
        Self.SubstLang := lt_Russian;
        Self.DisLanguage := lt_French;
      end;
  end; // case on all language combinations

  // Other options
  // Self.MainLang := lt_Latin;
  // Self.MainLang := lt_English;
  // Self.MainLang := lt_French;
  // Self.MainLang := lt_Spanish;
  // Self.MainLang := lt_Russian;
  // Self.SubstLang := lt_Latin;
  // Self.SubstLang := lt_English;
  // Self.SubstLang := lt_French;
  // Self.SubstLang := lt_Spanish;
  // Self.SubstLang := lt_Russian;
  // Self.DisLanguage := lt_English;
  // Self.DisLanguage := lt_French;
  // Self.DisLanguage := lt_Spanish;
  // Self.DisLanguage := lt_Russian;
end; // ___________________________________________________________LgCombination

procedure          tTAH.InitFilenames;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ InitFilenames
  * Initialize all filenames *
  Description:</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Dir:             String;
begin
  Dir := GetCurrentDir;
  Self.fUnitFileName := Dir + ReDirExport + cUnitFileName;
  Self.fLAFileName := Dir + ReDirExport + cLAFileName;
  Self.fENFileName := Dir + ReDirExport + cENFileName;
  Self.fFRFileName := Dir + ReDirExport + cFRFileName;
  Self.fESFileName := Dir + ReDirExport + cESFileName;
  Self.fRUFileName := Dir + ReDirExport + cRUFileName;
  Self.fITFileName := Dir + ReDirExport + cITFileName;
  Self.fGEFileName := Dir + ReDirExport + cGEFileName;
  Self.fPTFileName := Dir + ReDirExport + cPTFileName;
  Self.fMDFileName := Dir + ReDirExport + cMDFileName;
  Self.fDefENFilename := Dir + ReDirExport + cDefENFileName;
  Self.fDefFRFilename := Dir + ReDirExport + cDefFRFileName;
  Self.fDefESFilename := Dir + ReDirExport + cDefESFileName;
  Self.fDefRUFilename := Dir + ReDirExport + cDefRUFileName;
  Self.fLADicoFilename := Dir + ReDirExport + cLADicoFilename;
  Self.fFixTradFilename := Dir + ReDirExport + cFixTradFilename;

  Self.fSignatures.Filename := Dir + ReDirExport + cListFileName;
  Self.fNotes.FileName := Dir + ReDirExport + cNotesFileName;
  Self.fDocums.FileName := Dir + ReDirExport + cDocumFileName;
  Self.fTA98List.Filename := Dir + ReDirExport + cTA98ListFilename;
  Self.fFMA.Filename := Dir + ReDirExport + cTAFMAFilename;
  Self.fComments.Filename := Dir + ReDirExport + cCommFilename;
end; // ___________________________________________________________InitFilenames

procedure          tTAH.BuildUnit;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildUnit
  * Build the units from UNIT table *
  Description:
  This procedure reads the extracted UNIT file from TAH database and builds
  the array of all existing units. Units are stored at a position equal
  to their UID.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyValue:         Integer;
  Indx:            Integer;
  IOR:             Integer;
  MyUID:           Integer;
  MaxUID:          Integer;
  MaxTID:          Integer;
  Posit:           Integer;
  MyTID:           Integer;
  NewEntity:       Integer;
  MyVoc:           Integer;
  Line:            String;
  MyLine:          String;
  FileName:        String;
  InFile:          TextFile;
  MyEntity:        tEntity;
  MyUnit:          tUnit;
  ChildUnit:       tUnit;
  FatherUnit:      tUnit;
  Father98Unit:    tUnit;
  FatherTaxUnit:   tUnit;
  ChildType:       tTetra;
  FatherType:      tTetra;
  Father98Type:    tTetra;
  FatherTaxType:   tTetra;
  Indy:            tTip;
begin
  // Open input file in text format
  FileName := fUnitFileName;
  AssignFile( Infile, FileName );

  // Define the array for entities
  MaxTID := 0;
  MaxUID := 24999;
  Self.FTotUnit := MaxUID;
  SetLength( Self.fUnit, Self.fTotUnit + 1 );

  // Loop on all lines of input file and prepare splitting
  Reset( InFile );
  while not EOF( InFile ) do
  begin

    // Read the next line of text
    {$I-}
    Readln( InFile, Line );
    IOR := IOResult;
    {$I+}
    if ( IOR = 0 ) then
    begin

      // Retrieve TID
      MyLine := Line;
      MyUID := 0;
      Posit := Pos( CurSep, MyLine );
      if ( Posit > 0 ) then
        MyUID := StrToInt( Copy( MyLine, 1, Posit - 1 ) );
      if ( MyUID = 5111 ) then
        MyUID := MyUID;
      if ( MyUID > MaxUID ) then
        Break;

      MyLine := Copy( MyLine, Posit + 1, Length( MyLine ) );
      FUnit[ MyUID ] := tUnit.Create( MyUID );

      // Load entity
      FUnit[ MyUID ].DecodeUnit( MyLine );

      // Compute highest TID
      if ( FUnit[ MyUID ].Generator > MaxTID ) then
        MaxTID := FUnit[ MyUID ].Generator;
      if ( FUnit[ MyUID ].ASet > MaxTID ) then
        MaxTID := FUnit[ MyUID ].Aset;
      if ( FUnit[ MyUID ].Main > MaxTID ) then
        MaxTID := FUnit[ MyUID ].Main;
      if ( FUnit[ MyUID ].Left > MaxTID ) then
        MaxTID := FUnit[ MyUID ].Left;
      if ( FUnit[ MyUID ].Right > MaxTID ) then
        MaxTID := FUnit[ MyUID ].Right;
    end;
  end; // while on the raw source file of units
  Self.FTotTAH := MaxTID;

  // Close the reading of source file
  CloseFile( InFile );

  // Set the vocabulary property
  for Indx := 1 to MaxUID do
  begin
    MyUnit := FUnit[ Indx ];
    if ( MyUnit = nil ) then
      Continue;
    MyVoc := MyUnit.Reference;
    if ( ( MyUnit.TypUnit = tt_Voc ) and
         ( MyVoc > 0 ) and ( MyVoc < 25000 ) ) then
      FUnit[ MyVoc ].Vocabulary := Indx;
  end; // for on all units
end; // _______________________________________________________________BuildUnit

procedure          TTAH.BuildEntity;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildEntity
  * Build the TAH entities *
  Description:
  For each unit, the corresponding virtual entities are created and filled.
  Any unit may correspond to 1 to 5 entities. These entities are
  absent in the database and should be instanciated by this procedure.</P>
  Temporarilly, all units are not present in the database and are represented
  directly by their constituting entities, sharing a common UID: then, the
  above operation does not take place.</P>
  The instanciation procedure creates unconditionally for each entity a subset
  of 8 fields for each entity, corresponding to the partonomic ancestor, the
  taxonomic ancestor and the unit reference. These fields are necessary for
  the inversion of the hierarchies: determining the set of children of each
  entity in both hierarchies.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyValue:         Integer;
  Indx:            Integer;
  IOR:             Integer;
  MyUID:           Integer;
  MaxUID:          Integer;
  MaxTID:          Integer;
  Posit:           Integer;
  MyTID:           Integer;
  NewEntity:       Integer;
  Line:            String;
  MyLine:          String;
  FileName:        String;
  InFile:          TextFile;
  MyEntity:        tEntity;
  ChildUnit:       tUnit;
  FatherUnit:      tUnit;
  Father98Unit:    tUnit;
  FatherTaxUnit:   tUnit;
  ChildType:       tTetra;
  FatherType:      tTetra;
  Father98Type:    tTetra;
  FatherTaxType:   tTetra;
  Indy:            tTip;
begin

  // Define the array for entities
  SetLength( Self.FEntity, Self.FTotTAH + 1 );

  // Second part: expansion of all units in the virtual entities
  // Exclusively the following 8 fields are created:
  // - TID: unique entity identifier
  // - NewUnit: flag for virtual entity (transitory variable)
  // - Tetra: unique unit identifier to which the created entity belongs
  // - TetraTip: type of entity within unit (see type tTip)
  // - PartAnc: unique partonomic ancestor
  // - PartSeq: sequential position of partonomic ancestor
  // - TaxAnc: unique taxonomic ancestor
  // - TaxSeq: sequential position of taxonomic ancestor

  // Build all the entities for each present unit
  for Indx := 0 to Self.fTotUnit do
  begin
    if ( FUnit[ Indx ] <> nil ) then
    begin

      // Search for ancestor
      ChildUnit := FUnit[ Indx ];
      ChildType := ChildUnit.TypUnit;
      FatherUnit := GetUnitByPos( ChildUnit.Parto );
      Father98Unit := GetUnitByPos( ChildUnit.Part98 );
      FatherTaxUnit := GetUnitByPos( ChildUnit.Taxo );
      MyValue := ChildUnit.Generator;
      FatherType := tt_undef;
      Father98Type := tt_undef;
      FatherTaxType := tt_undef;
      if ( Indx = 5885 ) then
        MyValue := MyValue;
      if ( ( FatherUnit <> nil ) or
           ( FatherTaxUnit <> nil ) or
           ( Father98Unit <> nil  ) ) then
      begin
        if ( FatherUnit <> nil ) then
          FatherType := FatherUnit.TypUnit;
        if ( Father98Unit <> nil ) then
          Father98Type := Father98Unit.TypUnit;
        if ( FatherTaxUnit <> nil ) then
          FatherTaxType := FatherTaxUnit.TypUnit;
      end else
      begin
        if ( ( ChildType <> tt_lex ) and
             ( ChildType <> tt_tax ) and
             ( ChildType <> tt_voc ) and
             ( ChildType <> tt_dup ) and
             ( ChildType <> tt_del ) and
             ( ChildType <> tt_int ) and
             ( ChildType <> tt_trans ) and
             ( Indx <> TATopPos ) ) then
        begin
          MyEntity := MyEntity;        // Temporary: missing father unit
          Continue;                    // This should not occur in final version
        end;
      end;

      // Build a single entity
      if ( ChildType = tt_single ) then
      begin
        MyEntity := TEntity.Create;
        MyEntity.Link := pw_Undef;            // necessary, bad initial value!!!
        MyEntity.Level := lv_undef;
        MyEntity.TID := ChildUnit.Generator;
        MyEntity.Tetra := Indx;
        MyEntity.TetraTip := tp_single;
        MyEntity.Level := lv_undef;
        if ( ( ChildUnit.Broken ) and ( FatherUnit <> nil ) ) then
        begin
          MyEntity.PartAnc := FatherUnit.Generator;
          MyEntity.PartSeq := ChildUnit.SeqPart;
        end else
        begin
          if ( FatherType = tt_single ) then
          begin
            MyEntity.PartAnc := FatherUnit.Generator;
            MyEntity.PartSeq := ChildUnit.SeqPart;
          end else
          if ( FatherType in [ tt_set, tt_mset ] ) then
          begin
            MyEntity.PartAnc := FatherUnit.ASet;
            MyEntity.PartSeq := ChildUnit.SeqPart;
          end else
          begin
            MyEntity.PartAnc := ChildUnit.Parto;
            MyEntity.PartSeq := ChildUnit.SeqPart + 2;
          end;
        end;
        if ( FatherTaxUnit <> nil ) then
          MyEntity.TaxAnc := FatherTaxUnit.Generator
        else
          MyEntity.TaxAnc := ChildUnit.Taxo;
        MyEntity.TaxSeq := ChildUnit.SeqTax;
        NewEntity := ChildUnit.Generator;
        FEntity[ NewEntity ] := MyEntity;
      end else

      // Build a taxonomic entity, a vocabulary entity or an interface entity
      if ( ChildType in [ tt_tax, tt_voc, tt_int ] ) then
      begin
        MyEntity := TEntity.Create;
        MyEntity.Tetra := Indx;
        MyEntity.Level := lv_undef;
        if ( ChildType = tt_tax ) then
        begin
          MyEntity.TetraTip := tp_tax;
          MyEntity.TypeEntity := to_undef;
        end else
        if ( ChildType = tt_int ) then
        begin
          MyEntity.TetraTip := tp_int;
          MyEntity.TypeEntity := to_non;
        end else
        begin
          MyEntity.TetraTip := tp_voc;
          MyEntity.TypeEntity := to_non;
        end;
        MyEntity.Link := pw_undef;
        MyEntity.PartAnc := ChildUnit.Parto;
        MyEntity.PartSeq := ChildUnit.SeqPart;
        if ( FatherTaxUnit <> nil ) then
          MyEntity.TaxAnc := FatherTaxUnit.Generator
        else
          MyEntity.TaxAnc := ChildUnit.Taxo;
        MyEntity.TaxSeq := ChildUnit.SeqTax;
        MyEntity.TID := ChildUnit.Generator;
        MyEntity.FID := ChildUnit.FID;
        MyEntity.Cod98 := ChildUnit.Cod98;
        NewEntity := ChildUnit.Generator;
        FEntity[ NewEntity ] := MyEntity;
      end else

      // Build a pair entity
      if ( ChildType = tt_pair ) then
      begin

        // Loop on all tips of a pair unit (four tips)
        for Indy := tp_genpair to tp_rightpair do
        begin

          // Common field values
          MyEntity := TEntity.Create;
          MyEntity.Tetra := Indx;
          MyEntity.TetraTip := Indy;
          MyEntity.TypeEntity := to_Undef;
          MyEntity.Level := lv_undef;
          MyEntity.Link := pw_undef;

          // Specific values by tip
          MyTID := 0;
          case Indy of
            tp_genpair:
              begin
                MyTID := ChildUnit.Generator;
                if ( FatherTaxUnit <> nil ) then
                  MyEntity.TaxAnc := FatherTaxUnit.Generator
                else
                  MyEntity.TaxAnc := ChildUnit.Taxo;
                MyEntity.TaxSeq := ChildUnit.SeqTax;
                MyEntity.PartSeq := ChildUnit.SeqPart;
                if ( FatherType in [ tt_pair ] ) then
                  MyEntity.PartAnc := FatherUnit.Generator
                else
                if ( FatherType in [ tt_pset ] ) then
                  MyEntity.PartAnc := FatherUnit.Aset
                else
                if ( FatherType in [ tt_set ] ) then
                  if ( ChildUnit.Broken ) then
                    MyEntity.PartAnc := FatherUnit.Generator;
              end;
            tp_pair:
              begin
                MyTID := ChildUnit.Main;
                if ( FatherType = tt_single ) then
                begin
                  MyEntity.PartAnc := FatherUnit.Generator;
                  MyEntity.PartSeq := ChildUnit.SeqPart;
                end else
                if ( FatherType in [ tt_pair, tt_pset ] ) then
                begin
                  MyEntity.PartAnc := FatherUnit.Main;
                  if ( ChildUnit.Broken ) then
                    MyEntity.PartAnc := FatherUnit.Generator;
                  MyEntity.PartSeq := ChildUnit.SeqPart + 2;
                end else
                if ( FatherType in [ tt_set, tt_mset ] ) then
                begin
                  MyEntity.PartAnc := FatherUnit.ASet;
                  MyEntity.PartSeq := ChildUnit.SeqPart;
                end;
              end;
            tp_leftpair:
              begin
                MyTID := ChildUnit.Left;
                MyEntity.PartAnc := ChildUnit.Main;
                MyEntity.PartSeq := 1;
                MyEntity.TaxAnc := ChildUnit.Generator;
                MyEntity.TaxSeq := 1;
              end;
            tp_rightpair:
              begin
                MyTID := ChildUnit.Right;
                MyEntity.PartAnc := ChildUnit.Main;
                MyEntity.PartSeq := 2;
                MyEntity.TaxAnc := ChildUnit.Generator;
                MyEntity.TaxSeq := 2;
              end;
          end; // case
          MyEntity.TID := MyTID;
          NewEntity := MyTID;
          FEntity[ NewEntity ] := MyEntity;
        end; // for on all entities of the pair
      end else

      // Build a pset entity
      if ( ChildType in [ tt_pset ] ) then
      begin

        // Loop on all tips of a pset unit (five tips)
        for Indy := tp_genpset to tp_rightpset do
        begin

          // Common field values
          MyEntity := tEntity.Create;
          MyEntity.Tetra := Indx;
          MyEntity.TetraTip := indy;
          MyEntity.TypeEntity := to_undef;
          MyEntity.Level := lv_undef;
          MyEntity.Link := pw_undef;

          // Specific values by tip
          MyTID := 0;
          case Indy of
            tp_genpset:
              begin
                MyTID := ChildUnit.Generator;
                if ( FatherTaxUnit <> nil ) then
                  MyEntity.TaxAnc := FatherTaxUnit.Generator
                else
                  MyEntity.TaxAnc := ChildUnit.Taxo;
                MyEntity.TaxSeq := ChildUnit.SeqTax;
              end;
            tp_setpset:
              begin
                MyTID := ChildUnit.ASet;
                if ( FatherType = tt_pair ) then
                begin
                  MyEntity.PartAnc := FatherUnit.Generator;
                  MyEntity.PartSeq := ChildUnit.SeqPart;
                end else
                if ( FatherType = tt_pset ) then
                begin
                  MyEntity.PartAnc := FatherUnit.ASet;
                  MyEntity.PartSeq := ChildUnit.SeqPart;
                end
              end;
            tp_pset:
              begin
                MyTID := ChildUnit.Main;
                if ( FatherType = tt_single ) then
                begin
                  MyEntity.PartAnc := FatherUnit.Generator;
                  MyEntity.PartSeq := ChildUnit.SeqPart;
                end else
                if ( FatherType = tt_pair ) then
                begin
                  MyEntity.PartAnc := FatherUnit.Main;
                  MyEntity.PartSeq := ChildUnit.SeqPart + 2;
                end else
                if ( FatherType = tt_pset ) then
                begin
                  MyEntity.PartAnc := FatherUnit.Main;
                  if ( ChildUnit.Broken ) then
                    MyEntity.PartAnc := FatherUnit.Generator;
                  MyEntity.PartSeq := ChildUnit.SeqPart + 2;
                end else
                if ( FatherType in [ tt_set, tt_mset ] ) then
                begin
                  MyEntity.PartAnc := FatherUnit.ASet;
                  MyEntity.PartSeq := ChildUnit.SeqPart;
                end;
              end;
            tp_leftpset:
              begin
                MyTID := ChildUnit.Left;
                MyEntity.PartAnc := ChildUnit.Main;
                MyEntity.PartSeq := 1;
                MyEntity.TaxAnc := ChildUnit.Aset;
                MyEntity.TaxSeq := 1;
              end;
            tp_rightpset:
              begin
                MyTID := ChildUnit.Right;
                MyEntity.PartAnc := ChildUnit.Main;
                MyEntity.PartSeq := 2;
                MyEntity.TaxAnc := ChildUnit.Aset;
                MyEntity.TaxSeq := 2;
              end;
          end; // case
          MyEntity.TID := MyTID;
          NewEntity := MyTID;
          FEntity[ NewEntity ] := MyEntity;
        end; // for on all entities of a pset
      end else

      // Build a set entity
      if ( ChildType in [ tt_set, tt_mset ] ) then
      begin

        // Loop on all tips of a set unit (two tips)
        for Indy := tp_genset to tp_set do
        begin

          // Common field values
          MyEntity := tEntity.Create;
          MyEntity.Tetra := Indx;
          MyEntity.TypeEntity := to_undef;
          if ( ( Indy = tp_set ) and ( ChildType = tt_mset ) ) then
          begin
            MyEntity.TetraTip := tp_mset;
            MyEntity.TypeEntity := to_MstImm;
          end else
            MyEntity.TetraTip := Indy;
          MyEntity.Level := lv_undef;
          MyEntity.Link := pw_undef;

          // Specific values by tip
          MyTID := 0;
          case Indy of
            tp_genset:
              begin
                MyTID := ChildUnit.Generator;
                if ( FatherTaxUnit <> nil ) then
                  MyEntity.TaxAnc := FatherTaxUnit.Generator
                else
                  MyEntity.TaxAnc := ChildUnit.Taxo;
                MyEntity.TaxSeq := ChildUnit.SeqTax;
              end;
            tp_set:
              begin
                MyTID := ChildUnit.ASet;
                if ( FatherType = tt_pair ) then
                begin
                  MyEntity.PartAnc := FatherUnit.ASet;
                  MyEntity.PartSeq := ChildUnit.SeqPart;
                end else
                if ( FatherType in [ tt_set, tt_mset ] ) then
                begin
                  if ( ChildUnit.Broken ) then
                  begin
                    MyEntity.PartAnc := FatherUnit.Generator;
                    MyEntity.PartSeq := ChildUnit.SeqPart;
                  end else
                  begin
                    MyEntity.PartAnc := FatherUnit.ASet;
                    MyEntity.PartSeq := ChildUnit.SeqPart;
                  end;
                end else
                if ( FatherType = tt_single ) then
                begin
                  MyEntity.PartAnc := FatherUnit.Generator;
                  MyEntity.PartSeq := ChildUnit.SeqPart;
                end else
                if ( FatherType = tt_pset ) then
                begin
                  if ( ChildUnit.Broken ) then
                  begin
                    MyEntity.PartAnc := FatherUnit.Generator;
                    MyEntity.PartSeq := ChildUnit.SeqPart;
                  end else
                  begin
                    MyEntity.PartAnc := FatherUnit.Main;
                    MyEntity.PartSeq := ChildUnit.SeqPart;
                  end;
                end;
              end;
          end; // case
          MyEntity.TID := MyTID;
          NewEntity := MyTID;
          FEntity[ NewEntity ] := MyEntity;
        end; // for on all entities of a set
      end else

      // Build a reference entity
      if ( ChildType = tt_ref ) then
      begin
        MyEntity := tEntity.Create;
        MyEntity.Tetra := Indx;
        MyEntity.TetraTip := tp_ref;
        MyEntity.TypeEntity := to_undef;
        MyEntity.Link := pw_undef;
        MyEntity.Reference := ChildUnit.Reference;
        MyEntity.TID := ChildUnit.Generator;
        if ( FatherUnit.TypUnit = tt_ref ) then
        begin
          MyEntity.PartAnc := FatherUnit.Generator;
          MyEntity.PartSeq := ChildUnit.SeqPart;
        end else
        if ( FatherUnit.TypUnit = tt_single ) then
        begin
          MyEntity.PartAnc := FatherUnit.Generator;
          MyEntity.PartSeq := ChildUnit.SeqPart;
        end else
        if ( FatherUnit.TypUnit = tt_set ) then
        begin
          if ( ChildUnit.Broken ) then
          begin
            MyEntity.PartAnc := FatherUnit.Generator;
            MyEntity.PartSeq := ChildUnit.SeqPart;
          end else
          begin
            MyEntity.PartAnc := FatherUnit.ASet;
            MyEntity.PartSeq := ChildUnit.SeqPart;
          end;
        end else
        begin
          MyEntity.PartAnc := FatherUnit.Main;
          MyEntity.PartSeq := ChildUnit.SeqPart + 2;
        end;
        NewEntity := ChildUnit.Generator;
        FEntity[ NewEntity ] := MyEntity;
      end else

      // Build a lexical reference entity
      if ( ChildType = tt_lex ) then
      begin
        MyEntity := tEntity.Create;
        MyEntity.Tetra := Indx;
        MyEntity.TetraTip := tp_lex;
        MyEntity.TypeEntity := to_mat;
        MyEntity.Link := pw_undef;
        MyEntity.TID := ChildUnit.Generator;
        MyEntity.Reference := ChildUnit.Reference;
        NewEntity := ChildUnit.Generator;
        FEntity[ NewEntity ] := MyEntity;
      end else

      // Build a duplicate entity (TA98 only)
      if ( ChildType = tt_dup ) then
      begin
        MyEntity := tEntity.Create;
        MyEntity.Tetra := Indx;
        MyEntity.TetraTip := tp_dup;
        MyEntity.TypeEntity := to_mat;
        MyEntity.Link := pw_undef;
        MyEntity.Level := lv_undef;
        MyEntity.TID := ChildUnit.Generator;
        MyEntity.Reference := ChildUnit.Reference;
        if ( ( Father98Unit <> nil ) ) then
        begin
          MyEntity.Anc98 := ChildUnit.Part98;
          MyEntity.Seq98 := ChildUnit.SeqPart98;
        end;
        NewEntity := ChildUnit.Generator;
        FEntity[ NewEntity ] := MyEntity;
      end else

      // Build a deleted entity
      if ( ChildType = tt_del ) then
      begin
        MyEntity := tEntity.Create;
        MyEntity.Tetra := Indx;
        MyEntity.TetraTip := tp_del;
        MyEntity.TypeEntity := to_undef;
        MyEntity.Link := pw_undef;
        MyEntity.Level := lv_undef;
        MyEntity.TID := ChildUnit.Generator;
        NewEntity := ChildUnit.Generator;
        FEntity[ NewEntity ] := MyEntity;
      end else

      // Build a wait entity
      if ( ChildType = tt_trans ) then
      begin
        MyEntity := tEntity.Create;
        MyEntity.Tetra := Indx;
        MyEntity.TetraTip := tp_wait;
        MyEntity.TypeEntity := to_undef;
        MyEntity.Link := pw_undef;
        MyEntity.Level := lv_undef;
        MyEntity.TID := Indx;
        NewEntity := Indx;
        FEntity[ NewEntity ] := MyEntity;
      end;
    end;
  end; // for
end; // _____________________________________________________________BuildEntity

procedure          tTAH.BuildTermsLA;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsLA
  * Collect all Latin terms *
  Description:
  This procedure reads the Latin terms raw file exported from the database,
  builds sequentially all term tLATerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  MyTID:           Integer;
  PastTID:         Integer;
  NbTerm:          Integer;
  Line:            String;
  Expr:            String;
  Trans:           String;
  FileName:        String;
  IndS:            tSynType;
  InFile:          TextFile;
  MyEntity:        tEntity;
  MyTerm:          tSingle;
begin
  // Open input file in text format, splitted or unsplitted
  FileName := Self.LAFileName;
  AssignFile( Infile, FileName );
  Reset( InFile );
  MyEntity := nil;
  PastTID := 0;
  SetLength( Self.FLAPlus, 0 );

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
      Posit := Pos( CurSep, Line );
      MyTID := StrToInt( Copy( Line, 1, Posit - 1 ) );
      if ( MyTID = 28823 ) then
        MyTID := MyTID;
      if ( MyTID <> PastTID ) then
        MyEntity := Self.GetEntityByTID( MyTID );
      if ( MyEntity <> nil ) then
      begin

        // Expected format is made of 14 fields:
        // TID¦LID¦UID¦Exp¦Obl¦Pref¦Adj¦Mdl¦Fix¦Dat¦Cat¦Src¦Int¦Lib
        MyTerm := tSingle.Create( lt_Latin );
        with MyTerm do
        begin
          Lgt := Length( Line );
          Posit := Pos( CurSep, Line );
          TID := MyTID;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          LID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          if ( Trans <> cEmpty ) then
            UID := StrToInt( Trans );
          Line := Copy( Line, Posit + 1, Lgt );
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
          Trans := Copy( Line, 1, Posit - 1 );
          IsModel := Trans = '1';
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          IsFix := Trans = '1';
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Update := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Expr := Copy( Line, 1, Posit - 1 );
          Category := st_Undef;
          for IndS := low( tSynType ) to Pred( High( tSynType ) ) do
          begin
            if cSynType[ IndS ] = Expr then
            begin
              Category := IndS;
              Break;
            end;
          end; // for
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Source := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          IntLgt := 0;
          if ( Posit - 1 > 0 ) then
            IntLgt := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Libelle := cEmpty;
          if ( Posit < Length( Line ) ) then
            Libelle := Copy( Line, Posit + 1, Lgt );
        end; // with MyTerm
        if ( MyTerm.Category in [ st_bas, st_RAT, st_irr ] ) then
          MyTerm.BuildFrom := bd_direct;
        MyEntity.LgCurrent := lt_Latin;
        MyEntity.AddTerm( MyTerm );
        PastTID := MyTID;

        // Add LA terms to the specific array of Latin
        if ( ( MyTerm.UID >= 0 ) and
             ( MyTerm.Category in
               [ st_Bas, st_Off, st_Of2, st_Of3, st_RAT ] ) ) then
        begin
          NbTerm := Length( Self.FLAPlus );
          Inc( NbTerm );
          SetLength( Self.FLAPlus, NbTerm  );
          Self.FLAPlus[ NbTerm - 1 ] := MyTerm;
        end;
      end;
    end;
  end; // while

  // Close the reading of source file
  CloseFile( InFile );
end; // ____________________________________________________________BuildTermsLA

procedure          TTAH.BuildTermsEN;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsEN
  * Collect all English terms for an entity *
  Description:
  This procedure reads the English terms raw file exported from the database,
  builds sequentially all term TLATerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  MyUID:           Integer;
  PastUID:         Integer;
  Line:            String;
  Expr:            String;
  FileName:        String;
  Trans:           String;
  InFile:          TextFile;
  IndS:            tSynType;
  MyEntity:        TEntity;
  MyTerm:          TSingle;
begin
  // Open input file in text format, splitted or unsplitted
  FileName := Self.ENFileName;
  AssignFile( Infile, FileName );
  Reset( InFile );
  MyEntity := nil;
  PastUID := 0;

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

      // Decode all the fields
      Posit := Pos( CurSep, Line );
      MyUID := StrToInt( Copy( Line, 1, Posit - 1 ) );
      if ( MyUID = 5885 ) then
        MyUID := MyUID;
      MyTerm := TSingle.Create( lt_English );
      MyTerm.UID := MyUID;
      MyTerm.DecodeTerm( Line );

      // Add the term to its entity
      MyEntity := Self.GetEntityByTID( MyTerm.TID );
      if ( MyEntity <> nil ) then
      begin
        MyEntity.LgCurrent := lt_English;
        MyEntity.AddTerm( MyTerm );
        PastUID := MyUID;
      end;
    end;
  end; // while

  // Close the reading of source file
  CloseFile( InFile );
end; // ____________________________________________________________BuildTermsEN

procedure          TTAH.BuildTermsFR;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsFR
  * Collect all French terms for an entity *
  Description:
  This procedure reads the French terms raw file exported from the database,
  builds sequentially all term tFRTerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  MyUID:           Integer;
  Line:            String;
  Past:            String;
  Expr:            String;
  FileName:        String;
  Trans:           String;
  IndS:            tSynType;
  InFile:          TextFile;
  MyEntity:        TEntity;
  MyTerm:          TSingle;
begin
  // Open input file in text format, splitted or unsplitted
  FileName := Self.FRFileName;
  AssignFile( Infile, FileName );
  Reset( InFile );
  MyEntity := nil;

  // Loop on all lines of input file and prepare splitting
  while not EOF( InFile ) do
  begin

    // Read the next line of text
    {$I-}
    Past := Line;
    Readln( InFile, Line );
    IOR := IOResult;
    {$I+}
    if ( IOR = 0 ) then
    begin

      // Decode all the fields
      Posit := Pos( CurSep, Line );
      MyUID := StrToInt( Copy( Line, 1, Posit - 1 ) );
      MyTerm := TSingle.Create( lt_French );
      MyTerm.UID := MyUID;
      MyTerm.DecodeTerm( Line );

      // Add the term to its entity
      MyEntity := Self.GetEntityByTID( MyTerm.TID );
      if ( MyUID = 6077 ) then
        MyUID := MyUID;
      if ( MyEntity <> nil ) then
      begin
        MyEntity.LgCurrent := lt_French;
        MyTerm.Effective := st_dab;
        MyEntity.AddTerm( MyTerm );
      end;
    end;
  end; // while

  // Close the reading of source file
  CloseFile( InFile );
end; // ____________________________________________________________BuildTermsFR

procedure          TTAH.BuildTermsES;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsES
  * Collect all Spanish terms for an entity *
  Description:
  This procedure reads the Spanish terms raw file exported from the database,
  builds sequentially all term TLATerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  MyUID:           Integer;
  Line:            String;
  Past:            String;
  Expr:            String;
  FileName:        String;
  Trans:           String;
  IndS:            tSynType;
  InFile:          TextFile;
  MyEntity:        TEntity;
  MyTerm:          TSingle;
begin
  // Open input file in text format, splitted or unsplitted
  FileName := Self.ESFileName;
  AssignFile( Infile, FileName );
  Reset( InFile );
  MyEntity := nil;

  // Loop on all lines of input file and prepare splitting
  while not EOF( InFile ) do
  begin

    // Read the next line of text
    {$I-}
    Past := Line;
    Readln( InFile, Line );
    IOR := IOResult;
    {$I+}
    if ( IOR = 0 ) then
    begin

      // Decode all the fields
      Posit := Pos( CurSep, Line );
      MyUID := StrToInt( Copy( Line, 1, Posit - 1 ) );
      MyTerm := TSingle.Create( lt_Spanish );
      MyTerm.UID := MyUID;
      MyTerm.DecodeTerm( Line );

      // Add the term to its entity
      MyEntity := Self.GetEntityByTID( MyTerm.TID );
      if ( MyUID = 12249 ) then
        MyUID := MyUID;
      if ( MyEntity <> nil ) then
      begin
        MyEntity.LgCurrent := lt_Spanish;
        MyEntity.AddTerm( MyTerm );
      end;
    end;
  end; // while

  // Close the reading of source file
  CloseFile( InFile );
end; // ____________________________________________________________BuildTermsES

procedure          TTAH.BuildTermsRU;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsRU
  * Collect all Russian terms for an entity *
  Description:
  This procedure reads the Russian terms raw file exported from the database,
  builds sequentially all term TLATerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  MyUID:           Integer;
  PastUID:         Integer;
  Count:           Integer;
  Line:            String;
  Past:            String;
  Expr:            String;
  FileName:        String;
  Trans:           String;
  MyStringList:    TStringList;
  IndS:            tSynType;
  InFile:          TextFile;
  MyEntity:        tEntity;
  MyTerm:          tSingle;
begin

  // Read the entire file with adequate encoding
  MyStringList := TStringList.Create;
  FileName := Self.RUFileName;
  MyStringList.LoadFromFile( FileName, TEncoding.UTF8 );
  PastUID := 0;
  Count := MyStringList.Count;
  for Indx := 0 to Count - 1 do
  begin
    Line := MyStringList[ Indx ];

    // Decode all the fields
    Posit := Pos( CurSep, Line );
    MyUID := StrToInt( Copy( Line, 1, Posit - 1 ) );
    MyTerm := TSingle.Create( lt_Russian );
    MyTerm.UID := MyUID;
    MyTerm.DecodeTerm( Line );

    // Add the term to its entity
    if ( MyUID <> PastUID ) then
      MyEntity := Self.GetEntityByTID( MyTerm.TID );
    if ( MyUID = 11777 ) then
      MyUID := MyUID;
    if ( MyEntity <> nil ) then
    begin
      MyEntity.LgCurrent := lt_Russian;
      MyEntity.AddTerm( MyTerm );
      PastUID := MyUID;
    end;
  end; // for on all lines
end; // ____________________________________________________________BuildTermsRU

procedure          TTAH.BuildTermsIT;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsIT
  * Collect all Italian terms for an entity *
  Description:
  This procedure reads the Italian terms raw file exported from the database,
  builds sequentially all term TLATerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  MyTID:           Integer;
  PastTID:         Integer;
  Line:            String;
  Past:            String;
  Expr:            String;
  FileName:        String;
  Trans:           String;
  IndS:            tSynType;
  InFile:          TextFile;
  MyEntity:        TEntity;
  MyTerm:          TSingle;
begin
  // Open input file in text format, splitted or unsplitted
  FileName := Self.ITFileName;
  AssignFile( Infile, FileName );
  Reset( InFile );
  MyEntity := nil;
  PastTID := 0;

  // Loop on all lines of input file and prepare splitting
  while not EOF( InFile ) do
  begin

    // Read the next line of text
    {$I-}
    Past := Line;
    Readln( InFile, Line );
    IOR := IOResult;
    {$I+}
    if ( IOR = 0 ) then
    begin
      Posit := Pos( CurSep, Line );
      Expr := Copy( Line, 1, Posit - 1 );
      if ( Expr = cEmpty ) then
        Expr := Expr;
      MyTID := StrToInt( Expr );
      if ( MyTID <> PastTID ) then
        MyEntity := Self.GetEntityByTID( MyTID );
      if MyEntity <> nil then
      begin

        // Expected format is made of 9 fields:
        // TID¦LID¦UID¦Exp¦Obl¦Dat¦Cat¦Src¦Lib
        MyTerm := TSingle.Create( lt_Italian );
        with MyTerm do
        begin
          Lgt := Length( Line );
          Posit := Pos( CurSep, Line );
          TID := MyTID;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          LID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          if ( Trans <> cEmpty ) then
            UID := StrToInt( Trans );
          Line := Copy( Line, Posit + 1, Lgt );
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
          Update := Copy( Line, 1, Posit - 1 );
          Line := Copy( Line, Posit + 1, Lgt );
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
          Posit := Pos( CurSep, Line );
          Source := Copy( Line, 1, Posit - 1 );
          Libelle := Copy( Line, Posit + 1, Lgt );
        end;
        MyEntity.LgCurrent := lt_Italian;
        MyEntity.AddTerm( MyTerm );
        PastTID := MyTID;
      end;
    end;
  end; // while

  // Close the reading of source file
  CloseFile( InFile );
end; // ____________________________________________________________BuildTermsIT

procedure          TTAH.BuildTermsGE;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsGE
  * Collect all German terms for an entity *
  Description:
  This procedure reads the German terms raw file exported from the database,
  builds sequentially all term TGETerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

end; // ____________________________________________________________BuildTermsGE

procedure          TTAH.BuildTermsPT;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsPT
  * Collect all Portugese terms for an entity *
  Description:
  This procedure reads the Portugese terms raw file exported from the database,
  builds sequentially all term TPTTerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

end; // ____________________________________________________________BuildTermsPT

procedure          TTAH.BuildTermsMD;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildTermsMD
  * Collect all universal terms *
  Description:
  This procedure reads the universal terms raw file exported from the database,
  builds sequentially all term TMDTerm objects, and call the AddTerm procedure
  in order to store this term into its corresponding entity.</P>
  Expected format is made of 12 fields:
  UID = Unit identifier
  LID = formula identifier (presently unused)
  Opt = TID of optional expansion
  Obl = TID of mandatory expansion
  Prf= TID of prefix expansion
  Adj = TID of adjective expansion
  Pre = TID of preposition expansion
  Sel = Type of preposition
  Dat = date of last change
  Cat = category of formula (mod, md1, md2, md3)
  Src = author of the formula
  Lib = basic universal formula, as string comma separated</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  MyUID:           Integer;
  PastUID:         Integer;
  NbTerm:          Integer;
  Line:            String;
  Past:            String;
  Expr:            String;
  FileName:        String;
  Trans:           String;
  IndS:            tSynType;
  InFile:          TextFile;
  MyEntity:        tEntity;
  MyTerm:          tSingle;
begin
  // Open input file in text format
  FileName := Self.MDFileName;
  AssignFile( Infile, FileName );
  Reset( InFile );
  MyEntity := nil;
  PastUID := 0;
  SetLength( Self.FFormula, 0  );

  // Loop on all lines of input file and prepare splitting
  while not EOF( InFile ) do
  begin

    // Read the next line of text
    {$I-}
    Past := Line;
    Readln( InFile, Line );
    IOR := IOResult;
    {$I+}
    if ( IOR = 0 ) then
    begin
      Lgt := Length( Line );
      Posit := Pos( CurSep, Line );
      Expr := Copy( Line, 1, Posit - 1 );
      MyUID := StrToInt( Expr );
      if ( MyUID = 5111 ) then
        Expr := Expr;

      // Decode all the fields
      MyTerm := tSingle.Create( lt_Universal );
      MyTerm.UID := MyUID;
      MyTerm.DecodeTerm( Line );

      // Add formula to its entity
      if ( MyUID <> PastUID ) then
        MyEntity := Self.GetUnitGenerator( MyUID );
      if ( MyEntity <> nil ) then
      begin
        MyEntity.LgCurrent := lt_Universal;
        MyEntity.AddTerm( MyTerm );
        PastUID := MyUID;

        // Add formula to the specific array of formulas
        NbTerm := Length( Self.FFormula );
        Inc( NbTerm );
        SetLength( Self.FFormula, NbTerm  );
        Self.FFormula[ NbTerm - 1 ] := MyTerm;
      end;
    end;
  end; // while

  // Close the reading of source file
  CloseFile( InFile );
end; // ____________________________________________________________BuildTermsMD

procedure          TTAH.MakeUnitPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeUnitPage
  * Build a single Unit Page *
  Description:
  This method checks if the specified entity is eligible for a Unit Page and
  builds this Unit Page.</P>
  Unit Pages are defined only for specific entities.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  LangDir:         String;
  Actual:          tEntity;
  TetraPage:       tTetraPage;
  Lang:            tLanguage;
  MyTetra:         tTetrahedron;
begin

  // Check for a non applicable entity
  // Unit Page is not applicable to taxonomic entities
  MyTetra := GetTetrahedronByTID( TID );
  if ( ( IsTaxonomy( TID ) and ( MyTetra = nil ) ) or
       ( ( MyTetra <> nil ) and
         ( MyTetra.TetraType = tt_undef ) ) ) then
    Exit;
  if ( MyTetra <> nil ) then
  begin
    case MyTetra.TetraType of
    tt_single, tt_tax, tt_int:
      Actual := MyTetra.Genr;
    tt_set, tt_mset:
      Actual := MyTetra.ASet;
    else
      Actual := MyTetra.Main;
    end; // case on all types of unit
  end else
    Actual := Self.GetEntityByTID( TID );

  // Build the Unit Page
  if ( Actual <> nil ) then
  begin
    TetraPage := tTetraPage.Create;
    CurrPage := TetraPage;
    TetraPage.PageName :=
      cTAH + IntToStr( MyTetra.TetraID ) + cSpace + tiTetraPageEN;
    TetraPage.Actual := Actual;
    TetraPage.CategPage := ca_Tetra;
    TetraPage.UID := MyTetra.TetraID;
    TetraPage.Build;

    // Write the file of the Unit Page
    LangDir := cLgShort[ MainLang ];
    if ( MainLang = lt_Latin ) then
      LangDir := LangDir + cLgShort[ SubstLang ];
    LangDir := LangDir + cSlash;
    TetraPage.Directory := cProjectDir + cAutoDir + cDirUnit + LangDir;
    TetraPage.FileName := cTAH + IntToStr( MyTetra.TetraID ) + cSpace +
                          cUnit + cSpace +
                          cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
    TetraPage.HelpDir := cProjectDir + cHelpDir;
    TetraPage.HelpFileName := HelpUnitPage;
    TetraPage.HelpIco := cHelpImg;
    TetraPage.WritePage;
  end;
end; // ____________________________________________________________MakeUnitPage

procedure          tTAH.MakeBatchUnit(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBatchUnit
  * Build recursively an entire batch of Unit Pages *
  Description:
  This method processes a found start section until the next stop section or
  the leaves of the hierarchy is reached. It generates recursively all the
  corresponding Unit Pages.</P>
  Warning: The unit is specified by the TID of one of its entities. The
  considered hierarchy is the partonomy for specific entities, and the taxonomy
  otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  TetID:           Integer;
  IsTax:           Boolean;
  Children:        String;
  AChild:          String;
  Actual:          tEntity;
  Child:           tEntity;
  TetraPage:       tTetraPage;
  Lang:            tLanguage;
  Tetra:           tTetrahedron;
begin
  // Recursive search in the section
  Actual := Self.GetEntityByTID( TID );
  if ( Actual <> nil ) then
  begin

      // Find children depending on type of hierarchy
      IsTax := Self.IsTaxonomy( TID );
      if ( IsTax ) then
        Children := Actual.TaxCh
      else
        Children := Actual.PartCh;

      // Skip specific entities (leaves) in taxonomy
      if ( not ( IsTax and ( Children = cEmpty ) ) ) then
      begin

        // Process all children
        while ( Children <> cEmpty ) do
        begin
          Posit := Pos( cSemi, Children );
          if ( Posit > 0 ) then
          begin
            AChild := Copy( Children, 1, Posit - 1 );
            Children := Copy( Children, Posit + 1, Length( Children ) );
          end else
          begin
            AChild := Children;
            Children := cEmpty;
          end;

          // Make recursive call
          Child := Self.GetEntityByPos( StrToInt( AChild ) );
          if ( Child <> nil ) then
            MakeBatchUnit( Child.TID );
        end; // while on all children
      end;

    // Search for the tetrahedron
    TetID := Actual.Tetra;
    MakeUnitPage( TetID );
  end;
end; // ___________________________________________________________MakeBatchUnit

procedure          tTAH.MakeBatchEntity(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBatchEntity
  * Process a batch of Entity Pages *
  Description:
  This procedure is call from the menu mnuEntityBatchClick. It corresponds
  to a request for building a batch of Entity Pages under an entity according
  to the taxonomic or partonomic hierarchy.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyPart:          String;
  MyTax:           String;
  StopLevel:       String;
  Actual:          tEntity;
begin
  // Initial stuff
  Actual := Self.GetEntityByTID( TID );
  if ( Actual <> nil ) then
  begin

    // Find the stop level
    MyPart := Actual.ListPart;
    MyTax := Actual.ListTax;
    StopLevel := cEmpty;
    if ( MyPart = 'P1' ) then
      StopLevel := 'P2'
    else if ( MyPart = 'P2' ) then
      StopLevel := 'P3'
    else if ( MyPart = 'P3' ) then
      StopLevel := 'P4'
    else if ( MyTax = 'T1' ) then
      StopLevel := 'T2'
    else if ( MyTax = 'T2' ) then
      StopLevel := 'T3'
    else if ( MyTax = 'T3' ) then
      StopLevel := 'T4';

    // Process the hierarchy on a taxonomic or partonomic position
    if ( ( MyPart <> cEmpty ) or ( MyTax <> cEmpty ) ) then
      MakeEntitySector( TID, StopLevel );
  end;
end; // _________________________________________________________MakeBatchEntity

procedure          tTAH.MakeEntitySector(
  TID:             Integer;
  StopLevel:       String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeEntitySector
  * Explore recursively an entire sector of Entity Pages *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  IsTax:           Boolean;
  MyPart:          String;
  MyTax:           String;
  Children:        String;
  AChild:          String;
  Actual:          tEntity;
  Child:           tEntity;
  Tetra:           tTetrahedron;
begin
  // Recursive search in the sector
  Actual := Self.GetEntityByTID( TID );
  if ( Actual <> nil ) then
  begin

    // Find children depending on type of hierarchy
    IsTax := Self.IsTaxonomy( TID );
    if ( IsTax ) then
      Children := Actual.TaxCh
    else
      Children := Actual.PartCh;

    // Skip specific entities (leaves) in taxonomy
    if ( not ( IsTax and ( Children = cEmpty ) ) ) then
    begin

      // Process all children
      while ( Children <> cEmpty ) do
      begin
        Posit := Pos( cSemi, Children );
        if ( Posit > 0 ) then
        begin
          AChild := Copy( Children, 1, Posit - 1 );
          Children := Copy( Children, Posit + 1, Length( Children ) );
        end else
        begin
          AChild := Children;
          Children := cEmpty;
        end;

        // Check the stop level
        Child := Self.GetEntityByPos( StrToInt( AChild ) );
        MyPart := Child.ListPart;
        MyTax := Child.ListTax;
        if ( StopLevel <> cEmpty ) then
          if ( ( ( MyPart = StopLevel ) and ( not IsTax ) ) or
               ( ( MyTax = StopLevel ) and ( IsTax ) ) ) then
            Continue;

        // Make recursive call
        if ( Child <> nil ) then
          MakeEntitySector( Child.TID, StopLevel );
      end; // while
    end;

    // Build all entities of the present unit
    Tetra := GetTetrahedronByTID( TID );

    // Build the Entity Page of the generator entity
    if ( Tetra.Genr <> nil ) then
      MakeEntityPage( Tetra.Genr );

    // Build the Entity page of the main entity
    if ( Tetra.Main <> nil ) then
      MakeEntityPage( Tetra.Main );

    // Build the Entity page of generic set entity
    if ( Tetra.ASet <> nil ) then
      MakeEntityPage( Tetra.Aset );

    // Build the Entity page of the left lateral entity (of pair or pset)
    if ( ( Tetra.ASin <> nil ) and ( Tetra.ASin.TID = TID ) ) then
      MakeEntityPage( Tetra.ASin );

    // Build the Entity page of the right lateral entity (of pair or pset)
    if ( ( Tetra.ADex <> nil ) and ( Tetra.ADex.TID = TID ) ) then
      MakeEntityPage( Tetra.ADex );
  end;
end; // ________________________________________________________MakeEntitySector

procedure          tTAH.MakeEntityPage(
  MyEntity:        tEntity );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeEntityPage
  * Build a single Entity Page *
  Description:
  This procedure generates a single Entity Page for the specified entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  LangDir:         String;
  EntityPage:      tEntityPage;
  Lang:            tLanguage;
  MySection:       tSection;
begin
  if ( MyEntity <> nil ) then
  begin
    EntityPage := tEntityPage.Create;
    CurrPage := EntityPage;
    EntityPage.PageName := cTAH + IntToStr( MyEntity.TID ) +
                           cSpace + Self.GetLabel( reEntityPage );
    EntityPage.Actual := MyEntity;
    EntityPage.CategPage := ca_Entity;
    EntityPage.Build;

    // Write the file of the Entity Page
    LangDir := cLgShort[ MainLang ];
    if ( MainLang = lt_Latin ) then
      LangDir := LangDir + cLgShort[ SubstLang ];
    LangDir := LangDir + cSlash;
    EntityPage.Directory := cProjectDir + cAutoDir + cEntity + cSlash + LangDir;
    Lang := Self.DisLanguage;
    EntityPage.FileName := cTAH + IntToStr( MyEntity.TID ) + cSpace +
                           cEntity + cSpace +
                           cLgShort[ Lang ] + cPeriod + HtmlExt;
    EntityPage.HelpDir := cProjectDir + cHelpDir;
    EntityPage.HelpFileName := HelpEntityPage;
    EntityPage.HelpIco := cHelpImg;
    EntityPage.WritePage;
  end;
end; // __________________________________________________________MakeEntityPage

procedure          tTAH.MakeTestPage(
  MyTest:          tTypeTest );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTestPage
  * Build a Test Page *
  Description:
  This procedure builds any language test page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TestPage:        tTestPage;
  DirLang:         String;
begin

  // Build the Test Page
  TestPage := tTestPage.Create;
  CurrPage := TestPage;
  TestPage.PageName := cTAH + cSpace + tiTestPageEN;
  TestPage.CategPage := ca_Test;
  TestPage.TypeTest := MyTest;
  TestPage.Build;

  // Write the file of the Translation Page
  DirLang := cLgShort[ MainLang ] + cSlash;
  TestPage.Directory := cProjectDir + cAutoDir + DirTestName + DirLang;
  TestPage.FileName := cTest + cTypeTest[ MyTest ] + cSpace +
                       cLgShort[ MainLang ] + cPeriod + HtmlExt;
  TestPage.HelpDir := DirHelpRelName;
  TestPage.HelpFileName := HelpTestPage;
  TestPage.HelpIco := cHelpImg;
  TestPage.WritePage;
end; // ____________________________________________________________MakeTestPage

procedure          tTAH.MakeUniversalBatch(
  TID:             Integer;
  StartSection:    tDisplay );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeUniversalBatch
  * Build a range of Universal Pages *
  Description:
  This method searches the hierarchy under the actual entity for the occurence
  of the specified start section. More than one such occurence is possible.
  The corresponding stop section is defined.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  IsTax:           Boolean;
  AChild:          String;
  Children:        String;
  Actual:          tEntity;
  Child:           tEntity;
  StopSection:     tDisplay;
begin
  // Initial stuff
  Actual := Self.GetEntityByTID( TID );
  if ( Actual <> nil ) then
  begin

    // Define the stop section
    StopSection := ds_u;
    if ( StartSection = ds_t ) then
      StopSection := ds_s
    else if ( StartSection = ds_s ) then
      StopSection := ds_r
    else if ( StartSection = ds_r ) then
      StopSection := ds_q
    else if ( StartSection = ds_q ) then
      StopSection := ds_p;

    // Direct match on start section
    if ( Actual.Display = StartSection ) then
    begin
      MakeUniversalPage( TID, StopSection );
      Exit;
    end;

    // Find children depending on type of hierarchy
    IsTax := Self.IsTaxonomy( TID );
    if IsTax then
      Children := Actual.TaxCh
    else
      Children := Actual.PartCh;

    // Process all children
    while ( Children <> cEmpty ) do
    begin
      Posit := Pos( cSemi, Children );
      if Posit > 0 then
      begin
        AChild := Copy( Children, 1, Posit - 1 );
        Children := Copy( Children, Posit + 1, Length( Children ) );
      end else
      begin
        AChild := Children;
        Children := cEmpty;
      end;

      // Recursive call on the entire subhierarchy
      Child := Self.GetEntityByPos( StrToInt( AChild ) );
      if ( Child.Display <> StopSection ) then
        MakeUniversalBatch( Child.TID, StartSection );
    end; // while
  end;
end; // ______________________________________________________MakeUniversalBatch

procedure          tTAH.MakeUniversalPage(
  TID:             Integer;
  StopSection:     tDisplay );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeUniversalPage
  * Explore recursively an entire section of Universal Pages *
  Description:
  This method processes a found start section until the next stop section or
  the leaves of the hierarchy is reached. It generates recursively all the
  corresponding Universal Pages.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  IsTax:           Boolean;
  Children:        String;
  AChild:          String;
  TitlePage:       String;
  LangDir:         String;
  Actual:          tEntity;
  Child:           tEntity;
  UniversalPage:   tUniversalPage;
  Lang:            tLanguage;
begin
  // Recursive search in the section
  IsTax := Self.IsTaxonomy( TID );
  Actual := Self.GetEntityByTID( TID );
  if ( Actual.Generator > 0 ) then
  begin
    TID := Actual.Generator;
    Actual := Self.GetEntityByTID( TID );
  end;
  if ( Actual <> nil ) then
  begin

    // Exploration up to stop section or leaf of hierarchy
    if ( Actual.Display <> StopSection ) then
    begin

      // Find children depending on type of hierarchy
      if IsTax then
        Children := Actual.TaxCh
      else
        Children := Actual.PartCh;

      // Skip specific entities (leaves) in taxonomy
      if not ( IsTax and ( Children = cEmpty ) ) then
      begin

        // Process all children
        while ( Children <> cEmpty ) do
        begin
          Posit := Pos( cSemi, Children );
          if Posit > 0 then
          begin
            AChild := Copy( Children, 1, Posit - 1 );
            Children := Copy( Children, Posit + 1, Length( Children ) );
          end else
          begin
            AChild := Children;
            Children := cEmpty;
          end;

          // Make recursive call
          Child := Self.GetEntityByPos( StrToInt( AChild ) );
          // if ( Child <> nil ) then
          //   MakeUniversalPage( Child.TID, StopSection );
        end; // while
      end;
    end;

    // Build the Universal Page
    UniversalPage := TUniversalPage.Create;
    CurrPage := UniversalPage;
    TitlePage := Self.GetLabel( reUniversalPage, True, lt_English );
    UniversalPage.PageName := cTAH + IntToStr( TID ) + cSpace + TitlePage;
    UniversalPage.Actual := Actual;
    UniversalPage.Build;

    // Write the Universal Page
    LangDir := cLgShort[ DisLanguage ] + cSlash;
    UniversalPage.Directory := cProjectDir + cAutoDir + cDirUniversal +
                               LangDir;
    UniversalPage.FileName := cTAH + IntToStr( TID ) + cSpace +
                              cUnivPage + cSpace +
                              cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
    UniversalPage.HelpDir := cProjectDir + cHelpDir;
    UniversalPage.HelpFileName := HelpUniversalPage;
    UniversalPage.HelpIco := cHelpImg;
    UniversalPage.WritePage;
  end;
end; // _______________________________________________________MakeUniversalPage

procedure          tTAH.MakePropertyPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePropertyPage
  * Build and write a Property Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  PropertyPage:    tPropertyPage;
  Lang:            tLanguage;
begin

  // Build the Latin Page
  PropertyPage := tPropertyPage.Create;
  CurrPage := PropertyPage;
  PropertyPage.PageName := cTAH + IntToStr( TID ) + cSpace + tiPropertyPageEN;
  PropertyPage.Build( TID );

  // Write the file of the Entity Page
  PropertyPage.Directory := cProjectDir + cAutoDir + DirPropertyName;
  PropertyPage.FileName := cTAH + IntToStr( TID ) + cSpace + cProperty +
                         cSpace + cLgShort[ MainLang ] + cPeriod + HtmlExt;
  PropertyPage.HelpDir := DirHelpRelName;
  PropertyPage.HelpFileName := HelpPropertyPage;
  PropertyPage.HelpIco := cHelpImg;
  PropertyPage.WritePage;
end; // ________________________________________________________MakePropertyPage

procedure          tTAH.MakeRATPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeUniversalPage
  * Build and write a RAT Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  RATPage:         tRATPage;
  Lang:            tLanguage;
  Actual:          tEntity;
begin

  // Check for valid TID
  Actual := Self.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;
  if ( ( Actual.ListPart <> 'P3' ) and ( Actual.ListPart <> 'P4' ) ) then
    Exit;

  // Build the Universal Page
  RATPage := tRATPage.Create;
  CurrPage := RATPage;
  RATPage.PageName := cTAH + IntToStr( TID ) + cSpace + tiUnivPageEN;
  RATPage.Actual := Actual;
  RATPage.Build;

  // Write the file of the Universal Page
  RATPage.Directory := cProjectDir + cAutoDir + DirUniversalName;
  RATPage.FileName := cTAH + IntToStr( TID ) + cSpace + cUniv +
                       cSpace + cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
  RATPage.HelpDir := DirHelpRelName;
  RATPage.HelpFileName := HelpUnivPage;
  RATPage.HelpIco := cHelpImg;
  RATPage.WritePage;
end; // _______________________________________________________MakeUniversalPage

procedure          tTAH.MakeDefinPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeDefinPage
  * Build a Definition Pages *
  Description:
  This method builds the definition page corresponding to the selected entity.
  It means that it builds the definition page of the generator of the
  tetrahedron of the selected entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  DefinPage:       tDefinPage;
  Lang:            tLanguage;
  MyTetra:         tTetrahedron;
  Generator:       tEntity;
begin
  // Retrieve the generator of the tetrahedron of the specified entity
  Actual := Self.GetEntityByTID( TID );
  Generator := nil;
  if ( Actual <> nil ) then
  begin
    MyTetra := GetTetrahedronByTID( Actual.TID );
    if ( MyTetra <> nil ) then
      Generator := MyTetra.Genr;
  end;

  // Build the Definition Page
  if ( Generator <> nil ) then
  begin
    DefinPage := TDefinPage.Create;
    CurrPage := DefinPage;
    DefinPage.PageName := cTAH + IntToStr( TID ) + cSpace + tiDefinPageEN;
    DefinPage.Actual := Generator;
    DefinPage.Build;

    // Write the file of the Definition Page
    DefinPage.Directory := cProjectDir + cAutoDir + cDirDefinition +
                           cLgShort[ DisLanguage ];
    DefinPage.FileName := cTAH + IntToStr( TID ) + cSpace + cDefinition +
                          cSpace + cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
    DefinPage.HelpDir := cProjectDir + cHelpDir;
    DefinPage.HelpFileName := HelpDefinPage;
    DefinPage.HelpIco := cHelpImg;
    DefinPage.WritePage;
  end;
end; // ___________________________________________________________MakeDefinPage

procedure          tTAH.MakeGroupSegmentPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGroupSegmentPage
  * Build a group of Segmentation Pages at level 4 *
  Description:
  First, the selected entity is used in order to retrieve the level 4 entity
  to which it belongs. Then, the level 4 page is built. Finally, all level 5
  pages are  built in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  TetID:           Integer;
  TID4:            Integer;
  TID5:            Integer;
  NbTetra4:        Integer;
  MyTID:           ^Integer;
  Actual:          tEntity;
  Tetra:           tTetrahedron;
  ListTetra4:      tList;
begin
  // Retrieve the actual entity and redefine it, if below level 5
  TID4 := 0;
  Actual := Self.GetEntityByTID( TID );
  TetID := Actual.Tetra;
  Tetra := GetTetrahedronByTID( TetID );
  if ( Tetra <> nil ) then
  begin
    TID4 := Tetra.Main.Niveau4;
    Actual := GetEntityByTID( TID4 );
  end;
  if ( Actual <> nil ) then
  begin

    // Build the level 4 page
    MakeSegmentPage( TID4, 4 );

    // Build all level 5 pages
    ListTetra4 := TList.Create;
    NbTetra4 := GetListLevel4( TID4, ListTetra4 );

    // Loop at level 4
    for Indy := 0 to NbTetra4 - 1 do
    begin
      MyTID := ListTetra4[ Indy ];
      TID5 := MyTID^;
      MakeSegmentPage( TID5, 5 );
    end;
  end;
end; // ____________________________________________________MakeGroupSegmentPage

procedure          tTAH.MakeSegmentPage(
  TID:             Integer;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSegmentPage
  * Build a unique Segmentation Page at specified level *
  Description:
  This procedure controls the building and the storage of any Segmentation
  Page, whatever is its level. The selected entity is directly used for
  level 5. But for level 4, the selected entity is analyzed and its entity
  at level 4 is retrieved and replaces the selected entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TetID:           Integer;
  PageLevel:       String;
  Title:           String;
  Actual:          tEntity;
  Tetra:           tTetrahedron;
  SegmentPage:     tSegmentPage;
  Lang:            tLanguage;
begin
  // Retrieve the actual entity and redefine it, if below level 5
  Actual := Self.GetEntityByTID( TID );
  Title := tiL5SegmentPageEN;
  if ( Level = 4 ) then
  begin
    TetID := Actual.Tetra;
    Tetra := GetTetrahedronByTID( TetID );
    if ( Tetra <> nil ) then
    begin
      TID := Tetra.Main.Niveau4;
      Actual := GetEntityByTID( TID );
      Title := tiL4SegmentPageEN;
    end;
  end;
  if ( Actual <> nil ) then
  begin

    // Build the Segmentation Page
    SegmentPage := TSegmentPage.Create;
    CurrPage := SegmentPage;
    SegmentPage.PageName := cTAH + IntToStr( TID ) + cSpace + Title;
    SegmentPage.Actual := Actual;
    SegmentPage.Level := Level;
    SegmentPage.Build;

    // Write the file of the Segmentation Page
    SegmentPage.Directory := cProjectDir + cAutoDir + DirSegmentName;
    if ( Level = 5 ) then
      PageLevel := cSegmentation
    else
    if ( Level = 4 ) then
      PageLevel := 'Level4';
    SegmentPage.FileName := cTAH + IntToStr( TID ) + cSpace + PageLevel +
                          cSpace + cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
    SegmentPage.HelpDir := DirHelpRelName;
    SegmentPage.HelpFileName := HelpSegmentationPage;
    SegmentPage.HelpIco := cHelpImg;
    SegmentPage.WritePage;
  end;
end; // _________________________________________________________MakeSegmentPage

procedure          tTAH.MakeSegmentExcel(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSegmentExcel
  * Build a level 4 Excel file *
  Description:
  This procedure controls the build and storage of a text file ready for
  import in an Excel spreadsheet.</P>
  The range of this file is a level 4 unit.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TetID:           Integer;
  L4ID:            Integer;
  PageLevel:       String;
  Actual:          tEntity;
  Tetra:           tTetrahedron;
  SegmentPage:     tSegmentPage;
  Lang:            tLanguage;
begin
  // Retrieve the actual entity and redefine it, if below level 5
  Actual := Self.GetEntityByTID( TID );
  TetID := Actual.Tetra;
  Tetra := GetTetrahedronByTID( TetID );
  if ( Tetra <> nil ) then
  begin
    L4ID := Tetra.Main.Niveau4;
    Actual := GetEntityByTID( L4ID );
  end;
  if ( Actual <> nil ) then
  begin

    // Build the Segmentation Page
    SegmentPage := TSegmentPage.Create;
    SegmentPage.Actual := Actual;
    SegmentPage.Level := 4;
    SegmentPage.BuildExcel;

    // Write the file of the Segmentation Page
    SegmentPage.Directory := cProjectDir + cAutoDir + DirSegmentName;
    Lang := lt_English;
    PageLevel := 'ExcelL4';
    SegmentPage.FileName := cTAH + IntToStr( TID ) + cSpace + PageLevel +
                          cSpace + cLgShort[ Lang ] + cPeriod + TextExt;
    SegmentPage.WriteExcel;
  end;
end; // ________________________________________________________MakeSegmentExcel

procedure          tTAH.MakeSegment6Columns(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSegment6Columns
  * Build a 6-column format Excel file *
  Description:
  This procedure controls the build and storage of a 6 column format
  ready for import in an Excel spreadsheet.</P>
  The range of this file is a level 4 unit.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TetID:           Integer;
  L4ID:            Integer;
  PageLevel:       String;
  Actual:          tEntity;
  Tetra:           tTetrahedron;
  SegmentPage:     tSegmentPage;
  Lang:            tLanguage;
begin
  // Retrieve the actual entity and redefine it, if below level 5
  Actual := Self.GetEntityByTID( TID );
  TetID := Actual.Tetra;
  Tetra := GetTetrahedronByTID( TetID );
  if ( Tetra <> nil ) then
  begin
    L4ID := Tetra.Main.Niveau4;
    Actual := GetEntityByTID( L4ID );
  end;
  if ( Actual <> nil ) then
  begin

    // Build the Segmentation Page
    SegmentPage := TSegmentPage.Create;
    SegmentPage.Actual := Actual;
    SegmentPage.Level := 4;
    SegmentPage.Build6Columns;

    // Write the file of the Segmentation Page
    SegmentPage.Directory := cProjectDir + cAutoDir + DirSegmentName;
    Lang := lt_English;
    PageLevel := '6ColumnsL4';
    SegmentPage.FileName := cTAH + IntToStr( TID ) + cSpace + PageLevel +
                          cSpace + cLgShort[ Lang ] + cPeriod + TextExt;
    SegmentPage.WriteExcel;
  end;
end; // _____________________________________________________MakeSegment6Columns

procedure          tTAH.MakeValidPage(
  TID:             Integer;
  MyCateg:         tCategPage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeValidPage
  * Build a Validation Page *
  Description:
  The Validation Page is reserved to level 3 and 4 entities only, either in the
  partonomy or in the taxonomy. It collects all entities at this level and
  display them in sequence. For each entity having one or more specific
  inqueries, they are displayed in turn together with all actions.</P>
  This Page may be extended to other levels by a new development.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  ValidPage:       tValidPage;
  Lang:            tLanguage;
begin
  // Retrieve the specified entity
  Actual := Self.GetEntityByTID( TID );
  if ( Actual <> nil ) then
  begin

    // Check the eligibility of this entity
    if ( not ( ( Actual.ListPart = cTypeListPage[ li_part4 ] ) or
               ( Actual.ListTax = cTypeListPage[ li_tax4 ] ) or
               ( Actual.ListPart = cTypeListPage[ li_part3 ] ) or
               ( Actual.ListTax = cTypeListPage[ li_tax3 ] ) ) ) then
      Exit;

    // Create and build the Validation Page
    ValidPage := TValidPage.Create;
    CurrPage := ValidPage;
    ValidPage.PageName := cTAH + IntToStr( TID ) + cSpace + tiValidPageEN;
    ValidPage.Actual := Actual;
    ValidPage.CategPage := MyCateg;
    ValidPage.Build;

    // Write the file of the Validation Page
    Lang := lt_English;
    ValidPage.Directory := cProjectDir + cAutoDir + DirValidName;
    ValidPage.FileName := cTAH + IntToStr( TID ) + cSpace + cValidation +
                          cSpace + cLgShort[ Lang ] + cPeriod + HtmlExt;
    ValidPage.HelpDir := DirHelpRelName;
    ValidPage.HelpFileName := HelpValidPage;
    ValidPage.HelpIco := cHelpImg;
    ValidPage.WritePage;
  end;
end; // ___________________________________________________________MakeValidPage

procedure          tTAH.MakeValidL5Pages(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeValidL5Pages
  * Build all level 5 validation pages Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  TetValue:        Integer;
  NbTetra4:        Integer;
  MyTID:           ^Integer;
  Main:            tEntity;
  Actual:          tEntity;
  Tetra4:          tTetrahedron;
  ListTetra4:      tList;
begin
  // Initial stuff
  Main := Self.GetEntityByTID( TID );
  if ( Main <> nil ) then
  begin
    TetValue := Main.Niveau5;
    if ( TetValue > 0 ) then
    begin
      Actual := Self.GetEntityByTID( TetValue );
      if ( Actual <> nil ) then
      begin
        TetValue := Actual.Niveau4;
        ListTetra4 := TList.Create;
        NbTetra4 := GetListLevel4( TetValue, ListTetra4 );

        // Search for all level 5 brother entities
        for Indy := 0 to NbTetra4 - 1 do
        begin
          MyTID := ListTetra4[ Indy ];
          Tetra4 := GetTetrahedronByTID( MyTID^ );
          if ( Tetra4 <> nil ) then
          begin

            // Retrieve the sorted list of tetrahedrons at level 5
            TetValue := Tetra4.TetraID;
            MakeValidPage( TetValue );
          end;
        end;
      end;
    end;
  end;
end; // ________________________________________________________MakeValidL5Pages

procedure          tTAH.MakeAnyPart98Page(
  TID:             Integer;
  AType:           tTypeListPage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAnyPart98Page
  * Prepare any Partonomy List at any level *
  Description:
  This method interprets a call for generation of multiple lists and split it
  into individual calls for single list pages.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  MyTID:           Integer;
  MyList:          String;
begin

  // Call at P4: direct execution
  if ( AType = li_TA98part4 ) then
  begin
    Self.MakePart98Page( TID, AType );
  end else

  // Call at P3: direct execution, plus all calls at P4
  if ( AType = li_TA98part3 ) then
  begin
    Self.MakePart98Page( TID, AType );
    MyList := GetListEntityByP4( TID );
    {while ( MyList <> cEmpty ) do
    begin
      Posit := Pos( cSemi, MyList );
      if ( Posit > 0 ) then
      begin
        MyTID := StrToInt( Copy( MyList,  1, Posit - 1 ) );
        MyList := Copy( MyList, Posit + 1, Length( MyList ) );
      end else
      begin
        MyTID := StrToInt( MyList );
        MyList := cEmpty;
      end;
      Self.MakePart98Page( MyTID, li_part4 );
    end;} // while
  end else

  // Call at P2: direct execution, plus all calls at P3
  if ( AType = li_TA98part2 ) then
  begin
    Self.MakePart98Page( TID, li_TA98part2 );
    MyList := GetListEntityByP3( TID );
    {while ( MyList <> cEmpty ) do
    begin
      Posit := Pos( cSemi, MyList );
      if ( Posit > 0 ) then
      begin
        MyTID := StrToInt( Copy( MyList,  1, Posit - 1 ) );
        MyList := Copy( MyList, Posit + 1, Length( MyList ) );
      end else
      begin
        MyTID := StrToInt( MyList );
        MyList := cEmpty;
      end;
      Self.MakePart98Page( MyTID, li_TA98part3 );
    end;} // while
  end else

  // Call at P2 full
  if ( AType = li_TA98part2f ) then
  begin
    Self.MakePart98Page( TID, AType );
  end else

  // Call at P1: direct execution only
  if ( AType = li_TA98part1 ) then
  begin
    Self.MakePart98Page( TID, li_TA98part1 );
  end;
end; // _______________________________________________________MakeAnyPart98Page

procedure          tTAH.MakeAnyPartonomyPage(
  TID:             Integer;
  AType:           tTypeListPage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAnyPartonomyPage
  * Prepare all partonomy lists for a specified level and below *
  Description:
  This method interprets a call for generation of multiple lists and split it
  into individual calls for single list pages. A call to a specified list
  at level P2 (respectively P3) will generate any number of calls to children
  lists at the level P3 (respectively P4). Recursively, any call generated
  at level P3 will be propagated at the P4 level if necessary. A call to
  level P2F and P3F is automatically generated when sublists are
  present for a P2 or P3 call.</P>
  The calls to the levels P1, P2F, P3F and P4 are always considered as single
  call.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  MyTID:           Integer;
  MyList:          String;
begin

  // Call at P4: direct execution
  if ( AType = li_part4 ) then
  begin
    Self.MakePartonomyPage( TID, AType );
  end else

  // Call at P3: direct execution, plus all calls at P4
  if ( AType = li_part3 ) then
  begin
    Self.MakePartonomyPage( TID, li_part3 );
    MyList := GetListEntityByP4( TID );
    if ( MyList <> cEmpty ) then
      Self.MakePartonomyPage( TID, li_part3f );
    while ( MyList <> cEmpty ) do
    begin
      Posit := Pos( cSemi, MyList );
      if ( Posit > 0 ) then
      begin
        MyTID := StrToInt( Copy( MyList,  1, Posit - 1 ) );
        MyList := Copy( MyList, Posit + 1, Length( MyList ) );
      end else
      begin
        MyTID := StrToInt( MyList );
        MyList := cEmpty;
      end;
      Self.MakePartonomyPage( MyTID, li_part4 );
    end; // while on all P4 components of the list
  end else

  // Call at P3 full: direct execution only
  if ( AType = li_part3f ) then
  begin
    Self.MakePartonomyPage( TID, li_part3f );
  end else

  // Call at P2: direct execution, plus all calls at P3
  if ( AType = li_part2 ) then
  begin
    Self.MakePartonomyPage( TID, li_part2 );
    MyList := GetListEntityByP3( TID );
    if ( MyList <> cEmpty ) then
      Self.MakePartonomyPage( TID, li_part2f );
    while ( MyList <> cEmpty ) do
    begin
      Posit := Pos( cSemi, MyList );
      if ( Posit > 0 ) then
      begin
        MyTID := StrToInt( Copy( MyList,  1, Posit - 1 ) );
        MyList := Copy( MyList, Posit + 1, Length( MyList ) );
      end else
      begin
        MyTID := StrToInt( MyList );
        MyList := cEmpty;
      end;
      Self.MakeAnyPartonomyPage( MyTID, li_part3 );
    end; // while on all P3 components of the list
  end else

  // Call at P2 full: direct execution only
  if ( AType = li_part2f ) then
  begin
    Self.MakePartonomyPage( TID, li_part2f );
  end else

  // Call at P1: direct execution only
  if ( AType = li_part1 ) then
  begin
    Self.MakePartonomyPage( TID, li_part1 );
  end;
end; // ____________________________________________________MakeAnyPartonomyPage

procedure          tTAH.MakePart98Page(
  TID:             Integer;
  AType:           tTypeListPage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePart98Page
  * Prepare a single Part98 List at any level for a specific entity *
  Description:
  A Partonomy TA98 List is a printable list of all entities generated from the
  partonomy of the specified entity, in a standard traversal of the tree,
  adjusted to the representation of TA98. The hierarchy structure is shown
  by an indentation of the terms.</P>
  The terms corresponding to the displayed entities follow the rules below:
  - Two columns in Latin and any selected language (English by default),
  - Short non expanded versions of the terms,
  - Display presentation of the terms,
  - UK/US sign for English terms,
  - Display of references marked by the sign '->'
  - Pointer to scientific notes when available.</P>
  There are 4 levels of lists. The first level corresponds to the top of the
  partonomy. The last level corresponds to the more detailed part of the
  partonomy, including its leaves. The intermediate levels corresponds to the
  partonomy inbetween.</P>
  The Partonomy List is suitable for direct printing. The printing is
  controlled by a CSS style sheet.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsTax:           Boolean;
  Actual:          tEntity;
  APage:           tListPage;
  Lang:            tLanguage;
  Tetra:           tTetrahedron;
begin
  // Retrieve the actual entity
  Actual := Self.GetEntityByTID( TID );
  if ( ( Actual <> nil ) and
       ( ( Actual.ListPart98 = cTypeListPage[ AType ] ) or // any marked level
         ( AType = li_part2f ) or  ( AType = li_TA98part2f ) or
         ( Actual.ListPart = cTypeListPage[ li_part3 ] ) or // ???
         ( ( AType = li_part0 ) and //
           ( Actual.ListPart = cTypeListPage[ li_part1 ] ) ) or
         ( ( AType = li_part0 ) and // CNS alone
           ( Actual.TID = 5068 ) ) or
         ( ( AType = li_part0 ) and // PNS alone
           ( Actual.TID = 6322 ) ) or
         ( ( ( AType = li_part3 ) or ( AType = li_Excel ) ) and // ICA
           ( Actual.TID = 3898 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // PCA
           ( Actual.TID = 4028 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // BA
           ( Actual.TID = 4027 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // ACA
           ( Actual.TID = 3968 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // AChA
           ( Actual.TID = 3916 ) ) or
         ( ( ( AType = li_part3 ) or ( AType = li_Excel ) ) and // MCA
           ( Actual.TID = 3992 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // VA
           ( Actual.TID = 4051 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // WM cerebellum
           ( Actual.TID = 9191 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // walls auris media
           ( Actual.TID = 30725 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // vas sanguineum auris internae
           ( Actual.TID = 25761 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // bony labyrinth
           ( Actual.TID = 26101 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // vestibular labyrinth
           ( Actual.TID = 26120 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // cochlear labyrinth
           ( Actual.TID = 26123 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // organum spirale
           ( Actual.TID = 31325 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // ori hypo
           ( Actual.TID = 24704 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // tunica fibrosa
           ( Actual.TID = 15511 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // tunica vasculosa
           ( Actual.TID = 15797 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // retina
           ( Actual.TID = 6950 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // strata retinae
           ( Actual.TID = 7645 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // Retinal neurons
           ( Actual.TID = 7644 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // extraocular muscles
           ( Actual.TID = 15758 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // structurae palpebrales
           ( Actual.TID = 15117 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // apparatus lacrimalis
           ( Actual.TID = 7085 ) ) or
         ( ( AType = li_part0 ) and                             //
           ( Actual.TID = 10568 ) ) ) ) then
  begin

    // Search for the TA98 representative entity
    Actual := GetTA98EntityByTID( Actual.TID );
    {if ( Actual.TID > 7444 ) then
    begin
      Tetra := GetTetrahedronByTID( Actual.TID );
      Actual := Tetra.Genr;
    end;}

    // Build the Partonomy Page
    APage := TListPage.Create;
    if ( Actual <> nil ) then
      if ( Actual.TID <> 10568 ) then
        APage.PageName := cTAH + IntToStr( Actual.TID ) + cSpace +
                          tiPart98PageEN + cSpace + cTypeListPage[ AType ]
      else
        APage.PageName := cTAH + cSpace + 'Reference Page';
    CurrPage := APage;
    APage.Actual := Actual;
    APage.TypeList := AType;
    APage.CategPage := ca_ListTA98;
    APage.Build;

    // Write the file of the partonomy list Page
    Lang := lt_English;
    APage.Directory := cProjectDir + cAutoDir + DirListName;
    if ( ( AType = li_TA98part2 ) or ( AType = li_TA98part3 ) )  then
      APage.Directory := PublicRootDir + '../../' + 'EntryPageNew';
    if ( Actual <> nil ) then
      if ( Actual.TID <> 10568 ) then
        APage.FileName := cTAH + IntToStr( Actual.TID ) + cSpace + cPart98 +
                          cTypeListPage[ AType ] + cSpace + cLgShort[ Lang ] +
                          cPeriod + HtmlExt
      else
        APage.FileName := cTAH + cSpace + 'Reference' + cSpace +
                          cLgShort[ Lang ] + cPeriod + HtmlExt;
    APage.HelpDir := DirHelpRelName;
    APage.HelpFileName := HelpListPage;
    APage.HelpIco := cHelpImg;

    // Write a partonomy page
    if ( AType <> li_Excel ) then
      APage.WritePage

    // Write the Excel file
    else
      APage.WriteTextLines;
  end;
end; // __________________________________________________________MakePart98Page

procedure          tTAH.MakePartonomyPage(
  TID:             Integer;
  AType:           tTypeListPage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePartonomyPage
  * Prepare a single partonomy list at any level *
   ==============================================
  Description:
  A partonomy list is a list of all entities generated from the top entity,
  following the partonomic links in a standard traversal of the tree. The
  hierarchy structure is shown by an indentation of the terms.</P>
  The present procedure is call with 2 arguments:
  - the TID parameter is the unique entity identifier of the top entity
    governing the content of the list,
  - the type of list parameter determines the level from 0 to 4 of the list.
  There are several versions of the partonomy lists:
  - standard lists, with two languages, and hyperlinks to unit and entities
    that participate to the list, as well as links to FMA and TA98, for
    more details, see below,
  - published lists, a simplified version of the standard lists,
  - 5-language lists, with latin, English, French, Spanish and Russian terms.
  In the standard lists, the terms corresponding to the displayed entities
  follow the rules below:
  - List navigation section,
  - Two columns, usually in Latin and any other modern language,
  - Short non expanded versions of the terms,
  - Display presentation of the terms,
  - UK/US sign for English terms,
  - Inconstant entities between round parentheses,
  - Display of references marked by the eye icon,
  - Display of generic embedded partonomy lists where necessary,
  - Pointer to scientific notes when available, and scientific note section,
  - Signature section.</P>
  There are 5 levels of lists, from 0 to 4. The first level corresponds to
  the top of the partonomy. The last level corresponds to the more detailed
  part of the partonomy, including its leaves. The intermediate levels
  corresponds to the partonomy inbetween. Each level but the fourth can be
  seen in short presentation with sublevels not developed, or in expanded
  presentation with full list.</P>
  The Partonomy list is suitable for direct printing. The printing is
  controlled by a CSS style sheet.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsTax:           Boolean;
  DirLang:         String;
  Actual:          tEntity;
  APage:           tListPage;
  Lang:            tLanguage;
  Tetra:           tTetrahedron;
begin
  // Retrieve the actual entity
  Actual := Self.GetEntityByTID( TID );
  if ( ( Actual <> nil ) and
       ( ( Actual.ListPart = cTypeListPage[ AType ] ) or // any marked level
         ( AType = li_part2f ) or
         ( AType = li_part3f ) or
         ( Actual.ListPart = cTypeListPage[ li_part3 ] ) or // ???
         ( ( AType = li_part0 ) and //
           ( Actual.ListPart = cTypeListPage[ li_part1 ] ) ) or
         ( ( AType = li_part0 ) and // CNS alone
           ( Actual.TID = 5068 ) ) or
         ( ( AType = li_part0 ) and // PNS alone
           ( Actual.TID = 6322 ) ) or
         ( ( AType = li_part0 ) and                             //
           ( Actual.TID = 10568 ) ) or

         // Transitory stuff for Excel spreadsheet
         ( ( ( AType = li_part3 ) or ( AType = li_Excel ) ) and // ICA
           ( Actual.TID = 3898 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // PCA
           ( Actual.TID = 4028 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // BA
           ( Actual.TID = 4027 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // ACA
           ( Actual.TID = 3968 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // AChA
           ( Actual.TID = 3916 ) ) or
         ( ( ( AType = li_part3 ) or ( AType = li_Excel ) ) and // MCA
           ( Actual.TID = 3992 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // VA
           ( Actual.TID = 4051 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // WM cerebellum
           ( Actual.TID = 9191 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // walls auris media
           ( Actual.TID = 30725 ) ) or
         ( ( ( AType = li_part4 ) or ( AType = li_Excel ) ) and // vas sanguineum auris internae
           ( Actual.TID = 25761 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // bony labyrinth
           ( Actual.TID = 26101 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // vestibular labyrinth
           ( Actual.TID = 26120 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // cochlear labyrinth
           ( Actual.TID = 26123 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // organum spirale
           ( Actual.TID = 31325 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // ori hypo
           ( Actual.TID = 24704 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // tunica fibrosa
           ( Actual.TID = 15511 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // tunica vasculosa
           ( Actual.TID = 15797 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // retina
           ( Actual.TID = 6950 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // strata retinae
           ( Actual.TID = 7645 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // Retinal neurons
           ( Actual.TID = 7644 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // extraocular muscles
           ( Actual.TID = 15758 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // structurae palpebrales
           ( Actual.TID = 15117 ) ) or
         ( ( ( AType = li_undef ) or ( AType = li_Excel ) ) and // apparatus lacrimalis
           ( Actual.TID = 7085 ) ) ) ) then
  begin

    // Exclude generic entities
    IsTax := IsTaxonomy( Actual.TID );
    if ( Actual.TID = 36256 ) then
      IsTax := False;   // temporary
    if ( IsTax ) then
    begin
      Tetra := GetTetrahedronByTID( Actual.TID );
      if ( ( Tetra.TetraType in [ tt_tax, tt_trans ] ) and
           ( Actual.TID <> 13367 ) ) then
        Exit;
      if ( Tetra.Main <> nil ) then
        Actual := Tetra.Main
      else
        Actual := Tetra.Genr;
    end;

    // Build the partonomy page
    APage := tListPage.Create;
    if ( Actual.TID <> 13367 ) then
      APage.PageName := cTAH + IntToStr( Actual.TID ) + cSpace +
                        tiPartListPageEN + cSpace + cTypeListPage[ AType ]
    else
      APage.PageName := cTAH + cSpace + 'Reference Page';
    CurrPage := APage;
    APage.Actual := Actual;
    APage.TypeList := AType;
    APage.CategPage := ca_ListPart;
    APage.Build;

    // Define the directories and filenames of the partonomy list Page
    if ( IsPub ) then
    begin

      // Prepare a 5-language published list
      if ( MultiLg ) then
      begin
        APage.Directory := cProjectDir + cAutoDir + cPartDir + c5L;
        APage.FileName := cTAH + IntToStr( Actual.TID ) + cSpace +
                          cPub + cSpace + cTypeListPage[ AType ] + cSpace +
                          cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
      end else

      // Prepare a bicolumn published list
      begin
        DirLang := cLgShort[ MainLang ];
        APage.Directory := cProjectDir + cAutoDir + cPartDir + DirLang;
        APage.FileName := cTAH + IntToStr( Actual.TID ) + cSpace +
                          cPub + cSpace + cTypeListPage[ AType ] + cSpace +
                          cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
      end;
    end else
    begin

      // Prepare a standard list
      DirLang := cLgShort[ MainLang ];
      if ( MainLang = lt_Latin ) then
        DirLang := DirLang + cLgShort[ SubstLang ];
      DirLang := DirLang + cSlash;
      APage.Directory := cProjectDir + cAutoDir + cPartDir + DirLang;
      if ( Actual.TID <> 13367 ) then
        APage.FileName := cTAH + IntToStr( Actual.TID ) + cSpace +
                          cTypeListPage[ AType ] + cSpace +
                          cLgShort[ DisLanguage ] + cPeriod + HtmlExt

      // Special Reference Page for non-physical entities
      else
        APage.FileName := cTAH + cSpace + 'Reference' + cSpace +
                          cLgShort[ Lang ] + cPeriod + HtmlExt;
    end;
    APage.HelpDir := cProjectDir + cHelpDir;
    APage.HelpFileName := HelpListPage;
    APage.HelpIco := cHelpImg;

    // Write the partonomy page
    if ( AType <> li_Excel ) then
      APage.WritePage;

    // Write for an Excel file (semicolumn-separated text file)
    if ( IsExcel ) then
      APage.WriteTextLines;
  end;
end; // _______________________________________________________MakePartonomyPage

procedure          tTAH.MakeGenericPartonomyPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenericPartonomyPage
  * Prepare a generic Partonomy List *
  Description:
  A Partonomy List is a printable list of all entities generated from the
  partonomy of a generic entity, in a standard traversal of the tree. The
  hierarchy structure is shown by an indentation of the terms.</P>
  The terms corresponding to the displayed entities follow the rules below:
  - Two columns in Latin and any selected language (English by default),
  - Short non expanded versions of the terms,
  - Display presentation of the terms,
  - UK/US sign for English terms,
  - Display of references marked by the sign '->'
  The Generic Partonomy List is suitable for direct printing. The printing is
  controlled by a CSS style sheet.</P>
  A call to this procedure with a specific entity is not accepted and results
  in a no-op action.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsTax:           Boolean;
  Actual:          tEntity;
  APage:           tListPage;
  Lang:            tLanguage;
  AType:           tTypeListPage;
begin
  // Retrieve the actual entity
  Actual := Self.GetEntityByTID( TID );
  if ( ( Actual <> nil ) ) then
  begin

    // Exclude non generic entities
    IsTax := IsTaxonomy( Actual.TID );
    if ( not IsTax ) then
      Exit;

    // Exclude a generic entity without partonomic children
    if ( Actual.PartCh = cEmpty ) then
      Exit;

    // Build the Partonomy Page
    APage := TListPage.Create;
    CurrPage := APage;
    AType := li_gen;
    APage.PageName := cTAH + IntToStr( TID ) + cSpace + tiGenListPageEN;
    APage.Actual := Actual;
    APage.TypeList := AType;
    APage.Build;

    // Write the file of the partonomy list Page
    Lang := lt_English;
    APage.Directory := cProjectDir + cAutoDir + DirListName;
    APage.FileName := cTAH + IntToStr( TID ) + cSpace + cPartList +
                      cPeriod + HtmlExt;
    APage.HelpDir := cProjectDir + cHelpDir;
    APage.HelpFileName :=  HelpListPage;
    APage.HelpIco := cHelpImg;
    APage.WritePage;
  end;
end; // ________________________________________________MakeGenericPartonomyPage

procedure          tTAH.MakeAnyTaxonomyPage(
  TID:             Integer;
  AType:           tTypeListPage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAnyTaxonomyPage
  * Prepare any Taxonomy List at any level *
  Description:
  This method interprets a call for generation of multiple lists and split it
  into individual calls for single list pages.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  MyTID:           Integer;
  MyList:          String;
begin

  // Call at T4: direct execution
  if ( AType = li_tax4 ) then
  begin
      Self.MakeTaxonomyPage( TID, AType );
  end else

  // Call at T3: direct execution, plus all calls at T4
  if ( AType = li_tax3 ) then
  begin
    Self.MakeTaxonomyPage( TID, li_tax3 );
    MyList := GetListEntityByT4( TID );
    if ( MyList <> cEmpty ) then
      Self.MakeTaxonomyPage( TID, li_tax3f );
    while ( MyList <> cEmpty ) do
    begin
      Posit := Pos( cSemi, MyList );
      if ( Posit > 0 ) then
      begin
        MyTID := StrToInt( Copy( MyList,  1, Posit - 1 ) );
        MyList := Copy( MyList, Posit + 1, Length( MyList ) );
      end else
      begin
        MyTID := StrToInt( MyList );
        MyList := cEmpty;
      end;
      Self.MakeAnyTaxonomyPage( MyTID, li_tax4 );
    end; // while
  end else

  // Call at T3 full
  if ( AType = li_tax3f ) then
  begin
    Self.MakeTaxonomyPage( TID, AType );
  end else

  // Call at T2: direct execution, plus all calls at T3
  if ( AType = li_tax2 ) then
  begin
    Self.MakeTaxonomyPage( TID, li_tax2 );
    MyList := GetListEntityByT3( TID );
    if ( MyList <> cEmpty ) then
      Self.MakeTaxonomyPage( TID, li_tax2f );
    while ( MyList <> cEmpty ) do
    begin
      Posit := Pos( cSemi, MyList );
      if ( Posit > 0 ) then
      begin
        MyTID := StrToInt( Copy( MyList,  1, Posit - 1 ) );
        MyList := Copy( MyList, Posit + 1, Length( MyList ) );
      end else
      begin
        MyTID := StrToInt( MyList );
        MyList := cEmpty;
      end;
      Self.MakeAnyTaxonomyPage( MyTID, li_tax3 );
    end; // while
  end else

  // Call at T2 full
  if ( AType = li_tax2f ) then
  begin
    Self.MakeTaxonomyPage( TID, AType );
  end else

  // Call at T1 short
  if ( AType = li_tax1 ) then
  begin
    Self.MakeTaxonomyPage( TID, AType );
  end else

  // Call at T1 full
  if ( AType = li_tax1f ) then
  begin
    Self.MakeTaxonomyPage( TID, AType );
  end;
end; // _____________________________________________________MakeAnyTaxonomyPage


procedure          tTAH.MakeInterfacePage(
  TID:             Integer;
  AType:           tTypeListPage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeInterfacePage
  * Prepare a Interface List Page *
  Description:
  This method builds and store a interface list page, unless the page is empty
  when there are no taxonomic children for the specified top entity.</P>
  The page can be at any level of the taxonomy, between T1 and T4 and should
  be declared as such.</P>
  In addition, the declared entity at top of the list should be a interface
  entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  MyUnit:          tUnit;
  APage:           tListPage;
  Lang:            tLanguage;
begin

  // Check for eligibility of a interface list on this unit
  Actual := Self.GetEntityByTID( TID );
  MyUnit := Self.GetUnitByPos( Actual.Tetra );
  if ( ( Actual <> nil ) and ( MyUnit <> nil ) and
       ( TID = MyUnit.Generator ) and
       ( MyUnit.TypUnit = tt_int ) and
       ( MyUnit.ListTax = Copy( cTypeListPage[ AType ], 1, 2 ) ) ) then
  begin

    // Build the Interface Page
    APage := tListPage.Create;
    CurrPage := APage;
    APage.PageName := cTAH + IntToStr( TID ) + cSpace + 'Interface List' +
                      cSpace + cTypeListPage[ AType ];
    APage.Actual := Actual;
    APage.TypeList := AType;
    APage.CategPage := ca_ListInt;
    APage.Build;

    // Write the Interface Page
    Lang := lt_English;
    APage.Directory := cProjectDir + cAutoDir + DirListName + cSpace + cLgShort[ MainLang ];
    APage.FileName := cTAH + IntToStr( TID ) + cSpace +
                      cTypeListPage[ AType ] + cSpace +
                      cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
    APage.HelpDir := DirHelpRelName;
    APage.HelpFileName := HelpListPage;
    APage.HelpIco := cHelpImg;
    APage.WritePage;
  end;
end; // _______________________________________________________MakeInterfacePage

procedure          tTAH.MakeTaxonomyPage(
  TID:             Integer;
  AType:           tTypeListPage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxonomyPage
  * Prepare a Taxonomy List Page *
  Description:
  This method builds and store a taxonomy list page, unless the page is empty
  when there are no taxonomic children for the specified top entity.</P>
  The page can be at any level of the taxonomy, between T1 and T4 and should
  be declared as such.</P>
  In addition, the declared entity at top of the list should be a generic
  entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  MyUnit:          tUnit;
  APage:           tListPage;
  Lang:            tLanguage;
begin
  // Check for eligibility of a taxonomic list on this unit
  Actual := Self.GetEntityByTID( TID );
  MyUnit := Self.GetUnitByPos( Actual.Tetra );
  if ( ( Actual <> nil ) and ( MyUnit <> nil ) and
       ( TID = MyUnit.Generator ) and
       ( MyUnit.ListTax = Copy( cTypeListPage[ AType ], 1, 2 ) ) ) then
  begin

    // Build the Taxonomy Page
    APage := TListPage.Create;
    CurrPage := APage;
    APage.PageName := cTAH + IntToStr( TID ) + cSpace + tiTaxListPageEN +
                      cSpace + cTypeListPage[ AType ];
    APage.Actual := Actual;
    APage.TypeList := AType;
    APage.CategPage := ca_ListTax;
    APage.Build;

    // Write the Taxonomy Page
    Lang := lt_English;
    APage.Directory := cProjectDir + cAutoDir + cTaxDir + cSlash +
                       cLgShort[ MainLang ];
    APage.FileName := cTAH + IntToStr( TID ) + cSpace +
                      cTypeListPage[ AType ] + cSpace +
                      cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
    if ( Actual.TID = 10568 ) then
      APage.FileName := cTAH + cSpace + 'Reference' + cSpace +
                        cLgShort[ MainLang ] + cPeriod + HtmlExt;;
    APage.HelpDir := DirHelpRelName;
    APage.HelpFileName := HelpListPage;
    APage.HelpIco := cHelpImg;
    APage.WritePage;

    // Write an extra text file for Excel
    // if ( AType = li_tax3 ) then
    //   APage.WriteTextLines;
  end;
end; // ________________________________________________________MakeTaxonomyPage

procedure          tTAH.MakeHierarchyPage(
  TID:             Integer;
  StartSection:    tDisplay );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHierarchyPage
  * Make one or many Hierarchy Pages *
  Description:
  This method searches for all entities of the specified type, starting on
  the actual entity. For each found entity, a new creation of the corresponding
  page is started.</P>
  Hierarchy Pages are of four different types, each one covering a part of
  the hierarchy from the top entity to the leaves. Not all levels are
  necessarily present in a hierarchy. They are the following:</P>
  - Top level T: top hierarchy directly connected to the Top Page.</P>
  - Second level S: hierarchy section directly connected to the T level.</P>
  - Third level R: hierarchy section directly connected to the S level.</P>
  - Fourth level Q: hierarchy section directly connected to the R level.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  IsTax:           Boolean;
  MyChild:         String;
  Children:        String;
  MoreChildren:    String;
  Child:           tEntity;
  StopSection:     tDisplay;
  HierarPage:      tXMLHierarPage;
begin
  // Retrieve actual entity
  HierarPage := tXMLHierarPage.Create;
  HierarPage.Actual := Self.GetEntityByTID( TID );

  // Build a new Hierarchy Page when a start section has been found
  StopSection := ds_u;
  if ( HierarPage.Actual.Display = StartSection ) then
  begin
    if StartSection = ds_t then
      StopSection := ds_s
    else
    if StartSection = ds_s then
      StopSection := ds_r
    else
    if StartSection = ds_r then
      StopSection := ds_q
    else
    if StartSection = ds_q then
      StopSection := ds_e;
    HierarPage.BuildHierarPage( TID, StopSection );
    Exit;
  end;

  // Retrieve all the children according to type of hierarchy
  IsTax := IsTaxonomy( TID );
  if IsTax then
    Children := HierarPage.Actual.TaxCh
  else
    Children := HierarPage.Actual.PartCh;
  while ( Length( Children ) > 0 ) do
  begin
    Posit := Pos( cSemi, Children );
    if Posit > 0 then
    begin
      MyChild := Copy( Children, 1, Posit - 1 );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      MyChild := Children;
      Children := cEmpty;
    end;

    // Retrieve child entity
    Child := GetEntityByTID( StrToInt( MyChild ) );
    if ( Child <> nil ) then
    begin
      if IsTax then
        MoreChildren := Child.TaxCh
      else
        MoreChildren := Child.PartCh;
      if ( Length( MoreChildren ) > 0 ) then
        Self.MakeHierarchyPage( Child.TID, StartSection );
    end;
  end; // while
end; // _______________________________________________________MakeHierarchyPage

procedure          tTAH.MakeFMAList(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFMAList
  * Creation of FMA List Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
  APage:           tListPage;
  Lang:            tLanguage;
begin
  // Retrieve the actual entity
  Actual := Self.GetEntityByTID( TID );
  if ( Actual <> nil ) then
  begin

    // Build the Taxonomy Page
    APage := tListPage.Create;
    CurrPage := APage;
    APage.PageName := cTAH + IntToStr( TID ) + cSpace + cFMAList;
    APage.TypeList := li_FMA;
    APage.Actual := Actual;
    APage.Build;

    // Write the file of the Taxonomy Page
      Lang := lt_English;
      APage.Directory := cProjectDir + cAutoDir + DirListName;
      APage.FileName := cTAH + IntToStr( TID ) + cSpace + cFMA + cSpace +
                        cLgShort[ Lang ] + cPeriod + HtmlExt;
      APage.HelpDir := DirHelpRelName;
      APage.HelpFileName := HelpListPage;
      APage.HelpIco := cHelpImg;
      APage.WritePage;

      // Write an extra text file for Excel
      // if ( AType = li_tax3 ) then
      //   APage.WriteFMALines( 0 );
  end;
end; // _____________________________________________________________MakeFMAList

procedure          tTAH.MakeSingleLetterPage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSingleLetterPage
  * Creation of single letter page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  FileName:        String;
  ACode:           String;
  LPage:           TStringList;
  Letter:          Char;
  SinglePage:      tXMLSinglePage;
begin

  // Loop on all letters
  SinglePage := tXMLSinglePage.Create;
  Letter := 'a';
  for Indx := 1 to 26 do
  begin
    if ( Indx > 1 ) then
      Letter := Chr( Ord( Letter) + 1 );
    if ( ( Letter = 'w' ) or ( Letter = 'y' ) ) then
      Continue;

    // Read a single letter raw file
    ACode := '02';
    FileName := ACode + cSpace + Letter + cSpace + cLgShort[ LgCur ] +
                cPeriod + TextExt;
    LPage := TStringList.Create;
    LPage.LoadFromFile( DirAlphaName + cSlash + FileName );

    // Build the page
    SinglePage.ResetPage;
    SinglePage.BuildSinglePage( LPage );
  end;
end; // ____________________________________________________MakeSingleLetterPage

procedure          tTAH.MakeThreeLettersPage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeThreeLettersPage
  * Creation of a set of three letters pages *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  ALetter:         Char;
  Indx:            Integer;
begin

  // Loop on all letters
  ALetter := 'a';
  for Indx := 1 to 26 do
  begin
    if ( Indx > 1 ) then
      ALetter := Chr( Ord( ALetter ) + 1 );
    if ( ( ALetter = 'w' ) or ( ALetter = 'y' ) ) then // provisoire
      Continue;
    MakeThreePage( ALetter );
  end; // for
end; // ____________________________________________________MakeThreeLettersPage

procedure          tTAH.MakeThreePage(
  ALetter:         Char );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeThreePage
  * Creation of a subset by letter of three letters pages *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Count:           Integer;
  FileName:        String;
  ACode:           String;
  Line:            String;
  Line3:           String;
  Past3:           String;
  LPage:           TStringList;
  Section:         TStringList;
  ThreePage:       tXMLThreePage;
begin

  // Read a single letter raw file
  ACode := '02';
  FileName := ACode + cSpace + ALetter + cSpace + cLgShort[ LgCur ] +
              cPeriod + TextExt;
  LPage := TStringList.Create;
  LPage.LoadFromFile( DirAlphaName + cSlash + FileName );
  Count := LPage.Count;
  Section := TStringList.Create;
  ThreePage := tXMLThreePage.Create;

  // Loop on the entire raw file
  Line := LPage[ 0 ];
  Past3 := Copy( Line, 1, 3 );
  for Indx := 0 to Count - 1 do
  begin
    Line := LPage[ Indx ];
    Line3 := Copy( Line, 1, 3 );

    // Continue on actual section with 3 letter selection
    if ( Line3 = Past3 ) then
    begin
      Section.Add( Line );
    end;

    // Close actual section if new 3-letter selection or end of file
    if ( ( Line3 <> Past3 ) or ( Indx = Count - 1 ) ) then
    begin
      ThreePage.BuildThreePage( Section );
      if ( Indx = Count - 1 ) then
        Break;

      // Start a new section
      ThreePage.ResetPage;
      Section.Clear;
      Section.Add( Line );
    end;
    Past3 := Line3;
  end; // for
end; // ___________________________________________________________MakeThreePage

procedure          tTAH.MakeTA98chapterPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTA98chapterPage
  * Build a Trace TA98 subchapter Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TA98Page:        tTA98Page;
  Lang:            tLanguage;
begin

  // Build the TA98 Page for the entire chapter
  TA98Page := TTA98Page.Create( TID );
  CurrPage := TA98Page;
  TA98Page.PageName := cTAH + IntToStr( TID ) + cSpace + tiTA98ChapPageEN;
  TA98Page.Single := md_chap;
  TA98Page.Build;

  // Write the file of the TA98 Page
  TA98Page.Directory := cProjectDir + cAutoDir + DirTA98ListName;
  TA98Page.FileName := cTAH + IntToStr( TID ) + cSpace + cTA98Chap +
                       cSpace + cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
  TA98Page.HelpDir := DirHelpRelName;
  TA98Page.HelpFileName := HelpTA98ListPage;
  TA98Page.HelpIco := cHelpImg;
  TA98Page.WritePage;
end; // _____________________________________________________MakeTA98chapterPage

procedure          tTAH.MakeTA98subchapterPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTAsubchapter98Page
  * Build a Trace TA98 subchapter Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TA98Page:        tTA98Page;
  Lang:            tLanguage;
begin

  // Build the TA98 Page for the entire subchapter
  TA98Page := TTA98Page.Create( TID );
  CurrPage := TA98Page;
  TA98Page.PageName := cTAH + IntToStr( TID ) + cSpace + tiTA98SubPageEN;
  TA98Page.Single := md_subchap;
  TA98Page.Build;

  // Write the file of the TA98 Page
  TA98Page.Directory := cProjectDir + cAutoDir + DirTA98ListName;
  TA98Page.FileName := cTAH + IntToStr( TID ) + cSpace + cTA98Sub +
                       cSpace + cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
  TA98Page.HelpDir := DirHelpRelName;
  TA98Page.HelpFileName := HelpTA98ListPage;
  TA98Page.HelpIco := cHelpImg;
  TA98Page.WritePage;
end; // __________________________________________________MakeTA98subchapterPage

procedure          tTAH.MakeTA98sectionPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTA98sectionPage
  * Build a Trace TA98 long Page *
  Description:
  This procedure build a Trace TA98 long Page, including all possible sublists,
  for a section of TA98 A section is defined as a sequence of entities with a
  common left 8-digit code, in the source order of the original 1998
  Thieme publication.</P>
  An initial check verifies the the selected entity is the head of
  a section: no page is generated in case of failure.</P>
  In a second step, all sublists being part of the initial list are considered
  in turn, and their corrsponding pages are generated.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Section:         String;
  CurrSection:     String;
  TA98Page:        tTA98Page;
  Lang:            tLanguage;
  MyRec:           TA98Rec;
  Entity:          tEntity;
begin

  // Check for a head of a TA98 section
  if ( TID > Tot98 ) then
  begin
    Entity := GetEntityByTID( TID );
    TID := Entity.Tetra;
  end;
  if ( TID <= Tot98 ) then
  begin
    MyRec := TA98List.GetTA98( TID );
    if ( MyRec.List <> TID ) then
      Exit;
  end;

  // Build the TA98 Page for the entire section
  TA98Page := TTA98Page.Create( TID );
  CurrPage := TA98Page;
  TA98Page.PageName := cTAH + IntToStr( TID ) + cSpace + tiTA98LongPageEN;
  TA98Page.Single := md_sect;
  TA98Page.Build;

  // Write the file of the TA98 Page
  TA98Page.Directory := cProjectDir + cAutoDir + DirTA98ListName;
  TA98Page.FileName := cTAH + IntToStr( TID ) + cSpace + cTA98Long +
                        cSpace + cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
  TA98Page.HelpDir := DirHelpRelName;
  TA98Page.HelpFileName := HelpTA98ListPage;
  TA98Page.HelpIco := cHelpImg;
  TA98Page.WritePage;

  // Search for the sublists in the section
  Section := Copy( MyRec.TAcode, 1, 8 );
  repeat
    if ( MyRec.List = TID ) then
      MakeTA98ShortPage( TID );
    Inc( TID );
    MyRec := TA98List.GetTA98( TID );
    CurrSection := Copy( MyRec.TAcode, 1, 8 );
  until ( CurrSection <> Section );
end; // _____________________________________________________MakeTA98sectionPage

procedure          tTAH.MakeTA98ShortPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTA98ShortPage
  * Build a Trace TA98 short Page *
  Description:
  This procedure build an Trace TA98 short Page.</P>
  An initial verification that the selected TID is the head of a TA98 list is
  performed and no page is generated in case of failure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TA98Page:        tTA98Page;
  Lang:            tLanguage;
  MyRec:           tA98Rec;
  Entity:          tEntity;
begin

  // Check for a head of a TA98 sublist
  if ( TID > Tot98 ) then
  begin
    Entity := GetEntityByTID( TID );
    TID := Entity.Tetra;
  end;
  if ( TID <= Tot98 ) then
  begin
    MyRec := TA98List.GetTA98( TID );
    if ( MyRec.List <> TID ) then
      Exit;
  end;

  // Build the Trace TA98 Page for a sublist
  TA98Page := TTA98Page.Create( TID );
  CurrPage := TA98Page;
  TA98Page.PageName := cTAH + IntToStr( TID ) + cSpace + tiTA98ShortPageEN;
  TA98Page.Single := md_short;
  TA98Page.Build;

  // Write the file of the Trace TA98 short Page
  TA98Page.Directory := cProjectDir + cAutoDir + DirTA98ListName;
  TA98Page.FileName := cTAH + IntToStr( TID ) + cSpace + cTA98Short +
                        cSpace + cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
  TA98Page.HelpDir := DirHelpRelName;
  TA98Page.HelpFileName := HelpTA98ListPage;
  TA98Page.HelpIco := cHelpImg;
  TA98Page.WritePage;
end; // _______________________________________________________MakeTA98ShortPage

procedure          tTAH.MakeTA98subsectionPage(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTA98subsectionPage
  * Build a single Trace TA98 subsection Page *
  Description:
  This procedure build an Trace TA98 subsection Page.</P>
  An initial verification that the selected TID is the head of a TA98 list is
  performed and no page is generated in case of failure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TA98Page:        tTA98Page;
  Lang:            tLanguage;
  MyRec:           tA98Rec;
  Entity:          tEntity;
begin

  // Check for a head of a TA98 sublist
  if ( TID > Tot98 ) then
  begin
    Entity := GetEntityByTID( TID );
    TID := Entity.Tetra;
  end;
  if ( TID <= Tot98 ) then
  begin
    MyRec := TA98List.GetTA98( TID );
    if ( MyRec.List <> TID ) then
      Exit;
  end;

  // Build the Trace TA98 Page for a sublist
  TA98Page := TTA98Page.Create( TID );
  CurrPage := TA98Page;
  TA98Page.PageName := cTAH + IntToStr( TID ) + cSpace + tiTA98ShortPageEN;
  TA98Page.Single := md_short;
  TA98Page.Build;

  // Write the file of the Trace TA98 short Page
  TA98Page.Directory := cProjectDir + cAutoDir + DirTA98ListName;
  TA98Page.FileName := cTAH + IntToStr( TID ) + cSpace + cTA98Short +
                        cSpace + cLgShort[ DisLanguage ] + cPeriod + HtmlExt;
  TA98Page.HelpDir := DirHelpRelName;
  TA98Page.HelpFileName := HelpTA98ListPage;
  TA98Page.HelpIco := cHelpImg;
  TA98Page.WritePage;
end; // __________________________________________________MakeTA98subsectionPage

procedure          tTAH.InvertedHierarchy;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ InvertedHierarchy
  * Determine the children list for each TAH entity. *
  Description:
  This procedure is threefolds: it successively updates the partonomic
  hierarchy, then the TA98 partonomic hierarchy, then the taxonomic hierarchy,
  whatever is present.</P>
  Hierarchy updates are performed through a sequential scan of all TA entities,
  looking at ancestor fields for each hierarchy, and updating accordingly the
  list of children of the ancestor. In addition, a position indicator is
  also updated for the control of order of children in each hierarchy.</P>
  For all these hierarchies, multiple inheritance is not allowed.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  FatherTID:       Integer;
  Child:           String;
  MySeq:           String;
  Order:           String;
  Actual:          TEntity;
  PartFather:      TEntity;
  Part98:          TEntity;
  TaxFather:       TEntity;
begin
  // Loop on all entities
  for Indx := 1 to Self.FTotTAH do
  begin

    if ( Indx = 5289 ) then
      Child := Child;

    // Get entity
    Actual := Self.FEntity[ Indx ];
    if ( Actual <> nil ) then
    begin
      Self.FEntity[ Indx ].InternalTex;

      // Retrieve the partonomic ancestor
      Child := IntToStr( Actual.TID );
      MySeq := IntToStr( Actual.PartSeq );
      PartFather := GetEntityByTID( Actual.PartAnc );
      if ( Actual.PartAnc = 25962 ) then
        Child := Child;
      if ( PartFather <> nil ) then
      begin

        // Update the list of partonomic children
        if Length( PartFather.PartCh ) > 0 then
        begin
          PartFather.PartCh := PartFather.PartCh + cSemi + Child;
          PartFather.PartPos := PartFather.PartPos + cSemi + MySeq;
        end else
        begin
          PartFather.PartCh := Child;
          PartFather.PartPos := MySeq;
        end;
        PartFather.NbPartC := PartFather.NbPartC + 1;
        Self.FEntity[ Actual.PartAnc ] := PartFather;
      end;

      // Retrieve the TA98 partonomic ancestor
      MySeq := IntToStr( Actual.Seq98 );
      Child := IntToStr( Actual.TID );
      FatherTID := Actual.Anc98;
      Part98 := Self.FEntity[ FatherTID ];
      if ( Part98 <> nil ) then
      begin

        // Update the list of partonomic children
        if Length( Part98.Ch98 ) > 0 then
        begin
          Part98.Ch98 := Part98.Ch98 + cSemi + Child;
          Part98.Pos98 := Part98.Pos98 + cSemi + MySeq;
        end else
        begin
          Part98.Ch98 := Child;
          Part98.Pos98 := MySeq;
        end;
        Part98.NbPart98 := Part98.NbPart98 + 1;
        Self.FEntity[ FatherTID ] := Part98;
      end;

      // Retrieve the taxonomic ancestor
      Order := IntToStr( Actual.TaxSeq );
      TaxFather := GetEntityByTID( Actual.TaxAnc );
      if ( TaxFather <> nil ) then
      begin

        // Update the list of taxonomic children
        if Length( TaxFather.TaxCh ) > 0 then
        begin
          TaxFather.TaxCh := TaxFather.TaxCh + cSemi + Child;
          TaxFather.TaxPos := TaxFather.TaxPos + cSemi + Order;
        end else
        begin
          TaxFather.TaxCh := Child;
          TaxFather.TaxPos := Order;
        end;
        TaxFather.NbTaxC := TaxFather.NbTaxC + 1;
        Self.FEntity[ Actual.TaxAnc ] := TaxFather;
      end;
    end;
  end; // for on all entities
end; // _______________________________________________________InvertedHierarchy

function           tTAH.IsTaxonomy(
  TID:             Integer )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsTaxonomy
  * Define the type of hierarchy (partonomy or taxonomy) *
  Description:
  This procedure retrieves the top partonomic ancestor of the entity specified
  by its TID and checks its display type. A c value means a partonomy and a
  taxonomy otherwise.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
begin
  Result := False;
  Actual := Self.GetEntityByTID( TID );
  if ( Actual <> nil ) then
  begin
    Result := Actual.PartHierar[ 0 ] <> 7973;
  end;
end; // ______________________________________________________________IsTaxonomy

function           tTAH.GetListLevel3(
  TetValue:        Integer;
  var MyList:      tList )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListLevel3
  * Make a list of tetrahedrons at level 3 *
  Description:
  This function scans all existing tetrahedrons and makes a list of the
  tetrahedrons corresponding to a level-3 specified top tetrahedron.</P>
  This function, after collecting all candidate tetrahedrons, will sort
  them according to their sequence values, then returns this list and the
  number of retrieved tetrahedrons. The list is made of the TID of the
  tetrahedrons.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbEntity:        Integer;
  Current:         tEntity;
  MyTetra:         ^Tetra;
begin

  // Check the tetrahedron value
  if ( TetValue <= 0 ) then
  begin
    Result := 0;
    Exit;
  end;

  // Initialize the list

  // Loop on all entities
  NbEntity := Self.GetNbEntity();
  for Indx := 0 to NbEntity - 1 do
  begin
    Current := Self.FEntity[ Indx ];
    if ( Current <> nil ) then
    begin

      // Process each entity
      if ( Current.Niveau3 <> TetValue ) then
        Continue;
      if ( not ( Current.TetraTip in
           [ tp_single, tp_genPair, tp_GenPSet, tp_GenSet, tp_Ref ] ) ) then
        Continue;
      New( MyTetra );
      MyTetra^.UID := Current.Tetra;
      MyTetra^.Seq := Current.Sequence3;
      MyList.Add( MyTetra );
    end;
  end; // for

  // Manage the list and return
  MyList.Sort( @CompareIntegers );
  Result := MyList.Count;
end; // ___________________________________________________________GetListLevel3

function           tTAH.GetListLevel4(
  TetValue:        Integer;
  var MyList:      tList )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListLevel4
  * Make a list of tetrahedrons at level 4 *
  Description:
  This function scans all existing tetrahedrons and makes a list of the
  tetrahedrons corresponding to a level-4 specified top tetrahedron.</P>
  This function, after collecting all candidate tetrahedrons, will sort
  them according to their sequence values, then returns this list and the
  number of retrieved tetrahedrons. The list is made of the TID of the
  tetrahedrons.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbEntity:        Integer;
  Current:         tEntity;
  MyTetra:         ^Tetra;
begin

  // Check the tetrahedron value
  if ( TetValue <= 0 ) then
  begin
    Result := 0;
    Exit;
  end;

  // Initialize the list

  // Loop on all entities
  NbEntity := Self.GetNbEntity();
  for Indx := 0 to NbEntity - 1 do
  begin
    Current := Self.FEntity[ Indx ];
    if ( Current <> nil ) then
    begin

      // Process each entity
      if ( Current.Niveau4 <> TetValue ) then
        Continue;
      if ( not ( Current.TetraTip in
           [ tp_single, tp_genPair, tp_GenPSet, tp_GenSet, tp_Ref ] ) ) then
        Continue;
      New( MyTetra );
      MyTetra^.UID := Current.Tetra;
      MyTetra^.Seq := Current.Sequence4;
      MyList.Add( MyTetra );
    end;
  end; // for

  // Manage the list and return
  MyList.Sort( @CompareIntegers );
  Result := MyList.Count;
end; // ___________________________________________________________GetListLevel4

function           tTAH.GetListTetra(
  TetValue:        Integer;
  var MyList:      tList )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListTetra
  * Make a list of units at level-5 *
  Description:
  This function scans all existing units and makes a list of the
  units corresponding to a level-5 specified top unit.</P>
  This function, after collecting all candidate units, will sort
  them according to their sequence values, then returns this list and the
  number of retrieved units. The list is made of the UID of the units.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbEntity:        Integer;
  Niveau5:         Integer;
  Current:         tEntity;
  MyTetra:         ^Tetra;
begin

  // Check the tetrahedron value
  if ( TetValue <= 0 ) then
  begin
    Result := 0;
    Exit;
  end;

  // Initialize the list

  // Loop on all entities
  NbEntity := Self.GetNbEntity();
  for Indx := 0 to NbEntity - 1 do
  begin
    Current := Self.FEntity[ Indx ];
    if ( Current <> nil ) then
    begin

      // Process each entity
      Niveau5 := Current.Niveau5;
      if ( Niveau5 <> TetValue ) then
        Continue;
      if ( not ( Current.TetraTip in
           [ tp_single, tp_genPair, tp_GenPSet, tp_GenSet, tp_Ref ] ) ) then
        Continue;
      New( MyTetra );
      MyTetra^.UID := Current.TID;
      MyTetra^.Seq := Current.Sequence5;
      MyList.Add( MyTetra );
    end;
  end; // for

  // Manage the list and return
  MyList.Sort( @CompareIntegers );
  Result := MyList.Count;
end; // ____________________________________________________________GetListTetra

function           tTAH.GetTaxListTetra(
  TetValue:        Integer;
  var MyList:      tList )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTaxListTetra
  * Make a taxonomist list of units at T4 *
  Description:
  This function search for all descendant units of a T4 specified unit.</P>
  This function, after collecting all candidate units returns this list and the
  number of retrieved units. The list is made of the UID of the units.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  IndNext:         Integer;
  Posit:           Integer;
  PosSeq:          Integer;
  NbChild:         Integer;
  Smallest:        Integer;
  MyUID:           ^Integer;
  Seq:             Array of Integer;
  TaxChild:        Array of Integer;
  TaxChildren:     String;
  TaxSeq:          String;
  Tetra:           tTetrahedron;
  MyEntity:        tEntity;
  AChild:          TEntity;
begin

  // Check the unit value
  Result := 0;
  if ( TetValue <= 0 ) then
  begin
    Exit;
  end;

  // Retrieve the starting taxonomic entity
  Tetra := GetTetrahedronByUID( TetValue );
  if ( Tetra <> nil ) then
  begin
    MyEntity := Tetra.Genr;
    if ( ( MyEntity = nil ) and ( Tetra.TetraType = tt_single ) ) then
      MyEntity := Tetra.Main;
    if ( MyEntity = nil ) then
      Exit;

    // Search for all direct children
    TaxChildren := MyEntity.TaxCh;
    TaxSeq := MyEntity.TaxPos;

    // Extract each child and its position
    NbChild := 0;
    SetLength( TaxChild, 50 );
    SetLength( Seq, 50 );
    while ( TaxChildren <> cEmpty ) do
    begin
      Posit := Pos( cSemi, TaxChildren );
      PosSeq := Pos( cSemi, TaxSeq );
      if ( Posit > 0 ) then
      begin
        TaxChild[ NbChild ] := StrToInt( Copy( TaxChildren, 1, Posit - 1 ) );
        TaxChildren := Copy( TaxChildren, Posit + 1, Length( TaxChildren ) );
        Seq[ NbChild ] := StrToInt( Copy( TaxSeq, 1, PosSeq - 1 ) );
        TaxSeq := Copy( TaxSeq, PosSeq + 1, Length( TaxSeq ) );
      end else
      begin
        TaxChild[ NbChild ] := StrToInt( TaxChildren );
        TaxChildren := cEmpty;
        Seq[ NbChild ] := StrToInt( TaxSeq );
        TaxSeq := cEmpty;
      end;
      Inc( NbChild );
    end; // while on all children
    SetLength( TaxChild, NbChild );
    SetLength( Seq, NbChild );

    // Store the current entity
    New( MyUID );
    MyUID^ := MyEntity.TID;
    MyList.Add( MyUID );

    // Process all children in sequence
    for Indx := 0 to NbChild - 1 do
    begin

      // Search for the smallest sequence position
      Smallest := 10000;
      IndNext := 0;
      for Indy := 0 to NbChild - 1 do
      begin
        if ( Seq[ Indy ] < Smallest ) then
        begin
          Smallest := Seq[ Indy ];
          IndNext := Indy;
        end;
      end;
      Seq[ IndNext ] := 10000;

      // Access to the next entity
      AChild := GetEntityByTID( TaxChild[ IndNext ] );
      if ( ( AChild <> nil ) and
           ( not ( AChild.TetraTip in [ tp_leftPair, tp_rightPair ] ) ) ) then
        GetTaxListTetra( AChild.Tetra, MyList );
    end; // for on all children
  end;
  Result := MyList.Count;
end; // _________________________________________________________GetTaxListTetra

function           tTAH.GetPartListTetra(
  TetValue:        Integer;
  var MyList:      tList )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetPartListTetra
  * Make a partonomic list of units at P4 *
  Description:
  This function search for all descendant units of a P4 specified unit.</P>
  This function, after collecting all candidate units returns this list and the
  number of retrieved units. The list is made of the UID of the units.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  IndNext:         Integer;
  Posit:           Integer;
  PosSeq:          Integer;
  NbChild:         Integer;
  Smallest:        Integer;
  MyUID:           ^Integer;
  Seq:             Array of Integer;
  PartChild:       Array of Integer;
  PartChildren:    String;
  PartSeq:         String;
  Tetra:           tTetrahedron;
  MyEntity:        tEntity;
  AChild:          tEntity;
begin

  // Check the unit value
  Result := 0;
  if ( TetValue <= 0 ) then
  begin
    Exit;
  end;

  // Retrieve the starting partonomic entity
  Tetra := GetTetrahedronByUID( TetValue );
  if ( Tetra <> nil ) then
  begin
    MyEntity := Tetra.Main;
    if ( ( MyEntity = nil ) and ( Tetra.TetraType = tt_single ) ) then
      MyEntity := Tetra.Genr;
    if ( MyEntity = nil ) then
      Exit;

    // Search for all direct children
    PartChildren := MyEntity.PartCh;
    PartSeq := MyEntity.PartPos;

    // Extract each child and its position
    NbChild := 0;
    SetLength( PartChild, 50 );
    SetLength( Seq, 50 );
    while ( PartChildren <> cEmpty ) do
    begin
      Posit := Pos( cSemi, PartChildren );
      PosSeq := Pos( cSemi, PartSeq );
      if ( Posit > 0 ) then
      begin
        PartChild[ NbChild ] := StrToInt( Copy( PartChildren, 1, Posit - 1 ) );
        PartChildren := Copy( PartChildren, Posit + 1, Length( PartChildren ) );
        Seq[ NbChild ] := StrToInt( Copy( PartSeq, 1, PosSeq - 1 ) );
        PartSeq := Copy( PartSeq, PosSeq + 1, Length( PartSeq ) );
      end else
      begin
        PartChild[ NbChild ] := StrToInt( PartChildren );
        PartChildren := cEmpty;
        Seq[ NbChild ] := StrToInt( PartSeq );
        PartSeq := cEmpty;
      end;
      Inc( NbChild );
    end; // while on all children
    SetLength( PartChild, NbChild );
    SetLength( Seq, NbChild );

    // Store the current entity
    New( MyUID );
    MyUID^ := MyEntity.TID;
    MyList.Add( MyUID );

    // Process all children in sequence
    for Indx := 0 to NbChild - 1 do
    begin

      // Search for the smallest sequence position
      Smallest := 10000;
      IndNext := 0;
      for Indy := 0 to NbChild - 1 do
      begin
        if ( Seq[ Indy ] < Smallest ) then
        begin
          Smallest := Seq[ Indy ];
          IndNext := Indy;
        end;
      end;
      Seq[ IndNext ] := 10000;

      // Access to the next entity
      AChild := GetEntityByTID( PartChild[ IndNext ] );
      if ( ( AChild <> nil ) and
           ( not ( AChild.TetraTip in [ tp_leftPair, tp_rightPair,
                                        tp_leftpset, tp_rightpset ] ) ) ) then
        GetPartListTetra( AChild.Tetra, MyList );
    end; // for on all children
  end;
  Result := MyList.Count;
end; // ________________________________________________________GetPartListTetra

function           CompareIntegers(
  Item1, Item2:    Pointer)
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CompareIntegers
  * Compare two tetrahedrons for sort *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MySeq1:          Integer;
  MySeq2:          Integer;
begin
  MySeq1 := PTetra( Item1 ).Seq;
  MySeq2 := PTetra( Item2 ).Seq;
  if ( MySeq1 > MySeq2 ) then
    Result := 1
  else
  if ( MySeq1 = MySeq2 ) then
    Result := 0
  else
    Result := -1;
end; // _________________________________________________________CompareIntegers

procedure          tTAH.ReadFixTradFile;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadFixTradFile
  * Read the file of exceptions for traditional terms *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  Lgt:             Integer;
  Posit:           Integer;
  Line:            String;
  Filename:        String;
  InFile:          TextFile;
begin
  // Open input file in text format, splitted or unsplitted
  Filename := Self.fFixTradFilename;
  AssignFile( Infile, FileName );
  Reset( InFile );
  NbFixTrad := 0;

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
      Posit := Pos( CurSep, Line );
      FixTrad[ NbFixTrad ].TID := StrToInt( Copy( Line, 1, Posit - 1 ) );
      Lgt := Length( Line );
      Line := Copy( Line, Posit + 1, Lgt );
      Posit := Pos( CurSep, Line );
      FixTrad[ NbFixTrad ].Pos := StrToInt( Copy( Line, 1, Posit - 1 ) );
      FixTrad[ NbFixTrad ].Syntax := Copy( Line, Posit + 1, Length( Line ) );
      Inc( NbFixTrad );
      if ( NbFixTrad >= Length( FixTrad ) ) then
        break;
    end;
  end; // while

  // Close the reading of source file
  CloseFile( InFile );
end; // _________________________________________________________ReadFixTradFile

function           tTAH.GetPartListPosition(
  TID:             Integer;
  var FourList:    tFourList )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetPartListPosition
  * Retrieve all markers of a partonomy list *
  Description:
  This procedure ascends the partonomy starting from the specified entity and
  search for all markers of list between the actual level and the top level.
  Abscence of marker is indicated by a null value.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx: Integer;
  MyTID:           Integer;
  MyPosition:      String;
  Actual:          TEntity;
  MyUnit:          TTetrahedron;
begin

  // Reset the markers
  Result := False;
  for Indx := 1 to 4 do
    FourList[ Indx ] := 0;
  MyTID := TID;

  // Loop on the partonomy ancestors
  while ( MyTID > 0 ) do
  begin

    // Retrieve the actual entity
    Actual := Self.GetEntityByTID( MyTID );
    if ( Actual = nil ) then
      Break;
    MyUnit := Self.GetTetrahedronByUID( Actual.Tetra );

    // Check for the presence of a marker of list
    MyPosition := Actual.ListPart;
    if ( MyPosition <> cEmpty ) then
    begin
      Result := True;
      if ( MyPosition = 'P1' ) then
        FourList[ 1 ] := Actual.TID
      else
      if ( MyPosition = 'P2' ) then
        FourList[ 2 ] := Actual.TID
      else
      if ( MyPosition = 'P3' ) then
        FourList[ 3 ] := Actual.TID
      else
      if ( MyPosition = 'P4' ) then
        FourList[ 4 ] := Actual.TID;
    end;

    // Go one step higher in the partonomy
    MyTID := Actual.PartAnc;
    if ( ( MyTID = 0 ) and ( MyUnit <> nil ) and ( MyUnit.Main <> nil ) ) then
      MyTID := MyUnit.Main.PartAnc;
  end; // while
end; // _____________________________________________________GetPartListPosition

function           tTAH.GetTaxListPosition(
  TID:             Integer;
  var FourList:    tFourList )
  :                Boolean;
var
  Indx: Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTaxListPosition
  * Retrieve all positions for a taxonomy list *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTID:           Integer;
  MyPosition:      String;
  Actual:          tEntity;
begin
  Result := False;
  for Indx := 1 to 4 do
    FourList[ Indx ] := 0;
  MyTID := TID;

  // Search the taxonomy ancestors
  while ( MyTID > 0 ) do
  begin
    Actual := Self.GetEntityByTID( MyTID );
    if ( Actual <> nil ) then
    begin
      MyPosition := Actual.ListTax;
      if ( MyPosition <> cEmpty ) then
      begin
        Result := True;
        if ( MyPosition = 'T1' ) then
          FourList[ 1 ] := Actual.TID
        else
        if ( MyPosition = 'T2' ) then
          FourList[ 2 ] := Actual.TID
        else
        if ( MyPosition = 'T3' ) then
          FourList[ 3 ] := Actual.TID
        else
        if ( MyPosition = 'T4' ) then
          FourList[ 4 ] := Actual.TID;
      end;
      MyTID := Actual.TaxAnc;
    end else
      MyTID := 0;
  end; // while
end; // ______________________________________________________GetTaxListPosition

end.


