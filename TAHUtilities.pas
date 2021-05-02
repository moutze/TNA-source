{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit TAHUtilities
  * Recipient unit for general utilities *
  Description:
  </P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit TAHUtilities;

interface

uses
  HTMLSection, TAHParam;

                             // Add a line on an HTML page
  function                   AddTag(
                               TagText: String;
                               Level: Integer )
                               : Integer;
                             // Append a new TD tag for an HTML table
  procedure                  MakeTD(
                               TheClass: String;
                               Field: String;
                               Bubble: String;
                               Level: Integer;
                               PClass: String = cEmpty );
                             //
  function                   MakeToggle(
                               DivId: String )
                               : String;
                             // Append a TD tag for a title of section
  procedure                  MakeTDTitleSection(
                               ASection: tSection;
                               Level: Integer;
                               Icon: String = cEmpty;
                               IconBubble: String = cEmpty );
                             // Append a TD tag for a TA908 title of section
  procedure                  MakeTDTA98TitleSection(
                               ASection: tTA98ListSection;
                               Level: Integer );

implementation

uses
  StrUtils, TAHBrowser;

function           AddTag(
  TagText:         String;
  Level:           Integer )
  :                Integer;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AddTag
  * Add a new tag to the HTML page. *
  Arguments:
  TagText - Text for tag or group of tags
  Level - Number of indents
  Returns:
  Return line position.
  Description:
  This method writes a given tag in the HTML listbox at the next line. The
  indent value specifies the number of double spaces before the tag in order
  to make readable the HTML file. The given line position is either the
  position of a preceeding line after which to insert the current tag or a
  negative value meaning insertion at end.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IndentText:      String;
begin
  IndentText := cEmpty;
  if ( IsIndent ) then
    IndentText := DupeString( '  ', Level );
  Result := CurrPage.Page.Add( IndentText + TagText )
end; // __________________________________________________________________AddTag

procedure          MakeTD(
  TheClass:        String;
  Field:           String;
  Bubble:          String;
  Level:           Integer;
  PClass:          String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTD
  * Append a new TD tag for an HTML table *
  Description:
  This methoid creates a single TD tag and its content.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin

  // Standard treatment: open the TD tag
  if Length( Bubble ) = 0 then
    AddTag( TDOTAG + TheClass + cAnr, Level )
  else
    AddTag( TDOTAG + TheClass + cSpace +
            cTitleEmpty + Bubble + cDQuote + cAnr, Level );

  // Optional presence of a DIV tag
  if ( Length( PClass ) > 0 ) then
  begin
    AddTag( DIVOTAG + PClass + cAnr, Level + 1 );
    AddTag( Field, Level + 2 );
    AddTag( DIVETAG, Level + 1 );
  end else
    AddTag( Field, Level + 1 );

  // Close the TD tag
  AddTag( TDETAG, Level );
end; // __________________________________________________________________MakeTD

function           MakeToggle(
  DivId:           String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeToggle
  * Prepare a toggle HTML button. *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  icon:            String;
begin
  icon := cOpenSrc;
  if ( TA98Short ) then
    icon := 'src="green.jpg"';
  Result :=
    IMGOTAG + 'id' + cEqual + cDQuote + 'Btn' + DivId + cDQuote + cSpace +
    'type' + cEqual + cDQuote + 'button' + cDQuote + cSpace +
    'onclick' + cEqual + cDQuote + 'ToggleSection' + cRol + cSpace +
    cQuote + DivID + cQuote + cSpace + cRor + cDQuote + cSpace +
    icon + cAnr;
end; // ______________________________________________________________MakeToggle

procedure          MakeTDTitleSection(
  ASection:        TSection;
  Level:           Integer;
  Icon:            String;
  IconBubble:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTDTitleSection
  * Append a new TD tag for an HTML table *
  Description:
  This method creates a TD tag for a title of a section. It includes a
  toggle button for control of the display of the section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  SectID:          String;
  BtnID:           String;
  Toggle:          String;
begin

  // Standard treatment: open the TD tag
  if Length( ASection.SectionBubble ) = 0 then
    AddTag( TDOTAG + cClassTitleSect + cAnr, Level )
  else
    AddTag( TDOTAG + cClassTitleSect + cSpace +
            cTitleEmpty + ASection.SectionBubble + cDQuote + cAnr, Level );

    // Addition of a toggle button for titles of sections
    SectID := cIDSection[ ASection.SectionType ];
    BtnID := cIDButton[ ASection.SectionType ];
    Toggle := MakeToggle( SectID );
    AddTag( Toggle, Level + 1 );

    // Addition of the section title
    AddTag( ASection.SectionTitle, Level + 1 );

  // Close the TD tag
  AddTag( TDETAG, Level );

  // Add a knowledge help icon and link
  if ( Icon <> cEmpty ) then
  begin
    AddTag( TDTAG, Level );
      AddTag( DIVOTAG + 'id="boxhelp"'{cIdHelpIcon} + cSpace + cTitleEmpty + IconBubble +
              cDQuote + cAnr, Level + 1 );
        AddTag( Icon, Level + 2 );

        // Addition of a toggle button for titles of sections
        SectID := cKNSection[ ASection.SectionType ];
        BtnID := cKNButton[ ASection.SectionType ];
        Toggle := IMGOTAG + 'id' + cEqual + cDQuote +
                  'Btn' + SectID + cDQuote + cSpace +
                  'type' + cEqual + cDQuote + 'button' + cDQuote + cSpace +
                  'onclick' + cEqual + cDQuote + 'ToggleKB' + cRol +
                  cSpace + cQuote + 'boxhelpx' + cQuote + cSpace +
                  cRor + cDQuote + cSlash + cAnr;
        AddTag( '<iframe src="HelpNounGenderFREN.html" width="520px" height="500px"></iframe>', Level + 2 );
        AddTag( Toggle, Level + 2 );
      AddTag( DIVETAG, Level + 1 );
      AddTag( '<script> InitKB( "boxhelpx" )</script>', Level + 1 );
    AddTag( TDETAG, Level );
  end;
end; // ______________________________________________________MakeTDTitleSection

procedure          MakeTDTA98TitleSection(
  ASection:        TTA98ListSection;
  Level:           Integer );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeTDTA98TitleSection
  * Append a new TD tag for an HTML table *
  Description:
  This method creates a TD tag for a title of a section. It includes a
  toggle button for control of the display of the section.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  SectID:          String;
  BtnID:           String;
  Toggle:          String;
begin

  // Standard treatment: open the TD tag
  if Length( ASection.SectionBubble ) = 0 then
    AddTag( TDOTAG + cClassTitleSect + cAnr, Level )
  else
    AddTag( TDOTAG + cClassTitleSect + cSpace +
            cTitleEmpty + ASection.SectionBubble + cDQuote + cAnr, Level );

    // Addition of a toggle button for titles of sections
    SectID := CIDSection[ ASection.SectionType ];
    BtnID := CIDButton[ ASection.SectionType ];
    Toggle := MakeToggle( SectId );
    AddTag( Toggle, Level + 1 );

    // Addition of the section title
    AddTag( ASection.SectionTitle, Level + 1 );

  // Close the TD tag
  AddTag( TDETAG, Level );
end; // __________________________________________________MakeTDTA98TitleSection

end.
