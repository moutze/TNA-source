{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit ITProc
  * Package for Italian language management *
  Description:
  This package handles all aspects of the Italian language in order to
  manipulate and generate Italian terms. It is sufficient for the domain of
  anatomy when the RAT rules are applied. There is no need of a dictionary.</P>

  RAT rules for ITALIAN:
  - Terms are made of words of the following types: noun, adjective or
    assimilated, prefix and invariant.
  - Cases are exclusively nominative and genitive. The only accepted
    preposition is de (del) for genitive.
  - A noun is necessarily unique and may be followed by any other type of
    word in any number. A prefix cannot be in last position. An invariant
    is expected as unique in the last position. A noun cannot be followed by
    another noun.
  - An adjective   necessarily qualifies the noun it follows.
  - Terms are made of blank separated words, except for prefixes followed by an
    adjective or another prefix.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit ITProc;

interface

uses
  TAHParam, Term, ComCtrls;

const
  NbPlurIT         = 6;
  NbFrontIT        = 5;
  NbMascIT         = 2;
  NbFemIT          = 5;
  NbExceptIT       = 4;
  NbBinomeIT       = 4;
  NbExGenderIT     = 6;

type
  tPlurIT          = Array[ 1 .. NbPlurIT, nu_sin .. nu_plu ] of String;
  tFrontIT         = Array[ 1 .. NbFrontIT ] of String;
  tMascIT          = Array[ 1 .. NbMascIT ] of String;
  tFemIT           = Array[ 1 .. NbFemIT ] of String;
  tExceptIT        = Array[ 1 .. NbExceptIT, nu_sin .. nu_plu ] of String;
  tBinomeIT        = Array[ 1 .. NbBinomeIT, 1 .. 2 ] of String;
  TExceptGenderIT  = Array[ 1 .. NbExGenderIT,
                            ge_masculine .. ge_feminine ] of String;

                             // Define the Spanish Term object
  TITTerm                    = class( TTerm )
    public
      constructor            Create(
                               Nominative: String );
      function               MakePluralIT()
                               : String;
      function               MakeLateralIT()
                               : String;
      function               MakeGenitiveIT()
                               : String;
      procedure              SetNominativeIT(
                               Value: String );
  end;
                             // Translate a single word into French
  function                   ItalianOf(
                               LAWord: String )
                               : String;
                             // Make a feminine adjective from a masculine form
  function                   MakeGenderIT(
                               AWord: String;
                               Syntax: String )
                               : String;
                             // Translate a universal formula in Italian
  function                   TranslateTermIT(
                               TreeFormula: TTreeView )
                               : String;
                             // Find the gender of a word
  function                   GenderIT(
                               AWord: String )
                               : tGender;
                             // Find the introductory string for genitive
  function                   MakeInGenitiveIT(
                               MyNumber: String;
                               MyGender: TGender;
                               MySpecif: String;
                               MyElision: Boolean )
                               : String;
var
                   // Rules for plural: substitute left ending by the right one
                   // The order of rules is important
  PlurIT:          tPlurIT = (
                   ( 'ión', 'iones' ),
                   ( 'ior', 'iores' ),
                   ( 'ar', 'ares' ),
                   ( 'al', 'ales' ),
                   ( 'aiz', 'aices' ),
                   ( '', 's' ) );

                   // Plural exceptions: applied before using the rules
  ExceptIT:        tExceptIT = (
                   ( 'genou', 'genoux' ),
                   ( 'pou', 'poux' ),
                   ( 'caillou', 'cailloux' ),
                   ( 'bal', 'bals' ) );

                   // Frontal adjectives: those positioned before the noun
  FrontIT:         tFrontIT = (
                   'primero',
                   'segundo',
                   'tercero',
                   'cuarto',
                   'quinto' );

                   // Masculine words: applied before using the rules
  MascIT:          tMascIT = (
                   'dia',
                   'corazon' );

                   // Feminine words: applied before using the rules
  FemIT:           tFemIT = (
                   'mano',
                   'radio',
                   'foto',
                   'labor',
                   'sor' );

                   // Exceptions for gender: not derived from a rule
  ExceptGenderIT:  TExceptGenderIT = (
                   ( 'beau', 'belle' ),
                   ( 'bref', 'brève' ),
                   ( 'gros', 'grosse' ),
                   ( 'long', 'longue' ),
                   ( 'moyen', 'moyenne' ),
                   ( 'vieux', 'vieille' ) );

                   // Binomes Latin-Italian
  LAITEquiv:       tBinomeIT = (
                   ( 'cornu', 'corne' ),
                   ( 'lamina', 'lame' ),
                   ( 'posterior', 'postérieur' ),
                   ( 'spinalis', 'spinal' ) );

implementation

uses
  SysUtils, Entity, TAHBrowser, SingleTerms, LAProc;

constructor        TITTerm.Create(
  Nominative:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create
  * Variant of constructor of an Italian term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited Create( Nominative );
  Self.Language := lt_Italian;
end; // __________________________________________________________________Create

function           TITTerm.MakePluralIT()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralIT
  * Construction of a plural Italian term *
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

    // Check for presence of genitive
    if ( not IsGen ) then
    begin
      IsGen := ( Word = 'de' ) or ( Word = 'del' );
    end;

    // Append words at genitive, left unchanged
    if ( IsGen ) then
    begin
      Plural := Plural + cSpace + Word
    end else
    begin

      // Define plural from exceptions
      IsExcept := False;
      for Indx := 1 to NbExceptIT do
      begin
        if ( Word = ExceptIT[ Indx, nu_sin ] )  then
        begin
          Word := ExceptIT[ Indx, nu_plu ];
          Plural := Plural + cSpace + Word;
          IsExcept := True;
          Break;
        end;
      end; // for
      if ( IsExcept ) then
        Break;

      // Loop on all Spanish plural rules if no exception matches
      Plural := Plural + cSpace + Word;
      for Indx := 1 to NbPlurIT do
      begin
        SingVal := PlurIT[ Indx, nu_sin ];
        Lgt := Length( SingVal );
        if ( Lgt > 0 ) then
        begin
          if ( Copy( Word, Length( Word ) - Lgt + 1, Lgt ) = SingVal ) then
          begin
            Plural := Copy( Plural, 1, Length( Plural ) - Lgt ) +
                      PlurIT[ Indx, nu_plu ];
            Break;
          end;
        end else
        begin
          Plural := Plural + PlurIT[ Indx, nu_plu ];
        end;
      end; // for
    end;
  end; // while

  // Return plural term
  Result := Copy( Plural, 2, Length( Plural ) );
end; // ____________________________________________________________MakePluralIT

function           GenderIT(
  AWord:           String )
  :                tGender;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GenderIT
  * Search for gender of a noun in Italian *
  Description:
  This procedure receives a string, from which the first word is extracted and
  analyzed for its gender. The return value is either masculine or feminine.</P>
  Lists of exceptions are first considered. If no match is obtained, rules
  are examined and they define the gender.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Posit:           Integer;
  Noun:            String;
  Last:            String;
  Last2:           String;
  Last3:           String;
  Last4:           String;
begin
  // Look for the first noun of the term
  Noun := AWord;
  Posit := Pos( cSpace, Noun );
  if ( Posit > 0 ) then
    Noun := Copy( Noun, 1, Posit - 1 );

  // Check for a frontal adjective before the noun
  for Indx := 1 to NbFrontIT do
  begin
    if ( Noun = FrontIT[ Indx ] ) then
    begin
      Noun := Copy( AWord, Length( Noun ) + 2, Length( AWord ) );
      Posit := Pos( cSpace, Noun );
      if ( Posit > 0 ) then
        Noun := Copy( Noun, 1, Posit - 1 );
      Break;
    end;
  end; // for

  // Set to masculine by list of exceptions
  Result := ge_masculine;
  for Indx := 1 to NbMascIT do
  begin
    if ( Noun = MascIT[ Indx ] ) then
      Exit;
  end; // for

  // Set to feminine by list of exception
  Result := ge_feminine;
  for Indx := 1 to NbFemIT do
  begin
    if ( Noun = FemIT[ Indx ] ) then
      Exit;
  end; // for

  // Set to masculine by rules
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
  if ( ( Last = 'a' ) or
       ( Last2 = 'ez' ) or
       ( Last3 = 'zón' ) or
       ( Last3 = 'dad' ) or
       ( Last3 = 'tad' ) or
       ( Last3 = 'tud' ) or
       ( Last3 = 'sis' ) or
       ( Last4 = 'ción' ) or
       ( Last4 = 'sión' ) or
       ( Last4 = 'triz' ) ) then
  begin
    Result := ge_feminine;
    Exit;
  end;

  // Default if no rule applies
  Result := ge_masculine;
end; // ________________________________________________________________GenderIT

function           TITTerm.MakeGenitiveIT()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenitiveIT
  * Construction of a genitive Italain term *
  Description:
  This procedure handles a Spanish singular term and transform it to the
  genitive singular form. An elision before a wowel is taken into account.</P>
  The genitive is different according to genericity in Italian. The genitive
  is without definite article for generic term and with definite article for
  specific terms. The selection is done from the given parameter.</P>
  When a laterality is specified for the term, the genitive is built with the
  corresponding lateral adjective.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IsElud:          Boolean;
  IsGen:           Boolean;
  Gender:          tGender;
  DeForm:          String;
  ATerm:           String;
begin
  // Search for the gender
  ATerm := Self.Lateral;
  Gender := GenderIT( ATerm );
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
      DeForm := 'de' + cSpace
    else
      DeForm := 'de la' + cSpace;
  end;
  Result := DeForm + ATerm;
end; // __________________________________________________________MakeGenitiveIT

function           TITTerm.MakeLateralIT()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLateralIT
  * Construction of a lateral Italian term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  LatForm:         String;
  NewTerm:         String;
  ATerm:           String;
  Gender:          tGender;
  Later:           tLink;
begin

  // Find the adjective of laterality
  ATerm := Self.Nominative;
  Later := Self.Side;
  LatForm := cEmpty;
  Gender := GenderIT( ATerm );
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

  // Position the lateral modifier
  begin
    NewTerm := cEmpty;
    for Indx := 0 to Self.NbWord - 1 do
    begin
      if ( Indx = Self.WordPos ) then
        NewTerm := NewTerm + cSpace + LatForm;
      NewTerm := Self.Node[ Indx ].Lem + cSpace + NewTerm;
    end; // for
    NewTerm := Copy( NewTerm, 2, Length( NewTerm ) );
  end;
  if ( Self.WordPos = Self.NbWord ) then
    NewTerm := NewTerm + cSpace + LatForm;
  Result := NewTerm;
end; // ___________________________________________________________MakeLateralIT

procedure          TITTerm.SetNominativeIT(
  Value:           String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNominativeIT
  * Action when entering a new value for Nominative property *
  Description:
  This method enters a new value for the property Nominative and reset the
  properties of this object.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  NbWord:          Integer;
  MyTerm:          String;
  MyCell:          WordAnal;
begin
  // Store the words (blank separated)
  MyTerm := Self.Nominative;
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
end; // _________________________________________________________SetNominativeIT

function           MakeGenderIT(
  AWord:           String;
  Syntax:          String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenderIT
  * Make an adjective at a specified gender in Italian *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Lgt:             Integer;
  Last1:           String;
  Last2:           String;
  Last3:           String;
  Last4:           String;
  Indx: Integer;
begin
  // Initial stuff
  Lgt := Length( AWord );
  Last1 := Copy( AWord, Lgt, 1 );
  Last2 := Copy( AWord, Lgt - 1, 2 );
  Last3 := Copy( AWord, Lgt - 2, 3 );
  Last4 := Copy( AWord, Lgt - 3, 4 );

  // Scan the exceptions
  for Indx := 1 to NbExGenderIT do
  begin
    if ( AWord = ExceptGenderIT[ Indx, ge_masculine ] ) then
    begin
      Result := ExceptGenderIT[ Indx, ge_feminine ];
      Exit;
    end;
  end; // for

  // Apply successive rules for gender
  Result := AWord;
  if ( Last1 = 'o' ) then
  begin
    Result := Copy( AWord, 1, Lgt - 1 ) + 'a';
    Exit;
  end;
end; // ____________________________________________________________MakeGenderIT

function           ItalianOf(
  LAWord:          String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ItalianOf
  * Translate a Latin word into Italian *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  for Indx := 1 to NbBinomeIT do
  begin
    if ( LAWord = LAITEquiv[ Indx, 1 ] ) then
    begin
      Result := LAITEquiv[ Indx, 2 ];
      Exit;
    end;
  end; // for
end; // _______________________________________________________________ItalianOf

function           TranslateTermIT(
  TreeFormula:     TTreeView )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TranslateTermIT
  * Translate a term from the universal tree formula *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Found:           Boolean;
  MyText:          String;
  TopFormula:      TTreeNode;
  MyNode1:         TTreeNode;
  MyNode2:         TTreeNode;
  MyNode3:         TTreeNode;
  MyNode4:         TTreeNode;
  MyNode5:         TTreeNode;
  Before:          TTreeNode;
begin

  // Initial stuff
  Result := cEmpty;
  TopFormula := TreeFormula.Items[ 0 ];
  MyNode1 := TopFormula.GetFirstChild;
  Found := False;
  Before := TopFormula;

  // Rule 1A: Nb(T)
  // ==============

  // Search for Nb
  while ( MyNode1 <> nil ) do
  begin
    if ( Copy( MyNode1.Text, 1, 2 ) = 'Nb' ) then
    begin
      Found := True;
      Break;
    end;
    Before := MyNode1;
    MyNode1 := MyNode1.GetFirstChild;
  end; // while
  if ( not Found ) then
    Exit; // Nb function not found
  MyNode2 := MyNode1.GetFirstChild;
  if ( MyNode2.Text <> 'T' ) then
    Exit; // T function not found under Nb

  // Treatment of a NbS function: transforms to No Op
  if ( MyNode1.Text = 'NbS' ) then
  begin
    MyNode2.MoveTo( Before, naAddChild );
    MyNode1.Delete;
  end else

  // Treatment of a NbP function: applies on T arguments
  if ( MyNode1.Text = 'NbP' ) then
  begin
    MyNode2.MoveTo( Before, naAddChild );
    MyNode1.Delete;
    MyNode3 := MyNode2.getFirstChild;
    MyNode5 := MyNode3.getFirstChild;
    MyNode4 := TreeFormula.Items.AddChild( MyNode3, 'NbP' );
    MyNode5.MoveTo( MyNode4, naAddChild );
  end else
    Exit; // Invalid Nb function

  // Rule 1b: Md(T)
  // ==============

  // Initial stuff
  Result := cEmpty;
  TopFormula := TreeFormula.Items[ 0 ];
  MyNode1 := TopFormula.GetFirstChild;
  Found := False;
  Before := TopFormula;

  // Search for Md
  while ( MyNode1 <> nil ) do
  begin
    if ( Copy( MyNode1.Text, 1, 2 ) = 'Md' ) then
    begin
      Found := True;
      Break;
    end;
    Before := MyNode1;
    MyNode1 := MyNode1.GetFirstChild;
  end; // while
  if ( not Found ) then
    Exit; // Md function not found
  MyNode2 := MyNode1.GetFirstChild;
  if ( MyNode2.Text <> 'T' ) then
    Exit; // T function not found under Md

  // Treatment of a MdS function: transforms to No Op
  MyText := MyNode1.Text;
  if ( MyText = 'MdS' ) then
  begin
    MyNode2.MoveTo( Before, naAddChild );
    MyNode1.Delete;
  end else

  // Remove the Md function of its actual position
  if ( ( MyText = 'MdL' ) or ( MyText = 'MdR' ) ) then
  begin
    MyNode2.MoveTo( Before, naAddChild );
    MyNode1.Delete;

    // First attempt: apply Md to F group if FB
    MyNode3 := MyNode2.GetLastChild;
    if ( ( MyNode3 <> nil ) and ( MyNode3.Text = 'FB' ) ) then
    begin
      MyNode4 := TreeFormula.Items.AddChild( MyNode2, MyText );
      MyNode3.MoveTo( MyNode4, naAddChild );
    end else
    // Second attempt: apply Md to M group if MB
    begin
      MyNode3 := MyNode2.GetPrevChild( MyNode3 );
      if ( ( MyNode3 <> nil ) and ( MyNode3.Text = 'MB' ) ) then
      begin
        MyNode4 := TreeFormula.Items.AddChild( MyNode2, MyText );
        MyNode3.MoveTo( MyNode4, naAddChild );
      end else
      // Third attempt: apply Md to B group if BB
      begin
        MyNode3 := MyNode2.GetPrevChild( MyNode3 );
        if ( ( MyNode3 <> nil ) and ( MyNode3.Text = 'BB' ) ) then
        begin
          MyNode4 := TreeFormula.Items.AddChild( MyNode2, MyText );
          MyNode3.MoveTo( MyNode4, naAddChild );
        end
      end;
    end;
  end;
end; // _________________________________________________________TranslateTermIT

function           MakeInGenitiveIT(
  MyNumber:        String;
  MyGender:        TGender;
  MySpecif:        String;
  MyElision:       Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeInGenitiveIT
  * Prepare the introductory string for genitive in Italian *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyWord:          String;
begin
  if ( MyNumber = 'S' ) then
  begin

    // Masculine target
    if ( MyGender = ge_masculine ) then
    begin

      // No elision
      if ( not MyElision ) then
      begin

        //  Full specificity
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
        begin
          MyWord := 'del';
        end else

        // No specificity
        begin
          MyWord := 'de';
        end;
      end else

      // With elision
      if ( MyElision ) then
      begin

        //  Full specificity
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
        begin
          MyWord := 'de l''';
        end else

        // No specificity
        begin
          MyWord := 'd''';
        end;
      end
    end else

    // Feminine target
    if ( MyGender = ge_feminine ) then
    begin// No elision
      if ( not MyElision ) then
      begin

        //  Full specificity
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
        begin
          MyWord := 'de la';
        end else

        // No specificity
        begin
          MyWord := 'de'
        end;
      end else

      // With elision
      if ( MyElision ) then
      begin

        //  Full specificity
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
        begin
          MyWord := 'de l'''
        end else

        // No specificity
        begin
          MyWord := 'd'''
        end;
      end;
    end;
  end else

  // Plural target
  if ( MyNumber = 'P' ) then
  begin

    // Masculine target
    if ( MyGender = ge_masculine ) then
    begin

      // No elision
      if ( not MyElision ) then
      begin

        //  Full specificity
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
        begin
          MyWord := 'des';
        end else

        // No specificity
        begin
          MyWord := 'de';
        end;
      end else

      // With elision
      if ( MyElision ) then
      begin

        //  Full specificity
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
        begin
          MyWord := 'd''';
        end else

        // No specificity
        begin
          MyWord := 'd''';
        end;
      end
    end else

    // Feminine target
    if ( MyGender = ge_feminine ) then
    begin

      // No elision
      if ( not MyElision ) then
      begin

        //  Full specificity
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
        begin
          MyWord := 'des';
        end else

        // No specificity
        begin
          MyWord := 'de';
        end;
      end else

      // With elision
      if ( MyElision ) then
      begin

        //  Full specificity
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
          MyWord := 'd'''
        else

        // No specificity
          MyWord := 'd''';
      end;
    end;
  end;
  Result := MyWord;
end; // ________________________________________________________MakeInGenitiveIT

end.
