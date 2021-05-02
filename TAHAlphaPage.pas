{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit TAAlphaPage
  * Generation of KWIC or alphanetical Pages. *
  Description:
  This procedure generates the KWIC or alphabetical page of all base terms.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit TAHAlphaPage;

interface
                   // Build the raw alphabetical file
  procedure        TAHMakeAlphaPage(
                     Index: Integer;
                     Kwic: Boolean );

implementation

uses
  {$WARNINGS OFF}
  SysUtils, StrUtils, Classes, stdCtrls,
  {$WARNINGS ON}
  TAHParam, TAHBrowser, LAProc, Entity, SingleTerms, Term;

procedure          TAHMakeAlphaPage(
  Index:           Integer;
  Kwic:            Boolean );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TAHMakeAlphaPage
  * Creation of raw alphabetical page *
  Description:
  This procedure makes an alphabetical page of all base expanded terms.<P>
  Two variants are available: a version with all entities once, and a version
  with Key Word In Context (KWIC) applied on all entities.<P>
  The procedure is dependent on the language specified by a global variable.
  The resulting action of this procedure is somewhat different from one
  language to another.<P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indw:            Integer;
  Indx:            Integer;
  Indy:            Integer;
  Indz:            Integer;
  Lgt:             Integer;
  Count:           Integer;
  NbEntity:        Integer;
  Posit:           Integer;
  NbAnal:          Integer;
  NbTerm:          Integer;
  NbExp:           Integer;
  TotTerm:         Integer;
  TotTA:           Integer;
  NbLoc:           Integer;
  MyLoc:           Integer;
  Loc:             Integer;
  Encore:          Boolean;
  First:           String;
  ACode:           String;
  BreakCode:       String;
  Base:            String;
  FileName:        String;
  MyTerm:          String;
  TID:             String;
  CurrCode:        String;
  ViewCode:        String;
  BeginPart:       String;
  EndPart:         String;
  BreakSeq:        String;
  Rotation:        String;
  RefWord:         String;
  MyClass1:        String;
  MyClass2:        String;
  Debut:           String;
  ActLetter:       Char;
  Page:            TStringList;
  LPage:           TStringList;
  Lang:            tLanguage;
  Terms:           tTerms;
  Actual:          tEntity;
  Current:         tEntity;
  ATerm:           tSingle;
  Found:           tListInt;
  LatinTerm:       tTerm;
  Query:           tSearch;
begin
  // Create top of page
  Page := TStringList.Create;
  Actual := TAH.GetEntityByTID( Index );
  ACode := Actual.Cod98;
  Lgt := 2;
  ACode := Copy( ACode, 2, Lgt );
  Lang := LgCur;
  ViewCode := cTAH + ACode;

  // Loop on all terms
  Count := 0;
  NbTerm := 0;
  NbEntity := 0;
  TotTA := TAH.TotTAH;
  for Indx := Index to TotTA - 1 do
  begin

    // Check for end of list
    Current := TAH.GetEntityByTID( Indx );
    if ( Current = nil ) then
      Continue;
    CurrCode := Current.Cod98;
    BreakCode := Copy( CurrCode, 2, Lgt );
    TID := IntToStr( Current.TID );
    if ( BreakCode <> ACode ) then
      Continue;

    // Collect base term
    SetLength( Terms, 20 );
    Inc( NbEntity );
    Current.LgCurrent := lt_Latin;
    Current.Query := tSearch.Create( st_Bas );
    Current.SearchTerm;
    ATerm := Current.CurrSingle;
    if ( ATerm = nil ) then
      Continue;
    Base := ATerm.Mandat + ATerm.Option;

    // Discard unwanted entities
    Debut := Copy( Current.InternalTex, 1, 4 );
    if ( ( Debut = 'PAR ' ) or ( Debut = 'SIN ' ) or
         ( Debut = 'DEX ' ) or ( Debut = 'SET ' ) or
         ( Debut = 'ERR ' ) ) then
    begin
      TotTerm := TotTerm;
      Continue;
    end;

    // Store the terms
    Terms[ 0 ] := Base;
    TotTerm := 1;
    Inc( Count );
    SetLength( Terms, TotTerm );

    // Loop on all terms
    for NbExp := 0 to TotTerm - 1 do
    begin

      // Pure alphabetical list
      LatinTerm := tTerm.Create( Terms[ NbExp ], Lang, nu_unspec );
      if ( not Kwic ) then
      begin
        // Prepare the class for Latin
        if ( Lang = lt_Latin ) then
        begin
          if ( not LatinTerm.IsRegular ) then
            Continue;
          MyClass1 := LatinTerm.Node[ 0 ].Lem;
          MyClass2 := cEmpty;
          if ( LatinTerm.NbWord > 1 ) then
            MyClass2 := LatinTerm.Node[ 1 ].Lem;
          if ( MyClass1 = 'cl_classis' ) then
          begin
            RefWord := LatinTerm.Node[ 1 ].Lem;
          end else
          if ( MyClass1 = 'cl_par' ) then
          begin
            if ( MyClass2 = 'cl_classis' ) then
              RefWord := LatinTerm.Node[ 2 ].Lem
            else
              RefWord := LatinTerm.Node[ 1 ].Lem;
          end else
            RefWord := MyClass1;
        end;

        // Write alphabetical line
        Page.Add( RefWord + CurSep + MyTerm + CurSep + TID );
        Inc( NbTerm );
      end else

      // KWIC permutation
      begin
        // Make Latin KWIC
        if ( Lang = lt_Latin ) then
        begin

          // Process terms with successful analysis
          if ( LatinTerm.IsRegular ) then
          begin
            // Loop on all words or morphosemantems
            NbAnal := LatinTerm.NbWord;
            for Indw := 0 to NbAnal - 1 do
            begin
              // Build the rotated term
              Rotation := cEmpty;
              for Indy := 0 to NbAnal - 1 do
              begin
                Indz := ( Indw + Indy ) mod NbAnal;
                if Indy > 0 then
                  Rotation := Rotation + cSpace;
                if ( Indz = 0 ) and ( Indw > 0 ) then
                  Rotation := Rotation + cBreak + cSpace;
                Rotation := Rotation + LatinTerm.Node[ Indz ].Wrd;
              end; // for

              // Retrieve the class on which to sort
              RefWord := LatinTerm.Node[ Indw ].Lem;

              // Write a new line
              Page.Add( RefWord + CurSep + Rotation + CurSep + TID );
              Inc( NbTerm );
            end; // for
          end else

          // Process terms without successful analysis
          begin
            Rotation := MyTerm;
            Debut := Copy( MyTerm, 1, 4 );
            if ( ( Debut = 'PAR ' ) or ( Debut = 'SIN ' ) or
                 ( Debut = 'DEX ' ) or ( Debut = 'SET ' ) or
                 ( Debut = 'ERR ' ) ) then
            begin
              Rotation := Copy( MyTerm, 5, Length( MyTerm ) );
            end;

            // Retrieve and analyze the first word
            Posit := Pos( cSpace, Rotation );
            if ( Posit > 0 ) then
              First := Copy( Rotation, 1, Posit - 1 )
            else
              First := Rotation;
            RefWord := cEmpty;
            if ( WordExists( First, NbLoc, Found ) ) then
            begin
              MyLoc := Found[ 0 ];
              RefWord := Latin[ MyLoc ].Sub;
            end;

            // Write initial non permutated line
            Page.Add( RefWord + CurSep + Rotation + CurSep + TID );
            Posit := Pos( cSpace, Rotation );
            Encore := Posit > 0;
            Inc( Count );
            BreakSeq := cSpace + cBreak + cSpace;

            // Loop on all permuted lines
            while ( Encore ) do
            begin
              BeginPart := Copy( Rotation, 1, Posit - 1 );
              EndPart := Copy( Rotation, Posit + 1, Length( Rotation ) );
              Rotation := EndPart + BreakSeq + BeginPart;
              BreakSeq := cSpace;
              Posit := Pos( cSpace, EndPart );
              Encore := ( Posit > 0 ) and ( Copy( EndPart, Posit, 2 ) <> ' |' );

              // Retrieve and analyze the first word
              Posit := Pos( cSpace, Rotation );
              if ( Posit > 0 ) then
                First := Copy( Rotation, 1, Posit - 1 )
              else
                First := Rotation;
              RefWord := cEmpty;
              if ( WordExists( First, NbLoc, Found ) ) then
              begin
                MyLoc := Found[ 0 ];
                RefWord := Latin[ MyLoc ].Sub;
              end;

              // Write a new rotation of the line
              Page.Add( RefWord + CurSep + Rotation + CurSep + TID );
              Inc( NbTerm );
            end; // while
          end;
        end else

        // Make French and English KWIC
        begin
          {Rotation := Expansion;
          Posit := Pos( cSpace, Rotation );
          Encore := Posit > 0;
          BreakSeq := cSpace + cBreak + cSpace;
          while Encore do
          begin
            BeginPart := Copy( Rotation, 1, Posit - 1 );
            EndPart := Copy( Rotation, Posit + 1, Length( Rotation ) );
            Rotation := EndPart + BreakSeq + BeginPart;
            BreakSeq := cSpace;
            Posit := Pos( cSpace, EndPart );
            Encore := ( Posit > 0 ) and ( Copy( EndPart, Posit, 2 ) <> ' |' );
            Next3 := Copy( Rotation, 1, 3 );
            Next4 := Copy( Rotation, 1, 4 );
            NoWrite := False;

            // Remove English stop words: the, and, of, for
            if Lang = lt_English then
            begin
              NoWrite :=
                ( Next4 = 'for ' ) or
                ( Next3 = 'of ' ) or
                ( Next4 = 'and ' ) or
                ( Next4 = 'the ' );
            end;

            // Remove French stop words: de, le la, les, des, du
            if Lang = lt_French then
            begin
              NoWrite :=
                ( Next4 = 'des ' ) or
                ( Next3 = 'du ' ) or
                ( Next4 = 'les ' ) or
                ( Next3 = 'le ' ) or
                ( Next3 = 'la ' ) or
                ( Next3 = 'de ' );
            end;

            // Modify for French: l'
            if ( Lang = lt_French ) and ( Copy( Rotation, 1, 2 ) = 'l''' ) then
            begin
              Rotation :=
                Copy( Rotation, 3, Length( Rotation ) ) + cSpace + 'l''';
              Posit := Posit - 2;
              BreakSeq := cEmpty;
            end;

            // Write a new line
            if not NoWrite then
            begin
              Page.Add( CurSep + Rotation + CurSep + Base + CurSep + CurrCode +
                        CurSep + TID );
              Inc( NbTerm );
            end;
          end; // while }
        end;
      end;
    end; // for on all terms of a single entity
  end; // for on all entities in the range of the list

  // Sort on class when present or rotated expanded term
  Page.Sort;

  // Save the full raw file of terms
  FileName := ACode + cSpace + cLgShort[ Lang ] + cPeriod + TextExt;
  Page.SaveToFile( DirAlphaName + cSlash + FileName );

  // Write one raw file of terms for each letter
  ActLetter := 'a';
  Loc := 0;
  LPage := TStringList.Create;
  while ( True ) do
  begin

    // Scan for the actual letter and build the corresponding list
    if ( Loc < Page.Count ) then
    begin
      MyTerm := Page[ Loc ];
      Inc( Loc );
      if ( MyTerm[ 1 ] = CurSep ) then
      begin
        Continue;
      end;
      if ( MyTerm[ 1 ] = ActLetter ) then
      begin
        LPage.Add( MyTerm );
        Continue;
      end;
    end;

    // Write the single letter non empty file
    if ( LPage.Count > 0 ) then
    begin
      FileName := ACode + cSpace + ActLetter + cSpace + cLgShort[ Lang ] +
                  cPeriod + TextExt;
      LPage.SaveToFile( DirAlphaName + cSlash + FileName );
    end;

    // Prepare the next letter
    if ( ActLetter = 'z' ) then
      Break;
    ActLetter := MyTerm[ 1 ];
    LPage.Clear;
    LPage.Add( MyTerm );
  end; // while

  // Create top of HTLM page
  {HtmlPage := TStringList.Create;
  if Lang = lt_French then
    Title := ViewCode + cSpace + tiAlphaPageFR + cSpace + cLgShort[ Lang ]
  else
    Title := ViewCode + cSpace + tiAlphaPageEN + cSpace + cLgShort[ Lang ];
  AddTag( DOCTYPETAG, 0, HTMLPage);
  AddTag( HTMLTAG, 0, HTMLPage );
    AddTag( HEADTAG, 1, HTMLPage );
      AddTag( TITLETAG + Title + TITLEETAG, 2, HTMLPage );
      AddTag( CALLCSSVIEWTAG, 2, HTMLPage );
      AddTag( CALLCSSPRINTTAG, 2, HTMLPage );
    AddTag( HEADETAG, 1, HTMLPage );
    AddTag( BODYTAG, 1, HTMLPage );
      AddTag( DIVOTAG + cIdContainer + cAnr, 2, HTMLPage );

  // Display the page header with Latin title and help icon
  Title := cEmpty;
  if Lang = lt_Latin then
    Title := TA[ Index ].LA + cSpace + TermNewExpansion( Index, lt_Latin )
  else
  if Lang = lt_English then
    Title := TA[ Index ].EN + cSpace + TermNewExpansion( Index, lt_English )
  else
  begin
    TAGetLibellesByTID( TA[ Index ].TID, lt_French, st_Bas, NbLib, ASyn );
    if NbLib > 0 then
      Title := FRLib[ ASyn[ 1 ] ].Lib;
  end;
  MyHelp := AOTAG + cHrefEmpty + DirHelpRelName + HelpAlphaPage +
            cDQuote + cAnr + cHelpImg + AETAG;
  if Lang = lt_French then
  begin
    if Kwic then
      MyMode := tiKWICPageFR
    else
      MyMode := tiAlphaPageFR;
    MakeHeader700( MyMode + cComma + cSpace + cLgTextFR[ Lang ],
                   Title, cEmpty, MyHelp, bbHelpOnPageFR, 3, HTMLPage )
  end else
  begin
    if Kwic then
      MyMode := tiKWICPageEN
    else
      MyMode := tiAlphaPageEN;
    MakeHeader700( MyMode + cComma + cSpace + cLgTextEN[ Lang ],
                   Title, cEmpty, MyHelp, bbHelpOnPageEN, 3, HTMLPage );
  end;

  // Open the table and display column headers
  AddTag( DIVOTAG + cIdBody700 + cAnr, 3, HTMLPage ); // open #Body700
    AddTag( TABLEOTAG + cClassBodyTable + cAnr, 4, HTMLPage );
      AddTag( TROTAG + cSpace + cClassHeaderColor + cAnr, 5, HTMLPage );
        if Lang = lt_French then
        begin
          Bubble := bbTIDFR + cSpace + fdInBubbleFR;
          MakeTD( cClassColNno, fdTACodeFR, Bubble, 6, HTMLPage );
          MakeTD( cClassColXno, fdBaseTermFR, cEmpty, 6, HTMLPage );
          Bubble := cEmpty;
          if Kwic then
            Bubble := bbKwicTermFR;
          MakeTD( cClassColXno, fdExpandedFR, Bubble, 6, HTMLPage );
        end else
        begin
          Bubble := bbTIDEN + cSpace + fdInBubbleEN;
          MakeTD( cClassColNno, fdTACodeEN, Bubble, 6, HTMLPage );
          MakeTD( cClassColXno, fdBaseTermEN, cEmpty, 6, HTMLPage );
          Bubble := cEmpty;
          if Kwic then
            Bubble := bbKwicTermEN;
          MakeTD( cClassColXno, fdExpandedEN, Bubble, 6, HTMLPage );
        end;
      AddTag( TRETAG, 5, HTMLPage );

    // Loop on all entries
    for Indx := 0 to NbTerm - 1 do
    begin
      MyLine := Page[ Indx ];
      Posit := Pos( CurSep, MyLine );
      MyClass := Copy( MyLine, 1, Posit - 1 );
      MyLine := Copy( MyLine, Posit + 1, Length( MyLine ) );
      Posit := Pos( CurSep, MyLine );
      Expansion := Copy( MyLine, 1, Posit - 1 );
      MyLine := Copy( MyLine, Posit + 1, Length( MyLine ) );
      Posit := Pos( CurSep, MyLine );
      Base := Copy( MyLine, 1, Posit - 1 );
      MyLine := Copy( MyLine, Posit + 1, Length( MyLine ) );
      Posit := Pos( CurSep, MyLine );
      CurrCode := Copy( MyLine, 1, Posit - 1 );
      DisCode := TAHeadCode + CurrCode;
      TID := Copy( MyLine, Posit + 1, Length( MyLine ) );
      TID := TAHeadCode + TID;
      AddTag( TRTAG, 5, HTMLPage );
        MakeTD( cClassColN, DisCode, TID, 6, HTMLPage );
        if ( MyClass = cEmpty ) and ( not KWIC ) and ( Lang = lt_Latin ) then
          MyClass := Base
        else if ( MyClass = cEmpty ) and ( Lang = lt_English ) then
          MyClass := Base;
        if MyClass = cEmpty then
          Count := Count;
        MakeTD( cClassColXX, MyClass, cEmpty, 6, HTMLPage );
        if Lang = lt_French then
          ToEntity := AOTAG + cHrefEmpty + cRetroDir + DirEntityName + cSpace +
                      cLgShort[ Lang ] + cSlash + CurrCode + cSpace + cEntity +
                      cSpace + cLgShort[ Lang ] + cPeriod + HtmlExt + cDQuote +
                      cAnr + Expansion + AETAG
        else
          ToEntity := AOTAG + cHrefEmpty + cRetroDir + DirEntityName + cSpace +
                      cLgShort[ lt_English ] + cSlash + CurrCode + cSpace +
                      cEntity + cSpace + cLgShort[ lt_English ] + cPeriod +
                      HtmlExt + cDQuote + cAnr + Expansion + AETAG;
        MakeTD( cClassColXXX, ToEntity, cEmpty, 6, HTMLPage );
      AddTag( TRETAG, 5, HTMLPage );
    end; // for
    AddTag( TABLEETAG, 4, HTMLPage );

        // Display statistics at bottom of page
        if Lang = lt_French then
        begin
          Stat1 := fdEntriesFR + cColumn + cSpace + IntToStr( Count );
          Stat2 := fdTermsFR + cColumn + cSpace + IntToStr( NbTerm );
          Stat3 := fdEntityFR + cColumn + cSpace + IntToStr( NbEntity );
          Stat4 := fdDateFR + cColumn + cSpace + DateToStr( Date );
          MakeStat4x( Stat1, bbNbEntriesFR, Stat2, bbNbTermsFR,
                      Stat3, bbNbEntityFR, Stat4, bbDateGenerFR, 4, HTMLPage );
        end else
        begin
          Stat1 := fdEntriesEN + cColumn + cSpace + IntToStr( Count );
          Stat2 := fdTermsEN + cColumn + cSpace + IntToStr( NBTerm );
          Stat3 := fdEntityEN + cColumn + cSpace + IntToStr( NbEntity );
          Stat4 := fdDateEN + cColumn + cSpace + DateToStr( Date );
          MakeStat4x( Stat1, bbNbEntriesEN, Stat2, bbNbTermsEN,
                      Stat3, bbNbEntityEN, Stat4, bbDateGenerEN, 4, HTMLPage );
        end;
        AddTag( DIVETAG, 3, HTMLPage ); // close #Body700

        // Close the HTML page
        MakeFooter700( cSignature, 3, HTMLPage );
      AddTag( DIVETAG, 2, HTMLPage ); // close #Container700
    AddTag( BODYETAG, 1, HTMLPage );
  AddTag( HTMLETAG, 0, HTMLPage );

  // Save page on external file
  if ACode = cEmpty then
    ACode := 'All';
  if Kwic then
    MyMode := cKWIC
  else
    MyMode := cAlpha;
  FileName := ACode + cSpace + MyMode + cSpace + cLgShort[ Lang ] +
              cPeriod + HtmlExt;
  HTMLPage.SaveToFile( DirAlphaName + cSlash + FileName );}
end; // ________________________________________________________TAHMakeAlphaPage

end.
