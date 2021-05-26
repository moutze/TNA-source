{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit TAHPage
  * Class for any web server page of TAH *
  Description:
  This unit contains the class definition for generated pages necessary to
  the TAH web server. There are two kinds of pages: HTML pages and XML
  pages, both inheriting from TAHPage.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit TAHPage;

interface

uses
  TAHParam, Classes, Entity, HTMLSection;

type

                             // TAH web page class definition
  tTAHPage                   = class( TObject )
  private
    fActual:                 tEntity;
    fPag:                    TStringList;
    fPageName:               String;
    fDir:                    String;
    fFil:                    String;
                             // Prepare a section
    procedure                MakeSection(
                               SType: tSectionType );
                               virtual;
                               abstract;
  public
                             // Entity related of the page
    property Actual:         tEntity read fActual write fActual;
                             // List of strings containing the HTML or XML code
    property Page:           tStringList read fPag write fPag;
                             // Page name
    property PageName:       String read fPageName write fPageName;
                             // Directory where to store the page
    property Directory:      String read fDir write fDir;
                             // Page filename
    property FileName:       String read fFil write fFil;

                             // Constructor Create with TID
    constructor              Create(
                               TID: Integer ); overload;
                             // Common procedure for building any page
    procedure                Build; virtual; abstract;
                             // Common procedure for writing any page
    procedure                WritePage; virtual; abstract;

                             // Define the list of FMA children for a list
    {procedure                MakeFMAListDescendants(
                               MySection: TFMAListSection;
                               TID: Integer;
                               Level: Integer;
                               AType: TTypeListPage;
                               IsStop: Boolean;
                               var TotChildren: Integer );}
  end;

                             // HTML page class definition
  tHTMLPage                  = class( tTAHPage )
  private
    fHeader:                 tHTMLHeader;
    fFooter:                 tHTMLFooter;
    fSection:                Array of TSection;
    fDirH:                   String;
    fFILH:                   String;
    fUrl:                    String;
    fIco:                    String;
    fCateg:                  tCategPage;
    function                 GetNbSection()
                               : Integer;
  public
    property Header:         tHTMLHeader read fHeader write fHeader;
    property Footer:         tHTMLFooter read fFooter write fFooter;
    property NbSection:      Integer read GetNbSection;
                             // Directory where is the help page
    property HelpDir:        String read fDirH write fDirH;
                             // Page filename of the help page
    property HelpFileName:   String read fFilH write fFilH;
                             // URL of help page
    property HelpUrl:        String read fUrl write fUrl;
                             // Icon file for help page
    property HelpIco:        String read fIco write fIco;
                             // Category of page
    property CategPage:      tCategPage read fCateg write fCateg;

                             //
    procedure                MakeHeader700(
                               Legend: String;
                               LegendBubble: String;
                               Content: String;
                               Bubble: String;
                               Icon: String;
                               IconBubble: String;
                               Level: Integer );
                             //
    procedure                MakeStat2x(
                               Legend1: String;
                               Bubble1: String;
                               Legend2: String;
                               Bubble2: String;
                               Level: Integer );
                             //
    procedure                MakeStat3x(
                               Legend1: String;
                               Bubble1: String;
                               Legend2: String;
                               Bubble2: String;
                               Legend3: String;
                               Bubble3: String;
                               Level: Integer );
                             //
    procedure                MakeStat4x(
                               Legend1: String;
                               Bubble1: String;
                               Legend2: String;
                               Bubble2: String;
                               Legend3: String;
                               Bubble3: String;
                               Legend4: String;
                               Bubble4: String;
                               Level: Integer );
                             //
    procedure                MakeHeaderNotes(
                               Legend1: String;
                               Bubble1: String;
                               Legend2: String;
                               Bubble2: String;
                               Legend3: String;
                               Bubble3: String;
                               Legend4: String;
                               Bubble4: String;
                               Level: Integer );
                             //
    procedure                MakeFooter700(
                               Signature: String;
                               Level: Integer );
                             //
    procedure                MakeFooter1400(
                               Signature: String;
                               Level: Integer );
                             //
    procedure                MakeTopHTMLPage(
                               Level: Integer );
                             //
    procedure                MakeBottomHTMLPage(
                               Level: Integer );
                             // Prepare the content of an HTML Page header
    procedure                MakeHeader;
                             // Prepare the content of an HTML Page footer
    procedure                MakeFooter;
                             // Add a section to the page
    procedure                AddSection(
                               MySection: tSection );
                             // Get a section of the page
    function                 GetSection(
                               PosSection: Integer )
                               : tSection;
                             // Write HTML content of header
    procedure                WriteHeader(
                               Lev: Integer );
                             // Write HTML content of footer
    procedure                WriteFooter(
                               Lev: Integer );
  end;

                             // Class definition for Entity Page
  tEntityPage                = class( tHTMLPage )
  private
                             // Make header
    procedure                MakeHeader;
                             // Prepare a section
    procedure                MakeSection(
                               SType: tSectionType );
                               override;

  public
                             // Build an Entity Page or an Extended Page
    procedure                Build; override;
                             // Write the HTML Entity Page
    procedure                WritePage; override;
  end;

                             // Class definition for Tetra Page
  tTetraPage                 = class( tHTMLPage )
  private
    fUID:                    Integer;
                             // Make header of a Unit page
    procedure                MakeHeader;
                             // Prepare a section of a Unit page
    procedure                MakeSection(
                               SType: tSectionType );
  public
    property UID:            Integer read fUID write fUID;
                             // Build a Unit Page
    procedure                Build;
                             // Write a Unit Page;
    procedure                WritePage;
  end;
                             // Class definition for Validation Page
  tValidPage                 = class( tHTMLPage )
  private
    fLevel:                  Integer;
    fSection:                Array of tBiColSection;
    function                 GetNbSection()
                               : Integer;
  public
    property Level:          Integer read fLevel write fLevel;
    property NbSection:      Integer read GetNbSection;
                             // Initiate a Validation Page
    procedure                Build;
                             // Make header
    procedure                MakeHeader;
                             // Prepare a section
    procedure                MakeSection(
                               SType: tSectionType );
                             // Make level 4 section
    procedure                MakeLevel4Section(
                               MySection: tBiColSection );
                             // Make navigation section
    procedure                MakeNavigationSection(
                               MySection: tBiColSection );
                             // Write the Validation Page
    procedure                WritePage;
                             // Write a section of a specified type
    procedure                WriteSection(
                               PosSection: Integer;
                               Lev: Integer );
                             // Add a section to the page
    procedure                AddSection(
                               MySection: tBiColSection );
                             // Get a section of the page
    function                 GetSection(
                               PosSection: Integer )
                               : tBiColSection;
  end;

                             // Class definition for the Trace TA98 Page
  //TNote                      = Array of TListSection;
  //TLine                      = Array of TTA98ListSection;
  tTA98Page                  = class( tHTMLPage )
  private
                             // Flag for production of recursive sublists
    fSingle:                 TModeTA98;
  public
                             // Flag for production of recursive sublists
    property Single:         tModeTA98 read fSingle write fSingle;
                             // Initiate a TA98 Page
    procedure                Build;
                             // Make header
    procedure                MakeHeader;
                             // Prepare a section
    procedure                MakeSection(
                               SType: tSectionType );
                             // Write the TA98 Page
    procedure                WritePage;
  end;

                             // Class definition for Segmentation Page
  tSegmentPage               = class( tHTMLPage )
  private
    fLevel:                  Integer;
  public
    property Level:          Integer read fLevel write fLevel;
                             // Initiate a Segmentation Page
    procedure                Build;
                             // Make header
    procedure                MakeHeader;
                             // Prepare a section
    procedure                MakeSection(
                               SType: tSectionType );
                             // Make the navigation section
    procedure                MakeNavigationSection(
                               MySection: tBiColSection );
                             // Make a level 4 tetrahedron section
    procedure                MakeL4TetraSection(
                               MySection: tBiColSection );
                             // Make a level 5 tetrahedron section
    procedure                MakeL5TetraSection(
                               MySection: tBiColSection );
                             // Make a level 5 full section
    procedure                MakeL5FullSection(
                               MySection: tBiColSection );
                             // Write the Segmentation Page
    procedure                WritePage;
                             // Write a section of a specified type
    procedure                WriteSection(
                               PosSection: Integer;
                               Lev: Integer );
                             // Build an Excel file at level 4
    procedure                BuildExcel;
                             // Build an Excel file at level 4
    procedure                Build6Columns;
                             // Write an Excel file at level 4
    procedure                WriteExcel;
  end;

  { Class definition for Definition Page }
  tDefinPage                 = class( tHTMLPage )
  public
                             // Initiate a Definition Page
    procedure                Build;
                             // Make header
    procedure                MakeHeader;
                             // Prepare a section
    procedure                MakeSection(
                               SType: tSectionType );
                             // Define the content of the definition section
    procedure                MakeDefSection(
                               MySection: tBiColSection );
                             // Define a list section
    procedure                MakeDefListSection(
                               IsTax: Boolean;
                               MySection: tBiColSection );
                             // Build the list of descendant definitions
    procedure                MakeDescendantDef(
                               TID: Integer;
                               Level: Integer;
                               IsTax: Boolean;
                               MySection: tBiColSection );
                             // Recurse through definitions
    procedure                MakeNextDef(
                               TID: Integer;
                               Level: Integer;
                               IsTax: Boolean;
                               MySection: tBiColSection );
                             // Develop a cascade taxonomic definition
    procedure                MakeCascadeTaxDef(
                               ATID: Integer;
                               MySection: tBiColSection;
                               Lang: tLanguage );
                             // Develop a multi stages taxonomic defi nition
    procedure                MakeLevelTaxDef(
                               ActTID: Integer;
                               NextTID: Integer;
                               Level: Integer;
                               MySection: tBiColSection;
                               Lang: tLanguage );
                             // Write the Definition Page
    procedure                WritePage;
                             // Write the section of a specified type
    procedure                WriteSection(
                               PosSection: Integer;
                               Lev: Integer );
  end;

                             // Class definition for Universal Page
  tUniversalPage             = class( tHTMLPage )

  private
                             // Make Universal Page header
    procedure                MakeHeader;
                             // Prepare a section
    procedure                MakeSection(
                               SType: tSectionType );
  public
                             // Prepare a Universal Page
    procedure                Build;
                             // Write a Universal Page
    procedure                WritePage;
  end;

                             // Class definition for List Page
  tFMALine                   = Array of tFMAListSection;
  tListPage                  = class( tHTMLPage )
  private
    fTyp:                    tTypeListPage;
    FMALine:                 tFMALine;
    function                 GetNbFMAList()
                               : Integer;
  public
    property TypeList:       tTypeListPage read fTyp write fTyp;
    property LineFMA:        tFMALine read FMALine write FMALine;
    property NbFMAList:      Integer read GetNbFMAList;
                             // Initiate a List Page
    procedure                Build;
                             // Make header
    procedure                MakeHeader;
                             // Make sections
    procedure                MakeSection(
                               SType: tSectionType );
                             // Make the sections of the Reference Page
    procedure                MakeReferenceSections;
                             // Add a FMA section to the page
    procedure                AddFMAList(
                               MyList: tFMAListSection );
                             // Get a FMA line of the page
    function                 GetFMAList(
                               PosSection: Integer )
                               : tFMAListSection;
                             // Make a FMA Page at any level
    procedure                MakeFMAList;
                             // Make an Excel input file
    procedure                MakeExcelList;
                             // Make the Reference Page
    procedure                MakeReferencePage;
                             // Write a List Page
    procedure                WritePage;
                             // Write all FMA lines of a List Page
    procedure                WriteFMALines(
                               Lev: Integer );
                             // Write all lines in a text file of a List Page
    procedure                WriteTextLines;
  end;

                             // Class definition for RAT Page
  tRATPage                   = class( tHTMLPage )
  private
    fTyp:                    tTypeListPage;
  public
    property TypeList:       tTypeListPage read fTyp write fTyp;
                             // Initiate a List Page
    procedure                Build;
                             // Make header
    procedure                MakeHeader;
                             // Make sections
    procedure                MakeSection(
                               SType: tSectionType );
                             // Write a List Page
    procedure                WritePage;
  end;

                             //
  tPropsValue                = class( TObject )
  private
    fTID:                    Integer;
    fLib:                    String;
    fSub:                    String;
    fBil:                    Boolean;
    fMul:                    Boolean;
    fImm:                    Boolean;
    fNon:                    Boolean;
    fDim:                    Boolean;
    fRef:                    Boolean;
    fMal:                    Boolean;
    fFem:                    Boolean;
    fInc:                    Boolean;
    fSpc:                    Boolean;
    fMat:                    Boolean;
    fGen:                    Boolean;
    fGtr:                    Boolean;
    fPar:                    Boolean;
    fInd:                    Integer;
  public
    property TID:            Integer read fTID write fTID;
    property Libelle:        String read fLib write fLib;
    property Subst:          String read fSub write fSub;
    property IsBil:          Boolean read fBil write fBil;
    property IsMul:          Boolean read fMul write fMul;
    property IsImm:          Boolean read fImm write fImm;
    property IsNon:          Boolean read fNon write fNon;
    property IsDim:          Boolean read fDim write fDim;
    property IsRef:          Boolean read fRef write fRef;
    property IsMal:          Boolean read fMal write fMal;
    property IsFem:          Boolean read fFem write fFem;
    property IsInc:          Boolean read fInc write fInc;
    property IsSpc:          Boolean read fSpc write fSpc;
    property IsMat:          Boolean read fMat write fMat;
    property IsGen:          Boolean read fGen write fGen;
    property IsGtr:          Boolean read fGtr write fGtr;
    property IsPar:          Boolean read fPar write fPar;
    property Indent:         Integer read fInd write fInd;
  end;

                             // Class definition for Property Page
  tPropertyPage              = class( tHTMLPage )
  private
    fPropertySet:            array of tPropsValue;
  public
                             // Initiate a Latin Page
    procedure                Build(
                               TID: Integer );
                             // Make Latin Page header
    procedure                MakeHeader;
                             // Make the content
    procedure                MakeContent(
                               TID: Integer;
                               Indent: Integer;
                               var Count: Integer );
                             // Make the content
    procedure                MakePropertyLine(
                               MyEntity: tEntity;
                               Indent: Integer );
                             // Prepare the content of Entity Page footer
    procedure                MakeFooter(
                               Stat1: String;
                               Stat2: String;
                               Stat3: String;
                               Legend1: String;
                               Legend2: String;
                               Legend3: String );
                             // Write the HTML Entity Page
    procedure                WritePage;
                             // Write the HTML Entity Page
    procedure                WriteLine(
                               ALine: tPropsValue;
                               Level: Integer );
  end;

                             // Class definition for Test Page
  tTestPage                  = class( tHTMLPage )
  private
    fTest:                   tTypeTest;
                             // Make Test Page header
    procedure                MakeHeader;
                             // Prepare a section
    procedure                MakeSection(
                               SType: tSectionType );
  public
    property TypeTest:       tTypeTest read fTest write fTest;
                             // Prepare a Latin Page
    procedure                Build;
                             // Write a Latin Page
    procedure                WritePage;
  end;

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * Class for XML Page of TAH *
  Description:
  This unit contains the class definition for generated XML pages necessary to
  the TAH web server. There is one kind of page: Hierarchy Page.</P>
  The Hierarchy Page is a set of imbricated XML tags, following the rules
  inherent to XML documents. XML tags are specified in order to represent a
  sectiom of a hierarchy, either a taxonomy or a partonomy. Each section is
  delimited by a start entity of a given type and a stop entity, which indeed
  is the start entity of a further section. All sections together are supposed
  to cover the whole hierarchy. Sections are designed in such a way that the
  corresponding XML pages are roughly of equivalent size.</P>
  The start and stop entities are of the following types: T level for the
  top of hierarchy, S level for the immediate successors, R level for the next
  step and Q level for the part ending at the leaves of the hierarchy. Any
  level may reach the bottom of hierarchy by itself, making the following
  levels unnecessary.</P>
  When the hierarchy reaches a stop entity, which is the start of a new
  section, a call for a new Hierarchy Page is encoded under the form of the
  URL of this page. It is the responsability of the treeview deploying the
  hierarchy to require the new Hierarchy Page from the application server.</P>
  About file names of Hierarchy Pages. The file names obey to the following
  pattern: 'TAH' + internal identifier + space + 'Hierarchy' + space +
  2-digit language acronym + dot + 'xml.'. Example: TAH259 Hierarchy LA.xml.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
                             // XML page class definition
  tXMLPage                   = class( tTAHPage )
  private
    FTagSet:                 Array of tTagItem;
    function                 GetNbTag():
                               Integer;
  public
    property NbTag:          Integer read GetNbTag;
                             // Make a new tag item
    procedure                MakeTagItem(
                               Body: String;
                               Level: Integer;
                               Position: Integer = -1 );
    procedure                ResetPage;
  end;

                             // Hierarchy page class definition
  tXMLHierarPage             = class( tXMLPage )
  private
    fNbN:                    Integer;
    fNbT:                    Integer;
    fNbS:                    Integer;
    fNbR:                    Integer;
    fNbQ:                    Integer;
                             // Make XML header
    procedure                MakeHierarHeader;
                             // Make a Hierar Page of any type
    procedure                MakeHierarPage(
                               TID: Integer;
                               StopSection: tDisplay );
                             // Process a single node and its descendants
    procedure                ProcessNode(
                               Level: Integer;
                               IsTax: Boolean;
                               ATID: Integer;
                               StopSection: tDisplay );
                             // Make XML footer for hierarchical Page
    procedure                MakeHierarFooter(
                               NbTot: Integer;
                               NbSCall: Integer;
                               NbRCall: Integer;
                               NbQCall: Integer );
                             // Write the Hierarchy Page
    procedure                WriteHierarPage;
  public
    property NbNodes:        Integer read fNbN write fNbN;
    property NbTot:          Integer read fNbT write fNbT;
    property NbSCall:        Integer read fNbS write fNbS;
    property NbRCall:        Integer read fNbR write fNbR;
    property NbQCall:        Integer read fNbQ write fNbQ;
                             // Build a Hierarchy Page
    procedure                BuildHierarPage(
                               TID: Integer;
                               StartSection: tDisplay );
  end;

                             // Single letter Page class definition
  tXMLSinglePage             = class( tXMLPage )
  private
                             // Make XML header
    procedure                MakeSingleHeader;
                             // Make XML footer for Single letter Page
    procedure                MakeSingleFooter;
                             // Write the Single letter Page
    procedure                WriteSinglePage;
  public
                             // Build a Single letter Page
    procedure                BuildSinglePage(
                               LPage: TStringList );
  end;

                             // Three letters Page class definition
  tXMLThreePage              = class( tXMLPage )
  private
                             // Make XML header for Three letters Page
    procedure                MakeThreeHeader;
                             // Make XML footer for Three letters Page
    procedure                MakeThreeFooter;
                             // Write the Three letters Page
    procedure                WriteThreePage;
  public
                             // Build a Single letter Page
    procedure                BuildThreePage(
                               Section: TStringList );
  end;

implementation

uses
  StrUtils, SysUtils, AccessXML, SingleTerms, Term, TAHUtilities, TAHBrowser,
  Definitions, Tetra, TAHInterface;

constructor        tTAHPage.Create(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create/1
  * Create a new TAH Page with an instanciated entity. *
  Arguments:
  This constructor overload the standard constructor. It specifically
  instanciates the supporting entity attached to the Page from its
  identifier.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.Actual := TAH.GetEntityByTID( TID );
end; // ________________________________________________________________Create/1

{procedure          tTAHPage.MakeFMAListDescendants(
  MySection:       TFMAListSection;
  TID:             Integer;
  Level:           Integer;
  AType:           tTypeListPage;
  IsStop:          Boolean;
  var TotChildren: Integer );}
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFMAListDescendants
  * Make the FMA list of children for a FMA Page *
  Description:
  This recursive procedure works on a partonomy of the model of anatomy
  as present in the TAH database. It writes the tree of descendants of the
  specified node.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  Indn:            Integer;
  Indm:            Integer;
  Indz:            Integer;
  Posit:           Integer;
  NbTrueChildren:  Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  ActDiv:          Integer;
  NbNote:          Integer;
  MbNote:          Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  NbTerm:          Integer;
  StopList:        Boolean;
  MyTID:           Integer;
  IsRef:           Boolean;
  IsUSA:           Boolean;
  IsPair:          Boolean;
  IsPSet:          Boolean;
  Children:        String;
  SortList:        String;
  ViewCode:        String;
  FMACode:         String;
  Bubble:          String;
  MyIndent:        String;
  TAValue:         String;
  FMAValue:        String;
  MyValue:         String;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          tEntity;
  AChild:          tEntity;
  AChildRef:       tEntity;
  Gener:           tEntity;
  AnItem:          tFMAListItem;
  CurrType:        tTypeListPage;
  MySingle:        tSingle;
  SynTerm:         tSingle;
  MyComment:       tFMAComment;
begin
  // Retrieve the top entity of the list
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get direct children and their number
  Children := Actual.PartCh;
  SortList := Actual.PartPos;
  NbTrueChildren := Actual.NbPartC;
  if ( Children = cEmpty ) then
    Exit;

  // Extract the list of order position
  NbOrder := 0;
  while ( SortList <> cEmpty ) do
  begin
    Inc( NbOrder );
    Posit := Pos( cSemi, SortList );
    if ( Posit > 0 ) then
    begin
      Order[ NbOrder ] := StrToInt( Copy( SortList, 1, Posit - 1 ) );
      SortList := Copy( SortList, Posit + 1, Length( SortList ) );
    end else
    begin
      Order[ NbOrder ] := StrToInt( SortList );
      SortList := cEmpty;
    end;
  end; // while

  // Extract the list of children
  for Indx := 1 to NbTrueChildren do
  begin
    Posit := Pos( cSemi, Children );
    if ( Posit > 0 ) then
    begin
      Child[ Indx ] := StrToInt( Copy( Children, 1, Posit - 1 ) );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      Child[ Indx ] := StrToInt( Children );
      Children := cEmpty;
    end;
  end; // for

  // Check for the presence of a partial partonomy of a set generator
  if ( ( Actual.Generator > 0 ) and
       ( Actual.TetraTip = tp_pset ) ) then
  begin
    AChild := TAH.GetEntityByTID( Actual.Generator );
    if ( AChild.NbPartC > 0 ) then
    begin

      // Compute the value for the generator
      ViewCode := IntToStr( AChild.TID );
      MyIndent := Chr( Ord( 'a' ) + Level - 1 ) ;
      TAValue := AChild.GetOfficial( TAH.MainLang, True );
      TAValue := cNumber + cSpace + TAValue;
      MySingle := AChild.GetSingleTerm( st_FMA, lt_English );
      FMAValue := cEmpty;
      if ( MySingle <> nil ) then
        FMAValue := MySingle.Mandat;

      // Display the generator
      AnItem := tFMAListItem.Create;
      AnItem.TAID := ViewCode;
      AnItem.TATerm := TAValue;
      AnItem.FMAID := IntToStr( AChild.FID );
      AnItem.FMATerm := FMAValue;
      AnItem.Indent := MyIndent;
      MySection.AddFMALine( AnItem );
      Inc( TotChildren );

      // Display the entire partial partonomy of the generator
      Self.MakeFMAListDescendants( MySection, Actual.Generator, Level + 1,
                                   li_undef, True, TotChildren );
    end;
  end;

  // Loop on all children
  ActDiv := 0;
  IsRef := False;
  for Indx := 1 to NbTrueChildren do
  begin

    // Search the position of the next child according to sortlist
    Small := 1;
    AnOrder := Order[ Small];
    for Indy := 2 to NbTrueChildren do
    begin
      if Order[ Indy ] < AnOrder then
      begin
        Small := Indy;
        AnOrder := Order[ Small];
      end;
    end; // for
    Inds := Small;
    Order[ Small ] := 10000;

    // Retrieve the next child entity to be displayed
    AChild := TAH.GetEntityByTID( Child[ Inds ] );
    AChildRef := nil;
    if ( AChild <> nil ) then
    begin

      // Handling of a possible reference
      IsRef := ( AChild.Reference > 0 );
      if ( IsRef ) then
      begin
        AChildRef := AChild;
        AChild := TAH.GetEntityByTID( AChild.Reference );
      end;

      // Do not show left and right entities
      if ( ( AChild.Link <> pw_MemberL ) and
           ( AChild.Link <> pw_MemberR ) and
           ( AChild.Link <> pw_SMemberL ) and
           ( AChild.Link <> pw_SMemberR ) and
           ( AChild.Link <> pw_IMemberL ) and
           ( AChild.Link <> pw_IMemberR ) and
           ( AChild.Link <> pw_TMemberL ) and
           ( AChild.Link <> pw_TMemberR ) ) then
      begin

        // Prepare the next line
        ViewCode := cEmpty;
        if ( AChild.TID > 0 ) then
          ViewCode := IntToStr( AChild.TID );
        FMACode := cEmpty;
        if ( AChild.FID > 0 ) then
          FMACode := IntToStr( AChild.FID )
        else
        if ( AChild.FID = -1 ) then
          FMACode := cNotAvailable;
        IsPair := AChild.TetraTip = tp_pair;
        IsPSet := AChild.TetraTip = tp_pset;
        if ( IsPair or IsPSet ) then
        begin
          Gener := TAH.GetEntityByTID( AChild.Generator );
          if ( Gener <> nil ) then
          begin
            if ( Gener.TID > 0 ) then
              ViewCode := IntToStr( Gener.TID );
            if ( Gener.FID > 0 ) then
              FMACode := IntToStr( Gener.FID );
          end;
        end;
        MyIndent := Chr( Ord( 'a' ) + Level - 1 );
        TAValue := AChild.GetOfficial( TAH.MainLang, True );
        MySingle := AChild.GetSingleTerm( st_FMA, lt_English );
        FMAValue := cEmpty;
        if ( MySingle <> nil ) then
          FMAValue := MySingle.Mandat;

        // Search for FMA comments
        if ( AChild.FID <= 0 ) then
        begin
          if ( IsPair or IsPSet ) then
            MyComment := TAH.FMAs.FMAComment( Gener.TID, 0 )
          else
            MyComment := TAH.FMAs.FMAComment( AChild.TID, 0 );
          if ( MyComment <> nil ) then
            FMAValue := MyComment.Comment;
        end;

        // Presence of an explicit term in reference
        if ( AChildRef <> nil ) then
        begin
          MyValue := AChildRef.GetOfficial( TAH.MainLang, True );
          if ( (  MyValue <> cEmpty ) and
               ( Copy( MyValue, 1, 3 ) <> 'ERR' ) ) then
          begin
            TAValue := MyValue;
          end;
        end;
        Inc( TotChildren );

        // Compute the next line and store it
        AnItem := tFMAListItem.Create;
        AnItem.TAID := ViewCode;
        AnItem.TATerm := TAValue;
        AnItem.FMAID := FMACode;
        AnItem.FMATerm := FMAValue;
        if ( IsRef ) then
          AnItem.TATerm := '->' + AnItem.TATerm;
        AnItem.Indent := MyIndent;
        MySection.AddFMALine( AnItem );

        // Recursive call for next levels
        if ( IsRef ) then
          Self.MakeFMAListDescendants( MySection, AChildRef.TID, Level + 1,
                                       li_undef, True, TotChildren )
        else
          Self.MakeFMAListDescendants( MySection, AChild.TID, Level + 1,
                                       Atype, True, TotChildren );
      end;
    end; // AChild <> nil
  end; // for Indx := 1 to NbTrueChildren
end; // __________________________________________________MakeFMAListDescendants }

function           tHTMLPage.GetNbSection()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbSection
  * Property read method for number of section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FSection );
end; // ____________________________________________________________GetNbSection

function           tHTMLPage.GetSection(
  PosSection:      Integer )
  :                tSection;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSection
  * Property read method for number of section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Self.FSection[ PosSection ];
end; // ______________________________________________________________GetSection

procedure          tHTMLPage.MakeHeader700(
  Legend:          String;
  LegendBubble:    String;
  Content:         String;
  Bubble:          String;
  Icon:            String;
  IconBubble:      String;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeader700
  * Make header 700px *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( IsLarge ) then
    AddTag( DIVOTAG + cIdHeader1400 + cAnr, Level )
  else
    AddTag( DIVOTAG + cIdHeader700 + cAnr, Level );
    AddTag( TABLETAG, Level + 1 );
      AddTag( TDTAG, Level + 2 );
        if ( IsLarge ) then
          AddTag( TABLEOTAG + cIdTitleBox1400 + cAnr, Level + 3 )
        else
          AddTag( TABLEOTAG + cIdTitleBox700 + cAnr, Level + 3 );
          AddTag( TRTAG, Level + 4 );
            AddTag( DIVOTAG + cIdTitleLegend + cSpace + cTitleEmpty +
                    LegendBubble + cDQuote + cAnr, Level + 5 );
              AddTag( Legend, Level + 6 );
            AddTag( DIVETAG, Level + 5 );
          AddTag( TRETAG, Level + 4 );
          AddTag( TRTAG, Level + 4 );
            AddTag( DIVOTAG + cIdTitleContent + cSpace + cTitleEmpty + Bubble +
                    cDQuote + cAnr, Level + 5 );
              AddTag( Content, Level + 6 );
            AddTag( DIVETAG, Level + 5 );
          AddTag( TRETAG, Level + 4 );
        AddTag( TABLEETAG, Level + 3 );
      AddTag( TDETAG, Level + 2 );
      AddTag( TDTAG, Level + 2 );
        AddTag( DIVOTAG + cIdHelpIcon + cSpace + cTitleEmpty + IconBubble +
                cDQuote + cAnr, Level + 3 );
          AddTag( Icon, Level + 4 );
        AddTag( DIVETAG, Level + 3 );
      AddTag( TDETAG, Level + 2 );
    AddTag( TABLEETAG, Level + 1 );
  AddTag( DIVETAG, Level );
end; // ___________________________________________________________MakeHeader700

procedure          tHTMLPage.MakeStat2x(
  Legend1:         String;
  Bubble1:         String;
  Legend2:         String;
  Bubble2:         String;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeStat2x
  * Make table statistics with 2 fields *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( IsLarge ) then
    AddTag( TABLEOTAG + cSpace + cClassFooter1400 + cAnr, Level )
  else
    AddTag( TABLEOTAG + cSpace + cClassFooter700 + cAnr, Level );
    AddTag( TRTAG, Level + 1 );
      MakeTD( cClassBase2L, Legend1, Bubble1, Level + 2 );
      MakeTD( cClassBase2R, Legend2, Bubble2, Level + 2 );
    AddTag( TRETAG, Level + 1 );
  AddTag( TABLEETAG, Level );
end; // ______________________________________________________________MakeStat2x

procedure          tHTMLPage.MakeStat3x(
  Legend1:         String;
  Bubble1:         String;
  Legend2:         String;
  Bubble2:         String;
  Legend3:         String;
  Bubble3:         String;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeStat3x
  * Make table statistics with 3 fields *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( IsLarge ) then
    AddTag( TABLEOTAG + cSpace + cClassFooter1400 + cAnr, Level )
  else
    AddTag( TABLEOTAG + cSpace + cClassFooter700 + cAnr, Level );
    AddTag( TRTAG, Level + 1 );
      MakeTD( cClassBase3L, Legend1, Bubble1, Level + 2 );
      MakeTD( cClassBase3C, Legend2, Bubble2, Level + 2 );
      MakeTD( cClassBase3R, Legend3, Bubble3, Level + 2 );
    AddTag( TRETAG, Level + 1 );
  AddTag( TABLEETAG, Level );
end; // ______________________________________________________________MakeStat3x

procedure          tHTMLPage.MakeStat4x(
  Legend1:         String;
  Bubble1:         String;
  Legend2:         String;
  Bubble2:         String;
  Legend3:         String;
  Bubble3:         String;
  Legend4:         String;
  Bubble4:         String;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeStat4x
  * Make table statistics with 4 fields *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( IsLarge ) then
    AddTag( TABLEOTAG + cSpace + cClassFooter1400 + cAnr, Level )
  else
    AddTag( TABLEOTAG + cSpace + cClassFooter700 + cAnr, Level );
    AddTag( TRTAG, Level + 1 );
      MakeTD( cClassBase4L, Legend1, Bubble1, Level + 2 );
      MakeTD( cClassBase4CL, Legend2, Bubble2, Level + 2 );
      MakeTD( cClassBase4CR, Legend3, Bubble3, Level + 2 );
      MakeTD( cClassBase4R, Legend4, Bubble4, Level + 2 );
    AddTag( TRETAG, Level + 1 );
  AddTag( TABLEETAG, Level );
end; // ______________________________________________________________MakeStat4x

procedure          tHTMLPage.MakeHeaderNotes(
  Legend1:         String;
  Bubble1:         String;
  Legend2:         String;
  Bubble2:         String;
  Legend3:         String;
  Bubble3:         String;
  Legend4:         String;
  Bubble4:         String;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeaderNotes
  * Make table statistics with 4 fields *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  AddTag( TABLEOTAG + cSpace + cClassSingleTable + cAnr, Level );
    AddTag( TRTAG, Level + 1 );
      MakeTD( cClassBase4L, Legend1, Bubble1, Level + 2 );
      MakeTD( cClassBase4CL, Legend2, Bubble2, Level + 2 );
      MakeTD( cClassBase4CR, Legend3, Bubble3, Level + 2 );
      MakeTD( cClassBase4R, Legend4, Bubble4, Level + 2 );
    AddTag( TRETAG, Level + 1 );
  AddTag( TABLEETAG, Level );
end; // _________________________________________________________MakeHeaderNotes

procedure          tHTMLPage.MakeFooter700(
  Signature:       String;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFooter700
  * Make signature with copyrights *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  AddTag( DIVOTAG + cIdFooter700 + cAnr, Level );
    AddTag( PTAG + Signature + PETAG, Level + 1 );
  AddTag( DIVETAG, Level );
end; // ___________________________________________________________MakeFooter700

procedure          tHTMLPage.MakeFooter1400(
  Signature:       String;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFooter1400
  * Make signature with copyrights *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  AddTag( DIVOTAG + cIdFooter1400 + cAnr, Level );
    AddTag( POTAG + cClassSigne + cAnr + Signature + PETAG, Level + 1 );
  AddTag( DIVETAG, Level );
end; // __________________________________________________________MakeFooter1400

procedure          tHTMLPage.MakeTopHTMLPage(
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTopHTMLPage
  * Make the top part of an HTML Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  AddTag( DOCTYPETAG, Level );
  AddTag( HTMLTAG, Level );
    AddTag( HEADTAG, Level + 1 );
      AddTag( TITLETAG + PageName + TITLEETAG, Level + 2 );
      AddTag( CALLCSSVIEWTAG, Level + 2 );
      AddTag( CALLCSSPRINTTAG, Level + 2 );
      AddTag( CALLJSENTITY, Level + 2 );
    AddTag( HEADETAG, Level + 1 );
    AddTag( BODYTAG, Level + 1 );
      AddTag( DIVOTAG + cIdContainer + cAnr, Level + 2 );
end; // _________________________________________________________MakeTopHTMLPage

procedure          tHTMLPage.MakeBottomHTMLPage(
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBottomHTMLPage
  * Make the bottom part of an HTML Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
        // Close the global divisions
        AddTag( DIVETAG + cOComment + 'Body700' + cEComment, Level + 3 );
      AddTag( DIVETAG + cOComment + 'Container700' + cEComment, Level + 2 );

      // Add a javascript to call for initialisation of the 3 hierarchies
      AddTag( SCRIPTTAG, Level + 2 );
        AddTag( 'InitSections' + cRol + cSpace + cRor + cSemi, Level + 3 );
      AddTag( SCRIPTETAG, Level + 2 );

      // Close global tags
    AddTag( BODYETAG, Level + 1 );
  AddTag( HTMLETAG, Level );
end; // ______________________________________________________MakeBottomHTMLPage

procedure          tHTMLPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeader
  * Make the header of an HTML Page *
  Description:
  This method creates the content of the header of an HTML Page for the
  specified entity. The header is made of 3 strings: the introduction text
  specifying the type of page, the title in main language and the bubble in
  substitution language.</P>
  This method is usually inherited by each specific HTML Page for a possible
  adjustment, in particular the Entity Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTitle:         String;
  MyBubble:        String;
  MyHeader:        tHTMLHeader;
  Main:            tEntity;
  MySingle:        tSingle;
  Aterm:           tSingle;
  MyUnit:          tUnit;
  MySection:       tSection;
begin

  // Initial stuff
  MyHeader := nil;
  MyTitle := cEmpty;
  MyBubble := cEmpty;
  Main := Self.Actual;
  if ( Main <> nil ) then
  begin

    // Title and bubble for a Unit Page
    if ( Self.CategPage = ca_Tetra ) then
    begin
      MyTitle := Main.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
      MyBubble := Main.GetLibelle( lb_Official, TAH.SubstLang, st_undef,
                                   True, False );
    end else
    begin

      // Title and bubble for TA98 partonomic list
      if ( Self.CategPage = ca_ListTA98 ) then
      begin
        MyUnit := TAH.GetUnitByPos( Main.Tetra );
        if ( MyUnit.ASet > 0 ) then
          Main := TAH.GetEntityByTID( MyUnit.ASet );
        if ( Main.TetraTip = tp_dup ) then
          Main := TAH.GetEntityByPos( Main.Reference );
        Main.LgCurrent := TAH.MainLang;
        Main.Query := tSearch.Create( st_Ori );
        Main.SearchTerm;
        ATerm := Main.CurrSingle;
        MyTitle := cEmpty;
        if ( ATerm <> nil ) then
          MyTitle := ATerm.Mandat;
        Main.LgCurrent := TAH.SubstLang;
        Main.Query := tSearch.Create( st_Ori );
        Main.SearchTerm;
        ATerm := Main.CurrSingle;
        MyBubble := cEmpty;
        if ( ATerm <> nil ) then
          MyBubble := ATerm.Mandat;
      end else

      // Title and bubble for all other pages
      begin

        // Accept the field reference to retrieve a missing title.
        if ( ( Main.Reference > 0 ) and ( Main.TetraTip <> tp_voc ) ) then
          Main := TAH.GetEntityByTID( Main.Reference );
        if ( Main <> nil ) then
        begin
          MyUnit := TAH.GetUnitByPos( Main.Tetra );

          // Use language title for vocabulary entities, English by default
          if ( ( MyUnit <> nil ) and ( Main.TetraTip = tp_voc ) ) then
          begin
            MyTitle := Main.GetLibelle
                         ( lb_Title, TAH.MainLang, st_undef, True );
            if ( MyTitle = cEmpty ) then
              MyTitle := Main.GetLibelle
                           ( lb_Title, lt_English, st_undef, True );
            MyBubble := Main.GetLibelle
                          ( lb_Title, TAH.SubstLang, st_undef, True, False );
          end else

          // Use language title for standby entities
          if ( ( MyUnit <> nil ) and ( Main.TetraTip = tp_wait ) ) then
          begin
            MyTitle := 'free unused entity';
            MyBubble := cEmpty;
          end else

          // Use official terms for interface entities
          if ( ( MyUnit <> nil ) and ( Main.TetraTip = tp_int ) ) then
          begin
            MyTitle := Main.GetLibelle
                         ( lb_Title, TAH.MainLang, st_undef, True );
            MyBubble := Main.GetLibelle
                         ( lb_Title, TAH.SubstLang, st_undef, True );
          end else

          // Use official term
          begin
                MyTitle := Main.GetLibelle
                         ( lb_Official, TAH.MainLang, st_undef, True );
                MyBubble := Main.GetLibelle
                         ( lb_Official, TAH.SubstLang, st_undef, True, False );
          end;
        end;
      end;
    end;

    // Prepare the content of header
    MyHeader := tHTMLHeader.Create;
    MyHeader.Title := MyTitle;
    MyHeader.Bubble := MyBubble;
    MyHeader.Intro := cEmpty;
    if ( Dev ) then
    begin
      MySection := tSection.Create;
      if ( not IsPub ) then
        MyHeader.Intro := MyHeader.Intro + cComma + cSpace +
                          TAH.GetLabel( reWorkInProgress, False );
    end;
  end;

  // Add the header to the HTML Page
  Self.Header := MyHeader;
end; // ______________________________________________________________MakeHeader

procedure          tHTMLPage.MakeFooter;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFooter
  * Make the footer of an HTML Page *
  Description:
  This method prepares the footer of an Entity Page, consisting of the current
  date.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyFooter:        tHTMLFooter;
begin

  // Create the object footer
  MyFooter := tHTMLFooter.Create;

  // Store the date of creation of the page
  MyFooter.DateCreation := DateToStr( Date );

  // Add the footer to the Entity Page
  Self.Footer := MyFooter;
end; // ______________________________________________________________MakeFooter

procedure          tHTMLPage.AddSection(
  MySection:       tSection ) ;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddSection
  * Add a section to a HTML Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbSect:          Integer;
begin
  NbSect := Self.NbSection;
  Inc( NbSect );
  SetLength( Self.FSection, NbSect );
  Self.FSection[ NbSect - 1 ] := MySection;
end; // ______________________________________________________________AddSection

procedure          tHTMLPage.WriteHeader(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteHeader
  * Display the page header with title and help icon *
  Description:
  This method writes the HTML header of the page. The following items are the
  constituant parts of a page header:
  - an introduction text to the page with language information,
  - a bubble for introduction text,
  - a title in main language,
  - a bubble for title in subsidiary language,
  - a help icon pointing to the help file of this type of page,
  - a bubble for help icon.
  All texts and bubbles but the titles are given in interface language.</P>
  The title font is possibly adjusted when the text is long.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;  // Enf of text in title
  MyIntro:         String;   // Introduction text of the page
  MyIntroBubble:   String;   // Bubble for introduction text of the page
  MyHelp:          String;   // Icon with link to help file on this page type
  MyHelpBubble:    String;   // Bubble for help icon
  MyTitle:         String;   // Visible title of the page in main language
  MyShort:         String;   // Short title of the page
  MyTitleBubble:   String;   // Bubble for title in subsidiary language
begin
  MyIntro := Self.Header.Intro;
  MyIntroBubble := Self.Header.Legend;
  MyHelp := cEmpty;
  if ( not IsPub ) then
    MyHelp := AOTAG + cHrefEmpty + Self.HelpDir + Self.HelpFileName +
                  cDQuote + cAnr + Self.HelpIco + AETAG;
  MyTitle := Self.Header.Title;
  Posit := Pos( cAnl, MyTitle );
  MyShort := cEmpty;
  if ( Posit > 0 ) then
    MyShort := Copy( MyTitle, 1, Posit - 2 );
  if ( Length( MyShort ) > 45 ) then
    MyTitle := POTAG + cClassSmallFont + cAnr + MyTitle
  else
    MyTitle := PTAG + MyTitle;
  MyTitleBubble := Self.Header.Bubble;
  MyHelpBubble := TAH.GetLabel( reHelpOnPage );
  MakeHeader700( MyIntro, MyIntroBubble, MyTitle, MyTitleBubble,
                 MyHelp, MyHelpBubble, Lev );
end; // _____________________________________________________________WriteHeader

procedure          tHTMLPage.WriteFooter(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteFooter
  * Display the page footer *
  Description:
  The footer of Entity Page is simply made of the date of generation of the
  page. In addition, the FIPAT signature is closing this footer.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyText:          String;
  Legend:          String;
  MyDate:          String;
  MySection:       tSection;
begin
  MySection := tSection.Create;
  MyDate := TAH.GetLabel( reDateGener );
  MyText := MyDate + cColumn + cSpace + Self.Footer.DateCreation;
  Legend := TAH.GetBubble( reDateGener );
  MakeStat2x( Self.Footer.Stat1, Self.Footer.Legend1, MyText, Legend, Lev );
  if ( IsLarge ) then
    MakeFooter1400( cSignature, 3 )
  else
    MakeFooter700( cSignature, 3 );
end; // _____________________________________________________________WriteFooter

procedure          tEntityPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tEntityPage.Build
  * Build an Entity Page *
  Description:
  This method builds all the sections of an Entity Page in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  SecondLang:      tLanguage;
begin

  // Display section in the order of occurence
  if ( Self.Actual <> nil ) then
  begin

    // Display title and identification
    Self.MakeHeader;
    Self.MakeSection( sc_Identification );

    // Display navigation items
    if ( ( Self.Actual.TypeEntity <> to_non ) or
         ( Actual.TetraTip = tp_int ) ) then
      Self.MakeSection( sc_Navigation );

    // Display interface section
    if ( Actual.TetraTip = tp_int ) then
      Self.MakeSection( sc_Interface );

    // Display properties of the unit
    if ( Actual.TetraTip <> tp_int ) then
      Self.MakeSection( sc_Property );

    // Display vocabulary for vocabulary units only
    if ( Actual.TetraTip = tp_voc ) then
      Self.MakeSection( sc_Vocabulary );

    // Display all terms in main and subsidiary language
    if ( Actual.TetraTip <> tp_int ) then
    begin
      Self.Actual.LgCurrent := TAH.MainLang;
      case TAH.MainLang of
        lt_Latin: Self.MakeSection( sc_Latin );
        lt_English: Self.MakeSection( sc_English );
        lt_French: Self.MakeSection( sc_French );
        lt_Spanish: Self.MakeSection( sc_Spanish );
        lt_Russian: Self.MakeSection( sc_Russian );
      end; // case
      Self.Actual.LgCurrent := TAH.SubstLang;
      case TAH.SubstLang of
        lt_Latin: Self.MakeSection( sc_Latin );
        lt_English: Self.MakeSection( sc_English );
        lt_French: Self.MakeSection( sc_French );
        lt_Spanish: Self.MakeSection( sc_Spanish );
        lt_Russian: Self.MakeSection( sc_Russian );
      end; // case
    end;

    // Display horizontal relations
    // Self.MakeSection( sc_Linkage );

    // Display textual information
    Self.MakeSection( sc_Definition );
    Self.MakeSection( sc_Note );
    Self.MakeSection( sc_Documentation );

    // Display the partonomy
    if ( not ( Self.Actual.TetraTip in [ tp_voc, tp_int ] ) ) then
      Self.MakeSection( sc_LightPartonomy );
      Self.MakeSection( sc_FullPartonomy );

    // Display the taxonomy
    Self.MakeSection( sc_Taxonomy );
    // Self.MakeSection( sc_Level );

    // Display page footer
    Self.MakeFooter;
  end;
end; // _______________________________________________________tEntityPage.Build

procedure          tEntityPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tEntityPage.MakeHeader
  * Make the header of an Entity Page *
  Description:
  This method prepares the header of an Entity Page. It is based on a common
  header defined for all HTML pages and an adjustment of the introductive
  text specific to the Entity Page.</P>
  The Entity page is built with three languages: the primary language is the
  language of the anatomical content; the subsidiary language is also about the
  anatomical content in a complementary view under the form of bubbles; the
  interface language is the language of presentation of the page. Potentially,
  any language may be required in any position, but these choices may be
  limited by the actual implementation.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  PageType:        String;
  LanguageType:    String;
  MyLanguages:     String;
  MySection:       TSection;
begin
  inherited;

  // Page type
  MySection := tSection.Create;
  PageType := TAH.GetLabel( reEntityPage );

  // Information on applied languages
  LanguageType := TAH.GetLabel( rePrimaryLang, False );
  MyLanguages := LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.MainLang ] + cComma;
  LanguageType := TAH.GetLabel( reSecondaryLang, False );
  MyLanguages := MyLanguages + cSpace +
                 LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.SubstLang ] + cComma;
  LanguageType := TAH.GetLabel( reDisplayLang, False );
  MyLanguages := MyLanguages + cSpace +
                 LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.DisLanguage ];

  // Finalize the introduction header
  Self.Header.Intro := PageType + cComma + cSpace +
                       MyLanguages +
                       Self.Header.Intro;

  // Prepare the legend about introduction
  Self.Header.Legend := TAH.GetBubble( rePageIntro );
end; // ______________________________________________________________MakeHeader

procedure          tEntityPage.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tEntityPage.MakeSection
  * Make a section of any type for an Entity Page *
   ===============================================
  Description:
  This method builds any section of an Entity Page. To do
  that, it creates each section with its specific type, all being descendants
  of tBiColSection.</P>
  A section is a collection of section items in any number, which are created
  by the specific methods. A section item corresponds to a single line in the
  final bi-column page. A section item defines the content to be later
  formatted in HTML format.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MySection:       tBiColSection;
begin
  // Create the sections with their specific attributes
  case ( SType ) of

    // Create the hierarchy sections
    sc_Taxonomy:
      begin
        MySection := tTaxoSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectTax );
        MySection.SectionBubble := TAH.GetBubble( reSectTax );
      end;
    sc_FullPartonomy:
      begin
        MySection := tFullPartSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectFullPart );
        MySection.SectionBubble := TAH.GetBubble( reSectFullPart );
      end;
    sc_LightPartonomy:
      begin
        MySection := tLightPartSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectLightPart );
        MySection.SectionBubble := TAH.GetBubble( reSectLightPart );
      end;

    // Create the HTML sections
    sc_identification:
      begin
        MySection := tIdSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectIdent );
        MySection.SectionBubble := TAH.GetBubble( reSectIdent );
      end;
    sc_Navigation:
      begin
        MySection := tNavSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectNavig );
        MySection.SectionBubble := TAH.GetBubble( reSectNavig );
      end;
    sc_Interface:
      begin
        MySection := tIntSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectInt );
        MySection.SectionBubble := TAH.GetBubble( reSectInt );
      end;
    sc_Latin:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectLatin );
        MySection.SectionBubble := TAH.GetBubble( reSectLatin );
      end;
    sc_English:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectEnglish );
        MySection.SectionBubble := TAH.GetBubble( reSectEnglish );
      end;
    sc_French:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectFrench );
        MySection.SectionBubble := TAH.GetBubble( reSectFrench );
      end;
    sc_Spanish:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectSpanish );
        MySection.SectionBubble := TAH.GetBubble( reSectSpanish );
      end;
    sc_Russian:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectRussian );
        MySection.SectionBubble := TAH.GetBubble( reSectRussian );
      end;
    sc_definition:
      begin
        MySection := tDefSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectTaxDef );
        MySection.SectionBubble := TAH.GetBubble( reSectTaxDef );
      end;
    sc_Property:
      begin
        MySection := tPropSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectProp );
        MySection.SectionBubble := TAH.GetBubble( reSectProp );
      end;
    sc_Vocabulary:
      begin
        MySection := tVocSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectOcc );
        MySection.SectionBubble := TAH.GetBubble( reSectOcc );
      end;
    sc_Level:
      begin
        MySection := tLevelSection.Create;
        MySection.SectionTitle := paBrother[ en ];
        MySection.SectionBubble := bbBrother[ en ];
      end;
    sc_Linkage:
      begin
        MySection := tLinkSection.Create;
        MySection.SectionTitle := paLinkage[ en ];
        MySection.SectionBubble := bbLinkage[ en ];
      end;
    sc_Documentation:
      begin
        MySection := tDocumSection.Create;
        MySection.SectionTitle := paDocum[ en ];
        MySection.SectionBubble := bbDocum[ en ];
      end;
    sc_Note:
      begin
        MySection := tNoteSection.Create;
        MySection.SectionTitle := paNote[ en ];
        MySection.SectionBubble := bbNote[ en ];
      end;
    else
      MySection := nil;
  end; // case on all section types of an Entity page

  // Build the sections
  if ( MySection <> nil ) then
  begin
    MySection.PageType := ca_Entity;
    MySection.SectionType := SType;
    MySection.Entity := Self.Actual;
    MySection.UID := Self.Actual.Tetra;
    MySection.Build;

    // Add the section to the Entity Page
    Self.AddSection( MySection );
  end;
end; // _________________________________________________tEntityPage.MakeSection

procedure          tEntityPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tEntityPage.WritePage
  * Write an Entity Page file or an Extended Page file *
   ====================================================
  Description:
  This method writes an Entity Page or an Extended Page and save it as an
  HTML file. It writes in turn the header, all sections and the footer of
  the page.</P>
  The goal of this method is the translation of all information of the page
  into HTML format. The information is stored either in the page structure
  itself, or the several sections created for the page.</P>
  The method takes care of the indentention level of each contribution,
  helping to make more readable the layout of the generated HTML page.</P>
  Due to the presence of different alphabets in the language sections, these
  pages must be encoded in UTF8.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  FileName:        String;
  ASection:        tSection;
begin

  // Build the top of HTML page with page name
  Self.Page := TStringList.Create;
  MakeTopHTMLPage( 0 );

        // Write header (inherited method)
        Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

        // Write all sections
        for Indx := 0 to Self.NbSection - 1 do
        begin
          ASection := GetSection( Indx );
          TBiColSection( ASection ).WriteSection( 4 );
        end;

        // Write footer (inherited method)
        Self.WriteFooter( 3 );

  // Build the bottom of an HTML Page
  MakeBottomHTMLPage( 0 );

  // Save page on external file
  FileName := Self.Directory + cSlash + Self.FileName;
  Page.SaveToFile( FileName, TEncoding.UTF8 );
end; // ___________________________________________________tEntityPage.WritePage

procedure          tTetraPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTetraPage.Build
  * Build a Unit Page *
  Description:
  This method builds all the sections of a Unit Page in turn. The order of
  creation of the sections is the order of presentation on the page.</P>
  The following sections are available: sc_Identification, sc_Navigation,
  sc_Latin, sc_English, sc_French, sc_Definition, sc_note, sc_LightPartonomy,
  sc_Taxonomy.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( Self.Actual <> nil ) then
  begin
    Self.MakeHeader;
    Self.MakeSection( sc_Identification );
    Self.MakeSection( sc_Navigation );
    Self.MakeSection( sc_Definition );
    Self.MakeSection( sc_Note );
    Self.MakeSection( sc_LightPartonomy );
    Self.MakeSection( sc_Taxonomy );
    Self.MakeFooter;
  end;
end; // ________________________________________________________tTetraPage.Build

procedure          tTetraPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTetraPage.MakeHeader
  * Make a header of a Unit Page *
  Description:
  This method prepares the header of a Unit Page. It is based on a common
  header defined for all HTML pages and an adjustment of the introductive
  text specific to the Unit Page.</P>
  The Unit page is built with three languages: the primary language is the
  language of the anatomical content; the subsidiary language is also about the
  anatomical content in a complementary view under the form of bubbles; the
  interface language is the language of presentation of the page. Potentially,
  any language may be required in any position, but these choices may be
  limited by the actual implementation.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  PageType:        String;
  LanguageType:    String;
  MyLanguages:     String;
  MySection:       tSection;
begin
  inherited;

  // Page type
  MySection := TSection.Create;
  PageType := TAH.GetLabel( reUnitPage );

  // Information on applied languages
  LanguageType := TAH.GetLabel( rePrimaryLang, False );
  MyLanguages := LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.MainLang ] + cComma;
  LanguageType := TAH.GetLabel( reSecondaryLang, False );
  MyLanguages := MyLanguages + cSpace +
                 LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.SubstLang ] + cComma;
  LanguageType := TAH.GetLabel( reDisplayLang, False );
  MyLanguages := MyLanguages + cSpace +
                 LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.DisLanguage ];

  // Finalize the introduction header
  Self.Header.Intro := PageType + cComma + cSpace +
                       MyLanguages +
                       Self.Header.Intro;

  // Prepare the legend about introduction
  Self.Header.Legend := TAH.GetLabel( rePageIntro );
end; // ______________________________________________________________MakeHeader

procedure          tTetraPage.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTetraPage.MakeSection
  * Make a section of any type for a Unit Page *
   ============================================
  Description:
  This method builds any section of an Unit Page. To do
  that, it creates each section with its specific type, all being descendants
  of tBiColSection.</P>
  A section is a collection of section items in any number, which are created
  by the specific methods. A section item corresponds to a single line in the
  final bi-column page. A section item defines the content to be later
  formatted in HTML format.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MySection:       tBiColSection;
begin

  // Store the items of the section by section type
  case SType of
    sc_Identification:
      begin
        MySection := tIdSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectIdent );
        MySection.SectionBubble := TAH.GetBubble( reSectIdent );
      end;
    sc_Navigation:
      begin
        MySection := tNavSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectNavig );
        MySection.SectionBubble := TAH.GetBubble( reSectNavig );
      end;
    sc_Definition:
      begin
        MySection := tDefSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectTaxDef );
        MySection.SectionBubble := TAH.GetBubble( reSectTaxDef );
      end;
    sc_Latin:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectLatin );
        MySection.SectionBubble := TAH.GetBubble( reSectLatin );
      end;
    sc_English:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectEnglish );
        MySection.SectionBubble := TAH.GetBubble( reSectEnglish );
      end;
    sc_French:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectFrench );
        MySection.SectionBubble := TAH.GetBubble( reSectFrench );
      end;
    sc_Spanish:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectSpanish );
        MySection.SectionBubble := TAH.GetBubble( reSectSpanish );
      end;
    sc_Russian:
      begin
        MySection := tLangSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectRussian );
        MySection.SectionBubble := TAH.GetBubble( reSectRussian );
      end;
    sc_Note:
      begin
        MySection := tNoteSection.Create;
        MySection.SectionTitle := paNote[ en ];
        MySection.SectionBubble := bbNote[ en ];
      end;
    sc_LightPartonomy:
      begin
        MySection := tTetraPartSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectPart );
        MySection.SectionBubble := TAH.GetBubble( reSectPart );
      end;
    sc_Taxonomy:
      begin
        MySection := tTetraTaxSection.Create;
        MySection.SectionTitle := TAH.GetLabel( reSectTax );
        MySection.SectionBubble := TAH.GetBubble( reSectTax );
      end;
    else
      MySection := nil;
  end; // case on all scetion type ot a Unit page

  // Build the sections
  if ( MySection <> nil ) then
  begin
    MySection.SectionType := SType;
    MySection.Entity := Self.Actual;
    MySection.UID := Self.UID;
    MySection.PageType := ca_Tetra;
    MySection.Build;

    // Add the section to the Unit Page
    Self.AddSection( MySection );
  end;
end; // __________________________________________________tTetraPage.MakeSection

procedure          tTetraPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTetraPage.WritePage
  * Write a Unit Page *
  Description:
  This method writes a Unit Page as it has been created through the build
  method and save it as an HTML file. It writes in turn the header, all
  sections and the footer of the page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbSection:       Integer;
  Page:            TStringList;
  ASection:        tSection;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  MakeTopHTMLPage( 0 );

      // Write header (inherited method)
      Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

        // Write all sections
        NbSection := Self.NbSection;
        for Indx := 0 to NbSection - 1 do
        begin
          ASection := GetSection( Indx );
          TBiColSection( ASection ).WriteSection( 4 );
        end;

        // Write footer (inherited method)
        Self.WriteFooter( 3 );

  // Build the bottom of an HTML Page
  MakeBottomHTMLPage( 0 );

  // Save page on external file
  FileName := Self.Directory + Self.FileName;
  Page.SaveToFile( FileName, TEncoding.UTF8 );
end; // ____________________________________________________tTetraPage.WritePage

function           tValidPage.GetNbSection()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbSection
  * Find the number of section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FSection );
end; // ____________________________________________________________GetNbSection

procedure          tValidPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tValidPage.Build
  * Build a single Segmentation Page *
  Description:
  This method builds all the sections of a Segmentation Page in turn. The
  sections to be built are possibly different according to the active level.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
begin
  Actual := Self.Actual;
  if ( Actual <> nil ) then
  begin

    Self.MakeHeader;
    Self.MakeSection( sc_Identification );
    // Self.MakeSection( sc_Navig4 );
    // Self.MakeSection( sc_Navigation );
    Self.MakeSection( sc_ValidFormula );
    Self.MakeSection( sc_ValidVocab );
    Self.MakeSection( sc_ValidTerm );
    Self.MakeFooter;
  end;
end; // ________________________________________________________tValidPage.Build

procedure          tValidPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeader
  * Make a header of a Validation Page *
  Description:
  This method prepares the header of a Validation Page. It is based on a
  common header defined for all HTML pages and an adjustment of the introductive
  text specific to the Validation Page, depending on the type of page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyHeader:        String;
begin

  // Standard header
  inherited;

    // Prepare selectively the header
    if ( ( Self.Actual.ListPart = cTypeListPage[ li_part4 ] ) and
         ( Self.CategPage = ca_ListPart ) ) then
      MyHeader := heValidPart4[ en ]
    else
    if ( ( Self.Actual.ListTax = cTypeListPage[ li_tax4 ] ) and
         ( Self.CategPage = ca_ListTax ) ) then
      MyHeader := heValidTax4[ en ]
    else
    if ( ( Self.Actual.ListPart = cTypeListPage[ li_part3 ] ) and
         ( Self.CategPage = ca_ListPart ) ) then
      MyHeader := heValidPart3[ en ]
    else
    if ( ( Self.Actual.ListTax = cTypeListPage[ li_tax3 ] ) and
         ( Self.CategPage = ca_ListTax ) ) then
      MyHeader := heValidTax3[ en ];
    Self.Header.Intro := MyHeader + cSpace + Self.Header.Intro;
end; // ______________________________________________________________MakeHeader

procedure          tValidPage.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tValidPage.MakeSection
  * Make a section of any type for a Validation Page *
  Description:
  This method is call for any section for a Validation Page and distributes
  the work to the specific methods corresponding to each section type.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyValidSection:  tValidSection;
  MyListSection:   tBiColSection;
begin
  // Create a new section
  if ( SType in [ sc_ValidTerm, sc_ValidFormula, sc_ValidVocab ] ) then
  begin
    MyValidSection := tValidSection.Create;
    MyValidSection.SectionType := SType;
    MyValidSection.Entity := Self.Actual;
    MyValidSection.PageType := ca_Valid;
  end else
  begin
    MyListSection := tBiColSection.Create;
    MyListSection.SectionType := SType;
    MyListSection.Entity := Self.Actual;
    MyListSection.PageType := ca_Valid;
  end;

  // Store the items of the section by section type
  // Idenfification section
  if ( SType = sc_Identification ) then
  begin
    MyListSection.SectionTitle := TAH.GetLabel( reSectIdent );
    MyListSection.SectionBubble := TAH.GetBubble( reSectIdent );
    tIdSection( MyListSection ).Build;
  end else

  //
  {if ( SType = sc_Navig4 ) then
  begin
    MyListSection.SectionTitle := paNavig4[ en ];
    MyListSection.SectionBubble := bbNavig4[ en ];
    Self.MakeLevel4Section( MyListSection );
  end else
  if ( SType = sc_Navigation ) then
  begin
    MyListSection.SectionTitle := paNavigation[ en ];
    MyListSection.SectionBubble := bbNavigation[ en ];
    Self.MakeNavigationSection( MyListSection );
  end else}

  // Validation of vocabulary
  // if ( SType = sc_ValidVocab ) then
  // begin
  //   MyValidSection.SectionTitle := scValidVocab[ en ];
  //   MyValidSection.SectionBubble := bsValidVocab[ en ];
  //   tValidVocabSection( MyValidSection ).Build;
  // end;

  // Validation section
  if ( SType = sc_ValidTerm ) then
  begin
    MyValidSection.SectionTitle := scValidPart[ en ];
    MyValidSection.SectionBubble := bsValidPart[ en ];
    tValidTermSection( MyValidSection ).Build;
  end;

  // Add the section to the Segmentation Page
  if ( SType in [ sc_ValidTerm, sc_ValidFormula, sc_ValidVocab ] ) then
    Self.AddSection( tBiColSection( MyValidSection ) )
  else
    Self.AddSection( MyListSection );
end; // __________________________________________________tValidPage.MakeSection

procedure          tValidPage.MakeNavigationSection(
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeNavigationSection
  * Make the navigation section for a Validation Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  TetValue:        Integer;
  NbTetra4:        Integer;
  MyTID:           ^Integer;
  ViewCode:        String;
  Value:           String;
  Bubble:          String;
  AnItem:          tBiColItem;
  Main:            tEntity;
  Tetra4:          tTetrahedron;
  ListTetra4:      tList;
  MyMain:          tEntity;
begin
  // Initial stuff
  Main := Self.Actual;
  if ( Main <> nil ) then
  begin
    TetValue := Main.Niveau4;
    ListTetra4 := TList.Create;
    NbTetra4 := TAH.GetListLevel4( TetValue, ListTetra4 );

    // Search for all level 5 brother entities
    for Indy := 0 to NbTetra4 - 1 do
    begin
      MyTID := ListTetra4[ Indy ];
      Tetra4 := TAH.GetTetrahedronByTID( MyTID^ );
      if ( Tetra4 <> nil ) then
      begin
        MyMain := Tetra4.Main;
        if ( MyMain = nil ) then
          MyMain := Tetra4.Genr;

        // Retrieve the sorted list of units at level 5
        TetValue := Tetra4.TetraID;
        ViewCode := cTAH + IntToStr( TetValue );
        Value := MyMain.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
        Bubble := MyMain.GetLibelle( lb_Base, TAH.SubstLang );
        if ( MyMain.TID <> Main.TID ) then
        begin
          Value := AOTAG + cHrefEmpty + '../' + cValidation + cSpace +
                   cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                   IntToStr( MyMain.TID ) + cSpace + cValidation +
                   cSpace + cLgShort[ TAH.SubstLang ] +
                   cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
        end;

        // Display the next line
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.AltLabel := cEmpty;
        AnItem.Value := Value;
        AnItem.Bubble := Bubble;
        AnItem.Indent := cEmpty;
        AnItem.PartLink := cEmpty;
        MySection.AddItem( AnItem );
      end;
    end; // for
  end;
end; // ___________________________________________________MakeNavigationSection

procedure          tValidPage.MakeLevel4Section(
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLevel4Section
  * Make the level 4 section for a Validation Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  TetValue:        Integer;
  NewValue:        Integer;
  NbTetra3:        Integer;
  MyTID:           ^Integer;
  ViewCode:        String;
  Value:           String;
  Bubble:          String;
  AnItem:          tBiColItem;
  Main:            tEntity;
  NewMain:         tEntity;
  Tetra3:          tTetrahedron;
  ListTetra3:      tList;
  MyMain:          tEntity;
begin
  // Initial stuff
  Main := Self.Actual;
  if ( Main <> nil ) then
  begin
    TetValue := Main.Niveau3;
    if ( TetValue = 0 ) then
    begin
      NewValue := Main.Niveau4;
      NewMain := TAH.GetEntityByTID( NewValue );
      TetValue := NewMain.Niveau3;
    end else
      NewMain := Main;
    ListTetra3 := TList.Create;
    NbTetra3 := TAH.GetListLevel3( TetValue, ListTetra3 );

    // Search for all level 5 brother entities
    for Indy := 0 to NbTetra3 - 1 do
    begin
      MyTID := ListTetra3[ Indy ];
      Tetra3 := TAH.GetTetrahedronByTID( MyTID^ );
      if ( Tetra3 <> nil ) then
      begin
        MyMain := Tetra3.Main;
        if ( MyMain = nil ) then
          MyMain := Tetra3.Genr;

        // Retrieve the sorted list of tetrahedrons at level 4
        TetValue := Tetra3.TetraID;
        ViewCode := cTAH + IntToStr( TetValue );
        Value := MyMain.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
        Bubble := MyMain.GetLibelle( lb_Base, TAH.SubstLang );
        if ( MyMain.TID <> NewMain.TID ) then
        begin
          Value := AOTAG + cHrefEmpty + '../' + cValidation + cSpace +
                   cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                   IntToStr( MyMain.TID ) + cSpace + cValidation +
                   cSpace + cLgShort[ TAH.SubstLang ] +
                   cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
        end;

        // Display the next line
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.AltLabel := cEmpty;
        AnItem.Value := Value;
        AnItem.Bubble := Bubble;
        AnItem.Indent := cEmpty;
        AnItem.PartLink := cEmpty;
        MySection.AddItem( AnItem );
      end;
    end;
  end;
end; // _______________________________________________________MakeLevel4Section

procedure          tValidPage.AddSection(
  MySection:       tBiColSection ) ;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddSection
  * Add a section to the validation Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbSect:          Integer;
begin
  NbSect := Self.NbSection;
  Inc( NbSect );
  SetLength( Self.FSection, NbSect );
  Self.FSection[ NbSect - 1 ] := MySection;
end; // ______________________________________________________________AddSection

function           tValidPage.GetSection(
  PosSection:      Integer )
  :                tBiColSection;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSection
  * Property read method for number of section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Self.FSection[ PosSection ];
end; // ______________________________________________________________GetSection

procedure          tValidPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tValidPage.WritePage
  * Write the Validation Page file *
  Description:
  This method writes a Validation Page and save it as an HTML file. It writes
  in turn the header, all sections and the footer of the page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbSection:       Integer;
  PageName:        String;
  Page:            TStringList;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  PageName := Self.PageName;
  AddTag( DOCTYPETAG, 0 );
  AddTag( HTMLTAG, 0 );
    AddTag( HEADTAG, 1 );
      AddTag( TITLETAG + PageName + TITLEETAG, 2 );
      AddTag( CALLCSSVIEWTAG, 2 );
      AddTag( CALLCSSPRINTTAG, 2 );
    AddTag( HEADETAG, 1 );
    AddTag( BODYTAG, 1 );
      AddTag( DIVOTAG + cIdContainer + cAnr, 2 ); // open #Container700

      // Write header (inherited method)
      Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

        // Write all sections
        NbSection := Self.NbSection;
        for Indx := 0 to NbSection - 1 do
        begin
          Self.WriteSection( Indx, 4 );
        end;

        // Write footer (inherited method)
        Self.WriteFooter( 3 );

        // Close the validation page
        AddTag( DIVETAG, 3 ); // close #Body700
      AddTag( DIVETAG, 2 ); // close #Container700
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSpace + cLgShort[ lt_English ] +
                   cSlash + Self.FileName );
end; // ____________________________________________________tValidPage.WritePage

procedure          tValidPage.WriteSection(
  PosSection:      Integer;
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tValidPage.WriteSection
  * Write a section of any type for a Segmentation Page *
  Description:
  This method writes a single section of a Segmentation Page. Each section
  is made of a variable number of items, which are handled in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbItem:          Integer;
  LinkText:        String;
  Content:         String;
  MyTitle:         String;
  MyBubble:        String;
  ASection:        tValidSection;
  HTMLSection:     tBiColSection;
  AnItem:          tValidEntry;
  OtherItem:       tBiColItem;
begin
  ASection := nil;
  HTMLSection := nil;
  if ( PosSection <= 0 ) then
  begin
    HTMLSection := Self.GetSection( PosSection );
    NbItem := HTMLSection.NbItem;
    MyTitle := HTMLSection.SectionTitle;
    MyBubble := HTMLSection.SectionBubble;
  end else
  begin
    ASection := tValidSection( Self.GetSection( PosSection ) );
    NbItem := ASection.NbLine;
    MyTitle := ASection.SectionTitle;
    MyBubble := ASection.SectionBubble;
  end;
  if ( ( ASection <> nil ) or ( HTMLSection <> nil ) ) then
  begin

    // Skip an empty section
    if ( NbItem = 0 ) then
      Exit;

    // Write the section title
    if ( IsLarge ) then
      AddTag( TABLEOTAG + cSectionTitle1400 + cAnr, Lev )
    else
      AddTag( TABLEOTAG + cSectionTitle700 + cAnr, Lev );
      AddTag( TRTAG, Lev + 1 );
        MakeTD( cClassTitleSect, MyTitle, MyBubble, Lev + 2 );
      AddTag( TRETAG, Lev + 1 );
    AddTag( TABLEETAG, Lev );
    AddTag( TABLEOTAG + cSectionContent + cAnr, Lev );

    // Loop on all items
    for Indx := 0 to NbItem - 1 do
    begin

      // HTML sections
      if ( PosSection <= 0 ) then
      begin

        // Write the item content
        OtherItem := HTMLSection.GetItem( Indx );
        if ( AnItem <> nil ) then
        begin
          AddTag( TRTAG, Lev + 1 );
            MakeTD( cClassRub, OtherItem.SrcLabel, OtherItem.AltLabel,
                    Lev + 3 );
            MakeTD( cClassSpec, OtherItem.Value, cEmpty, Lev + 3 );
        end;
      end else

      // Validation section
      begin

        // Write the item content
        AnItem := ASection.GetLine( Indx );
        if ( AnItem <> nil ) then
        begin
          AddTag( TRTAG, Lev + 1 );

            // New entity line
            if ( AnItem.ViewCode <> cEmpty ) then
            begin
              MakeTD( cClassRubm, AnItem.ViewCode, cEmpty, Lev + 2 );
              LinkText := AnItem.Term;
              if ( AnItem.OriLA <> cEmpty ) then
                LinkText := AOTAG + AnItem.OriLA + LinkText + AETAG;
              Content := LinkText;
              if ( Indx = NbItem - 1 ) then
                Content := AnItem.Title;
              MakeTD( cClassSpec, Content, AnItem.Bubble, Lev + 2 );
            end else

            // New inquery line
            if ( AnItem.DateInquiry <> cEmpty ) then
            begin
              MakeTD( cClassRubm, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassSpec, AnItem.Title, AnItem.Source, Lev + 2 );
            end else

            // Action line
            if ( AnItem.DateAction <> cEmpty ) then
            begin
              MakeTD( cClassRubm, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassSpec, AnItem.DateAction + cSpace + AnItem.Action,
                      AnItem.Source, Lev + 2 );
            end else

            // Statistic line
            if ( AnItem.ViewCode = cEmpty ) then
            begin
              MakeTD( cClassRubm, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassSpec, AnItem.Title, AnItem.Bubble, Lev + 2 );
            end;

          AddTag( TRETAG, Lev + 1 );
        end;
      end;
    end; // for

    AddTag( TABLEETAG, Lev );
  end;
end; // _________________________________________________tValidPage.WriteSection

procedure          tTA98Page.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTA98Page.Build
  * Build a single TA98 Page *
  Description:
  This method builds all the sections of a TA98 Page in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
begin
  Actual := Self.Actual;
  if ( Actual <> nil ) then
  begin
    Self.MakeHeader;
    Self.MakeSection( sc_TA98Navigation );
    Self.MakeSection( sc_TA98List );
    Self.MakeFooter;
  end;
end; // _________________________________________________________tTA98Page.Build

procedure          tTA98Page.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeader
  * Make a header of a TA98 Page *
  Description:
  This method prepares the header of a TA98 Page. It is based on a common
  header defined for all HTML pages and an adjustment of the introductive
  text specific to the TA98 Page.</P>
  The adjustment is dependant on the type of TA98 Page, either long by
  section (common 8-digit code) or short by subsection.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyPage:          String;
begin
  inherited;
  if ( Self.Single = md_short ) then
    MyPage := tiTA98ShortPage[ en ]
  else
  if ( Self.Single = md_sect ) then
    MyPage := tiTA98LongPage[ en ]
  else
  if ( Self.Single = md_subchap ) then
    MyPage := tiTA98SubPage[ en ]
  else
  if ( Self.Single = md_chap ) then
    MyPage := tiTA98ChapPage[ en ];
  Self.Header.Intro := MyPage + cSpace + Self.Header.Intro;
end; // ______________________________________________________________MakeHeader

procedure          tTA98Page.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTA98Page.MakeSection
  * Make a section of any type for a TA98 Page *
  Description:
  This method is call for any section for a TA98 Page and distributes
  the work to the specific methods corresponding to each section type.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Recurs:          tModeTA98;
  MySection:       tTA98ListSection;
  Complement:      tListSection;
begin
  // Create a new section
  MySection := tTA98ListSection.Create;
  MySection.SectionType := SType;
  MySection.Entity := Self.Actual;

  // Store the items of the section by section type
  if ( SType = sc_TA98Navigation ) then
  begin
    Recurs := Self.Single;
    MySection.SectionTitle := paTA98Navig[ en ];
    MySection.SectionBubble := bbTA98Navig[ en ];
    tTA98NavSection( MySection ).Build;
    Self.AddSection( MySection );
  end;
  if ( SType = sc_TA98List ) then
  begin
    MySection.SectionTitle := paTA98List[ en ];
    MySection.SectionBubble := bbTA98List[ en ];
    Complement := TListSection.Create;
    Complement.SectionType := sc_TA98Notes;
    Complement.SectionTitle := 'TA98 trace notes';
    Complement.SectionBubble := cEmpty;
    Recurs := Self.Single;
    TTA98DetailSection( MySection ).Build;
    Self.AddSection( MySection );
    Self.AddSection( Complement );
  end;
end; // ___________________________________________________tTA98Page.MakeSection

procedure          tTA98Page.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTA98Page.WritePage
  * Write a TA98 List Page file *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  PageName:        String;
  MyID:            String;
  Page:            TStringList;
  ATA98Section:    tTA98ListSection;
  ASection:        tListSection;
  MyType:          tSectionType;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  PageName := Self.PageName;
  AddTag( DOCTYPETAG, 0 );
  AddTag( HTMLTAG, 0 );
    AddTag( HEADTAG, 1 );
      AddTag( TITLETAG + PageName + TITLEETAG, 2 );
      AddTag( CALLCSSVIEWTAG, 2 );
      AddTag( CALLCSSPRINTTAG, 2 );
      AddTag( CALLJSENTITY, 2 );
    AddTag( HEADETAG, 1 );
    AddTag( BODYTAG, 1 );
      AddTag( DIVOTAG + cIdContainer + cAnr, 2 ); // open #Container700

        // Write header (inherited method)
        Self.WriteHeader( 3 );
          AddTag( DIVOTAG + cIdBody700 + cAnr, 4 ); // open #Body700

            // Open the TA98 navigation section
            if ( IsLarge ) then
              AddTag( TABLEOTAG + cSectionTitle700 + cAnr, 6 )
            else
              AddTag( TABLEOTAG + cSectionTitle700 + cAnr, 6 );
              AddTag( TRTAG, 7 );
                ATA98Section := TTA98ListSection( Self.GetSection( 0 ) );
                MakeTDTA98TitleSection( ATA98Section, 8 );
              AddTag( TRETAG, 7 );
            AddTag( TABLEETAG, 6 );

            // Open a DIV tag for the section with specific ID
            MyType := ATA98Section.SectionType;
            MyID := 'Id=' + cDQuote + cIDSection[ MyType ] + cDQuote;
            AddTag( DIVOTAG + MyID + cAnr, 5 );

            // Write all the lines
            AddTag( TABLETAG, 6 );
              ATA98Section.WriteLines( 7 );
            AddTag( TABLEETAG, 6 );

            // Close the DIV tag
            AddTag( DIVETAG + cOComment + cIDSection[ MyType ] + cEComment, 5 );

            // Open the TA98 list section
            if ( IsLarge ) then
              AddTag( TABLEOTAG + cSectionTitle1400 + cAnr, 6 )
            else
              AddTag( TABLEOTAG + cSectionTitle700 + cAnr, 6 );
              AddTag( TRTAG, 7 );
                ATA98Section := TTA98ListSection( Self.GetSection( 1 ) );
                MakeTDTA98TitleSection( ATA98Section, 8 );
              AddTag( TRETAG, 7 );
            AddTag( TABLEETAG, 6 );

            // Open a DIV tag for the section with specific ID
            MyType := ATA98Section.SectionType;
            MyID := 'Id=' + cDQuote + cIDSection[ MyType ] + cDQuote;
            AddTag( DIVOTAG + MyID + cAnr, 5 );

            // Write all the lines
            AddTag( TABLETAG, 6 );
              ATA98Section.WriteLines( 7 );
            AddTag( TABLEETAG, 6 );

            // Close the DIV tag
            AddTag( DIVETAG + cOComment + cIDSection[ MyType ] + cEComment, 5 );

            // Open the TA98 trace notes section
            if ( IsLarge ) then
              AddTag( TABLEOTAG + cSectionTitle1400 + cAnr, 6 )
            else
              AddTag( TABLEOTAG + cSectionTitle700 + cAnr, 6 );
              AddTag( TRTAG, 7 );
                ASection := TListSection( Self.GetSection( 2 ) );
                MakeTDTitleSection( ASection, 8 );
              AddTag( TRETAG, 7 );
            AddTag( TABLEETAG, 6 );

            // Open a DIV tag for the section with specific ID
            MyType := ASection.SectionType;
            MyID := 'Id=' + cDQuote + cIDSection[ MyType ] + cDQuote;
            AddTag( DIVOTAG + MyID + cAnr, 5 );

            // Write all the notes
            AddTag( TABLETAG, 6 );
              ASection.WriteNotes( 7 );
            AddTag( TABLEETAG, 6 );

            // Close the DIV tag
            AddTag( DIVETAG + cOComment + cIDSection[ MyType ] + cEComment, 5 );
          AddTag( DIVETAG + cOComment + 'Body700' + cEComment, 4 );

        // Write footer (inherited method)
        Self.WriteFooter( 3 );

        // Close the global divisions
      AddTag( DIVETAG + cOComment + 'Container700' + cEComment, 2 );

      // Add a javascript to call for initialisation of the 3 hierarchies
      AddTag( SCRIPTTAG, 2 );
        AddTag( 'InitSections' + cRol + cSpace + cRor + cSemi, 3 );
      AddTag( SCRIPTETAG, 2 );

      // Close global tags
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSpace + cLgShort[ lt_English ] +
                   cSlash + Self.FileName, TEncoding.UTF8 );
end; // _____________________________________________________tTA98Page.WritePage

procedure          tSegmentPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TSegmentPage.Build
  * Build a single Segmentation Page *
  Description:
  This method builds all the sections of a Segmentation Page in turn. The
  sections to be built are possibly different according to the active level.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
begin
  Actual := Self.Actual;
  if ( Actual <> nil ) then
  begin
    Self.MakeHeader;
    Self.MakeSection( sc_Identification );
    if ( Self.Level = 5 ) then
    begin
      Self.MakeSection( sc_Navigation );
      Self.MakeSection( sc_SegLevel5Short );
      Self.MakeSection( sc_SegLevel5Full );
    end else
    if ( Self.Level = 4 ) then
    begin
      Self.MakeSection( sc_SegLevel4 );
    end;
    Self.MakeFooter;
  end;
end; // ______________________________________________________tSegmentPage.Build

procedure          tSegmentPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeader
  * Make a header of a Segmentation Page *
  Description:
  This method prepares the header of a Segmentation Page. It is based on a
  common header defined for all HTML pages and an adjustment of the introductive
  text specific to the Segmentation Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited;
  if ( Self.Level = 4 ) then
  begin
    Self.Header.Intro :=
      tiL4SegmentPage[ en ] + cSpace + Self.Header.Intro;
  end else
  if ( Self.Level = 5 ) then
  begin
    Self.Header.Intro :=
      tiL5SegmentPage[ en ] + cSpace + Self.Header.Intro;
  end;
end; // ______________________________________________________________MakeHeader

procedure          tSegmentPage.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSection
  * Dispatch sections for a Segmentation Page *
  Description:
  This method is call for any section for a Segmentation Page and distributes
  the work to the specific methods corresponding to each section type.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MySection:       tBiColSection;
begin
  // Create a new section
  MySection := tBiColSection.Create;
  MySection.SectionType := SType;
  MySection.Entity := Self.Actual;
  MySection.PageType := ca_Segment;

  // Store the items of the section by section type
  if ( SType = sc_Identification ) then
  begin
    MySection.SectionTitle := TAH.GetLabel( reSectIdent );
    MySection.SectionBubble := TAH.GetBubble( reSectIdent );
    TIdSection( MySection ).Build;
  end else
  if ( SType = sc_Navigation ) then
  begin
    MySection.SectionTitle := paNavigation[ en ];
    MySection.SectionBubble := bbNavigation[ en ];
    Self.MakeNavigationSection( MySection );
  end else
  if ( SType = sc_SegLevel4 ) then
  begin
    MySection.SectionTitle := paL4[ en ];
    MySection.SectionBubble := bbL4[ en ];
    Self.MakeL4TetraSection( MySection );
  end else
  if ( SType = sc_SegLevel5Short ) then
  begin
    MySection.SectionTitle := paL5Short[ en ];
    MySection.SectionBubble := bbL5Short[ en ];
    Self.MakeL5TetraSection( MySection );
  end else
  if ( SType = sc_SegLevel5Full ) then
  begin
    MySection.SectionTitle := paL5Full[ en ];
    MySection.SectionBubble := bbL5Full[ en ];
    Self.MakeL5FullSection( MySection );
  end;

  // Add the section to the Segmentation Page
  Self.AddSection( MySection );
end; // _____________________________________________________________MakeSection

procedure          tSegmentPage.MakeNavigationSection(
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeNavigationSection
  * Make a navigation section for a Segmentation Page *
  Description:
  This method retrieves the entity at level 4 for the specified selected
  entity, prepares its values and builds the corresponding hyperlink for
  display in this section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TetID:           Integer;
  TID4:            Integer;
  Value:           String;
  Bubble:          String;
  Main:            tEntity;
  Actual:          tEntity;
  Tetra:           tTetrahedron;
  AnItem:          tBiColItem;
begin
  // Initial stuff
  Main := Self.Actual;
  if ( Main <> nil ) then
  begin

    // Retrieve the level 4 entity
    TetID := Main.Tetra;
    Tetra := TAH.GetTetrahedronByTID( TetID );
    Actual := nil;
    if ( Tetra <> nil ) then
    begin
      TID4 := Tetra.Genr.Niveau4;
      Actual := TAH.GetEntityByTID( TID4 );
    end;
    if ( Actual <> nil ) then
    begin

      // Prepare the value with hyperlink
      Value := Main.GetLibelle( lb_Base, TAH.MainLang );
      Value := AOTAG + cHrefEmpty + '../' + cSegmentation + cSpace +
               cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
               IntToStr( Actual.TID ) + cSpace + 'Level4' +
               cSpace + cLgShort[ TAH.SubstLang ] +
               cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
      Bubble := Main.GetLibelle( lb_Base, TAH.SubstLang );

      // Link to level 4
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := 'Level 4';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := Value;
      AnItem.Bubble := Bubble;
      MySection.AddItem( AnItem );
    end;
  end;
end; // ___________________________________________________MakeNavigationSection

procedure          tSegmentPage.MakeL4TetraSection(
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeL4TetraSection
  * Make an level 4 tetrahedron section for a Segmentation Page *
  Description:
  This procedure scans all tetrahedrons which are present in the specified
  level 4 identifier and for each of them establishes the list of all
  corresponding tetrahedrons at level 5.</P>
  The entire list is displayed using the main entities of each tetrahedron.
  The traditional terms are used when available, otherwise the short display
  term. The number of tetrahedrons and the number of entities is given at
  the bottom of the list</P>
  Each initial tetrahedron of a sublist at level 5 is made marked by bold
  characters. In addition, it has an hyperlink to the corresponding level 5
  Segmentation Page, where all entities are visible.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Start:           Integer;
  TetValue:        Integer;
  NbTetra4:        Integer;
  NbTetra5:        Integer;
  ActNiv:          Integer;
  NbItem:          Integer;
  NbEntity:        Integer;
  Plus:            Integer;
  MyTID:           ^Integer;
  ListTetra4:      tList;
  ListTetra5:      tList;
  ViewCode:        String;
  Value:           String;
  Bubble:          String;
  MyIndent:        String;
  Stack:           Array [ 1 .. 20 ] of Integer;
  Main:            tEntity;
  Tetra4:          tTetrahedron;
  Tetra5:          tTetrahedron;
  AnItem:          tBiColItem;
  Color:           tLanguage;
begin
  // Initial stuff
  Start := 0;
  NbItem := 0;
  NbEntity := 0;
  Main := Self.Actual;
  if ( Main <> nil ) then
  begin

    // Retrieve the sorted list of tetrahedrons at level 4
    TetValue := Main.TID;
    ListTetra4 := TList.Create;
    NbTetra4 := TAH.GetListLevel4( TetValue, ListTetra4 );

    // Loop at level 4
    for Indy := 0 to NbTetra4 - 1 do
    begin
      MyTID := ListTetra4[ Indy ];
      Tetra4 := TAH.GetTetrahedronByTID( MyTID^ );
      if ( Tetra4 <> nil ) then
      begin

        // Retrieve the sorted list of tetrahedrons at level 5
        TetValue := Tetra4.TetraID;
        ListTetra5 := TList.Create;
        NbTetra5 := TAH.GetListTetra( TetValue, ListTetra5 );

        // Display the tetrahedrons
        ActNiv := 0;
        for Indx := 0 to NbTetra5 - 1 do
        begin
          MyTID := ListTetra5[ Indx ];
          Tetra5 := TAH.GetTetrahedronByTID( MyTID^ );
          if ( Tetra5 <> nil ) then
          begin
            ViewCode := CTAH + IntToStr( Tetra5.TetraID );
            Value := Tetra5.Main.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
            Bubble := Tetra5.Main.GetLibelle( lb_Base, TAH.SubstLang );

            // Add hyperlink to first tetrahedron at level 5
            if ( Indx = 0 ) then
            begin
              Value := '<B>' + Value + '</B>';
              Value := AOTAG + cHrefEmpty + '../' + cSegmentation + cSpace +
                       cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                       IntToStr( Tetra5.Main.TID ) + cSpace + cSegmentation +
                       cSpace + cLgShort[ TAH.SubstLang ] +
                       cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
            end;

            // Remove lexical references
            if ( Tetra5.TetraType = tt_lex ) then
              Continue;

            // Search term for a reference
            if ( Tetra5.TetraType = tt_ref ) then
            begin
              if ( Tetra5.Genr <> nil ) then
                Value := Tetra5.Genr.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
              Value := Value + cSpace + cRefImg;
              if ( Tetra5.Genr = nil ) then
                Value := Value + cSpace + '(unspecified)';
            end;

            // Define the level of indentation
            if ( Indx = 0 ) then
            begin
              ActNiv := 1;
              Stack[ 1 ] := Tetra5.TetraID;
            end else
            begin
              if ( Tetra5.Main.PartAnc = Stack[ ActNiv ] )then
              begin
                Inc( ActNiv );
                Stack[ ActNiv ] := Tetra5.TetraID;
              end else
              begin
                repeat
                  if ( Tetra5.Main.PartAnc = Stack[ ActNiv ] ) then
                    Break;
                  Dec( ActNiv );
                until ( ActNiv = 0 );
                Inc( ActNiv );
                Stack[ ActNiv ] := Tetra5.TetraID;
              end;
            end;

            // Set the partonomic indentation
            Color := lt_Latin;
            MyIndent := Chr( Ord( 'a' ) + ActNiv - 1 );

            // Tag the deleted entities
            if ( Tetra5.TetraType = tt_del ) then
              Value := 'DEL' + cColumn + cSpace + Value;

            // Define and store the next line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := ViewCode;
            AnItem.AltLabel := cEmpty;
            AnItem.Value := Value;
            AnItem.Bubble := Bubble;
            AnItem.Indent := MyIndent;
            AnItem.Color := Color;
            AnItem.PartLink := cEmpty;
            MySection.AddItem( AnItem );

            // Augment the counters
            Inc( NbItem );
            Plus := 0;
            if ( Tetra5.TetraType = tt_Single ) then
              Plus := 1
            else
            if ( Tetra5.TetraType = tt_Pair ) then
              Plus := 4
            else
            if ( Tetra5.TetraType = tt_Pset ) then
              Plus := 5
            else
            if ( Tetra5.TetraType = tt_Set ) then
              Plus := 2
            else
            if ( Tetra5.TetraType = tt_Ref ) then
              Plus := 2
            else
            if ( Tetra5.TetraType = tt_Del ) then
              Plus := 1;
            Inc( NbEntity, Plus );
          end;
        end; // for Indx
      end;
    end; // for Indy

    // Display number of items and entities in the whole list
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := cEmpty;
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Number of level 4' + cSpace + IntToStr( NbTetra4 );
    AnItem.Bubble := cEmpty;
    AnItem.PartLink := cEmpty;
    MySection.AddItem( AnItem );
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := cEmpty;
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Number of items is' + cSpace + IntToStr( NbItem );
    AnItem.Bubble := cEmpty;
    AnItem.PartLink := cEmpty;
    MySection.AddItem( AnItem );
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := cEmpty;
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Number of entities is' + cSpace + IntToStr( NbEntity );
    AnItem.Bubble := cEmpty;
    AnItem.PartLink := cEmpty;
    MySection.AddItem( AnItem );
  end;
end; // ______________________________________________________MakeL4TetraSection

procedure          tSegmentPage.MakeL5TetraSection(
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeL5TetraSection
  * Make a level 5 unit section for a Segmentation Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Start:           Integer;
  TetValue:        Integer;
  NbTetra:         Integer;
  ActNiv:          Integer;
  MyTID:           ^Integer;
  ListTetra:       TList;
  ViewCode:        String;
  Value:           String;
  Bubble:          String;
  MyIndent:        String;
  Stack:           Array [ 1 .. 20 ] of Integer;
  Main:            tEntity;
  Tetra:           tTetrahedron;
  AnItem:          tBiColItem;
  Color:           tLanguage;
begin
  // Initial stuff
  Start := 0;
  Main := Self.Actual;
  if ( Main <> nil ) then
  begin

    // Retrieve the sorted list of units
    TetValue := Main.TID;
    ListTetra := tList.Create;
    NbTetra := TAH.GetListTetra( TetValue, ListTetra );

    // Display the units
    ActNiv := 0;
    for Indx := 0 to NbTetra - 1  do
    begin
      MyTID := ListTetra[ Indx ];
      Tetra := TAH.GetTetrahedronByTID( MyTID^ );
      if ( Tetra <> nil ) then
      begin

        // Skip deleted entities
        if ( Tetra.TetraType = tt_del ) then
           Break;

        // Skip lexical references
        if ( Tetra.TetraType = tt_lex ) then
           Continue;

        // Prepare the unit for display
        ViewCode := CTAH + IntToStr( Tetra.TetraID );
        Value := Tetra.Main.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
        Value := AOTAG + cHrefEmpty + '../' + cTetrahedron + cSpace +
                 cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                 IntToStr( Tetra.TetraID ) + cSpace + cTetrahedron +
                 cSpace + cLgShort[ TAH.SubstLang ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
        Bubble := Tetra.Main.GetLibelle( lb_Base, TAH.SubstLang );

        // Search term for a reference
        if ( Tetra.TetraType = tt_ref ) then
        begin
          if ( Tetra.Genr <> nil ) then
            Value := Tetra.Genr.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
          Value := Value + cSpace + cRefImg;
          if ( Tetra.Genr = nil ) then
            Value := Value + cSpace + '(unspecified)';
        end;

        // Define the level of indentation
        if ( Indx = 0 ) then
        begin
          ActNiv := 1;
          Stack[ 1 ] := Tetra.TetraID;
        end else
        begin
          if ( Tetra.Main.PartAnc = Stack[ ActNiv ] )then
          begin
            Inc( ActNiv );
            Stack[ ActNiv ] := Tetra.TetraID;
          end else
          begin
            repeat
              if ( Tetra.Main.PartAnc = Stack[ ActNiv ] ) then
                Break;
              Dec( ActNiv );
            until ( ActNiv = 0 );
            Inc( ActNiv );
            Stack[ ActNiv ] := Tetra.TetraID;
          end;
        end;

        // Set the partonomic indentation
        Color := lt_Latin;
        MyIndent := Chr( Ord( 'a' ) + ActNiv - 1 );

        // Define and store the next line
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.AltLabel := cEmpty;
        AnItem.Value := Value;
        AnItem.Bubble := Bubble;
        AnItem.Indent := MyIndent;
        AnItem.Color := Color;
        AnItem.PartLink := cEmpty;
        MySection.AddItem( AnItem );
      end;
    end; // for
  end;
end; // ______________________________________________________MakeL5TetraSection

procedure          tSegmentPage.MakeL5FullSection(
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeL5FullSection
  * Make a level 5 full section for a Segmentation Page *
  Description:
  This method builds a section which is a list of all entities of the list
  of tetrahedrons, alternating background color between tetrahedrons.
  Systematic hyperlinks to entities are provided.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Start:           Integer;
  L5Value:         Integer;
  NbTetra:         Integer;
  MyTID:           ^Integer;
  ListTetra:       tList;
  ViewCode:        String;
  Value:           String;
  Bubble:          String;
  MyIndent:        String;
  Main:            tEntity;
  Tetra:           tTetrahedron;
  AnItem:          tBiColItem;
  Color:           tLanguage;
begin
  // Initial stuff
  Start := 0;
  Main := Self.Actual;
  if ( Main <> nil ) then
  begin

    // Retrieve the sorted list of tetrahedrons
    L5Value := Main.TID;
    ListTetra := tList.Create;
    NbTetra := TAH.GetListTetra( L5Value, ListTetra );

    // Display the tetrahedrons
    Color := lt_English;
    for Indx := 0 to NbTetra - 1 do
    begin

      // Switch the color for the actual tetrahedron
      if ( Color = lt_English ) then
        Color := lt_Latin
      else
        Color := lt_English;
      MyIndent := Chr( Ord( 'a' ) );

      if Indx = NbTetra - 1 then
        Color := Color;


      // Display the full tetrahedron
      MyTID := ListTetra[ Indx ];
      Tetra := TAH.GetTetrahedronByTID( MyTID^ );
      if ( Tetra <> nil ) then
      begin

        // Display the generator entity
        if ( Tetra.Genr <> nil ) then
        begin
          ViewCode := CTAH + IntToStr( Tetra.Genr.TID );
          Value := Tetra.Genr.GetLibelle( lb_Base, TAH.MainLang );
          Bubble := Tetra.Genr.GetLibelle( lb_Base, TAH.SubstLang );
          Value := AOTAG + cHrefEmpty + '../' + cEntity + cSpace +
                   cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                   IntToStr( Tetra.Genr.TID ) + cSpace + cEntity +
                   cSpace + cLgShort[ TAH.SubstLang ] +
                   cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ViewCode;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := Value;
          AnItem.Bubble := Bubble;
          AnItem.Indent := MyIndent;
          AnItem.Color := Color;
          AnItem.PartLink := cEmpty;
          MySection.AddItem( AnItem );
        end;

        // Display the set entity
        if ( Tetra.ASet <> nil ) then
        begin
          ViewCode := CTAH + IntToStr( Tetra.ASet.TID );
          Value := Tetra.ASet.GetLibelle( lb_Base, TAH.MainLang );
          Bubble := Tetra.ASet.GetLibelle( lb_Base, TAH.SubstLang );
          Value := AOTAG + cHrefEmpty + '../' + cEntity + cSpace +
                   cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                   IntToStr( Tetra.Aset.TID ) + cSpace + cEntity +
                   cSpace + cLgShort[ TAH.SubstLang ] +
                   cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ViewCode;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := Value;
          AnItem.Bubble := Bubble;
          AnItem.Indent := MyIndent;
          AnItem.Color := Color;
          AnItem.PartLink := cEmpty;
          MySection.AddItem( AnItem );
        end;

        // Display the main entity
        ViewCode := cTetraEN[ Tetra.TetraType ] + cSpace + '<B>' +
                    CTAH + IntToStr( Tetra.TetraID ) + '</B>';
        Value := Tetra.Main.GetLibelle( lb_Base, TAH.MainLang );
        Bubble := Tetra.Main.GetLibelle( lb_Base, TAH.SubstLang );
        Value := AOTAG + cHrefEmpty + '../' + cEntity + cSpace +
                 cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                 IntToStr( Tetra.Main.TID ) + cSpace + cEntity +
                 cSpace + cLgShort[ TAH.SubstLang ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.AltLabel := cEmpty;
        AnItem.Value := Value;
        AnItem.Bubble := Bubble;
        AnItem.Indent := MyIndent;
        AnItem.Color := Color;
        AnItem.PartLink := cEmpty;
        MySection.AddItem( AnItem );

        // Display the left lateral entity
        if ( Tetra.ASin <> nil ) then
        begin
          ViewCode := CTAH + IntToStr( Tetra.ASin.TID );
          Value := Tetra.ASin.GetLibelle( lb_Base, TAH.MainLang );
          Bubble := Tetra.ASin.GetLibelle( lb_Base, TAH.SubstLang );
          Value := AOTAG + cHrefEmpty + '../' + cEntity + cSpace +
                   cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                   IntToStr( Tetra.ASin.TID ) + cSpace + cEntity +
                   cSpace + cLgShort[ TAH.SubstLang ] +
                   cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ViewCode;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := Value;
          AnItem.Bubble := Bubble;
          AnItem.Indent := MyIndent;
          AnItem.Color := Color;
          AnItem.PartLink := cEmpty;
          MySection.AddItem( AnItem );
        end;

        // Display the right lateral entity
        if ( Tetra.ADex <> nil ) then
        begin
          ViewCode := CTAH + IntToStr( Tetra.ADex.TID );
          Value := Tetra.ADex.GetLibelle( lb_Base, TAH.MainLang );
          Bubble := Tetra.ADex.GetLibelle( lb_Base, TAH.SubstLang );
          Value := AOTAG + cHrefEmpty + '../' + cEntity + cSpace +
                   cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                   IntToStr( Tetra.ADex.TID ) + cSpace + cEntity +
                   cSpace + cLgShort[ TAH.SubstLang ] +
                   cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ViewCode;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := Value;
          AnItem.Bubble := Bubble;
          AnItem.Indent := MyIndent;
          AnItem.Color := Color;
          AnItem.PartLink := cEmpty;
          MySection.AddItem( AnItem );
        end;
      end;
    end; // for
  end;
end; // _______________________________________________________MakeL5FullSection

procedure          tSegmentPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tSegmentPage.WritePage
  * Write the Segmentation Page file *
  Description:
  This method writes an Segmentation Page and save it as an HTML file. It writes
  in turn the header, all sections and the footer of the page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbSection:       Integer;
  PageName:        String;
  Page:            TStringList;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  PageName := Self.PageName;
  AddTag( DOCTYPETAG, 0 );
  AddTag( HTMLTAG, 0 );
    AddTag( HEADTAG, 1 );
      AddTag( TITLETAG + PageName + TITLEETAG, 2 );
      AddTag( CALLCSSVIEWTAG, 2 );
      AddTag( CALLCSSPRINTTAG, 2 );
    AddTag( HEADETAG, 1 );
    AddTag( BODYTAG, 1 );
      AddTag( DIVOTAG + cIdContainer + cAnr, 2 ); // open #Container700

      // Write header (inherited method)
      Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

          // Display the column headers
          AddTag( TABLEOTAG + cClassBodyTable + cAnr, 4 );
            AddTag( TROTAG + cSpace + cClassHeaderColor + cAnr, 5 );
              MakeTD( cClassColNno, fdSection[ en ], cEmpty, 6 );
              MakeTD( cClassColNno, fdItem[ en ], cEmpty, 6 );
              MakeTD( cClassColXXXno, fdValue[ en ], cEmpty, 6 );
            AddTag( TRETAG, 5 );
          AddTag( TABLEETAG, 4 );

        // Write all sections
        NbSection := Self.NbSection;
        for Indx := 0 to NbSection - 1 do
        begin
          Self.WriteSection( Indx, 4 );
        end;

        // Write footer (inherited method)
        Self.WriteFooter( 3 );

        // Close the HTML page
        AddTag( DIVETAG, 3 ); // close #Body700
      AddTag( DIVETAG, 2 ); // close #Container700
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSpace + cLgShort[ lt_English ] +
                   cSlash + Self.FileName );
end; // __________________________________________________TSegmentPage.WritePage

procedure          tSegmentPage.WriteSection(
  PosSection:      Integer;
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteSection
  * Write a section of any type for a Segmentation Page *
  Description:
  This method writes a single section of a Segmentation Page. Each section
  is made of a variable number of items, which are handled in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbItem:          Integer;
  MyClass:         String;
  LinkText:        String;
  Content:         String;
  ASection:        tSection;
  AnItem:          tBiColItem;
begin
  ASection := Self.GetSection( PosSection );
  if ( ASection <> nil ) then
  begin

      // Skip an empty section
      NbItem := TBiColSection( ASection ).NbItem;
      if ( NbItem = 0 ) then
        Exit;

      // Write the section title
      if ( IsLarge ) then
        AddTag( TABLEOTAG + cSectionTitle1400 + cAnr, 6 )
      else
        AddTag( TABLEOTAG + cSectionTitle700 + cAnr, 6 );
        AddTag( TRTAG, Lev + 1 );
          MakeTD( cClassTitleSect, ASection.SectionTitle,
                  cEmpty, Lev + 2 );
        AddTag( TRETAG, Lev + 1 );
      AddTag( TABLEETAG, Lev );
      AddTag( TABLEOTAG + cSectionContent + cAnr, Lev );

      // Loop on all items
      for Indx := 0 to NbItem - 1 do
      begin

        // Write the item content
        AnItem := TBiColSection( ASection ).GetItem( Indx );
        if ( AnItem <> nil ) then
        begin
          MyClass := cEmpty;
          if ( AnItem.Indent <> cEmpty ) then
            MyClass := cClassEmpty + cLgShort[ AnItem.Color ] +
                       AnItem.Indent + cDQuote;
          AddTag( TRTAG, Lev + 1 );
            MakeTD( cClassRub, AnItem.SrcLabel, AnItem.AltLabel, Lev + 2 );
            LinkText := AnItem.Value;
            if ( AnItem.Url <> cEmpty ) then
              LinkText := AOTAG + AnItem.Url + LinkText + AETAG;
            Content := LinkText;
            if ( AnItem.PartLink <> cEmpty ) then
              Content := Content + cSpace + AnItem.PartLink;
            MakeTD( cClassSpec, Content, AnItem.Bubble,
                    Lev + 2, MyClass );
          AddTag( TRETAG, Lev + 1 );
        end;
      end; // for

    AddTag( TABLEETAG, Lev );
  end;
end; // ____________________________________________________________WriteSection

procedure          tSegmentPage.BuildExcel;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildExcel
  * Build an Excel file at level 4 *
  Description:
  This procedure writes a semicolumn delimited text file, ready to import as
  an Excel spreadsheet.</P>
  There are 5 columns:
  - TAH unique identifier,
  - Short Latin display term,
  - Short English display term,
  - Official term,
  - English equivalent.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Start:           Integer;
  TetValue:        Integer;
  NbTetra4:        Integer;
  NbTetra5:        Integer;
  NbItem:          Integer;
  NbEntity:        Integer;
  MyTID:           ^Integer;
  ListTetra4:      tList;
  ListTetra5:      tList;
  ViewCode:        String;
  LAShort:         String;
  Official:        String;
  ENShort:         String;
  ENEquiv:         String;
  Main:            tEntity;
  Tetra4:          tTetrahedron;
  Tetra5:          tTetrahedron;
  Page:            TStringList;
begin
  // Initial stuff
  Start := 0;
  NbItem := 0;
  NbEntity := 0;
  Main := Self.Actual;
  Page := TStringList.Create;
  if ( Main <> nil ) then
  begin

    // Retrieve the sorted list of tetrahedrons at level 4
    TetValue := Main.TID;
    ListTetra4 := TList.Create;
    NbTetra4 := TAH.GetListLevel4( TetValue, ListTetra4 );

    // Store headers of column
    ViewCode := 'Entity ID';
    LAShort := 'Short official term';
    ENShort := 'Short English equivalent';
    Official := 'Base term';
    ENEquiv := 'English base term';
    Page.Add( ViewCode + cSemi + LAShort + cSemi + ENShort +
              cSemi + Official + cSemi + ENEquiv );

    // Loop at level 4
    for Indy := 0 to NbTetra4 - 1 do
    begin
      MyTID := ListTetra4[ Indy ];
      Tetra4 := TAH.GetTetrahedronByTID( MyTID^ );
      if ( Tetra4 <> nil ) then
      begin

        // Retrieve the sorted list of tetrahedrons at level 5
        TetValue := Tetra4.TetraID;
        ListTetra5 := tList.Create;
        NbTetra5 := TAH.GetListTetra( TetValue, ListTetra5 );

        // Display the tetrahedrons
        for Indx := 0 to NbTetra5 - 1 do
        begin
          MyTID := ListTetra5[ Indx ];
          Tetra5 := TAH.GetTetrahedronByTID( MyTID^ );
          if ( Tetra5 <> nil ) then
          begin

            // Do not display references and deleted entities
            if ( ( Tetra5.TetraType = tt_ref ) or
                 ( Tetra5.TetraType = tt_del ) ) then
            begin
              Continue;
            end;

            // Store semicolumn delimited information
            ViewCode := CTAH + IntToStr( Tetra5.TetraID );
            LAShort := Tetra5.Main.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
            ENShort := Tetra5.Main.GetLibelle( lb_Official, TAH.SubstLang, st_undef, True );
            Official := Tetra5.Main.GetLibelle( lb_Base, TAH.MainLang );
            ENEquiv := Tetra5.Main.GetLibelle( lb_Base, TAH.SubstLang );
            Page.Add( ViewCode + cSemi + LAShort + cSemi + ENShort +
                      cSemi + Official + cSemi + ENEquiv );
          end;
        end; // for Indx
      end;
    end; // for Indy
  end;
  Self.Page := Page;
end; // ______________________________________________________________BuildExcel

procedure          tSegmentPage.Build6Columns;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Build6Columns
  * Build a 6-column format Excel file at level 4 *
  Description:
  This procedure writes a semicolumn delimited text file similar to the FIPAT
  6-column format, ready to import as an Excel spreadsheet.</P>
  There are 6 columns:
  (1) TAH unique identifier,
  (2) Short Latin official term,
  (3) Official Latin synonym terms (semicolumn delimited),
  (4) Short UK English equivalent term,
  (5) Short US English equivalent term (only if different),
  (6) Official UK English synonym terms (semicolumn delimited).</P>
  The terms which are presented here are the main entities of tetrahedrons,
  because it is the entities which constitute the global partonomy. It
  means the pairs, the sets or the psets for the multi-facet tetrahedrons. The
  main entities usually does not have any raw term, but they get autogenerated
  terms. The terms are the short terms without expansion, in order to fit to
  the original 6-column format.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Indz:            Integer;
  Start:           Integer;
  TetValue:        Integer;
  NbTetra4:        Integer;
  NbTetra5:        Integer;
  NbItem:          Integer;
  NbEntity:        Integer;
  NbSyn:           Integer;
  Count:           Integer;
  Posit:           Integer;
  NextAID:         Integer;
  MyTID:           ^Integer;
  ListTetra4:      tList;
  ListTetra5:      tList;
  ViewCode:        String;
  LAShort:         String;
  ENUKShort:       String;
  ENUSShort:       String;
  LAOff:           String;
  ENOff:           String;
  Selector:        String;
  UKText:          String;
  USText:          String;
  MyENUK:          String;
  Status:          String;
  InqLib:          String;
  MyAction:        String;
  Main:            tEntity;
  MyEntity:        tEntity;
  MyGeneric:       tEntity;
  Tetra4:          tTetrahedron;
  Tetra5:          tTetrahedron;
  Page:            TStringList;
  ALATerm:         tSingle;
  AENTerm:         tSingle;
  Inquiry:         tInquiries;
  Action:          ActionRec;
begin
  // Initial stuff
  Start := 0;
  NbItem := 0;
  NbEntity := 0;
  Main := Self.Actual;
  Page := TStringList.Create;
  if ( Main <> nil ) then
  begin

    // Retrieve the sorted list of tetrahedrons at level 4
    TetValue := Main.TID;
    ListTetra4 := tList.Create;
    NbTetra4 := TAH.GetListLevel4( TetValue, ListTetra4 );

    // Store headers of column
    ViewCode := 'Entity ID';
    LAShort := 'Short official term';
    LAOff := 'Latin synonyms';
    ENUKShort := 'Short UK English display term';
    ENUSShort := 'Short US English display term';
    ENOff := 'English synonyms';
    Status := 'Validation status';
    InqLib := 'Libelle of the inquiry';
    Page.Add( ViewCode + CurSep + LAShort + CurSep + LAOff + CurSep +
              ENUKShort + CurSep + ENUSShort + CurSep + ENOff + CurSep +
              Status + CurSep + InqLib );

    // Loop at level 4
    for Indy := 0 to NbTetra4 - 1 do
    begin
      MyTID := ListTetra4[ Indy ];
      Tetra4 := TAH.GetTetrahedronByTID( MyTID^ );
      if ( Tetra4 <> nil ) then
      begin

        // Retrieve the sorted list of tetrahedrons at level 5
        TetValue := Tetra4.TetraID;
        ListTetra5 := tList.Create;
        NbTetra5 := TAH.GetListTetra( TetValue, ListTetra5 );

        // Display the tetrahedrons
        for Indx := 0 to NbTetra5 - 1 do
        begin
          MyTID := ListTetra5[ Indx ];
          Tetra5 := TAH.GetTetrahedronByTID( MyTID^ );
          if ( Tetra5 <> nil ) then
          begin

            // Do not display deleted entities
            if ( Tetra5.TetraType = tt_del ) then
              Continue;

            // Do not display lexical references
            if ( Tetra5.TetraType = tt_lex ) then
              Continue;

            // Handling of references
            if ( Tetra5.TetraType = tt_ref ) then
            begin
              MyEntity := TAH.GetEntityByTID( Tetra5.Main.Reference );
              MyGeneric := TAH.GetEntityByTID( MyEntity.Generator );
              if ( MyEntity = nil ) then
                Continue;
            end else

            // Retrieve generator entity
            begin
              MyEntity := Tetra5.Main;
              MyGeneric := Tetra5.Genr;
              if ( MyGeneric = nil ) then
                MyGeneric := MyEntity;
            end;

            // Retrieve identifier and short official term
            ViewCode := CTAH + IntToStr( MyEntity.TID );
            LAShort := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );

            // Handling of inconstant entities
            if ( Tetra5.Main.Inconstant ) then
              LAShort := cRol + LAShort + cRoR;

            // Retrieve all Latin synonyms
            NbSyn := 0;
            if ( MyGeneric <> nil ) then
              NbSyn := MyGeneric.NbLATerm;
            LAOff := cEmpty;
            if ( NbSyn > 0 ) then
            begin
              Count := 0;
              for Indz := 0 to NbSyn - 1 do
              begin
                MyGeneric.LgCurrent := lt_Latin;
                MyGeneric.Query := tSearch.Create( st_Off );
                MyGeneric.Query.SynPos := Count;
                MyGeneric.SearchTerm;
                ALATerm := MyGeneric.CurrSingle;
                if ( ALATerm <> nil ) then
                begin
                  if ( Indz > 0 ) then
                    LAOff := LAOff + cSemi + cSpace;
                  LAOff := LAOff + ALATerm.Mandat + ALATerm.Bracket;
                  Inc( Count );
                end;
              end;
            end;

            // Retrieve UK English equivalent
            ENUKShort := MyEntity.GetLibelle( lb_Official, TAH.SubstLang,
                                              st_undef, True );
            if ( Tetra5.Main.Inconstant ) then
              ENUKShort := cRol + ENUKShort + cRoR;

            // Compute US English equivalent
            Selector := cEmpty;
            AENTerm := nil;
            if ( MyGeneric <> nil ) then
            begin
              MyGeneric.LgCurrent := lt_English;
              MyGeneric.Query := tSearch.Create( st_USA );
              MyGeneric.SearchTerm;
              AENTerm := MyGeneric.CurrSingle;
            end;
            if ( AENTerm <> nil ) then
            begin
              Selector := AENTerm.Libelle;
            end;
            ENUSShort := cEmpty;
            if ( Selector <> cEmpty ) then
            begin
              Posit := Pos( cSlash, Selector );
              if ( Posit > 0 ) then
              begin
                UKText := Copy( Selector, 1, Posit - 1 );
                USText := Copy( Selector, Posit + 1, Length( Selector ) );
                MyENUK := ENUKShort;
                repeat
                  Posit := Pos( UKText, MyENUK );
                  if ( Posit > 0 ) then
                  begin
                    MyENUK := Copy( MyENUK, 1, Posit - 1 ) + USText +
                      Copy( MyENUK, Posit + Length( UKText ),
                      Length( MyENUK ) );
                  end;
                until ( Posit = 0 );
              end;
              ENUSShort := MyENUK;
            end;

            // Retrieve all English synonyms
            NbSyn := 0;
            if ( MyGeneric <> nil ) then
              NbSyn := MyGeneric.NbENTerm;
            ENOff := cEmpty;
            if ( NbSyn > 0 ) then
            begin
              Count := 0;
              for Indz := 0 to NbSyn - 1 do
              begin
                MyEntity.LgCurrent := lt_English;
                MyEntity.Query := tSearch.Create( st_Ofd );
                MyEntity.Query.SynPos := Count;
                MyEntity.SearchTerm;
                AENTerm := MyEntity.CurrSingle;
                if ( AENTerm <> nil ) then
                begin
                  if ( Indz > 0 ) then
                    ENOff := ENOff + cSemi + cSpace;
                  ENOff := ENOff + AENTerm.Mandat + AENTerm.Bracket;
                  Inc( Count );
                end;
              end;
            end;

            // Retrieve validation status and inquery libelle
            InqLib := cEmpty;
            Status := cEmpty;
            if ( TAH.Inquiries.InquiryExist( Tetra5.TetraID, Inquiry ) ) then
            begin
              MyAction := TAH.Actions.ListActions( Inquiry[ 0 ].IID );
              InqLib := Inquiry[ 0 ].Lib;

              // Go through the list of all actions
              while ( MyAction <> cEmpty ) do
              begin
                Posit := Pos( cSemi, MyAction );
                if ( Posit > 0 ) then
                begin
                  NextAID := strToInt( Copy( MyAction, 1, Posit - 1 ) );
                  MyAction := Copy( MyAction, Posit + 1, Length( MyAction ) );
                end else
                begin
                  NextAID := StrToInt( MyAction );
                  MyAction := cEmpty;
                end;
                if ( MyAction <> cEmpty ) then
                  Continue;
                if ( TAH.Actions.ActionExist( NextAID , Action ) ) then
                begin
                  if ( Action.Status = 'red' ) then
                    Status := 'red'
                  else
                  if ( Action.Status = 'ora' ) then
                    Status := 'orange'
                  else
                  if ( Action.Status = 'gre' ) then
                    Status := 'green';
                end;
              end; // while
            end;

            // Handling of references
            if ( Tetra5.TetraType = tt_ref ) then
            begin
              LAShort := '->' + cSpace + LAShort;
              ENUKShort := '->' + cSpace + ENUKShort;
            end;

            // Write the next line of spreadsheet
            Page.Add( ViewCode + CurSep + LAShort + CurSep + LAOff +
                      CurSep + ENUKShort + CurSep + ENUSShort + CurSep + ENOff +
                      CurSep + Status + CurSep + InqLib );
          end;
        end; // for Indx
      end;
    end; // for Indy
  end;
  Self.Page := Page;
end; // ____________________________________________________________Build6Column

procedure          tSegmentPage.WriteExcel;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteExcel
  * Write an Excel file at level 4 *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Save page on external file
  Self.Page.SaveToFile( Self.Directory + cSpace + cLgShort[ lt_English ] +
                        cSlash + Self.FileName );
end; // ______________________________________________________________WriteExcel

procedure          tDefinPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TDefinPage.Build
  * Build a single Definition Page *
  Description:
  This method builds all the sections of a Definition Page in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Actual:          tEntity;
begin
  Actual := Self.Actual;
  if ( Actual <> nil ) then
  begin
    Self.MakeHeader;
    // Self.MakeSection( sc_Identification );
    // Self.MakeSection( sc_Definition );
    // Self.MakeSection( sc_Partonomy );
    Self.MakeSection( sc_TaxDefinListe );
    Self.MakeSection( sc_PartDefinListe );
    // Self.MakeSection( sc_Taxonomy );
    Self.MakeFooter;
  end;
end; // ________________________________________________________TDefinPage.Build

procedure          tDefinPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeader
  * Make a header of a Definition Page *
  Description:
  This method prepares the header of a Definition Page. It is based on a common
  header defined for all HTML pages and an adjustment of the introductive
  text specific to the Definition Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited;
  Self.Header.Intro := tiDefinPage[ en ] + cSpace + Self.Header.Intro;
end; // ______________________________________________________________MakeHeader

procedure          tDefinPage.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSection
  * Make a section of any type for a Definition Page *
  Description:
  This method is call for any section for a Definition Page and distributes
  the work to the specific methods corresponding to each section type.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  FMAChangeStore:  Boolean;
  MySection:       tBiColSection;
  APage:           tEntityPage;
begin
  // Create a new section
  MySection := tBiColSection.Create;
  MySection.SectionType := SType;
  MySection.Entity := Self.Actual;
  MySection.PageType := ca_Definition;

  // Store the items of the section by section type
  if ( SType = sc_Identification ) then
  begin
    MySection.SectionTitle := TAH.GetLabel( reSectIdent );
    MySection.SectionBubble := TAH.GetBubble( reSectIdent );
    TIdSection( MySection ).Build;
  end else
  if ( SType = sc_Definition ) then
  begin
    MySection.SectionTitle := TAH.GetLabel( reSectTaxDef );
    MySection.SectionBubble := TAH.GetBubble( reSectTaxDef );
    Self.MakeDefSection( MySection );
  end else
  {if ( SType = sc_FullPartonomy ) then
  begin
    MySection.SectionTitle := paInferred[ TAH.DisLang ];
    MySection.SectionBubble := bbInferred[ TAH.DisLang ];
    APage := TEntityPage.Create;
    APage.Actual := Self.Actual;
    APage.MakeLightPartonomySection( MySection, False );
  end else}
  if ( SType = sc_PartDefinListe ) then
  begin
    MySection.SectionTitle := paPartDefList[ en ];
    MySection.SectionBubble := bbPartDefList[ en ];
    Self.MakeDefListSection( False, MySection );
  end else
  if ( SType = sc_Taxonomy ) then
  begin
    MySection.SectionTitle := paTaxonomy[ en ];
    MySection.SectionBubble := bbTaxonomy[ en ];
    APage := tEntityPage.Create;
    APage.Actual := Self.Actual;
    FMAChangeStore := FMAChange;
    FMAChange := False;
    tTaxoSection( MySection ).Build;
    FMAChange := FMAChangeStore;
  end else
  if ( SType = sc_TaxDefinListe ) then
  begin
    MySection.SectionTitle := paTaxDefList[ en ];
    MySection.SectionBubble := bbTaxDefList[ en ];
    Self.MakeDefListSection( True, MySection );
  end;

  // Add the section to the Entity Page
  Self.AddSection( MySection );
end; // _____________________________________________________________MakeSection

procedure          tDefinPage.MakeDefSection(
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeDefSection
  * Make the definition section *
  Description:
  This method collects all definitions available for the actual entity and
  prepares their display text.</P>
  The encyclopedic definitions are complemented with a mention of their
  source, when it is available.</P>
  The taxonomic definitions are prepared from the position of entity in the
  taxonomy.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  DefEN            = 1;
  DefFR            = 2;
var
  Indx:            Integer;
  Indy:            Integer;
  NbDef:           Integer;
  PosDef:          Integer;
  MyPos:           Integer;
  IsTaxDef:        Boolean;
  MyTerm:          String;
  MySource:        String;
  MyValue:         String;
  Bubble:          String;
  DefinitionEN:    Array of DefRec;
  DefinitionFR:    Array of DefRec;
  Actual:          tEntity;
  AnItem:          tBiColItem;
  MyDef:           DefRec;
  Def:             tDefinition;
begin

  // Initial stuff
  Actual := Self.Actual;
  if ( Actual <> nil ) then
  begin
    Def := TAH.Definitions;

    // English encyclopedic definitions in any number
    NbDef := Def.FilterByUID( Actual.TID, DefEN );
    for Indy := 0 to NbDef - 1 do
    begin
      // MyDef := DefinitionEN[ Indy ];
      MyDef := Def.GetDefinition( Indy );
      if ( MyDef.typ = dt_Encyclopedic ) then
      begin

        // Affichage du type de définition à gauche
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := paEncyclopedic[ en ];
        AnItem.AltLabel := bbEncyclopedic[ en ];

        // Recherche de la source
        MySource := MyDef.Src;
        if MySource = 'DOR29' then
          MySource := 'Dorland''s Illustrated Medical Dictionary, 29th Edition'
        else
        if MySource = 'FEN' then
          MySource := 'Pocket Atlas of Human Anatomy, H. Feneis & W. Dauber, ' +
                      ' 4th English Edition, Thieme 2000'
        else
        if MySource = 'STED' then
          MySource := 'Stedman''s Medical Dictionary, 28th ed. '
        else
        if MySource = 'DAU08' then
          MySource := 'translated from SENEIS'' Bild Lexicon der Anatomie, ' +
                      'Dauber Wolfgang, 10th Edition, Thieme 2008'
        else
        if ( MySource = 'web' ) or ( MySource = 'WEB' ) then
          MySource := 'web source'
        else
        if ( MySource = 'RB' ) or ( MySource = 'PS' ) or
           ( MySource = 'PN' ) then
          MySource := 'internal source'
        else
          MySource := 'undocumented source';

        // Prepare the definition together with its source
        MyTerm := MyDef.Def;
        MyTerm := UpperCase( Copy( MyTerm, 1, 1 ) ) +
                  Copy( Myterm, 2, Length( MyTerm ) - 1 );
        MyTerm := MyTerm + cSpace + cRol + MySource + cRor;
        AnItem.Value := MyTerm;
        AnItem.Bubble := cEmpty;
        MySection.AddItem( AnItem );
      end;
    end; // for

    // Loop on non encyclopedic definitions in English
    for Indx := 0 to NbDef - 1 do
    begin
      // MyDef := DefinitionEN[ Indx ];
      MyDef := Def.GetDefinition( Indy );
      if ( MyDef.typ = dt_Encyclopedic ) then
        Continue;

      // Taxonomic definition
      if ( MyDef.typ = dt_Taxonomic ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := paTaxonomicEN[ en ];
        AnItem.AltLabel := bbTaxonomic[ en ];
        AnItem.Value := Def.MakeTaxDefinition( Indx, True );
        Bubble := bbTaxDef[ en ];
        AnItem.Bubble := Bubble;
        MySection.AddItem( AnItem );

        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := paTaxonomicEN[ en ] + cSpace + '(with ref)';
        AnItem.AltLabel := bbTaxonomic[ en ];
        AnItem.Value := Def.MakeTaxDefinition( Indx, True );
        Bubble := bbTaxDef[ en ];
        AnItem.Bubble := Bubble;
        MySection.AddItem( AnItem );
      end else

      // Other definitions
      begin
        AnItem := tBiColItem.Create;

        // Spatial or positional definition
        if ( MyDef.typ = dt_Spatial ) then
        begin
          AnItem.SrcLabel := paSpatial[ en ];
          AnItem.AltLabel := bbSpatial[ en ];
        end else

        // Functional definition
        if ( MyDef.typ = dt_Functional ) then
        begin
          AnItem.SrcLabel := paFunctional[ en ];
          AnItem.AltLabel := bbFunctional[ en ];
        end else

        // Physical definition
        if ( MyDef.typ = dt_Physical ) then
        begin
          AnItem.SrcLabel := paPhysical[ en ];
          AnItem.AltLabel := bbPhysical[ en ];
        end;
        AnItem.Value := MyDef.Def;
        AnItem.Bubble := cEmpty;
        MySection.AddItem( AnItem );
      end;
    end; // for

    // Loop on French taxonomic definitions
    NbDef := Def.FilterByUID( Actual.TID, DefFR );
    for Indx := 0 to NbDef - 1 do
    begin
      // MyDef := DefinitionFR[ Indx ];
      MyDef := Def.GetDefinition( Indy );
      if ( MyDef.typ = dt_Taxonomic ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := paTaxonomicFR[ en ];
        AnItem.AltLabel := bbTaxonomic[ en ];
        AnItem.Value := Def.MakeTaxDefinition( Indx );
        Bubble := bbTaxDef[ en ];
        AnItem.Bubble := Bubble;
        MySection.AddItem( AnItem );
      end
    end; // for

    // Autogenerated definition for the lateral members of a pair
    {if ( ( Actual.Link = pw_MemberL ) or ( Actual.Link = pw_MemberR ) ) then
    begin

      // Retrieve all English definitions of the generator
      NbDef := Def.FilterByUID( Actual.TaxAnc, 1 );

      // Search for an English taxonomic definition
      IsTaxDef := False;
      PosDef := 0;
      for Indx := 0 to NbDef - 1 do
      begin
        if ( DefinitionEN[ Indx ].typ = dt_taxonomic ) then
        begin
          IsTaxDef := True;
          PosDef := Indx;
          Break;
        end;
      end; // for

      // Add the English autogenerated definition
      if ( IsTaxDef ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := paAutoLateral[ DisLang ];
        AnItem.AltLabel := bbAutoPair[ DisLang ];
        AnItem.Value := Def.MakeAutoLateralDef( PosDef, Actual.Link );
        AnItem.Bubble := cEmpty;
        MySection.AddItem( AnItem );
      end;

      // Retrieve all French definitions of the generator
      NbDef := Def.FilterByUID( Actual.TaxAnc, DefFR );

      // Search for a French taxonomic definition
      IsTaxDef := False;
      PosDef := 0;
      for Indx := 0 to NbDef - 1 do
      begin
        if ( DefinitionFR[ Indx ].typ = dt_taxonomic ) then
        begin
          IsTaxDef := True;
          PosDef := Indx;
          Break;
        end;
      end;

      // Add the autogenerated French definition
      if ( IsTaxDef ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := paAutoLateral[ DisLang ];
        AnItem.AltLabel := bbAutoPair[ DisLang ];
        AnItem.Value := Def.MakeAutoLateralDef( PosDef, Actual.Link );
        AnItem.Bubble := cEmpty;
        MySection.AddItem( AnItem );
      end;
    end else

    // Autogenerated definition for symmetrical pairs
    if ( ( Actual.TypeEntity = to_ParMat ) or
         ( Actual.TypeEntity = to_ParImm ) ) then
    begin

      // Retrieve all English definitions of the generator
      NbDef := Def.FilterByUID( Actual.Generator, DefEN );

      // Search for a taxonomic definition of the generator
      IsTaxDef := False;
      PosDef := 0;
      for Indx := 0 to NbDef - 1 do
      begin
        if ( DefinitionEN[ Indx ].typ = dt_taxonomic ) then
        begin
          IsTaxDef := True;
          PosDef := Indx;
          Break;
        end;
      end;

      // Add the definition
      if ( IsTaxDef ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := paAutoPair[ DisLang ];
        AnItem.AltLabel := bbAutoPair[ DisLang ];
        AnItem.Value := Def.MakeAutoPairDef( PosDef );
        AnItem.Bubble := cEmpty;
        MySection.AddItem( AnItem );
      end;

      // Retrieve all French definitions of the generator
      NbDef := Def.FilterByUID( Actual.Generator, DefFR );

      // Search for a taxonomic definition of the generator
      IsTaxDef := False;
      PosDef := 0;
      for Indx := 0 to NbDef - 1 do
      begin
        if ( DefinitionFR[ Indx ].typ = dt_taxonomic ) then
        begin
          IsTaxDef := True;
          PosDef := Indx;
          Break;
        end;
      end;

      // Add the definition
      if ( IsTaxDef ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := paAutoPair[ DisLang ];
        AnItem.AltLabel := bbAutoPair[ DisLang ];
        AnItem.Value := Def.MakeAutoPairDef( PosDef );
        AnItem.Bubble := cEmpty;
        MySection.AddItem( AnItem );
      end;
    end else

    // Autogenerated definition for sets
    if ( ( Actual.TypeEntity = to_SetMat ) or
         ( Actual.TypeEntity = to_SetImm ) ) then
    begin
      NbDef := Def.FilterByUID( Actual.Generator, 1 );
      if ( NbDef >= 2 ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := paAutoSet[ DisLang ];
        AnItem.AltLabel := bbAutoPair[ DisLang ];
        AnItem.Value := Def.MakeAutoSetDef( 1 );
        AnItem.Bubble := cEmpty;
        MySection.AddItem( AnItem );
      end;
    end;

    // Autogenerated definition for pairs of sets (to be added)
    if ( ( Actual.TypeEntity = to_PstMat ) or
         ( Actual.TypeEntity = to_PstImm ) ) then
    begin

    end;

    // Link to the Entity Page
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'More information';
    AnItem.AltLabel := cEmpty;
    MyValue := 'Entity Page';
    MyValue := AOTAG + cHrefEmpty +
               '../Entity EN/' +
               cTAH + IntToStr( Actual.TID ) + cSpace +
               'Entity EN' + cPeriod + HtmlExt + cDQuote + cAnr +
               MyValue + AETAG;
    AnItem.Value := 'See' + cSpace + MyValue;
    AnItem.Bubble := cEmpty;
    MySection.AddItem( AnItem );}
  end;
end; // __________________________________________________________MakeDefSection

procedure          tDefinPage.MakeDefListSection(
  IsTax:           Boolean;
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeDefListSection
  * Make a definition list section for a Definition Page *
  Description:
  This procedure follows the descendant partonomy of the selected entity and
  provides for each child its taxonomic definition when available.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbDef:           Integer;
  OrdSet:          Integer;
  ViewCode:        String;
  Value:           String;
  MyIndent:        String;
  Main:            tEntity;
  Definition:      Array of DefRec;
  MyDef:           DefRec;
  AnItem:          tBiColItem;
begin
  // Initial stuff
  Main := Self.Actual;
  if ( Main <> nil ) then
  begin

    // Prepare the left column with ID number
    ViewCode := cTAHEntity + IntToStr( Main.TID );

    // Prepare the right column with definition
    for Indx := 1 to TAH.Definitions.NbSet do
    begin
      if ( TAH.MainLang = TAH.Definitions.Language[ Indx ] ) then
      begin
        OrdSet := Indx;
        Break;
      end;
    end; // on all lots of definitions
    SetLength( Definition, 10 );
    NbDef := TAH.Definitions.FilterByUID( Main.TID, OrdSet );
    SetLength( Definition, NbDef );
    Value := cEmpty;
    for Indx := 0 to NbDef - 1 do
    begin
      MyDef := TAH.Definitions.GetDefinition( Indx );
      if ( ( MyDef.typ = dt_Taxonomic ) and
           ( ( MyDef.Src = 'RB' ) or
             ( MyDef.Src = 'GO' ) ) ) then
      begin
        Value := TAH.Definitions.MakeTaxDefinition( Indx, True );
        Break;
      end;
    end; // for
    if ( Value = cEmpty ) then
    begin
      Value := Main.GetLibelle( lb_Base, TAH.MainLang );
    end;
    MyIndent := Chr( Ord( 'a' ) );

    // Taxonomy list
    if ( IsTax ) then
    begin

      // List of taxonomic ancestors and current entity
      MakeCascadeTaxDef( Main.TID, MySection, TAH.MainLang );

      // List of taxonomic children
      MakeDescendantDef( Main.TID, 2, IsTax, MySection );
    end else

    // Partonomy list (only children)
    begin

      // First item: top entity
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := ViewCode;
      AnItem.AltLabel := cEmpty;
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := MyIndent;
      AnItem.Color := lt_None;
      MySection.AddItem( AnItem );

      // List of partonomic children
      MakeDescendantDef( Main.TID, 2, False, MySection );
    end;
  end;
end; // ______________________________________________________MakeDefListSection

procedure          tDefinPage.MakeDescendantDef(
  TID:             Integer;
  Level:           Integer;
  IsTax:           Boolean;
  MySection:       TBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeDescendantDef
  * Recursive exploration of partonomic subtree of definitions *
  Description:
  This procedure starts from the specified entity down in the partonomic
  hierarchy, and provides the definitions of all its children. Then, for each
  child, a recursive call will explore the subtree at the next level. The
  process continues down to the leaves of the tree.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbChildren:      Integer;
  NbTrueChildren:  Integer;
  NbOrder:         Integer;
  Posit:           Integer;
  MyTID:           Integer;
  MyPos:           Integer;
  Small:           Integer;
  Children:        String;
  SortList:        String;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          tEntity;
  Next:            tEntity;
begin
  // Initial stuff
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get children and their number
  if ( IsTax ) then
  begin
    Children := Actual.TaxCh;
    SortList := Actual.TaxPos;
    NbTrueChildren := Actual.NbTaxC;
  end else
  begin
    Children := Actual.PartCh;
    SortList := Actual.PartPos;
    NbTrueChildren := Actual.NbPartC;
  end;
  if ( Children = cEmpty ) then
    Exit;

  // Extract the list of order position
  NbOrder := 0;
  while ( SortList <> cEmpty ) do
  begin
    Inc( NbOrder );
    Posit := Pos( cSemi, SortList );
    if ( Posit > 0 ) then
    begin
      Order[ NbOrder ] := StrToInt( Copy( SortList, 1, Posit - 1 ) );
      SortList := Copy( SortList, Posit + 1, Length( SortList ) );
    end else
    begin
      Order[ NbOrder ] := StrToInt( SortList );
      SortList := cEmpty;
    end;
  end; // while

  // Extract the list of children
  NbChildren := 0;
  while ( Children <> cEmpty ) do
  begin
    Inc( NbChildren );
    Posit := Pos( cSemi, Children );
    if ( Posit > 0 ) then
    begin
      Child[ NbChildren ] := StrToInt( Copy( Children, 1, Posit - 1 ) );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      Child[ NbChildren ] := StrToInt( Children );
      Children := cEmpty;
    end;
  end; // while

  // Loop on all children
  for Indx := 1 to NbChildren do
  begin

    // Find next entity according to vector of positions
    Small := Order[ 1 ];
    MyPos := 1;
    for Indy := 2 to NbChildren do
    begin
      if ( Small > Order[ Indy ] ) then
      begin
        Small := Order[ Indy ];
        MyPos := Indy;
      end;
    end; // for
    Order[ MyPos ] := 10000;

    // Skip lateral members of pairs
    MyTID := Child[ MyPos ];
    Next := TAH.GetEntityByTID( MyTID );
    if ( ( Next.Link = pw_MemberL ) or ( Next.Link = pw_MemberR ) or
         ( Next.Link = pw_SMemberL ) or ( Next.Link = pw_SMemberR ) or
         ( Next.Link = pw_IMemberL ) or ( Next.Link = pw_IMemberR ) or
         ( Next.Link = pw_TMemberL ) or ( Next.Link = pw_TMemberR ) ) then
      Continue;

    // Find and process entity
    MakeNextDef( MyTID, Level, IsTax, MySection );
  end; // for
end; // _______________________________________________________MakeDescendantDef

procedure          tDefinPage.MakeNextDef(
  TID:             Integer;
  Level:           Integer;
  IsTax:           Boolean;
  MySection:       tBiColSection );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeNextDef
  * Make a definition list section for a Definition Page *
  Description:
  This procedure makes a recursive circle together with MakeDescendantDef. It
  displays the definitions of a single entity and starts the display of all the
  possible children.</P>
  This procedure is made of two parts. The initial part retrieves any
  taxonomic definition directly attached to the specified entity and
  displays it. The second part is activated in case of failure of the
  initial part, in case of absence of any taxonomic definition and it
  attempts to autogenerate a definition starting from an alternate entity
  of the same anatomical unit.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbDef:           Integer;
  PosDef:          Integer;
  NewTID:          Integer;
  PosLang:         Integer;
  IsTaxDef:        Boolean;
  Present:         Boolean;
  ViewCode:        String;
  Value:           String;
  NextValue:       String;
  Bubble:          String;
  MyIndent:        String;
  NoDef:           String;
  AnItem:          tBiColItem;
  Main:            tEntity;
  Refer:           tEntity;
  Definition:      Array of DefRec;
  MyDef:           DefRec;
  Def:             tDefinition;
begin
  // Initial stuff
  Main := TAH.GetEntityByTID( TID );
  if ( Main <> nil ) then
  begin
    Def := TAH.Definitions;

    // Prepare the left column with ID number
    ViewCode := cTAHEntity + IntToStr( Main.TID );

    // Search for the position of main language
    for Indx := 1 to Def.NbSet do
    begin
      if ( Def.Language[ Indx ] = TAH.MainLang ) then
      begin
        PosLang := Indx;
        NbDef := Def.FilterByUID( Main.TID, PosLang );
        break;
      end;
    end; // for on all definition lots

    // Prepare the right column with taxonomic definition
    Value := cEmpty;
    Bubble := cEmpty;
    if ( NbDef > 0 ) then
    begin
      Present := False;
      for Indx := 0 to NbDef - 1 do
      begin
        MyDef := Def.GetDefinition( Indx );
        if ( ( MyDef.typ = dt_Taxonomic ) and
             ( ( MyDef.Src = 'RB' ) or
               ( MyDef.Src = 'GO' ) or
               ( MyDef.Src = 'HtD' ) or
               ( MyDef.Src = 'FMA' ) ) ) then
        begin
          Value := Def.MakeTaxDefinition( Indx, True );
          Present := True;
          Break;
        end;
      end; // for

      // Prepare an empty definition with fake differentia
      if ( not Present ) then
      begin
        MyDef.Def := 'DIFFERENTIA';
        Value := Def.MakeTaxDefinition( Indx, True );
      end;
    end else

    begin

      // Retrieve all definitions of the generator
      NbDef := Def.FilterByUID( Main.Generator, PosLang );

      // Autogenerated definition for symmetrical pairs
      if ( ( Main.TypeEntity = to_ParMat ) or
           ( Main.TypeEntity = to_ParImm ) ) then
      begin

        // Search for a taxonomic definition of the generator
        IsTaxDef := False;
        PosDef := 0;
        for Indx := 0 to NbDef - 1 do
        begin
          MyDef := Definition[ Indx ];
          if ( MyDef.typ = dt_taxonomic ) then
          begin
            IsTaxDef := True;
            PosDef := Indx;
            Break;
          end;
        end; // for
        if ( IsTaxDef ) then
        begin
          Value := Def.MakeAutoPairDef( PosDef );
          Bubble := bbAutoPair[ en ];
        end;
      end else

      // Autogenerated definition for sets
      if ( ( Main.TypeEntity = to_SetMat ) or
           ( Main.TypeEntity = to_SetImm ) ) then
      begin

        // Search for a taxonomic definition of the generator
        IsTaxDef := False;
        PosDef := 0;
        for Indx := 0 to NbDef - 1 do
        begin
          MyDef := Definition[ Indx ];
          if ( MyDef.typ = dt_taxonomic ) then
          begin
            IsTaxDef := True;
            PosDef := Indx;
            Break;
          end;
        end; // for
        if ( IsTaxDef ) then
        begin
          Value := Def.MakeAutoSetDef( PosDef );
          Bubble := bbAutoPair[ en ];
        end;
      end else

      // Autogenerated definition for pairs of sets
      if ( ( Main.TypeEntity = to_PstMat ) or
           ( Main.TypeEntity = to_PstImm ) ) then
      begin

        // Search for a taxonomic definition of the generator
        IsTaxDef := False;
        PosDef := 0;
        for Indx := 0 to NbDef - 1 do
        begin
          MyDef := Definition[ Indx ];
          if ( MyDef.typ = dt_taxonomic ) then
          begin
            IsTaxDef := True;
            PosDef := Indx;
            Break;
          end;
        end; // for
        if ( IsTaxDef ) then
        begin
          Value := Def.MakeAutoPstDef( PosDef );
          Bubble := bbAutoPair[ en ];
        end;
      end;
    end;

    // Normal treatment for an entity without definition
    if ( Value = cEmpty ) then
    begin
      if ( Main.TetraTip <> tp_ref ) then
      begin
        NoDef := TAH.GetLabel( reNoDefinition, False );
        Value := Main.GetLibelle( lb_Base, TAH.MainLang ) + cSpace + Nodef;
      end else

      // Treatment for a reference elsewhere defined
      begin
        NewTID := Main.Reference;
        Refer := TAH.GetEntityByTID( NewTID );
        Value := Refer.GetLibelle( lb_Base, TAH.MainLang ) + cSpace +
                                   'is a reference.';
      end;
    end;

    // First item: top entity
    NextValue := Main.GetLibelle( lb_Base, lt_English );
    if ( ( NextValue <> Value ) and
         ( Main.Link <> pw_MemberL ) and
         ( Main.Link <> pw_MemberR ) ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := ViewCode;
      AnItem.AltLabel := cEmpty;
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      MyIndent := Chr( Ord( 'a' ) + Level - 1 );
      AnItem.Indent := MyIndent;
      AnItem.Color := lt_None;
      MySection.AddItem( AnItem );
    end;
  end;

  // Build the next level in taxonomic hierarchy
  MakeDescendantDef( Main.TID, Level + 1, IsTax, MySection );
end; // _____________________________________________________________MakeNextDef

procedure          tDefinPage.MakeCascadeTaxDef(
  ATID:            Integer;
  MySection:       tBiColSection;
  Lang:            tLanguage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeCascadeTaxDef
  * Develop a cascade taxonomic definition *
  Description:
  This section presents the taxonomic hierarchy of the main entity of the page
  with for each level the differentia that distincts it from its father entity.
  The result is a cascade of differentia which alltogether define the main
  entity.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Level:           Integer;
  Bubble:          String;
  MyValue:         String;
  AnItem:          tBiColItem;
  Actual:          tEntity;
  Ancestor:        tEntity;
begin
  // Retrieve the entity
  Actual := TAH.GetEntityByTID( ATID );
  if ( Actual <> nil ) then
  begin

    // Retrieve the immediate taxonomic ancestor
    Ancestor := TAH.GetEntityByTID( Actual.TaxAnc );
    if ( Ancestor <> nil ) then
    begin

      // Write the first title line of taxonomic definition
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reTaxGlobal );
      AnItem.AltLabel := TAH.GetLabel( buTaxGlobal );
      AnItem.Value := cEmpty;
      AnItem.Bubble := cEmpty;
      MySection.AddItem( AnItem );

      // Search the immediate taxonomic ancestor and build it
      Level := 1;
      MakeLevelTaxDef( Actual.TID, Actual.TaxAnc, Level, MySection, Lang );

      // Build the ground level
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := cTAHUnit + IntToStr( Actual.Tetra );
      AnItem.AltLabel := cEmpty;
      MyValue := Actual.GetLibelle( lb_Base, TAH.MainLang );
      AnItem.Value := BTAG + MyValue + BETAG;
      Bubble := cEmpty;
      AnItem.Bubble := Bubble;
      MySection.AddItem( AnItem );
    end;
  end;
end; // _______________________________________________________MakeCascadeTaxDef

procedure          tDefinPage.MakeLevelTaxDef(
  ActTID:          Integer;
  NextTID:         Integer;
  Level:           Integer;
  MySection:       tBiColSection;
  Lang:            tLanguage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLevelTaxDef
  * Recursively build next level of a cascade taxonomic definition *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbDef:           Integer;
  Diff:            String;
  InDiff:          String;
  Genus:           String;
  Side:            String;
  AnItem:          tBiColItem;
  Actual:          tEntity;
  MyLatEntity:     tEntity;
  Definition:      Array of DefRec;
  MyDef:           DefRec;
  Def:             tDefinition;
begin
  // Retrieve the entity
  Def := TAH.Definitions;
  Actual := TAH.GetEntityByTID( NextTID );
  if ( Actual <> nil ) then
  begin

    // Recursively build the successive levels up to the top of taxonomy
    if ( NextTID <> 10123 ) then
      MakeLevelTaxDef( Actual.TID, Actual.TaxAnc, Level + 1, MySection, Lang );

    // Build the genus level
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := cTAHUnit + IntToStr( Actual.TID );
    AnItem.AltLabel := cEmpty;
    Genus := Actual.GetLibelle( lb_Base, Lang );
    Genus := BTAG + Genus + BETAG;
    Genus := cCul + Genus + cComma + cSpace + IntToStr( Actual.TaxAnc ) + cCur;
    Genus := MakeHyperlinks( Genus, Lang, False );
    AnItem.Value := Genus;
    AnItem.Bubble := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + Level );
    AnItem.Color := lt_None;
    MySection.AddItem( AnItem );

    // Search for the differentia
    for Indx := 1 to 5 do
    begin
      if ( Lang = Def.Language[ Indx ] ) then
      begin
        NbDef := Def.FilterByUID( ActTID, Indx );
        Break;
      end;
    end; // on all lots of definitions

    // Autogenerate lateral members of pairs
    Diff := cEmpty;
    if ( ( NbDef = 0 ) and ( Actual.IsBilateral ) ) then
    begin
      for Indx := 0 to NbDef - 1 do
      begin
        MyDef := Definition[ Indx ];
        if ( MyDef.typ <> dt_Taxonomic ) then
          Continue;
        Break;
      end; // for
      MyLatEntity := TAH.GetEntityByTID( ActTID );
      Side := cEmpty;
      if ( MyLatEntity.Link in [ pw_MemberL, pw_IMemberL ] ) then
        Side := TAH.GetLabel( reLeftSide )
      else
      if ( MyLatEntity.Link in [ pw_MemberR, pw_IMemberR ] ) then
        Side := TAH.GetLabel( reRightSide );
      Diff := Copy( MyDef.Def, 1, Length( MyDef.Def ) - 1 ) + cSpace + Side;
    end else

    begin
      // Absence of definition
      if ( NbDef = 0 ) then
      begin
        Diff := TAH.GetLabel( reNoDefinition, False );
      end else

      // Extract definition
      begin
        for Indx := 0 to NbDef - 1 do
        begin
          MyDef := Def.GetDefinition( Indx );
          if ( MyDef.typ <> dt_Taxonomic ) then
            Continue;
          Diff := MyDef.Def;
          Break;
        end; // for
      end;
    end;

    // Prepare the hyperlinks
    Diff := MakeHyperlinks( Diff, Lang, True );

    // Add the FMA source if present
    if ( MyDef.Src = 'FMA' ) then
    begin
      Diff := Diff + cSpace + cRol + 'Fundational Model of Anatomy' + cRor;
    end;

    // Build the differentia level
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := cEmpty;
    AnItem.AltLabel := cEmpty;
    InDiff := TAH.GetLabel( reInDifferentia, False );
    AnItem.Value := InDiff + cSpace + Diff + cSpace + 'isa';
    AnItem.Bubble := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + Level );
    AnItem.Color := lt_None;
    MySection.AddItem( AnItem );
  end;
end; // _________________________________________________________MakeLevelTaxDef

procedure          tDefinPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TDefinPage.WritePage
  * Write the Definition Page file *
  Description:
  This method writes an Definition Page and save it as an HTML file. It writes
  in turn the header, all sections and the footer of the page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbSection:       Integer;
  PageName:        String;
  Page:            TStringList;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  PageName := Self.PageName;
  AddTag( DOCTYPETAG, 0 );
  AddTag( HTMLTAG, 0 );
    AddTag( HEADTAG, 1 );
      AddTag( TITLETAG + PageName + TITLEETAG, 2 );
      AddTag( CALLCSSVIEWTAG, 2 );
      AddTag( CALLCSSPRINTTAG, 2 );
    AddTag( HEADETAG, 1 );
    AddTag( BODYTAG, 1 );
      AddTag( DIVOTAG + cIdContainer + cAnr, 2 ); // open #Container700

      // Write header (inherited method)
      Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

          // Display the column headers
          AddTag( TABLEOTAG + cClassBodyTable + cAnr, 4 );
            AddTag( TROTAG + cSpace + cClassHeaderColor + cAnr, 5 );
              MakeTD( cClassColNno, fdSection[ en ], cEmpty, 6 );
              MakeTD( cClassColNno, fdItem[ en ], cEmpty, 6 );
              MakeTD( cClassColXXXno, fdValue[ en ], cEmpty, 6 );
            AddTag( TRETAG, 5 );
          AddTag( TABLEETAG, 4 );

        // Write all sections
        NbSection := Self.NbSection;
        for Indx := 0 to NbSection - 1 do
        begin
          Self.WriteSection( Indx, 4 );
        end;

        // Write footer (inherited method)
        Self.WriteFooter( 3 );

        // Close the HTML page
        AddTag( DIVETAG, 3 ); // close #Body700
      AddTag( DIVETAG, 2 ); // close #Container700
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSlash + Self.FileName, TEncoding.UTF8 );
end; // ____________________________________________________TDefinPage.WritePage

procedure          tDefinPage.WriteSection(
  PosSection:      Integer;
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteSection
  * Write a section of any type for a Definition Page *
  Description:
  This method writes a single section of a Definition Page. Each section is made
  of a variable number of items, which are handled in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbItem:          Integer;
  MyClass:         String;
  LinkText:        String;
  Content:         String;
  ASection:        tSection;
  AnItem:          tBiColItem;
begin
  ASection := Self.GetSection( PosSection );
  if ( ASection <> nil ) then
  begin

      // Skip an empty section
      NbItem := tBiColSection( ASection ).NbItem;
      if ( NbItem = 0 ) then
        Exit;

      // Write the section title
      if ( IsLarge ) then
        AddTag( TABLEOTAG + cSectionTitle1400 + cAnr, 6 )
      else
        AddTag( TABLEOTAG + cSectionTitle700 + cAnr, 6 );
        AddTag( TRTAG, Lev + 1 );
          MakeTD( cClassTitleSect, ASection.SectionTitle,
                  cEmpty, Lev + 2 );

          // Additional local help for section on taxonomy
          if ( ( ASection.SectionType = sc_Taxonomy ) and FMAChange ) then
            MakeTD( cClassTitleSect, 'Help on colors',
                    ASection.SectionBubble, Lev + 2 );

        AddTag( TRETAG, Lev + 1 );
      AddTag( TABLEETAG, Lev );
      AddTag( TABLEOTAG + cSectionContent + cAnr, Lev );

      // Loop on all items
      for Indx := 0 to NbItem - 1 do
      begin

        // Write the item content
        AnItem := TBiColSection( ASection ).GetItem( Indx );
        if ( AnItem <> nil ) then
        begin
          MyClass := cEmpty;
          if ( AnItem.Indent <> cEmpty ) then
            MyClass := cClassEmpty + cLgShort[ AnItem.Color ] +
                       AnItem.Indent + cDQuote;
          AddTag( TRTAG, Lev + 1 );
            MakeTD( cClassRub, AnItem.SrcLabel, AnItem.AltLabel, Lev + 2 );
            LinkText := AnItem.Value;
            if ( AnItem.Url <> cEmpty ) then
              LinkText := AOTAG + AnItem.Url + LinkText + AETAG;
            Content := LinkText;
            if ( AnItem.PartLink <> cEmpty ) then
              Content := Content + cSpace + AnItem.PartLink;
            MakeTD( cClassSpec, Content, AnItem.Bubble,
                    Lev + 2, MyClass );
          AddTag( TRETAG, Lev + 1 );
        end;
      end; // for

    AddTag( TABLEETAG, Lev );
  end;
end; // ____________________________________________________________WriteSection

procedure          tUniversalPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tUniversalPage.Build
  * Build a Universal Page *
  Description:
  This public method builds an entire Universal Page for the specified entity.
  The Universal Page is built from header to footer, making all its sections
  in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Actual := Self.Actual;
  if ( Actual <> nil ) then
  begin
    Self.MakeHeader;
    Self.MakeSection( sc_Identification );
    Self.MakeSection( sc_Latin );
    Self.MakeSection( sc_English );
    Self.MakeSection( sc_French );
    Self.MakeSection( sc_Spanish );
    Self.MakeSection( sc_Russian );
    Self.MakeSection( sc_Definition );
    Self.MakeSection( sc_TermDesign );
    Self.MakeSection( sc_Analysis );
    Self.MakeSection( sc_Syntax );
    Self.MakeSection( sc_Declension );
    Self.MakeFooter;
  end;
end; // ____________________________________________________tUniversalPage.Build

procedure          tUniversalPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tUniversalPage.WritePage
  * Write the Universal Page *
  Description:
  This public method write the HTML file representing the Universal Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbSection:       Integer;
  Page:            TStringList;
  ASection:        tSection;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  MakeTopHTMLPage( 0 );

      // Write header
      Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

          // Display the column headers
          AddTag( TABLEOTAG + cClassBodyTable + cAnr, 4 );
            AddTag( TROTAG + cSpace + cClassHeaderColor + cAnr, 5 );
              MakeTD( cClassColNno, fdSection[ en ], cEmpty, 6 );
              MakeTD( cClassColNno, fdItem[ en ], cEmpty, 6 );
              MakeTD( cClassColXXXno, fdValue[ en ], cEmpty, 6 );
            AddTag( TRETAG, 5 );
          AddTag( TABLEETAG, 4 );

        // Write all sections
        NbSection := Self.NbSection;
        for Indx := 0 to NbSection - 1 do
        begin
          ASection := GetSection( Indx );
          TBiColSection( ASection ).WriteSection( 4 );
        end;

        // Write footer
        Self.WriteFooter( 3 );

        // Close the HTML page
        AddTag( DIVETAG, 3 ); // close #Body700
      AddTag( DIVETAG, 2 ); // close #Container700
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSlash + Self.FileName, TEncoding.UTF8 );
end; // ________________________________________________tUniversalPage.WritePage

procedure          tUniversalPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tUniversalPage.MakeHeader
  * Make a header for Universal Page *
  Description:
  This private method adjust the header for the Universal Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TitlePage:       String;
begin
  inherited;
  TitlePage := TAH.GetLabel( reUniversalPage );
  Self.Header.Intro := TitlePage + cSpace + Self.Header.Intro;
end; // _______________________________________________tUniversalPage.MakeHeader

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tUniversalPage.MakeSection
  * Make a section of any type *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure          tUniversalPage.MakeSection(
  SType:           tSectionType );
var
  MySection:       tBiColSection;
begin

  // Store the items of the section by section type
  if ( SType = sc_Identification ) then
  begin
    MySection := tIdSection.Create;
    MySection.SectionTitle := TAH.GetLabel( reSectIdent );
    MySection.SectionBubble := TAH.GetBubble( reSectIdent );
  end else
  if ( SType = sc_Latin ) then
  begin
    MySection := tLangSection.Create;
    Self.Actual.LgCurrent := lt_Latin;
    MySection.SectionTitle := TAH.GetLabel( reSectLatin );
    MySection.SectionBubble := TAH.GetBubble( reSectLatin );
  end else
  if ( SType = sc_English ) then
  begin
    MySection := tLangSection.Create;
    Self.Actual.LgCurrent := lt_English;
    MySection.SectionTitle := TAH.GetLabel( reSectEnglish );
    MySection.SectionBubble := TAH.GetBubble( reSectEnglish );
  end else
  if ( SType = sc_French ) then
  begin
    MySection := tLangSection.Create;
    Self.Actual.LgCurrent := lt_French;
    MySection.SectionTitle := TAH.GetLabel( reSectFrench );
    MySection.SectionBubble := TAH.GetBubble( reSectFrench );
  end else
  if ( SType = sc_Spanish ) then
  begin
    MySection := tLangSection.Create;
    Self.Actual.LgCurrent := lt_Spanish;
    MySection.SectionTitle := TAH.GetLabel( reSectSpanish );
    MySection.SectionBubble := TAH.GetBubble( reSectSpanish );
  end else
  if ( SType = sc_Russian ) then
  begin
    MySection := tLangSection.Create;
    Self.Actual.LgCurrent := lt_Russian;
    MySection.SectionTitle := TAH.GetLabel( reSectRussian );
    MySection.SectionBubble := TAH.GetBubble( reSectRussian );
  end else
  if ( SType = sc_Definition ) then
  begin
    MySection := tDefSection.Create;
    MySection.SectionTitle := scDefinition[ en ];
    MySection.SectionBubble := bsDefinition[ en ];
  end else
  if ( SType = sc_TermDesign ) then
  begin
    MySection := tTermDesignSection.Create;
    MySection.SectionTitle := scDesignTerm[ en ];
    MySection.SectionBubble := bsDesignTerm[ en ];
  end else
  if ( SType = sc_Analysis ) then
  begin
    MySection := tWordAnalysisSection.Create;
    MySection.SectionTitle := scLatinTerm[ en ];
    MySection.SectionBubble := bsLatinTerm[ en ];
  end else
  if ( SType = sc_Syntax ) then
  begin
    MySection := tSyntaxSection.Create;
    MySection.SectionTitle := scLatinSyntax[ en ];
    MySection.SectionBubble := bsLatinSyntax[ en ];
  end else
  if ( SType = sc_Declension ) then
  begin
    MySection := tDeclensionSection.Create;
    MySection.SectionTitle := scLatinDecl[ en ];
    MySection.SectionBubble := bsLatinDecl[ en ];
  end;
  MySection.SectionType := SType;
  MySection.Entity := Self.Actual;
  MySection.PageType := ca_Latin;
  MySection.Build;

  // Add the section to the Entity Page
  Self.AddSection( MySection );
end; // ______________________________________________tUniversalPage.MakeSection

function           tListPage.GetNbFMAList()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbFMAList
  * Property read method for number of FMA lines *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FMALine ) + 1;
end; // ____________________________________________________________GetNbFMAList

procedure          tListPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tListPage.Build
  * Build a List Page *
  Description:
  This method builds a List page, either a taxonomy or a partonomy list,
  including a TA98 partonomic list. By extension, this method also build a
  FMA List Page.</P>
  The body of a list page is made of two parts:
  - A hierarchical indented list starting from the designed entity,
  - A list of corresponding notes.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Build header
  CurrPage := Self;
  if ( Self.Actual <> nil ) then
  begin
    if ( not TA98Short ) then
      Self.MakeHeader;

    // Build the List navigation section
    if ( ( Self.TypeList <> li_gen ) and
         ( not IsTA98 ) and
         ( not IsPub ) and
         ( not MultiLg ) and
         ( Self.TypeList <> li_int4 ) and
         ( Self.CategPage <> ca_ListTA98 ) ) then
      Self.MakeSection( sc_NavList );

    // Build the universal statistic section
    // Self.MakeSection( sc_StatUniv );

    // Build the Reference Page (call on entity 10568 Taxonomy Page T4)
    if ( Self.Actual.TID = 13367 )  then
    begin
      Self.PageName := 'TAH Reference Page';
      Self.MakeReferenceSections;
    end else

    // Build partonomy list
    if ( ( Self.TypeList = li_part0 ) or
         ( Self.TypeList = li_part1 ) or
         ( Self.TypeList = li_part2 ) or
         ( Self.TypeList = li_part2f ) or
         ( Self.TypeList = li_part3 ) or
         ( Self.TypeList = li_part3f ) or
         ( Self.TypeList = li_part4 ) ) then
    begin
      Self.MakeSection( sc_PartList );
      if ( not IsPub ) then
        Self.MakeSection( sc_Signature );
    end else

    // Build TA98 partonomy list
    if ( ( Self.TypeList = li_TA98part1 ) or
         ( Self.TypeList = li_TA98part2 ) or
         ( Self.TypeList = li_TA98part2f ) or
         ( Self.TypeList = li_TA98part3 ) or
         ( Self.TypeList = li_TA98part4 ) ) then
    begin
      Self.MakeSection( sc_Part98 );
      // Self.MakeSection( sc_Signature );
    end else

    // Build taxonomy list
    if ( ( Self.TypeList = li_tax1 ) or
         ( Self.TypeList = li_tax1f ) or
         ( Self.TypeList = li_tax2 ) or
         ( Self.TypeList = li_tax2f ) or
         ( Self.TypeList = li_tax3 ) or
         ( Self.TypeList = li_tax3f ) or
         ( Self.TypeList = li_tax4 ) ) then
    begin
      Self.MakeSection( sc_Taxonomy );
      Self.MakeSection( sc_TaxList );
      Self.MakeSection( sc_Signature );
    end else

    // Build interface list
    if ( Self.TypeList = li_int4 ) then
    begin
      Self.MakeSection( sc_IntList );
    end else

    // Build generic list
    if ( ( Self.TypeList = li_gen ) ) then
    begin
      Self.MakeSection( sc_PartList );
      Self.MakeSection( sc_Signature );
    end else

    // Build a FMA page
    if ( ( Self.TypeList = li_FMA ) ) then
    begin
      Self.MakeFMAList;
    end else

    // Build an Excel input file
    if ( ( Self.TypeList = li_Excel ) ) then
    begin
      Self.MakeExcelList;
    end;

    // Build footer
    if ( not TA98Short ) then
      Self.MakeFooter;
  end;
end; // _________________________________________________________tListPage.Build

procedure          tListPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tListPage.MakeHeader
  * Make a header of a List Page *
  Description:
  This method prepares the header of an List Page. It is based on a common
  header defined for all HTML pages and an adjustment of the introductive
  text specific to the List Page.</P>
  The List page is built with three languages: the primary language is the
  language of the anatomical content; the subsidiary language is also about the
  anatomical content in a complementary view under the form of bubbles; the
  interface language is the language of presentation of the page. Potentially,
  any language may be required in any position, but these choices may be
  limited by the actual implementation.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  PageType:        String;
  LanguageType:    String;
  MyLanguages:     String;
  MyList:          String;
  MySection:       tSection;
  MyType:          tTypeListPage;
begin
  inherited;

  // Check for Published lists
  if ( IsPub ) then
    Exit;

  // Page type
  MySection := tSection.Create;
  MyType := Self.TypeList;
  if ( ( MyType <= li_part4 ) and ( MyType >= li_part1 ) ) then
    MyList := TAH.GetLabel( rePartonomyPage )
  else
  if ( ( MyType <= li_tax4 ) and ( MyType >= li_tax1 ) ) then
    MyList := TAH.GetLabel( reTaxonomyPage )
  else
  if ( ( MyType <= li_int4 ) and ( MyType >= li_int4 ) ) then
    MyList := TAH.GetLabel( reInterfacePage );
  PageType := MyList + cSpace + cTypeListPage[ MyType];

  // Information on applied languages
  LanguageType := TAH.GetLabel( rePrimaryLang, False );
  MyLanguages := LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.MainLang ] + cComma;
  LanguageType := TAH.GetLabel( reSecondaryLang, False );
  MyLanguages := MyLanguages + cSpace +
                 LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.SubstLang ] + cComma;
  LanguageType := TAH.GetLabel( reDisplayLang, False );
  MyLanguages := MyLanguages + cSpace +
                 LanguageType + cColumn + cSpace +
                 cLgShort[ TAH.DisLanguage ];

  // Finalize the introduction header
  Self.Header.Intro := PageType + cComma + cSpace +
                       MyLanguages +
                       Self.Header.Intro;

  // Prepare the legend about introduction
  Self.Header.Legend := TAH.GetLabel( rePageIntro );
end; // ______________________________________________________________MakeHeader

procedure          tListPage.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tListPage.MakeSection
  * Make a section of any type for a List Page *
    ==========================================
  Description:
  This method builds any section of a List Page. To do that, it distributes
  the work to the specific methods corresponding to each section type.</P>
  A section is a collection of section items in any number, which are created
  by the specific methods. A section item corresponds to a single line in the
  final HTML page. A section item defines the content to be later formatted
  in HTML format.</P>
  Some sections are dual sections, due to the fact that they generate two
  sections at a time, typically a list of entities and a list of notes. In
  this situation the second section acts as a complement of the first one.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MySection:       tListSection;
  MyBiColSection:  tBiColSection;
  MyDual:          tListSection;
begin
  // Create a new section in the List page
  if ( ( SType = sc_PartList ) or
       ( SType = sc_Part98 ) or
       ( SType = sc_TaxList ) or
       ( SType = sc_IntList ) or
       ( SType = sc_ValidUniv ) ) then
  begin
    if ( SType = sc_TaxList ) then
      MySection := tTaxListSection.Create
    else
    if ( SType = sc_IntList ) then
      MySection := tIntListSection.Create
    else
    if ( SType = sc_PartList ) then
      MySection := tPartListSection.Create
    else
    if ( SType = sc_Part98 ) then
      MySection := tPart98Section.Create;
    MySection.SectionType := SType;
    MySection.Entity := Self.Actual;
    MySection.PageType := Self.CategPage;
    MySection.TypeList := Self.TypeList;

    // Make the partonomy list section with a dual section of notes
    if ( SType = sc_PartList ) then
    begin
      MySection.SectionTitle := TAH.GetLabel( reSectPartList );
      MySection.SectionBubble := TAH.GetBubble( reSectPartList );
      MyDual := tListSection.Create;
      MyDual.SectionType := sc_NoteList;
      MyDual.SectionTitle := TAH.GetLabel( reSectNote );
      MyDual.SectionBubble := TAH.GetBubble( reSectNote );
      MySection.ComplSection := MyDual;
      MySection.Build;
    end else

    // Make the TA98 partonomy list section with a dual section of notes
    if ( SType = sc_Part98 ) then
    begin
      MySection.SectionTitle := scPart98[ en ];
      MySection.SectionBubble := bsPart98[ en ];
      MyDual := tListSection.Create;
      MyDual.SectionType := sc_NoteList;
      MyDual.SectionTitle := TAH.GetLabel( reSectNote );
      MyDual.SectionBubble := TAH.GetLabel( reSectNote );
      MySection.ComplSection := MyDual;
      MySection.Build;
    end else

    // Make the taxonomy list section with a dual section of notes
    if ( SType = sc_TaxList ) then
    begin
      MySection.SectionTitle := TAH.GetLabel( reSectTaxList );
      MySection.SectionBubble := TAH.GetBubble( reSectTaxList );
      MyDual := tListSection.Create;
      MyDual.SectionType := sc_NoteList;
      MyDual.SectionTitle := TAH.GetLabel( reSectNote );
      MyDual.SectionBubble := TAH.GetBubble( reSectNote );
      MySection.ComplSection := MyDual;
      MySection.Build;
    end else

    // Make the interface list section
    if ( SType = sc_IntList ) then
    begin
      MySection.SectionTitle := TAH.GetLabel( reSectIntList );
      MySection.SectionBubble := TAH.GetBubble( reSectIntList );
      MyDual := tListSection.Create;
      MyDual.SectionType := sc_NoteList;
      MyDual.SectionTitle := TAH.GetLabel( reSectNote );
      MyDual.SectionBubble := TAH.GetBubble( reSectNote );
      MySection.ComplSection := MyDual;
      MySection.Build;
    end;
  end else

  // Make the navigation section of a List page
  if ( SType = sc_NavList ) then
  begin
    MyBiColSection := tNavListSection.Create;
    MyBiColSection.SectionTitle := TAH.GetLabel( reSectNavigList );
    MyBiColSection.SectionBubble := TAH.GetBubble( reSectNavigList );
    MyBiColSection.SectionType := SType;
    MyBiColSection.Entity := Self.Actual;
    MyBiColSection.PageType := Self.CategPage;
    MyBiColSection.TypeList := Self.TypeList;
    MyBiColSection.Build;
  end else

  // Make the ancestor taxonomy section of a List page
  if ( SType = sc_Taxonomy ) then
  begin
    MyBiColSection := tTaxoSection.Create;
    MyBiColSection.SectionType := SType;
    MyBiColSection.Entity := Self.Actual;
    MyBiColSection.PageType := Self.CategPage;
    MyBiColSection.TypeList := Self.TypeList;
    MyBiColSection.SectionTitle := TAH.GetLabel( reSectTaxAnc );
    MyBiColSection.SectionBubble := TAH.GetBubble( reSectTaxAnc );
    MyBiColSection.Build;
  end else

  // Make a signature section
  if ( SType = sc_Signature ) then
  begin
    MyBiColSection := tSignatureSection.Create;
    MyBiColSection.SectionType := SType;
    MyBiColSection.Entity := Self.Actual;
    MyBiColSection.UID := Self.Actual.Tetra;
    MyBiColSection.PageType := Self.CategPage;
    MyBiColSection.TypeList := Self.TypeList;
    MyBiColSection.SectionTitle := TAH.GetLabel( reSectSign );
    MyBiColSection.SectionBubble := TAH.GetBubble( reSectSign );
    MyBiColSection.Build;
  end else

  // Make the universal statistic section of a List page
  if ( SType = sc_StatUniv ) then
  begin
    MyBiColSection := tUnivSection.Create;
    MyBiColSection.SectionType := SType;
    MyBiColSection.Entity := Self.Actual;
    MyBiColSection.PageType := Self.CategPage;
    MyBiColSection.TypeList := Self.TypeList;
    MyBiColSection.SectionTitle := scStatList[ en ];
    MyBiColSection.SectionBubble := bsStatList[ en ];
    MyBiColSection.Build;
  end;

  // Add the section(s) to the List page
  if ( ( SType = sc_PartList ) or
       ( SType = sc_Part98 ) or
       ( SType = sc_TaxList ) ) then
  begin
    Self.AddSection( MySection );
    if ( ( SType <> sc_Part98 ) and ( not MultiLg ) ) then
      Self.AddSection( MyDual );
  end else
  if ( SType = sc_ValidUniv ) then
  begin
    Self.AddSection( MySection );
  end else
  if ( SType = sc_NavList ) then
    Self.AddSection( MyBiColSection )
  else
  if ( SType = sc_IntList ) then
    Self.AddSection( MySection )
  else
  if ( SType = sc_Taxonomy ) then
    Self.AddSection( MyBiColSection )
  else
  if ( SType = sc_StatUniv ) then
    Self.AddSection( MyBiColSection )
  else
  if ( SType = sc_Signature ) then
    Self.AddSection( MyBiColSection );
end; // ___________________________________________________tListPage.MakeSection

procedure          tListPage.MakeReferenceSections;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeReferenceSections
  * Make the sections of the Reference List Page *
  Description:
  This method build a Reference Page made of 4 List sections on dedicated
  entities.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
                   // TID of taxonomic reference top entities
  RefTID:          array [ 1 .. 4 ] of Integer =
                   ( 13368, 9565, 13513, 11375 );
var
  Indx:            Integer;
  MySection:       tTaxListSection;
begin
  for Indx := 1 to 4 do
  begin
    MySection := tTaxListSection.Create;
    MySection.SectionType := sc_Reference;
    MySection.Entity := TAH.GetEntityByTID( RefTID[ Indx ] );
    MySection.PageType := Self.CategPage;
    MySection.TypeList := Self.TypeList;
    case ( Indx ) of
    1: // Direction terms
      begin
        MySection.SectionTitle := paDirT[ en ];
        MySection.SectionBubble := bbDirT[ en ];
      end;
    2: // Reference planes
      begin
        MySection.SectionTitle := paRefP[ en ];
        MySection.SectionBubble := bbRefP[ en ];
      end;
    3: // Reference lines
      begin
        MySection.SectionTitle := paRefL[ en ];
        MySection.SectionBubble := bbRefL[ en ];
      end;
    4: // Movements of joints
      begin
        MySection.SectionTitle := paMovJ[ en ];
        MySection.SectionBubble := bbMovJ[ en ];
      end;
    end;
    tTaxListSection( MySection ).Build;
    Self.AddSection( MySection );
  end;
end; // ___________________________________________________MakeReferenceSections

procedure          tListPage.MakeFMAList;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFMAList
  * Make a FMA List Page at any level *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indn:            Integer;
  Indx:            Integer;
  TotNote:         Integer;
  TotChildren:     Integer;
  TotItems:        Integer;
  NbTerm:          Integer;
  TooMuch:         Boolean;
  IsStop:          Boolean;
  TACode:          String;
  FMACode:         String;
  Value:           String;
  Actual:          tEntity;
  MyList:          tFMAListSection;
  AnItem:          tFMAListItem;
  MySingle:        tSingle;
begin
  Actual := Self.Actual;
  if ( ( Actual <> nil ) and ( Actual.PartCh <> cEmpty ) ) then
  begin

    // Build the line of headers of columns
    MyList := tFMAListSection.Create;
    AnItem := tFMAListItem.Create;
    AnItem.TAID := '<B>TAID</B>';
    AnItem.TATerm := '<B>TA term</B>';
    AnItem.FMAID := '<B>FMAID</B>';
    AnItem.FMATerm := '<B>FMA term</B>';
    AnItem.Indent := 'a';
    MyList.AddFMALine( AnItem );

    // Build the top entity, with synonyms and inconstant flag
    AnItem := tFMAListItem.Create;
    TACode := cEmpty;
    if ( Actual.TID > 0 ) then
      TACode := IntToStr( Actual.TID );
    AnItem.TAID := TACode;
    Value := Actual.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
    AnItem.TATerm := Value;
    FMACode := cEmpty;
    if ( Actual.FID > 0 ) then
      FMACode := IntToStr( Actual.FID )
    else
    if ( Actual.FID = -1 ) then
      FMACode := cNotAvailable;
    AnItem.FMAID := FMACode;
    Actual.LgCurrent := lt_English;
    Actual.Query := tSearch.Create( st_FMA );
    Actual.SearchTerm;
    MySingle := Actual.CurrSingle;
    Value := cEmpty;
    if ( MySingle <> nil ) then
      Value := MySingle.Mandat;
    AnItem.FMATerm := Value;
    AnItem.Indent := 'a';
    MyList.AddFMALine( AnItem );

    // Build all children of the partonomy
    TooMuch := False;
    TotNote := 0;
    IsStop := Self.TypeList <> li_part0;
    TotChildren := 1;
    //Self.MakeFMAListDescendants( MyList, Actual.TID, 2, li_FMA, IsStop,
    //                             TotChildren );

    // Display the number of items in the list
    TotItems := MyList.NbFMALine - 1;
    AnItem := tFMAListItem.Create;
    AnItem.TAID := cEmpty;
    AnItem.TATerm := IntToStr( TotItems ) + cSpace + 'items';
    AnItem.FMATerm := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + 1 );
    MyList.AddFMALine( AnItem );

    // Display the total number of entities in the list
    if ( TotChildren > 0 ) and ( TotChildren <> TotItems ) then
    begin
      AnItem := tFMAListItem.Create;
      AnItem.TAID := cEmpty;
      AnItem.TATerm := IntToStr( TotChildren ) + cSpace + 'entities';
      AnItem.FMATerm := cEmpty;
      AnItem.Indent := Chr( Ord( 'a' ) + 1 );
      MyList.AddFMALine( AnItem );
    end;

    // Store the list of FMA lines
    Self.AddFMAList( MyList );
  end;
end; // _____________________________________________________________MakeFMAList

procedure          tListPage.MakeExcelList;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeExcelList
  * Make an Excel input file *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indn:            Integer;
  Indx:            Integer;
  TotNote:         Integer;
  TotChildren:     Integer;
  TotPartial:      Integer;
  TotItems:        Integer;
  NbTerm:          Integer;
  DupTID:          Integer;
  ActTID:          Integer;
  TooMuch:         Boolean;
  IsStop:          Boolean;
  IsNote:          Boolean;
  IsDup:           Boolean;
  Left:            String;
  Right:           String;
  ViewUnit:        String;
  ViewCode:        String;
  ViewFMA:         String;
  FMALib:          String;
  LineText:        String;
  Actual:          TEntity;
  AnItem:          TListItem;
  MyNote:          NoteRec;
  SynTerm:         TSingle;
  ATerm:           TSingle;
  AType:           TTypeListPage;
  MySection:       TListSection;
  CountByLg:       tCountLg;
begin
  Actual := Self.Actual;
  AType := Self.TypeList;

  // Create a single section
  MySection := TListSection.Create;
  MySection.SectionType := sc_PartList;
  MySection.Entity := Self.Actual;
  MySection.PageType := Self.CategPage;
  MySection.TypeList := Self.TypeList;

  // Work on the content of the file
  if ( ( Actual <> nil ) and ( Actual.PartCh <> cEmpty ) ) then
  begin

    // Build the line for the top entity
    MySection.MakeSingleLine( Actual, 1, CountByLg, False, True, True );

    // Build all children of the partonomy
    TooMuch := False;
    IsStop := Self.TypeList <> li_part0;
    TotChildren := 1;
    TotPartial := 0;
    MySection.MakePartListDescendants( Actual.TID, 2, AType, IsStop, True,
                                       TotChildren, TotPartial, CountByLg );

    // Display the number of items in the list
    TotItems := MySection.NbLine - 1;
    AnItem := TListItem.Create;
    AnItem.ViewCode := cEmpty;
    LineText := TAH.GetLabel( reLines, False );
    AnItem.Left := IntToStr( TotItems ) + cSpace + LineText;
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
    MySection.AddLine( AnItem );
  end;

  // Store the single section
  Self.AddSection( MySection );
end; // ___________________________________________________________MakeExcelList

procedure          tListPage.MakeReferencePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeReferencePage
  * Make a Reference Page *
  Description:
  This procedure feed the content of the Reference Page, which is made of four
  separate contributions from the taxonomy. They are:
  - the direction terms of the human body and the limbs, TAH:10568
  - the reference planes, TAH:13506
  - the reference lines, TAH: 13513
  - the movements of joints, TAH:11375</P>
  Each part is built in turn, with a title, a hierarchical indented list, and
  the count of number of entities.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTID:           Integer;
  TotNote:         Integer;
  TotChildren:     Integer;
  TotItems:        Integer;
  NbDiv:           Integer;
  TooMuch:         Boolean;
  IsExt:           Boolean;
  AnItem:          TListItem;
  StoreNote:       Array of NoteRec;
  NewHead:         TEntity;
begin

  // Make list of anatomical directions
  {Actual := Self.Actual;
  if ( Actual <> nil ) then
  begin

    // Build the line of headers of columns
    NbDiv := 2;
    AnItem := TListItem.Create;
    AnItem.ViewCode := '<B>TID</B>';
    AnItem.Left := '<B>Short official term</B>';
    AnItem.Right := '<B>Short English equivalent</B>';
    AnItem.Indent := 'a';
    AddLine( AnItem );

    // Make a title for the direction terms
    AnItem := TListItem.Create;
    AddLine( AnItem );
    AnItem := TListItem.Create;
    AnItem.Left := '<B>Direction terms</B>';
    AddLine( AnItem );

    // Build the top entity
    AnItem := TListItem.Create;
    AnItem.ViewCode := IntToStr( Actual.TID );
    AnItem.Left := Actual.GetOfficial( TAH.MainLang, True );
    AnItem.Right := Actual.GetOfficial( TAH.SubstLang, True );
    AnItem.Indent := 'a';
    AddLine( AnItem );

    // Build all descendant lines of the partonomy
    TooMuch := False;
    SetLength( StoreNote, 20 );
    TotNote := 0;
    TotChildren := 1;
    //Self.MakeTaxListDescendants( MyList, Actual.TID, 2, False, True, IsExt,
    //                             li_tax1, StoreNote, TotNote, TotChildren );

    // Compute number of children
    TotItems := NbLine - 1;
    AnItem := TListItem.Create;
    AnItem.ViewCode := cEmpty;
    AnItem.Left := IntToStr( TotItems ) + cSpace + 'items';
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + 1 );
    AddLine( AnItem );

    // Make a title for the reference planes
    AnItem := TListItem.Create;
    AddLine( AnItem );
    AnItem := TListItem.Create;
    AnItem.Left := '<B>Reference planes</B>';
    AddLine( AnItem );
    MyTID := 13506;
    NewHead := TAH.GetEntityByTID( MyTID );

    // Build the top entity
    AnItem := TListItem.Create;
    AnItem.ViewCode := IntToStr( MyTID );
    AnItem.Left := NewHead.GetOfficial( TAH.MainLang, True );
    AnItem.Right := NewHead.GetOfficial( TAH.SubstLang, True );
    AnItem.Indent := 'a';
    AddLine( AnItem );

    // Build all descendant lines of the partonomy
    TooMuch := False;
    SetLength( StoreNote, 20 );
    TotNote := 0;
    TotChildren := 1;
    //Self.MakeTaxListDescendants( MyList, MyTID, 2, False, True, IsExt,
    //                             li_tax1, StoreNote, TotNote, TotChildren );

    // Compute number of children
    TotItems := NbLine - 1;
    AnItem := TListItem.Create;
    AnItem.ViewCode := cEmpty;
    AnItem.Left := IntToStr( TotChildren ) + cSpace + 'items';
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + 1 );
    AddLine( AnItem );

    // Make a title for the reference lines
    AnItem := TListItem.Create;
    AddLine( AnItem );
    AnItem := TListItem.Create;
    AnItem.Left := '<B>Reference lines</B>';
    AddLine( AnItem );
    MyTID := 13513;
    NewHead := TAH.GetEntityByTID( MyTID );

    // Build the top entity
    AnItem := TListItem.Create;
    AnItem.ViewCode := IntToStr( MyTID );
    AnItem.Left := NewHead.GetOfficial( TAH.MainLang, True );
    AnItem.Right := NewHead.GetOfficial( TAH.SubstLang, True );
    AnItem.Indent := 'a';
    AddLine( AnItem );

    // Build all descendant lines of the partonomy
    TooMuch := False;
    SetLength( StoreNote, 20 );
    TotNote := 0;
    TotChildren := 1;
    //MakeTaxListDescendants( MyList, MyTID, 2, False, True, IsExt,
    //                             li_tax1, StoreNote, TotNote, TotChildren );

    // Compute number of children
    TotItems := NbLine - 1;
    AnItem := TListItem.Create;
    AnItem.ViewCode := cEmpty;
    AnItem.Left := IntToStr( TotChildren ) + cSpace + 'items';
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + 1 );
    AddLine( AnItem );

    // Make a title for the reference planes
    AnItem := TListItem.Create;
    AddLine( AnItem );
    AnItem := TListItem.Create;
    AnItem.Left := '<B>Joint movements</B>';
    AddLine( AnItem );
    MyTID := 11375;
    NewHead := TAH.GetEntityByTID( MyTID );

    // Build the top entity
    AnItem := TListItem.Create;
    AnItem.ViewCode := IntToStr( MyTID );
    AnItem.Left := NewHead.GetOfficial( TAH.MainLang, True );
    AnItem.Right := NewHead.GetOfficial( TAH.SubstLang, True );
    AnItem.Indent := 'a';
    AddLine( AnItem );

    // Build all descendant lines of the partonomy
    TooMuch := False;
    SetLength( StoreNote, 20 );
    TotNote := 0;
    TotChildren := 1;
    //MakeTaxListDescendants( MyList, MyTID, 2, False, True, IsExt,
    //                             li_tax1, StoreNote, TotNote, TotChildren );

    // Compute number of children
    TotItems := NbLine - 1;
    AnItem := TListItem.Create;
    AnItem.ViewCode := cEmpty;
    AnItem.Left := IntToStr( TotChildren ) + cSpace + 'items';
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + 1 );
    AddLine( AnItem );
  end;}
end; // _______________________________________________________MakeReferencePage

procedure          tListPage.AddFMAList(
  MyList:          tFMAListSection ) ;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddFMAList
  * Add a FMA list to the List Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbSect:          Integer;
begin
  NbSect := Self.NbFMAList;
  SetLength( Self.FMALine, NbSect );
  Self.FMALine[ NbSect - 1 ] := MyList;
end; // ______________________________________________________________AddFMAList

function           tListPage.GetFMAList(
  PosSection:      Integer )
  :                TFMAListSection;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetFMAList
  * Retrieve a list of FMA lines *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := nil;
  if ( ( PosSection < Length( Self.FMALine ) ) and ( PosSection >= 0 ) ) then
    Result := Self.FMALine[ PosSection ];
end; // ______________________________________________________________GetFMAList

procedure          tListPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TListPage.WritePage
  * Write a List page *
  Description:
  This method writes an entire List page, made of HTML and List sections. It
  calls the adequate section method for writing each section in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbSection:       Integer;
  PageName:        String;
  Page:            TStringList;
  ASection:        TSection;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  PageName := Self.PageName;
  AddTag( DOCTYPETAG, 0 );
  AddTag( HTMLTAG, 0 );
    AddTag( HEADTAG, 1 );
      AddTag( TITLETAG + PageName + TITLEETAG, 2 );
      if ( TA98Short ) then
      begin
        AddTag( TA98CSSVIEWTAG, 2 );
        AddTag( TA98CSSPRINTTAG, 2 );
        AddTag( TA98JSENTITY, 2 )
      end else
      begin
        AddTag( CALLCSSVIEWTAG, 2 );
        AddTag( CALLCSSPRINTTAG, 2 );
        AddTag( CALLJSENTITY, 2 );
      end;
    AddTag( HEADETAG, 1 );
    AddTag( BODYTAG, 1 );
      if ( IsLarge ) then
        AddTag( DIVOTAG + cIdContainer1400 + cAnr, 2 ) // open #Container1400
      else
        if ( IsTA98 ) then
          AddTag( DIVOTAG + c660 + cAnr, 2 )
        else
          AddTag( DIVOTAG + cIdContainer + cAnr, 2 ); // open #Container700

        // Write header (inherited method)
        if ( not IsTA98 ) then
          Self.WriteHeader( 3 );

        // Open the table
        if ( IsLarge ) then
          AddTag( DIVOTAG + cIdBody1400 + cAnr, 3 ) // open #Body1400
        else
          AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

        // Write all sections
        NbSection := Self.NbSection;
        for Indx := 0 to NbSection - 1 do
        begin
          ASection := GetSection( Indx );
          if ( ASection.SectionType in
               [ sc_NavList, sc_StatUniv, sc_Signature, sc_taxonomy ] ) then
            TBiColSection( ASection ).WriteSection( 4 )
          else
            TListSection( ASection ).WriteSection( 4 );
        end; // for

        // Write footer (inherited method)
        if ( not IsTA98 ) then
          Self.WriteFooter( 3 );

        // Close the table
        AddTag( DIVETAG + cOComment + 'Body700' + cEComment, 3 );

        // Close the global divisions
      AddTag( DIVETAG + cOComment + 'Container700' + cEComment, 2 );

      // Add a javascript to call for initialisation of the 3 hierarchies
      AddTag( SCRIPTTAG, 2 );
        AddTag( 'InitSections' + cRol + cSpace + cRor + cSemi, 3 );
      AddTag( SCRIPTETAG, 2 );

      // Close global tags
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSlash + Self.FileName, TEncoding.UTF8 );
end; // _____________________________________________________TListPage.WritePage

procedure          tListPage.WriteFMALines(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteFMALines
  * Write all lines of a FMA List Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  TotLine:         Integer;
  MyClass:         String;
  MyList:          tFMAListSection;
  MyLine:          tFMAListItem;
begin
  MyList := Self.GetFMAList( 0 );
  if ( MyList = nil ) then
    Exit;
  TotLine := MyList.NbFMALine;
  for Indx := 0 to TotLine - 1 do
  begin
    MyLine := MyList.GetFMALine( Indx );
    MyClass := cClassEmpty + cLgShort[ lt_Latin ] + MyLine.Indent + cDQuote;
    if ( MyLine <> nil ) then
    begin
      AddTag( TRTAG, Lev + 1 );
        MakeTD( cClassColS, MyLine.TAID, cEmpty, Lev + 2 );
        MakeTD( cClassColX, MyLine.TATerm, cEmpty, Lev + 2, MyClass );
        MakeTD( cClassColS, MyLine.FMAID, cEmpty, Lev + 2 );
        MakeTD( cClassColX, MyLine.FMATerm, cEmpty, Lev + 2 );
      AddTag( TRETAG, Lev + 1 );
    end;
  end; // for
end; // ___________________________________________________________WriteFMALines

procedure          tListPage.WriteTextLines;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteTextLines
  * Write all lines in a text file of a List Page *
  Description:
  This method writes all lines of a List Page in a text format suitable for
  viewing in Excel. Indentation of hierarchical terms is realized by a double
  space at each level. A title line is present as the first line.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  Raw              = '  ';
var
  Indx:            Integer;
  TotLine:         Integer;
  Posit:           Integer;
  ALine:           String;
  Indent:          String;
  MyFile:          String;
  Left:            String;
  Right:           String;
  TID:             String;
  UID:             String;
  MyList:          tListSection;
  MyLine:          tListItem;
  Page:            TStringList;
  MyEncoding:      tEncoding;
begin

  // Initial stuff
  MyList := TListSection( GetSection( 1 ) );
  TotLine := MyList.NbLine;
  Page := TStringList.Create;
  if ( TotLine > 0 ) then
  begin

    // Loop on all lines
    for Indx := 0 to TotLine - 1 do
    begin
      MyLine := MyList.GetLine( Indx );
      if ( MyLine <> nil ) then
      begin

        // Prepare the indentation
        Indent := cEmpty;
        if ( MyLine.Indent = 'b' ) then
          Indent := Raw
        else if ( MyLine.Indent = 'c' ) then
          Indent := Raw + Raw
        else if ( MyLine.Indent = 'd' ) then
          Indent := Raw + Raw + Raw
        else if ( MyLine.Indent = 'e' ) then
          Indent := Raw + Raw + Raw + Raw
        else if ( MyLine.Indent = 'f' ) then
          Indent := Raw + Raw + Raw + Raw + Raw
        else if ( MyLine.Indent = 'g' ) then
          Indent := Raw + Raw + Raw + Raw + Raw + Raw
        else if ( MyLine.Indent = 'h' ) then
          Indent := Raw + Raw + Raw + Raw + Raw + Raw + Raw
        else if ( MyLine.Indent = 'i' ) then
          Indent := Raw + Raw + Raw + Raw + Raw + Raw + Raw + Raw
        else if ( MyLine.Indent = 'j' ) then
          Indent := Raw + Raw + Raw + Raw + Raw + Raw + Raw + Raw + Raw;

        // Prepare the identificators
        TID := MyLine.ViewCode;
        Posit := Pos( '>', TID );
        TID := Copy( TID, Posit + 1, Length( TID) );
        Posit := Pos( '<', TID );
        TID := Copy( TID, 1, Posit - 1 );
        UID := MyLine.ViewUnit;
        Posit := Pos( '>', UID );
        UID := Copy( UID, Posit + 1, Length( UID) );
        Posit := Pos( '<', UID );
        UID := Copy( UID, 1, Posit - 1 );

        // Prepare the left and right items
        Left := MyLine.Left;
        Posit := Pos( '<B>', Left );
        if ( Posit = 1 ) then
        begin
          Left := Copy( Left, 4, Length( Left ) );
          Left := Copy( Left, 1, Length( Left ) - 4 );
          Posit := Pos( '>', Left );
          if ( Posit > 0 ) then
          begin
            Left := Copy( Left, Posit + 1, Length( Left ) );
            Posit := Pos( '<', Left );
            Left := Copy( Left, 1, Posit - 1 );
          end;
        end else
        begin
          Posit := Pos( '<', Left );
          if ( Posit > 0 ) then
            Left := Copy( Left, 1, Posit - 1 );
        end;
        if ( Indx = 0 ) then
          Left := 'Latin';
        Right := MyLine.Right;
        Posit := Pos( '<B>', Right );
        if ( Posit = 1 ) then
        begin
          Right := Copy( Right, 4, Length( Right ) );
          Right := Copy( Right, 1, Length( Right ) - 4 );
          Posit := Pos( '>', Right );
          if ( Posit > 0 ) then
          begin
            Right := Copy( Right, Posit + 1, Length( Right ) );
            Posit := Pos( '<', Right );
            Right := Copy( Right, 1, Posit - 1 );
          end;
        end else
        begin
          Posit := Pos( '<', Right );
          if ( Posit > 0 ) then
            Right := Copy( Right, 1, Posit - 1 );
        end;
        if ( Indx = 0 ) then
          Right := 'Russian';

        // Build the line
        ALine := TID + CurSep +
                 UID + CurSep +
                 Indent + Left + CurSep +
                 Indent + Right;
        Page.Add( ALine );
      end;
    end; // for
  end;

  // Write the text file
  MyEncoding := TEncoding.UTF8;
  MyFile := Copy( Self.FileName, 1, Length( Self.FileName ) - 3 ) + 'txt';
  Page.SaveToFile( Self.Directory + cSlash + MyFile, MyEncoding );
end; // __________________________________________________________WriteTextLines

procedure          tRATPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  tRATPage.Build
  * Build a RAT Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Build header
  CurrPage := Self;
  if ( Self.Actual <> nil ) then
  begin
    Self.MakeHeader;

    // Build the List navigation section
    Self.MakeSection( sc_NavList );

    // Build the universal statistic section
    Self.MakeSection( sc_StatUniv );

    // Build the universal validation section
    Self.MakeSection( sc_ValidUniv );

    // Build footer
    Self.MakeFooter;
  end;
end; // __________________________________________________________tRATPage.Build

procedure          tRATPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeader
  * Make a header of a RAT Page *
  Description:
  This method prepares the header of a RAT Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTitle:         String;
  First:           String;
  Start:           String;
begin
  inherited;

  // Display the introductory text
  Self.Header.Intro := tiUnivPageEN + cComma + cSpace +
                       cLgTextEN[ TAH.MainLang ];
end; // ______________________________________________________________MakeHeader

procedure          tRATPage.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSection
  * Make a section of any type for a RAT Page *
    =========================================
  Description:
  This method builds any section of a RAT Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MySection:       tListSection;
  MyHTMLSection:   tBiColSection;
  MyDual:          tListSection;
begin

  // Make a Universal validation section
  if ( SType = sc_ValidUniv ) then
  begin
    MySection := tValidUnivSection.Create;
    MySection.Entity := Self.Actual;
    MySection.SectionType := SType;
    MySection.SectionTitle := scValidUniv[ en ];
    MySection.SectionBubble := bsValidUniv[ en ];
    MyDual := tListSection.Create;
    MyDual.SectionType := sc_NoteList;
    MyDual.SectionTitle := scNoteUniv[ en ];
    MyDual.SectionBubble := bsNoteUniv[ en ];
    MySection.ComplSection := MyDual;
    MySection.Build;
  end;

  // Make the navigation section
  if ( SType = sc_NavList ) then
  begin
    MyHTMLSection := tNavListSection.Create;
    MyHTMLSection.SectionType := SType;
    MyHTMLSection.Entity := Self.Actual;
    MyHTMLSection.PageType := Self.CategPage;
    MyHTMLSection.TypeList := Self.TypeList;
    MyHTMLSection.SectionTitle := TAH.GetLabel( reSectNavigList, False );
    MyHTMLSection.SectionBubble := TAH.GetBubble( reSectNavigList, False );
    MyHTMLSection.Build;
  end else

  // Make the universal statistic section
  if ( SType = sc_StatUniv ) then
  begin
    MyHTMLSection := tUnivSection.Create;
    MyHTMLSection.SectionType := SType;
    MyHTMLSection.Entity := Self.Actual;
    MyHTMLSection.PageType := Self.CategPage;
    MyHTMLSection.TypeList := Self.TypeList;
    MyHTMLSection.SectionTitle := scStatList[ en ];
    MyHTMLSection.SectionBubble := bsStatList[ en ];
    MyHTMLSection.Build;
  end;

  // Add the section(s) to the List page
  if ( SType = sc_ValidUniv ) then
  begin
    Self.AddSection( MySection );
    Self.AddSection( MyDual );
  end else
  if ( SType = sc_NavList ) then
    Self.AddSection( MyHTMLSection )
  else
  if ( SType = sc_StatUniv ) then
    Self.AddSection( MyHTMLSection );
end; // _____________________________________________________________MakeSection

procedure          tRATPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tRATPage.WritePage
  * Write a RAT page *
  Description:
  This method writes an entire RAT page, made of HTML and List sections. It
  calls the adequate section method for writing each section in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbSection:       Integer;
  PageName:        String;
  Page:            TStringList;
  ASection:        TSection;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  PageName := Self.PageName;
  AddTag( DOCTYPETAG, 0 );
  AddTag( HTMLTAG, 0 );
    AddTag( HEADTAG, 1 );
      AddTag( TITLETAG + PageName + TITLEETAG, 2 );
      AddTag( CALLCSSVIEWTAG, 2 );
      AddTag( CALLCSSPRINTTAG, 2 );
      AddTag( CALLJSENTITY, 2 );
    AddTag( HEADETAG, 1 );
    AddTag( BODYTAG, 1 );
      AddTag( DIVOTAG + cIdContainer + cAnr, 2 ); // open #Container700

        // Write header (inherited method)
        Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 4 ); // open #Body700

        // Write all sections
        NbSection := Self.NbSection;
        for Indx := 0 to NbSection - 1 do
        begin
          ASection := GetSection( Indx );
          if ( ASection.SectionType in [ sc_NavList, sc_StatUniv ] ) then
            TBiColSection( ASection ).WriteSection( 4 )
          else
            TListSection( ASection ).WriteSection( 4 );
        end; // for

        // Write footer (inherited method)
        Self.WriteFooter( 3 );

        // Close the global divisions
      AddTag( DIVETAG + cOComment + 'Container700' + cEComment, 2 );

      // Add a javascript to call for initialisation of the 3 hierarchies
      AddTag( SCRIPTTAG, 2 );
        AddTag( 'InitSections' + cRol + cSpace + cRor + cSemi, 3 );
      AddTag( SCRIPTETAG, 2 );

      // Close global tags
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSpace + cLgShort[ lt_English ] +
                   cSlash + Self.FileName, TEncoding.UTF8 );
end; // ______________________________________________________tRATPage.WritePage

procedure          tPropertyPage.Build(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tPropertyPage.Build
  * Build a Property Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Count:           Integer;
  Stat1:           String;
  Legend1:         String;
  Main:            TEntity;
begin
  Main := TAH.GetEntityByTID( TID );
  if ( Main <> nil ) then
  begin

    // Build the header og page
    Self.Actual := Main;
    Self.MakeHeader;

    // Build the content of page
    Count := 0;
    Self.MakeContent( TID, 1, Count );

    // Build the footer of page
    Stat1 := fdEntries[ en ] + cColumn + cSpace + IntToStr( Count );
    Legend1 := bbNbEntries[ en ];
    Self.MakeFooter( Stat1, cEmpty, cEmpty, Legend1, cEmpty, cEmpty );
  end;
end; // _____________________________________________________tPropertyPage.Build

procedure          tPropertyPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHeader
  * Make a header for Latin Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited;
  Self.Header.Intro := tiPropertyPage[ en ] + cSpace +
                       Self.Header.Intro;
end; // ______________________________________________________________MakeHeader

procedure          tPropertyPage.MakeContent(
  TID:             Integer;
  Indent:          Integer;
  var Count:       Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeContent
  * Make a content of Property Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  ChildTID:        Integer;
  Children:        String;
  MyEntity:        TEntity;
begin
  MyEntity := TAH.GetEntityByTID( TID );
  if ( MyEntity <> nil ) then
  begin

    // Make a single property line
    Self.MakePropertyLine( MyEntity, Indent );
    Inc( Count );

    // Process all children
    Children := MyEntity.PartCh;
    while ( Children <> cEmpty ) do
    begin
      Posit := Pos( cSemi, Children );
      if ( Posit > 0 ) then
      begin
        ChildTID := StrToInt( Copy( Children, 1, Posit - 1 ) );
        Children := Copy( Children, Posit + 1, Length( Children ) );
      end else
      begin
        ChildTID := StrToInt( Children );
        Children := cEmpty;
      end;

      // Recursive call
      Self.MakeContent( ChildTID, Indent + 1, Count );
    end; // while
  end;
end; // _____________________________________________________________MakeContent

procedure          tPropertyPage.MakePropertyLine(
  MyEntity:        tEntity;
  Indent:          Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePropertyLine
  * Make a single line of Property Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Line:            Integer;
  IsBil:           Boolean;
  IsMul:           Boolean;
  IsMat:           Boolean;
  IsImm:           Boolean;
  IsNon:           Boolean;
  IsDim:           Boolean;
  IsRef:           Boolean;
  IsMal:           Boolean;
  IsFem:           Boolean;
  IsInc:           Boolean;
  IsGen:           Boolean;
  IsSpc:           Boolean;
  IsGtr:           Boolean;
  IsPar:           Boolean;
  Actual:          tEntity;
  MySingle:        tSingle;
  Query:           tSearch;
begin

  Actual := Self.Actual;
  if ( Actual <> nil ) then
  begin

    // Add a new line
    Line := Length( Self.FPropertySet );
    Inc( Line );
    SetLength( Self.FPropertySet, Line );
    Self.FPropertySet[ Line - 1 ] := TPropsValue.Create;

    // Set the ID and term values
    Self.FPropertySet[ Line - 1 ].FTID := MyEntity.TID;
    MyEntity.LgCurrent := TAH.MainLang;
    MyEntity.Query := tSearch.Create( st_Bas );
    MyEntity.SearchTerm;
    MySingle := MyEntity.CurrSingle;
    if ( MySingle <> nil ) then
      Self.FPropertySet[ Line - 1 ].FLib :=
        MySIngle.Mandat + MySingle.Option + MySingle.Bracket;
    MyEntity.LgCurrent := TAH.SubstLang;
    MyEntity.Query := tSearch.Create( st_Bas );
    MyEntity.SearchTerm;
    MySingle := MyEntity.CurrSingle;
    if ( MySingle <> nil ) then
      Self.fPropertySet[ Line - 1 ].FSub :=
        MySIngle.Mandat + MySingle.Option + MySingle.Bracket;
    Self.fPropertySet[ Line - 1 ].FInd := Indent;

    // Set all the property values
    MyEntity.GetHierarProperties( IsBil, IsMul, IsMat, IsImm, IsNon, IsDim,
                                  IsGen, IsSpc, IsPar, IsGtr );
    IsRef := MyEntity.Reference <> 0;
    IsMal := MyEntity.Link = pw_MemberM;
    IsFem := MyEntity.Link = pw_MemberF;
    IsInc := MyEntity.Inconstant;
    Self.fPropertySet[ Line - 1 ].fBil := IsBil;
    Self.fPropertySet[ Line - 1 ].fMul := IsMul;
    Self.fPropertySet[ Line - 1 ].fImm := IsImm;
    Self.fPropertySet[ Line - 1 ].fNon := IsNon;
    Self.fPropertySet[ Line - 1 ].fDim := IsDim;
    Self.fPropertySet[ Line - 1 ].fRef := IsRef;
    Self.fPropertySet[ Line - 1 ].fMal := IsMal;
    Self.fPropertySet[ Line - 1 ].fFem := IsFem;
    Self.fPropertySet[ Line - 1 ].fInc := IsInc;
    Self.fPropertySet[ Line - 1 ].fSpc := IsSpc;
    Self.fPropertySet[ Line - 1 ].fMat := IsMat;
    Self.fPropertySet[ Line - 1 ].fGen := IsGen;
    Self.fPropertySet[ Line - 1 ].fGtr := IsGtr;
    Self.fPropertySet[ Line - 1 ].fPar := IsPAR;
  end;
end; // ________________________________________________________MakePropertyLine

procedure          tPropertyPage.MakeFooter(
  Stat1:           String;
  Stat2:           String;
  Stat3:           String;
  Legend1:         String;
  Legend2:         String;
  Legend3:         String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFooter
  * Make the footer of Latin Page *
  Description:
  This method prepares the footer of a Latin Page, consisting of the current
  date.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyFooter:        tHTMLFooter;
begin

  // Create the object footer
  MyFooter := THTMLFooter.Create;

  // Store the statistrical values
  MyFooter.Stat1 := Stat1;
  MyFooter.Stat2 := Stat2;
  MyFooter.Stat3 := Stat3;
  MyFooter.Legend1 := Legend1;
  MyFooter.Legend2 := Legend2;
  MyFooter.Legend3 := Legend3;

  // Store the date of creation of the page
  MyFooter.DateCreation := DateToStr( Date );

  // Add the footer to the Entity Page
  Self.Footer := MyFooter;
end; // ______________________________________________________________MakeFooter

procedure          tPropertyPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tPropertyPage.WritePage
  * Write the Property Page file *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbLine:          Integer;
  AClass:          String;
  Page:            TStringList;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  AddTag( DOCTYPETAG, 0 );
  AddTag( HTMLTAG, 0 );
    AddTag( HEADTAG, 1 );
      AddTag( TITLETAG + Self.PageName + TITLEETAG, 2 );
      AddTag( CALLCSSVIEWTAG, 2 );
      AddTag( CALLCSSPRINTTAG, 2 );
    AddTag( HEADETAG, 1 );
    AddTag( BODYTAG, 1 );
      AddTag( DIVOTAG + cIdContainer + cAnr, 2 ); // open #Container700

        // Write header
        Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

          // Display the column headers
          AddTag( TABLEOTAG + cClassBodyTable + cAnr, 4 );
            AddTag( TROTAG + cSpace + cClassHeaderColor + cAnr, 5 );
              MakeTD( cClassColno, fdRefID[ en ], cEmpty, 6 );
              AClass := cClassColSSno;
              MakeTD( AClass, 'B', bbBilatText[ en ], 6 );
              MakeTD( AClass, 'M', bbMultiText[ en ], 6 );
              MakeTD( AClass, 'I', bbImmatText[ en ], 6 );
              MakeTD( AClass, 'N', bbNonPhysText[ en ], 6 );
              MakeTD( AClass, 'D', bbDimorphicText[ en ], 6 );
              MakeTD( AClass, 'R', bbReferText[ en ], 6 );
              MakeTD( AClass, 'M', bbMaleText[ en ], 6 );
              MakeTD( AClass, 'F', bbFemaleText[ en ], 6 );
              MakeTD( AClass, 'I', bbInconsText[ en ], 6 );
              MakeTD( AClass, 'S', bbSpeciText[ en ], 6 );
              MakeTD( AClass, 'M', bbMaterText[ en ], 6 );
              MakeTD( AClass, 'G', bbGenerText[ en ], 6 );
              MakeTD( AClass, 'R', bbInconsText[ en ], 6 );
              MakeTD( AClass, 'B', bbBilatText[ en ], 6 );
              MakeTD( cClassColXXXno, fdExpanded[ en ],
                      fdOfficial[ en ] + cSpace +
                      fdInBubble[ en ], 6 );
            AddTag( TRETAG, 5 );
          AddTag( TABLEETAG, 4 );

        // Write all lines
        NbLine := Length( Self.FPropertySet );
        AddTag( TABLEOTAG + cAnr, 4 );
        for Indx := 0 to NbLine - 1 do
          WriteLine( FPropertySet[ Indx ], 5 );
        AddTag( TABLEETAG, 4 );

        // Write footer
        Self.WriteFooter( 3 );

        // Close the HTML page
        AddTag( DIVETAG, 3 ); // close #Body700
      AddTag( DIVETAG, 2 ); // close #Container700
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSlash + Self.FileName );
end; // _________________________________________________tPropertyPage.WritePage

procedure          tPropertyPage.WriteLine(
  ALine:           tPropsValue;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteLine
  * Write a single line of a Property Page *
  Description:
  This method writes a single line of a Property Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTID:           Integer;
  MyCode:          String;
  MyImage:         String;
  Bubble:          String;
  Exp:             String;
  ExpBubble:       String;
  AClass:          String;
  MyIndent:        String;
  Actual:          TEntity;
begin

  // Initial stuff
  MyTID := ALine.TID;
  Actual := TAH.GetEntityByTID( MyTID );
  if ( Actual <> nil ) then
  begin
    AddTag( TRTAG, Level + 1 );

    // Column 1: TAH Reference ID
    MyCode := cTAH + IntToStr( MyTID );
    if ( MyTID = 0 ) then
      AClass := cClassColSSNo
    else
      AClass := cClassColNem;
    MakeTD( AClass, MyCode, cEmpty, Level + 2 );
    AClass := cClassIcon16x16;

    // Column 2: laterality property
    if ( ALine.IsBil ) then
    begin
      MyImage := cBilatImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 2: multiplicity property
    if ( ALine.IsMul ) then
    begin
      MyImage := cMultiImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 3: immateriality property
    if ( ALine.IsImm ) then
    begin
      MyImage := cImmatImg;
      Bubble := bbImmatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 4: non physical property
    if ( ALine.IsNon ) then
    begin
      MyImage := cNonPhImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 5: dimorphic property
    if ( ALine.IsDim ) then
    begin
      MyImage := cDimorImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 6: reference property
    if ( ALine.IsRef ) then
    begin
      MyImage := cReferImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 7: male property
    if ( ALine.IsMal ) then
    begin
      MyImage := cMSymbImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 8: female property
    if ( ALine.IsFem ) then
    begin
      MyImage := cFSymbImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 9: inconstant property
    if ( ALine.IsInc ) then
    begin
      MyImage := cIncstImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );


    // Column 10: specific entity
    if ( ALine.IsSpc ) then
    begin
      MyImage := cSpeciImg;
      Bubble := bbSpeciText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 11: material entity
    if ( ALine.IsMat ) then
    begin
      MyImage := cMaterImg;
      Bubble := bbMaterText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 12: generator entity
    if ( ALine.IsGen ) then
    begin
      MyImage := cGenerImg;
      Bubble := bbGenerText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 13:
    if ( ALine.IsGtr ) then
    begin
      MyImage := cIncstImg;
      Bubble := bbBilatText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 14: Pair
    if ( ALine.IsPar ) then
    begin
      MyImage := cPaireImg;
      Bubble := bbPaireText[ en ];
    end else
    begin
      MyImage := cExpndImg;
      Bubble := cEmpty;
    end;
    MakeTD( AClass, MyImage, Bubble, Level + 2 );

    // Column 15: expanded prefered term
    Exp := ALine.Libelle;
    ExpBubble := ALine.Subst;
    MyIndent := Chr( Ord( 'a' ) + ALine.Indent - 1 );
    AClass := cClassEmpty + cLgShort[ TAH.MainLang ] + MyIndent + cDQuote;
    MakeTD( cClassColXXX, Exp, ExpBubble, Level + 2, AClass );

    AddTag( TRETAG, Level + 1 );
  end;
end; // _______________________________________________________________WriteLine

procedure          tTestPage.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTestPage.Build
  * Build a Language Test Page *
   ============================
  Description:
  This procedure builds a Language Test page for the main language of the
  page.</p>
  The operations are threefold:
  - Build the header of the page,
  - Build all sections,
  - Build the footer of the page.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTest:          Integer;
  PageTitle:       String;
  MyLanguage:      String;
  ASection:        tSectionType;
  MyHeader:        tHTMLHeader;
  MySection:       tSection;
begin

    // Prepare the header
    MyHeader := tHTMLHeader.Create;
    PageTitle := TAH.GetLabel( reLangTestPage );
    MyTest := 0;
    case Self.TypeTest of
      te_NounGender: MyTest := reTestNounGender;
      te_AdjGender: MyTest := reTestAdjGender;
      te_NounPlural:
        begin
          MyHeader.Title := 'Test for plural of nouns';
          MyHeader.Bubble := 'Validation of gender of nouns from ' +
                             'the stored value';
        end;
      te_AdjPlural:
        begin
          MyHeader.Title := 'Test for plural of adjectives';
          MyHeader.Bubble := 'Validation of plural of adjectives from ' +
                             'the stored value';
        end;
      te_NounGenSin:
        begin
          MyHeader.Title := 'Test for genitive singular nouns';
          MyHeader.Bubble := 'Validation of the genitive singular of nouns from ' +
                             'the stored value';
        end;
      te_AdjGenSin:
        begin
          MyHeader.Title := 'Test for genitive singular adjectives';
          MyHeader.Bubble := 'Validation of the genitive singular of adjectives' +
                             'from the stored value';
        end;
      te_NounGenPlu:
        begin
          MyHeader.Title := 'Test for genitive plural nouns';
          MyHeader.Bubble := 'Validation of the genitive plural of nouns from ' +
                             'the stored value';
        end;
      te_AdjGenPlu:
        begin
          MyHeader.Title := 'Test for genitive plural adjectives';
          MyHeader.Bubble := 'Validation of the genitive plural of adjectives' +
                             ' from the stored value';
        end;
      te_NoExpansion: MyTest := reTestNoExp;
      te_AdjExpansion:
        begin
          MyHeader.Title := 'Test for adjective expansion';
          MyHeader.Bubble := 'Validation of the adjective expansion ' +
                             'from the stored value';
        end;
      te_MandExpansion:
        begin
          MyHeader.Title := 'Test for mandatory expansion';
          MyHeader.Bubble := 'Validation of the mandatory expansion ' +
                             'from the stored value';
        end;
      te_LatExpansion:
        begin
          MyHeader.Title := 'Test for lateral expansion';
          MyHeader.Bubble := 'Validation of the lateral expansion ' +
                             'from the stored value';
        end;
      te_OptExpansion:
        begin
          MyHeader.Title := 'Test for optional expansion';
          MyHeader.Bubble := 'Validation of the optional expansion ' +
                             'from the stored value';
        end;
      te_AllExpansions: MyTest := reTestAllExp;
    end; // case on all sections
    if ( MyTest > 0 ) then
    begin
      MyHeader.Title := TAH.GetLabel( MyTest );
      MyHeader.Bubble := TAH.GetBubble( MyTest );
    end;
    case TAH.MainLang of
      lt_Latin:   MyLanguage := TAH.GetLabel( reInLatin, False );
      lt_English: MyLanguage := TAH.GetLabel( reInEnglish, False );
      lt_French:  MyLanguage := TAH.GetLabel( reInFrench, False );
      lt_Spanish: MyLanguage := TAH.GetLabel( reInSpanish, False );
      lt_Russian: MyLanguage := TAH.GetLabel( reInRussian, False );
    end;
    MyHeader.Intro := PageTitle + cSpace + MyLanguage;


    // Modify the header in development phase
    if ( Dev ) then
    begin
      if ( not IsPub ) then
        MyHeader.Intro := MyHeader.Intro + cComma + cSpace +
                          TAH.GetLabel( reWorkInProgress, False );
    end;
    Self.Header := MyHeader;

    // Make the sections
    case Self.TypeTest of
      te_NounGender:
        begin
          if ( TAH.MainLang <> lt_Latin ) then
          begin
            Self.MakeSection( sc_TestNounGender );
            Self.MakeSection( sc_RuleNounGender );
          end;
          Self.MakeSection( sc_FreeNounGender );
        end;
      te_AdjGender:
        begin
          if ( TAH.MainLang <> lt_Latin ) then
          begin
            Self.MakeSection( sc_TestAdjGender );
            Self.MakeSection( sc_RuleAdjGender );
          end;
          Self.MakeSection( sc_FreeAdjGender );
        end;
      te_NounPlural:
        begin
          Self.MakeSection( sc_TestNounPlural );
          case TAH.MainLang of
            lt_French: Self.MakeSection( sc_RuleWordPlural );
            lt_Spanish, lt_English, lt_Russian:
              Self.MakeSection( sc_RuleNounPlural );
          end; // case
          Self.MakeSection( sc_FreeNounPlural );
        end;
      te_AdjPlural:
        begin
          Self.MakeSection( sc_TestAdjPlural );
          case TAH.MainLang of
            lt_French: Self.MakeSection( sc_RuleWordPlural );
            lt_Spanish, lt_English, lt_Russian:
              Self.MakeSection( sc_RuleAdjPlural );
          end; // case
          Self.MakeSection( sc_FreeAdjPlural );
        end;
      te_NounGenSin:
        begin
          Self.MakeSection( sc_TestNounGenSin );
          // Self.MakeSection( sc_RuleNounGenSin );
          Self.MakeSection( sc_FreeNounGenSin );
        end;
      te_AdjGenSin:
        begin
          Self.MakeSection( sc_TestAdjGenSin );
          // Self.MakeSection( sc_RuleAdjGenSin );
          Self.MakeSection( sc_FreeAdjGenSin );
        end;
      te_NounGenPlu:
        begin
          Self.MakeSection( sc_TestNounGenPlu );
          Self.MakeSection( sc_RuleNounGenPlu );
          Self.MakeSection( sc_FreeNounGenPlu );
        end;
      te_AdjGenPlu:
        begin
          Self.MakeSection( sc_TestAdjGenPlu );
          Self.MakeSection( sc_RuleAdjGenPlu );
          Self.MakeSection( sc_FreeAdjGenPlu );
        end;
      te_NoExpansion:
        begin
          Self.MakeSection( sc_TestNoExp );
        end;
      te_AdjExpansion:
        begin
          Self.MakeSection( sc_TestAdjExp );
        end;
      te_MandExpansion:
        begin
          Self.MakeSection( sc_TestMandExp );
        end;
      te_LatExpansion:
        begin
          Self.MakeSection( sc_TestLatExp );
        end;
      te_OptExpansion:
        begin
          Self.MakeSection( sc_TestOptExp );
        end;
      te_AllExpansions:
        begin
          Self.MakeSection( sc_TestNoExp );
          Self.MakeSection( sc_TestAdjExp );
          Self.MakeSection( sc_TestMandExp );
          Self.MakeSection( sc_TestLatExp );
          Self.MakeSection( sc_TestOptExp );
        end;
    end;

    // Prepare the footer
    Self.MakeFooter;
end; // _________________________________________________________tTestPage.Build

procedure          tTestPage.MakeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTestPage.MakeHeader
  * Make a header for a Test Page *
  Description:
  This private method adjust the header for a Test Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited;
  Self.Header.Intro := tiTestPage[ en ] + cSpace +
                       Self.Header.Intro;
end; // ____________________________________________________tTestPage.MakeHeader

procedure          tTestPage.MakeSection(
  SType:           tSectionType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTestPage.MakeSection
  * Make a section of any type for the Translation Page *
  Description:
  This procedure dispatches to specific routines the construction of the
  different sections awailable on this page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MySection:       tBiColSection;
begin
  // Create a new section
  case SType of
    sc_TestNounGender, sc_TestAdjGender, sc_TestNounPlural, sc_TestAdjPlural,
    sc_TestNounGenSin, sc_TestAdjGenSin, sc_TestNounGenPlu, sc_TestAdjGenPlu,
    sc_TestNoExp, sc_TestAdjExp, sc_TestMandExp, sc_TestLatExp, sc_TestOptExp:
      MySection := tTestSection.Create;
    sc_RuleNounGender, sc_RuleAdjGender, sc_RuleNounPlural, sc_RuleAdjPlural,
    sc_RuleWordPlural, sc_RuleAdjExp:
      MySection := tRuleSection.Create;
    sc_FreeNounGender, sc_FreeAdjGender, sc_FreeNounPlural, sc_FreeAdjPlural,
    sc_FreeNounGenSin, sc_FreeNounGenPlu, sc_FreeAdjGenSin, sc_FreeAdjGenPlu,
    sc_FreeAdjExp:
      MySection := tFreeTestSection.Create;
  end;
  MySection.SectionType := SType;
  MySection.PageType := Self.CategPage;

  // Store the items of the section by section type
  case SType of
    sc_TestAdjGender:
      begin
        MySection.SectionTitle := 'Controled test for adjective gender';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_RuleAdjGender:
      begin
        MySection.SectionTitle := 'Rules for adjective gender';
        MySection.SectionBubble := cEmpty;
        tRuleSection( MySection ).Build;
      end;
    sc_FreeAdjGender:
      begin
        MySection.SectionTitle := 'Free test for adjective gender';
        MySection.SectionBubble := cEmpty;
        tFreeTestSection( MySection ).Build;
      end;
    sc_TestNounGender:
      begin
        MySection.SectionTitle := TAH.GetLabel( reSectCTNGender );
        MySection.SectionBubble := TAH.GetBubble( reSectCTNGender );
        tTestSection( MySection ).Build;
      end;
    sc_RuleNounGender:
      begin
        MySection.SectionTitle := TAH.GetLabel( reSectRTNGender );
        MySection.SectionBubble := TAH.GetBubble( reSectRTNGender );
        tRuleSection( MySection ).Build;
      end;
    sc_FreeNounGender:
      begin
        MySection.SectionTitle := TAH.GetLabel( reSectFTNGender );
        MySection.SectionBubble := TAH.GetBubble( reSectFTNGender );
        tFreeTestSection( MySection ).Build;
      end;
    sc_TestNounPlural:
      begin
        MySection.SectionTitle := 'Controled test for nominative plural nouns';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_RuleNounPlural:
      begin
        MySection.SectionTitle := 'Rules for nominative plural nouns';
        MySection.SectionBubble := cEmpty;
        tRuleSection( MySection ).Build;
      end;
    sc_RuleWordPlural:
      begin
        MySection.SectionTitle := 'Rules for nominative plural nouns and adjectives';
        MySection.SectionBubble := cEmpty;
        tRuleSection( MySection ).Build;
      end;
    sc_FreeNounPlural:
      begin
        MySection.SectionTitle := 'Free test for nominative plural nouns ';
        MySection.SectionBubble := cEmpty;
        tFreeTestSection( MySection ).Build;
      end;
    sc_TestAdjPlural:
      begin
        MySection.SectionTitle := 'Controled test for nominative plural adjectives';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_RuleAdjPlural:
      begin
        MySection.SectionTitle := 'Rules for nominative plural adjectives';
        MySection.SectionBubble := cEmpty;
        tRuleSection( MySection ).Build;
      end;
    sc_FreeAdjPlural:
      begin
        MySection.SectionTitle := 'Free test for nominative plural adjectives';
        MySection.SectionBubble := cEmpty;
        tFreeTestSection( MySection ).Build;
      end;
    sc_TestNounGenSin:
      begin
        MySection.SectionTitle := 'Controled test for genitive singular nouns';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_TestAdjGenSin:
      begin
        MySection.SectionTitle := 'Controled test for genitive singular adjectives';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_TestNounGenPlu:
      begin
        MySection.SectionTitle := 'Controled test for genitive plural nouns';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_TestAdjGenPlu:
      begin
        MySection.SectionTitle := 'Controled test for genitive plural adjectives';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_FreeNounGenSin:
      begin
        MySection.SectionTitle := 'Free test for genitive singular nouns';
        MySection.SectionBubble := cEmpty;
        tFreeTestSection( MySection ).Build;
      end;
    sc_FreeAdjGenSin:
      begin
        MySection.SectionTitle := 'Free test for genitive singular adjectives';
        MySection.SectionBubble := cEmpty;
        tFreeTestSection( MySection ).Build;
      end;
    sc_FreeNounGenPlu:
      begin
        MySection.SectionTitle := 'Free test for genitive plural nouns';
        MySection.SectionBubble := cEmpty;
        tFreeTestSection( MySection ).Build;
      end;
    sc_FreeAdjGenPlu:
      begin
        MySection.SectionTitle := 'Free test for genitive plural adjectives';
        MySection.SectionBubble := cEmpty;
        tFreeTestSection( MySection ).Build;
      end;
    sc_TestNoExp:
      begin
        MySection.SectionTitle := 'Controled test for terms without expansion';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_TestAdjExp:
      begin
        MySection.SectionTitle := 'Controled test for adjective expansion';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_RuleAdjExp:
      begin
        MySection.SectionTitle := 'Models for adjective expansion';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_FreeAdjExp:
      begin
        MySection.SectionTitle := 'Controled test for adjective expansion';
        MySection.SectionBubble := cEmpty;
        tFreeTestSection( MySection ).Build;
      end;
    sc_TestMandExp:
      begin
        MySection.SectionTitle := 'Controled test for mandatory expansion';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_TestLatExp:
      begin
        MySection.SectionTitle := 'Controled test for lateral expansion';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
    sc_TestOptExp:
      begin
        MySection.SectionTitle := 'Controled test for optional expansion';
        MySection.SectionBubble := cEmpty;
        tTestSection( MySection ).Build;
      end;
  end; // case on all section types

  // Add the section to the Entity Page
  Self.AddSection( MySection );
end; // ___________________________________________________tTestPage.MakeSection

procedure          tTestPage.WritePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTestPage.WritePage
  * Write a Test Page *
  Description:
  This public method write the HTML file representing a Test Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbSection:       Integer;
  MyHelpFile:      String;
  DirName:         String;
  KnowFileName:    String;
  KnowIcon:        String;
  Page:            TStringList;
  ASection:        tSection;
begin

  // Build the top of HTML page with page name
  Page := TStringList.Create;
  Self.Page := Page;
  MakeTopHTMLPage( 0 );

      // Write header
      Self.WriteHeader( 3 );

        // Open the table
        AddTag( DIVOTAG + cIdBody700 + cAnr, 3 ); // open #Body700

          // Display the column headers
          AddTag( TABLEOTAG + cClassBodyTable + cAnr, 4 );
            AddTag( TROTAG + cSpace + cClassHeaderColor + cAnr, 5 );
              MakeTD( cClassColSno, TAH.GetLabel( reBicolSection, False ),
                      'xxxx', 6 );
              MakeTD( cClassColNno, TAH.GetLabel( reBicolLeft, False ),
                      TAH.GetBubble( reBicolLeft, False ), 6 );
              MakeTD( cClassColXXXno, TAH.GetLabel( reBicolRight, False ),
                      cEmpty, 6 );
            AddTag( TRETAG, 5 );
          AddTag( TABLEETAG, 4 );

        // Write all sections
        NbSection := Self.NbSection;
        for Indx := 0 to NbSection - 1 do
        begin
          ASection := GetSection( Indx );
          KnowIcon := cEmpty;
          MyHelpFile := cEmpty;
          if ( ASection.SectionType = sc_RuleNounGender ) then
          begin
            DirName := '../Test Language/';
            KnowFileName := 'HelpNounGender' +
                            cLgShort[ TAH.MainLang ] +
                            cLgShort[ TAH.DisLanguage ] +
                            cPeriod + cHTML;
            KnowIcon := '<img src="../../img/KnowIcon32.png"' + cSpace +
                        {'id="BtnKnowNounGender"' + cSpace +
                        'type="button"' + cSpace + }
                        'onclick="ToggleSection( ''boxknowledge'' )"/>';
            MyHelpFile := AOTAG + cHrefEmpty + DirName + KnowFileName +
                          cDQuote + cAnr + KnowIcon + AETAG;
          end;
          tBiColSection( ASection ).WriteSection( 4, KnowIcon );
        end;

        // Write footer
        Self.WriteFooter( 3 );

        // Close the HTML page
        AddTag( DIVETAG, 3 ); // close #Body700
      AddTag( DIVETAG, 2 ); // close #Container700
    AddTag( BODYETAG, 1 );
  AddTag( HTMLETAG, 0 );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSlash + Self.FileName, TEncoding.UTF8 );
end; // _____________________________________________________tTestPage.WritePage

function           tXMLPage.GetNbTag()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbTag
  * Retrieve current number of tags *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fTagSet );
end; // ________________________________________________________________GetNbTag

procedure          tXMLPage.ResetPage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ResetPage
  * Reset an XML Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( Self.FTagSet, 0 );
end; // _______________________________________________________________ResetPage

procedure          tXMLPage.MakeTagItem(
  Body:            String;
  Level:           Integer;
  Position:        Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTagItem
  * Make a new tag item to the XML page *
  Description:
  This method is the basic procedure for the collection of new tags or group
  of tags in the XML page. It stores all information necessary for the final
  writing of XML tags.</P>
  A TagItem class of object is defined as a container of a single contribution
  submitted by this method. The XML Page object includes an array of such
  TagItem objects.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbItem:          Integer;
  TagItem:         tTagItem;
begin

  // Prepare the new tag and the tag array
  TagItem := TTagItem.Create;
  TagItem.Tag := Body;
  TagItem.Level := Level;
  NbItem := Length( Self.fTagSet );
  Inc( NbItem );
  SetLength( Self.fTagSet, NbItem );

  // Insert the new tag item at last position
  if ( Position = -1 ) or ( Position >= NbItem - 2 ) then
    Self.fTagSet[ NbItem - 1 ] := TagItem
  else

  // Insert the new tag item at specified position
  begin
    for Indx := NbItem - 1 downto Position + 1 do
      Self.fTagSet[ Indx ] := Self.fTagSet[ Indx - 1 ];
    Self.fTagSet[ Position ] := TagItem;
  end;
end; // _____________________________________________________________MakeTagItem

procedure          tXMLHierarPage.MakeHierarHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHierarHeader
  * Make the header to the XML page *
  Description:
  This method creates the header of a Hierarchy Page, containing an encoding
  directive for utf-8 and an opening tag.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.MakeTagItem( cEncoding, 0 );
  Self.MakeTagItem( BeginXml( xmlTreeView ), 0 );
end; // ________________________________________________________MakeHierarHeader

procedure          tXMLHierarPage.BuildHierarPage(
  TID:             Integer;
  StartSection:    tDisplay );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildHierarPage
  * Build and write an XML Hierarchy Page *
  Description:
  This procedure prepares an XML file for the top hierarchy.<P>
  The recursive procedure ProcessNode is called for the specified top node. All
  children are processed in turn with their descendants when present.<P>
  The total number of entries is calculated at the end and is displayed. It is
  equal to the sum plus 1 of all childset nb values.<P>
  Each end of the top hierarchy when a section is reached is given with an url
  for the specification of the rest of the hierarchy up to the leaves.<P>
  The language for generation of this file is determined by the global
  variable LgCur, which is set in the calling procedure.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Build the Hierarchy Page
  Self.PageName := cTAH + IntToStr( TID ) + cSpace + tiHierarPageEN;
  Self.MakeHierarPage( TID, StartSection );

  // Write the file of the Entity Page
  Self.Directory := cProjectDir + cAutoDir + DirHierarchyName + cSpace +
                    cLgShort[ TAH.MainLang ];
  Self.FileName := cTAH + IntToStr( TID ) + cSpace + cHierarchy + cSpace +
                   cLgShort[ TAH.MainLang ] + cPeriod + XmlExt;
  Self.WriteHierarPage;

end; // _________________________________________________________BuildHierarPage

procedure          tXMLHierarPage.MakeHierarPage(
  TID:             Integer;
  StopSection:     tDisplay );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHierarPage
  * Make a single Hierarchy Page of a specified type *
  Description:
  This method is called for an entity of a specified type. It builds the
  Hierarchy Page for this entity, using a recursive procedure down the
  hierarchy. The construction is stopped on the an entity of a stop section
  is found or at the leaves of the hierarchy.</P>
  Both hierarchies, partonomy or taxonomy, are considered.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotChild:        Integer;
  IsTax:           Boolean;
  ACode:           String;
  ViewCode:        String;
  MyTitle:         String;
  MyTAID:          String;
  ATerm:           tSingle;
  MyEntity:        tEntity;
begin

  // Initial stuff
  MyEntity := Self.Actual;
  Self.Page := TStringList.Create;
  PageName := Self.PageName;
  ACode := IntToStr( TID );
  ViewCode := cTAH + ACode;
  Self.NbNodes := 0;
  Self.NbTot := 0;
  Self.NbSCall := 0;
  Self.NbRCall := 0;
  Self.NbQCall := 0;

  // Head of XML message
  if ( MyEntity <> nil ) then
  begin
    Self.MakeHierarHeader;
    MyEntity.LgCurrent := lt_Latin;
    MyEntity.Query := tSearch.Create( st_Dis );
    MyEntity.SearchTerm;
    ATerm := MyEntity.CurrSingle;
    if ( ATerm = nil ) then
    begin
      MyEntity.Query := TSearch.Create( st_Bas );
      MyEntity.SearchTerm;
      ATerm := MyEntity.CurrSingle;
    end;
    MyTitle := Self.Actual.InternalTex;

    // Process the display term and its descendants
    if ( ATerm <> nil ) then
    begin
      MyTitle := ATerm.Mandat + ATerm.Option;
      MyTAID := 'c' + ACode;
      Self.MakeTagItem( BeginXmlPar( xmlNode, Param( xmlTitle, MyTitle ) +
              Param( xmlTAID, MyTAID ) ), 1 );
      TotChild := Actual.NbPartC;
      IsTax := TAH.IsTaxonomy( TID );
      if IsTax then
        TotChild := Actual.NbTaxC;
      Self.MakeTagItem( BeginXmlPar( xmlChildSet,
                        Param( xmlNb, IntToStr( TotChild ) ) ), 2 );
      Self.ProcessNode( 2, IsTax, TID, StopSection );
      Self.MakeTagItem( EndXml( xmlChildSet ), 2 );
      Self.MakeTagItem( EndXml( xmlNode ), 1 );
      Self.MakeHierarFooter( Self.NbTot, Self.NbSCall, Self.NbRCall,
                             Self.NbQCall );
    end;
  end;
end; // __________________________________________________________MakeHierarPage

procedure          tXMLHierarPage.ProcessNode(
  Level:           Integer;
  IsTax:           Boolean;
  ATID:            Integer;
  StopSection:     tDisplay );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ProcessNode
  * Process recursively a node and all its descendants *
  Description:
  This method processes an entity and considers all its children as long as
  they are positioned before a possible stop section entity. The process
  continues recursively on all children in turn. The Hierarchy Page is built
  from each entity using the display name. A count of the number of
  entities is done, as well as the number of continuation sections.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  TotChildren:     Integer;
  TotChild:        Integer;
  NbNodes:         Integer;
  IsChildren:      Boolean;
  MyTitle:         String;
  MyUrl:           String;
  MyTAID:          String;
  Chose:           String;
  MyEntity:        tEntity;
  Child:           tEntity;
  MySingle:        tSingle;
begin
  // Initial stuff
  TotChildren := 0;
  MyEntity := Self.Actual;
  if ( MyEntity <> nil ) then
  begin
    // Loop on all the children
    NbNodes := 0;
    MyEntity.GetChildren( IsTax );
    for Indx := 0 to MyEntity.NbChildren - 1 do
    begin

      // Display current child
      Child := TAH.GetEntityByTID( MyEntity.SortedChildren[ Indx ] );
      if ( Child <> nil ) then
      begin

        // Handling of references
        if ( Child.Reference > 0 ) then
          Continue;

        // Retrieve display term in current language
        Child.LgCurrent := lt_Latin;
        Child.Query := tSearch.Create( st_Bas );
        Child.SearchTerm;
        MySingle := Child.CurrSingle;
        if ( MySingle <> nil ) then
          MyTitle := MySingle.Mandat + MySingle.Option + MySingle.Bracket;

        // Display last node of current hierarchy page
        TotChild := Child.NbPartC;
        if IsTax then
          TotChild := Child.NbTaxC;
        IsChildren := TotChild > 0;
        MyTAID := IntToStr( Child.TID );

        if ( ( Child.Display = StopSection ) or ( not IsChildren ) ) then
        begin
          MyUrl := cTAH + MyTAID + cSpace + cHierarchy +
                   cSpace + cLgShort[ LgCur ] + cPeriod + XmlExt;
          if IsChildren then
          begin
            Self.MakeTagItem( BeginXmlPar( xmlNode,
                              Param( xmlTitle, MyTitle ) +
                              Param( xmlTAID, 'c' + MyTAID ) +
                              Param( xmlUrl, MyUrl ) ) +
                              EndXml( xmlNode ), Level + 1 );
            if Child.Display = ds_s then
              Self.NbSCall := Self.NbSCall + 1;
            if Child.Display = ds_r then
              Self.NbRCall := Self.NbRCall + 1;
            if Child.Display = ds_q then
              Self.NbQCall := Self.NbQCall + 1;
          end else
          begin
            Chose := Param( xmlTitle, MyTitle ) +
                     Param( xmlTAID, 'c' + MyTAID );
            Chose := BeginXmlPar( xmlNode, Chose );
            Chose := Chose + EndXml( xmlNode );
            Self.MakeTagItem( Chose, Level + 1 );
          end;
        end else

        // Recursive call
        begin
          Self.MakeTagItem( BeginXmlPar( xmlNode, Param( xmlTitle, MyTitle ) +
                            Param( xmlTAID, 'c' + MyTAID ) ), Level + 1 );
          Self.MakeTagItem( BeginXmlPar( xmlChildSet,
                            Param( xmlNb, IntToStr( TotChild ) ) ),
                            Level + 2 );
          Self.Actual := Child;
          Self.ProcessNode( Level + 2, IsTax, Child.TID, StopSection );
          Self.MakeTagItem( EndXml( xmlChildSet ), Level + 2 );
          Self.MakeTagItem( EndXml( xmlNode ), Level + 1 );
        end;
        Inc( NbNodes );
      end;
    end; // for
    Self.NbTot := Self.NbTot + NbNodes;
  end;
end; // _____________________________________________________________ProcessNode

procedure          tXMLHierarPage.MakeHierarFooter(
  NbTot:           Integer;
  NbSCall:         Integer;
  NbRCall:         Integer;
  NbQCall:         Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeHierarFooter
  * Make the footer of the XML page *
  Description:
  This method creates the footer of a Hierarchy Page, containing a count of
  Hierarchy Page sections by type and a closing tag.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyStat:          String;
begin
  MyStat := Param( xmlEntry, IntToStr( NbTot ) ) +
            Param( xmlSCall, IntToStr( NbSCall ) ) +
            Param( xmlRCall, IntToStr( NbRCall ) ) +
            Param( xmlQCall, IntToStr( NbQCall ) ) + cSlash;
  Self.MakeTagItem( BeginXmlPar( xmlStat, MyStat ), 1 );
  Self.MakeTagItem( EndXml( xmlTreeView ), 0 );
end; // ________________________________________________________MakeHierarFooter

procedure          tXMLHierarPage.WriteHierarPage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteHierarPage
  * Write an XML Hierarchy Page *
  Description:
  This method handles all XML stored contributions and writes the XML tags on
  a page, to be saved at end.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbItem:          Integer;
  Indx:            Integer;
begin
  // Loop on all tag items
  NbItem := Length( Self.FTagSet );
  for Indx := 0 to NbItem - 1 do
    AddTag( Self.FTagSet[ Indx ].Tag, Self.FTagSet[ Indx ].Level );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSlash + Self.FileName );
end; // _________________________________________________________WriteHierarPage

procedure          tXMLSinglePage.BuildSinglePage(
  LPage:           TStringList );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildSinglePage
  * Build a Single letter Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Count:           Integer;
  NbOcc:           Integer;
  NbWord:          Integer;
  Posit:           Integer;
  Level:           Integer;
  MyLine:          String;
  Word:            String;
  Past:            String;
  ActLetter:       Char;
  Second:          Char;
  PastSec:         Char;
begin;

  // Build the Single letter Page
  Self.Page := TStringList.Create;
  Self.PageName := tiSinglePageEN;
  Self.MakeSingleHeader;
  Count := LPage.Count;
  Level := 0;
  Self.MakeTagItem( BeginXmlPar( xmlItem,
                    Param( xmlNbItem, IntToStr( Count ) ) ), Level + 1 );

  // Loop on all entries of a single letter
  MyLine := LPage[ 0 ];
  ActLetter := MyLine[ 1 ];
  Second := MyLine[ 2 ];
  NbWord := 0;
  NbOcc := 0;
  Past := cEmpty;
  PastSec := cSpace;
  for Indx := 0 to Count - 1 do
  begin
    MyLine := LPage[ Indx ];

    // Extract word
    Posit := Pos( CurSep, MyLine );
    Word := Copy( MyLine, 1, Posit - 1 );
    Second := Word[ 2 ];

    // Presence of a new word
    if ( Word <> Past ) then
    begin
      Inc( NbWord );

      // Open a new second letter
      if ( Indx > 0 ) then
        Self.MakeTagItem( BeginXmlPar( xmlWord,
                          Param( xmlNbOcc, IntToStr( NbOcc ) ) ) + Past +
                          EndXml( xmlWord ), Level + 4 );
      if ( ( Second <> PastSec ) or ( Indx = 0 ) ) then
      begin
        if ( Indx > 0 ) then
          Self.MakeTagItem( EndXml( xmlLetter ), Level + 3 );
        Self.MakeTagItem( BeginXMLPar( xmlLetter,
          Param( xmlPattern, ActLetter + Second ) ), Level + 3 );
      end;
      NbOcc := 0;
    end;
    Past := Word;
    PastSec := Word[ 2 ];
    Inc( NbOcc );

    // Final task closing the loop
    if ( Indx = Count - 1 ) then
    begin
      Self.MakeTagItem( BeginXmlPar( xmlWord,
                        Param( xmlNbOcc, IntToStr( NbOcc ) ) ) + Past +
                        EndXml( xmlWord ), Level + 4 );
    end;
  end;

  // Terminate the file
  Self.MakeTagItem( BeginXmlPar( xmlWords,
                    Param( xmlNbWord, IntToStr( NbWord ) ) ), Level + 2, 3 );
  Self.MakeTagItem( EndXml( xmlLetter ), Level + 3 );
  Self.MakeTagItem( EndXml( xmlWords ), Level + 2 );
  Self.MakeTagItem( EndXml( xmlItem ), Level + 1 );
  Self.MakeSingleFooter;

  // Write the file of the Single letter Page
  Self.Directory := cProjectDir + cAutoDir + DirSingleName + cSpace +
                    cLgShort[ TAH.MainLang ];
  Self.FileName := cSingle + cSpace + ActLetter + cSpace +
                   cLgShort[ TAH.MainLang ] + cPeriod + XmlExt;
  Self.WriteSinglePage;
end; // _________________________________________________________BuildSinglePage

procedure          tXMLSinglePage.MakeSingleHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSingleHeader
  * Make the header to the Single letter XML page *
  Description:
  This method creates the header of a Single letter Page, containing an encoding
  directive for utf-8 and an opening tag.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.MakeTagItem( cEncoding, 0 );
  Self.MakeTagItem( BeginXml( xmlSingle ), 0 );
end; // ________________________________________________________MakeSingleHeader

procedure          tXMLSinglePage.MakeSingleFooter;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSingleFooter
  * Make the footer of the Single letter XML page *
  Description:
  This method creates the footer of a Single letter Page..</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.MakeTagItem( EndXml( xmlSingle ), 0 );
end; // ________________________________________________________MakeSingleFooter

procedure          tXMLSinglePage.WriteSinglePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteSinglePage
  * Write an XML Single letter Page *
  Description:
  This method handles all XML stored contributions and writes the XML tags on
  a page, to be saved at end.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbItem:          Integer;
  Indx:            Integer;
begin
  // Loop on all tag items
  NbItem := Length( Self.FTagSet );
  for Indx := 0 to NbItem - 1 do
    AddTag( Self.FTagSet[ Indx ].Tag, Self.FTagSet[ Indx ].Level );

  // Save page on external file
  Page.SaveToFile( Self.Directory + cSlash + Self.FileName );
end; // _________________________________________________________WriteSinglePage

procedure          tXMLThreePage.BuildThreePage(
  Section:         TStringList );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BuildThreePage
  * Build a Three letters Page *
  Description:
  This procedure build a three letters Page from the received list of
  strings. The page is stored on a local directory.</P>
  There are two parameter driven actions which are taken in order to limit the
  size of files to be uploaded (not yet implemented).</P>
  1. The list of entities, made of TID, is limited to an upper value.</P>
  2. The number of displayed terms is limited to an upper value.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx: Integer;
  Count: Integer;
  NbOcc: Integer;
  NbWord: Integer;
  Posit: Integer;
  Level: Integer;
  LocWord: Integer;
  MyLine: String;
  Line3: String;
  Word: String;
  Past: String;
  Three: String;
  MyLib: String;
  MyTID: String;
  MyList: String;
begin;
  // Build the Single letter Page
  Self.Page := TStringList.Create;
  Self.PageName := tiThreePageEN;
  Self.MakeThreeHeader;
  Count := Section.Count;
  Level := 0;
  Self.MakeTagItem(BeginXmlPar(xmlItem, Param(xmlNbItem, IntToStr(Count))),
    Level + 1);
  // Loop on all entries of a single letter
  MyLine := Section[0];
  Three := Copy(MyLine, 1, 3);
  Line3 := Three;
  NbWord := 0;
  NbOcc := 0;
  Past := cEmpty;
  LocWord := 0;
  MyList := cEmpty;
  for Indx := 0 to Count - 1 do
  begin
    MyLine := Section[Indx];
    // Extract word
    Posit := Pos(CurSep, MyLine);
    Word := Copy(MyLine, 1, Posit - 1);
    if (Length(Word) >= 3) then
      Line3 := Copy(Word, 1, 3)
    else
      Line3 := Copy(Word, 1, 2) + cSpace;
    MyLine := Copy(MyLine, Posit + 1, Length(MyLine));
    Posit := Pos(CurSep, MyLine);
    MyLib := Copy(MyLine, 1, Posit - 1);
    MyTID := Copy(MyLine, Posit + 1, Length(MyLine));
    // Open a new word
    if (Word <> Past) then
    begin
      Inc(NbWord);
      if (Indx > 0) then
      begin
        Self.MakeTagItem(BeginXmlPar(xmlWord, Param(xmlNbOcc, IntToStr(NbOcc)) +
          Param(xmlName, Past)), Level + 3, LocWord);
        Self.MakeTagItem(BeginXml(xmlList) + MyList + EndXml(xmlList),
          Level + 4);
        Self.MakeTagItem(EndXml(xmlWord), Level + 3);
        MyList := cEmpty;
      end;
      LocWord := Self.NbTag;
      NbOcc := 0;
    end;
    // Continue on a known word
    if (MyList <> cEmpty) then
      MyList := MyList + CurSep + MyTID
    else
      MyList := MyTID;
    Self.MakeTagItem(BeginXml(xmlTerm), Level + 4);
    Self.MakeTagItem(BeginXml(xmlLib) + MyLib + EndXml(xmlLib), Level + 5);
    Self.MakeTagItem(BeginXml(xmlTID) + MyTID + EndXml(xmlTID), Level + 5);
    Self.MakeTagItem(EndXml(xmlTerm), Level + 4);
    Past := Word;
    Inc(NbOcc);
    if (Indx = Count - 1) then
    begin
      Self.MakeTagItem(BeginXmlPar(xmlWord, Param(xmlNbOcc, IntToStr(NbOcc)) +
        Param(xmlName, Past)), Level + 3, LocWord);
      Self.MakeTagItem(BeginXml(xmlList) + MyList + EndXml(xmlList), Level + 4);
      Self.MakeTagItem(EndXml(xmlWord), Level + 3);
    end;
  end; // for
  // Terminate the file
  Self.MakeTagItem(BeginXmlPar(xmlWords, Param(xmlNbWord, IntToStr(NbWord))),
    Level + 2, 3);
  Self.MakeTagItem(EndXml(xmlWords), Level + 2);
  Self.MakeTagItem(EndXml(xmlItem), Level + 1);
  Self.MakeThreeFooter;
  // Write the file of the three letters Page
  Self.Directory := cProjectDir + cAutoDir + DirThreeName + cSpace + cLgShort[TAH.MainLang];
  Self.FileName := cThree + cSpace + Three + cSpace + cLgShort[TAH.MainLang] +
    cPeriod + XmlExt;
  Self.WriteThreePage;
end; // __________________________________________________________BuildThreePage

procedure          tXMLThreePage.MakeThreeHeader;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeThreeHeader
  * Make the header to the Three letters XML page *
  Description:
  This method creates the header of a Single letter Page, containing an encoding
  directive for utf-8 and an opening tag.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.MakeTagItem( cEncoding, 0 );
  Self.MakeTagItem( BeginXml( xmlThree ), 0 );
end; // _________________________________________________________MakeThreeHeader

procedure          tXMLThreePage.MakeThreeFooter;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeThreeFooter
  * Make the footer of the Three letters XML page *
  Description:
  This method creates the footer of a Single letter Page..</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.MakeTagItem( EndXml( xmlThree ), 0 );
end; // _________________________________________________________MakeThreeFooter

procedure          tXMLThreePage.WriteThreePage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteThreePage
  * Write an XML Three letters Page *
  Description:
  This method handles all XML stored contributions and writes the XML tags on
  a page, to be saved at end.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbItem: Integer;
  Indx: Integer;
begin
  // Loop on all tag items
  NbItem := Length( Self.FTagSet );
  for Indx := 0 to NbItem - 1 do
    AddTag( Self.FTagSet[ Indx ].Tag, Self.FTagSet[ Indx ].Level );
  // Save page on external file
  Page.SaveToFile( Self.Directory + cSlash + Self.FileName );
end; // __________________________________________________________WriteThreePage

end.
