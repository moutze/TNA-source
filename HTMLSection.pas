{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit HTMLSection
  * Class for all sections of an HTML Page *
  Description:
  This unit contains the class definition for header, footer and any sections
  of HTML pages, whatever is the type of the page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit HTMLSection;

interface

uses
  Entity, TAHParam, ComCtrls, Stat, WList, SingleTerms;

type
  tListSection = class;
  tTA98ListItem = class;

                             // HTML header class definition
  tHTMLHeader                = class( TObject )
  private
    FPre:                    String;
    FTit:                    String;
    FBub:                    String;
    FLeg:                    String;
  public
                             // Introductive text
    property Intro:          String read FPre write FPre;
                             // Page title, usually the Latin official term
    property Title:          String read FTit write FTit;
                             // Page title bubble, usually English equivalent
    property Bubble:         String read FBub write FBub;
                             // Page legend bubble
    property Legend:         String read FLeg write FLeg;
  end;

                             // HTML footer class definition
  tHTMLFooter                = class( TObject )
  private
    FNb1:                    String;
    FNb2:                    String;
    FNb3:                    String;
    FLg1:                    String;
    FLg2:                    String;
    FLg3:                    String;
    FDat:                    String;
  public
                             // First value for display
    property Stat1:          String read FNb1 write FNb1;
                             // Second value for display
    property Stat2:          String read FNb2 write FNb2;
                             // Third value for display
    property Stat3:          String read FNb3 write FNb3;
                             // Legend in bubble for first value
    property Legend1:        String read FLg1 write FLg1;
                             // Legend in bubble for second value
    property Legend2:        String read FLg2 write FLg2;
                             // Legend in bubble for third value
    property Legend3:        String read FLg3 write FLg3;
                             // Date of creation of the page
    property DateCreation:   String read FDat write FDat;
  end;

                             // Top section class
  tSection                   = class( TObject )
  private
    fSTit:                   String;
    fSBub:                   String;
    fSTyp:                   tSectionType;
    fPTyp:                   tCategPage;
    fEntity:                 tEntity;
    fUID:                    Integer;
    fTLis:                   tTypeListPage;
  public
    // Title of the section in interface language
    property SectionTitle:   String read fSTit write fSTit;
                             // Bubble about the title of the section
    property SectionBubble:  String read fSBub write fSBub;
                             // Type of section
    property SectionType:    tSectionType read fSTyp write fSTyp;
                             // Category of the page owner of this section
    property PageType:       tCategPage read fPTyp write fPTyp;
                             // Entity relevant to the section
    property Entity:         tEntity read fEntity write fEntity;
                             // Unit identifier relevant to the section
    property UID:            Integer read fUID write fUID;
                             // Type of list
    property TypeList:       tTypeListPage read fTLis write fTLis;
                             // Common procedure for building any section
    procedure                Build; virtual; abstract;
  end;

                             { Bi-column item class definition }
  tBiColItem                 = class( TObject )
  private
    fSrcLabel:               string;
    fAltLabel:               string;
    fValue:                  string;
    fBubble:                 string;
    fUrl:                    string;
    fPartLink:               string;
    fIndent:                 string;
    fIconR:                  string;
    fDefIcon:                string;
    fDef:                    string;
    fTypeItem:               tTypeItem;
    fColor:                  tLanguage;
  public
                             // Source label for the item in display language
    property SrcLabel:       string read fSrcLabel write fSrcLabel;
                             // Alternative label for bubbles
    property AltLabel:       string read fAltLabel write fAltLabel;
                             // Value of item
    property Value:          string read fValue write fValue;
                             // Bubble associated to the item
    property Bubble:         string read fBubble write fBubble;
                             // URL applicable to the item
    property Url:            string read fUrl write fUrl;
                             // Partonomic link
    property PartLink:       string read fPartLink write fPartLink;
                             // Indentation of item
    property Indent:         string read fIndent write fIndent;
                             // Additional icon on the right
    property IconRight:      string read fIconR write fIconR;
                             // Icon for a definition
    property DefIcon:        string read fDefIcon write fDefIcon;
                             // Definition text
    property Def:            string read fDef write fDef;
                             // Item type: Normal or MakeDiv
    property TypeItem:       tTypeItem read fTypeItem write fTypeItem;
                             // Background color depending on current language
                             property Color: tLanguage read fColor write fColor;
                           end;

                             // Bicolumn section class definition
  tBiColSection              = class( tSection )
  private
    fItem:                   array of tBiColItem;
    function                 GetNbItem()
                               : Integer;
  public
                             // Number of items
    property NbItem:         Integer read GetNbItem;
                             // Add a new item to the section
    procedure                AddItem(
                               AnItem: tBiColItem );
                             // Retrieve an item of the section by position
    function                 GetItem(
                               PosItem: Integer )
                               : tBiColItem;
                             // Compute the entity type
    function                 GetEntityType(
                               TID: Integer )
                               : String;
                             // Compute the entity type for Id section
    procedure                MakeTypeOfEntity(
                               TID: Integer;
                               Lang: tLanguage;
                               var Value: String;
                               var Bubble: String );
                             // Compute the unit type for Id section
    procedure                MakeTypeOfUnit(
                               TID: Integer;
                               Lang: tLanguage;
                               var Value: String;
                               var Bubble: String );
                             // Compute the unit type
    function                 GetTetraType(
                               TID: Integer )
                               : String;
                             //
    function                 RetrieveScientificNote(
                               MyTID: Integer;
                               UID: Integer;
                               var TotNote: Integer;
                               var StoreNote: Array of NoteRec )
                               : Boolean;
                             // Scan descendants for linkage section
    procedure                LinkageOnDescendant(
                               Actual: tEntity );
                             // Write any bi-column section
    procedure                WriteSection(
                               Lev: Integer;
                               MyHelpFile: String = cEmpty );
                             // Define
    procedure                MakeStatUnivDescendants(
                               MyStat: tStatUniversal;
                               TID: Integer;
                               Level: Integer;
                               AType: tTypeListPage;
                               IsStop: Boolean;
                               var TotChildren: Integer;
                               var TotPartial: Integer);
                             // Display a group of a term
    procedure                DisplayGroup(
                               MyFormula: String;
                               Level: Integer );
                             // Make an mandatory expansion
    procedure                MakeMandExpansion(
                               TID: Integer;
                               MyObl: Integer );
                             // Make an adjective expansion
    procedure                MakeAdjExpansion(
                               TID: Integer;
                               MyAdj: Integer;
                               MyPref: Integer;
                               Level: Integer );
  end;

                             // Identification section
  tIdSection =               class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Navigation section
  tNavSection                = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Interface section
  tIntSection                = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Latin terms section
  tLangSection               = class( tBiColSection )
  public
    procedure                Build; override;
  end;

                             // Property section
  tPropSection               = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Vocabulary section
  tVocSection               = class( tBiColSection )
  public
    procedure                Build; override;
                             // Build a level on the vocabulary tree
    procedure                MakeVocLevel(
                               TID: Integer;
                               var Count: Integer;
                               var SupList: tSupList );
                             // Build the formula list by word type
    procedure                MakeListByWordType(
                               LexType: tLexType;
                               MyWordList: tWordList;
                               var Count: Integer );
                             // Display of the supplementary list
    procedure                DisplaySupList(
                               var Count: Integer;
                               SupList: tSupList );
  end;
                             // Documentation section
  tDocumSection              = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Definition section
  tDefSection                = class( tBiColSection )
  private
    procedure                MakeTaxDefGeneric(
                               Lang: tLanguage = lt_None );
    procedure                MakeEncDefGeneric;
    procedure                MakeTaxDefLateral;
    procedure                MakeTaxDefPair;
    procedure                MakeTaxDefSet;
    procedure                MakeTaxDefPSet;
  public
    procedure                Build; override;
  end;
                             // Note section
  tNoteSection               = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Level section
  tLevelSection              = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             //
  tLinkSection               = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Signature section
  tSignatureSection          = class( tBiColSection )
  private
    procedure                MakePartSigLevel4;
    procedure                MakePartSigLevel3;
    procedure                MakePartSigLevel21;
    procedure                MakeTaxSigLevel4;
    procedure                MakeTaxSigLevel3;
    procedure                MakeTaxSigLevel21;
  public
    procedure                Build; override;
  end;
                             // List navigation section
  tNavListSection            = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Universal section
  tUnivSection               = class( tBiColSection )
  public
    procedure                Build; override;
  end;

  tTermDesignSection         = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             // Test section
  tTestSection               = class( tBiColSection )
  private
    fNbTest:                 Integer;
    function                 GetNbTest()
                               :Integer;
    procedure                SetTestHeading(
                               AnItem: tBicolItem );
  public
    property NbTest:         Integer read GetNbTest;
    procedure                Build; override;
  end;
                             // Rules for test section
  tRuleSection               = class( tBiColSection )
  private
    fNbRule:                 Integer;
    function                 GetNbRule()
                               :Integer;
  public
    property NbRule:         Integer read GetNbRule;
    procedure                Build; override;
  end;
                             // Free test section
  tFreeTestSection           = class( tBiColSection )
  private
    fNbTest:                 Integer;
    procedure                SetFreeHeading;
  public
    property NbTest:         Integer read fNbTest write fNbTest;
    procedure                Build; override;
  end;
                             //
  tWordAnalysisSection       = class( tBiColSection )
  public
    procedure                Build; override;
  end;
                             //
  tSyntaxSection             = class( tBiColSection )
  public
    procedure                Build; override;
  end;

                             //
  tDeclensionSection         = class( tBiColSection )
  public
    procedure                Build; override;
  end;

                             // Single item for 4-column FMA lists
  tFMAListItem               = class( TObject )
  private
    fTAID:                   String;
    fTATerm:                 String;
    fFMAID:                  String;
    fFMATerm:                String;
    fIndent:                 String;
  public
    property TAID:           String read fTAID write fTAID;
    property TATerm:         String read fTATerm write fTATerm;
    property FMAID:          String read fFMAID write fFMAID;
    property FMATerm:        String read fFMATerm write fFMATerm;
    property Indent:         String read fIndent write fIndent;
  end;

                             // Section class definition for FMA 2-column lists
  tFMAListSection            = class( tSection )
  private
    fFMALine:                array of tFMAListItem;
    function                 GetNbFMALine()
                               : Integer;
  public
                             // Number of items
    property NbFMALine:      Integer read GetNbFMALine;
                             // Add a new line to the FMA list section
    procedure                AddFMALine(
                               AnItem: tFMAListItem );
                             // Retrieve a line of FMA list section by position
    function                 GetFMALine(
                               PosItem: Integer )
                               : tFMAListItem;
                             // Reset the lines
    procedure                ResetFMALines;
  end;

                             // Hierarchy section class definition
  tHierarchySection          = class( tBicolSection )
                             private
                             // Ancestors for any Page
    procedure                MakeAscendants(
                               TID: Integer;
                               Level: Integer;
                               IsTax: Boolean;
                               Alter: Boolean;
                               IsPair: Boolean;
                               IsSet: Boolean;
                               IsPSet: Boolean;
                               IsExt: Boolean;
                               var NbAnc: Integer;
                               var AncListe: Array of Integer );
                             // Define the list of children
    procedure                MakePartUnitDescendants(
                               TID: Integer;
                               Level: Integer;
                               TooMuch: Boolean;
                               Recur: Boolean;
                               DivName: String;
                               IsExt: Boolean;
                               var NbDiv: Integer );
                             // Taxonomic children for a Unit Page
    procedure                MakeTaxDescendants(
                               TID: Integer;
                               Level: Integer;
                               IsTax: Boolean;
                               TooMuch: Boolean;
                               Recur: Boolean;
                               IsInf: Boolean;
                               AncLink: Boolean;
                               DivName: String;
                               IsExt: Boolean;
                               var NbDiv: Integer );
                             // Full partonomic children for an Entity Page
    procedure                MakePartFullDescendants(
                               TID: Integer;
                               Level: Integer;
                               TooMuch: Boolean;
                               Recur: Boolean;
                               AncLink: Boolean;
                               DivName: String; var NbDiv: Integer);
                             // Light partonomic children for an Entity Page
    procedure                MakePartLightDescendants(
                               TID: Integer;
                               Level: Integer;
                               TooMuch: Boolean;
                               Recur: Boolean;
                               DivName: String;
                               IsExt: Boolean;
                               var NbDiv: Integer );
  end;

                             // Make a light partonomy section for Entity Page
  tTetraPartSection          = class( tHierarchySection )
  public
    procedure                Build; override;
  end;
                             // Make a light partonomy section for Entity Page
  tTetraTaxSection           = class( tHierarchySection )
  public
    procedure                Build; override;
  end;
                             // Make a taxonomy section for Entity Page
  tTaxoSection               = class( tHierarchySection )
  public
    procedure                Build; override;
  end;
                             // Make a full partonomy section for Entity Page
  tFullPartSection           = class( tHierarchySection )
  public
    procedure                Build; override;
  end;
                             // Make a light partonomy section for Entity Page
  tLightPartSection          = class( tHierarchySection )
  public
    procedure                Build; override;
  end;

                             // Definition of an entry in a validation list
                             // An entry consists of a unit, a list of inqueries
                             // and all actions related to each inquery
  tValidEntry                = class( TObject )
  private
    fUnit:                   String;
    fCode:                   String;
    fFMAID:                  String;
    fTerm:                   String;
    fBubble:                 String;
    fFMALib:                 String;
    fOriLA:                  String;
    fProf:                   String;
    fRaw:                    String;
    fDatI:                   String;
    fSrc:                    String;
    fTit:                    String;
    fDatA:                   String;
    fFire:                   Boolean;
    fAct:                    String;
  public
    property ViewUnit:       String read fUnit write fUnit;
    property ViewCode:       String read fCode write fCode;
    property ViewFMA:        String read fFMAID write fFMAID;
    property Term:           String read fTerm write fTerm;
    property Bubble:         String read fBubble write fBubble;
    property FMALib:         String read fFMALib write fFMALib;
    property OriLA:          String read fOriLA write fOriLA;
    property Profile:        String read fProf write fProf;
    property Formula:        String read fRaw write fRaw;
    property DateInquiry:    String read fDatI write fDatI;
    property Source:         String read fSrc write fSrc;
    property Title:          String read fTit write fTit;
    property DateAction:     String read fDatA write fDatA;
    property ColorFire:      Boolean read fFire write fFire;
    property Action:         String read fAct write fAct;
  end;

                             // List section class definition
  tValidSection              = class( tSection )
    fLine:                   Array of tValidEntry;
    fNote:                   Array of NoteRec;
    function                 GetNbLine()
                               : Integer;
    function                 GetNbNote()
                               : Integer;
  public
                             // Number of items
    property NbLine:         Integer read GetNbLine;
    property NbNote:         Integer read GetNbNote;
                             // Add a new validation entry to the list section
    procedure                AddLine(
                               AnItem: tValidEntry );
                             // Retrieve a line of the list section by position
    function                 GetLine(
                               PosItem: Integer )
                               : TValidEntry;
                             // Reset the lines
    procedure                ResetLines;
                             // Display inquiries
    procedure                DisplayUnitInquiries(
                               Inquiry: TInquiries;
                               var TotInq: Integer;
                               var TotRed: Integer;
                               var TotOra: Integer;
                               var TotGre: Integer;
                               IsGlobal: Boolean = False );
                             // Write a section of a List section
    procedure                WriteSection(
                               Lev: Integer );
                             // Write all lines of a List section
    procedure                WriteLines(
                               Lev: Integer );
  end;
                             // Validation of vocabulary section
  // tValidVocabSection         = class( tValidSection )
  // public
  //   procedure                Build; override;
  // end;
                             // Validation of term section
  tValidTermSection          = class( tValidSection )
  public
    procedure                Build; override;
  end;
                             // Item for 2-language lists
  tListItem                  = class( TObject )
  private
    fUnit:                   String;
    fCode:                   String;
    fFMAID:                  String;
    fNote:                   Boolean;
    fValue:                  String;
    fTypeItem:               tTypeItem;
    fUni1:                   string;
    fOff1:                   string;
    fUni2:                   string;
    fOff2:                   string;
    fUni3:                   string;
    fOff3:                   string;
    fUni4:                   string;
    fOff4:                   string;
    fUni5:                   string;
    fOff5:                   string;
    fBubble:                 string;
    fFMALib:                 string;
    fOriLA:                  string;
    fIndent:                 string;
    fTA98:                   Boolean;
    fTA98Code:               string;
    fTAPlus:                 Boolean;
    fPaire:                  Boolean;
    fProf:                   string;
    fBrL:                    Boolean;
    fBrH:                    Boolean;
    fRaw:                    string;
    fFam:                    tFamily;
  public
    property ViewUnit:       string read fUnit write fUnit;
    property ViewCode:       string read fCode write fCode;
    property ViewFMA:        string read fFMAID write fFMAID;
    property Value:          string read fValue write fValue;
    property ItemType:       tTypeItem read fTypeItem write fTypeItem;
    property NoteFlag:       Boolean read fNote write fNote;
    property Left:           string read fUni1 write fUni1;
    property Right:          string read fOff1 write fOff1;
    property Uni2:           string read fUni2 write fUni2;
    property Off2:           string read fOff2 write fOff2;
    property Uni3:           string read fUni3 write fUni3;
    property Off3:           string read fOff3 write fOff3;
    property Uni4:           string read fUni4 write fUni4;
    property Off4:           string read fOff4 write fOff4;
    property Uni5:           string read fUni5 write fUni5;
    property Off5:           string read fOff5 write fOff5;
    property Bubble:         string read fBubble write fBubble;
    property FMALib:         string read fFMALib write fFMALib;
    property OriLA:          string read fOriLA write fOriLA;
    property Indent:         string read fIndent write fIndent;
    property TA98:           Boolean read fTA98 write fTA98;
    property TA98Code:       string read fTA98Code write fTA98Code;
    property TAPlus:         Boolean read fTAPlus write fTAPlus;
    property IsPaire:        Boolean read fPaire write fPaire;
    property Profile:        string read fProf write fProf;
    property ValidLow:       Boolean read fBrL write fBrL;
    property ValidHigh:      Boolean read fBrH write fBrH;
    property Formula:        string read fRaw write fRaw;
    property Family:         tFamily read fFam write fFam;
  end;

                             // List section class definition
  tListSection               = class( tSection )
  private
    fLine:                   Array of tListItem;
    fComp:                   tListSection;
    fNote:                   Array of NoteRec;
    function                 GetNbLine()
                               : Integer;
    function                 GetNbNote()
                               : Integer;
  public
                             // Number of items
    property NbLine:         Integer read GetNbLine;
                             // Complement section
    property ComplSection:   tListSection read fComp write fComp;
                             // Number of notes
    property NbNote:         Integer read GetNbNote;
                             // Prepare a new line
    procedure                MakeSingleLine(
                               Actual: tEntity;
                               Level: Integer;
                               var CountByLg: tCountLg;
                               IsRef: Boolean = False;
                               IsShort: Boolean = False;
                               IsExcel: Boolean = False );
                             // Prepare a new interface line
    procedure                MakeInterfaceLine(
                               Actual: tEntity;
                               Level: Integer;
                               var CountByLg: tCountLg;
                               IsRef: Boolean = False;
                               IsShort: Boolean = False;
                               IsExcel: Boolean = False );
                             // Prepare a new line in multilanguage format
    procedure                MakeMultiLine(
                               Actual: tEntity;
                               Level: Integer;
                               var CountByLg: tCountLg;
                               IsRef: Boolean = False;
                               IsShort: Boolean = False;
                               IsExcel: Boolean = False );
                             // Prepare a new TA98 line
    procedure                MakeSingle98Line(
                               Actual: tEntity;
                               Level: Integer;
                               Child98: String;
                               var DivName: String;
                               var NbDiv: Integer;
                               var IsOpen: Boolean;
                               IsRef: Boolean = False;
                               IsShort: Boolean = False;
                               IsExcel: Boolean = False );
                             // Add a new line to the list section
    procedure                AddLine( AnItem: tListItem );
                             // Add a new note to the list section
    procedure                AddNote(
                               ANote: NoteRec );
                             // Retrieve a line of the list section by position
    function                 GetLine(
                               PosItem: Integer ): tListItem;
                             // Retrieve a note of the list section by position
    function                 GetNote(
                               PosItem: Integer )
                               : NoteRec;
                             // Reset the lines
    procedure                ResetLines;
                             // Write a section of a List section
    procedure                WriteSection(
                               Lev: Integer );
                             // Write all lines of a List section
    procedure                WriteLines(
                               Lev: Integer );
                             // Write all lines of a Interface List section
    procedure                WriteIntLines(
                               Lev: Integer );
                             // Write all lines of a TA98 list section
    procedure                WriteTA98Lines(
                               Lev: Integer );
                             // Write all notes of a List section
    procedure                WriteNotes(
                               Lev: Integer );
                             // Define the list of partonomic children for a list
    procedure                MakePartListDescendants(
                               TID: Integer;
                               Level: Integer;
                               AType: tTypeListPage;
                               IsStop: Boolean;
                               IsExcel: Boolean;
                               var TotChildren: Integer;
                               var TotPartial: Integer;
                               var CountByLg: tCountLg );
                             // Define the list of TA98 partonomic children
    procedure                MakePart98Descendants(
                               TID: Integer;
                               Level: Integer;
                               AType: tTypeListPage;
                               IsStop: Boolean;
                               IsExcel: Boolean;
                               var TotChildren: Integer;
                               var TotPartial: Integer;
                               var DivName: String;
                               var NbDiv: Integer;
                               var IsOpen: Boolean );
                             // Define the list of taxonomic children for a list
    procedure                MakeTaxListDescendants(
                               TID: Integer;
                               Level: Integer;
                               IsInf: Boolean;
                               AncLink: Boolean;
                               IsExt: Boolean;
                               var TotChildren: Integer );
                             //
    procedure                MakeValidUnivDescendants(
                               TID: Integer;
                               var TotUniv: Integer;
                               var TotMiss: Integer );
                             // Prepare a new universal validation line
    procedure                MakeValidLine(
                               Actual: tEntity;
                               var TotUniv: Integer;
                               var TotMiss: Integer );
  end;
                             // Partonomic list section
  tPartListSection           = class( tListSection )
  public
    procedure                Build; override;
  end;
                             // TA98 Partonomic list section
  tPart98Section             = class( tListSection )
  public
    procedure                Build; override;
  end;
                             // Partonomic list section
  tTaxListSection            = class( tListSection )
  public
    procedure                Build; override;
  end;
                             // Interface list section
  tIntListSection            = class( tListSection )
  public
    procedure                Build; override;
  end;
                             // Universal validation section
  tValidUnivSection            = class( tListSection )
  public
    procedure                Build; override;
  end;
                             // Single item for TA98 lists
  tTA98ListItem              = class( TObject )
  private
    fCode:                   String;
    fValue:                  String;
    fBubble:                 String;
    fIndent:                 String;
    fTetra:                  String;
    fTID:                    String;
    fText:                   String;
    fPlus:                   String;
    fStatus:                 String;
    fError:                  String;
    fErrTxt:                 String;
    fSeg:                    String;
    fSub:                    String;
  public
    property ViewCode:       String read fCode write fCode;
    property Value:          String read fValue write fValue;
    property Bubble:         String read fBubble write fBubble;
    property Indent:         String read fIndent write fIndent;
    property Tetra :         String read fTetra write fTetra;
    property TID :           String read fTID write fTID;
    property Text:           String read fText write fText;
    property Plus:           String read fPlus write fPlus;
    property Status:         String read fStatus write fStatus;
    property Error:          String read fError write fError;
    property ErrTxt:         String read fErrTxt write fErrTxt;
    property Segment:        String read fSeg write fSeg;
    property SubSegment:     String read fSub write fSub;
  end;
                             // Section class definition TA98 lists
  tTA98ListSection           = class( tSection )
  private
    fLine:                   array of tTA98ListItem;
    fRecurs:                 tModeTA98;
    function                 GetNbLine()
                               : Integer;
  public
                             // Number of items
    property NbLine:         Integer read GetNbLine;
                             //
    property Recurs:         tModeTA98 read fRecurs write fRecurs;
                             // Add a new line to the list section
    procedure                AddTA98Line(
                               AnItem: tTA98ListItem );
                             // Retrieve a line of the list section by position
    function                 GetTA98Line(
                               PosItem: Integer )
                               : tTA98ListItem;
                             // Write all lines of a TA98 List Page
    procedure                WriteLines(
                               Lev: Integer );
                             // Write all notes of a TA98 List Page
    procedure                WriteNotes(
                               Lev: Integer );
                             // Define a TA98 list
    procedure                MakeTA98List(
                               TID: Integer;
                               ModeInit: tModeTA98;
                               Recurs: tModeTA98;
                               Section: string;
                               SubChap: string;
                               Chap: string;
                               var CountTA98: Integer;
                               var CountTAH: Integer;
                               var StoreNote: Array of NoteRec;
                               var TotNote: Integer);
  end;
                             // TA98 navigation section
  tTA98NavSection            = class( tTA98ListSection )
  public
    procedure                Build; override;
  end;
                             // TA98 detail section
  tTA98DetailSection         = class( tTA98ListSection )
  public
    procedure                Build;
                               // var Complement: tListSection );
                               override;
  end;
                             // Class for tag of XML Page
  tTagItem                   = class( TObject )
  private
    fTag:                    string;
    fLevel:                  Integer;
  public
    property Tag:            string read fTag write fTag;
    property Level:          Integer read fLevel write fLevel;
  end;

  // Encode the type of list
  function                   GetTypeList(
                               ListPos: String )
                               : tTypeListPage;
                             // Check than DateL is anterior to DateR
  function                   DateBefore(
                               DateL: String;
                               DateR: String )
                               : Boolean;
implementation

uses
  TAHBrowser, SysUtils, BiProps, Tetra, Classes,
  TAHUtilities, LAProc, Term, FRProc, Definitions, List,
  RUProc, ITProc, ESProc, EnProc, TAHInterface, Comments;

function           tBiColSection.GetNbItem()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbItem
  * Property read method for number of lines in a section *
  Description:
  This procedure retrieves the number of lines in a section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( fItem );
end; // _______________________________________________________________GetNbItem

procedure          tBiColSection.AddItem(
  AnItem:          tBicolItem );
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddItem
  * Add an item to a section *
  Description:
  This procedure increase by one unit the size of the area of items, and add
  the given item in the last position.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Nb:              Integer;
begin
  Nb := Self.NbItem + 1;
  SetLength( Self.fItem, Nb );
  Self.fItem[ Nb - 1 ] := AnItem;
end; // _________________________________________________________________AddItem

function           tBiColSection.GetItem(
  PosItem:         Integer )
  :                tBiColItem;
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetItem
  * Get an item by its position from a section *
  Description:
  This procedure returns the item at the specified position, if the position is
  within the limits of existing positions, nil otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := nil;
  if ( ( PosItem < 0 ) or ( PosItem > Self.NbItem ) ) then
    Exit;
  Result := Self.FItem[ PosItem ];
end; // _________________________________________________________________GetItem

function           tFMAListSection.GetNbFMALine()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbFMALine
  * Property read method for number of FMA lines in an FMA section *
  Description:
  This procedure retrieves the number of FMA lines in a section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fFMALine );
end; // ____________________________________________________________GetNbFMALine

procedure          tFMAListSection.AddFMALine(
  AnItem:          tFMAListItem );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddFMALine
  * Add a FMA line to a FMA List section *
  Description:
  This procedure increase by one unit the size of the area of lines, and add
  the given FMA line in the last position.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Nb:              Integer;
begin
  Nb := Self.NbFMALine + 1;
  SetLength( Self.fFMALine, Nb );
  Self.fFMALine[ Nb - 1 ] := AnItem;
end; // ______________________________________________________________AddFMALine

procedure          tFMAListSection.ResetFMALines;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ResetFMALines
  * Reset all line to a List section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( Self.fFMALine, 0 );
end; // ___________________________________________________________ResetFMALines

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetFMALine
  * Get a FMA line by its position from a FMA List section *
  Description:
  This procedure returns the line at the specified position, if the position is
  within the limits of existing positions, nil otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           tFMAListSection.GetFMALine(
  PosItem:         Integer )
  :                tFMAListItem;
begin
  Result := nil;
  if ( ( PosItem < 0 ) or ( PosItem > Self.NbFMALine - 1 ) ) then
    Exit;
  Result := Self.fFMALine[ PosItem ];
end; // ______________________________________________________________GetFMALine

function           tBiColSection.GetEntityType(
  TID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetEntityType
  * Compute the entity type *
  Description:
  This methods prepares a text describing the entity type.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsGeneric:       Boolean;
  ViewTID:         String;
  MyQualif:        String;
  Main:            tEntity;
begin

  // Initial stuff
  Main := TAH.GetEntityByTID( TID );
  if ( Main <> nil ) then
  begin

    // Search for a generator entity
    IsGeneric := ( ( Main.TetraTip = tp_genPair ) or
                   ( Main.TetraTip = tp_genSet ) or
                   ( Main.TetraTip = tp_setPSet ) or
                   ( Main.TetraTip = tp_genPSet ) );
    IsGeneric := IsGeneric or Main.Generic;

    // Generate text
    ViewTID := TAH.GetLabel( reValGenusUndef + Integer( Main.TypeEntity ),
               False );
    if ( IsGeneric ) then
      MyQualif := TAH.GetLabel( reUnitGeneric, False )
    else
      MyQualif := TAH.GetLabel( reUnitSpecific, False );
    ViewTID := MyQualif + cSpace + ViewTID + cSpace +
               TAH.GetLabel( reEntityEntity, False );
  end;
  Result := ViewTID;
end; // ___________________________________________________________GetEntityType

procedure          tBiColSection.MakeTypeOfEntity(
  TID:             Integer;
  Lang:            tLanguage;
  var Value:       String;
  var Bubble:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTypeOfEntity
  * Retrieve descriptive texts for the type of an entity *
  Description:
  This methods prepares a text describing the entity type for display in a
  section. It determines both the text for display and an
  accompanying bubble with a short explanation on the present type.</P>
  StandardDoc/17.02.21
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Tip:             tTip;
  Main:            tEntity;
begin

  // Initial stuff
  Main := TAH.GetEntityByTID( TID );
  Value := cEmpty;
  Bubble := cEmpty;
  if ( Main <> nil ) then
  begin
    Tip := Main.TetraTip;
    case Tip of
      tp_undef: // 0
        begin
          Value := TAH.GetLabel( reValGenusUndef, False );
          Bubble := TAH.GetBubble( reValGenusUndef, False );
        end;
      tp_single: // 1
        begin
          Value := TAH.GetLabel( reValGenusSingle, False );
          Bubble := TAH.GetBubble( reValGenusSingle, False );
        end;
      tp_genpair: // 2
        begin
          Value := TAH.GetLabel( reValGenusGenpair, False );
          Bubble := TAH.GetBubble( reValGenusGenpair, False );
        end;
      tp_pair: // 3
        begin
          Value := TAH.GetLabel( reValGenusPair, False );
          Bubble := TAH.GetBubble( reValGenusPair, False );
        end;
      tp_leftpair: // 4
        begin
          Value := TAH.GetLabel( reValGenusLpair, False );
          Bubble := TAH.GetBubble( reValGenusLpair, False );
        end;
      tp_rightpair: // 5
        begin
          Value := TAH.GetLabel( reValGenusRpair, False );
          Bubble := TAH.GetBubble( reValGenusRpair, False );
        end;
      tp_genpset: // 6
        begin
          Value := TAH.GetLabel( reValGenusGenps, False );
          Bubble := TAH.GetBubble( reValGenusGenps, False );
        end;
      tp_setpset: // 7
        begin
          Value := TAH.GetLabel( reValGenusSetps, False );
          Bubble := TAH.GetBubble( reValGenusSetps, False );
        end;
      tp_pset: // 8
        begin
          Value := TAH.GetLabel( reValGenusPset, False );
          Bubble := TAH.GetBubble( reValGenusPset, False );
        end;
      tp_leftpset: // 9
        begin
          Value := TAH.GetLabel( reValGenusLps, False );
          Bubble := TAH.GetBubble( reValGenusLps, False );
        end;
      tp_rightpset: // 10
        begin
          Value := TAH.GetLabel( reValGenusRps, False );
          Bubble := TAH.GetBubble( reValGenusRps, False );
        end;
      tp_genset: // 11
        begin
          Value := TAH.GetLabel( reValGenusGenset, False );
          Bubble := TAH.GetBubble( reValGenusGenset, False );
        end;
      tp_set: // 12
        begin
          Value := TAH.GetLabel( reValGenusSet, False );
          Bubble := TAH.GetBubble( reValGenusSet, False );
        end;
      tp_ref: // 13
        begin
          Value := TAH.GetLabel( reValGenusRef, False );
          Bubble := TAH.GetBubble( reValGenusRef, False );
        end;
      tp_del: // 14
        begin
          Value := TAH.GetLabel( reValGenusDel, False );
          Bubble := TAH.GetBubble( reValGenusDel, False );
        end;
      tp_lex: // 15
        begin
          Value := TAH.GetLabel( reValGenusLex, False );
          Bubble := TAH.GetBubble( reValGenusLex, False );
        end;
      tp_tax: // 16
        begin
          Value := TAH.GetLabel( reValGenusTax, False );
          Bubble := TAH.GetBubble( reValGenusTax, False );
        end;
      tp_wait: // 17
        begin
          Value := TAH.GetLabel( reValGenusWait, False );
          Bubble := TAH.GetBubble( reValGenusWait, False );
        end;
      tp_voc: // 18
        begin
          Value := TAH.GetLabel( reValGenusVoc, False );
          Bubble := TAH.GetBubble( reValGenusVoc, False );
        end;
      tp_dup: // 19
        begin
          Value := TAH.GetLabel( reValGenusDup, False );
          Bubble := TAH.GetBubble( reValGenusDup, False );
        end;
      tp_int: // 20
        begin
          Value := TAH.GetLabel( reValGenusInt, False );
          Bubble := TAH.GetBubble( reValGenusInt, False );
        end;
      tp_mset: // 21
        begin
          Value := TAH.GetLabel( reValGenusMset, False );
          Bubble := TAH.GetBubble( reValGenusMset, False );
        end;
      tp_genmset: // 22
        begin
          Value := TAH.GetLabel( reValGenusMset, False );
          Bubble := TAH.GetBubble( reValGenusMset, False );
        end;
    end; // case on all types of entity
  end;
end; // ________________________________________________________MakeTypeOfEntity

procedure          tBiColSection.MakeTypeOfUnit(
  TID:             Integer;
  Lang:            tLanguage;
  var Value:       String;
  var Bubble:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTypeOfUnit
  * Retrieve descriptive texts for the type of a unit *
  Description:
  This methods prepares a text describing the unit type for display in a
  section. It determines both the text for display and an
  accompanying bubble with a short explanation on the present type.</P>
  StandardDoc/17.02.21
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTetra:         tTetrahedron;
  Main:            tEntity;
begin
  Main := TAH.GetEntityByTID( TID );
  Value := cEmpty;
  Bubble := cEmpty;
  if ( Main <> nil ) then
  begin
    MyTetra := TAH.GetTetrahedronByUID( Main.Tetra );
    case MyTetra.TetraType of
      tt_single:
        begin
          Value := TAH.GetLabel( reUnitGenusSingle, False );
          Bubble := TAH.GetBubble( reUnitGenusSingle, False );
        end;
      tt_set:
        begin
          Value := TAH.GetLabel( reUnitGenusSet, False );
          Bubble := TAH.GetBubble( reUnitGenusSet, False );
        end;
      tt_pair:
        begin
          Value := TAH.GetLabel( reUnitGenusPair, False );
          Bubble := TAH.GetBubble( reUnitGenusPair, False );
        end;
      tt_pset:
        begin
          Value := TAH.GetLabel( reUnitGenusPset, False );
          Bubble := TAH.GetBubble( reUnitGenusPset, False );
        end;
      tt_mset:
        begin
          Value := TAH.GetLabel( reUnitGenusMset, False );
          Bubble := TAH.GetBubble( reUnitGenusMset, False );
        end;
      tt_tax:
        begin
          Value := TAH.GetLabel( reUnitGenusTax, False );
          Bubble := TAH.GetBubble( reUnitGenusTax, False );
        end;
      tt_voc:
        begin
          Value := TAH.GetLabel( reUnitGenusVoc, False );
          Bubble := TAH.GetBubble( reUnitGenusVoc, False );
        end;
      tt_int:
        begin
          Value := TAH.GetLabel( reUnitGenusInt, False );
          Bubble := TAH.GetBubble( reUnitGenusInt, False );
        end;
    end; // case on all types of units
  end;
end; // __________________________________________________________MakeTypeOfUnit

function           tBiColSection.GetTetraType(
  TID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTetraType
  * Compute the unit type *
  Description:
  This methods prepares a text describing the unit type. First, the unit to
  which belongs the specified entity is retrieved. Second, the variable for
  unit type is decoded and the describing text of this type is retrieved.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyText:          String;
  MyEntity:        tEntity;
  MyUnit:          tUnit;
begin

  // Initial stuff
  MyText := cEmpty;
  MyEntity := TAH.GetEntityByTID( TID );
  MyUnit := nil;
  if ( MyEntity <> nil ) then
    MyUnit := TAH.GetUnitByPos( MyEntity.Tetra );
  if ( MyUnit <> nil ) then
  begin

    // Generate text for unit type in interface language
    case MyUnit.TypUnit of
      tt_Single: MyText := TAH.GetLabel( reUnitGenusSingle, False );
      tt_Pair:   MyText := TAH.GetLabel( reUnitGenusPair, False );
      tt_Set:    MyText := TAH.GetLabel( reUnitGenusSet, False );
      tt_Pset:   MyText := TAH.GetLabel( reUnitGenusPset, False );
      tt_tax:    MyText := TAH.GetLabel( reUnitGenusTax, False );
      tt_voc:    MyText := TAH.GetLabel( reUnitGenusVoc, False );
      tt_int:    MyText := TAH.GetLabel( reUnitGenusInt, False );
    end; // case on all types of unit
    MyText := MyText + cSpace + TAH.GetLabel( reUnitUnit, False );
  end;
  Result := MyText;
end; // ____________________________________________________________GetTetraType

function           GetTypeList(
  ListPos:         String )
  :                tTypeListPage;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTypeList
  * Get the type of list from a value *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := li_undef;
  if ( ListPos = 'P1' ) then
    Result := li_part1
  else
  if ( ListPos = 'P2' ) then
    Result := li_part2
  else
  if ( ListPos = 'P3' ) then
    Result := li_part3
  else
  if ( ListPos = 'P4' ) then
    Result := li_part4
  else
  if ( ListPos = 'T1' ) then
    Result := li_tax1
  else
  if ( ListPos = 'T2' ) then
    Result := li_tax2
  else
  if ( ListPos = 'T2F' ) then
    Result := li_tax2
  else
  if ( ListPos = 'T3' ) then
    Result := li_tax3
  else
  if ( ListPos = 'T4' ) then
    Result := li_tax4;
end; // _____________________________________________________________GetTypeList

function           DateBefore(
  DateL:           String;
  DateR:           String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DateBefore
  * Check date anteriority: DateL DateBefore DateR *
  Description:
  This function returns True when DateL is anterior to DateR.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  DayL:            Integer;
  MonthL:          Integer;
  YearL:           Integer;
  DayR:            Integer;
  MonthR:          Integer;
  YearR:           Integer;
begin
  Result := False;

  // Decode left date
  Posit := Pos( cPeriod, DateL );
  if ( Posit > 0 ) then
  begin
    DayL := StrToInt( Copy( DateL, 1, Posit - 1 ) );
    DateL := Copy( DateL, Posit + 1, Length( DateL ) );
    Posit := Pos( cPeriod, DateL );
    if ( Posit > 0 ) then
    begin
      MonthL := StrToInt( Copy( DateL, 1, Posit - 1 ) );
      YearL := StrToInt( Copy( DateL, Posit + 1, Length( DateL ) ) );
    end else
      Exit;
  end else
    Exit;

  // Decode Right date
  Posit := Pos( cPeriod, DateR );
  if ( Posit > 0 ) then
  begin
    DayR := StrToInt( Copy( DateR, 1, Posit - 1 ) );
    DateR := Copy( DateR, Posit + 1, Length( DateR ) );
    Posit := Pos( cPeriod, DateR );
    if ( Posit > 0 ) then
    begin
      MonthR := StrToInt( Copy( DateR, 1, Posit - 1 ) );
      YearR := StrToInt( Copy( DateR, Posit + 1, Length( DateR ) ) );
    end else
      Exit;
  end else
    Exit;

  // Compute the result
  Result := ( YearL <= YearR ) and
            ( MonthL <= MonthR ) and
            ( DayL <= DayR );
end; // ______________________________________________________________DateBefore

function           tBiColSection.RetrieveScientificNote(
  MyTID:           Integer;
  UID:             Integer;
  var TotNote:     Integer;
  var StoreNote:   Array of NoteRec )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RetrieveScientificNote
  * Retrieve a scientific note *
  Description:
  Retrieve all notes for a specified unit and select the first scientific
  note.</P>
  Temporarily, the notes are specified by entity; This entity is the generator
  of the unit. In the future they will be specified directly by unit.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indn:            Integer;
  Indm:            Integer;
  AltTID:          Integer;
  NbNote:          Integer;
  MbNote:          Integer;
  IsDup:           Boolean;
  MyNote:          Array of NoteRec;
  MyType:          tNoteType;
  TheNote:         NoteRec;
  Tetra:           tUnit;
begin

  // Retrieve TID as generator of the unit
  // Transitorily, only when unit is present!
  Tetra := TAH.GetUnitByPos( UID );
  if ( Tetra <> nil ) then
  begin
    if ( Tetra.TypUnit in [ tt_single, tt_pair, tt_pset, tt_set ] ) then
      MyTID := Tetra.Generator
    else
      MyTID := Tetra.Main;
  end;

  // Retrieve all notes
  Result := False;
  NbNote := 0;
  SetLength( MyNote, 10 );
  if ( TAH.Notes.GetNotes( MyTID, NbNote, MyNote ) ) then
  begin
    SetLength( MyNote, NbNote );

    // Select all scientific notes
    AltTID := 0;
    for Indn := 0 to NbNote - 1 do
    begin
      MyType := MyNote[ Indn ].Typ;
      if ( MyType = nt_Scientific ) then
      begin

        // Indirect adressing of a note
        TheNote := MyNote[ Indn ];
        IsDup := TheNote.Txt[ 1 ] = '!';
        if ( IsDup ) then
        begin
          AltTID :=
            StrToInt( Copy( TheNote.Txt, 2, Length( TheNote.Txt ) ) );
          SetLength( MyNote, 10 );
          MbNote := 0;
          if ( TAH.Notes.GetNotes( AltTID, MbNote, MyNote ) ) then
          begin
            SetLength( MyNote, MbNote );

            // Select the first scientific note
            for Indm := 0 to MbNote - 1 do
            begin
              MyType := MyNote[ Indm ].Typ;
              if ( MyType = nt_Scientific ) then
              begin
                TheNote := MyNote[ Indm ];
                Break;
              end;
            end; // for
          end;
        end;

        // Store the note
        if ( TheNote.Txt[ 1 ] <> '!' ) then
        begin
          TheNote.TID := UID;
          TheNote.Dup := AltTID;
          if ( ( IsDup ) and ( TheNote.UID <> 0 ) ) then
            TheNote.Dup := TheNote.UID;
          StoreNote[ TotNote ] := TheNote;
          Inc( TotNote );
          Result := True;
        end;
      end;
    end; // for
  end;
end; // __________________________________________________RetrieveScientificNote

procedure          tNavSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tNavSection.Build
  * Make the navigation section *
  Description:
  See tNavListSection.Build for the navigation section of lists.</P>
  This method prepare all links from this page to other related pages. It is
  designed for Entity Pages, Unit Pages and other entity related pages.</P>
  There are different groups of links, mandatory or optional:
  - Unit link to the Unit page
  - Entity links to the constituting Entity pages,
  - Entity-based page links,
  - (Validation page links),
  - (Segmentation page links),
  - Partonomy list pages links,
  - Taxonomy list pages links,
  - (TA98 list pages links),
  - Language switches.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  GenTID:          Integer;
  TA98TID:         Integer;
  HeadShort:       Integer;
  HeadLong:        Integer;
  ATID:            Integer;
  P2:              Integer;
  P3:              Integer;
  P4:              Integer;
  T2:              Integer;
  T3:              Integer;
  T4:              Integer;
  MyGen:           Integer;
  IsExt:           Boolean;
  Found:           Boolean;
  LeftTitle:       String;
  Value:           String;
  Value2:          String;
  MyValue:         String;
  NewValue:        String;
  Bubble:          String;
  EntityPage:      String;
  UniversalPage:   String;
  DefPage:         String;
  TACode8:         String;
  MyType:          String;
  Level:           String;
  Short:           String;
  Full:            String;
  ShortLink:       String;
  FullLink:        String;
  MyList:          String;
  PageTypeString:  String;
  MyID:            String;
  Lang:            String;
  LangDir:         String;
  Main:            tEntity;
  Actual:          tEntity;
  Active:          tEntity;
  Long:            tEntity;
  Gener:           tEntity;
  RefEntity:       tEntity;
  Tetra:           tTetrahedron;
  TetraAlt:        tTetrahedron;
  AnItem:          tBiColItem;
  FourList:        tFourList;
  MyTA98Rec:       TA98Rec;
  MyPageType:      tCategPage;
  AType:           tTypeListPage;
begin

  // 1. Links to entities of the current unit
  // ========================================
  Main := Self.Entity;
  MyGen := Main.TID;
  if ( Main.Generator > 0 ) then
    MyGen := Main.Generator;
  MyPageType := Self.PageType;
  IsExt := MyPageType = ca_Extended;
  LangDir := cLgShort[ TAH.MainLang ];
  if ( TAH.MainLang = lt_Latin ) then
    LangDir := LangDir + cLgShort[ TAH.SubstLang ];
  LangDir := LangDir + cSlash;
  if ( Main <> nil ) then
  begin
    Tetra := TAH.GetTetrahedronByTID( Main.TID );

    // Links to the pages of the unit and its entities
    if ( ( Tetra <> nil ) and
         ( Tetra.TetraType <> tt_int ) and
         ( ( not TAH.IsTaxonomy( Main.TID ) ) or
           ( Tetra.TetraType = tt_tax ) or
           ( Tetra.Genr <> nil ) ) ) then
    begin

      // Link to the Unit Page
      MyValue := 'ERR' + cSpace + Main.InternalTex;
      GenTID := 0;
      case ( Tetra.TetraType ) of
      tt_single, tt_tax, tt_voc, tt_mset:
        begin
          if ( Tetra.Genr <> nil ) then
          begin
            MyValue := Tetra.Genr.GetLibelle( lb_Official, TAH.MainLang,
                       st_undef, True );
            GenTID := Tetra.Genr.Tetra;
          end;
        end;
      tt_set:
        begin
          if ( Tetra.ASet <> nil ) then
          begin
            MyValue := Tetra.ASet.GetLibelle( lb_Official, TAH.MainLang,
                       st_undef, True );
            GenTID := Tetra.ASet.Tetra;
          end;
        end;
      else
        begin
          if ( Tetra.Main <> nil ) then
          begin
            MyValue := Tetra.Main.GetLibelle( lb_Official, TAH.MainLang,
                       st_undef, True );
            GenTID := Tetra.Main.Tetra;
          end;
        end;
      end; // case on unit types
      if ( MyPageType <> ca_Tetra ) then
      begin
        MyValue := AOTAG + cHrefEmpty + cRetroDir2x + cDirUnit +
                   LangDir + cTAH + IntToStr( GenTID ) + cSpace +
                   cUnit + cSpace + cLgShort[ TAH.DisLanguage ] +
                   cPeriod + HtmlExt + cDQuote + cAnr + MyValue + AETAG;
      end;

      // Store the unit line
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reNavigToUnit );
      AnItem.AltLabel := TAH.GetLabel( buNavigToUnit );
      AnItem.Value := MyValue;
      AnItem.Bubble := cEmpty;
      AnItem.PartLink := cEmpty;
      AddItem( AnItem );

      // Display the generic optional set and specific Entity Pages of the unit
      if ( Tetra.Genr <> nil ) then
      begin

        // Prepare the first line: generic entity or single entity
        MyValue := Tetra.Genr.GetLibelle( lb_Official, TAH.MainLang,
                                          st_undef, True );
        if ( ( Main.TID <> Tetra.Genr.TID ) or
             ( MyPageType = ca_Tetra ) ) then
        begin
          MyValue := AOTAG + cHrefEmpty +
                     cRetroDir2x + cDirEntity + LangDir + cTAH +
                     IntToStr( Tetra.Genr.TID ) + cSpace +
                     cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                     cPeriod + HtmlExt + cDQuote + cAnr + MyValue + AETAG;
        end;
        if ( Tetra.TetraType <> tt_tax ) then
          MyType := TAH.GetLabel( reGeneric, False )
        else
          MyType := TAH.GetLabel( reTaxonomic, False );
        MyValue := MyType + cColumn + cSpace + MyValue;

        // Store the first line
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := TAH.GetLabel( reNavigToEntity );
        AnItem.AltLabel := TAH.GetLabel( buNavigToEntity );
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.PartLink := cEmpty;
        AddItem( AnItem );

        // Prepare the second line: optional set entity
        if ( ( Tetra.ASet <> nil ) and ( Tetra.TetraType = tt_pset ) ) then
        begin
          MyValue := Tetra.ASet.GetLibelle( lb_Official, TAH.MainLang,
                     st_undef, True );
          if ( ( Main.TID <> Tetra.ASet.TID ) or
               ( MyPageType = ca_Tetra ) ) then
          begin
            MyValue := AOTAG + cHrefEmpty +
                       cRetroDir2x + cDirEntity + LangDir +
                       cTAH + IntToStr( Tetra.ASet.TID ) + cSpace +
                       cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                       cPeriod + HtmlExt + cDQuote + cAnr + MyValue + AETAG;
          end;
          MyType := TAH.GetLabel( reGenericSet, False );
          MyValue := MyType + cColumn + cSpace + MyValue;

          // Store the second line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := cEmpty;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := MyValue;
          AnItem.Bubble := cEmpty;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );
        end;

        // Prepare the third line: specific entity
        if ( ( Tetra.Main <> nil ) or ( Tetra.Aset <> nil ) ) then
        begin
          if ( Tetra.Main <> nil ) then
          begin
            Value := Tetra.Main.GetLibelle( lb_Official, TAH.MainLang,
                     st_undef, True );
            if ( ( Main.TID <> Tetra.Main.TID ) or
                 ( MyPageType = ca_Tetra ) ) then
            begin
              Value := AOTAG + cHrefEmpty +
                       cRetroDir2x + cDirEntity + LangDir +
                       cTAH + IntToStr( Tetra.Main.TID ) + cSpace +
                       cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                       cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
            end;
          end else
          if ( Tetra.ASet <> nil ) then
          begin
            Value := Tetra.Aset.GetLibelle( lb_Official, TAH.MainLang,
                     st_undef, True );
            if ( ( Main.TID <> Tetra.ASet.TID ) or
                 ( MyPageType = ca_Tetra ) ) then
            begin
              Value := AOTAG + cHrefEmpty +
                       cRetroDir2x + cDirEntity + LangDir +
                       cTAH + IntToStr( Tetra.Aset.TID ) + cSpace +
                       cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                       cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
            end;
          end;
          MyType := TAH.GetLabel( reSpecific, False );
          MyValue := MyType + cColumn + cSpace + Value;

          // Store the third line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := cEmpty;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := MyValue;
          AnItem.Bubble := cEmpty;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );
        end;

        // Display the lateral Entity Pages of the unit
        if ( ( Tetra.ASin <> nil ) and ( Tetra.ADex <> nil ) ) then
        begin

          // Prepare the left member entity
          MyValue := Tetra.ASin.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );
          if ( Main.TID <> Tetra.ASin.TID ) then
          begin
            MyValue := AOTAG + cHrefEmpty +
                       cRetroDir2x + cDirEntity + LangDir +
                       cTAH + IntToStr( Tetra.ASin.TID ) + cSpace +
                       cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                       cPeriod + HtmlExt + cDQuote + cAnr + MyValue + AETAG;
          end;
          MyType := TAH.GetLabel( reLeft, False );
          MyValue := MyType + cColumn + cSpace + MyValue;

          // Store the fourth line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := TAH.GetLabel( reLateralNavig );
          AnItem.AltLabel := TAH.GetLabel( buLateralNavig );
          AnItem.Value := MyValue;
          AnItem.Bubble := cEmpty;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );

          // Prepare the right member entity
          MyValue := Tetra.ADex.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );
          if ( Main.TID <> Tetra.ADex.TID ) then
          begin
            MyValue := AOTAG + cHrefEmpty +
                       cRetroDir2x + cDirEntity + LangDir +
                       cTAH + IntToStr( Tetra.ADex.TID ) + cSpace +
                       cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                       cPeriod + HtmlExt + cDQuote + cAnr + MyValue + AETAG;
          end;
          MyType := TAH.GetLabel( reRight, False );
          MyValue := MyType + cColumn + cSpace + MyValue;

          // Store the fifth line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := cEmpty;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := MyValue;
          AnItem.Bubble := cEmpty;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );
        end;
      end;
    end;

    // 2. Links to other entity-based pages
    // ====================================
    if ( ( MyPageType in [ ca_Entity ] ) and
         ( Tetra.TetraType <> tt_int ) ) then
    begin
      Lang := cLgShort[ TAH.MainLang ];
      if ( TAH.MainLang = lt_Latin ) then
        Lang := cLgShort[ TAH.SubstLang ];
      UniversalPage := TAH.GetLabel( reUniversalPage );
      UniversalPage := AOTAG + cHrefEmpty +
                       cRetroDir2x + cUnivPage + cSlash + Lang + cSlash +
                       cTAH + IntToStr( MyGen ) + cSpace +
                       cUnivPage + cSpace + cLgShort[ TAH.DisLanguage ] +
                       cPeriod + HtmlExt + cDQuote + cAnr +
                       UniversalPage + AETAG;
      DefPage := TAH.GetLabel( reDefinitionPage );
      DefPage := AOTAG + cHrefEmpty +
                 cRetroDir2x + cDefinition + cSlash + Lang + cSlash +
                 cTAH + IntToStr( MyGen ) + cSpace +
                 cDefinition + cSpace + cLgShort[ TAH.DisLanguage ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + DefPage + AETAG;
      Value := UniversalPage + cSpace + DefPage;

      // Store the line
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reEntityOriented );
      AnItem.AltLabel := TAH.GetLabel( buEntityOriented );
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AnItem.PartLink := cEmpty;
      AddItem( AnItem );
    end;

    // 3. Links to segmentation-related pages of current entity
    // ========================================================
    {if ( ( MyPageType in [ ca_Entity ] ) and
         ( Dev ) and
         ( Tetra <> nil ) ) then
    begin
      Bubble := cEmpty;
      ListTetra := TList.Create;
      Head := TAH.GetEntityByTID( Main.Tetra );
      if ( Head <> nil ) then
      begin
        NbTetra := TAH.GetListTetra( Head.Niveau5, ListTetra );
        if ( NbTetra > 0 ) then
        begin
          MyTID := ListTetra[ 0 ];
          Tetra := TAH.GetTetrahedronByTID( MyTID^ );
          if ( Tetra <> nil ) then
          begin
            if ( Tetra.Genr <> nil ) then
            begin
              Value := Tetra.Genr.GetPref( TAH.MainLang );
              Bubble := Tetra.Genr.GetPref( TAH.SubstLang );
              GenTID := Tetra.Genr.TID;
            end else
            begin
              Value := Tetra.Main.GetPref( TAH.MainLang );
              Bubble := Tetra.Main.GetPref( TAH.SubstLang );
              GenTID := Tetra.Main.TID;
            end;
            Value := AOTAG + cHrefEmpty +
                     cRetroDir + cSegmentation + cSpace +
                     cLgShort[ TAH.SubstLang ] + cSlash +
                     cTAH + IntToStr( GenTID ) + cSpace +
                     cSegmentation + cSpace + cLgShort[ TAH.SubstLang ] +
                     cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
            Value := 'S5:' + cSpace + Value;
          end;
        end;
      end;

      // Retrieve the unit at level 4
      if ( Tetra.Main <> nil ) then
      begin
        L4ID := Tetra.Main.Niveau4;
        L4Entity := TAH.GetEntityByTID( L4ID );
        if ( L4Entity  <> nil ) then
        begin
          LeftTitle := cSegmentation;
          MyValue := L4Entity.GetPref( TAH.MainLang );
          Bubble := L4Entity.GetPref( TAH.SubstLang );
          MyValue := AOTAG + cHrefEmpty +
                     cRetroDir + cSegmentation + cSpace +
                     cLgShort[ TAH.SubstLang ] + cSlash +
                     cTAH + IntToStr( Tetra.Main.TID ) + cSpace +
                     'Level4' + cSpace + cLgShort[ TAH.SubstLang ] +
                     cPeriod + HtmlExt + cDQuote + cAnr + MyValue + AETAG;
          MyValue := 'S4:' + cSpace + MyValue;
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ltToSegmentPage[ TAH.DisLang ];
          AnItem.AltLabel := cEmpty;
          AnItem.Value := MyValue + cSpace + Value;
          AnItem.Bubble := Bubble;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );
        end;
      end;
    end;}

    // 4. Links to validation-related pages of current entity
    // ======================================================
    {if ( ( MyPageType in [ ca_Entity ] ) and
         ( Dev ) and
         ( Tetra <> nil ) ) then
    begin
      ListTetra := TList.Create;
      Head := TAH.GetEntityByTID( Main.Tetra );
      if ( Head <> nil ) then
      begin
        Bubble := cEmpty;
        NbTetra := TAH.GetListTetra( Head.Niveau5, ListTetra );
        if ( NbTetra > 0 ) then
        begin
          MyTID := ListTetra[ 0 ];
          Tetra := TAH.GetTetrahedronByTID( MyTID^ );
          if ( Tetra <> nil ) then
          begin
            if ( Tetra.Genr <> nil ) then
            begin
              Value := Tetra.Genr.GetPref( TAH.MainLang );
              Bubble := Tetra.Genr.GetPref( TAH.SubstLang );
              GenTID := Tetra.Genr.TID;
            end else
            begin
              Value := Tetra.Main.GetPref( TAH.MainLang );
              Bubble := Tetra.Main.GetPref( TAH.SubstLang );
              GenTID := Tetra.Main.TID;
            end;
            NewValue := AOTAG + cHrefEmpty +
                        cRetroDir + cValidation + cSpace +
                        cLgShort[ TAH.SubstLang ] + cSlash +
                        cTAH + IntToStr( GenTID ) + cSpace +
                        cValidation + cSpace + cLgShort[ TAH.SubstLang ] +
                        cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
            NewValue := 'V5:' + cSpace + NewValue;

            // Display the link to the Validation Page at level 5
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := ltToValidPage[ TAH.DisLang ];
            AnItem.AltLabel := 'This link reaches the corresponding' +
                               'Validation Page';
            AnItem.Value := NewValue;
            AnItem.Bubble := Bubble;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end;
      end;
    end;}

    // 5. Links to partonomy list pages
    // ================================
    if ( MyPageType in [ ca_Entity,  ca_Tetra ] ) then
    begin
      if ( TAH.GetPartListPosition( Main.TID, FourList ) ) then
      begin
        P2 := FourList[ 2 ];
        P3 := FourList[ 3 ];
        P4 := FourList[ 4 ];

        // Retrieve the vocabulary
        Level := TAH.GetLabel( reLevel );
        Short := TAH.GetLabel( reShort );
        Full := TAH.GetLabel( reFull );
        AType := Self.TypeList;

        // Prepare the links for level 2
        if ( P2 > 0 ) then
        begin
          Actual := TAH.GetEntityByTID( P2 );
          if ( Actual <> nil ) then
          begin
            Value := Actual.GetLibelle( lb_Official, TAH.MainLang,
                                        st_undef, True );
            Value := Level + cSpace + '2' + cColumn + cSpace + Value + cSpace +
                     AOTAG + cHrefEmpty + cRetroDir2x + cPart + cSlash +
                     LangDir + cTAH +
                     IntToStr( P2 ) + cSpace + cTypeListPage[ li_part2 ] +
                     cSpace + cLgShort[ TAH.DisLanguage ] +
                     cPeriod + HtmlExt + cDQuote + cAnr +
                     Short + AETAG;
            Value := Value + cSpace +
                     AOTAG + cHrefEmpty + cRetroDir2x + cPart + cSlash +
                     LangDir + cTAH +
                     IntToStr( P2 ) + cSpace + cTypeListPage[ li_part2f ] +
                     cSpace + cLgShort[ TAH.DisLanguage ] +
                     cPeriod + HtmlExt + cDQuote + cAnr +
                     Full + AETAG;

            // Create and store the first line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := TAH.GetLabel( reToPartonomy );
            AnItem.AltLabel := TAH.GetLabel( buToPartonomy );
            AnItem.Value := Value;
            AnItem.Bubble := cEmpty;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end;

        // Prepare the links for level 3
        if ( P3 > 0 ) then
        begin
          Actual := TAH.GetEntityByTID( P3 );
          if ( Actual <> nil ) then
          begin
            Value := Actual.GetLibelle( lb_Official, TAH.MainLang,
                                        st_undef, True );

            // Check for presence of the level 4
            TetraAlt := TAH.GetTetrahedronByTID( P3 );
            RefEntity := TetraAlt.Main;
            if ( RefEntity = nil ) then
              RefEntity := TetraAlt.Genr;
            MyList := TAH.GetListEntityByP4( P3 );
            if ( ( MyList <> cEmpty ) and ( RefEntity <> nil ) ) then
            begin

                // Consider the short list
                if ( AType <> li_part3 ) then
                begin
                  ShortLink :=
                    AOTAG + cHrefEmpty + cRetroDir2x + cPart + cSlash +
                    LangDir + cTAH +
                    IntToStr( RefEntity.TID ) + cSpace +
                    cTypeListPage[ li_part3 ] + cSpace +
                    cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + Short + AETAG;
                  Value := Value + cSpace + ShortLink;
                end;

                // Consider the full list
                if ( AType <> li_part3f ) then
                begin
                  FullLink :=
                    AOTAG + cHrefEmpty + cRetroDir2x + cPart + cSlash +
                    LangDir + cTAH +
                    IntToStr( RefEntity.TID ) + cSpace +
                    cTypeListPage[ li_part3f ] +
                    cSpace + cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + Full + AETAG;
                  Value := Value + cSpace + FullLink;
                end;
            end else
            begin
              Value := AOTAG + cHrefEmpty + cRetroDir2x + cPart + cSlash +
                       LangDir + cTAH +
                       IntToStr( RefEntity.TID ) + cSpace +
                       cTypeListPage[ li_part3 ] + cSpace +
                       cLgShort[ TAH.DisLanguage ] + cPeriod + HtmlExt +
                       cDQuote + cAnr + Value + AETAG;
            end;
            Value := Level + cSpace + '3' + cColumn + cSpace + Value;

            // Create and store the second line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := cEmpty;
            AnItem.AltLabel := cEmpty;
            if ( P2 = 0 ) then
            begin
              AnItem.SrcLabel := TAH.GetLabel( reToPartonomy );
              AnItem.AltLabel := TAH.GetLabel( buToPartonomy );
            end;
            AnItem.Value := Value;
            AnItem.Bubble := cEmpty;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end;

        // Prepare the links for level 4
        if ( P4 > 0 ) then
        begin
          Actual := TAH.GetEntityByTID( P4 );
          if ( Actual <> nil ) then
          begin
            TetraAlt := TAH.GetTetrahedronByTID( P4 );
            if ( TetraAlt.Main <> nil ) then
            begin
              Value := Actual.GetLibelle( lb_Official, TAH.MainLang,
                                          st_undef, True );
              Value := Level + cSpace + '4' + cColumn + cSpace +
                       AOTAG + cHrefEmpty + cRetroDir2x + cPart + cSlash +
                       LangDir +
                       cTAH + IntToStr( TetraAlt.Main.TID ) + cSpace +
                       cTypeListPage[ li_part4 ] + cSpace +
                       cLgShort[ TAH.DisLanguage ] + cPeriod + HtmlExt +
                       cDQuote + cAnr + Value + AETAG;
            end;

            // Create and store third line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := cEmpty;
            AnItem.AltLabel := cEmpty;
            AnItem.Value := Value;
            AnItem.Bubble := cEmpty;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end;
      end;
    end;

    // 6. Links to taxonomy list pages
    // ===============================
    if ( MyPageType in [ ca_Entity, ca_Tetra ] ) then
    begin
      Gener := Tetra.Genr;
      if ( Gener = nil ) then
        Gener := Tetra.Main;
      if ( TAH.GetTaxListPosition( Gener.TID, FourList ) ) then
      begin
        T2 := FourList[ 2 ];
        T3 := FourList[ 3 ];
        T4 := FourList[ 4 ];

        // Make contribution for taxonomy level 2
        if ( T2 > 0 ) then
        begin
          Actual := TAH.GetEntityByTID( T2 );
          if ( Actual <> nil ) then
          begin
            Value := Actual.GetLibelle( lb_Official, TAH.MainLang,
                                        st_undef, True );
            Value := Level + cSpace + '2' + cColumn + cSpace + Value + cSpace +
                     AOTAG + cHrefEmpty + cRetroDir2x + cTax + cSlash +
                     LangDir + cTAH +
                     IntToStr( T2 ) + cSpace + cTypeListPage[ li_tax2 ] +
                     cSpace + cLgShort[ TAH.DisLanguage ] +
                     cPeriod + HtmlExt + cDQuote + cAnr + Short + AETAG;
            Value := Value + cSpace +
                     AOTAG + cHrefEmpty + cRetroDir2x + cTax + cSlash +
                     LangDir + cTAH +
                     IntToStr( T2 ) + cSpace + cTypeListPage[ li_tax2f ] +
                     cSpace + cLgShort[ TAH.DisLanguage ] +
                     cPeriod + HtmlExt + cDQuote + cAnr + Full + AETAG;

            // Create and store the the first line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := TAH.GetLabel( reToTaxonomy );
            AnItem.AltLabel := TAH.GetLabel( buToTaxonomy );
            AnItem.Value := Value;
            AnItem.Bubble := cEmpty;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end;

        // Make contribution for taxonomy level 3
        if ( T3 > 0 ) then
        begin
          Actual := TAH.GetEntityByTID( T3 );
          if ( Actual <> nil ) then
          begin
            Value := Actual.GetLibelle( lb_Official, TAH.MainLang,
                                        st_undef, True );
            Value := Level + cSpace + '3' + cColumn + cSpace +
                     AOTAG + cHrefEmpty + cRetroDir + cTax +
                     cSpace + LangDir + cTAH +
                     IntToStr( T3 ) + cSpace +
                     cTypeListPage[ li_tax3 ] +
                     cSpace + cLgShort[ TAH.DisLanguage ] +
                     cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;

            // Create and store the the second line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := cEmpty;
            AnItem.AltLabel := cEmpty;
            if ( T2 = 0 ) then
            begin
              AnItem.SrcLabel := TAH.GetLabel( reToTaxonomy );
              AnItem.AltLabel := TAH.GetLabel( buToTaxonomy );
            end;
            AnItem.Value := Value;
            AnItem.Bubble := cEmpty;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end;

        // Make contribution for taxonomy level 4
        if ( T4 > 0 ) then
        begin
          Actual := TAH.GetEntityByTID( T4 );
          if ( Actual <> nil ) then
          begin
            if ( Tetra.TetraType = tt_int ) then
              Value := Actual.GetLibelle( lb_Title, TAH.MainLang,
                                          st_undef, True )
            else
              Value := Actual.GetLibelle( lb_Official, TAH.MainLang,
                                          st_undef, True );
            Value := Level + cSpace + '4' + cColumn + cSpace +
                     AOTAG + cHrefEmpty + cRetroDir + cTax +
                     cSpace + LangDir + cTAH +
                     IntToStr( T4 ) + cSpace +
                     cTypeListPage[ li_tax4 ] +
                     cSpace + cLgShort[ TAH.DisLanguage ] +
                     cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;

            // Create and store the third line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := cEmpty;
            AnItem.AltLabel := cEmpty;
            if ( ( T2 = 0 ) and ( T3= 0 ) ) then
            begin
              AnItem.SrcLabel := TAH.GetLabel( reToTaxonomy );
              AnItem.AltLabel := TAH.GetLabel( buToTaxonomy );
            end;
            AnItem.Value := Value;
            AnItem.Bubble := cEmpty;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end;
      end;
    end;

    // 6. Links to TA98 list pages
    // ===========================
    {if ( MyPageType in [ ca_Entity ] ) then
    begin
      TA98TID := Main.TID;
      if ( Tetra.Genr <> nil ) then
      begin
        TA98TID := Tetra.Genr.TID;
      end;
      if ( TA98TID > 7544 ) then
      begin
        if ( Tetra.Main <> nil ) then
        begin
          TA98TID := Tetra.Main.TID;
        end;
      end;
      if ( TA98TID > 7544 ) then
      begin
        if ( Tetra.ASet <> nil ) then
        begin
          TA98TID := Tetra.Aset.TID;
        end;
      end;
      if ( TA98TID <= 7544 ) then
      begin

        // Search for the head of the short list
        MyTA98Rec := TAH.TA98List.GetTA98( TA98TID );
        HeadShort := MyTA98Rec.List;

        // Prepare the short list term
        Active := TAH.GetEntityByTID( HeadShort );
        NewValue := cEmpty;
        if ( Active <> nil ) then
        begin
          Value := Active.GetLibelle( lb_Official, TAH.MainLang );
          NewValue := 'Short' + cColumn + cSpace +
                      AOTAG +
                        cHrefEmpty + cRetroDir +
                        cTA98 + cSpace + cList + cSpace +
                          cLgShort[ TAH.SubstLang ] + cSlash +
                        cTAH + IntToStr( HeadShort ) + cSpace + cTA98Short +
                          cSpace + cLgShort[ TAH.SubstLang ] +
                        cPeriod + HtmlExt + cDQuote + cAnr +
                        Value +
                      AETAG;
        end;

        // Search for the head of the long list
        TACode8 := Copy( Main.Cod98, 1, 8 );
        if ( TACode8 <> cEmpty ) then
        begin
          ATID := TA98TID;
          repeat
            HeadLong := ATID;
            Dec( ATID );
            MyTA98Rec := TAH.TA98List.GetTA98( ATID );
            ATID := MyTA98Rec.List;
            Found := ATID = 0;
            if ( not Found ) then
            begin
              Long := TAH.GetEntityByTID( ATID );
              if ( Long <> nil ) then
                Found := ( Copy( Long.Cod98, 1, 8 ) <> TACode8 );
            end;
          until Found;

          // Prepare the long list term
          Active := TAH.GetEntityByTID( HeadLong );
          Value := cEmpty;
          if ( Active <> nil ) then
          begin
            Value := Active.GetLibelle( lb_Official, TAH.MainLang );
            NewValue := NewValue + cSpace +
                        'Long' + cColumn + cSpace +
                        AOTAG +
                          cHrefEmpty + cRetroDir +
                          cTA98 + cSpace + cList + cSpace +
                            cLgShort[ TAH.SubstLang ] + cSlash +
                          cTAH + IntToStr( HeadLong ) + cSpace + cTA98Long +
                            cSpace + cLgShort[ TAH.SubstLang ] +
                          cPeriod + HtmlExt + cDQuote + cAnr +
                          Value +
                        AETAG;
          end;

          // Create and store the Partonomy List line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ltTraceTA98[ TAH.DisLang ];
          AnItem.AltLabel := 'These links reach the Trace TA98 Pages';
          AnItem.Value := NewValue;
          AnItem.Bubble := cEmpty;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );
        end;
      end;
    end;}

    // 7. Selection of the language
    // ============================
    // There are 8 combinations of languages:
    // - 4 Latin with a modern language,
    // - 4 modern language with Latin.
    // The current modern languages are English, French, Spanish and Russian.
    // The interface language for any combination is always the modern language.
    // Other combinations are normally not generated.
    begin

      // Initial stuff
      MyID := IntToStr( Main.TID );
      case MyPageType of
        ca_Entity: PageTypeString := cEntity;
        ca_Tetra:
          begin
            PageTypeString := cUnit;
            MyID := IntToStr( Main.Tetra );
          end;
        else PageTypeString := cEmpty;
      end;

      // Build the Latin switches
      Value := cEmpty;
      Bubble := cEmpty;
      NewValue := TAH.GetLabel( reEnglish );
      if ( ( TAH.MainLang <> lt_Latin ) or
           ( TAH.SubstLang <> lt_English ) ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir2x + PageTypeString +
                    cSlash + cLgShort[ lt_Latin ] + cLgShort[ lt_English ] +
                    cSlash + cTAH + MyID + cSpace +
                    PageTypeString + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end else
        Bubble := TAH.GetLabel( buLAEN );
      Value := Value + cSpace + NewValue;
      NewValue := TAH.GetLabel( reFrench );
      if ( ( TAH.MainLang <> lt_Latin ) or
           ( TAH.SubstLang <> lt_French ) ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir2x + PageTypeString +
                    cSlash + cLgShort[ lt_Latin ] + cLgShort[ lt_French ] +
                    cSlash + cTAH + MyID + cSpace +
                    PageTypeString + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end else
        Bubble := TAH.GetLabel( buLAFR );
      Value := Value + cSpace + NewValue;
      NewValue := TAH.GetLabel( reSpanish );
      if ( ( TAH.MainLang <> lt_Latin ) or
           ( TAH.SubstLang <> lt_Spanish ) ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir2x + PageTypeString +
                    cSlash + cLgShort[ lt_Latin ] + cLgShort[ lt_Spanish ] +
                    cSlash + cTAH + MyID + cSpace +
                    PageTypeString + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end else
        Bubble := TAH.GetLabel( buLAES );
      Value := Value + cSpace + NewValue;
      NewValue := TAH.GetLabel( reRussian );
      if ( ( TAH.MainLang <> lt_Latin ) or
           ( TAH.SubstLang <> lt_Russian ) ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir2x + PageTypeString +
                    cSlash + cLgShort[ lt_Latin ] + cLgShort[ lt_Russian ] +
                    cSlash + cTAH + MyID + cSpace +
                    PageTypeString + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end else
        Bubble := TAH.GetLabel( buLARU );
      Value := Value + cSpace + NewValue;

      // Build the modern languages switches
      Value2 := cEmpty;
      NewValue := TAH.GetLabel( reEnglish );
      if ( TAH.MainLang <> lt_English ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir2x + PageTypeString +
                    cSlash + cLgShort[ lt_English ] + cSlash + cTAH +
                    MyID + cSpace +
                    PageTypeString + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end else
        Bubble := TAH.GetLabel( buENLA );
      Value2 := Value2 + cSpace + NewValue;
      NewValue := TAH.GetLabel( reFrench );
      if ( TAH.MainLang <> lt_French ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir2x + PageTypeString +
                    cSlash + cLgShort[ lt_French ] + cSlash + cTAH +
                    MyID + cSpace +
                    PageTypeString + cSpace + cLgShort[ lt_French ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end else
        Bubble := TAH.GetLabel( buFRLA );
      Value2 := Value2 + cSpace + NewValue;
      NewValue := TAH.GetLabel( reSpanish );
      if ( TAH.MainLang <> lt_Spanish ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir2x + PageTypeString +
                    cSlash + cLgShort[ lt_Spanish ] + cSlash + cTAH +
                    MyID + cSpace +
                    PageTypeString + cSpace + cLgShort[ lt_Spanish ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end else
        Bubble := TAH.GetLabel( buESLA );
      Value2 := Value2 + cSpace + NewValue;
      NewValue := TAH.GetLabel( reRussian );
      if ( TAH.MainLang <> lt_Russian ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir2x + PageTypeString +
                    cSlash + cLgShort[ lt_Russian ] + cSlash + cTAH +
                    MyID + cSpace +
                    PageTypeString + cSpace + cLgShort[ lt_Russian ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end else
        Bubble := TAH.GetLabel( buRULA );
      Value2 := Value2 + cSpace + NewValue;

      // Create and store the Latin language selectors
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLatinSel );
      AnItem.AltLabel := TAH.GetLabel( buLatinSel );
      AnItem.Value := Value;
      AnItem.Bubble := Bubble;
      AnItem.PartLink := cEmpty;
      AddItem( AnItem );

      // Create and store the modern language selectors
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLanguageSel );
      AnItem.AltLabel := TAH.GetLabel( buLanguageSel );
      AnItem.Value := Value2;
      AnItem.Bubble := Bubble;
      AnItem.PartLink := cEmpty;
      AddItem( AnItem );
    end;
  end;
end; // _______________________________________________________tNavSection.Build

procedure          tPropSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tPropSection.Build
  * Make the property section *
  Description:
  This method retrieves all the property values of an entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
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
  IsPar:           Boolean;
  IsGtr:           Boolean;
  IsAny:           Boolean;
  Actual:          tEntity;
  Generator:       tEntity;
  AnItem:          tBiColItem;
  Tetra:           tTetrahedron;
  MyUnit:          tUnit;
begin
  Actual := Self.Entity;
  if ( Actual <> nil ) then
  begin

    // First item: type of entity, physical entities only
    Tetra := TAH.GetTetrahedronByTID( Actual.TID );
    MyUnit := TAH.GetUnitByPos( Actual.TID );
    if ( ( ( Tetra <> nil ) ) and
         ( not ( Tetra.TetraType in [ tt_tax, tt_voc, tt_int ] ) ) ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLibTypeEntity );
      AnItem.AltLabel := TAH.GetBubble( reLibTypeEntity );
      AnItem.Value := GetEntityType( Actual.TID );
      AnItem.Bubble := cEmpty;
      AddItem( AnItem );
    end;

    // Second item: type of actual unit, mandatory
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reLibTypeUnit );
    AnItem.AltLabel := TAH.GetBubble( reLibTypeUnit );
    AnItem.Value := GetTetraType( Actual.TID );
    AnItem.Bubble := cEmpty;
    AnItem.PartLink := cEmpty;
    AddItem( AnItem );

    // Get all the flags for properties
    Actual.GetHierarProperties( IsBil, IsMul, IsMat, IsImm, IsNon, IsDim,
                                IsGen, IsSpc, IsPar, IsGtr );
    IsRef := Actual.Reference <> 0;
    IsMal := Actual.Link = pw_MemberM;
    IsFem := Actual.Link = pw_MemberF;
    IsInc := Actual.Inconstant;
    if ( Actual.Generator <> 0 ) then
    begin
      Generator := TAH.GetEntityByTID( Actual.Generator );
      if ( Generator <> nil ) then
        IsInc := IsInc or ( Generator.Inconstant );
    end;
    IsAny := IsBil or IsMul or IsRef or IsMal or IsFem or IsInc or IsMat or
             IsImm or IsNon or IsDim or IsGen or IsSpc or IsPar;

    // Check for presence of this section
    if ( IsAny ) then
    begin

      // Third item : bilaterality property
      {if ( IsBil ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := cBilatImg + cSpace + ltBilaterality[ TAH.DisLang ];
        AnItem.AltLabel := 'Bilaterality means symmetry through the central ' +
                           'saggital plane';
        AnItem.Value := puBilatText[ TAH.DisLang ];
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end; }

      // Fourth item: generator property
      if ( IsGtr ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := cGntorImg + cSpace + TAH.GetLabel( reGenerator );
        AnItem.AltLabel := TAH.GetLabel( buGenerator );
        AnItem.Value := puGeneratorText[ en ];
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Fifth item: specificity
      if ( IsSpc or IsGen ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := cSpeciImg + cSpace + TAH.GetLabel( reSpecificity );
        AnItem.AltLabel := TAH.GetLabel( buSpecificity );
        if ( IsSpc ) then
          AnItem.Value := TAH.GetLabel( reSpecificText )
        else
        if ( IsGen ) then
          AnItem.Value := TAH.GetLabel( reGenericText );
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Seventh item: composite property
      if ( IsMul ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := cMultiImg + cSpace + TAH.GetLabel( reComposition );
        AnItem.AltLabel := TAH.GetLabel( buComposition );
        AnItem.Value := TAH.GetLabel( reIsMultiple );
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Eigth item: pair
      if ( IsPar ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := cPaireImg + cSpace + TAH.GetLabel( reBilaterality );
        AnItem.AltLabel := TAH.GetLabel( buBilaterality );
        AnItem.Value := TAH.GetLabel( reIsSymPair );;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Ninth item: inconstant
      if ( IsInc ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := cIncstImg + cSpace + puIncst[ en ];
        AnItem.AltLabel := cEmpty;
        AnItem.Value := puIncstText[ en ];
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Tenth item: sexual dimorphism
      if ( IsDim ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := cDimorImg + cSpace + puDim[ en ];
        AnItem.AltLabel := cEmpty;
        AnItem.Value := puDimText[ en ];
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Eleventh item: gender
      if ( IsMal or IsFem ) then
      begin
        AnItem := TBiColItem.Create;
        if ( IsMal) then
        begin
          AnItem.SrcLabel := cMSymbImg + cSpace + puMSymb[ en ];
          AnItem.Value := puMSymbText[ en ];
        end else
        if ( IsFem) then
        begin
          AnItem.SrcLabel := cFSymbImg + cSpace + puFSymb[ en ];
          AnItem.Value := puFSymbText[ en ];
        end;
        AnItem.AltLabel := cEmpty;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Twelth item: reference
      if ( IsRef ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := cReferImg + cSpace + puImmat[ en ];
        AnItem.AltLabel := cEmpty;
        AnItem.Value := puImmatText[ en ];
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Thirtenth item: materiality property
      if ( IsMat or IsImm ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := cMaterImg + cSpace + TAH.GetLabel( reMateriality );
        AnItem.AltLabel := TAH.GetLabel( buMateriality );
        if ( IsMat ) then
          AnItem.Value := TAH.GetLabel( reMaterial )
        else
        if ( IsImm ) then
          AnItem.Value := TAH.GetLabel( reImmaterial );
        AnItem.Bubble := cEmpty;
        AnItem.Indent := 'a';
        AnItem.Color := lt_None;
        AddItem( AnItem );
      end;

      // Fiftenth item: dimension property
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reDimension );
      AnItem.AltLabel := TAH.GetLabel( buDimension );
      if ( IsNon ) then
      begin
        AnItem.Value := puNonPhText[ en ];
        AnItem.Bubble := cEmpty;
      end else
      begin
        if ( ( Actual.TypeEntity in
               [ to_mat, to_setmat, to_parmat, to_pstmat ] ) or
             ( ( MyUnit <> nil ) and ( not ( MyUnit.Material in
               [ ma_surf, ma_line, ma_point ] ) ) ) ) then
        begin
          AnItem.Value := TAH.GetLabel( reTridimension );
          AnItem.Bubble := TAH.GetLabel( buTridimension );
        end else
        begin
          AnItem.Value := 'This object is a point, a line or a surface';
          AnItem.Bubble := cEmpty;
        end;
      end;
      AnItem.Indent := 'a';
      AnItem.Color := lt_None;
      AddItem( AnItem );

    end;
  end;
end; // ______________________________________________________TPropSection.Build

procedure          tVocSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tVocSection.Build
  * Make the occurrences section *
  Description:
  This method retrieves all the occurrences of a word.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTID:           Integer;
  Count:           Integer;
  Posit:           Integer;
  IsSub:           Boolean;
  Children:        String;
  Child:           String;
  Actual:          tEntity;
  MyEntity:        tEntity;
  AnItem:          tBiColItem;
  SupList:         tSupList;
begin

  // Initial stuff
  Actual := Self.Entity;
  Count := 0;
  SupList := TSupList.Create;
  IsSub := False;
  if ( Actual <> nil ) then
  begin

    // Check for eligibility of this section
    // Either a vocabulary entity, or the ancestor of a vocabulary entity
    if ( not ( Actual.TetraTip in [ tp_voc, tp_tax ] ) ) then
      Exit;
    Children := Actual.TaxCh;

    while ( Children <> cEmpty ) do
    begin
      Posit := Pos( cSemi, Children );
      if ( Posit > 0 ) then
      begin
        Child := Copy( Children, 1, Posit - 1 );
        Children := Copy( Children, Posit + 1, Length( Children ) );
      end else
      begin
        Child := Children;
        Children := cEmpty;
      end;
      MyTID := StrToInt( Child );
      MyEntity := TAH.GetEntityByTID( MyTID );
      if ( MyEntity <> nil ) then
        IsSub := IsSub or ( MyEntity.TetraTip in [ tp_voc, tp_tax ] );
    end; // while on list of children

    if ( ( Actual.TetraTip = tp_tax ) and ( not IsSub ) ) then
      Exit;

    // Make the current vocabulary level
    MakeVocLevel( Actual.TID, Count, SupList );
  end;

  // Display the supplementary list
  DisplaySupList( Count, SupList );

  // Display number of occurences
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := TAH.GetLabel( reNbOccur );
  AnItem.AltLabel := TAH.GetLabel( buNbOccur );
  AnItem.Value := IntToStr( Count ) + cSpace + 'items';
  AnItem.Bubble := cEmpty;
  AnItem.Indent := cBaseIndent;
  AnItem.Color := TAH.MainLang;
  AddItem( AnItem );
end; // _______________________________________________________TVocSection.Build

procedure          tVocSection.MakeVocLevel(
  TID:             Integer;
  var Count:       Integer;
  var SupList:     tSupList );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeVocLevel
  * Make a single level of the occurences section *
  Description:
  This method retrieves all the occurences of a word.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbOcc:           Integer;
  MyUID:           Integer;
  MyTID:           Integer;
  MyPlus:          Integer;
  MyRef:           Integer;
  Posit:           Integer;
  NbChildren:      Integer;
  Next:            Integer;
  Len:             Integer;
  CurrSeq:         Integer;
  Lower:           Integer;
  NbStr:           Integer;
  NbSup:           Integer;
  First:           Boolean;
  IsSub:           Boolean;
  IsDup:           Boolean;
  MyNoun:          String;
  MyAdjective:     String;
  MyPrefix:        String;
  MyValue:         String;
  MyTerm:          String;
  MyUniv:          String;
  MyBubble:        String;
  MyMatch:         String;
  LastChar:        String;
  Children:        String;
  Positions:       String;
  MyChild:         String;
  FirstChild:      String;
  MyPattern:       String;
  Child:           Array of Integer;
  Sequence:        Array of Integer;
  AnItem:          tBiColItem;
  Actual:          tEntity;
  MyEntity:        tEntity;
  MyWordList:      tWordList;
  MyOccurence:     OccRec;
  MySup:           OccRec;
  MyUnit:          tUnit;
  MyType:          tLibelleType;
begin

// First part: handling of all occurences related to the vocabulary entry
// ======================================================================

  Actual := TAH.GetEntityByTID( TID );
  IsSub := False;
  if ( Actual <> nil ) then
  begin

    // Check for eligibility of this section
    // Either a vocabulary entity, or the father of a vocabulary entity
    if ( not ( Actual.TetraTip in [ tp_voc, tp_tax ] ) ) then
      Exit;
    Children := Actual.TaxCh;
    while ( Children <> cEmpty ) do
    begin
      Posit := Pos( cSemi, Children );
      if ( Posit > 0 ) then
      begin
        FirstChild := Copy( Children, 1, Posit - 1 );
        Children := Copy( Children, Posit + 1, Length( Children ) );
      end else
      begin
        FirstChild := Children;
        Children := cEmpty;
      end;
      MyTID := StrToInt( FirstChild );
      MyEntity := TAH.GetEntityByTID( MyTID );
      if ( MyEntity <> nil ) then
        IsSub := IsSub or ( MyEntity.TetraTip in [ tp_voc, tp_tax ] );
    end; // while on all chidren
    Children := Actual.TaxCh;
    Positions := Actual.TaxPos;

    // Search for the active words
    MyNoun := Actual.GetVocabulary( TAH.MainLang, st_Nou );
    MyAdjective := Actual.GetVocabulary( TAH.MainLang, st_Adj );
    MyPrefix := Actual.GetVocabulary( TAH.MainLang, st_Pre );

    // Display the active vocabulary entity
    if ( ( MyNoun <> cEmpty ) or ( MyAdjective <> cEmpty ) or
         ( MyPrefix <> cEmpty ) ) then
    begin
      MyValue := cOBold + Actual.GetLibelle( lb_Official, TAH.MainLang ) +
                 CEBold;
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reVocabulary ) +
                         cSpace + IntToStr( Actual.TID );
      AnItem.AltLabel := TAH.GetLabel( buVocabulary );
      AnItem.Value := Trim( MyValue );
      AnItem.Indent := cBaseIndent;
      AnItem.Color := TAH.MainLang;
      AddItem( AnItem );

      // Display an eventual reference entity
      MyRef := Actual.Reference;
      MyEntity := TAH.GetEntityByPos( MyRef );
      if ( ( MyEntity <> nil ) and
           ( MyEntity.Generator <> 0 ) and
           ( MyEntity.Generator <> MyRef ) ) then
        MyEntity := TAH.GetEntityByPos( MyEntity.Generator );
      if ( MyEntity <> nil ) then
      begin
        MyValue := MyEntity.GetLibelle( lb_Official, TAH.MainLang );
        AnItem := tBiColItem.Create;
        AnItem.AltLabel := cEmpty; // TAH.GetLabel( buVocabulary );
        AnItem.Value := MyValue;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := TAH.MainLang;

        // Prepare the reference
        AnItem.SrcLabel := 'Reference' + cSpace + IntToStr( MyRef );
        AnItem.SrcLabel := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
                           cLgShort[ TAH.MainLang ] +
                           cSlash + cTAH + IntToStr( MyRef ) + cSpace +
                           cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                           cPeriod + HtmlExt + cDQuote + cAnr +
                           AnItem.SrcLabel + AETAG;
        AddItem( AnItem );
      end;
    end;

    // Search for all occurences of the present unit in universal formulas
    MyWordList := tWordList.Create( Actual.Tetra );
    NbOcc := MyWordList.NbWord - MyWordList.NbPlus;
    if ( NbOcc > 0 ) then
    begin

      // Display by noun
      MakeListByWordType( lx_noun, MyWordList, Count );
      MakeListByWordType( lx_compl, MyWordList, Count );

      // Display by adjective
      MakeListByWordType( lx_adj, MyWordList, Count );

      // Display by prefix
      MakeListByWordType( lx_pref, MyWordList, Count );
    end;

    // Move the supplementary terms to the supplementary list
    if ( not IsSub ) then
    begin
      MyPlus := MyWordList.NbPlus;
      if ( MyPlus > 0 ) then
      begin
        First := True;
        NbSup := SupList.NbSup;
        NbStr := NbSup;

        // Loop on supplementary terms
        for Indx := NbOcc to NbOcc + MyPlus - 1 do
        begin

          // Select the entity
          MyOccurence := MyWordList.Occur[ Indx ];
          MyMatch := MyOccurence.Match[ 3 ];
          if ( ( MyMatch <> 'B' ) and
               ( MyMatch <> 'R' ) and
               ( MyMatch <> 'I' ) ) then
            Continue;
          MyUID := MyOccurence.UID;
          if ( MyUID = 50000 ) then
            Continue;
          MyUnit := TAH.GetUnitByPos( MyUID );
          MyEntity := nil;
          if ( MyUnit <> nil ) then
            MyEntity := TAH.GetEntityByPos( MyUnit.Generator );
          if ( MyEntity = nil ) then
            Continue;

          // Check that this entity is not already in the list
          IsDup := False;
          for Indy := 0 to NbSup - 1 do
          begin
            MySup := SupList.Occur[ Indy ];
            if ( MyUID = MySup.UID ) then
            begin
              IsDup := True;
              Break;
            end;
          end;
          if ( IsDup ) then
            Continue;

          // Store the entity in the supplementary list
          Len := SupList.NbSup;
          if ( NbStr >= Len ) then
            SupList.SetNbSup( Len + 10 );
          SupList.SetSup( NbStr, MyOccurence );
          Inc( NbStr );
        end; // on all existing complementary terms
        SupList.SetNbSup( NbStr );
      end;
    end; // move of supplementary terms

// Second part: handling of taxonomic children of the present vocabulary entry
// ===========================================================================
    // Recursive treatment of vocabulary children of a taxonomic entity
    if ( IsSub ) then
    begin

      // Extraction of children and their position
      Next := -1;
      while ( Children <> cEmpty ) do
      begin

        // Adjust the dimension of the list of children and positions
        Inc( Next );
        Len := Length( Child );
        if ( Len <= Next ) then
        begin
          SetLength( Child, Len + 10 );
          SetLength( Sequence, Len + 10 );
        end;

        // Store the next child and its position
        Posit := Pos( cSemi, Children );
        if ( Posit > 0 ) then
        begin
          Child[ Next ] := StrToInt( Copy( Children, 1, Posit - 1 ) );
          Children := Copy( Children, Posit + 1, Length( Children ) );
          Posit := Pos( cSemi, Positions );
          Sequence[ Next ] := StrToInt( Copy( Positions, 1, Posit - 1 ) );
          Positions := Copy( Positions, Posit + 1, Length( Positions ) );
        end else
        begin
          Child[ Next ] := StrToInt( Children );
          Children := cEmpty;
          Sequence[ Next ] := StrToInt( Positions );
        end;
      end;  // while on list of children

      // Finalize the list of children and positions
      NbChildren := Next + 1;
      SetLength( Child, NbChildren );
      SetLength( Sequence, NbChildren );

      // Loop on all children
      for Indy := 0 to NbChildren - 1 do
      begin

        // Search the next position of child in ascending order
        Next := 0;
        CurrSeq := 10000;
        Lower := 0;
        for Indx := 0 to NbChildren - 1 do
        begin
          if ( Sequence[ Indx ] < CurrSeq ) then
          begin
            Next := Child[ Indx ];
            CurrSeq := Sequence[ Indx ];
            Lower := Indx;
          end;
        end;  // for on all positions
        Sequence[ Lower ] := 10000;

        // Work on the next level by recursive call
        MakeVocLevel( Next, Count, SupList );
      end; // for on all children
    end;
  end;
end; // ____________________________________________________________MakeVocLevel

procedure          tLangSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tLangSection.Build
  * Make any language section *
  Description:
  This method collects all possible terms for a specified language and
  display them. The language is the current language as specified in the
  concerned entity.</P>
  A term status is computed, giving the quality of the term on a 5-level scale.
  The four levels are in order of decreasing regularity: universal, modified,
  regular, protected and irregular.</p>
  The rules governing the status of a term are the followings:
  - universal term, the term and all its expansions are universal, directly
    issued from the relevant universal formulas.
  - modified term, the term is derived from the universal formula and
    inherits its properties except a few semantically minor changes.
  - regular term, the term and all its expansions are universal except at
    least one that is regular, this means specific to the present language.
  - protected term, the term and all its expansions are universal or regular
    except at least one that is protected, this means irregular but managed.
  - irregular term, the term and all its expansion are universal, regular or
    managed except at least one that is irregular; such a term cannot be
    computed in all situations and is then replaced by the universal term.</p>
  This section is a bicolumn section with descriptors on the left and values
  on the right.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbLA:            Integer;
  Count:           Integer;
  IsExpLA:         Boolean;
  IsFirst:         Boolean;
  IsSecond:        Boolean;
  MyCode98:        String;
  MyValue:         String;
  LongTerm:        String;
  UnivTerm:        String;
  BaseTerm:        String;
  MyNou:           String;
  MyAdj:           String;
  MyPre:           String;
  MyInv:           String;
  MyBubble:        String;
  FMACode:         String;
  Actual:          tEntity;
  ALATerm:         tSingle;
  FMATerm:         tSingle;
  AnItem:          tBiColItem;
  IsSourceTerm:    tSynType;
  MyLang:          tLanguage;
begin

  // Initial stuff
  Actual := Self.Entity;
  MyLang := Actual.LgCurrent;
  if ( Actual <> nil ) then
  begin

    // Process all items of a section
    LongTerm := Actual.GetLibelle( lb_Official, MyLang, st_mod );
    UnivTerm := Actual.GetLibelle( lb_Universal, MyLang, st_for );
    NbLA := Actual.NbCurrent;

    // First item: official term
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reMainTerm );
    AnItem.AltLabel := TAH.GetLabel( buMainTerm );
    AnItem.Value := LongTerm;
    AnItem.Bubble := MyBubble;
    AnItem.Indent := cBaseIndent;
    AnItem.Color := MyLang;
    AddItem( AnItem );

    // Status of official term
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reTermStatus );
    AnItem.AltLabel := TAH.GetLabel( buTermStatus );
    IsSourceTerm := st_undef;
    for Indx := 0 to NbLA - 1 do
    begin
      IsSourceTerm := Actual.CurrTerm[ Indx ].Effective;
      if ( IsSourceTerm in cGroupMain ) then
        Break;
    end;
    if ( ( LongTerm <> cEmpty ) and ( LongTerm = UnivTerm ) ) then
    begin
      MyValue := TAH.GetLabel( reStatusUni );
      MyBubble := TAH.GetLabel( buStatusUni );
    end else
    begin
      if ( IsSourceTerm in [ st_her, st_hrm ] ) then
      begin
        MyValue := TAH.GetLabel( reStatusHer );
        MyBubble := TAH.GetLabel( buStatusHer );
      end else
      if ( IsSourceTerm = st_bas ) then
      begin
        MyValue := TAH.GetLabel( reStatusReg );
        MyBubble := TAH.GetLabel( buStatusReg );
      end else
      if ( IsSourceTerm in [ st_mam, st_RAT ] ) then
      begin
        MyValue := TAH.GetLabel( reStatusPro );
        MyBubble := TAH.GetLabel( buStatusPro );
      end else
      if ( IsSourceTerm in [ st_irr, st_irm ] ) then
      begin
        MyValue := TAH.GetLabel( reStatusIrr );
        MyBubble := TAH.GetLabel( buStatusIrr );
      end;
    end;
    AnItem.Value := MyValue;
    AnItem.Bubble := MyBubble;
    AnItem.Indent := cBaseIndent;
    AnItem.Color := MyLang;
    AddItem( AnItem );

    // Second term: universal term (when not selected as official term)
    if ( ( LongTerm <> UnivTerm ) ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reUniversalTerm );
      AnItem.AltLabel := TAH.GetLabel( buUniversalTerm );
      AnItem.Value := UnivTerm;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := MyLang;
      AddItem( AnItem );
    end;

    // Third item: formal term (if different from official term)
    BaseTerm := Actual.GetLibelle( lb_Base, MyLang );
    if ( ( BaseTerm <> UnivTerm ) and
         ( BaseTerm <> LongTerm ) and
         ( BaseTerm <> cEmpty ) ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLibFormalTerm );
      AnItem.AltLabel := TAH.GetBubble( reLibFormalTerm );
      AnItem.Value := BaseTerm;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := MyLang;
      AddItem( AnItem );
    end;

    // Fourth item: first official synonym
    MyValue := Actual.GetLibelle( lb_Synonym, MyLang, st_ofd );
    IsFirst := False;
    IsSecond := False;
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := ltOfficialLA[ en ];
      AnItem.AltLabel := bbOfficialLA[ en ];
      AnItem.Value := MyValue;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := MyLang;
      AddItem( AnItem );
      IsFirst := True;
    end;

    // Fifth item: second official synonym
    if ( IsFirst ) then
    begin
      MyValue := Actual.GetLibelle( lb_Synonym2, MyLang, st_od2 );
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ en ];
        AnItem.AltLabel := bbOfficialLA[ en ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := MyLang;
        AddItem( AnItem );
        IsSecond := True;
      end;
    end;

    // Sixth item: third official synonym
    if ( IsSecond ) then
    begin
      MyValue := Actual.GetLibelle( lb_Synonym3, MyLang, st_od3 );
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ en ];
        AnItem.AltLabel := bbOfficialLA[ en ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := MyLang;
        AddItem( AnItem );
      end;
    end;

    // Seventh item: internal database name
    MyValue := Actual.InternalTex;
    if ( ( MyValue <> cEmpty ) and ( MyLang = lt_Latin ) ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reInternalTerm );
      AnItem.AltLabel := TAH.GetLabel( buInternalTerm );
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := MyLang;
      AddItem( AnItem );
    end;

    // Eighth item: FMA official term (with ID and hyperlink)
    Actual.Query := tSearch.Create( st_FMA );
    if ( MyLang = lt_English ) then
    begin
      Actual.SearchTerm;
      FMATerm := Actual.CurrSingle;
      if ( ( FMATerm <> nil ) and ( Actual.FID > 0 ) ) then
      begin
        AnItem := tBiColItem.Create;
        FMACode := cFMA + cColumn + IntToStr( Actual.FID );
        MyValue := FMATerm.Mandat;
        FMACode := AOTAG + cHrefEmpty + BioPortalUrl +
                   IntToStr( Actual.FID ) + cDQuote + cAnr +
                   FMACode + AETAG;
        MyValue := FMACode + cSpace + MyValue;
        AnItem.Value := MyValue;
        AnItem.SrcLabel := ltFMA[ en ];
        AnItem.AltLabel := bbFMA[ en ];
        AnItem.Indent := cBaseIndent;
        AnItem.Color := MyLang;
        AddItem( AnItem );
      end;
    end;

    // Nineth item: source TA98 term (TA98 online version)
    MyValue := Actual.GetLibelle( lb_Single, MyLang, st_Ori );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := tBiColItem.Create;
      case ( MyLang ) of
        lt_Latin:
        begin
          AnItem.SrcLabel := TAH.GetLabel( reTA98LATerm );
          AnItem.AltLabel := TAH.GetLabel( buTA98LATerm );
        end;
        lt_English:
        begin
          AnItem.SrcLabel := TAH.GetLabel( reTA98ENTerm );
          AnItem.AltLabel := TAH.GetLabel( buTA98ENTerm );
        end;
        lt_French:
        begin
          AnItem.SrcLabel := TAH.GetLabel( reTA98FRTerm );
          AnItem.AltLabel := TAH.GetLabel( buTA98FRTerm );
        end;
        lt_Spanish:
        begin
          AnItem.SrcLabel := TAH.GetLabel( reTA98ESTerm );
          AnItem.AltLabel := TAH.GetLabel( buTA98ESTerm );
        end;
        lt_Russian:
        begin
          AnItem.SrcLabel := TAH.GetLabel( reTA98RUTerm );
          AnItem.AltLabel := TAH.GetLabel( buTA98RUTerm );
        end;
      end;
      MyCode98 := Actual.Cod98;
      if ( MyCode98 <> cEmpty ) then
        MyCode98 := MyCode98 + cSpace;
      AnItem.Value := MyCode98 + MyValue;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := MyLang;
      AddItem( AnItem );
    end;

    // Tenth item: initial source TA98 term (TA98 print version)
    MyValue := Actual.GetLibelle( lb_Single, MyLang, st_Ini );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := ltInitialLA[ en ];
      AnItem.AltLabel := bbInitialLA[ en ];
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := MyLang;
      AddItem( AnItem );
    end;

    // Eleventh item: source TA98 official synonyms
    if ( NbLA > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbLA - 1 do
      begin
        Actual.Query.MyType := st_Alt;
        Actual.Query.SynPos := Count;
        Actual.SearchTerm;
        ALATerm := Actual.CurrSingle;
        if ( ALATerm <> nil ) then
        begin
          Inc( Count );
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ltAlternateLA[ en ];
          AnItem.AltLabel := bbAlternateLA[ en ];
          AnItem.Value := ALATerm.Mandat;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := MyLang;
          AddItem( AnItem );
        end;
      end;  // for
      Actual.Query.SynPos := 0;
    end;

    // Twelweth item: short trivial synonyms
    if ( NbLA > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbLA - 1 do
      begin
        Actual.Query.MyType := st_Syn;
        Actual.Query.SynPos := Count;
        Actual.SearchTerm;
        ALATerm := Actual.CurrSingle;
        if ( ALATerm <> nil ) then
        begin
          Inc( Count );
          IsExpLA := ALATerm.Option <> cEmpty;
          AnItem := tBiColItem.Create;
          if ( Count = 1 ) then
          begin
            AnItem.SrcLabel := TAH.GetLabel( reRelatedTerm );
            AnItem.AltLabel := TAH.GetLabel( buRelatedTerm );
          end;
          AnItem.Value := ALATerm.Mandat;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := MyLang;
          AddItem( AnItem );

          // Thirteenth item: expanded trivial synonyms when present
          if ( IsExpLA ) then
          begin
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := ltExpSynonymLA[ en ];
            AnItem.AltLabel := bbExpSynonymLA[ en ];
            AnItem.Value := ALATerm.Mandat + ALATerm.Option;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := MyLang;
          end;
        end;
      end; // for
      Actual.Query.SynPos := 0;
    end;

    // Fourteenth item: Basle Nomina Anatomica 1916 terms
    Actual.Query.MyType := st_BNA;
    Actual.SearchTerm;
    ALATerm := Actual.CurrSingle;
    if ( ALATerm <> nil ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := ltBasleLA[ en ];
      AnItem.AltLabel := bbBasleLA[ en ];
      AnItem.Value := ALATerm.Libelle;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := MyLang;
      AddItem( AnItem );
    end;

    // Fifteenth item: Vocabulary (vocabulary entity only)
    MyNou := Actual.GetVocabulary( MyLang, st_Nou );
    MyAdj := Actual.GetVocabulary( MyLang, st_Adj );
    MyPre := Actual.GetVocabulary( MyLang, st_Pre );
    MyInv := Actual.GetVocabulary( MyLang, st_Inv );
    if ( ( MyNou <> cEmpty ) or ( MyAdj <> cEmpty ) or
         ( MyPre <> cEmpty ) or ( MyInv <> cEmpty ) ) then
    begin
      MyValue := cEmpty;
      if ( MyNou <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Noun' + cColumn + cSpace + MyNou;
      if ( MyAdj <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Adjective' + cColumn + cSpace + MyAdj;
      if ( MyPre <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Prefix' + cColumn + cSpace + MyPre;
      if ( MyInv <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Invariant' + cColumn + cSpace + MyInv;
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reVocabulary );
      AnItem.AltLabel := TAH.GetLabel( buVocabulary );
      AnItem.Value := Trim( MyValue );
      AnItem.Indent := cBaseIndent;
      AnItem.Color := MyLang;
      AddItem( AnItem );
    end;

    // Sixteenth item: Interface string (interface entity only)
  end;
end; // ______________________________________________________TLangSection.Build

// procedure          TENSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TENSection.Build
  * Make the English language section *
  Description:
  This method collects any possible English terms for display.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{var
  Indx:            Integer;
  NbEN:            Integer;
  Count:           Integer;
  Posit:           Integer;
  IsFirst:         Boolean;
  IsSecond:        Boolean;
  IsAuto:          Boolean;
  IsExp:           Boolean;
  Bubble:          String;
  LinkText:        String;
  MyValue:         String;
  MyCode98:        String;
  ENEquivalent:    String;
  UKText:          String;
  USText:          String;
  Selector:        String;
  MyFMACode:       String;
  // MyTerm:          String;
  LongTerm:        String;
  UnivTerm:        String;
  BaseTerm:        String;
  MyNou:           String;
  MyAdj:           String;
  MyPre:           String;
  MyInv:           String;
  MyText:          String;
  MyBubble:        String;
  Later:           tLink;
  Main:            TEntity;
  Gen:             TEntity;
  BasENTerm:       TSingle;
  MyUniversal:     TSingle;
  ATerm:           TSingle;
  AnItem:          TBiColItem;
  Tetra:           TTetrahedron;
  Query:           TSearch;
begin

  // Initial stuff
  Main := Self.Entity;
  if ( Main <> nil ) then
  begin

    // Define autogenerated terms
    IsAuto :=
      ( Main.Link = pw_MemberL ) or ( Main.Link = pw_MemberR ) or
      ( Main.TypeEntity = to_ParMat ) or ( Main.TypeEntity = to_ParImm ) or
      ( Main.TypeEntity = to_HomMat ) or ( Main.TypeEntity = to_HomImm ) or
      ( Main.Link = pw_MemberF ) or ( Main.Link = pw_MemberM ) or
      ( Main.TypeEntity = to_SetMat ) or ( Main.TypeEntity = to_SetImm ) or
      ( Main.TypeEntity = to_PstMat ) or ( Main.TypeEntity = to_PstImm );

    // Process all items of a section
    Tetra := TAH.GetTetrahedronByTID( Main.TID );
    if ( ( Tetra <> nil ) and ( Tetra.Genr <> nil ) ) then
      NbEN := Tetra.Genr.NbENTerm
    else
      NbEN := Main.NbENTerm;

    // Process all items of a section
    LongTerm := Main.GetLibelle( lb_Official, lt_English );
    UnivTerm := Main.GetLibelle( lb_Universal, lt_English );

    // First item: term issued from universal formula
    if ( UnivTerm <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reUniversalTerm );
      AnItem.AltLabel := TAH.GetLabel( buUniversalTerm );
      AnItem.Value := UnivTerm;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;

    // Second item: official term
    if ( ( LongTerm <> cEmpty ) and ( LongTerm = UnivTerm ) ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reMainTerm );
      AnItem.AltLabel := TAH.GetLabel( buMainTerm );
      AnItem.Value := LongTerm;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;

    // Third item: English base term
    BaseTerm := Main.GetLibelle( lb_Base, lt_English );
    if ( ( BaseTerm <> LongTerm ) and ( BaseTerm <> cEmpty ) ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reFormalTerm );
      AnItem.AltLabel := TAH.GetLabel( buFormalTerm );
      LinkText := cHrefEmpty + cRetroDir + cLatin + cSlash + cTAH +
                  IntToStr( Main.TID ) + cSpace + cLatin + cPeriod +
                  HtmlExt + cDQuote + cAnr;
      AnItem.Value := BaseTerm;
      AnItem.Url := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;

    // Fourth item: first official synonym
    MyValue := Main.GetLibelle( lb_Synonym, lt_English );
    IsSecond := False;
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
      AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
      AnItem.Value := MyValue;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
      IsFirst := True;
    end;

    // Fifth item: second official synonym
    if ( IsFirst ) then
    begin
      MyValue := Main.GetLibelle( lb_Synonym2, lt_English );
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
        AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_English;
        AddItem( AnItem );
        IsSecond := True;
      end;
    end;

    // Sixth item: third official synonym
    if ( IsSecond ) then
    begin
      MyValue := Main.GetLibelle( lb_Synonym3, lt_English );
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
        AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_English;
        AddItem( AnItem );
      end;
    end;

    // xxx item: text item
    MyValue := Main.GetLibelle( lb_Text, lt_English );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Text item';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;

    // yyy item: title item
    MyValue := Main.GetLibelle( lb_Title, lt_English );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Title item';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;

    // Seventh item: source TA98 term
    Query := TSearch.Create( Main, st_Ori, lt_English );
    Query.SearchTerm;
    BasENTerm := Query.Single;
    if ( BasENTerm <> nil ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := ltOriginalEN[ TAH.DisLang ];
      AnItem.AltLabel := bbOriginalEN[ TAH.DisLang ];
      MyCode98 := Main.Cod98;
      if ( MyCode98 <> cEmpty ) then
        MyCode98 := MyCode98 + cSpace;
      AnItem.Value := MyCode98 + BasENTerm.Mandat;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;

    // Eighth item: source TA98 precursor terms (TA98 print version)
    Query.MyType := st_Ini;
    Query.SearchTerm;
    BasENTerm := Query.Single;
    if ( BasENTerm <> nil ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := ltOriginalEN[ TAH.DisLang ];
      AnItem.AltLabel := bbOriginalEN[ TAH.DisLang ];
      AnItem.Value := BasENTerm.Mandat;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;

    // Nineth item: source TA98 official synonyms
    if ( NbEN > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbEN - 1 do
      begin
        Query.MyType := st_Alt;
        Query.SynPos := Count;
        Query.SearchTerm;
        BasENTerm := Query.Single;
        if ( BasENTerm <> nil ) then
        begin
          Inc( Count );
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltAlternateEN[ TAH.DisLang ];
          AnItem.AltLabel := bbAlternateEN[ TAH.DisLang ];
          AnItem.Value := BasENTerm.Mandat;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_English;
          AddItem( AnItem );
        end;
      end;  // for
      Query.SynPos := 0;
    end;

    // Tenth item: FMA official term (with ID and hyperlink)
    Query.MyType := st_FMA;
    Query.SearchTerm;
    BasENTerm := Query.Single;
    if ( ( BasENTerm <> nil ) and ( Main.FID > 0 ) ) then
    begin
      AnItem := TBiColItem.Create;
      MyFMACode := cFMA + cColumn + IntToStr( Main.FID );
      MyValue := BasENTerm.Mandat;
      MyFMACode := AOTAG + cHrefEmpty + BioPortalUrl + IntToStr( Main.FID ) +
                   cDQuote + cAnr + MyFMACode + AETAG;
      MyValue := MyFMACode + cSpace + MyValue;
      AnItem.Value := MyValue;
      AnItem.SrcLabel := ltFMA[ TAH.DisLang ];
      AnItem.AltLabel := bbFMA[ TAH.DisLang ];
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;

    // Eleventh item bis: BNA term
    Query.MyType := st_BNA;
    Query.SearchTerm;
    BasENTerm := Query.Single;
    if ( BasENTerm <> nil ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := ltBasleLA[ TAH.DisLang ];
      AnItem.AltLabel := bbBasleLA[ TAH.DisLang ];
      AnItem.Value := BasENTerm.Mandat;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;}

      // Twelweth item: display term when applicable
      {if ( IsAuto ) then
      begin
        ATerm := Main.GetSingleTerm( st_Dis, lt_English );
        if ( ATerm <> nil ) then
        begin
          MyValue := ATerm.Mandat + ATerm.Option + ATerm.Bracket;
          if ( MyValue <> Preferred ) then
          begin
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltDisplayEN[ TAH.DisLang ];
            AnItem.AltLabel := bbDisplayEN[ TAH.DisLang ];
            AnItem.Value := MyValue;
            Bubble := cEmpty;
            if ( ATerm <> nil ) and ( ATerm.BuildFrom = bd_Auto ) then
              Bubble := 'Build by autogeneration';
            if ( ATerm <> nil ) and ( ATerm.BuildFrom = bd_Stored ) then
              Bubble := 'Build from stored display term';
            AnItem.Bubble := Bubble;
            AnItem.Indent := 'a';
            AnItem.Color := lt_English;
            AddItem( AnItem );
          end;
        end;
      end;

      // Thirtenth item: English stored autogenerated term
      ATerm := Main.GetSingleTerm( st_Bat, lt_English );
      if ( ATerm <> nil ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltAutoBaseEN[ TAH.DisLang ];
        AnItem.AltLabel := bbAutoBaseEN[ TAH.DisLang ];
        AnItem.Value := ATerm.Libelle;
        Bubble := cEmpty;
        if ( ATerm.Update <> cEmpty ) then
          Bubble := 'Stored on' + cSpace + ATerm.Update;
        AnItem.Bubble := Bubble;
        AnItem.Indent := 'a';
        AnItem.Color := lt_English;
        AddItem( AnItem );
      end;

      // Fourtenth item: English stored display term
      ATerm := Main.GetSingleTerm( st_Dit, lt_English );
      if ( ATerm <> nil ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltAutoDisEN[ TAH.DisLang ];
        AnItem.AltLabel := bbAutoDisEN[ TAH.DisLang ];
        AnItem.Value := ATerm.Libelle;
        Bubble := cEmpty;
        if ( ATerm.Update <> cEmpty ) then
          Bubble := 'Stored on' + cSpace + ATerm.Update;
        AnItem.Bubble := Bubble;
        AnItem.Indent := 'a';
        AnItem.Color := lt_English;
        AddItem( AnItem );
      end;}

      // Fiftenth item: short trivial synonyms
      {if ( NbEN > 0 ) then
      begin
        Count := 0;
        for Indx := 0 to NbEN - 1 do
        begin
          Query.MyType := st_Syn;
          Query.SynPos := Count;
          Query.SearchTerm;
          ATerm := Query.Single;
          if ( ATerm <> nil ) then
          begin
            Inc( Count );
            IsExp := ATerm.Option <> cEmpty;
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltSynonymEN[ TAH.DisLang ];
            AnItem.AltLabel := bbSynonymEN[ TAH.DisLang ];
            AnItem.Value := ATerm.Mandat;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_English;
            AddItem( AnItem );

            // Sixtenth item: expanded trivial synonyms when present
            if IsExp then
            begin
              AnItem := TBiColItem.Create;
              AnItem.SrcLabel := ltExpSynonymEN[ TAH.DisLang ];
              AnItem.AltLabel := bbExpSynonymEN[ TAH.DisLang ];
              AnItem.Value := ATerm.Mandat + ATerm.Option;
              AnItem.Indent := cBaseIndent;
              AnItem.Color := lt_English;
              AddItem( AnItem );
            end;
          end;
        end; // for
        Query.SynPos := 0;
      end;

      // Sevententh item: eponyms
      if ( NbEN > 0 ) then
      begin
        Count := 0;
        for Indx := 0 to NbEN - 1 do
        begin
          Query.MyType := st_Epo;
          Query.SynPos := Count;
          Query.SearchTerm;
          ATerm := Query.Single;
          if ( ATerm <> nil ) then
          begin
            Inc( Count );
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltEponymEN[ TAH.DisLang ];
            AnItem.AltLabel := bbEponymEN[ TAH.DisLang ];
            AnItem.Value := ATerm.Mandat;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_English;
            AddItem( AnItem );
          end;
        end; // for
        Query.SynPos := 0;
      end;

      // Eightenth item: Identification of author
      if ( NbEN > 0 ) then
      begin
        Count := 0;
        for Indx := 0 to NbEN - 1 do
        begin
          Query.MyType := st_Nam;
          Query.SynPos := Count;
          Query.SearchTerm;
          ATerm := Query.Single;
          if ( ATerm <> nil ) then
          begin
            Inc( Count );
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltAuthorEN[ TAH.DisLang ];
            AnItem.AltLabel := bbAuthorEN[ TAH.DisLang ];
            if ( Length( ATerm.Source ) > 0 ) then
            begin
              LinkText := cHrefEmpty + WhoNamedItUrl + ATerm.Source +
                          cPeriod + 'html' + cDQuote + cAnr;
              MyValue := AOTAG + LinkText + ATerm.Mandat + AETAG;
            end else
            begin
              MyValue := ATerm.Mandat;
            end;
            AnItem.Value := MyValue;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_English;
            AddItem( AnItem );
          end;
        end; // for
        Query.SynPos := 0;
      end;

      // Ninetenth item: UK/US selector
      Later := pw_Undef;
      Selector := cEmpty;

      // Selector present for entity
      Query.MyType := st_USA;
      Query.SearchTerm;
      ATerm := Query.Single;
      if ( ATerm <> nil ) then
      begin
        Selector := ATerm.Libelle;
      end else

      // Selector on generator entity
      begin
        Gen := TAH.GetEntityByPos( Main.Generator );
        if ( Gen <> nil ) then
        begin
          Query := TSearch.Create( Gen, st_USA, lt_English );
          Query.SearchTerm;
          ATerm := Query.Single;
          if ( ATerm <> nil ) then
            Selector := ATerm.Libelle;
        end;
      end;

      // Selector for members of a pair
      if ( Selector = cEmpty ) then
      begin
        if ( ( Main.Link = pw_MemberL ) or ( Main.Link = pw_MemberR ) or
             ( Main.Link = pw_IMemberL ) or ( Main.Link = pw_IMemberR ) ) then
        begin
          Gen := TAH.GetEntityByPos( Main.TaxAnc );
          if ( Gen <> nil ) then
          begin
            Query := TSearch.Create( Gen, st_USA, lt_English );
            Query.SearchTerm;
            ATerm := Query.Single;
            if ( ATerm <> nil ) then
              Selector := ATerm.Libelle;
          end;
        end else

        // Selector for members of a pset
        if ( ( Main.Link = pw_SMemberL ) or ( Main.Link = pw_SMemberR ) or
             ( Main.Link = pw_TMemberL ) or ( Main.Link = pw_TMemberR ) ) then
        begin
          Gen := TAH.GetEntityByPos( Main.TaxAnc );
          if ( Gen <> nil ) then
          begin
            Gen := TAH.GetEntityByPos( Gen.Generator );
            if ( Gen <> nil ) then
            begin
              Query := TSearch.Create( Gen, st_USA, lt_English );
              Query.SearchTerm;
              ATerm := Query.Single;
              if ( ATerm <> nil ) then
                Selector := ATerm.Libelle;
            end;
          end;
        end;
      end;

      // Compute US English equivalent
      if ( Selector <> cEmpty ) then
      begin
        Posit := Pos( cSlash, Selector );
        if ( Posit > 0 ) then
        begin
          UKText := Copy( Selector, 1, Posit - 1 );
          USText := Copy( Selector, Posit + 1, Length( Selector ) );
          Posit := Pos( UKText, ENEquivalent );
          if ( Posit > 0 ) then
          begin
            ENEquivalent := Copy( ENEquivalent, 1, Posit - 1 ) + USText +
              Copy( ENEquivalent, Posit + Length( UKText ),
              Length( ENEquivalent ) );

            // Display US English equivalent
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := 'US English equivalent';
            AnItem.AltLabel := cEmpty;
            AnItem.Value := ENEquivalent;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_English;
            AddItem( AnItem );
          end;
        end;
      end;

    // Twentyth item: Vocabulary
    MyNou := Main.GetVocabulary( lt_English, st_Nou );
    MyAdj := Main.GetVocabulary( lt_English, st_Adj );
    MyPre := Main.GetVocabulary( lt_English, st_Pre );
    MyInv := Main.GetVocabulary( lt_English, st_Inv );
    if ( ( MyNou <> cEmpty ) or ( MyAdj <> cEmpty ) or
         ( MyPre <> cEmpty ) or ( MyInv <> cEmpty ) ) then
    begin
      MyValue := cEmpty;
      if ( MyNou <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Noun' + cColumn + cSpace + MyNou;
      if ( MyAdj <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Adjective' + cColumn + cSpace + MyAdj;
      if ( MyPre <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Prefix' + cColumn + cSpace + MyPre;
      if ( MyInv <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Invariant' + cColumn + cSpace + MyInv;
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reVocabulary );
      AnItem.AltLabel := TAH.GetLabel( buVocabulary );
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;
  end;
end;}// ________________________________________________________TENSection.Build

//procedure          TFRSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TFRSection.Build
  * Make the French language section *
  Description:
  This method collects any possible French terms for display.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{var
  Indx:            Integer;
  NbFR:            Integer;
  Count:           Integer;
  IsAuto:          Boolean;
  IsExp:           Boolean;
  IsFirst:         Boolean;
  IsSecond:        Boolean;
  Bubble:          String;
  LinkText:        String;
  BaseTerm:        String;
  LongTerm:        String;
  UnivTerm:        String;
  MyValue:         String;
  MyCode98:        String;
  FREquivalent:    String;
  MyNou:           String;
  MyAdj:           String;
  MyPre:           String;
  MyInv:           String;
  MyTerm:          String;
  MyText:          String;
  MyBubble:        String;
  Main:            TEntity;
  BasFRTerm:       TSingle;
  ATerm:           TSingle;
  AnItem:          TBiColItem;
  Tetra:           TTetrahedron;
  Query:           TSearch;
begin

  // Initial stuff
  Main := Self.Entity;
  if ( Main <> nil ) then
  begin

    // Define autogenerated terms
    IsAuto :=
      ( Main.Link = pw_MemberL ) or ( Main.Link = pw_MemberR ) or
      ( Main.TypeEntity = to_ParMat ) or ( Main.TypeEntity = to_ParImm ) or
      ( Main.TypeEntity = to_HomMat ) or ( Main.TypeEntity = to_HomImm ) or
      ( Main.Link = pw_MemberF ) or ( Main.Link = pw_MemberM ) or
      ( Main.TypeEntity = to_SetMat ) or ( Main.TypeEntity = to_SetImm ) or
      ( Main.TypeEntity = to_PstMat ) or ( Main.TypeEntity = to_PstImm );

    // Process all items of a section
    Tetra := TAH.GetTetrahedronByTID( Main.TID );
    if ( ( Tetra <> nil ) and ( Tetra.Genr <> nil ) ) then
      NbFR := Tetra.Genr.NbFRTerm
    else
      NbFR := Main.NbFRTerm;

    // Process all items of a section
    LongTerm := Main.GetLibelle( lb_Official, lt_French );
    UnivTerm := Main.GetLibelle( lb_Universal, lt_French );

    // First item: term issued from universal formula
    if ( UnivTerm <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reUniversalTerm );
      AnItem.AltLabel := TAH.GetLabel( buUniversalTerm );
      AnItem.Value := UnivTerm;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_French;
      AddItem( AnItem );
    end else

    // Universal term failure
    begin
      if ( Main.IsFormula ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := TAH.GetLabel( reSpecificTerm );
        AnItem.AltLabel := TAH.GetLabel( buSpecificTerm );
        AnItem.Value := '(missing term)';
        AnItem.Bubble := 'A universal formula does exist, but generation ' +
                         'of a term in the present language has failed.';
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_French;
        AddItem( AnItem );
      end;
    end;

    // Second item: official term
    MyTerm := LongTerm;
    if ( ( LongTerm <> cEmpty ) and ( LongTerm = UnivTerm ) ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reSpecificTerm );
      AnItem.AltLabel := TAH.GetLabel( buSpecificTerm );
      AnItem.Value := MyTerm;
      AnItem.Bubble := TAH.GetLabel( buAsUniversal );
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_French;
      AddItem( AnItem );
    end;

    // Third item: base term
    BaseTerm := Main.GetLibelle( lb_Base, lt_French );
    if ( ( BaseTerm <> LongTerm ) and ( BaseTerm <> cEmpty ) ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reFormalTerm );
      AnItem.AltLabel := TAH.GetLabel( buFormalTerm );
      LinkText := cHrefEmpty + cRetroDir + cLatin + cSlash + cTAH +
                  IntToStr( Main.TID ) + cSpace + cLatin + cPeriod +
                  HtmlExt + cDQuote + cAnr;
      AnItem.Value := BaseTerm;
      AnItem.Url := cEmpty;
      Bubble := cEmpty;
      AnItem.Bubble := Bubble;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_French;
      AddItem( AnItem );
    end;

    // Fourth item: first official synonym
    MyValue := Main.GetLibelle( lb_Synonym, lt_French );
    IsFirst := False;
    IsSecond := False;
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
      AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
      AnItem.Value := MyValue;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_French;
      AddItem( AnItem );
      IsFirst := True;
    end;

    // Fifth item: second official synonym
    if ( IsFirst ) then
    begin
      MyValue := Main.GetLibelle( lb_Synonym2, lt_French );
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
        AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_French;
        AddItem( AnItem );
        IsSecond := True;
      end;
    end;

    // Sixth item: third official synonym
    if ( IsSecond ) then
    begin
      MyValue := Main.GetLibelle( lb_Synonym3, lt_French );
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
        AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_French;
        AddItem( AnItem );
      end;
    end;

    // xxx item: text item
    MyValue := Main.GetLibelle( lb_Text, lt_French );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Text item';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;

    // yyy item: title item
    MyValue := Main.GetLibelle( lb_Title, lt_French );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Title item';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;

    // Seventh item: source TA98 term
    Query := TSearch.Create( Main, st_Ori, lt_French );
    Query.SearchTerm;
    BasFRTerm := Query.Single;
    if ( BasFRTerm <> nil ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := ltOriginalFR[ TAH.DisLang ];
      AnItem.AltLabel := bbOriginalFR[ TAH.DisLang ];
      MyCode98 := Main.Cod98;
      if ( MyCode98 <> cEmpty ) then
        MyCode98 := MyCode98 + cSpace;
      AnItem.Value := MyCode98 + BasFRTerm.Mandat;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_French;
      AddItem( AnItem );
    end;

    // Eighth item: source TA98 official synonyms
    if ( NbFR > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbFR - 1 do
      begin
        Query.MyType := st_Alt;
        Query.SynPos := Count;
        Query.SearchTerm;
        BasFRTerm := Query.Single;
        if ( BasFRTerm <> nil ) then
        begin
          Inc( Count );
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltAlternateEN[ TAH.DisLang ];
          AnItem.AltLabel := bbAlternateEN[ TAH.DisLang ];
          AnItem.Value := BasFRTerm.Mandat;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_French;
          AddItem( AnItem );
        end;
      end;  // for
      Query.SynPos := 0;
    end; }

    // Sixth item: display synonym when applicable
    {if ( IsAuto ) then
    begin
      ATerm := Main.GetSingleTerm( st_Dis, lt_French );
      if ( ATerm <> nil ) then
      begin
        MyValue := ATerm.Mandat + ATerm.Option + ATerm.Bracket;
        if ( MyValue <> Preferred ) then
        begin
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltDisplayFR[ TAH.DisLang ];
          AnItem.AltLabel := bbDisplayFR[ TAH.DisLang ];
          AnItem.Value := MyValue;
          Bubble := cEmpty;
          if ( ATerm <> nil ) and ( ATerm.BuildFrom = bd_Auto ) then
            Bubble := 'Build by autogeneration';
          if ( ATerm <> nil ) and ( ATerm.BuildFrom = bd_Stored ) then
            Bubble := 'Build from stored display term';
          AnItem.Bubble := Bubble;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_French;
          AddItem( AnItem );
        end;
      end;
    end;}

    // Nineth item: short trivial synonyms
    {if ( NbFR > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbFR - 1 do
      begin
        Query.MyType := st_Syn;
        Query.SynPos := Count;
        Query.SearchTerm;
        ATerm := Query.Single;
        if ( ATerm <> nil ) then
        begin
          Inc( Count );
          IsExp := ATerm.Option <> cEmpty;
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltSynonymFR[ TAH.DisLang ];
          AnItem.AltLabel := bbSynonymFR[ TAH.DisLang ];
          if ( IsExp ) then
            AnItem.Value := ATerm.Mandat + '<I>' + ATerm.Option + '</I>'
          else
            AnItem.Value := ATerm.Mandat;
          AnItem.Bubble := cEmpty;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_French;
          AddItem( AnItem );
        end;
      end; // for
      query.SynPos := 0;
    end;

    // Eleventh item: eponyms
    if ( NbFR > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbFR - 1 do
      begin
        Query.MyType := st_Epo;
        Query.SynPos := Count;
        Query.SearchTerm;
        ATerm := Query.Single;
        if ( ATerm <> nil ) then
        begin
          Inc( Count );
          IsExp := ATerm.Option <> cEmpty;
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltEponymFR[ TAH.DisLang ];
          AnItem.AltLabel := bbEponymFR[ TAH.DisLang ];
          AnItem.Value := ATerm.Mandat;
          AnItem.Bubble := cEmpty;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_French;
          AddItem( AnItem );
        end;
      end; // for
      Query.SynPos := 0;
    end;

    // Twentyfirst item: Vocabulary
    MyNou := Main.GetVocabulary( lt_French, st_Nou );
    MyAdj := Main.GetVocabulary( lt_French, st_Adj );
    MyPre := Main.GetVocabulary( lt_French, st_Pre );
    MyInv := Main.GetVocabulary( lt_French, st_Inv );
    if ( ( MyNou <> cEmpty ) or ( MyAdj <> cEmpty ) or
         ( MyPre <> cEmpty ) or ( MyInv <> cEmpty ) ) then
    begin
      MyValue := cEmpty;
      if ( MyNou <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Noun' + cColumn + cSpace + MyNou;
      if ( MyAdj <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Adjective' + cColumn + cSpace + MyAdj;
      if ( MyPre <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Prefix' + cColumn + cSpace + MyPre;
      if ( MyInv <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Invariant' + cColumn + cSpace + MyInv;
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reVocabulary );
      AnItem.AltLabel := TAH.GetLabel( buVocabulary );
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_French;
      AddItem( AnItem );
    end;
  end;
end;}// ________________________________________________________TFRSection.Build

// procedure          TSPSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TSPSection.Build
  * Make the Spanish language section *
  Description:
  This method collects any possible Spanish term for display. There are 11
  possible items.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{const
  DisplayColor:    TLanguage = lt_Italian;
var
  Indx:            Integer;
  NbSP:            Integer;
  Count:           Integer;
  IsAuto:          Boolean;
  IsExp:           Boolean;
  IsFirst:         Boolean;
  IsSecond:        Boolean;
  Bubble:          String;
  LinkText:        String;
  UnivTerm:        String;
  LongTerm:        String;
  BaseTerm:        String;
  MyValue:         String;
  MyCode98:        String;
  SPEquivalent:    String;
  MyNou:           String;
  MyAdj:           String;
  MyPre:           String;
  MyInv:           String;
  MyTerm:          String;
  MyBubble:        String;
  Main:            TEntity;
  BasSPTerm:       TSingle;
  ATerm:           TSingle;
  AnItem:          TBiColItem;
  Tetra:           TTetrahedron;
  Query:           TSearch;
begin

  // Initial stuff
  Main := Self.Entity;
  if ( Main <> nil ) then
  begin

    // Define autogenerated terms
    IsAuto :=
      ( Main.Link = pw_MemberL ) or ( Main.Link = pw_MemberR ) or
      ( Main.TypeEntity = to_ParMat ) or ( Main.TypeEntity = to_ParImm ) or
      ( Main.TypeEntity = to_HomMat ) or ( Main.TypeEntity = to_HomImm ) or
      ( Main.Link = pw_MemberF ) or ( Main.Link = pw_MemberM ) or
      ( Main.TypeEntity = to_SetMat ) or ( Main.TypeEntity = to_SetImm ) or
      ( Main.TypeEntity = to_PstMat ) or ( Main.TypeEntity = to_PstImm );

    // Process all items of a section
    Tetra := TAH.GetTetrahedronByTID( Main.TID );
    if ( ( Tetra <> nil ) and ( Tetra.Genr <> nil ) ) then
      NbSP := Tetra.Genr.NbSPTerm
    else
      NbSP := Main.NbSPTerm;

    // Process all items of a section
    LongTerm := Main.GetLibelle( lb_Official, lt_Spanish );
    UnivTerm := Main.GetLibelle( lb_Universal, lt_Spanish );

    // First item: term issued from universal formula
    if ( UnivTerm <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reUniversalTerm );
      AnItem.AltLabel := TAH.GetLabel( buUniversalTerm );
      AnItem.Value := UnivTerm;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Spanish;
      AddItem( AnItem );
    end;

    // Second item: official term
    MyTerm := LongTerm;
    if ( ( LongTerm <> cEmpty ) and ( LongTerm = UnivTerm ) ) then
    begin
      LinkText := cHrefEmpty + cRetroDir + cLatin + cSlash + cTAH +
                  IntToStr( Main.TID ) + cSpace + cLatin + cPeriod +
                  HtmlExt + cDQuote + ;
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reSpecificTerm );
      AnItem.AltLabel := TAH.GetLabel( buSpecificTerm );
      AnItem.Value := MyTerm;
      AnItem.Bubble := TAH.GetLabel( buAsUniversal );
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Spanish;
      AddItem( AnItem );
    end;

    // Third item: formal term
    BaseTerm := Main.GetLibelle( lb_Base, lt_Spanish );
    if ( ( BaseTerm <> LongTerm ) and ( BaseTerm <> cEmpty ) ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reFormalTerm );
      AnItem.AltLabel := TAH.GetLabel( buFormalTerm );
      LinkText := cHrefEmpty + cRetroDir + cLatin + cSlash + cTAH +
                  IntToStr( Main.TID ) + cSpace + cLatin + cPeriod +
                  HtmlExt + cDQuote + cAnr;
      AnItem.Value := BaseTerm;
      AnItem.Url := cEmpty;
      Bubble := cEmpty;
      AnItem.Bubble := Bubble;
      AnItem.Color := lt_Spanish;
      AddItem( AnItem );
    end;

    // Fourth item: first official synonym
    MyValue := Main.GetLibelle( lb_Synonym, lt_Spanish );
    IsFirst := False;
    IsSecond := False;
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
      AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
      AnItem.Value := MyValue;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Spanish;
      AddItem( AnItem );
      IsFirst := True;
    end;

    // Fifth item: second official synonym
    if ( IsFirst ) then
    begin
      MyValue := Main.GetLibelle( lb_Synonym2, lt_Spanish );
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
        AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_Spanish;
        AddItem( AnItem );
        IsSecond := True;
      end;
    end;

    // Sixth item: third official synonym
    if ( IsSecond ) then
    begin
      MyValue := Main.GetLibelle( lb_Synonym3, lt_Spanish );
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
        AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_Spanish;
        AddItem( AnItem );
      end;
    end;

    // xxx item: text item
    MyValue := Main.GetLibelle( lb_Text, lt_Spanish );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Text item';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;

    // yyy item: title item
    MyValue := Main.GetLibelle( lb_Title, lt_Spanish );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Title item';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;

    // Seventh item: source TA98 term
    Query := TSearch.Create( Main, st_Ori, lt_Spanish );
    Query.SearchTerm;
    BasSPTerm := Query.Single;
    if ( BasSPTerm <> nil ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := ltOriginalSP[ TAH.DisLang ];
      AnItem.AltLabel := bbOriginalSP[ TAH.DisLang ];
      MyCode98 := Main.Cod98;
      if ( MyCode98 <> cEmpty ) then
        MyCode98 := MyCode98 + cSpace;
      AnItem.Value := MyCode98 + BasSPTerm.Mandat;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Spanish;
      AddItem( AnItem );
    end;

    // Eighth item: source TA98 official synonyms
    if ( NbSP > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbSP - 1 do
      begin
        Query.MyType := st_Alt;
        Query.SynPos := Count;
        Query.SearchTerm;
        BasSPTerm := Query.Single;
        if ( BasSPTerm <> nil ) then
        begin
          Inc( Count );
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltAlternateEN[ TAH.DisLang ];
          AnItem.AltLabel := bbAlternateEN[ TAH.DisLang ];
          AnItem.Value := BasSPTerm.Mandat;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_Spanish;
          AddItem( AnItem );
        end;
      end;  // for
      Query.SynPos := 0;
    end; }

    // Eighth item: short trivial synonyms
    {if ( NbFR > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbFR - 1 do
      begin
        ATerm := Main.GetSingleTerm( st_Syn, lt_French, Count );
        if ( ATerm <> nil ) then
        begin
          Inc( Count );
          IsExp := ATerm.Option <> cEmpty;
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltSynonymFR[ TAH.DisLang ];
          AnItem.AltLabel := bbSynonymFR[ TAH.DisLang ];
          AnItem.Value := ATerm.Mandat;
          AnItem.Bubble := cEmpty;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_French;
          AddItem( AnItem );

          // Nineth item: expanded trivial synonyms when present
          if IsExp then
          begin
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltExpSynonymFR[ TAH.DisLang ];
            AnItem.AltLabel := bbExpSynonymFR[ TAH.DisLang ];
            AnItem.Value := ATerm.Mandat + ATerm.Option;
            AnItem.Bubble := cEmpty;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_French;
            AddItem( AnItem );
          end;
        end;
      end; // for
    end;

    // Tenth item: eponyms
    if ( NbFR > 0 ) then
    begin
      Count := 0;
      for Indx := 0 to NbFR - 1 do
      begin
        ATerm := Main.GetSingleTerm( st_Epo, lt_French, Count );
        if ( ATerm <> nil ) then
        begin
          Inc( Count );
          IsExp := ATerm.Option <> cEmpty;
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltEponymFR[ TAH.DisLang ];
          AnItem.AltLabel := bbEponymFR[ TAH.DisLang ];
          AnItem.Value := ATerm.Mandat;
          AnItem.Bubble := cEmpty;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_French;
          AddItem( AnItem );
        end;
      end; // for
    end;}

    // Eleventh item: Vocabulary
    {MyNou := Main.GetVocabulary( lt_Spanish, st_Nou );
    MyAdj := Main.GetVocabulary( lt_Spanish, st_Adj );
    MyPre := Main.GetVocabulary( lt_Spanish, st_Pre );
    MyInv := Main.GetVocabulary( lt_Spanish, st_Inv );
    if ( ( MyNou <> cEmpty ) or ( MyAdj <> cEmpty ) or
         ( MyPre <> cEmpty ) or ( MyInv <> cEmpty ) ) then
    begin
      MyValue := cEmpty;
      if ( MyNou <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Noun' + cColumn + cSpace + MyNou;
      if ( MyAdj <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Adjective' + cColumn + cSpace + MyAdj;
      if ( MyPre <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Prefix' + cColumn + cSpace + MyPre;
      if ( MyInv <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Invariant' + cColumn + cSpace + MyInv;
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reVocabulary );
      AnItem.AltLabel := TAH.GetLabel( buVocabulary );
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Spanish;
      AddItem( AnItem );
    end;
  end;
end;}// ________________________________________________________TSPSection.Build

// procedure          TRUSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TRUSection.Build
  * Make the Russian language section *
  Description:
  This method collects any possible Russian terms for display. There are 11
  possible items.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{const
  DisplayColor:    TLanguage = lt_Italian;
var
  Indx:            Integer;
  NbRU:            Integer;
  Count:           Integer;
  GenTID:          Integer;
  IsAuto:          Boolean;
  IsExp:           Boolean;
  IsFirst:         Boolean;
  IsSecond:        Boolean;
  Bubble:          String;
  LinkText:        String;
  LongTerm:        String;
  UnivTerm:        String;
  BaseTerm:        String;
  MyValue:         String;
  MyCode98:        String;
  MyNou:           String;
  MyAdj:           String;
  MyPre:           String;
  MyInv:           String;
  MyTerm:          String;
  MyBubble:        String;
  BasRUTerm:       TSingle;
  ATerm:           TSingle;
  MySingle:        TSingle;
  Main:            TEntity;
  Generator:       TEntity;
  AnItem:          TBiColItem;
  Tetra:           TTetrahedron;
  Query:           TSearch;
begin

  // Initial stuff
  Main := Self.Entity;
  if ( Main <> nil ) then
  begin

    // Define autogenerated terms
    IsAuto :=
      ( Main.Link = pw_MemberL ) or ( Main.Link = pw_MemberR ) or
      ( Main.TypeEntity = to_ParMat ) or ( Main.TypeEntity = to_ParImm ) or
      ( Main.TypeEntity = to_HomMat ) or ( Main.TypeEntity = to_HomImm ) or
      ( Main.Link = pw_MemberF ) or ( Main.Link = pw_MemberM ) or
      ( Main.TypeEntity = to_SetMat ) or ( Main.TypeEntity = to_SetImm ) or
      ( Main.TypeEntity = to_PstMat ) or ( Main.TypeEntity = to_PstImm );

    LongTerm := Main.GetLibelle( lb_Official, lt_Russian );
    UnivTerm := Main.GetLibelle( lb_Universal, lt_Russian );

    // First item: term issued from universal formula
    if ( UnivTerm <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reUniversalTerm );
      AnItem.AltLabel := TAH.GetLabel( buUniversalTerm );
      AnItem.Value := UnivTerm;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end else

    // Universal term failure
    begin
      if ( Main.IsFormula ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := TAH.GetLabel( reUniversalTerm );
        AnItem.AltLabel := TAH.GetLabel( buUniversalTerm );
        AnItem.Value := cRol + TAH.GetLabel( reMissingUniv ) + cRor;
        AnItem.Bubble := TAH.GetLabel( buMissingUniv );
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_English;
        AddItem( AnItem );
      end;
    end;

    // Second item: official term
    MyTerm := LongTerm;
    if ( ( LongTerm <> cEmpty ) and ( LongTerm = UnivTerm ) ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reSpecificTerm );
      AnItem.AltLabel := TAH.GetLabel( buSpecificTerm );
      AnItem.Value := MyTerm;
      AnItem.Bubble := TAH.GetLabel( buAsUniversal );
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;

      // Third item: formal term
      BaseTerm := Main.GetLibelle( lb_Base, lt_Russian );
      if ( ( BaseTerm <> UnivTerm ) and
           ( BaseTerm <> LongTerm ) and
           ( BaseTerm <> cEmpty ) ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := TAH.GetLabel( reFormalTerm );
        AnItem.AltLabel := TAH.GetLabel( buFormalTerm );
        LinkText := cHrefEmpty + cRetroDir + cLatin + cSlash + cTAH +
                    IntToStr( Main.TID ) + cSpace + cLatin + cPeriod +
                    HtmlExt + cDQuote + cAnr;
        AnItem.Value := BaseTerm;
        AnItem.Url := cEmpty;
        Bubble := cEmpty;
        AnItem.Bubble := Bubble;
        AnItem.Color := lt_English;
        AddItem( AnItem );
      end;

      // Fourth item: first official synonym
      MyValue := Main.GetLibelle( lb_Synonym, lt_Russian );
      IsFirst := False;
      IsSecond := False;
      if ( MyValue <> cEmpty ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
        AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
        AnItem.Value := MyValue;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_English;
        AddItem( AnItem );
        IsFirst := True;
      end;

      // Fifth item: second official synonym
      if ( IsFirst ) then
      begin
        MyValue := Main.GetLibelle( lb_Synonym2, lt_Russian );
        if ( MyValue <> cEmpty ) then
        begin
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
          AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
          AnItem.Value := MyValue;
          AnItem.Bubble := cEmpty;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_English;
          AddItem( AnItem );
          IsSecond := True;
        end;
      end;

      // Sixth item: third official synonym
      if ( IsSecond ) then
      begin
        MyValue := Main.GetLibelle( lb_Synonym3, lt_Russian );
        if ( MyValue <> cEmpty ) then
        begin
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := ltOfficialLA[ TAH.DisLang ];
          AnItem.AltLabel := bbOfficialLA[ TAH.DisLang ];
          AnItem.Value := MyValue;
          AnItem.Bubble := cEmpty;
          AnItem.Indent := cBaseIndent;
          AnItem.Color := lt_English;
          AddItem( AnItem );
        end;
      end;

      // Process all items of a section
      Tetra := TAH.GetTetrahedronByTID( Main.TID );
      if ( ( Tetra <> nil ) and ( Tetra.Genr <> nil ) ) then
        NbRU := Tetra.Genr.NbRUTerm
      else
        NbRU := Main.NbRUTerm;  }

      // Fourth item: all official synonyms
      {if ( NbRU > 0 ) then
      begin
        Count := 0;
        for Indx := 0 to NbRU - 1 do
        begin
          Query := TSearch.Create( Main, st_Off, lt_Russian );
          Query.SynPos := Count;
          Query.SearchTerm;
          ATerm := Query.Single;
          if ( ATerm <> nil ) then
          begin
            Inc( Count );
            IsExp := ATerm.Option <> cEmpty;
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltOfficialRU[ TAH.DisLang ];
            AnItem.AltLabel := bbOfficialRU[ TAH.DisLang ];
            if ( IsExp ) then
              AnItem.Value := ATerm.Mandat + ATerm.Option
            else
              AnItem.Value := ATerm.Mandat;
            AnItem.Bubble := cEmpty;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_English;
            AddItem( AnItem );
          end;
        end; // for
      end;}

    // xxx item: text item
    {MyValue := Main.GetLibelle( lb_Text, lt_Russian );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Text item';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;

    // yyy item: title item
    MyValue := Main.GetLibelle( lb_Title, lt_Russian );
    if ( MyValue <> cEmpty ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Title item';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;

      // Sixth item: source TA98 term
      Query := TSearch.Create( Main, st_Ori, lt_Russian );
      Query.SearchTerm;
      BasRUTerm := Query.Single;
      if ( BasRUTerm <> nil ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := ltOriginalRU[ TAH.DisLang ];
        AnItem.AltLabel := bbOriginalRU[ TAH.DisLang ];
        MyCode98 := Main.Cod98;
        if ( MyCode98 <> cEmpty ) then
          MyCode98 := MyCode98 + cSpace;
        AnItem.Value := MyCode98 + BasRUTerm.Mandat;
        AnItem.Indent := cBaseIndent;
        AnItem.Color := lt_English;
        AddItem( AnItem );
      end;

      // Seventh item: source TA98 official synonyms
      if ( NbRU > 0 ) then
      begin
        Count := 0;
        for Indx := 0 to NbRU - 1 do
        begin
          Query := TSearch.Create( Main, st_Alt, lt_Russian );
          Query.SynPos := Count;
          Query.SearchTerm;
          BasRUTerm := Query.Single;
          if ( BasRUTerm <> nil ) then
          begin
            Inc( Count );
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltAlternateEN[ TAH.DisLang ];
            AnItem.AltLabel := bbAlternateEN[ TAH.DisLang ];
            AnItem.Value := BasRUTerm.Mandat;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_English;
            AddItem( AnItem );
          end;
        end; // for
      end; }

      // Eighth item: short trivial synonyms
      {if ( NbFR > 0 ) then
      begin
        Count := 0;
        for Indx := 0 to NbFR - 1 do
        begin
          ATerm := Main.GetSingleTerm( st_Syn, lt_French, Count );
          if ( ATerm <> nil ) then
          begin
            Inc( Count );
            IsExp := ATerm.Option <> cEmpty;
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltSynonymFR[ TAH.DisLang ];
            AnItem.AltLabel := bbSynonymFR[ TAH.DisLang ];
            AnItem.Value := ATerm.Mandat;
            AnItem.Bubble := cEmpty;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_French;
            AddItem( AnItem );

            // Nineth item: expanded trivial synonyms when present
            if IsExp then
            begin
              AnItem := TBiColItem.Create;
              AnItem.SrcLabel := ltExpSynonymFR[ TAH.DisLang ];
              AnItem.AltLabel := bbExpSynonymFR[ TAH.DisLang ];
              AnItem.Value := ATerm.Mandat + ATerm.Option;
              AnItem.Bubble := cEmpty;
              AnItem.Indent := cBaseIndent;
              AnItem.Color := lt_French;
              AddItem( AnItem );
            end;
          end;
        end; // for
      end;

      // Tenth item: eponyms
      if ( NbFR > 0 ) then
      begin
        Count := 0;
        for Indx := 0 to NbFR - 1 do
        begin
          ATerm := Main.GetSingleTerm( st_Epo, lt_French, Count );
          if ( ATerm <> nil ) then
          begin
            Inc( Count );
            IsExp := ATerm.Option <> cEmpty;
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := ltEponymFR[ TAH.DisLang ];
            AnItem.AltLabel := bbEponymFR[ TAH.DisLang ];
            AnItem.Value := ATerm.Mandat;
            AnItem.Bubble := cEmpty;
            AnItem.Indent := cBaseIndent;
            AnItem.Color := lt_French;
            AddItem( AnItem );
          end;
        end; // for
      end;}

    // Eleventh item: Vocabulary
    {MyNou := Main.GetVocabulary( lt_Russian, st_Nou );
    MyAdj := Main.GetVocabulary( lt_Russian, st_Adj );
    MyPre := Main.GetVocabulary( lt_Russian, st_Pre );
    MyInv := Main.GetVocabulary( lt_Russian, st_Inv );
    if ( ( MyNou <> cEmpty ) or ( MyAdj <> cEmpty ) or
         ( MyPre <> cEmpty ) or ( MyInv <> cEmpty ) ) then
    begin
      MyValue := cEmpty;
      if ( MyNou <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Noun' + cColumn + cSpace + MyNou;
      if ( MyAdj <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Adjective' + cColumn + cSpace + MyAdj;
      if ( MyPre <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Prefix' + cColumn + cSpace + MyPre;
      if ( MyInv <> cEmpty ) then
        MyValue := MyValue + cSpace + 'Invariant' + cColumn + cSpace + MyInv;
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reVocabulary );
      AnItem.AltLabel := TAH.GetLabel( buVocabulary );
      AnItem.Value := MyValue;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_English;
      AddItem( AnItem );
    end;
  end;
end;}// ________________________________________________________TRUSection.Build

procedure          TDocumSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TDocumSection.Build
  * Make the documentation section *
   ================================
  Description:
  This method retrieves a possible documentation record and prepares its
  display. The author and date of last update of this documentation record
  is visible in a bubble (development mode only).</P>
  The description text which is displayed is expected to be in HTML format,
  in order to enhance its presentation, but a text only contribution is also
  possible. The description may include URL links to other pages and even to
  external sources.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  Bubble:          String;
  MyDate:          String;
  MyDocum:         DocumRec;
  Actual:          TEntity;
  AnItem:          TBiColItem;
begin

  // Initial stuff
  Actual := Self.Entity;
  if ( Actual <> nil ) then
  begin

    // Check for presence of this section: use unit ID
    if ( TAH.Docums.DocumExist( Actual.Tetra, MyDocum ) ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := cEmpty;
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MakeHyperLinks( MyDocum.Des );
      Bubble := cEmpty;
      if ( Dev ) then
      begin
        MyDate := MyDocum.Dat;
        Posit := Pos( cSpace, MyDate );
        if ( Posit > 0 ) then
          MyDate := Copy( MyDate, 1, Posit - 1 );
        Bubble := 'By' + cSpace + MyDocum.Aut + cSpace + 'on' + cSpace + MyDate;
      end;
      AnItem.Bubble := Bubble;
      AddItem( AnItem );
    end;
  end;
end; // _____________________________________________________TDocumSection.Build

procedure          tNoteSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tNoteSection.Build
  * Make a note section *
  Description:
  This method collects all possible notes for the actual entity and prepares
  their display in the note section.</P>
  Notes are described under the form of an HTML text with intermixed hyperlinks
  to any mentioned anatomical entity leading to its coresponding Entity Page.
  In addition, bold and italics subparts are possible.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbNote:          Integer;
  MbNote:          Integer;
  Refer:           Integer;
  MyNoteID:        Integer;
  Bubble:          String;
  Value:           String;
  MyNote:          Array of NoteRec;
  MyRefNote:       Array of NoteRec;
  AnItem:          tBiColItem;
  Actual:          tEntity;
  MyNoteType:      tNoteType;
  MyPageType:      tCategPage;
begin

  // Check for presence of this section
  if ( TAH.Notes.TotNotes < 9999 ) then
  begin

    // Initial stuff
    Actual := Self.Entity;
    MyPageType := Self.PageType;
    if ( Actual <> nil ) then
    begin

      // Loop on all possible notes
      MyNoteID := Actual.Tetra;
      SetLength( MyNote, 10 );
      NbNote := 0;
      if ( TAH.Notes.GetNotes( MyNoteID, NbNote, MyNote ) ) then
      begin
        SetLength( MyNote, NbNote );
        for Indx := 0 to NbNote - 1 do
        begin
          MyNoteType := MyNote[ Indx ].Typ;
          if ( not ( MyNoteType in
               [ nt_Scientific, nt_Terminology,
                 nt_Taxonomy, nt_Implement ] ) ) then
            Continue;
          if ( not ( ( ( MyPageType = ca_Tetra ) and
                       ( MyNoteType = nt_Scientific ) ) or
                     ( ( MyPageType = ca_Tetra ) and
                       ( MyNoteType = nt_Implement ) ) or
                     ( ( MyPageType = ca_Extended ) and
                       ( MyNoteType = nt_Taxonomy ) ) or
                     ( ( MyPageType = ca_Entity ) and
                       ( MyNoteType = nt_Terminology ) ) ) ) then
            Continue;

          // Author and date (only in development mode)
          Bubble := cEmpty;
          if ( Dev ) then
          begin
            Bubble := 'By' + cSpace + MyNote[ Indx ].Who + cSpace +
                      'on' + cSpace + MyNote[ Indx ].Dat;
          end;

          // Prepare the new item
          if ( ( ( MyPageType = ca_Tetra ) and
                 ( MyNoteType in [ nt_Scientific ] ) ) or
               ( ( MyPageType = ca_Tetra ) and
                 ( MyNoteType = nt_Implement ) ) or
               ( ( MyPageType = ca_Extended ) and
                 ( MyNoteType = nt_Taxonomy ) ) or
               ( ( MyPageType = ca_Entity ) and
                 ( MyNoteType in [ nt_Terminology ] ) ) ) then
          begin
            AnItem := TBiColItem.Create;

            // TA98 note text
            if ( MyNoteType = nt_TA98 ) then
            begin
              AnItem.SrcLabel := paNote98[ en ];
              AnItem.AltLabel := bbTA98Note[ en ];
            end else

            // TA98 error note
            if ( MyNoteType = nt_Error ) then
            begin
              AnItem.SrcLabel := paNoteEr[ en ];
              AnItem.AltLabel := bbErrorNote[ en ];
            end else

            // Past RevTermA note
            if ( MyNoteType = nt_RevTermA ) then
            begin
              AnItem.SrcLabel := paNote10[ en ];
              AnItem.AltLabel := bbRevisionNote[ en ];
            end else

            // Problem note
            if ( MyNoteType = nt_Problem ) then
            begin
              AnItem.SrcLabel := paNoteProb[ en ];
              AnItem.AltLabel := bbProblemNote[ en ];
            end else

            // RevTermA note
            if ( MyNoteType = nt_Revision ) then
            begin
              AnItem.SrcLabel := paNoteRv[ en ];
              AnItem.AltLabel := bbRvNote[ en ];
            end else

            // Taxonomy note
            if ( MyNoteType = nt_Taxonomy ) then
            begin
              AnItem.SrcLabel := paNoteTx[ en ];
              AnItem.AltLabel := bbTxNote[ en ];
            end else

            // Implementation note
            if ( MyNoteType = nt_Implement ) then
            begin
              AnItem.SrcLabel := paNoteImpl[ en ];
              AnItem.AltLabel := bbImplNote[ en ];
            end else

            // Terminology note
            if ( MyNoteType = nt_Terminology ) then
            begin
              AnItem.SrcLabel := paNoteTn[ en ];
              AnItem.AltLabel := bbTnNote[ en ];
            end;

            // End of new item
            Value := MyNote[ Indx ].Txt;
            Value := MakeHyperlinks( Value, TAH.DisLanguage, False );
            AnItem.Value := Value;
            AnItem.Bubble := Bubble;
            AddItem( AnItem );
          end else

          // Scientific note
          if ( MyNoteType = nt_Scientific ) then
          begin
            Value := MyNote[ Indx ].Txt;

            // Search for a reference
            if ( Value[ 1 ] = '!' ) then
            begin
              Refer := StrToInt( Copy( Value, 2, Length( Value ) ) );
              SetLength( MyRefNote, 10 );
              MbNote := 0;
              TAH.Notes.GetNotes( Refer, MbNote, MyRefNote );
              if ( MbNote > 0 ) then
              begin
                SetLength( MyRefNote, MbNote );
                for Indy := 0 to MbNote - 1 do
                begin
                  MyNoteType := MyRefNote[ Indy ].Typ;
                  if ( MyNoteType = nt_Scientific ) then
                  begin
                    Value := MyRefNote[ Indx ].Txt;
                    Break;
                  end;
                end; // for
              end;
            end;
            Value := MakeHyperlinks( Value, TAH.DisLanguage, True );

            // Store the note
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := paNoteSc[ en ];
            AnItem.AltLabel := bbScNote[ en ];
            AnItem.Value := Value;
            AnItem.Bubble := Bubble;
            AddItem( AnItem );
          end else

          // Implementation note
          if ( MyNoteType = nt_Implement ) then
          begin
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := paNoteImpl[ en ];
            AnItem.AltLabel := bbImplNote[ en ];
            Value := MyNote[ Indx ].Txt;
            Value := MakeHyperlinks( Value, TAH.DisLanguage, False );
            AnItem.Value := Value;
            AnItem.Bubble := Bubble;
            AddItem( AnItem );
          end else

          // Translation note
          if ( MyNoteType = nt_Translation ) then
          begin
            AnItem := TBiColItem.Create;
            AnItem.SrcLabel := paNoteTra[ en ];
            AnItem.AltLabel := bbTraNote[ en ];
            Value := MyNote[ Indx ].Txt;
            Value := MakeHyperlinks( Value, TAH.DisLanguage, False );
            AnItem.Value := Value;
            AnItem.Bubble := Bubble;
            AddItem( AnItem );
          end;
        end; // for
      end;
    end;
  end;
end; // ______________________________________________________TNoteSection.Build

procedure          TDefSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TDefSection.Build
  * Build a definition section *
  Description:
  This method collects all the taxonomic definitions available for the actual
  entity and prepares their display text. It works on all languages available to
  definitions.</P>
  The taxonomic definitions are built according to the genus and differentia
  paradigm.</P>
  The definition section may be present on unit page, entity page, Latin page,
  extended page and translation page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsGeneric:       Boolean;
  Actual:          TEntity;
  Tetra:           TTetrahedron;
begin

  // Selection of applicable entity
  Actual := Self.Entity;
  if ( Self.PageType = ca_Tetra  ) then
  begin
    Tetra := TAH.GetTetrahedronByTID( Actual.TID );
    if ( Tetra <> nil ) then
      Actual := Tetra.Genr;
  end;
  if ( Actual <> nil ) then
  begin

    // Generic page definition
    IsGeneric := ( ( Actual.TetraTip = tp_genPair ) or
                   ( Actual.TetraTip = tp_genSet ) or
                   ( Actual.TetraTip = tp_genPSet ) or
                   ( Actual.TetraTip = tp_setPSet ) or
                   ( Actual.TetraTip = tp_single ) or
                   ( Actual.TetraTip = tp_voc ) or
                   ( Actual.TetraTip = tp_tax ) );
    IsGeneric := IsGeneric or Actual.Generic;
    if ( ( IsGeneric ) and
         ( Actual.TypeEntity <> to_SetMat ) and
         ( Actual.TypeEntity <> to_SetImm ) ) then
    begin
      if ( Self.PageType in
           [ ca_Extended ] ) then
      begin
        Self.MakeTaxDefGeneric( lt_None );
        Self.MakeEncDefGeneric;
      end else
      if ( Self.PageType in
           [ ca_Entity, ca_Latin, ca_Tetra ] ) then
      begin
        Self.MakeTaxDefGeneric( TAH.MainLang );
      end;
    end else

    // Autogenerated definition for the lateral members of a pair
    if ( ( Actual.Link = pw_MemberL ) or
         ( Actual.Link = pw_MemberR ) or
         ( Actual.Link = pw_SMemberL ) or
         ( Actual.Link = pw_SMemberR ) ) then
      Self.MakeTaxDefLateral
    else
    // Autogenerated definition for symmetrical pairs
    if ( ( Actual.TypeEntity = to_ParMat ) or
         ( Actual.TypeEntity = to_ParImm ) ) then
      Self.MakeTaxDefPair
    else

    // Autogenerated definition for sets (to be completed for French)
    if ( ( Actual.TypeEntity = to_SetMat ) or
         ( Actual.TypeEntity = to_SetImm ) ) then
      Self.MakeTaxDefSet
    else

    // Autogenerated definition for pairs of sets (to be completed)
    if ( ( Actual.TypeEntity = to_PstMat ) or
         ( Actual.TypeEntity = to_PstImm ) ) then
      Self.MakeTaxDefPSet;
  end;
end; // _______________________________________________________TDefSection.Build

procedure          tDefSection.MakeTaxDefGeneric(
  Lang:            tLanguage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxDefGeneric
  * Define the content of a definition section for a generic entity *
  Description:
  This method makes all the taxonomic definitions present on the actual
  generic page. A generic page is the page related to the generic entity
  of all composite units, or the unique entity of a single unit. All sets are
  visited in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbDef:           Integer;
  Bubble:          String;
  AnItem:          tBiColItem;
  MyDefType:       tDefType;
  Def:             tDefinition;
begin

  // No specific language: all languages are concerned
  Def := TAH.Definitions;
  if ( Lang = lt_None ) then
  begin

    // Loop on all sets for taxonomic definitions
    for Indy := 1 to Def.NbSet do
    begin
      NbDef := Def.FilterByUID( Self.UID, Indy );
      for Indx := 0 to NbDef - 1 do
        begin
        MyDefType := Def.GetDefinitionType( Indx );
        if ( MyDefType = dt_Taxonomic ) then
        begin
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := TAH.GetLabel( reDefTaxonomic );
          AnItem.AltLabel := TAH.GetLabel( buDefTaxonomic );
          AnItem.Value := Def.MakeTaxDefinition( Indx, True );
          Bubble := bbTaxDef[ en ];
          AnItem.Bubble := Bubble;
          AddItem( AnItem );
        end;
      end; // for on all taxonomic definitions of a set
    end; // for on all sets
  end else

  // Only one specified language is concerned
  begin
    if ( Lang = lt_Latin ) then
      Lang := lt_English;
    for Indy := 1 to Def.NbSet do
    begin
      if ( Def.Language[ Indy ] = Lang ) then
      begin
        NbDef := Def.FilterByUID( Self.UID, Indy );
        for Indx := 0 to NbDef - 1 do
        begin
          MyDefType := Def.GetDefinitionType( Indx );
          if ( MyDefType = dt_Taxonomic ) then
          begin
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := TAH.GetLabel( reDefTaxonomic );
            AnItem.AltLabel := TAH.GetLabel( buDefTaxonomic );
            AnItem.Value := Def.MakeTaxDefinition( Indx, True );
            Bubble := bbTaxDef[ en ];
            AnItem.Bubble := Bubble;
            AddItem( AnItem );
          end;
        end; // for on all taxonomic definitions of the set
        Break;
      end;
    end;
  end;
end; // _______________________________________________________MakeTaxDefGeneric

procedure          tDefSection.MakeEncDefGeneric;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeEncDefGeneric
  * Define the content of an encyclopedic definition section of a generic page *
  Description:
  This method makes all the encyclopedic definitions present on the actual
  generic page. A generic page is the page related to the generic entity
  of all composite units, or the unique entity of a single unit. All sets are
  visited in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  {Indx:            Integer;
  Indy:            Integer;
  NbDef:           Integer;
  Bubble:          String;
  AnItem:          TBiColItem;
  MyDefType:       TDefType;}
  Def:             TDefinition;
begin
  Def := TAH.Definitions;

  // Plain language definitions in English
  {for Indx := 0 to NbDef - 1 do
  begin
    MyDefType := Def.GetDefinitionType( Indx );
    if ( MyDefType = dt_Encyclopedic ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := paPlainLanguage[ en ];
      // AnItem.Value := MakeEncDefinition( Indx );  missing method
      AddItem( AnItem );
      Break;
    end;
  end; // for }
end; // _______________________________________________________MakeTaxDefGeneric

procedure          TDefSection.MakeTaxDefLateral;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxDefLateral
  * Define the content of a definition section of a lateral page *
  Description:
  This method makes all the taxonomic definitions present on the actual lateral
  page. A lateral page is a page related to a lateral member of a pair. All
  sets are visited in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbDef:           Integer;
  PosDef:          Integer;
  IsTaxDef:        Boolean;
  AnItem:          TBiColItem;
  MyDefType:       TDefType;
  Def:             TDefinition;
  Side:            TLink;
begin
  Def := TAH.Definitions;
  Side := Self.Entity.Link;

  // Loop on all sets for lateral definitions
  for Indy := 1 to Def.NbSet do
  begin
    // Skip languages different from the main language
    if ( TAH.MainLang <> Def.Language[ Indy ] ) then
      Continue;

    // Search for the first taxonomic definition
    IsTaxDef := False;
    PosDef := 0;
    NbDef := Def.FilterByUID( Self.UID, Indy );
    for Indx := 0 to NbDef - 1 do
    begin
      MyDefType := Def.GetDefinitionType( Indx );
      if ( MyDefType = dt_Taxonomic ) then
      begin
        IsTaxDef := True;
        PosDef := Indx;
        Break;
      end;
    end; // for up to the first taxonomic definition

    // Add the autogenerated definition
    if ( IsTaxDef ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := paAutoLateral[ en ];
      AnItem.AltLabel := bbAutoPair[ en ];
      AnItem.Value := Def.MakeAutoLateralDef( PosDef, Side );
      AnItem.Bubble := cEmpty;
      AddItem( AnItem );
    end;
  end; // Loop on all sets
end; // _______________________________________________________MakeTaxDefLateral

procedure          TDefSection.MakeTaxDefPair;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxDefPair
  * Define the content of a definition section of a pair page *
  Description:
  This method makes all the taxonomic definitions present on the actual pair
  page. A pair page is a page related to a paired entity. All sets are
  visited in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbDef:           Integer;
  PosDef:          Integer;
  IsTaxDef:        Boolean;
  AnItem:          TBiColItem;
  MyDefType:       TDefType;
  Def:             TDefinition;
begin
  Def := TAH.Definitions;

  // Loop on all sets for pair definitions
  for Indy := 1 to Def.NbSet do
  begin
    // Skip languages different from the main language
    if ( TAH.MainLang <> Def.Language[ Indy ] ) then
      Continue;

    // Search for a taxonomic definition of the generator
    IsTaxDef := False;
    PosDef := 0;
    NbDef := Def.FilterByUID( UID, Indy );
    for Indx := 0 to NbDef - 1 do
    begin
      MyDefType := Def.GetDefinitionType( Indx );
      if ( MyDefType = dt_Taxonomic ) then
      begin
        IsTaxDef := True;
        PosDef := Indx;
        Break;
      end;
    end; // for up to first English taxonomic definition

    // Add the definition
    if ( IsTaxDef ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := paAutoPair[ en ];
      AnItem.AltLabel := bbAutoPair[ en ];
      AnItem.Value := Def.MakeAutoPairDef( PosDef );
      AnItem.Bubble := cEmpty;
      AddItem( AnItem );
    end;
  end; // for on all sets
end; // __________________________________________________________MakeTaxDefPair

procedure          TDefSection.MakeTaxDefSet;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxDefSet
  * Define the content of a definition section of a set page *
  Description:
  This method makes all the taxonomic definitions present on the actual set
  page. A set page is a page related to a set entity. All sets are
  visited in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  NbDef:           Integer;
  AnItem:          TBiColItem;
  Def:             TDefinition;
begin
  Def := TAH.Definitions;

  // Loop on all sets for set definitions
  for Indy := 1 to Def.NbSet do
  begin
    // Skip languages different from the main language
    if ( TAH.MainLang <> Def.Language[ Indy ] ) then
      Continue;

    NbDef := Def.FilterByUID( UID, Indy );
    if ( NbDef >= 2 ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := paAutoSet[ en ];
      AnItem.AltLabel := bbAutoPair[ en ];
      AnItem.Value := Def.MakeAutoSetDef( 1 );
      AnItem.Bubble := cEmpty;
      AddItem( AnItem );
    end;
  end; // for on all sets
end; // ___________________________________________________________MakeTaxDefSet

procedure          TDefSection.MakeTaxDefPSet;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxDefPSet
  * Make the definition section of a pset page *
  Description:
  This method makes all the taxonomic definitions present on the actual pset
  page. A pset page is a page related to a pset entity. All sets are
  visited in turn.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  NbDef:           Integer;
  AnItem:          TBiColItem;
  Def:             TDefinition;
begin // to be developed)
  Def := TAH.Definitions;

  // Loop on all sets for set definitions
  for Indy := 1 to Def.NbSet do
  begin
    // Skip languages different from the main language
    if ( TAH.MainLang <> Def.Language[ Indy ] ) then
      Continue;

    NbDef := Def.FilterByUID( UID, Indy );
    if ( NbDef >= 1 ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := paAutoSet[ en ];
      AnItem.AltLabel := bbAutoPair[ en ];
      AnItem.Value := Def.MakeAutoPstDef( 0 );
      AnItem.Bubble := cEmpty;
      AddItem( AnItem );
    end;
  end; // for on all sets
end; // __________________________________________________________MakeTaxDefPSet

procedure          TLevelSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TLevelSection.Build
  * Make a level section *
  Description:
  This method collects the brother entities of the actual entity.</P>
  Brothers exist in both the partonomy and taxonomy. Therefore, this procedure
  searches them first in the partonomy, seconf in the taxonomy.</P>
  The search for brothers look for the father in the specified hierarchy, then
  look for the list of children, which are the brothers.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  MyTID:           Integer;
  InitLevel:       Boolean;
  IsExt:           Boolean;
  AllBrothers:     String;
  ViewCode:        String;
  Value:           String;
  LinkText:        String;
  Bubble:          String;
  HierarText:      String;
  PageType:        String;
  Actual:          TEntity;
  Father:          TEntity;
  Brother:         TEntity;
  AnItem:          TBiColItem;
begin

  // Initial stuff
  PageType := cEntity;
  IsExt := Self.PageType = ca_Extended;
  if ( IsExt ) then
    PageType := cExtended;
  Actual := Self.Entity;
  if ( Actual <> nil ) then
  begin

    // Check for presence of this section
    Father := TAH.GetEntityByTID( Actual.PartAnc );
    if ( ( Father <> nil ) and Dev ) then
    begin

      // Brothers in partonomy
      AllBrothers := Father.PartCh;
      if ( ( Length( AllBrothers ) > 0 ) and ( Father.TID <> 7765 ) ) then
      begin

        // Retrieve each brother entity
        InitLevel := False;
        repeat
          Posit := Pos( cSemi, AllBrothers );
          if ( Posit > 0 ) then
          begin
            MyTID := StrToInt( Copy( AllBrothers, 0, Posit - 1 ) );
            AllBrothers :=
              Copy( AllBrothers, Posit + 1, Length( AllBrothers ) );
          end else
          begin
            MyTID := StrToInt( AllBrothers );
            AllBrothers := cEmpty;
          end;
          Brother := TAH.GetEntityByTID( MyTID );

          // Display the brother node
          if ( Brother <> nil ) then
          begin

            // Check type of hierarchy
            if ( Actual.PartCh <> cEmpty ) then
              HierarText := 'by generic partonomy'
            else
              HierarText := 'by global partonomy';

            // Initial text for partonomy
            if ( not InitLevel ) then
            begin
              AnItem := TBiColItem.Create;
              AnItem.SrcLabel := HierarText;
              AnItem.AltLabel := cEmpty;
              AddItem( AnItem );
              InitLevel := True;
            end;

            // Left column for TAH unique identifier
            AnItem := TBiColItem.Create;
            ViewCode := cTAH + IntToStr( MyTID );
            AnItem.SrcLabel := ViewCode;
            AnItem.AltLabel := cEmpty;

            // Right column for brother entity
            Value := Brother.GetLibelle( lb_Base, TAH.MainLang );
            LinkText := cEmpty;
            if ( Brother.TID <> Actual.TID ) then
              LinkText := cHrefEmpty + ViewCode + cSpace + PageType +
                          cSpace + cLgShort[ lt_English ] + cPeriod +
                          HtmlExt + cDQuote + cAnr;
            Bubble := Brother.GetLibelle( lb_Base, TAH.SubstLang );
            AnItem.Value := Value;
            AnItem.Bubble := Bubble;
            AnItem.Url := LinkText;
            AnItem.Color := TAH.MainLang;
            AnItem.Indent := 'a';
            AddItem( AnItem );
          end;
        until ( AllBrothers = cEmpty ); // repeat
      end;
    end;

    // Brothers in taxonomy
    Father := TAH.GetEntityByTID( Actual.TaxAnc );
    if ( ( Father <> nil ) and Dev ) then
    begin
      AllBrothers := Father.TaxCh;
      if ( Length( AllBrothers ) > 0 ) then
      begin

        // Retrieve each brother entity
        InitLevel := False;
        repeat
          Posit := Pos( cSemi, AllBrothers );
          if ( Posit > 0 ) then
          begin
            MyTID := StrToInt( Copy( AllBrothers, 0, Posit - 1 ) );
            AllBrothers :=
              Copy( AllBrothers, Posit + 1, Length( AllBrothers ) );
          end else
          begin
            MyTID := StrToInt( AllBrothers );
            AllBrothers := cEmpty;
          end;
          Brother := TAH.GetEntityByTID( MyTID );

          // Display the brother node
          if ( Brother <> nil ) then
          begin

            // Initial text for taxonomy
            if ( not InitLevel ) then
            begin
              AnItem := TBiColItem.Create;
              AnItem.SrcLabel := 'by taxonomy';
              AnItem.AltLabel := cEmpty;
              AddItem( AnItem );
              InitLevel := True;
            end;

            // Left column for TAH unique identifier
            AnItem := TBiColItem.Create;
            ViewCode := cTAH + IntToStr( MyTID );
            AnItem.SrcLabel := ViewCode;
            AnItem.AltLabel := cEmpty;

            // Right column for brother entity
            Value := Brother.GetLibelle( lb_Base, TAH.MainLang );
            LinkText := cEmpty;
            if ( Brother.TID <> Actual.TID ) then
              LinkText := cHrefEmpty + ViewCode + cSpace + PageType +
                          cSpace + cLgShort[ lt_English ] + cPeriod +
                          HtmlExt + cDQuote + cAnr;
            Bubble := Brother.GetLibelle( lb_Base, TAH.SubstLang );
            AnItem.Value := Value;
            AnItem.Bubble := Bubble;
            AnItem.Url := LinkText;
            AnItem.Color := TAH.MainLang;
            AnItem.Indent := 'a';
            AddItem( AnItem );
          end;
        until ( AllBrothers = cEmpty ); // repeat
      end;
    end;
  end;
end; // _____________________________________________________TLevelSection.Build

procedure          TLinkSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TLinkSection.Build
  * Make the linkage section *
  Description:
  This method collects any horizontal properties which have been set for the
  entity which is driving the present Entity Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  First:           Integer;
  Prime:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  LinkText:        String;
  Expand:          String;
  AllProps:        TLinkage;
  Actual:          TEntity;
  Right:           TEntity;
  AnItem:          TBiColItem;
  MyProp:          PropsRec;
begin

  // Check for presence of bivalued properties
  Actual := Self.Entity;
  AllProps := TAH.BiProperties;
  First := -1;
  NbChildren := 0;
  NbSpecific := 0;
  if ( AllProps <> nil ) then
    First := AllProps.PROPSGetPositionByTID( Actual.TID );
  if ( ( First > -1 ) and ( Dev ) ) then
  begin

    // Loop on all bivalued properties for present object
    for Indx := First to AllProps.TotPROPS - 1 do
    begin
      MyProp := AllProps.BiProp( Indx );
      if ( MyProp.Left > Actual.TID ) then
        Break;

      // Display a single bivalued property
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel :=cPROPS[ tPropType( MyProp.RID - 1 ) ];
      AnItem.AltLabel := cPropDef[ tPropType( MyProp.RID - 1 ) ];
      Right := TAH.GetEntityByTID( MyProp.Right );
      if ( Right <> nil ) then
      begin
        Expand := Right.GetLibelle( lb_Base, lt_Latin );
        LinkText := AOTAG + cHrefEmpty + cTAH + IntToStr( Right.TID ) +
                  cSpace + cEntity + cSpace + cLgShort[ lt_English ] + cPeriod +
                  HtmlExt + cDQuote + cAnr;
        AnItem.Value := Expand;
        AnItem.Bubble := cEmpty;
        AnItem.Url := LinkText;
        AnItem.Indent := 'a';
        AnItem.Color := lt_Latin;
        AddItem( AnItem );
      end;

      // Display function of any target muscle
      if ( MyProp.RID = 28 ) then  // 28: joint is_target_of muscle
      begin
        Prime := AllProps.PROPSGetPositionByTID( MyProp.Right );
        if ( Prime > -1 ) then
        begin
          for Indy := Prime to AllProps.TotProps - 1 do
          begin
            if ( MyProp.Left > MyProp.Right ) then
              Break;
            if ( MyProp.RID = 13 ) then // 13: muscle has_function function
            begin
              AnItem := TBiColItem.Create;
              AnItem.SrcLabel := cEmpty;
              AnItem.AltLabel := cEmpty;
                Right := TAH.GetEntityByTID( MyProp.Right );
                if ( Right <> nil ) then
                begin
                  Expand := Right.GetLibelle( lb_Base, lt_Latin );
                  LinkText := AOTAG + cHrefEmpty + cTAH +
                    IntToStr( Right.TID ) + cSpace +
                    cEntity + cSpace + cLgShort[ lt_English ] + cPeriod +
                    HtmlExt + cDQuote + cAnr;
                  LinkText := 'which' + cSpace +
                    cPROPS[ tPropType( MyProp.RID - 1 ) ] +
                    cSpace + LinkText;
                  AnItem.Value := Expand;
                  AnItem.Bubble := cPropDef[ tPropType( MyProp.RID - 1 ) ];
                  AnItem.Indent := 'a';
                  AnItem.Url := LinkText;
                  AnItem.Color := lt_Latin;
                  AddItem( AnItem );
                end;
            end;
          end; // for
        end;
      end;

      // Display possible additional properties set on descendant entities
      Actual.GetNumberOfChildren( False, False, False, NbChildren, NbSpecific );
      if ( NbChildren > 0 ) then
        Self.LinkageOnDescendant( Actual );
    end; // for
  end;

  // Display properties set on descendant entities
  Actual.GetNumberOfChildren( False, False, False, NbChildren, NbSpecific );
  if ( NbChildren > 0 ) then
    Self.LinkageOnDescendant( Actual );
end; // ______________________________________________________TLinkSection.Build

procedure          TBiColSection.LinkageOnDescendant(
  Actual:          TEntity );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LinkageOnDescendant
  * Scan the descendants for linkage section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  NbOrder:         Integer;
  Posit:           Integer;
  NbChildren:      Integer;
  Small:           Integer;
  PrevRID:         Integer;
  AnOrder:         Integer;
  Prime:           Integer;
  First:           Integer;
  Init:            Boolean;
  Children:        String;
  SortList:        String;
  Expand:          String;
  LinkText:        String;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  LinkType:        tLink;
  AChild:          TEntity;
  Right:           TEntity;
  MyProp:          PropsRec;
  AnItem:          TBiColItem;
begin

  // Get children and their number
  Children := Actual.PartCh;
  SortList := Actual.PartPos;
  if Children = cEmpty then
    Exit;

  // Extract the list of order position
  NbOrder := 0;
  while SortList <> cEmpty do
  begin
    Inc( NbOrder );
    Posit := Pos( cSemi, SortList );
    if Posit > 0 then
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
  while Children <> cEmpty do
  begin
    Inc( NbChildren );
    Posit := Pos( cSemi, Children );
    if Posit > 0 then
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
  First := -1;
  for Indx := 1 to NbChildren do
  begin

    // Search next child according to sortlist
    Small := 1;
    AnOrder := Order[ Small];
    for Indy := 2 to NbOrder do
    begin
      if Order[ Indy ] < AnOrder then
      begin
        Small := Indy;
        AnOrder := Order[ Small ];
      end;
    end; // for
    Inds := Small;
    Order[ Small ] := 10000;

    // Retrieve the child entity
    AChild := TAH.GetEntityByTID( Child[ Inds ] );
    if ( AChild <> nil ) then
    begin
      LinkType := AChild.Link;
      if ( LinkType = pw_PartOf ) or
         ( LinkType = pw_BranchOf ) or
         ( LinkType = pw_SetOf ) then
      begin
        Prime := TAH.BiProperties.PROPSGetPositionByTID( AChild.TID );
        if ( Prime > -1 ) then
        begin
          Init := True;
          PrevRID := 0;
          for Indy := Prime to TAH.BiProperties.TotProps - 1 do
          begin
            MyProp := TAH.BiProperties.BiProp( Indy );
            if ( MyProp.Left > AChild.TID ) then
              Break;

            // Restriction applied on part_of transitive properties
            if ( MyProp.RID ) in
               [ 1, 2, 3, 4, 5, 8, 11, 16, 20, 32, 33, 48 ] then
            begin

              // Exclude repeat of symetric links
              if ( MyProp.RID = PrevRID ) and ( PrevRID in [ 8, 31, 45 ] ) then
                Continue;
              PrevRID := MyProp.RID;

              // Heading of the section (once only)
              if ( First = -1 ) then
              begin
                AnItem := TBiColItem.Create;
                AnItem.SrcLabel := 'Linkage';
                AnItem.AltLabel := cEmpty;
                First := 0;
              end;

              // Initial line with has_part relation
              if ( Init ) then
              begin
                AnItem := TBiColItem.Create;
                AnItem.SrcLabel := cPROPS[ pt_has_part ];
                AnItem.AltLabel := cPropDef[ pt_has_part ];
                Expand := AChild.GetLibelle( lb_Base, lt_Latin );
                LinkText := AOTAG + cHrefEmpty + cTAH +
                  IntToStr( AChild.TID ) + cSpace + cEntity + cSpace +
                  cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr;
                AnItem.Value := Expand;
                AnItem.Bubble := cEmpty;
                AnItem.Url := LinkText;
                AnItem.Indent := 'a';
                AnItem.Color := lt_Latin;
                AddItem( AnItem );
                Init := False;
              end;

              // All subsequent transitive relations
              Right := TAH.GetEntityByTID( MyProp.Right );
              if ( Right <> nil ) then
              begin
                AnItem := TBiColItem.Create;
                AnItem.SrcLabel := cEmpty;
                AnItem.AltLabel := cEmpty;
                Expand := Right.GetLibelle( lb_Base, lt_Latin );
                LinkText := AOTAG + cHrefEmpty + cTAH +
                            IntToStr( Right.TID ) + cSpace +
                            cEntity + cSpace + cLgShort[ lt_English ] +
                            cPeriod + HtmlExt + cDQuote + cAnr;
                LinkText := 'which' + cSpace +
                            cPROPS[ tPropType( MyProp.RID - 1 ) ] +
                            cSpace + LinkText;
                Expand := LinkText + Expand + AETAG;
                AnItem.Value := Expand;
                AnItem.Bubble := cPropDef[ tPropType( MyProp.RID - 1 ) ];
                AnItem.Url := cEmpty;
                AnItem.Indent := 'a';
                AnItem.Color := lt_Latin;
                AddItem( AnItem );
              end;
            end else

            // Restriction applied on surface_of transitive properties
            if ( MyProp.RID in [ 34, 45 ] ) then
            begin

              // Exclude repeat of symetric links
              if ( MyProp.RID = PrevRID ) and
                 ( PrevRID in [ 8, 31, 45 ] ) then
                Continue;
              PrevRID := MyProp.RID;

              // Heading of the section (once only)
              if ( First = -1 ) then
              begin
                AnItem := TBiColItem.Create;
                AnItem.SrcLabel := 'Linkage';
                AnItem.AltLabel := cEmpty;
                First := 0;
              end;

              // Initial line with surface_of relation
              if ( Init ) then
              begin
                AnItem := TBiColItem.Create;
                AnItem.SrcLabel := cPROPS[ pt_has_surface ];
                AnItem.AltLabel := cPropDef[ pt_has_surface ];
                Expand := AChild.GetLibelle( lb_Base, lt_Latin );
                LinkText := AOTAG + cHrefEmpty + cTAH +
                            IntToStr( AChild.TID ) + cSpace +
                            cEntity + cSpace + cLgShort[ LgCur ] + cPeriod +
                            HtmlExt + cDQuote + cAnr;
                AnItem.Value := Expand;
                AnItem.Bubble := cEmpty;
                AnItem.Url := LinkText;
                AnItem.Indent := 'a';
                AnItem.Color := lt_Latin;
                AddItem( AnItem );
                Init := False;
              end;

              // All subsequent transitive relations
              Right := TAH.GetEntityByTID( MyProp.Right );
              if ( Right <> nil ) then
              begin
                AnItem := TBiColItem.Create;
                AnItem.SrcLabel := cEmpty;
                AnItem.AltLabel := cEmpty;
                Expand := Right.GetLibelle( lb_Base, lt_Latin );
                LinkText := AOTAG + cHrefEmpty + cTAH +
                            IntToStr( Right.TID ) + cSpace +
                            cEntity + cSpace + cLgShort[ LgCur ] +
                            cPeriod + HtmlExt + cDQuote + cAnr;
                LinkText := 'which' + cSpace +
                            cPROPS[ tPropType( MyProp.RID - 1 ) ] +
                            cSpace + LinkText;
                AnItem.Value := Expand;
                AnItem.Bubble := cPropDef[ tPropType( MyProp.RID - 1 ) ];
                AnItem.Url := LinkText;
                AnItem.Indent := 'a';
                AnItem.Color := lt_Latin;
                AddItem( AnItem );
              end;
            end;
          end; // for
        end;
      end;

      // Call for next level
      Self.LinkageOnDescendant( AChild );
    end;
  end;
end; // _____________________________________________________LinkageOnDescendant

procedure          tNavListSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tNavListSection.Build
  * Make a List navigation section (partonomy and taxonomy) *
  Description:
  This procedure prepares a list of hyperlinks for all partial lists in
  relation to the present list. The links are limited to the levels between
  the level of the specified entity and the top level.</P>
  Navigation between languages is present. It is possible to
  select any primary language, the subsidiary language being always Latin and
  the interface language being the primary language.</P>
  In addition, a return link towards the home pages of the website is
  defined.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  P1:              Integer;
  P2:              Integer;
  P3:              Integer;
  P4:              Integer;
  T1:              Integer;
  T2:              Integer;
  T3:              Integer;
  T4:              Integer;
  TID:             Integer;
  Value:           String;
  NewValue:        String;
  ShortLink:       String;
  FullLink:        String;
  Full:            String;
  Short:           String;
  MyList:          String;
  TypeL:           String;
  LangDir:         String;
  MyFile:          String;
  Main:            tEntity;
  Gener:           tEntity;
  MyEntity:        tEntity;
  Tetra:           tTetrahedron;
  FourList:        tFourList;
  AnItem:          tBiColItem;
  MyType:          tTypeListPage;
  MyLang:          tLanguage;
begin
  Main := Self.Entity;
  if ( Main <> nil ) then
  begin
    TID := Main.TID;
    Tetra := TAH.GetTetrahedronByTID( TID );
    if ( Tetra <> nil ) then
    begin

      // Find the language directory
      LangDir := cLgShort[ TAH.MainLang ];
      if ( TAH.MainLang = lt_Latin ) then
        LangDir := LangDir + cLgShort[ TAH.SubstLang ];
      LangDir := LangDir + cSlash;

      // Links to partonomy list pages
      MyLang := TAH.MainLang;
      Short := TAH.GetLabel( reShort );
      Full := TAH.GetLabel( reFull );
      MyType := Self.TypeList;
      if ( MyType in [ li_part0, li_part1, li_part2, li_part2f,
                       li_part3, li_part3f, li_part4 ] ) then
      begin
        TypeL := cPart;
        Gener := Tetra.Main;
        if ( Gener = nil ) then
          Gener := Tetra.Genr;
        if ( ( Gener <> nil ) and
             ( TAH.GetPartListPosition( TID, FourList ) ) ) then
        begin
          P1 := FourList[ 1 ];
          P2 := FourList[ 2 ];
          P3 := FourList[ 3 ];
          P4 := FourList[ 4 ];

          // Return to the home page of the partonomy
          Value := 'TNA partonomy';
          MyFile := DirViewPartList + cLgShort[ TAH.MainLang ];
          if ( TAH.MainLang = lt_Latin ) then
            MyFile := MyFile + cLgShort[ TAH.SubstLang ];
          Value := AOTAG + cHrefEmpty + cRetroDir3x + cPropDir + MyFile +
                   cPeriod + cHTML + cDQuote + cAnr + Value + AETAG;

          // Store the line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := TAH.GetLabel( reHomePage );
          AnItem.AltLabel := TAH.GetLabel( buHomePage );
          AnItem.Value := Value;
          AnItem.Bubble := cEmpty;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );

          // Make contribution for partonomy top level
          if ( P1 > 0 ) then
          begin
            MyEntity := TAH.GetEntityByTID( P1 );
            if ( MyEntity <> nil ) then
            begin

              // Special for TNA (transitory ???)
              Value := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );
              Value := AOTAG + cHrefEmpty + cRetroDir3x + cAutoDir + cPartDir +
                       LangDir + cTAH + IntToStr( P1 ) + cSpace +
                       cTypeListPage[ li_part1 ] + cSpace +
                       cLgShort[ TAH.DisLanguage ] + cPeriod + cHTM +
                       cDQuote + cAnr + Value + AETAG;

              // Consider the short list
              {
              if ( MyType <> li_part1 ) then
                ShortLink :=
                  AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                  cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                  IntToStr( P1 ) + cSpace + cPart + cTypeListPage[ li_part1 ] +
                  cSpace + cLgShort[ DisLanguage ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + Short + AETAG;
              Value := Value + cSpace + ShortLink;

              // Consider the full list
              if ( MyType <> li_part0 ) then
                FullLink :=
                  AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                  cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                  IntToStr( P1 ) + cSpace + cPart + cTypeListPage[ li_part0 ] +
                  cSpace + cLgShort[ DisLanguage ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + Full + AETAG;
              Value := Value + cSpace + FullLink;}

              // Store the line
              AnItem := tBiColItem.Create;
              AnItem.SrcLabel := TAH.GetLabel( reTopLevel );
              AnItem.AltLabel := TAH.GetLabel( buTopLevel );
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.PartLink := cEmpty;
              AddItem( AnItem );
            end;
          end;

          // Make contribution for partonomy level 2
          if ( P2 > 0 ) then
          begin
            MyEntity := TAH.GetEntityByTID( P2 );
            if ( MyEntity <> nil ) then
            begin

              // Consider the short list
              Value := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );
              if ( MyType <> li_part2 ) then
                ShortLink :=
                  AOTAG + cHrefEmpty + cRetroDir + LangDir + cTAH +
                  IntToStr( P2 ) + cSpace + cTypeListPage[ li_part2 ] +
                  cSpace + cLgShort[ TAH.DisLanguage ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + Short + AETAG;
              Value := Value + cSpace + ShortLink;

              // Consider the full list
              if ( MyType <> li_part2f ) then
                FullLink :=
                  AOTAG + cHrefEmpty + cRetroDir + LangDir + cTAH +
                  IntToStr( P2 ) + cSpace + cTypeListPage[ li_part2f ] +
                  cSpace + cLgShort[ TAH.DisLanguage ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + Full + AETAG;
              Value := Value + cSpace + FullLink;

              // Store the line
              AnItem := tBiColItem.Create;
              if ( P3 > 0 ) then
              begin
                AnItem.SrcLabel := TAH.GetLabel( reLevel2 );
                AnItem.AltLabel := TAH.GetLabel( buLevel2 );
              end else
              begin
                AnItem.SrcLabel := TAH.GetLabel( reCurrentLevel );
                AnItem.AltLabel := TAH.GetLabel( buCurrentLevel );
              end;
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.PartLink := cEmpty;
              AddItem( AnItem );
            end;
          end;

          // Make contribution for partonomy level 3
          if ( P3 > 0 ) then
          begin
            MyEntity := TAH.GetEntityByTID( P3 );
            if ( MyEntity <> nil ) then
            begin
              Value := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );

              // Check for presence of the level 4
              MyList := TAH.GetListEntityByP4( TID );
              if ( MyList <> cEmpty ) then
              begin

                // Consider the short list
                if ( MyType <> li_part3 ) then
                begin
                  ShortLink :=
                    AOTAG + cHrefEmpty + cRetroDir + LangDir + cTAH +
                    IntToStr( P3 ) + cSpace + cTypeListPage[ li_part3 ] +
                    cSpace + cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + Short + AETAG;
                  Value := Value + cSpace + ShortLink;
                end;

                // Consider the full list
                if ( MyType <> li_part3f ) then
                begin
                  FullLink :=
                    AOTAG + cHrefEmpty + cRetroDir + LangDir + cTAH +
                    IntToStr( P3 ) + cSpace + cTypeListPage[ li_part3f ] +
                    cSpace + cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + Full + AETAG;
                  Value := Value + cSpace + FullLink;
                end;
              end;

              // Store the line
              AnItem := tBiColItem.Create;
              if ( P4 > 0 ) then
              begin
                AnItem.SrcLabel := TAH.GetLabel( reLevel3 );
                AnItem.AltLabel := TAH.GetLabel( buLevel3 );
              end else
              begin
                AnItem.SrcLabel := TAH.GetLabel( reCurrentLevel );
                AnItem.AltLabel := TAH.GetLabel( buCurrentLevel );
              end;
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.PartLink := cEmpty;
              AddItem( AnItem );
            end;

            // Make contribution for partonomy level 4
            MyEntity := TAH.GetEntityByTID( P4 );
            if ( MyEntity <> nil ) then
            begin
              Value := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );
              {if ( MyType <> li_part4 ) then
              begin
                FullLink :=
                  AOTAG + cHrefEmpty + cRetroDir + LangDir + cTAH +
                  IntToStr( P4 ) + cSpace + cTypeListPage[ li_part4 ] +
                  cSpace + cLgShort[ TAH.DisLanguage ] + cPeriod + HtmlExt +
                  cDQuote + cAnr + cFull[ en ] + AETAG;
                Value := Value + cSpace + FullLink;
              end;}
              AnItem := tBiColItem.Create;
                AnItem.SrcLabel := TAH.GetLabel( reCurrentLevel );
                AnItem.AltLabel := TAH.GetLabel( buCurrentLevel );
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.PartLink := cEmpty;
              AddItem( AnItem );
            end;
          end;
        end;
      end else // partonomic lists

      // Links to taxonomy list pages: actual level and levels above
      // ===========================================================
      if ( MyType in [ li_tax1, li_tax2, li_tax2f,
                       li_tax3, li_tax3f, li_tax4 ] ) then
      begin

        // Search all taxonomic levels
        TypeL := cTax;
        Gener := Tetra.Genr;
        if ( Gener = nil ) then
          Gener := Tetra.Main;
        if ( TAH.GetTaxListPosition( Gener.TID, FourList ) ) then
        begin
          T1 := FourList[ 1 ];
          T2 := FourList[ 2 ];
          T3 := FourList[ 3 ];
          T4 := FourList[ 4 ];

          // Return to the top view of the taxonomy
          Value := 'TA taxonomy';
          Value := AOTAG + cHrefEmpty + cRetroDir + cRetroDir +
                   DirViewTaxList + cLgShort[ TAH.MainLang ] +
                   cPeriod + cHTML + cDQuote + cAnr + Value + AETAG;

          // Store the line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := TAH.GetLabel( reHomePage );
          AnItem.AltLabel := TAH.GetLabel( buHomePage );
          AnItem.Value := Value;
          AnItem.Bubble := cEmpty;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );

          // Make contribution for taxonomy level 1
          if ( T1 > 0 ) then
          begin
            MyEntity := TAH.GetEntityByTID( T1 );
            if ( MyEntity <> nil ) then
            begin

              // Consider the condensed list
              Value := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );
              ShortLink := TAH.GetLabel( reShort );
              if ( MyType <> li_tax1 ) then
                ShortLink :=
                  AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                  cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                  IntToStr( T1 ) + cSpace + cTax +
                  cTypeListPage[ li_tax1 ] +
                  cSpace + cLgShort[ TAH.DisLanguage ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + ShortLink + AETAG;
              Value := Value + cSpace + ShortLink;

              // Consider the full list
              FullLink := TAH.GetLabel( reFull );
              if ( MyType <> li_tax1f ) then
                FullLink :=
                  AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                  cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                  IntToStr( T1 ) + cSpace + cTax +
                  cTypeListPage[ li_tax1f ] +
                  cSpace + cLgShort[ TAH.DisLanguage ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + FullLink + AETAG;
              Value := Value + cSpace + FullLink;

              // Store the line
              AnItem := tBiColItem.Create;
              AnItem.SrcLabel := TAH.GetLabel( reTopLevel );
              AnItem.AltLabel := TAH.GetLabel( buTopLevel );
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.PartLink := cEmpty;
              AddItem( AnItem );
            end;
          end;

          // Make contribution for taxonomy level 2
          if ( T2 > 0 ) then
          begin
            NewValue := cEmpty;
            // if ( MyType = li_tax3 ) then
            begin
              MyEntity := TAH.GetEntityByTID( T2 );
              if ( MyEntity <> nil ) then
              begin

                // Consider the condensed list
                Value := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                              st_undef, True );
                ShortLink := TAH.GetLabel( reShort );
                if ( MyType <> li_tax2 ) then
                  ShortLink :=
                    AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                    cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                    IntToStr( T2 ) + cSpace + cTax +
                    cTypeListPage[ li_tax2 ] +
                    cSpace + cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + ShortLink + AETAG;
                Value := Value + cSpace + ShortLink;

                // Consider the full list
                FullLink := TAH.GetLabel( reFull );
                if ( MyType <> li_tax2f ) then
                  FullLink :=
                    AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                    cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                    IntToStr( T2 ) + cSpace + cTax +
                    cTypeListPage[ li_tax2f ] +
                    cSpace + cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + FullLink + AETAG;
                Value := Value + cSpace + FullLink;
              end;
            end;

            // Create and store the Partonomy List line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := TAH.GetLabel( reLevel2 );
            AnItem.AltLabel := TAH.GetLabel( buLevel2 );
            AnItem.Value := Value;
            AnItem.Bubble := cEmpty;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;

          // Make contribution for taxonomy level 3
          if ( T3 > 0 ) then
          begin
            MyEntity := TAH.GetEntityByTID( T3 );
            if ( MyEntity <> nil ) then
            begin
              Value := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );

              // Check for presence of the level 4
              MyList := TAH.GetListEntityByT4( TID );
              if ( MyList <> cEmpty ) then
              begin

                // Consider the short list
                if ( MyType <> li_tax3 ) then
                begin
                  ShortLink :=
                    AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                    cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                    IntToStr( T3 ) + cSpace + cTax +
                    cTypeListPage[ li_tax3 ] + cSpace +
                    cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + Short + AETAG;
                  Value := Value + cSpace + ShortLink;
                end;

                // Consider the full list
                if ( MyType <> li_tax3f ) then
                begin
                  FullLink :=
                    AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                    cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                    IntToStr( T3 ) + cSpace + cTax +
                    cTypeListPage[ li_tax3f ] +
                    cSpace + cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + Full + AETAG;
                  Value := Value + cSpace + FullLink;
                end;
              end;

              // Store the line
              AnItem := tBiColItem.Create;
              if ( T4 > 0 ) then
              begin
                AnItem.SrcLabel := TAH.GetLabel( reLevel3 );
                AnItem.AltLabel := TAH.GetLabel( buLevel3 );
              end else
              begin
                AnItem.SrcLabel := TAH.GetLabel( reCurrentLevel );
                AnItem.AltLabel := TAH.GetLabel( buCurrentLevel );
              end;
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.PartLink := cEmpty;
              AddItem( AnItem );
            end;

            // Make contribution for taxonomy level 4
            MyEntity := TAH.GetEntityByTID( T4 );
            if ( MyEntity <> nil ) then
            begin
              Value := MyEntity.GetLibelle( lb_Official, TAH.MainLang,
                                            st_undef, True );
              {if ( MyType <> li_tax4 ) then
              begin
                FullLink :=
                  AOTAG + cHrefEmpty + cRetroDir + cList +
                  cSpace + cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                  IntToStr( T4 ) + cSpace + cTax +
                  cTypeListPage[ li_tax4 ] +
                  cSpace + cLgShort[ TAH.DisLanguage ] + cPeriod + HtmlExt +
                  cDQuote + cAnr + cFull[ en ] + AETAG;
                Value := Value + cSpace + FullLink;
              end; }
              AnItem := tBiColItem.Create;
                AnItem.SrcLabel := TAH.GetLabel( reCurrentLevel );
                AnItem.AltLabel := TAH.GetLabel( buCurrentLevel );
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.PartLink := cEmpty;
              AddItem( AnItem );
            end;
          end;
        end;
      end; // taxonomic lists

      // Links to alternate language versions
      // ====================================
      // Selection of the subsidiary language if main is Latin
      Value := TAH.GetLabel( reEnglish );
      if ( TAH.SubstLang <> lt_English ) then
      begin
        Value := AOTAG + cHrefEmpty + cRetroDir + cLgShort[ lt_Latin ] +
                 cLgShort[ lt_English ] + cSlash + cTAH +
                 IntToStr( TID ) + cSpace +
                 cTypeListPage[ MyType ] + cSpace + cLgShort[ lt_English ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
      end;
      NewValue := TAH.GetLabel( reFrench );
      if ( TAH.SubstLang <> lt_French ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir +  cLgShort[ lt_Latin ] +
                    cLgShort[ lt_French ] + cSlash + cTAH +
                    IntToStr( TID ) + cSpace +
                    cTypeListPage[ MyType ] + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end;
      Value := Value + cSpace + NewValue;
      NewValue := TAH.GetLabel( reSpanish );
      if ( TAH.SubstLang <> lt_Spanish ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir + cLgShort[ lt_Latin ] +
                    cLgShort[ lt_Spanish ] + cSlash + cTAH +
                    IntToStr( TID ) + cSpace +
                    cTypeListPage[ MyType ] + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end;
      Value := Value + cSpace + NewValue;
      NewValue := TAH.GetLabel( reRussian );
      if ( TAH.SubstLang <> lt_Russian ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir +  cLgShort[ lt_Latin ] +
                    cLgShort[ lt_Russian ] + cSlash + cTAH +
                    IntToStr( TID ) + cSpace +
                    cTypeListPage[ MyType ] + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end;
      Value := Trim( Value + cSpace + NewValue );

      // Create and store the language selector
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLatinSel );
      AnItem.AltLabel := TAH.GetLabel( buLatinSel );
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AnItem.PartLink := cEmpty;
      AddItem( AnItem );

      // Selection of the primary language if not Latin
      Value := TAH.GetLabel( reEnglish );
      if ( MyLang <> lt_English ) then
      begin
        Value := AOTAG + cHrefEmpty + cRetroDir +
                 cLgShort[ lt_English ] + cSlash + cTAH +
                 IntToStr( TID ) + cSpace +
                 cTypeListPage[ MyType ] + cSpace + cLgShort[ lt_English ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
      end;
      NewValue := TAH.GetLabel( reFrench );
      if ( MyLang <> lt_French ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir +
                    cLgShort[ lt_French ] + cSlash + cTAH +
                    IntToStr( TID ) + cSpace +
                    cTypeListPage[ MyType ] + cSpace + cLgShort[ lt_French ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end;
      Value := Value + cSpace + NewValue;
      NewValue := TAH.GetLabel( reSpanish );
      if ( MyLang <> lt_Spanish ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir +
                    cLgShort[ lt_Spanish ] + cSlash + cTAH +
                    IntToStr( TID ) + cSpace +
                    cTypeListPage[ MyType ] + cSpace + cLgShort[ lt_Spanish ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end;
      Value := Value + cSpace + NewValue;
      NewValue := TAH.GetLabel( reRussian );
      if ( MyLang <> lt_Russian ) then
      begin
        NewValue := AOTAG + cHrefEmpty + cRetroDir +
                    cLgShort[ lt_Russian ] + cSlash + cTAH +
                    IntToStr( TID ) + cSpace +
                    cTypeListPage[ MyType ] + cSpace + cLgShort[ lt_Russian ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + NewValue + AETAG;
      end;
      Value := Value + cSpace + NewValue;

      // Create and store the language selector
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLanguageSel );
      AnItem.AltLabel := TAH.GetLabel( buLanguageSel );
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AnItem.PartLink := cEmpty;
      AddItem( AnItem );
    end;
  end;
end; // ___________________________________________________tNavListSection.Build

procedure          TUnivSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tUnivSection.Build
  * Make a universal statistic section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  MaxC             = 6;
  cC               = cUnderline;
  Blank:           Array[ 1 .. 5 ] of String = (
                   cC,
                   cC + cC,
                   cC + cC + cC,
                   cC + cC + cC + cC,
                   cC + cC + cC + cC + cC );
var
  Indx:            Integer;
  Number:          Integer;
  TotNo:           Integer;
  TotM:            Integer;
  TotF:            Integer;
  TotMF:           Integer;
  TotBL:           Integer;
  TotBH:           Integer;
  TotContr:        Integer;
  TotAll:          Integer;
  TotChildren:     Integer;
  TotPartial:      Integer;
  NbLine:          Integer;
  Lgt:             Integer;
  Percent:         Integer;
  IsStop:          Boolean;
  Mid1:            Real;
  Mid2:            Real;
  Value:           String;
  Contrib:         String;
  Actual:          TEntity;
  AnItem:          TBiColItem;
  AType:           TTypeListPage;
  MyStat:          TStatUniversal;
begin
  Actual := Self.Entity;
  AType := Self.TypeList;
  if ( ( Actual <> nil ) and ( Actual.PartCh <> cEmpty ) ) then
  begin

    // Creat the universal statistic object
    MyStat := TStatUniversal.Create( Actual.Tetra );

    // Feed statistic for top unit of the list
    MyStat.NewItem( Actual.Tetra );

    // Feed statistic for all children of the partonomy
    IsStop := Self.TypeList <> li_part0;
    TotChildren := 1;
    TotPartial := 0;
    MakeStatUnivDescendants( MyStat, Actual.TID, 2, AType, IsStop, TotChildren,
                             TotPartial );

    // Display the global values
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Number of sampled entities';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MyStat.Total );
    AnItem.Bubble := cEmpty;
    AnItem.PartLink := cEmpty;
    AddItem( AnItem );
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Number of universals';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MyStat.TotUniv );
    AnItem.Bubble := cEmpty;
    AnItem.PartLink := cEmpty;
    AddItem( AnItem );

    // Display the contributions
    NbLine := MyStat.NbProfile;
    TotNo := 0;
    TotM := 0;
    TotF := 0;
    TotMF := 0;
    TotBL := 0;
    TotBH := 0;
    TotAll := 0;
    for Indx := 0 to NbLine - 1 do
    begin

      // Compute values for a single contribution
      TotContr := 0;
      Number := MyStat.NoExp[ Indx ];
      Inc( TotNo, Number );
      Inc( TotContr, Number );
      Contrib := IntToStr( Number );
      Lgt := MaxC - Length( Contrib );
      Value := 'No: ' + Contrib + Blank[ Lgt ];
      Number := MyStat.MExp[ Indx ];
      Inc( TotM, Number );
      Inc( TotContr, Number );
      Contrib := IntToStr( Number );
      Lgt := MaxC - Length( Contrib );
      Value := Value + cSpace + 'M:  ' + Contrib + Blank[ Lgt ];
      Number := MyStat.FExp[ Indx ];
      Inc( TotF, Number );
      Inc( TotContr, Number );
      Contrib := IntToStr( Number );
      Lgt := MaxC - Length( Contrib );
      Value := Value + cSpace + 'F:  ' + Contrib + Blank[ Lgt ];
      Number := MyStat.MFExp[ Indx ];
      Inc( TotMF, Number );
      Inc( TotContr, Number );
      Contrib := IntToStr( Number );
      Lgt := MaxC - Length( Contrib );
      Value := Value + cSpace + 'MF: ' + Contrib + Blank[ Lgt ];
      Number := MyStat.ValidLow[ Indx ];
      Inc( TotBL, Number );
      Contrib := IntToStr( Number );
      Lgt := MaxC - Length( Contrib );
      Value := Value + cSpace + 'BL: ' + Contrib + Blank[ Lgt ];
      Number := MyStat.ValidHigh[ Indx ];
      Inc( TotBH, Number );
      Contrib := IntToStr( Number );
      Lgt := MaxC - Length( Contrib );
      Value := Value + cSpace + 'BH: ' + Contrib;

      // Compute total per contribution
      Contrib := IntToStr( TotContr );
      Lgt := MaxC - Length( Contrib );
      Value := Contrib + Blank[ Lgt ] + Value;
      Inc( TotAll, TotContr );

      // Write line of contribution
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := MyStat.Profile[ Indx ];
      AnItem.AltLabel := cEmpty;
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AnItem.PartLink := cEmpty;
      AddItem( AnItem );
    end; // for on all contributions

    // Write the total
    Contrib := IntToStr( TotNo );
    Lgt := MaxC - Length( Contrib );
    Value := 'No: ' + Contrib + Blank[ Lgt ];
    Contrib := IntToStr( TotM );
    Lgt := MaxC - Length( Contrib );
    Value := Value + cSpace + 'M:  ' + Contrib + Blank[ Lgt ];
    Contrib := IntToStr( TotF );
    Lgt := MaxC - Length( Contrib );
    Value := Value + cSpace + 'F:  ' + Contrib + Blank[ Lgt ];
    Contrib := IntToStr( TotMF );
    Lgt := MaxC - Length( Contrib );
    Value := Value + cSpace + 'MF:  ' + Contrib + Blank[ Lgt ];
    Contrib := IntToStr( TotBL );
    Lgt := MaxC - Length( Contrib );
    Value := Value + cSpace + 'BL:  ' + Contrib + Blank[ Lgt ];
    Contrib := IntToStr( TotBH );
    Lgt := MaxC - Length( Contrib );
    Value := Value + cSpace + 'BH:  ' + Contrib + Blank[ Lgt ];
    Contrib := IntToStr( TotAll );
    Lgt := MaxC - Length( Contrib );
    Value := Contrib + Blank[ Lgt ] + Value;
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Total';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := Value;
    AnItem.Bubble := cEmpty;
    AnItem.PartLink := cEmpty;
    AddItem( AnItem );

    // Write the mismatch rate
    if ( TotAll > 0 ) then
    begin
      Mid1 := 1000.0 * ( TotBH / TotAll );
      Percent := Round( Mid1 );
      Value := FloatToStr( Percent / 10.0 ) + cSpace + cPercent;
      Mid2 := 1000.0 * ( ( TotBH + TotBL ) / TotAll );
      Percent := Round( Mid2 );
      Value := Value + cSpace + cDash + cSpace + FloatToStr( Percent / 10.0 ) +
               cSpace + cPercent;
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Mismatch rates';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AnItem.PartLink := cEmpty;
      AddItem( AnItem );
    end;
  end;
end; // ______________________________________________________tUnivSection.Build

procedure          TBiColSection.MakeStatUnivDescendants(
  MyStat:          TStatUniversal;
  TID:             Integer;
  Level:           Integer;
  AType:           TTypeListPage;
  IsStop:          Boolean;
  var TotChildren: Integer;
  var TotPartial:  Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeStatUnivDescendants
  * Make the universal statistic for Partonomy List Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  Posit:           Integer;
  NbTrueChildren:  Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  ActDiv:          Integer;
  IsRef:           Boolean;
  Children:        String;
  SortList:        String;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          TEntity;
  AChild:          TEntity;
  AChildRef:       TEntity;
  MyLink:          tLink;
begin
  // Retrieve the top entity of the list
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get direct children and their number
  Children := Actual.PartCh;
  SortList := Actual.PartPos;
  NbTrueChildren := Actual.NbPartC;

  // Extract the list of order position
  if ( Children = cEmpty ) then
    Exit;
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

      // Skip left and right entities
      MyLink := AChild.Link;
      if ( MyLink in [ pw_MemberL, pw_MemberR, pw_SMemberL, pw_SMemberR,
           pw_IMemberL, pw_IMemberR, pw_TMemberL, pw_TMemberR ] ) then
        Continue;

      // Prepare and display a single line
      MyStat.NewItem( AChild.Tetra );

      // Continue on chidren
      Self.MakeStatUnivDescendants( MyStat, AChild.TID, Level + 1, Atype,
                                    True, TotChildren, TotPartial );
    end;
  end; // for Indx := 1 to NbTrueChildren
end; // _________________________________________________MakeStatUnivDescendants

procedure          tBiColSection.DisplayGroup(
  MyFormula:       String;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DisplayGroup
  * Build and display model of a group of a Latin term  *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  MyLnk:           Integer;
  IsPrefix:        Boolean;
  Libelle:         String;
  MyLib:           String;
  MyVoc:           String;
  Explicit:        String;
  LinkText:        String;
  IntTerm:         String;
  ModTerm:         String;
  Source:          String;
  Bubble:          String;
  MyDefIcon:       String;
  MyDef:           String;
  MyContrib:       String;
  AType:           String;
  MyFather:        String;
  Refer:           tEntity;
  Father:          tEntity;
  AnItem:          tBiColItem;
  ARef:            tSingle;
  Lang:            tLanguage;
  MyType:          tContrib;
  MyUnit:          tUnit;
begin

  // Loop on all contributions from formula
  Lang := lt_English;
  repeat

    // Search for the next contribution in formula
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

    // Extract contributing entity
    Posit := Pos( '(', MyContrib );
    if ( Posit > 0 ) then
    begin
      AType := MyContrib[ 1 ];
      MyContrib := Copy(  MyContrib, Posit + 1, Length( MyContrib ) - 3 );
    end else
      Continue;
    MyLnk := StrToInt( MyContrib );
    MyType := co_Undefined;
    if ( AType = 'N' ) then
      MyType := co_Noun
    else
    if ( AType = 'A' ) then
      MyType := co_Adj
    else
    if ( AType = 'P' ) then
      MyType := co_Pref
    else
    if ( AType = 'C' ) then
      MyType := co_Compl
    else
    if ( AType = 'I' ) then
      MyType := co_Inv;

    // Initialization of the treatment
    begin
      MyUnit := TAH.GetUnitByPos( MyLnk );
      Refer := nil;
      if ( MyUnit <> nil ) then
        Refer := TAH.GetEntityByTID( MyUnit.Generator );

      // Treatment of an unreferenced contribution
      // Normally, unreferenced contributions do not exist !!!
      if ( Refer = nil ) then
      begin
        case MyType of
          co_Noun:  Source := 'Unreferenced noun';
          co_Compl: Source := 'Unreferenced noun complement';
          co_Adj:   Source := 'Unreferenced adjective';
          co_Pref:  Source := 'Unreferenced prefix';
          co_Inv:   Source := 'Unreferenced invariant';
        end; // case
        Bubble := cEmpty;
        Libelle := cAnr + MyLib + cAnl;
        LinkText := cEmpty;
      end else

      // Treatment of referenced contributions
      begin

        // Search libelle of entity
        Refer.LgCurrent := lt_Latin;
        Refer.Query := tSearch.Create( st_Bas );
        Refer.SearchTerm;
        ARef := Refer.CurrSingle;
        Explicit := cEmpty;
        if ( ARef <> nil ) then
          Explicit := ARef.Mandat + ARef.Option;

        // Search libelle of taxonomic ancestor
        MyFather := cEmpty;
        if ( ( Refer.TetraTip = tp_voc ) or ( Refer.TID <= 38 ) ) then
        begin
          Father := TAH.GetEntityByTID( Refer.TaxAnc );
          Father.LgCurrent := lt_Latin;
          Father.Query := tSearch.Create( st_Bas );
          Father.SearchTerm;
          ARef := Father.CurrSingle;
          if ( ARef <> nil ) then
            MyFather := cRol + ARef.Mandat + ARef.Option + cRor + cSpace;
        end;

        // 1. Treatment of a noun contribution
        if ( MyType = co_Noun ) then
        begin
          Refer.Query := tSearch.Create( st_Nou );
          Refer.SearchTerm;
          ARef := Refer.CurrSingle;
          MyVoc := cEmpty;
          if ( ARef <> nil ) then
            MyVoc := ARef.Mandat;
          Source := paRefNoun[ en ];
          Bubble := baRefNoun[ en ];
          if ( ARef <> nil ) then
          begin
            Libelle := cTAH + IntToStr( MyLnk ) + cSpace + Explicit + cSpace +
                       MyFather + cAnr + MyVoc + cAnl;
            LinkText := cHrefEmpty + DirTAHName + cTAH + IntToStr( Refer.TID ) +
                        cSpace + cEntity + cSpace + cLgShort[ Lang ] + cPeriod +
                        HtmlExt + cDQuote + cAnr;
          end;
        end else

        // 2. Treatment of a noun complement contribution
        if ( MyType = co_Compl ) then
        begin
          Refer.Query := tSearch.Create( st_Nou );
          Refer.SearchTerm;
          ARef := Refer.CurrSingle;
          MyVoc := cEmpty;
          if ( ARef <> nil ) then
            MyVoc := ARef.Mandat;
          Source := paRefCompl[ en ];
          Bubble := baRefCompl[ en ];
          if ( ARef <> nil ) then
          begin
            Libelle := cTAH + IntToStr( MyLnk ) + cSpace +
                       Explicit + cSpace + cAnr + MyVoc + cAnl;
            LinkText := cHrefEmpty + DirTAHName + cTAH + IntToStr( Refer.TID ) +
                        cSpace + cEntity + cSpace + cLgShort[ Lang ] + cPeriod +
                        HtmlExt + cDQuote + cAnr;
          end;
        end else

        // 3. Treatment of proximity by an adjective
        if ( MyType = co_Adj ) then
        begin
          Refer.Query := tSearch.Create( st_Adj );
          Refer.SearchTerm;
          ARef := Refer.CurrSingle;
          MyVoc := cEmpty;
          if ( ARef <> nil ) then
            MyVoc := ARef.Mandat;
          Libelle := cTAH + IntToStr( MyLnk ) + cSpace + Explicit + cSpace +
                     MyFather + cAnr + MyVoc + cAnl;
          LinkText := cHrefEmpty + DirTAHName + cTAH +
                      IntToStr( Refer.TID ) + cSpace +
                      cEntity + cSpace + cLgShort[ Lang ] + cPeriod +
                      HtmlExt + cDQuote + cAnr;
          IsPrefix := False;
          Source := paRefAdj[ en ];
          Bubble := baRefAdj[ en ];
        end else

        // 4. Treatment of proximity by a prefix
        if ( MyType = co_Pref ) then
        begin
          Refer.Query := tSearch.Create( st_Pre );
          Refer.SearchTerm;
          ARef := Refer.CurrSingle;
          MyVoc := cEmpty;
          if ( ARef <> nil ) then
            MyVoc := ARef.Mandat;
          Libelle := cTAH + IntToStr( MyLnk ) + cSpace +
                     Explicit + cSpace + cAnr + MyVoc + cAnl;
          LinkText := cHrefEmpty + DirTAHName + cTAH +
                      IntToStr( Refer.TID ) + cSpace +
                      cEntity + cSpace + cLgShort[ Lang ] + cPeriod +
                      HtmlExt + cDQuote + cAnr;
          Source := 'Referenced prefix';
          Bubble := cEmpty;
        end else

        // 5. Treatment of invariants
        if ( MyType = co_Inv ) then
        begin
          IntTerm := cEmpty;
          if ( ARef <> nil ) then
            IntTerm := ARef.Intrinsic;
          ModTerm := IntTerm;
          if not IsPrefix then
            ModTerm := cSpace + ModTerm;
          Explicit := ModTerm;
          Libelle := cTAH + IntToStr( MyLnk ) + cSpace +
                     IntTerm + cSpace + cAnr + Explicit + cAnl;
          Source := 'Referenced invariant';
          Bubble := cEmpty;
        end;

        // Look for a definition
        {NbDefEN := TAH.Definitions.FilterByUID( Refer.TID, 1 );
        MyDef := cEmpty;
        MyDefIcon := cEmpty;
        if ( NbDefEN > 0 ) then
        begin
          MyDef := TAH.Definitions.MakeTaxDefinition( 0, False, True );
          MyDefIcon := cDefIcon;
        end;}
      end;

      // Display the contribution
      if ( ( MyType <> co_Group ) and ( MyType <> co_Ref ) ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := Source;
        AnItem.AltLabel := Bubble;
        AnItem.Value := Libelle;
        AnItem.Bubble := cEmpty;
        AnItem.Url := LinkText;
        AnItem.Color := lt_Latin;
        AnItem.Def := MyDef;
        AnItem.DefIcon := MyDefIcon;
        AnItem.Indent := Chr( Ord( cBaseIndent ) + Level - 1 );
        AddItem( AnItem );
      end;
    end;
  until ( MyFormula = cEmpty ); // repeat on all contributions
end; // ____________________________________________________________DisplayGroup

procedure          tBicolSection.MakeMandExpansion(
  TID:             Integer;
  MyObl:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeMandExpansion
  * Make an mandatory expansion for the term design section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Level:           Integer;
  Value:           String;
  LinkText:        String;
  AFormula:        String;
  MyEntity:        tEntity;
  AnItem:          tBiColItem;
  LAModelMand:     tSingle;
  MySingle:        tSingle;
begin

  // Global construct of mandatory expansion (recursive approach)
  MyEntity := TAH.GetEntityByTID( MyObl );
  MyEntity.LgCurrent := lt_Latin;
  MyEntity.Query := tSearch.Create( st_For );
  MyEntity.SearchTerm;
  LAModelMand := MyEntity.CurrSingle;

  // Recursive loop if mandatory term has itself a mandatory expansion
  while ( LAModelMand <> nil ) do
  begin
    Value := cTAH + IntToStr( MyObl ) + cSpace + LAModelMand.Libelle;
    LinkText := cHrefEmpty + cRetroDir + cEntity + cSpace +
                cLgShort[ lt_English ] + cSlash + cTAH +
                IntToStr( MyObl ) + cSpace + cEntity + cSpace +
                cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr;

    // Prepare the mandatory contribution
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Mandatory expansion';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := Value;
    AnItem.Color := lt_Latin;
    AnItem.Url := LinkText;
    AddItem( AnItem );

    // Build and display the base raw term of mandatory expansion
    MyEntity.LgCurrent := lt_Universal;
    MyEntity.Query := TSearch.Create( st_Mod );
    MyEntity.SearchTerm;
    MySingle := MyEntity.CurrSingle;
    AFormula := MySingle.Mandat;
    Level := 1;
    DisplayGroup( AFormula, Level );

    // Search for possible recursive expansions
    if ( LAModelMand.Obl > 0 ) then
    begin
      MyEntity := TAH.GetEntityByTID( LAModelMand.Obl );
      MyEntity.LgCurrent := lt_Latin;
      MyEntity.Query := tSearch.Create( st_mod );
      MyEntity.SearchTerm;
      LAModelMand := MyEntity.CurrSingle;
    end else
      LAModelMand := nil;
  end; // while: on all mandatory recursive expansions
end; // _______________________________________________________MakeMandExpansion

procedure          tBicolSection.MakeAdjExpansion(
  TID:             Integer;
  MyAdj:           Integer;
  MyPref:          Integer;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAdjExpansion
  * Make an adjective expansion for the term design section *
  Description:
  This procedure builds the analysis of an adjective expansion, under the
  form of indented lines of descriptive text.</p>
  An adjective expansion is possibly accompanied by a prefix expansion in
  front of it. This possibility is taken into account.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  PrefTID:         Integer;
  Value:           String;
  LinkText:        String;
  ExpAdj:          String;
  ExpPref:         String;
  MyRef:           String;
  MyFather:        String;
  MyEntity:        tEntity;
  MyEntityPref:    tEntity;
  Father:          tEntity;
  AnItem:          tBiColItem;
  ARef:            tSingle;
  VocUnit:         tUnit;
begin
  if ( MyAdj > 0 ) then
  begin

    // Global construct of adjective expansion
    VocUnit := TAH.GetUnitByPos( MyAdj );
    if ( ( VocUnit <> nil ) and ( VocUnit.Vocabulary > 0 ) ) then
    begin
      MyEntity := TAH.GetEntityByTID( VocUnit.Vocabulary );
      if ( MyEntity <> nil ) then
      begin
        ExpAdj := MyEntity.GetVocabulary( lt_Latin, st_Adj );

        // Search for a possible prefix
        if ( ( ExpAdj <> cEmpty ) and ( MyPref > 0 ) ) then
        begin

          // Retrieve the prefix
          VocUnit := TAH.GetUnitByPos( MyPref );
          if ( ( VocUnit <> nil ) and ( VocUnit.Vocabulary > 0 ) ) then
          begin
            MyEntityPref := TAH.GetEntityByTID( VocUnit.Vocabulary );
            if ( MyEntityPref <> nil ) then
            begin
              PrefTID := MyEntityPref.TID;
              ExpPref := MyEntityPref.GetVocabulary( lt_Latin, st_Pre );
            end;
          end;
        end;

        // Manage the found adjective
        if ( ExpAdj <> cEmpty ) then
        begin
          Value := cTAH + IntToStr( MyAdj ) + cSpace + ExpPref + ExpAdj;
          LinkText := cHrefEmpty + cRetroDir + cEntity + cSpace +
                      cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                      IntToStr( TID ) + cSpace + cEntity + cSpace +
                      cLgShort[ TAH.SubstLang ] +
                      cPeriod + HtmlExt + cDQuote + cAnr;

          // Prepare the basic contribution
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := paAdjExpansion[ en ];
          AnItem.AltLabel := baBasicPart[ en ];
          AnItem.Value := Value;
          AnItem.Url := Linktext;
          AnItem.Color := lt_Latin;
          AnItem.Indent := Chr( Ord( cBaseIndent ) + Level - 1 );
          AddItem( AnItem );

          // Search libelle of taxonomic ancestor
          MyFather := cEmpty;
          if ( ( MyEntity.TetraTip = tp_voc ) or ( MyEntity.TID <= 38 ) ) then
          begin
            Father := TAH.GetEntityByTID( MyEntity.TaxAnc );
            Father.LgCurrent := lt_Latin;
            Father.Query := tSearch.Create( st_Bas );
            Father.SearchTerm;
            ARef := Father.CurrSingle;
            if ( ARef <> nil ) then
              MyFather := cRol + ARef.Mandat + ARef.Option + cRor + cSpace;
          end;

          // Define the reference to the prefix
          if ( MyEntityPref <> nil ) then
          begin
            MyRef := MyEntityPref.InternalTex;
            MyRef := cSpace + cSpace + MyRef + cSpace +
                     MyFather + cSpace + cAnr + ExpPref + cAnl;

            // Display the prefix
            Value := cTAH + IntToStr( PrefTID ) + cSpace + MyRef;
            LinkText := cHrefEmpty + cRetroDir + cEntity + cSpace +
                        cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                        IntToStr( PrefTID ) + cSpace + cEntity + cSpace +
                        cLgShort[ TAH.SubstLang ] +
                        cPeriod + HtmlExt + cDQuote + cAnr;

            // Prepare the prefix contribution
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := 'Referenced prefix';
            AnItem.AltLabel := baBasicPart[ en ];
            AnItem.Value := Value;
            AnItem.Url := Linktext;
            AnItem.Color := lt_Latin;
            AnItem.Indent := Chr( Ord( cBaseIndent ) + Level );
            AddItem( AnItem );
          end;

          // Define the reference to the adjective
          MyRef := MyEntity.InternalTex;
          MyRef := cSpace + cSpace + MyRef + cSpace +
                   MyFather + cSpace + cAnr + ExpAdj + cAnl;

          // Display the adjective
          Value := cTAH + IntToStr( MyEntity.TID ) + cSpace + MyRef;
          LinkText := cHrefEmpty + cRetroDir + cEntity + cSpace +
                      cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                      IntToStr( MyEntity.TID ) + cSpace + cEntity + cSpace +
                      cLgShort[ TAH.SubstLang ] +
                      cPeriod + HtmlExt + cDQuote + cAnr;

          // Prepare the adjective contribution
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := 'Referenced adjective';
          AnItem.AltLabel := baBasicPart[ en ];
          AnItem.Value := Value;
          AnItem.Url := Linktext;
          AnItem.Color := lt_Latin;
          AnItem.Indent := Chr( Ord( cBaseIndent ) + Level );
          AddItem( AnItem );
        end;
      end;
    end;
  end;
end; // ________________________________________________________MakeAdjExpansion

procedure          tTestSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTestSection.Build
  * Make a controled test section for any language *
  Description:
  A controled test is a collection of single tests made of pairs of a request
  for a value and the corresponding expected answer. When the request is
  executed, the result is compared to the expected answer and the test can be
  accepted or not. This strategy can be applied to several contexts that are
  recognized under different section types.</p>
  This procedure builds a controled test section on gender, plural and case of
  adjectives and nouns possible in all languages. It also realize a controled
  test on entities and their attached universal formula, to be compared with
  the generated terms.</p>
  Any section type may be available in one or all languages, depending on
  specific features of the language.</p>
  For the correctly generated adjectives or nouns, three kinds of information
  are possibly displayed:
  - when the result is based on a rule, the rule ordinal is given and the rule
    can be retrieved in the rule section, shown with "by rule #",
  - when the result is attributed to a default rule, the default flag is set,
    shown with "by default",
  - when the result is an exception, the adjective or the noun is flagged
    as such, shown with "by exeption".</p>
  For the incorrect adjectives and nouns, the wrong result is displayed. A
  manual corrective action is then necessary. Normally, no incorrect values
  are present.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
type
  tChGender     = Array[ 1 .. 50, va_word .. va_5 ] of String;
var
  Indx:            Integer;
  NbTest:          Integer;
  TID:             Integer;
  NbGoodFem:       Integer;
  NbGoodNeu:       Integer;
  NbGoodPlus:      Integer;
  IdentFem:        Integer;
  IdentNeu:        Integer;
  IsRule:          Boolean;
  IsGoodFem:       Boolean;
  IsGoodNeu:       Boolean;
  IsGoodPlus:      Boolean;
  MyMasc:          String;
  MyFem:           String;
  MyNeu:           String;
  MyPLus:          String;
  MyPLus2:         String;
  MyPLus3:         String;
  MyResultFem:     String;
  MyResultNeu:     String;
  MyResultPlus:    String;
  JustifFem:       String;
  JustifNeu:       String;
  JustifPlus:      String;
  Val1:            String;
  Val2:            String;
  Val3:            String;
  Val4:            String;
  ExplResult:      String;
  LangDir:         String;
  MyText:          String;
  Lang:            tLanguage;
  CheckGender:     tChGender;
  AnItem:          tBiColItem;
  NounCase:        tNounCase;
  AdjCase:         tAdjCase;
  Actual:          tEntity;
  MyComment:       tComment;
begin

  // 1. Write heading in first line
  // ==============================
  AnItem := tBiColItem.Create;
  Self.SetTestHeading( AnItem );

  // 2. Retrieve the list of all tests for this section
  // ==================================================
  Lang := TAH.MainLang;
  NbTest := Self.NbTest;
  for Indx := 1 to NbTest do
  begin
    CheckGender[ Indx, va_3 ] := cEmpty;
    case Lang of
      lt_Latin:
        begin
          case Self.SectionType of
            sc_TestNounGender:
              begin
                CheckGender[ Indx, va_word ] :=
                  cNounChGenderLA[ Indx, va_word ];
                CheckGender[ Indx, va_1 ] :=
                  cNounChGenderLA[ Indx, va_1 ];
              end;
            sc_TestAdjGender:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChGenderLA[ Indx, ge_masculine ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChGenderLA[ Indx, ge_feminine ];
                CheckGender[ Indx, va_2 ] :=
                  cAdjChGenderLA[ Indx, ge_neuter ];
              end;
            sc_TestAdjPlural:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChPluralLA[ Indx, nu_sin ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChPluralLA[ Indx, nu_plu ];
                CheckGender[ Indx, va_2 ] :=
                  cAdjChPluralLA[ Indx, nu_plf ];
                CheckGender[ Indx, va_3 ] :=
                  cAdjChPluralLA[ Indx, nu_pln ];
              end;
            sc_TestNounGenSin:
              begin
                CheckGender[ Indx, va_word ] :=
                  cNounChGenSinLA[ Indx, nu_sin ];
                CheckGender[ Indx, va_1 ] :=
                  cNounChGenSinLA[ Indx, nu_plu ];
              end;
            sc_TestAdjGenSin:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChGenSinLA[ Indx, nu_sin ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChGenSinLA[ Indx, nu_plu ];
                CheckGender[ Indx, va_2 ] :=
                  cAdjChGenSinLA[ Indx, nu_plf ];
                CheckGender[ Indx, va_3 ] :=
                  cAdjChGenSinLA[ Indx, nu_pln ];
              end;
            sc_TestNounGenPlu:
              begin
                CheckGender[ Indx, va_word ] :=
                  cNounChGenPluLA[ Indx, nu_sin ];
                CheckGender[ Indx, va_1 ] :=
                  cNounChGenPluLA[ Indx, nu_plu ];
              end;
            sc_TestAdjGenPlu:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChGenPluLA[ Indx, nu_sin ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChGenPluLA[ Indx, nu_plu ];
                CheckGender[ Indx, va_2 ] :=
                  cAdjChGenPluLA[ Indx, nu_plf ];
                CheckGender[ Indx, va_3 ] :=
                  cAdjChGenPluLA[ Indx, nu_pln ];
              end;
            sc_TestNoExp:
              begin
                TID := cNoChExpLA[ Indx, nu_plu ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                                Lang, st_for, True, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_Latin );
                TID := TID;
              end;
            sc_TestAdjExp:
              begin
                TID := cAdjChExpLA[ Indx, nu_plu ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                                Lang, st_for, False, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_Latin );
                TID := TID;
              end;
            sc_TestMandExp:
              begin
                TID := cMandChExpLA[ Indx, nu_plu ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                if ( TID = 9275 ) then // transitory
                  CheckGender[ Indx, va_word ] :=
                    Actual.GetLibelle( lb_Synonym, Lang, st_Ofd, True, False )
                else
                  CheckGender[ Indx, va_word ] :=
                    Actual.GetLibelle( lb_Official, Lang, st_For, True, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_Latin );
                TID := TID;
              end;
            sc_TestOptExp:
              begin
                TID := cOptChExpLA[ Indx, nu_sin ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Universal,
                                             lt_Latin, st_for, False, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cOptChExpLA[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_Latin );
                TID := TID;
              end;
            sc_TestLatExp:
              begin
                TID := cLatChExpLA[ Indx, nu_sin ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                             lt_Latin, st_for, False, False );
                CheckGender[ Indx, va_3 ] :=
                  Trim( Actual.GetLibelle( lb_Official,
                  lt_Latin, st_bas, True, False ) );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cLatChExpLA[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_Latin );
                CheckGender[ Indx, va_4 ] := TAH.GetTextValue( TID, False,
                                             lt_Latin, True );
                TID := TID;
              end;
          end; // case on all possible section types for Latin
        end;
      lt_English:
        begin
          case Self.SectionType of
            sc_TestNoExp:
              begin
                TID := cNoChExpEN[ Indx, nu_sin ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                             lt_English, st_mod, False, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cNoChExpEN[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_English );
                TID := TID;
              end;
            sc_TestAdjExp:
              begin
                TID := cAdjChExpEN[ Indx, nu_plu ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                             lt_English, st_mod, False, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_English );
                TID := TID;
              end;
            sc_TestMandExp:
              begin
                TID := cMandChExpEN[ Indx, nu_sin ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] :=
                  Actual.GetLibelle( lb_Official, lt_English, st_for,
                                     True, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cMandChExpEN[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_English );
              end;
            sc_TestOptExp:
              begin
                TID := cOptChExpEN[ Indx, nu_sin ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle
                  ( lb_Official, lt_English, st_for, False, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cOptChExpEN[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_English );
                TID := TID;
              end;
            sc_TestLatExp:
              begin
                TID := cLatChExpEN[ Indx, nu_sin ];
                if ( TID = 0 ) then
                  Continue;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                             lt_English, st_for, False, False );
                CheckGender[ Indx, va_3 ] :=
                  Trim( Actual.GetLibelle( lb_Official,
                  lt_English, st_bas, True, False ) );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cLatChExpEN[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_English );
                CheckGender[ Indx, va_4 ] := TAH.GetTextValue( TID, False,
                                             lt_English, True );
                TID := TID;
              end;
          end; // case on all section types for English
        end;
      lt_French:
        begin
          case Self.SectionType of
            sc_TestAdjGender:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChGenderFR[ Indx, ge_masculine ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChGenderFR[ Indx, ge_feminine ];
              end;
            sc_TestNounGender:
              begin
                CheckGender[ Indx, va_word ] :=
                  cNounChGenderFR[ Indx, va_word ];
                CheckGender[ Indx, va_1 ] :=
                  cNounChGenderFR[ Indx, va_1 ];
              end;
            sc_TestAdjPlural:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChPluralFR[ Indx, nu_sin ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChPluralFR[ Indx, nu_plu ];
                CheckGender[ Indx, va_2 ] :=
                  cAdjChPluralFR[ Indx, nu_plf ];
              end;
            sc_TestNoExp:
              begin
                TID := cNoChExpFR[ Indx, nu_sin ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                             lt_French, st_mod, True, False );
                TID := cNoChExpFR[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_French );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
              end;
            sc_TestAdjExp:
              begin
                TID := cAdjChExpFR[ Indx, nu_sin ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                                Lang, st_mod, True, False );
                TID := cAdjChExpFR[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             Lang );
                CheckGender[ Indx, va_3 ] := IntToStr( TID );
              end;
            sc_TestMandExp:
              begin
                TID := cMandChExpFR[ Indx, nu_sin ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Universal,
                                                Lang, st_for, True, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cMandChExpFR[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             Lang );
              end;
            sc_TestLatExp:
              begin
                TID := cLatChExpFR[ Indx, nu_sin ];
                if ( TID = 0 ) then
                  Continue;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                             lt_French, st_for, False, False );
                CheckGender[ Indx, va_3 ] :=
                  Trim( Actual.GetLibelle( lb_Official,
                  lt_French, st_bas, True, False ) );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cLatChExpFR[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_French );
                CheckGender[ Indx, va_4 ] := TAH.GetTextValue( TID, False,
                                             lt_French, True );
              end;
          end; // cas on all available section types for French
        end;
      lt_Spanish:
        begin
          case Self.SectionType of
            sc_TestAdjGender:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChGenderES[ Indx, ge_masculine ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChGenderES[ Indx, ge_feminine ];
              end;
            sc_TestAdjExp:
              begin
                TID := cAdjChExpES[ Indx, nu_sin ];
                Actual := TAH.GetEntityByTID( TID );
                if ( Actual = nil ) then
                  Exit;
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                                Lang, st_mod, True, False );
                TID := cAdjChExpES[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             Lang );
                CheckGender[ Indx, va_3 ] := IntToStr( TID );
              end;
          end; // case on all section types for Spanish
        end;
      lt_Russian:
        begin
          case Self.SectionType of
            sc_TestAdjGender:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChGenderRU[ Indx, ge_masculine ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChGenderRU[ Indx, ge_feminine ];
              end;
            sc_TestNounGender:
              begin
                CheckGender[ Indx, va_word ] :=
                  cNounChGenderRU[ Indx, ge_masculine ];
                CheckGender[ Indx, va_1 ] :=
                  cNounChGenderRU[ Indx, ge_feminine ];
              end;
            sc_TestAdjPlural:
              begin
                CheckGender[ Indx, va_word ] :=
                  cAdjChPluralRU[ Indx, nu_sin ];
                CheckGender[ Indx, va_1 ] :=
                  cAdjChPluralRU[ Indx, nu_plu ];
              end;
            sc_TestNoExp:
              begin
                TID := cNoChExpRU[ Indx, nu_plu ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                             lt_Russian, st_mod, True, False );
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_Russian );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := TID;
              end;
            sc_TestAdjExp:
              begin
                TID := cAdjChExpRU[ Indx, nu_sin ];
                if ( TID = 0 ) then
                begin
                  Dec( NbTest );
                  Continue;
                end;
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_word ] := Actual.GetLibelle( lb_Official,
                                             lt_Russian, st_for, True, False );
                CheckGender[ Indx, va_2 ] := IntToStr( TID );
                TID := cAdjChExpRU[ Indx, nu_plu ];
                Actual := TAH.GetEntityByTID( TID );
                CheckGender[ Indx, va_1 ] := TAH.GetTextValue( TID, False,
                                             lt_Russian );
                TID := TID;
              end;
          end; // case on all section types for Russian
        end;
    end; // case on all languages
  end; // for on all available test words
  AnItem.Value := IntToStr( NbTest ) + cSpace +
                  TAH.GetLabel( reTestEntries, False);
  AddItem( AnItem );

  // Test all adjectives: MyMasc = MySing, MyFem = MyPlur
  NbGoodFem := 0;
  NbGoodNeu := 0;
  NbGoodPlus := 0;
  for Indx := 1 to NbTest do
  begin

    // Get the validated adjectives
    MyMasc := CheckGender[ Indx, va_word ];
    MyFem := CheckGender[ Indx, va_1 ];
    MyNeu := CheckGender[ Indx, va_2 ];
    MyPlus := CheckGender[ Indx, va_3 ];
    MyPlus2 := CheckGender[ Indx, va_4 ];
    MyPlus3 := CheckGender[ Indx, va_5 ];

    // NEW WAY
    // Process each individual test
    IsRule := False;
    IsGoodFem := False;
    IsGoodNeu := False;
    IsGoodPlus := False;
    case Self.SectionType of

      // Test the nominative plural of nouns
      sc_TestNounPlural:
        begin
          case Lang of
            // Plural nouns are obtained from the Latin dictionary
            lt_Latin:
              begin
                MyMasc := cNounChPluralLA[ Indx, nu_sin ];
                GetNounLA( MyMasc, NounCase );
                if ( NounCase[ 1 ] <> cEmpty ) then
                  MyResultFem := NounCase[ 3 ];
                IsGoodFem := MyResultFem = cNounChPluralLA[ Indx, nu_plu ];
                MyNeu := cEmpty;
                MyPlus := cEmpty;
              end;
            // Plural nouns are computed on a rules and exceptions basis
            lt_English:
              begin
                MyMasc := cNounChPluralEN[ Indx, nu_sin ];
                Myfem := cNounChPluralEN[ Indx, nu_plu ];
                MyResultFem := TestNounPluralEN( MyMasc, IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
            // Plural nouns are computed on a rules and exceptions basis
            lt_French:
              begin
                MyMasc := cNounChPluralFR[ Indx, nu_sin ];
                Myfem := cNounChPluralFR[ Indx, nu_plu ];
                MyResultFem := TestNounPluralFR( MyMasc, IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
            // Plural nouns are computed on a rules and exceptions basis
            lt_Spanish:
              begin
                MyMasc := cNounChPluralES[ Indx, nu_sin ];
                Myfem := cNounChPluralES[ Indx, nu_plu ];
                MyResultFem := TestNounPluralES( MyMasc, IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
            // Plural nouns are computed on a rules and exceptions basis
            lt_Russian:
              begin
                MyMasc := cNounChPluralRU[ Indx, nu_sin ];
                Myfem := cNounChPluralRU[ Indx, nu_plu ];
                MyResultFem := TestNounPluralRU( MyMasc, IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
          end; // case on all languages
        end;
    end; // case on all section type

    // OLD WAY
    // Process the feminine and neuter from the masculine form
    // or process the plural from the singular form
    case Lang of
      lt_Latin:
        begin
          case Self.SectionType of
            sc_TestAdjPlural:
              begin
                GetAdjectiveLA( MyMasc, AdjCase );
                if ( AdjCase[ 1 ] <> cEmpty ) then
                begin
                  MyFem := AdjCase[ 3 ];
                  MyNeu := AdjCase[ 7 ];
                  MyPlus := AdjCase[ 11 ];
                end;
              end;
            sc_TestNounGenSin:
              begin
                GetNounLA( MyMasc, NounCase );
                if ( NounCase[ 1 ] <> cEmpty ) then
                begin
                  MyResultFem := NounCase[ 2 ];
                  IsGoodFem := MyFem = NounCase[ 2 ];
                end;
              end;
            sc_TestAdjGenSin:
              begin
                GetAdjectiveLA( MyMasc, AdjCase );
                if ( AdjCase[ 1 ] <> cEmpty ) then
                begin
                  MyResultFem := AdjCase[ 2 ];
                  IsGoodFem := MyFem = AdjCase[ 2 ];
                  MyResultNeu := AdjCase[ 6 ];
                  IsGoodNeu := MyNeu = AdjCase[ 6 ];
                  MyResultPlus := AdjCase[ 10 ];
                  IsGoodPlus := MyPlus = AdjCase[ 10 ];
                end;
              end;
            sc_TestNounGenPlu:
              begin
                GetNounLA( MyMasc, NounCase );
                if ( NounCase[ 1 ] <> cEmpty ) then
                begin
                  MyResultFem := NounCase[ 4 ];
                  IsGoodFem := MyFem = NounCase[ 4 ];
                end;
              end;
            sc_TestAdjGenPlu:
              begin
                GetAdjectiveLA( MyMasc, AdjCase );
                if ( AdjCase[ 1 ] <> cEmpty ) then
                begin
                  MyFem := AdjCase[ 3 ];
                  MyNeu := AdjCase[ 7 ];
                  MyPlus := AdjCase[ 11 ];
                end;
              end;
            sc_TestAdjExp, sc_TestNoExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
              end;
            sc_TestMandExp, sc_TestOptExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
                MyResultNeu := MyNeu;
              end;
            sc_TestLatExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
                MyResultNeu := MyNeu;
                IsGoodPlus := MyPlus = MyPlus2;
              end;
          end;
        end;
      lt_English:
        begin
          case Self.SectionType of
            sc_TestAdjExp, sc_TestNoExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
              end;
            sc_TestMandExp, sc_TestOptExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
              end;
            sc_TestLatExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
                MyResultNeu := MyNeu;
                IsGoodPlus := MyPlus = MyPlus2;
              end;
          end;
        end;
      lt_French:
        begin
          case Self.SectionType of
            sc_TestAdjGender:
              begin
                MyResultFem := TestAdjectiveGenderFR( ge_feminine, MyMasc,
                                                      IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
            sc_TestNounGender:
              begin
                MyResultFem := TestNounGenderFR( MyMasc, IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
            sc_TestAdjPlural:
              begin
                MyResultFem := TestAdjPluralFR( MyMasc, IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
                MyPlus := TestAdjectiveGenderFR( ge_feminine, MyMasc,
                                                 IsRule, IdentNeu );
                MyResultNeu := TestAdjPluralFR( MyPlus, IsRule, IdentNeu );
                IsGoodNeu := MyNeu = MyResultNeu;
              end;
            sc_TestNoExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
              end;
            sc_TestAdjExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
              end;
            sc_TestMandExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
              end;
            sc_TestLatExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
                MyResultNeu := MyNeu;
                IsGoodPlus := MyPlus = MyPlus2;
              end;
          end; // case on all types of section
        end;
      lt_Spanish:
        begin
          case Self.SectionType of
            sc_TestAdjGender:
              begin
                MyResultFem := TestAdjectiveGenderES( ge_feminine, MyMasc,
                                                      IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
            sc_TestAdjExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
              end;
          end;
        end;
      lt_Russian:
        begin
          case Self.SectionType of
            sc_TestAdjGender:
              begin
                MyResultFem := TestAdjectiveGenderRU( ge_feminine, MyMasc,
                                                      IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
                MyResultNeu := TestAdjectiveGenderRU( ge_neuter, MyMasc, IsRule,
                                                      IdentNeu );
                IsGoodNeu := MyNeu = MyResultNeu;
              end;
            sc_TestNounGender:
              begin
                MyResultFem := TestNounGenderRU( MyMasc, IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
            sc_TestAdjPlural:
              begin
                MyResultFem := TestAdjPluralRU( MyMasc, IsRule, IdentFem );
                IsGoodFem := MyFem = MyResultFem;
              end;
            sc_TestAdjExp, sc_TestNoExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
              end;
            sc_TestMandExp, sc_TestOptExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
                MyResultNeu := MyNeu;
              end;
            sc_TestLatExp:
              begin
                IsGoodFem := MyMasc = MyFem;
                if ( IsGoodFem ) then
                  MyResultFem := 'OK' + cColumn + MyMasc
                else
                  MyResultFem := 'Error' + cColumn + MyFem;
                MyResultNeu := MyNeu;
                IsGoodPlus := MyPlus = MyPlus2;
              end;
          end; // case on all types of section
        end;
    end; // case on all languages

    // 3. Justify the result of the test
    // =================================
    if ( not ( SectionType in
               [ sc_TestAdjExp, sc_TestMandExp, sc_TestLatExp,
                 sc_TestNoExp, sc_TestOptExp ] ) ) then
    begin
      JustifFem := cEmpty;
      JustifNeu := cEmpty;
      JustifPlus := cEmpty;
      if ( IsGoodFem ) then
      begin
        Inc( NbGoodFem );
        if ( ( not IsGoodNeu ) or ( SectionType = sc_TestAdjPlural ) ) then
        begin
          if ( Lang = lt_Latin ) then
            JustifFem := TAH.GetLabel( reTestByDico, False )
          else
          if ( ( IsRule ) and ( IdentFem > 0 ) ) then
            JustifFem := TAH.GetLabel( reTestByRule, False ) + cSpace +
                         IntToStr( IdentFem )
          else
          if ( ( IsRule ) and ( IdentFem = 0 ) ) then
            JustifFem := TAH.GetLabel( reTestByDefault, False )
          else
            JustifFem := TAH.GetLabel( reTestByExcept, False );

          // Make explicit the coded value
          if ( MyResultFem = 'm' ) then
            ExplResult := TAH.GetLabel( reTestMasculine, False )
          else
          if ( MyResultFem = 'f' ) then
            ExplResult := TAH.GetLabel( reTestFeminine, False )
          else
          if ( MyResultFem = 'n' ) then
            ExplResult := TAH.GetLabel( reTestNeuter, False );
          JustifFem := ExplResult + cSpace + JustifFem;
        end else
          JustifFem := MyResultFem;
      end else
        JustifFem := TAH.GetLabel( reTestFound, False ) + cSpace + MyResultFem;

      if ( MyResultNeu <> cEmpty ) then
      begin
        if ( IsGoodNeu ) then
        begin
          Inc( NbGoodNeu );
          if ( not IsGoodPlus ) then
          begin
            if ( IsRule ) then
              JustifNeu := TAH.GetLabel( reTestByRule, False ) + cSpace
                            + IntToStr( IdentNeu )
            else
              JustifNeu := TAH.GetLabel( reTestByExcept, False );
            JustifNeu := MyResultNeu + cSpace + JustifNeu;
          end else
            JustifNeu := MyResultNeu;
        end;
      end else
      if ( ( not IsGoodFem ) and ( not IsGoodNeu ) ) then
      begin
        JustifFem := TAH.GetLabel( reTestFound, False ) + cSpace + MyResultFem;
        JustifNeu := TAH.GetLabel( reTestFound, False ) + cSpace + MyResultNeu;
      end;
    end;

    if ( MyResultPlus <> cEmpty ) then
    begin
      if ( IsGoodPlus ) then
      begin
        Inc( NbGoodPlus );
        if ( IsRule ) then
          JustifPlus := TAH.GetLabel( reTestByRule, False ) + cSpace +
                        IntToStr( IdentNeu )
        else
          JustifPlus := TAH.GetLabel( reTestByDico, False );
        JustifPlus := MyResultPlus + cSpace + JustifPlus;
      end else
        JustifPlus := TAH.GetLabel( reTestFound, False ) + cSpace +
                      MyResultPlus;
    end else
    if ( ( not IsGoodFem ) and ( not IsGoodNeu ) ) then
    begin
      JustifFem := TAH.GetLabel( reTestFound, False ) + cSpace + MyResultFem;
      JustifNeu := TAH.GetLabel( reTestFound, False ) + cSpace + MyResultNeu;
    end;

    // 4. Display the result of the test
    // =================================

    // Expansion tests
    if ( SectionType in [ sc_TestAdjExp, sc_TestMandExp, sc_TestLatExp,
                          sc_TestNoExp, sc_TestOptExp ] ) then
    begin
      AnItem := tBiColItem.Create;

      // Make hyperlink to Entity Page on TID
      LangDir := cLgShort[ TAH.MainLang ];
      if ( TAH.MainLang = lt_Latin ) then
        LangDir := LangDir + cLgShort[ TAH.SubstLang ];
      LangDir := LangDir + cSlash;
      AnItem.SrcLabel := AOTAG + cHrefEmpty + cRetroDir2x + cDirEntity +
                         LangDir + cTAH + MyNeu + cSpace + cEntity + cSpace +
                         cLgShort[ TAH.DisLanguage ] + cPeriod + HtmlExt +
                         cDQuote + cAnr + MyNeu + AETAG;
      if ( IsGoodFem ) then
      begin
        AnItem.Value := MyFem;
        Inc( NbGoodFem );
      end else
        AnItem.Value := TAH.GetLabel( reTestFound, False ) + cSpace +
                        MyMasc + cSpace +
                        TAH.GetLabel( reTestInstead, False ) + cSpace + MyFem;
      AddItem( AnItem );

      // Second line of results
      if ( ( MyPlus <> MyMasc ) and
           ( MyPlus2 <> cEmpty ) and
           ( Self.SectionType = sc_TestLatExp ) ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := cEmpty;
        if ( IsGoodPlus ) then
          AnItem.Value := MyPlus
        else
          AnItem.Value := TAH.GetLabel( reTestFound, False ) + cSpace +
                          MyPlus + cSpace +
                          TAH.GetLabel( reTestInstead, False ) + cSpace +
                          MyPlus2;
        AddItem( AnItem );

      end;

      // Display a comment
      if ( MyNeu <> cEmpty ) then
      begin
        TID := StrToInt( MyNeu );
        MyComment := TAH.Comments.GetCommentByTID( TID, TAH.MainLang,
                                                   Self.SectionType );
        if ( MyComment <> nil ) then
        begin
          AnItem := tBiColItem.Create;
          MyText := MyComment.Comment;
          MyText := MyComment.MakeHyperlinks( MyText, TAH.MainLang );
          AnItem.Value := MyText;
          AddItem( AnItem );
        end;
      end;
    end else

    // Syntax tests
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := MyMasc;
      if ( ( not IsGoodFem ) and ( IsGoodNeu ) ) then
        AnItem.Value := MyFem + cSpace + JustifFem
      else
      if ( not IsGoodFem ) and ( IsGoodNeu ) then
        AnItem.Value := MyNeu + cSpace + JustifNeu
      else
        AnItem.Value := JustifFem + cSpace + JustifNeu + cSpace + JustifPlus;
      AddItem( AnItem );
    end;
  end; // for on all available tests

  // 5. Summarize the test
  // =====================
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := TAH.GetLabel( reTestResult, False );
  AnItem.AltLabel := TAH.GetBubble( reTestResult );
  if ( NbGoodFem < NbTest ) then
    AnItem.Value := IntToStr( NbTest - NbGoodFem - NbGoodNeu ) +
                    cSpace + TAH.GetLabel( reTestFail, False )
  else
    AnItem.Value := TAH.GetLabel( reTestSuccess, False );
  AddItem( AnItem );
end; // ______________________________________________________tTestSection.Build

procedure          tRuleSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tRuleSection.Build
  * Display the rules applicable to the test, for any language *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
type
  tAdjRuGender     = Array[ 1 .. 50, ge_masculine .. ge_neuter ] of String;
var
  Indx:            Integer;
  NbRule:          Integer;
  MyTID:           Integer;
  MyMasc:          String;
  MyFem:           String;
  MyNeu:           String;
  MyModel:         String;
  ExplResult:      String;
  Actual:          tEntity;
  Lang:            tLanguage;
  AdjRuGender:     tAdjRuGender;
  AnItem:          tBiColItem;
begin

  // Retrieve the list of rules according to test and language
  Lang := TAH.MainLang;
  NbRule := Self.GetNbRule;
  case Lang of
    lt_English:
      begin
        for Indx := 1 to NbRule do
        begin
          AdjRuGender[ Indx, ge_masculine ] :=
            cNounRuPluralEN[ Indx, nu_sin ];
          AdjRuGender[ Indx, ge_feminine ] :=
            cNounRuPluralEN[ Indx, nu_plu ];
        end; // for on all available rules
      end;
    lt_French:
      begin
        case Self.SectionType of
          sc_RuleAdjGender:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                  cAdjRuGenderFR[ Indx, ge_masculine ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cAdjRuGenderFR[ Indx, ge_feminine ];
              end; // for on all available rules
            end;
          sc_RuleNounGender:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                  cNounRuGenderFR[ Indx, va_word ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cNounRuGenderFR[ Indx, va_1 ];
              end; // for on all available rules
            end;
          sc_RuleWordPlural:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                  cWordRuPluralFR[ Indx, nu_sin ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cWordRuPluralFR[ Indx, nu_plu ];
              end; // for on all available rules
            end;
          sc_RuleAdjExp:
            begin
              for Indx := 1 to NbRule do
              begin
                MyTID := StrToInt( cAdjRuExpFR[ Indx, 1 ] );
                AdjRuGender[ Indx, ge_masculine ] := cAdjRuExpFR[ Indx, 1 ];
                MyModel := cAdjRuExpFR[ Indx, 2 ];
                Actual := TAH.GetEntityByTID( MyTID );
                AdjRuGender[ Indx, ge_feminine ] :=
                  cAdjRuExpFR[ Indx, 2 ] + cSpace +
                  Actual.GetLibelle( lb_Official, Lang, st_mod, True, False );
                // AdjRuGender[ Indx, ge_feminine ] :=
                //   AdjRuExpFR[ Indx, nu_plu ];
              end; // for on all available rules
            end;
        end; // case on all section types
      end;
    lt_Spanish:
      begin
        case Self.SectionType of
          sc_RuleAdjExp:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                cAdjRuGenderES[ Indx, ge_masculine ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cAdjRuGenderES[ Indx, ge_feminine ];
              end; // for on all available rules
            end;
          sc_RuleNounPlural:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                  cWordRuPluralES[ Indx, nu_sin ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cWordRuPluralES[ Indx, nu_plu ];
              end; // for on all available rules
            end;
        end;
      end;
    lt_Russian:
      begin
        case Self.SectionType of
          sc_RuleNounGender:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                  cNounRuGenderRU[ Indx, ge_masculine ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cNounRuGenderRU[ Indx, ge_feminine ];
              end; // for on all available rules
            end;
          sc_RuleAdjGender:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                  cAdjRuGenderRU[ Indx, ge_masculine ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cAdjRuGenderRU[ Indx, ge_feminine ];
                AdjRuGender[ Indx, ge_neuter ] :=
                  cAdjRuGenderRU[ Indx, ge_neuter ];
              end;
            end;
          sc_RuleNounPlural:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                  cNounRuPluralRU[ Indx, nu_sin ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cNounRuPluralRU[ Indx, nu_plu ];
              end; // for on all available rules
            end;
          sc_RuleAdjPlural:
            begin
              for Indx := 1 to NbRule do
              begin
                AdjRuGender[ Indx, ge_masculine ] :=
                  cAdjRuPluralRU[ Indx, nu_sin ];
                AdjRuGender[ Indx, ge_feminine ] :=
                  cAdjRuPluralRU[ Indx, nu_plu ];
              end; // for on all available rules
            end;
        end; // for on all available rules
      end;
  end;

  // Write heading
  AnItem := tBiColItem.Create;
  if ( Self.SectionType = sc_RuleAdjGender ) then
    AnItem.SrcLabel := 'Rules for adjectives gender'
  else
  if ( Self.SectionType = sc_RuleNounGender ) then
    AnItem.SrcLabel := TAH.GetLabel( reTestTotRules, False )
  else
  if ( Self.SectionType = sc_RuleWordPlural ) then
    AnItem.SrcLabel := 'Rules for nouns and adjectives at plural'
  else
  if ( Self.SectionType = sc_RuleNounPlural ) then
    AnItem.SrcLabel := 'Rules for nouns at plural'
  else
  if ( Self.SectionType = sc_RuleAdjPlural ) then
    AnItem.SrcLabel := 'Rules for adjectives at plural'
  else
  if ( Self.SectionType = sc_RuleAdjExp ) then
    AnItem.SrcLabel := 'Models for adjective expansion';
  AnItem.Value := IntToStr( NbRule ) + cSpace +
                  TAH.GetLabel( reTestEntries, False );
  AddItem( AnItem );

  // Loop on all the rules
  for Indx := 1 to NbRule do
  begin
    MyMasc := AdjRuGender[ Indx, ge_masculine ];
    MyFem := AdjRuGender[ Indx, ge_feminine ];
    MyNeu := AdjRuGender[ Indx, ge_neuter ];

    // Prepare explicite value
    if ( Self.SectionType = sc_RuleNounGender ) then
    begin
      ExplResult := cEmpty;
      if ( MyFem = 'm' ) then
        ExplResult := TAH.GetLabel( reTestMasculine, False )
      else
      if ( MyFem = 'f' ) then
        ExplResult := TAH.GetLabel( reTestFeminine, False )
      else
      if ( MyFem = 'n' ) then
        ExplResult := TAH.GetLabel( reTestNeuter, False );
    end;

    // Display the rule
    AnItem := tBiColItem.Create;
    if ( Self.SectionType = sc_RuleAdjExp ) then
    begin
      AnItem.SrcLabel := MyMasc;
      AnItem.Value := MyFem;
    end else
    if ( Self.SectionType = sc_RuleNounGender ) then
    begin
      if ( Indx = NbRule ) then
      begin
        AnItem.SrcLabel := TAH.GetLabel( reTestDefault, False );
        AnItem.Value := ExplResult;
      end else
      begin
        AnItem.SrcLabel := MyMasc;
        AnItem.Value := ExplResult;
      end;
    end else
    begin
      AnItem.SrcLabel := MyMasc + cSpace + IntToStr( Indx );
      AnItem.Value := MyFem + cSpace + MyNeu;
    end;
    AddItem( AnItem );
  end; // for on all rules of the test
end; // ______________________________________________________tRuleSection.Build

procedure          tFreeTestSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tFreeTestSection.Build
  * Make a Free test section for any language *
  Description:
  This procedure builds a free test section on gender of adjectives valid in all
  languages. In free test, the list of adjectives is available at masculine,
  and the validated feminine is not available. The test generates the feminine
  form, but the validation is left to the user.</p>
  A count of all entries by rule and exceptions is realized:
  - 0 to NbRule - 1: entries by rules
  - NbRule + 0: default
  - NbRule + 1: exceptions masculin
  - NbRule + 2: exceptions feminin
  - NbRule + 3: exceptions neuter
  - NbRule + 4: exceptions plus
  - NbRule + 5: failures.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
type
  tRuleAdjExp      = Array[ 1 .. 50, 1 .. 2 ] of String;
var
  Indx:            Integer;
  Indy:            Integer;
  Indz:            Integer;
  NbTest:          Integer;
  NbRule:          Integer;
  NbGoodFem:       Integer;
  NbGoodNeu:       Integer;
  IdentFem:        Integer;
  IdentNeu:        Integer;
  Posit:           Integer;
  CountRule:       Integer;
  CountMasc:       Integer;
  CountFem:        Integer;
  CountNeu:        Integer;
  AValue:          Integer;
  TID:             Integer;
  MyCount:         Integer;
  PosDefault:      Integer;
  MyStat:          Array of Integer;
  IsRuleFem:       Boolean;
  IsRuleNeu:       Boolean;
  MyWord:          String;
  Before:          String;
  MyMasc:          String;
  MyFem:           String;
  MyNeu:           String;
  MyPlus:          String;
  MyAdj:           String;
  MyPref:          String;
  MyUID:           String;
  MyValue:         String;
  MyModel:         String;
  MyLibUni:        String;
  MyLibBas:        String;
  PosModel:        String;
  MyReason:        String;
  ExplResult:      String;
  ValDefault:      String;
  MyList:          TStringList;
  Lang:            tLanguage;
  AnItem:          tBiColItem;
  MyEntity:        tEntity;
  Actual:          tEntity;
  MyUnit:          tUnit;
  NounCase:        tNounCase;
  AdjCase:         tAdjCase;
  MySingle:        tSingle;
  VocUnit:         tUnit;
  RuleAdjExp:      tRuleAdjExp;
  MySection:       tRuleSection;
begin

  // 1. Retrieve the number of rules and the models for formula
  // ==========================================================
  MyList := TStringList.Create;
  Lang := TAH.MainLang;
  MySection := tRuleSection.Create;
  MySection.SectionType := Self.SectionType;
  NbRule := MySection.NbRule;

  // Preset the statistical counters
  SetLength( MyStat, NbRule + 5 );
  for Indx := 0 to NbRule + 5 do
    MyStat[ Indx ] := 0;

  // Find a default rule
  if ( Self.SectionType in [ sc_FreeNounGender ] ) then
  begin
    for Indx := 1 to NbRule do
    begin
      case Lang of
        lt_French:
          begin
            if ( cNounRuGenderFR[ Indx, va_word ] = cEmpty ) then
            begin
              PosDefault := Indx;
              ValDefault := cNounRuGenderFR[ Indx, va_1 ];
              Break;
            end;
          end;
      end; // on all languages
    end; // for on all rules
  end;

  // Retrieve the models for adjective expansion
  if ( Self.SectionType = sc_FreeAdjExp ) then
  begin
    for Indx := 1 to NbRule do
    begin
      RuleAdjExp[ Indx, 1 ] := cAdjRuExpFR[ Indx, 1 ];
      RuleAdjExp[ Indx, 2 ] := cAdjRuExpFR[ Indx, 2 ];
    end; // for on all available rules
  end;

  // 2. Retrieve all applicable items
  // ================================
  for Indx := 1 to 24999 do
  begin
    MyUnit := TAH.GetUnitByPos( Indx );
    if ( MyUnit = nil ) then
      Continue;
    MyEntity := TAH.GetEntityByTID( Indx );
    if ( MyEntity = nil ) then
      Continue;
    if ( Indx = 12261 ) then  // debug only
      TID := TID;

    // Management of free adjective expansion
    MyWord := cEmpty;
    if ( SectionType = sc_FreeAdjExp ) then
    begin
      MySingle := MyEntity.GetStructuredTerm( lb_Universal, lt_Universal,
                                              st_mod );
      if ( MySingle = nil ) then
        Continue;

      // Retrieve the adjective
      TID := MySingle.Adjective;
      if ( TID = 0 ) then
        Continue;
      VocUnit := TAH.GetUnitByPos( TID );
      if ( ( VocUnit <> nil ) and ( VocUnit.Vocabulary > 0 ) ) then
      begin
        Actual := TAH.GetEntityByTID( VocUnit.Vocabulary );
        if ( Actual <> nil ) then
          MyAdj := Actual.GetVocabulary( Lang, st_Adj );
      end;

      // Retrieve the prefix if any
      TID := MySingle.Prefix;
      if ( TID <> 0 ) then
      begin
        VocUnit := TAH.GetUnitByPos( TID );
        if ( ( VocUnit <> nil ) and ( VocUnit.Vocabulary > 0 ) ) then
        begin
          Actual := TAH.GetEntityByTID( VocUnit.Vocabulary );
          if ( Actual <> nil ) then
            MyPref := Actual.GetVocabulary( Lang, st_Pre );
        end;
        MyAdj := MyPref + MyAdj;
      end;

      // Defines all values to be stored for subsequent sort
      MyModel := MySingle.GetModelFormula;
      MyLibUni := MyEntity.GetLibelle( lb_Universal, Lang, st_for, True, False);
      MyLibBas := MyEntity.GetLibelle( lb_Universal, Lang, st_bas, True, False);
      MyWord := MyModel + cSpace + MyLibUni;
      if ( MyLibUni <> MyLibBas ) then
        MyWord := MyWord + cSpace + '->' + cSpace + MyLibBas;

      // Compare to the available models
      PosModel := 'x';
      for Indz := 1 to NbRule do
      begin
        if ( RuleAdjExp[ Indz, 2 ] = MyModel ) then
          PosModel := IntToStr( Indz );
      end; // on all models
    end else // work on section sc_FreeAdjExp

    // General management of any section
    if ( MyUnit.TypUnit = tt_voc ) then
    begin
      case SectionType of
        sc_FreeAdjGender, sc_FreeAdjPlural, sc_FreeAdjGenSin, sc_FreeAdjGenPlu:
          MyWord := MyEntity.GetVocabulary( Lang, st_Adj );
        sc_FreeNounGender, sc_FreeNounPlural, sc_FreeNounGenSin,
        sc_FreeNounGenPlu:
          MyWord := MyEntity.GetVocabulary( Lang, st_Nou );
      end;
    end;

    // Discard non applicable entities
    if ( MyWord = cEmpty ) then
      Continue;

    // Store the retrieved values for subsequent sort
    if ( SectionType = sc_FreeAdjExp ) then
    begin
      if ( MyWord <> cEmpty ) then
        MyList.Add( MyAdj + cSpace + IntToStr( Indx ) + CurSep +
                    PosModel + cSpace + MyWord );
    end else
    begin
      MyList.Add( MyWord + cSpace + IntToStr( Indx ) + CurSep +
                  MyWord );
    end;
  end; // for on all units, selecting the vocabulary units

  // 3. Sort the list of found items
  // ===============================
  MyList.Sort;
  NbTest := MyList.Count;
  Self.NbTest := NbTest;

  // 4. Write heading on first line
  // ==============================
  Self.SetFreeHeading;

  // 5. Compute all items
  // ====================
  Before := cEmpty;
  CountMasc := 0;
  CountFem := 0;
  CountNeu := 0;
  MyCount := 0;
  for Indx := 0 to NbTest - 1 do
  begin

    // Retrieve next entry and discard duplicates
    MyMasc := MyList.Strings[ Indx ];
    Posit := Pos( CurSep, MyMasc );
    MyWord := Copy( MyMasc, Posit + 1, Length( MyMasc ) );
    MyMasc := Copy( MyMasc, 1, Posit - 1 );
    Posit := Pos( cSpace, MyMasc );
    if ( Posit > 0 ) then
      MyUID := Copy( MyMasc, Posit + 1, Length( MyMasc ) );
    if ( MyWord = Before ) then
    begin
      Inc( MyCount );
      Continue;
    end;
    Before := MyWord;
    MyFem := cEmpty;

    // Check for gender, number or case
    IsRuleFem := False;
    IdentFem := 0;
    IsRuleNeu := False;
    IdentNeu := 0;
    case Lang of
      lt_Latin:
        begin
          case SectionType of
          sc_FreeNounGender:
            begin
              GetNounLA( MyWord, NounCase );
              MyFem := NounCase[ 5 ];
            end;
          sc_FreeAdjGender:
            begin
              GetAdjectiveLA( MyWord, AdjCase );
              if ( AdjCase[ 1 ] <> cEmpty ) then
              begin
                MyFem := AdjCase[ 5 ];
                MyNeu := AdjCase[ 9 ];
              end else
              begin
                MyFem := cEmpty;
                MyNeu := cEmpty;
              end;
            end;
          sc_FreeNounPlural:
            begin
              GetNounLA( MyWord, NounCase );
              if ( NounCase[ 1 ] <> cEmpty ) then
                MyFem := NounCase[ 3 ];
              MyNeu := cEmpty;
              MyPlus := cEmpty;
            end;
          sc_FreeAdjPlural:
            begin
              GetAdjectiveLA( MyWord, AdjCase );
              if ( AdjCase[ 1 ] <> cEmpty ) then
              begin
                MyFem := AdjCase[ 3 ];
                MyNeu := AdjCase[ 7 ];
                MyPlus := AdjCase[ 11 ];
              end;
            end;
          sc_FreeNounGenSin:
            begin
              GetNounLA( MyWord, NounCase );
              if ( NounCase[ 1 ] <> cEmpty ) then
                MyFem := NounCase[ 2 ];
            end;
          sc_FreeAdjGenSin:
            begin
              GetAdjectiveLA( MyWord, AdjCase );
              if ( AdjCase[ 1 ] <> cEmpty ) then
              begin
                MyFem := AdjCase[ 2 ];
                MyNeu := AdjCase[ 6 ];
                MyPlus := AdjCase[ 10 ];
              end;
            end;
          sc_FreeNounGenPlu:
            begin
              GetNounLA( MyWord, NounCase );
              if ( NounCase[ 1 ] <> cEmpty ) then
                MyFem := NounCase[ 4 ];
            end;
          sc_FreeAdjGenPlu:
            begin
              GetAdjectiveLA( MyWord, AdjCase );
              if ( AdjCase[ 1 ] <> cEmpty ) then
              begin
                MyFem := AdjCase[ 4 ];
                MyNeu := AdjCase[ 8 ];
                MyPlus := AdjCase[ 12 ];
              end;
            end;
          end; // case on Latin sections
        end;
      lt_English:
        begin
          case SectionType of
          sc_FreeNounPlural:
            begin
              MyFem := TestNounPluralEN( MyWord, IsRuleFem, IdentFem );
            end;
          end; // case on English sections
        end;
      lt_French:
        begin
          case SectionType of
          sc_FreeAdjGender:
            begin
              MyFem := TestAdjectiveGenderFR
                       ( ge_feminine, MyWord, IsRuleFem, IdentFem );
            end;
          sc_FreeNounGender:
            begin
              MyFem := TestNounGenderFR( MyWord, IsRuleFem, IdentFem );
              if ( IdentFem = PosDefault ) then
                IdentFem := 0;
            end;
          sc_FreeNounPlural:
            begin
              MyFem := TestNounPluralFR( MyWord, IsRuleFem, IdentFem );
            end;
          sc_FreeAdjPlural:
            begin
              MyFem := TestAdjPluralFR( MyWord, IsRuleFem, IdentFem );
              MyPlus := TestAdjectiveGenderFR( ge_feminine, MyWord,
                                               IsRuleNeu, IdentNeu );
              MyNeu := TestAdjPluralFR( MyPlus, IsRuleNeu, IdentNeu );
            end;
          sc_FreeAdjExp:
            begin
              Posit := Pos( cSpace, MyWord );
              PosModel := Copy( MyWord, 1, Posit - 1 );
              if ( PosModel <> 'x' ) then
                IdentFem := StrToInt( PosModel );
              MyFem := Copy( MyWord, Posit + 1, Length( MyWord ) );
              MyNeu := cEmpty;
              MyPlus := cEmpty;
            end;
          end; // case on French sections
        end;
      lt_Spanish:
        begin
          case SectionType of
            sc_FreeAdjExp:
              begin
                MyFem := TestAdjectiveGenderES
                         ( ge_feminine, MyWord, IsRuleFem, IdentFem );
              end;
            sc_FreeNounPlural:
              begin
                MyFem := TestNounPluralES( MyWord, IsRuleFem, IdentFem );
              end;
          end;
        end;
      lt_Russian:
        begin
          case SectionType of
            sc_FreeAdjGender:
              begin
                MyFem := TestAdjectiveGenderRU
                         ( ge_feminine, MyWord, IsRuleFem, IdentFem );
                MyNeu := TestAdjectiveGenderRU
                         ( ge_neuter, MyWord, IsRuleNeu, IdentNeu );
              end;
            sc_FreeNounGender:
              begin
                MyFem := TestNounGenderRU ( MyWord, IsRuleFem, IdentFem );
              end;
            sc_FreeNounPlural:
              begin
                MyFem := TestNounPluralRU( MyWord, IsRuleFem, IdentFem );
              end;
            sc_FreeAdjPlural:
              begin
                MyFem := TestAdjPluralRU( MyWord, IsRuleFem, IdentFem );
              end;
          end; // case on Russian sections
        end;
    end; // case

    // 6. Display the results
    // ======================
    if ( MyUID = '8360' ) then
      MyUID := MyUID;
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := MyMasc;
    if ( SectionType = sc_FreeAdjExp ) then
      AnItem.SrcLabel := MyUID;

    // Prepare an explicite value
    ExplResult := cEmpty;
    if ( MyFem = 'm' ) then
      ExplResult := TAH.GetLabel( reTestMasculine, False )
    else
    if ( MyFem = 'f' ) then
      ExplResult := TAH.GetLabel( reTestFeminine, False )
    else
    if ( MyFem = 'n' ) then
      ExplResult := TAH.GetLabel( reTestNeuter, False );

    // Display a rule generated value without neutral value
    MyValue := cEmpty;
    NbGoodFem := 0;
    if ( ( MyFem <> cEmpty ) and ( IdentFem > 0 ) ) then
    begin
      if ( ( IdentNeu = 0 ) or ( SectionType = sc_FreeAdjPlural ) ) then
      begin
        MyReason := TAH.GetLabel( reTestByRule, False );
        if ( SectionType = sc_FreeAdjExp ) then
          MyReason := 'by model';
        if ( not IsRuleFem ) then
          MyReason := TAH.GetLabel( reTestByDefault, False );
        if ( SectionType = sc_FreeNounGender ) then
        begin
          if ( MyFem = 'm' ) then
            Inc( CountMasc )
          else
          if ( MyFem = 'f' ) then
            Inc( CountFem )
          else
          if ( MyFem = 'n' ) then
            Inc( CountNeu );
          MyValue := ExplResult + cSpace + MyReason + cSpace +
                     IntToStr( IdentFem );
          Inc( MyStat[ IdentFem - 1 ] );
        end;
        if ( SectionType = sc_FreeNounPlural ) then
        begin
          if ( MyFem = 's' ) then
            Inc( CountMasc )
          else
          if ( MyFem = 'p' ) then
            Inc( CountFem );
        end;
        if ( SectionType = sc_FreeAdjPlural ) then
        begin
          if ( MyFem = 's' ) then
            Inc( CountMasc )
          else
          if ( MyFem = 'p' ) then
            Inc( CountFem );
        end;
      end;
      Inc( NbGoodFem );
    end else

    // Display a default generated value
    if ( ( MyFem <> cEmpty ) and ( IdentFem = 0 ) ) then
    begin
      if ( ( ( SectionType = sc_FreeNounGender ) and ( Lang = lt_Latin ) ) or
           ( ( SectionType = sc_FreeAdjGender ) and ( Lang = lt_Latin ) ) or
           ( ( SectionType = sc_FreeAdjPlural ) and ( Lang = lt_Latin ) ) ) then
      begin
        if ( MyFem = 'm' ) then
          Inc( CountMasc )
        else
        if ( MyFem = 'f' ) then
          Inc( CountFem )
        else
        if ( MyFem = 'n' ) then
          Inc( CountNeu );
      end else
      if ( ( SectionType = sc_FreeAdjPlural ) or
           ( ( SectionType = sc_FreeNounPlural ) and
             ( Lang = lt_English ) ) ) then
      begin
        if ( IsRuleFem ) then
        begin
          MyValue := ExplResult + cSpace +
                     TAH.GetLabel( reTestByDefault, False );
          Inc( MyStat[ NbRule ] );
        end else
        begin
          if ( SectionType <> sc_FreeAdjExp ) then
            MyValue := ExplResult + cSpace +
                       TAH.GetLabel( reTestByExcept, False );
          Inc( MyStat[ NbRule + 1 ] );
        end;
      end else
      if ( ( IdentNeu = 0 ) or
           ( SectionType = sc_FreeNounGender ) ) then
      begin
        if ( IsRuleFem ) then
        begin
          MyValue := ExplResult + cSpace +
                     TAH.GetLabel( reTestByDefault, False );
          Inc( MyStat[ NbRule ] );
          Inc( CountMasc );
        end else
        begin
          MyValue := ExplResult + cSpace +
                     TAH.GetLabel( reTestByExcept, False );
          if ( MyFem = 'm' ) then
          begin
            Inc( MyStat[ NbRule + 1 ] );
            Inc( CountMasc );
          end else
          if ( MyFem = 'f' ) then
          begin
            Inc( MyStat[ NbRule + 2 ] );
            Inc( CountFem );
          end;
        end;
      end else
      if ( ( IdentNeu = 0 ) or
           ( ( SectionType = sc_FreeNounPlural ) and
             ( Lang <> lt_English ) ) ) then
      begin
        MyValue := ExplResult + cSpace + TAH.GetLabel( reTestByDico, False );
      end;
      Inc( NbGoodFem );
    end;

    // Display with a neutral value
    NbGoodNeu := 0;
    if ( MyNeu <> cEmpty ) then
    begin
      if ( ( ( SectionType = sc_FreeNounGender ) and ( Lang = lt_Latin ) ) or
           ( ( SectionType = sc_FreeAdjGender ) and ( Lang = lt_Latin ) ) or
           ( ( SectionType = sc_FreeAdjPlural ) and ( Lang = lt_Latin ) ) ) then
      begin
        MyValue := MyValue + cSpace + MyNeu;
      end else
      if ( ( MyNeu <> cEmpty ) and ( IdentNeu > 0 ) and ( MyNeu <> MyFem ) ) then
      begin
        MyValue := ExplResult + cSpace + MyNeu + cSpace +
                   TAH.GetLabel( reTestByExcept, False ) + cSpace +
                   IntToStr( IdentNeu );
        Inc( MyStat[ IdentNeu - 1 ] );
        Inc( NbGoodNeu );
      end else
      if ( ( MyNeu <> cEmpty ) and ( IdentNeu = 0 ) ) then
      begin
        MyValue := ExplResult + cSpace + MyNeu + cSpace +
                   TAH.GetLabel( reTestByExcept, False );
        Inc( NbGoodNeu );
      end;
    end;

    // Display with a plus value
    NbGoodNeu := 0;
    if ( MyPlus <> cEmpty ) then
    begin
      if ( ( SectionType = sc_FreeAdjPlural ) and ( Lang = lt_Latin ) ) then
      begin
        MyValue := ExplResult + cSpace + MyPlus + cSpace +
                   TAH.GetLabel( reTestByDico, False );
      end;
    end;

    // Absence of value
    if ( MyFem = cEmpty ) then
    begin
      MyValue := 'not found';
      Inc( MyStat[ NbRule + 5 ] );
    end;

    AnItem.Value := MyValue;
    AddItem( AnItem );
  end; // for on all found entries

  // 7. Display the summary statistics
  // =================================
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := TAH.GetLabel( reTestStatistics );
  AnItem.Value := cEmpty;
  AddItem( AnItem );
  if ( ( not ( SectionType in [ sc_FreeNounGender ] ) ) and
       ( Lang <> lt_Latin ) ) then
  begin
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Number of rules';
    AnItem.Value := IntToStr( NbRule );
    AddItem( AnItem );
    CountRule := 0;
    for Indy := 0 to NbRule - 1 do
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := 'Rule' + cSpace + IntToStr( Indy + 1 );
      AnItem.Value := IntToStr( MyStat[ Indy ] );
      Inc( CountRule, MyStat[ Indy ] );
      AddItem( AnItem );
    end; // for on all rules
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Total by rules';
    AnItem.Value := IntToStr( CountRule );
    AddItem( AnItem );
  end else
  if ( SectionType = sc_FreeNounGender ) then
  begin
    for Indx := 1 to NbRule - 1 do
    begin
      if ( cNounRuGenderFR[ Indx, va_1 ] = 'm' ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := TAH.GetLabel( reTestByRule, False ) + cSpace +
                           IntToStr( Indx );
        AnItem.Value := IntToStr( MyStat[ Indx - 1 ] );
        AddItem( AnItem );
      end;
    end; // on all masculine rules
    if ( ValDefault = 'm' ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reTestByDefault, False );
      AnItem.Value := IntToStr( MyStat[ NbRule ] );
      AddItem( AnItem );
    end;
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reTestExcMasc, False );
    AnItem.Value := IntToStr( MyStat[ NbRule + 1 ] );
    AddItem( AnItem );
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reTestTotMasc, False );
    AnItem.Value := BTAG + IntToStr( CountMasc ) + BETAG;
    AddItem( AnItem );
    for Indx := 1 to NbRule - 1 do
    begin
      if ( cNounRuGenderFR[ Indx, va_1 ] = 'f' ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := TAH.GetLabel( reTestByRule, False ) + cSpace +
                           IntToStr( Indx );
        AnItem.Value := IntToStr( MyStat[ Indx - 1 ] );
        AddItem( AnItem );
      end;
    end; // on all feminine rules
    if ( ValDefault = 'f' ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reTestByDefault, False );
      AnItem.Value := IntToStr( MyStat[ NbRule ] );
      AddItem( AnItem );
    end;
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reTestExcFem, False );
    AnItem.Value := IntToStr( MyStat[ NbRule + 2 ] );
    AddItem( AnItem );
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reTestTotFem, False );
    AnItem.Value := BTAG + IntToStr( CountFem ) + BETAG;
    AddItem( AnItem );
    if ( Lang in [ lt_Latin, lt_Russian ] ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := 'Total neuter';
      AnItem.Value := IntToStr( CountNeu );
      AddItem( AnItem );
    end;
  end;
  if ( MyStat[ NbRule + 4 ] > 0 ) then
  begin
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Number of failures';
    AnItem.Value := IntToStr( MyStat[ NbRule + 2 ] );
    AddItem( AnItem );
  end;
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := TAH.GetLabel( reTestValid, False );
  AValue := 0;
  if ( ( ( SectionType = sc_FreeadjGender ) and ( Lang = lt_Latin ) ) or
       ( ( SectionType = sc_FreeNounPlural ) and ( Lang = lt_Latin ) ) or
       ( ( SectionType = sc_FreeAdjPlural ) and ( Lang = lt_Latin ) ) or
       ( ( SectionType = sc_FreeNounGenSin ) and ( Lang = lt_Latin ) ) or
       ( ( SectionType = sc_FreeAdjGenSin ) and ( Lang = lt_Latin ) ) or
       ( ( SectionType = sc_FreeNounGenPlu ) and ( Lang = lt_Latin ) ) or
       ( ( SectionType = sc_FreeAdjGenPlu ) and ( Lang = lt_Latin ) ) ) then
  begin
    AValue := NbTest - MyStat[ NbRule + 2 ];
  end else
  if ( SectionType <> sc_FreeNounGender ) then
  begin
    AValue := MyStat[ NbRule ] + MyStat[ NbRule + 1 ] +
                              MyStat[ NbRule + 2 ] + CountRule
  end else
    AValue := CountMasc + CountFem + CountNeu;
  AnItem.Value := BTAG + IntToStr( AValue ) + BETAG;
  AddItem( AnItem );
  if ( SectionType <> sc_FreeNounPlural ) then
  begin
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reTestDuplic, False );
    AnItem.Value := IntToStr( NbTest - AValue );
    AddItem( AnItem );
  end;
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := TAH.GetLabel( reTestTotal, False );
  AnItem.Value := IntToStr( NbTest );
  AddItem( AnItem );
end; // __________________________________________________tFreeTestSection.Build

procedure          tTermDesignSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTermDesignSection.Build
  * Make a Term Design section for a Latin term *
  Description:
  This method builds the term design section, which describes the way the term
  is built from the basic text contributions and the applicable expansions.
  This kind of analysis is available only for Latin terms. It is intended
  to guide the translation of terms in different vernacular languages.</P>
  In this model of anatomical terminology, it has been decided to never
  duplicate the lexical information of any term. This means that each time a
  term is built from another term, this is done by programmatic expansion. In
  other word the other terms are always specified by their identifiers. This
  approach insures a maximum of coherence, a minimum of raw lexical information
  and consequently a minimum of lexical errors.</P>
  The expansion process is based on noun groups. Each noun is considered to
  form a group together with possible associated adjectives (and a possible
  unfrequent invariant). A term is composed of a basic noun group and a number
  of expansions, that are noun groups issued from other terms. A mandatory
  expansion is permanently associated to a basic term and an optional expansion
  is only occasionally present depending on the context.</P>
  At the syntax level, at least for Latin and other western languages,
  expansions are expressed as genitive. In noun groups, rules of gender and
  number are applicable. The syntax is evidently language dependant.</P>
  Any term may be exist in different types, that are defined elsewhere. The
  type of term governs: 1) the number of a term; 2) the expression of
  laterality.</P>
  This modeling process is exclusively restricted to Regular Anatomical
  Terms (RAT rules). It is dependant on a Latin dictionary of anatomical
  words, presently made of some 4000 entries, covering the entire TA.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyObl:           Integer;
  MyOpt:           Integer;
  MyAdj:           Integer;
  MyPref:          Integer;
  Level:           Integer;
  MyTerm:          String;
  MyRaw:           String;
  Value:           String;
  Generated:       String;
  LinkText:        String;
  Formula:         String;
  OptFormula:      String;
  PrefPart:        String;
  MandatPart:      String;
  AdjPart:         String;
  OptPart:         String;
  BaseFormula:     String;
  Actual:          tEntity;
  MyEntity:        tEntity;
  AnItem:          tBiColItem;
  LAModelBase:     tSingle;
  LAModelOpt:      tSingle;
  MySingle:        tSingle;
  MyUnit:          tTetrahedron;
begin
  // Initial stuff
  Actual := Self.Entity;
  if ( ( Actual <> nil ) and ( Actual.Reference = 0 ) ) then
  begin

    // Retrieve and display the term to be modeled
    MyTerm := Actual.GetLibelle( lb_Universal, lt_Latin, st_for );
    if ( MyTerm = cEmpty ) then
      Exit;
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := paOriginTerm[ en ];
    AnItem.AltLabel := baOriginTerm[ en ];
    AnItem.Value := MyTerm;
    AnItem.Indent := cBaseIndent;
    AnItem.Color := lt_Latin;
    AddItem( AnItem );

    // 1. Basic part of the term, mandatory
    //    =================================

    // Source entity
    Actual.LgCurrent := lt_Latin;
    Actual.Query := tSearch.Create( st_For );
    Actual.SearchTerm;
    LAModelBase := Actual.CurrSingle;
    if ( LAModelBase = nil ) then
      Exit;
    MyAdj := LAModelBase.Adjective;
    MyPref := LAModelBase.Prefix;
    MyObl := LAModelBase.Obl;
    MyOpt := LAModelBase.Exp;
    Generated := LAModelBase.Mandat;
    MyRaw := LAModelBase.Libelle;
    Value := cTAH + IntToStr( Actual.TID ) + cSpace + MyRaw;
    LinkText := cHrefEmpty + cRetroDir + cEntity + cSpace +
                cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                IntToStr( Actual.TID ) + cSpace + cEntity + cSpace +
                cLgShort[ TAH.SubstLang ] + cPeriod + HtmlExt + cDQuote + cAnr;

    // Prepare the basic contribution
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := paBasicPart[ en ];
    AnItem.AltLabel := baBasicPart[ en ];
    AnItem.Value := Value;
    AnItem.Url := LinkText;
    AnItem.Color := lt_Latin;
    AnItem.Indent := cBaseIndent;
    AddItem( AnItem );

    // Build and display composition of the base raw term
    if ( LAModelBase <> nil ) then
    begin
      Actual.LgCurrent := lt_Universal;
      Actual.Query := TSearch.Create( st_Mod );
      Actual.SearchTerm;
      MySingle := Actual.CurrSingle;
      BaseFormula := cEmpty;
      if ( MySingle <> nil ) then
        BaseFormula := MySingle.Mandat;
      Level := 2;
      DisplayGroup( BaseFormula, Level );
    end;

    // 2. Mandatory adjective expansion of the term
    //    =========================================
    if ( MyAdj > 0 ) then
    begin
      MakeAdjExpansion( Actual.TID, MyAdj, MyPref, 1 );
      AdjPart := cRoL + IntToStr( MyAdj ) + cRor;
      if ( MyPref > 0 ) then
        PrefPart := cRoL + IntToStr( MyPref ) + cRor;
    end;

    // 3. Mandatory genitive expansion of the term
    //    ========================================
    if ( MyObl > 0 ) then
    begin
      MakeMandExpansion( Actual.TID, MyObl );
      MyEntity := TAH.GetEntityByTID( MyObl );
      MandatPart := cRoL + IntToStr( MyEntity.Tetra ) + cRor;
    end;

    // 4. Optional genitive expansion of the term
    //    =======================================
    OptFormula := cEmpty;
    if ( ( LAModelBase <> nil ) and
         ( MyOpt > 0 ) ) then
    begin

      // Global construct of optional expansion
      MyEntity := TAH.GetEntityByTID( MyOpt );
      MyUnit := TAH.GetTetrahedronByUID( MyOpt );
      OptPart := cRoL + IntToStr( MyEntity.Tetra ) + cRor;
      MyUnit.Genr.LgCurrent := lt_Latin;
      MyUnit.Genr.Query := tSearch.Create( st_For );
      MyUnit.Genr.SearchTerm;
      LAModelOpt := MyUnit.Genr.CurrSingle;
      if ( LAModelOpt <> nil ) then
      begin
        Value := cTAH + IntToStr( MyOpt ) + cSpace + Trim( LAModelOpt.Mandat );
        LinkText := cHrefEmpty + cRetroDir + cEntity + cSpace +
                    cLgShort[ lt_English ] + cSlash + cTAH +
                    IntToStr( MyOpt ) + cSpace + cEntity + cSpace +
                    cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr;

        // Prepare the optional contribution
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := paOptExpansion[ en ];
        AnItem.AltLabel := baOptExpansion[ en ];
        AnItem.Value := Value;
        AnItem.Color := lt_Latin;
        AnItem.Url := LinkText;
        AddItem( AnItem );

        // Explore the optional expansion
        MyEntity.LgCurrent := lt_Universal;
        MyEntity.Query := tSearch.Create( st_Mod );
        MyEntity.SearchTerm;
        MySingle := MyEntity.CurrSingle;
        BaseFormula := MySingle.Mandat;
        Level := 2;
        DisplayGroup( BaseFormula, Level );
        if ( MySingle <> nil ) then
        begin
          MakeAdjExpansion( Actual.TID, MySingle.Adjective,
                            MySingle.Prefix, Level );
        end;
      end;
    end;

    // Build the string universal formula
    Formula := BaseFormula;
    if ( PrefPart <> cEmpty ) then
      Formula := Formula + cComma + cAmpersand + cExpPref + PrefPart;
    if ( AdjPart <> cEmpty ) then
      Formula := Formula + cComma + cAmpersand + cExpAdj + AdjPart;
    if ( MandatPart <> cEmpty ) then
      Formula := Formula + cComma + cAmpersand + cExpMand + MandatPart;
    if ( OptPart <> cEmpty ) then
      Formula := Formula + cComma + cAmpersand + cExpOpt + OptPart;

    // Display the string formula of the term
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := paFormula[ en ];
    AnItem.AltLabel := baFormula[ en ];
    AnItem.Value := Formula;
    AnItem.Bubble := cEmpty;
    AnItem.Url := cEmpty;
    AnItem.Color := lt_Latin;
    AddItem( AnItem );
  end;
end; // ________________________________________________tTermDesignSection.Build

procedure          tWordAnalysisSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tWordAnalysisSection.Build
  * Make a word analysis section *
  Description:
  This procedure generates a word analysis section.</P>
  Considering a Latin term, it parses it with the Latin parser and the Latin
  dictionary. Then it considers all semantically relevant lexemes of the
  term and analyzes their declension. There is one display line for each
  lexeme present in the source term.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbAnal:          Integer;
  MyTerm:          String;
  Decoded:         String;
  Actual:          tEntity;
  AnItem:          tBiColItem;
  LatinTerm:       tTerm;
  MySingle:        tSingle;
begin
  // Initial stuff
  Actual := Self.Entity;
  if ( Actual <> nil ) then
  begin

    // Term analysis
    Actual.LgCurrent := lt_Latin;
    Actual.Query := tSearch.Create( st_Bas );
    Actual.SearchTerm;
    MySingle := Actual.CurrSingle;
    MyTerm := MySingle.Mandat + MySingle.Option;
    LatinTerm := TTerm.Create( MyTerm, lt_Latin );

    // Term to be analyzed
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Term to be analyzed';
    AnItem.AltLabel := 'The exact term that has been analyzed by the ' +
                       'Latin parser';
    AnItem.Value := MyTerm;
    AnItem.Color := lt_Latin;
    AddItem( AnItem );

    // Words and declension found in expanded term
    if ( LatinTerm.IsRegular ) then
    begin
      NbAnal := LatinTerm.NbWord;
      for Indx := 0 to NbAnal - 1 do
      begin
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := LatinTerm.Node[ Indx ].Wrd;
        AnItem.AltLabel := 'For each word of the term, the found syntax ' +
                            'analysis';
        DecodeDeclension( LatinTerm.Node[ Indx ].Cod, Decoded );
        AnItem.Value := Decoded;
        AnItem.Bubble := LatinTerm.Node[ Indx ].Cod;
        AnItem.Color := lt_Latin;
        AddItem( AnItem );
      end; // for on all lexemes of the term
    end else

    // Warning for unsuccessful analysis
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := 'Syntax error';
      AnItem.AltLabel := 'The Latin parser failed to analyzed the term';
      AnItem.Value := 'Unsuccessful term analysis';
      AnItem.Bubble := cEmpty;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;
  end;
end; // ______________________________________________tWordAnalysisSection.Build

procedure          tSyntaxSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tSyntaxSection.Build
  * Make a syntax section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbAnal:          Integer;
  Level:           Integer;
  MyLevel1:        Integer;
  MyLevel2:        Integer;
  IsPrefix1:       Boolean;
  IsPrefix2:       Boolean;
  IsIncr:          Boolean;
  MyTerm:          String;
  Link:            String;
  MyDecl:          String;
  PastDecl:        String;
  MyLine:          String;
  Graph:           String;
  MyPrefix1:       String;
  MyPrefix2:       String;
  Actual:          tEntity;
  AnItem:          tBiColItem;
  LatinTerm:       tTerm;
  MySingle:        tSingle;
begin
  // Initial stuff
  Actual := Self.Entity;
  if ( Actual <> nil ) then
  begin

    // Term analysis
    // MyTerm := Actual.GetLibelle( lb_Base, lt_Latin, st_undef, False );
    Actual.LgCurrent := lt_Latin;
    Actual.Query := tSearch.Create( st_Bas );
    Actual.SearchTerm;
    MySingle := Actual.CurrSingle;
    MyTerm := MySingle.Mandat + MySingle.Option;
    LatinTerm := TTerm.Create( MyTerm, lt_Latin );

    // Syntactical analysis of term
    Level := 1;
    Link := cEmpty;
    MyLevel1 := 0;
    MyLevel2 := 0;
    IsPrefix1 := False;
    IsPrefix2 := False;
    IsIncr := False;
    NbAnal := LatinTerm.NbWord;
    for Indx := 0 to NbAnal - 1 do
    begin

      // Adjust the level of indentation
      MyDecl := LatinTerm.Node[ Indx ].Cod;
      if Length( MyDecl ) = 3 then
        MyDecl := MyDecl + cSpace + cSpace;
      if ( ( MyDecl[ 1 ] = cWordShort[ wt_adj ] ) or
           ( MyDecl[ 1 ] = cWordShort[ wt_mor ] ) or
           ( MyDecl[ 1 ] = cWordShort[ wt_ppr ] ) or
           ( MyDecl[ 1 ] = cWordShort[ wt_com ] ) ) then
      begin
        if Copy( MyDecl, 3, 3 ) <> Copy ( PastDecl, 3, 3 ) then
          Dec( Level );
      end;
      if IsIncr then
        Inc( Level );
      IsIncr := ( Indx = 0 ) or
                ( ( MyDecl[ 1 ] = cWordShort[ wt_sub ] ) and
                  ( MyDecl[ 4 ] = cCaseShort[ wa_gen ] ) );

      // Build the next line of graph
      Graph := MakeNode( LatinTerm.Node[ Indx ].Lem, MyDecl );
      Link := cEmpty;
      if ( Indx > 0 ) or
         ( ( Indx = 0 ) and ( MyDecl[ 1 ] = cWordShort[ wt_mod ] ) ) then
      begin
        Link := MakeLink( MyDecl );
        if ( MyDecl[ 4 ] = cCaseShort[ wa_nom ] ) and
           ( MyDecl[ 1 ] = cWordShort[ wt_sub ] ) then
          Link := MakeLink( 'appos' );
      end;
      MyLine := Link + Graph;
      if MyDecl[ 1 ] <> cWordShort[ wt_mor ] then
        PastDecl := MyDecl;

      // Store maximum two prefix lines
      if ( MyDecl[ 1 ] = cWordShort[ wt_mod ] ) then
      begin
        if not Isprefix1 then
        begin
          MyPrefix1 := MyLine;
          MyLevel1 := Level;
          IsPrefix1 := True;
          Continue;
        end else
        if not Isprefix2 then
        begin
          MyPrefix2 := MyLine;
          MyLevel2 := Level;
          IsPrefix2 := True;
          Continue;
        end
      end;

      // Prepare the item
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := IntToStr( Level );
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyLine;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := Chr( Ord( 'a' ) + Level - 1 );
      AnItem.Color := lt_Latin;
      AddItem( AnItem );

      // Add one or two stored prefix items as an intermediate lines
      if IsPrefix1 then
      begin
        IsPrefix1 := False;
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := IntToStr( MyLevel1 + 1 );
        AnItem.AltLabel := cEmpty;
        AnItem.Value := MyPrefix1;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := Chr( Ord( 'a' ) + MyLevel1 );
        AnItem.Color := lt_Latin;
        AddItem( AnItem );
      end;
      if IsPrefix2 then
      begin
        IsPrefix2 := False;
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := IntToStr( MyLevel2 + 1 );
        AnItem.AltLabel := cEmpty;
        AnItem.Value := MyPrefix2;
        AnItem.Bubble := cEmpty;
        AnItem.Indent := Chr( Ord( 'a' ) + MyLevel2 );
        AnItem.Color := lt_Latin;
        AddItem( AnItem );
      end;
      if MyDecl[ 1 ] = cWordShort[ wt_mor ] then
        Inc( Level );
    end; // for

    // Add one or two stored prefix items as last lines
    if IsPrefix1 then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := IntToStr( MyLevel1 );
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyPrefix1;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := Chr( Ord( 'a' ) + MyLevel1 - 1 );
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;
    if IsPrefix2 then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := IntToStr( MyLevel2 );
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyPrefix2;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := Chr( Ord( 'a' ) + MyLevel2 - 1 );
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end;
  end;
end; // ____________________________________________________tSyntaxSection.Build

procedure          tDeclensionSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tDeclensionSection.Build
  * Make a declension section *
  Description:
  This method prepares the declension section, which consists of all the
  words of the current term and their declension at nominative and genitive,
  singular and plural.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbAnal:          Integer;
  LgtErase:        Integer;
  LID:             Integer;
  MyTerm:          String;
  Declension:      String;
  MyBubble:        String;
  MyDecl:          String;
  Cpt:             String;
  Actual:          tEntity;
  AnItem:          tBiColItem;
  LatinTerm:       tTerm;
  MySingle:        tSingle;
begin
  // Initial stuff
  Actual := Self.Entity;
  if ( Actual <> nil ) then
  begin

    // Term analysis
    Actual.LgCurrent := lt_Latin;
    Actual.Query := tSearch.Create( st_Bas );
    Actual.SearchTerm;
    MySingle := Actual.CurrSingle;
    MyTerm := MySingle.Mandat + MySingle.Option;
    LatinTerm := TTerm.Create( MyTerm, lt_Latin );

    // Full declension of all used words
    LgtErase := 0;
    NbAnal := LatinTerm.NbWord;
    for Indx := 0 to NbAnal - 1 do
    begin
      LID := 0;
      if ( LatinTerm.Node[ Indx ].LID <> cEmpty ) then
        LID := StrToInt( LatinTerm.Node[ Indx ].LID );
      if ( LID = 0 ) then
        Continue;
      MyDecl := LatinTerm.Node[ Indx ].Cod;
      MyBubble := TypeGender( MyDecl[ 1 ], MyDecl[ 3 ] );
      if ( ( MyDecl[ 1 ] = cWordShort[ wt_mod ] ) or
           ( MyDecl[ 1 ] = cWordShort[ wt_mor ] ) ) then
      begin
          Declension := LatinTerm.Node[ Indx ].Wrd;
          LgtErase := LgtErase + Length( LatinTerm.Node[ Indx ].Wrd );
      end else
      begin
          LatinDeclension( LID, LgtErase, Declension, Cpt );
          LgtErase := 0;
      end;

      // Prepare and store the corresponding section item
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := LatinTerm.Node[ Indx ].Lem;
      AnItem.AltLabel := MyBubble;
      AnItem.Value := Declension;
      AnItem.Bubble := cEmpty;
      AnItem.Indent := 'a';
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
    end; // for
  end;
end; // ________________________________________________tDeclensionSection.Build

procedure          TBiColSection.WriteSection(
  Lev:             Integer;
  MyHelpFile:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteSection
  * Write a bi-column section of any type *
   =======================================
  Description:
  This method writes a single bi-column section of any Page. Each section is
  made of a variable number of items, which are handled in turn.</P>
  Amongst the section items may be present DIV information, which goal is the
  creation of divisions controled by a toggle switch, active when the page is
  displayed as a dynamic HTML feature. There are open and close DIV items.
  In addition, an implicite division is automatically created for each section
  as a whole.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbItem:          Integer;
  Posit:           Integer;
  Nb:              Integer;
  MyClass:         String;
  InitText:        String;
  LinkText:        String;
  RestText:        String;
  Content:         String;
  MyID:            String;
  DivID:           String;
  BtnId:           String;
  Toggle:          String;
  MyValue:         String;
  MyIndent:        String;
  MyDef:           String;
  MyURL:           String;
  MyHelp:          String;
  AnItem:          tBiColItem;
  MyType:          tSectionType;
begin

    // Skip an empty section
    NbItem := GetNbItem;
    MyType := Self.SectionType;
    if ( NbItem = 0 ) then
      Exit;

    // Write the section title
    if ( IsLarge ) then
      AddTag( TABLEOTAG + cSectionTitle1400 + cAnr, Lev )
    else
      AddTag( TABLEOTAG + cSectionTitle700 + cAnr, Lev );
      AddTag( TRTAG, Lev + 1 );
        MyHelp := 'Knowledge help';
        MakeTDTitleSection( Self, Lev + 2, MyHelpFile, MyHelp );
      AddTag( TRETAG, Lev + 1 );
    AddTag( TABLEETAG, Lev );

    // Open a DIV tag for the section with specific ID
    MyID := 'Id=' + cDQuote + cIDSection[ MyType ] + cDQuote;
    AddTag( DIVOTAG + MyID + cAnr, Lev );
      AddTag( TABLEOTAG + cSectionContent + cAnr, Lev + 1 );

      // Loop on all items
      BtnId := cEmpty;
      DivId := cEmpty;
      for Indx := 0 to NbItem - 1 do
      begin

        // Write the item content
        AnItem := Self.GetItem( Indx );
        if ( AnItem <> nil ) then
        begin

          // Open a DIV tag
          if ( AnItem.TypeItem = tt_MakeODiv ) then
          begin
            Inc( Lev );
            AddTag( TABLEETAG, Lev );
            MyID := 'Id=' + cDQuote + AnItem.Value + cDQuote;
            AddTag( DIVOTAG + MyID + cAnr, Lev );
              AddTag( TABLEOTAG + cSectionContent + cAnr, Lev + 1 );
            Continue;
          end;

          // Close a DIV tag
          if ( AnItem.TypeItem = tt_MakeEDiv ) then
          begin
              AddTag( TABLEETAG, Lev + 1 );
            AddTag( DIVETAG + cOComment + AnItem.Bubble + cEComment, Lev );
            // Close the division by default
            MyValue := Copy( AnItem.Bubble, 9, Length( AnItem.Bubble ) );
            Nb := 0;
            if ( Length( MyValue ) > 0 ) then
              Nb := StrToInt( MyValue );
            if ( Nb > 1 ) then
            begin
              AddTag( SCRIPTTAG, Lev );
                AddTag( 'ToggleSection' + cRol + cSpace + cDQuote +
                        AnItem.Bubble + cDQuote + cSpace + cRor,
                        Lev + 1 );
              AddTag( SCRIPTETAG, Lev );
            end;
            AddTag( TABLEOTAG + cSectionContent + cAnr, Lev );
            Dec( Lev );
            Continue;
          end;

          // Creation of a toggle button for children of hierarchies
          Toggle := cEmpty;
          if ( MyType in
               [ sc_Taxonomy, sc_FullPartonomy, sc_LightPartonomy ] ) then
          begin
            if ( ( AnItem.Indent = 'a' ) and ( Indx < NbItem - 1 ) ) then
            begin

              // Assign DIV Id and button Id
              if ( MyType = sc_LightPartonomy ) then
              begin
                DivID := cDivNameInf;
              end else
              if ( MyType = sc_Taxonomy ) then
              begin
                DivID := cDivNameTax;
              end else
              if ( MyType = sc_FullPartonomy ) then
              begin
                DivID := cDivNamePart;
              end;

              // Build the toggle button
              Toggle := MakeToggle( DivId + '1' );
            end;
          end;

          // Write the 2-column item
          MyClass := cEmpty;
          MyIndent := cBaseIndent;
          if ( AnItem.Indent <> cEmpty ) then
            MyIndent := AnItem.Indent;
          if ( AnItem.Indent <> cEmpty ) then
            MyClass := cClassEmpty + cLgShort[ AnItem.Color ] +
                       MyIndent + cDQuote;
          AddTag( TRTAG, Lev + 2 );

            // Write the left column
            MakeTD( cClassRub, AnItem.SrcLabel, AnItem.AltLabel, Lev + 3 );

            // Separate the text for hyperlink from the given value
            Posit := 0;
            MyValue := AnItem.Value;
            InitText := cEmpty;
            LinkText := MyValue;
            RestText := cEmpty;
            if ( AnItem.Url <> cEmpty ) then
            begin
              if ( ( MyValue <> cEmpty ) and ( MyValue[ 1 ] = cAnl ) ) then
              begin
                Posit := Pos( cAnr, MyValue );
                if ( Posit > 0 ) then
                begin
                  InitText := Copy( MyValue, 1, Posit - 1 );
                  LinkText := Copy( MyValue, Posit + 1, Length( MyValue ) );
                end else
                begin
                  LinkText := MyValue;
                end;
              end else
              begin
                Posit := Pos( cSpace, MyValue );
                if ( ( Posit > 0 ) and ( AnItem.Url <> cEmpty ) ) then
                begin
                  LinkText := Copy( MyValue, 1, Posit - 1 );
                  RestText := Copy( MyValue, Posit + 1, Length( MyValue ) );
                end else
                begin
                  LinkText := MyValue;
                end;
              end;
              MyURL := AnItem.Url;
              MyURL := Copy( MyURL, 1, Length( MyURL ) - 1 );
              MyDef := cEmpty;
              if ( AnItem.Def <> cEmpty ) then
                MyDef := 'Title' + cEqual + cDQuote + AnItem.Def + cDQuote;
              LinkText := AOTAG + MyURL + cSpace + MyDef + cAnr +
                          LinkText + AETAG;
            end;

            // Make effective the hyperlink
            if ( AnItem.SrcLabel = 'Latin term' ) then
               Posit := Posit;
            Content := LinkText;
            if ( InitText <> cEmpty ) then
              Content := InitText + cAnr + cSpace + LinkText;
            if ( AnItem.PartLink <> cEmpty ) then
              Content := Content + cSpace + AnItem.PartLink;
            // Content := Toggle + Content;
            if ( AnItem.IconRight <> cEmpty ) then
              Content := Content + AnItem.IconRight;
            if ( RestText <> cEmpty ) then
              Content := Content + cSpace + RestText;

            // Write the right column
            MakeTD( cClassSpec, Content, AnItem.Bubble, Lev + 3, MyClass );
          AddTag( TRETAG, Lev + 2 );
        end;
      end; // for

      // Close the DIV tag for the section
      AddTag( TABLEETAG, Lev + 1 );
    AddTag( DIVETAG + cOComment + cIDSection[ MyType ] + cEComment, Lev );
  end; // __________________________________________________________WriteSection

procedure          tSignatureSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tSignatureSection.Build
  * Compute and display the signatures of any list at any level *
   ============================================================
  Description:
  This method controls the dispatching of the work on signatures depending
  on the type of the list. All types of lists are considered here.</P>
  There are four types of lists:
  - partonomic lists at any level,
  - TA98 partonomic lists at levels 3 and 4,
  - taxonomic lists at any level,
  - generic partonomic lists (no level).</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyUID:         Integer;
  Actual:        tEntity;
  ListType:      tTypeListPage;
  PageType:      tCategPage;
  MyList:        SigRec;
  AnItem:        tBiColItem;
  MyUnit:        tUnit;
  Sig:           tSignatures;
begin

  // Check for validity of the section:
  // - this section is available only for partonomic and taxonomic list pages
  // - a registered signature must be present
  PageType := Self.PageType;
  ListType := Self.TypeList;
  MyUID := Self.UID;
  Sig := TAH.Signatures;
  if ( Sig <> nil ) then
  begin
  MyList := Sig.GetSigRec( MyUID, ListType );
    if ( ( not ( PageType in [ ca_ListPart, ca_listTA98, ca_ListTax ] ) ) or
         ( MyList.UID <> MyUID ) ) then
      Exit;
  end;

  // Retrieve the actual list
  Actual := Self.Entity;
  MyUID := Actual.Tetra;
  MyUnit := TAH.GetUnitByPos( MyUID );
  if ( MyUnit <> nil ) then
  begin

    // Write the type of list
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Type of list';
    AnItem.AltLabel := 'One of partonomic or taxonomic, plus the level of ' +
                       'the current list';
    AnItem.Value := cTypeListPage[ ListType];
    if ( PageType = ca_listTA98 ) then
      AnItem.Value := AnItem.Value + cSpace + 'for TA98';
    AddItem( AnItem );

    // Write the list unit identifier
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'List Unit Identifier';
    AnItem.AltLabel := 'Unit identifier defining the current list';
    AnItem.Value := IntToStr( MyUID );
    AddItem( AnItem );

    // Dispatch the treatment according to the type of list.
    // Partonomic list level 4
    // =======================
    if ( ListType in [ li_part4, li_TA98Part4, li_gen ] ) then
      MakePartSigLevel4
    else

    // Partonomic list level 3
    // =======================
    if ( ListType in [ li_part3, li_part3f, li_TA98Part3 ] ) then
      MakePartSigLevel3
    else

    // Partonomic list level 1 or 2
    // ============================
    if ( ( ListType in [ li_part2, li_part2f, li_part1,
                         li_TA98part2, li_TA98part2f, li_TA98part1 ] ) ) then
      MakePartSigLevel21
    else

    // Taxonomic list level 4
    // =======================
    if ( ListType = li_tax4 ) then
      MakeTaxSigLevel4
    else

    // Taxonomic list level 3
    // =======================
    if ( ListType in [ li_tax3, li_tax3f ] ) then
      MakeTaxSigLevel3
    else

    // Taxonomic list level 1 or 2
    // =======================
    if ( ( ListType in [ li_tax2, li_tax2f, li_tax1 ] ) ) then
      MakeTaxSigLevel21;
  end;
end; // _________________________________________________tSignatureSection.Build

procedure          TSignatureSection.MakePartSigLevel4;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePartSigLevel4
  * Make the signature section for a partonomic list at level 4 *
  Description:
  This methods prepare the signature section of a partonomic list, either
  standard or TA98, at level 4. The level 4 being the lowest possible level,
  there are no sublevels to consider.</P>
  First the number of children and the number of units in the list are
  computed. Second, the stored signature and accompanying values are
  retrieved. By comparison of values, the stored number of children and units
  are validated or marked as invalid.</P>
  If present, the number of generic partonomies is displayed,</P>
  Finally, the current signature is computed and compared to the stored value
  of the signature. A message either validates the stored signature or displays
  the new value. In this later situation, the list must be considered as
  changed since its last validation. When the change is known and accepted,
  the new value of the signature must replace the stored value. When not, the
  possibility of an unvoluntary change is feasible and an inquiry is
  necessary.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotChildren:   Integer;
  TotUnits:      Integer;
  NbSpecific:    Integer;
  Posit:         Integer;
  MySignature:   Integer;
  ASeq:          Integer;
  ALev:          Integer;
  TA98:          Boolean;
  MyDate:        String;
  MyList:        SigRec;
  AnItem:        TBiColItem;
  MyUnit:        TUnit;
begin

  // Check the number of children
  MyList := TAH.Signatures.GetSigRec( Self.UID, Self.TypeList );
  TA98 := Self.PageType = ca_ListTA98;
  if ( not TA98 ) then
  begin
    TotChildren := 0;
    Self.Entity.GetNumberOfChildren( False, False, False, TotChildren,
                                     NbSpecific );
    if ( TotChildren <> MyList.NbCh ) then
    begin

      // Invalid number of children
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Invalid check';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := 'Found children' + cColumn + cSpace +
                      IntToStr( TotChildren );
      AddItem( AnItem );
    end else
    begin

      // Valid number of children according to signature
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Number of children';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := IntToStr( MyList.NbCh ) + cSpace + cRol +
                      'validated' + cRor;
      AddItem( AnItem );
    end;
  end;

  // Check the number of units
  TotUnits := 1;
  Self.Entity.GetNumberOfChildren( False, TA98, True, TotUnits, NbSpecific );
  if ( TotUnits <> MyList.NbUn ) then
  begin

    // Invalid number of units
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid check';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found units' + cColumn + cSpace + IntToStr( TotUnits );
    AddItem( AnItem );
  end else
  begin

    // Valid number of units according to signature
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Number of units';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MyList.NbUn ) + cSpace + cRol +
                    'validated' + cRor;
    AddItem( AnItem );
  end;

  // Write the number of brocken children
  if ( ( MyList.Sign > 0 ) and ( MyList.NbBr > 0 ) ) then
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Generic children';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MyList.NbBr );
    AddItem( AnItem );
  end;

  // Compute the current signature
  ASeq := 1;
  ALev := 1;
  MyUnit := TAH.GetUnitByPos( Self.UID );
  MySignature := MyUnit.GetSignature( False, TA98, ASeq, ALev );
  if ( ( MyList.Sign > 0 ) and ( MySignature = MyList.Sign ) ) then
  begin

    // Current signature is validated
    MyDate := MyList.DatS;
    Posit := Pos( cSpace, MyDate );
    if ( Posit > 0 ) then
      MyDate := Copy( MyDate, 1, Posit - 1 );
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol + 'validated' +
                    cSpace + 'since' + cSpace + MyDate + cRor;
    AddItem( AnItem );
  end else
  begin

    // Invalid signature: new signature is displayed
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol + 'stored value'  +
                    cSpace + IntToStr( MyList.Sign ) + cRor;
    AddItem( AnItem );
  end;
end; // _______________________________________________________MakePartSigLevel4

procedure          TSignatureSection.MakePartSigLevel3;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePartSigLevel3
  * Make the signature section for a partonomic list at level 3 *
  Description:
  This methods prepare the signature section of a partonomic list at
  level 3. The level 3 being above the level 4, the presence of sublists is
  feasible.</P>
  In a first step, all sublists at level 4 are retrieved, their signature is
  computed and compared to their stored value. Two possible errors are: absence
  of stored signature or invalid stored signature.</P>
  In a second step, the number of children and the number of units of the list
  are computed, including the sublists, and compared to the stored values,
  taking into account the proper children and the proper units of the actual
  list at level 3. Error messages are displayed when the comparison failed.</P>
  In a third step, the current signature is computed and compared to the stored
  value of the signature. A message either validates the stored signature or
  displays the new value. In this later situation, the list must be considered
  as changed since its last validation. When the change is known and accepted,
  the new value of the signature replaces the stored value. When not, the
  possibility of an unvoluntary change is feasible and an inquiry is
  necessary.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:          Integer;
  TotChildren:   Integer;
  SubChildren:   Integer;
  TotUnits:      Integer;
  SubUnits:      Integer;
  TotSub:        Integer;
  NbSpecific:    Integer;
  Posit:         Integer;
  MySignature:   Integer;
  ASeq:          Integer;
  ALev:          Integer;
  ChildUID:      Integer;
  IsOver:        Boolean;
  TA98:          Boolean;
  ListChildren:  String;
  MyChild:       String;
  MyDate:        String;
  MySubDate:     String;
  Value:         String;
  MyList:        SigRec;
  MyChildList:   SigRec;
  AnItem:        TBiColItem;
  MyUnit:        TUnit;
  ChildUnit:     TTetrahedron;
  ChildEntity:   TEntity;
  ChildType:     TTypeListPage;
begin

  // Write the sublists
  MyList := TAH.Signatures.GetSigRec( Self.UID, Self.TypeList );
  ListChildren := TAH.Signatures.GetChildren( Self.UID, Self.TypeList );
  SubChildren := 0;
  SubUnits := 0;

  // Compute the date of the list
  MyDate := MyList.DatS;
  Posit := Pos( cSpace, MyDate );
  if ( Posit > 0 ) then
    MyDate := Copy( MyDate, 1, Posit - 1 );
  IsOver := False;

  // Loop on all sublists at level 4
  TotSub := MyList.NbSub;
  TA98 := Self.PageType = ca_ListTA98;
  for Indx := 1 to TotSub do
  begin

    // Retrieve the UID of the child
    Posit := Pos( cSemi, ListChildren );
    if ( Posit > 0 ) then
    begin
      MyChild := Copy( ListChildren, 1, Posit - 1 );
      ListChildren := Copy( ListChildren, Posit + 1, Length( ListChildren ) );
    end else
      MyChild := ListChildren;
    ChildUID := 0;
    if ( Length( MyChild ) > 0 ) then
      ChildUID := StrToInt( MyChild );

    // Retrieve the child list information
    ChildType := li_Part4;
    if ( PageType = ca_ListTA98 ) then
      ChildType := li_TA98Part4;
    MyChildList := TAH.Signatures.GetSigRec( ChildUID, ChildType );
    if ( MyChildList.UID = ChildUID ) then
    begin

      // Display the child list profile
      if ( PageType <> ca_listTA98 ) then
        Inc( SubChildren, MyChildList.NbCh );
      Inc( SubUnits, MyChildList.NbUn );
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Sublist' + cSpace + IntToStr( Indx );
      AnItem.AltLabel := cEmpty;
      MySubDate := MyChildList.DatS;
      Posit := Pos( cSpace, MySubDate );
      if ( Posit > 0 ) then
        MySubDate := Copy( MySubDate, 1, Posit - 1 );
      IsOver := IsOver or DateBefore( MyDate, MySubDate );
      Value := MyChild + cSpace + MyChildList.Descr + cSpace;
      if ( PageType <> ca_listTA98 ) then
        Value := Value + IntToStr( MyChildList.NbCh ) + cSlash;
      Value := Value + IntToStr( MyChildList.NbUn ) + cSpace +
               'on' + cSpace + MySubDate;
      AnItem.Value := Value;
      AddItem( AnItem );

      // Check the signature of the child list
      ASeq := 1;
      ALev := 1;
      MySignature := 0;
      MyUnit := TAH.GetUnitByPos( ChildUID );
      if ( MyUnit <> nil ) then
      begin
        MySignature := MyUnit.GetSignature( False, TA98, ASeq, ALev );
        if ( ( MyChildList.Sign > 0 ) and
             ( MyChildList.Sign <> MySignature ) ) then
        begin
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := 'Invalid signature';
          AnItem.AltLabel := cEmpty;
          AnItem.Value := IntToStr( MySignature ) + cSpace + cRol +
                          'stored value' + cSpace +
                          IntToStr( MyChildList.Sign ) + cRor;
          AddItem( AnItem );
        end;
      end else
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := 'Absent signature';
        AnItem.AltLabel := cEmpty;
        AnItem.Value := 'New value is' + cSpace + IntToStr( MySignature );
        AddItem( AnItem );
      end;

      // Check number of children and units
      ChildUnit := TAH.GetTetrahedronByUID( ChildUID );
      ChildEntity := ChildUnit.Genr;
      if ( ChildUnit.TetraType in [ tt_pair, tt_pset ] ) then
        ChildEntity := ChildUnit.Main
      else
      if ( ChildUnit.TetraType = tt_set ) then
        ChildEntity := ChildUnit.ASet;
      if ( ChildEntity = nil ) then
        Continue;
      TotChildren := 0;
      if ( PageType <> ca_listTA98 ) then
        ChildEntity.GetNumberOfChildren( False, TA98, False, TotChildren,
                                         NbSpecific );
      TotUnits := 1;
      ChildEntity.GetNumberOfChildren( False, TA98, True, TotUnits,
                                       NbSpecific );
      if ( PageType <> ca_listTA98 ) then
      begin

        // Check taxonomic list or standard partonomic list
        if ( ( TotChildren <> MyChildList.NbCh ) or
             ( TotUnits <> MyChildList.NbUn ) ) then
        begin
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := 'Error in sublist';
          AnItem.AltLabel := cEmpty;
          AnItem.Value := cEmpty;
          if ( TotChildren <> MyChildList.NbCh ) then
            AnItem.Value := 'Found children' + cSpace +
                            IntToStr( TotChildren ) + cSpace;
          if ( TotUnits <> MyChildList.NbUn ) then
              AnItem.Value := AnItem.Value + 'Found units' + cSpace +
                              IntToStr( TotUnits );
          AddItem( AnItem );
        end;
      end else

      // Check TA98 partonomic list
      begin
        if ( ( TotUnits <> MyChildList.NbUn ) ) then
        begin
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := 'Error in sublist';
          AnItem.AltLabel := cEmpty;
          if ( TotUnits <> MyChildList.NbUn ) then
              AnItem.Value := AnItem.Value + 'Found units' + cSpace +
                              IntToStr( TotUnits );
          AddItem( AnItem );
        end;
      end;
    end;
  end; // for on all sublists at level 4

  // Display subtotals for sublists
  AnItem := TBiColItem.Create;
  AnItem.SrcLabel := 'Subtotals';
  AnItem.AltLabel := cEmpty;
  Value := cEmpty;
  if ( PageType <> ca_listTA98 ) then
    Value := 'subchildren' + cSpace + IntToStr( SubChildren );
  AnItem.Value := Value + cSpace + 'subunits' + cSpace + IntToStr( Subunits );
  AddItem( AnItem );

  // Warning for overdating
  if ( IsOver ) then
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Warning: overdating';
    AnItem.AltLabel := 'Check for date of the list regarding dates of the ' +
                       'sublists';
    AnItem.Value := 'anterior date for the list' + cSpace + MyDate;
    AddItem( AnItem );
  end;

  // Proper children
  if ( TotSub = 0 ) then
    MyList.PrCh := MyList.NbCh;
  if ( PageType <> ca_listTA98 ) then
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Proper children';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MyList.PrCh );
    AddItem( AnItem );
  end;

  // Check the number of children
  if ( PageType <> ca_listTA98 ) then
  begin
  TotChildren := 0;
  Self.Entity.GetNumberOfChildren( False, TA98, False, TotChildren,
                                   NbSpecific );
    if ( ( TotChildren - MyList.PrCh ) <> SubChildren ) then
    begin

      // Invalid number of children
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Invalid check';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := 'Found children' + cColumn + cSpace +
                      IntToStr( TotChildren );
      AddItem( AnItem );
    end else
    if ( MyList.NbCh  <> TotChildren ) then
    begin

      // Invalid number in list
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Invalid stored information';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := 'List value' + cColumn + cSpace +
                      IntToStr( MyList.NbCh ) + cSpace + 'expected' + cColumn +
                      cSpace + IntToStr( TotChildren );
      AddItem( AnItem );
    end else
    begin

      // Valid number of children
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Number of children';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := IntToStr( TotChildren ) + cSpace + cRol +
                      'validated' + cRor;
      AddItem( AnItem );
    end;
  end;

  // Proper units
  if ( TotSub = 0 ) then
    MyList.PrUn := MyList.NbUn;
  AnItem := TBiColItem.Create;
  AnItem.SrcLabel := 'Proper units';
  AnItem.AltLabel := cEmpty;
  AnItem.Value := IntToStr( MyList.PrUn );
  AddItem( AnItem );

  // Check the number of units
  TotUnits := 1;
  Self.Entity.GetNumberOfChildren( False, TA98, True, TotUnits, NbSpecific );
  if ( ( TotUnits - MyList.PrUn ) <> SubUnits ) then
  begin

    // Invalid number  of units
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid check';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found units' + cColumn + cSpace + IntToStr( TotUnits );
    AddItem( AnItem );
  end else
  begin

    // Valid number of units
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Number of units';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( TotUnits ) + cSpace + cRol +
                    'validated' + cRor;
    AddItem( AnItem );
  end;

  // Write the signature
  ASeq := 1;
  ALev := 1;
  MyUnit := TAH.GetUnitByPos( Self.Entity.Tetra );
  MySignature := MyUnit.GetSignature( False, TA98, ASeq, ALev );
  MyDate := MyList.DatS;
  Posit := Pos( cSpace, MyDate );
  if ( Posit > 0 ) then
    MyDate := Copy( MyDate, 1, Posit - 1 );
  if ( ( MyList.Sign  > 0 ) and ( MySignature = MyList.Sign ) ) then
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol + 'validated' +
                    cSpace + 'since' + cSpace + MyDate + cRor;
    AddItem( AnItem );
  end else

  // Invalid signature
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol + cSpace +
                    MyDate + cRor;
    AddItem( AnItem );
  end;
end; // _______________________________________________________MakePartSigLevel3

procedure          tSignatureSection.MakePartSigLevel21;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePartSigLevel21
  * Make the signature section for a partonomic list at level 2 or 1 *
  Description:
  This methods prepare the signature section of a partonomic list at
  level 2 or 1. The presence of sublists is nearly certain.</P>
  In a first step, all sublists at the immediate sublevel 4 are retrieved,
  their signature is computed and compared to their stored value. Two possible
  errors are: absence of stored signature or invalid stored signature.</P>
  In a second step, the number of children and the number of units of the list
  are computed, including the sublists, and compared to the stored values,
  taking into account the proper children and the proper units of the actual
  list. Error messages are displayed when the comparison failed.</P>
  In a third step, the current signature is computed and compared to the stored
  value of the signature. A message either validates the stored signature or
  displays the new value. In this later situation, the list must be considered
  as changed since its last validation. When the change is known and accepted,
  the new value of the signature replaces the stored value. When not, the
  possibility of an unvoluntary change is feasible and an inquiry is
  necessary.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:          Integer;
  TotChildren:   Integer;
  SubChildren:   Integer;
  TotUnits:      Integer;
  SubUnits:      Integer;
  TotSub:        Integer;
  NbSpecific:    Integer;
  Posit:         Integer;
  MySignature:   Integer;
  ASeq:          Integer;
  ALev:          Integer;
  ChildUID:      Integer;
  MyUID:         Integer;
  TA98:          Boolean;
  ListChildren:  String;
  MyChild:       String;
  MyDate:        String;
  MyList:        SigRec;
  MyChildList:   SigRec;
  AnItem:        tBiColItem;
  MyUnit:        tUnit;
  ChildUnit:     tTetrahedron;
  ChildEntity:   tEntity;
  MyTypeList:    tTypeListPage;
  MyTypeList2:   tTypeListPage;
begin
  // Write the sublists
  MyList := TAH.Signatures.GetSigRec( Self.UID, Self.TypeList );
  ListChildren := TAH.Signatures.GetChildren( Self.UID, Self.TypeList );
  SubChildren := 0;
  SubUnits := 0;
  TA98 := Self.PageType = ca_ListTA98;

  // Loop on all sublists at level immediately below the current level
  TotSub := MyList.NbSub;
  for Indx := 1 to TotSub do
  begin
    Posit := Pos( cSemi, ListChildren );
    if ( Posit > 0 ) then
    begin
      MyChild := Copy( ListChildren, 1, Posit - 1 );
      ListChildren := Copy( ListChildren, Posit + 1, Length( ListChildren ) );
    end else
      MyChild := ListChildren;
    if ( MyChild = cEmpty ) then
      Continue;
    ChildUID := StrToInt( MyChild );
    if ( TA98 ) then
    begin
      MyTypeList := li_TA98Part3;
      MyTypeList2 := li_TA98Part3;
      if ( Self.TypeList = li_TA98Part1 ) then
        MyTypeList := li_TA98Part2;
    end else
    begin
      MyTypeList := li_Part3;
      MyTypeList2 := li_Part3;
      if ( Self.TypeList = li_Part1 ) then
        MyTypeList := li_Part2;
    end;
    MyChildList := TAH.Signatures.GetSigRec( ChildUID, MyTypeList );
    if ( MyChildList.UID = 0 ) then
      MyChildList := TAH.Signatures.GetSigRec( ChildUID, MyTypeList2 );
    if ( MyChildList.UID = ChildUID ) then
    begin
      Inc( SubChildren, MyChildList.NbCh );
      Inc( SubUnits, MyChildList.NbUn );
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := 'Sublist' + cSpace + IntToStr( Indx );
      AnItem.AltLabel := cEmpty;
      MyDate := MyChildList.DatS;
      Posit := Pos( cSpace, MyDate );
      if ( Posit > 0 ) then
        MyDate := Copy( MyDate, 1, Posit - 1 );
      AnItem.Value := MyChild + cSpace + MyChildList.Descr + cSpace +
                      IntToStr( MyChildList.NbCh ) + cSlash +
                      IntToStr( MyChildList.NbUn ) + cSpace +
                      'on' + cSpace + MyDate;
      AddItem( AnItem );

      // Check number of children and units
      ChildUnit := TAH.GetTetrahedronByUID( ChildUID );
      ChildEntity := ChildUnit.Genr;
      if ( ( ChildUnit.TetraType in [ tt_pair, tt_pset ] ) and
           ( Self.PageType <> ca_ListTA98 ) ) then
        ChildEntity := ChildUnit.Main
      else
      if ( ChildUnit.TetraType = tt_set ) then
        ChildEntity := ChildUnit.ASet;
      if ( not TA98 ) then
      begin
        TotChildren := 0;
        ChildEntity.GetNumberOfChildren( False, False, False, TotChildren,
                                         NbSpecific );
      end;
      TotUnits := 1;
      if ( ChildEntity <> nil ) then
        ChildEntity.GetNumberOfChildren( False, TA98, True, TotUnits,
                                         NbSpecific );
      if ( Self.PageType <> ca_ListTA98 ) then
      begin
        if ( ( TotChildren <> MyChildList.NbCh ) or
             ( TotUnits <> MyChildList.NbUn ) ) then
        begin
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := 'Error in sublist';
          AnItem.AltLabel := cEmpty;
          if ( TotChildren <> MyChildList.NbCh ) then
            AnItem.Value := 'Found children' + cSpace +
            IntToStr( TotChildren ) + cSpace;
          if ( TotUnits <> MyChildList.NbUn ) then
              AnItem.Value := AnItem.Value + 'Found units' + cSpace +
                              IntToStr( TotUnits );
          AddItem( AnItem );
        end;
      end else
      begin
        if ( TotUnits <> MyChildList.NbUn ) then
        begin
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := 'Error in sublist';
          AnItem.AltLabel := cEmpty;
          if ( TotUnits <> MyChildList.NbUn ) then
              AnItem.Value := AnItem.Value + 'Found units' + cSpace +
                              IntToStr( TotUnits );
          AddItem( AnItem );
        end;
      end;
    end;
  end; // for on all sublists at sublevel immediatly below the current level

  // Display subtotals for sublists
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := 'Subtotals';
  AnItem.AltLabel := cEmpty;
  if ( Self.PageType <> ca_ListTA98 ) then
    AnItem.Value := 'subchildren' + cSpace + IntToStr( SubChildren ) + cSpace +
                    'subunits' + cSpace + IntToStr( Subunits )
  else
    AnItem.Value := 'subunits' + cSpace + IntToStr( Subunits );
  AddItem( AnItem );

  // Display the number of proper children
  if ( not TA98 ) then
  begin
    if ( Self.PageType <> ca_ListTA98 ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := 'Proper children';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := IntToStr( MyList.PrCh );
      AddItem( AnItem );

      // Check the number of children
      TotChildren := 0;
      Self.Entity.GetNumberOfChildren( False, TA98, False, TotChildren,
                                       NbSpecific );
      if ( MyList.NbCh <> TotChildren ) then
      begin

        // Invalid number of children from database
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := 'Invalid number of children';
        AnItem.AltLabel := cEmpty;
        AnItem.Value := 'Found children' + cColumn + cSpace +
                        IntToStr( TotChildren );
        AddItem( AnItem );
      end;
      if ( ( SubChildren + MyList.PrCh ) <> TotChildren ) then
      begin

        // Invalid number of children from sublists
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := 'Check';
        AnItem.AltLabel := cEmpty;
        AnItem.Value := 'Sublist children' + cColumn + cSpace +
                        IntToStr( SubChildren );
        AddItem( AnItem );
      end else
      begin

        // Valid number of children
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := 'Number of children';
        AnItem.AltLabel := cEmpty;
        AnItem.Value := IntToStr( TotChildren ) + cSpace + cRol +
          'validated' + cRor;
        AddItem( AnItem );
      end;
    end;
  end;

  // Display the number of proper units
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := 'Proper units';
  AnItem.AltLabel := cEmpty;
  AnItem.Value := IntToStr( MyList.PrUn );
  AddItem( AnItem );

  // Check the number of units
  TotUnits := 1;
  Self.Entity.GetNumberOfChildren( False, TA98, True, TotUnits, NbSpecific );
  if ( MyList.NbUn  <> TotUnits ) then
  begin

    // Invalid number of units from database
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Invalid number of units';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found units' + cColumn + cSpace + IntToStr( MyList.NbUn );
    AddItem( AnItem );
  end;
  if ( ( SubUnits + MyList.PrUn ) <> TotUnits ) then
  begin

    // Invalid number of units from sublists
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Check';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found units' + cColumn + cSpace + IntToStr( SubUnits );
    AddItem( AnItem );
  end else
  begin

    // Valid number of units
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Number of units';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( TotUnits ) + cSpace + cRol + 'validated' + cRor;
    AddItem( AnItem );
  end;

  // Write the signature
  ASeq := 1;
  ALev := 1;
  MyUID := Self.Entity.Tetra;
  MyUnit := TAH.GetUnitByPos( MyUID );
  MySignature := MyUnit.GetSignature( False, TA98, ASeq, ALev );
  MyDate := MyList.DatS;
  Posit := Pos( cSpace, MyDate );
  if ( Posit > 0 ) then
    MyDate := Copy( MyDate, 1, Posit - 1 );
  if ( ( MyList.Sign > 0 ) and ( MyList.Sign = MySignature ) ) then
  begin
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol +
                    'validated' + cSpace + 'since' + cSpace + MyDate + cRor;
    AddItem( AnItem );
  end else

  // Invalid signature
  begin
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Invalid signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol + cSpace +
                    MyDate + cRor;
    AddItem( AnItem );
  end;
end; // ______________________________________________________MakePartSigLevel21

procedure          TSignatureSection.MakeTaxSigLevel4;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxSigLevel4
  * Make the signature section for a taxonomic list at level 4 *
  Description:
  This methods prepare the signature section of a taxonomic list at
  level 4. There are no sublists.</P>
  In a first step, the number of children and the number of units of the list
  are computed, including the sublists, and compared to the stored values,
  taking into account the proper children and the proper units of the actual
  list. Error messages are displayed when the comparison failed.</P>
  In a second step, the current signature is computed and compared to the stored
  value of the signature. A message either validates the stored signature or
  displays the new value. In this later situation, the list must be considered
  as changed since its last validation. When the change is known and accepted,
  the new value of the signature replaces the stored value. When not, the
  possibility of an unvoluntary change is feasible and an inquiry is
  necessary.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotChildren:   Integer;
  TotUnits:      Integer;
  NbSpecific:    Integer;
  Posit:         Integer;
  MySignature:   Integer;
  ASeq:          Integer;
  ALev:          Integer;
  MyUID:         Integer;
  MyDate:        String;
  MyList:        SigRec;
  AnItem:        TBiColItem;
  MyUnit:        TUnit;
begin

  // Check the number of children
  MyList := TAH.Signatures.GetSigRec( Self.UID, Self.TypeList );
  TotChildren := 0;
  Self.Entity.GetNumberOfChildren( True, False, False, TotChildren,
                                   NbSpecific );
  if ( TotChildren <> MyList.NbCh ) then
  begin

    // Invalid number of children
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid check';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found children' + cColumn + cSpace +
                    IntToStr( TotChildren );
    AddItem( AnItem );
  end else
  begin

    // Valid number of children
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Number of children';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MyList.NbCh ) + cSpace + cRol +
                    'validated' + cRor;
    AddItem( AnItem );
  end;

  // Check the number of units
  TotUnits := 1;
  Self.Entity.GetNumberOfChildren( True, False, True, TotUnits, NbSpecific );
  if ( TotUnits <> MyList.NbUn ) then
  begin

    // Invalid number of units
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid check';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found units' + cColumn + cSpace + IntToStr( TotUnits );
    AddItem( AnItem );
  end else
  begin

    // Valid number of units
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Number of units';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MyList.NbUn ) + cSpace + cRol +
                    'validated' + cRor;
    AddItem( AnItem );
  end;

  // Write the number of brocken children
  if ( ( MyList.Sign  > 0) and ( MyList.NbBr  > 0 ) ) then
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Generic children';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MyList.NbBr );
    AddItem( AnItem );
  end;

  // Write the signature
  ASeq := 1;
  ALev := 1;
  MyUID := Self.Entity.Tetra;
  MyUnit := TAH.GetUnitByPos( MyUID );
  MySignature := MyUnit.GetSignature( True, False, ASeq, ALev );
  if ( ( MyList.Sign  > 0 ) and ( MySignature = MyList.Sign ) )
  then
  begin
    MyDate := MyList.DatS;
    Posit := Pos( cSpace, MyDate );
    if ( Posit > 0 ) then
      MyDate := Copy( MyDate, 1, Posit - 1 );
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol +
                    'validated' + cSpace + 'since' + cSpace + MyDate + cRor;
    AddItem( AnItem );
  end else

  // Invalid signature
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace +
                    cRol + 'stored value' + cSpace + IntToStr( MyList.Sign ) +
                    cRor;
    AddItem( AnItem );
  end;
end; // ________________________________________________________MakeTaxSigLevel4

procedure          TSignatureSection.MakeTaxSigLevel3;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxSigLevel3
  * Make the signature section for a taxonomic list at level 3 *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:          Integer;
  TotChildren:   Integer;
  SubChildren:   Integer;
  TotUnits:      Integer;
  SubUnits:      Integer;
  TotSub:        Integer;
  NbSpecific:    Integer;
  Posit:         Integer;
  MySignature:   Integer;
  ASeq:          Integer;
  ALev:          Integer;
  ChildUID:      Integer;
  MyUID:         Integer;
  ListChildren:  String;
  MyChild:       String;
  MyDate:        String;
  MyList:        SigRec;
  MyChildList:   SigRec;
  AnItem:        TBiColItem;
  MyUnit:        TUnit;
  ChildUnit:     TTetrahedron;
  ChildEntity:   TEntity;
begin

  // Check for a registered signature
  MyList := TAH.Signatures.GetSigRec( Self.UID, li_Tax3 );
  if ( MyList.UID <= 0 ) then
    Exit;
  if ( ( Self.TypeList <> li_Tax3 ) and ( Self.TypeList <> li_Tax3f ) ) then
    Exit;

  // Retrieve the number of children
  TotUnits := 1;
  Self.Entity.GetNumberOfChildren( True, False, True, TotUnits, NbSpecific );

  // Write the sublists
  SubChildren := 0;
  SubUnits := 0;
  ListChildren := TAH.Signatures.GetChildren( Self.UID, Self.TypeList );
  TotSub := MyList.NbSub;
  for Indx := 1 to TotSub do
  begin

    // Retrieve the UID of the child
    Posit := Pos( cSemi, ListChildren );
    if ( Posit > 0 ) then
    begin
      MyChild := Copy( ListChildren, 1, Posit - 1 );
      ListChildren := Copy( ListChildren, Posit + 1, Length( ListChildren ) );
    end  else
      MyChild := ListChildren;
    ChildUID := 0;
    if ( Length( MyChild ) > 0 ) then
      ChildUID := StrToInt( MyChild );

    // Retrieve the child list information
    MyChildList := TAH.Signatures.GetSigRec( ChildUID, li_Tax4 );
    if ( ( MyChildList.UID = ChildUID ) and ( ChildUID <> 0 ) ) then
    begin

      // Display the child list profile
      Inc( SubChildren, MyChildList.NbCh );
      Inc( SubUnits, MyChildList.NbUn );
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := 'Sublist' + cSpace + IntToStr(Indx);
      AnItem.AltLabel := 'Any sublist at level immediately below ' +
                         'the current list level';
      MyDate := MyChildList.DatS;
      Posit := Pos( cSpace, MyDate );
      if ( Posit > 0 ) then
        MyDate := Copy( MyDate, 1, Posit - 1 );
      AnItem.Value := MyChild + cSpace + MyChildList.Descr + cSpace +
                      IntToStr( MyChildList.NbCh ) + cSlash +
                      IntToStr( MyChildList.NbUn ) + cSpace +
                      'on' + cSpace + MyDate;
      AddItem( AnItem );

      // Check the signature of the child list
      MyUnit := TAH.GetUnitByPos( ChildUID );
      ASeq := 1;
      ALev := 1;
      MySignature := 0;
      if ( MyUnit <> nil ) then
        MySignature := MyUnit.GetSignature( True, False, ASeq, ALev );
      if ( ( MyChildList.Sign > 0 ) and
           ( MyChildList.Sign <> MySignature ) ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := 'Invalid signature';
        AnItem.AltLabel := 'Difference between the calculated and the stored ' +
                           'sublist signature' ;
        AnItem.Value := IntToStr( MySignature ) + cSpace +
                        cRol + 'stored value' + cSpace +
                        IntToStr( MyChildList.Sign ) + cRor;
        AddItem( AnItem );
      end;

      // Check number of children and units
      ChildUnit := TAH.GetTetrahedronByUID( ChildUID );
      ChildEntity := ChildUnit.Genr;
      TotChildren := 0;
      if ( ChildEntity <> nil ) then
        ChildEntity.GetNumberOfChildren( True, False, False, TotChildren,
                                         NbSpecific );
      TotUnits := 1;
      if ( ChildEntity <> nil ) then
        ChildEntity.GetNumberOfChildren( True, False, True, TotUnits,
                                         NbSpecific );
      if ( ( TotChildren <> MyChildList.NbCh ) or
           ( TotUnits <> MyChildList.NbUn ) ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := 'Error in sublist';
        AnItem.AltLabel := 'Difference in count of children and/or units ' +
                           'for the sublist';
        if ( TotChildren <> MyChildList.NbCh ) then
          AnItem.Value := 'Found children' + cSpace + IntToStr( TotChildren ) +
                          cSpace;
        if ( TotUnits <> MyChildList.NbUn ) then
            AnItem.Value := AnItem.Value + 'Found units' + cSpace +
                            IntToStr( TotUnits );
        AddItem( AnItem );
      end;
    end;
  end; // for on all sublists

  // Display subtotals for sublists
  AnItem := TBiColItem.Create;
  AnItem.SrcLabel := 'Subtotals';
  AnItem.AltLabel := 'Total of children and units on all sublists';
  AnItem.Value := 'subchildren' + cSpace + IntToStr( SubChildren ) + cSpace +
                  'subunits' + cSpace + IntToStr( Subunits );
  AddItem( AnItem );

  // Proper children
  AnItem := TBiColItem.Create;
  AnItem.SrcLabel := 'Proper children';
  AnItem.AltLabel := 'The number of proper children declared for the current ' +
                     'list';
  AnItem.Value := IntToStr( MyList.PrCh );
  AddItem( AnItem );

  // Check the number of children
  TotChildren := 0;
  Self.Entity.GetNumberOfChildren( True, False, False, TotChildren,
                                   NbSpecific );
  if ( ( TotChildren - MyList.PrCh ) <> SubChildren ) then
  begin

    // Invalid number of children
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid check';
    AnItem.AltLabel := 'Difference between the found number of children of ' +
                       'the current list and the total of the sublists plus ' +
                       'the proper children of the current list';
    AnItem.Value := 'Found children' + cColumn + cSpace +
                    IntToStr( TotChildren );
    AddItem( AnItem );
  end else
  if ( MyList.NbCh  <> TotChildren ) then
  begin

    // Invalid number in list
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid stored information';
    AnItem.AltLabel := 'Difference between the found number of children of ' +
                       'the current list and the stored number';
    AnItem.Value := 'List value' + cColumn + cSpace +
                    IntToStr( MyList.NbCh ) + cSpace + 'expected' + cColumn +
                    cSpace + IntToStr( TotChildren );
    AddItem( AnItem );
  end else
  begin

    // Valid number of children
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Number of children';
    AnItem.AltLabel := 'The number of children is validated';
    AnItem.Value := IntToStr( TotChildren ) + cSpace + cRol +
                    'validated' + cRor;
    AddItem( AnItem );
  end;

  // Proper units
  AnItem := TBiColItem.Create;
  AnItem.SrcLabel := 'Proper units';
  AnItem.AltLabel := 'The number of proper units declared for the current list';
  AnItem.Value := IntToStr( MyList.PrUn );
  AddItem( AnItem );

  // Check the number of units
  TotUnits := 1;
  Self.Entity.GetNumberOfChildren( True, False, True, TotUnits, NbSpecific );
  if ( ( TotUnits - MyList.PrUn ) <> SubUnits ) then
  begin

    // Invalid number of units
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid check';
    AnItem.AltLabel := 'Difference between the found number of units of ' +
                       'the current list and the total of the sublists plus ' +
                       'the proper units of the current list';
    AnItem.Value := 'Found units' + cColumn + cSpace + IntToStr(TotUnits);
    AddItem( AnItem );
  end else
  begin

    // Valid number of units
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Number of units';
    AnItem.AltLabel := 'The number of units is validated';
    AnItem.Value := IntToStr(TotUnits) + cSpace + cRol + 'validated' + cRor;
    AddItem( AnItem );
  end;

  // Write the signature
  ASeq := 1;
  ALev := 1;
  MyUID := Self.Entity.Tetra;
  MyUnit := TAH.GetUnitByPos( MyUID );
  MySignature := MyUnit.GetSignature( True, False, ASeq, ALev );
  MyDate := MyList.DatS;
  Posit := Pos( cSpace, MyDate );
  if ( Posit > 0 ) then
    MyDate := Copy( MyDate, 1, Posit - 1 );
  if ( ( MyList.Sign  > 0 ) and ( MySignature = MyList.Sign ) )
  then
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Signature';
    AnItem.AltLabel := 'Valid signature against the stored information';
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol +
                    'validated' + cSpace + 'since' + cSpace + MyDate + cRor;
    AddItem( AnItem );
  end else

  // Invalid signature
  begin
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := 'Invalid signature';
    AnItem.AltLabel := 'Invalid signature against the stored information';
    AnItem.Value := IntToStr( MySignature ) + cSpace +
                    cRol + 'stored value' + cSpace + IntToStr( MyList.Sign ) +
                    cRor;
    AddItem( AnItem );
  end;
end; // ________________________________________________________MakeTaxSigLevel3

procedure          tSignatureSection.MakeTaxSigLevel21;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxSigLevel21
  * Make the signature section for a taxonomic list at level 2 or 1 *
  Description:
  This methods prepare the signature section of a taxonomic list at
  level 2 or 1. The presence of sublists is nearly certain.</P>
  In a first step, all sublists at the immediate sublevel 4 are retrieved,
  their signature is computed and compared to their stored value. Two possible
  errors are: absence of stored signature or invalid stored signature.</P>
  In a second step, the number of children and the number of units of the list
  are computed, including the sublists, and compared to the stored values,
  taking into account the proper children and the proper units of the actual
  list. Error messages are displayed when the comparison failed.</P>
  In a third step, the current signature is computed and compared to the stored
  value of the signature. A message either validates the stored signature or
  displays the new value. In this later situation, the list must be considered
  as changed since its last validation. When the change is known and accepted,
  the new value of the signature replaces the stored value. When not, the
  possibility of an unvoluntary change is feasible and an inquiry is
  necessary.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:          Integer;
  TotChildren:   Integer;
  SubChildren:   Integer;
  TotUnits:      Integer;
  SubUnits:      Integer;
  TotSub:        Integer;
  NbSpecific:    Integer;
  Posit:         Integer;
  MySignature:   Integer;
  ASeq:          Integer;
  ALev:          Integer;
  ChildUID:      Integer;
  MyUID:         Integer;
  ListChildren:  String;
  MyChild:       String;
  MyDate:        String;
  MyList:        SigRec;
  MyChildList:   SigRec;
  AnItem:        tBiColItem;
  MyUnit:        tUnit;
  ChildUnit:     tTetrahedron;
  ChildEntity:   tEntity;
  MyTypeList:    tTypeListPage;
begin
  // Write the sublists
  MyList := TAH.Signatures.GetSigRec( Self.UID, Self.TypeList );
  ListChildren := TAH.Signatures.GetChildren( Self.UID, Self.TypeList );
  SubChildren := 0;
  SubUnits := 0;

  // Loop on all sublists at level immediately below the current level
  TotSub := MyList.NbSub;
  for Indx := 1 to TotSub do
  begin
    Posit := Pos( cSemi, ListChildren );
    if ( Posit > 0 ) then
    begin
      MyChild := Copy( ListChildren, 1, Posit - 1 );
      ListChildren := Copy( ListChildren, Posit + 1, Length( ListChildren ) );
    end else
      MyChild := ListChildren;
    if ( MyChild = cEmpty ) then
      Continue;
    ChildUID := StrToInt( MyChild );
    MyTypeList := li_tax3;
    if ( Self.TypeList in [ li_tax1, li_tax1F ] ) then
      MyTypeList := li_tax2;
    MyChildList := TAH.Signatures.GetSigRec( ChildUID, MyTypeList );
    if ( MyChildList.UID = ChildUID ) then
    begin
      Inc( SubChildren, MyChildList.NbCh );
      Inc( SubUnits, MyChildList.NbUn );
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := 'Sublist' + cSpace + IntToStr( Indx );
      AnItem.AltLabel := cEmpty;
      MyDate := MyChildList.DatS;
      Posit := Pos( cSpace, MyDate );
      if ( Posit > 0 ) then
        MyDate := Copy( MyDate, 1, Posit - 1 );
      AnItem.Value := MyChild + cSpace + MyChildList.Descr + cSpace +
                      IntToStr( MyChildList.NbCh ) + cSlash +
                      IntToStr( MyChildList.NbUn ) + cSpace +
                      'on' + cSpace + MyDate;
      AddItem( AnItem );

      // Check number of children and units
      ChildUnit := TAH.GetTetrahedronByUID( ChildUID );
      ChildEntity := ChildUnit.Genr;
      TotChildren := 0;
      ChildEntity.GetNumberOfChildren( True, False, False, TotChildren,
                                       NbSpecific );
      TotUnits := 1;
      ChildEntity.GetNumberOfChildren( True, False, True, TotUnits,
                                       NbSpecific );
      if ( ( TotChildren <> MyChildList.NbCh ) or
           ( TotUnits <> MyChildList.NbUn ) ) then
      begin
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := 'Error in sublist';
        AnItem.AltLabel := cEmpty;
        if ( TotChildren <> MyChildList.NbCh ) then
          AnItem.Value := 'Found children' + cSpace + IntToStr( TotChildren ) +
                          cSpace;
        if ( TotUnits <> MyChildList.NbUn ) then
            AnItem.Value := AnItem.Value + 'Found units' + cSpace +
                            IntToStr( TotUnits );
        AddItem( AnItem );
      end;
    end;
  end; // for on all sublists at sublevel immediatly below the current level

  // Display subtotals for sublists
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := 'Subtotals';
  AnItem.AltLabel := cEmpty;
  AnItem.Value := 'subchildren' + cSpace + IntToStr( SubChildren ) + cSpace +
                  'subunits' + cSpace + IntToStr( Subunits );
  AddItem( AnItem );

  // Display the number of proper children
  AnItem := TBiColItem.Create;
  AnItem.SrcLabel := 'Proper children';
  AnItem.AltLabel := cEmpty;
  AnItem.Value := IntToStr( MyList.PrCh );
  AddItem( AnItem );

  // Check the number of children
  TotChildren := 0;
  Self.Entity.GetNumberOfChildren( True, False, False, TotChildren,
                                   NbSpecific );
  if ( MyList.NbCh <> TotChildren ) then
  begin

    // Invalid number of children from database
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Invalid number of children';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found children' + cColumn + cSpace +
                    IntToStr( TotChildren );
    AddItem( AnItem );
  end;
  if ( ( SubChildren + MyList.PrCh ) <> TotChildren ) then
  begin

    // Invalid number of children from sublists
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Check';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Sublist children' + cColumn + cSpace +
                    IntToStr( SubChildren );
    AddItem( AnItem );
  end else
  begin

    // Valid number of children
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Number of children';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( TotChildren ) + cSpace + cRol +
      'validated' + cRor;
    AddItem( AnItem );
  end;

  // Display the number of proper units
  AnItem := tBiColItem.Create;
  AnItem.SrcLabel := 'Proper units';
  AnItem.AltLabel := cEmpty;
  AnItem.Value := IntToStr( MyList.PrUn );
  AddItem( AnItem );

  // Check the number of units
  TotUnits := 1;
  Self.Entity.GetNumberOfChildren( True, False, True, TotUnits, NbSpecific );
  if ( MyList.NbUn  <> TotUnits ) then
  begin

    // Invalid number of units from database
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Invalid number of units';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found units' + cColumn + cSpace + IntToStr( MyList.NbUn );
    AddItem( AnItem );
  end;
  if ( ( SubUnits + MyList.PrUn ) <> TotUnits ) then
  begin

    // Invalid number of units from sublists
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Check';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := 'Found units' + cColumn + cSpace + IntToStr( SubUnits );
    AddItem( AnItem );
  end else
  begin

    // Valid number of units
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Number of units';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( TotUnits ) + cSpace + cRol + 'validated' + cRor;
    AddItem( AnItem );
  end;

  // Write the signature
  ASeq := 1;
  ALev := 1;
  MyUID := Self.Entity.Tetra;
  MyUnit := TAH.GetUnitByPos( MyUID );
  MySignature := MyUnit.GetSignature( True, False, ASeq, ALev );
  MyDate := MyList.DatS;
  Posit := Pos( cSpace, MyDate );
  if ( Posit > 0 ) then
    MyDate := Copy( MyDate, 1, Posit - 1 );
  if ( ( MyList.Sign > 0 ) and ( MyList.Sign = MySignature ) ) then
  begin
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol +
                    'validated' + cSpace + 'since' + cSpace + MyDate + cRor;
    AddItem( AnItem );
  end else

  // Invalid signature
  begin
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := 'Invalid signature';
    AnItem.AltLabel := cEmpty;
    AnItem.Value := IntToStr( MySignature ) + cSpace + cRol + cSpace +
                    MyDate + cRor;
    AddItem( AnItem );
  end;
end; // _______________________________________________________MakeTaxSigLevel21

procedure          tTaxoSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTaxoSection.Build
  * Make the taxonomy section of an Entity Page *
  Description:
  This procedure prepares the content of the taxonomy section under the form
  of the entire taxonomy above and below the main entity.</P>
  This procedure is made of three parts in general, but limited to the first
  two parts for specific entities, which by definition, have no children in
  the taxonomy. The three parts are:</P>
  1. Build the list of ancestors of the main entity up to the top entity
     which is invariably res anatomica, using an indentation schema from left
     to right. A special treatment is done for pairs, sets or pset, which
     ancestor list is usually made of virtual entities.</P>
  2. Display the main entity, totally left indented.</P>
  3. Build the list of children of the main entity in an exhaustive way, unless
     they are too numerous (installation parameter), in which case a partial
     list is presented. This part is present only for generic entities. Again,
     an indentation schema from left to right is used.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  IsTax:           Boolean = True;
  Alter:           Boolean = False;
var
  NbAnc:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  NbDiv:           Integer;
  TooMuch:         Boolean;
  IsExt:           Boolean;
  Value:           String;
  Bubble:          String;
  MyIndent:        String;
  ViewCode:        String;
  BubbleCode:      String;
  Main:            tEntity;
  Trans:           tEntity;
  AncListe:        Array[ 0 .. 30 ] of Integer;
  MyColor:         tLanguage;
  AnItem:          tBiColItem;
begin

  // Retrieve the main entity
  Main := Self.Entity;
  IsExt := Self.PageType = ca_Extended;
  if ( Main <> nil ) then
  begin

    // Compute the number of children of the main entity
    NbChildren := 0;
    NbSpecific := 0;
    Main.GetNumberOfChildren( True, False, False, NbChildren, NbSpecific );

    // Write an item for help on colors
    if ( Main.TetraTip <> tp_int ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reHelpOnColors );
      AnItem.AltLabel := TAH.GetBubble( reHelpOnColors );
      AnItem.Value := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AnItem.Bubble := cEmpty;
      AddItem( AnItem );
    end;

    // Prepare the line for main entity with hyperlink to FMA
    if ( ( Main.FID > 0 ) ) then
    begin
      ViewCode := AOTAG + cHrefEmpty + BioPortalUrl +
                  IntToStr( Main.FID ) + cDQuote + cAnr +
                  cFMA + cColumn + IntToStr( Main.FID ) + AETAG;
      BubbleCode := cTAH + cColumn + 'E' + IntToStr( Main.TID );
    end else
    begin
      ViewCode := cTAH + cColumn + 'E' + IntToStr( Main.TID );
      BubbleCode := cEmpty;
    end;
    Value := Main.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
    Bubble := Main.GetLibelle( lb_Official, TAH.SubstLang, st_undef, True );
    if ( ( Value = cEmpty ) and ( Main.TypeEntity = to_non ) ) then
    begin
      Value := Main.GetLibelle( lb_Title, TAH.MainLang, st_undef, True );
      if ( Value = cEmpty ) then
        Value := Main.GetLibelle( lb_Title, lt_English, st_undef, True );
    end;
    if ( NbChildren = 0 ) then
      Value := cRoundImg + Value
    else
      Value := MakeToggle( cDivNameTax + '1' ) + Value;

    // Select color for history of change
    MyColor := lt_Latin;
    if ( IsExt ) then
    begin
      // Light blue color is selected for showing new entities
      if ( ( FMAChange ) and ( Main.ChLink = 'n' ) ) then
        MyColor := lt_French;

      // Light pink color is selected for showing updated entities
      if ( ( FMAChange ) and ( Main.ChLink = 'm' ) ) then
        MyColor := lt_English;
      Trans := TAH.GetEntityByPos( Main.Generator );
      if ( ( Trans <> nil ) and ( Trans.ChLink = 'm' ) ) then
        MyColor := lt_English;
    end;

    // Create the pivot entity
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := ViewCode;
    AnItem.AltLabel := BubbleCode;
    AnItem.Value := Value;
    AnItem.Bubble := Bubble;
    AnItem.Indent := cBaseIndent;
    AnItem.Color := MyColor;

    // Treatment of pairs, without children
    if ( ( Main.TypeEntity = to_ParMat ) or
         ( Main.TypeEntity = to_ParImm ) ) then
    begin
      NbAnc := 0;
      MakeAscendants( Main.TID, 1, IsTax, Alter, True, False, False,
                      IsExt, NbAnc, AncListe );
      AddItem( AnItem );
    end else

    // Treatment of sets, without children
    if ( ( Main.TypeEntity = to_SetMat ) or
         ( Main.TypeEntity = to_SetImm ) ) then
    begin
      NbAnc := 0;
      MakeAscendants( Main.TID, 1, IsTax, Alter, False, True, False,
                      IsExt, NbAnc, AncListe );
      AddItem( AnItem );
    end else

    // Treatment of pairs of sets, without children
    if ( ( Main.TypeEntity = to_PstMat ) or
         ( Main.TypeEntity = to_PstImm ) ) then
    begin
      NbAnc := 0;
      MakeAscendants( Main.TID, 1, IsTax, Alter, False, False, True,
                      IsExt, NbAnc, AncListe );
      AddItem( AnItem );
    end else

    // Treatment of non physical entities
    if ( ( Main.TypeEntity = to_non ) ) then
    begin
      NbAnc := 0;
      MakeAscendants( Main.TID, 1, IsTax, Alter, False, False, False,
                      IsExt, NbAnc, AncListe );
      AddItem( AnItem );
    end else

    // Standard treatment, with children
    if ( Main.TaxAnc > 0 ) then
    begin

      // First part: list of ancestors
      NbAnc := 0;
      MakeAscendants( Main.TID, 1, IsTax, Alter, False, False, False,
                      IsExt, NbAnc, AncListe );

      // Second part: main entity
      AddItem( AnItem );
    end;

      // Skip the descendants on taxonomic List pages
      if ( Self.PageType = ca_ListTax ) then
        Exit;

      // Third part: hierarchy of children left to right indented
      TooMuch := NbChildren >= cTooMuch;
      if ( NbChildren > 0 ) then
      begin

        // Open the children division
        AnItem := tBiColItem.Create;
        AnItem.TypeItem := tt_MakeODiv;
        AnItem.Value := cDivNameTax + '1';
        AddItem( AnItem );

        // Build all children of the taxonomy
        NbDiv := 2;
        MakeTaxDescendants( Main.TID, 2, True, TooMuch, True, True, False,
                            cDivNameTax, IsExt, NbDiv );
        NbTax := NbDiv - 1;

        // Close the children division
        AnItem := tBiColItem.Create;
        AnItem.TypeItem := tt_MakeEDiv;
        AddItem( AnItem );

        // Build the count of children
        Value := IntToStr( NbChildren ) + cSpace +
                 TAH.GetLabel( reChildren, False ) + cSpace +
                 cRol + IntToStr( NbSpecific ) + cSpace + 'leaves' + cRor;
        MyIndent := Chr( Ord( cBaseIndent ) + 1 );
        MyColor := TAH.MainLang;
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := TAH.GetLabel( reTotalList );
        AnItem.AltLabel := TAH.GetLabel( buTotalList );
        AnItem.Value := Value;
        AnItem.Bubble := cEmpty;
        AnItem.Url := cEmpty;
        AnItem.PartLink := cEmpty;
        AnItem.Indent := MyIndent;
        AnItem.Color := MyColor;
        AddItem( AnItem );
      end;
  end;
end; // ______________________________________________________tTaxoSection.Build

procedure          tHierarchySection.MakeAscendants(
  TID:             Integer;
  Level:           Integer;
  IsTax:           Boolean;
  Alter:           Boolean;
  IsPair:          Boolean;
  IsSet:           Boolean;
  IsPSet:          Boolean;
  IsExt:           Boolean;
  var NbAnc:       Integer;
  var AncListe:    Array of Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAscendants
  * Make the list of ancestors in a hierarchy *
  Description:
  This recursive procedure works on the taxonomy or the partonomy of entities
  as present in the TAH database. It writes the complete tree of ascendants
  of the specified node.<P>
  In addition, it may display alternate taxonomic hierarchies, when the
  actual taxonomy differs from a preceeding version. In this situation, the
  background colors are different.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  MyTID:           Integer;
  Index:           Integer;
  NbPos:           Integer;
  ATID:            Integer;
  MyPast:          Integer;
  Found:           Boolean;
  IsTopPart:       Boolean;
  IsItem:          Boolean;
  OKPseudo:        Boolean;
  Source:          String;
  ASource:         String;
  ViewCode:        String;
  BubbleCode:      String;
  Bubble:          String;
  AltBubble:       String;
  LinkText:        String;
  Marque:          String;
  MyIndent:        String;
  Value:           String;
  AltValue:        String;
  FMAID:           String;
  MyLink:          String;
  ALink:           String;
  AText:           String;
  PageType:        String;
  MyPageType:      String;
  MyChange:        String;
  LangDir:         String;
  MyColor:         tLanguage;
  Main:            tEntity;
  Actual:          tEntity;
  Father:          tEntity;
  OneMore:         tEntity;
  Trans:           tEntity;
  MyPair:          tEntity;
  ATerm:           tSingle;
  AnItem:          tBiColItem;
  AddItem1:        tBiColItem;
  AddItem2:        tBiColItem;
  AddItem3:        tBiColItem;
  MyPos:           Array[ 0 .. 2 ] of Integer;
begin

  // Retrieve the main entity
  PageType := cEntity;
  if ( IsExt ) then
    PageType := cTetrahedron;
  Main := Self.Entity;
  IsTopPart := False;
  if ( Main <> nil ) then
  begin

    // Retrieve the ancestor entity
    Found := False;
    Actual := TAH.GetEntityByTID( TID );
    if ( Actual <> nil ) then
    begin

      // First part: recursively ascending the hierarchy
      // ***********************************************

      // Handling of partonomy
      if ( not IsTax ) then
      begin

        // Move to the next ancestor level for partonomy
        MyTID := Actual.PartAnc;
        Father := TAH.GetEntityByTID( MyTID );
        if ( Father <> nil ) then
          IsTopPart := Father.Link = pw_Display;
        if ( ( MyTID > 0 ) and ( not IsTopPart ) and
             ( Actual.Link <> pw_Display ) ) then
        begin
          Self.MakeAscendants( MyTID, Level + 1, IsTax, Alter,
            IsPair, IsSet, IsPSet, IsExt, NbAnc, AncListe )
        end;
      end else

      // Handling of taxonomy
      // Check the list of displayed entities for taxonomy
      if ( IsTax ) then
      begin
        Marque := cEmpty;

        // Check for the presence of TID in the list
        Index := Actual.TID;
        for Indx := 0 to NbAnc - 1 do
        begin
          if AncListe[ Indx ] = Index then
          begin
            Found := True;
            Break;
          end;
        end; // for

        // Add a new entity to the list
        if not Found then
        begin
          Inc( NbAnc );
          AncListe[ NbAnc - 1 ] := Index;

          // Move to the next ancestor level for taxonomy
          if ( NbAnc > 1 ) then
          begin
            if ( Actual.Generator > 0 ) then
            begin
              MyPair := TAH.GetEntityByTID( Actual.Generator );
              MyTID := 0;
              if ( MyPair <> nil ) then
                MyTID := MyPair.TaxAnc;
            end else
              MyTID := Actual.TaxAnc;
          end else
          begin
            if ( Actual.TaxAnc > 0 ) then
            begin
              if ( Actual.TetraTip in [ tp_genpair, tp_single, tp_genpset,
                                        tp_genset, tp_leftpair, tp_rightpair,
                                        tp_tax, tp_voc, tp_int ] ) then
              begin
                MyTID := Actual.TaxAnc
              end else
              begin
                MyPair := TAH.GetEntityByTID( Actual.TaxAnc );
                MyTID := 0;
                if ( MyPair <> nil ) then
                  MyTID := MyPair.Generator;
              end;
            end else
            begin
              MyPair := TAH.GetEntityByTID( Actual.Generator );
              MyTID := 0;
              if ( MyPair <> nil ) then
                MyTID := MyPair.TaxAnc;
            end;
          end;
          if ( MyTID > 0 ) then
          begin
            Self.MakeAscendants( MyTID, Level + 1, IsTax, Alter,
              IsPair, IsSet, IsPSet, IsExt, NbAnc, AncListe );
          end;
        end;

        // Check for alternate taxonomic hierarchy
        if ( IsExt ) then
        begin
          MyTID := Actual.PastTaxAnc;
          if ( FMAChange and ( MyTID > 0 ) ) then
          begin
            Self.MakeAscendants( MyTID, Level + 1, IsTax, True,
              IsPair, IsSet, IsPSet, IsExt, NbAnc, AncListe );
          end;
        end;
      end;

      // Second part: write the hierarchy
      // ********************************

      // Discard the main entity
      if ( Level = 1 ) then
        Exit;

      // Discard unnecessary entity on top of hierarchy
      if ( Actual.TID = 7973 ) then
        Exit;

      // Skip not neccessary entities at top of taxonomy
      if ( IsTax and ( Actual.TID = 10188 ) ) then
        Exit;
      if ( Actual.TID = 8719 ) then
        Exit;
      if ( ( ( not FMAHist ) or ( not FMAChange ) ) and Alter ) then
        Exit;

      // Search for an existing pseudo entity to replace actual entity
      OKPseudo := False;
      AddItem1 := nil;
      AddItem2 := nil;
      AddItem3 := nil;
      if ( IsTax  and ( IsPair or IsSet or IsPSet ) ) then
      begin
        OKPseudo := True;
        NbPos := 0;
        TAH.GetPositionsByGen( Actual.TID, NbPos, MyPos );
        for Indx := 0 to NbPos - 1 do
        begin
          Trans := TAH.GetEntityByPos( MyPos[ Indx ] );
          if ( Trans = nil ) then
            Break;
          if ( ( ( IsPSet ) and
                 ( ( Trans.TypeEntity = to_PstMat ) or
                   ( Trans.TypeEntity = to_PstImm ) ) ) or
               ( ( IsPair ) and
                 ( ( Trans.TypeEntity = to_ParMat ) or
                  ( Trans.TypeEntity = to_ParImm ) ) ) or
               ( ( IsSet ) and
                 ( ( Trans.TypeEntity = to_SetMat ) or
                   ( Trans.TypeEntity = to_SetImm ) ) ) ) then
          begin
            Actual := Trans;
            OKPseudo := False;
            Break;
          end;
        end; // for
      end;

      // Prepare the content for each entity in hierarchy
      // Write the FMA ID in left column
      if ( ( IsTax ) and ( Actual.FID > 0 ) ) then
      begin
        FMAID := IntToStr( Actual.FID );
        ViewCode := cFMA + cColumn + FMAID;
        ViewCode := AOTAG + cHrefEmpty + BioPortalUrl + FMAID + cDQuote +
                    cAnr + ViewCode + AETAG;
        BubbleCode := cTAH + IntToStr( Actual.TID );
      end else
      begin
        ViewCode := cTAH + IntToStr( Actual.TID );
        BubbleCode := cEmpty;
      end;
      Source := ViewCode;

      if ( Actual.TID = 39330 ) then
        Source := Source;

      // Write indented term in right column and current language in bubble
      if ( Actual.TypeEntity = to_non ) then
      begin
        Value := Actual.GetLibelle( lb_Title, TAH.MainLang );
        if ( Value = cEmpty ) then
          Value := Actual.GetLibelle( lb_Official, TAH.MainLang );
      end else
      if ( IsExt ) then
      begin
        Value := Actual.GetLibelle( lb_Base, TAH.MainLang );
        Bubble := Actual.GetLibelle( lb_Base, TAH.SubstLang );
      end else
      begin
        Value := Actual.GetLibelle( lb_Official, TAH.MainLang );
        Bubble := Actual.GetLibelle( lb_Official, TAH.SubstLang );
      end;
      MyIndent := Chr( Ord( cBaseIndent ) + Level - 1 );
      MyColor := lt_Latin;

      // Select color for history of change
      // light yellow: lt_Latin for normal entities
      // light blue: lt_french for new entities
      // light pink: lt_English for modified entities
      // light gray: lt_Dutch for past ancestors
      // light green: lt_Italian for pseudo entities
      if ( IsExt ) then
      begin
        // Light blue color is selected for showing new entities
        if ( ( IsTax and FMAChange ) and ( Actual.ChLink = 'n' ) ) then
          MyColor := lt_French;

        // Light pink color is selected for showing updated entities
        if ( ( IsTax and FMAChange ) and ( Actual.ChLink = 'm' ) ) then
          MyColor := lt_English;
        Trans := TAH.GetEntityByPos( Actual.Generator );
        if ( ( Trans <> nil ) and ( Trans.ChLink = 'm' ) ) then
          MyColor := lt_English;

        // Other color is selected for showing ancestor of modified entities
        if ( IsTax and Alter and FMAChange ) then
          MyColor := lt_Italian;
      end;

      // Prepare presentation of pseudo entities in taxonomy only
      IsItem := False;
      if ( IsTax and OKPseudo and ( Level > 1 ) and
          ( IsPair or IsSet or IsPSet ) ) then
      begin
        if ( IsPair ) then
          AText := cParLA
        else if ( IsSet ) then
          AText := TAH.GetLabel( reClassis, False, TAH.MainLang )
        else if ( IsPSet ) then
          if ( TAH.MainLang = lt_Latin ) then
            AText := cParClassiumLA
          else if ( TAH.MainLang = lt_English ) then
            AText := cParClassiumEN
          else if ( TAH.MainLang = lt_French ) then
            AText := cParClassiumFR
          else if ( TAH.MainLang = lt_Spanish ) then
            AText := cParClassiumES
          else if ( TAH.MainLang = lt_Russian ) then
            AText := cParClassiumRU;
        if ( ( Actual.TID <> 10123 ) and
             ( Actual.TID <> 10124 ) and
             ( Actual.TID <> 10126 ) and
             ( Actual.TID <> 10127 ) ) then
        begin
          Value := Atext + cSpace + cRol + cSpace + Value + cSpace + cRor;
          MyIndent := Chr( Ord( cBaseIndent ) + Level - 1 );
          if ( ( MyColor = lt_Latin ) and FMAChange ) then
            MyColor := lt_Dutch;
        end else
        begin

          // Check for last upper level pseudo entities
          if ( ( Actual.TID = 10126 ) or ( Actual.TID = 10127 ) ) then
          begin
            // Initialize
            AddItem1 := nil;
            AddItem2 := nil;
            AddItem3 := nil;

            // Additional item for the new res corporea aggregata
            if ( Actual.TID = 10126 ) then
            begin
              ATID := 10132;
              OneMore := TAH.GetEntityByTID( ATID );
              if ( OneMore <> nil ) then
              begin
                AddItem1 := tBiColItem.Create;
                AddItem1.SrcLabel := cTAH + IntToStr( ATID );
                AddItem1.AltLabel := cEmpty;
                AddItem1.Value := cRoundImg +
                                  OneMore.GetLibelle( lb_Base, TAH.MainLang );
                AddItem1.Bubble := OneMore.GetLibelle( lb_Base, TAH.SubstLang );
                AddItem1.Indent := Chr( Ord( cBaseIndent ) + Level );
                if ( FMAChange ) then
                  AddItem1.Color := lt_French
                else
                  AddItem1.Color := lt_Latin;
              end;
            end;

            // Additional item for the new res incorporea aggregata
            if ( Actual.TID = 10127 ) then
            begin
              ATID := 20244;
              OneMore := TAH.GetEntityByTID( ATID );
              if ( OneMore <> nil ) then
              begin
                AddItem1 := tBiColItem.Create;
                AddItem1.SrcLabel := cTAH + IntToStr( ATID );
                AddItem1.AltLabel := cEmpty;
                AddItem1.Value := cRoundImg +
                                  OneMore.GetLibelle( lb_Base, TAH.MainLang );
                AddItem1.Bubble := OneMore.GetLibelle( lb_Base, TAH.SubstLang );
                AddItem1.Indent := Chr( Ord( cBaseIndent ) + Level );
                if ( FMAChange ) then
                  AddItem1.Color := lt_French
                else
                  AddItem1.Color := lt_Latin;
              end;
            end;

            // Additional item for history of classis rerum corporearum
            if ( ( Actual.TID = 10126 ) and
                 ( ( IsSet or IsPSet ) and FMAHist and FMAChange ) ) then
            begin
              AddItem2 := tBiColItem.Create;
              AddItem2.SrcLabel := cTAH + IntToStr( 10126 );
              AddItem2.AltLabel := cEmpty;
              AddItem2.Value := cRoundImg +
                                Actual.GetLibelle( lb_Base, TAH.MainLang );
              AddItem2.Bubble := Actual.GetLibelle( lb_Base, TAH.SubstLang );
              AddItem2.Indent := Chr( Ord( cBaseIndent ) + Level );
              if ( FMAChange ) then
                AddItem2.Color := lt_Italian
              else
                AddItem2.Color := lt_Latin;
            end;

            // Additional item for history of classis rerum incorporearum
            if ( ( Actual.TID = 10127 ) and
                 ( IsSet and FMAHist and FMAChange ) ) then
            begin
              AddItem2 := tBiColItem.Create;
              AddItem2.SrcLabel := cTAH + IntToStr( 10127 );
              AddItem2.AltLabel := cEmpty;
              AddItem2.Value := cRoundImg +
                                Actual.GetLibelle( lb_Base, TAH.MainLang );
              AddItem2.Bubble := Actual.GetLibelle( lb_Base, TAH.SubstLang );
              AddItem2.Indent := Chr( Ord( cBaseIndent ) + Level );
              if ( FMAChange ) then
                AddItem2.Color := lt_Italian
              else
                AddItem2.Color := lt_Latin;
            end;

            // Additional item for the composite of res corporea
            if ( Actual.TID = 10126 ) then
            begin
              ATID := 0;
              if ( IsPair ) then
                ATID := 10281
              else if ( IsSet ) then
                ATID := 20182
              else if ( IsPSet ) then
                ATID := 20183;
              OneMore := TAH.GetEntityByTID( ATID );
              if ( OneMore <> nil ) then
              begin
                AddItem3 := tBiColItem.Create;
                AddItem3.SrcLabel := cTAH + IntToStr( ATID );
                if ( ( OneMore.FID > 0 ) and ( ATID = 20182 ) ) then
                begin
                  ASource := cFMA + IntToStr( OneMore.FID );
                  ALink := AOTAG + cSpace + cHrefEmpty + ASource + cSpace +
                            PageType + cSpace + cLgShort[ TAH.DisLanguage ] +
                            cPeriod + HtmlExt + cDQuote + cAnr + MyLink + AETAG;
                  ASource := AOTAG + cHrefEmpty + FMEBaseUrl + cQuest +
                             cFmaID + cEqual + IntToStr( OneMore.FID ) +
                             cDQuote + cAnr + ASource + AETAG;
                  AddItem3.SrcLabel := ASource;
                  AddItem3.AltLabel := cTAH + '20182';
                end;
                AddItem3.Value := cRoundImg +
                                  OneMore.GetLibelle( lb_Base, TAH.MainLang );
                AddItem3.Bubble := OneMore.GetLibelle( lb_Base, TAH.SubstLang );
                AddItem3.Indent := MyIndent;
                if ( FMAChange ) then
                begin
                  AddItem3.Color := lt_French;
                  if ( IsSet ) then
                    AddItem3.Color := lt_English;
                end else
                  AddItem3.Color := lt_Latin;
              end;
            end;

            // Make an additional item for the composite of res incorporea
            if ( Actual.TID = 10127 ) then
            begin
              ATID := 0;
              if ( IsPair ) then
                ATID := 10526
              else if ( IsSet ) then
                ATID := 20245
              else if ( IsPSet ) then
                ATID := 20246;
              OneMore := TAH.GetEntityByTID( ATID );
              if ( OneMore <> nil ) then
              begin
                AddItem3 := TBiColItem.Create;
                AddItem3.SrcLabel := cTAH + IntToStr( ATID );
                if ( ( OneMore.FID > 0 ) and ( ATID = 20245 ) ) then
                begin
                  ASource := cFMA + IntToStr( OneMore.FID );
                  ALink := AOTAG + cSpace + cHrefEmpty + ASource + cSpace +
                            PageType + cSpace + cLgShort[ TAH.DisLanguage ] +
                            cPeriod + HtmlExt + cDQuote + cAnr + MyLink + AETAG;
                  ASource := AOTAG + cHrefEmpty + FMEBaseUrl + cQuest +
                             cFmaID + cEqual + IntToStr( OneMore.FID ) +
                             cDQuote + cAnr + ASource + AETAG;
                  AddItem3.SrcLabel := ASource;
                  AddItem3.AltLabel := cTAH + '20245';
                end;
                AddItem3.Value := cRoundImg +
                                  OneMore.GetLibelle( lb_Base, TAH.MainLang );
                AddItem3.Bubble := OneMore.GetLibelle( lb_Base, TAH.SubstLang );
                AddItem3.Indent := MyIndent;
                if ( FMAChange ) then
                begin
                  AddItem3.Color := lt_French;
                  if ( IsSet ) then
                    AddItem3.Color := lt_English;
                end else
                  AddItem3.Color := lt_Latin;
              end;
            end;

            IsItem := True;
          end;
          MyIndent := Chr( Ord( cBaseIndent ) + Level + 1 );
        end;
      end else

      // Last entity
      if ( IsTax and ( IsPair or IsSet or IsPSet ) and ( Level = 1 ) ) then
      begin

        NbPos := 0;
        TAH.GetPositionsByGen( Actual.TID, NbPos, MyPos );
        for Indx := 0 to NbPos - 1 do
        begin
          Actual := TAH.GetEntityByPos( MyPos[ Indx ] );
          if ( ( ( IsPair ) and
                 ( ( Actual.TypeEntity = to_ParMat ) or
                   ( Actual.TypeEntity = to_ParImm ) ) ) or
               ( ( IsSet ) and
                 ( ( Actual.TypeEntity = to_SetMat ) or
                   ( Actual.TypeEntity = to_SetImm ) ) ) or
               ( ( IsPSet ) and
                 ( ( Actual.TypeEntity = to_PstMat ) or
                   ( Actual.TypeEntity = to_PstImm ) ) ) ) then
          begin
            Value := Actual.GetLibelle( lb_Base, TAH.MainLang );
            Break;
          end;
        end;  // for
      end;

      // Define the Url to the Entity Page of current entity
      LangDir := cLgShort[ TAH.MainLang ];
      if ( TAH.MainLang = lt_Latin ) then
        LangDir := LangDir + cLgShort[ TAH.SubstLang ];
      LangDir := LangDir + cSlash;
      LinkText := cEmpty;
      if ( Level > 1 ) then
      begin
        ViewCode := cTAH + IntToStr( Actual.TID );
        LinkText := cHrefEmpty + cRetroDir + LangDir +
                    ViewCode + cSpace + cEntity +
                    cSpace + cLgShort[ TAH.DisLanguage ] + cPeriod +
                    HtmlExt + cDQuote + cAnr;
      end;

      // Add the link to relatio entity corresponding to partonomic ancestor
      MyLink := cEmpty;
      if ( ( not IsTax ) and ( not IsTopPart ) ) then
      begin
        if ( ( Actual.Link <> pw_Top ) and ( Actual.TID <> 13545 ) and
             ( Actual.PartAnc <> 0 ) and ( Actual.Link <> pw_Display ) ) then
        begin
          MyLink := cRol + cLinkLong[ Actual.Link ] + cRor;
          ViewCode := cTAH + IntToStr( cLinkID[ Actual.Link ] );
          MyLink := AOTAG + cSpace + cHrefEmpty + cRetroDir + LangDir +
                    ViewCode + cSpace + cEntity + cSpace +
                    cLgShort[ TAH.DisLanguage ] + cPeriod +
                    HtmlExt + cDQuote + cAnr + MyLink + AETAG;
        end;
      end;

      // Mark non source FMA entities in taxonomy
      if ( IsTax and ( Actual.FID = 0 ) ) then
        Marque := cAster + cSpace
      else
        Marque := cEmpty;

      // Prepare bubble for term in substitution language
      if ( IsTax ) then
      begin
        Actual.LgCurrent := TAH.SubstLang;
        Actual.Query := tSearch.Create( st_FMA );
        Actual.SearchTerm;
        ATerm := Actual.CurrSingle;
        if ( ATerm <> nil ) then
        begin
          Marque := cEmpty;
          Bubble := ATerm.Mandat + ATerm.Option;
        end else
        begin
          if ( Actual.TypeEntity = to_non ) then
          begin
            Bubble := Actual.GetLibelle( lb_Title, TAH.SubstLang );
            if ( Bubble = cEmpty ) then
              Bubble := Actual.GetLibelle( lb_Official, TAH.SubstLang );
          end else
          begin
            Actual.Query.MyType := st_Bas;
            Actual.SearchTerm;
            ATerm := Actual.CurrSingle;
            if ( ATerm <> nil ) then
              Bubble := ATerm.Mandat + ATerm.Option
            else
              Bubble := Actual.GetLibelle( lb_Base, TAH.SubstLang );
          end;
        end;
      end;
      if ( Marque <> cEmpty ) then
        Bubble := Marque + Bubble;

      // Return variables
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := Source;
      AnItem.AltLabel := BubbleCode;
      AnItem.Value := cRoundImg + Value;
      AnItem.Bubble := Bubble;
      AnItem.Url := LinkText;
      AnItem.PartLink := MyLink;
      AnItem.Indent := MyIndent;
      AnItem.Color := MyColor;
      AddItem( AnItem );

      // Additional lines
      if ( IsItem ) then
      begin
        if ( AddItem1 <> nil ) then
        begin
          AddItem1.PartLink := MyLink;
          AddItem1.Url := LinkText;
          AddItem( AddItem1 );
        end;
        if ( AddItem2 <> nil ) then
        begin
          AddItem2.PartLink := MyLink;
          AddItem2.Url := LinkText;
          AddItem( AddItem2 );
        end;
        if ( AddItem3 <> nil ) then
        begin
          AddItem3.PartLink := ALink;
          AddItem3.Url := LinkText;
          AddItem( AddItem3 );
        end;
      end;
    end;
  end;
end; // __________________________________________________________MakeAscendants

procedure          tHierarchySection.MakePartUnitDescendants(
  TID:             Integer;
  Level:           Integer;
  TooMuch:         Boolean;
  Recur:           Boolean;
  DivName:         String;
  IsExt:           Boolean;
  var NbDiv:       Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePartUnitDescendants
  * Make the list of children in the partonomy of a Unit Page *
  Description:
  This recursive procedure works on a partonomy of the model of anatomy
  as present in the TAH database. It writes a tetra view of the tree of
  descendants of the specified node in the partonomy, depending on the
  number of descendants.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Indz:            Integer;
  Inds:            Integer;
  Posit:           Integer;
  NbChildren:      Integer;
  NbTrueChildren:  Integer;
  NbSpecific:      Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  ActDiv:          Integer;
  First:           Integer;
  NbProps:         Integer;
  IsRef:           Boolean;
  IsPar:           Boolean;
  IsOpen:          Boolean;
  Children:        String;
  SortList:        String;
  ViewCode:        String;
  LinkText:        String;
  Bubble:          String;
  ViewBubble:      String;
  MyIndent:        String;
  Value:           String;
  MyLink:          String;
  Toggle:          String;
  AddIcon:         String;
  Linkage:         String;
  PageType:        String;
  LangDir:         String;
  MyColor:         tLanguage;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          tEntity;
  AChild:          tEntity;
  AChildRef:       tEntity;
  Father:          tEntity;
  AnItem:          tBiColItem;
  AnItem2:         tBiColItem;
  AllProps:        tLinkage;
  MyProp:          PropsRec;
begin
  // Initial stuff
  PageType := cEntity;
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get children and their number
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

  // Loop on all children
  ActDiv := 0;
  IsRef := False;
  for Indx := 1 to NbTrueChildren do
  begin
    Isopen := False;

    // Search next child according to sortlist
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
    MyColor := lt_Latin;

    // Retrieve the child entity
    AChild := TAH.GetEntityByTID( Child[ Inds ] );
    if ( AChild <> nil ) then
    begin

      // Handling of a possible reference
      IsRef := ( AChild.Reference > 0 );
      AChildRef := nil;
      if ( IsRef ) then
      begin
        AChildRef := AChild;
        AChild := TAH.GetEntityByTID( AChild.Reference );
      end;

      // Prepare the left column for the next child
      ViewBubble := cTAHEntity + IntToStr( AChild.TID );
      ViewCode := cTAHUnit + IntToStr( AChild.Tetra );

      // Do not show left and right entities in light presentation
      if ( ( AChild.Link <> pw_MemberL ) and
           ( AChild.Link <> pw_MemberR ) and
           ( AChild.Link <> pw_SMemberL ) and
           ( AChild.Link <> pw_SMemberR ) and
           ( AChild.Link <> pw_IMemberL ) and
           ( AChild.Link <> pw_IMemberR ) and
           ( AChild.Link <> pw_TMemberL ) and
           ( AChild.Link <> pw_TMemberR ) ) then
      begin

        // Prepare indentation, value, etc
        LangDir := cLgShort[ TAH.MainLang ];
        if ( TAH.MainLang = lt_Latin ) then
          LangDir := LangDir + cLgShort[ TAH.SubstLang ];
        LangDir := LangDir + cSlash;
        MyIndent := Chr( Ord( 'a' ) + Level - 1 );
        Value := AChild.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
        PageType := cTetrahedron;
        LinkText := cHrefEmpty + cRetroDir + LangDir +
                    cTAH + IntToStr( AChild.Tetra ) + cSpace +
                    cUnit + cSpace + cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr;
        Bubble := AChild.GetLibelle( lb_Official, TAH.SubstLang,
                  st_undef, True );

        // Handling of a reference
        if ( IsRef ) then
          MyLink := AOTAG + cSpace + cHrefEmpty + ViewCode + cSpace + cEntity +
                    cSpace + cLgShort[ lt_English ] + cPeriod +
                    HtmlExt + cDQuote + cAnr + AETAG
        else
          MyLink := cEmpty;

        // Prepare toggle button
        IsPar := ( ( AChild.TypeEntity = to_ParMat ) or
                   ( AChild.TypeEntity = to_ParImm ) or
                   ( AChild.TypeEntity = to_PstMat ) or
                   ( AChild.TypeEntity = to_PstImm ) );
        if ( ( ( not IsRef ) and
               ( IsPar ) and              // more than two children in partonomy
               ( AChild.NbPartC > 2 ) ) or // for a pair
             ( ( not IsRef ) and
               ( not IsPar ) and              // at least one child in partonomy
               ( AChild.NbPartC > 0 ) ) ) then // if not a pair
        begin
          Toggle := MakeToggle( DivName + IntToStr( NbDiv ) );
          IsOpen := True;
        end else
          Toggle := cRoundImg;

        // Add icon for references
        First := -1;
        AddIcon := cEmpty;
        if ( IsRef ) then
        begin
          AddIcon := cRefImg;

          // Add model linkage to partonomic father when available
          AllProps := TAH.BiProperties;
          if ( AllProps <> nil ) then
            First := AllProps.PROPSGetPositionByTID( AChild.TID );
          if ( First > -1 ) then
          begin
            NbProps := AllProps.TotProps;
            for Indz := 0 to NbProps - 1 do
            begin
              MyProp := AllProps.BiProp( First + Indz );
              Father := Actual;
              if ( ( Father.TypeEntity = to_ParMat ) or
                   ( Father.TypeEntity = to_ParImm ) or
                   ( Father.TypeEntity = to_PstMat ) or
                   ( Father.TypeEntity = to_PstImm ) ) then
                Father := TAH.GetEntityByTID( Actual.Generator );
              if ( MyProp.Right = Father.TID ) then
              begin
                Linkage := cPROPS[ tPropType( MyProp.RID - 1 ) ];
                AddIcon := AddIcon + Linkage;
                Break;
              end;
            end; // for
          end;
        end;

        // Return variables
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.AltLabel := ViewBubble;
        AnItem.Value := Toggle + Value;
        AnItem.Bubble := Bubble;
        AnItem.Url := LinkText;
        AnItem.PartLink := MyLink;
        AnItem.Indent := MyIndent;
        AnItem.Color := MyColor;
        AnItem.IconRight := AddIcon;
        AddItem( AnItem );

        // Open a subdivision of descendants
        if ( IsOpen ) then
        begin
          AnItem2 := tBiColItem.Create;
          AnItem2.TypeItem := tt_MakeODiv;
          AnItem2.Value := DivName + IntToStr( NbDiv );
          ActDiv := NbDiv;
          Inc( NbDiv );
          AddItem( AnItem2 );
        end;

        // Call for next level
        if ( ( not TooMuch ) and
             ( Recur ) and
             ( MyColor <> lt_German ) ) then
        begin
          if ( IsRef ) then
            Self.MakePartUnitDescendants( AChildRef.TID, Level + 1,
              False, Recur, DivName, IsExt, NbDiv )
          else
            Self.MakePartUnitDescendants( AChild.TID, Level + 1,
              False, Recur, DivName, IsExt, NbDiv );
        end else
        begin

          // Compute number of children and specific entities
          if ( ( MyColor <> lt_German )and ( not IsRef ) ) then
          begin
            NbChildren := 0;
            NbSpecific := 0;
            AChild.GetNumberOfChildren( False, False, True, NbChildren,
                                        NbSpecific );
            if ( NbChildren > 0 ) then
            begin
              AnItem := tBiColItem.Create;
              Value := '...' + cSpace + IntToStr( NbChildren ) + cSpace +
                       'children' + cSpace + cRol + IntToStr( NbSpecific ) +
                       cSpace + 'leaves' + cRor;
              MyIndent := Chr( Ord( 'a' ) + 2 );
              MyColor := TAH.MainLang;

              // Return variables
              AnItem.SrcLabel := cEmpty;
              AnItem.AltLabel := cEmpty;
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.Url := cEmpty;
              AnItem.PartLink := cEmpty;
              AnItem.Indent := MyIndent;
              AnItem.Color := MyColor;
              AddItem( AnItem );
            end;
          end;
        end; // next level
      end; // no show left and right
    end; // AChild <> nil

    // Close a subdivision of descendants
    if ( IsOpen ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.TypeItem := tt_MakeEDiv;
      AnItem.Bubble := DivName + IntToStr( ActDiv );
      AddItem( AnItem );
    end;
  end; // for
end; // _________________________________________________MakePartUnitDescendants

procedure          tHierarchySection.MakeTaxDescendants(
  TID:             Integer;
  Level:           Integer;
  IsTax:           Boolean;
  TooMuch:         Boolean;
  Recur:           Boolean;
  IsInf:           Boolean;
  AncLink:         Boolean;
  DivName:         String;
  IsExt:           Boolean;
  var NbDiv:       Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxDescendants
  * Make the list of children in the taxonomy *
  Description:
  This recursive procedure works on a taxonomy of the model of anatomy
  as present in the TAH database. It writes all or a part of the tree of
  descendants of the specified node in the taxonomy, depending on the
  number of descendants.<P>
  Description of arguments:
  MySection: container of all the lines of the page,
  TID: identifier of current entity,
  Level: actual level of indentation in recursive process,
  IsTax: flag for taxonomy or partonomy,
  TooMuch: flag when number of children is above the internal limit,
  Recur: allow recursion down the hierarchy,
  IsInf: flag ???
  AncLink: flag for display of links to ancestor,
  DivName: name of division related to expansion options in the hierarchy,
  IsExt: flag for Extended Page
  NbDiv: number of created divisions.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  Posit:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  NbTrueChildren:  Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  TrueTot:         Integer;
  ActDiv:          Integer;
  First:           Integer;
  IsFma:           Boolean;
  IsRef:           Boolean;
  IsPar:           Boolean;
  Children:        String;
  SortList:        String;
  ViewCode:        String;
  LinkText:        String;
  Bubble:          String;
  ViewBubble:      String;
  Marque:          String;
  MyIndent:        String;
  Value:           String;
  MyLink:          String;
  FMAID:           String;
  Toggle:          String;
  AddIcon:         String;
  Linkage:         String;
  PageType:        String;
  MyTID:           String;
  LangDir:         String;
  MyColor:         tLanguage;
  ALink:           tLink;
  Order:           Array[ 1 .. 100 ] of Integer;
  Child:           Array[ 1 .. 100 ] of Integer;
  Actual:          tEntity;
  AChild:          tEntity;
  Father:          tEntity;
  AnItem:          tBiColItem;
  AnItem2:         tBiColItem;
  AllProps:        tLinkage;
  MyProp:          PropsRec;
begin
  // Initial stuff
  PageType := cEntity;
  if ( IsExt ) then
    PageType := cTetrahedron;
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get children and their number
  if ( IsTax ) then
  begin
    Children := Actual.TaxCh;
    SortList := Actual.TaxPos;
    NbTrueChildren := Actual.NbTaxC;
    if ( Actual.PastTaxCh <> cEmpty ) then
      if ( Children <> cEmpty ) then
      begin
        Children := Children + cSemi + Actual.PastTaxCh;
        SortList := SortList + cSemi + Actual.PastTaxPos;
      end else
      begin
        Children := Actual.PastTaxCh;
        SortList := Actual.PastTaxPos;
      end;
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

  // Display FMA changes
  TrueTot := NbTrueChildren;
  if ( FMAChange ) then
    TrueTot := NbChildren;

  // Loop on all children
  ActDiv := 0;
  IsRef := False;
  for Indx := 1 to TrueTot do
  begin

    // Search next child according to sortlist
    Small := 1;
    AnOrder := Order[ Small];
    for Indy := 2 to TrueTot do
    begin
      if ( ( Indx <= NbTrueChildren ) and ( Indy > NbTrueChildren ) ) then
        Continue;
      if Order[ Indy ] < AnOrder then
      begin
        Small := Indy;
        AnOrder := Order[ Small];
      end;
    end; // for
    Inds := Small;
    Order[ Small ] := 10000;
    MyColor := lt_Latin;

    // Retrieve the child entity
    AChild := TAH.GetEntityByTID( Child[ Inds ] );
    if ( AChild <> nil ) then
    begin

      // Remove left and right entities
      if ( IsInf and not IsExt) then
      begin
        ALink := AChild.Link;
        if ( ALink in [ pw_MemberL, pw_MemberR, pw_SMemberL, pw_SMemberR,
             pw_IMemberL, pw_IMemberR, pw_TMemberL, pw_TMemberR ] ) then
          Continue;
      end;

      // Handling of a possible reference
      IsRef := ( ( not IsTax ) and ( IsInf ) and ( AChild.Reference > 0 ) );
      if ( IsRef ) then
      begin
        ViewCode := cTAH + IntToStr( AChild.Reference );
        AChild := TAH.GetEntityByTID( AChild.Reference );
      end;
      if ( ( not IsRef ) and ( AChild.Reference > 0 ) ) then
        Continue;

      // Prepare the left column for the next child
      if ( IsTax and IsExt and ( AChild.FID > 0 ) ) then
      begin
        FMAID := IntToStr( AChild.FID );
        ViewCode := cFMA + FMAID;
        ViewCode := AOTAG + cHrefEmpty + FMEBaseUrl +
                    '?fmaid=' + FMAID + cDQuote + cAnr + ViewCode + AETAG;
        ViewBubble := cTAH + IntToStr( AChild.TID );
      end else
      begin
        ViewCode := cTAH + IntToStr( AChild.TID );
        ViewBubble := cEmpty;
        if ( AChild.FID > 0 ) then
          ViewBubble := cFMA + IntToStr( AChild.FID );
      end;

      // Prepare the background color for history of modifications
      MyColor := lt_Latin;                 // light yellow for background
      if ( IsTax and FMAChange ) then
      begin
        if ( AChild.ChLink = 'n' ) then  // light blue for new entiy
          MyColor := lt_French
        else
        if ( AChild.ChLink = 'd' ) then  // yellow for deleted entity
          MyColor := lt_Italian
        else
        if ( ( AChild.ChLink = 'm' ) and ( Indx > NbTrueChildren ) ) then
        begin
          MyColor := lt_German;          // red for modified entity (before)
          Continue;
        end else
        if ( AChild.ChLink = 'm' ) then  // pink for modified entity (after)
          MyColor := lt_English;
      end;

      // Prepare indentation, value, etc
      MyIndent := Chr( Ord( 'a' ) + Level - 1 );
      Value := AChild.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
      if ( Value = cEmpty ) then
        Value := AChild.GetLibelle( lb_Title, TAH.MainLang, st_undef, True );
      MyLink := cEmpty;
      if ( not IsTax ) then
      begin
        ALink := AChild.Link;
        if ( IsInf ) then
        begin
          if ( AChild.Link = pw_PairPartOf ) then
            ALink := pw_PartOf;
          if ( AChild.Link = pw_PairMemberOf ) then
            ALink := pw_MemberOf;
          if ( AChild.Link = pw_PairMemberIn ) then
            ALink := pw_MemberIn;
          if ( AChild.Link = pw_PMemberOf ) then
            ALink := pw_MemberOf;
          if ( AChild.Link = pw_PairSetOf ) then
            ALink := pw_SetOf;
          if ( AChild.Link = pw_PairSetIn ) then
            ALink := pw_SetIn;
          if ( AChild.Link = pw_PairOf ) then
            ALink := pw_PartOf;
          if ( AChild.Link = pw_PairSpaceIn ) then
            ALink := pw_SurfaceIn;
          if ( AChild.Link = pw_BranchPairOf ) then
            ALink := pw_BranchOf;
          if ( AChild.Link = pw_PairSetOf ) then
            ALink := pw_SetOf;
          if ( AChild.Link = pw_PairSubsetOf ) then
            ALink := pw_SubsetOf;
        end;
        MyLink := cEmpty;
        if ( ( AncLink ) and ( ALink <> pw_Display ) ) then
        begin
          LangDir := cLgShort[ TAH.MainLang ];
          if ( TAH.MainLang = lt_Latin ) then
            LangDir := LangDir + cLgShort[ TAH.SubstLang ];
          LangDir := LangDir + cSlash;
          MyLink := cRol + cLinkLong[ ALink ] + cRor;
          ViewCode := cTAH + IntToStr( cLinkID[ ALink ] );
          MyLink := AOTAG + cSpace + cHrefEmpty + ViewCode + cSpace + PageType +
                    cSpace + cLgShort[ lt_English ] + cPeriod +
                    HtmlExt + cDQuote + cAnr + MyLink + AETAG;
        end;
      end;
      MyTID := IntToStr( AChild.Tetra );
      LinkText := cHrefEmpty + cTAH + MyTID + cSpace + cUnit + cSpace +
                  cLgShort[ TAH.SubstLang ] + cPeriod +
                  HtmlExt + cDQuote + cAnr;
      if ( IsTax and ( AChild.FID = 0 ) ) then
        Marque := '* '
      else
        Marque := cEmpty;

      // Handling of a reference
      if ( IsRef ) then
        MyLink := AOTAG + cSpace + cHrefEmpty + ViewCode + cSpace + PageType +
                  cSpace + cLgShort[ lt_English ] + cPeriod +
                  HtmlExt + cDQuote + cAnr + MyLink + AETAG;

      // Prepare bubble for term in substitution language
      Bubble := AChild.GetLibelle( lb_Base, TAH.SubstLang );
      if ( Bubble = cEmpty ) then
        Bubble := AChild.GetLibelle( lb_Title, TAH.SubstLang, st_undef, True );
      if ( IsTax ) then
      begin
        AChild.LgCurrent := lt_English;
        AChild.Query := tSearch.Create( st_FMA );
        AChild.SearchTerm;
        IsFma := AChild.CurrSingle <> nil;
        if ( IsFma ) then
          Marque := cEmpty;
      end;
      if ( Marque <> cEmpty ) then
        Bubble := Marque + Bubble;

      // Prepare toggle button
      IsPar := ( ( AChild.TypeEntity = to_ParMat ) or
                 ( AChild.TypeEntity = to_ParImm ) or
                 ( AChild.TypeEntity = to_PstMat ) or
                 ( AChild.TypeEntity = to_PstImm ) );
      if ( ( ( Istax ) and
             ( AChild.NbTaxC > 0 ) and   // at least one child in taxonomy
             ( AChild.TetraTip <> tp_genpair ) ) or
           ( ( Istax ) and
             ( AChild.NbTaxC > 2 ) and   // more than two children in taxonomy
             ( not ( AChild.TetraTip in [ tp_genpair, tp_genpset ] ) ) ) or
           ( ( not Istax ) and
             ( not IsRef ) and
             ( IsPar ) and               // more than two children in partonomy
             ( AChild.NbPartC > 2 ) ) or // for a pair
           ( ( not Istax ) and
             ( not IsRef ) and
             ( not IsPar ) and               // at least one child in partonomy
             ( AChild.NbPartC > 0 ) ) ) then // if not a pair
      begin
        Toggle := MakeToggle( DivName + IntToStr( NbDiv ) );
      end else
      begin
        Toggle := cRoundImg;
      end;

      // Add icon for generator (inferred partonomy only)
      AddIcon := cEmpty;
      if ( ( AChild.Generator > 0 ) and ( IsInf ) ) then
      begin
        AddIcon := cLinkGenerImg;
        AddIcon := AOTAG + cSpace + cHrefEmpty +
                   cTAH + IntToStr( AChild.Generator ) + cSpace + cEntity +
                   cSpace + cLgShort[ lt_English ] + cPeriod +
                   HtmlExt + cDQuote + cAnr + AddIcon + AETAG;
      end;

      // Add icon for references
      First := -1;
      if ( IsRef ) then
      begin
        AddIcon := AddIcon + cSpace + cRefImg;

        // Add linkage to partonomic father when available
        AllProps := TAH.BiProperties;
        if ( AllProps <> nil ) then
          First := AllProps.PROPSGetPositionByTID( AChild.TID );
          if ( First > -1 ) then
          begin
            MyProp := AllProps.BiProp( First );
            Father := Actual;
            if ( ( Father.TypeEntity = to_ParMat ) or
                 ( Father.TypeEntity = to_ParImm ) or
                 ( Father.TypeEntity = to_PstMat ) or
                 ( Father.TypeEntity = to_PstImm ) ) then
              Father := TAH.GetEntityByTID( Actual.Generator );
            if ( MyProp.Right = Father.TID ) then
            begin
              Linkage := cPROPS[ tPropType( MyProp.RID - 1 ) ];
              AddIcon := AddIcon + Linkage;
            end;
          end;
      end;

      // Return variables
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := ViewCode;
      AnItem.AltLabel := ViewBubble;
      AnItem.Value := Toggle + Value;
      AnItem.Bubble := Bubble;
      AnItem.Url := LinkText;
      AnItem.PartLink := MyLink;
      AnItem.Indent := MyIndent;
      AnItem.Color := MyColor;
      AnItem.IconRight := AddIcon;
      AddItem( AnItem );

      // Open a subdivision of descendents
      if ( Toggle <> cRoundImg ) and ( Toggle <> cRefImg ) then
      begin
        AnItem2 := TBiColItem.Create;
        AnItem2.TypeItem := tt_MakeODiv;
        AnItem2.Value := DivName + IntToStr( NbDiv );
        ActDiv := NbDiv;
        Inc( NbDiv );
        AddItem( AnItem2 );
      end;

      // Call for next level
      if ( ( not TooMuch ) and
           ( Recur ) and
           ( MyColor <> lt_German ) and
           ( not IsRef ) ) then
      begin
        Self.MakeTaxDescendants( AChild.TID, Level + 1, IsTax, False,
                                 Recur, IsInf, AncLink, DivName, IsExt, NbDiv );
      end else
      begin

        // Compute number of children
        if ( ( MyColor <> lt_German )and ( not IsRef ) ) then
        begin
          NbChildren := 0;
          NbSpecific := 0;
          AChild.GetNumberOfChildren( IsTax, False, IsInf, NbChildren,
                                      NbSpecific );
          if ( NbChildren > 0 ) then
          begin
            AnItem := tBiColItem.Create;
            Value := '...' + cSpace + IntToStr( NbChildren ) + cSpace +
                     'children' + cSpace + cRol + IntToStr( NbSpecific ) +
                     cSpace + 'leaves' + cRor;
            MyIndent := Chr( Ord( 'a' ) + 2 );
            MyColor := TAH.MainLang;

            // Return variables
            AnItem.SrcLabel := cEmpty;
            AnItem.AltLabel := cEmpty;
            AnItem.Value := Value;
            AnItem.Bubble := cEmpty;
            AnItem.Url := cEmpty;
            AnItem.PartLink := cEmpty;
            AnItem.Indent := MyIndent;
            AnItem.Color := MyColor;
            AddItem( AnItem );
          end;
        end;
      end;

      // Close a subdivision of descendents
      if ( ( ( Istax ) and
             ( AChild.NbTaxC > 0 ) and   // at least one child in taxonomy
             ( AChild.TetraTip <> tp_genpair ) ) or
           ( ( Istax ) and
               ( AChild.NbTaxC > 0 ) and
               ( not ( AChild.TetraTip in [ tp_genpair, tp_genpset] ) ) ) or
           ( ( not Istax ) and
             ( not IsRef ) and
             ( AChild.NbPartC > 0 ) and
             ( AChild.TypeEntity <> to_ParMat ) and
             ( AChild.TypeEntity <> to_ParImm ) ) ) then
      begin
        AnItem := tBiColItem.Create;
        AnItem.TypeItem := tt_MakeEDiv;
        AnItem.Bubble := DivName + IntToStr( ActDiv );
        AddItem( AnItem );
      end;
    end; // AChild <> nil
  end; // for
end; // ______________________________________________________MakeTaxDescendants

procedure          tHierarchySection.MakePartFullDescendants(
  TID:             Integer;
  Level:           Integer;
  TooMuch:         Boolean;
  Recur:           Boolean;
  AncLink:         Boolean;
  DivName:         String;
  var NbDiv:       Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePartFullDescendants
  * Make the list of children in the partonomy, full presentation *
  Description:
  This recursive procedure works a partonomy of the model of anatomy
  as present in the TAH database. It writes a full view of the tree of
  descendants of the specified node in the partonomy, depending on the
  number of descendants.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  Posit:           Integer;
  NbChildren:      Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  ActDiv:          Integer;
  IsOpen:          Boolean;
  IsValid:         Boolean;
  Children:        String;
  SortList:        String;
  ViewCode:        String;
  LinkText:        String;
  LinkCode:        String;
  Bubble:          String;
  ViewBubble:      String;
  MyIndent:        String;
  Value:           String;
  MyLink:          String;
  Toggle:          String;
  LangDir:         String;
  MyColor:         tLanguage;
  ALink:           tLink;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          tEntity;
  AChild:          tEntity;
  AnItem:          tBiColItem;
  AnItem2:         tBiColItem;
  MyLang:          tLanguage;
  FatherType:      tType;
  ChildType:       tType;
begin
  // Initial stuff
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get children and their number
  Children := Actual.PartCh;
  SortList := Actual.PartPos;
  NbChildren := Actual.NbPartC;
  if Children = cEmpty then
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
  for Indx := 1 to NbChildren do
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

  // Loop on all children
  ActDiv := 0;
  for Indx := 1 to NbChildren do
  begin
    IsOpen := False;

    // Search next child according to specified sequence
    Small := 1;
    AnOrder := Order[ Small];
    for Indy := 2 to NbChildren do
    begin
      if Order[ Indy ] < AnOrder then
      begin
        Small := Indy;
        AnOrder := Order[ Small];
      end;
    end; // for
    Inds := Small;
    Order[ Small ] := 10000;
    MyColor := lt_Latin;

    // Retrieve the child entity
    AChild := TAH.GetEntityByTID( Child[ Inds ] );
    if ( AChild <> nil ) then
    begin

      if ( AChild.TID = 27485 ) then
        Inds := Inds;

      // Exclusion of a possible reference
      if ( AChild.Reference = 0 ) then
      begin

        // Prepare the left column for the next child
        ViewCode := cTAH + IntToStr( AChild.TID );
        ViewBubble := cEmpty;
        if ( AChild.FID > 0 ) then
          ViewBubble := cFMA + IntToStr( AChild.FID );

        // Prepare the right column for the next child
        // Prepare the background color for history of modifications
        MyColor := lt_Latin;

        // Validate the link against type of father and child
        ALink := AChild.Link;
        FatherType := cLinkValid[ ALink, is_Father ];
        ChildType := cLinkValid[ ALink, is_Child ];
        IsValid := True;
        IsValid := IsValid and ( ChildType = AChild.TypeEntity );
        IsValid := IsValid and ( FatherType = Actual.TypeEntity );
        if ( ( not IsValid ) and ( ALink <> pw_MemberL ) and
             ( ALink <> pw_MemberR ) and ( ALink <> pw_Undef ) ) then
          ALink := pw_Invalid;

        // Prepare indentation, value, etc
        LangDir := cLgShort[ TAH.MainLang ];
        if ( TAH.MainLang = lt_Latin ) then
          LangDir := LangDir + cLgShort[ TAH.SubstLang ];
        LangDir := LangDir + cSlash;
        MyIndent := Chr( Ord( 'a' ) + Level - 1 );
        Value := AChild.GetLibelle( lb_Base, TAH.MainLang );
        MyLink := cEmpty;
        if ( ( AncLink ) and ( ALink <> pw_Display ) ) then
        begin
          MyLink := cRol + cLinkLong[ ALink ] + cRor;
          LinkCode := cTAH + IntToStr( cLinkID[ ALink ] );
          MyLink := AOTAG + cSpace + cHrefEmpty + cRetroDir + LangDir +
                    LinkCode + cSpace + cEntity + cSpace +
                    cLgShort[ TAH.SubstLang ] + cPeriod +
                    HtmlExt + cDQuote + cAnr + MyLink + AETAG;
        end;
        MyLang := lt_English;
        if ( en = fr ) then
          MyLang := lt_French;
        LinkText := cHrefEmpty + cTAH + IntToStr( AChild.TID ) + cSpace +
                    cEntity + cSpace + cLgShort[ MyLang ] + cPeriod +
                    HtmlExt + cDQuote + cAnr;

        // Prepare bubble for term in substitution language
        Bubble := AChild.GetLibelle( lb_Base, TAH.SubstLang );

        // Prepare toggle button
        if ( AChild.NbPartC > 0 ) then
        begin
          Toggle := MakeToggle( DivName + IntToStr( NbDiv ) );
          IsOpen := True;
        end else
          Toggle := cRoundImg;

        // Return variables
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.AltLabel := ViewBubble;
        AnItem.Value := Toggle + Value;
        AnItem.Bubble := Bubble;
        AnItem.Url := LinkText;
        AnItem.PartLink := MyLink;
        AnItem.Indent := MyIndent;
        AnItem.Color := MyColor;
        AddItem( AnItem );

        // Open a subdivision of descendents
        if ( IsOpen ) then
        begin
          AnItem2 := tBiColItem.Create;
          AnItem2.TypeItem := tt_MakeODiv;
          AnItem2.Value := DivName + IntToStr( NbDiv );
          ActDiv := NbDiv;
          Inc( NbDiv );
          AddItem( AnItem2 );
        end;

        // Call for next level
        if ( ( not TooMuch ) and
             ( Recur ) and
             ( MyColor <> lt_German ) ) then
        begin
          Self.MakePartFullDescendants( AChild.TID, Level + 1, False, Recur,
                                        AncLink, DivName, NbDiv );
        end;
      end;
    end;

    // Close a subdivision of descendents
    if ( IsOpen ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.TypeItem := tt_MakeEDiv;
      AnItem.Bubble := DivName + IntToStr( ActDiv );
      AddItem( AnItem );
    end;
  end; // for
end; // _________________________________________________MakePartFullDescendants

procedure          tHierarchySection.MakePartLightDescendants(
  TID:             Integer;
  Level:           Integer;
  TooMuch:         Boolean;
  Recur:           Boolean;
  DivName:         String;
  IsExt:           Boolean;
  var NbDiv:       Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePartLightDescendants
  * Make the list of children in the partonomy, light presentation *
  Description:
  This recursive procedure works on a partonomy of the model of anatomy
  as present in the TAH database. It writes a light view of the tree of
  descendants of the specified node in the partonomy, depending on the
  number of descendants.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Indz:            Integer;
  Inds:            Integer;
  Posit:           Integer;
  NbChildren:      Integer;
  NbTrueChildren:  Integer;
  NbSpecific:      Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  ActDiv:          Integer;
  First:           Integer;
  NbProps:         Integer;
  IsRef:           Boolean;
  IsPar:           Boolean;
  IsOpen:          Boolean;
  Children:        String;
  SortList:        String;
  ViewCode:        String;
  LinkText:        String;
  Bubble:          String;
  ViewBubble:      String;
  MyIndent:        String;
  Value:           String;
  Trans:           String;
  MyLink:          String;
  Toggle:          String;
  AddIcon:         String;
  Linkage:         String;
  PageType:        String;
  MyColor:         tLanguage;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          tEntity;
  AChild:          tEntity;
  AChildRef:       tEntity;
  Father:          tEntity;
  AnItem:          tBiColItem;
  AnItem2:         tBiColItem;
  MyLang:          tLanguage;
  AllProps:        tLinkage;
  MyProp:          PropsRec;
begin
  // Initial stuff
  PageType := cEntity;
  if ( IsExt ) then
    PageType := cExtended;
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get children and their number
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

  // Loop on all children
  ActDiv := 0;
  IsRef := False;
  for Indx := 1 to NbTrueChildren do
  begin
    Isopen := False;

    // Search next child according to sortlist
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
    MyColor := lt_Latin;

    // Retrieve the child entity
    AChild := TAH.GetEntityByTID( Child[ Inds ] );
    AChildRef := nil;
    if ( AChild <> nil ) then
    begin

      if ( AChild.Reference = 11907 ) then
        AChild := AChild;

      // Handling of a possible reference
      IsRef := ( AChild.Reference > 0 );
      if ( IsRef ) then
      begin
        AChildRef := TAH.GetEntityByTID( Child[ Inds ] );
        AChild := TAH.GetEntityByTID( AChild.Reference );
      end;

      // Prepare the left column for the next child
      ViewCode := cTAH + IntToStr( AChild.TID );
      ViewBubble := cEmpty;
      if ( AChild.FID > 0 ) then
        ViewBubble := cFMA + IntToStr( AChild.FID );

      // Do not show left and right entities in light presentation
      if ( ( AChild.Link <> pw_MemberL ) and
           ( AChild.Link <> pw_MemberR ) and
           ( AChild.Link <> pw_SMemberL ) and
           ( AChild.Link <> pw_SMemberR ) and
           ( AChild.Link <> pw_IMemberL ) and
           ( AChild.Link <> pw_IMemberR ) and
           ( AChild.Link <> pw_TMemberL ) and
           ( AChild.Link <> pw_TMemberR ) ) then
      begin

        // Prepare indentation, value, etc
        MyIndent := Chr( Ord( 'a' ) + Level - 1 );
        Value := AChild.GetLibelle( lb_Official, TAH.MainLang,
                                    st_undef, True );
        MyLang := lt_English;
        if ( en = fr ) then
          MyLang := lt_French;
        LinkText := cHrefEmpty + cTAH + IntToStr( AChild.TID ) + cSpace +
                    PageType + cSpace +
                    cLgShort[ TAH.DisLanguage ] + cPeriod + HtmlExt +
                    cDQuote + cAnr;
        Bubble := AChild.GetLibelle( lb_Official, TAH.SubstLang,
                                     st_undef, True );

        // Handling of a reference
        if ( IsRef ) then
          MyLink := AOTAG + cSpace + cHrefEmpty + ViewCode + cSpace + cEntity +
                    cSpace + cLgShort[ lt_English ] + cPeriod +
                    HtmlExt + cDQuote + cAnr + AETAG
        else
          MyLink := cEmpty;

        // Prepare toggle button
        IsPar := ( ( AChild.TypeEntity = to_ParMat ) or
                   ( AChild.TypeEntity = to_ParImm ) or
                   ( AChild.TypeEntity = to_PstMat ) or
                   ( AChild.TypeEntity = to_PstImm ) );
        if ( ( ( not IsRef ) and
               ( IsPar ) and               // more than two children in partonomy
               ( AChild.NbPartC > 2 ) ) or // for a pair
             ( ( not IsRef ) and
               ( not IsPar ) and               // at least one child in partonomy
               ( AChild.NbPartC > 0 ) ) ) then // if not a pair
        begin
          Toggle := MakeToggle( DivName + IntToStr( NbDiv ) );
          IsOpen := True;
        end else
          Toggle := cRoundImg;

        // Add icon for generator
        AddIcon := cEmpty;
        if ( AChild.Generator > 0 ) then
        begin
          AddIcon := cLinkGenerImg;
          AddIcon := AOTAG + cSpace + cHrefEmpty +
                     cTAH + IntToStr( AChild.Generator ) + cSpace + PageType +
                     cSpace + cLgShort[ lt_English ] + cPeriod +
                     HtmlExt + cDQuote + cAnr + AddIcon + AETAG;
        end;

        // Add icon for references
        First := -1;
        if ( IsRef ) then
        begin
          AddIcon := AddIcon + cSpace + cRefImg;

          // Add model linkage to partonomic father when available
          AllProps := TAH.BiProperties;
          if ( AllProps <> nil ) then
            First := AllProps.PROPSGetPositionByTID( AChild.TID );
          if ( First > -1 ) then
          begin
            NbProps := AllProps.TotProps;
            for Indz := 0 to NbProps - 1 do
            begin
              MyProp := AllProps.BiProp( First + Indz );
              Father := Actual;
              if ( ( Father.TypeEntity = to_ParMat ) or
                   ( Father.TypeEntity = to_ParImm ) or
                   ( Father.TypeEntity = to_PstMat ) or
                   ( Father.TypeEntity = to_PstImm ) ) then
                Father := TAH.GetEntityByTID( Actual.Generator );
              if ( MyProp.Right = Father.TID ) then
              begin
                Linkage := cPROPS[ tPropType( MyProp.RID - 1 ) ];
                AddIcon := AddIcon + Linkage;
                Break;
              end;
            end; // for
          end;
        end;

        // Return variables
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.AltLabel := ViewBubble;
        AnItem.Value := Toggle + Value;
        AnItem.Bubble := Bubble;
        AnItem.Url := LinkText;
        AnItem.PartLink := MyLink;
        AnItem.Indent := MyIndent;
        AnItem.Color := MyColor;
        AnItem.IconRight := AddIcon;
        AddItem( AnItem );

        // Open a subdivision of descendants
        if ( IsOpen ) then
        begin
          AnItem2 := tBiColItem.Create;
          AnItem2.TypeItem := tt_MakeODiv;
          AnItem2.Value := DivName + IntToStr( NbDiv );
          ActDiv := NbDiv;
          Inc( NbDiv );
          AddItem( AnItem2 );
        end;

        // Call for next level
        if ( ( not TooMuch ) and
             ( Recur ) and
             ( MyColor <> lt_German ) ) then
        begin
          if ( IsRef ) then
            Self.MakePartLightDescendants(
              AChildRef.TID, Level + 1, False, Recur, DivName, IsExt, NbDiv )
          else
            Self.MakePartLightDescendants(
              AChild.TID, Level + 1, False, Recur, DivName, IsExt, NbDiv );
        end else
        begin

          // Compute number of children and specific entities
          if ( ( MyColor <> lt_German )and ( not IsRef ) ) then
          begin
            NbChildren := 0;
            NbSpecific := 0;
            AChild.GetNumberOfChildren( False, False, True, NbChildren,
                                        NbSpecific );
            if ( NbChildren > 0 ) then
            begin
              AnItem := TBiColItem.Create;
              Value := '...' + cSpace + IntToStr( NbChildren ) + cSpace +
                       'children' + cSpace + cRol + IntToStr( NbSpecific ) +
                       cSpace + 'leaves' + cRor;
              MyIndent := Chr( Ord( 'a' ) + 2 );
              MyColor := TAH.MainLang;

              // Return variables
              AnItem.SrcLabel := cEmpty;
              AnItem.AltLabel := cEmpty;
              AnItem.Value := Value;
              AnItem.Bubble := cEmpty;
              AnItem.Url := cEmpty;
              AnItem.PartLink := cEmpty;
              AnItem.Indent := MyIndent;
              AnItem.Color := MyColor;
              AddItem( AnItem );
            end;
          end;
        end; // next level
      end; // no show left and right
    end; // AChild <> nil

    // Close a subdivision of descendants
    if ( IsOpen ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.TypeItem := tt_MakeEDiv;
      AnItem.Bubble := DivName + IntToStr( ActDiv );
      AddItem( AnItem );
    end;
  end; // for
end; // ________________________________________________MakePartLightDescendants

procedure          tTetraPartSection.build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTetraPartSection.build
  * Make the Unit partonomy section *
  Description:
  This procedure builds the Part_Of hierarchy section of a Tetra Page.</P>
  This section aims at being a presentation of the TAH partonomy, based on
  tetraedrons. This goal is achieved with tetraedrons represented by their
  tetraedron names and identifiers.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbItem:          Integer;
  ATID:            Integer;
  MyIndx:          Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  ActLevel:        Integer;
  Start:           Integer;
  TheEnd:          Integer;
  NbDiv:           Integer;
  MyUID:           Integer;
  TooMuch:         Boolean;
  IsShift:         Boolean;
  ViewCode:        String;
  MyIndent:        String;
  Value:           String;
  LinkText:        String;
  AName:           String;
  PageType:        String;
  Bubble:          String;
  Actual:          tEntity;
  Father:          tEntity;
  Lateral:         tEntity;
  Child:           tEntity;
  AnItem:          tBiColItem;
  MyColor:         tLanguage;
begin

  // Initial stuff
  Actual := Self.Entity;
  MyUID := Self.UID;
  if ( Actual <> nil ) then
  begin

    // Find the father entity
    NbItem := Actual.NbPartHierar;
    if ( NbItem > 1 ) then
      Father := TAH.GetEntityByPos( Actual.PartHierar[ NbItem - 2 ] )
    else
      Father := TAH.GetEntityByPos( Actual.PartHierar[ 0 ] );
    if ( Father <> nil ) then
    begin

      // Inference for members of symmetrical pairs
      if ( ( NbItem > 0 ) and
           ( ( Actual.Link = pw_MemberL ) or
             ( Actual.Link = pw_MemberR) or
             ( Actual.Link = pw_SMemberL) or
             ( Actual.Link = pw_SMemberR) or
             ( Actual.Link = pw_IMemberL) or
             ( Actual.Link = pw_IMemberR) or
             ( Actual.Link = pw_TMemberL) or
             ( Actual.Link = pw_TMemberR ) ) and
           ( Father.Link in [ pw_PairPartOf, pw_PairSpaceIn, pw_PairOf,
             pw_PairMemberOf, pw_PairMemberIn, pw_PairSetIn, pw_BranchPairOf,
             pw_BranchPairOf, pw_PairSetOf, pw_PairSetPairOf, pw_PairSubsetOf,
             pw_PairSetPairBranchOf ] ) ) then
      begin

        // Loop on lateral partonomic hierarchy
        for Indx := 0 to NbItem - 2 do
        begin

          // Display lateral hierarchy
          Lateral := TAH.GetEntityByPos( Actual.PartHierar[ Indx ] );

          MyIndx := -1;
          if ( Lateral <> nil ) then
          begin
            MyIndx := Lateral.TID;
            if ( Lateral.Link in
               [ pw_PairPartOf, pw_PairMemberOf, pw_PairSetOf,
                 pw_PMemberOf, pw_PairSetIn, pw_PairOf, pw_PairMemberIn,
                 pw_PairSpaceIn, pw_BranchPairOf,
                 pw_PairSetPairOf, pw_PairSetPairBranchOf,
                 pw_PairSubsetOf ] ) then
            begin
              Lateral.GetChildren( False );
              ATID := -1;
              if ( ( Actual.Link = pw_MemberL ) or
                   ( Actual.Link = pw_SMemberL ) or
                   ( Actual.Link = pw_IMemberL ) or
                   ( Actual.Link = pw_TMemberL ) ) then
                ATID := Lateral.SortedChildren[ 0 ]
              else
              if ( ( Actual.Link = pw_MemberR ) or
                   ( Actual.Link = pw_SMemberR ) or
                   ( Actual.Link = pw_IMemberR ) or
                   ( Actual.Link = pw_TMemberR ) ) then
                ATID := Lateral.SortedChildren[ 1 ];
              Child := TAH.GetEntityByPos( ATID );
              if ( Child <> nil ) then
              begin
                if ( ( Child.Link = pw_MemberL ) or
                     ( Child.Link = pw_MemberR ) or
                     ( Child.Link = pw_SMemberL ) or
                     ( Child.Link = pw_SMemberR ) or
                     ( Child.Link = pw_IMemberL ) or
                     ( Child.Link = pw_IMemberR ) or
                     ( Child.Link = pw_TMemberL ) or
                     ( Child.Link = pw_TMemberR ) ) then
                    MyIndx := ATID
                  else
                    MyIndx := -1;
              end;
            end;

            // Pair set with missing lateral sets: create a virtual entity
            if ( ( MyIndx = -1 ) and
                 ( Lateral.Link in [ pw_PairSetOf, pw_PairSetIn ] ) ) then
            begin
              Child := TAH.GetEntityByPos( Lateral.Generator );
              if ( Child <> nil ) then
              begin
                ViewCode := cTAH + IntToStr( Child.TID );
                Value := Child.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
                Value := 'classis' + cSpace + cRol + Value + cRor;
                if ( Actual.Link = pw_MemberL ) then
                  Value := Value + cSpace + 'sinistra';
                if ( Actual.Link = pw_MemberR ) then
                  Value := Value + cSpace + 'dextra';
                AName := Child.GetLibelle( lb_Base, TAH.SubstLang );
                if ( Actual.Link = pw_MemberL ) then
                  AName := 'left set' + cSpace + cRol + AName + cRor;
                if ( Actual.Link = pw_MemberR ) then
                  AName := 'right set' + cSpace + cRol + AName + cRor;
              end;
            end;
          end;

          if ( MyIndx > -1 ) then
          begin
            Child := TAH.GetEntityByPos( MyIndx );
            if ( Child <> nil ) then
            begin
              ViewCode := cTAH + IntToStr( Child.TID );
              if ( ViewCode = 'TAH13545' ) then
                ViewCode := 'TAH10200';
              Value := Child.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
              AName := Child.GetLibelle( lb_Base, TAH.SubstLang );
            end;
          end;
          PageType := cEntity;
          Value := cRoundImg + Value;
          ActLevel := NbItem - Indx - 2;
          MyIndent := Chr( Ord( 'a' ) + ActLevel );
          LinkText := cHrefEmpty + ViewCode + cSpace + PageType +
                        cSpace + cLgShort[ lt_English ] + cPeriod +
                        HtmlExt + cDQuote + cAnr;

          // Define and store the next line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ViewCode;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := Value;
          AnItem.Bubble := AName;
          AnItem.Url := LinkText;
          if ( ( TAH.MainLang = lt_Spanish ) or
               ( TAH.MainLang = lt_Russian ) ) then
            AnItem.Color := lt_None
          else
            AnItem.Color := TAH.MainLang;
          AnItem.Indent := MyIndent;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );
        end; // for
      end else

      // Inference for pair sets, sets and non composite entities
      if ( NbItem > 0 ) then
      begin

        // Define starting value depending on display status
        Start := 0;
        for Indx := NbItem - 1 downto 0 do
        begin
          Lateral := TAH.GetEntityByPos( Actual.PartHierar[ Indx ] );
          if ( ( Lateral <> nil ) and ( Lateral.Link = pw_Display ) ) then
          begin
            Start := Indx;
            Break;
          end;
        end; // for

        // Loop on the partonomic hierarchy
        TheEnd := NbItem - 1;
        IsShift := ( Actual.Link = pw_MemberL ) or ( Actual.Link = pw_MemberR );
        if ( IsShift ) then
          TheEnd := NbItem - 2;
        if ( TheEnd < Start ) then
          TheEnd := Start;
        for Indx := Start to TheEnd - 1 do
        begin

          // Discard unnecessary entity on top of hierarchy
          if ( Actual.PartHierar[ Indx ] = 7973 ) then
            Continue;

          // Discard res generica terms
          Lateral := TAH.GetEntityByPos( Actual.PartHierar[ Indx ] );
          if ( ( Copy( Lateral.InternalTex, 1, 12 ) = 'res generica' ) ) then
            Continue;

          // Display lateral hierarchy
          MyIndx := 0;
          if ( Lateral <> nil ) then
          begin
            if ( Lateral.Link in [ pw_PairPartOf, pw_PairMemberOf, pw_PairSetOf,
               pw_PMemberOf, pw_PairSetIn, pw_PairOf, pw_PairMemberIn,
               pw_PairSpaceIn, pw_SetIn, pw_BranchPairOf, pw_QlinePairOf,
               pw_PairSetOf, pw_PairSetPairOf, pw_QSurfacePairOf,
               pw_QSpacePairOf, pw_QLineOf, pw_BranchPairOf ] ) then
            begin

              // Find a possible lateral child
              Lateral.GetChildren( False );
              ATID := -1;
              if ( Actual.Link = pw_MemberL ) then
                ATID := Lateral.SortedChildren[ 0 ]
              else
              if ( Actual.Link = pw_MemberR ) then
                ATID := Lateral.SortedChildren[ 1 ];
              MyIndx := Actual.PartHierar[ Indx ];
              if ATID > -1 then
                MyIndx := ATID;
            end else
              MyIndx := Lateral.TID;
          end;
          Child := TAH.GetEntityByPos( MyIndx );
          if ( Child <> nil ) then
          begin

            // Compute the values for the next line
            PageType := cTetrahedron;
            ViewCode := cTAHUnit + IntToStr( Child.Tetra );
            Bubble := cTAHEntity + IntToStr( Child.TID );
            MyIndent := Chr( Ord( 'a' ) + NbItem - Indx - 1 );
            if ( IsShift ) then
              MyIndent := Chr( Ord( 'a' ) + NbItem - Indx - 2 );
            LinkText := cHrefEmpty + cTAH + IntToStr( Child.Tetra ) + cSpace +
                        cUnit + cSpace + cLgShort[ lt_English ] + cPeriod +
                        HtmlExt + cDQuote + cAnr;
            Value := Child.GetLibelle( lb_Official, TAH.MainLang,
                     st_undef, True );
            AName := Child.GetLibelle( lb_Official, TAH.SubstLang,
                     st_undef, True );
            if ( Indx < TheEnd ) then
              Value := cRoundImg + Value;
            if ( Bubble = 'TAH:E13545' ) then
            begin
              Bubble := 'TAH:E10200';
              ViewCode := Bubble;
              LinkText := cEmpty;
            end;

            // Prepare and store the next line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := ViewCode;
            AnItem.AltLabel := Bubble;
            AnItem.Value := Value;
            AnItem.Bubble := AName;
            AnItem.Url := LinkText;
            if ( ( TAH.MainLang = lt_Spanish ) or
                 ( TAH.MainLang = lt_Russian ) ) then
              AnItem.Color := lt_None
            else
              AnItem.Color := TAH.MainLang;
            AnItem.Indent := MyIndent;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end; // for on all entities of the partonomic hierarchy

        // Compute the number of children
        NbChildren := 0;
        NbSpecific := 0;
        Actual.GetNumberOfChildren( False, False, True, NbChildren,
                                    NbSpecific );

        // Display the main entity
        ViewCode := cTAHUnit + IntToStr( MyUID );
        Bubble := cTAHEntity + IntToStr( Actual.TID );
        Value := Actual.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
        if ( NbChildren = 0 ) then
          Value := cRoundImg + Value
        else
          Value := MakeToggle( cDivNameInf + '1' ) + Value;
        AName := Actual.GetLibelle( lb_Official, TAH.SubstLang, st_undef, True );
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.AltLabel := Bubble;
        AnItem.Value := Value;
        AnItem.Bubble := AName;
        AddItem( AnItem );

        // Display the hierarchy of children left to right indented
        TooMuch := NbChildren >= cTooMuch;
        if ( NbChildren > 0 ) then
        begin

          // Open the children division
          AnItem := tBiColItem.Create;
          AnItem.TypeItem := tt_MakeODiv;
          AnItem.Value := cDivNameInf + '1';
          AddItem( AnItem );

          // Build all children in a light view of the partonomy
          NbDiv := 2;
          Self.MakePartUnitDescendants( Actual.TID, 2, TooMuch, True,
                                        cDivNameInf, False, NbDiv );
          NbInf := NbDiv - 1;

          // Close the children division
          AnItem := tBiColItem.Create;
          AnItem.TypeItem := tt_MakeEDiv;
          AnItem.Bubble := cDivNameInf + '1';
          AddItem( AnItem );

          // Display total number of children
          Value := IntToStr( NbChildren ) + cSpace + 'children';
          MyIndent := Chr( Ord( 'a' ) + 1 );
          MyColor := TAH.MainLang;
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := 'Total';
          AnItem.AltLabel := cEmpty;
          AnItem.Value := Value;
          AnItem.Bubble := cEmpty;
          AnItem.Url := cEmpty;
          AnItem.PartLink := cEmpty;
          AnItem.Indent := MyIndent;
          AnItem.Color := MyColor;
          AddItem( AnItem );
        end;
      end;
    end;
  end;
end; // _________________________________________________tTetraPartSection.build

procedure          tTetraTaxSection.build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTetraTaxSection.build
  * Make the taxonomy section of a Unit Page *
  Description:
  This procedure prepares the content of the taxonomy section under the form
  of the entire taxonomy of the Unit. The starting entity is the generator
  of the unit</P>
  This procedure is made of three parts:</P>
  1. The list of ancestors of the generator entity of the unit up to
     the top entity which is invariably res anatomica.</P>
  2. The generator entity itself.</P>
  3. The list of children of the generator entity.</P>
  When an entity in this list has a corresponding FMA entity, an hyperlink is
  created, that opens directly the FMA browser on this entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbAnc:           Integer;
  NbDiv:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  TooMuch:         Boolean;
  Value:           String;
  MyIndent:        String;
  AName:           String;
  ViewCode:        String;
  BubbleCode:      String;
  Actual:          tEntity;
  Main:            tEntity;
  Tetra:           tTetrahedron;
  AncListe:        Array[ 0 .. 30 ] of Integer;
  MyColor:         tLanguage;
  AnItem:          tBiColItem;
  MySingle:        tSingle;
  MyType:          tType;
  Query:           tSearch;
begin

  // Retrieve the main entity
  Actual := Self.Entity;
  if ( Actual <> nil ) then
  begin
    Tetra := TAH.GetTetrahedronByTID( Actual.TID );
    if ( Tetra <> nil ) then
    begin
      Main := Tetra.Genr;
      if ( Main = nil ) then
        Main := Tetra.Main;

      // Prepare the line for main entity
      Main.LgCurrent := TAH.MainLang;
      Main.Query := tSearch.Create( st_Bas );
      Main.SearchTerm;
      MySingle := Main.CurrSingle;
      if ( MySingle <> nil ) then
      begin
        Value := MySingle.Mandat + MySingle.Option + MySingle.Bracket;
        if ( MySingle.BuildFrom = bd_model ) then
          Value := Value + cSpace + cUniversal;
      end;
      Value := cRoundImg + Value;
      AName := Main.GetLibelle( lb_Base, TAH.SubstLang );
      AnItem := tBiColItem.Create;
      AnItem.Value := Value;
      AnItem.Bubble := AName;
      NbAnc := 0;

      // Prepare the code with FMA hyperlink when present
      if ( Main.FID > 0 ) then
      begin
        ViewCode := AOTAG + cHrefEmpty + BioPortalUrl +
                    IntToStr( Main.FID ) + cDQuote + cAnr +
                    cFMA + cColumn + IntToStr( Main.FID ) + AETAG;
        BubbleCode := cTAH + cColumn + 'G' + IntToStr( Main.TID );
      end else
      begin
        ViewCode := cTAH + cColumn + 'G' + IntToStr( Main.TID );
        BubbleCode := cEmpty;
      end;
      AnItem.SrcLabel := ViewCode;
      AnItem.AltLabel := BubbleCode;
      MyType := Main.TypeEntity;

      // Treatment of pairs
      if ( ( MyType = to_ParMat ) or ( MyType = to_ParImm ) ) then
      begin
        MakeAscendants( Main.Generator, 1, True, False, True, False, False,
                        True, NbAnc, AncListe );
      end else

      // Treatment of sets
      if ( ( MyType = to_SetMat ) or ( MyType = to_SetImm ) ) then
      begin
        MakeAscendants( Main.Generator, 1, True, False, False, True, False,
                        True, NbAnc, AncListe );
      end else

      // Treatment of pairs of sets
      if ( ( MyType = to_PstMat ) or ( MyType = to_PstImm ) ) then
      begin
        MakeAscendants( Main.Generator, 1, True, False, False, False, True,
                        True, NbAnc, AncListe );
      end else

      // Standard treatment
      if ( Main.TaxAnc > 0 ) then
      begin
        MakeAscendants( Main.TID, 1, True, False, False, False, False,
                        True, NbAnc, AncListe );
      end;

      // Display the generator entity
      AddItem( AnItem );

      // Compute the number of children
      NbChildren := 0;
      NbSpecific := 0;
      Main.GetNumberOfChildren( True, False, True, NbChildren, NbSpecific );

      // Third part: list of children
      TooMuch := NbChildren >= cTooMuch;
      if ( NbChildren > 0 ) then
      begin

        // Open the children division
        AnItem := tBiColItem.Create;
        AnItem.TypeItem := tt_MakeODiv;
        AnItem.Value := cDivNameInf + '1';
        AddItem( AnItem );

        // Build all children in a light view of the taxonomy
        NbDiv := 2;
        Self.MakeTaxDescendants( Main.TID, 2, True, TooMuch, True, True,
                                 False, cDivNameInf, False, NbDiv );
        NbInf := NbDiv - 1;

        // Close the children division
        AnItem := tBiColItem.Create;
        AnItem.TypeItem := tt_MakeEDiv;
        AnItem.Bubble := cDivNameInf + '1';
        AddItem( AnItem );

        // Display total number of children
        Value := IntToStr( NbChildren ) + cSpace + 'children';
        MyIndent := Chr( Ord( 'a' ) + 1 );
        MyColor := TAH.MainLang;
        AnItem := TBiColItem.Create;
        AnItem.SrcLabel := 'Total';
        AnItem.AltLabel := cEmpty;
        AnItem.Value := Value;
        AnItem.Bubble := cEmpty;
        AnItem.Url := cEmpty;
        AnItem.PartLink := cEmpty;
        AnItem.Indent := MyIndent;
        AnItem.Color := MyColor;
        AddItem( AnItem );
      end;
    end;
  end;
end; // __________________________________________________tTetraTaxSection.build

procedure          tFullPartSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tFullPartSection.Build
  * Make the full partonomy section of an Entity Page *
  Description:
  This method prepares the content of the partonomy section for an Entity
  Page. This full partonomy section is larger than the light partonomy
  section, with extensive information on the part_of links.</P>
  The hierarchy is decomposed into two parts, the list of ancestors and the
  list of children arranged around the central entity of the page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbAnc:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  Lvl:             Integer;
  NbDiv:           Integer;
  TooMuch:         Boolean;
  Children:        String;
  MyIndent:        String;
  Value:           String;
  AName:           String;
  ViewCode:        String;
  MyLink:          String;
  LangDir:         String;
  AncListe:        Array[ 0 .. 30 ] of Integer;
  Main:            tEntity;
  MyColor:         tLanguage;
  AnItem:          tBiColItem;
begin

  // Initial stuff
  Main := Self.Entity;
  if ( Main <> nil ) then
  begin

    // Check for the presence of this section
    if ( Main.TypeEntity <> to_non ) then
    begin

      // Prepare the TAH ancestors hierarchy
      NbAnc := 0;
      Self.MakeAscendants( Main.TID, 1, False, False, False, False, False,
                           True, NbAnc, AncListe );

      // Compute the number of children
      NbChildren := 0;
      NbSpecific := 0;
      Main.GetNumberOfChildren( False, False, False, NbChildren, NbSpecific );

      // Prepare the main entity
      ViewCode := cTAH + IntToStr( Main.TID );
      Value := Main.GetLibelle( lb_Base, TAH.MainLang );
      if ( NbChildren = 0 ) then
        Value := cRoundImg + Value
      else
        Value := MakeToggle( cDivNamePart + '1' ) + Value;
      AName := Main.GetLibelle( lb_Base, TAH.SubstLang );

      // Prepare the link to direct ancestor in partonomy
      LangDir := cLgShort[ TAH.MainLang ];
      if ( TAH.MainLang = lt_Latin ) then
        LangDir := LangDir + cLgShort[ TAH.SubstLang ];
      LangDir := LangDir + cSlash;
      MyLink := cEmpty;
      if ( ( Main.Link <> pw_Top ) and ( Main.TID <> 13545 ) and
           ( Main.PartAnc <> 0 ) and ( Main.Link <> pw_Display ) ) then
      begin
        MyLink := cRol + cLinkLong[ Main.Link ] + cRor;
        MyLink := AOTAG + cSpace + cHrefEmpty + cRetroDir + LangDir +
                  cTAH + IntToStr( cLinkID[ Main.Link ] ) + cSpace +
                  cEntity + cSpace + cLgShort[ lt_English ] + cPeriod +
                  HtmlExt + cDQuote + cAnr + MyLink + AETAG;
      end;

      // Store the main entity
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := ViewCode;
      AnItem.Value := Value;
      AnItem.Bubble := AName;
      AnItem.PartLink := MyLink;
      AnItem.Color := TAH.MainLang;
      AnItem.Indent := cBaseIndent;
      AddItem( AnItem );

      // Prepare the children in the hierarchy
      Children := Main.PartCh;

      // Display the children
      TooMuch := NbChildren >= cTooMuch;
      Lvl := 2;
      if NbChildren > 0 then
      begin

        // Open the children division
        AnItem := tBiColItem.Create;
        AnItem.TypeItem := tt_MakeODiv;
        AnItem.Value := cDivNamePart + '1';
        AddItem( AnItem );

        // Build all children of the partonomy in full view
        NbDiv := 2;
        Self.MakePartFullDescendants( Main.TID, Lvl, TooMuch,
                                      True, True, cDivNamePart, NbDiv );
        NbPart := NbDiv - 1;

        // Close the children division
        AnItem := tBiColItem.Create;
        AnItem.TypeItem := tt_MakeEDiv;
        AnItem.Bubble := cDivNamePart + '1';
        AddItem( AnItem );

        // Display total number of children
        Value := IntToStr( NbChildren ) + cSpace +
                 TAH.GetLabel( reChildren, False );
        MyIndent := Chr( Ord( 'a' ) + 1 );
        MyColor := TAH.MainLang;
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := TAH.GetLabel( reTotalList );
        AnItem.AltLabel := TAH.GetLabel( buTotalList );
        AnItem.Value := Value;
        AnItem.Bubble := cEmpty;
        AnItem.Url := cEmpty;
        AnItem.PartLink := cEmpty;
        AnItem.Indent := MyIndent;
        AnItem.Color := MyColor;
        AddItem( AnItem );
      end;
    end;
  end;
end; // __________________________________________________TFullPartSection.Build

procedure          tLightPartSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tLightPartSection.Build
  * Make the light partonomy section *
  Description:
  This procedure builds the light partonomy section of an Entity Page.</P>
  This section aims at being a light presentation of the TAH partonomy and it
  is simpler than the full partonomy section. This goal is achieved by the
  following restrictions:
  - Absence of lateral members of pairs,
  - Terms are represented by their short official term,
  - Traditional terms are preferred when present,
  - Absence of the links specifications,
  - Lateral hierarchies are shown when a laterality is specified.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbItem:          Integer;
  ATID:            Integer;
  MyIndx:          Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  ActLevel:        Integer;
  Start:           Integer;
  TheEnd:          Integer;
  NbDiv:           Integer;
  TooMuch:         Boolean;
  IsShift:         Boolean;
  IsExt:           Boolean;
  ViewCode:        String;
  MyIndent:        String;
  Value:           String;
  LinkText:        String;
  MyLink:          String;
  AName:           String;
  PageType:        String;
  Actual:          tEntity;
  Father:          tEntity;
  Lateral:         tEntity;
  Child:           tEntity;
  AnItem:          tBiColItem;
  MyColor:         tLanguage;
  Alink:           tLink;
begin

  // Initial stuff
  IsExt := Self.PageType = ca_Extended;
  Actual := Self.Entity;
  if ( ( Actual <> nil ) and
       ( Actual.TetraTip <> tp_tax ) and
       ( Actual.TetraTip <> tp_voc ) ) then
  begin

    // Find the father entity
    NbItem := Actual.NbPartHierar;
    if ( NbItem > 1 ) then
      Father := TAH.GetEntityByPos( Actual.PartHierar[ NbItem - 2 ] )
    else
      Father := TAH.GetEntityByPos( Actual.PartHierar[ 0 ] );
    if ( ( Father <> nil ) and ( Actual.Link <> pw_top ) ) then
    begin

      // Inference for members of symmetrical pairs
      if ( ( NbItem > 0 ) and
           ( ( Actual.Link = pw_MemberL ) or
             ( Actual.Link = pw_MemberR) or
             ( Actual.Link = pw_SMemberL) or
             ( Actual.Link = pw_SMemberR) or
             ( Actual.Link = pw_IMemberL) or
             ( Actual.Link = pw_IMemberR) or
             ( Actual.Link = pw_TMemberL) or
             ( Actual.Link = pw_TMemberR ) ) and
           ( Father.Link in [ pw_PairPartOf, pw_PairSpaceIn, pw_PairOf,
             pw_PairMemberOf, pw_PairMemberIn, pw_PairSetIn, pw_BranchPairOf,
             pw_BranchPairOf, pw_PairSetOf, pw_PairSetPairOf, pw_PairSubsetOf,
             pw_PairSetPairBranchOf ] ) ) then
      begin

        // Loop on lateral partonomic hierarchy
        for Indx := 0 to NbItem - 2 do
        begin
          if ( Actual.PartHierar[ Indx ] = 7973 ) then
             Continue;
          if ( Actual.PartHierar[ Indx ] = 39330 ) then
            ATID := ATID;

          // Display lateral hierarchy
          Lateral := TAH.GetEntityByPos( Actual.PartHierar[ Indx ] );
          MyIndx := -1;
          if ( Lateral <> nil ) then
          begin
            MyIndx := Lateral.TID;
            if ( Lateral.Link in
               [ pw_PairPartOf, pw_PairMemberOf, pw_PairSetOf,
                 pw_PMemberOf, pw_PairSetIn, pw_PairOf, pw_PairMemberIn,
                 pw_PairSpaceIn, pw_BranchPairOf,
                 pw_PairSetPairOf, pw_PairSetPairBranchOf,
                 pw_PairSubsetOf ] ) then
            begin
              Lateral.GetChildren( False );
              ATID := -1;
              if ( ( Actual.Link = pw_MemberL ) or
                   ( Actual.Link = pw_SMemberL ) or
                   ( Actual.Link = pw_IMemberL ) or
                   ( Actual.Link = pw_TMemberL ) ) then
                ATID := Lateral.SortedChildren[ 0 ]
              else
              if ( ( Actual.Link = pw_MemberR ) or
                   ( Actual.Link = pw_SMemberR ) or
                   ( Actual.Link = pw_IMemberR ) or
                   ( Actual.Link = pw_TMemberR ) ) then
                ATID := Lateral.SortedChildren[ 1 ];
              Child := TAH.GetEntityByPos( ATID );
              if ( Child <> nil ) then
              begin
                if ( ( Child.Link = pw_MemberL ) or
                     ( Child.Link = pw_MemberR ) or
                     ( Child.Link = pw_SMemberL ) or
                     ( Child.Link = pw_SMemberR ) or
                     ( Child.Link = pw_IMemberL ) or
                     ( Child.Link = pw_IMemberR ) or
                     ( Child.Link = pw_TMemberL ) or
                     ( Child.Link = pw_TMemberR ) ) then
                    MyIndx := ATID
                  else
                    MyIndx := -1;
              end;
            end;

            // Pair set with missing lateral sets: create a virtual entity
            if ( ( MyIndx = -1 ) and
                 ( Lateral.Link in [ pw_PairSetOf, pw_PairSetIn ] ) ) then
            begin
              Child := TAH.GetEntityByPos( Lateral.Generator );
              if ( Child <> nil ) then
              begin
                ViewCode := cTAH + IntToStr( Child.TID );
                Value := Child.GetLibelle( lb_Official, TAH.MainLang,
                                           st_undef, True );
                Value := cClassis + cSpace + cRol + Value + cRor;
                if ( Actual.Link = pw_MemberL ) then
                  Value := Value + cSpace + 'sinistra';
                if ( Actual.Link = pw_MemberR ) then
                  Value := Value + cSpace + 'dextra';
                AName := Child.GetLibelle( lb_Base, TAH.SubstLang );
                if ( Actual.Link = pw_MemberL ) then
                  AName := 'left set' + cSpace + cRol + AName + cRor;
                if ( Actual.Link = pw_MemberR ) then
                  AName := 'right set' + cSpace + cRol + AName + cRor;
              end;
            end;
          end;

          if ( MyIndx > -1 ) then
          begin
            Child := TAH.GetEntityByPos( MyIndx );
            if ( Child <> nil ) then
            begin
              ViewCode := cTAH + IntToStr( Child.TID );
              if ( ViewCode = 'TAH13545' ) then
                ViewCode := 'TAH10200';
              Value := Child.GetLibelle( lb_Official, TAH.MainLang,
                                         st_undef, True );
              AName := Child.GetLibelle( lb_Base, TAH.SubstLang,
                                         st_undef, True, False );
            end;
          end;
          PageType := cEntity;
          if ( IsExt ) then
            PageType := cExtended;
          Value := cRoundImg + Value;
          ActLevel := NbItem - Indx - 2;
          MyIndent := Chr( Ord( cBaseIndent ) + ActLevel );
          LinkText := cHrefEmpty + ViewCode + cSpace + PageType +
                      cSpace + cLgShort[ lt_English ] + cPeriod +
                      HtmlExt + cDQuote + cAnr;

          // Define and store the next line
          AnItem := tBiColItem.Create;
          AnItem.SrcLabel := ViewCode;
          AnItem.AltLabel := cEmpty;
          AnItem.Value := Value;
          AnItem.Bubble := AName;
          AnItem.Url := LinkText;
          AnItem.Color := TAH.MainLang;
          AnItem.Indent := MyIndent;
          AnItem.PartLink := cEmpty;
          AddItem( AnItem );
        end; // for
      end else

      // Inference for pair sets, sets and non composite entities
      if ( NbItem > 0 ) then
      begin

        // Define starting value depending on display status
        Start := 0;
        for Indx := NbItem - 1 downto 0 do
        begin
          Lateral := TAH.GetEntityByPos( Actual.PartHierar[ Indx ] );
          if ( ( Lateral <> nil ) and ( Lateral.Link = pw_Display ) ) then
          begin
            Start := Indx;
            Break;
          end;
        end; // for

        // Loop on the partonomic hierarchy
        TheEnd := NbItem - 1;
        IsShift := ( Actual.Link = pw_MemberL ) or ( Actual.Link = pw_MemberR );
        if ( IsShift ) then
          TheEnd := NbItem - 2;
        if ( TheEnd < Start ) then
          TheEnd := Start;
        for Indx := Start to TheEnd - 1 do
        begin

          // Discard unnecessary entity on top of hierarchy
          if ( Actual.PartHierar[ Indx ] = 7973 ) then
            Continue;

          // Discard res generica terms
          Lateral := TAH.GetEntityByPos( Actual.PartHierar[ Indx ] );
          if ( ( Copy( Lateral.InternalTex, 1, 12 ) = 'res generica' ) ) then
            Continue;

          // Display lateral hierarchy
          MyIndx := 0;
          if ( Lateral <> nil ) then
          begin
            if ( Lateral.Link in [ pw_PairPartOf, pw_PairMemberOf, pw_PairSetOf,
               pw_PMemberOf, pw_PairSetIn, pw_PairOf, pw_PairMemberIn,
               pw_PairSpaceIn, pw_SetIn, pw_BranchPairOf, pw_QlinePairOf,
               pw_PairSetOf, pw_PairSetPairOf, pw_QSurfacePairOf,
               pw_QSpacePairOf, pw_QLineOf, pw_BranchPairOf ] ) then
            begin

              // Find a possible lateral child
              Lateral.GetChildren( False );
              ATID := -1;
              if ( Actual.Link = pw_MemberL ) then
                ATID := Lateral.SortedChildren[ 0 ]
              else
              if ( Actual.Link = pw_MemberR ) then
                ATID := Lateral.SortedChildren[ 1 ];
              MyIndx := Actual.PartHierar[ Indx ];
              if ATID > -1 then
                MyIndx := ATID;
            end else
              MyIndx := Lateral.TID;
          end;
          Child := TAH.GetEntityByPos( MyIndx );
          if ( Child <> nil ) then
          begin

            // Compute the values for the next line
            PageType := cEntity;
            if ( IsExt ) then
              PageType := cExtended;
            ViewCode := cTAH + IntToStr( Child.TID );
            MyIndent := Chr( Ord( cBaseIndent ) + NbItem - Indx - 1 );
            if ( IsShift ) then
              MyIndent := Chr( Ord( cBaseIndent ) + NbItem - Indx - 2 );
            LinkText := AOTAG + cSpace + cHrefEmpty + ViewCode + cSpace +
                        PageType + cSpace +
                        cLgShort[ TAH.DisLanguage ] + cPeriod +
                        HtmlExt + cDQuote + cAnr;
            Value := Child.GetLibelle( lb_Official, TAH.MainLang,
                                       st_undef, True );
            AName := Child.GetLibelle( lb_Official, TAH.SubstLang,
                                       st_undef, True, False );
            if ( Indx < TheEnd ) then
              Value := cRoundImg + Value;

            // Prepare and store the next line
            AnItem := tBiColItem.Create;
            AnItem.SrcLabel := ViewCode;
            AnItem.AltLabel := cEmpty;
            AnItem.Value := Value;
            AnItem.Bubble := AName;
            AnItem.Url := LinkText;
            if ( ( TAH.MainLang = lt_Spanish ) or
                 ( TAH.MainLang = lt_Russian ) ) then
              AnItem.Color := lt_None
            else
              AnItem.Color := TAH.MainLang;
            AnItem.Indent := MyIndent;
            AnItem.PartLink := cEmpty;
            AddItem( AnItem );
          end;
        end; // for on all partonomic ancestors

        // Compute the number of children
        NbChildren := 0;
        NbSpecific := 0;
        Actual.GetNumberOfChildren( False, False, True, NbChildren,
                                    NbSpecific );

        // Display the main entity
        ViewCode := cTAH + IntToStr( Actual.TID );
        Value := Actual.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
        if ( NbChildren = 0 ) then
          Value := cRoundImg + Value
        else
          Value := MakeToggle( cDivNameInf + '1' ) + Value;
        AName := Actual.GetLibelle( lb_Official, TAH.SubstLang,
                 st_undef, True, False );
        AnItem := tBiColItem.Create;
        AnItem.SrcLabel := ViewCode;
        AnItem.Value := Value;
        AnItem.Bubble := AName;
        AnItem.Color := TAH.MainLang;
        AnItem.Indent := cBaseIndent;
        AddItem( AnItem );

        // Display the hierarchy of children left to right indented
        TooMuch := NbChildren >= cTooMuch;
        if ( NbChildren > 0 ) then
        begin

          // Open the children division
          AnItem := TBiColItem.Create;
          AnItem.TypeItem := tt_MakeODiv;
          AnItem.Value := cDivNameInf + '1';
          AddItem( AnItem );

          // Build all children in a light view of the partonomy
          NbDiv := 2;
          Self.MakePartLightDescendants( Actual.TID, 2, TooMuch, True,
                                         cDivNameInf, IsExt, NbDiv );
          NbInf := NbDiv - 1;

          // Close the children division
          AnItem := tBiColItem.Create;
          AnItem.TypeItem := tt_MakeEDiv;
          AnItem.Bubble := cDivNameInf + '1';
          AddItem( AnItem );

          // Display total number of children
          Value := IntToStr( NbChildren ) + cSpace +
                   TAH.GetLabel( reChildren, False );
          MyIndent := Chr( Ord( cBaseIndent ) + 1 );
          MyColor := TAH.MainLang;
          AnItem := TBiColItem.Create;
          AnItem.SrcLabel := TAH.GetLabel( reTotalList );
          AnItem.AltLabel := TAH.GetLabel( buTotalList );
          AnItem.Value := Value;
          AnItem.Bubble := cEmpty;
          AnItem.Url := cEmpty;
          AnItem.PartLink := cEmpty;
          AnItem.Indent := MyIndent;
          AnItem.Color := MyColor;
          AddItem( AnItem );
        end;
      end;

      // Inference for pair of homologs
      if ( NbItem > 0 ) and
         ( ( Actual.Link = pw_MemberF ) or ( Actual.Link = pw_MemberM ) ) and
         ( Father.Link in [ pw_PairPartOf, pw_PairOf,
                            pw_PairSpaceIn, pw_PairMemberOf, pw_PairMemberIn,
                            pw_PairSetIn, pw_PMemberOf, pw_PairSetOf ] ) then
      begin

        // Loop on sexually dimorphic homologs of partonomic hierarchy
        for Indx := NbItem - 2 downto 1 do
        begin

          // Display gender specific hierarchy
          Lateral := TAH.GetEntityByPos( Hierar[ Indx ] );
          MyIndx := 0;
          if ( Lateral <> nil ) then
          begin
            if ( Lateral.Link in [ pw_PairPartOf, pw_PairMemberOf,
               pw_PMemberOf, pw_PairSetIn, pw_PairOf, pw_PairMemberIn,
               pw_PairSpaceIn ] ) or
               ( Indx = NbItem - 2 ) then
            begin

              // Find a possible gender specific child
              Lateral.GetChildren( False );
              ATID := -1;
              if ( Actual.Link = pw_MemberL ) then
                ATID := Lateral.SortedChildren[ 0 ]
              else
              if ( Actual.Link = pw_MemberR ) then
                ATID := Lateral.SortedChildren[ 1 ];
              MyIndx := Hierar[ Indx ];
              if ATID > -1 then
                MyIndx := ATID;
            end;
          end;
          Child := TAH.GetEntityByPos( MyIndx );
          if ( Child <> nil ) then
          begin

            // TAH unique identifier in left column
            AnItem := tBiColItem.Create;
            ViewCode := cTAH + IntToStr( Child.TID );
            AnItem.SrcLabel := ViewCode;
            AnItem.AltLabel := cEmpty;

            // Indented TAH term in right column
            MyIndent := Chr( Ord( 'a' ) + Indx - 1 );
            ALink := Child.Link;
            MyLink := cLinkLong[ ALink ];
            ViewCode := cTAH + IntToStr( Child.TID );
            if ( Child.Link = pw_PairPartOf ) then
              MyLink := cLinkLong[ pw_PartOf ];
            if ( Child.Link = pw_PairMemberOf ) then
              MyLink := cLinkLong[ pw_MemberOf ];
            if ( Child.Link = pw_PairMemberIn ) then
              MyLink := cLinkLong[ pw_MemberIn ];
            if ( Child.Link = pw_PMemberOf ) then
              MyLink := cLinkLong[ pw_MemberOf ];
            if ( Child.Link = pw_PairSetIn ) then
              MyLink := cLinkLong[ pw_SetOf ];
            if ( Child.Link = pw_PairOf ) then
              MyLink := cLinkLong[ pw_PartOf ];
            //if ( Child.Link = pw_PairDivOf ) then
            //  MyLink := cLinkLong[ pw_DivisionOf ];
            //if ( Child.Link = pw_PairSpaceIn ) then
            //  MyLink := cLinkLong[ pw_DivisionOf ];
            Value := Child.GetLibelle( lb_Base, TAH.MainLang );
            if ( Indx < NbItem - 2 ) then
              Value := Value + cSpace + cRol + MyLink + cRor;
            if ( Indx > 1 ) then
              LinkText := AOTAG + cHrefEmpty + ViewCode + cSpace + cEntity +
                          cSpace + cLgShort[ lt_English ] + cPeriod +
                          HtmlExt + cDQuote + cAnr;
            AName := Child.GetLibelle( lb_Base, TAH.SubstLang );
            AnItem.Value := Value;
            AnItem.Bubble := AName;
            AnItem.Url := LinkText;
            AnItem.Color := TAH.MainLang;
            AnItem.Indent := MyIndent;
            AddItem( AnItem );
          end;
        end; // for
      end;
    end;
  end;
end; // _________________________________________________tLightPartSection.Build

function           tValidSection.GetNbLine()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbLine
  * Property read method for number of lines in a section *
  Description:
  This procedure retrieves the number of lines in a section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( FLine );
end; // _______________________________________________________________GetNbItem

function           tValidSection.GetNbNote()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbNote
  * Property read method for number of notes in a section *
  Description:
  This procedure retrieves the number of notes in a section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( FNote );
end; // _______________________________________________________________GetNbNote

procedure          tValidSection.AddLine(
  AnItem:          TValidEntry );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddLine
  * Add a line to a List section *
  Description:
  This procedure increase by one unit the size of the area of lines, and add
  the given line in the last position.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Nb:              Integer;
begin
  Nb := Self.NbLine + 1;
  SetLength( Self.FLine, Nb );
  Self.FLine[ Nb - 1 ] := AnItem;
end; // _________________________________________________________________AddLine

function           tValidSection.GetLine(
  PosItem:         Integer )
  :                tValidEntry;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetLine
  * Get a line by its position from a List section *
  Description:
  This procedure returns the line at the specified position, if the position is
  within the limits of existing positions, nil otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := nil;
  if ( ( PosItem < 0 ) or ( PosItem > Self.NbLine - 1 ) ) then
    Exit;
  Result := Self.FLine[ PosItem ];
end; // _________________________________________________________________GetLine

procedure          tValidSection.ResetLines;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ResetLines
  * Reset all line to a validation section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( Self.FLine, 0 );
end; // ______________________________________________________________ResetLines

procedure          tValidTermSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TValidTermSection.Build
  * Make the Term Section for a Validation Page *
  Description:
  This section considers all units at level 5 for the present entity. In
  addition, and for each unit with an existing inquery, the validation
  information is displayed with all its history, in a time sequential order.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Start:           Integer;
  TetValue:        Integer;
  NbTetra:         Integer;
  ActNiv:          Integer;
  TotDis:          Integer;
  TotInq:          Integer;
  TotRed:          Integer;
  TotOra:          Integer;
  TotGre:          Integer;
  MyTID:           ^Integer;
  IsTax:           Boolean;
  ListTetra:       tList;
  ViewCode:        String;
  Value:           String;
  Bubble:          String;
  Flag:            String;
  ListType:        String;
  SubListType:     String;
  Main:            tEntity;
  Tetra:           tTetrahedron;
  Inquiry:         tInquiries;
  MyMain:          tEntity;
  MyRef:           tEntity;
  AnItem:          tValidEntry;
begin
  // Initial stuff
  Start := 0;
  Main := Self.Entity;
  TotInq := 0;
  TotRed := 0;
  TotOra := 0;
  TotGre := 0;
  if ( Main <> nil ) then
  begin

    // Retrieve the sorted list of units depending of type of list
    TetValue := Main.Tetra;
    ListTetra := TList.Create;
    NbTetra := 0;
    IsTax := ( ( Main.ListTax = cTypeListPage[ li_tax4 ] ) or
               ( Main.ListTax = cTypeListPage[ li_tax3 ] ) );
    IsTax := ( IsTax and ( Self.TypeList in [ li_tax4, li_tax3 ] ) );
    if ( IsTax ) then
    begin
      NbTetra := TAH.GetTaxListTetra( TetValue, ListTetra );
      ListType := Main.ListTax;
    end else
    begin
      NbTetra := TAH.GetPartListTetra( TetValue, ListTetra );
      ListType := Main.ListPart;
    end;

    // Skip an empty list
    if ( NbTetra = 0 ) then
      Exit;

    // Consider a possible list inquiry
    if ( TAH.Inquiries.InquiryExist( TetValue, Inquiry ) ) then
    begin

      // Define and store the list inquiry
      AnItem := TValidEntry.Create;
      AnItem.ViewCode := 'List' + cSpace + ListType;
      AnItem.Term := 'Global inquiry';
      AnItem.Bubble := cEmpty;
      Self.AddLine( AnItem );

      // Display the list inquiries
      DisplayUnitInquiries( Inquiry, TotInq, TotRed, TotOra, TotGre, True );
    end;

    // Display the units
    ActNiv := 0;
    TotDis := 0;
    for Indx := 0 to NbTetra - 1 do
    begin
      MyTID := ListTetra[ Indx ];
      Tetra := TAH.GetTetrahedronByTID( MyTID^ );

      // Skip lexical references
      if ( Tetra.TetraType = tt_lex ) then
        Continue;

      // Find the relevant entity for display
      if ( Tetra <> nil ) then
      begin
        if ( IsTax ) then
        begin
          MyMain := Tetra.Genr;
          if ( Tetra.Genr = nil ) then
            MyMain := Tetra.Main;
        end else
        begin
          MyMain := Tetra.Main;
          if ( Tetra.TetraType = tt_set ) then
            MyMain := Tetra.ASet
          else
          if ( MyMain = nil ) then
            MyMain := Tetra.Genr;
        end;

        // Check for a sublevel
        if ( IsTax ) then
          SubListType := MyMain.ListTax
        else
          SubListType := MyMain.ListPart;
        if ( ( ( ListType = cTypeListPage[ li_part3 ] ) and
               ( SubListType = cTypeListPage[ li_part4 ] ) ) or
             ( ( ListType = cTypeListPage[ li_tax3 ] ) and
               ( SubListType = cTypeListPage[ li_tax4 ] ) ) ) then
        begin
          if ( TAH.Inquiries.InquiryExist( Tetra.TetraID, Inquiry ) ) then
          begin

            // Define and store the list inquiry
            AnItem := TValidEntry.Create;
            AnItem.ViewCode := 'List' + cSpace + SubListType;
            AnItem.Term := 'Sublist inquiry';
            AnItem.Bubble := cEmpty;
            Self.AddLine( AnItem );
            DisplayUnitInquiries( Inquiry, TotInq, TotRed, TotOra, TotGre, True );
          end;
        end;

        // Prepare the code to be displayed with its hyperlink
        ViewCode := CTAH + IntToStr( Tetra.TetraID );
        ViewCode := AOTAG + cHrefEmpty + '../' + cTetrahedron + cSpace +
                    cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                    IntToStr( MyMain.Tetra ) + cSpace + cTetrahedron +
                    cSpace + cLgShort[ TAH.SubstLang ] +
                    cPeriod + HtmlExt + cDQuote + cAnr +  ViewCode + AETAG;

        // Prepare the entity to be displayed with its hyperlink
        if ( Tetra.TetraType <> tt_ref ) then
        begin
          Value := MyMain.GetLibelle( lb_Official, TAH.MainLang );
          Bubble := MyMain.GetLibelle( lb_Base, TAH.SubstLang );
          Value := AOTAG + cHrefEmpty + '../' + cEntity + cSpace +
                   cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                   IntToStr( MyMain.TID ) + cSpace + cEntity +
                   cSpace + cLgShort[ TAH.SubstLang ] +
                   cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
        end else

        // Prepare a reference entity
        begin
          Value := cSpace + cRefImg;
          if ( Tetra.Genr <> nil ) then
          begin
            MyRef := TAH.GetEntityByTID( Tetra.Genr.Reference );
            if ( MyRef <> nil ) then
            begin
              Value := MyRef.GetLibelle( lb_Official, TAH.MainLang, st_undef, True ) + Value;
              Value := AOTAG + cHrefEmpty + '../' + cEntity + cSpace +
                       cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                       IntToStr( MyRef.TID ) + cSpace + cEntity +
                       cSpace + cLgShort[ TAH.SubstLang ] +
                       cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
            end else
              Value := MyMain.InternalTex + Value + cSpace + '(unspecified)';
          end;
          Bubble := cEmpty;
        end;

        // Flag for deleted and no op entities
        Flag := cEmpty;
        if ( Tetra.TetraType = tt_del ) then
          Flag := 'DEL' + cColumn;
        if ( Tetra.TetraType = tt_trans ) then
          Flag := 'NOP' + cColumn;
        if ( Flag <> cEmpty ) then
          Value := Flag + cSpace + Value;

        // Define and store the next line
        AnItem := TValidEntry.Create;
        AnItem.ViewCode := ViewCode;
        AnItem.Term := Value;
        AnItem.Bubble := Bubble;
        Self.AddLine( AnItem );
        Inc( TotDis );
      end;

      // Display all inquiries for current unit
      if ( TAH.Inquiries.InquiryExist( Tetra.TetraID, Inquiry ) ) then
        DisplayUnitInquiries( Inquiry, TotInq, TotRed, TotOra, TotGre );
    end; // for on all units

    // Display the number of units
    AnItem := TValidEntry.Create;
    AnItem.DateAction := cEmpty;
    AnItem.Source := cEmpty;
    AnItem.Title := 'Number of units' + cColumn + cSpace + IntToStr( TotDis );
    Self.AddLine( AnItem );

    // Display the number of inquiries
    AnItem := TValidEntry.Create;
    AnItem.DateAction := cEmpty;
    AnItem.Source := cEmpty;
    AnItem.Title := 'Number of inquiries' + cColumn + cSpace +
                    IntToStr( TotInq );
    Self.AddLine( AnItem );

    // Display the number of red lights
    AnItem := TValidEntry.Create;
    AnItem.DateAction := cEmpty;
    AnItem.Source := cEmpty;
    AnItem.Title := 'Number of red lights' + cColumn + cSpace +
                    IntToStr( TotRed );
    Self.AddLine( AnItem );

    // Display the number of orange lights
    AnItem := TValidEntry.Create;
    AnItem.DateAction := cEmpty;
    AnItem.Source := cEmpty;
    AnItem.Title := 'Number of orange lights' + cColumn + cSpace +
                    IntToStr( TotOra );
    Self.AddLine( AnItem );

    // Display the number of green lights
    AnItem := TValidEntry.Create;
    AnItem.DateAction := cEmpty;
    AnItem.Source := cEmpty;
    AnItem.Title := 'Number of green lights' + cColumn + cSpace +
                    IntToStr( TotGre );
    Self.AddLine( AnItem );
  end;
end; // _________________________________________________TValidTermSection.Build

procedure          tValidSection.DisplayUnitInquiries(
  Inquiry:         tInquiries;
  var TotInq:      Integer;
  var TotRed:      Integer;
  var TotOra:      Integer;
  var TotGre:      Integer;
  IsGlobal:        Boolean );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DisplayUnitInquiries
  * Display all inquiries of a unit *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  Count:           Integer;
  Posit:           Integer;
  NextAID:         Integer;
  MyAction:        String;
  SourceAction:    String;
  MyDate:          String;
  MyImg:           String;
  MySource:        String;
  MyTitle:         String;
  MyDescr:         String;
  MyStatus:        String;
  Action:          ActionRec;
  AnItem:          tValidEntry;
begin
  // Loop on all inquiries
  Count := Length( Inquiry );
  for Indy := 0 to Count - 1 do
  begin
    if ( ( ( IsGlobal ) and ( Inquiry[ Indy ].Lis = cEmpty ) ) or
         ( ( not IsGlobal ) and ( Inquiry[ Indy ].Lis <> cEmpty ) ) ) then
      Continue;
    Inc( TotInq );
    MyAction := TAH.Actions.ListActions( Inquiry[ Indy ].IID );
    SourceAction := MyAction;
    Posit := Pos( cSpace, Inquiry[ Indy ].Dat );
    if ( Posit > 0 ) then
      MyDate := Copy( Inquiry[ Indy ].Dat, 1, Posit - 1 )
    else
      MyDate := Inquiry[ Indy ].Dat;

    // Search the firecolor of last action
    NextAID := 0;
    while ( MyAction <> cEmpty ) do
    begin
      Posit := Pos( cSemi, MyAction );
      if ( Posit > 0 ) then
      begin
        NextAID := StrToInt( Copy( MyAction, 1, Posit - 1 ) );
        MyAction := Copy( MyAction, Posit + 1, Length( MyAction ) );
      end else
      begin
        NextAID := StrToInt( MyAction );
        MyAction := cEmpty;
      end;
    end; // While on all actions
    if ( TAH.Actions.ActionExist( NextAID , Action ) ) then
    begin
      if ( Action.Status = 'red' ) then
      begin
        MyImg := cRedImg;
        Inc( TotRed );
      end else
      if ( Action.Status = 'gre' ) then
      begin
        MyImg := cGreenImg;
        Inc( TotGre );
      end else
      if ( Action.Status = 'ora' ) then
      begin
        MyImg := cOrangeImg;
        Inc( TotOra );
      end;
    end;

    // Search the source and title of inquiry
    MySource := 'Inquiry' + cSpace + cNumber + cSpace +
                IntToStr( Inquiry[ Indy ].IID ) + cSpace +
                'open by' + cSpace + Inquiry[ Indy ].Who + cSpace +
                'on' + cSpace + Inquiry[ Indy ].Dat;
    MyTitle := MyImg + cSpace + '<B>' + Inquiry[ Indy ].Lib + '</B>';

    // Define and store the inquiry
    AnItem := TValidEntry.Create;
    AnItem.DateInquiry := MyDate;
    AnItem.Source := MySource;
    AnItem.Title := MyTitle;
    Self.AddLine( AnItem );

    // Go through the list of all actions
    while ( SourceAction <> cEmpty ) do
    begin
      Posit := Pos( cSemi, SourceAction );
      if ( Posit > 0 ) then
      begin
        NextAID := strToInt( Copy( SourceAction, 1, Posit - 1 ) );
        SourceAction :=
          Copy( SourceAction, Posit + 1, Length( SourceAction ) );
      end else
      begin
        NextAID := StrToInt( SourceAction );
        SourceAction := cEmpty;
      end;
      if ( TAH.Actions.ActionExist( NextAID , Action ) ) then
      begin
        Posit := Pos( cSpace, Action.Dat );
        if ( Posit > 0 ) then
          MyDate := Copy( Action.Dat, 1, Posit - 1 )
        else
          MyDate := Action.Dat;
        MyDescr := Action.Descr;
        MyDescr := MakeHyperlinks( MyDescr );
        if ( Action.Status = 'red' ) then
          MyStatus := 'red'
        else
        if ( Action.Status = 'gre' ) then
          MyStatus := 'green'
        else
        if ( Action.Status = 'ora' ) then
          MyStatus := 'orange';
        MySource := 'Action' + cSpace + cNumber + cSpace +
                    IntToStr( Action.AID ) + cSpace +
                    'open by' + cSpace + Action.Aut + cSpace +
                    'with status' + cSpace + MyStatus;

        // Define and store the next action
        AnItem := tValidEntry.Create;
        AnItem.DateAction := MyDate;
        AnItem.Source := MySource;
        AnItem.Action := MyDescr;
        Self.AddLine( AnItem );
      end;
    end; // while on all actions of an inquery
  end; // for on all inquiries
end; // ____________________________________________________DisplayUnitInquiries

procedure          tValidSection.WriteSection(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteSection
  * Write a validation section *
   ============================
  Description:
  This method writes a validation section of a List Page. Each section is
  made of a variable number of items, which are handled in turn.</P>
  Amongst the section items may be present DIV information, which goal is the
  creation of divisions controled by a toggle switch, active when the page is
  displayed as a dynamic HTML feature. There are open and close DIV items.
  In addition, an implicite division is automatically created for each section
  as a whole.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyID:            String;
  MyType:          tSectionType;
begin
  if ( Self <> nil ) then
  begin

    // Write the section title
    if ( IsLarge ) then
      AddTag( TABLEOTAG + cSectionTitle1400 + cAnr, Lev )
    else
      AddTag( TABLEOTAG + cSectionTitle700 + cAnr, Lev );
      AddTag( TRTAG, Lev + 1 );
        MakeTDTitleSection( Self, Lev + 2 );

        // Additional local help for section on taxonomy
        if ( ( SectionType = sc_Taxonomy ) and FMAChange ) then
          MakeTD( cClassTitleSect, 'Help on colors',
                        SectionBubble, Lev + 2 );

      AddTag( TRETAG, Lev + 1 );
    AddTag( TABLEETAG, Lev );

    // Open a DIV tag for the section with specific ID
    MyType := Self.SectionType;
    MyID := 'Id=' + cDQuote + cIDSection[ MyType ] + cDQuote;
    AddTag( DIVOTAG + MyID + cAnr, Lev );
      AddTag( TABLEOTAG + cSectionContent + cAnr, Lev + 1 );

      // Special sections for lists or notes
      begin
        if ( MyType = sc_ValidUniv ) then
        begin
          AddTag( TABLETAG, 5 );
          WriteLines( 5 );
          AddTag( TABLEETAG, 5 );
        end;
      end;

      // Close the DIV tag for the section
      AddTag( TABLEETAG, Lev + 1 );
    AddTag( DIVETAG + cOComment + cIDSection[ MyType ] + cEComment, Lev );
  end;
end; // ____________________________________________________________WriteSection

procedure          tValidSection.WriteLines(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteLines
  * Write all lines of a List Page *
  Description:
  This procedure writes all collected lines in sequence. The first line
  contains the column titles.</P>
  The following columns are present:
  - The FMA unique identifier, with hyperlink to the FME website,
  - The TA98 icon when the line corresponds to a TA98 entity, with the TA98
    11-digit code and the original TA98 term in a bubble,
  - The Entity unique identifier, with hyperlink to the Entity Page,
  - The Unit unique identifier, with hyperlink to the Unit Page,
  - The pair icon, indicating that the present entity is a pair (only in the
    taxonomy),
  - The term in first language, usually Latin, with corresponding FMA term if
    it exist in a bubble,
  - The term in second language, any vernacular, with US variant in a bubble
    if English.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  TotLine:         Integer;
  MyView:          String;
  MyTA98:          String;
  MyTA98Code:      String;
  MyPaire:         String;
  MyProfile:       String;
  MyBubble:        String;
  MyBr:            String;
  MyFamily:        String;
  MyLine:          tValidEntry;
begin
  TotLine := Self.NbLine;
  if ( TotLine > 0 ) then
  begin
    for Indx := 0 to TotLine - 1 do
    begin
      MyLine := GetLine( Indx );
      if ( MyLine <> nil ) then
      begin

        // Prepare the profile
        if ( Self.SectionType = sc_ValidUniv ) then
        begin
          MyProfile := MyLine.Profile;
          MyBubble := MyLine.Formula;
        end;

        // Write the line
        AddTag( TRTAG, Lev + 1 );
          MakeTD( cClassColS, MyLine.ViewFMA, MyLine.FMALib, Lev + 2 );
          MakeTD( cClassColS, MyTA98, MyTA98Code, Lev + 2 );
          MakeTD( cClassColS, MyLine.ViewCode, cEmpty, Lev + 2 );
          MakeTD( cClassColS, MyView, cEmpty, Lev + 2 );
          MakeTD( cClassColS, MyProfile, MyBubble, Lev + 2 );
          if ( Self.SectionType = sc_ValidUniv ) then
            MakeTD( cClassColS, MyBr, MyFamily, Lev + 2 );
          if ( Self.TypeList in
               [ li_tax1, li_tax2, li_tax2f, li_tax3, li_tax4 ] ) then
            MakeTD( cClassColS, MyPaire, cEmpty, Lev + 2 );
          MakeTD( cClassColX, MyLine.Title, cEmpty, Lev + 2 );
          MakeTD( cClassColX, MyLine.Action, MyLine.Bubble, Lev + 2 );
        AddTag( TRETAG, Lev + 1 );
      end;
    end; // for
  end;
end; // ______________________________________________________________WriteLines

function           tListSection.GetNbLine()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbLine
  * Property read method for number of lines in a section *
  Description:
  This procedure retrieves the number of lines in a section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( FLine );
end; // _______________________________________________________________GetNbItem

function           tListSection.GetNbNote()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbNote
  * Property read method for number of notes in a section *
  Description:
  This procedure retrieves the number of notes in a section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( FNote );
end; // _______________________________________________________________GetNbNote

procedure          tListSection.AddLine( AnItem: tListItem );
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddLine
  * Add a line to a List section *
  Description:
  This procedure increase by one unit the size of the area of lines, and add
  the given line in the last position.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Nb:              Integer;
begin
  Nb := Self.NbLine + 1;
  SetLength( Self.FLine, Nb );
  Self.FLine[ Nb - 1 ] := AnItem;
end; // _________________________________________________________________AddLine

procedure          tListSection.AddNote(
  ANote:           NoteRec );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddNote
  * Add a note to a List section *
  Description:
  This procedure increase by one unit the size of the area of notes, and add
  the given note in the last position.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Nb:              Integer;
begin
  Nb := Self.NbNote + 1;
  SetLength( Self.FNote, Nb );
  Self.FNote[ Nb - 1 ] := ANote;
end; // _________________________________________________________________AddNote

function           tListSection.GetLine(
  PosItem:         Integer )
  : tListItem;
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetLine
  * Get a line by its position from a List section *
  Description:
  This procedure returns the line at the specified position, if the position is
  within the limits of existing positions, nil otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := nil;
  if ( ( PosItem < 0 ) or ( PosItem > Self.NbLine - 1 ) ) then
    Exit;
  Result := Self.fLine[ PosItem ];
end; // _________________________________________________________________GetLine

function           tListSection.GetNote(
  PosItem:         Integer )
  :                NoteRec;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNote
  * Get a note by its position from a List section *
  Description:
  This procedure returns the note at the specified position, if the position is
  within the limits of existing positions, nil otherwise.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( ( PosItem < 0 ) or ( PosItem > Self.NbNote - 1 ) ) then
    Exit;
  Result := Self.FNote[ PosItem ];
end; // _________________________________________________________________GetNote

procedure          tListSection.ResetLines;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ResetLines
  * Reset all line to a List section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( Self.FLine, 0 );
end; // ______________________________________________________________ResetLines

procedure          tListSection.WriteSection(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteSection
  * Write a section of any type for a List page *
   =============================================
  Description:
  This method writes a single section of a List Page. Each section is made of
  a variable number of items, which are handled in turn.</P>
  Amongst the section items may be present DIV information, which goal is the
  creation of divisions controled by a toggle switch, active when the page is
  displayed as a dynamic HTML feature. There are open and close DIV items.
  In addition, an implicite division is automatically created for each section
  as a whole.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyID:            String;
  MyType:          tSectionType;
begin
  if ( Self <> nil ) then
  begin

    // Write the section title
    if ( not TA98Short ) then
    begin
    if ( IsLarge ) then
      AddTag( TABLEOTAG + cSectionTitle1400 + cAnr, Lev )
    else
      AddTag( TABLEOTAG + cSectionTitle700 + cAnr, Lev );
        AddTag( TRTAG, Lev + 1 );
          MakeTDTitleSection( Self, Lev + 2 );

          // Additional local help for section on taxonomy
          if ( ( SectionType = sc_Taxonomy ) and FMAChange ) then
            MakeTD( cClassTitleSect, 'Help on colors',
                          SectionBubble, Lev + 2 );

        AddTag( TRETAG, Lev + 1 );
      AddTag( TABLEETAG, Lev );
    end;

    // Open a DIV tag for the section with specific ID
    MyType := Self.SectionType;
    MyID := 'Id=' + cDQuote + cIDSection[ MyType ] + cDQuote;
    AddTag( DIVOTAG + MyID + cAnr, Lev );
      if ( not TA98Short ) then
        AddTag( TABLEOTAG + cSectionContent + cAnr, Lev + 1 );

      // Special sections for lists or notes
      begin
        if ( ( MyType = sc_PartList ) or
             ( MyType = sc_TaxList ) or
             ( MyType = sc_ValidUniv ) or
             ( MyType = sc_Reference ) ) then
        begin
          AddTag( TABLETAG, 5 );
          WriteLines( 5 );
          AddTag( TABLEETAG, 5 );
        end else
        if ( MyType = sc_IntList ) then
        begin
          AddTag( TABLETAG, 5 );
          WriteIntLines( 5 );
          AddTag( TABLEETAG, 5 );
        end else
        if ( MyType = sc_Part98 ) then
        begin
          //if ( not TA98Short ) then
            AddTag( TABLETAG, 5 );
          WriteTA98Lines( 5 );
          //if ( not TA98Short ) then
            AddTag( TABLEETAG, 5 );
        end else
        if ( MyType = sc_NoteList ) then
        begin
          AddTag( TABLETAG, 5 );
          WriteNotes( 5 );
          AddTag( TABLEETAG, 5 );
        end;
      end;

      // Close the DIV tag for the section
      AddTag( TABLEETAG, Lev + 1 );
    AddTag( DIVETAG + cOComment + cIDSection[ MyType ] + cEComment, Lev );
  end;
end; // _______________________________________________tListSection.WriteSection

procedure          tListSection.WriteLines(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteLines
  * Write all lines of a List Page *
  Description:
  This procedure writes all collected lines in sequence. The first line
  contains the column titles.</P>
  The following columns are present:
  - The FMA unique identifier, with hyperlink to the FME website,
  - The TA98 icon when the line corresponds to a TA98 entity, with the TA98
    11-digit code and the original TA98 term in a bubble,
  - The Entity unique identifier, with hyperlink to the Entity Page,
  - The Unit unique identifier, with hyperlink to the Unit Page,
  - The pair icon, indicating that the present entity is a pair (only in the
    taxonomy),
  - The term in first language, usually Latin, with corresponding FMA term if
    it exist in a bubble,
  - The term in second language, any vernacular, with US variant in a bubble
    if English.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  TotLine:         Integer;
  MyClassLeft:     String;
  MyClassRight:    String;
  MyClassFR:       String;
  MyClassSP:       String;
  MyClassRU:       String;
  MyView:          String;
  MyTA98:          String;
  MyTA98Code:      String;
  MyOriLA:         String;
  MyPaire:         String;
  MyProfile:       String;
  MyBubble:        String;
  MyBr:            String;
  MyFamily:        String;
  MyLine:          tListItem;
begin
  TotLine := Self.NbLine;
  if ( TotLine > 0 ) then
  begin
    for Indx := 0 to TotLine - 1 do
    begin
      MyLine := GetLine( Indx );
      if ( MyLine <> nil ) then
      begin

        // Prepare the class for first and second language
        MyClassLeft :=
          cClassEmpty + cLgShort[ lt_Latin ] + MyLine.Indent + cDQuote;
        MyClassRight :=
          cClassEmpty + cLgShort[ lt_English ] + MyLine.Indent + cDQuote;
        MyClassFR :=
          cClassEmpty + cLgShort[ lt_French ] + MyLine.Indent + cDQuote;
        MyClassSP :=
          cClassEmpty + cLgShort[ lt_Dutch ] + MyLine.Indent + cDQuote;
        MyClassRU :=
          cClassEmpty + cLgShort[ lt_German ] + MyLine.Indent + cDQuote;

        // Prepare the Unit column with a possible note icon
        if ( ( MyLine.Left <> cEmpty ) and ( MyLine.Left[ 1 ] = '#' ) ) then
          MyView := MyView;
        MyView := Trim( MyLine.ViewUnit );
        if ( MyLine.NoteFlag ) then
          MyView := MyView + cIsNote;

        // Prepare the pair icon
        MyPaire := cEmpty;
        if ( MyLine.IsPaire ) then
          MyPaire := cPaireImg;
        if ( Indx = 0 ) then
          MyPaire := '<B>Pair</B>';

        // Prepare the TA98 icon
        MyTA98 := cBlankImg;
        if ( MyLine.TA98 ) then
          MyTA98 := cTA98Img;
        if ( Indx = 0 ) then
          MyTA98 := '<B>TA</B>';

        // Alternatively, replace TA98 icon by Plus icon
        if ( ( MyTA98 = cBlankImg ) and ( MyLine.TAPlus ) ) then
          MyTA98 := cTAPlusImg;

        // Prepare original TA98 text
        MyTA98Code := cEmpty;
        MyOriLA := cEmpty;
        if( MyLine.OriLA <> cEmpty ) then
          MyOriLA := cSpace + MyLine.OriLA;
        if ( Indx > 0 ) then
          MyTA98Code := MyLine.TA98Code + MyOriLA;

        // Prepare the profile
        if ( Self.SectionType = sc_ValidUniv ) then
        begin
          MyProfile := MyLine.Profile;
          MyBubble := MyLine.Formula;
          MyBr := ' ';
          MyFamily := cEmpty;
          if ( MyLine.ValidLow ) then
          begin
            MyBr := cArobas;
          end else
          if ( MyLine.ValidHigh ) then
          begin
            MyBr := cAmpersand;
            MyFamily := cFamily[ MyLine.Family ];
          end;
          if ( Indx = 0 ) then
            MyBr := '<B>OK</B>';
        end;

        // Write the line in 700 px format
        if ( ( not IsLarge ) or
             ( IsLarge and ( not MultiLg ) ) ) then
        begin
          AddTag( TRTAG, Lev + 1 );
            MakeTD( cClassColS, MyLine.ViewFMA, MyLine.FMALib, Lev + 2 );
            MakeTD( cClassColS, MyTA98, MyTA98Code, Lev + 2 );
            if ( not IsPub ) then
            begin
              MakeTD( cClassColS, MyLine.ViewCode, cEmpty, Lev + 2 );
            end;
            MakeTD( cClassColS, MyView, cEmpty, Lev + 2 );
            MakeTD( cClassColS, MyProfile, MyBubble, Lev + 2 );
            if ( Self.SectionType = sc_ValidUniv ) then
              MakeTD( cClassColS, MyBr, MyFamily, Lev + 2 );
            if ( Self.TypeList in
                 [ li_tax1, li_tax2, li_tax2f, li_tax3, li_tax4 ] ) then
              MakeTD( cClassColS, MyPaire, cEmpty, Lev + 2 );
            MakeTD( cClassColX, MyLine.Left, cEmpty, Lev + 2,
                    MyClassLeft );
            MakeTD( cClassColX, MyLine.Right, MyLine.Bubble, Lev + 2,
                    MyClassRight );
          AddTag( TRETAG, Lev + 1 );

          // Write additional lines for multilanguage option
          if ( MultiLg ) then
          begin
            AddTag( TRTAG, Lev + 1 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColX, MyLine.Uni2, cEmpty, Lev + 2,
                      MyClassLeft );
              MakeTD( cClassColX, MyLine.Off2, MyLine.Bubble, Lev + 2,
                      MyClassRight );
            AddTag( TRETAG, Lev + 1 );
            AddTag( TRTAG, Lev + 1 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColX, MyLine.Uni3, cEmpty, Lev + 2,
                      MyClassLeft );
              MakeTD( cClassColX, MyLine.Off3, MyLine.Bubble, Lev + 2,
                      MyClassRight );
            AddTag( TRETAG, Lev + 1 );
            AddTag( TRTAG, Lev + 1 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColX, MyLine.Uni4, cEmpty, Lev + 2,
                      MyClassLeft );
              MakeTD( cClassColX, MyLine.Off4, MyLine.Bubble, Lev + 2,
                      MyClassRight );
            AddTag( TRETAG, Lev + 1 );
            AddTag( TRTAG, Lev + 1 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
              MakeTD( cClassColX, MyLine.Uni5, cEmpty, Lev + 2,
                      MyClassLeft );
              MakeTD( cClassColX, MyLine.Off5, MyLine.Bubble, Lev + 2,
                      MyClassRight );
            AddTag( TRETAG, Lev + 1 );
          end;
        end else

        // Write a multilanguage line in large format
        begin
          AddTag( TRTAG, Lev + 1 );
            MakeTD( cClassColS, MyLine.ViewFMA, MyLine.FMALib, Lev + 2 );
            MakeTD( cClassColS, MyTA98, MyTA98Code, Lev + 2 );
            if ( not IsPub ) then
              MakeTD( cClassColS, MyLine.ViewCode, cEmpty, Lev + 2 );
            MakeTD( cClassColS, MyView, cEmpty, Lev + 2 );
            MakeTD( cClassColS, MyProfile, MyBubble, Lev + 2 );
            if ( MyLine.Right = cNBSP ) then
              MakeTD( cClassColX, MyLine.Left, MyLine.Bubble, Lev + 2,
                      MyClassRight )
            else
              MakeTD( cClassColX, MyLine.Right, MyLine.Bubble, Lev + 2,
                      MyClassRight );
            if ( MyLine.Off2 = cNBSP ) then
              MakeTD( cClassColX, MyLine.Uni2, cEmpty, Lev + 2, MyClassLeft )
            else
              MakeTD( cClassColX, MyLine.Off2, cEmpty, Lev + 2, MyClassLeft );
            if ( MyLine.Off3 = cNBSP ) then
              MakeTD( cClassColX, MyLine.Uni3, cEmpty, Lev + 2, MyClassFR )
            else
              MakeTD( cClassColX, MyLine.Off3, cEmpty, Lev + 2, MyClassFR );
            if ( MyLine.Off4 = cNBSP ) then
              MakeTD( cClassColX, MyLine.Uni4, cEmpty, Lev + 2, MyClassSP )
            else
              MakeTD( cClassColX, MyLine.Off4, cEmpty, Lev + 2, MyClassSP );
            if ( MyLine.Off5 = cNBSP ) then
              MakeTD( cClassColX, MyLine.Uni5, cEmpty, Lev + 2, MyClassRU )
            else
              MakeTD( cClassColX, MyLine.Off5, cEmpty, Lev + 2, MyClassRU );
          AddTag( TRETAG, Lev + 1 );
        end;
      end;
    end; // for
  end;
end; // _________________________________________________tListSection.WriteLines

procedure          tListSection.WriteIntLines(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteIntLines
  * Write all lines of a Interface List Page *
  Description:
  This procedure writes all collected lines in sequence. The first line
  contains the column titles.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  TotLine:         Integer;
  MyClassLeft:     String;
  MyClassRight:    String;
  MyClassEN:       String;
  MyClassFR:       String;
  MyClassES:       String;
  MyClassRU:       String;
  MyView:          String;
  MyTA98:          String;
  MyTA98Code:      String;
  MyOriLA:         String;
  MyPaire:         String;
  MyProfile:       String;
  MyBubble:        String;
  MyBr:            String;
  MyFamily:        String;
  MyLine:          tListItem;
begin
  TotLine := Self.NbLine;
  if ( TotLine > 0 ) then
  begin

    // Loop on all lines
    for Indx := 0 to TotLine - 1 do
    begin
      MyLine := GetLine( Indx );
      if ( MyLine <> nil ) then
      begin

        // Prepare the class for first and second language
        MyClassLeft :=
          cClassEmpty + cLgShort[ lt_Latin ] + MyLine.Indent + cDQuote;
        MyClassRight :=
          cClassEmpty + cLgShort[ TAH.SubstLang ] + MyLine.Indent + cDQuote;
        MyClassEN :=
          cClassEmpty + cLgShort[ lt_English ] + MyLine.Indent + cDQuote;
        MyClassFR :=
          cClassEmpty + cLgShort[ lt_French ] + MyLine.Indent + cDQuote;
        MyClassES :=
          cClassEmpty + cLgShort[ lt_Dutch ] + MyLine.Indent + cDQuote;
        MyClassRU :=
          cClassEmpty + cLgShort[ lt_Italian ] + MyLine.Indent + cDQuote;

        // Write the line in 700 px format
        AddTag( TRETAG, Lev + 1 );
          MyView := Trim( MyLine.ViewUnit );
          MakeTD( cClassColS, MyView, cEmpty, Lev + 2 );
          MakeTD( cClassColN, MyLine.Left, cEmpty, Lev + 2, MyClassLeft );
          MakeTD( cClassColXXX, MyLine.Right, cEmpty, Lev + 2, MyClassRight );
        AddTag( TRETAG, Lev + 1 );
        AddTag( TRTAG, Lev + 1 );
          MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
          MakeTD( cClassColN, MyLine.Uni2, cEmpty, Lev + 2, MyClassEN );
          MakeTD( cClassColXXX, MyLine.Off2, cEmpty, Lev + 2, MyClassEN );
        AddTag( TRETAG, Lev + 1 );
        AddTag( TRTAG, Lev + 1 );
          MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
          MakeTD( cClassColN, MyLine.Uni3, cEmpty, Lev + 2, MyClassFR );
          MakeTD( cClassColXXX, MyLine.Off3, cEmpty, Lev + 2, MyClassFR );
        AddTag( TRETAG, Lev + 1 );
        AddTag( TRTAG, Lev + 1 );
          MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
          MakeTD( cClassColN, MyLine.Uni4, cEmpty, Lev + 2, MyClassES );
          MakeTD( cClassColXXX, MyLine.Off4, cEmpty, Lev + 2, MyClassES );
        AddTag( TRETAG, Lev + 1 );
        AddTag( TRTAG, Lev + 1 );
          MakeTD( cClassColS, cEmpty, cEmpty, Lev + 2 );
          MakeTD( cClassColN, MyLine.Uni5, cEmpty, Lev + 2, MyClassRU );
          MakeTD( cClassColXXX, MyLine.Off5, cEmpty, Lev + 2, MyClassRU );
        AddTag( TRETAG, Lev + 1 );
      end;
    end; // for on all lines
  end;
end; // ______________________________________________tListSection.WriteIntLines

procedure          tListSection.WriteTA98Lines(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteTA98Lines
  * Write all lines of a TA98 list Page *
  Description:
  This procedure writes all collected lines in sequence. The first line
  contains the column titles.</P>
  The following columns are present:
  - The FMA unique identifier, with hyperlink to the FME website,
  - The TA98 icon when the line corresponds to a TA98 entity, with the TA98
    11-digit code and the original TA98 term in a bubble,
  - The Entity unique identifier, with hyperlink to the Entity Page,
  - The Unit unique identifier, with hyperlink to the Unit Page,
  - The pair icon, indicating that the present entity is a pair (only in the
    taxonomy),
  - The term in first language, usually Latin, with corresponding FMA term if
    it exist in a bubble,
  - The term in second language, any vernacular, with US variant in a bubble
    if English.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  TotLine:         Integer;
  Nb:              Integer;
  MyClassLeft:     String;
  MyClassRight:    String;
  MyView:          String;
  MyTA98:          String;
  MyID:            String;
  MyValue:         String;
  Toggle:          String;
  MyLine:          tListItem;
begin
  TotLine := Self.NbLine;
  if ( TotLine > 0 ) then
  begin
    for Indx := 0 to TotLine - 1 do
    begin
      Toggle := cEmpty;
      MyLine := GetLine( Indx );
      if ( MyLine <> nil ) then
      begin

          // Open a DIV tag
          if ( MyLine.ItemType = tt_MakeODiv ) then // ?????????????????
          begin
            AddTag( TABLEETAG, Lev );
            MyID := 'Id=' + cDQuote + MyLine.Value + cDQuote;
            AddTag( DIVOTAG + MyID + cAnr, Lev );
            Inc( Lev );
            AddTag( TABLETAG, Lev );
            Continue;
          end else

          // Close a DIV tag
          if ( MyLine.ItemType = tt_MakeEDiv ) then
          begin
            AddTag( TABLEETAG, Lev );
            Dec( Lev );
            AddTag( DIVETAG + cOComment + MyLine.Bubble + cEComment, Lev );
            // Close the division by default
            MyValue := Copy( MyLine.Bubble, 9, Length( MyLine.Bubble ) );
            Nb := 0;
            if ( Length( MyValue ) > 0 ) then
              Nb := StrToInt( MyValue );
            if ( ( Nb > 1 ) or ( TA98Short ) ) then
            begin
              AddTag( SCRIPTTAG, Lev );
                if ( not TA98Short ) then
                  AddTag( 'ToggleSection' + cRol + cSpace + cDQuote +
                          MyLine.Bubble + cDQuote + cSpace + cRor, Lev + 1 )
                else
                  AddTag( 'InitSection' + cRol + cSpace + cDQuote +
                          MyLine.Bubble + cDQuote + cSpace + cRor, Lev + 1 );

              AddTag( SCRIPTETAG, Lev );
              AddTag( TABLETAG, Lev );
            end;
            Continue;
          end else

          // Build the toggle button
          if ( MyLine.Value <> cEmpty ) then
          begin
            Toggle := MyLine.Value;
            // AddTag( DIVOTAG + cAnr, Lev );
            //   MakeTD( cClassColS, MyLine.Value, cEmpty, Lev + 1 );
            // AddTag( DIVETAG, Lev );
          end; //??????????????????????

        // Prepare the class for first and second language
        MyClassLeft :=
          cClassEmpty + cLgShort[ lt_Latin ] + MyLine.Indent + cDQuote;
        MyClassRight :=
          cClassEmpty + cLgShort[ lt_English ] + MyLine.Indent + cDQuote;

        // Prepare the Unit column with a possible note icon
        MyView := MyLine.ViewUnit;
        if ( MyLine.NoteFlag ) then
          MyView := MyView + cIsNote;

        // Prepare the TA98 icon
        MyTA98 := cBlankImg;
        if ( MyLine.TA98 ) then
          MyTA98 := MyLine.TA98Code;
        if ( ( not IsTA98 ) and ( Indx = 0 ) ) then
          MyTA98 := '<B>TA98</B>';

        // Write the line
        // AddTag( TABLETAG, Lev );
        AddTag( TRTAG, Lev + 1 );
          MakeTD( cClassColS, MyLine.ViewCode, cEmpty, Lev + 2 );
          MakeTD( cClassColS, MyTA98, cEmpty, Lev + 2 );
          if ( Toggle <> cEmpty ) then
            MakeTD( cClassColX, Toggle + cSpace + MyLine.Left, cEmpty, Lev + 2,
                    MyClassLeft )
          else
            MakeTD( cClassColX, MyLine.Left, cEmpty, Lev + 2, MyClassLeft );
          MakeTD( cClassColX, MyLine.Right, MyLine.Bubble, Lev + 2,
                  MyClassRight );
        AddTag( TRETAG, Lev + 1 );
        // AddTag( TABLEETAG, Lev );
      end;
    end; // for
  end;
end; // _____________________________________________tListSection.WriteTA98Lines

procedure          tListSection.WriteNotes(
  Lev:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteNotes
  * Write all notes of a List Page *
  Description:
  The notes have been collected as an array of note records. The relevant items
  are extracted in a character delimited string, headed by the sort string built
  from the entity identifier. Then the set of all strings is sorted. Finally,
  each note is extracted from its string and displayed.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  TotLine:         Integer;
  Posit:           Integer;
  MyClassLeft:     String;
  RefSort:         String;
  ANote:           String;
  Indent:          String;
  ViewCode:        String;
  PastCode:        String;
  Left:            String;
  MyView:          String;
  MyLine:          tListItem;
  AllNotes:        TStringList;
begin

  // Find all lines and prepare for sorting
  AllNotes := TStringList.Create;
  TotLine := GetNbLine;
  MyLine := nil;
  for Indx := 0 to TotLine - 1 do
  begin
    MyLine := GetLine( Indx );
    MyView := MyLine.ViewCode;
    RefSort := MyLine.ViewCode;
    while ( Length( RefSort ) < 6 ) do
      RefSort := '0' + RefSort;
    AllNotes.Add( RefSort + CurSep + MyView + CurSep + MyLine.Left +
                  CurSep + MyLine.Indent );
  end;
  AllNotes.Sort;

  // Display all sorted lines
  PastCode := cEmpty;
  for Indx := 0 to TotLine - 1 do
  begin
    ANote := AllNotes[ indx ];
    Posit := Pos( CurSep, ANote );
    ANote := Copy( ANote, Posit + 1, Length( ANote ) );
    Posit := Pos( CurSep, ANote );
    ViewCode := Copy( ANote, 1, Posit - 1 );
    if ( ViewCode = PastCode ) then
      Continue;
    ANote := Copy( ANote, Posit + 1, Length( ANote ) );
    Posit := Pos( CurSep, ANote );
    Left := Copy( ANote, 1, Posit - 1 );
    Left := MakeHyperlinks( Left, TAH.DisLanguage, False );
    Indent := Copy( ANote, Posit + 1, Length( ANote ) );
    MyClassLeft := cClassEmpty + cLgShort[ lt_Latin ] + Indent + cDQuote;
    if ( MyLine <> nil ) then
    begin
      AddTag( TRTAG, Lev + 1 );
        MakeTD( cClassColS, ViewCode, cEmpty, Lev + 2 );
        MakeTD( cClassColX, Left, cEmpty, Lev + 2, MyClassLeft );
      AddTag( TRETAG, Lev + 1 );
    end;
    PastCode := ViewCode;
  end; // for
end; // _________________________________________________tListSection.WriteNotes

procedure          tListSection.MakePart98Descendants(
  TID:             Integer;
  Level:           Integer;
  AType:           tTypeListPage;
  IsStop:          Boolean;
  IsExcel:         Boolean;
  var TotChildren: Integer;
  var TotPartial:  Integer;
  var DivName:     String;
  var NbDiv:       Integer;
  var IsOpen:      Boolean );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePart98Descendants
  * Make the list of children for the TA98 partonomy list page *
  Description:
  This recursive procedure works on the TA98 partonomy of the model of anatomy
  as present in the TAH database. It writes the tree of TA98 descendants of the
  specified node.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  Indz:            Integer;
  Posit:           Integer;
  NbTrueChildren:  Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  ActDiv:          Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  NbTerm:          Integer;
  MyTID:           Integer;
  PastTot:         Integer;
  NextTID:         Integer;
  StopList:        Boolean;
  Children:        String;
  SortList:        String;
  ViewCode:        String;
  ViewUnit:        String;
  Bubble:          String;
  MyIndent:        String;
  Value:           String;
  Child98:         String;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          tEntity;
  ADisplay:        tEntity;
  AFather:         tEntity;
  Gener:           tEntity;
  AChild:          tEntity;
  AnItem:          tListItem;
  CurrType:        tTypeListPage;
  SynTerm:         tSingle;
  MyUnit:          tUnit;
  Query:           tSearch;
begin
  // Retrieve the top entity of the list
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get direct children and their number
  Children := Actual.Ch98;
  SortList := Actual.Pos98;
  NbTrueChildren := Actual.NbPart98;

  // Extract the list of order position
  if ( Children = cEmpty ) then
    Exit;
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
  NbTrueChildren := NbOrder;
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

  // Loop on all children
  ActDiv := 0;
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
    NextTID := Child[ Inds ];
    AChild := TAH.GetEntityByTID( NextTID );
    ADisplay := TAH.GetTA98EntityByTID( Child[ Inds ] );
    if ( AChild.TetraTip <> tp_dup ) then
      NextTID := ADisplay.TID;

    // Prepare and display a single TA98 line
    if ( ADisplay <> nil ) then
    begin

      // Write the line
      MakeSingle98Line( ADisplay, Level, AChild.Ch98, DivName, NbDiv, IsOpen,
                        False, True, IsExcel );

      // Possibly stop the list and insert a pointer to sublist
      CurrType := GetTypeList( ADisplay.ListPart98 );
      StopList := ( ( CurrType <> li_undef ) and ( CurrType = AType ) );
      StopList := StopList or
                  ( ( CurrType = li_tax3 ) and ( AType = li_tax2 ) ) or
                  ( ( CurrType = li_tax2 ) and ( AType = li_tax1 ) ) or
                  ( ( ( CurrType = li_part3 ) or ( CurrType = li_TA98part3 )) and
                    ( ( AType = li_part2 ) or ( AType = li_TA98part2 ) ) ) or
                  ( ( ( CurrType = li_part2 ) or ( CurrType = li_TA98part2 )) and
                    ( ( AType = li_part1 ) or ( AType = li_TA98part1 )) );
      if ( ( ( StopList ) ) or
           ( ( CurrType = li_Part3 ) or ( CurrType = li_TA98Part3 ) ) or
           ( ( CurrType = li_Part4 ) or ( CurrType = li_TA98Part4 )) ) then
      begin
        Value := AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                 cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                 IntToStr( ADisplay.TID ) + cSpace + cTax +
                 cTypeListPage[ CurrType ] +
                 cSpace + cLgShort[ TAH.SubstLang ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
        NbChildren := 1;
        ADisplay.GetNumberOfChildren( True, False, True, NbChildren,
                                      NbSpecific );
        Value := Value + cSpace + ADisplay.ListPos + cSpace +
                 IntToStr( NbChildren) + cSpace + 'entities';
        if ( CurrType <> li_tax4 ) then
          Inc( TotChildren, NbChildren )
        else
          Inc( TotChildren );
      end else
        Inc( TotChildren );

      // Call for next level
      if ( not StopList ) then
      begin
        Self.MakePart98Descendants( NextTID, Level + 1, Atype, True,
                                    IsExcel, TotChildren, TotPartial,
                                    DivName, NbDiv, IsOpen );
      end;
    end;
  end; // for Indx := 1 to NbTrueChildren

  // Close a subdivision of descendants
  if ( ( IsOpen ) and ( Level = 2 ) ) then
  begin
    AnItem := TListItem.Create;
    AnItem.ItemType := tt_MakeEDiv;
    AnItem.Bubble := DivName + IntToStr( NbDiv );
    AddLine( AnItem );
  end;
end; // ___________________________________________________MakePart98Descendants

procedure          tListSection.MakePartListDescendants(
  TID:             Integer;
  Level:           Integer;
  AType:           tTypeListPage;
  IsStop:          Boolean;
  IsExcel:         Boolean;
  var TotChildren: Integer;
  var TotPartial:  Integer;
  var CountByLg:   tCountLg );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePartListDescendants
  * Make the list of children for the Partonomy List Page *
  Description:
  This recursive procedure works on a partonomy of the model of anatomy
  as present in the TAH database. It writes the tree of descendants of the
  specified node.<P>
  In addition, in case there is a generic partial partonomy
  related to an entity present in the list of descendants, this distinct
  partonomy is inserted in the list, marked by a # (number sign).</P>
  The preparation and display of each line in the list is given to a
  specialized procedure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  Indz:            Integer;
  Posit:           Integer;
  NbTrueChildren:  Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  ActDiv:          Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  NbTerm:          Integer;
  MyTID:           Integer;
  PastTot:         Integer;
  StopList:        Boolean;
  IsRef:           Boolean;
  IsShort:         Boolean;
  Children:        String;
  SortList:        String;
  ViewCode:        String;
  ViewUnit:        String;
  Bubble:          String;
  MyIndent:        String;
  Value:           String;
  Plus:            String;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          tEntity;
  AChild:          tEntity;
  AFather:         tEntity;
  AChildRef:       tEntity;
  Gener:           tEntity;
  AnItem:          tListItem;
  CurrType:        tTypeListPage;
  SynTerm:         tSingle;
  MyUnit:          tUnit;
  Query:           tSearch;
begin
  // Retrieve the top entity of the list
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  if ( Actual.TID = 40071 ) then
    Children := Children;

  // Get direct children and their number
  Children := Actual.PartCh;
  SortList := Actual.PartPos;
  NbTrueChildren := Actual.NbPartC;

  // 1. Build a partial generic partonomy
  // ====================================
  // Check for the presence of a partial partonomy
  if ( ( Actual.Generator > 0 ) and
       ( ( Actual.TetraTip = tp_pset ) or
         ( Actual.TetraTip = tp_setpset ) or
         ( Actual.TetraTip = tp_tax ) or
         //( Actual.TetraTip = tp_pair ) or
         ( Actual.TetraTip = tp_set ) ) ) then
  begin
    AChild := TAH.GetEntityByTID( Actual.Generator );
    if ( AChild <> nil ) then
      MyUnit := TAH.GetUnitByPos( AChild.Tetra );
    AFather := TAH.GetEntityByTID( Actual.PartAnc );
    if ( ( AChild <> nil ) and ( AChild.NbPartC > 0 ) and
         ( ( AChild.TetraTip = tp_GenSet ) or
           //( AChild.TetraTip = tp_GenPair ) or
           ( AChild.TetraTip = tp_GenPSet ) ) ) then
    begin

      // Compute the value for the generator
      ViewCode := IntToStr( AChild.TID );
      ViewCode := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
                  cLgShort[ lt_English ] + cSlash + cTAH + ViewCode +
                  cSpace + cEntity + cSpace + cLgShort[ lt_English ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + ViewCode + AETAG;
      ViewUnit := IntToStr( Actual.Tetra );
      if ( not IsPub ) then
      begin
        ViewUnit := AOTAG + cHrefEmpty +cRetroDir + cTetrahedron + cSpace +
                    cLgShort[ lt_English ] + cSlash + cTAH + ViewUnit +
                    cSpace + cTetrahedron + cSpace + cLgShort[ lt_English ] +
                    cPeriod + HtmlExt + cDQuote + cAnr +
                    ViewUnit + AETAG;
      end;
      MyIndent := Chr( Ord( 'a' ) + Level - 1 ) ;
      Value := AChild.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
      Value := cNumber + cSpace + Value;
      Bubble := AChild.GetLibelle( lb_Official, TAH.SubstLang, st_undef, True );
      Bubble := cNumber + cSpace + Bubble;

      // Add first synonym and inconstant flag
      Plus := AChild.GetLibelle( lb_synonym, TAH.MainLang, st_ofd, True );
      if ( Plus <> cEmpty ) then
        Value := Trim( Value ) + cSemi + cSpace + Plus;
      if ( AChild.Inconstant ) then
        Value := cRol + Value + cRor;
      Plus := AChild.GetLibelle( lb_synonym, TAH.SubstLang, st_ofd, True );
      if ( Plus <> cEmpty ) then
        Bubble := Trim( Bubble ) + cSemi + cSpace + Plus;
      if ( AChild.Inconstant ) then
        Bubble := cRol + Bubble + cRor;

      // Add second synonym and inconstant flag
      Plus := AChild.GetLibelle( lb_synonym2, TAH.MainLang, st_od2, True );
      if ( Plus <> cEmpty ) then
        Value := Trim( Value ) + cSemi + cSpace + Plus;
      if ( AChild.Inconstant ) then
        Value := cRol + Value + cRor;
      Plus := AChild.GetLibelle( lb_synonym2, TAH.SubstLang, st_od2, True );
      if ( Plus <> cEmpty ) then
        Bubble := Trim( Bubble ) + cSemi + cSpace + Plus;
      if ( AChild.Inconstant ) then
        Bubble := cRol + Bubble + cRor;

      // Add third synonym and inconstant flag
      Plus := AChild.GetLibelle( lb_synonym3, TAH.MainLang, st_od3, True );
      if ( Plus <> cEmpty ) then
        Value := Trim( Value ) + cSemi + cSpace + Plus;
      if ( AChild.Inconstant ) then
        Value := cRol + Value + cRor;
      Plus := AChild.GetLibelle( lb_synonym3, TAH.SubstLang, st_od3, True );
      if ( Plus <> cEmpty ) then
        Bubble := Trim( Bubble ) + cSemi + cSpace + Plus;
      if ( AChild.Inconstant ) then
        Bubble := cRol + Bubble + cRor;

      // Display the generator for single line
      AnItem := tListItem.Create;
      AnItem.ViewUnit := ViewUnit;
      AnItem.ViewCode := ViewCode;
      AnItem.Indent := MyIndent;
      AnItem.TA98 := False;
      if ( not MultiLg ) then
      begin
        AnItem.Left := Value;
        AnItem.Right := Bubble;
      end else

      // Display generator in multiple columns
      begin
        AnItem.Left := Value;
        AnItem.Right := cNBSP;
        AnItem.Uni2 := cNumber + cSpace +
          AChild.GetLibelle( lb_Official, lt_English, st_undef, True );
        AnItem.Off2 := cNBSP;
        AnItem.Uni3 := cNumber + cSpace +
          AChild.GetLibelle( lb_Official, lt_French, st_undef, True );
        AnItem.Off3 := cNBSP;
        AnItem.Uni4 := cNumber + cSpace +
          AChild.GetLibelle( lb_Official, lt_Spanish, st_undef, True );
        AnItem.Off4 := cNBSP;
        AnItem.Uni5 := cNumber + cSpace +
          AChild.GetLibelle( lb_Official, lt_Russian, st_undef, True );
        AnItem.Off5 := cNBSP;
      end;
      AddLine( AnItem );
      Inc( TotPartial );

      // Display the entire partial partonomy of the generator
      PastTot := TotChildren;
      Self.MakePartListDescendants ( Actual.Generator, Level + 2, li_undef,
                                     True, IsExcel, TotChildren, TotPartial,
                                     CountByLg );
      TotPartial := TotPartial + TotChildren - PastTot;
      TotChildren := PastTot;
    end;
  end;

  // 2. Build the global partonomy
  // =============================
  // Extract the list of order position
  if ( Children = cEmpty ) then
    Exit;
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
    if ( AChild.TID = 38453 ) then
      IsRef := IsRef;

    // Handling of a possible reference
    IsRef := ( AChild.Reference > 0 );
    IsShort := True;
    if ( IsRef ) then
    begin
      AChildRef := TAH.GetEntityByTID( Child[ Inds ] );
      MyUnit := TAH.GetUnitByPos( AChild.Reference );
      AChild := nil;
      if ( MyUnit <> nil ) then
      begin
        if ( MyUnit.TypUnit = tt_pset ) then
          AChild := TAH.GetEntityByTID( MyUnit.Aset )
        else
          AChild := TAH.GetEntityByTID( MyUnit.Generator );
      end;
      // IsShort := False;
    end;

    // Prepare and display a single line
    if ( AChild <> nil ) then
    begin
      if ( MultiLg ) then
        MakeMultiLine( AChild, Level, CountByLg, IsRef, IsShort, IsExcel )
      else
        MakeSingleLine( AChild, Level, CountByLg, IsRef, IsShort, IsExcel );

      // Possibly stop the list and insert a pointer to sublist
      if ( IsRef ) then
        CurrType := GetTypeList( AChildRef.ListPart )
      else
        CurrType := GetTypeList( AChild.ListPart );
      StopList := ( ( CurrType <> li_undef ) and ( CurrType = AType ) );
      StopList := StopList or
                  ( ( CurrType = li_tax3 ) and ( AType = li_tax2 ) ) or
                  ( ( CurrType = li_tax2 ) and ( AType = li_tax1 ) ) or
                  ( ( CurrType = li_part3 ) and ( AType = li_part2 ) ) or
                  ( ( CurrType = li_part4 ) and ( AType = li_part3 ) ) or
                  ( ( CurrType = li_part2 ) and ( AType = li_part1 ) );
      if ( ( ( StopList ) and ( not IsRef ) ) or
           ( ( CurrType = li_Part3 ) and ( not IsRef ) ) or
           ( ( CurrType = li_Part4 ) and ( not IsRef ) ) ) then
      begin
        Value := AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                 cLgShort[ TAH.MainLang ] + cSlash + cTAH +
                 IntToStr( AChild.TID ) + cSpace + cTax +
                 cTypeListPage[ CurrType ] +
                 cSpace + cLgShort[ TAH.DisLanguage ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
        NbChildren := 1;
        AChild.GetNumberOfChildren( True, False, True, NbChildren, NbSpecific );
        Value := Value + cSpace + AChild.ListPos + cSpace +
                 IntToStr( NbChildren) + cSpace + 'entities';
        if ( CurrType <> li_tax4 ) then
          Inc( TotChildren, NbChildren )
        else
          Inc( TotChildren );
      end else
        Inc( TotChildren );

      // Call for next level
      if ( not StopList ) then
      begin
        if ( IsRef ) then
          Self.MakePartListDescendants( AChildRef.TID, Level + 1,
            li_undef, True, IsExcel, TotChildren, TotPartial, CountByLg )
        else
          Self.MakePartListDescendants( AChild.TID, Level + 1,
            Atype, True, IsExcel, TotChildren, TotPartial, CountByLg );
      end;
    end;
  end; // for Indx := 1 to NbTrueChildren
end; // _________________________________________________MakePartListDescendants

procedure          tListSection.MakeTaxListDescendants(
  TID:             Integer;
  Level:           Integer;
  IsInf:           Boolean;
  AncLink:         Boolean;
  IsExt:           Boolean;
  var TotChildren: Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTaxListDescendants
  * Make the list of children in the taxonomy for a list page *
  Description:
  This recursive procedure works on a taxonomy of the model of anatomy
  as present in the TAH database. It writes all or a part of the tree of
  descendants of the specified node in the taxonomy, depending on the
  number of descendants.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  Posit:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  NbTrueChildren:  Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  TrueTot:         Integer;
  ActDiv:          Integer;
  IsRef:           Boolean;
  StopList:        Boolean;
  Children:        String;
  SortList:        String;
  Value:           String;
  PageType:        String;
  MyColor:         tLanguage;
  Order:           Array[ 1 .. 200 ] of Integer;
  Child:           Array[ 1 .. 200 ] of Integer;
  Actual:          tEntity;
  AChild:          tEntity;
  CurrType:        tTypeListPage;
  AType:           tTypeListPage;
  CountByLg:       tCountLg;
begin
  // Initial stuff
  PageType := cEntity;
  if ( IsExt ) then
    PageType := cExtended;
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get children and their number
  Children := Actual.TaxCh;
  SortList := Actual.TaxPos;
  NbTrueChildren := Actual.NbTaxC;
  if Children = cEmpty then
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

  // Display FMA changes
  TrueTot := NbTrueChildren;
  if ( FMAChange ) then
    TrueTot := NbChildren;

  // Loop on all children
  ActDiv := 0;
  IsRef := False;
  for Indx := 1 to TrueTot do
  begin

    // Search next child according to sortlist
    Small := 1;
    AnOrder := Order[ Small];
    StopList := False;
    for Indy := 2 to TrueTot do
    begin
      if ( ( Indx <= NbTrueChildren ) and ( Indy > NbTrueChildren ) ) then
        Continue;
      if Order[ Indy ] < AnOrder then
      begin
        Small := Indy;
        AnOrder := Order[ Small];
      end;
    end; // for
    Inds := Small;
    Order[ Small ] := 10000;
    MyColor := lt_Latin;

    // Retrieve the child entity
    AChild := TAH.GetEntityByTID( Child[ Inds ] );
    Value := Actual.GetLibelle( lb_Official, TAH.MainLang, st_undef, True );
    AType := Self.TypeList;
    if ( AChild <> nil ) then
    begin
      if ( AChild.TetraTip = tp_int ) then
        MakeInterfaceLine( AChild, Level, CountByLg )
      else
        MakeSingleLine( AChild, Level, CountByLg );

      // Possibly stop the list and insert a pointer to sublist
      CurrType := GetTypeList( AChild.ListTax );
      StopList := ( ( CurrType <> li_undef ) and ( CurrType = AType ) );
      StopList := StopList or
                  ( ( CurrType = li_tax3 ) and ( AType = li_tax2 ) ) or
                  ( ( CurrType = li_tax2 ) and ( AType = li_tax1 ) ) or
                  ( ( CurrType = li_tax4 ) and ( AType = li_tax3 ) );
      if ( ( ( StopList ) and ( not IsRef ) ) or
           ( ( CurrType = li_tax3 ) and ( not IsRef ) ) or
           ( ( CurrType = li_tax4 ) and ( not IsRef ) ) ) then
      begin
        Value := AOTAG + cHrefEmpty + cRetroDir + cList + cSpace +
                 cLgShort[ TAH.SubstLang ] + cSlash + cTAH +
                 IntToStr( AChild.TID ) + cSpace + cTax +
                 cTypeListPage[ CurrType ] +
                 cSpace + cLgShort[ TAH.SubstLang ] +
                 cPeriod + HtmlExt + cDQuote + cAnr + Value + AETAG;
        NbChildren := 1;
        AChild.GetNumberOfChildren( True, False, True, NbChildren, NbSpecific );
        Value := Value + cSpace +
                 AChild.ListPos + cSpace +
                 IntToStr( NbChildren) + cSpace + 'entities';
        if ( CurrType <> li_tax4 ) then
          Inc( TotChildren, NbChildren )
        else
          Inc( TotChildren );
      end else
        Inc( TotChildren );
    end;

    // Call for next level
    if ( not StopList ) then
    begin
      if ( MyColor <> lt_German ) then
      begin
        Self.MakeTaxListDescendants( AChild.TID, Level + 1, IsInf,
          AncLink, IsExt, TotChildren );
      end;
    end;
  end; // for
end; // __________________________________________________MakeTaxListDescendants

procedure          tPartListSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tPartListSection.Build
  * Make a partonomy list section at any level *
  Description:
  This method builds a Partonomy List Page which is defined by the partonomy
  of a specified entity. In addition, a list of all notes belonging to any
  entity belonging to this partonomy on this page is displayed in increasing
  order of entity identifiers.</P>
  The presentation is made of the following columns:
  - The FMA unique identifier, when a match as been found between two entities
    in TA and FMA respectively, with hyperlink to a FMA website,
  - The TA98 icon when this entity is matching a TA98 entity, with TA98 code
    and official term in bubble,
  - The unique TID of the entity, with hyperlink to the related Entity Page,
  - The unique UID of the entity, with hyperlink to the related Unit Page,
  - The first language column, usually Latin,
  - The second language column, often English.</P>
  Each language columns in the list is displayed in the following way:
  - The official term, unexpanded, (or language equivalent)
  - The list of official synonyms, semicolumn separated,
  - Round parentheses for inconstant terms,
  - The FMA official term as a bubble, when a FMA link exists.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indz:            tLanguage;
  Indn:            Integer;
  TotNote:         Integer;
  TotChildren:     Integer;
  TotPartial:      Integer;
  TotItems:        Integer;
  DupTID:          Integer;
  ActTID:          Integer;
  LeftT:           Integer;
  RightT:          Integer;
  TooMuch:         Boolean;
  IsStop:          Boolean;
  IsDup:           Boolean;
  Percent:         String;
  cMiss:           String;
  LineText:        String;
  Actual:          tEntity;
  AnItem:          tListItem;
  MyNote:          NoteRec;
  AType:           tTypeListPage;
  NoteSection:     tListSection;
  CountByLg:       tCountLg;
  Lang:            tLanguage;
begin
  // Temporary business
  if ( LgValid ) then
  begin
    ValidateRU;
  end;

  // Initial stuff
  for Indz := lt_Latin to lt_Russian do
    CountByLg[ Indz ] := 0;
  Actual := Self.Entity;
  AType := Self.TypeList;
  if ( ( Actual <> nil ) and ( Actual.PartCh <> cEmpty ) ) then
  begin

    // Build the line of headers of columns
    AnItem := tListItem.Create;
    AnItem.ViewUnit := cOBold + cUID + cEBold;
    AnItem.ViewCode := cOBold + cTID + cEBold;
    AnItem.ViewFMA := cOBold + cFMA + cEBold;
    if ( ( not IsLarge ) or
         ( IsLarge and ( not MultiLg ) ) ) then
    begin
      if ( MultiLg ) then
      begin
        AnItem.Left := cOBold + 'Universal term' + cEBold;
        AnItem.Right := cOBold + 'Official term (when different)' + cEBold;
      end else
      begin
        case TAH.MainLang of
          lt_Latin: LeftT := reShortTermLA;
          lt_English: LeftT := reShortTermEN;
          lt_French: LeftT := reShortTermFR;
          lt_Spanish: LeftT := reShortTermES;
          lt_Russian: LeftT := reShortTermRU;
        end;
        case TAH.SubstLang of
          lt_Latin: RightT := reShortTermLA;
          lt_English: RightT := reShortTermEN;
          lt_French: RightT := reShortTermFR;
          lt_Spanish: RightT := reShortTermES;
          lt_Russian: RightT := reShortTermRU;
        end;
        AnItem.Left := cOBold + TAH.GetLabel( LeftT ) + cEBold;
        AnItem.Right := cOBold + TAH.GetLabel( RightT ) + cEBold;
      end;
    end else
    begin
      AnItem.Right := cOBold + TAH.GetLabel( reShortTermLA ) + cEBold;
      AnItem.Off2 := cOBold + TAH.GetLabel( reShortTermEN ) + cEBold;
      AnItem.Off3 := cOBold + TAH.GetLabel( reShortTermFR ) + cEBold;
      AnItem.Off4 := cOBold + TAH.GetLabel( reShortTermES ) + cEBold;
      AnItem.Off5 := cOBold + TAH.GetLabel( reShortTermRU ) + cEBold;
    end;
    AnItem.FBubble := bbShortOFF[ TAH.SubstLang, en ];
    AnItem.FMALib := bbShortOFF[ TAH.MainLang, en ];
    AddLine( AnItem );

    // Build the line for the top entity
    if ( MultiLg ) then
      Self.MakeMultiLine( Actual, 1, CountByLg, False, True )
    else
      Self.MakeSingleLine( Actual, 1, CountByLg, False, True );

    // Build all children of the partonomy
    TooMuch := False;
    IsStop := Self.TypeList <> li_part0;
    TotChildren := 1;
    TotPartial := 0;
    MakePartListDescendants( Actual.TID, 2, AType, IsStop, False, TotChildren,
                             TotPartial, CountByLg );

    // Display the number of items in the list
    TotItems := NbLine - 1;
    AnItem := tListItem.Create;
    AnItem.ViewCode := cEmpty;
    LineText := TAH.GetLabel( reLines, False );
    if ( MultiLg ) then
    begin
      AnItem.Right := IntToStr( TotItems ) + cSpace + LineText;
      AnItem.Left := cEmpty;
    end else
    begin
      AnItem.Left := IntToStr( TotItems ) + cSpace + LineText;
      AnItem.Right := cEmpty;
    end;
    AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
    AddLine( AnItem );

    // Display the missmatches to universal formula in multilist
    if ( ( IsLarge ) and ( not IsPub ) ) then
    begin
      cMiss := 'points';
      AnItem := tListItem.Create;
      AnItem.Right := IntToStr( CountByLg[ lt_Latin ] ) + cSpace + cMiss;
      AnItem.Off2 := IntToStr( CountByLg[ lt_English ] ) + cSpace + cMiss;
      AnItem.Off3 := IntToStr( CountByLg[ lt_French ] ) + cSpace + cMiss;
      AnItem.Off4 := IntToStr( CountByLg[ lt_Spanish ] ) + cSpace + cMiss;
      AnItem.Off5 := IntToStr( CountByLg[ lt_Russian ] ) + cSpace + cMiss;
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );

      // Display the percentage of missmatches
      AnItem := tListItem.Create;
      Percent := FloatToStrF( CountByLg[ lt_Latin ] * 100 / TotItems,
                              ffFixed, 4, 1 );
      AnItem.Right := Percent + cSpace + '%';
      Percent := FloatToStrF( CountByLg[ lt_English ] * 100 / TotItems,
                              ffFixed, 4, 1 );
      AnItem.Off2 := Percent + cSpace + '%';
      Percent := FloatToStrF( CountByLg[ lt_French ] * 100 / TotItems,
                              ffFixed, 4, 1 );
      AnItem.Off3 := Percent + cSpace + '%';
      Percent := FloatToStrF( CountByLg[ lt_Spanish ] * 100 / TotItems,
                              ffFixed, 4, 1 );
      AnItem.Off4 := Percent + cSpace + '%';
      Percent := FloatToStrF( CountByLg[ lt_Russian ] * 100 / TotItems,
                              ffFixed, 4, 1 );
      AnItem.Off5 := Percent + cSpace + '%';
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );
    end else
    if ( not IsPub ) then

    // Display the missmatches to universal formula in single list
    begin
      Lang := Actual.LgCurrent;
      {cMiss := 'penalty points';
      AnItem := tListItem.Create;
      Percent := FloatToStrF( CountByLg[ TAH.MainLang ]/10, ffFixed, 4, 1 );
      AnItem.Left := Percent + cSpace + cMiss;
      Percent := FloatToStrF( CountByLg[ TAH.SubstLang ]/10, ffFixed, 4, 1 );
      AnItem.Right := Percent + cSpace + cMiss;
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );}

      // Display the percentage of missmatches
      AnItem := tListItem.Create;
      Percent := FloatToStrF( 100 - CountByLg[ TAH.MainLang ] * 10 / TotItems,
                              ffFixed, 4, 1 );
      AnItem.Left := Percent + cSpace + '%';
      Percent := FloatToStrF( 100 - CountByLg[ TAH.SubstLang ] * 10 / TotItems,
                              ffFixed, 4, 1 );
      AnItem.Right := Percent + cSpace + '%';
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );
    end;

    // Display the total number of partial entities in the list
    if ( ( TotPartial > 0 ) and ( not IsPub ) ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Left := IntToStr( TotPartial ) + cSpace + 'partial items';
      AnItem.Right := cEmpty;
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );
    end;

    // Display the total number of entities in the list
    if ( ( TotChildren > 0 ) and ( TotPartial > 0 ) ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Left := IntToStr( TotChildren ) + cSpace + 'entities';
      AnItem.Right := cEmpty;
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );
    end;

    // Build the title of the list of footnotes
    NoteSection := Self.ComplSection;
    TotNote := Self.NbNote;
    if ( ( TotNote > 0 ) and ( not MultiLg ) ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewCode := cOBold + cUID + cEBold;
      AnItem.Left := cOBold + 'Libelle of note' + cEBold;
      NoteSection.AddLine( AnItem );

      // Loop on all notes
      for Indn := 0 to TotNote - 1 do
      begin
        // Retrieve the note
        MyNote := Self.GetNote( Indn );

        // Check for a duplicated note
        DupTID := MyNote.Dup;
        IsDup := DupTID > 0;
        ActTID := MyNote.TID;

        // Prepare the duplicate note
        if ( IsDup ) then
        begin
          AnItem := tListItem.Create;
          AnItem.ViewCode := IntToStr( DupTID );
          AnItem.Left := MyNote.Txt;
          NoteSection.AddLine( AnItem );
        end;

        // Prepare the text note
        AnItem := tListItem.Create;
        AnItem.ViewCode := IntToStr( ActTID );
        if ( IsDup ) then
          AnItem.Left := 'See note #' + cSpace + IntToStr( DupTID )
        else
          AnItem.Left := MyNote.Txt;
        NoteSection.AddLine( AnItem );
      end; // for
    end;
  end;
end; // __________________________________________________tPartListSection.Build

procedure          tPart98Section.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tPart98Section.Build
  * Make a TA98 partonomy list section at any level *
  Description:
  This method builds a TA98 Partonomy List Page which is defined by the
  partonomy of a specified entity. In addition, a list of all notes belonging
  to any entity belonging to this partonomy on this page is displayed in
  increasing order of entity identifiers.</P>
  The presentation is made of the following columns:
  - The FMA unique identifier, when a match as been found between two entities
    in TA and FMA respectively, with hyperlink to a FMA website,
  - The TA98 icon when this entity is matching a TA98 entity, with TA98 code
    and official term in bubble,
  - The unique TID of the entity, with hyperlink to the related Entity Page,
  - The unique UID of the entity, with hyperlink to the related Unit Page,
  - The first language column, usually Latin,
  - The second language column, often English.</P>
  Each language columns in the list is displayed in the following way:
  - The official term, unexpanded, (or language equivalent)
  - The list of official synonyms, semicolumn separated,
  - Round parentheses for inconstant terms,
  - The FMA official term as a bubble, when a FMA link exists.</P>

  The A3 lists by chapters of the entire TA98 terminology are the following:
  01 13111  9602    99
  02 11296   305   402   769   851   894  1027
  03 13126  1304  1372  1404  1433  1434  1510
  04 13112  1673  1730  1770  1835  1873  1971  2061  2175
  05  2276  2438  2460  2509  2526  2559  2594  2658  2727  2746
  06  2766  2823  2918  2929  2963
  07  3014
  08  3041  3104  3111  3139  3140
  09  3144  3232  3272  3355  3419
  10  3444  3448  3449
  11  3535  3543  3544  3553  3557  2764
  12 13151  3614  3726  3769  4115  4173  4286  4339  4419  4436  4480  4692
      4727  4775  4810  4845
  13  4861  4869 13152
  14  5062  5068
  15
  16
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indn:            Integer;
  TotNote:         Integer;
  TotChildren:     Integer;
  TotPartial:      Integer;
  TotItems:        Integer;
  DupTID:          Integer;
  ActTID:          Integer;
  NbDiv:           Integer;
  TooMuch:         Boolean;
  IsStop:          Boolean;
  IsDup:           Boolean;
  IsOpen:          Boolean;
  DivName:         String;
  LineText:        String;
  Actual:          tEntity;
  ADisplay:        tEntity;
  AnItem:          tListItem;
  MyNote:          NoteRec;
  AType:           tTypeListPage;
  NoteSection:     tListSection;
begin
  DivName := 'Child';
  NbDiv := 0;
  IsOpen := False;
  Actual := Self.Entity;
  AType := Self.TypeList;
  if ( ( Actual <> nil ) and
       ( ( Actual.Ch98 <> cEmpty ) or ( Actual.TID = 1433 ) or
         ( Actual.TID = 887 ) or ( Actual.TID = 3139 ) or
         ( Actual.TID = 3140 ) or ( Actual.TID = 3448 ) or
         ( Actual.TID = 3543 ) or ( Actual.TID = 2764 ) or
         ( Actual.TID = 13152 ) or ( Actual.TID = 6758 ) ) and
       ( TAH.DoTA98( Actual.Tetra ) ) ) then
  begin

    // Build the line of headers of columns
    if ( not TA98Short ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewUnit := cOBold + cUID + cEBold;
      AnItem.ViewCode := cOBold + cTID + cEBold;
      AnItem.ViewFMA := cOBold + cFMA + cEBold;
      AnItem.Left := cOBold + cShortOFF[ TAH.MainLang, en ] + cEBold;
      AnItem.Right := cOBold + cShortOFF[ TAH.SubstLang, en ] + cEBold;
      AnItem.FBubble := bbShortOFF[ TAH.SubstLang, en ];
      AnItem.FMALib := bbShortOFF[ TAH.MainLang, en ];
      AddLine( AnItem );
    end;

    // Build the line for the top entity
    ADisplay := TAH.GetTA98EntityByTID( Actual.TID );
    if ( ( Actual.TID <> 13111 ) ) then
      Self.MakeSingle98Line( ADisplay, 1, cEmpty, DivName, NbDiv, IsOpen,
      False, True );

    // Build all children of the partonomy
    TooMuch := False;
    IsStop := Self.TypeList <> li_part0;
    TotChildren := 1;
    TotPartial := 0;
    MakePart98Descendants( Actual.TID, 2, AType, IsStop, False, TotChildren,
                           TotPartial, DivName, NbDiv, IsOpen );

    // Display the number of items in the list
    if ( not TA98Short ) then
    begin
      TotItems := NbLine - 1;
      AnItem := TListItem.Create;
      AnItem.ViewCode := cEmpty;
      LineText := TAH.GetLabel( reLines, False );
      AnItem.Left := IntToStr( TotItems ) + cSpace + LineText;
      AnItem.Right := cEmpty;
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );
    end;

    // Display the total number of partial entities in the list
    if ( ( not TA98Short ) and ( TotPartial > 0 ) ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Left := IntToStr( TotPartial ) + cSpace + 'partial items';
      AnItem.Right := cEmpty;
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );
    end;

    // Display the total number of entities in the list
    if ( ( not TA98Short ) and ( TotChildren > 0 ) and ( TotPartial > 0 ) ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Left := IntToStr( TotChildren ) + cSpace + 'entities';
      AnItem.Right := cEmpty;
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );
    end;

    // Build the title of the list of footnotes
    NoteSection := Self.ComplSection;
    TotNote := Self.NbNote;
    if ( TotNote > 0 ) then
    begin
      AnItem := TListItem.Create;
      AnItem.ViewCode := cOBold + cUID + cEBold;
      AnItem.Left := cOBold + 'Libelle of note' + cEBold;
      NoteSection.AddLine( AnItem );

      // Loop on all notes
      for Indn := 0 to TotNote - 1 do
      begin
        // Retrieve the note
        MyNote := Self.GetNote( Indn );

        // Check for a duplicated note
        DupTID := MyNote.Dup;
        IsDup := DupTID > 0;
        ActTID := MyNote.TID;

        // Prepare the next note line
        AnItem := TListItem.Create;
        AnItem.ViewCode := IntToStr( ActTID );
        if ( IsDup ) then
          AnItem.Left := 'See note #' + cSpace + IntToStr( DupTID )
        else
          AnItem.Left := MyNote.Txt;
        NoteSection.AddLine( AnItem );
      end; // for on all notes
    end;
  end;
end; // ____________________________________________________tPart98Section.Build

procedure          tTaxListSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTaxListSection.Build
  * Make a taxonomy list at any level *
  Description:
  This method builds a taxonomy list page which is defined by the taxonomy
  of a specified entity at top of the list.</P>
  Depending on the starting top entity, selected at different levels from
  1 to 4, the size of the taxonomy is variable, becoming smaller with higher
  levels. In other words, the lower levels include the higher ones. Each time
  a higher level is encountered, it is made visible in the hierarchy with
  indication of the number of children. An hyperlink is also provided in order
  to directly open this level.</P>
  The taxonomy list includes the references (with hyperlink to FMA website) to
  the FMA unique identifier, when a strict correspondance exist between the
  TA and FMA entities. In addition, the FMA official term is also made
  available as a bubble.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indn:            Integer;
  NbDiv:           Integer;
  TotChildren:     Integer;
  TotItems:        Integer;
  TotNote:         Integer;
  ActTID:          Integer;
  DupTID:          Integer;
  LeftT:           Integer;
  RightT:          Integer;
  IsDup:           Boolean;
  TooMuch:         Boolean;
  IsExt:           Boolean;
  Actual:          tEntity;
  AnItem:          tListItem;
  MyNote:          NoteRec;
  NoteSection:     tListSection;
  CountByLg:       tCountLg;
begin
  Actual := Self.Entity;
  if ( ( Actual <> nil ) ) then
  begin

    // Build the line of headers of columns
    NbDiv := 2;
    AnItem := tListItem.Create;
    AnItem.ViewUnit := cOBold + cUID + cEBold;
    AnItem.ViewCode := cOBold + cTID + cEBold;
    AnItem.ViewFMA := cOBold + cFMAID + cEBold;
    case TAH.MainLang of
      lt_Latin: LeftT := reShortTermLA;
      lt_English: LeftT := reShortTermEN;
      lt_French: LeftT := reShortTermFR;
      lt_Spanish: LeftT := reShortTermES;
      lt_Russian: LeftT := reShortTermRU;
    end;
    case TAH.SubstLang of
      lt_Latin: RightT := reShortTermLA;
      lt_English: RightT := reShortTermEN;
      lt_French: RightT := reShortTermFR;
      lt_Spanish: RightT := reShortTermES;
      lt_Russian: RightT := reShortTermRU;
    end;
    AnItem.Left := cOBold + TAH.GetLabel( LeftT ) + cEBold;
    AnItem.Right := cOBold + TAH.GetLabel( RightT ) + cEBold;
    AnItem.Bubble := ltFMAEN;
    AnItem.Indent := 'a';
    AddLine( AnItem );

    // Build the line for the top entity
    Self.MakeSingleLine( Actual, 1, CountByLg );

    // Build all descendant lines of the taxonomy
    TooMuch := False;
    TotChildren := 1;
    IsExt := False;
    Self.MakeTaxListDescendants
      ( Actual.TID, 2, False, True, IsExt, TotChildren );

    // Display the number of children in the list
    TotItems := NbLine - 1;
    AnItem := tListItem.Create;
    AnItem.ViewCode := cEmpty;
    AnItem.Left := IntToStr( TotItems ) + cSpace + cItems;
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + 1 );
    AddLine( AnItem );

    // Display the total number of entities in the list
    if ( TotChildren > 0 ) and ( TotChildren <> TotItems ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Left := IntToStr( TotChildren ) + cSpace + cEntities;
      AnItem.Right := cEmpty;
      AnItem.Indent := Chr( Ord( 'a' ) + 1 );
      AddLine( AnItem );
    end;

    // Management of notes
    // Build the title of the list of footnotes
    NoteSection := Self.ComplSection;
    TotNote := Self.NbNote;
    if ( TotNote > 0 ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewCode := cOBold + cUID + cEBold;
      AnItem.Left := cOBold + 'Libelle of note' + cEBold;
      NoteSection.AddLine( AnItem );

      // Loop on all notes
      for Indn := 0 to TotNote - 1 do
      begin
        // Retrieve the note
        MyNote := Self.GetNote( Indn );

        // Check for a duplicated note
        DupTID := MyNote.Dup;
        IsDup := DupTID > 0;
        ActTID := MyNote.TID;

        // Prepare the next note line
        AnItem := tListItem.Create;
        AnItem.ViewCode := IntToStr( ActTID );
        if ( IsDup ) then
          AnItem.Left := 'See note #' + cSpace + IntToStr( DupTID )
        else
          AnItem.Left := MyNote.Txt;
        NoteSection.AddLine( AnItem );
      end; // for
    end;
  end;
end; // ___________________________________________________tTaxListSection.Build

procedure          tIntListSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tIntListSection.Build
  * Make a interface list at any level *
  Description:
  This method builds a interface list page which is defined by the taxonomy
  of a specified entity at top of the list.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indn:            Integer;
  TotChildren:     Integer;
  TotItems:        Integer;
  TotNote:         Integer;
  ActTID:          Integer;
  DupTID:          Integer;
  IsDup:           Boolean;
  TooMuch:         Boolean;
  IsExt:           Boolean;
  Actual:          tEntity;
  AnItem:          tListItem;
  MyNote:          NoteRec;
  NoteSection:     tListSection;
  CountByLg:       tCountLg;
begin
  Actual := Self.Entity;
  if ( ( Actual <> nil ) ) then
  begin

    // Build the two line of headers of columns
    AnItem := tListItem.Create;
    AnItem.ViewUnit := cOBold + cUID + cEBold;
    AnItem.Left := cOBold + 'Title of entity' + cEBold;
    AnItem.Right := cOBold + 'Title of entity (subsidiary language)' + cEBold;
    AnItem.Uni2 := TAH.GetLabel( reLibHeadTitle, True, lt_English );
    AnItem.Off2 := TAH.GetLabel( reLibHeadBubble, True, lt_English );
    AnItem.Uni3 := TAH.GetLabel( reLibHeadTitle, True, lt_French );
    AnItem.Off3 := TAH.GetLabel( reLibHeadBubble, True, lt_French );
    AnItem.Uni4 := TAH.GetLabel( reLibHeadTitle, True, lt_Spanish );
    AnItem.Off4 := TAH.GetLabel( reLibHeadBubble, True, lt_Spanish );
    AnItem.Uni5 := TAH.GetLabel( reLibHeadTitle, True, lt_Russian );
    AnItem.Off5 := TAH.GetLabel( reLibHeadBubble, True, lt_Russian );
    AnItem.Bubble := cEmpty;
    AnItem.Indent := 'a';
    AddLine( AnItem );

    // Build the line for the top entity
    Self.MakeInterfaceLine( Actual, 1, CountByLg );

    // Build all descendant lines of the taxonomy
    TooMuch := False;
    TotChildren := 1;
    IsExt := False;
    Self.MakeTaxListDescendants
      ( Actual.TID, 2, False, True, IsExt, TotChildren );

    // Display the number of children in the list
    TotItems := NbLine - 1;
    AnItem := tListItem.Create;
    AnItem.ViewCode := cEmpty;
    AnItem.Left := IntToStr( TotItems ) + cSpace + cItems;
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( 'a' ) + 1 );
    AddLine( AnItem );

    // Display the total number of entities in the list
    if ( TotChildren > 0 ) and ( TotChildren <> TotItems ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Left := IntToStr( TotChildren ) + cSpace + cEntities;
      AnItem.Right := cEmpty;
      AnItem.Indent := Chr( Ord( 'a' ) + 1 );
      AddLine( AnItem );
    end;
  end;
end; // ___________________________________________________tIntListSection.Build

procedure          tListSection.MakeSingleLine(
  Actual:          tEntity;
  Level:           Integer;
  var CountByLg:   tCountLg;
  IsRef:           Boolean;
  IsShort:         Boolean;
  IsExcel:         Boolean );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSingleLine
  * Make a single line for partonomy or taxonomy of List Page *
  Description:
  This procedure prepares a single line for the taxonomy or partonomy
  hierarchy and store it.</P>
  The following columns are present:
  - The FMA unique identifier, with hyperlink to the FME website,
  - The TA98 icon when the line corresponds to a TA98 entity, with the TA98
    11-digit code and the original TA98 term in a bubble,
  - The Entity unique identifier, with hyperlink to the Entity Page,
  - The Unit unique identifier, with hyperlink to the Unit Page,
  - The pair icon, indicating that the present entity is a pair, for taxonomy
    only,
  - The term in main language, usually Latin, with corresponding FMA term if
    it exist in a bubbsubsidiary language, any vernacular, (parameter SubstLang),
    with US variant in a bubble if English.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  UnivWeight:      array[ 1 .. 5 ] of Integer = ( 0, 2, 4, 8, 10 );
var
  Indx:            Integer;
  Indz:            Integer;
  Indn:            Integer;
  Indm:            Integer;
  Posit:           Integer;
  NbTerm:          Integer;
  NbNote:          Integer;
  MbNote:          Integer;
  TIDInit:         Integer;
  MyTID:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  NbLA:            Integer;
  NbLang:          Integer;
  Factor:          Integer;
  IsUSA:           Boolean;
  IsPaire:         Boolean;
  StopList:        Boolean;
  IsTax:           Boolean;
  IsBracket:       Boolean;
  IsFirst:         Boolean;
  IsSecond:        Boolean;
  ViewCode:        String;
  ViewUnit:        String;
  ViewFMA:         String;
  MyBubble:        String;
  OriLA:           String;
  FMALib:          String;
  RightTerm:       String;
  LeftTerm:        String;
  UKUSDiff:        String;
  USVal:           String;
  UKVal:           String;
  MyIndent:        String;
  ListType:        String;
  MySyn:           String;
  Eponym:          String;
  Children:        String;
  MyRef:           String;
  ListCode:        String;
  LangDir:         String;
  MySet:           tEntity;
  Gener:           tEntity;
  MyTetra:         tUnit;
  ATerm:           tSingle;
  AnItem:          tListItem;
  MyLink:          tLink;
  MyNote:          Array of NoteRec;
  MyOtherNote:     Array of NoteRec;
  MyType:          tNoteType;
  TheNote:         NoteRec;
  CurrType:        tTypeListPage;
  AType:           tTypeListPage;
  MySynType:       tSynType;
  MyCateg:         tSynType;
  MyEffective:     tSynType;
  FourList:        tFourList;
  TetraAlt:        tTetrahedron;
  SourceTerm:      tSynType;
begin
  IsBracket := Not IsExcel;
  if ( Actual <> nil ) then
  begin

    // Find the language directory
    LangDir := cLgShort[ TAH.MainLang ];
    if ( TAH.MainLang = lt_Latin) then
      LangDir := LangDir + cLgShort[ TAH.SubstLang ];
    LangDir := LangDir + cSlash;

    // Skip left and right entities
    MyLink := Actual.Link;
    if ( MyLink in [ pw_MemberL, pw_MemberR, pw_SMemberL, pw_SMemberR,
                     pw_IMemberL, pw_IMemberR, pw_TMemberL, pw_TMemberR ] ) then
      Exit;

    // Prepare the identifiers: FMA, Entity and Unit
    MyTetra := TAH.GetUnitByPos( Actual.Tetra );
    ViewCode := IntToStr( Actual.TID );
    ViewUnit := IntToStr( Actual.Tetra );

    // Make hyperlink to Entity Page on TID
    ViewCode := AOTAG + cHrefEmpty + cRetroDir2x + cDirEntity + LangDir +
                cTAH + ViewCode +
                cSpace + cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                cPeriod + HtmlExt + cDQuote + cAnr + ViewCode + AETAG;

    // Make hyperlink to Unit Page on UID for non taxonomic entities
    if ( ( MyTetra <> nil ) and ( MyTetra.TypUnit <> tt_tax ) ) then
    begin
      if ( not IsPub ) then
        ViewUnit := AOTAG + cHrefEmpty + cRetroDir2x + cDirUnit + LangDir +
                    cTAH + ViewUnit + cSpace + cUnit + cSpace +
                    cLgShort[ TAH.DisLanguage ] + cPeriod + HtmlExt +
                    cDQuote + cSpace +
                    cID + cEqual + ViewUnit + cAnr + ViewUnit + AETAG;
    end;

    // Prepare indentation
    MyIndent := Chr( Ord( cBaseIndent ) + Level - 1 );

    if ( Actual.TID = 30929 ) then
      OriLA := OriLA;

    // Prepare the left column term with main language
    LeftTerm := Actual.GetLibelle( lb_Official, TAH.MainLang,
                                   st_bas, IsShort );

    // Search for first synonym
    IsFirst := False;
    MySyn := Actual.GetLibelle( lb_synonym, TAH.MainLang, st_ofd, IsShort );
    if ( MySyn <> cEmpty ) then
    begin
      LeftTerm := LeftTerm + cSemi + cSpace + MySyn;
      IsFirst := True;
    end;

    // Search for second synonym
    IsSecond := False;
    if ( IsFirst ) then
    begin
      MySyn := Actual.GetLibelle( lb_synonym2, TAH.MainLang, st_od2, IsShort );
      if ( MySyn <> cEmpty ) then
      begin
        LeftTerm := LeftTerm + cSemi + cSpace + MySyn;
        IsSecond := True;
      end;
    end;

    // Search for third synonym
    if ( IsSecond ) then
    begin
      MySyn := Actual.GetLibelle( lb_synonym3, TAH.MainLang, st_od3, IsShort );
      if ( MySyn <> cEmpty ) then
        LeftTerm := LeftTerm + cSemi + cSpace + MySyn;
    end;

    // Calculate the universal factor for main language (irregular by default)
    Actual.LgCurrent := TAH.MainLang;
    NbLang := Actual.NbCurrent;
    SourceTerm := st_undef;
    for Indx := 0 to NbLang - 1 do
    begin
      MyCateg := Actual.CurrTerm[ Indx ].Category;
      MyEffective := Actual.CurrTerm[ Indx ].Effective;
      if ( MyCateg in cGroupMain ) then
      begin
        SourceTerm := MyEffective;
        Break;
      end;
    end; // for
    if ( SourceTerm in cGroupFormula ) then
      Factor := UnivWeight[ 1 ]
    else
    if ( SourceTerm in cGroupInherit ) then
      Factor := UnivWeight[ 2 ]
    else
    if ( SourceTerm in cGroupBase ) then
      Factor := UnivWeight[ 3 ]
    else
    if ( SourceTerm in cGroupManaged ) then
      Factor := UnivWeight[ 4 ]
    else
      Factor := UnivWeight[ 5 ];
    if ( Factor > 0 ) then
      Factor := Factor;
    Inc( CountByLg[ Actual.LgCurrent ], Factor );

    // Add the UK/US flag if present
    if ( TAH.MainLang = lt_English ) then
    begin
      Actual.LgCurrent := lt_English;
      Actual.Query := tSearch.Create( st_USA );
      Actual.SearchTerm;
      IsUSA := Actual.CurrSingle <> nil;
      Gener := nil;
      if ( MyTetra <> nil ) then
        Gener := TAH.GetEntityByTID( MyTetra.Generator );
      if ( Gener <> nil ) then
      begin
        Gener.LgCurrent := lt_English;
        Gener.Query := tSearch.Create( st_USA );
        Gener.SearchTerm;
        ATerm := Gener.CurrSingle;
        IsUSA := IsUSA or ( ATerm <> nil );
      end;
      if ( IsUSA and ( not IsExcel ) and ( ATerm <> nil ) ) then
      begin

        // Add the US text as bubble to left column, including synonyms
        if ( Gener <> nil ) then
        begin
          UKUSDiff := ATerm.Mandat;
          Posit := Pos( cSlash, UKUSDiff );
          UKVal := Copy( UKUSDiff, 1, Posit - 1 );
          USVal := Copy( UKUSDiff, Posit + 1, Length( UKUSDiff ) );
          MyBubble := Actual.GetLibelle( lb_Official, lt_English,
                                         st_undef, IsShort, False );
          Posit := Pos( UKVal, MyBubble );
          while ( Posit > 0 ) do
          begin
            MyBubble := Copy( MyBubble, 1, Posit - 1 ) + USVal +
                        Copy( MyBubble, Posit + Length( UKVal ),
                              Length( MyBubble ) );
            Posit := Pos( UKVal, MyBubble );
          end; // while
        end;
        LeftTerm := LeftTerm + cSpace + cUsa;
      end;
    end;

    // Prepare the bilateral flag for paired entities
    IsPaire := ( ( ( Actual.TetraTip = tp_GenPair ) and
                   ( Actual.NbTaxC = 2 ) ) or
                 ( ( Actual.TetraTip = tp_GenPSet ) and
                   ( Actual.NbTaxC = 0 ) ) );

    // Search for a possible sublevel
    AType := Self.TypeList;
    CurrType := li_undef;
    if ( AType in [ li_tax1, li_tax1f, li_tax2, li_tax2f,
                    li_tax3, li_tax3f, li_tax4 ] ) then
    begin
      IsTax := True;
      ListType := cTax;
      CurrType := GetTypeList( Actual.ListTax )
    end else
    if ( AType in [ li_part1, li_part0, li_part2, li_part2f,
                    li_part3, li_part3f, li_part4 ] ) then
    begin
      IsTax := False;
      ListType := cPart;
      CurrType := GetTypeList( Actual.ListPart );
    end;
    StopList := ( ( CurrType <> li_undef ) and
                  ( CurrType > AType ) and
                  ( Level > 1 ) );
    if ( ( AType <> li_tax2f ) and
         ( AType <> li_part2f ) and
         ( AType <> li_part3f ) ) then
    begin
      if ( CurrType > AType ) then
      begin
        StopList := ( StopList or ( CurrType in [ li_tax2, li_tax3, li_tax4,
                      li_part2, li_part3, li_part4 ] ) );
      end;
    end;

    // Presence of a sublevel: display number of children
    if ( StopList and ( not IsRef ) ) then
    begin
      NbChildren := 0;
      NbSpecific := 0;
      Children := TAH.GetLabel( reChildren, False, TAH.DisLanguage );
      Actual.GetNumberOfChildren( IsTax, False, False, NbChildren, NbSpecific );
      if ( not IsPub ) then
      begin
        LeftTerm := AOTAG + cHrefEmpty + cRetroDir2x + cDirPartList + LangDir +
                    cTAH + IntToStr( Actual.TID ) + cSpace +
                    cTypeListPage[ CurrType ] + cSpace +
                    cLgShort[ TAH.DisLanguage ] +
                    cPeriod + HtmlExt + cDQuote + cAnr + LeftTerm + AETAG;
        LeftTerm := cOBold + LeftTerm + cEBold + cSpace +
                    cTypeListPage[ CurrType ] + cSpace +
                    IntToStr( NbChildren ) + cSpace + Children;
      end;
    end;

    // Prepare the FMA identifier
    ViewFMA := cEmpty;
    if ( Actual.FID > 0 ) then
    begin
      ViewFMA := IntToStr( Actual.FID );
      ViewFMA := AOTAG + cHrefEmpty + FMABioportalUrl + BioportalQuest +
                 IntToStr( Actual.FID ) + BioportalPost + cDQuote + cAnr +
                 ViewFMA + AETAG;

      // Prepare the FMA term
      if ( Gener <> nil ) then
      begin
        Gener.LgCurrent := lt_English;
        Gener.Query := tSearch.Create( st_FMA );
        Gener.SearchTerm;
        ATerm := Gener.CurrSingle;
        FMALib := cEmpty;
        if ( ATerm <> nil ) then
          FMALib := ATerm.Mandat;
      end;
    end;

    // Prepare the TA98 original Latin term
    Actual.LgCurrent := lt_Latin;
    Actual.Query := tSearch.Create( st_Ori );
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    if ( ( ATerm = nil ) and ( MyTetra <> nil ) ) then
    begin
      if ( Actual.TetraTip = tp_pair ) then
        MySet := TAH.GetEntityByPos( MyTetra.Generator )
      else
        MySet := TAH.GetEntityByPos( MyTetra.ASet );
      if ( MySet <> nil ) then
      begin
        MySet.LgCurrent := lt_Latin;
        MySet.Query := tSearch.Create( st_Ori );
        MySet.SearchTerm;
        ATerm := MySet.CurrSingle;
      end;
    end;
    OriLA := cEmpty;
    if ( ATerm <> nil ) then
      OriLA := ATerm.Mandat;

    if ( Actual.TID = 30500 ) then
      OriLA := OriLA;

    // Prepare the right column term with substitutiuon language
    RightTerm := Actual.GetLibelle( lb_Official, TAH.SubstLang,
                                    st_undef, IsShort );

    // Search for first synonym
    IsFirst := False;
    MySyn := Actual.GetLibelle( lb_synonym, TAH.SubstLang, st_ofd, IsShort );
    if ( MySyn <> cEmpty ) then
    begin
      RightTerm := Trim( RightTerm ) + cSemi + cSpace + MySyn;
      IsFirst := True;
    end;

    // Search for second synonym
    IsSecond := False;
    if ( IsFirst ) then
    begin
      MySyn := Actual.GetLibelle( lb_synonym2, TAH.SubstLang, st_od2, IsShort );
      if ( MySyn <> cEmpty ) then
      begin
        RightTerm := Trim( RightTerm ) + cSemi + cSpace + MySyn;
        IsSecond := True;
      end;
    end;

    // Search for third synonym
    if ( IsSecond ) then
    begin
      MySyn := Actual.GetLibelle( lb_synonym3, TAH.SubstLang, st_od3, IsShort );
      if ( MySyn <> cEmpty ) then
        RightTerm := Trim( RightTerm ) + cSemi + cSpace + MySyn;
    end;

    // Calculate the universal factor for subsidiary language on main term
    Actual.LgCurrent := TAH.SubstLang;
    NbLang := Actual.NbCurrent;
    SourceTerm := st_undef;
    for Indx := 0 to NbLang - 1 do
    begin
      MyCateg := Actual.CurrTerm[ Indx ].Category;
      MyEffective := Actual.CurrTerm[ Indx ].Effective;
      if ( MyCateg in cGroupMain ) then
      begin
        SourceTerm := MyEffective;
        Break;
      end;
    end; // for
    if ( SourceTerm in cGroupFormula ) then
      Factor := UnivWeight[ 1 ]
    else
    if ( SourceTerm in cGroupInherit ) then
      Factor := UnivWeight[ 2 ]
    else
    if ( SourceTerm in cGroupBase ) then
      Factor := UnivWeight[ 3 ]
    else
    if ( SourceTerm in cGroupManaged ) then
      Factor := UnivWeight[ 4 ]
    else
      Factor := UnivWeight[ 5 ];
    if ( Factor > 0 ) then
      Factor := Factor;
    Inc( CountByLg[ Actual.LgCurrent ], Factor );

    // Add the UK/US flag if present (only for English as SubstLang)
    if ( TAH.SubstLang = lt_English ) then
    begin
      Actual.LgCurrent := lt_English;
      Actual.Query := tSearch.Create( st_USA );
      Actual.SearchTerm;
      IsUSA := Actual.CurrSingle <> nil;
      Gener := nil;
      if ( MyTetra <> nil ) then
        Gener := TAH.GetEntityByTID( MyTetra.Generator );
      if ( Gener <> nil ) then
      begin
        Gener.LgCurrent := lt_English;
        Gener.Query := tSearch.Create( st_USA );
        Gener.SearchTerm;
        ATerm := Gener.CurrSingle;
        IsUSA := IsUSA or ( ATerm <> nil );
      end;
      if ( IsUSA and ( not IsExcel ) and ( ATerm <> nil ) ) then
      begin

        // Add the US text as bubble to right column, including synonyms
        if ( Gener <> nil ) then
        begin
          UKUSDiff := ATerm.Mandat;
          Posit := Pos( cSlash, UKUSDiff );
          UKVal := Copy( UKUSDiff, 1, Posit - 1 );
          USVal := Copy( UKUSDiff, Posit + 1, Length( UKUSDiff ) );
          MyBubble := Actual.GetLibelle( lb_Official, lt_English,
                                         st_undef, IsShort, False );
          Posit := Pos( UKVal, MyBubble );
          while ( Posit > 0 ) do
          begin
            MyBubble := Copy( MyBubble, 1, Posit - 1 ) + USVal +
                        Copy( MyBubble, Posit + Length( UKVal ),
                              Length( MyBubble ) );
            Posit := Pos( UKVal, MyBubble );
          end; // while
        end;
        RightTerm := RightTerm + cSpace + cUsa;
      end;
    end;

    // Use bubble for eponym in Excel spreadsheet
    if ( IsExcel ) then
    begin
      Gener := TAH.GetEntityByTID( Actual.Tetra );
      if ( Gener <> nil ) then
      begin
        Gener.LgCurrent := TAH.SubstLang;
        Gener.Query := tSearch.Create( st_Epo );
        Gener.SearchTerm;
        ATerm := Gener.CurrSingle;
        MyBubble := cEmpty;
        if ( ATerm <> nil ) then
        begin
          Eponym := ATerm.Mandat;
          MyBubble := Eponym;
        end;
      end;
    end;

    // Management of inconstant flag
    if ( Actual.Inconstant ) then
    begin
      LeftTerm := cRol + LeftTerm + cRor;
      RightTerm := cRol + RightTerm + cRor;
    end;

    // Make the reference visible on each column
    if ( IsRef ) then
    begin
      if ( IsExcel ) then
      begin
        LeftTerm := '->' + CSpace + LeftTerm;
        RightTerm := '->' + CSpace + RightTerm;
      end else
      begin
        MyRef := cRefImg;
        if ( not IsPub ) then
        begin

          // Search for the partonomic list that owns the referenced entity
          TAH.GetPartListPosition( Actual.TID, FourList );
          ListCode := cEmpty;
          ListType := cEmpty;
          for Indx := 4 downto 2 do
          begin
            if ( FourList[ Indx ] > 0 ) then
            begin
              TetraAlt := TAH.GetTetrahedronByTID( FourList[ Indx ] );
              if ( TetraAlt.Main <> nil ) then
                ListCode := IntToStr( TetraAlt.Main.TID );
              if ( Indx = 4 ) then
                ListType := 'PartP4'
              else
              if ( Indx = 3 ) then
                ListType := 'PartP3'
              else
              if ( Indx = 2 ) then
                ListType := 'PartP4';
              Break;
            end;
          end; // for on partonomic sublists

          // Prepare the link to the list where is located the reference
          MyRef := AOTAG + cHrefEmpty + cRetroDir +
                   cList + cSpace + cLgShort[ TAH.MainLang ] + cSlash +
                   cTAH + ListCode + cSpace +
                   ListType + cSpace + cLgShort[ TAH.SubstLang ] +
                   cPeriod + chtm + cNumber + IntToStr( Actual.Tetra ) +
                   cDQuote + cAnr + MyRef + AETAG;
        end;

        // Adjust the terms in left and right columns
        LeftTerm := LeftTerm + cSpace + MyRef;
        RightTerm := RightTerm + cSpace + MyRef;
      end;
    end;

    // Search all the notes for the current entity
    NbNote := 0;
    SetLength( MyNote, 10 );
    if ( (TAH.Notes <> nil ) and
         ( TAH.Notes.GetNotes( Actual.Tetra, NbNote, MyNote ) ) ) then
    begin
      SetLength( MyNote, NbNote );

      // Select the scientific notes
      for Indn := 0 to NbNote - 1 do
      begin
        MyType := MyNote[ Indn ].Typ;
        if ( MyType = nt_Scientific ) then
        begin

          // Indirect adressing of a note
          TheNote := MyNote[ Indn ];
          if ( TheNote.Txt[ 1 ] = '!' ) then
          begin
            TIDInit := TheNote.TID;
            MyTID :=
              StrToInt( Copy( TheNote.Txt, 2, Length( TheNote.Txt ) ) );
            SetLength( MyOtherNote, 10 );
            TheNote.Dup := MyTID;
            if ( TAH.Notes.GetNotes( MyTID, MbNote, MyOtherNote ) ) then
            begin
              SetLength( MyOtherNote, MbNote );

              // Select the scientific notes
              for Indm := 0 to MbNote - 1 do
              begin
                MyType := MyOtherNote[ Indm ].Typ;
                if ( MyType = nt_Scientific ) then
                begin
                  TheNote := MyOtherNote[ Indm ];
                  TheNote.TID := TIDInit;
                  TheNote.Dup := MyTID;
                  Break;
                end;
              end; // for
            end;
          end;

          // Store the note
          if ( TheNote.Txt[ 1 ] <> '!' ) then
          begin
            ViewUnit := ViewUnit + cIsNote;
            AddNote( TheNote );
          end;
        end;
      end;
    end;

    // Store the line
    AnItem := tListItem.Create;
    AnItem.ViewCode := ViewCode;
    AnItem.ViewUnit := ViewUnit;
    AnItem.ViewFMA := ViewFMA;
    AnItem.Left := LeftTerm;
    AnItem.Right := RightTerm;
    AnItem.Bubble := MyBubble;
    AnItem.Indent := MyIndent;
    AnItem.TA98Code := Actual.Cod98;
    AnItem.OriLA := OriLA;
    AnItem.FMALib := FMALib;
    AnItem.TA98 := Actual.Tetra <= Tot98;
    AnItem.FTAPlus := False;
    if ( MyTetra <> nil ) then
      AnItem.FTAPlus := MyTetra.Mandat;
    AnItem.IsPaire := IsPaire;
    AddLine( AnItem );
  end;
end; // __________________________________________________________MakeSingleLine

procedure          tListSection.MakeInterfaceLine(
  Actual:          tEntity;
  Level:           Integer;
  var CountByLg:   tCountLg;
  IsRef:           Boolean;
  IsShort:         Boolean;
  IsExcel:         Boolean );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeInterfaceLine
  * Make a interface line for an Interface Page *
  Description:
  This procedure prepares a interface line for the taxonomy
  hierarchy and store it.</P>
  The following columns are present:
  - The FMA unique identifier, with hyperlink to the FME website,
  - The TA98 icon when the line corresponds to a TA98 entity, with the TA98
    11-digit code and the original TA98 term in a bubble,
  - The Entity unique identifier, with hyperlink to the Entity Page,
  - The Unit unique identifier, with hyperlink to the Unit Page,
  - The pair icon, indicating that the present entity is a pair, for taxonomy
    only,
  - The term in main language, usually Latin, with corresponding FMA term if
    it exist in a bubbsubsidiary language, any vernacular, (parameter SubstLang),
    with US variant in a bubble if English.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  UnivWeight:      array[ 1 .. 5 ] of Integer = ( 0, 2, 4, 8, 10 );
var
  Indx:            Integer;
  Indz:            Integer;
  Indl:            tLanguage;
  Indn:            Integer;
  Indm:            Integer;
  Posit:           Integer;
  NbTerm:          Integer;
  NbNote:          Integer;
  MbNote:          Integer;
  TIDInit:         Integer;
  MyTID:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  NbLA:            Integer;
  NbLang:          Integer;
  Factor:          Integer;
  IsUSA:           Boolean;
  IsPaire:         Boolean;
  StopList:        Boolean;
  IsTax:           Boolean;
  IsBracket:       Boolean;
  IsFirst:         Boolean;
  IsSecond:        Boolean;
  ViewCode:        String;
  ViewUnit:        String;
  ViewFMA:         String;
  MyBubble:        String;
  OriLA:           String;
  FMALib:          String;
  RightTerm:       String;
  LeftTerm:        String;
  Uni2:            String;
  Off2:            String;
  Uni3:            String;
  Off3:            String;
  Uni4:            String;
  Off4:            String;
  Uni5:            String;
  Off5:            String;
  USVal:           String;
  UKVal:           String;
  UKUSDiff:        String;
  MyIndent:        String;
  ListType:        String;
  MySyn:           String;
  Eponym:          String;
  Children:        String;
  MyRef:           String;
  ListCode:        String;
  MySet:           tEntity;
  Gener:           tEntity;
  MyTetra:         tUnit;
  ATerm:           tSingle;
  AnItem:          tListItem;
  MyLink:          tLink;
  MyNote:          Array of NoteRec;
  MyOtherNote:     Array of NoteRec;
  MyType:          tNoteType;
  TheNote:         NoteRec;
  CurrType:        tTypeListPage;
  AType:           tTypeListPage;
  Query:           tSearch;
  MySynType:       tSynType;
  MyCateg:         tSynType;
  MyEffective:     tSynType;
  FourList:        tFourList;
  TetraAlt:        tTetrahedron;
  SourceTerm:      tSynType;
begin
  if ( Actual <> nil ) then
  begin

    // Prepare the unit identifier
    MyTetra := TAH.GetUnitByPos( Actual.Tetra );
    ViewUnit := IntToStr( Actual.Tetra );

    // Prepare indentation
    MyIndent := Chr( Ord( cBaseIndent ) + Level - 1 );

    if ( Actual.TID = 12613 ) then
      OriLA := OriLA;

    // Prepare the left and right column term with main language
    LeftTerm := Actual.GetLibelle( lb_Title, lt_Latin, st_bas, IsShort );
    RightTerm := Actual.GetLibelle( lb_Title, lt_English, st_bas, IsShort );

    // Prepare the libelles and bubbles for interface languages
    for Indl := lt_English to lt_Russian do
    begin
      case Indl of
        lt_English:
          begin
            Uni2 := Actual.GetLibelle( lb_Text, Indl, st_bas, IsShort );
            Off2 := Actual.GetLibelle( lb_Bubble, Indl, st_bas, IsShort );
          end;
        lt_French:
          begin
            Uni3 := Actual.GetLibelle( lb_Text, Indl, st_bas, IsShort );
            Off3 := Actual.GetLibelle( lb_Bubble, Indl, st_bas, IsShort );
          end;
        lt_Spanish:
          begin
            Uni4 := Actual.GetLibelle( lb_Text, Indl, st_bas, IsShort );
            Off4 := Actual.GetLibelle( lb_Bubble, Indl, st_bas, IsShort );
          end;
        lt_Russian:
          begin
            Uni5 := Actual.GetLibelle( lb_Text, Indl, st_bas, IsShort );
            Off5 := Actual.GetLibelle( lb_Bubble, Indl, st_bas, IsShort );
          end;
      end;
    end; // for on all interface languages

    // Store the line
    AnItem := tListItem.Create;
    AnItem.ViewUnit := ViewUnit;
    AnItem.Left := LeftTerm;
    AnItem.Right := RightTerm;
    AnItem.Left := LeftTerm;
    AnItem.Uni2 := Uni2;
    AnItem.Off2 := Off2;
    AnItem.Uni3 := Uni3;
    AnItem.Off3 := Off3;
    AnItem.Uni4 := Uni4;
    AnItem.Off4 := Off4;
    AnItem.Uni5 := Uni5;
    AnItem.Off5 := Off5;
    AnItem.Indent := MyIndent;
    AddLine( AnItem );
  end;
end; // _______________________________________________________MakeInterfaceLine

procedure          tListSection.MakeMultiLine(
  Actual:          tEntity;
  Level:           Integer;
  var CountByLg:   tCountLg;
  IsRef:           Boolean;
  IsShort:         Boolean;
  IsExcel:         Boolean );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeMultiLine
  * Make a multilanguage line for partonomy of List Page *
  Description:
  This procedure prepares a multilanguage line for the partonomy
  hierarchy and store it.</P>
  The following columns are present:
  - The FMA unique identifier, with hyperlink to the FME website,
  - The TA98 icon when the line corresponds to a TA98 entity, with the TA98
    11-digit code and the original TA98 term in a bubble,
  - The Entity unique identifier, with hyperlink to the Entity Page,
  - The Unit unique identifier, with hyperlink to the Unit Page,
  - The pair icon, indicating that the present entity is a pair, for taxonomy
    only,
  - The universal term in all languages, with corresponding FMA term if
    it exist in a bubble (parameter MainLang),
  - The official term in all languages if different from the universal term.</P>
  Synonyms are presently not considered.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsPaire:         Boolean;
  IsBracket:       Boolean;
  ViewCode:        String;
  ViewUnit:        String;
  ViewFMA:         String;
  OriLA:           String;
  FMALib:          String;
  OffTerm:         String;
  UniTerm:         String;
  MyIndent:        String;
  MySet:           tEntity;
  Gener:           tEntity;
  MyTetra:         tUnit;
  ATerm:           tSingle;
  AnItem:          tListItem;
  MyLink:          tLink;
  MyLang:          tLanguage;
begin
  IsBracket := Not IsExcel;
  if ( Actual <> nil ) then
  begin

    // Skip left and right entities
    MyLink := Actual.Link;
    if ( MyLink in [ pw_MemberL, pw_MemberR, pw_SMemberL, pw_SMemberR,
                     pw_IMemberL, pw_IMemberR, pw_TMemberL, pw_TMemberR ] ) then
      Exit;

    // Prepare the identifiers: FMA, Entity and Unit
    MyTetra := TAH.GetUnitByPos( Actual.Tetra );
    ViewCode := IntToStr( Actual.TID );
    ViewUnit := IntToStr( Actual.Tetra );

    // Make hyperlink to Entity Page on TID
    ViewCode := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
                cLgShort[ TAH.SubstLang ] + cLgShort[ TAH.MainLang ] +
                cSlash + cTAH + ViewCode +
                cSpace + cEntity + cSpace + cLgShort[ TAH.DisLanguage ] +
                cPeriod + HtmlExt + cDQuote + cAnr + ViewCode + AETAG;

    // Make hyperlink to Unit Page on UID for non taxonomic entities
    if ( ( MyTetra <> nil ) and ( MyTetra.TypUnit <> tt_tax ) ) then
    begin
      ViewUnit := AOTAG + cHrefEmpty +cRetroDir + cTetrahedron + cSpace +
                  cLgShort[ TAH.MainLang ] + cLgShort[ TAH.SubstLang ] +
                  cSlash + cTAH + ViewUnit +
                  cSpace + cTetrahedron + cSpace + cLgShort[ lt_English ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + ViewUnit + AETAG;
    end;

    // Prepare indentation
    MyIndent := Chr( Ord( cBaseIndent ) + Level - 1 );
    if ( Actual.TID = 3968 ) then
      Level := Level;

    // Loop on all languages
    AnItem := TListItem.Create;
    for MyLang := lt_Latin to lt_Russian do
    begin

      // Retrieve the universal and official terms
      OffTerm := Actual.GetLibelle( lb_Official, MyLang, st_undef, IsShort );
      UniTerm := Actual.GetLibelle( lb_Universal, MyLang, st_undef, IsShort );

      // Make the official term empty if equal to the universal time
      if ( OffTerm = UniTerm ) then
      begin
        OffTerm := cNBSP;
      end else
      begin
        if ( not IsRef ) then
          Inc( CountByLg[ MyLang ] );
      end;

      // Make the reference visible on each column
      if ( IsRef ) then
      begin
        if ( IsExcel ) then
        begin
          if ( OffTerm <> cNBSP ) then
            OffTerm := '->' + CSpace + OffTerm;
          UniTerm := '->' + CSpace + UniTerm;
        end else
        begin
          if ( OffTerm <> cNBSP ) then
            OffTerm := OffTerm + cSpace + cRefImg;
          UniTerm := UniTerm + cSpace + cRefImg;
        end;
      end;

      // Store the language terms
      if ( MyLang = lt_Latin ) then
      begin
        AnItem.Left := UniTerm;
        AnItem.Right := OffTerm;
      end else
      if ( MyLang = lt_English ) then
      begin
        AnItem.Uni2 := UniTerm;
        AnItem.Off2 := OffTerm;
      end else
      if ( MyLang = lt_French ) then
      begin
        AnItem.Uni3 := UniTerm;
        AnItem.Off3 := OffTerm;
      end else
      if ( MyLang = lt_Spanish ) then
      begin
        AnItem.Uni4 := UniTerm;
        AnItem.Off4 := OffTerm;
      end else
      if ( MyLang = lt_Russian ) then
      begin
        AnItem.Uni5 := UniTerm;
        AnItem.Off5 := OffTerm;
      end;
    end;
  end; // for on all 5 languages

  // Prepare parameters independant of language
  // Prepare the bilateral flag for paired entities
  IsPaire := ( ( Actual.TetraTip = tp_GenPair ) and
               ( Actual.NbTaxC = 2 ) );

  // Prepare the FMA identifier
  ViewFMA := cEmpty;
  if ( Actual.FID > 0 ) then
   begin
     ViewFMA := IntToStr( Actual.FID );
     ViewFMA := AOTAG + cHrefEmpty + FMEBaseUrl + cQuest + cFmaID +
                cEqual + IntToStr( Actual.FID ) + cDQuote + cAnr +
                ViewFMA + AETAG;

     // Prepare the FMA term
     Gener := TAH.GetEntityByTID( Actual.Tetra );
     if ( Gener <> nil ) then
     begin
       Gener.LgCurrent := lt_English;
       Gener.Query := TSearch.Create( st_FMA );
       Gener.SearchTerm;
       ATerm := Gener.CurrSingle;
       FMALib := cEmpty;
       if ( ATerm <> nil ) then
         FMALib := ATerm.Mandat;
     end;
   end;

   // Prepare the TA98 original Latin term
   Actual.LgCurrent := lt_Latin;
   Actual.Query := tSearch.Create( st_Ori );
   Actual.SearchTerm;
   ATerm := Actual.CurrSingle;
   if ( ( ATerm = nil ) and ( MyTetra <> nil ) ) then
   begin
     if ( Actual.TetraTip = tp_pair ) then
       MySet := TAH.GetEntityByPos( MyTetra.Generator )
     else
       MySet := TAH.GetEntityByPos( MyTetra.ASet );
     if ( MySet <> nil ) then
     begin
       MySet.LgCurrent := lt_Latin;
       MySet.Query := tSearch.Create( st_Ori );
       MySet.SearchTerm;
       ATerm := MySet.CurrSingle;
     end;
   end;
   OriLA := cEmpty;
   if ( ATerm <> nil ) then
     OriLA := ATerm.Mandat;

  // Finalized the multilanguage line
  AnItem.ViewCode := ViewCode;
  AnItem.ViewUnit := ViewUnit;
  AnItem.ViewFMA := ViewFMA;
  AnItem.Indent := MyIndent;
  AnItem.FTAPlus := False;
  AnItem.OriLA := OriLA;
  AnItem.FMALib := FMALib;
  AnItem.IsPaire := IsPaire;
  AnItem.TA98Code := Actual.Cod98;
  AnItem.TA98 := Actual.Tetra <= Tot98;
  if ( MyTetra <> nil ) then
    AnItem.FTAPlus := MyTetra.Mandat;
  AddLine( AnItem );
end; // ___________________________________________________________MakeMultiLine

procedure          tListSection.MakeSingle98Line(
  Actual:          tEntity;
  Level:           Integer;
  Child98:         String;
  var DivName:     String;
  var NbDiv:       Integer;
  var IsOpen:      Boolean;
  IsRef:           Boolean;
  IsShort:         Boolean;
  IsExcel:         Boolean );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeSingle98Line
  * Make a single TA98 line for partonomy of List Page *
  Description:
  This procedure prepares a single TA98 line for partonomy hierarchy and store
  it.</P>
  The following columns are present:
  - The FMA unique identifier, with hyperlink to the FME website,
  - The TA98 icon when the line corresponds to a TA98 entity, with the TA98
    11-digit code and the original TA98 term in a bubble,
  - The Entity unique identifier, with hyperlink to the Entity Page,
  - The Unit unique identifier, with hyperlink to the Unit Page,
  - The pair icon, indicating that the present entity is a pair, for taxonomy
    only,
  - The term in first language, usually Latin, with corresponding FMA term if
    it exist in a bubble (parameter MainLang),
  - The term in second language, any vernacular, (parameter SubstLang),
    with US variant in a bubble if English.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indz:            Integer;
  Indn:            Integer;
  Indm:            Integer;
  Posit:           Integer;
  NbTerm:          Integer;
  NbNote:          Integer;
  MbNote:          Integer;
  TIDInit:         Integer;
  MyTID:           Integer;
  NbChildren:      Integer;
  NbSpecific:      Integer;
  TIDPlus:         Integer;
  MyPos:           Integer;
  IsUSA:           Boolean;
  IsPaire:         Boolean;
  StopList:        Boolean;
  IsTax:           Boolean;
  IsBracket:       Boolean;
  IsFirst:         Boolean;
  IsSecond:        Boolean;
  IsToggle:        Boolean;
  IsTogglePlus:    Boolean;
  ViewCode:        String;
  ViewUnit:        String;
  ViewFMA:         String;
  MyBubble:        String;
  OriLA:           String;
  FMALib:          String;
  RightTerm:       String;
  LeftTerm:        String;
  UKUSDiff:        String;
  USVal:           String;
  UKVal:           String;
  MyIndent:        String;
  MyIndentPlus:    String;
  ListType:        String;
  MySyn:           String;
  Eponym:          String;
  Toggle:          String;
  ChildrenPlus:    String;
  MyTA98Code:      String;
  MySet:           tEntity;
  Gener:           tEntity;
  ActualPlus:      tEntity;
  MyTetra:         tUnit;
  ATerm:           tSingle;
  AnItem:          tListItem;
  MyLink:          tLink;
  MyNote:          Array of NoteRec;
  MyOtherNote:     Array of NoteRec;
  MyType:          tNoteType;
  TheNote:         NoteRec;
  CurrType:        tTypeListPage;
  AType:           tTypeListPage;
  MySynType:       tSynType;
begin

  // Retrieve actual entity for duplicates
  MyIndent := cLevel[ Actual.Level ];
  if ( ( Actual <> nil ) and ( Actual.TetraTip = tp_dup ) ) then
  begin
    Actual := TAH.GetEntityByTID( Actual.Reference );
  end;

  IsBracket := Not IsExcel;
  if ( Actual <> nil ) then
  begin

    // Skip left and right entities
    MyLink := Actual.Link;
    if ( MyLink in [ pw_MemberL, pw_MemberR, pw_SMemberL, pw_SMemberR,
                     pw_IMemberL, pw_IMemberR, pw_TMemberL, pw_TMemberR ] ) then
      Exit;

    // Prepare the identifiers: FMA, Entity and Unit
    MyTetra := TAH.GetUnitByPos( Actual.Tetra );
    ViewCode := IntToStr( Actual.TID );
    if ( Actual.TID = 25633 ) then
      ViewCode := cEmpty;
    if ( Actual.TID = 11296 ) then
      ViewCode := cEmpty;
    if ( Actual.TID = 13126 ) then
      ViewCode := cEmpty;
    if ( Actual.TID = 13112 ) then
      ViewCode := cEmpty;
    if ( Actual.TID = 13151 ) then
      ViewCode := cEmpty;
    if ( Actual.TID = 13613 ) then
      ViewCode := cEmpty;

    // Make hyperlink to Entity Page on TID
    if ( TA98Short ) then
    begin
      MyTA98Code := Copy( Actual.Cod98, 2, 12 );
      if ( Actual.Sexe <> sx_undef ) then
        MyTA98Code := MyTA98Code + cSexe[ Actual.Sexe ];
      ViewCode := AOTAG + cHrefEmpty +
                  cTA98Tree + cSlash +
                  cEntity98 + cSpace + cLgShort[ lt_English ] + cSlash +
                  MyTA98Code + cSpace + cEntity98 + cSpace +
                  cLgShort[ lt_English ] +
                  cPeriod + HtmlExt + cDQuote + cSpace +
                  cTarget + cEqual + cDQuote + cUBlank + cDQuote +
                  cAnr + ViewCode + AETAG;
    end else
    begin
      ViewCode := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
                  cLgShort[ lt_English ] + cSlash + cTAH + ViewCode +
                  cSpace + cEntity + cSpace + cLgShort[ lt_English ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + ViewCode + AETAG;
    end;

    // Prepare indentation according to TA98 original setup
    Actual.Level := lv_undef;
    IsToggle := ( MyIndent = '4' ) or ( MyIndent = '5' ) or
                ( MyIndent = '6' ) or ( MyIndent = '7' ) or
                ( MyIndent = '2' ) or ( MyIndent = '3' );

    // Discard toggle button if no child or if the child has a toggle button
    IsTogglePlus := False;
    ChildrenPlus := Actual.Ch98;
    if ( Child98 <> cEmpty ) then
      ChildrenPlus := Child98;
    if ( ChildrenPlus <> cEmpty ) then
    begin
      MyPos := Pos( cSemi, ChildrenPlus );
      if ( MyPos > 0 ) then
        TIDPlus := StrToInt( Copy( ChildrenPlus, 1, MyPos - 1 ) )
      else
        TIDPlus := StrToInt( ChildrenPlus );
      ActualPlus := nil;
      if ( TIDPlus > 0 ) then
        ActualPlus := TAH.GetTA98EntityByTID( TIDPlus );
      if ( ActualPlus <> nil ) then
      begin
        MyIndentPlus := cLevel[ ActualPlus.Level ];
        IsTogglePlus := ( MyIndentPlus = '4' ) or ( MyIndentPlus = '5' ) or
                        ( MyIndentPlus = '6' ) or ( MyIndentPlus = '7' );
      end;
    end;

    // Close a possibly open preceeding section
    if ( ( IsOpen ) and ( IsToggle ) ) then
    begin
      AnItem := TListItem.Create;
      AnItem.ItemType := tt_MakeEDiv;
      AnItem.Bubble := DivName + IntToStr( NbDiv );
      AddLine( AnItem );
      Inc( NbDiv );
      IsOpen := False;
    end;

    // Make a blank toggle
    if ( ( ( IsToggle ) and
         ( Actual.Ch98 = cEmpty ) and
         ( Child98 = cEmpty ) ) or
         ( IsToggle and IsTogglePlus ) ) then
    begin
      Toggle := IMGOTAG + 'src' + cEqual + cDQuote + 'empty.jpg' + cDQuote +
                cSlash + cAnr;
      IsToggle := False;
    end;

    // Prepare a toggle button on level 7
    if ( IsToggle ) then
    begin
      Toggle := MakeToggle( DivName + IntToStr( NbDiv ) );
      IsOpen := True;
    end;

    // Prepare the left column term with main language
    Actual.LgCurrent := TAH.MainLang;
    Actual.Query := tSearch.Create( st_Ori );
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    LeftTerm := '---';
    if ( ATerm <> nil ) then
      LeftTerm := ATerm.Mandat;

    // Add possible synonyms for left term
    Gener := TAH.GetEntityByTID( Actual.Generator );
    if ( Gener = nil ) then
      Gener := Actual;

    // Search for first TA98 synonym
    Actual.Query := tSearch.Create( st_Alt );
    Actual.Query.SynPos := 0;
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    IsFirst := False;
    IsSecond := False;
    if ( ATerm <> nil ) then
    begin
      MySyn := Aterm.Mandat;
      LeftTerm := LeftTerm + cSemi + cSpace + MySyn;
      IsFirst := True;
    end;

    // Search for second synonym
    {if ( IsFirst ) then
    begin
      Query := TSearch.Create( Actual, st_Of2, TAH.MainLang );
      Query.SynPos := 0;
      Query.SearchTerm;
      ATerm := Query.Single;
      if ( ATerm <> nil ) then
      begin
        MySyn := Aterm.Mandat;
        if ( not IsShort ) then
          MySyn := MySyn + ATerm.Option;
        if ( ( ATerm.Bracket <> cEmpty ) and IsBracket ) then
          MySyn := MySyn + cSpace + ATerm.Bracket;
        if ( ATerm.BuildFrom = bd_model ) then
          MySyn := MySyn + cSpace + cUniversal;
        LeftTerm := LeftTerm + cSemi + cSpace + MySyn;
        IsSecond := True;
      end;
    end;

    // Search for third synonym
    if ( IsSecond ) then
    begin
      Query := TSearch.Create( Actual, st_Of3, TAH.MainLang );
      Query.SynPos := 0;
      Query.SearchTerm;
      ATerm := Query.Single;
      if ( ATerm <> nil ) then
      begin
        MySyn := Aterm.Mandat;
        if ( not IsShort ) then
          MySyn := MySyn + ATerm.Option;
        if ( ( ATerm.Bracket <> cEmpty ) and IsBracket ) then
          MySyn := MySyn + cSpace + ATerm.Bracket;
        if ( ATerm.BuildFrom = bd_model ) then
          MySyn := MySyn + cSpace + cUniversal;
        LeftTerm := LeftTerm + cSemi + cSpace + MySyn;
      end;
    end;}

    // Add a possible gender-specific sign
    if ( Actual.Sexe = sx_male ) then
      LeftTerm := LeftTerm + cSpace + cMale
    else
    if ( Actual.Sexe = sx_female ) then
      LeftTerm := LeftTerm + cSpace + cFemale;

    // Prepare the bilateral flag for paired entities
    IsPaire := ( ( Actual.TetraTip = tp_GenPair ) and
                 ( Actual.NbTaxC = 2 ) );

    // Search for a possible sublevel
    AType := Self.TypeList;
    IsTax := False;
    CurrType := li_undef;
    if ( AType in [ li_tax1, li_tax1f, li_tax2, li_tax2f,
                    li_tax3, li_tax4 ] ) then
    begin
      IsTax := True;
      ListType := cTax;
      CurrType := GetTypeList( Actual.ListTax )
    end else
    if ( AType in [ li_part1, li_part0, li_part2, li_part2f,
                    li_part3, li_part4 ] ) then
    begin
      IsTax := False;
      ListType := cPart98;
      CurrType := GetTypeList( Actual.ListPart );
    end;
    StopList := ( ( CurrType <> li_undef ) and
                  ( CurrType > AType ) and
                  ( Level > 1 ) );
    if ( ( AType <> li_tax2f ) and ( AType <> li_part2f ) ) then
    begin
      if ( CurrType > AType ) then
      begin
        StopList := ( StopList or ( CurrType in [ li_tax2, li_tax3, li_tax4,
                      li_part2, li_part3, li_part4 ] ) );
      end;
    end;

    // Presence of a sublevel: display number of children
    if ( StopList and ( not IsRef ) ) then
    begin
      NbChildren := 0;
      NbSpecific := 0;
      LeftTerm := AOTAG + cHrefEmpty + {cRetroDir + cList + cSpace +
                  cLgShort[ TAH.SubstLang ] + cSlash +} cTAH +
                  IntToStr( Actual.TID ) + cSpace +
                  ListType + cTypeListPage[ CurrType ] + cSpace +
                  cLgShort[ lt_English ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + LeftTerm + AETAG;
    end;

    // Prepare the right column term with substitutiuon language
    Actual.LgCurrent := TAH.SubstLang;
    Actual.Query := tSearch.Create( st_Ori );
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    RightTerm := '---';
    if ( ATerm <> nil ) then
      RightTerm := ATerm.Mandat;

    // Add possible synonyms for right term
    Gener := TAH.GetEntityByTID( Actual.Generator );
    if ( Gener = nil ) then
      Gener := Actual;

    // Search for first synonym
    Actual.Query := tSearch.Create( st_Alt );
    Actual.Query.SynPos := 0;
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    IsFirst := False;
    if ( ATerm <> nil ) then
    begin
      MySyn := Aterm.Mandat;
      RightTerm := RightTerm + cSemi + cSpace + MySyn;
      IsFirst := True;
    end;

    // Search for second synonym
    {if ( IsFirst ) then
    begin
      MySynType := st_Od2;
      if ( Actual.TID = 38695 ) then // temporary
        MySynType := st_Un1;
      if ( Actual.TID = 34378 ) then // temporary
        MySynType := st_Un2;
      Query := TSearch.Create( Actual, MySynType, TAH.SubstLang );
      Query.SearchTerm;
      ATerm := Query.Single;
      IsSecond := False;
      if ( ATerm <> nil ) then
      begin
        MySyn := Aterm.Mandat;
        if ( not IsShort ) then
          MySyn := MySyn + ATerm.Option;
        if ( ( ATerm.Bracket <> cEmpty ) and IsBracket ) then
          MySyn := MySyn + cSpace + ATerm.Bracket;
        if ( ATerm.BuildFrom = bd_model ) then
          MySyn := MySyn + cSpace + cUniversal;
        RightTerm := RightTerm + cSemi + cSpace + MySyn;
        IsSecond := True;
      end;
    end;

    // Search for third synonym
    if ( IsSecond ) then
    begin
      Query := TSearch.Create( Actual, st_Od3, TAH.SubstLang );
      Query.SearchTerm;
      ATerm := Query.Single;
      if ( ATerm <> nil ) then
      begin
        MySyn := Aterm.Mandat;
        if ( not IsShort ) then
          MySyn := MySyn + ATerm.Option;
        if ( ( ATerm.Bracket <> cEmpty ) and IsBracket ) then
          MySyn := MySyn + cSpace + ATerm.Bracket;
        if ( ATerm.BuildFrom = bd_model ) then
          MySyn := MySyn + cSpace + cUniversal;
        RightTerm := RightTerm + cSemi + cSpace + MySyn;
      end;
    end;}

    // Add the UK/US flag if present (only for English as SubstLang)
    if ( TAH.SubstLang = lt_English ) then
    begin
      Actual.LgCurrent := lt_English;
      Actual.Query := tSearch.Create( st_USA );
      Actual.SearchTerm;
      IsUSA := Actual.CurrSingle <> nil;
      Gener := nil;
      if ( MyTetra <> nil ) then
        Gener := TAH.GetEntityByTID( MyTetra.Generator );
      if ( Gener <> nil ) then
      begin
        Gener.LgCurrent := lt_English;
        Gener.Query := tSearch.Create( st_USA );
        Gener.SearchTerm;
        ATerm := Gener.CurrSingle;
        IsUSA := IsUSA or ( ATerm <> nil );
      end;
      if ( IsUSA and ( not IsExcel ) and ( ATerm <> nil ) ) then
      begin

        // Add the US text as bubble to right column, including synonyms
        if ( Gener <> nil ) then
        begin
          UKUSDiff := ATerm.Mandat;
          Posit := Pos( cSlash, UKUSDiff );
          UKVal := Copy( UKUSDiff, 1, Posit - 1 );
          USVal := Copy( UKUSDiff, Posit + 1, Length( UKUSDiff ) );
          MyBubble := RightTerm;
          Posit := Pos( UKVal, MyBubble );
          while ( Posit > 0 ) do
          begin
            MyBubble := Copy( MyBubble, 1, Posit - 1 ) + USVal +
                        Copy( MyBubble, Posit + Length( UKVal ),
                              Length( MyBubble ) );
            Posit := Pos( UKVal, MyBubble );
          end; // while
        end;
        RightTerm := RightTerm + cSpace + cUsa;
      end;
    end;

    // Add a possible gender-specific sign
    if ( Actual.Sexe = sx_male ) then
      RightTerm := RightTerm + cSpace + cMale
    else
    if ( Actual.Sexe = sx_female ) then
      RightTerm := RightTerm + cSpace + cFemale;

    // Management of inconstant flag
    if ( Actual.Inconstant ) then
    begin
      LeftTerm := cRol + LeftTerm + cRor;
      RightTerm := cRol + RightTerm + cRor;
    end;

    // Search all the notes for the current entity
    NbNote := 0;
    SetLength( MyNote, 10 );
    if ( TAH.Notes.GetNotes( Actual.Tetra, NbNote, MyNote ) ) then
    begin
      SetLength( MyNote, NbNote );

      // Select the scientific notes
      for Indn := 0 to NbNote - 1 do
      begin
        MyType := MyNote[ Indn ].Typ;
        if ( MyType = nt_Scientific ) then
        begin

          // Indirect adressing of a note
          TheNote := MyNote[ Indn ];
          if ( TheNote.Txt[ 1 ] = '!' ) then
          begin
            TIDInit := TheNote.TID;
            MyTID :=
              StrToInt( Copy( TheNote.Txt, 2, Length( TheNote.Txt ) ) );
            SetLength( MyOtherNote, 10 );
            if ( TAH.Notes.GetNotes( MyTID, MbNote, MyOtherNote ) ) then
            begin
              SetLength( MyOtherNote, MbNote );

              // Select the scientific notes
              for Indm := 0 to MbNote - 1 do
              begin
                MyType := MyOtherNote[ Indm ].Typ;
                if ( MyType = nt_Scientific ) then
                begin
                  TheNote := MyOtherNote[ Indm ];
                  TheNote.TID := TIDInit;
                  Break;
                end;
              end; // for
            end;
          end;

          // Store the note
          if ( TheNote.Txt[ 1 ] <> '!' ) then
          begin
            ViewUnit := ViewUnit + cIsNote;
            AddNote( TheNote );
          end;
        end;
      end;
    end;

    // Store the line
    AnItem := tListItem.Create;
    AnItem.ViewCode := ViewCode;
    AnItem.ViewUnit := cEmpty;
    AnItem.ViewFMA := cEmpty;
    AnItem.Value := Toggle;
    AnItem.Left := LeftTerm;
    AnItem.Right := RightTerm;
    AnItem.Bubble := MyBubble;
    AnItem.Indent := MyIndent;
    AnItem.TA98Code := Actual.Cod98;
    AnItem.OriLA := OriLA;
    AnItem.FMALib := FMALib;
    AnItem.TA98 := TAH.DoTA98( Actual.TID );
    AnItem.FTAPlus := False;
    if ( MyTetra <> nil ) then
      AnItem.FTAPlus := MyTetra.Mandat;
    AnItem.IsPaire := IsPaire;
    AddLine( AnItem );

    // Open a subdivision of descendants
    if ( ( IsOpen ) and ( IsToggle ) ) then
    begin
      AnItem := tListItem.Create;
      AnItem.ItemType := tt_MakeODiv;
      AnItem.Value := DivName + IntToStr( NbDiv );
      AddLine( AnItem );
    end;
  end;
end; // ________________________________________________________MakeSingle98Line

procedure          tValidUnivSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tValidUnivSection.Build
  * Make a universal validation section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indn:            Integer;
  TotNote:         Integer;
  TotUniv:         Integer;
  TotMiss:         Integer;
  TotItems:        Integer;
  DupTID:          Integer;
  ActTID:          Integer;
  Percent:         Integer;
  Mid:             Real;
  A:               Real;
  IsStop:          Boolean;
  IsDup:           Boolean;
  Value:           String;
  LineText:        String;
  Actual:          tEntity;
  AnItem:          tListItem;
  MyNote:          NoteRec;
  AType:           tTypeListPage;
  NoteSection:     tListSection;
begin
  Actual := Self.Entity;
  AType := Self.TypeList;
  if ( ( Actual <> nil ) and ( Actual.PartCh <> cEmpty ) ) then
  begin

    // Build the line of headers of columns
    AnItem := TListItem.Create;
    AnItem.ViewUnit := cOBold + cUID + cEBold;
    AnItem.ViewCode := cOBold + cTID + cEBold;
    AnItem.ViewFMA := cOBold + cFMA + cEBold;
    // if ( Self.TypeList <> li_val ) then
    // begin
    //   AnItem.Left := cOBold + cShortOFF[ TAH.MainLang, DisLang ] + cEBold;
    //   AnItem.Right := cOBold + cShortOFF[ TAH.SubstLang, DisLang ] + cEBold;
    //   AnItem.FBubble := bbShortOFF[ TAH.SubstLang, DisLang ];
    //   AnItem.FMALib := bbShortOFF[ TAH.MainLang, DisLang ];
    // end else
    // begin
      AnItem.Left := cOBold + 'Universal term' + cEBold;
      AnItem.Right := cOBold + 'Language selection' + cEBold;
      AnItem.FBubble := cEmpty;
      AnItem.FMALib := cEmpty;
      AnItem.Profile := cOBold + 'Profile' + cEBold;
    // end;
    AddLine( AnItem );

    // Build the line for the top entity
    TotUniv := 0;
    TotMiss := 0;
    Self.MakeValidLine( Actual, TotUniv, TotMiss );

    // Build all children of the partonomy
    IsStop := Self.TypeList <> li_part0;
    MakeValidUnivDescendants( Actual.TID, TotUniv, TotMiss );

    // Display the number of items in the list
    TotItems := NbLine - 1;
    AnItem := tListItem.Create;
    AnItem.ViewCode := cEmpty;
    LineText := TAH.GetLabel( reLines, False );
    AnItem.Left := IntToStr( TotItems ) + cSpace + LineText;
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
    AddLine( AnItem );

    // Display the number of universal terms
    AnItem := tListItem.Create;
    AnItem.ViewCode := cEmpty;
    AnItem.Left := IntToStr( TotUniv ) + cSpace + 'universal terms';
    AnItem.Right := cEmpty;
    AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
    AddLine( AnItem );

    // Display the number of non matching terms
    if ( TotUniv > 0 ) then
    begin
      A := TotUniv;
      Mid := 100.0 * ( ( TotMiss - TotItems + TotUniv ) / A );
      Percent := Round( Mid );
      Value := FloatToStr( Percent / 10.0 ) + cSpace + cPercent;
      AnItem := TListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Left := IntToStr( TotMiss - TotItems + TotUniv ) + cSpace +
                     'missmatches' + cSpace +
                     cRol + IntToStr( Percent ) + cSpace + cPercent + cRor;
      AnItem.Right := cEmpty;
      AnItem.Indent := Chr( Ord( cBaseIndent ) + 1 );
      AddLine( AnItem );
    end;
  end;

  // Collection of the universal notes
  NoteSection := Self.ComplSection;
  TotNote := Self.NbNote;
  if ( TotNote > 0 ) then
  begin
    AnItem := TListItem.Create;
    AnItem.ViewCode := cOBold + cTID + cEBold;
    AnItem.Left := cOBold + 'Libelle of note' + cEBold;
    NoteSection.AddLine( AnItem );

    // Loop on all notes
    for Indn := 0 to TotNote - 1 do
    begin
      // Retrieve the note
      MyNote := Self.GetNote( Indn );

      // Check for a duplicated note
      DupTID := MyNote.Dup;
      IsDup := DupTID > 0;
      ActTID := MyNote.TID;

      // Prepare the next note line
      AnItem := TListItem.Create;
      AnItem.ViewCode := IntToStr( ActTID );
      if ( IsDup ) then
        AnItem.Left := 'See note #' + cSpace + IntToStr( DupTID )
      else
        AnItem.Left := MyNote.Txt;
      NoteSection.AddLine( AnItem );
    end; // for
  end;
end; // _________________________________________________tValidUnivSection.Build

procedure          tListSection.MakeValidUnivDescendants(
  TID:             Integer;
  var TotUniv:     Integer;
  var TotMiss:     Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeValidUnivDescendants
  * Search the descendants for universal validation section *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  Posit:           Integer;
  NbTrueChildren:  Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  ActDiv:          Integer;
  IsRef:           Boolean;
  Children:        String;
  SortList:        String;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Actual:          tEntity;
  AChild:          tEntity;
  AChildRef:       tEntity;
  MyLink:          tLink;
begin
  // Retrieve the top entity of the list
  Actual := TAH.GetEntityByTID( TID );
  if ( Actual = nil ) then
    Exit;

  // Get direct children and their number
  Children := Actual.PartCh;
  SortList := Actual.PartPos;
  NbTrueChildren := Actual.NbPartC;

  // Extract the list of order position
  if ( Children = cEmpty ) then
    Exit;
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

      // Skip left and right entities
      MyLink := AChild.Link;
      if ( MyLink in [ pw_MemberL, pw_MemberR, pw_SMemberL, pw_SMemberR,
           pw_IMemberL, pw_IMemberR, pw_TMemberL, pw_TMemberR ] ) then
        Continue;

      // Prepare and display a single line
      Self.MakeValidLine( AChild, TotUniv, TotMiss );

      // Continue on chidren
      Self.MakeValidUnivDescendants( AChild.TID, TotUniv, TotMiss );
    end;
  end; // for Indx := 1 to NbTrueChildren
end; // ________________________________________________MakeValidUnivDescendants

procedure          tListSection.MakeValidLine(
  Actual:          tEntity;
  var TotUniv:     Integer;
  var TotMiss:     Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeValidLine
  * Make a universal validation line *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsRef:           Boolean;
  IsBrL:           Boolean;
  IsBrH:           Boolean;
  IsTA98:          Boolean;
  ViewCode:        String;
  ViewUnit:        String;
  ViewFMA:         String;
  MyBubble:        String;
  OriLA:           String;
  Code98:          String;
  FMALib:          String;
  RightTerm:       String;
  LeftTerm:        String;
  MyProfile:       String;
  // MyRaw:           String;
  MyString1:       String;
  MyString2:       String;
  // MyFamily:        TFamily;
  MySet:           tEntity;
  Gener:           tEntity;
  MyTetra:         tUnit;
  ATerm:           tSingle;
  MySingle:        tSingle;
  MyAlter:         tSingle;
  AnItem:          tListItem;
  MyLink:          tLink;
  // MyFormula:       TFormula;
begin
  if ( Actual <> nil ) then
  begin

    // Skip left and right entities
    MyLink := Actual.Link;
    if ( MyLink in [ pw_MemberL, pw_MemberR, pw_SMemberL, pw_SMemberR,
                     pw_IMemberL, pw_IMemberR, pw_TMemberL, pw_TMemberR ] ) then
      Exit;

    // Skip references
    IsRef := Actual.TetraTip = tp_ref;
    if ( IsRef ) then
      Exit;

    // Prepare the identifiers: FMA, Entity and Unit
    MyTetra := TAH.GetUnitByPos( Actual.Tetra );
    Gener := TAH.GetEntityByTID( MyTetra.Generator );
    if ( Gener = nil ) then
      Gener := Actual;
    ViewCode := IntToStr( Actual.TID );
    ViewUnit := IntToStr( Actual.Tetra );

    // Make hyperlink to Entity Page on TID
    ViewCode := AOTAG + cHrefEmpty +cRetroDir + cEntity + cSpace +
                cLgShort[ lt_English ] + cSlash + cTAH + ViewCode +
                cSpace + cEntity + cSpace + cLgShort[ lt_English ] +
                cPeriod + HtmlExt + cDQuote + cAnr + ViewCode + AETAG;

    // Make hyperlink to Unit Page on UID for non taxonomic entities
    if ( ( MyTetra <> nil ) and ( MyTetra.TypUnit <> tt_tax ) ) then
    begin
      ViewUnit := AOTAG + cHrefEmpty +cRetroDir + cTetrahedron + cSpace +
                  cLgShort[ lt_English ] + cSlash + cTAH + ViewUnit +
                  cSpace + cTetrahedron + cSpace + cLgShort[ lt_English ] +
                  cPeriod + HtmlExt + cDQuote + cAnr + ViewUnit + AETAG;
    end;

    // Prepare the left and right column terms
    MySingle := Actual.GetSingle( lb_Official, TAH.MainLang );
    MyAlter := Actual.GetSingle( lb_Universal, TAH.MainLang );
    if ( MySingle <> nil ) then
    begin
      MyString1 := MySingle.Mandat + '<I>' + Mysingle.Option + '</I>' +
                   MySingle.Bracket;
      MyString2 := cEmpty;
      if ( MyAlter <> nil ) then
        MyString2 := Trim( MyAlter.Mandat ) + '<I>' + MyAlter.Option + '</I>' +
                     MyAlter.Bracket;
      {if ( ( MySingle.BuildFrom = bd_model ) and
           ( MyString1 = MyString2 ) ) then
        MyString1 := MyString1 + cSpace + cUniversal;
      if ( ( MyAlter <> nil ) and ( MyAlter.BuildFrom = bd_model ) ) then
        MyString2 := MyString2 + cSpace + cUniversal;}

      // Universal term found as effective
      if ( ( MySingle.Effective in [ st_for ] ) and
           ( MyString1 = MyString2 ) ) then
      begin
        LeftTerm := MyString1;
        RightTerm := cEmpty;
      end else

      // Other term found as effective in presence of universal term
      if ( ( MySingle.Effective in [ st_RAT, st_bas ] ) and
           ( MyAlter <> nil ) and
           ( MyAlter.BuildFrom = bd_model ) ) then
      begin
        LeftTerm := MyString2;
        RightTerm := MyString1;
      end else

      // Absence of universal term
      begin
        LeftTerm := cEmpty;
        RightTerm := MyString1;
      end;
    end;
    if ( RightTerm <> cEmpty ) then
      Inc( TotMiss );

    // Prepare the profile of term
    {MyFormula := tFormula.Create( Actual.Tetra );
    MyProfile := cEmpty;
    if ( MyFormula <> nil ) then
      MyProfile := MyFormula.Profile;
    if ( MyProfile <> cEmpty ) then
      Inc( TotUniv );
    IsBrL := MyFormula.ValidLow;
    IsBrH := MyFormula.ValidHigh;
    MyRaw := MyFormula.Raw;
    MyFamily := MyFormula.Family; }

    // Prepare the FMA identifier
    ViewFMA := cEmpty;
    if ( Actual.FID > 0 ) then
    begin
      ViewFMA := IntToStr( Actual.FID );
      ViewFMA := AOTAG + cHrefEmpty + FMEBaseUrl + cQuest + cFmaID +
                 cEqual + IntToStr( Actual.FID ) + cDQuote + cAnr +
                 ViewFMA + AETAG;

      // Prepare the FMA term
      if ( Gener <> nil ) then
      begin
        Gener.LgCurrent := lt_English;
        Gener.Query := tSearch.Create( st_FMA );
        Gener.SearchTerm;
        ATerm := Gener.CurrSingle;
        FMALib := cEmpty;
        if ( ATerm <> nil ) then
          FMALib := ATerm.Mandat;
      end;
    end;

    // Prepare the TA98 original Latin term
    Actual.LgCurrent := lt_Latin;
    Actual.Query := tSearch.Create( st_Ori );
    Actual.SearchTerm;
    ATerm := Actual.CurrSingle;
    if ( ( ATerm = nil ) and ( MyTetra <> nil ) ) then
    begin
      if ( Actual.TetraTip = tp_pair ) then
        MySet := TAH.GetEntityByPos( MyTetra.Generator )
      else
        MySet := TAH.GetEntityByPos( MyTetra.ASet );
      if ( MySet <> nil ) then
      begin
        MySet.LgCurrent := lt_Latin;
        MySet.Query := tSearch.Create( st_Ori );
        MySet.SearchTerm;
        ATerm := MySet.CurrSingle;
      end;
    end;
    OriLA := cEmpty;
    Code98 := cEmpty;
    IsTA98 := False;
    if ( ATerm <> nil ) then
    begin
      OriLA := ATerm.Mandat;
      Code98 := MyTetra.Cod98;
      IsTA98 := True;
    end;

    // Store the line
    AnItem := tListItem.Create;
    AnItem.ViewCode := ViewCode;
    AnItem.ViewUnit := ViewUnit;
    AnItem.ViewFMA := ViewFMA;
    AnItem.Left := LeftTerm;
    AnItem.Right := RightTerm;
    AnItem.Bubble := MyBubble;
    AnItem.OriLA := OriLA;
    AnItem.TA98 := IsTA98;
    AnItem.TA98Code := Code98;
    AnItem.FMALib := FMALib;
    AnItem.Profile := MyProfile;
    // AnItem.Formula := MyRaw;
    AddLine( AnItem );
  end;
end; // ___________________________________________________________MakeValidLine

function           tTA98ListSection.GetNbLine()
  :                Integer;
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbLine
  * Property read method for number of lines in a TA98section *
  Description:
  This procedure retrieves the number of lines in a TA98section.</P>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ }
begin
  Result := Length(Self.FLine);
end; // _______________________________________________________________GetNbLine

procedure          tTA98ListSection.AddTA98Line(
  AnItem:          tTA98ListItem );
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddTA98Line
  * Add a line to a TA98 section *
  Description:
  This procedure increase by one unit the size of the area of lines, and add
  the given line in the last position.</P>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ }
var
  Nb:              Integer;
begin
  Nb := Self.NbLine + 1;
  SetLength(Self.FLine, Nb);
  Self.FLine[Nb - 1] := AnItem;
end; // _____________________________________________________________AddTA98Line

function           tTA98ListSection.GetTA98Line(
  PosItem:         Integer )
  :                tTA98ListItem;
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTA98Line
  * Get a line by its position from a TA98 section *
  Description:
  This procedure returns the line at the specified position, if the position is
  within the limits of existing positions, nil otherwise.</P>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ }
begin
  Result := nil;
  if ((PosItem < 0) or (PosItem > Self.NbLine)) then
    Exit;
  Result := Self.FLine[PosItem];
end; // _____________________________________________________________GetTA98Line

procedure          tTA98ListSection.WriteLines(
  Lev:             Integer );
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteLines
  * Write all lines of a TA98 List Page *
  Description:
  This procedure writes the first part of a TA98 List Page, giving a tracing
  for each TA98 entry with its destination elsewhere in the current revision.
  Each TA98 entity becomes 1 to 5 new entities or is deleted.</P>
  A statistical summary is given as a last line, counting entities both in
  TA98 and in he revision.</P>
  The procedure applies for both the long and short version of the TA98
  List Page.</P>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ }
var
  Indx:            Integer;
  TotLine:         Integer;
  Last:            Integer;
  PastTetra:       String;
  Tetra:           String;
  MyClassLeft:     String;
  MyClassRight:    String;
  MyTetra:         String;
  MyTID:           String;
  MySegment:       String;
  MySubSegment:    String;
  Indent:          String;
  IndentA:         String;
  IndentB:         String;
  MyList:          tTA98ListItem;
  MyLine:          tTA98ListItem;
begin

  // Initial stuff: Indent defines the background color (see css file)
  Indent := cLgShort[lt_Italian];
  IndentA := cLgShort[lt_Italian];
  IndentB := cLgShort[lt_French];
  PastTetra := cEmpty;
  MyList := GetTA98Line(0);
  TotLine := GetNbLine;

  // Write the title line
  if (Self.SectionType = sc_TA98Navigation) then
  begin
    AddTag(TRTAG, Lev + 1);
    MakeTD(cClassColS, BTAG + fdTA98Code[ en ] + BETAG, cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'Link to alternate Trace pages' + BETAG,
      cEmpty, Lev + 2);
    AddTag(TRETAG, Lev + 1);
  end
  else if (Self.SectionType = sc_TA98List) then
  begin
    AddTag(TRTAG, Lev + 1);
    MakeTD(cClassColS, BTAG + fdTA98Code[ en ] + BETAG, cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'TA98 preferred term and synonyms' + BETAG,
      cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'Type' + BETAG, cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'Status' + BETAG, cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'Level4' + BETAG, cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'Level5' + BETAG, cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'UID' + BETAG, cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'TID' + BETAG, cEmpty, Lev + 2);
    MakeTD(cClassColX, BTAG + 'TAH official term' + BETAG, cEmpty, Lev + 2);
    AddTag(TRETAG, Lev + 1);
  end;

  // Write all lines, but the last
  Last := 0;
  if ( Self.SectionType = sc_TA98Navigation ) then
    Last := TotLine - 1
  else if ( Self.SectionType = sc_TA98List ) then
    Last := TotLine - 2;
  for Indx := 0 to Last do
  begin
    MyLine := GetTA98Line(Indx);
    MyTID := MyLine.TID;
    MyTetra := MyLine.Tetra;
    MySegment := MyLine.Segment;
    if (MyLine.Segment = '0') then
      MySegment := cEmpty;
    MySubSegment := MyLine.SubSegment;
    if ( MyLine.SubSegment = '0' ) then
      MySubSegment := cEmpty;
    if ( MyTetra <> PastTetra ) then
    begin
      if (Indent = IndentA) then
        Indent := IndentB
      else
        Indent := IndentA;
      Tetra := MyTetra;
    end
    else
    begin
      Tetra := cEmpty;
      MySegment := cEmpty;
      MySubSegment := cEmpty;
    end;
    MyClassLeft := cClassEmpty + cLgShort[lt_Latin] + MyLine.Indent + cDQuote;
    MyClassRight := cClassEmpty + Indent + 'a' + cDQuote;
    if (MyLine <> nil) then
    begin
      AddTag(TRTAG, Lev + 1);
      MakeTD(cClassColS, MyLine.ViewCode, cEmpty, Lev + 2);
      MakeTD(cClassColX, MyLine.Value, MyLine.Bubble, Lev + 2, MyClassLeft);
      MakeTD(cClassColX, MyLine.Status, cEmpty, Lev + 2);
      MakeTD(cClassColX, MyLine.Error, MyLine.ErrTxt, Lev + 2);
      MakeTD(cClassColX, MySegment, cEmpty, Lev + 2);
      MakeTD(cClassColX, MySubSegment, cEmpty, Lev + 2);
      MakeTD(cClassColX, Tetra, cEmpty, Lev + 2);
      MakeTD(cClassColX, MyTID, cEmpty, Lev + 2);
      MakeTD(cClassColX, MyLine.Text, MyLine.Plus, Lev + 2, MyClassRight);
      AddTag(TRETAG, Lev + 1);
    end;
    PastTetra := MyTetra;
  end; // for

  // Write the last line of statistic
  if (Self.SectionType = sc_TA98List) then
  begin
    MyLine := GetTA98Line(TotLine - 1);
    AddTag(TRTAG, Lev + 1);
    MakeTD(cClassColS, cEmpty, cEmpty, Lev + 2);
    MakeTD(cClassColX, MyLine.Value, cEmpty, Lev + 2);
    MakeTD(cClassColX, cEmpty, cEmpty, Lev + 2);
    MakeTD(cClassColX, cEmpty, cEmpty, Lev + 2);
    MakeTD(cClassColX, cEmpty, cEmpty, Lev + 2);
    MakeTD(cClassColX, cEmpty, cEmpty, Lev + 2);
    MakeTD(cClassColX, cEmpty, cEmpty, Lev + 2);
    MakeTD(cClassColX, cEmpty, cEmpty, Lev + 2);
    MakeTD(cClassColX, MyLine.Text, cEmpty, Lev + 2);
    AddTag(TRETAG, Lev + 1);
  end;
end; // ______________________________________________________________WriteLines

procedure          tTA98ListSection.WriteNotes(
  Lev:             Integer );
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ WriteNotes
  * Write all notes of a TA98 List Page *
  Description:
  The notes have been collected as an array of note records. The relevant items
  are extracted in a character delimited string, headed by the sort string built
  from the entity identifier. Then the set of all strings is sorted. Finally,
  each note is extracted from its string and displayed.</P>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ }
var
  Indx:            Integer;
  TotLine:         Integer;
  Posit:           Integer;
  TID:             Integer;
  MyClassLeft:     String;
  RefSort:         String;
  ANote:           String;
  Indent:          String;
  ViewCode:        String;
  Left:            String;
  MyLine:          tTA98ListItem;
  AllNotes:        TStringList;
  Actual:          tEntity;
begin

  // Find all lines and prepare for sorting
  AllNotes := TStringList.Create;
  TotLine := GetNbLine;
  MyLine := nil;
  for Indx := 0 to TotLine - 1 do
  begin
    MyLine := GetTA98Line(Indx);
    RefSort := MyLine.ViewCode;
    while (Length(RefSort) < 6) do
      RefSort := '0' + RefSort;
    AllNotes.Add(RefSort + CurSep + MyLine.ViewCode + CurSep + MyLine.Text +
      CurSep + MyLine.Indent);
  end;
  AllNotes.Sort;

  // Display all sorted lines
  for Indx := 0 to TotLine - 1 do
  begin
    ANote := AllNotes[Indx];
    Posit := Pos(CurSep, ANote);
    ANote := Copy(ANote, Posit + 1, Length(ANote));
    Posit := Pos(CurSep, ANote);
    ViewCode := Copy(ANote, 1, Posit - 1);
    if (Indx > 0) then
    begin
      TID := StrToInt(ViewCode);
      Actual := TAH.GetEntityByTID(TID);
      if (Actual <> nil) then
        ViewCode := Actual.Cod98;
    end;
    ANote := Copy(ANote, Posit + 1, Length(ANote));
    Posit := Pos(CurSep, ANote);
    Left := Copy(ANote, 1, Posit - 1);
    Indent := Copy(ANote, Posit + 1, Length(ANote));
    MyClassLeft := cClassEmpty + cLgShort[lt_Latin] + Indent + cDQuote;
    if (MyLine <> nil) then
    begin
      AddTag(TRTAG, Lev + 1);
      MakeTD(cClassColS, ViewCode, cEmpty, Lev + 2);
      MakeTD(cClassColX, Left, cEmpty, Lev + 2, MyClassLeft);
      AddTag(TRETAG, Lev + 1);
    end;
  end; // for
end; // ______________________________________________________________WriteNotes

procedure          tTA98NavSection.Build;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTA98NavSection.Build
  * Navigation between TA98 trace lists *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TID:             Integer;
  Past:            Integer;
  CurrTID:         Integer;
  StartTID:        Integer;
  EndSub:          Boolean;
  IsSect:          Boolean;
  IsSub:           Boolean;
  IsShort:         Boolean;
  Found:           Boolean;
  Section:         String;
  SubChap:         String;
  Chap:            String;
  MyValue:         String;
  MyShort:         String;
  MyRec:           TA98Rec;
  Current:         tEntity;
  AnItem:          tTA98ListItem;
  MyTerm:          tSingle;
begin

  // Find subchapter for non subchapter mode
  Recurs := Self.Recurs;
  StartTID := Self.Entity.TID;
  TID := StartTID;
  Past := TID;
  if ( ( Recurs <> md_subchap ) or ( Recurs <> md_chap ) ) then
  begin
    SubChap := Copy( Self.Entity.Cod98, 1, 5 );
    repeat
      Past := TID;
      Dec( TID );
      MyRec := TAH.TA98List.GetTA98( TID );
      TID := MyRec.List;
      Found := Copy( MyRec.TAcode, 1, 5 ) <> SubChap;
    until Found;
    TID := Past;
  end;

  // Initial stuff
  CurrTID := Past;
  MyRec := TAH.TA98List.GetTA98( CurrTID );
  Section := Copy( Self.Entity.Cod98, 1, 8 );
  SubChap := Copy( Self.Entity.Cod98, 1, 5 );
  Chap := Copy( Self.Entity.Cod98, 1, 3 );
  Current := TAH.GetEntityByTID( CurrTID );
  IsSect := True;
  IsShort := False;

  // Display a header
  MyValue := cEmpty;
  Current.LgCurrent := TAH.MainLang;
  Current.Query := tSearch.Create( st_Ini );
  Current.SearchTerm;
  MyTerm := Current.CurrSingle;
  if (MyTerm = nil) then
  begin
    Current.Query := tSearch.Create( st_Ori );
    Current.SearchTerm;
    MyTerm := Current.CurrSingle;
  end;
  if ( MyTerm <> nil ) then
    MyValue := MyTerm.Mandat + MyTerm.Bracket;

  // Prepare hyperlink to the section page
  if ( ( Recurs <> md_subchap ) and ( Recurs <> md_chap ) ) then
  begin
    MyValue := AOTAG + cHrefEmpty + cRetroDir + cTraceTA98 + cSpace +
      cLgShort[lt_English] + cSlash + cTAH + IntToStr(Current.Tetra) + cSpace +
      cTA98 + cSpace + cSub + cSpace + cLgShort[lt_English] + cPeriod + HtmlExt
      + cDQuote + cAnr + MyValue + AETAG;
  end;

  // Store the header
  AnItem := tTA98ListItem.Create;
  AnItem.ViewCode := BTAG + SubChap + BETAG;
  AnItem.Value := MyValue;
  AddTA98Line( AnItem );

  // Loop on all entities of the chapter or subchapter
  repeat

    // Display a section
    if ( IsSect ) then
    begin

      // Get TA98 term
      MyValue := cEmpty;
      Current.Query := tSearch.Create( st_Ini );
      Current.SearchTerm;
      MyTerm := Current.CurrSingle;
      if ( MyTerm = nil ) then
      begin
        Current.Query := tSearch.Create( st_Ori );
        Current.SearchTerm;
        MyTerm := Current.CurrSingle;
      end;
      if ( MyTerm <> nil ) then
        MyValue := MyTerm.Mandat + MyTerm.Bracket;

      // Prepare hyperlink to the section page
      if ( ( TID <> StartTID ) or ( Recurs = md_subchap ) ) then
      begin
        MyShort := TAH.GetLabel( reFull );
        MyValue := AOTAG + cHrefEmpty + cRetroDir + cTraceTA98 + cSpace +
          cLgShort[ lt_English ] + cSlash + cTAH + IntToStr( Current.Tetra ) +
          cSpace + cTA98 + cSpace + MyShort + cSpace + cLgShort[ lt_English ] +
          cPeriod + HtmlExt + cDQuote + cAnr + MyValue + AETAG;
      end;

      // Store the section line
      AnItem := tTA98ListItem.Create;
      AnItem.ViewCode := BTAG + Section + BETAG;
      AnItem.Value := MyValue;
      AnItem.Indent := MyRec.Ind;
      AddTA98Line( AnItem );
      IsSect := False;
    end;

    // Display a short range (subsection in TA98)
    if ( IsShort ) then
    begin

      // Get TA98 term
      MyValue := cEmpty;
      Current.Query := tSearch.Create( st_Ini );
      Current.SearchTerm;
      MyTerm := Current.CurrSingle;
      if ( MyTerm = nil ) then
      begin
        Current.Query := tSearch.Create( st_Ori );
        Current.SearchTerm;
        MyTerm := Current.CurrSingle;
      end;
      if ( MyTerm <> nil ) then
        MyValue := MyTerm.Mandat + MyTerm.Bracket;

      // Prepare hyperlink to the subsection page
      if ( TID <> StartTID ) then
      begin
        MyShort := TAH.GetLabel( reShort );
        MyValue := AOTAG + cHrefEmpty + cRetroDir + cTraceTA98 + cSpace +
          cLgShort[ lt_English ] + cSlash + cTAH + IntToStr( Current.Tetra ) +
          cSpace + cTA98 + cSpace + Myshort + cSpace +
          cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
          MyValue + AETAG;
      end;

      // Store the subsection line
      AnItem := tTA98ListItem.Create;
      AnItem.ViewCode := BTAG + Current.Cod98 + BETAG;
      AnItem.Value := MyValue;
      AnItem.Indent := MyRec.Ind;
      AddTA98Line( AnItem );
      IsShort := False;
    end;

    // Check for end of the chapter or subchapter
    Inc( TID );
    MyRec := TAH.TA98List.GetTA98( TID );
    Current := TAH.GetEntityByTID( TID );
    if ( ( Current = nil ) or ( MyRec.List = 0 ) ) then
      Exit;
    IsShort := TID = MyRec.List;
    IsSect := Section <> Copy( Current.Cod98, 1, 8 );
    IsSub := SubChap <> Copy( Current.Cod98, 1, 5 );
    if ( IsSub ) then
    begin
      IsSect := False;
      IsShort := False;
      SubChap := Copy( Current.Cod98, 1, 5 );
    end;
    if ( IsSect ) then
    begin
      IsShort := False;
      Section := Copy( Current.Cod98, 1, 8 );
    end;
     CurrTID := TID;
    EndSub := ( ( ( Recurs = md_subchap )
                  and ( SubChap <> Copy( Current.Cod98, 1, 5 ) ) )
                or ( ( Chap <> Copy( Current.Cod98, 1, 3 ) ) ) );
  until EndSub;
end; // ___________________________________________________tTA98NavSection.Build

procedure          tTA98DetailSection.Build;
  // var Complement:  tListSection );
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tTA98DetailSection.Build
  * Prepare a TA98 List, long or short *
  Description:
  This method is responsible to write an entire section list for a
  TA98 Page. The list may be long with a common left 8-digit code, or short
  relative to a single sequence of the last 3 digits.</P>
  Each list considers all TA98 original entities in a strict sequential order,
  in conformity to the 1998 book presentation.</P>
  Then, it details what happens to each entity during the revision process,
  basically in two ways:
  - the entity is the source of a Unit in the revision, made of 1 to 5
  distinct entities,
  - the entity becomes a reference or is deleted.</P>
  The Units are developed in details for all their constitutive
  entities. The references and deletions are mentioned in the status field.</P>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ }
var
  Indn:            Integer;
  TID:             Integer;
  CountTAH:        Integer;
  CountTA98:       Integer;
  TotNote:         Integer;
  Section:         String;
  SubChap:         String;
  Chap:            String;
  MyRec:           TA98Rec;
  AnItem:          tTA98ListItem;
  AnItem2:         tListItem;
  StoreNote:       Array of NoteRec;
begin

  // Initial stuff
  {Recurs := Self.Recurs;
  TotNote := 0;
  CountTAH := 0;
  CountTA98 := 0;
  TID := Self.Entity.TID;
  MyRec := TAH.TA98List.GetTA98(TID);
  Section := Copy(Self.Entity.Cod98, 1, 8);
  SubChap := Copy(Self.Entity.Cod98, 1, 5);
  Chap := Copy(Self.Entity.Cod98, 1, 3);

  // Recursive call for list processing, long or short (argument Recurs)
  SetLength( StoreNote, 50 );
  MakeTA98List( TID, Recurs, Recurs, Section, SubChap, Chap, CountTA98,
                CountTAH, StoreNote, TotNote);

  // Display number of found entities in TA98 and TAH
  AnItem := TTA98ListItem.Create;
  AnItem.ViewCode := cEmpty;
  AnItem.Value := 'TA98 entities' + cColumn + cSpace + IntToStr(CountTA98);
  AnItem.Text := 'TAH entities' + cColumn + cSpace + IntToStr(CountTAH);
  AddTA98Line( AnItem );

  // Build the title of the list of TA98 deletion notes
  if (TotNote > 0) then
  begin
    AnItem2 := TListItem.Create;
    AnItem2.ViewCode := BTAG + 'UID' + BETAG;
    AnItem2.Left := '<B>Libelle of note</B>';
    Complement.AddLine( AnItem2 );

    // Loop on all deletion notes
    for Indn := 0 to TotNote - 1 do
    begin
      AnItem2 := TListItem.Create;
      AnItem2.ViewCode := IntToStr(StoreNote[Indn].TID);
      AnItem2.Left := StoreNote[Indn].Txt;
      Complement.AddLine( AnItem2 );
    end; // for
  end;}
end; // ________________________________________________tTA98DetailSection.Build

procedure          tTA98ListSection.MakeTA98List(
  TID:             Integer;
  ModeInit:        tModeTA98;
  Recurs:          tModeTA98;
  Section:         string;
  SubChap:         string;
  Chap:            string;
  var CountTA98:   Integer;
  var CountTAH:    Integer;
  var StoreNote:   Array of NoteRec;
  var TotNote:     Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTA98List
  * Make a list of entities for a Trace TA98 Page *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indn:            Integer;
  StartTID:        Integer;
  NbNote:          Integer;
  First:           Boolean;
  Terminated:      Boolean;
  IsAnc:           Boolean;
  IsNull:          Boolean;
  IsNote:          Boolean;
  EndShort:        Boolean;
  EndSect:         Boolean;
  EndSub:          Boolean;
  EndChap:         Boolean;
  ATerm:           String;
  Tetra:           String;
  MyTID:           String;
  TA98Code:        String;
  MySegment:       String;
  MySubSegment:    String;
  MyValue:         String;
  NewSection:      String;
  NewSub:          String;
  AnItem:          tTA98ListItem;
  AnItem2:         tTA98ListItem;
  MyTerm:          tSingle;
  MyRec:           TA98Rec;
  Current:         tEntity;
  Working:         tEntity;
  MyTetra:         tTetrahedron;
  MyNote:          Array of NoteRec;
  MyType:          tNoteType;
  MyTip:           tTip;
  MyUnit:          tUnit;
begin

  // Initial stuff
  First := True;
  StartTID := TID;
  MyRec := TAH.TA98List.GetTA98( TID );
  Current := TAH.GetEntityByTID( TID );

  // Build an initial informative line for a new section
  if ( Recurs = md_subchap ) then
  begin
    AnItem := tTA98ListItem.Create;
    AnItem.Value := 'Group by ' + Copy( MyRec.TAcode, 2, 8 );
    AddTA98Line( AnItem );
  end
  else if ( Recurs = md_chap ) then
  begin
    AnItem := tTA98ListItem.Create;
    AnItem.Value := 'Group by ' + Copy( MyRec.TAcode, 2, 5 );
    AddTA98Line( AnItem );
  end;

  // Loop on the single list
  repeat

    // Build the line of current TA98 entity
    MyTip := Current.TetraTip;
    AnItem := tTA98ListItem.Create;
    IsAnc := ( Current.PartAnc > 0 );
    AnItem.Error := cOK;

    // Make hyperlink to TA98 on-line version
    TA98Code := Copy( MyRec.TAcode, 2, Length( MyRec.TAcode ) );
    TA98Code := AOTAG + cHrefEmpty + PublicRootDir + cEntity + cSpace + cTA98 +
      cSpace + cLgShort[ lt_English ] + cSlash + TA98Code + cSpace + cEntity +
      cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
      MyRec.TAcode + AETAG;

    // Check for a note attached to the current entity
    NbNote := 0;
    IsNote := False;
    SetLength( MyNote, 10 );
    if ( TAH.Notes.GetNotes( TID, NbNote, MyNote ) ) then
    begin
      SetLength( MyNote, NbNote );
      // Collect a possible TA98 trace note
      for Indn := 0 to NbNote - 1 do
      begin
        MyType := MyNote[ Indn ].Typ;
        if ( MyType = nt_Del98 ) then
        begin
          // Store the note
          StoreNote[ TotNote ] := MyNote[ Indn ];
          StoreNote[ TotNote ].Txt :=
            MakeHyperLinks( MyNote[ Indn ].Txt, lt_English, False );
          Inc( TotNote );
          IsNote := True;
          Break;
        end;
      end; // for
    end;

    // Flag for presence of a note
    if ( IsNote ) then
      TA98Code := TA98Code + cIsNote;
    AnItem.ViewCode := TA98Code;

    // Define TA98 original term, including official synonym
    MyValue := cEmpty;
    Current.LgCurrent := TAH.MainLang;
    Current.Query := tSearch.Create( st_Ini );
    Current.SearchTerm;
    MyTerm := Current.CurrSingle;
    if ( MyTerm = nil ) then
    begin
      Current.Query.MyType := st_Ori;
      Current.SearchTerm;
      MyTerm := Current.CurrSingle;
    end;
    if ( MyTerm <> nil ) then
      MyValue := MyTerm.Mandat + MyTerm.Bracket;
    Current.Query.MyType := st_Alt;
    Current.SearchTerm;
    MyTerm := Current.CurrSingle;
    if ( MyTerm <> nil ) then
      MyValue := MyValue + cSemi + cSpace + MyTerm.Mandat + MyTerm.Bracket;
    if ( Current.Inconstant ) then
      MyValue := cRol + MyValue + cRor;
    AnItem.Value := MyValue;
    MyValue := cEmpty;
    Current.Query.MyType := st_Ori;
    Current.LgCurrent := TAH.SubstLang;
    Current.SearchTerm;
    MyTerm := Current.CurrSingle;
    if ( MyTerm <> nil ) then
      MyValue := MyTerm.Mandat + MyTerm.Bracket;
    Current.Query.MyType := st_Alt;
    Current.SearchTerm;
    MyTerm := Current.CurrSingle;
    if ( MyTerm <> nil ) then
      MyValue := MyValue + cSemi + cSpace + MyTerm.Mandat + MyTerm.Bracket;
    AnItem.Bubble := MyValue;
    AnItem.Indent := MyRec.Ind;

    // Make hyperlink to Unit Page
    Tetra := IntToStr(Current.Tetra);
    Tetra := AOTAG + cHrefEmpty + cRetroDir + cTetrahedron + cSpace +
      cLgShort[lt_English] + cSlash + cTAH + Tetra + cSpace + cTetrahedron +
      cSpace + cLgShort[lt_English] + cPeriod + HtmlExt + cDQuote + cAnr +
      Tetra + AETAG;
    MyTetra := TAH.GetTetrahedronByTID(Current.Tetra);
    MyUnit := TAH.GetUnitByPos(Current.Tetra);

    // Build the segment and subsegment information
    IsNull := False;
    if ( ( MyUnit <> nil ) and ( MyUnit.TypUnit <> tt_del ) ) then
    begin
      Working := MyTetra.Main;
      if ( MyTip = tp_single ) then
        Working := MyTetra.Genr
      else if ( ( MyTip = tp_genSet ) or ( MyTip = tp_set ) ) then
        Working := MyTetra.ASet;
      if ( Working <> nil ) then
      begin
        MySegment := IntToStr( MyUnit.Level4 );
        if ( MySegment <> '0' ) then
        begin
          MySegment := AOTAG + cHrefEmpty + cRetroDir + cSegmentation + cSpace +
            cLgShort[lt_English] + cSlash + cTAH + MySegment + cSpace + cLevel4
            + cSpace + cLgShort[lt_English] + cPeriod + HtmlExt + cDQuote + cAnr
            + MySegment + AETAG;
        end
        else
          MySegment := cEmpty;
        MySubSegment := IntToStr( MyUnit.Level5 );
        IsNull := MySubSegment = '0';
        MySubSegment := AOTAG + cHrefEmpty + cRetroDir + cSegmentation + cSpace
          + cLgShort[lt_English] + cSlash + cTAH + MySubSegment + cSpace +
          cSegmentation + cSpace + cLgShort[lt_English] + cPeriod + HtmlExt +
          cDQuote + cAnr + MySubSegment + AETAG;
      end;
    end;

    // Check for Unit type
    // Single Unit
    if ( MyTip = tp_single ) then
    begin
      Current.Query.MyType := st_Bas;
      Current.SearchTerm;
      MyTerm := Current.CurrSingle;
      AnItem.Text := MyTerm.Mandat + MyTerm.Bracket;
      AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Status := 'Single';
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr( Current.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[lt_English] + cSlash + cTAH + MyTID + cSpace + cEntity + cSpace
        + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      if ( not IsAnc ) then
      begin
        AnItem.Error := 'Err 1';
        AnItem.ErrTxt := 'Unused single entity.';
      end;
      Inc(CountTAH);
    end else

    // Pair tetrahedron
    if ( MyTip = tp_genPair ) then
    begin

      // Completion of first line
      Current.Query.MyType := st_Bas;
      Current.SearchTerm;
      MyTerm := Current.CurrSingle;
      AnItem.Text := MyTerm.Mandat + MyTerm.Bracket;
      AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Status := 'Pair';
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      if ( IsNull ) then
      begin
        AnItem.Error := 'Err 2';
        AnItem.ErrTxt := 'Unused paired entity.';
        MySubSegment := cEmpty;
      end;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr( Current.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      AddTA98Line( AnItem );
      Inc( CountTAH );
      MyTetra := TAH.GetTetrahedronByTID( Current.Tetra );

      // Pair line
      AnItem := tTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      MyTetra.Main.LgCurrent := TAH.MainLang;
      MyTetra.Main.Query := tSearch.Create( st_Dis );
      MyTetra.Main.SearchTerm;
      MyTerm := MyTetra.Main.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Text := MyTerm.Mandat + MyTerm.Bracket;
      MyTetra.Main.Query.MyType := st_Bas;
      MyTetra.Main.SearchTerm;
      MyTerm := MyTetra.Main.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Indent := cEmpty;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr( MyTetra.Main.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      AddTA98Line( AnItem );
      IsAnc := ( MyTetra.Main.PartAnc > 0 );
      if ( not IsAnc ) then
      begin
        AnItem.Error := 'Err 3';
        AnItem.ErrTxt := 'Partonomic orphan paired entity.';
      end;
      Inc( CountTAH );

      // Left line
      AnItem := tTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      MyTetra.Asin.LgCurrent := TAH.MainLang;
      MyTetra.Asin.Query := tSearch.Create( st_Bas );
      MyTetra.Asin.SearchTerm;
      MyTerm := MyTetra.Asin.CurrSingle;
      if ( MyTerm <> nil ) then
      begin
        if ( MyTerm.Short = cEmpty ) then
          AnItem.Text := MyTerm.Mandat
        else
          AnItem.Text := MyTerm.Short;
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option;
      end;
      AnItem.Indent := cEmpty;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr( MyTetra.ASin.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      AddTA98Line( AnItem );
      Inc( CountTAH );

      // Right line
      AnItem := tTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      MyTetra.ADex.LgCurrent := TAH.MainLang;
      MyTetra.ADex.Query := tSearch.Create( st_Bas );
      MyTetra.ADex.SearchTerm;
      MyTerm := MyTetra.ADex.CurrSingle;
      if ( MyTerm <> nil ) then
      begin
        if ( MyTerm.Short = cEmpty ) then
          AnItem.Text := MyTerm.Mandat
        else
          AnItem.Text := MyTerm.Short;
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option;
      end;
      AnItem.Indent := cEmpty;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr(MyTetra.ADex.TID);
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      Inc( CountTAH );
    end else

    // Pset tetrahedron, TA98 source at singular
    if ( MyTip = tp_genPSet ) then
    begin

      // Generator line
      MyTetra := TAH.GetTetrahedronByTID( Current.Tetra );
      ATerm := MyTetra.Genr.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.Genr.LgCurrent := TAH.MainLang;
      MyTetra.Genr.Query := tSearch.Create( st_Bas );
      MyTetra.Genr.SearchTerm;
      MyTerm := MyTetra.Genr.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Status := 'PSet';
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr( Current.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      AddTA98Line( AnItem );
      Inc( CountTAH );

      // Set line
      AnItem := tTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      ATerm := MyTetra.ASet.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.Aset.LgCurrent := TAH.MainLang;
      MyTetra.Aset.Query := tSearch.Create( st_Bas );
      MyTetra.Aset.SearchTerm;
      MyTerm := MyTetra.Aset.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Indent := cEmpty;
      MyTID := IntToStr( MyTetra.ASet.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      AddTA98Line( AnItem );
      Inc( CountTAH );

      // Pset line
      AnItem := TTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      ATerm := MyTetra.Main.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.Main.LgCurrent := TAH.MainLang;
      MyTetra.Main.Query := tSearch.Create( st_Bas );
      MyTetra.Main.SearchTerm;
      MyTerm := MyTetra.Main.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Indent := cEmpty;
      MyTID := IntToStr( MyTetra.Main.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      AddTA98Line( AnItem );
      Inc( CountTAH );

      // Left set line
      AnItem := TTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      ATerm := MyTetra.ASin.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.Asin.LgCurrent := TAH.MainLang;
      MyTetra.Asin.Query := tSearch.Create( st_Bas );
      MyTetra.Asin.SearchTerm;
      MyTerm := MyTetra.Asin.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Indent := cEmpty;
      MyTID := IntToStr( MyTetra.ASin.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      AddTA98Line( AnItem );
      Inc( CountTAH );

      // Right set line
      AnItem := tTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      ATerm := MyTetra.ADex.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.ADex.LgCurrent := TAH.MainLang;
      MyTetra.ADex.Query := tSearch.Create( st_Bas );
      MyTetra.ADex.SearchTerm;
      MyTerm := MyTetra.ADex.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Indent := cEmpty;
      MyTID := IntToStr( MyTetra.ADex.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr +
        MyTID + AETAG;
      AnItem.TID := MyTID;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      Inc( CountTAH );
    end else

    // Pset tetrahedron, source at plural
    if ( MyTip = tp_setPSet ) then
    begin

      // Generator line
      MyTetra := TAH.GetTetrahedronByTID( Current.Tetra );
      AnItem2 := TTA98ListItem.Create;
      AnItem2.ViewCode := cEmpty;
      AnItem2.Value := cEmpty;
      ATerm := MyTetra.Genr.GetLibelle( lb_Official, TAH.MainLang);
      AnItem2.Text := ATerm;
      MyTetra.Genr.LgCurrent := TAH.MainLang;
      MyTetra.Genr.Query := tSearch.Create( st_Bas );
      MyTetra.Genr.SearchTerm;
      MyTerm := MyTetra.Genr.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem2.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem2.Status := 'PSet';
      AnItem2.Indent := cEmpty;
      MyTID := IntToStr(MyTetra.Genr.TID);
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr
        + MyTID + AETAG;
      AnItem2.TID := MyTID;
      AnItem2.Tetra := Tetra;
      AnItem2.Segment := MySegment;
      AnItem2.SubSegment := MySubSegment;
      AddTA98Line( AnItem2 );
      Inc( CountTAH );

      // Set line
      ATerm := MyTetra.ASet.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.Aset.LgCurrent := TAH.MainLang;
      MyTetra.Aset.Query := tSearch.Create( st_Bas );
      MyTetra.Aset.SearchTerm;
      MyTerm := MyTetra.Aset.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr( Current.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr
        + MyTID + AETAG;
      AnItem.TID := MyTID;
      AddTA98Line( AnItem );
      Inc( CountTAH );

      // Pset line
      AnItem := TTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      ATerm := MyTetra.Main.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.Main.LgCurrent := TAH.MainLang;
      MyTetra.Main.Query := tSearch.Create( st_Bas );
      MyTetra.Main.SearchTerm;
      MyTerm := MyTetra.Main.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Indent := cEmpty;
      MyTID := IntToStr( MyTetra.Main.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr
        + MyTID + AETAG;
      AnItem.TID := MyTID;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      AddTA98Line( AnItem );
      Inc( CountTAH );

      // Left set line
      AnItem := TTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      ATerm := MyTetra.ASin.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.ASin.LgCurrent := TAH.MainLang;
      MyTetra.ASin.Query := tSearch.Create( st_Bas );
      MyTetra.ASin.SearchTerm;
      MyTerm := MyTetra.ASin.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Indent := cEmpty;
      MyTID := IntToStr( MyTetra.ASin.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote + cAnr
        + MyTID + AETAG;
      AnItem.TID := MyTID;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      AddTA98Line( AnItem );
      Inc( CountTAH );

      // Right set line
      AnItem := TTA98ListItem.Create;
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      ATerm := MyTetra.ADex.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.ADex.LgCurrent := TAH.MainLang;
      MyTetra.ADex.Query := tSearch.Create( st_Bas );
      MyTetra.ADex.SearchTerm;
      MyTerm := MyTetra.ADex.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Indent := cEmpty;
      MyTID := IntToStr( MyTetra.ADex.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[lt_English] + cSlash + cTAH + MyTID + cSpace + cEntity +
        cSpace + cLgShort[lt_English] + cPeriod + HtmlExt + cDQuote + cAnr
        + MyTID + AETAG;
      AnItem.TID := MyTID;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      Inc(CountTAH);
    end else

    // Set tetrahedron, TA98 source at plural
    if ( ( MyTip = tp_set ) ) then
    begin

      // Generator line
      MyTetra := TAH.GetTetrahedronByTID( Current.Tetra );
      AnItem2 := TTA98ListItem.Create;
      AnItem2.ViewCode := cEmpty;
      AnItem2.Value := cEmpty;
      ATerm := MyTetra.Genr.GetLibelle( lb_Official, TAH.MainLang );
      AnItem2.Text := ATerm;
      MyTetra.Genr.LgCurrent := TAH.MainLang;
      MyTetra.Genr.Query := tSearch.Create( st_Bas );
      MyTetra.Genr.SearchTerm;
      MyTerm := MyTetra.Genr.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem2.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem2.Status := 'Set';
      AnItem2.Indent := cEmpty;
      AnItem2.Tetra := Tetra;
      AnItem2.Segment := MySegment;
      AnItem2.SubSegment := MySubSegment;
      MyTID := IntToStr( MyTetra.Genr.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity
        + cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote +
        cAnr + MyTID + AETAG;
      AnItem2.TID := MyTID;
      AddTA98Line( AnItem2 );
      Inc( CountTAH );

      // Set line
      ATerm := MyTetra.ASet.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.Text := ATerm;
      MyTetra.ASet.LgCurrent := TAH.MainLang;
      MyTetra.ASet.Query := tSearch.Create( st_Bas );
      MyTetra.ASet.SearchTerm;
      MyTerm := MyTetra.ASet.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr( Current.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace + cEntity
        + cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt + cDQuote +
        cAnr + MyTID + AETAG;
      AnItem.TID := MyTID;
      Inc( CountTAH );
    end else

    // Set tetrahedron, TA98 source at singular
    if ( ( MyTip = tp_genSet ) ) then
    begin

      // Generator line
      MyTetra := TAH.GetTetrahedronByTID(Current.Tetra);
      AnItem2 := TTA98ListItem.Create;
      AnItem2.Value := AnItem.Value;
      AnItem2.ViewCode := TA98Code;
      ATerm := MyTetra.Genr.GetLibelle( lb_Official, TAH.MainLang );
      AnItem2.Text := ATerm;
      MyTetra.Genr.LgCurrent := TAH.MainLang;
      MyTetra.Genr.Query := tSearch.Create( st_Bas );
      MyTetra.Genr.SearchTerm;
      MyTerm := MyTetra.Genr.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem2.Plus := MyTerm.Mandat + MyTerm.Option +
          MyTerm.Bracket;
      AnItem2.Status := 'Set';
      AnItem2.Indent := cEmpty;
      AnItem2.Tetra := Tetra;
      AnItem2.Segment := MySegment;
      AnItem2.SubSegment := MySubSegment;
      MyTID := IntToStr( MyTetra.Genr.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace +
        cEntity + cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt +
        cDQuote + cAnr + MyTID + AETAG;
      AnItem2.TID := MyTID;
      AddTA98Line( AnItem2 );
      Inc( CountTAH );

      // Set line
      ATerm := MyTetra.ASet.GetLibelle( lb_Official, TAH.MainLang );
      AnItem.ViewCode := cEmpty;
      AnItem.Value := cEmpty;
      AnItem.Text := ATerm;
      MyTetra.ASet.LgCurrent := TAH.MainLang;
      MyTetra.ASet.Query := tSearch.Create( st_Bas );
      MyTetra.ASet.SearchTerm;
      MyTerm := MyTetra.ASet.CurrSingle;
      if ( MyTerm <> nil ) then
        AnItem.Plus := MyTerm.Mandat + MyTerm.Option + MyTerm.Bracket;
      AnItem.Tetra := Tetra;
      AnItem.Segment := MySegment;
      AnItem.SubSegment := MySubSegment;
      MyTID := IntToStr( MyTetra.ASet.TID );
      MyTID := AOTAG + cHrefEmpty + cRetroDir + cEntity + cSpace +
        cLgShort[ lt_English ] + cSlash + cTAH + MyTID + cSpace +
        cEntity + cSpace + cLgShort[ lt_English ] + cPeriod + HtmlExt +
        cDQuote + cAnr + MyTID + AETAG;
      AnItem.TID := MyTID;
      Inc( CountTAH );
    end else

    // Reference tetrahedron
    if ( MyTip = tp_ref ) then
    begin
      AnItem.Status := 'Ref';
      if ( not IsAnc ) then
      begin
        AnItem.Error := 'Err 13';
        AnItem.ErrTxt := 'Unused reference entity.';
      end;
    end else

    // Deleted tetrahedron
    if ( MyTip = tp_del ) then
    begin
      AnItem.Status := 'Deleted';
      MyTID := IntToStr( MyTetra.Genr.TID );
      AnItem.TID := MyTID;
    end;
    AddTA98Line( AnItem );
    Inc( CountTA98 );

    // Check for continuation of the list
    Inc( TID );
    Current := TAH.GetEntityByTID( TID );
    MyRec := TAH.TA98List.GetTA98( TID );
    NewSection := Copy( Current.Cod98, 1, 8 );
    NewSub := Copy( Current.Cod98, 1, 5 );
    EndShort := ( StartTID <> MyRec.List );
    EndSect := ( Section <> NewSection );
    if ( EndSect ) then
      Section := NewSection;
    EndSub := ( SubChap <> NewSub );
    EndChap := ( Chap <> Copy( Current.Cod98, 1, 3 ) );
    Terminated := ( ( Recurs = md_short ) and ( EndShort ) and
      ( ModeInit = md_short ) );
    Terminated := Terminated or ((Recurs = md_sect) and (EndSect) and
      (ModeInit = md_sect));
    Terminated := Terminated or ((Recurs = md_subchap) and (EndSub) and
      (ModeInit = md_subchap));
    Terminated := Terminated or ((Recurs = md_chap) and (EndChap) and
      (ModeInit = md_chap));

    // Call of consecutive subchapters for making a chapter
    if ((EndSub) and (Recurs = md_chap) and (not Terminated)) then
    begin
      SubChap := NewSub;
      MakeTA98List(TID, ModeInit, Recurs, Section, SubChap, Chap, CountTA98,
        CountTAH, StoreNote, TotNote);
      Exit;
    end;

    // Call of consecutive sections for making a subchapter
    if ((EndSect) and ((Recurs = md_subchap) or (Recurs = md_chap)) and
      (not Terminated)) then
    begin
      Section := NewSection;
      MakeTA98List(TID, ModeInit, md_subchap, NewSection, SubChap, Chap,
        CountTA98, CountTAH, StoreNote, TotNote);
      Exit;
    end;

    // Call of consecutive subsections for making a section
    if ((EndShort) and (Recurs = md_sect) and (not Terminated)) then
    begin
      MakeTA98List(TID, ModeInit, md_sect, Section, SubChap, Chap, CountTA98,
        CountTAH, StoreNote, TotNote);
      Exit;
    end;
    First := False;
  until ( Terminated );
end; // ____________________________________________________________MakeTA98List

procedure                tVocSection.MakeListByWordType(
  LexType:               tLexType;
  MyWordList:            tWordList;
  var Count:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeListByWordType
  * Make a list of occurences by word type *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbOcc:           Integer;
  MyUID:           Integer;
  First:           Boolean;
  MyNoun:          String;
  MyAdjective:     String;
  MyPrefix:        String;
  MyPattern:       String;
  MyMatch:         String;
  MyTerm:          String;
  MyBubble:        String;
  MyUniv:          String;
  MyInt:           String;
  MyEntity:        tEntity;
  AnItem:          tBiColItem;
  MyUnit:          tUnit;
  MyOccurence:     OccRec;
  MyType:          tLibelleType;
begin

  // Initial stuff
  NbOcc := MyWordList.NbWord - 1 - MyWordList.NbPlus;
  MyEntity := TAH.GetEntityByTID( MyWordList.Trigger );
  MyNoun := MyEntity.GetVocabulary( TAH.MainLang, st_Nou );
  MyAdjective := MyEntity.GetVocabulary( TAH.MainLang, st_Adj );
  MyPrefix := MyEntity.GetVocabulary( TAH.MainLang, st_Pre );

  // Get the display values by type of word
  if ( LexType = lx_noun ) then
  begin
    MyMatch := 'N';
    MyPattern := MyNoun;
    MyInt := TAH.GetLabel( reByNoun );
    MyBubble := TAH.GetLabel( buByNoun );
  end else
  if ( LexType = lx_compl ) then
  begin
    MyMatch := 'C';
    MyPattern := MyNoun;
    MyInt := 'by noun complement';
    MyBubble := cEmpty;
  end else
  if ( LexType = lx_adj ) then
  begin
    MyMatch := 'A';
    MyPattern := MyAdjective;
    MyInt := TAH.GetLabel( reByAdjective );
    MyBubble := TAH.GetLabel( buByAdjective );
  end else
  if ( LexType = lx_pref ) then
  begin
    MyMatch := 'P';
    MyPattern := MyPrefix;
    MyInt := TAH.GetLabel( reByPrefix );
    MyBubble := TAH.GetLabel( buByPrefix );
  end;

  // Display the list of occurences
  First := True;
  for Indx := 0 to NbOcc do
  begin
    MyOccurence := MyWordList.Occur[ Indx ];
    if ( Length( MyOccurence.Match ) <> 4 ) then
      Continue;
    if ( MyOccurence.Match[ 1 ] <> MyMatch ) then
      Continue;
    MyUID := MyOccurence.UID;
    MyUnit := TAH.GetUnitByPos( MyUID );

    // Skip the deleted entities
    MyEntity := nil;
    if ( MyUnit <> nil ) then
      MyEntity := TAH.GetEntityByPos( MyUnit.Generator );
    if ( ( MyEntity = nil ) {or
         ( MyEntity.TetraTip = tp_Del )} ) then
      Continue;

    // Display header word before the first occurence
    if ( First ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := MyInt;
      AnItem.AltLabel := MyBubble;
      AnItem.Value := MyPattern;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := TAH.MainLang;
      AddItem( AnItem );
      First := False;
    end;

    // Search for the preferred term
    MyType := lb_undef;
    if ( MyOccurence.Match[ 3 ] = 'M' ) then
      MyType := lb_Official
    else
    if ( MyOccurence.Match[ 3 ] = '1' ) then
      MyType := lb_synonym
    else
    if ( MyOccurence.Match[ 3 ] = '2' ) then
      MyType := lb_synonym2
    else
    if ( MyOccurence.Match[ 3 ] = '3' ) then
      MyType := lb_synonym3;
    MyTerm := MyEntity.GetLibelle( MyType, TAH.MainLang );
    if ( ( MyTerm <> cEmpty ) and
         ( MyTerm[ Length( MyTerm ) ] <> cCopyRights ) ) then
    begin
      MyUniv := MyEntity.GetLibelle( lb_Universal, TAH.MainLang );
      if ( MyUniv <> cEmpty ) then
        MyTerm := MyTerm + cSpace + cRol + MyUniv + cRor;
    end;
    MyBubble := MyEntity.GetLibelle( MyType, TAH.SubstLang );

    // Display the word occurence
    AnItem := TBiColItem.Create;
    AnItem.SrcLabel := IntToStr( MyUID ) + cSlash +
                       MyOccurence.Match + cSpace +
                       cTetraEN[ MyUnit.TypUnit ];
    AnItem.AltLabel := cEmpty;
    AnItem.Value := MyTerm;
    AnItem.Bubble := MyBubble;
    AnItem.Indent := cBaseIndent;
    AnItem.Color := TAH.MainLang;
    AddItem( AnItem );
    Inc( Count );
  end; // on all existing formulas
end; // ______________________________________________________MakeListByWordType

procedure                tVocSection.DisplaySupList(
  var Count:             Integer;
  SupList:               tSupList );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DisplaySupList
  * Display the supplementary list *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  MaxString        = 250;
var
  Indx:            Integer;
  NbStr:           Integer;
  TotSup:          Integer;
  MyUID:           Integer;
  First:           Boolean;
  MyMatch:         String;
  MyTerm:          String;
  MyBubble:        String;
  MyOccurence:     OccRec;
  MyEntity:        tEntity;
  MyUnit:          tUnit;
  AnItem:          tBiColItem;
  ATerm:           tSingle;
begin

  // Initial stuff
  TotSup := SupList.NbSup;
  First := True;
  NbStr := 0;

  // Loop on all occurences of the supplementary list
  for Indx := 0 to TotSup - 1 do
  begin

    // Get the next occurence
    MyOccurence := SupList.Occur[ Indx ];
    MyMatch := MyOccurence.Match[ 3 ];
    if ( ( MyMatch <> 'B' ) and
         ( MyMatch <> 'R' ) and
         ( MyMatch <> 'I' ) ) then
      Continue;
    MyUID := MyOccurence.UID;
    MyUnit := TAH.GetUnitByPos( MyUID );
    MyEntity := nil;
    if ( MyUnit <> nil ) then
      MyEntity := TAH.GetEntityByPos( MyUnit.Generator );
    if ( MyEntity = nil ) then
      Continue;

    // Display header
    if ( First ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := 'Vocabulary by string';
      AnItem.AltLabel := cEmpty;
      AnItem.Value := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := lt_Latin;
      AddItem( AnItem );
      First := False;
    end;

    // Display the occurence
    if ( NbStr <= MaxString ) then
    begin
      MyTerm := MyEntity.GetLibelle( lb_Official, TAH.MainLang );
      MyBubble := MyEntity.GetLibelle( lb_Official, TAH.SubstLang );
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := IntToStr( MyUID ) + cSlash + MyOccurence.Match;
      AnItem.AltLabel := cEmpty;
      AnItem.Value := MyTerm;
      AnItem.Bubble := MyBubble;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := TAH.MainLang;

      // Search for first synonym
      MyEntity.LgCurrent := TAH.MainLang;
      MyEntity.Query := tSearch.Create( st_Off );
      MyEntity.Query.SynPos := 0;
      MyEntity.SearchTerm;
      ATerm := MyEntity.CurrSingle;
      if ( ATerm <> nil ) then
        AnItem.Value := AnItem.Value + cSemi + cSpace + ATerm.Mandat;
      AddItem( AnItem );
    end;

    // Display the limit of the list when reached
    if ( NbStr = MaxString ) then
    begin
      AnItem := TBiColItem.Create;
      AnItem.SrcLabel := cEmpty;
      AnItem.AltLabel := cEmpty;
      AnItem.Value := '... more than' + cSpace +
                      IntToStr( MaxString ) + cSpace +
                      'string items';
      AnItem.Bubble := cEmpty;
      AnItem.Indent := cBaseIndent;
      AnItem.Color := TAH.MainLang;
      AddItem( AnItem );
    end;
    Inc( Count );
    Inc( NbStr );
  end; // on all occurences of the supplementary list
end; // __________________________________________________________DisplaySupList

procedure          tIdSection.Build;
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tIdSection.Build
  * Make an identification section *
  Description:
  This section specifies identification information about either a unit or an
  entity, depending on the type of page owning this section. It is used by
  several pages.</P>
  There are six possible items in this section. They are:</P>
  - The Latin official term,
  - The main language equivalent (only if not Latin)
  - The substitution language equivalent,
  - The unique entity or unit identifier,
  - The entity or unit type,
  - The materiality of entity or unit.</P>
  The displayed information is dependant on the category of owner page.</P>
  This section is a descendant of tBiColSection and each line is prepared as
  a tBiColItem record.</p>
  StandardDoc/17.02.2021
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsRef:           Boolean;
  Value:           String;
  Bubble:          String;
  AnItem:          tBiColItem;
  Main:            tEntity;
  MainRef:         tEntity;
  MyUnit:          tUnit;
  LgMain:          tLanguage;
  LgSubst:         tLanguage;
begin

  // Retrieve the entity of the page to which belongs the present section
  Main := Self.Entity;
  MyUnit := TAH.GetUnitByPos( Main.Tetra );
  IsRef := Main.TetraTip = tp_ref;
  MainRef := TAH.GetEntityByPos( Main.Reference );
  LgMain := TAH.MainLang;
  LgSubst := TAH.SubstLang;
  if ( Main <> nil ) then
  begin

    // First item: Latin official term.
    // Mandatory on all pages unless empty, as for non-physical entities
    if ( IsRef ) then
      Value := MainRef.GetLibelle( lb_Official, lt_Latin, st_undef, False )
    else
    begin
      if ( Main.TetraTip = tp_int ) then
        Value := Main.GetLibelle( lb_Title, lt_Latin, st_undef, False )
      else
        Value := Main.GetLibelle( lb_Official, lt_Latin, st_undef, False );
    end;
    if ( Value <> cEmpty ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AnItem.SrcLabel := TAH.GetLabel( reLibOffLatin );
      AnItem.AltLabel := TAH.GetBubble( reLibOffLatin );
      AddItem( AnItem );
    end;

    // Second item: Language equivalent term in main language if not Latin
    // Mandatory on all pages but Latin page
    if ( TAH.MainLang <> lt_Latin ) then
    begin
      if ( IsRef ) then
        Value := MainRef.GetLibelle( lb_Official, LgMain, st_undef, False)
      else
        if ( Main.TetraTip = tp_int ) then
          Value := Main.GetLibelle( lb_Title, LgMain, st_undef, False )
        else
          Value := Main.GetLibelle( lb_Official, LgMain, st_undef, False );
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLibOffTerm );
      AnItem.AltLabel := TAH.GetBubble( reLibOffTerm );
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AddItem( AnItem );
    end;

    // Third item: Language equivalent term in substitution language
    // Mandatory on all pages but Latin page
    if ( ( Self.PageType <> ca_Latin ) and ( LgSubst <> lt_Latin ) ) then
    begin
      if ( Main.TetraTip = tp_int ) then
        Value := Main.GetLibelle( lb_Title, LgSubst, st_undef, False )
      else
        Value := Main.GetLibelle( lb_Official, LgSubst, st_undef, False );
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLibEquivTerm );
      AnItem.AltLabel := TAH.GetBubble( reLibEquivTerm );
      AnItem.Value := Value;
      AnItem.Bubble := cEmpty;
      AddItem( AnItem );
    end;

    // Fourth item: unique identifier of the unit or the entity
    // Mandatory
    AnItem := tBiColItem.Create;
    case Self.PageType of
      ca_Tetra, ca_Segment, ca_Valid:
        begin
          AnItem.SrcLabel := TAH.GetLabel( reLibUnitID );
          AnItem.AltLabel := TAH.GetBubble( reLibUnitID );
          AnItem.Value := cTAHUnit + IntToStr( Main.Tetra );
        end;
      ca_Entity, ca_Extended, ca_Latin, ca_Definition:
        begin
          AnItem.SrcLabel := TAH.GetLabel( reLibEntityID );
          AnItem.AltLabel := TAH.GetBubble( reLibEntityID );
          AnItem.Value := cTAHEntity + IntToStr( Main.TID );
        end;
    end; // case
    AnItem.Bubble := cEmpty;
    AddItem( AnItem );

    // Fifth item: type of entity or unit
    // Mandatory on Definition, Segmentation, Validation and Entity page
    if ( Self.PageType in
         [ ca_Definition, ca_Segment, ca_Valid, ca_Entity ] ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLibTypeEntity );
      AnItem.AltLabel := TAH.GetBubble( reLibTypeEntity );
      Self.MakeTypeOfEntity( Main.TID, LgMain, Value, Bubble );
      AnItem.Value := Value;
      AnItem.Bubble := Bubble;
      AddItem( AnItem );
    end

    // Mandatory on Unit page
    else if ( Self.PageType = ca_Tetra ) then
    begin
      AnItem := tBiColItem.Create;
      AnItem.SrcLabel := TAH.GetLabel( reLibTypeUnit );
      AnItem.AltLabel := TAH.GetBubble( reLibTypeUnit, False );
      Self.MakeTypeOfUnit( Main.TID, LgMain, Value, Bubble );
      AnItem.Value := Value;
      AnItem.Bubble := Bubble;
      AddItem( AnItem );
    end;

    // Sixth item: materiality or non physical entity
    // Mandatory
    AnItem := tBiColItem.Create;
    AnItem.SrcLabel := TAH.GetLabel( reLibMaterial );
    AnItem.AltLabel := TAH.GetBubble( reLibMaterial, False );
    case MyUnit.Material of
      ma_mat:
        begin
          AnItem.Value := TAH.GetLabel( reValGenusMat, False );
          AnItem.Bubble := TAH.GetBubble( reValGenusMat, False );
        end;
      ma_imm, ma_surf, ma_line, ma_point:
        begin
          AnItem.Value := TAH.GetLabel( reValGenusImm, False );
          AnItem.Bubble := TAH.GetBubble( reValGenusImm, False );
        end;
      ma_non:
        begin
          AnItem.Value := TAH.GetLabel( reValGenusNon, False );
          AnItem.Bubble := TAH.GetBubble( reValGenusNon, False );
        end;
    end;
    AddItem( AnItem );
  end;
end; // ________________________________________________________tIdSection.Build

procedure          tIntSection.Build;
{ <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tIntSection.Build
  * Make an interface section *
  Description:
  This section displays the interface texts in all available display
  languages.</p>
  There are possibly three texts in an interface entity: a value text, a
  bulla for help at first level, and a title.</p>
  StandardDoc/01.03.2021
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyText:          Integer;
  MyBubble:        String;
  Indx:            tLanguage;
  AnItem:          tBiColItem;
  Main:            tEntity;
  MyUnit:          tUnit;
begin

  // Retrieve the entity of the page to which belongs the present section
  Main := Self.Entity;
  MyUnit := TAH.GetUnitByPos( Main.Tetra );
  if ( Main <> nil ) then
  begin

    // Display the interface languages
    for Indx := lt_English to lt_Russian do
    begin

      // Retrieve the value text
      AnItem := tBiColItem.Create;
      AnItem.Value := TAH.GetLabel( Main.TID, True, Indx );
      MyBubble := TAH.GetBubble( Main.TID, True, Indx );
      AnItem.Bubble := MyBubble;
      case Indx of
        lt_English: MyText := reInterfaceEN;
        lt_French:  MyText := reInterfaceFR;
        lt_Spanish: MyText := reInterfaceES;
        lt_Russian: MyText := reInterfaceRU;
        else        MyText := 0;
      end; // case
      if ( MyText > 0 ) then
      begin
        AnItem.SrcLabel := TAH.GetLabel( MyText );
        AnItem.AltLabel := TAH.GetBubble( MyText );
      end else
      begin
        AnItem.SrcLabel := cEmpty;
        AnItem.AltLabel := cEmpty;
      end;
      AddItem( AnItem );

      // Display the bubble text
      AnItem := tBiColItem.Create;
      AnItem.Value := MyBubble;
      AnItem.Bubble := cEmpty;
      AnItem.SrcLabel := cEmpty;
      AnItem.AltLabel := cEmpty;
      AddItem( AnItem );
    end; // for on all display languages
  end;
end; // _______________________________________________________tIntSection.Build

function           tRuleSection.GetNbRule()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbRule
  * Retrieve the number of applicable rules *
  Description:
  This function retrieves the rule array to be used according to
  the language and the section type, and returns its length.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbRule:          Integer;
  Lang:            tLanguage;
begin
  Lang := TAH.MainLang;
  NbRule := 0;
  case Lang of
    lt_English:
      begin
        case SectionType of
          sc_FreeNounPlural, sc_RuleNounPlural:
            NbRule := Length( cNounRuPluralEN );
        end;
      end;
    lt_French:
      begin
        case SectionType of
          sc_FreeAdjGender, sc_RuleAdjGender:
            NbRule := Length( cAdjRuGenderFR );
          sc_FreeNounGender, sc_RuleNounGender:
            NbRule := Length( cNounRuGenderFR );
          sc_FreeAdjPlural, sc_FreeNounPlural, sc_RuleAdjPlural,
          sc_RuleWordPlural:
            NbRule := Length( cWordRuPluralFR );
          sc_FreeAdjExp, sc_RuleAdjExp:
            NbRule := Length( cAdjRuExpFR );
        end;
      end;
    lt_Spanish:
      begin
        case SectionType of
          sc_FreeAdjGender, sc_RuleAdjGender:
            NbRule := Length( cAdjRuGenderES );
          sc_FreeNounPlural, sc_RuleNounPlural:
            NbRule := Length( cWordRuPluralES );
          sc_FreeNounGender, sc_RuleNounGender:
            NbRule := Length( cNounRuGenderES );
        end;
      end;
    lt_Russian:
      begin
        case SectionType of
          sc_FreeNounGender, sc_RuleNounGender:
            NbRule := Length( cNounRuGenderRU );
          sc_FreeAdjGender, sc_RuleAdjGender:
            NbRule := Length( cAdjRuGenderRU );
          sc_FreeNounPlural, sc_RuleNounPlural:
            NbRule := Length( cNounRuPluralRU );
          sc_FreeAdjPlural, sc_RuleAdjPlural:
            NbRule := Length( cAdjRuPluralRU );
        end;
      end;
  end; // case on all languages
  Result := NbRule;
end; // _______________________________________________________________GetNbRule

function           tTestSection.GetNbTest()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbTest
  * Retrieve the number of controled tests *
  Description:
  This function retrieves the controled tests array to be used according to
  the language and the section type, and returns its length.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbTest:          Integer;
  Lang:            tLanguage;
begin
  Result := 0;
  Lang := TAH.MainLang;
  NbTest := 0;
  case Lang of
    lt_Latin:
      begin
        case Self.SectionType of
          sc_TestNounGender: NbTest := Length( cNounChGenderLA );
          sc_TestAdjGender:  NbTest := Length( cAdjChGenderLA );
          sc_TestNounPlural: NbTest := Length( cNounChPluralLA );
          sc_TestAdjPlural:  NbTest := Length( cAdjChPluralLA );
          sc_TestNounGenSin: NbTest := Length( cNounChGenSinLA );
          sc_TestAdjGenSin:  NbTest := Length( cAdjChGenSinLA );
          sc_TestNounGenPlu: NbTest := Length( cNounChGenPluLA );
          sc_TestAdjGenPlu:  NbTest := Length( cAdjChGenPluLA );
          sc_TestNoExp:      NbTest := Length( cNoChExpLA );
          sc_TestAdjExp:     NbTest := Length( cAdjChExpLA );
          sc_TestMandExp:    NbTest := Length( cMandChExpLA );
          sc_TestLatExp:     NbTest := Length( cLatChExpLA );
          sc_TestOptExp:     NbTest := Length( cOptChExpLA );
        end; // case on all section types
      end;
    lt_English:
      begin
        case Self.SectionType of
          sc_TestNounPlural: NbTest := Length( cNounChPluralEN );
          sc_TestNoExp:      NbTest := Length( cNoChExpEN );
          sc_TestAdjExp:     NbTest := Length( cAdjChExpEN );
          sc_TestMandExp:    NbTest := Length( cMandChExpEN );
          sc_TestOptExp:     NbTest := Length( cOptChExpEN );
          sc_TestLatExp:     NbTest := Length( cLatChExpEN );
        end;
      end;
    lt_French:
      begin
        case Self.SectionType of
          sc_TestNounGender: NbTest := Length( cNounChGenderFR );
          sc_TestAdjGender:  NbTest := Length( cAdjChGenderFR );
          sc_TestNounPlural: NbTest := Length( cNounChPluralFR );
          sc_TestAdjPlural:  NbTest := Length( cAdjChPluralFR );
          sc_TestNoExp:      NbTest := Length( cNoChExpFR );
          sc_TestAdjExp:     NbTest := Length( cAdjChExpFR );
          sc_TestMandExp:    NbTest := Length( cMandChExpFR );
          sc_TestLatExp:     NbTest := Length( cLatChExpFR );
          sc_TestOptExp:     NbTest := Length( cOptChExpFR );
        end;
      end;
    lt_Spanish:
      begin
        case Self.SectionType of
          sc_TestNounPlural: NbTest := Length( cNounChPluralES );
          sc_TestAdjGender:  NbTest := Length( cAdjChGenderES );
          sc_TestAdjExp:     NbTest := Length( cAdjChExpES );
        end;
      end;
    lt_Russian:
      begin
        case Self.SectionType of
          sc_TestNounGender: NbTest := Length( cNounChGenderRU );
          sc_TestAdjGender:  NbTest := Length( cAdjChGenderRU );
          sc_TestNounPlural: NbTest := Length( cNounChPluralRU );
          sc_TestAdjPlural:  NbTest := Length( cAdjChPluralRU );
          sc_TestNoExp:      NbTest := NbNoChExpRU;
          sc_TestAdjExp:     NbTest := Length( cAdjChExpRU );
          sc_TestMandExp:    NbTest := NbMandChExpRU;
          sc_TestLatExp:     NbTest := NbLatChExpRU;
          sc_TestOptExp:     NbTest := NbOptChExpRU;
        end;
      end;
  end; // case on all languages
  Result := NbTest;
end; // _______________________________________________________________GetNbTest

procedure          tTestSection.SetTestHeading(
  AnItem:          tBicolItem );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetTestHeading
  * Retrieve the headings for controled tests *
  Description:
  This procedure adds a head line to any controled test. The left column
  label is accompanied by an explicative buble. It provides a specific
  answer depending on the language and the type of section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Lang:            tLanguage;
begin
  Lang := TAH.MainLang;
  case Self.SectionType of

    // Gender of nouns
    sc_TestNounGender, sc_TestAdjGender:
      begin
        AnItem.SrcLabel := TAH.GetLabel( reTestSize, False );
        AnItem.AltLabel := TAH.GetBubble( reTestSize, False );
      end;

    // Nominative plural of nouns
    sc_TestNounPlural:
      case Lang of
        lt_Latin:
          begin
            AnItem.SrcLabel := 'Test plural of Latin nouns';
            AnItem.AltLabel := 'Nominative plural nouns are retrieved from ' +
                               'the Latin dictionary';
          end;
        lt_English:
          begin
            AnItem.SrcLabel := 'Test plural of English nouns';
            AnItem.AltLabel := 'Nominative plural nouns are computed on ' +
                               'rules and exceptions basis';
          end;
        lt_French:
          begin
            AnItem.SrcLabel := 'Test plural of French nouns';
            AnItem.AltLabel := 'Nominative plural nouns are computed on ' +
                               'rules and exceptions basis';
          end;
        lt_Spanish:
          begin
            AnItem.SrcLabel := 'Test plural of Spanish nouns';
            AnItem.AltLabel := 'Nominative plural nouns are computed on ' +
                               'rules and exceptions basis';
          end;
        lt_Russian:
          begin
            AnItem.SrcLabel := 'Test plural of Russian nouns';
            AnItem.AltLabel := 'Nominative plural nouns are computed on ' +
                               'rules and exceptions basis';
          end;
      end;  // case on all language

    // Variation by gender of nominative plural adjectives
    sc_TestAdjPlural:
      case Lang of
        lt_Latin:
          begin
            AnItem.SrcLabel := 'Test plural of Latin adjectives';
            AnItem.AltLabel := 'Nominative plural adjectives are retrieved ' +
                               'from the Latin dictionary';
          end;
        lt_English:
          begin
            AnItem.SrcLabel := 'Test plural of English adjectives';
            AnItem.AltLabel := 'Nominative plural adjectives are computed on ' +
                               'rules and exceptions basis';
          end;
        lt_French:
          begin
            AnItem.SrcLabel := 'Test plural of French adjectives';
            AnItem.AltLabel := 'Nominative plural adjectives are computed on ' +
                               'rules and exceptions basis';
          end;
        lt_Spanish:
          begin
            AnItem.SrcLabel := 'Test plural of Spanish adjectives';
            AnItem.AltLabel := 'Nominative plural adjectives are computed on ' +
                               'rules and exceptions basis';
          end;
        lt_Russian:
          begin
            AnItem.SrcLabel := 'Test plural of Russian adjectives';
            AnItem.AltLabel := 'Nominative plural adjectives are computed on ' +
                               'rules and exceptions basis';
          end;
      end;  // case on all language

    // Genitive singular of nouns
    sc_TestNounGenSin:
      case Lang of
        lt_Latin:
          begin
            AnItem.SrcLabel := 'Test genitive singular of Latin nouns';
            AnItem.AltLabel := 'Genitive singular nouns are retrieved ' +
                               'from the Latin dictionary';
          end;
        lt_Russian:
          begin
            AnItem.SrcLabel := 'Test genitive singular of Russian nouns';
            AnItem.AltLabel := 'Genitive singular nouns are computed on ' +
                               'rules and exceptions basis';
          end;
      end;  // case on all language

    // Variation of adjectives at genitive singular
    sc_TestAdjGenSin:
      case Lang of
        lt_Latin:
          begin
            AnItem.SrcLabel := 'Test genitive singular of Latin adjectives';
            AnItem.AltLabel := 'Genitive singular adjectives are retrieved ' +
                               'from the Latin dictionary';
          end;
        lt_Russian:
          begin
            AnItem.SrcLabel := 'Test genitive singular of Russian adjectives';
            AnItem.AltLabel := 'Genitive singular adjectives are computed on ' +
                               'rules and exceptions basis';
          end;
      end;  // case on all language

    // Genitive plural of nouns
    sc_TestNounGenPlu:
      case Lang of
        lt_Latin:
          begin
            AnItem.SrcLabel := 'Test genitive plural of Latin nouns';
            AnItem.AltLabel := 'Genitive plural nouns are retrieved ' +
                               'from the Latin dictionary';
          end;
        lt_Russian:
          begin
            AnItem.SrcLabel :=  'Test genitive plural of Russian nouns';
            AnItem.AltLabel := 'Genitive plural nouns are computed on ' +
                               'rules and exceptions basis';
          end;
      end;  // case on all language

    // Variation of adjectives at genitive plural:
    sc_TestAdjGenPlu:
      case Lang of
        lt_Latin:
          begin
            AnItem.SrcLabel := 'Test genitive plural of Latin adjectives';
            AnItem.AltLabel := 'Genitive plural adjectives are retrieved ' +
                               'from the Latin dictionary';
          end;
        lt_Russian:
          begin
            AnItem.SrcLabel := 'Test genitive plural of Russian adjectives';
            AnItem.AltLabel := 'Genitive plural adjectives are computed on ' +
                               'rules and exceptions basis';
          end;
      end;  // case on all language

    // No expansion
    sc_TestNoExp:
      begin
        AnItem.SrcLabel := 'Extension of the test';
        AnItem.AltLabel := 'Number of pairs request - expected value ' +
                           'submitted to the test';
      end;

    // Adjective expansion
    sc_TestAdjExp:
      begin
        AnItem.SrcLabel := 'Extension of the test';
        AnItem.AltLabel := 'Number of pairs request - expected value ' +
                           'submitted to the test';
      end;

    // Mandatory expansion
    sc_TestMandExp:
      begin
        AnItem.SrcLabel := 'Extension of the test';
        AnItem.AltLabel := 'Number of pairs request - expected value ' +
                           'submitted to the test';
      end;

    // Optional expansion
    sc_TestOptExp:
      begin
        AnItem.SrcLabel := 'Extension of the test';
        AnItem.AltLabel := 'Number of pairs request - expected value ' +
                           'submitted to the test';
      end;

    // Lateral expansion
    sc_TestLatExp:
      begin
        AnItem.SrcLabel := 'Extension of the test';
        AnItem.AltLabel := 'Number of pairs request - expected value ' +
                           'submitted to the test';
      end;
  end;
end; // __________________________________________________________SetTestHeading

procedure          tFreeTestSection.SetFreeHeading;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFreeHeading
  * Retrieve the headings for free tests *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  AnItem:          tBiColItem;
  Lang:            tLanguage;
begin
  AnItem := tBiColItem.Create;
  Lang := TAH.MainLang;
  case SectionType of
    sc_FreeNounGender: AnItem.SrcLabel := TAH.GetLabel( reTestSize, False );
    sc_FreeAdjGender:
      begin
        case Lang of
          lt_French: AnItem.SrcLabel := 'Free test of gender of French adjectives';
          lt_Spanish: AnItem.SrcLabel := 'Free test of gender of Spanish adjectives';
          lt_Russian: AnItem.SrcLabel := 'Free test of gender of Russian adjectives';
        end;
      end;
    sc_FreeNounPlural:
      begin
        case Lang of
          lt_Latin:
            begin
              AnItem.SrcLabel := 'Extension';
              AnItem.AltLabel := 'This test includes all Latin nouns ' +
                                 'resulting from the existing vocabulary units';
            end;
          lt_English:
            begin
              AnItem.SrcLabel := 'Extension';
              AnItem.AltLabel := 'This test includes all English nouns ' +
                                 'resulting from the existing vocabulary units';
            end;
          lt_French:
            begin
              AnItem.SrcLabel := 'Extension';
              AnItem.AltLabel := 'This test includes all French nouns ' +
                                 'resulting from the existing vocabulary units';
            end;
          lt_Spanish:
            begin
              AnItem.SrcLabel := 'Extension';
              AnItem.AltLabel := 'This test includes all Spanish nouns ' +
                                 'resulting from the existing vocabulary units';
            end;
          lt_Russian:
            begin
              AnItem.SrcLabel := 'Extension';
              AnItem.AltLabel := 'This test includes all Russian nouns ' +
                                 'resulting from the existing vocabulary units';
            end;
        end;
      end;
    sc_FreeAdjPlural:
      begin
        case Lang of
          lt_French: AnItem.SrcLabel := 'Free test of plural of French adjectives';
          lt_Spanish: AnItem.SrcLabel := 'Free test of plural of Spanish adjectives';
          lt_Russian: AnItem.SrcLabel := 'Free test of plural of Russian adjectives';
        end;
      end;
    sc_FreeNounGenSin:
      begin
        case Lang of
          lt_Latin: AnItem.SrcLabel := 'Found entries';
          lt_French: AnItem.SrcLabel := 'Free test of genitive singular nouns';
          lt_Spanish: AnItem.SrcLabel := 'Free test of genitive singular nouns';
          lt_Russian: AnItem.SrcLabel := 'Free test of genitive singular nouns';
        end;
      end;
    sc_FreeAdjGenSin:
      begin
        case Lang of
          lt_French: AnItem.SrcLabel := 'Free test of genitive singular of French adjectives';
          lt_Spanish: AnItem.SrcLabel := 'Free test of genitive singular of Spanish adjectives';
          lt_Russian: AnItem.SrcLabel := 'Free test of genitive singular of Russian adjectives';
        end;
      end;
    sc_FreeNounGenPlu:
      begin
        case Lang of
          lt_Latin: AnItem.SrcLabel := 'Free test of genitive plural of Latin nouns';
          lt_French: AnItem.SrcLabel := 'Free test of genitive plural of French nouns';
          lt_Spanish: AnItem.SrcLabel := 'Free test of genitive plural of Spanish nouns';
          lt_Russian: AnItem.SrcLabel := 'Free test of genitive plural of Russian nouns';
        end;
      end;
    sc_FreeAdjGenPlu:
      begin
        case Lang of
          lt_French: AnItem.SrcLabel := 'Free test of genitive plural of French adjectives';
          lt_Spanish: AnItem.SrcLabel := 'Free test of genitive plural of Spanish adjectives';
          lt_Russian: AnItem.SrcLabel := 'Free test of genitive plural of Russian adjectives';
        end;
      end;
  end; // case
  AnItem.Value := IntToStr( FNbTest ) + cSpace +
                  TAH.GetLabel( reTestEntries, False );
  AddItem( AnItem );
end; // __________________________________________________________SetFreeHeading
end.
