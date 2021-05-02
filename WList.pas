{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit WList
  * Classs for list of words*
  Description:
  Unit dedicated to list of words in universal formulas.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit WList;

interface

uses
  TAHParam;

type

  OccRec                     = record
    UID:                     Integer;
    Match:                   String;
  end;
  OccList                    = array of OccRec;

                             // Class for collection of formula entities
  tWordList                  = class( TObject )
  private
                             // Trigger UID defining the list
    FTrg:                    Integer;
                             // Noun pattern for complementary search
    FNPatt:                  String;
                             // Adjective pattern for complementary search
    FAPatt:                  String;
                             // Prefix pattern for complementary search
    FPPatt:                  String;
                             // List of occurences
    FOcc:                    OccList;
                             //
    FPlus:                   Integer;
                             // Get the number of occurences
    function                 GetNbOcc()
                               : Integer;
                             // Retrieve an occurence
    function                 GetOcc(
                               Index: Integer )
                               : OccRec;
  public
    constructor              Create(
                               Trigger: Integer );
                             // UID of trigger unit
    property Trigger:        Integer read FTrg write FTrg;
                             // Search pattern for noun
    property NPattern:       String read FNPatt write FNPatt;
                             // Search pattern for adjective
    property APattern:       String read FAPatt write FAPatt;
                             // Search pattern for prefix
    property PPattern:       String read FPPatt write FPPatt;
                             // All occurences of the trigger word
    property Occur
      [ Index: Integer ]:    OccRec read GetOcc;
                             // Number of occurences
    property NbWord:         Integer read GetNbOcc;
                             // Number of complementary terms
    property NbPlus:         Integer read FPlus;
  end;

                             // Class for collection of supplementary entities
  tSupList                   = class( TObject )
  private
                             // List of occurences
    FSup:                    OccList;
                             // Get the number of occurences
    function                 GetNbSup()
                               : Integer;
                             // Retrieve an occurence
    function                 GetSup(
                               Index: Integer )
                               : OccRec;
  public
    constructor              Create;
                             // Set the number of occurences
    procedure                SetNbSup(
                               Len: Integer );
                             // Enter a new occurence
    procedure                SetSup(
                               Index: Integer;
                               Value: OccRec );
                             // All occurences
    property Occur
      [ Index: Integer ]:    OccRec read GetSup;
                             // Number of occurences
    property NbSup:          Integer read GetNbSup;
  end;

implementation

uses
  TAHBrowser, SysUtils, SingleTerms, Entity;

constructor        tWordList.Create(
  Trigger:         Integer);
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create/1
  * Create the word list *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  TotFormula:      Integer;
  TotLAPlus:       Integer;
  Posit:           Integer;
  NbOcc:           Integer;
  Count:           Integer;
  MyUID:           Integer;
  Already:         Boolean;
  MyTrg:           String;
  MyNoun:          String;
  MyAdjective:     String;
  MyPrefix:        String;
  MyPattern:       String;
  MyLibelle:       String;
  MyFormula:       tSingle;
  MyLAPlus:        tSingle;
  MandFormula:     tSingle;
  MyOcc:           OccRec;
  MyCat:           tSynType;
  Actual:          tEntity;
begin
  Self.FTrg := Trigger;
  MyTrg := IntToStr( Trigger );
  Self.FPlus := 0;

  // Loop on all formulas
  TotFormula := 0; // TAH.NbFormula;
  NbOcc := 0;
  for Indx := 0 to TotFormula - 1 do
  begin

    // Check for basic part
    MyFormula := TAH.GetFormula( Indx );
    MyLibelle := MyFormula.Libelle;
    Posit := Pos( cRol + MyTrg + cRor, MyLibelle );
    if ( Posit > 0 ) then
      Posit := Posit + 1;

    // Check for mandatory expansion
    if ( ( Posit = 0 ) and ( MyFormula.Obl > 0 ) ) then
    begin
      Actual := TAH.GetEntityByPos( MyFormula.Obl );
      if ( Actual = nil ) then
        Continue;
      Actual.LgCurrent := lt_Universal;
      if ( Actual.NbCurrent = 0 ) then
        Continue;
      MandFormula := Actual.CurrTerm[ 0 ];
      MyLibelle := MandFormula.Libelle;
      Posit := Pos( cRol + MyTrg + cRor, MyLibelle );
      if ( Posit > 0 ) then
        Posit := Posit + 1;
    end;

    // Check for optional expansion
    if ( ( Posit = 0 ) and ( MyFormula.Exp > 0 ) ) then
    begin
      Actual := TAH.GetEntityByPos( MyFormula.Exp );
      if ( Actual = nil ) then
        Continue;
      Actual.LgCurrent := lt_Universal;
      if ( Actual.NbCurrent = 0 ) then
        Continue;
      MandFormula := Actual.CurrTerm[ 0 ];
      MyLibelle := MandFormula.Libelle;
      Posit := Pos( cRol + MyTrg + cRor, MyLibelle );
      if ( Posit > 0 ) then
        Posit := Posit + 1;
    end;

    // Store the matching entities
    if ( Posit > 0 ) then
    begin
      MyOcc.UID := MyFormula.UID;
      MyOcc.Match := Copy( MyLibelle, Posit - 2, 1 );
      MyOcc.Match := MyOcc.Match + 'F';
      MyCat := MyFormula.Category;
      case MyCat of
        st_Mod: MyOcc.Match := MyOcc.Match + 'M';
        st_Md1: MyOcc.Match := MyOcc.Match + '1';
        st_Md2: MyOcc.Match := MyOcc.Match + '2';
        st_Md3: MyOcc.Match := MyOcc.Match + '3';
      end;
      MyOcc.Match := MyOcc.Match + 'B';
      NbOcc := Length( Self.FOcc );
      Inc( NbOcc );
      SetLength( Self.FOcc, NbOcc );
      Self.FOcc[ NbOcc - 1 ] := MyOcc;
    end;
  end; // for on all formulas

  // Define the search patterns for complementary terms
  Actual := TAH.GetEntityByPos( Trigger );
  MyNoun := Actual.GetVocabulary( lt_Latin, st_Nou );
  MyAdjective := Actual.GetVocabulary( lt_Latin, st_Adj );
  MyPrefix := Actual.GetVocabulary( lt_Latin, st_Pre );
  Self.PPattern := cEmpty;
  if ( MyPrefix <> cEmpty ) then
    Self.PPattern := MyPrefix;
  Self.NPattern := cEmpty;
  if ( MyNoun <> cEmpty ) then
    Self.NPattern := MyNoun;
  Self.APattern := cEmpty;
  if ( MyAdjective <> cEmpty ) then
    Self.APattern := Copy( MyAdjective, 1, Length( MyAdjective ) - 2 );

  // Loop on complementary terms (non universal)
  TotLAPlus := TAH.NbLAPlus;
  Count := 0;

  // Match on noun pattern
  MyPattern := Self.NPattern;
  if ( MyPattern <> cEmpty ) then
  begin
    for Indx := 0 to TotLAPlus - 1 do
    begin
      MyLAPlus := TAH.GetLAPlus( Indx );
      Posit := Pos( cSpace + MyPattern + cSpace,
                    cSpace + MyLAPlus.Libelle + cSpace );
      if ( Posit > 0 ) then
        Posit := Posit + 1;
      if ( Posit > 0 ) then
      begin

        // Check that this entity is not already in the list
        Actual := TAH.GetEntityByPos( MyLAPlus.TID );
        if ( Actual = nil ) then
          Continue;
        MyUID := Actual.Tetra;
        Already := False;
        for Indy := 0 to NbOcc - 1 do
        begin
          if ( Self.FOcc[ Indy ].UID = MyUID ) then
          begin
            Already := True;
            Break;
          end;
        end; // for on all already existing entities
        if ( Already ) then
          Continue;

        // Store the matching entities
        MyOcc.UID := MyUID;
        MyOcc.Match := 'X';
        MyOcc.Match := MyOcc.Match + 'S';
        MyCat := MyLAPlus.Category;
        case MyCat of
          st_Bas: MyOcc.Match := MyOcc.Match + 'B';
          st_Off: MyOcc.Match := MyOcc.Match + 'I';
          st_Of2: MyOcc.Match := MyOcc.Match + 'J';
          st_Of3: MyOcc.Match := MyOcc.Match + 'K';
          st_RAT: MyOcc.Match := MyOcc.Match + 'R';
        end;
        MyOcc.Match := MyOcc.Match + 'B';
        NbOcc := Length( Self.FOcc );
        Inc( NbOcc );
        SetLength( Self.FOcc, NbOcc );
        Self.FOcc[ NbOcc - 1 ] := MyOcc;
        Inc( Count );
      end;
    end; // for on all Latin complementary terms matching the noun pattern
  end;

  // Match on adjective pattern
  MyPattern := Self.APattern;
  if ( MyPattern <> cEmpty ) then
  begin
    for Indx := 0 to TotLAPlus - 1 do
    begin
      MyLAPlus := TAH.GetLAPlus( Indx );
      Posit := Pos( cSpace + MyPattern,
                    cSpace + MyLAPlus.Libelle );
      if ( Posit > 0 ) then
      begin

        // Check that this entity is not already in the list
        Actual := TAH.GetEntityByPos( MyLAPlus.TID );
        if ( Actual = nil ) then
          Continue;
        MyUID := Actual.Tetra;
        Already := False;
        for Indy := 0 to NbOcc - 1 do
        begin
          if ( Self.FOcc[ Indy ].UID = MyUID ) then
          begin
            Already := True;
            Break;
          end;
        end; // for on all already existing entities
        if ( Already ) then
          Continue;

        // Store the matching entities
        Actual := TAH.GetEntityByPos( MyLAPlus.TID );
        if ( Actual = nil ) then
          Continue;
        MyOcc.UID := Actual.Tetra;
        MyOcc.Match := 'X';
        MyOcc.Match := MyOcc.Match + 'S';
        MyCat := MyLAPlus.Category;
        case MyCat of
          st_Bas: MyOcc.Match := MyOcc.Match + 'B';
          st_Off: MyOcc.Match := MyOcc.Match + 'I';
          st_Of2: MyOcc.Match := MyOcc.Match + 'J';
          st_Of3: MyOcc.Match := MyOcc.Match + 'K';
          st_RAT: MyOcc.Match := MyOcc.Match + 'R';
        end;
        MyOcc.Match := MyOcc.Match + 'B';
        NbOcc := Length( Self.FOcc );
        Inc( NbOcc );
        SetLength( Self.FOcc, NbOcc );
        Self.FOcc[ NbOcc - 1 ] := MyOcc;
        Inc( Count );
      end;
    end; // for on all Latin complementary terms matching the adjective pattern
  end;

  // Match on prefix pattern
  MyPattern := Self.PPattern;
  if ( MyPattern <> cEmpty ) then
  begin
    for Indx := 0 to TotLAPlus - 1 do
    begin
      MyLAPlus := TAH.GetLAPlus( Indx );
      Posit := Pos( cSpace + MyPattern, cSpace + MyLAPlus.Libelle );
      if ( Posit > 0 ) then
        Posit := Posit + 1;
      if ( Posit > 0 ) then
      begin

        // Check that this entity is not already in the list
        Actual := TAH.GetEntityByPos( MyLAPlus.TID );
        if ( Actual = nil ) then
          Continue;
        MyUID := Actual.Tetra;
        Already := False;
        for Indy := 0 to NbOcc do
        begin
          if ( Self.FOcc[ Indy ].UID = MyUID ) then
          begin
            Already := True;
            Break;
          end;
        end; // for on all already existing entities
        if ( Already ) then
          Continue;

        // Store the matching entities
        Actual := TAH.GetEntityByPos( MyLAPlus.TID );
        if ( Actual = nil ) then
          Continue;
        MyOcc.UID := Actual.Tetra;
        MyOcc.Match := 'X';
        MyOcc.Match := MyOcc.Match + 'S';
        MyCat := MyLAPlus.Category;
        case MyCat of
          st_Bas: MyOcc.Match := MyOcc.Match + 'B';
          st_Off: MyOcc.Match := MyOcc.Match + 'I';
          st_Of2: MyOcc.Match := MyOcc.Match + 'J';
          st_Of3: MyOcc.Match := MyOcc.Match + 'K';
          st_RAT: MyOcc.Match := MyOcc.Match + 'R';
        end;
        MyOcc.Match := MyOcc.Match + 'B';
        NbOcc := Length( Self.FOcc );
        Inc( NbOcc );
        SetLength( Self.FOcc, NbOcc );
        Self.FOcc[ NbOcc - 1 ] := MyOcc;
        Inc( Count );
      end;
    end; // for on all Latin complementary terms matching the prefix pattern
  end;
  Self.FPlus := Count;
end; // ________________________________________________________________Create/1

function           TWordList.GetNbOcc()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbOcc
  * Retrieve the number of occurences in the formula list *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FOcc );
end; // ________________________________________________________________GetNbOcc

function           TWordList.GetOcc(
  Index:           Integer )
  :                OccRec;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetOcc
  * Retrieve the specified occurence in the formula list *
  Description:
  The occurence specified by the index is returned if it is in the range of
  the actual list. If not, a fake record with null identifier is returned.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyRec:           OccRec;
begin

  // Check for an empty list or invalid index
  if ( ( Length( Self.FOcc) <= 0 ) or
       ( Length( Self.FOcc) < Index ) or
       ( Index < 0 ) ) then
  begin
    MyRec.UID := 0;
    Result := MyRec;
  end;

  // Get the specified occurence
  Result := Self.FOcc[ Index ];
end; // __________________________________________________________________GetOcc

constructor        TSupList.Create;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create
  * Create a supplementary list *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( FSup, 0 );
end; // __________________________________________________________________Create

function           TSupList.GetNbSup()
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbSup
  * Retrieve the number of occurences in the supplementary list *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FSup );
end; // ________________________________________________________________GetNbSup

procedure          TSupList.SetNbSup(
  Len:             Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNbSup
  * Set the number of occurences in the supplementary list *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetLength( FSup, Len );
end; // ________________________________________________________________SetNbSup

function           TSupList.GetSup(
  Index:           Integer )
  :                OccRec;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetSup
  * Retrieve the specified occurence in the supplementary list *
  Description:
  The occurence specified by the index is returned if it is in the range of
  the actual list. If not, a fake record with null identifier is returned.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyRec:           OccRec;
begin

  // Check for an empty list or invalid index
  if ( ( Length( Self.FSup) <= 0 ) or
       ( Length( Self.FSup) < Index ) or
       ( Index < 0 ) ) then
  begin
    MyRec.UID := 0;
    Result := MyRec;
  end;

  // Get the specified occurence
  Result := Self.FSup[ Index ];
end; // __________________________________________________________________GetSup

procedure          TSupList.SetSup(
  Index:           Integer;
  Value:           OccRec );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetSup
  * Set a specified occurence in the supplementary list *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if ( ( Index >= 0 ) and ( Index < Length( Self.FSup ) ) ) then
    Self.FSup[ Index ] := Value;
end; // __________________________________________________________________SetSup

end.
