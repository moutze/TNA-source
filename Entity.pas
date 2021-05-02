{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit Entity
  * Class definition of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit Entity;

interface

uses
  System.Classes, StdCtrls, TAHParam, ComCtrls, SysUtils, SingleTerms;

type
  tChildren                  = array of Integer;
  tEntityList                = array of Integer;
  tTermSet                   = array of tSingle;

                             // Class for search package
  tSearch                    = class( TObject )
  private
    fType:                   tSynType;
    fLang:                   tLanguage;
    fDirect:                 Boolean;
    fUniv:                   Boolean;
    fPos:                    Integer;
    procedure                SetType(
                               Value: tSynType );
    procedure                SetLang(
                               Value: tLanguage );
  public
                             // Type of term searched for
    property MyType:         tSynType read fType write SetType;
                             // Language of term searched for
    property MyLang:         tLanguage read fLang write SetLang;
                             //
    property Direct:         Boolean read fDirect write fDirect;
                             //
    property IsUniv:         Boolean read fUniv write fUniv;
                             //
    property SynPos:         Integer read fPos write fPos;
                             // Constructor of the class
    constructor              Create(
                               AType: tSynType );
  end;

                             // Class for a single entity
  tEntity                    = class( TObject )
  private
    fTex:                    String;
    fTID:                    Integer;
    fFID:                    Integer;
    fGen:                    Integer;
    fLgCurr:                 tLanguage;
    fQuery:                  tSearch;
    fSingle:                 tSingle;
    fLATerms:                tTermSet;
    fENTerms:                tTermSet;
    fFRTerms:                tTermSet;
    fESTerms:                tTermSet;
    fRUTerms:                tTermSet;
    fITTerms:                tTermSet;
    fGETerms:                tTermSet;
    fPTTerms:                tTermSet;
    fMDTerms:                tTermSet;
    fSortedChildren:         tChildren;
    fPartHierar:             tEntityList;
    fPos:                    Integer;
    fCod:                    String;
    fCar:                    String;
    fIns:                    Integer;
    fExp:                    Integer;
    fDes:                    String;
    fPst:                    String;
    fNbc:                    Integer;
    fSeq:                    Integer;
    fE98:                    Integer;
    fD98:                    String;
    fP98:                    String;
    fN98:                    Integer;
    fS98:                    Integer;
    fIsa:                    Integer;
    fTes:                    String;
    fTst:                    String;
    fNbt:                    Integer;
    fOrd:                    Integer;
    fPis:                    Integer;
    fChl:                    String;
    fRes:                    String;
    fRst:                    String;
    fRbt:                    Integer;
    fTyp:                    tType;
    fLnk:                    tLink;
    fVer:                    tVersion;
    fLev:                    tLevel;
    fDis:                    tDisplay;
    fLat:                    tLaterality;
    fGnr:                    Boolean;
    fAct:                    Boolean;
    fIcs:                    Boolean;
    fMdt:                    Boolean;
    fBil:                    Boolean;
    fMul:                    Boolean;
    fF98xxx:                 Boolean;
    fM98xxx:                 Boolean;
    fDimxxx:                 Boolean;
    fFsb:                    Boolean;
    fMsb:                    Boolean;
    fNeo:                    Boolean;
    fImm:                    Boolean;
    fNv1:                    Integer;
    fSq1:                    Integer;
    fSq2:                    Integer;
    fNv3:                    Integer;
    fSq3:                    Integer;
    fNv4:                    Integer;
    fSq4:                    Integer;
    fNv5:                    Integer;
    fSq5:                    Integer;
    fTet:                    Integer;
    fTip:                    tTip;
    fQua:                    String;
    fLis:                    String;
    fLpt:                    String;
    fL98:                    String;
    fLtx:                    String;
    fSex:                    tSexe;
    fDimorph:                Integer;
    fTA98:                   Boolean;

    function                 GetNbLATerm():
                               Integer;
    function                 GetNbENTerm():
                               Integer;
    function                 GetNbFRTerm():
                               Integer;
    function                 GetNbESTerm():
                               Integer;
    function                 GetNbRUTerm():
                               Integer;
    function                 GetNbITTerm():
                               Integer;
    function                 GetNbGETerm():
                               Integer;
    function                 GetNbPTTerm():
                               Integer;
    function                 GetNbMDTerm():
                               Integer;
    function                 GetNbCurrent():
                               Integer;
    function                 GetNbChildren():
                               Integer;
    function                 GetNbPartHierar():
                               Integer;
    function                 GetPartAnc():
                               Integer;
    function                 GetPart98():
                               Integer;
    function                 GetSeq98():
                               Integer;
    function                 GetInternalTex():
                               String;
    function                 GetListPart():
                               String;
    function                 GetListPart98():
                               String;
    function                 GetListTax():
                               String;
    function                 GetTypeEntity():
                               tType;
    function                 GetLink():
                               tLink;
    function                 GetGenerator():
                               Integer;
    function                 GetInconstant():
                               Boolean;
    function                 GetFID():
                               Integer;
    function                 GetRef():
                               Integer;
    function                 GetCod98():
                               String;
    function                 GetNv1():
                               Integer;
    function                 GetSq1():
                               Integer;
    function                 GetNv2():
                               Integer;
    function                 GetSq2():
                               Integer;
    function                 GetNv3():
                               Integer;
    function                 GetSq3():
                               Integer;
    function                 GetNv4():
                               Integer;
    function                 GetSq4():
                               Integer;
    function                 GetNv5():
                               Integer;
    function                 GetSq5():
                               Integer;
    function                 GetTip():
                               tTip;
    function                 GetLevel():
                               tLevel;
    function                 GetPast():
                               Integer;
    function                 GetChange():
                               String;
                             // Check for a generic entity
    function                 IsGenEntity:
                               Boolean;
                             // Retrieve the TID of the generic entity
    function                 GetGeneric:
                               Integer;
                             // Check if entity has an applicable formula
    function                 HasFormula:
                               Boolean;
                             // Retrieve a term in the current language
    function                 GetTerm(
                               Index: Integer )
                               : tSingle;
                             // Set a term in the current language
    procedure                SetTerm(
                               Index: Integer;
                               Value: tSingle );
                             // Retrieve sexe
    function                 GetSexe()
                               : tSexe;
                             // Retrieve dimorphic entity
    function                 GetDimorph()
                               : Integer;
                             // Retrieve TA98 specific entities
    function                 Get98()
                               : Boolean;
                             // Retrieve any partonomic ancestor
    function                 GetPartHierar(
                               Index: Integer )
                               : Integer;
                             // Full partonomy of a single term
    procedure                TermHierarchy(
                               TID: Integer );
                             // Add a member to a partonomic list
    procedure                AddPartHierar(
                               TID: Integer );
  public
                             // Internal name
    property InternalTex:    String read GetInternalTex;
                             // TID unique identifier of entity
    property TID:            Integer read fTID write fTID;
                             // FID unique FMA identifier
    property FID:            Integer read GetFID write fFID;
                             // TID of generator entity
    property Generator:      Integer read GetGenerator write fGen;
                             // Number of Latin terms
    property NbLATerm:       Integer read GetNbLATerm;
                             // Number of English terms
    property NbENTerm:       Integer read GetNbENTerm;
                             // Number of French terms
    property NbFRTerm:       Integer read GetNbFRTerm;
                             // Number of Spanish terms
    property NbESTerm:       Integer read GetNbESTerm;
                             // Number of Russian terms
    property NbRUTerm:       Integer read GetNbRUTerm;
                             // Number of Italian terms
    property NbITTerm:       Integer read GetNbITTerm;
                             // Number of German terms
    property NbGETerm:       Integer read GetNbGETerm;
                             // Number of Portugese terms
    property NbPTTerm:       Integer read GetNbPTTerm;
                             // Number of model terms
    property NbMDTerm:       Integer read GetNbMDTerm;
                             // Number of terms in the current language
    property NbCurrent:      Integer read GetNbCurrent;
                             // Current language
    property LgCurrent:      tLanguage read fLgCurr write fLgCurr;
                             // Query for a single term
    property Query:          tSearch read fQuery write fQuery;
                             // Single term as issued from a search
    property CurrSingle:     tSingle read fSingle write fSingle;
                             // Any term in the current language
    property CurrTerm
      [ Index: Integer ]:    tSingle read GetTerm write SetTerm;
                             // Array of TID of partonomic children
    property SortedChildren: tChildren
                               read fSortedChildren
                               write fSortedChildren;
                             // Number of children
    property NbChildren:     Integer read GetNbChildren;
                             // Any partonomic ancestors
    property PartHierar
      [ Index: Integer ]:    Integer read GetPartHierar;
                             // Number of partonomic ancestor
    property NbPartHierar:   Integer read GetNbPartHierar;
                             // ???
    property Position:       Integer read fPos write fPos;
                             // Flag for generic entity
    property IsGeneric:      Boolean read IsGenEntity;
                             // TID of generic entity (= Generator ???)
    property GenEntity:      Integer read GetGeneric;
                             // Flag for existence of a universal formula
    property IsFormula:      Boolean read HasFormula;
                             // TA98 11-digit code
    property Cod98:          String read GetCod98 write fCod;
                             // Cardinality for composite entities
    property Cardinality:    String read fCar;
                             // TID of a referenced entity
    property Reference:      Integer read GetRef write fIns;
                             // Partonomic ancestor
    property PartAnc:        Integer read GetPartAnc write fExp;
                             // List of partonomic children ;-separated
    property PartCh:         String read fDes write fDes;
                             // Sequence position of partonomic children
    property PartPos:        String read fPst write fPst;
                             // Number of partonomic children
    property NbPartC:        Integer read fNbc write fNbc;
                             // Sequence position of partonomic ancestor
    property PartSeq:        Integer read fSeq write fSeq;
                             // TA98 partonomic ancestor
    property Anc98:          Integer read GetPart98 write fE98;
                             // List of TA98 partonomic children ;-separated
    property Ch98:           String read fD98 write fD98;
                             // Sequence position of TA98 partonomic children
    property Pos98:          String read fP98 write fP98;
                             // Number of TA98 partonomic children
    property NbPart98:       Integer read fN98 write fN98;
                             // Sequence position of TA98 partonomic ancestor
    property Seq98:          Integer read GetSeq98 write fS98;
                             // Taxonomic ancestor
    property TaxAnc:         Integer read fIsa write fIsa;
                             // List of taxonomic children ;-separated
    property TaxCh:          String read fTes write fTes;
                             // Sequence position of taxonomic children
    property TaxPos:         String read fTst write fTst;
                             // Number of taxonomic children
    property NbTaxC:         Integer read fNbt write fNbt;
                             // Sequence position of taxonomic ancestor
    property TaxSeq:         Integer read fOrd write fOrd;
                             // Original FMA taxonomic ancestor
    property PastTaxAnc:     Integer read GetPast;
                             // Type of change to FMA
    property ChLink:         String read GetChange;
                             // ???
    property PastTaxCh:      String read fRes write fRes;
                             // ???
    property PastTaxPos:     String read fRst write fRst;
                             // ???
    property NbPastTaxC:     Integer read fRbt write fRbt;
                             // Entity type
    property TypeEntity:     tType read GetTypeEntity write fTyp;
                             // ???
    property Link:           tLink read GetLink write fLnk;
                             // unused
    property Version:        tVersion read fVer;
                             // unused
    property Level:          tLevel read GetLevel write fLev;
                             // unused
    property Display:        tDisplay read fDis write fDis;
                             // unused
    property Lateral:        tLaterality read fLat;
                             // unused
    property Generic:        Boolean read fGnr;
                             // ???
    property Act:            Boolean read fAct;
                             // Flag for inconstant entity
    property Inconstant:     Boolean read GetInconstant;
                             // Flag for mandatory entity in generic partonomy
    property Mandatory:      Boolean read fMdt;
                             // Flag for bilateral entity
    property Bilateral:      Boolean read fBil write fBil;
                             // unused
    property Mul:            Boolean read fMul;
                             // unused
    property F98xxx:         Boolean read fF98xxx;
                             // unused
    property M98xxx:         Boolean read fM98xxx;
                             // unused
    property Dimorphicxxx:   Boolean read fDimxxx;
                             // unused
    property Fsb:            Boolean read fFsb;
                             // unused
    property Msb:            Boolean read fMsb;
                             // unused
    property Neo:            Boolean read fNeo;
                             // Flag for materiality
    property Immaterial:     Boolean read fImm;
                             // TID of level 1 top entity
    property Niveau1:        Integer read GetNv1;
                             // Position in level 1 list
    property Sequence1:      Integer read GetSq1;
                             // TID of level 2 top entity
    property Niveau2:        Integer read GetNv2;
                             // Position in level 2 list
    property Sequence2:      Integer read GetSq2;
                             // TID of level 3 top entity
    property Niveau3:        Integer read GetNv3;
                             // Position in level 3 list
    property Sequence3:      Integer read GetSq3;
                             // TID of level 4 top entity
    property Niveau4:        Integer read GetNv4;
                             // Position in level 4 list
    property Sequence4:      Integer read GetSq4;
                             // TID of level 5 top entity
    property Niveau5:        Integer read GetNv5;
                             // Position in level 5 list
    property Sequence5:      Integer read GetSq5;
                             // UID unique identifier of recipient unit
    property Tetra:          Integer read fTet write fTet;
                             // Unit type of recipient unit
    property TetraTip:       tTip read GetTip write fTip;
                             // ???
    property TetraQual:      String read fQua;
                             // unused: old system
    property ListPos:        String read fLis;
                             // Type of partonomic list
    property ListPart:       String read GetListPart;
                             // Type of TA98 partonomic list
    property ListPart98:     String read GetListPart98;
                             // Type of taxonomic list
    property ListTax:        String read GetListTax;
                             // Gender associated to the entity
    property Sexe:           tSexe read GetSexe;
                             // TID of alternate entity
    property Dimorph:        Integer read GetDimorph;
                             // TA98 specific entity
    property IsTA98:         Boolean read Get98;

                             // Entity constructor
    constructor              Create;
                             // Make a term from a universal formula
    function                 MakeFormula(
                               AType: tSynType )
                               : Boolean;
                             // Check for existence of a specific term
    function                 IsForTerm(
                               AType: tSynType )
                               : Boolean;
                             // Check for existence of a specific term
    function                 IsSpecificTerm(
                               AType: tSynType )
                               : Integer;
                             // Add a term to an entity
    procedure                AddTerm(
                               MyTerm: tSingle );
                             // Determine if an entity is bilateral
    function                 IsBilateral():
                               Boolean;
                             // Compute the number of children in a hierarchy
    procedure                GetNumberOfChildren(
                               IsTax: Boolean;
                               TA98: Boolean;
                               IsShort: Boolean;
                               var NbChildren: Integer;
                               var NbSpecific: Integer );
                             // Retrieve properties dependant on taxonomy
    procedure                GetHierarProperties(
                               var IsBil: Boolean;
                               var IsMul: Boolean;
                               var IsMat: Boolean;
                               var IsImm: Boolean;
                               var IsNon: Boolean;
                               var IsDim: Boolean;
                               var IsGen: Boolean;
                               var IsSpc: Boolean;
                               var IsPar: Boolean;
                               var IsGtr: Boolean );
                             // Compile the list of taxonomic ancestor
    procedure                GetTaxonomy(
                               var TaxEntity: array of tEntity;
                               var NbTax: Integer );
                             //
    function                 GetChildren(
                               IsTax: Boolean )
                               : String;
                             //
    procedure                SetSortedChild(
                               Pos: Integer;
                               Value: Integer );
                             // Get the libelle of a term
    function                 GetLibelle(
                               LibType: tLibelleType;
                               Lang: tLanguage;
                               SynType: tSynType = st_undef;
                               Short: Boolean = False;
                               IsReg: Boolean = True ):
                               String;
                             // Get a structured term term
    function                 GetStructuredTerm(
                               LibType: tLibelleType;
                               Lang: tLanguage;
                               SynType: tSynType = st_undef ):
                               tSingle;
                             // Get the single representation of a term
    function                 GetSingle(
                               LibType: tLibelleType;
                               Lang: tLanguage;
                               SynType: tSynType = st_undef ):
                               TSingle;
                             // Get vocabulary
    function                 GetVocabulary(
                               Lang: tLanguage;
                               SynType: tSynType )
                               : String;
                             // Check for deleted term
    function                 IsDeletedTerm(
                               SynType: tSynType )
                               : Boolean;
                             // Apply the search package
    procedure                SearchTerm;
  end;

                             // Class for units
  tTetrahedron               = class( TObject )
  private
    fGenr:                   tEntity;
    fMain:                   tEntity;
    fASet:                   tEntity;
    fASin:                   tEntity;
    fADex:                   tEntity;
    fType:                   tTetra;
    fUID:                    Integer;
    fL5ID:                   Integer;
  public
    property Genr:           tEntity read fGenr write fGenr;
    property Main:           tEntity read fMain write fMain;
    property ASet:           tEntity read fASet write fASet;
    property ASin:           tEntity read fASin write fASin;
    property ADex:           tEntity read fADex write fADex;
    property TetraType:      tTetra  read fType write fType;
    property TetraID:        Integer read fUID  write fUID;
    property Level5ID:       Integer read fL5ID write fL5ID;
  end;

implementation

uses
  TAHBrowser, LAProc, ENProc, FRProc, Term, Tetra, List;

constructor        tSearch.Create(
  AType:           tSynType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tSearch.Create/3
  * Constructor of a search package *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited Create;
  Self.FType := AType;
  Self.Direct := False;
  Self.IsUniv := False;
  Self.SynPos := 0;
end; // ________________________________________________________tSearch.Create/3

procedure          tSearch.SetType(
  Value:           tSynType );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetType
  * Change the type of a search package *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.FType := Value;
end; // _________________________________________________________________SetType

procedure          tSearch.SetLang(
  Value:           tLanguage );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetLang
  * Change the language of a search package *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.FLang := Value;
end; // _________________________________________________________________SetLang

constructor        tEntity.Create;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tEntity.Create/0
  * Constructor of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.FTyp := to_Undef;
  Self.FLnk := pw_Undef;
end; // ________________________________________________________tEntity.Create/0

function           tEntity.GetPartAnc()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetPartAnc
  * Retrieve the partonomic ancestor of an entity *
  Description:
  Normally, an explicite value is always present when it exists. A null value
  is possible when the database has not yet been completed.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Gener:           tEntity;
  Father:          tEntity;
begin
  // An explicit value is present
  Result := Self.Fexp;

  // Search of an inferred value
  {if ( Self.Fexp = 0 ) then
  begin

    // Search for a symmetrical pair
    if ( Self.FTip = 3 ) then
    begin
      Gener := TAH.GetEntityByTID( Self.Generator );
      if ( Gener <> nil ) then
      begin
        Father := TAH.GetEntityByTID( Gener.FExp );
        if ( ( Father <> nil ) and ( Father.FTip = 2 ) ) then
        begin
          Self.FExp := Father.Tetra;
          Self.FLnk := pw_PairPartOf;
          Result := Father.Tetra;
        end;
      end;
    end else

    // Search for a left or right member of a symmetrical pair
    if ( ( Self.FTip = 4 ) or ( Self.FTip = 5 ) ) then
    begin
      Self.FExp := Self.FTet;
      if ( Self.FTip = 4 ) then
        Self.FLnk := pw_MemberL
      else
        Self.FLnk := pw_MemberR;
      Result := Self.FTet;
    end;
    Self.FExp := Result;
  end;}
end; // ______________________________________________________________GetPartAnc

function           tEntity.GetPart98()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetPart98
  * Retrieve the TA98 partonomic ancestor of an entity *
  Description:
  This procedure returns the TA98 partonomic ancestor of an entity from its
  storage in the corresponding unit. A zero value is returned when the
  entity does not belong to the TA98 partonomy.</P>
  The first time this value is queried for an entity, because it is zero by
  default, the true value is automatically retrieved and stored for subsequent
  calls.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  Result := Self.FE98;

  // Missing value: search at unit level
  if ( ( Result = 0 ) and ( TAH.DoTA98( Self.TID ) ) ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Part98;
    Self.FE98 := Result;
  end;
end; // _______________________________________________________________GetPart98

function           tEntity.GetSeq98()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSeq98
  * Retrieve the TA98 position of the ancestor of an entity *
  Description:
  This procedure returns the sequence position of theTA98 partonomic ancestor
  of an entity from its storage in the corresponding unit. A zero value is
  returned when the entity does not belong to the TA98 partonomy.</P>
  The first time this value is queried for an entity, because it is zero by
  default, the true value is automatically retrieved and stored for subsequent
  calls.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  Result := Self.FS98;

  // Missing value: search at unit level
  if ( ( Result = 0 ) and ( TAH.DoTA98( Self.TID ) ) ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.SeqPart98;
    Self.FS98 := Result;
  end;
end; // ________________________________________________________________GetSeq98

function           tEntity.GetTerm(
  Index:           Integer )
  :                tSingle;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTerm
  * Retrieve a term in the current language *
  Description:
  This procedure gives access to the terms of the current language by their
  index from 0 to N - 1. The order of the terms is generally not meaningfull
  and only a full scan of all existing term gives evidence to the existence
  of a term.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  LgCurr:          tLanguage;
begin

  // Check the range of the index
  Result := nil;
  if ( ( Index >= 0 ) and ( Index < Self.NbCurrent ) ) then
  begin

    // Retrieve the term
    LgCurr := Self.LgCurrent;    LgCurr := Self.LgCurrent;
    case LgCurr of
      lt_Latin: Result := Self.FLATerms[ Index ];
      lt_English: Result := Self.FENTerms[ Index ];
      lt_French: Result := Self.FFRTerms[ Index ];
      lt_Spanish: Result := Self.FESTerms[ Index ];
      lt_Russian: Result := Self.FRUTerms[ Index ];
      lt_Italian: Result := Self.FITTerms[ Index ];
      lt_German: Result := Self.FGETerms[ Index ];
      lt_Portugese: Result := Self.FPTTerms[ Index ];
      lt_Universal: Result := Self.FMDTerms[ Index ];
      else Result := nil;
    end;
  end;
end; // _________________________ _______________________________________GetTerm

procedure          tEntity.SetTerm(
  Index:           Integer;
  Value:           tSingle );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetTerm
  * Replace an existing term in the current language *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  LgCurr:          tLanguage;
begin

  // Check the range of the index
  if ( ( Index >= 0 ) and ( Index < Self.NbCurrent ) ) then
  begin

    // Retrieve the term
    LgCurr := Self.LgCurrent;
    case LgCurr of
      lt_Latin: Self.FLATerms[ Index ] := Value;
      lt_English: Self.FENTerms[ Index ] := Value;
      lt_French: Self.FFRTerms[ Index ] := Value;
      lt_Spanish: Self.FESTerms[ Index ] := Value;
      lt_Russian: Self.FRUTerms[ Index ] := Value;
      lt_Italian: Self.FITTerms[ Index ] := Value;
      lt_German: Self.FGETerms[ Index ] := Value;
      lt_Portugese: Self.FPTTerms[ Index ] := Value;
      lt_Universal: Self.FMDTerms[ Index ] := Value;
    end;
  end;
end; // _________________________________________________________________SetTerm

function           tEntity.GetInternalTex()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetInternalTex
  * Retrieve the internal database name of an entity *
  Description:
  The variable is absent when a unit containing this entity
  exists. Therefore, it has to be retrieved in the unit structure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.FTex;

  // Missing value: search at unit level
  if ( Length( Result ) = 0 ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.IntText;
    Self.FTex := Result;
  end;
end; // __________________________________________________________GetInternalTex

function           tEntity.GetListPart()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListPart
  * Retrieve the subdivision indicator for partonomic list *
  Description:
  This variable is absent when a unit containing this entity
  exists. Therefore, it has to be retrieved in the unit structure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.FLpt;

  // Missing value: search at unit level
  if ( Length( Result ) = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.ListPart;
    Self.fLpt := Result;
  end;
end; // _____________________________________________________________GetListPart

function           tEntity.GetListPart98()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListPart98
  * Retrieve the subdivision indicator fora TA98 partonomic list *
  Description:
  This variable is absent when a unit containing this entity
  exists. Therefore, it has to be retrieved in the unit structure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fL98;

  // Missing value: search at unit level
  if ( Length( Result ) = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.ListPart98;
    Self.fL98 := Result;
  end;
end; // ___________________________________________________________GetListPart98

function           tEntity.GetListTax()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetListTax
  * Retrieve the subdivision indicator for taxonomic list *
  Description:
  This variable is absent when a unit containing this entity
  exists. Therefore, it has to be retrieved in the unit structure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fLTx;

  // Missing value: search at unit level
  if ( Length( Result ) = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.ListTax;
    Self.fLTx := Result;
  end;
end; // ______________________________________________________________GetListTax

function           tEntity.GetTypeEntity()
  :                tType;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTypeEntity
  * Retrieve the entity type *
  Description:
  This variable is absent when a unit containing this entity
  exists. Therefore, it has to be inferred from the unit structure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  ChildUnit:       tUnit;
begin
  // An explicit value is present
  Result := Self.fTyp;

  // Missing value: search at unit level
  if ( Result = to_Undef ) then
  begin
    ChildUnit := TAH.GetUnitByPos( Self.fTet );
    if ( ChildUnit <> nil ) then
    begin
      if ( ChildUnit.Material = ma_mat ) then
      begin
        case ( Self.FTip ) of
          tp_single, tp_leftPair, tp_rightpair, tp_genpset, tp_genPair,
          tp_genset:
            Result := to_Mat;
          tp_pair:
            Result := to_ParMat;
          tp_setpset, tp_leftpset, tp_rightpset, tp_set:
            Result := to_SetMat;
          tp_pset:
            Result := to_PstMat;
          tp_del:
            Result := to_Del;
          tp_ref:
            Result := to_Undef;
          tp_tax, tp_voc, tp_lex:
            Result := to_Mat;
        end; // case
      end else
      if ( ChildUnit.Material in [ ma_imm, ma_surf, ma_line, ma_point ] ) then
      begin
        case ( Self.FTip ) of
          tp_single, tp_genPair, tp_leftPair, tp_rightpair, tp_genpset,
          tp_genset:
            Result := to_Imm;
          tp_pair:
            Result := to_ParImm;
          tp_setpset, tp_leftpset, tp_rightpset, tp_set:
            Result := to_SetImm;
          tp_pset:
            Result := to_PstImm;
          tp_ref, tp_del:
            Result := to_Undef;
          tp_tax, tp_voc, tp_lex:
            Result := to_imm;
        end; // case
      end else
      if ( ChildUnit.Material in [ ma_non ] ) then
        Result := to_non;
    end;
    Self.fTyp := Result;
  end;
end; // ___________________________________________________________GetTypeEntity

function           tEntity.GetLink()
  :                tLink;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetLink
  * Retrieve the partonomic entity link (specialisation of partof) *
  Description:
  The link variable has to be inferred from the unit structure. Once it
  has been inferred, it is stored for possible subsequent usages. The present
  procedure is intended to solve all possible situations.</P>
  In general, the attribution of the type of link is dependant on the current
  unit and its partonomic ancestor unit, except a few cases independant of
  the ancestor unit. It depends on the unit type and the materiality flag.
  According to the tip value, the link is explicitely determined in all
  situation.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  ChildUnit:       tUnit;
  FatherUnit:      tUnit;
  ChildType:       tTetra;
  FatherType:      tTetra;
begin
  // An explicit value is present
  Result := Self.FLnk;

  // Missing value: search child and father units and types
  if ( Result = pw_Undef ) then
  begin
    ChildUnit := TAH.GetUnitByPos( Self.fTet );
    if ( ChildUnit <> nil ) then
    begin
      FatherUnit := TAH.GetUnitByPos( ChildUnit.Parto );
      if ( FatherUnit <> nil ) then
      begin
        FatherType := FatherUnit.TypUnit;
        ChildType := ChildUnit.TypUnit;

        // Treatment for a material child from a material father
        if ( ChildUnit.Material = ma_mat ) then
        begin
          case Self.fTip of
            tp_single:
              begin
                if ( FatherType = tt_single ) then
                  Result := pw_PartOf
                else
                if ( FatherType = tt_set ) then
                  Result := pw_MemberOf;
              end;
            tp_genpair:
              begin
                if ( FatherType = tt_pair ) then
                  Result := pw_PartOf
                else
                if ( FatherType = tt_pset ) then
                  Result := pw_PairMemberOf;
              end;
            tp_pair:
              begin
                if ( FatherType = tt_set ) then
                  Result := pw_PairMemberOf
                else
                  Result := pw_PairPartOf;
              end;
            tp_leftpair:
              Result := pw_MemberL;
            tp_rightpair:
              Result := pw_MemberR;
            tp_setpset:
              begin
                if ( FatherType = tt_pair ) then
                  Result := pw_SetOf
                else
                if ( FatherType = tt_pset ) then
                  Result := pw_SubsetOf;
              end;
            tp_pset:
              begin
                if ( FatherType = tt_pair ) then
                  Result := pw_PairSetPairOf
                else
                if ( FatherType = tt_pset ) then
                  Result := pw_PairSubsetOf;
              end;
            tp_leftpset:
              Result := pw_SMemberL;
            tp_rightpset:
              Result := pw_SMemberR;
            tp_set:
              begin
                if ( FatherType = tt_single ) then
                  Result := pw_SetOf
                else
                if ( FatherType = tt_set ) then
                  Result := pw_SubsetOf;
              end;
            tp_genset, tp_genpset, tp_ref, tp_del, tp_lex:
              Result := pw_undef;
          end; // case
        end else

        // Treatment of an immaterial child from a material father
        if ( ( FatherUnit.Material = ma_mat ) and
             ( ChildUnit.Material in
               [ ma_imm, ma_surf, ma_line, ma_point ] ) ) then
        begin
          case Self.FTip of
            tp_single:
              if ( FatherType = tt_single ) then
                Result := pw_SpaceOf;
            tp_pair:
              if ( FatherType = tt_single ) then
                Result := pw_QSpaceOf
              else
              if ( FatherType = tt_pair ) then
                Result := pw_QSpacePairOf
              else
              if ( FatherType = tt_pset ) then
                Result := pw_QMemberPairOf;
            tp_leftpair, tp_leftpset:
              Result := pw_TMemberL;
            tp_rightpair, tp_rightpset:
              Result := pw_TMemberR;
            tp_set:
              if ( FatherType = tt_single ) then
                Result := pw_ImmSetOf
              else
              if ( FatherType = tt_set ) then
                Result := pw_ImmSubsetOf;
            tp_pset:
              if ( FatherType = tt_single ) then
                Result := pw_ImmPairSetOf
              else
              if ( FatherType = tt_pair ) then
                Result := pw_ImmPairSetPairOf
              else
              if ( FatherType = tt_pset ) then
                Result := pw_ImmPairSetPsetOf;
          end; // case
        end else

        // Treatment of an immaterial child from an immaterial father
        if ( ( FatherUnit.Material in
               [ ma_imm, ma_surf, ma_line, ma_point ] ) and
             ( ChildUnit.Material in
               [ ma_imm, ma_surf, ma_line, ma_point ] ) ) then
        begin
          case Self.fTip of
            tp_leftpair:
              Result := pw_IMemberL;
            tp_rightpair:
              Result := pw_IMemberR;
            tp_leftpset:
              Result := pw_TMemberL;
            tp_rightpset:
              Result := pw_TMemberR;
          end; // case
        end;
      end;
    end;

    // Store the result in order not to compute it a second time!
    Self.fLnk := Result;
  end;
end; // _________________________________________________________________GetLink

function           tEntity.GetCod98()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetCod98
  * Retrieve the TA98 11-digit code of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fCod;

  // Missing value: search at unit level
  if ( Result = cEmpty ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Cod98;
  end;
end; // ________________________________________________________________GetCod98

function           tEntity.GetNv1()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNv1
  * Retrieve the level-1 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fNv1;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Level3;
  end;
end; // __________________________________________________________________GetNv1

function           tEntity.GetSq1()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSq1
  * Retrieve the sequence-1 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fSq1;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Seq4;
  end;
end; // __________________________________________________________________GetSq1

function           tEntity.GetNv2()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNv2
  * Retrieve the level-2 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          TUnit;
begin
  // An explicit value is present
  Result := Self.fNv1;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Level3;
  end;
end; // __________________________________________________________________GetNv2

function           tEntity.GetSq2()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSq2
  * Retrieve the sequence-2 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fSq2;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Seq4;
  end;
end; // __________________________________________________________________GetSq2

function           tEntity.GetNv3()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNv3
  * Retrieve the level-3 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fNv3;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Level3;
  end;
end; // __________________________________________________________________GetNv3

function           tEntity.GetSq3()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSq3
  * Retrieve the sequence-3 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.FSq3;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Seq4;
  end;
end; // __________________________________________________________________GetSq3

function           tEntity.GetNv4()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNv4
  * Retrieve the level-4 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fNv4;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Level4;
  end;
end; // __________________________________________________________________GetNv4

function           tEntity.GetSq4()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSq4
  * Retrieve the sequence-4 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.FSq4;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Seq4;
  end;
end; // __________________________________________________________________GetSq4

function           tEntity.GetNv5()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNv5
  * Retrieve the level-5 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.FNv5;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Level5;
  end;
end; // __________________________________________________________________GetNv5

function           tEntity.GetSq5()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSq5
  * Retrieve the sequence-5 value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.FSq5;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Seq5;
  end;
end; // __________________________________________________________________GetSq5

function           tEntity.GetTip()
  :                tTip;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTip
  * Retrieve the TetraTip value of an entity from its unit *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
  MyType:          tTetra;
begin
  // An explicit value is present
  Result := Self.fTip;

  // Missing value: search at unit level
  if ( Result = tp_Undef ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      MyType := MyUnit.TypUnit;
      case MyType of
      tt_single:
        Result := tp_single;
      tt_pair:
        if ( Self.TID = MyUnit.Generator ) then
          Result := tp_genpair
        else
        if ( Self.TID = MyUnit.Main ) then
          Result := tp_pair
        else
        if ( Self.TID = MyUnit.Left ) then
          Result := tp_leftpair
        else
        if ( Self.TID = MyUnit.Right ) then
          Result := tp_rightpair;
      tt_set:
        if ( Self.TID = MyUnit.Generator ) then
          Result := tp_genset
        else
        if ( Self.TID = MyUnit.ASet ) then
          Result := tp_set;
      tt_pset:
        if ( Self.TID = MyUnit.Generator ) then
          Result := tp_genpset
        else
        if ( Self.TID = MyUnit.Aset ) then
          Result := tp_setpset
        else
        if ( Self.TID = MyUnit.Main ) then
          Result := tp_pset
        else
        if ( Self.TID = MyUnit.Left ) then
          Result := tp_leftpset
        else
        if ( Self.TID = MyUnit.Right ) then
          Result := tp_rightpset;
      tt_ref:
        Result := tp_ref;
      tt_del:
        Result := tp_del;
      tt_lex:
        Result := tp_lex;
      tt_voc:
        Result := tp_voc;
      tt_mset:
        Result := tp_mset;
      end; // case
    end;
  end;
end; // __________________________________________________________________GetTip

function           tEntity.GetLevel()
  :                tLevel;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetLevel
  * Retrieve the level of indentation in TA98 *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
  Indx:            tLevel;
begin
  // An explicit value is present
  Result := Self.FLev;

  // Missing value: search at unit level
  if ( Result = lv_undef ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      for Indx := Low( tLevel ) to High( tLevel ) do
      begin
        if ( Indx = MyUnit.Indent ) then
        begin
          Result := Indx;
          Break;
        end;
      end; // on all levels
    end;
  end;
end; // ________________________________________________________________GetLevel

function           tEntity.GetSexe()
  :                TSexe;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSexe
  * Retrieve the sexe value of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.FSex;

  // Missing value: search at unit level
  if ( Result = sx_undef ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Sexe;
  end;
end; // _________________________________________________________________GetSexe

function           tEntity.GetDimorph()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetDimorph
  * Retrieve the UID of a dimorphic entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.FDimorph;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Dimorph;
  end;
end; // ______________________________________________________________GetDimorph

function           tEntity.Get98()
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Get98
  * Retrieve the appartenance of an entity to TA98 *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          TUnit;
begin
  // An explicit value is present
  Result := Self.FTA98;

  // Missing value: search at unit level
  if ( Result = False ) then
  begin
    UID := Self.FTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.List98;
  end;
end; // ___________________________________________________________________Get98

function           tEntity.GetPartHierar(
  Index:           Integer )
  : Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetPartHierar
  * Retrieve any partonomic ancestor of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbAnc:           Integer;
begin

  // Creation of the list of ancestors if not yet existing
  if ( Length( fPartHierar ) = 0 ) then
    Self.TermHierarchy( Self.TID );

  // Transfer the result
  NbAnc := Length( FPartHierar );
  if ( NbAnc > 0 ) then
    Result := fPartHierar[ Index ]
  else
    Result := 0;
end; // ___________________________________________________________GetPartHierar

function           tEntity.GetPast()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetPast
  * Retrieve the past taxonomic ancestor PastTaxAnc *
  Description:
  When the taxonomy is updated with the property PastTaxCh = m, the past
  taxonomic ancestor is stored for information about the current change. This
  field is used for display of the taxonomy in the Extended Entity Page.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fPis;

  // Missing value: search at unit level
  if ( ( Result = 0 ) and
       ( Self.TetraTip in [ tp_genpair, tp_genset, tp_genpset ] ) ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      Result := MyUnit.PastID;
    end;
  end;
end; // _________________________________________________________________GetPast

function           tEntity.GetChange()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetChange
  * Retrieve the change taxonomic information PastTaxCh *
  Description:
  This field PastTaxCh indicates the type of change that has been done;
  - n for a new entity
  - m for a modified entity (together with the PastTaxAnc property)
  - d for a deleted entity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fChl;

  // Missing value: search at unit level
  if ( Result = cEmpty ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      Result := MyUnit.Change;
    end;
  end;
end; // _______________________________________________________________GetChange

function           TEntity.GetGenerator()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetGenerator
  * Retrieve the generator of an entity *
  Description:
  The variable is absent when a unit containing this entity
  exists. Therefore, it has to be retrieved in the unit structure.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          TUnit;
begin
  // An explicit value is present
  Result := Self.fGen;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      if ( Self.FTip in [ tp_pair, tp_setpset, tp_pset, tp_set, tp_int,
                          tp_mset ] ) then
        Result := MyUnit.Generator;
    end;
    Self.fGen := Result;
  end;
end; // ____________________________________________________________GetGenerator

function           tEntity.GetInconstant()
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetInconstant
  * Retrieve the inconstant flag of a unit *
  Description:
  This method accesses a possible unit and retrieves its inconstant flag
  for any entity of the unit. An entity without unit (single unit) has its
  own inconstant flag that is returned.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  UID := Self.fTet;
  MyUnit := TAH.GetUnitByPos( UID );
  if ( MyUnit <> nil ) then
    Result := MyUnit.Inconstant
  else
    Result := Self.fIcs;
end; // ___________________________________________________________GetInconstant

function           tEntity.GetFID()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetFID
  * Retrieve the FID identifier of an entity *
  Description:
  This method retieves the FMA identifier corresponding to the present
  entity.</P>
  There are up to four possible FID for any unit and they have to be
  distributed to the adequate entities of the unit. For the pairs and pset,
  the FID of the generator is accepted!</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fFID;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      case Self.fTip of
        tp_single, tp_genpair, tp_genpset, tp_genset, tp_pair, tp_pset,
        tp_set, tp_setpset:
          Result := MyUnit.FID;
        tp_leftPair, tp_leftPSet:
          Result := MyUnit.FMAsin;
        tp_rightPair, tp_rightPSet:
          Result := MyUnit.FMAdex;
      end; // case
    end;
  end;
end; // __________________________________________________________________GetFID

function           tEntity.GetRef()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetRef
  * Retrieve the reference entity of an entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  // An explicit value is present
  Result := Self.fIns;

  // Missing value: search at unit level
  if ( Result = 0 ) then
  begin
    UID := Self.fTet;
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
      Result := MyUnit.Reference;
  end;
end; // __________________________________________________________________GetRef

function           tEntity.GetLibelle(
  LibType:         tLibelleType;
  Lang:            tLanguage;
  SynType:         tSynType;
  Short:           Boolean;
  IsReg:           Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetLibelle
  * Retrieve the libelle of a term in any form in the specified language *
  Description:
  This method retrieves a libelle of a specified type for an given
  language. The short or full term is an option.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbCurr:          Integer;
  IsPair:          Boolean;
  Single:          tSingle;
begin

  // Retrieve the corresponding single term
  Single := Self.GetStructuredTerm( LibType, Lang, SynType );

  // Compute the return value
  if ( Single <> nil ) then
  begin

    // Return a short term (without optional expansion: default)
    Single.Mandat := Trim( Single.Mandat );
    if ( Short ) then
    begin
      if ( Single.Short = cEmpty )  then
        Result := Single.Mandat
      else
        Result := Single.Short;
    end else

    // Return a full term
    begin
      Result := Single.Mandat;
      if ( Single.Option <> cEmpty )  then
        Result := Result + cSpace + '<I>' + Single.Option + '</I>';
    end;

    // Add the bracket part for paired entities or paired sets
    IsPair := ( ( Self.TypeEntity = to_PstMat ) or
                ( Self.TypeEntity = to_PstImm ) or
                ( Self.TypeEntity = to_ParMat ) or
                ( Self.TypeEntity = to_ParImm ) );
    if ( IsPair ) then
      Result := Result + Single.Bracket;

    // Add the irregular flag
    if ( IsReg and Irreg and ( cIrreg <> cEmpty ) and
         ( ( Single.Category = st_RAT ) or
           ( Single.Effective = st_RAT ) ) ) then
    begin
      Result := Result + cSpace + cIrreg;
      if ( LibType = lb_Universal ) then
        Result := cEmpty;
    end else

    // Add the Universal sign
    begin
      if ( ( ( Single.BuildFrom = bd_model ) or
             ( Single.BuildFrom = bd_auto ) or
             ( Single.Category in cGroupInherit ) or
             ( Single.Effective in cGroupInherit ) or
             ( LibType = lb_Universal ) ) and
           ( IsReg ) and
           ( Result <> cEmpty ) and
           ( cUniversal <> cEmpty) ) then
        if ( Single.Effective in cGroupFormula ) then
          Result := Trim( Result ) + cSpace + cUniversal
        else
          Result := Trim( Result ) + cSpace + cHeritage;
    end;
  end else

  // Return the null string when no term has been found
  begin
    Result := cEmpty;
  end;
end; // ______________________________________________________________GetLibelle

function           tEntity.GetStructuredTerm(
  LibType:         tLibelleType;
  Lang:            tLanguage;
  SynType:         tSynType )
  :                tSingle;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetStructuredTerm
  * Retrieve a single structured term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.LgCurrent := Lang;
  if ( Self.IsDeletedTerm( SynType ) ) then
    Result := nil
  else
    Result := Self.GetSingle( LibType, Lang, SynType );
end; // _______________________________________________________GetStructuredTerm

function           TEntity.GetVocabulary(
  Lang:            tLanguage;
  SynType:         TSynType )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetVocabulary
  * Retrieve a word of the vocabulary in a specified language *
  Description:
  This function is a simplified access to the words of the vocabulary,
  compared to the regular access by the function GetLibelle. It applies
  uniquely to the types st_nou, st_Adj, st_Pre and st_Inv.</P>
  The vocabulary is present on non physical entities under "nomen generale"
  of type tt_voc. Any of these entities may be the holder of a unique word in
  each category as noun, adjective or prefix, unless it holds a unique word
  of type invariant.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbTerm:          Integer;
  MyTerm:          TSingle;
begin

  // Check for allowed types
  Result := cEmpty;
  if ( not ( SynType in [ st_Nou, st_Adj, st_Pre, st_Inv ] ) ) then
    Exit;

  // Retrieve the word in the specified language
  Self.LgCurrent := Lang;
  NbTerm := NbCurrent;
  for Indx := 0 to NbTerm - 1 do
  begin
    MyTerm := Self.CurrTerm[ Indx ];
    if ( MyTerm.Category = SynType ) then
    begin
      Result := MyTerm.Libelle;
      Break;
    end;
  end; // for on all terms of the specified language
end; // ___________________________________________________________GetVocabulary

function           tEntity.GetSingle(
  LibType:         tLibelleType;
  Lang:            tLanguage;
  SynType:         tSynType )
  :                tSingle;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSingle
  * Retrieve the single of the official term in the specified language *
  Description:
  This method retrieves the official term of an entity or returns
  the base term in case of error.</P>
  The official term follows a strict definition:
  1) A traditional term is selected when present,
  2) If not present, a plural term is selected for sets or psets or a display
     term is selected for pairs,
  3) If one of the above search failed, the base term is selected.</P>
  The parameter Short (false by default) allows to retrieve the short form.</P>
  The parameter Bracket (true by default) allows to suppress the bracket
  value.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Univ:            Boolean;
begin
  Univ := LibType = lb_Universal;
  Result := nil;
  Self.LgCurrent := Lang;

  // Retrieve a possible text term and exit
  if ( ( LibType = lb_Text ) ) then
  begin
    Self.Query := tSearch.Create( st_tex );
    Self.SearchTerm;
    Result := Self.CurrSingle;
    Exit;
  end else

  // Retrieve a possible bubble text and exit
  if ( ( LibType = lb_Bubble ) ) then
  begin
    Self.Query := tSearch.Create( st_bul );
    Self.SearchTerm;
    Result := Self.CurrSingle;
    Exit;
  end else

  // Retrieve a possible value term and exit
  if ( ( LibType = lb_Value ) ) then
  begin
    Self.Query := tSearch.Create( SynType );
    Self.SearchTerm;
    Result := Self.CurrSingle;
    Exit;
  end else

  // Retrieve a possible title term and exit
  if ( ( LibType = lb_Title ) ) then
  begin
    Self.Query := tSearch.Create( st_tit );
    Self.SearchTerm;
    Result := Self.CurrSingle;
    Exit;
  end;

  // Handling of a single libelle
  Self.Query := tSearch.Create( st_Bas );
  if ( LibType = lb_Single ) then
  begin
    Self.Query.fType := SynType;
    Self.SearchTerm;
    Result := Self.CurrSingle;
    Exit;
  end else

  // Handling of a regular term or any synonym
  if ( ( Result = nil ) and
       ( LibType in [ lb_Regular, lb_Official, lb_Synonym, lb_Synonym2,
                      lb_Synonym3 ] ) ) then
  begin

    // Search for a plural term for sets and psets
    if ( ( Self.TypeEntity = to_SetMat ) or
         ( Self.TypeEntity = to_SetImm ) or
         ( Self.TypeEntity = to_PstMat ) or
         ( Self.TypeEntity = to_PstImm ) ) then
    begin
      if ( LibType = lb_Synonym ) then
        Self.Query.fType := st_pl1
      else
      if ( LibType = lb_Synonym2 ) then
        Self.Query.fType := st_pl2
      else
      if ( LibType = lb_Synonym3 ) then
        Self.Query.fType := st_pl3
      else
        Self.Query.fType := st_plm;
    end else

    // Search for a pair term
    if ( ( Self.TypeEntity = to_ParMat ) or
         ( Self.TypeEntity = to_ParImm ) ) then
    begin
      if ( LibType = lb_Synonym ) then
        Self.Query.fType := st_ds1
      else
      if ( LibType = lb_Synonym2 ) then
        Self.Query.fType := st_Od2
      else
      if ( LibType = lb_Synonym3 ) then
        Self.Query.fType := st_Od3
      else
        Self.Query.fType := st_dis;
    end else

    // Search for a single term
    if ( LibType = lb_Synonym ) then
      Self.Query.fType := st_Ofd
    else
    if ( LibType = lb_Synonym2 ) then
      Self.Query.fType := st_Od2
    else
    if ( LibType = lb_Synonym3 ) then
      Self.Query.fType := st_Od3
    else
      Self.Query.fType := st_Bas;
  end else

  // Handling of a base term
  if ( LibType = lb_Base ) then
  begin
    Self.Query.fType := st_Bas
  end else

  // Handling of a formula term
  if ( LibType = lb_Universal ) then
  begin
    Self.Query.fType := SynType;
  end;

  // Perform the specified search
  if ( Self.Query.fType <> st_undef ) then
  begin
    Self.Query.IsUniv := Univ;
    Self.SearchTerm;
  end;
  Result := Self.CurrSingle;
end; // _______________________________________________________________GetSingle

function           tEntity.GetNbLATerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbLATerm
  * Property read method for number of Latin terms *
  Description:
  This method determines the number of Latin terms present in the TEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fLATerms );
end; // _____________________________________________________________GetNbLATerm

function           tEntity.GetNbENTerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbENTerm
  * Property read method for number of English terms *
  Description:
  This method determines the number of English terms present in the TEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fENTerms );
end; // _____________________________________________________________GetNbENTerm

function           tEntity.GetNbFRTerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbFRTerm
  * Property read method for number of French terms *
  Description:
  This method determines the number of French terms present in the tEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fFRTerms );
end; // _____________________________________________________________GetNbFRTerm

function           tEntity.GetNbESTerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbESTerm
  * Property read method for number of Spanish terms *
  Description:
  This method determines the number of Spanish terms present in the tEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fESTerms );
end; // _____________________________________________________________GetNbESTerm

function           tEntity.GetNbRUTerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbRUTerm
  * Property read method for number of Russian terms *
  Description:
  This method determines the number of Russian terms present in the TEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fRUTerms );
end; // _____________________________________________________________GetNbRUTerm

function           tEntity.GetNbITTerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbITTerm
  * Property read method for number of Italian terms *
  Description:
  This method determines the number of Italian terms present in the TEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fITTerms );
end; // _____________________________________________________________GetNbITTerm

function           tEntity.GetNbGETerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbGETerm
  * Property read method for number of German terms *
  Description:
  This method determines the number of German terms present in the TEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fGETerms );
end; // _____________________________________________________________GetNbGETerm

function           tEntity.GetNbPTTerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbPTTerm
  * Property read method for number of Portugese terms *
  Description:
  This method determines the number of Portugese terms present in the tEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fPTTerms );
end; // _____________________________________________________________GetNbPTTerm

function           tEntity.GetNbMDTerm()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbMDTerm
  * Property read method for number of Universal terms *
  Description:
  This method determines the number of Universal terms present in the tEntity
  object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fMDTerms );
end; // _____________________________________________________________GetNbMDTerm

function           tEntity.GetNbCurrent()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbCurrent
  * Property read method for number of terms for current language *
  Description:
  This method determines the number of terms present in the tEntity for the
  current language.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyCurr:          tLanguage;
begin
  MyCurr := Self.LgCurrent;
  if ( MyCurr = lt_Latin ) then
    Result := Length( Self.fLATerms )
  else
  if ( MyCurr = lt_English ) then
    Result := Length( Self.fENTerms )
  else
  if ( MyCurr = lt_French ) then
    Result := Length( Self.fFRTerms )
  else
  if ( MyCurr = lt_Spanish ) then
    Result := Length( Self.fESTerms )
  else
  if ( MyCurr = lt_Russian ) then
    Result := Length( Self.fRUTerms )
  else
  if ( MyCurr = lt_Italian ) then
    Result := Length( Self.fITTerms )
  else
  if ( MyCurr = lt_German ) then
    Result := Length( Self.fGETerms )
  else
  if ( MyCurr = lt_Portugese ) then
    Result := Length( Self.fPTTerms )
  else
  if ( MyCurr = lt_Universal ) then
    Result := Length( Self.fMDTerms )
  else
    Result := 0;
end; // ____________________________________________________________GetNbCurrent

function           tEntity.IsForTerm(
  AType:           tSynType )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsForTerm
  * Chexk for the existence of a formula term *
  Description:
  This methods looks at all existing terms of the entity in the current
  language and check for the presence of a term of the specified type.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbTerm:          Integer;
begin

  // Loop on all terms searching for a formula term
  NbTerm := Self.NbCurrent;
  Result := False;
  if ( NbTerm > 0 ) then
  begin
    for Indx := 0 to NbTerm - 1 do
    begin
      if ( CurrTerm[ Indx ].Category = AType ) then
      begin
        Result := True;
        Break;
      end;
    end; // for on all terms
  end;
end; // _______________________________________________________________IsForTerm

function           tEntity.IsSpecificTerm(
  AType:           tSynType )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsSpecificTerm
  * Chexk for the existence of a specific term *
  Description:
  This methods looks at all existing terms of the entity in the current
  language and find the position of the specified type.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbTerm:          Integer;
begin

  // Loop on all terms searching for a formula term
  NbTerm := Self.NbCurrent;
  Result := -1;
  if ( NbTerm > 0 ) then
  begin
    for Indx := 0 to NbTerm - 1 do
    begin
      if ( CurrTerm[ Indx ].Category = AType ) then
      begin
        Result := Indx;
        Break;
      end;
    end; // for on all terms
  end;
end; // __________________________________________________________IsSpecificTerm

function           tEntity.IsGenEntity
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsGenEntity
  * Check for a generic entity *
  Description:
  A generic entity is an entity of one of the following tips (type TTip):
  tp_single, tp_genpair, tp_genpset, tp_genset, tp_tax, tp_voc, tp_lex, tp_del
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := ( Self.TetraTip in [ tp_genpair, tp_genpset,
                                 tp_genset, tp_tax, tp_lex, tp_voc, tp_del ] );
end; // _____________________________________________________________IsGenEntity

function           tEntity.GetGeneric
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetGeneric
  * Retrieve the TID of the generic entity *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  UID:             Integer;
  MyUnit:          tUnit;
begin
  Result := 0;
  UID := Self.Tetra;
  MyUnit := TAH.GetUnitByPos( UID );
  if ( MyUnit <> nil ) then
    if ( MyUnit.Generator > 0 ) then
      Result := MyUnit.Generator
    else
    if ( MyUnit.Main > 0 ) then
      Result := MyUnit.Main;
end; // ______________________________________________________________GetGeneric

function           tEntity.HasFormula
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ HasFormula
  * Check if entity has an applicable formula *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  GenTID:          Integer;
  Generator:       tEntity;
  Query:           tSearch;
begin
  GenTID := Self.GenEntity;
  if ( GenTID > 0 ) then
    Generator := TAH.GetEntityByTID( GenTID )
  else
    Generator := Self;
  Result := False;
  if ( Generator <> nil ) then
  begin
    Generator.LgCurrent := lt_Universal;
    Generator.Query := tSearch.Create( st_Mod );
    Generator.SearchTerm;
    Result := Generator.CurrSingle <> nil;
  end;
end; // ______________________________________________________________HasFormula

function           tEntity.GetNbChildren()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbChildren
  * Property read method for number of children in sorted list *
  Description:
  This method determines the number of children present in the TEntity
  object according to a specified hierarchy.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fSortedChildren );
end; // ___________________________________________________________GetNbChildren

function           tEntity.GetNbPartHierar()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbPartHierar
  * Property read method for number of items in partonomy *
  Description:
  This method determines the number of entities in the partonomy of the
  specified entity.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.fPartHierar );
end; // _________________________________________________________GetNbPartHierar

function           tEntity.IsBilateral()
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsBilateral
  * Determine bilaterality of an entity *
  Description:
  This method examines the descendants of an entity and determines if it is
  bilateral. Either the direct first taxonomic child has a partonomic link to
  its father which is pair member link, or the first taxonomic grand-child
  when the child is a set.</P>
  In case of the presence of the bilaterality flag, it takes advantage on the
  computed result.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  ChildPos:        Integer;
  Posit:           Integer;
  AChild:          tEntity;
  MyLink:          tLink;
  Actual:          tEntity;
begin

  // Check for a lexical reference
  Result := False;
  if ( Self.TetraTip = tp_lex ) then
    Actual := TAH.GetEntityByTID( Self.Reference )
  else
    Actual := Self;
  if ( Actual = nil ) then
    Exit;

  // Check the constraining flag
  if ( Actual.fTip in [ tp_pset, tp_pair ] ) then
  begin
    Result := True;
    Exit;
  end;

  // Find the first taxonomic child of actual entity
  Posit := Pos( cSemi, Actual.fTes );
  ChildPos := 0;
  if ( Posit > 0 ) then
    ChildPos := StrToInt( Copy( Actual.fTes, 1, Posit - 1 ) )
  else
  if ( Actual.fTes <> cEmpty ) then
    ChildPos := StrToInt( Actual.ftes );

  // Check for a link to its father compatible with bilaterality
  if ( ChildPos > 0 ) then
  begin
    AChild := TAH.GetEntityByTID( ChildPos );
    if ( AChild <> nil ) then
    begin
      MyLink := AChild.Link;
      if ( AChild.fTes <> cEmpty ) then
      begin
        Posit := Pos( cSemi, AChild.fTes );
        if ( Posit > 0 ) then
          ChildPos := StrToInt( Copy( AChild.fTes, 1, Posit - 1 ) );
        AChild := TAH.GetEntityByTID( ChildPos );
        if ( AChild <> nil ) then
          Result := ( MyLink = pw_MemberL ) or ( MyLink = pw_MemberR );
      end else
        Result :=
          ( ( MyLink = pw_MemberL ) or ( MyLink = pw_MemberR ) or
            ( MyLink = pw_SMemberL ) or ( MyLink = pw_SMemberR ) or
            ( MyLink = pw_IMemberL ) or ( MyLink = pw_IMemberR ) or
            ( MyLink = pw_TMemberL ) or ( MyLink = pw_TMemberR ) );
    end;
  end;
end; // _____________________________________________________________IsBilateral

function           tEntity.MakeFormula(
  AType:           tSynType )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeFormula
  * Make a language specific term from the universal model *
  Description:
  This method builds a new term from a universal formula for the current
  language. This term is added to the existing terms.</P>
  First, a check that the term does not already exist is performed. Indeed,
  it may have been created by another part of the program.</P>
  Second, the entity is checked for being a generic entity. Non generic
  entities do not have formula terms.</P>
  Third, a universal formula is searched for. If not, the process is stopped
  and a nil result is returned to the calling method.</P>
  Fourth, the nominative term is built from the formula and it is used for the
  construction of a new term in the entity current language, including the
  expansions specified together with the formula.</P>
  Fifth, the new term is added to the mother entity.</P>
  The present method is independant of any language, but it creates a term in
  the current language and ask to the language specific methods belonging to
  this language for the resolution of the universal formula.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbWord:          Integer;
  MyBasic:         String;
  Query:           tSearch;
  ATerm:           tSingle;
  MySingle:        tSingle;
  MyTerm:          tTerm;
  Lang:            tLanguage;
  NewCateg:        tSynType;
begin

  // Check for existence of the formula term
  Result := False;
  Lang := Self.LgCurrent;
  if ( not Self.IsForTerm( AType ) ) then
  begin

    // Check for a generic entity
    if ( ( Self.IsGeneric ) or ( Self.TetraTip = tp_Single ) ) then
    begin

      // Define the model formula
      case AType of
        st_For: NewCateg := st_Mod;
        st_Fr1: NewCateg := st_Md1;
        st_Fr2: NewCateg := st_Md2;
        st_Fr3: NewCateg := st_Md3;
        else NewCateg := st_undef;
      end;

      // Search for a universal formula
      Self.LgCurrent := lt_Universal;
      Self.Query := tSearch.Create( NewCateg );
      Self.SearchTerm;
      ATerm := Self.CurrSingle;
      if ( ATerm <> nil ) then
      begin

        // Build the basic part in the specified language from formula
        MyTerm := tTerm.Create;
        MyTerm.Language := Lang;
        MyTerm.Formula := ATerm.Mandat;
        MyBasic := cEmpty;
        if ( MyTerm.IsRegular ) then
          MyBasic := MyTerm.Nominative;

        // Build a new term in the specified language
        if ( MyBasic <> cEmpty ) then
        begin
          MySingle := tSingle.Create;
          MySingle.Exp := ATerm.Exp;
          MySingle.Obl := ATerm.Obl;
          MySingle.Prefix := ATerm.Prefix;
          MySingle.Adjective := ATerm.Adjective;
          MySingle.Category := AType;
          MySingle.Libelle := MyBasic;
          MySingle.Done := False;
          MySingle.Language := Lang;
          MySingle.BuildFrom := bd_model;
          NbWord := MyTerm.NbWord;
          MySingle.LgTerm := MyTerm;
          MySingle.TID := Self.TID;

          // Add the new term to its entity
          Self.LgCurrent := Lang;
          Self.AddTerm( MySingle );
          Result := True;
        end;
      end;
    end;
  end;
end; // _____________________________________________________________MakeFormula

procedure          tEntity.SearchTerm;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SearchTerm
  * Retrieve or build a single term of any language *
  Description:
  This procedure is the major component of terms generation.</P>
  This procedure examines the set of all stored terms of an entity for the
  current language and select a term corresponding to the specified type.
  This term is checked to see if its expansion has already been done and make
  it if not yet done. Then the object is returned to its calling
  procedure.</P>
  The autogenerated terms are initially absent of the list of terms and they
  have to be generated when they are needed. This is automatically done
  when the evidence of a missing term is there.</P>
  In addition, when no term can be found, a check for the existence of a
  universal formula is performed and a universal term can be generated in
  any language. This generation process is dependant on the availability of
  the necessary vocabulary, to be defined for each language separately.</P>
  When multiple terms of the same type are present, a position argument may
  require a particular occurence. This is true for official synonyms or
  related terms.</P>
  This procedure is a two phases process:
  1. Search of a term of the required type, and processing of its expansion
  when necessary.
  2. In case of a missing term, attempt to generate it as a derivative of
  the existing terms, including the creation of a new term from a universal
  formula.</P>
  This procedure is highly recursive, being able to call itself a multiple
  number of times.</P>
  The ratio from the number of real terms to the number of generated terms
  is expected to be higher than 1 to 20.</P>
  Concerning the expansion of a term being dependant on a laterality argument,
  this procedure compares the actual laterality argument to the one used for a
  previous expansion. In case of divergence, the expansion is redone with the
  actual laterality argument.</P>
  The Direct flag allows to search only for direct terms, those that are
  directly declared and not computed from other terms.</P>
  The IsUniv flag ask for a search limited to the universal terms.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbTerm:          Integer;
  Indx:            Integer;
  Count:           Integer;
  SynPos:          Integer;
  IsGen:           Boolean;
  Direct:          Boolean;
  IsUniv:          Boolean;
  NoUni:           Boolean;
  Single:          tSingle;
  MySingle:        tSingle;
  MyLink:          tLink;
  MyType:          tType;
  Lang:            tLanguage;
  AType:           tSynType;
  MyTerm:          tSingle;
begin

  // Extract the values for the search
  Lang := Self.LgCurrent;
  SynPos := Self.Query.SynPos;
  Direct := Self.Query.Direct;
  IsUniv := Self.Query.IsUniv;
  AType := Self.Query.MyType;

  // Generate a formula term
  if ( AType in cGroupFormula ) then
    Self.MakeFormula( AType );
  if ( AType in cGroupModel ) then
    Direct := True;

  // First part: retrieve an existing term and expand it
  // ===================================================

  // Search on all the terms of the current language
  Count := 0;
  NbTerm := Self.GetNbCurrent;
  Self.CurrSingle := nil;
  for Indx := 0 to NbTerm - 1 do
  begin
    MyTerm := Self.CurrTerm[ Indx ];
    if ( ( MyTerm.Category = AType ) or
         ( ( MyTerm.Category in cGroupMain ) and ( AType = st_bas ) ) or
         ( ( MyTerm.Category in cGroupSyn1 ) and ( AType = st_ofd ) ) or
         ( ( MyTerm.Category in cGroupSyn2 ) and ( AType = st_od2 ) ) or
         ( ( MyTerm.Category in cGroupSyn3 ) and ( AType = st_od3 ) ) ) then
    begin

      // Work on terms with a unique occurence
      if ( ( AType = st_Bas ) or ( AType = st_Ori ) or
           ( AType = st_For ) or ( AType = st_Fr1 ) or
           ( AType = st_Fr2 ) or ( AType = st_Fr3 ) or
           ( AType = st_tex ) or
           ( ( AType = st_Mod ) and ( Lang = lt_Universal ) ) or
           ( ( AType = st_Md1 ) and ( Lang = lt_Universal ) ) or
           ( ( AType = st_Md2 ) and ( Lang = lt_Universal ) ) or
           ( ( AType = st_Md3 ) and ( Lang = lt_Universal ) ) or
           ( ( AType = st_RAT ) and ( Lang = lt_Latin ) ) ) then
      begin
        if ( ( not MyTerm.Done ) {or ( AType = st_For )} ) then
        begin
          MyTerm.IsUniversal := Self.Query.IsUniv;
          MyTerm.ExpansionTerm;
        end;
        Self.CurrSingle := MyTerm;
        Break;
      end else

      // Work on terms with possible multiple occurences
      // They are: st_Alt, st_Syn, st_FMA
      begin
        if ( SynPos = Count ) then
        begin
          if ( not MyTerm.Done ) then
            MyTerm.ExpansionTerm;
          Self.CurrSingle := MyTerm;
          Break;
        end else
          Inc( Count );
      end;
    end;
  end; // for on all terms of the current language

  // Terminate the search if Direct is specified
  if ( Direct ) then
    Exit;

  // Terminate the search if an expansion has been found
  if ( Self.CurrSingle <> nil ) then
  begin

    // Possibly notify an error
    if ( not Self.CurrSingle.Performed ) then
    begin
      Self.CurrSingle.ErrNo := ErMissExp;
      Self.CurrSingle.ErrChain := Self.CurrSingle.ErrChain + cSemi +
                                  IntToStr( ErMissExp );
      Self.CurrSingle.Mandat := Self.CurrSingle.Basic + cSpace +
                                'ERR' + cSpace + Self.CurrSingle.ErrChain;
    end;
    Exit;
  end;

  // Second part: generate a missing term
  // ====================================

  // Check for a missing base term and autogenerate it
  IsGen := False;
  if ( AType = st_Bas ) then
  begin

    // Create a new single term
    Single := tSingle.Create( Lang );
    Single.TID := Self.TID;
    Single.Category := st_Bas;
    Single.IsUniversal := IsUniv;

    // Handling of lateral member entities
    IsGen := False;
    MyLink := Self.Link;
    MyType := Self.TypeEntity;
    if ( ( MyLink = pw_MemberL ) or ( MyLink = pw_MemberR ) or
         ( MyLink = pw_SMemberL ) or ( MyLink = pw_SMemberR ) or
         ( MyLink = pw_IMemberL ) or ( MyLink = pw_IMemberR ) or
         ( MyLink = pw_TMemberL ) or ( MyLink = pw_TMemberR ) ) then
    begin
      IsGen := Single.MakeBasLateral;
    end else

    // Handling of pairs
    if ( MyType = to_ParMat ) or ( MyType = to_ParImm ) then
    begin
      IsGen := Single.MakeBasPair;
    end else

    // Handling of psets
    if ( MyType = to_PstMat ) or ( MyType = to_PstImm )  then
    begin
      IsGen := Single.MakeBasPset;
    end else

    // Handling of set entities
    if ( ( MyType = to_SetMat ) or ( MyType = to_SetImm ) or
         ( MyType = to_MstMat ) or ( MyType = to_MstImm ) ) then
    begin
      IsGen := Single.MakeBasSet;
    end else

    // Handling of generator entities
    if ( ( MyType = to_Mat ) or ( MyType = to_Imm ) or
         ( MyType = to_Non ) or ( MyType = to_Del ) ) then
    begin
      IsGen := Single.MakeBasGener;
    end;

    // Notify an error in autogeneration process
    if ( not IsGen ) then
    begin
      Single.Performed := False;
      Single.ErrNo := ErMissGen;
      Single.ErrChain := IntToStr( ErMissGen ) + cSpace + Single.ErrChain;
      Single.Mandat := TAH.GetLabel( ErMissGen );
    end;

    // Return the new term
    Self.AddTerm( Single );
    Self.CurrSingle := Single;
    Exit;
  end else // End of treatment of st_bas

//______________________________________________________________________________

  // Check for a missing plural term and autogenerate it
  if ( AType in cGroupPlural ) then
  begin

    // Handling of set entities only
    Single := nil;
    if ( Self.FTyp = to_SetMat ) or ( Self.FTyp = to_SetImm ) or
       ( Self.FTyp = to_PstMat ) or ( Self.FTyp = to_PstImm ) then
    begin

      // Create a new single term
      Single := tSingle.Create( Lang );
      Single.TID := Self.TID;
      Single.Category := Atype;
      Single.IsUniversal := IsUniv;
      MyLink := Self.Link;

      // Handling of lateral set
      if ( ( MyLink = pw_MemberL ) or ( MyLink = pw_MemberR ) or
           ( MyLink = pw_SMemberL ) or ( MyLink = pw_SMemberR ) or
           ( MyLink = pw_IMemberL ) or ( MyLink = pw_IMemberR ) or
           ( MyLink = pw_TMemberL ) or ( MyLink = pw_TMemberR ) ) then
      begin
        IsGen := Single.MakePluLateral;
      end else

      // Handling of main set
      begin
        IsGen := Single.MakePluSet;
      end;
    end;

    // Return the new term
    if ( IsGen ) then
    begin
      Self.AddTerm( Single );
      Self.CurrSingle := Single;
    end else
      Self.CurrSingle := nil;
    Exit;
  end else // End of treatment of st_Plu

//______________________________________________________________________________

  // Autogeneration of a missing display term
  // This procedure applies for pairs only (for pset see st_Plu)
  if ( AType in cGroupDisplay ) then
  begin

    // Create a new single term
    Single := TSingle.Create( Lang );
    Single.TID := Self.TID;
    Single.Category := st_Dis;
    Single.IsUniversal := IsUniv;
    MyType := Self.TypeEntity;

    // Handling of symmetrical entities
    if ( ( MyType = to_ParMat ) or ( MyType = to_ParImm ) ) then
      IsGen := Single.MakeDisPair( AType );

    // Return the new term
    if ( IsGen ) then
    begin
      Self.AddTerm( Single );
      Self.CurrSingle := Single;
    end else
      Self.CurrSingle := nil;
    Exit;
  end else // End of treatment of st_Dis

//______________________________________________________________________________

  // Check for a missing official synonyms and autogenerate it
  if ( ( AType = st_Off ) or
       ( AType = st_Ofd) or
       ( AType = st_Of2 ) or
       ( AType = st_Of3 ) ) then
  begin

    // Create a new single term
    Single := tSingle.Create( Lang );
    Single.TID := Self.TID;
    Single.Category := AType;
    Single.IsUniversal := IsUniv;
    MyLink := Self.Link;
    MyType := Self.TypeEntity;

    // Handling of lateral member entities
    if ( ( MyLink = pw_MemberL ) or ( MyLink = pw_MemberR ) or
         ( MyLink = pw_SMemberL ) or ( MyLink = pw_SMemberR ) or
         ( MyLink = pw_IMemberL ) or ( MyLink = pw_IMemberR ) or
         ( MyLink = pw_TMemberL ) or ( MyLink = pw_TMemberR ) ) then
    begin
      IsGen := Single.MakeOffLateral;
    end else

    // Handling of pairs
    if ( MyType in [ to_ParMat, to_ParImm ] ) then
    begin
      IsGen := Single.MakeOffPair;
    end else

    // Handling of sets
    if ( MyType in [ to_SetMat, to_SetImm ] ) then
    begin
      IsGen := Single.MakeOffSet;
    end else

    // Handling of psets
    if ( MyType in [ to_PstMat, to_PstImm ] ) then
    begin
      IsGen := Single.MakeOffPset;
    end else

    // Handling of base term
    begin
      IsGen := Single.MakeOffBas;
    end;

    // Return the new term
    if ( IsGen ) then
    begin
      Self.AddTerm( Single );
      Self.CurrSingle := Single;
    end else
      Self.CurrSingle := nil;
    Exit;
  end else // end of treatment of st_Off

//______________________________________________________________________________

  // Check for a missing FMA term in pairs and autogenerate it
  if ( AType = st_FMA ) then
  begin

    // Create a new single term
    Single := TSingle.Create( Lang );
    Single.TID := Self.TID;
    Single.Category := st_Bas;
    Single.IsUniversal := IsUniv;

    // Take the FMA term of the generator for a pair
    if ( ( Self.TetraTip = tp_pair ) or ( Self.TetraTip = tp_pset ) ) then
    begin
      IsGen := Single.MakeFMAPair;
    end;

    // Return the new term
    if ( IsGen ) then
    begin
      Self.AddTerm( Single );
      Self.CurrSingle := Single;
    end else
      Self.CurrSingle := nil;
    Exit;
  end else // end of treatment of st_FMA

//______________________________________________________________________________

  // Check for a missing official synonyms in display form and autogenerate it
  if ( ( AType = st_Ofd ) or ( AType = st_Od2 ) or ( AType = st_Od3 ) ) then
  begin

    // Create a new single term
    Single := TSingle.Create( Lang );
    Single.TID := Self.TID;
    Single.Category := AType;
    MyLink := Self.Link;
    MyType := Self.TypeEntity;

    // Handling of lateral member entities
    if ( MyLink in [ pw_MemberL, pw_MemberR, pw_SMemberL, pw_SMemberR,
         pw_IMemberL, pw_IMemberR, pw_TMemberL, pw_TMemberR ] ) then
    begin
      IsGen := Single.MakeOffLateral;
    end else

    // Handling of pairs
    if ( MyType in [ to_ParMat, to_ParImm ] ) then
    begin
      IsGen := Single.MakeOfdPair;
    end else

    // Handling of single entity
    if ( MyType in [ to_Mat, to_Imm ] ) then
    begin
      // IsGen := Single.MakeOfdSingle;
      IsGen := Single.MakeOffBas;
    end else

    // Handling of sets
    if ( MyType in [ to_SetMat, to_SetImm ] ) then
    begin
      IsGen := Single.MakeOffSet;
    end else

    // Handling of psets
    if ( MyType in [ to_PstMat, to_PstImm ] ) then
    begin
      IsGen := Single.MakeOffPset;
    end;

    // Return the new term
    if ( IsGen ) then
    begin
      Self.AddTerm( Single );
      Self.CurrSingle := Single;
    end else
      Self.CurrSingle := nil;
    Exit;
  end else

//______________________________________________________________________________

  // Check for a universal term from the model
  // This group is necessary when a universal term is required for a non
  // generic entity, when the procedure MakeFormula() fails.
  if ( AType in cGroupFormula ) then
  begin
    MySingle := tSingle.Create( Lang );
    MySingle.TID := Self.TID;
    MySingle.IsUniversal := IsUniv;
    MyType := Self.TypeEntity;
    MyLink := Self.Link;
    MySingle.Category := AType;

    // Handling of lateral member entities
    if ( ( MyLink = pw_MemberL ) or ( MyLink = pw_MemberR ) or
         ( MyLink = pw_SMemberL ) or ( MyLink = pw_SMemberR ) or
         ( MyLink = pw_IMemberL ) or ( MyLink = pw_IMemberR ) or
         ( MyLink = pw_TMemberL ) or ( MyLink = pw_TMemberR ) ) then
    begin
      IsGen := MySingle.MakeFormulaLateral;
    end else

    // Handling of sets
    if ( ( MyType = to_SetMat ) or ( MyType = to_SetImm ) ) then
    begin
      IsGen := MySingle.MakeFormulaSet( AType );
    end else

    // Handling of psets
    if ( MyType in [ to_PstMat, to_PstImm ] ) then
    begin
      IsGen := MySingle.MakeFormulaPset;
    end else

    // Handling of symmetrical entities
    if ( MyType = to_ParMat ) or ( MyType = to_ParImm ) or
       ( MyType = to_PstMat ) or ( MyType = to_PstImm ) then
    begin
      IsGen := MySingle.MakeFormulaPair;
    end else

    // Handling of single entities
    if ( ( AType <> st_For ) and ( AType <> st_Fr1 ) and
         ( AType <> st_Fr2 ) and ( AType <> st_Fr3 ) ) then
    begin
      IsGen := MySingle.MakeFormulaSingle;
    end;

    if ( IsGen ) then
    begin
      Self.AddTerm( MySingle );
      Self.CurrSingle := MySingle;
    end else
      Self.CurrSingle := nil;
    Exit;
  end; // End of treatment of st_For or st_Uni and variants
end; // ______________________________________________________________SearchTerm

procedure          tEntity.AddTerm(
  MyTerm:          TSingle );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddTerm
  * Add a term in any language or universal *
  Description:
  This procedure adds a specified new term to the set of already stored terms
  of the calling entity. It acts on the specified current language.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbTerm:          Integer;
  Lang:            tLanguage;
begin
  NbTerm := Self.NbCurrent;
  Inc( NbTerm );
  Lang := Self.fLgCurr;
  case Lang of
    lt_Latin: SetLength( Self.fLATerms, NbTerm  );
    lt_English: SetLength( Self.fENTerms, NbTerm  );
    lt_French: SetLength( Self.fFRTerms, NbTerm  );
    lt_Spanish: SetLength( Self.fESTerms, NbTerm  );
    lt_Russian: SetLength( Self.fRUTerms, NbTerm  );
    lt_Italian: SetLength( Self.fITTerms, NbTerm  );
    lt_German: SetLength( Self.fGETerms, NbTerm  );
    lt_Portugese: SetLength( Self.fPTTerms, NbTerm  );
    lt_Universal: SetLength( Self.fMDTerms, NbTerm  );
  end;
  Self.CurrTerm[ NbTerm - 1 ] := MyTerm;
end; // _________________________________________________________________AddTerm

procedure          TEntity.GetNumberOfChildren(
  IsTax:           Boolean;
  TA98:            Boolean;
  IsShort:         Boolean;
  var NbChildren:  Integer;
  var NbSpecific:  Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNumberOfChildren
  * Compute the number of children of the actual entity *
  Description:
  The recursive method computes the exact number of descendants below an
  entity.</P>
  The IsTax parameter asserts the case of a taxonomy, otherwise a partonomy
  is assumed.</P>
  The IsShort parameter indicates to discard all left and right members of
  pairs in the computed total.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  TotChildren:     Integer;
  TotSpecific:     Integer;
  Posit:           Integer;
  NbPos:           Integer;
  IsGeneric:       Boolean;
  Children:        String;
  Child:           String;
  Next:            TEntity;
  MyPos:           Array[ 0 .. 2 ] of Integer;
begin
  // Get children and their number for taxonomy
  if ( IsTax ) then
  begin
    TotChildren := Self.NbTaxC;
    Children := Self.TaxCh
  end else
  begin

    // Get children and their number for TA98 partonomy
    if ( TA98 ) then
    begin
      if ( Self.TetraTip = tp_dup ) then
        Next := Self
      else
        Next := TAH.GetTA98EntityByTID( Self.TID );
      if ( Next <> nil ) then
      begin
        TotChildren := Next.NbPart98;
        Children := Next.Ch98;
      end;
    end else

    // Get children and their number for standard partonomy
    begin
      TotChildren := Self.NbPartC;
      Children := Self.PartCh;
    end;
  end;

  // Loop on all children
  TotSpecific := 0;
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
    Next := TAH.GetEntityByTID( StrToInt( Child ) );

    // Check and count specific entities
    NbPos := 0;
    TAH.GetPositionsByGen( Next.TID, NbPos, MyPos );
    IsGeneric := False;
    if ( Next.TaxAnc > 0 ) then
      IsGeneric := ( Length( Next.TaxCh ) > 0 ) or ( NbPos > 0 );
    IsGeneric := IsGeneric or Next.Generic;
    if ( ( IsTax ) and ( not IsShort ) and ( not IsGeneric ) ) then
      Inc( NbSpecific );

    // Exclude lateral entities for the short option
    if ( Next <> nil ) then
    begin
      if ( ( IsShort ) and
           ( ( Next.Link = pw_MemberL ) or
             ( Next.Link = pw_MemberR ) or
             ( Next.Link = pw_SMemberL ) or
             ( Next.Link = pw_SMemberR ) or
             ( Next.Link = pw_IMemberL ) or
             ( Next.Link = pw_IMemberR ) or
             ( Next.Link = pw_TMemberL ) or
             ( Next.Link = pw_TMemberR ) ) ) then
      begin
        Dec( TotChildren, 1 );
        Continue;
      end;

      // Recursively compute the number of descendants (exclude references)
      Next.GetNumberOfChildren( IsTax, TA98, IsShort, TotChildren,
                                TotSpecific );
    end;
  end; // while ( Children <> cEmpty )
  Inc( NbChildren, TotChildren );
  Inc( NbSpecific, TotSpecific );
end; // _____________________________________________________GetNumberOfChildren

procedure          tEntity.TermHierarchy(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TermHierarchy
  * Build the list of partonomic ancestors of an entity *
  Description:
  This recursive procedure builds the list of partonomic ancestors of
  the current entity, this later being included at the last position of
  the list. The first position normally always is for the top TA entity.
  The expansion of the hierarchy stops in the presence of a display link.<P>
  The entry value is the position of the TAH entry for which we are searching
  the ancestors.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyEntity:        tEntity;
  MyAnc:           Integer;
begin

  // Search the partonomy up to the top entity
  MyEntity := TAH.GetEntityByTID( TID );
  if ( MyEntity <> nil ) then
  begin
    if ( MyEntity.Display <> ds_c ) then
    begin
      MyAnc := MyEntity.PartAnc;
      if ( MyAnc > 0 ) then
      begin
        Self.TermHierarchy( MyAnc );
        Self.AddPartHierar( TID );
      end else
      if ( Self.NbPartHierar = 0 ) then
        Self.AddPartHierar( TID );
    end else
      Self.AddPartHierar( TID );
  end;
end; // ___________________________________________________________TermHierarchy

procedure          TEntity.AddPartHierar(
  TID:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddPartHierar
  * Add a new item at last position of the list of partonomic ancestors *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Lgt:             Integer;
begin
  Lgt := Length( FPartHierar );
  SetLength( Self.FPartHierar, Lgt + 1 );
  Self.FPartHierar[ Lgt ] := TID;
end; // ___________________________________________________________AddPartHierar

procedure          TEntity.GetHierarProperties(
  var IsBil:       Boolean;
  var IsMul:       Boolean;
  var IsMat:       Boolean;
  var IsImm:       Boolean;
  var IsNon:       Boolean;
  var IsDim:       Boolean;
  var IsGen:       Boolean;
  var IsSpc:       Boolean;
  var IsPar:       Boolean;
  var IsGtr:       Boolean );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetHierarProperties
  * Retrieve the properties dependant on taxonomy *
  Description:
  This method looks at the taxonomy and compile the related properties.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NbPos:           Integer;
  MyPos:           Array[ 0 .. 2 ] of Integer;
  MyType:          TType;
begin
  // Bilaterality
  IsBil := Self.IsBilateral();

  // Search properties dependant on type of entity
  MyType := Self.TypeEntity;
  IsPar := ( ( MyType = to_ParMat ) or ( MyType = to_ParImm ) or
             ( MyType = to_PstMat ) or ( MyType = to_PstImm ) );
  IsMul := ( ( MyType = to_SetMat ) or ( MyType = to_SetImm ) or
             ( MyType = to_PstMat ) or ( MyType = to_PstImm ) );
  IsMat := ( ( MyType = to_Mat ) or ( MyType = to_SetMat ) or
             ( MyType = to_ParMat ) or ( MyType = to_PstMat ) );
  IsImm := ( ( MyType = to_Imm ) or ( MyType = to_SetImm ) or
             ( MyType = to_ParImm ) or ( MyType = to_PstImm ) );
  IsNon := ( ( MyType = to_Non ) );
  IsDim := ( ( MyType = to_HomMat ) or ( MyType = to_HomImm ) );

  // Search for a generic or a specific entity
  IsGen := False;
  IsSpc := False;
  if ( not IsNon ) then
  begin
    IsGen := ( ( Self.TetraTip = tp_genPair ) or
               ( Self.TetraTip = tp_genSet ) or
               ( Self.TetraTip = tp_genPSet ) or
               ( Self.TetraTip = tp_setPSet ) or
               ( Self.TetraTip = tp_tax ) );
    IsGen := ( IsGen or Self.Generic );
    IsSpc := not IsGen;
  end;

  // Search for a generator of set or pair set
  NbPos := 0;
  TAH.GetPositionsByGen( Self.TID, NbPos, MyPos );
  IsGtr := NbPos > 0;
end; // _____________________________________________________GetHierarProperties

procedure          TEntity.GetTaxonomy(
  var TaxEntity:   array of TEntity;
  var NbTax:       Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetTaxonomy
  * Build the taxonomy of actual entity *
  Description:
  This method recursively compiles the list of taxonomic ancestors.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Father:          TEntity;
begin
  TaxEntity[ NbTax ] := Self;
  Inc( NbTax );
  Father := TAH.GetEntityByTID( Self.TaxAnc );
  if ( Father <> nil ) then
    Father.GetTaxonomy( TaxEntity, NbTax );
end; // _____________________________________________________________GetTaxonomy

function           TEntity.GetChildren(
  IsTax:           Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetChildren
  * Get the list of direct children for a TAH entity *
  Description:
  This function returns the unsorted semicolumn delimited list of all
  children identifiers of the specified entity.<P>
  In addition, a sorted array of children identifiers is provided as a
  return argument. The order is specified by the position argument as issued
  from the TAH database.<P>
  This function is sensitive to the type of hierarchy, either partonomy or
  taxonomy.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  PosChild:        Integer;
  PosPosition:     Integer;
  LeastPos:        Integer;
  Transit:         Integer;
  TotChildren:     Integer;
  Order:           String;
  ListChildren:    String;
  PosList:         array of Integer;
  Children:        array of Integer;
begin
  // Retrieve children information according to hierarchy type
  if ( IsTax ) then
    TotChildren := Self.NbTaxC
  else
    TotChildren := Self.NbPartC;
  Result := cEmpty;
  if ( TotChildren = 0 ) then
    Exit;
  if ( IsTax ) then
    Order := Self.TaxPos
  else
    Order := Self.PartPos;
  SetLength( Children, TotChildren );
  SetLength( PosList, TotChildren );
  if ( IsTax ) then
    ListChildren := Self.TaxCh
  else
    ListChildren := Self.PartCh;
  Result := ListChildren;

  // Extract each child and its position
  for Indx := 0 to TotChildren - 1 do
  begin
    PosChild := Pos( cSemi, ListChildren );
    PosPosition := Pos( cSemi, Order );
    if ( PosChild > 0 ) then
    begin
      Children[ Indx ] := StrToInt( Copy( ListChildren, 1, PosChild - 1 ) );
      PosList[ Indx ] := StrToInt( Copy( Order, 1, PosPosition - 1 ) );
      ListChildren :=
        Copy( ListChildren, PosChild + 1, Length( ListChildren ) );
      Order := Copy( Order, PosPosition + 1, Length( Order ) );
    end else
    begin
      Children[ Indx ] := StrToInt( ListChildren );
      PosList[ Indx ] := StrToInt( Order );
      ListChildren := cEmpty;
      Order := cEmpty
    end;
  end; // for

  // Sort the children according to positions
  for Indx := 0 to TotChildren - 2 do
  begin
    LeastPos := Indx;
    for Indy := Indx + 1 to TotChildren - 1 do
      if PosList[ Indy ] < PosList[ LeastPos ] then
        LeastPos := Indy;
    if ( LeastPos <> Indx ) then
    begin
      Transit := Children[ LeastPos ];
      Children[ LeastPos ] := Children[ Indx ];
      Children[ Indx ] := Transit;
      Transit := PosList[ LeastPos ];
      PosList[ LeastPos ] := PosList[ Indx ];
      PosList[ Indx ] := Transit;
    end;
  end; // for

  //
  for Indx := 0 to TotChildren - 1 do
  begin
    Self.SetSortedChild( Indx, Children[ Indx ] );
  end;
end; // _____________________________________________________________GetChildren

procedure          TEntity.SetSortedChild(
  Pos:             Integer;
  Value:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetSortedChild
  *  *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( Self.FSortedChildren, Pos + 1 );
  Self.FSortedChildren[ Pos ] := Value;
end; // __________________________________________________________SetSortedChild

function           tEntity.IsDeletedTerm(
  SynType:         tSynType )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsDeletedTerm
  * Retrieve a deleted synonym *
  Description:
  This functions scan all current terms and looks for the refutation of the
  currently specified synonym, giving a true result.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx: Integer;
begin
  Result := False;
  for Indx := 0 to Self.NbCurrent - 1 do
  begin
    if ( ( ( Self.CurrTerm[ Indx ].Category = st_dl1 ) and
           ( SynType = st_ofd ) ) or
         ( ( Self.CurrTerm[ Indx ].Category = st_dl2 ) and
           ( SynType = st_od2 ) ) or
         ( ( Self.CurrTerm[ Indx ].Category = st_dl3 ) and
           ( SynType = st_od3 ) ) ) then
    begin
      Result := True;
      Break;
    end;
  end; // on all current terms
end; // ______________________________________]____________________IsDeletedTerm

end.
