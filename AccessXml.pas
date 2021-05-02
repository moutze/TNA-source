{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit AccessXml
  * XML utility package for database table conversion *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit AccessXml;

interface

const
                   { Character constants }
  cLexSep          = '|';
  cSpace           = ' ';
  cColon           = ':';
  cEmpty           = '';
  cSlash           = '/';
  cBSlash          = '\';
  cPeriod          = '.';
  cAster           = '*';
  cEqual           = '=';
  cAnl             = '<';
  cAnr             = '>';
  cAmper           = '&';
  cApos            = '''';
  cQuestm          = '?';
  cQuote           = '''';
  cDQuote          = '"';
  cCRLF            = #13#10;
  cTab             = #9;
  cDataBegin       = '<![CDATA[';
  cDataEnd         = ']]>';
  cEncoding        = '<?xml version="1.0" encoding="utf-8"?>';
                   { Standard escape sequences in XML }
  cXmlAnl          = '&lt;';
  cXmlAnr          = '&gt;';
  cXmlAmp          = '&amp;';
  cXmlApos         = '&apos;';
  cXmlQuot         = '&quot;';

type
                   { Enumeration type of all XML tags. }
  tXmlTag          = (
                   xmlSeqFile,
                     xmlSource,
                     xmlRecord,
                       xmlUndef,
                     xmlTotal,
                     xmlDate,
                   xmlTreeView,
                     xmlNode, xmlTitle, xmlUrl, xmlLevel, xmlTAID,
                       xmlChildSet, xmlNb,
                     xmlStat, xmlEntry, xmlSCall, xmlRCall, xmlQCall, xmlRefer, xmlUpd,
                   xmlEntity,
                     xmlIdentity,
                       xmlID, xmlTA, xmlFMA, xmlCode,
                       xmlName, xmlEN, xmlLA, xmlFR,
                       xmlType,
                     xmlPartOf,
                       xmlAnc, xmlOrd,
                   xmlSingle, xmlThree,
                     xmlItem, xmlNbItem,
                     xmlWords, xmlNbWord,
                       xmlLetter, xmlPattern,
                       xmlTerm, xmlLib, xmlTID,
                       xmlWord, xmlNbOcc,
                       xmlList );

                   { Labels for XML defined tags }
                   tXml = Array [tXmlTag] of String;

                 var
                   { XML defined tags }
  cXmlLabel:       tXml = (
                   'FILE',
                     'SOURCE',
                     'REC',
                       'UNDEF',
                     'TOTAL',
                     'DATE',
                   'TREEVIEW',
                     'NODE', 'title', 'url', 'level', 'TAID',
                       'CHILDSET', 'nb',
                     'STAT', 'entry', 'S-call', 'R-call', 'Q-call', 'refer', 'upd',
                   'ENTITY',
                     'IDENTITY',
                       'ID', 'TA', 'FMA', 'Code',
                       'NAME', 'EN', 'LA', 'FR',
                       'TYPE',
                     'PARTOF',
                       'ANC', 'ord',
                   'SINGLE', 'THREE',
                     'ITEM', 'NbItem',
                     'WORDS', 'NbWord',
                       'LETTER', 'Pattern',
                       'TERM', 'Lib', 'TID',
                       'WORD', 'NbOcc',
                       'LIST' );

                   { Build an open XML tag }
function           BeginXml(
                     Tag: tXmlTag )
                     : String;
                   { Build an open XML tag with parameter }
function           BeginXmlPar(
                     Tag: tXmlTag;
                     Par: String )
                     : String;
                   { Build a close XML tag }
function           EndXml(
                     Tag: tXmlTag )
                     : String;
                   { Get full content of the first occurence of an XML tag }
function           GetXml(
                     Mess: String;
                     Tag: tXmlTag;
                     Times: Integer;
                     var More: Boolean;
                     var Par: String;
                     var After: String )
                     : String;
                   { Get full content of the next occurence of an XML tag }
function           GetXmlNext(
                     Tag: tXmlTag;
                     var More: Boolean;
                     var Par: String;
                     var After: String )
                     : String;
                   { Full pair tag - end tag with predefined tag }
function           X(
                     Tag: tXmlTag;
                     Content: String )
                     : String;
                   { Full pair tag - end tag with predefined tag and parameter }
function           XPar(
                     Tag: tXmlTag;
                     Par: String;
                     Content: String )
                     : String;
                   { Full pair tag - end tag with undefined tag }
function           XUndef(
                     ExtraTag: String;
                     Content: String )
                     : String;
                   { Full pair tag - end tag with undefined tag and parameter }
function           XParUndef(
                     ExtraTag: String;
                     Par: String;
                     Content: String )
                     : String;
                   { Build a parameter - value pair for a predefined tag }
function           Param(
                     Tag: tXmlTag;
                     Val: String )
                     : String;
                   { Build a parameter - value pair for an undefined tag }
function           ParamUndef(
                     ExtraTag: String;
                     Val: String )
                     : String;
                   { Get value from a parameter value pair }
function           ParValue(
                     Par: String;
                     Tag: tXmlTag)
                     : String;
                   { Optimized GREP search on strings }
function           Grep(
                     Pattern: String;
                     Content: String )
                     : Integer;
                   { Replacement of forbidden characters }
function           EscapeXmlMessage(
                     Xml: String )
                     : String;
                   { Restauration of forbidden characters }
function           RebuildXMLMessage(
                     Xml: String )
                     : String;

implementation

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BeginXml
  * Build a begin XML tag *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           BeginXml(
  Tag:             tXmlTag )
  :                String;
begin
  Result := cAnl + cXmlLabel[ Tag ] + cAnr;
end; // _______________________________________________________________ BeginXml

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BeginXmlPar
  * Build a begin XML tag with parameters *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           BeginXmlPar(
  Tag:             tXmlTag;
  Par:             String )
  :                String;
begin
  Result := cAnl + cXmlLabel[ Tag ] + Par + cAnr;
end; // ____________________________________________________________ BeginXmlPar

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ EndXml
  * Build an end XML tag *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           EndXml(
  Tag:             tXmlTag )
  :                String;
begin
  Result := cAnl + cSlash + cXmlLabel[ Tag ] + cAnr;
end; // _________________________________________________________________ EndXml

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetXml
  * Get content of an upper level XML tag *
  Arguments:
  Mess - String XML in which information is searched for
  Tag - Searched tag at upper level in the XML string
  Times - Position of occurence of the tag: 1 or more.
  Returns:
  The full content of the specified tag for the given occurence, empty when
  the search gives no result
  Description:
  This function searches in an XML message for a tag at upper level, this means
  non embedded in another tag. When the tag is found, its content is extracted.
  The occurence of a CData block is taken into account and the block is ignored.
  Multiple occurences of the same tag are possible and a specified position
  ordinal number will alter the processing.
  Note:
  This function is not optimised for search of multiple occurences of the same
  tag, because it restarts search each time from beginning of message.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           GetXml(
  Mess:            String;
  Tag:             tXmlTag;
  Times:           Integer;
  var More:        Boolean;
  var Par:         String;
  var After:       String )
  :                String;
var
  Posit:           Integer;
  PosSpace:        Integer;
  NbOcc:           Integer;
  Lgt:             Integer;
  Content:         String;
  Part:            String;
  Debut:           String;
  Fin:             String;
  ATag:            String;
  ShortTag:        String;
begin
  // Search next upper level begin-end tag
  Part := Mess;
  NbOcc := 0;
  Content := cEmpty;
  while Length( Part ) > 0 do
  begin
    // Skip <? ... ?> the XML encoding header if present
    Posit := Pos( cAnl, Part );
    if Posit = 0 then
      Break;
    if Part[ Posit + 1 ] = cQuestm then
    begin
      Posit := Pos( cQuestm + cAnr, Part );
      if Posit > 0 then
      begin
        Part := Copy( Part, Posit + 2, Length( Part ) );
        Posit := Pos( cAnl, Part );
      end;
    end;
    Part := Copy( Part, Posit, Length( Part ) - Posit + 1 );

    // Search begin tag
    Posit := Pos( cAnr, Part );
    if ( Posit = 0 ) then
      Break;
    Debut := Copy( Part, 1, Posit );
    PosSpace := Pos( cSpace, Debut );
    if ( PosSpace > 0 ) then
      Par := Copy( Debut, PosSpace + 1, Length( Debut ) - PosSpace - 1 );
    Fin := cAnl + cSlash + Copy( Debut, 2, Length( Debut ) );
    PosSpace := Pos( cSpace, Fin );
    if ( PosSpace > 0 ) then
      Fin := Copy( Fin, 1, PosSpace - 1 ) + cAnr;
    Part := Copy( Part, Posit + 1, Length( Part ) - Posit );

    // Search matching end tag
    Posit := Grep( Fin, Part );
    if Posit = 0 then
      Break;

    // Leave when successful
    ATag := BeginXML( Tag );
    if ( ( Copy( Debut, 1, Length( Atag ) - 1 ) =
      Copy( ATag, 1, Length( Atag ) - 1 ) ) ) then
    begin
      Inc( NbOcc );
      if ( NbOcc = Times ) then
      begin
        Content := Copy( Part, 1, Posit - 1 );

        // Check for the presence of CData
        Lgt := Length( cDataBegin );
        if ( cDataBegin = Copy( Content, 1, Lgt ) ) then
        begin
          Content := Copy( Content, Lgt + 1,
            Length( Content ) - Lgt - Length( cDataEnd ) );
        end;
        Part := Copy( Part, Posit + Length( Fin ), Length( Part ) );
        Break;
      end;
    end;
    Part := Copy( Part, Posit + Length( Fin ), Length( Part ) );
  end; // while

  // Prepare a possible next call with same tag (see GetXMLNext)
  After := Part;
  ShortTag := cAnl + cXmlLabel[ Tag ];
  More := Grep( ShortTag, Part ) > 0;

  // Remove escape sequences
  Result := RebuildXMLMessage( Content );
end; // _________________________________________________________________ GetXml

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GetXmlNext
  * Get content for the next occurence of a tag *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           GetXmlNext(
  Tag:             tXmlTag;
  var More:        Boolean;
  var Par:         String;
  var After:       String )
  :                String;
var
  Posit:           Integer;
  PosSpace:        Integer;
  Lgt:             Integer;
  Content:         String;
  Part:            String;
  Debut:           String;
  Fin:             String;
  ATag:            String;
  ShortTag:        String;
begin
  // Search next upper level begin-end tag
  Part := After;
  while Length( Part ) > 0 do
  begin
    // Search begin tag
    Posit := Pos( cAnl, Part );
    if Posit = 0 then
      Break;
    Part := Copy( Part, Posit, Length( Part ) - Posit + 1 );
    Posit := Pos( cAnr, Part );
    if Posit = 0 then
      Break;
    Debut := Copy( Part, 1, Posit );
    PosSpace := Pos( cSpace, Debut );
    if PosSpace > 0 then
      Par := Copy( Debut, PosSpace + 1, Length( Debut ) - PosSpace - 1 );
    Fin := cAnl + cSlash + Copy( Debut, 2, Length( Debut ) );
    PosSpace := Pos( cSpace, Fin );
    if PosSpace > 0 then
      Fin := Copy( Fin, 1, PosSpace - 1 ) + cAnr;
    Part := Copy( Part, Posit + 1, Length( Part ) - Posit );

    // Search matching end tag
    Posit := Grep( Fin, Part );
    if Posit = 0 then
      Break;

    // Leave when successful
    ATag := BeginXml( Tag );
    if Copy( Debut, 1, Length( Atag ) - 1 ) =
      Copy( ATag, 1, Length( Atag ) - 1 ) then
    begin
      Content := Copy( Part, 1, Posit - 1 );

      // Check for the presence of CData
      Lgt := Length( cDataBegin );
      if cDataBegin = Copy( Content, 1, Lgt ) then
        Content := Copy( Content, Lgt + 1,
          Length( Content ) - Lgt - Length( cDataEnd ) );
      Part := Copy( Part, Posit + Length( Fin ), Length( Part ) );
      Break;
    end;
    Part := Copy( Part, Posit + Length( Fin ), Length( Part ) );
  end; // while

  // Prepare a possible next call with same tag
  After := Part;
  ShortTag := cAnl + cXmlLabel[ Tag ];
  More := Grep( ShortTag, Part ) > 0;

  // Prepare next call with same tag
  Result := RebuildXMLMessage( Content );
end; // _____________________________________________________________ GetXmlNext

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ X
  * Build a begin-end XML message with predefined tag *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           X(
  Tag:             tXmlTag;
  Content:         String )
  :                String;
begin
  Result := BeginXml( Tag ) + EscapeXmlMessage( Content ) + EndXml( Tag );
end; // ______________________________________________________________________ X

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XPar
  * Build a begin-end XML message with predefined tag and parameters *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           XPar(
  Tag:             tXmlTag;
  Par:             String;
  Content:         String )
  :                String;
begin
  Result :=
    BeginXmlPar( Tag, Par ) + EscapeXmlMessage( Content ) + EndXml( Tag );
end; // ___________________________________________________________________ XPar

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XUndef
  * Build a begin-end XML part of message with undefined tag *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           XUndef(
  ExtraTag:        String;
  Content:         String )
  :                String;
begin
  Result := cAnl + ExtraTag + cAnr + EscapeXmlMessage( Content ) +
            cAnl + cSlash + ExtraTag + cAnr;
end; // _________________________________________________________________ XUndef

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XParUndef
  * Build a begin-end XML message with undefined tag and parameters *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           XParUndef(
  ExtraTag:        String;
  Par:             String;
  Content:         String )
  :                String;
begin
  Result := cAnl + ExtraTag + cSpace + Par + cAnr +
            EscapeXmlMessage( Content ) + cAnl + cSlash + ExtraTag + cAnr;
end; // ______________________________________________________________ XParUndef

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Param
  * Build a pair of parameter and value for a predefined tag *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           Param(
  Tag:             tXmlTag;
  Val:             String )
  :                String;
begin
  Result := cSpace + cXmlLabel[ Tag ] + cEqual + cDQuote + Val + cDQuote;
end; // ___________________________________________________________________Param

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ParamUndef
  * Build a pair of parameter and value for an undefined tag *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           ParamUndef(
  ExtraTag:        String;
  Val:             String )
  :                String;
begin
  Result := cSpace + ExtraTag + cEqual + cDQuote + Val + cDQuote;
end; // _____________________________________________________________ ParamUndef

function           ParValue(
  Par:             String;
  Tag:             tXmlTag)
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ParValue
  * Get value from a parameter value pair *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  MyTag:           String;
  Part:            String;
begin
  Posit := Grep( cXmlLabel[ Tag ], Par );
  Part := Copy( Par, Posit, Length( Par ) );
  Posit := Pos( cEqual, Part );
  MyTag := Copy( Part, 1, Posit - 1 );
  if ( MyTag <> cXmlLabel[ Tag ] ) then
    Exit;
  Part := Copy( Part, Posit + 2, Length( Part ) );
  Posit := Pos( '"', Part );
  Result := Copy( Part, 1, Posit - 1 );
end; // ________________________________________________________________ParValue

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Grep
  * Optimised search for a specified pattern in a string *
  Description:
  This function is an implementation of the Boyer-Moore algorithm.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           Grep(
  Pattern:         String;
  Content:         String )
  :                Integer;
const
  Size             = 256;
var
  Scale:           Array[ 0 .. Size - 1 ] of Byte;
  Indx:            Byte;
  Next:            Byte;
  Lgt:             Integer;
  LgtMess:         Integer;
  Posit:           Integer;
begin
  // Initial stuff
  Result := 0;
  Lgt := Length( Pattern );
  if ( Lgt > Size - 1 ) then
    Exit;
  Posit := Lgt;
  LgtMess := Length( Content );

  // Prepare the jump scale
  for Indx := 0 to Size - 1 do
    Scale[ Indx ] := Byte( Lgt );
  for Indx := 1 to Lgt - 1 do
    Scale[ Byte( Pattern[ Indx ] ) ] := Lgt - Indx;

  // Scan the message content
  while ( Posit <= LgtMess ) do
  begin
    for Indx := Lgt downto 1 do
    begin
      Next := Byte( Content[ Posit - Lgt + Indx ] );
      if Next <> Byte( Pattern[ Indx ] ) then
      begin
        Inc( Posit, Scale[ Next ] );
        Break;
      end else
      begin
        if Indx = 1 then
        begin
          Result := Posit - Lgt + 1;
          Exit;
        end;
      end;
    end; // for
  end; // while
end; // ____________________________________________________________________Grep

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ EscapeXmlMessage
  * Replacement of XML forbidden characters by defined escape sequences *
  Description:
  This procedure replaces any fobidden character in an XML message by the
  specified escape sequences.<P>
  There are 5 possible replacements:
  * '<' becomes '&lt;'
  * '>' becomes '&gt;'
  * '&' becomes '&amp;'
  * '''' becomes '&apos;'
  * '"' becomes '&quot;'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           EscapeXmlMessage(
  Xml:             String )
  :                String;
var
  Indx:            Integer;
  Res:             String;
begin
  Res := cEmpty;
  for Indx := 1 to Length( Xml ) do
  begin
    case Xml[ Indx ] of
    '<' : Res := Res + cXmlAnl;
    '>' : Res := Res + cXmlAnr;
    '&' : Res := Res + cXmlAmp;
    '''': Res := Res + cXmlApos;
    '"' : Res := Res + cXmlQuot;
    else  Res := Res + Xml[ Indx ];
    end; // case
  end; // for
  Result := Xml;
end; // ________________________________________________________EscapeXmlMessage

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RebuildXMLMessage
  * Replacement of XML escape sequences by corresponding characters *
  Description:
  This procedure makes the inverse of EscapeXMLMessage.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function           RebuildXMLMessage(
  Xml:             String )
  :                String;
var
  Posit:           Integer;
  ToDo:            String;
  Res:             String;
begin
  // Treatment of >
  ToDo := Xml;
  Posit := Grep( cXmlAnr, ToDo );
  while Posit > 0 do
  begin
    Res := Res + Copy( ToDo, 1, Posit - 1 ) + cAnr;
    ToDo := Copy( ToDo, Posit + Length( cXmlAnr ), Length( ToDo ) );
    Posit := Grep( cXmlAnr, ToDo );
  end; // while
  Todo := Res + ToDo;

  // Treatment of <
  Posit := Grep( cXmlAnl, ToDo );
  while Posit > 0 do
  begin
    Res := Res + Copy( ToDo, 1, Posit - 1 ) + cAnl;
    ToDo := Copy( ToDo, Posit + Length( cXmlAnl ), Length( ToDo ) );
    Posit := Grep( cXmlAnl, ToDo );
  end; // while
  ToDo := Res + ToDo;

  // Treatment of &
  Posit := Grep( cXmlAmp, ToDo );
  while Posit > 0 do
  begin
    Res := Res + Copy( ToDo, 1, Posit - 1 ) + cAmper;
    ToDo := Copy( ToDo, Posit + Length( cXmlAmp ), Length( ToDo ) );
    Posit := Grep( cXmlAmp, ToDo );
  end; // while
  ToDo := Res + ToDo;

  // Treatment of apostrophe
  Posit := Grep( cXmlApos, ToDo );
  while Posit > 0 do
  begin
    Res := Res + Copy( ToDo, 1, Posit - 1 ) + cApos;
    ToDo := Copy( ToDo, Posit + Length( cXmlApos ), Length( ToDo ) );
    Posit := Grep( cXmlApos, ToDo );
  end; // while
  ToDo := Res + ToDo;

  // Treatment of quote
  Posit := Grep( cXmlQuot, ToDo );
  while Posit > 0 do
  begin
    Res := Res + Copy( ToDo, 1, Posit - 1 ) + cQuote;
    ToDo := Copy( ToDo, Posit + Length( cXmlQuot ), Length( ToDo ) );
    Posit := Grep( cXmlQuot, ToDo );
  end; // while
  Result := Res + ToDo;
end; // _______________________________________________________RebuildXMLMessage

end.
