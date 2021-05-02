{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit Tetra
  * Class definition of a TAH unit *
  Description:
  This class represents a single unit (formerly a tetrahedron). A unit groups
  several related entities in a common recipient. The entities are
  virtual in the database and must be recreated at load time. The complete
  rebuild of entities is accomplished only when needed, on request of the
  several programs.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit Tetra;

interface

uses
  System.Classes, StdCtrls, TAHParam, ComCtrls, SysUtils;

type
                             // Class for a single unit
  tUnit                      = class( TObject )
  private
                             // Imported items
    fUID:                    Integer;                                    // # 1
    fFID:                    Integer;
    fFMAsin:                 Integer;
    fFMAdex:                 Integer;
    fFMAset:                 Integer;
    fCod:                    String;
    fRef:                    Integer;
    fGnr:                    Integer;
    fSet:                    Integer;
    fMai:                    Integer;

    fSin:                    Integer;                                    // # 11
    fDex:                    Integer;
    fTyp:                    tTetra;
    fMat:                    tMaterial;
    fPar:                    Integer;
    fSqp:                    Integer;
    fBro:                    Boolean;
    fP98:                    Integer;
    fS98:                    Integer;
    fTax:                    Integer;

    fSqt:                    Integer;                                    // # 21
    fNv1:                    Integer;
    fSq1:                    Integer;
    fNv2:                    Integer;
    fSq2:                    Integer;
    fNv3:                    Integer;
    fSq3:                    Integer;
    fNv4:                    Integer;
    fSq4:                    Integer;
    fNv5:                    Integer;

    fSq5:                    Integer;                                    // # 31
    fPis:                    Integer;
    fChl:                    String;
    fInc:                    Boolean;
    fMdt:                    Boolean;
    fInd:                    tLevel;
    Sex:                     tSexe;
    Dim:                     Integer;
    Is98:                    Boolean;
    fLpt:                    String;

    fL98:                    String;                                     // # 41
    fLtx:                    String;
    fVoc:                    Integer;
    fTex:                    String;                                     // # 44
  public
                             // Unique identifier of the unit: from 0 to 24999
    property UID:            Integer read fUID; //                       // # 1
                             // FMA identifier
    property FID:            Integer read fFID;
                             // FMA identifier of left member if any
    property FMAsin:         Integer read fFMAsin;
                             // FMA identifier of right member if any
    property FMAdex:         Integer read fFMAdex;
                             // FMA identifier of a set
    property FMAset:         Integer read fFMAset;
                             // TA98 11-digit code
    property Cod98:          String read fCod;
                             // UID of a referenced unit
    property Reference:      Integer read fRef;
                             // Generator entity of the unit
    property Generator:      Integer read fGnr;
                             // Generator set entity for pset
    property ASet:           Integer read fSet;
                             // Main specific entity of the unit
    property Main:           Integer read fMai;

                             // Left specific entity
    property Left:           Integer read fSin;                          // # 11
                             // Right specific entity
    property Right:          Integer read fDex;
                             // Type of entity
    property TypUnit:        tTetra read fTyp;
                             // Materiality of unit/entity
    property Material:       tMaterial read fMat;
                             // Partonomic unique ancestor of the unit if any
                             // Due to the presence of generic partonomies,
                             // this ancestor may be is absent for top units.
    property Parto:          Integer read fPar;
                             // Sequential position in partonomic hierarchy
    property SeqPart:        Integer read fSqp;
                             // Flag for broken partonomy
    property Broken:         Boolean read fBro;
                             // TA98 partonomic unique ancestor of the unit
    property Part98:         Integer read fP98;
                             // TA98 sequential position in partonomic hierarchy
    property SeqPart98:      Integer read fS98;
                             // Taxonomic unique ancestor of the unit
    property Taxo:           Integer read fTax;

                             // Sequential position in taxonomic hierarchy
    property SeqTax:         Integer read fSqt;                          // # 21
                             // UID of level 1 segment
    property Level1:         Integer read fNv1;
                             // Position in level 1 segment
    property Seq1:           Integer read fSq1;
                             // UID of level 2 segment
    property Level2:         Integer read fNv2;
                             // Position in level 2 segment
    property Seq2:           Integer read fSq2;
                             // UID of level 3 segment
    property Level3:         Integer read fNv3;
                             // Position in level 3 segment
    property Seq3:           Integer read fSq3;
                             // UID of level 4 segment
    property Level4:         Integer read fNv4;
                             // Position in level 4 segment
    property Seq4:           Integer read fSq4;
                             // UID of level 5 segment
    property Level5:         Integer read fNv5;

                             // Position in level 5 segment
    property Seq5:           Integer read fSq5;                          // # 31
                             // Past UID for history of changes in taxonomy
    property PastID:         Integer read fPis;
                             // Type of change for PastID
    property Change:         String read fChl;
                             // Inconstant unit
    property Inconstant:     Boolean read fInc;
                             // Flag for mandatory part in generic partonomy
    property Mandat:         Boolean read fMdt;
                             // Indentation for TA98
    property Indent:         tLevel read fInd;
                             // Flag for gender
    property Sexe:           tSexe read Sex;
                             // Flag for sexually dimorphic unit
    property Dimorph:        Integer read Dim;
                             // Unit specific to TA98
    property List98:         Boolean read Is98;
                             // Partonomic level P0 to P4
    property ListPart:       String read fLpt;
                             // TA98 Partonomic level A1 to A4
    property ListPart98:     String read fL98;                           // # 41
                             // Taxonomic level T1 to T4
    property ListTax:        String read fLtx;
                             // UID of a vocabulary related unit
    property Vocabulary:     Integer read fVoc write fVoc;
                             // Internal name of unit
    property IntText:        String read fTex;                           // # 43

                             // Create a unit
    constructor              Create(
                               UID: Integer );
                               overload;
                             // Decode a single unit from its DB source string
    procedure                DecodeUnit(
                               Line: String );
                             // Compute the signature of list
    function                 GetSignature(
                               IsTax: Boolean;
                               TA98: Boolean;
                               var Seq: Integer;
                               var Level: Integer )
                               : Integer;
  end;

implementation

uses
  TAHBrowser, Entity;

constructor        tUnit.Create(
  UID:             Integer);
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ tUnit.Create/1
   * Create a unit for the specified identifier *
   Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited Create;
  Self.fUID := UID;
end; // __________________________________________________________tUnit.Create/1

procedure          tUnit.DecodeUnit(
  Line:            String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DecodeUnit
  * Build a single unit from raw file *
  Description:
  Input format is made of 43 fields
  Internal format is made of 43 fields:

  UID¦FID¦FMAsin¦FMAdex¦FMAset¦Cod¦Ref¦Gnr¦Set¦Mai¦
  Sin¦Dex¦Typ¦Mat¦Par¦Sqp¦Bro¦P98¦S98¦Tax¦
  Sqt¦Nv1¦Sq1¦Nv2¦Sq2¦Nv3¦Sq3¦Nv4¦Sq4¦Nv5¦
  Sq5¦Pis¦Chl¦Inc¦Mdt¦Ind¦Sex¦Dim¦Is98¦Lpr¦
  L98¦Ltx¦Tex

  The above order of fields corresponds to the input file. Internal storage
  is in a different order. See above declaration of the present class tUnit for
  internal storage.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  Lgt:             Integer;
  Trans:           String;
  IndT:            tType;
  IndL:            tLink;
  IndV:            tVersion;
  IndI:            tLevel;
  IndJ:            tDisplay;
  IndB:            tLaterality;
  IndU:            tTetra;
begin
  Lgt := Length( Line );
  with Self do
  begin

    // Identifiers: 6 items (plus UID already set)
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fFID := StrToInt( Trans )
    else
      fFID := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fFMAsin := StrToInt( Trans )
    else
      fFMAsin := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fFMAdex := StrToInt( Trans )
    else
      fFMAdex := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fFMAset := StrToInt( Trans )
    else
      fFMAset := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    FCod := Copy( Line, 1, Posit - 1 );
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fRef := StrToInt( Trans )
    else
      fRef := 0;

    // Components of tetrahedron: 5 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fGnr := StrToInt( Trans )
    else
      fGnr := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fSet := StrToInt( Trans )
    else
      fSet := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fMai := StrToInt( Trans )
    else
      fMai := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fSin := StrToInt( Trans )
    else
      fSin := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fDex := StrToInt( Trans )
    else
      fDex := 0;

    // Type of unit: 1 item
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    fTyp := tt_undef;
    for IndU := Succ( Low( tTetra ) ) to High( tTetra ) do
    begin
      if ( Trans = cTetraEN[ IndU ] ) then
        fTyp := IndU;
    end;

    // Materiality: 1 item
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    fMat := ma_undef;
    if ( Trans = 'm' ) then
      fMat := ma_mat
    else if ( Trans = 'i' ) then
      fMat := ma_imm
    else if ( Trans = 's' ) then
      fMat := ma_surf
    else if ( Trans = 'l' ) then
      fMat := ma_line
    else if ( Trans = 'p' ) then
      fMat := ma_point
    else if ( Trans = 'n' ) then
      fMat := ma_non;

    // Partonomic ancestor: 3 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    if Posit > 1 then
      fPar := StrToInt( Copy( Line, 1, Posit - 1 ) )
    else
      fPar := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      fSqp := StrToInt( Trans )
    else
      fSqp := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    fbro := Trans = '1';

    // TA98 Partonomic ancestor: 2 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    if Posit > 1 then
      fP98 := StrToInt( Copy( Line, 1, Posit - 1 ) )
    else
      fP98 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      FS98 := StrToInt( Trans )
    else
      FS98 := 0;

    // Taxonomic ancestor: 2 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    if Posit > 1 then
      FTax := StrToInt( Copy( Line, 1, Posit - 1 ) )
    else
      FTax := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      FSqt := StrToInt( Trans )
    else
      FSqt := 0;

    // Level and sequences: 10 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FNv1 := StrToInt( Trans )
    else
      FNv1 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FSq1 := StrToInt( Trans )
    else
      FSq1 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FNv2 := StrToInt( Trans )
    else
      FNv2 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FSq2 := StrToInt( Trans )
    else
      FSq2 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FNv3 := StrToInt( Trans )
    else
      FNv3 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FSq3 := StrToInt( Trans )
    else
      FSq3 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FNv4 := StrToInt( Trans )
    else
      FNv4 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FSq4 := StrToInt( Trans )
    else
      FSq4 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FNv5 := StrToInt( Trans )
    else
      FNv5 := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      FSq5 := StrToInt( Trans )
    else
      FSq5 := 0;

    // History of changes: 2 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if Length( Trans ) > 0 then
      FPis := StrToInt( Trans )
    else
      FPis := 0;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    FChl := Copy( Line, 1, Posit - 1 );

    // Tetrahedron: 6 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    FInc := Trans = '1';
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    FMdt := Trans = '1';
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    FInd := lv_undef;
    for IndI := low( tLevel ) to Pred( High( tLevel ) ) do
    begin
      if ( cLevel[ IndI ] = Trans ) then
      begin
        FInd := IndI;
        Break;
      end;
    end;

    // Sexually dimorphic attributes: 2 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    Sex := sx_undef;
    if ( Trans = cSexe[ sx_Female ] ) then
      Sex := sx_Female
    else
    if ( Trans = cSexe[ sx_Male ] ) then
      Sex := sx_Male;
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    if ( Length( Trans ) > 0 ) then
      Dim := StrToInt( Trans );

    // Appartenance to the TA98 hierarchy: 1 item
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    Trans := Copy( Line, 1, Posit - 1 );
    Is98 := Trans = '1';

    // Top units for the list hierarchies: 3 items
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    FLpt := Copy( Line, 1, Posit - 1 );
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    FL98 := Copy( Line, 1, Posit - 1 );
    Line := Copy( Line, Posit + 1, Lgt );
    Posit := Pos( CurSep, Line );
    FLtx := Copy( Line, 1, Posit - 1 );

    // Internal database name: 1 item
    FTex := Copy( Line, Posit + 1, Length( Line ) );
  end;
end; // ______________________________________________________________DecodeUnit

function           tUnit.GetSignature(
  IsTax:           Boolean;
  TA98:            Boolean;
  var Seq:         Integer;
  var Level:       Integer )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSignature
  * Compute the signature of any hierarchical list from its top unit *
  Description:
  This function computes the signature of any list specified by
  the current unit: it can be partonony, TA98 partonomy or taxonomy. The
  first two arguments defines the type of hierarchy: False False for partonomy,
  False True for TA98 partonomy and True False for taxonomy. The list
  includes all units at the present level and excludes any unit at a lower
  level.</P>
  When in presence of a lower level, the signature of this sublist is retrieved
  and modified by the actual sequence and level position.</P>
  When in presence of an ordinary unit, its UID is modified by the actual
  sequence and level position. Then, all children of this unit are processed
  in turn, and their signature is recursively computed. The resulting value is
  XORed to the current signature value.</P>
  All successive signature values are recalculated modulo 25000. In this way,
  any signature value lies in the range from 0 to 24999.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
  SeqInt           = 20437;      // Any change to these 3 constants would
  LevInt           = 17431;      // mean that all signatures should be
  Modulo           = 25000;      // recomputed!
var
  Indx:            Integer;
  Indy:            Integer;
  Inds:            Integer;
  MyUID:           Integer;
  MySig:           Integer;
  ChildSig:        Integer;
  TotChildren:     Integer;
  Posit:           Integer;
  NbOrder:         Integer;
  Small:           Integer;
  AnOrder:         Integer;
  Order:           Array[ 1 .. 50 ] of Integer;
  Child:           Array[ 1 .. 50 ] of Integer;
  Children:        String;
  SortList:        String;
  MyEntity:        tEntity;
  Next:            tEntity;
  ChildUnit:       tUnit;
begin
  // Compute the signature of the entity
  MyUID := Self.UID;
  MyEntity := TAH.GetEntityByTID( Self.FMai );
  if ( MyEntity = nil ) then
    MyEntity := TAH.GetEntityByTID( Self.FGnr );
  MySig := ( MyUID + Seq * SeqInt ) mod Modulo;
  MySig := ( MySig + Level * LevInt ) mod Modulo;

  // Get children, sequence positions and their number
  SortList := cEmpty;
  TotChildren := 0;
  if ( MyEntity <> nil ) then
  begin
    if ( IsTax ) then
    begin
      TotChildren := MyEntity.NbTaxC;
      Children := MyEntity.TaxCh;
      SortList := MyEntity.TaxPos;
    end else
    if ( TA98 ) then
    begin
      TotChildren := MyEntity.NbPart98;
      Children := MyEntity.Ch98;
      SortList := MyEntity.Pos98;
    end else
    begin
      TotChildren := MyEntity.NbPartC;
      Children := MyEntity.PartCh;
      SortList := MyEntity.PartPos;
    end;
  end;

  // Extract the list of positions
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
  end; // while list not exhausted

  // Extract the list of children
  for Indx := 1 to TotChildren do
  begin
    Posit := Pos( cSemi, Children );
    if ( Posit > 0 ) then
    begin
      Child[ Indx ] := StrToInt( Copy( Children, 1, Posit - 1 ) );
      Children := Copy( Children, Posit + 1, Length( Children ) );
    end else
    begin
      Child[ Indx ] := 0;
      if ( Children <> cEmpty ) then
        Child[ Indx ] := StrToInt( Children );
      Children := cEmpty;
    end;
  end; // for on all children

  // Loop on all children
  if ( TotChildren > 0 ) then
    Inc( Level );
  for Indx := 1 to TotChildren do
  begin

    // Search the position of the next child according to sortlist
    Small := 1;
    AnOrder := Order[ Small];
    for Indy := 2 to TotChildren do
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
    Next := TAH.GetEntityByTID( Child[ Inds ] );
    ChildUnit := TAH.GetUnitByPos( Next.Tetra );

    // Do not consider left and right members of pairs
    if ( Next.Tetra = MyUID ) then
      Continue;

    // Recursively compute the child signature
    Inc( Seq );
    ChildSig := 0;
    if ( ChildUnit <> nil ) then
      ChildSig := ChildUnit.GetSignature( IsTax, TA98, Seq, Level );

    // Apply the child signature to the actual entity
    MySig := ( MySig XOR ChildSig ) mod Modulo;
  end; // for on all children

  if ( TotChildren > 0 ) then
    Dec( Level );
  Result := MySig;
end; // ____________________________________________________________GetSignature

end.



