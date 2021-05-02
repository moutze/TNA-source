{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit Stat
  * Package for statistical analysis *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit Stat;

interface

uses
  TAHParam;

type
  StatProfil                 = Array of String;
  StatValue                  = Array of Integer;
  tStatUniversal             = class( TObject )
  private
    FUID:                    Integer;
    FTot:                    Integer;
    FUniv:                   Integer;
    FProf:                   StatProfil;
    FNoExp:                  StatValue;
    FMExp:                   StatValue;
    FFExp:                   StatValue;
    FMFExp:                  StatValue;
    FBrL:                    StatValue;
    FBrH:                    StatValue;
    function                 GetNbProfile:
                               Integer;
  public
                             // UID governing the list
    property TopID:          Integer read FUID write FUID;
                             // Number of submited items
    property Total:          Integer read FTot write FTot;
                             // Number of universal items
    property TotUniv:        Integer read FUniv write FUniv;
                             // Number of profile
    property NbProfile:      Integer read GetNbProfile;
                             //
    property Profile:        StatProfil read FProf;
                             //
    property NoExp:          StatValue read FNoExp;
                             //
    property MExp:           StatValue read FMExp;
                             //
    property FExp:           StatValue read FFExp;
                             //
    property MFExp:          StatValue read FMFExp;
                             //
    property ValidLow:       StatValue read FBrL;
                             //
    property ValidHigh:      StatValue read FBrH;

                             // Constructor
    constructor              Create(
                               UID: Integer );
                             // Single item
    procedure                NewItem(
                               UID: Integer );
  end;
                             // Check for a valid partonomic ancestor
    function                 ValidPartAncestor(
                               UID: Integer;
                               Anc: Integer;
                               var Family: TFamily;
                               Extend: Boolean = True;
                               NbStep: Integer = 0 )
                               : Boolean;

implementation

uses
  Tetra, TAHBrowser;

constructor        tStatUniversal.Create(
  UID:             Integer);
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create/1
  * Create the object *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Self.TopID := UID;
end; // ________________________________________________________________Create/1

function           tStatUniversal.GetNbProfile
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetNbProfile
  * Retrieve the actual number of profiles *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := Length( Self.FProf );
end; // ____________________________________________________________GetNbProfile

procedure          tStatUniversal.NewItem(
  UID:             Integer);
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NewItem
  * Sample a new entity for the statistic *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbProf:          Integer;
  PosItem:         Integer;
  Found:           Boolean;
  Valid:           Boolean;
  // MyFormula:       TFormula;
  // MyFamily:        TFamily;
  MyProfile:       String;
  Last:            Char;
begin
  {Inc( Self.FTot );

  // Search for the formula
  MyFormula := TFormula.Create( UID );
  if ( MyFormula.Raw <> cEmpty ) then
    Inc( Self.FUniv );

  // Search for the profile
  MyProfile := MyFormula.Profile;
  if ( MyProfile = cEmpty ) then
    Exit;
  Last := MyProfile[ Length( MyProfile ) ];
  if ( Last = 'F' ) then
    MyProfile := Copy( MyProfile, 1, Length( MyProfile ) - 1 );
  Last := MyProfile[ Length( MyProfile ) ];
  if ( Last = 'M' ) then
    MyProfile := Copy( MyProfile, 1, Length( MyProfile ) - 1 );
  NbProf := Self.GetNbProfile;
  PosItem := -1;
  Found := False;
  if ( NbProf > 0 ) then
  begin
    for Indx := 0 to NbProf - 1 do
    begin
      if ( Self.FProf[ Indx ] = MyProfile ) then
      begin
        PosItem := Indx;
        Found := True;
        Break;
      end;
    end; // for on all existing profiles
  end;

  // Profile not found
  if ( not Found ) then
  begin
    SetLength( Self.FProf, NbProf + 1 );
    Self.FProf[ NbProf ] := MyProfile;
    PosItem := NbProf;

    // Adjust the value arrays
    SetLength( Self.FNoExp, NbProf + 1 );
    SetLength( Self.FMExp, NbProf + 1 );
    SetLength( Self.FFExp, NbProf + 1 );
    SetLength( Self.FMFExp, NbProf + 1 );
    SetLength( Self.FBrL, NbProf + 1 );
    SetLength( Self.FBrH, NbProf + 1 );
    Inc( NbProf );
  end;

  // Process the new item
  if ( ( PosItem >= 0 ) and ( PosItem < NbProf ) ) then
  begin
    if ( ( MyFormula.RawMandat = 0 ) and ( MyFormula.RawOption = 0 ) ) then
      Inc( Self.FNoExp[ PosItem ] )
    else
    if ( ( MyFormula.RawMandat > 0 ) and ( MyFormula.RawOption = 0 ) ) then
      Inc( Self.FMExp[ PosItem ] )
    else
    if ( ( MyFormula.RawMandat = 0 ) and ( MyFormula.RawOption > 0 ) ) then
      Inc( Self.FFExp[ PosItem ] )
    else
    if ( ( MyFormula.RawMandat > 0 ) and ( MyFormula.RawOption > 0 ) ) then
      Inc( Self.FMFExp[ PosItem ] );
  end;

  // Check for partonomic ancestor
  if ( MyFormula.RawMandat > 0 ) then
  begin
    Valid := ValidPartAncestor( UID, MyFormula.RawMandat, MyFamily );
    if ( not Valid ) then
      Inc( Self.FBrH[ PosItem ] )
    else
    if ( Valid and ( MyFamily > fa_indirect ) ) then
      Inc( Self.FBrL[ PosItem ] );
  end; }
end; // _________________________________________________________________NewItem

function           ValidPartAncestor(
  UID:             Integer;
  Anc:             Integer;
  var Family:      TFamily;
  Extend:          Boolean;
  NbStep:          Integer )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ValidPartAncestor
  * Find if a unit is a valid partonomic child of another unit *
  Description:
  This function check if a unit is in a valid partonomic dependency of another
  unit. The validity can be extended in two different ways: by secondary
  expansion (mandatory expansion of mandatory expansion) or by matching on a
  close family member (cousin, uncle or gand uncle).</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Step:            Integer;
  Valid:           Boolean;
  MyUnit:          TUnit;
  // MySecond:        TRaw;
  // Degree:          TFamily;
begin
  {Result := False;
  Family := fa_undef;
  Degree := Family;
  MyUnit := TAH.GetUnitByPos( UID );
  Step := 1;
  while ( MyUnit <> nil ) do
  begin
    if ( Degree < fa_ancestor ) then
      Degree := Succ( Degree );
    if ( MyUnit.Parto = Anc ) then
    begin
      Result := True;
      if ( Degree < fa_ancestor ) then
        Family := Succ( Degree );
      Break;
    end else
    if ( NbStep >= Step ) then
      Exit;
    MyUnit := TAH.GetUnitByPos( MyUnit.Parto );
    Inc( Step );
  end; // while on all partonomic ancestors
  if ( not Extend ) then
    Exit;

  // Check for a brother
  if ( not Result ) then
  begin
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      Valid := ValidPartAncestor( Anc, MyUnit.Parto, Family, False );
      if ( ( Valid ) and ( Family = fa_parent ) ) then
      begin
        Family := fa_brother;
        Result := True;
      end;
    end;
  end;

  // Check for a cousin or uncle
  if ( not Result ) then
  begin
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      MyUnit := TAH.GetUnitByPos( MyUnit.Parto );
      if ( MyUnit <> nil ) then
      begin
        Valid := ValidPartAncestor( Anc, MyUnit.Parto, Family, False );
        if ( Valid ) then
        begin
          if ( Family = fa_parent ) then
            Family := fa_uncle;
          if ( Family = fa_gdparent ) then
            Family := fa_cousin;
          Result := True;
        end;
      end;
    end;
  end;

  // Check for a grand uncle and grand cousin
  if ( not Result ) then
  begin
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      MyUnit := TAH.GetUnitByPos( MyUnit.Parto );
      if ( MyUnit <> nil ) then
      begin
        MyUnit := TAH.GetUnitByPos( MyUnit.Parto );
        if ( MyUnit <> nil ) then
        begin
          Valid := ValidPartAncestor( Anc, MyUnit.Parto, Family, False );
          if ( Valid ) then
          begin
            if ( Family = fa_parent ) then
              Family := fa_gduncle;
            if ( Family = fa_gdparent ) then
              Family := fa_gdcousin;
            Result := True;
          end;
        end;
      end;
    end;
  end;

  // Check for a grand grand uncle
  if ( not Result ) then
  begin
    MyUnit := TAH.GetUnitByPos( UID );
    if ( MyUnit <> nil ) then
    begin
      MyUnit := TAH.GetUnitByPos( MyUnit.Parto );
      if ( MyUnit <> nil ) then
      begin
        MyUnit := TAH.GetUnitByPos( MyUnit.Parto );
        if ( MyUnit <> nil ) then
        begin
          MyUnit := TAH.GetUnitByPos( MyUnit.Parto );
          if ( MyUnit <> nil ) then
          begin
            Valid := ValidPartAncestor( Anc, MyUnit.Parto, Family, False );
            if ( Valid ) then
            begin
              if ( Family = fa_parent ) then
                Family := fa_gdgduncle;
              Result := True;
            end;
          end;
        end;
      end;
    end;
  end;}
end; // _______________________________________________________ValidPartAncestor

end.
