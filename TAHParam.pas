{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit TAHParam
  * Basic constants, types and variables for TAH *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit TAHParam;

interface

uses
  ComCtrls, TAHInterface;

type
  tDisLang         = ( en, fr );

const
                   // Single line signature for all pages.
                   // The signature is made of three distinct parts:
                   // 1. A reference with hyperlink to FIPAT,
                   // 2. A link to the official page of the website, where
                   //    the FIPAT policy about licenses is presented,
                   // 3. A reference of the license applicable to this page
                   //    with hyperlink to Creative Commons.
                   // This information corresponds to a direct decision of
                   // FIPAT and cannot be changed without another decision.
  cSignature       =
    '<A href="http://www.ifaa.net/index.php/fipat/">' +
    'FEDERATIVE INTERNATIONAL PROGRAMME FOR ANATOMICAL TERMINOLOGY</A> ' +
    '<A href="../../licensing-policy.html">' +
    'Creative Commons Attribution-ShareAlike 4.0 International</A> ' +
    '<A rel=license href="http://creativecommons.org/licenses/by-sa/4.0/">' +
    '(CC BY-SA 4.0)</A>';

                   // Database export files
  cUnitFileName    = 'Export UNIT.txt';
  cLAFileName      = 'Export LA.txt';
  cListFileName    = 'Export LIST.txt';
  cENFileName      = 'Export EN.txt';
  cFRFileName      = 'Export FR.txt';
  cESFileName      = 'Export ES.txt';
  cRUFileName      = 'Export RU.txt';
  cITFileName      = 'Export IT.txt';
  cGEFileName      = 'Export GE.txt';
  cPTFileName      = 'Export PT.txt';
  cMDFileName      = 'Export MD.txt';
  cNotesFileName   = 'Export NOTES.txt';
  cDefENFileName   = 'Export DEFEN.txt';
  cDefFRFileName   = 'Export DEFFR.txt';
  cDefESFileName   = 'Export DEFES.txt';
  cDefRUFileName   = 'Export DEFRU.txt';
  cDocumFileName   = 'Export Docum.txt';
  cLADicoFileName  = 'Export LA case.txt';
  cFixTradFileName = 'Export FIXTRAD.txt';
  cTA98ListFileName= 'Export TA98.txt';
  cTAFMAFileName   = 'Export FMA.txt';
  cCommFileName    = 'Export COMMENTS.txt';
                   // Filename to be confirmed
  LAModFileName    = 'Export MODLA.txt';
  ConcordFileName  = 'Export Concordance.txt';
  RawFormFileName  = 'Export Formula.txt';
  FMAFileName      = 'FMA save.xml';
  FMAModFileName   = 'Export MODFMA.txt';
  PROPSFileName    = 'Export PROPS.txt';
  SEQFileName      = 'Export SEQ.txt';
  SequenceFileName = 'Export Sequence.txt';
  PrintTextFileName= 'Page file.txt';
  ChangeFileName   = 'Change file.txt';
  PictureFileName  = 'Export PICTURE.txt';
  InqueryFileName  = 'Export Inquiry.txt';
  ActionFileName   = 'Export Action.txt';

                   // HTML page directories for generated pages
  cProjectDir      = 'C://Users/Robert/Documents/MyTAH/TAH web/' +
                     'Private/EntryTNA/';
  cAutoDir         = 'auto/';
  cHelpDir         = 'help/';
  cKnowDir         = 'know/';
  cTourDir         = 'tour/';
  cPropDir         = 'prop/';
  cServDir         = 'serv/';
  cImgDir          = 'img/';
  cPDFDir          = 'PDF/';
  cEditDir         = 'edit/';
  cPartDir         = 'Part List/';
  cTaxDir          = 'Tax List/';
                   // Public TA98 root dorectory
  PublicRootDir    = 'C://Users/Robert/Documents/MyTAH/TAH web/' +
                     'Public/EntryPageNew/TA98 Tree/';
                   // Redirection for export file from exe directory
  RedirExport      = '/../../../../TAH Export/';
                   // URL for documentation
  FMEBaseUrl       = 'http://fme.biostr.washington.edu/FME/index.jsp';
  FMABioportalUrl  = 'https://bioportal.bioontology.org/ontologies/FMA/';
  BioportalQuest   = '?p=classes&conceptid=http%3A%2F%2Fpurl.org%2Fsig%2Font%2Ffma%2Ffma';
  BioportalPost    = '&jump_to_nav=true';
  FMAAltUrl        = 'http://xiphoid.biostr.washington.edu/fma/fmabrowser-hierarchy.html';
  WhoNamedItUrl    = 'http://www.whonamedit.com/doctor.cfm/';
                   // BioPortal
  BioPortalUrl     = 'https://bioportal.bioontology.org/ontologies/FMA/?p=classes&conceptid=http%3A%2F%2Fpurl.org%2Fsig%2Font%2Ffma%2Ffma';
                   // Directory names
  DirTASynonymName = 'Synonym';          // Single language with synonyms
  DirTA98Name      = 'TA98';             // Facsimile TA98
  DirRevTermAName  = 'RevTermA';         // Facsimile RevTermA
  DirExpansionName = 'Expansion';        // Generation of expansions
  DirHierarchyName = 'Hierarchy';        // Hierarchy LG XML files
  DirHierTA98Name  = 'Hierarchy TA98';   // Hierarchy TA98 LG XML files
  DirSingleName    = 'Single';           // Single letter Latin XML files
  DirThreeName     = 'Three';            // Three letters LatinXML files
  DirStatName      = 'Stat';             // Statistics
  cDirEntity       = 'Entity/';          // Entity Page
  cDirUnit         = 'Unit/';            // Unit Page
  cDirPartList     = 'Part List/';       // Partonomic list Page
  cDirTaxList      = 'Tax List/';        // Taxonomic list Page
  DirTestName      = 'Test Language/';   // Test Page
  DirEntityXMLName = 'Entity XML';       // Entity XML
  DirEntity98Name  = 'Entity TA98';      // TA98 Entity Page
  cDirUniversal    = 'Universal/';        // Universal Page
  DirLatin98Name   = 'Latin TA98';       // TA98 Latin Page
  DirPropertyName  = 'Property';         // Property Page
  DirUniversalName = 'Universal';        // Universal Page
  DirProperty98Name= 'Property TA98';    // Property Page
  DirDoubleName    = 'Double';           //
  Dir3LanguageName = 'TA3X';             // LA, EN, FR no expansion
  Dir3PlusName     = 'TA3X Plus';        // LA, EN, FR vertical expansion
  Dir3ExpandedName = 'TA3X Expansion';   // LA, EN, FR horizontal expansion
  DirTAtoFMAName   = 'TAtoFMA';          // TA to FMA Page
  DirHelpRelName   = '../HelpPage/';
  DirTranslatName  = 'Translation';      // Translation
  DirAlphaName     = 'Alpha';            // Alphabetical list
  DirTA98AlphaName = 'Alpha TA98';       // Alphabetical list TA98 version
  DirNotesName     = 'Notes';            // Notes Page
  DirTAHName       = '../Entity LA/';    // Relative TAH
  cDirDefinition   = 'Definition/';      // Definition list
  DirTA98ListName  = 'TA98 List';        // TA98 list
  DirSegmentName   = 'Segmentation';     // Segmentation
  DirValidName     = 'Validation';       // Validation
  DirListName      = 'List';             // List
  DirViewPartList  = 'ViewPartList';     // Navigate the partonomic lists
  DirViewTaxList   = 'ViewTaxList';      // Navigate the tax lists

                   { * HTML page filenames * }
  HelpSynonymPage  = 'View Synonym Page.html';
  HelpTA98Page     = 'View TA98 Page.html';
  HelpRevTermAPage = 'View RevTermA Page.html';
  HelpStatPage     = 'View Statistics Page.html';
  HelpPropertyPage = 'View Property Page.html';
  HelpUnivPage     = 'View Universal Page.html';
  HelpDefinPage    = 'View Definition Page.html';
  HelpTA98ListPage = 'View TA98 List Page.html';
  HelpSegmentationPage = 'View Segmentation Page.html';
  HelpEntityPage   = 'View Entity Page.html';
  HelpUnitPage     = 'View Unit Page.html';
  HelpTestPage     = 'View Test Page.html';
  HelpUniversalPage= 'View Universal Page.html';
  HelpValidPage    = 'View Validation Page.html';
  HelpListPage     = 'View List Page.html';
  HelpAlphaPage    = 'View Alpha Page.html';
  HelpNotesPage    = 'View Notes Page.html';

                   { * Icons location * }
  cBilatImg        = '<img src="../../../img/bilat.jpg"/>';
  cGntorImg        = '<img src="../../../img/gntor.jpg"/>';
  cGenerImg        = '<img src="../../../img/gener.jpg"/>';
  cSpeciImg        = '<img src="../../../img/speci.jpg"/>';
  cMultiImg        = '<img src="../../../img/multi.jpg"/>';
  cPaireImg        = '<img src="../../../img/pair.jpg"/>';
  cReferImg        = '<img src="../../../img/refer.jpg"/>';
  cNewCdImg        = '<img src="../../../img/newcd.jpg"/>';
  cIncstImg        = '<img src="../../../img/incst.jpg"/>';
  cDimorImg        = '<img src="../../../img/dimor.jpg"/>';
  cMSymbImg        = '<img src="../../../img/msymb.jpg"/>';
  cFSymbImg        = '<img src="../../../img/fsymb.jpg"/>';
  cExpndImg        = '<img src="../../../img/expnd.jpg"/>';
  cMaterImg        = '<img src="../../../img/mater.jpg"/>';
  cImmatImg        = '<img src="../../../img/immat.jpg"/>';
  cProblemImg      = '<img src="../../../img/probl.jpg"/>';
  cNonPhImg        = '<img src="../../../img/nonph.jpg"/>';
  cHelpImg         = '<img src="../../../img/Help48.bmp"/>';
  cOpenSrc         = 'src="../../../img/open.jpg"';
  cCloseSrc        = 'src="../../../img/close.jpg"';
  cRoundSrc        = 'src="../../../img/round.jpg"';
  cRoundImg        = '<img src="../../../img/round.jpg"/>';
  cRefImg          = '<img src=''../../../img/Reference.png''/>';
  cLinkGenerImg    = '<img src="../../../img/G.jpg"/>';
  cRedImg          = '<img src="../../../img/red.jpg"/>';
  cGreenImg        = '<img src="../../../img/green.jpg"/>';
  cOrangeImg       = '<img src="../../../img/orange.jpg"/>';
  cTA98Img         = '<img src="../../../img/TA98.jpg"/>';
  cBlankImg        = '<img src="../../../img/blank.jpg"/>';
  cTAPlusImg       = '<img src="../../../img/plus.jpg"/>';
  cUniversal       = '<img src=''../../../img/UniLogo.png''/>';
  cHeritage        = '<img src=''../../../img/ModLogo.png''/>';

                   // Error identifiers
  erMissExp        = 1;                // Missing exp
  erMissAdj        = 2;                // Missing adj
  erMissAdjUnit    = 5;                // Missing adj unit
  erMissAdjVoc     = 6;                // Missing adj voc
  erMissAdjSpec    = 7;                // Missing adj voc
  erAdjLang        = 11;               // Language adjective procedure
  erMissPreUnit    = 8;                // Missing pre unit
  erMissPreVoc     = 9;                // Missing pre voc
  erMissPreSpec    = 10;               // Missing pre voc
  erMissMand       = 12;               // Missing mandatory expansion
  erMissGen        = 3;                // Missing gen
  erMissBasGen     = 4;                // Missing bas gen

                   { * Characters * }
  CurSep           = '¦';
  cBreak           = '|';
  cSpace           = ' ';
  cEmpty           = '';
  cAster           = '*';
  cPlus            = '+';
  cMinus           = '-';
  cRol             = '(';
  cRor             = ')';
  cSql             = '[';
  cSqr             = ']';
  cCul             = '{';
  cCur             = '}';
  cAnl             = '<';
  cAnr             = '>';
  cPeriod          = '.';
  cSemi            = ';';
  cColumn          = ':';
  cDash            = '-';
  cQuote           = #39;      // Single quote
  cDQuote          = '"';      // Double quote
  cSlash           = '/';
  cComma           = ',';
  cFemale          = '♀';      // Female sign
  cMale            = '♂';      // Male sign
  cUsa             = '▲';      // US/UK sign
  cEqual           = '=';
  cNumber          = '#';      // Start of a generic partonomy
  cIsNote          = '↓';      // Presence of a note
  cQuest           = '?';
  cCopyRights      = '©';      // The CopyRights sign
  cRegistered      = '®';      // The Registered sign
  // cUniversal       = '©'; //'ⓤ';      // The Universal sign (circled u)
  cDefIcon         = '♥';      // Definition icon
  cAmpersand       = '&';      // Ampersand sign
  cNBSP            = #160;     // No break space
  cUnderline       = '_';
  cPercent         = '%';      // Percentage sign
  cArobas          = '@';      // Arobase sign
  cExclam          = '!';      // Exclamation mark
  cIrreg           = ' ';       // Irregular flag (= '!')

                               // TA98 end of page note
  cTA98Sign        = '<FONT SIZE="4" COLOR=red>♦</FONT>';
                               // Error note symbole
  cErrorSign       = '<FONT SIZE="4" COLOR=blue>♠</FONT>';
                               // RAT note symbole
  cRATSign         = '<FONT SIZE="4" COLOR=green>♣</FONT>';
                               // Redirection note symbole
  cRedirSign       = '<FONT SIZE="4" COLOR=pink>♥</FONT>' ;
  cRetroDir        = '../';
  cRetroDir2x      = '../../';
  cRetroDir3x      = '../../../';
  cClassPrefix     = 'cl_';
  cFile            = 'file:///';

                   // Identifiers of representation of words
  reClassis        = 12631;            // Classis

                   // Words and terms
  cTA98            = 'TA98';
  cTA              = 'TA';
  cTAH             = 'TAH';
  cTAHEntity       = 'TAH:E';
  cTAHUnit         = 'TAH:U';
  cRevTermA        = 'RevTermA';
  cTarget          = 'target';
  cUBlank          = '_blank';
  cFor             = 'for';
  cPour            = 'pour';
  cIndent          = 'Indent';
  cStat            = 'Stat';
  cProperty        = 'Property';
  cUniv            = 'Universal';
  cDefinition      = 'Definition';
  cTA98Long        = 'TA98 Long';
  cTA98Short       = 'TA98 Short';
  cTA98Sub         = 'TA98 Sub';
  cTA98Chap        = 'TA98 Chapter';
  cSegmentation    = 'Segmentation';
  cLevel4          = 'Level4';
  cProperty98      = 'Property TA98';
  cCode            = 'Code';
  cEntity          = 'Entity';
  cEntities        = 'entities';
  //cLaterals        = 'Lateral members';
  cTetrahedron     = 'Tetra';
  cTraceTA98       = 'TA98 List';
  cUnit            = 'Unit';
  cGeneric         = 'Generic';
  cSpecific        = 'Specific';
  cExtended        = 'Extended';
  cTranslation     = 'Translation';
  cTest            = 'Test';
  cEntity98        = 'Entity TA98';
  cTA98Tree        = 'TA98 Tree';
  cLatin           = 'Latin';
  cUnivPage        = 'Universal';
  cValidation      = 'Validation';
  cList            = 'List';
  cPart            = 'Part List';
  cPart98          = 'Part98';
  cPartList        = 'Generic Partonomy';
  cTax             = 'Tax List';
  cFMA             = 'FMA';
  cSynonym         = 'Synonym';
  cHierarchy       = 'Hierarchy';
  cSingle          = 'Single';
  cThree           = 'Three';
  cAlpha           = 'Alpha';
  cKWIC            = 'KWIC';
  cAnd             = 'and';
  cEt              = 'et';
  cProblem98       = 'Problem TA98';
  cNoFMA           = 'No FMA equivalent';
  cNotAvailable    = 'na';
  cWhich           = 'which';
  cQui             = 'qui';
  cMoreInfo        = 'More information';
  cSee             = 'See';
  cTooMuch         = 300;
  cOComment        = '<! ';
  cEComment        = ' >';
  cModifier        = 'Modifier:';
  cParLA           = 'par';
  cParEN           = 'pair of';
  cParFR           = 'paire de';
  cParEllisionFR   = 'paire d''';
  cParES           = 'par de';
  cParRU           = 'пapa';
  cRoundPar        = '(par)';
  cRoundPair       = '(pair)';
  cRoundPaire      = '(paire)';
  cRoundPara       = '(пара)';
  cFMAID           = 'FMAID';
  cLeft            = 'left';
  cRight           = 'right';
  cPage            = 'Page';
  cFMAList         = 'FMA List';
  cLong            = 'Long';
  cSub             = 'Sub';
  cOBold           = '<B>';
  cEBold           = '</B>';
  cOItalic         = '<I>';
  cEItalic         = '</I>';
  cParClassiumLA   = 'par classium';
  cParClassiumFR   = 'paire d''ensembles';
  cParClassiumEN   = 'pair of sets';
  cParClassiumES   = 'par de juntos';
  cParClassiumRU   = 'paire d''ensembles';
  cClassis         = 'classis';
  cSet             = 'set';
  cEnsemble        = 'ensemble';
  cJunto           = 'junto';
  cClassisRU       = 'вместе';
  cOf              = 'of';
  cDe              = 'de';
  cDes             = 'des';
  cDApos           = 'd''';
  cOK              = 'OK';
  cChildren        = 'children';
  cTID             = 'TID';
  cUID             = 'UID';
  cItems           = 'items';
  cBaseIndent      = 'a';
  cTagfmaid        = '?fmaid';
  cRefSign         = '->';
  cNewPar          = '<P>';
  cTaxonomic       = 'Taxonomic';
  cErr             = 'ERR';
  cHTML            = 'html';
  cHTM             = 'htm';
  cID              = 'id';
  cExpPref         = 'P';
  cExpAdj          = 'D';
  cExpMand         = 'M';
  cExpOpt          = 'F';
  cPub             = 'Pub';
  c5L              = '5L';

                   // Translated words and terms by display language
                   // English
  cFullEN          = 'Full';
  cShortEN         = 'Short';
  cLinesEN         = 'lines';
  cTopLevelEN      = 'Level 1';
  cLevel2EN        = 'Level 2';
  cLevel3EN        = 'Level 3';
  cCurrLevelEN     = 'Current level';
                   // French
  cFullFR          = 'Entier';
  cShortFR         = 'Abrégé';
  cLinesFR         = 'lignes';
  cTopLevelFR      = 'Niveau 1';
  cLevel2FR        = 'Niveau 2';
  cLevel3FR        = 'Niveau 3';
  cCurrLevelFR     = 'Niveau courant';
                   // Generic access
  cFull:           array[ tDisLang ] of String =
                   ( cFullEN, cFullFR );
  cShort:          array[ tDisLang ] of String =
                   ( cShortEN, cShortFR );
  cLines:          array[ tDisLang ] of String =
                   ( cLinesEN, cLinesFR );
  cTopLevel:       array[ tDisLang ] of String =
                   ( cTopLevelEN, cTopLevelFR );
  cLevel2:         array[ tDisLang ] of String =
                   ( cLevel2EN, cLevel2FR );
  cLevel3:         array[ tDisLang ] of String =
                   ( cLevel3EN, cLevel3FR );
  cCurrLevel:      array[ tDisLang ] of String =
                   ( cCurrLevelEN, cCurrLevelFR );
                   // Bubbles for translated words and terms by display language
                   // English
  bbTopLevelEN     = 'Links to the lists at top level';
  bbLevel2EN       = 'Links to the lists at level 2';
  bbLevel3EN       = 'Link to the full list at level 3';
  bbCurrLevelEN    = 'Current level, as actually presented on this page';
                   // French
  bbTopLevelFR     = 'Liens vers les listes au niveau supérieur';
  bbLevel2FR       = 'Liens vers les listes au niveau 2';
  bbLevel3FR       = 'Lien vers la liste entière au niveau 3';
  bbCurrLevelFR    = 'Niveau courant, tel que présenté actuellement sur cette page';
                   // Generic access
  bbTopLevel:      array[ tDisLang ] of String =
                   ( bbTopLevelEN, bbTopLevelFR );
  bbLevel2:        array[ tDisLang ] of String =
                   ( bbLevel2EN, bbLevel2FR );
  bbLevel3:        array[ tDisLang ] of String =
                   ( bbLevel3EN, bbLevel3FR );
  bbCurrLevel:     array[ tDisLang ] of String =
                   ( bbCurrLevelEN, bbCurrLevelFR );

                   // Translated words and terms by content language EN
                   // Latin
  cShortOFFLAEN    = 'Short official term';
                   // English
  cShortOFFENEN    = 'Short English equivalent';
                   // French
  cShortOFFFREN    = 'Short French equivalent';
                   // Spanish
  cShortOFFSPEN    = 'Short Spanish equivalent';
                   // Russian
  cShortOFFRUEN    = 'Short Russian equivalent';
                   // Translated words and terms by content language FR
                   // Latin
  cShortOFFLAFR    = 'Terme officiel court';
                   // English
  cShortOFFENFR    = 'Equivalent anglais court';
                   // French
  cShortOFFFRFR    = 'Equivalent français court';
                   // Spanish
  cShortOFFSPFR    = 'Equivalent espagnol court';
                   // Russian
  cShortOFFRUFR    = 'Equivalent russe court';

                   // Bubbles for translated terms by content language EN
                   // Latin
  bbShortOFFLAEN   = 'Short official term in Latin';
                   // English
  bbShortOFFENEN   = 'Short English official term equivalent of the Latin ' +
                     'official term';
                   // French
  bbShortOFFFREN   = 'Short French official term equivalent of the Latin ' +
                     'official term';
                   // Spanish
  bbShortOFFSPEN   = 'Short Spanish official term equivalent of the Latin ' +
                     'official term';
                   // Bubbles for translated terms by content language FR
                   // Latin
  bbShortOFFLAFR   = 'Terme officiel latin en forme courte';
                   // English
  bbShortOFFENFR   = 'Terme officiel anglais en forme courte équivalent du ' +
                     'terme latin officiel';
                   // French
  bbShortOFFFRFR   = 'Terme officiel français en forme courte équivalent du ' +
                     'terme latin officiel';
                   // Spanish
  bbShortOFFSPFR   = 'Terme officiel espagnol en forme courte équivalent du ' +
                     'terme latin officiel';

                   // Name of division
  cDivNameInf      = 'ChildInf';
  cDivNameTax      = 'ChildTax';
  cDivNamePart     = 'ChildPar';

                   {  }
  Expansion        = True;
  HtmlExt          = 'htm';
  XmlExt           = 'xml';
  TextExt          = 'txt';
  TATopPos         = 7973;
  NoSelectionText  = 'no selection';
  cEncoding        = '<?xml version="1.0" encoding="utf-8"?>';

                   // English
  scNavListEN      = 'List navigation';
  scStatListEN     = 'List statistics';
  scLanguageITEN   = 'Italian terms';
  scLanguageGEEN   = 'German terms';
  scLanguagePTEN   = 'Portugese terms';
  scDefinitionEN   = 'Taxonomic definition';
  scDesignTermEN   = 'Latin model';
  scLatinTermEN    = 'Analysis of words';
  scLatinSyntaxEN  = 'Syntax analysis of term';
  scLatinDeclEN    = 'Declension of words';
  scPartLEN        = 'Partonomy list';
  scPart98EN       = 'TA98 partonomy list';
  scTaxLEN         = 'Taxonomy list';
  scValidUnivEN    = 'Universal validation';
  scNoteUnivEN     = 'Universal notes list';
  scValidPartEN    = 'Validation of terms';
  scValidFormulaEN = 'Validation of universal formulas';
  scValidVocabEN   = 'Validation of multilingual vocabulary';
                   // French
  scNavListFR      = 'Navigation intra liste';
  scStatListFR     = 'Statistiques de liste';
  scLanguageITFR   = 'Termes italiens';
  scLanguageGEFR   = 'Termes allemands';
  scLanguagePTFR   = 'Termes portugais';
  scDefinitionFR   = 'Définition taxonomique';
  scDesignTermFR   = 'Modélisation latine';
  scLatinTermFR    = 'Analyse des mots';
  scLatinSyntaxFR  = 'Analyse syntaxique';
  scLatinDeclFR    = 'Déclinaison des mots';
  scPartLFR        = 'Liste partonomique';
  scPart98FR       = 'Liste partonomique TA98';
  scTaxLFR         = 'Liste taxonomique';
  scValidUnivFR    = 'Validation universelle';
  scNoteUnivFR     = 'Liste de notes universelles';
  scValidPartFR    = 'Validation des termes';
  scValidFormulaFR = 'Validation des formules universelles';
  scValidVocabFR   = 'Validation du vocabulaire multilingue';
                   // Generic access
  scNavList:       array[ tDisLang ] of String =
                   ( scNavListEN, scNavListFR );
  scStatList:      array[ tDisLang ] of String =
                   ( scStatListEN, scStatListFR );
  scLanguageIT:    array[ tDisLang ] of String =
                   ( scLanguageITEN, scLanguageITFR );
  scLanguageGE:    array[ tDisLang ] of String =
                   ( scLanguageGEEN, scLanguageGEFR );
  scLanguagePT:    array[ tDisLang ] of String =
                   ( scLanguagePTEN, scLanguagePTFR );
  scDefinition:    array[ tDisLang ] of String =
                   ( scDefinitionEN, scDefinitionFR );
  scDesignTerm:    array[ tDisLang ] of String =
                   ( scDesignTermEN, scDesignTermFR );
  scLatinTerm:     array[ tDisLang ] of String =
                   ( scLatinTermEN, scLatinTermFR );
  scLatinSyntax:   array[ tDisLang ] of String =
                   ( scLatinSyntaxEN, scLatinSyntaxFR );
  scLatinDecl:     array[ tDisLang ] of String =
                   ( scLatinDeclEN, scLatinDeclFR );
  scPartL:         array[ tDisLang ] of String =
                   ( scPartLEN, scPartLFR );
  scPart98:        array[ tDisLang ] of String =
                   ( scPart98EN, scPart98FR );
  scTaxL:          array[ tDisLang ] of String =
                   ( scTaxLEN, scTaxLFR );
  scValidUniv:     array[ tDisLang ] of String =
                   ( scValidUnivEN, scValidUnivFR );
  scNoteUniv:      array[ tDisLang ] of String =
                   ( scNoteUnivEN, scNoteUnivFR );
  scValidPart:     array[ tDisLang ] of String =
                   ( scValidPartEN, scValidPartFR );
  scValidFormula:  array[ tDisLang ] of String =
                   ( scValidFormulaEN, scValidFormulaFR );
  scValidVocab:    array[ tDisLang ] of String =
                   ( scValidVocabEN, scValidVocabFR );

                   // Bubbles for titles of section by interface language
                   // English
  bsNavListEN      = 'Links for navigation between partial lists.';
  bsStatListEN     = 'Statistical analysis of the entities of the list.';
  bsLanguageITEN   = 'All terms for actual entity in Italian';
  bsLanguageGEEN   = 'All terms for actual entity in German';
  bsLanguagePTEN   = 'All terms for actual entity in Portugese';
  bsDefinitionEN   = 'The taxonomic definition applicable to the actual entity';
  bsDesignTermEN   = 'Modelisation of the Latin term with dependencies on ' +
                     'other entities';
  bsLatinTermEN    = 'Syntactic analysis of all lexemes present in the term';
  bsLatinSyntaxEN  = 'Global syntactic analysis of the term';
  bsLatinDeclEN    = 'All declensions of words at nominative and genitive, ' +
                     'singular and plural';
  bsPartLEN        = 'Partonomy list of descendants of the specified entity';
  bsPart98EN       = 'TA98 partonomy list of descendants of the specified entity';
  bsTaxLEN         = 'Taxonomy list of descendants of the specified entity';
  bsSignatureEN    = 'Signature of a list and statistics';
  bsValidUnivEN    = 'Universal validation of descendants of the specified ' +
                     'entity';
  bsNoteScientEN   = 'Scientific note list regarding the above hierarchy';
  bsNoteUnivEN     = 'Universal note list regarding the above hierarchy';
  bsValidPartEN    = 'Validation of terms with display of inquiries ' +
                     'and related actions';
  bsValidFormulaEN = 'Validation of formulas for existence, conformity and ' +
                     'completion';
  bsValidVocabEN   = 'Validation of vocabulary of the present list in all ' +
                     'languages';
                   // French
  bsNavListFR      = 'Liens pour la navigation entre listes partielles.';
  bsStatListFR     = 'Analyse statistique des entités de la liste.';
  bsLanguageITFR   = 'Tous les termes de la présente entité en italien';
  bsLanguageGEFR   = 'Tous les termes de la présente entité en allemand';
  bsLanguagePTFR   = 'Tous les termes de la présente entité en portugais';
  bsDefinitionFR   = 'La définitions taxonomique applicable à la présente ' +
                     'entité';
  bsDesignTermFR   = 'Modélisation du terme latin avec dépendances à ' +
                     'd''autres entités';
  bsLatinTermFR    = 'Analyse syntaxique de tous les lexèmes présents dans ' +
                     'le terme';
  bsLatinSyntaxFR  = 'Analyse syntaxique globale du terme';
  bsLatinDeclFR    = 'Toutes les déclinaison des mots, au nominatif et au ' +
                     'genitif, singulier et pluriel';
  bsPartLFR        = 'Liste partonomique des descendants de l''entité ' +
                     'spécifiée.';
  bsPart98FR       = 'Liste partonomique TA98 des descendants de l''entité ' +
                     'spécifiée.';
  bsTaxLFR         = 'Liste taxonomique des descendants de l''entité ' +
                     'spécifiée.';
  bsSignatureFR    = 'Signature de liste et statistiques.';
  bsValidUnivFR    = 'Validation universelle des descendants de l''entité ' +
                     'spécifiée.';
  bsNoteScientFR   = 'Liste de notes scientifiques concernant la hiérarchie ' +
                     'ci-dessus.';
  bsNoteUnivFR     = 'Liste de notes universelles concernant la hiérarchie ' +
                     'ci-dessus.';
  bsValidPartFR    = 'Validation des termes avec affichage des enquêtes et ' +
                     'actions relatives.';
  bsValidFormulaFR = 'Validation des formules en existence, conformité et ' +
                     'complétude.';
  bsValidVocabFR   = 'Validation du vocabulaire de la présente liste dans ' +
                     'toutes les langues.';
                   // Generic access
  bsNavList:       array[ tDisLang ] of String =
                   ( bsNavListEN, bsNavListFR );
  bsStatList:      array[ tDisLang ] of String =
                   ( bsStatListEN, bsStatListFR );
  bsLanguageIT:    array[ tDisLang ] of String =
                   ( bsLanguageITEN, bsLanguageITFR );
  bsLanguageGE:    array[ tDisLang ] of String =
                   ( bsLanguageGEEN, bsLanguageGEFR );
  bsLanguagePT:    array[ tDisLang ] of String =
                   ( bsLanguagePTEN, bsLanguagePTFR );
  bsDefinition:    array[ tDisLang ] of String =
                   ( bsDefinitionEN, bsDefinitionFR );
  bsDesignTerm:    array[ tDisLang ] of String =
                   ( bsDesignTermEN, bsDesignTermFR );
  bsLatinTerm:     array[ tDisLang ] of String =
                   ( bsLatinTermEN, bsLatinTermFR );
  bsLatinSyntax:   array[ tDisLang ] of String =
                   ( bsLatinSyntaxEN, bsLatinSyntaxFR );
  bsLatinDecl:     array[ tDisLang ] of String =
                   ( bsLatinDeclEN, bsLatinDeclFR );
  bsPartL:         array[ tDisLang ] of String =
                   ( bsPartLEN, bsPartLFR );
  bsPart98:        array[ tDisLang ] of String =
                   ( bsPart98EN, bsPart98FR );
  bsTaxL:          array[ tDisLang ] of String =
                   ( bsTaxLEN, bsTaxLFR );
  bsSignature:     array[ tDisLang ] of String =
                   ( bsSignatureEN, bsSignatureFR );
  bsValidUniv:     array[ tDisLang ] of String =
                   ( bsValidUnivEN, bsValidUnivFR );
  bsNoteScient:    array[ tDisLang ] of String =
                   ( bsNoteScientEN, bsNoteScientFR );
  bsNoteUniv:      array[ tDisLang ] of String =
                   ( bsNoteUnivEN, bsNoteUnivFR );
  bsValidPart:     array[ tDisLang ] of String =
                   ( bsValidPartEN, bsValidPartFR );
  bsValidFormula:  array[ tDisLang ] of String =
                   ( bsValidFormulaEN, bsValidFormulaFR );
  bsValidVocab:    array[ tDisLang ] of String =
                   ( bsValidVocabEN, bsValidVocabFR );

                   // Page headers by display language
                   // English
  heValidPart4EN   = 'Validation, partonomy level 4';
  heValidTax4EN    = 'Validation, taxonomy level 4';
  heValidPart3EN   = 'Validation, partonomy level 3';
  heValidTax3EN    = 'Validation, taxonomy level 3';
                   // French
  heValidPart4FR   = 'Validation, partonomie niveau 4';
  heValidTax4FR    = 'Validation, taxonomie niveau 4';
  heValidPart3FR   = 'Validation, partonomie niveau 3';
  heValidTax3FR    = 'Validation, taxonomie niveau 3';
                   // Access by language
  heValidPart4:    array[ tDisLang ] of String =
                   ( heValidPart4EN, heValidPart4FR );
  heValidTax4:     array[ tDisLang ] of String =
                   ( heValidTax4EN, heValidTax4FR );
  heValidPart3:    array[ tDisLang ] of String =
                   ( heValidPart3EN, heValidPart3FR );
  heValidTax3:     array[ tDisLang ] of String =
                   ( heValidTax3EN, heValidTax3FR );

                   { * English bubble texts * }
  bbHelpOnPageEN   = 'Help on the this Page';
  bbBilatTextEN    = 'Bilateral generic entity with left and right children';
  bbPaireTextEN    = 'Pair of symmetrical entities';
  bbMultiTextEN    = 'Composite entity which is a set or a pair set';
  bbMaterTextEN    = 'Material entity having a mass';
  bbSpeciTextEN    = 'Specific entity being a leaf in the taxonomy';
  bbGenerTextEN    = 'Generator entity for pairs, sets and pairs of sets';
  bbReferTextEN    = 'Entity from another location locally referenced';
  bbGenderTextEN   = 'Gender-specific entity (male or female)';
  bbMaleTextEN     = 'Entity instanciated for male gender only';
  bbFemaleTextEN   = 'Entity instanciated for female gender only';
  bbInconsTextEN   = 'Variant entity (inconstant structure)';
  bbExpandTextEN   = 'Expanded term created for uniqueness or clarity';
  bbImmatTextEN    = 'Immaterial physical entity (lacking mass, having a dimension)';
  bbNonPhysTextEN  = 'Non physical entity';
  bbDimorphicTextEN= 'Sexually dimorphic physical entity';
  bbProblemTextEN  = 'A problem is associated to this entity';
  bbNbEntriesEN    = 'Count of entries in the table';
  bbNbNotesEN      = 'Count of notes displayed at bottom of the page';
  bbNbTermsEN      = 'Count of terms in the table';
  bbNbEntityEN     = 'Count of entities in the table';
  bbNbSectionsEN   = 'Count of sections in the table';
  bbNbSubChapsEN   = 'Count of subchapters in the table';
  bbNbLinesEN      = 'Number of lines in the table';
  bbDateGenerEN    = 'Date when this page has been generated';
  bbPartialCodeEN  = 'Partial code of TA defining the hierarchy';
  bbPartTitleEN    = 'Hierarchy title (in English in bubble)';
  bbStatEntriesEN  = 'Number of entries in the hierarchy entity';
  bbStatRefsEN     = 'Number of references in the hierarchy entity';
  bbStatUpdatesEN  = 'Number of updates in the hierarchy entity';
  bbBaseLAEN       = 'Formal base term when different from the official term';
  bbAnalyzedLAEN   = 'The Latin term which is analyzed';
  bbOffLAEN        = 'Unique Latin official term as agreed by IFAA';
  bbShortLAEN      = 'Short official term (not necessary unique)';
  bbIntLAEN        = 'Intrinsic part of preferred term';
  bbModelLAEN      = 'Latin term selected for universal model';
  bbOfficialLAEN   = 'An synonym officially validated';
  bbExpOfficialLAEN= 'An exact synonym officially validated with expansion';
  bbExpSynonymLAEN = 'A trivial synonym with expansion, for documentation and retrieval';
  bbEponymLAEN     = 'A Latin eponym, for documentation and retrieval';
  bbAuthorLAEN     = 'An author who has given his name to an anatomical entity';
  bbAcronymLAEN    = 'A Latin acronym, for documentation and retrieval';
  bbDisplayLAEN    = 'A display term, simplified synonym of preferred term';
  bbPluralLAEN     = 'A plural term for sets only';
  bbShortDisplayLAEN = 'A short display term, simplified synonym of short official term';
  bbDisplayRATLAEN = 'A display term, simplified synonym of traditional term';
  bbNOSLAEN        = 'A NOS term, not otherwise specified';
  bbInternalLAEN   = 'A internal database term partly in Latin';
  bbBasleLAEN      = 'The related term of BNA as published in 1916';
  bbVocabularyLAEN = 'The related Latin vocabulary induced by the current unit';
  bbVocabularyENEN = 'The related English vocabulary induced by the current unit';
  bbVocabularyFREN = 'The related French vocabulary induced by the current unit';
  bbVocabularySPEN = 'The related Spanish vocabulary induced by the current unit';
  bbVocabularyRUEN = 'The related Russian vocabulary induced by the current unit';
  bbAutoBaseLAEN   = 'An autogenerated stored base term in Latin';
  bbAutoBaseENEN   = 'An autogenerated stored base term in English';
  bbAutoBaseFREN   = 'An autogenerated stored base term in French';
  bbShortModelFREN = 'A removed short base term in French replaced by a Latin model generation';
  bbFullModelFREN  = 'A removed full base term in French replaced by a Latin model generation';
  bbAutoDisLAEN    = 'An autogenerated stored display term in Latin';
  bbAutoDisENEN    = 'An autogenerated stored display term in English';
  bbAutoDisFREN    = 'An autogenerated stored display term in French';
  bbDeprecLAEN     = 'A Latin depreciated term, which should not to be used anymore';
  bbGenitiveLAEN   = 'The Latin genitive form of the official term, used for expansion';
  bbOriginalLAEN   = 'The TA98 Latin preferred term, official term in this version';
  bbNonRATLAEN     = 'An irregular term, non compliant to the RAT rules';
  bbAlternateLAEN  = 'Official synonym in TA98 version';
  bbInitialLAEN    = 'A TA98 Latin precursor term, which initially was the preferred term or official synonym';
  bbBaseENEN       = 'Short version of English equivalent';
  bbAnalyzedENEN   = 'Unique English term which is analyzed';
  bbEquivENEN      = 'The language equivalent in conformity to the Latin official term';
  bbIntENEN        = 'Intrinsic part of preferred term';
  bbUniversalEN    = 'Language term generated from the universal formula';
  bbFMAEN          = 'The official term of the Foundational Model of Anatomy';
  bbOfficialENEN   = 'An official English synonym officially validated';
  bbExpOfficialENEN= 'An official English synonym officially validated with expansion';
  bbSynonymENEN    = 'A trivial English synonym, for documentation and retrieval';
  bbExpSynonymENEN = 'A trivial English synonym with expansion, for documentation and retrieval';
  bbEponymENEN     = 'A English eponym, for documentation and retrieval';
  bbAuthorENEN     = 'Author of eponym, who has given his name to an anatomical entity';
  bbAcronymENEN    = 'A English acronym, for documentation and retrieval';
  bbDisplayENEN    = 'A English display term, simplified synonym of preferred term';
  bbDeprecENEN     = 'An English depreciated term, which should not to be used anymore';
  bbGenitiveENEN   = 'The genitive form of the official English equivalent, used for expansion';
  bbOriginalENEN   = 'A TA98 English equivalent (Terminologia Anatomica Thieme 1998)';
  bbOriginalFREN   = 'A TA98 French equivalent (multiple sources)';
  bbOriginalSPEN   = 'A TA98 Spanish equivalent (Wikiproyecto: Anatomía Humana/Terminología Anatómica)';
  bbOriginalRUEN   = 'A TA98 Russian equivalent (Kolesnikov version 07.05.2006)';
  bbAlternateENEN  = 'A TA98 English synonym';
  bbInitialENEN    = 'A TA98 English precursor source term';
  bbBaseFREN       = 'Short version of French equivalent';
  bbBaseSPEN       = 'Short version of Spanish equivalent';
  bbBaseRUEN       = 'Short version of Russian equivalent';
  bbBaseITEN       = 'Short version of Italian equivalent';
  bbBaseGEEN       = 'Short version of German equivalent';
  bbBasePTEN       = 'Short version of Portugese equivalent';
  bbEquivFREN      = 'The French equivalent as selected by the authors of this language';
  bbEquivSPEN      = 'The Spanish equivalent as selected by the authors of this language';
  bbEquivRUEN      = 'The Russian equivalent as selected by the authors of this language';
  bbEquivITEN      = 'The Italian equivalent as selected by the authors of this language';
  bbEquivGEEN      = 'The German equivalent as selected by the authors of this language';
  bbEquivPTEN      = 'The Portugese equivalent as selected by the authors of this language';
  bbExpLAEN        = 'The unique Latin base term';
  bbExpENEN        = 'The unique English base term';
  bbExpFREN        = 'The unique French base term';
  bbExpSPEN        = 'The unique Spanish base term';
  bbExpRUEN        = 'The unique Russian base term';
  bbIntFREN        = 'Intrinsic part of preferred term';
  bbOfficialFREN   = 'An exact French synonym equivalent officially validated';
  bbOfficialSPEN   = 'An exact Spanish synonym equivalent officially validated';
  bbOfficialRUEN   = 'An exact Russian synonym equivalent officially validated';
  bbOfficialITEN   = 'An exact Italian synonym equivalent officially validated';
  bbOfficialGEEN   = 'An exact German synonym equivalent officially validated';
  bbOfficialPTEN   = 'An exact Portugese synonym equivalent officially validated';
  bbExpOfficialFREN= 'An exact French synonym equivalent officially validated with expansion';
  bbExpOfficialSPEN= 'An exact Spanish synonym equivalent officially validated with expansion';
  bbSynonymFREN    = 'A trivial French synonym, for documentation and retrieval';
  bbExpSynonymFREN = 'A trivial French synonym with expansion, for documentation and retrieval';
  bbEponymFREN     = 'A French eponym, for documentation and retrieval';
  bbAuthorFREN     = 'Auteur';
  bbAcronymFREN    = 'A French acronym, for documentation and retrieval';
  bbDisplayFREN    = 'A French display term, simplified synonym of preferred term';
  bbDeprecFREN     = 'A French depreciated term, which should not to be used anymore';
  bbGenitiveFREN   = 'The genitive form of the official French equivalent, used for expansion';
  bbTACodeBubbleEN = 'Reference ID (11-digit TA code in bubble)';
  bbRefIDBubbleEN  = '11-digit TA code (reference ID in bubble)';
  bbCatTerm        = 'Category of synonym term';
  bbSourceTerm     = 'Source or author of the synonym term';
  bbExpandID       = 'TID for expansion of the synonym term';
  bbLanguageID     = 'Unique language identifier of the synonym term';
  bbMultinlingualEN= 'Synonym term in any language';
  bbKwicTermEN     = 'Key Word In Context (KWIC) permuted term';
  bbAltTermEN      = 'same term in alternate language';
  bbTaxDefEN       = 'The genus for this definition has been automaticaly generated from the taxonomy';
  bbNavigToUnitEN  = 'Link to the unit containing the present entity';
  bbAlterEntityEN  = 'Links to the non lateral entities belonging to the present unit';
  bbLaterEntityEN  = 'Links to the lateral entities belonging to the present unit';
  bbNavigEntityEN  = 'Links to other pages specific of the present entity';
  bbUnitTypeEN     = 'The type of the present unit: single, set, pair or pset';
                   { * French bubble texts * }
  bbHelpOnPageFR   = 'Aide pour cette page';
  bbBilatTextFR    = 'Entité bilatérale avec instances gauche et droite';
  bbPaireTextFR    = 'Entité symmétrique';
  bbMultiTextFR    = 'Entité composite sous forme d''ensemble ou de paire d''ensembles';
  bbMaterTextFR    = 'Entité physique matérielle ayant une masse';
  bbSpeciTextFR    = 'Entité spécifique feuille de la taxonomie';
  bbGenerTextFR    = 'Entité générateur de paires, d''ensembles ou de paires d''ensembles';
  bbReferTextFR    = 'Entité en une autre position référencée localement';
  bbGenderTextFR   = 'Entité spécifique par le genre (masculin ou féminin)';
  bbMaleTextFR     = 'Entité instanciable pour le genre masculin seulement';
  bbFemaleTextFR   = 'Entité instanciable pour le genre féminin seulement';
  bbInconsTextFR   = 'Entité variable (structure inconstante)';
  bbExpandTextFR   = 'Terme expansé (pour raisons d''unicité ou de clarté)';
  bbImmatTextFR    = 'Entité physique immatérielle sans masse, avec dimension';
  bbNonPhysTextFR  = 'Entité non physique';
  bbDimorphicTextFR= 'Entité sexuellement dimorphique';
  bbProblemTextFR  = 'Un problème est associé à cette entité';
  bbNbEntriesFR    = 'Décompte des lignes dans le tableau';
  bbNbNotesFR      = 'Décompte des notes affichées en bas de page';
  bbNbEntityFR     = 'Décompte des entités dans la table';
  bbNbTermsFR      = 'Décompte des termes dans la table';
  bbNbSectionsFR   = 'Décompte des sections dans le tableau';
  bbNbSubChapsFR   = 'Décompte des sous-chapitres dans le tableau';
  bbNbLinesFR      = 'Décompte des lignes en français dans le tableau';
  bbDateGenerFR    = 'Date à laquelle cette page a été générée';
  bbPartialCodeFR  = 'Code partiel TA définissant la hiérarchie';
  bbPartTitleFR    = 'Titre de la hiérarchie TA';
  bbStatEntriesFR  = 'Nombre d''entrées dans cette position hiérarchique';
  bbStatRefsFR     = 'Nombre de références dans cette position hiérarchique';
  bbStatUpdatesFR  = 'Nombre de revisions dans cette position hiérarchique';
  bbTACodeBubbleFR = 'ID de référence (code TA à 11 chiffres en bulle)';
  bbCatTermFR      = 'Catégorie du terme synonyme';
  bbSourceTermFR   = 'Source ou auteur du terme synonyme';
  bbExpandIDFR     = 'TID pour expansion du terme synonyme';
  bbLanguageIDFR   = 'Identificateur unique par language du terme synonyme';
  bbMultinlingualFR= 'Terme synonyme en tout langage (expansion en bulle)';
  bbKwicTermFR     = 'Terme permuté selon Key Word In Context (KWIC)';
  bbTaxDefFR       = 'Le genus de cette définition a été généré automatiquement à partir de la taxonomie';
  bbNavigToUnitFR  = 'Lien vers l''unité qui contient la présente entité';
  bbAlterEntityFR  = 'Liens vers les entités non latérales appartenant à la présente unité';
  bbLaterEntityFR  = 'Liens vers les entités latérales appartenant à la présente unité';
  bbNavigEntityFR  = 'Liens vers d''autres pages spécifiques à l''entité présente';
  bbUnitTypeFR     = 'Le type de la présente unité: simple, ensemble, paire ou spaire';

                   { * English bubble texts for sections * }
  bbPartLEN        = 'Partonomy list of descendants of the specified entity';
  bbTaxLEN         = 'Taxonomy list of descendants of the specified entity';
  bbDirTEN         = 'List of main direction terms applied in anatomy';
  bbRefPEN         = 'List of reference planes for the human body';
  bbRefLEN         = 'List of reference lines for the human body';
  bbMovJEN         = 'List of joint movements allowed in the human body';
  bbTA98NavigEN    = 'TA98 list tree for navigation between lists.';
  bbTA98ListEN     = 'TA98 list of all entities and their new definitions.';
  bbNavigationEN   = 'Navigation based on entities of the unit and links to ' +
                     'hierarchical lists.';
  bbNavig4EN       = 'Navigation based on level 4.';
  bbL4EN           = 'List of tetrahedrons at level 4';
  bbL5ShortEN      = 'Short list of tetrahedrons at level 5';
  bbL5FullEN       = 'Full list of entities at level 5';
  bbTaxDefListEN   = 'List of definitions for the taxonomic subtree of entity.';
  bbPartDefListEN  = 'List of definitions for the partonomic subtree of entity.';
  bbTACodeEN       = 'TA98 11-digit code or closest related code';
  bbTIDEN          = 'Unique ID number of an anatomical entity';
  bbTetraTIDEN     = 'Unique ID number of an anatomical unit';
  bbFMAIDEN        = 'Unique FMA corresponding identifier';
  bbWordRefEN      = 'Reference word at nominative, masculine, singular';
  bbSortingEN      = 'Word on which the entries of this page are sorted';
  bbGenericEN      = 'A generic class groups words corresponding to a common entity';
  bbEntityTypeEN   = 'Type of entity: specificity, materiality, multiplicity, physicality';
  bbCardinalityEN  = 'Cardinality: estimate of number of entities in a composite entity';
  bbGeneratorEN    = 'Name of generator entity for paired or composite entity';
  bbGenForEN       = 'Name of generated entity for paired or composite entity';
  bb2LanguageEN    = 'All terms for actual entity in Latin and English';
  bbModelTermEN    = 'Composition of a raw term into units of meaning.';
  bbTransTermEN    = 'Translation of a term: ajustable parameters';
  bbTreeFormulaEN  = 'Universal formula of the term in a tree presentation';
  bbConcordanceEN  = 'Table of concordance between Latin and target language';
  bbDisplayTransEN = 'Final translation corresponding to the parameter setting';
  bbAutoTermEN     = 'Automatic translation of the term in Latin, English and French';
  bbPropertyEN     = 'Single valued properties';
  bbLinkageEN      = 'Bivalued linkages between TA entities outside the ' +
                     'hierarchical links';
  bbSequenceEN     = 'Ordered sequences of anatomical entities';
  bbDocumEN        = 'Documentation available on actual entity';
  bbBrotherEN      = 'Entities with the same father node';
  bbSEQTitleEN     = 'Title of the sequence';
  bbSEQDescrEN     = 'Full description of the sequence';
  bbEncyclopedicEN = 'General definition as found in encyclopedia';
  bbLinkedEN       = 'Encyclopedic definition with explicite links to other ' +
                     'anatomical entities';
  bbTaxonomicEN    = 'Definition based on genus and differentia from taxonomy';
  bbSpatialEN      = 'Definition based on location in the human body';
  bbFunctionalEN   = 'Functional definition with functional and temporal parts';
  bbHistologicalEN = 'Definition based on histological structure of tissue';
  bbPhysicalEN     = 'Definition made of physical parameters and measurements';
  bbNoteEN         = 'All notes relative to the actual entity.';
  bbTA98NoteEN     = 'End of page note from the TA98 original version';
  bbErrorNoteEN    = 'Correction concerning the TA98 original version';
  bbRATNoteEN      = 'Correction concerning the TA98 non-compliant RAT terms';
  bbRedirNoteEN    = 'Redirection of an entity to another';
  bbProblemNoteEN  = 'Unresolved problem concerning the TA98 original version';
  bbRevisionNoteEN = 'Revision note for the transition before RevTermA';
  bbRvNoteEN       = 'Revision note for RevTermA';
  bbTnNoteEN       = 'Terminology note indicating the presence of conflict ' +
                     'with the prevalent terminological rules';
  bbTxNoteEN       = 'Note of change of the taxonomy';
  bbScNoteEN       = 'Note referring to the scientific litterature.';
  bbImplNoteEN     = 'Note concerning the implementation of the database.';
  bbTraNoteEN      = 'Note concerning the translation of TA in alternate ' +
                     'languages.';
  bbPartUnitEN     = 'The partitive hierarchy for the specific entity of the ' +
                     'unit.';
  bbPartonomyEN    = 'The partitive hierarchy for the actual entity.';
  bbInferredEN     = 'The inferred hierarchy for the actual entity';
  bbTaxUnitEN      = 'The taxonomic hierarchy for the generic entity of the ' +
                     'unit.';
  bbTaxonomyEN     = 'The taxonomic hierarchy for the actual entity.';
  bbAutoPairEN     = 'An autogenerated definition for the members of a ' +
                     'symmetrical pair.';

                   { * French bubble texts for sections * }
  bbDirTFR         = 'Liste des orientations dans l''espace applicables en anatomie.';
  bbRefPFR         = 'Liste des plans de reference pour le corps humain.';
  bbRefLFR         = 'Liste des lignes de reference pour le corps humain.';
  bbMovJFR         = 'Liste des mouvements des articulations permises dans le corps humain.';
  bbTA98NavigFR    = 'Arbre des listes TA98 pour navigation entre les listes.';
  bbTA98ListFR     = 'Liste TA98 de toutes les entités et leurs nouvelles valeurs.';
  bbNavigationFR   = 'Navigation basée sur les entités de l''unité et sur ' +
                     'des listes hiérarchiques.';
  bbNavig4FR       = 'Navigation basée sur le niveau 4.';
  bbL4FR           = 'Liste de tétraèdres au niveau 4';
  bbL5ShortFR      = 'Liste courte de tétraèdres au niveau 5';
  bbL5FullFR       = 'Liste complète d''entités au niveau 5';
  bbTaxDefListFR   = 'Liste de définitions pour l''arbre taxonomique de l''entité';
  bbPartDefListFR  = 'Liste de définitions pour l''arbre partonomique de l''entité';
  bbTACodeFR       = 'Code TA98 à 11 chiffres ou code relatif le plus proche';
  bbTIDFR          = 'Identificateur unique d''entité anatomique';
  bbTetraTIDFR     = 'Identificateur unique d''unité anatomique';
  bbFMAIDFR        = 'Unique identificateur FMA correspondant';
  bbWordRefFR      = 'Mot de référence au nominatif, masculin, singulier';
  bbGenericFR      = 'Une classe générique groupe des mots se rapportant à une entité commune';
  bbEntityTypeFR   = 'Type d''entité: spécificité, matérialité, multiplicité, physicalité';
  bbCardinalityFR  = 'Cardinalité: estimation du nombre d''entités dans une entité composite';
  bbGeneratorFR    = 'Nom du l''entité génératrice de l''entité paire ou composite';
  bbGenForFR       = 'Nom du l''entité paire ou composite générée';
  bbBaseLAFR       = 'Terme de base formel si différent du terme officiel';
  bbExpLAFR        = 'Le terme de base unique';
  bbOffLAFR        = 'Le terme latin officiel unique agréé par IFAA';
  bbShortLAFR      = 'Le terme officiel court (pas nécessairement unique)';
  bbIntLAFR        = 'Partie intrinsèque du terme préféré';
  bbModelLAFR      = 'Terme latin sélectionné pour le modèle universelle';
  bbOfficialLAFR   = 'Synonyme latin exact officiellement validé';
  bbExpOfficialLAFR= 'Synonyme latin exact officiellement validé avec expansion';
  bbExpSynonymLAFR = 'Synonyme latin trivial avec expansion, pour la documentation et la recherche seulement';
  bbEponymLAFR     = 'Eponyme latin, pour la documentation et la recherche seulement';
  bbAuthorLAFR     = 'Auteur';
  bbAcronymLAFR    = 'Acronyme latin, pour la documentation et la recherche seulement';
  bbDisplayLAFR    = 'Terme d''affichage, version simplifiée du terme préféré';
  bbPluralLAFR     = 'Terme pluriel pour les ensembles seulement';
  bbShortDisplayLAFR = 'Terme d''affichage court, version simplifiée du terme officiel court';
  bbDisplayRATLAFR = 'Terme d''affichage, version simplifiée du terme traditionnel';
  bbNOSLAFR        = 'Terme NOS latin, de latéralité non spécifiée par ailleurs';
  bbInternalLAFR   = 'Terme latin interne à la base de donnée';
  bbBasleLAFR      = 'Terme relatif en latin de la BNA publiée en 1916';
  bbVocabularyLAFR = 'Le vocabulaire latin induit par la présente unité';
  bbVocabularyENFR = 'Le vocabulaire anglais induit par la présente unité';
  bbVocabularyFRFR = 'Le vocabulaire français induit par la présente unité';
  bbVocabularySPFR = 'Le vocabulaire espagnol induit par la présente unité';
  bbVocabularyRUFR = 'Le vocabulaire russe induit par la présente unité';
  bbAutoBaseLAFR   = 'Terme latin de base autogénéré et stoqué';
  bbAutoBaseENFR   = 'Terme anglais de base autogénéré et stoqué';
  bbAutoBaseFRFR   = 'Terme français de base autogénéré et stoqué';
  bbShortModelFRFR = 'Terme français court retiré en faveur d''un terme autogénéré selon modèle Latin';
  bbFullModelFRFR  = 'Terme français long retiré en faveur d''un terme autogénéré selon modèle Latin';
  bbAutoDisLAFR    = 'Terme latin de display autogénéré et stoqué';
  bbAutoDisENFR    = 'Terme anglais de display autogénéré et stoqué';
  bbAutoDisFRFR    = 'Terme français de display autogénéré et stoqué';
  bbDeprecLAFR     = 'Terme déprécié latin, à ne plus utiliser';
  bbGenitiveLAFR   = 'Forme génitive latine du terme officiel, pour l''expansion';
  bbOriginalLAFR   = 'Précurseur latin TA98, terme officiel dans cette version';
  bbNonRATLAFR     = 'Terme irrégulier qui ne satisfait pas aux règles RAT';
  bbAlternateLAFR  = 'Synonyme officiel latin TA98 dans cette version';
  bbInitialLAFR    = 'Un terme présurseur latin, qui initialement était le terme preféré ou un synonyme officiel';
  bbBaseENFR       = 'Version courte du terme équivalent anglais';
  bbExpENFR        = 'Version unique du terme de base anglais';
  bbEquivENFR      = 'Terme équivalent du language conforme au terme latin officiel';
  bbIntENFR        = 'Partie intrinsèque du terme préféré';
  bbUniversalFR    = 'Terme du langage généré à partir de la formule universelle';
  bbFMAFR          = 'Le terme officiel du Foundational Model of Anatomy';
  bbOfficialENFR   = 'Synonyme anglais exact officiellement validé';
  bbExpOfficialENFR= 'Synonyme anglais exact officiellement validé avec expansion';
  bbSynonymENFR    = 'Synonyme anglais trivial, pour la documentation et la recherche seulement';
  bbExpSynonymENFR = 'Synonyme anglais trivial avec expansion, pour la documentation et la recherche seulement';
  bbEponymENFR     = 'Eponyme anglais, pour la documentation et la recherche seulement';
  bbAuthorENFR     = 'Auteur';
  bbAcronymENFR    = 'Acronyme anglais, pour la documentation et la recherche seulement';
  bbDisplayENFR    = 'Terme d''affichage anglais, version simplifiée du terme préféré';
  bbDeprecENFR     = 'Terme déprécié anglais, à ne plus utiliser';
  bbGenitiveENFR   = 'Forme génitive anglaise du terme officiel, pour l''expansion';
  bbOriginalENFR   = 'Equivalent anglais de la TA98 (Terminologia Anatomica ' +
                     'Thieme 1998)';
  bbOriginalFRFR   = 'Equivalent français de la TA98 (divers sources)';
  bbOriginalSPFR   = 'Equivalent espagnol de la TA98 (Wikiproyecto: Anatomía ' +
                     'Humana/Terminología Anatómica)';
  bbOriginalRUFR   = 'Equivalent russe de la TA98 (version Kolesnikov ' +
                     '07.05.2006)';
  bbAlternateENFR  = 'Synonyme officiel anglais de la TA98';
  bbInitialENFR    = 'Terme source précurseur de la TA98';
  bbBaseFRFR       = 'Version courte du terme équivalent français';
  bbBaseSPFR       = 'Version courte du terme équivalent espagnol';
  bbBaseRUFR       = 'Version courte du terme équivalent russe';
  bbBaseITFR       = 'Version courte du terme équivalent italien';
  bbBaseGEFR       = 'Version courte du terme équivalent allemand';
  bbBasePTFR       = 'Version courte du terme équivalent portugais';
  bbEquivFRFR      = 'Terme équivalent français en conformité du terme officiel en Latin';
  bbEquivSPFR      = 'Terme équivalent espagnol en conformité du terme officiel en Latin';
  bbEquivRUFR      = 'Terme équivalent russe en conformité du terme officiel en Latin';
  bbEquivITFR      = 'Terme équivalent italien en conformité du terme officiel en Latin';
  bbEquivGEFR      = 'Terme équivalent allemand en conformité du terme officiel en Latin';
  bbEquivPTFR      = 'Terme équivalent portugais en conformité du terme officiel en Latin';
  bbExpFRFR        = 'Terme équivalent français conforme au terme officiel';
  bbExpSPFR        = 'Terme équivalent espagnol conforme au terme officiel';
  bbExpRUFR        = 'Terme équivalent russe conforme au terme officiel';
  bbIntFRFR        = 'Partie intrinsèque du terme préféré';
  bbOfficialFRFR   = 'Synonyme français exact officiellement validé';
  bbOfficialSPFR   = 'Synonyme espagnol exact officiellement validé';
  bbOfficialRUFR   = 'Synonyme russe exact officiellement validé';
  bbOfficialITFR   = 'Synonyme italien exact officiellement validé';
  bbOfficialGEFR   = 'Synonyme allemand exact officiellement validé';
  bbOfficialPTFR   = 'Synonyme portugais exact officiellement validé';
  bbExpOfficialFRFR= 'Synonyme français exact officiellement validé avec expansion';
  bbExpOfficialSPFR= 'Synonyme espagnol exact officiellement validé avec expansion';
  bbSynonymFRFR    = 'Synonyme français trivial, pour la documentation et la recherche seulement';
  bbExpSynonymFRFR = 'Synonyme français trivial avec expansion, pour la documentation et la recherche seulement';
  bbEponymFRFR     = 'Eponyme français, pour la documentation et la recherche seulement';
  bbAuthorFRFR     = 'Auteur';
  bbAcronymFRFR    = 'Acronyme français, pour la documentation et la recherche seulement';
  bbDisplayFRFR    = 'Terme d''affichage français, version simplifiée du terme préféré';
  bbDeprecFRFR     = 'Terme déprécié français, à ne plus utiliser';
  bbGenitiveFRFR   = 'Forme génitive française du terme officiel, pour l''expansion';
  bbPropertyFR     = 'Propriétés mono-valuées';
  bbLinkageFR      = 'Liens bi-valués entre entités de la TA en dehors des ' +
                     'liens hiérarchiques';
  bbSequenceFR     = 'Séquences ordonnées d''entité anatomiques';
  bbDocumFR        = 'Documentation disponible sur l''entité actuelle';
  bbBrotherFR      = 'Entités avec le même noeud père';
  bbSEQTitleFR     = 'Titre de la séquence';
  bbSEQDescrFR     = 'Description exhaustive de la séquence';
  bbEncyclopedicFR = 'Définition générale telle qu''on trouve dans les ' +
                     'dictionnaires ou encyclopédies';
  bbLinkedFR       = 'Definition encyclopédique avec liens explicites aux autres entités anatomiques';
  bbTaxonomicFR    = 'Définition basée sur le paradigme genus et differentia ' +
                     'à partir de la taxonomie';
  bbAutoPairFR     = 'Une définition autogénérée pour les membres d''une paire symmétrique';
  bbSpatialFR      = 'Définition basée sur la localisation dans le corps humain';
  bbFunctionalFR   = 'Définition fonctionelle avec une partie fonctionelle ' +
                     'et une partie temporelle';
  bbHistologicalFR = 'Définition basée sur la structure histologique des tissus';
  bbPhysicalFR     = 'Definition constituée de paramètres et mesures physiques';
  bbNoteFR         = 'Toutes les notes relatives à la présente entité.';
  bbTA98NoteFR     = 'Note de bas de page telle que figurant dans la version TA98';
  bbErrorNoteFR    = 'Note errata concernant la version TA98';
  bbProblemNoteFR  = 'Problème relatif à la version originale TA98';
  bbRedirNoteFR    = 'Redirection d''une entité sur une autre';
  bbRevisionNoteFR = 'Note de transition avant RevTermA';
  bbRvNoteFR       = 'Note de revision RevTermA';
  bbTnNoteFR       = 'Note de terminologie indiquent un désaccord avec les ' +
                     'règles prévalentes usuelles.';
  bbTxNoteFR       = 'Note de changement de la taxonomie';
  bbScNoteFR       = 'Note de référence à la littérature scientifique';
  bbImplNoteFR     = 'Note concernant l''implémentation de la base de données.';
  bbTraNoteFR      = 'Note concernant la traduction dans des languages autres.';
  bbPartUnitFR     = 'La hiérarchie partitive pour l''entité spécifique de ' +
                     'l''unité.';
  bbPartonomyFR    = 'La hiérarchie partitive pour la présente entité.';
  bbInferredFR     = 'La hiérarchie induite latérale de la TAH';
  bbTaxUnitFR      = 'La hiérarchie taxonomique pour l''entité générique de ' +
                     'l''unité.';
  bbTaxonomyFR     = 'La hiérarchie taxonomique pour la présente entité.';
  bbModelTermFR    = 'Composition d''un terme brut en ses unités de sens.';
  bbTransTermFR    = 'Traduction du terme: paramètres ajustables';
  bbTreeFormulaFR  = 'Formule universelle du terme présentée en vue ' +
                     'arborescente';
  bbConcordanceFR  = 'Table de concordance entre le Latin et le language cible';
  bbDisplayTransFR = 'Traduction finale correspondant aux paramètres établis';
  bbAutoTermFR     = 'Traduction automatique en Latin, an glais et français';

                   { * Bilingual bubble texts * }
  bbHelpOnPage:    array[ tDisLang ] of String =
                   ( bbHelpOnPageEN, bbHelpOnPageFR );
  bbDateGener:     array[ tDisLang ] of String =
                   ( bbDateGenerEN, bbDateGenerFR );
  bbBaseLA:        array[ tDisLang ] of String =
                   ( bbBaseLAEN, bbBaseLAFR );
  bbBaseEN:        array[ tDisLang ] of String =
                   ( bbBaseENEN, bbBaseENFR );
  bbBaseFR:        array[ tDisLang ] of String =
                   ( bbBaseFREN, bbBaseFRFR );
  bbBaseSP:        array[ tDisLang ] of String =
                   ( bbBaseSPEN, bbBaseSPFR );
  bbBaseRU:        array[ tDisLang ] of String =
                   ( bbBaseRUEN, bbBaseRUFR );
  bbBaseIT:        array[ tDisLang ] of String =
                   ( bbBaseITEN, bbBaseITFR );
  bbBaseGE:        array[ tDisLang ] of String =
                   ( bbBaseGEEN, bbBaseGEFR );
  bbBasePT:        array[ tDisLang ] of String =
                   ( bbBasePTEN, bbBasePTFR );
  bbExpLA:         array[ tDisLang ] of String =
                   ( bbExpLAEN, bbExpLAFR );
  bbOffLA:         array[ tDisLang ] of String =
                   ( bbOffLAEN, bbOffLAFR );
  bbShortLA:       array[ tDisLang ] of String =
                   ( bbShortLAEN, bbShortLAFR );
  bbExpEN:         array[ tDisLang ] of String =
                   ( bbExpENEN, bbExpENFR );
  bbEquivEN:       array[ tDisLang ] of String =
                   ( bbEquivENEN, bbEquivENFR );
  bbExpFR:         array[ tDisLang ] of String =
                   ( bbExpFREN, bbExpFRFR );
  bbExpSP:         array[ tDisLang ] of String =
                   ( bbExpSPEN, bbExpSPFR );
  bbExpRU:         array[ tDisLang ] of String =
                   ( bbExpRUEN, bbExpRUFR );
  bbEquivFR:       array[ tDisLang ] of String =
                   ( bbEquivFREN, bbEquivFRFR );
  bbEquivSP:       array[ tDisLang ] of String =
                   ( bbEquivSPEN, bbEquivSPFR );
  bbEquivRU:       array[ tDisLang ] of String =
                   ( bbEquivRUEN, bbEquivRUFR );
  bbEquivIT:       array[ tDisLang ] of String =
                   ( bbEquivITEN, bbEquivITFR );
  bbEquivGE:       array[ tDisLang ] of String =
                   ( bbEquivGEEN, bbEquivGEFR );
  bbEquivPT:       array[ tDisLang ] of String =
                   ( bbEquivPTEN, bbEquivPTFR );
  bbIntLA:         array[ tDisLang ] of String =
                   ( bbIntLAEN, bbIntLAFR );
  bbModelLA:       array[ tDisLang ] of String =
                   ( bbModelLAEN, bbModelLAFR );
  bbIntEN:         array[ tDisLang ] of String =
                   ( bbIntENEN, bbIntENFR );
  bbUniversal:     array[ tDisLang ] of String =
                   ( bbUniversalEN, bbUniversalFR );
  bbIntFR:         array[ tDisLang ] of String =
                   ( bbIntFREN, bbIntFRFR );
  bbFMA:           array[ tDisLang ] of String =
                   ( bbFMAEN, bbFMAFR );
  bbDirT:          array[ tDisLang ] of String =
                   ( bbDirTEN, bbDirTFR );
  bbRefP:          array[ tDisLang ] of String =
                   ( bbRefPEN, bbRefPFR );
  bbRefL:          array[ tDisLang ] of String =
                   ( bbRefLEN, bbRefLFR );
  bbMovJ:          array[ tDisLang ] of String =
                   ( bbMovJEN, bbMovJFR );
  bbTA98Navig:     array[ tDisLang ] of String =
                   ( bbTA98NavigEN, bbTA98NavigFR );
  bbTA98List:      array[ tDisLang ] of String =
                   ( bbTA98ListEN, bbTA98ListFR );
  bbNavigation:    array[ tDisLang ] of String =
                   ( bbNavigationEN, bbNavigationFR );
  bbNavig4:        array[ tDisLang ] of String =
                   ( bbNavig4EN, bbNavig4FR );
  bbL4:            array[ tDisLang ] of String =
                   ( bbL4EN, bbL4FR );
  bbL5Short:       array[ tDisLang ] of String =
                   ( bbL5ShortEN, bbL5ShortFR );
  bbL5Full:        array[ tDisLang ] of String =
                   ( bbL5FullEN, bbL5FullFR );
  bbTaxDefList:    array[ tDisLang ] of String =
                   ( bbTaxDefListEN, bbTaxDefListFR );
  bbPartDefList:   array[ tDisLang ] of String =
                   ( bbPartDefListEN, bbPartDefListFR );
  bbTID:           array[ tDisLang ] of String =
                   ( bbTIDEN, bbTIDFR );
  bbTetraTID:      array[ tDisLang ] of String =
                   ( bbTetraTIDEN, bbTetraTIDFR );
  bbTACode:        array[ tDisLang ] of String =
                   ( bbTACodeEN, bbTACodeFR );
  bbFMAID:         array[ tDisLang ] of String =
                   ( bbFMAIDEN, bbFMAIDFR );
  bbEntityType:    array[ tDisLang ] of String =
                   ( bbEntityTypeEN, bbEntityTypeFR );
  bbUnitType:      array[ tDisLang ] of String =
                   ( bbUnitTypeEN, bbUnitTypeFR );
  bbGenerator:     array[ tDisLang ] of String =
                   ( bbGeneratorEN, bbGeneratorFR );
  bbCardinality:   array[ tDisLang ] of String =
                   ( bbCardinalityEN, bbCardinalityFR );
  bbGenFor:        array[ tDisLang ] of String =
                   ( bbGenForEN, bbGenForFR );
  bbOfficialLA:    array[ tDisLang ] of String =
                   ( bbOfficialLAEN, bbOfficialLAFR );
  bbOfficialEN:    array[ tDisLang ] of String =
                   ( bbOfficialENEN, bbOfficialENFR );
  bbOfficialFR:    array[ tDisLang ] of String =
                   ( bbOfficialFREN, bbOfficialFRFR );
  bbOfficialSP:    array[ tDisLang ] of String =
                   ( bbOfficialSPEN, bbOfficialSPFR );
  bbOfficialRU:    array[ tDisLang ] of String =
                   ( bbOfficialRUEN, bbOfficialRUFR );
  bbOfficialIT:    array[ tDisLang ] of String =
                   ( bbOfficialITEN, bbOfficialITFR );
  bbOfficialGE:    array[ tDisLang ] of String =
                   ( bbOfficialGEEN, bbOfficialGEFR );
  bbOfficialPT:    array[ tDisLang ] of String =
                   ( bbOfficialPTEN, bbOfficialPTFR );
  bbExpOfficialLA: array[ tDisLang ] of String =
                   ( bbExpOfficialLAEN, bbExpOfficialLAFR );
  bbExpOfficialEN: array[ tDisLang ] of String =
                   ( bbExpOfficialENEN, bbExpOfficialENFR );
  bbExpOfficialFR: array[ tDisLang ] of String =
                   ( bbExpOfficialFREN, bbExpOfficialFRFR );
  bbExpOfficialSP: array[ tDisLang ] of String =
                   ( bbExpOfficialSPEN, bbExpOfficialSPFR );
  bbDisplayLA:     array[ tDisLang ] of String =
                   ( bbDisplayLAEN, bbDisplayLAFR );
  bbPluralLA:      array[ tDisLang ] of String =
                   ( bbPluralLAEN, bbPluralLAFR );
  bbShortDisplayLA:array[ tDisLang ] of String =
                   ( bbShortDisplayLAEN, bbShortDisplayLAFR );
  bbDisplayRATLA:  array[ tDisLang ] of String =
                   ( bbDisplayRATLAEN, bbDisplayRATLAFR );
  bbNOSLA:         array[ tDisLang ] of String =
                   ( bbNOSLAEN, bbNOSLAFR );
  bbDisplayEN:     array[ tDisLang ] of String =
                   ( bbDisplayENEN, bbDisplayENFR );
  bbDisplayFR:     array[ tDisLang ] of String =
                   ( bbDisplayFREN, bbDisplayFRFR );
  bbInternalLA:    array[ tDisLang ] of String =
                   ( bbInternalLAEN, bbInternalLAFR );
  bbBasleLA:       array[ tDisLang ] of String =
                   ( bbBasleLAEN, bbBasleLAFR );
  bbVocabularyLA:  array[ tDisLang ] of String =
                   ( bbVocabularyLAEN, bbVocabularyLAFR );
  bbVocabularyEN:  array[ tDisLang ] of String =
                   ( bbVocabularyENEN, bbVocabularyENFR );
  bbVocabularyFR:  array[ tDisLang ] of String =
                   ( bbVocabularyFREN, bbVocabularyFRFR );
  bbVocabularySP:  array[ tDisLang ] of String =
                   ( bbVocabularySPEN, bbVocabularySPFR );
  bbVocabularyRU:  array[ tDisLang ] of String =
                   ( bbVocabularyRUEN, bbVocabularyRUFR );
  bbAutoBaseLA:    array[ tDisLang ] of String =
                   ( bbAutoBaseLAEN, bbAutoBaseLAFR );
  bbAutoBaseEN:    array[ tDisLang ] of String =
                   ( bbAutoBaseENEN, bbAutoBaseENFR );
  bbAutoBaseFR:    array[ tDisLang ] of String =
                   ( bbAutoBaseFREN, bbAutoBaseFRFR );
  bbShortModelFR:  array[ tDisLang ] of String =
                   ( bbShortModelFREN, bbShortModelFRFR );
  bbFullModelFR:   array[ tDisLang ] of String =
                   ( bbFullModelFREN, bbFullModelFRFR );
  bbAutoDisLA:     array[ tDisLang ] of String =
                   ( bbAutoDisLAEN, bbAutoDisLAFR );
  bbAutoDisEN:     array[ tDisLang ] of String =
                   ( bbAutoDisENEN, bbAutoDisENFR );
  bbAutoDisFR:     array[ tDisLang ] of String =
                   ( bbAutoDisFREN, bbAutoDisFRFR );
  bbSynonymEN:     array[ tDisLang ] of String =
                   ( bbSynonymENEN, bbSynonymENFR );
  bbEponymLA:      array[ tDisLang ] of String =
                   ( bbEponymLAEN, bbEponymLAFR );
  bbEponymEN:      array[ tDisLang ] of String =
                   ( bbEponymENEN, bbEponymENFR );
  bbAuthorLA:      array[ tDisLang ] of String =
                   ( bbAuthorLAEN, bbAuthorLAFR );
  bbAuthorEN:      array[ tDisLang ] of String =
                   ( bbAuthorENEN, bbAuthorENFR );
  bbSynonymFR:     array[ tDisLang ] of String =
                   ( bbSynonymFREN, bbSynonymFRFR );
  bbEponymFR:      array[ tDisLang ] of String =
                   ( bbEponymFREN, bbEponymFRFR );
  bbExpSynonymLA:  array[ tDisLang ] of String =
                   ( bbExpSynonymLAEN, bbExpSynonymLAFR );
  bbExpSynonymEN:  array[ tDisLang ] of String =
                   ( bbExpSynonymENEN, bbExpSynonymENFR );
  bbExpSynonymFR:  array[ tDisLang ] of String =
                   ( bbExpSynonymFREN, bbExpSynonymFRFR );
  bbEncyclopedic:  array[ tDisLang ] of String =
                   ( bbEncyclopedicEN, bbEncyclopedicFR );
  bbTaxonomic:     array[ tDisLang ] of String =
                   ( bbTaxonomicEN, bbTaxonomicFR );
  bbLinked:        array[ tDisLang ] of String =
                   ( bbLinkedEN, bbLinkedFR );
  bbSpatial:       array[ tDisLang ] of String =
                   ( bbSpatialEN, bbSpatialFR );
  bbFunctional:    array[ tDisLang ] of String =
                   ( bbFunctionalEN, bbFunctionalFR );
  bbHistological:  array[ tDisLang ] of String =
                   ( bbHistologicalEN, bbHistologicalFR );
  bbPhysical:      array[ tDisLang ] of String =
                   ( bbPhysicalEN, bbPhysicalFR );
  bbDocum:         array[ tDisLang ] of String =
                   ( bbDocumEN, bbDocumFR );
  bbPartonomy:     array[ tDisLang ] of String =
                   ( bbPartonomyEN, bbPartonomyFR );
  bbTaxonomy:      array[ tDisLang ] of String =
                   ( bbTaxonomyEN, bbTaxonomyFR );
  bbPartUnit:      array[ tDisLang ] of String =
                   ( bbPartUnitEN, bbPartUnitFR );
  bbTaxUnit:       array[ tDisLang ] of String =
                   ( bbTaxUnitEN, bbTaxUnitFR );
  bbAutoPair:      array[ tDisLang ] of String =
                   ( bbAutoPairEN, bbAutoPairFR );
  bbTaxDef:        array[ tDisLang ] of String =
                   ( bbTaxDefEN, bbTaxDefFR );
  bbBrother:       array[ tDisLang ] of String =
                   ( bbBrotherEN, bbBrotherFR );
  bbInferred:      array[ tDisLang ] of String =
                   ( bbInferredEN, bbInferredFR );
  bbModelTerm:     array[ tDisLang ] of String =
                   ( bbModelTermEN, bbModelTermFR );
  bbTransTerm:     array[ tDisLang ] of String =
                   ( bbTransTermEN, bbTransTermFR );
  bbTreeFormula:   array[ tDisLang ] of String =
                   ( bbTreeFormulaEN, bbTreeFormulaFR );
  bbConcordance:   array[ tDisLang ] of String =
                   ( bbConcordanceEN, bbConcordanceFR );
  bbDisplayTrans:  array[ tDisLang ] of String =
                   ( bbDisplayTransEN, bbDisplayTransFR );
  bbAutoTerm:      array[ tDisLang ] of String =
                   ( bbAutoTermEN, bbAutoTermFR );
  bbNote:          array[ tDisLang ] of String =
                   ( bbNoteEN, bbNoteFR );
  bbTA98Note:      array[ tDisLang ] of String =
                   ( bbTA98NoteEN, bbTA98NoteFR );
  bbErrorNote:     array[ tDisLang ] of String =
                   ( bbErrorNoteEN, bbErrorNoteFR );
  bbRevisionNote:  array[ tDisLang ] of String =
                   ( bbRevisionNoteEN, bbRevisionNoteFR );
  bbProblemNote:   array[ tDisLang ] of String =
                   ( bbProblemNoteEN, bbProblemNoteFR );
  bbRvNote:        array[ tDisLang ] of String =
                   ( bbRvNoteEN, bbRvNoteFR );
  bbTnNote:        array[ tDisLang ] of String =
                   ( bbTnNoteEN, bbTnNoteFR );
  bbTxNote:        array[ tDisLang ] of String =
                   ( bbTxNoteEN, bbTxNoteFR );
  bbScNote:        array[ tDisLang ] of String =
                   ( bbScNoteEN, bbScNoteFR );
  bbImplNote:      array[ tDisLang ] of String =
                   ( bbImplNoteEN, bbImplNoteFR );
  bbTraNote:       array[ tDisLang ] of String =
                   ( bbTraNoteEN, bbTraNoteFR );
  bbProperty:      array[ tDisLang ] of String =
                   ( bbPropertyEN, bbPropertyFR );
  bbNbEntries:     array[ tDisLang ] of String =
                   ( bbNbEntriesEN, bbNbEntriesFR );
  bbBilatText:     array[ tDisLang ] of String =
                   ( bbBilatTextEN, bbBilatTextFR );
  bbPaireText:     array[ tDisLang ] of String =
                   ( bbPaireTextEN, bbPaireTextFR );
  bbMultiText:     array[ tDisLang ] of String =
                   ( bbMultiTextEN, bbMultiTextFR );
  bbMaterText:     array[ tDisLang ] of String =
                   ( bbMaterTextEN, bbMaterTextFR );
  bbImmatText:     array[ tDisLang ] of String =
                   ( bbImmatTextEN, bbImmatTextFR );
  bbSpeciText:     array[ tDisLang ] of String =
                   ( bbSpeciTextEN, bbSpeciTextFR );
  bbGenerText:     array[ tDisLang ] of String =
                   ( bbGenerTextEN, bbGenerTextFR );
  bbNonPhysText:   array[ tDisLang ] of String =
                   ( bbNonPhysTextEN, bbNonPhysTextFR );
  bbDimorphicText: array[ tDisLang ] of String =
                   ( bbDimorphicTextEN, bbDimorphicTextFR );
  bbReferText:     array[ tDisLang ] of String =
                   ( bbReferTextEN, bbReferTextFR );
  bbMaleText:      array[ tDisLang ] of String =
                   ( bbMaleTextEN, bbMaleTextFR );
  bbFemaleText:    array[ tDisLang ] of String =
                   ( bbFemaleTextEN, bbFemaleTextFR );
  bbInconsText:    array[ tDisLang ] of String =
                   ( bbInconsTextEN, bbInconsTextFR );
  bbLinkage:       array[ tDisLang ] of String =
                   ( bbLinkageEN, bbLinkageFR );
  bbOriginalLA:    array[ tDisLang ] of String =
                   ( bbOriginalLAEN, bbOriginalLAFR );
  bbNonRATLA:      array[ tDisLang ] of String =
                   ( bbNonRATLAEN, bbNonRATLAFR );
  bbAlternateLA:   array[ tDisLang ] of String =
                   ( bbAlternateLAEN, bbAlternateLAFR );
  bbOriginalEN:    array[ tDisLang ] of String =
                   ( bbOriginalENEN, bbOriginalENFR );
  bbOriginalFR:    array[ tDisLang ] of String =
                   ( bbOriginalFREN, bbOriginalFRFR );
  bbOriginalSP:    array[ tDisLang ] of String =
                   ( bbOriginalSPEN, bbOriginalSPFR );
  bbOriginalRU:    array[ tDisLang ] of String =
                   ( bbOriginalRUEN, bbOriginalRUFR );
  bbAlternateEN:   array[ tDisLang ] of String =
                   ( bbAlternateENEN, bbAlternateENFR );
  bbInitialLA:     array[ tDisLang ] of String =
                   ( bbInitialLAEN, bbInitialLAFR );
  bbInitialEN:     array[ tDisLang ] of String =
                   ( bbInitialENEN, bbInitialENFR );
  bbNavigToUnit:   array[ tDisLang ] of String =
                   ( bbNavigToUnitEN, bbNavigToUnitFR );
  bbAlterEntity:   array[ tDisLang ] of String =
                   ( bbAlterEntityEN, bbAlterEntityFR );
  bbLaterEntity:   array[ tDisLang ] of String =
                   ( bbLaterEntityEN, bbLaterEntityFR );
  bbNavigEntity:   array[ tDisLang ] of String =
                   ( bbNavigEntityEN, bbNavigEntityFR );

                   { * Class definitions for CSS * }
  cTableTitle      = 'class="TABLETITLE"';
  cFmt6Table       = 'class="Fmt6Table"';
  cCodeTable       = 'class="CodeTable"';
  cSpecTable       = 'class="SpecTable"';
  cSectionTitle700 = 'class="SectionTitle700"';
  cSectionTitle1400= 'class="SectionTitle1400"';
  cSectionContent  = 'class="SectionContent"';
  cTA98Titre       = 'class="TA98Titre"';
  cTA98Table       = 'class="TA98Table"';
  cTAStatTable     = 'class="TAStatTable"';
  cTAProperty      = 'class="TAProperty"';
  cSingleTable     = 'class="SingleTable"';
  cLeafPar         = 'class="LeafPar"';
  cSectionPar      = 'class="SectionPar"';
  cTermTable       = 'class="TermTable"';
  cCodeTitle       = 'class="CodeTitle"';
  cTAtoFMA         = 'class="TAtoFMA"';
  cClassRub        = 'class="rub"';
  cClassRubM       = 'class="rubm"';
  cClassTID        = 'class="TID"';
  cClassRef        = 'class="ref"';
  cClassTyp        = 'class="typ"';
  cClassTyp25      = 'class="typ25"';
  cClassTyp50      = 'class="typ50"';
  cClassErr        = 'class="err"';
  cClassSpec       = 'class="spec"';
  cClassDual       = 'class="dual"';
  cClassTrio       = 'class="trio"';
  cClassText       = 'class="text"';
  cClassTitleSect  = 'class="TitleSection"';
  cClassTerm       = 'class="term"';
  cClassTerm40     = 'class="term40"';
  cClassTerm270    = 'class="term270"';
  cClassTerm300    = 'class= term300"';
  cClassTerm350    = 'class="term350"';
  cClassTerm400    = 'class="term400"';
  cClassTerm450    = 'class="term450"';
  cClassTerm500    = 'class="term500"';
  cClassCol40      = 'class="Col40"';
  cClassCol40Red   = 'class="Col40Red"';
  cClassTitreLeft  = 'class="TitreLeft"';
  cClassTitreRight = 'class="TitreRight"';
  cClassEmpty      = 'class="';
  cClassLev        = 'class="lev';
  cTitleEmpty      = 'title="';
  cHrefEmpty       = 'href="';
  cTitle700Table   = 'class="TITLE700TABLE"';
  cBody700Table    = 'class="BODY700TABLE"';
  cBase700Table    = 'class="BASE700TABLE"';
  cClassTAID       = 'class="TAID"';
  cClassTAIDRef    = 'class="TAIDRef"';
  cClassTAIDTitre  = 'class="TAIDTitre"';
  cClassTAIDTitre25= 'class="TAIDTitre25"';
  cClassTAIDTitre50= 'class="TAIDTitre50"';
  cClassTitre350   = 'class="Titre350"';
  cClassTitre450   = 'class="Titre450"';
  cClassTACode     = 'class="TACode"';
  cClassTACodeRef  = 'class="TACodeRef"';
  cClassTACodeTitre= 'class="TACodeTitre"';
  cClassPartTitre  = 'class="PartTitre"';
  cClassStatTitre  = 'class="StatTitre"';
  cClassCountTitre = 'class="CountTitre"';
  cClassCountMoins = 'class="CountMoins"';
  cRuleBlank       = 'class="RuleBlank"';
  cRuleGray        = 'class="RuleGray"';
  cRuleBlack       = 'class="RuleBlack"';
  cClassLAa        = 'class="LAa"';
  cClassLA300      = 'class="LA300"';
  cClassLA350      = 'class="LA350"';
  cClassLA380      = 'class="LA380"';
  cClassLA400      = 'class="LA400"';
  cClassENa        = 'class="ENa"';
  cClassEN300      = 'class="EN300"';
  cClassEN380      = 'class="EN380"';
  cClassLG300      = 'class="LG300"';
  cClassLG380      = 'class="LG380"';
  cClassFRa        = 'class="FRa"';
                   { * Constantes for title 700px * }
  cClassIconTitle  = 'class="IconTitle"';       // right icon title
  cClassMainTitle  = 'class="MainTitle"';       // left main title
                   { * Constantes for body 700px * }
  cClassColSSS     = 'class="ColSSS"';          // small SSS 20 column
  cClassColSSSno   = 'class="ColSSSno"';        // small SSS 20 column no color
  cClassIcon16x16  = 'class="ColIcon"';         // small 30 column for icon
  cClassColSS      = 'class="ColSS"';           // small SS 40 column
  cClassColSSem    = 'class="ColSSem"';         // small SS 40 col emphasized
  cClassColSSno    = 'class="ColSSno"';         // small SS 40 column no color
  cClassColS       = 'class="ColS"';            // small S 60 column
  cClassColSem     = 'class="ColSem"';          // small S 60 column emphasized
  cClassColno      = 'class="Colno"';           // small S 100 column no color
  cClassColSno     = 'class="ColSno"';          // small S 60 column no color
  cClassColN       = 'class="ColN"';            // normal N 100 column
  cClassColNno     = 'class="ColNno"';          // normal N 100 column no color
  cClassColNem     = 'class="ColNem"';          // normal N 100 col emphasized
  cClassColNN      = 'class="ColNN"';           // normal NN 200 column
  cClassColNNno    = 'class="ColNNno"';         // normal NN 200 col no color
  cClassColX       = 'class="ColX"';            // large X 300 column
  cClassColXno     = 'class="ColXno"';          // large X 300 column no color
  cClassColXP      = 'class="ColXP"';           // large XP 315 column
  cClassColXPno    = 'class="ColXPno"';         // large XP 315 column no color
  cClassColXX      = 'class="ColXX"';           // large XX 400 column
  cClassColXXno    = 'class="ColXXno"';         // large XX 400 column no color
  cClassColXXX     = 'class="ColXXX"';          // large XXX 500 column
  cClassColXXXno   = 'class="ColXXXno"';        // large XXX 500 col no color
  cClassColNote    = 'class="ColNote"';         // 700 col left justified
  cClassColNSign   = 'class="ColNSign"';        // Left small note sign column
  cClassColNCode   = 'class="ColNCode"';        // Mid code column
  cClassColNText   = 'class="ColNText"';        // Right note text column
  cClassBodyTable  = 'class="BodyTable"';       // table for body
  cClassNoteTable  = 'class="NoteTable"';       // table for notes
  cClassSingleTable= 'class="SingleTable"';     // table for note headers
  cClassHeaderColor= 'class="HeaderColor"';     // color for header
  cClassRuleSub    = 'class="RuleSubChapter"';  // separation for subchapter
  cClassRuleSect   = 'class="RuleSection"';     // separation for section
                   { * Constantes for footer 700px * }
  cClassBase2L     = 'class="Base2L"';          // left part of 2 for footer
  cClassBase2R     = 'class="Base2R"';          // right part of 2 for footer
  cClassBase3L     = 'class="Base3L"';          // left part of 3 for footer
  cClassBase3C     = 'class="Base3C"';          // central part of 3 for footer
  cClassBase3R     = 'class="Base3R"';          // right part of 3 for footer
  cClassBase4L     = 'class="Base4L"';          // left part of 4 for footer
  cClassBase4CL    = 'class="Base4CL"';         // center left part of 4
  cClassBase4CR    = 'class="Base4CR"';         // center right part of 4
  cClassBase4R     = 'class="Base4R"';          // right part of 4 for footer
  cClassFooter700  = 'class="FooterTable700"';  // table for footer information 700 px
  cClassFooter1400 = 'class="FooterTable1400"'; // table for footer information 1400 px
  cClassBaseTable  = 'class="BaseTable"';       // table for copyrights notice
  cClassSigne      = 'class="Signature"';       // ifaa signature
  cClassSmallFont  = 'class="SmallFont"';       // small font

                   { * ID definitions for CSS * }
  cIdContainer     = 'id="Container700"';       // Page container 700px
  c660             = 'width="660px"';           // Special width for TA98
  cIdContainer1400 = 'id="Container1400"';      // Page container 1400px
  cIdTitle700      = 'id="Title700"';           // Page title 700px <<< old >>>
  cIdHeader700     = 'id="Header700"';          // Page header 700px
  cIdHeader1400    = 'id="Header1400"';         // Page header 1400px
  cIdBody700       = 'id="Body700"';            // Page body 700px
  cIdBody1400      = 'id="Body1400"';           // Page body 1400px
  cIdFooter700     = 'id="Footer700"';          // Page footer 700px
  cIdFooter1400    = 'id="Footer1400"';         // Page footer 700px
  cIdTitleBox700   = 'id="TitleBox700"';        // Header title box 700px
  cIdTitleBox1400  = 'id="TitleBox1400"';       // Header title box 1400px
  cIdTitleLegend   = 'id="TitleLegend"';        // Header title legend
  cIdTitleContent  = 'id="TitleContent"';       // Header title content
  cIdHelpIcon      = 'id="HelpIcon"';           // Header help icon

                   { * HTML tags constants * }
  HTMLTAG          = '<html xmlns="http://www.w3.org/1999/xhtml">';
                                                // Begin HTML tag
  HTMLETAG         = '</html>';                 // End HTML tag
  HEADTAG          = '<head>';                  // Begin HEAD tag
  HEADETAG         = '</head>';                 // End HEAD tag
  TITLETAG         = '<title>';                 // Begin TITLE tag
  TITLEETAG        = '</title>';                // End TITLE tag
  BODYTAG          = '<body>';                  // Begin BODY tag
  BODYETAG         = '</body>';                 // End BODY tag
  PTAG             = '<p>';                     // Begin P tag
  POTAG            = '<p ';                     // Begin open P tag
  PETAG            = '</p>';                    // End P tag
  AOTAG            = '<a ';                     // Begin A tag
  AETAG            = '</a>';                    // End A tag
  SPANTAG          = '<span>';                  // Begin SPAN tag
  SPANOTAG         = '<span ';                  // Begin open SPAN tag
  SPANETAG         = '</span>';                 // End SPAN tag
  BTAG             = '<b>';                     // Begin Bold tag
  BETAG            = '</b>';                    // End Bold tag
  FONTTAG          = '<FONT>';                  // Begin FONT tag
  FONTOTAG         = '<FONT ';                  // Begin open FONT tag
  FONTETAG         = '</FONT>';                 // End FONT tag
  TABLETAG         = '<TABLE>';                 // Begin TABLE tag
  TABLEOTAG        = '<TABLE ';                 // Begin open TABLE tag
  TABLEETAG        = '</TABLE>';                // End TABLE tag
  HRTAG            = '<HR>';                    // Begin HR tag
  TRTAG            = '<TR>';                    // Begin TR tag
  TROTAG           = '<TR ';                    // Begin open TR tag
  TRETAG           = '</TR>';                   // End TR tag
  TDTAG            = '<TD>';                    // Begin TD tag
  TDOTAG           = '<TD ';                    // Begin open TD tag
  TDETAG           = '</TD>';                   // End TD tag
  ITTAG            = '<I>';                     // Begin I tag
  ITOTAG           = '<I>';                     // Begin open I tag
  ITETAG           = '</I>';                    // End I tag
  CALLCSSVIEWTAG   = '<LINK REL=StyleSheet HREF="../../../serv/TAPage.css" '
                     + 'type="text/css" media="screen" />';
  TA98CSSVIEWTAG   = '<LINK REL=StyleSheet HREF="TAPage.css" ' +
                     'type="text/css" media="screen" />';
                                                // Access the style sheet
  DIVOTAG          = '<DIV ';                   // Begin DIV tag
  DIVETAG          = '</DIV>';                  // End DIV tag
  DIVTAG           = '<DIV>';                   // DIV tag
  SCRIPTTAG        = '<SCRIPT>';                // SCRIPT tag
  SCRIPTETAG       = '</SCRIPT>';               // End SCRIPT tag
  BUTTONOTAG       = '<BUTTON ';                // BUTTON tag
  BUTTONETAG       = '</BUTTON>';               // End BUTTON tag
  IMGOTAG          = '<IMG ';                   // IMG tag
  IMGETAG          = '</IMG>';                  // End IMG tag
  CALLCSSPRINTTAG  = '<LINK REL=StyleSheet ' +
                     'HREF="../TAPageP.css" media="print" />';
  TA98CSSPRINTTAG  = '<LINK REL=StyleSheet ' +
                     'HREF="TAPageP.css" media="print" />';
                                                // Access printer stylesheet
  DOCTYPETAG       = '<!DOCTYPE html PUBLIC ' + // DOCTYPE tag
                   '"-//W3C//DTD XHTML 1.0 Transitional//EN" ' +
                   '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
  METATAG          = '<meta http-equiv="Content-Type" ' +
                     'content="text/html; charset=utf-8" />';
  CALLJSENTITY     = '<script type="text/javascript" src="../../../serv/EntityPage.js" ></script>';
  TA98JSENTITY     = '<script type="text/javascript" src="TA98Page.js" ></script>';
                                                // META tag

                   // Navigation section
  ltNavigToUnitEN  = 'To the unit';
  ltNavigToEntityEN= 'To the entities';
  ltLaterEntityEN  = 'Lateral members';
  ltEntityBasedEN  = 'To the entity oriented pages';
  ltToSegmentPageEN= 'To the segmentation page';
  ltToValidPageEN  = 'To the validation page';
  ltPartListEN     = 'To the partonomy lists';
  ltTaxListEN      = 'To the taxonomy lists';
  ltTraceTA98EN    = 'To the TA98 trace';
                   // Property section
  ltUnitTypeEN     = 'Type of unit';
  ltBilateralityEN = 'Bilaterality';
  ltGeneratorEN    = 'Generator';
  ltSpecificityEN  = 'Specificity';
  ltGenericityEN   = 'Genericity';

  ltShortLAEN      = 'Short official term';
  ltEquivFREN      = 'French equivalent';
  ltEquivSPEN      = 'Spanish equivalent';
  ltEquivRUEN      = 'Russian equivalent';
  ltEquivITEN      = 'Italian equivalent';
  ltEquivGEEN      = 'German equivalent';
  ltEquivPTEN      = 'Portugese equivalent';
  ltBaseLAEN       = 'Base term';
  ltExpENEN        = 'English Base term';
  ltIntLAEN        = 'Head noun of official term';
  ltModelLAEN      = 'Model term';
  ltOfficialLAEN   = 'Official synonym';
  ltExpOfficialLAEN= 'Expanded official synonym';
  ltExpSynonymLAEN = 'Expanded related term';
  ltEponymLAEN     = 'Eponym';
  ltAcronymLAEN    = 'Acronym';
  ltDisplayLAEN    = 'Display term';
  ltShortDisplayLAEN = 'Short display term';
  ltShortPluralLAEN= 'Short plural term';
  ltDisplayRATLAEN = 'Traditional display term';
  ltNOSLAEN        = 'NOS term';
  ltInternalLAEN   = 'Database internal term';
  ltBasleLAEN      = 'Basle Nomina Anatomica';
  ltVocabularyLAEN = 'Latin induced vocabulary';
  ltVocabularyENEN = 'English induced vocabulary';
  ltVocabularyFREN = 'French induced vocabulary';
  ltVocabularySPEN = 'Spanish induced vocabulary';
  ltVocabularyRUEN = 'Russian induced vocabulary';
  ltAutoBaseLAEN   = 'Latin stored base term';
  ltAutoBaseENEN   = 'English stored base term';
  ltAutoBaseFREN   = 'French stored base term';
  ltShortModelFREN = 'Short French removed base term';
  ltFullModelFREN  = 'Full French removed base term';
  ltAutoDisLAEN    = 'Latin stored display term';
  ltAutoDisENEN    = 'English stored display term';
  ltAutoDisFREN    = 'French stored display term';
  ltDeprecLAEN     = 'Depreciated term';
  ltGenitiveLAEN   = 'Genitive form';
  ltAlternateLAEN  = 'TA98 official synonym';
  ltInitialLAEN    = 'TA98 precursor term';
  ltAlternateENEN  = 'TA98 English synonym';
  ltInitialENEN    = 'TA98 English source term';
  ltTA98CodeENEN   = 'TA98 code';
  ltNonRATLAEN     = 'Traditional term';
  ltIntENEN        = 'Head noun of English equivalent';
  ltUniversalEN    = 'Universal term';
  ltFMAEN          = 'Official FMA term';
  ltOfficialENEN   = 'Official English synonym';
  ltExpOfficialENEN= 'Expanded official English synonym';
  ltSynonymENEN    = 'English related term';
  ltExpSynonymENEN = 'Expanded English related term';
  ltEponymENEN     = 'English eponym';
  ltAuthorENEN     = 'Author';
  ltAcronymENEN    = 'English acronym';
  ltDisplayENEN    = 'English display term';
  ltDeprecENEN     = 'English depreciated term';
  ltGenitiveENEN   = 'English genitive form';
  ltBaseENEN       = 'Short English equivalent';
  ltBaseFREN       = 'Short French equivalent';
  ltBaseSPEN       = 'Short Spanish equivalent';
  ltBaseRUEN       = 'Short Russian equivalent';
  ltBaseITEN       = 'Short Italian equivalent';
  ltBaseGEEN       = 'Short German equivalent';
  ltBasePTEN       = 'Short Portugese equivalent';
  ltExpFREN        = 'French base term';
  ltExpSPEN        = 'Spanish base term';
  ltExpRUEN        = 'Russian base term';
  ltIntFREN        = 'Root of French equivalent';
  ltOfficialFREN   = 'Official French synonym';
  ltOfficialSPEN   = 'Official Spanish synonym';
  ltOfficialRUEN   = 'Official Russian synonym';
  ltOfficialITEN   = 'Official Italian synonym';
  ltOfficialGEEN   = 'Official German synonym';
  ltOfficialPTEN   = 'Official Portugese synonym';
  ltExpOfficialFREN= 'Expanded official French synonym';
  ltExpOfficialSPEN= 'Expanded official Spanish synonym';
  ltExpOfficialRUEN= 'Expanded official Russian synonym';
  ltSynonymFREN    = 'French related term';
  ltExpSynonymFREN = 'Expanded French related term';
  ltEponymFREN     = 'French eponym';
  ltAuthorFREN     = 'Author';
  ltAcronymFREN    = 'French acronym';
  ltDisplayFREN    = 'French display term';
  ltDeprecFREN     = 'French depreciated term';
  ltGenitiveFREN   = 'French genitive form';
  ltGenericEN      = 'generic';
  ltSpecificEN     = 'specific';
  ltTaxonomicEN    = 'taxonomic';
  ltVocabEN        = 'vocabulary';
  ltInterfaceEN    = 'interface';
                   // French texts for section items
                   // Navigation section
  ltNavigToUnitFR  = 'Vers l''unité';
  ltNavigToEntityFR= 'Vers les entités';
  ltLaterEntityFR  = 'Membres latéraux';
  ltEntityBasedFR  = 'Vers les pages orientées entités';
  ltToSegmentPageFR= 'Vers la page de segmentation';
  ltToValidPageFR  = 'Vers la page de validation';
  ltPartListFR     = 'Vers les listes partonomiques';
  ltTaxListFR      = 'Vers les listes taxonomiques';
  ltTraceTA98FR    = 'Vers la trace TA98';
                   // Property section
  ltUnitTypeFR     = 'Type d''unité';
  ltBilateralityFR = 'Bilatéralité';
  ltGeneratorFR    = 'Générateur';
  ltSpecificityFR  = 'Spécificité';
  ltGenericityFR   = 'Généricité';

  ltShortLAFR      = 'Terme officiel court';
  ltEquivFRFR      = 'Equivalent français';
  ltEquivSPFR      = 'Equivalent espagnol';
  ltEquivRUFR      = 'Equivalent russe';
  ltEquivITFR      = 'Equivalent italien';
  ltEquivGEFR      = 'Equivalent allemand';
  ltEquivPTFR      = 'Equivalent portugais';
  ltBaseLAFR       = 'Terme de base';
  ltExpENFR        = 'Terme de base anglais';
  ltIntLAFR        = 'Mot de base du terme de base';
  ltModelLAFR      = 'Terme modèle';
  ltOfficialLAFR   = 'Synonyme officiel';
  ltExpOfficialLAFR= 'Synonyme officiel expansé';
  ltExpSynonymLAFR = 'Terme lié expansé';
  ltEponymLAFR     = 'Eponyme';
  ltAuthorLAFR     = 'Auteur';
  ltAcronymLAFR    = 'Acronyme';
  ltDisplayLAFR    = 'Terme d''affichage';
  ltShortDisplayLAFR = 'Terme d''affichage court';
  ltShortPluralLAFR= 'Terme pluriel court';
  ltDisplayRATLAFR = 'Terme d''affichage traditionnel';
  ltNOSLAFR        = 'Terme NOS';
  ltInternalLAFR   = 'Terme interne Latin';
  ltBasleLAFR      = 'Basle Nomina Anatomica';
  ltVocabularyLAFR = 'Vocabulaire latin induit';
  ltVocabularyENFR = 'Vocabulaire anglais induit';
  ltVocabularyFRFR = 'Vocabulaire français induit';
  ltVocabularySPFR = 'Vocabulaire espagnol induit';
  ltVocabularyRUFR = 'Vocabulaire russe induit';
  ltAutoBaseLAFR   = 'Terme de base autogénéré';
  ltAutoBaseENFR   = 'Terme de base autogénéré';
  ltAutoBaseFRFR   = 'Terme de base autogénéré';
  ltShortModelFRFR = 'Terme de base court retiré';
  ltFullModelFRFR  = 'Terme de base long retiré';
  ltAutoDisLAFR    = 'Terme de display autogénéré';
  ltAutoDisENFR    = 'Terme de display autogénéré';
  ltAutoDisFRFR    = 'Terme de display autogénéré';
  ltDeprecLAFR     = 'Terme déprécié';
  ltGenitiveLAFR   = 'Génitif';
  ltAlternateLAFR  = 'Synonyme TA98';
  ltInitialLAFR    = 'Terme source latin TA98';
  ltAlternateENFR  = 'Synonyme TA98';
  ltInitialENFR    = 'Terme source anglais TA98';
  ltNonRATLAFR     = 'Terme traditionnel';
  ltIntENFR        = 'Mot de base de l''équivalent anglais';
  ltUniversalFR    = 'Terme universel';
  ltFMAFR          = 'Terme official FMA';
  ltOfficialENFR   = 'Synonyme officiel anglais';
  ltExpOfficialENFR= 'Synonyme officiel anglais expansé';
  ltSynonymENFR    = 'Terme lié anglais';
  ltExpSynonymENFR = 'Terme lié anglais expansé';
  ltEponymENFR     = 'Eponyme';
  ltAuthorENFR     = 'Auteur';
  ltAcronymENFR    = 'Acronyme';
  ltDisplayENFR    = 'Terme d''affichage anglais';
  ltDeprecENFR     = 'Terme déprécié';
  ltGenitiveENFR   = 'Génitif';
  ltBaseENFR       = 'Equivalent anglais court';
  ltBaseFRFR       = 'Equivalent français court';
  ltBaseSPFR       = 'Equivalent espagnol court';
  ltBaseRUFR       = 'Equivalent russe court';
  ltBaseITFR       = 'Equivalent italien court';
  ltBaseGEFR       = 'Equivalent allemand court';
  ltBasePTFR       = 'Equivalent portugais court';
  ltExpFRFR        = 'Terme de base français';
  ltExpSPFR        = 'Terme de base espagnol';
  ltExpRUFR        = 'Terme de base russe';
  ltIntFRFR        = 'Racine de l''équivalent français';
  ltOfficialFRFR   = 'Synonyme officiel français';
  ltOfficialSPFR   = 'Synonyme officiel espagnol';
  ltOfficialRUFR   = 'Synonyme officiel russe';
  ltOfficialITFR   = 'Synonyme officiel italien';
  ltOfficialGEFR   = 'Synonyme officiel allemand';
  ltOfficialPTFR   = 'Synonyme officiel portugais';
  ltExpOfficialFRFR= 'Synonyme officiel français expansé';
  ltExpOfficialSPFR= 'Synonyme officiel espagnol expansé';
  ltExpOfficialRUFR= 'Synonyme officiel russe expansé';
  ltSynonymFRFR    = 'Terme lié français';
  ltExpSynonymFRFR = 'Terme lié français expansé';
  ltEponymFRFR     = 'Eponyme';
  ltAuthorFRFR     = 'Auteur';
  ltAcronymFRFR    = 'Acronyme';
  ltDisplayFRFR    = 'Terme d''affichage français';
  ltDeprecFRFR     = 'Terme déprécié';
  ltGenitiveFRFR   = 'Génitif';
  ltGenericFR      = 'générique';
  ltSpecificFR     = 'spécifique';
  ltTaxonomicFR    = 'taxonomique';
  ltVocabFR        = 'vocabulaire';
  ltInterfaceFR    = 'interface';
                   // Bilingual constants for section items
                   // Navigation section
  ltNavigToUnit:   array[ tDisLang ] of String =
                   ( ltNavigToUnitEN, ltNavigToUnitFR );
  ltNavigToEntity: array[ tDisLang ] of String =
                   ( ltNavigToEntityEN, ltNavigToEntityFR );
  ltLaterEntity:   array[ tDisLang ] of String =
                   ( ltLaterEntityEN, ltLaterEntityFR );
  ltEntityBased:   array[ tDisLang ] of String =
                   ( ltEntityBasedEN, ltEntityBasedFR );
  ltToSegmentPage: array[ tDisLang ] of String =
                   ( ltToSegmentPageEN, ltToSegmentPageFR );
  ltToValidPage:   array[ tDisLang ] of String =
                   ( ltToValidPageEN, ltToValidPageFR );
  ltPartList:      array[ tDisLang ] of String =
                   ( ltPartListEN, ltPartListFR );
  ltTaxList:       array[ tDisLang ] of String =
                   ( ltTaxListEN, ltTaxListFR );
  ltTraceTA98:     array[ tDisLang ] of String =
                   ( ltTraceTA98EN, ltTraceTA98FR );
                   // Property section
  ltUnitType:      array[ tDisLang ] of String =
                   ( ltUnitTypeEN, ltUnitTypeFR );
  ltBilaterality:  array[ tDisLang ] of String =
                   ( ltBilateralityEN, ltBilateralityFR );
  ltGenerator:     array[ tDisLang ] of String =
                   ( ltGeneratorEN, ltGeneratorFR );
  ltSpecificity:   array[ tDisLang ] of String =
                   ( ltSpecificityEN, ltSpecificityFR );
  ltGenericity:    array[ tDisLang ] of String =
                   ( ltGenericityEN, ltGenericityFR );

  ltBaseLA:        array[ tDisLang ] of String =
                   ( ltBaseLAEN, ltBaseLAFR );
  ltBaseEN:        array[ tDisLang ] of String =
                   ( ltBaseENEN, ltBaseENFR );
  ltBaseFR:        array[ tDisLang ] of String =
                   ( ltBaseFREN, ltBaseFRFR );
  ltBaseSP:        array[ tDisLang ] of String =
                   ( ltBaseSPEN, ltBaseSPFR );
  ltBaseRU:        array[ tDisLang ] of String =
                   ( ltBaseRUEN, ltBaseRUFR );
  ltBaseIT:        array[ tDisLang ] of String =
                   ( ltBaseITEN, ltBaseITFR );
  ltBaseGE:        array[ tDisLang ] of String =
                   ( ltBaseGEEN, ltBaseGEFR );
  ltBasePT:        array[ tDisLang ] of String =
                   ( ltBasePTEN, ltBasePTFR );
  ltEquivFR:       array[ tDisLang ] of String =
                   ( ltEquivFREN, ltEquivFRFR );
  ltEquivSP:       array[ tDisLang ] of String =
                   ( ltEquivSPEN, ltEquivSPFR );
  ltEquivRU:       array[ tDisLang ] of String =
                   ( ltEquivRUEN, ltEquivRUFR );
  ltEquivIT:       array[ tDisLang ] of String =
                   ( ltEquivITEN, ltEquivITFR );
  ltEquivGE:       array[ tDisLang ] of String =
                   ( ltEquivGEEN, ltEquivGEFR );
  ltEquivPT:       array[ tDisLang ] of String =
                   ( ltEquivPTEN, ltEquivPTFR );
  ltShortLA:       array[ tDisLang ] of String =
                   ( ltShortLAEN, ltShortLAFR );
  ltExpEN:         array[ tDisLang ] of String =
                   ( ltExpENEN, ltExpENFR );
  ltExpFR:         array[ tDisLang ] of String =
                   ( ltExpFREN, ltExpFRFR );
  ltExpSP:         array[ tDisLang ] of String =
                   ( ltExpSPEN, ltExpSPFR );
  ltExpRU:         array[ tDisLang ] of String =
                   ( ltExpRUEN, ltExpRUFR );
  ltIntLA:         array[ tDisLang ] of String =
                   ( ltIntLAEN, ltIntLAFR );
  ltModelLA:       array[ tDisLang ] of String =
                   ( ltModelLAEN, ltModelLAFR );
  ltIntEN:         array[ tDisLang ] of String =
                   ( ltIntENEN, ltIntENFR );
  ltUniversal:     array[ tDisLang ] of String =
                   ( ltUniversalEN, ltUniversalFR );
  ltIntFR:         array[ tDisLang ] of String =
                   ( ltIntFREN, ltIntFRFR );
  ltFMA:           array[ tDisLang ] of String =
                   ( ltFMAEN, ltFMAFR );
  ltgeneric:       array[ tDisLang ] of String =
                   ( ltgenericEN, ltgenericFR );
  ltspecific:      array[ tDisLang ] of String =
                   ( ltspecificEN, ltspecificFR );
  ltTaxonomic:     array[ tDisLang ] of String =
                   ( ltTaxonomicEN, ltTaxonomicFR );
  ltVocab:         array[ tDisLang ] of String =
                   ( ltVocabEN, ltVocabFR );
  ltInterface:     array[ tDisLang ] of String =
                   ( ltInterfaceEN, ltInterfaceFR );
  ltOfficialLA:    array[ tDisLang ] of String =
                   ( ltOfficialLAEN, ltOfficialLAFR );
  ltOfficialEN:    array[ tDisLang ] of String =
                   ( ltOfficialENEN, ltOfficialENFR );
  ltOfficialFR:    array[ tDisLang ] of String =
                   ( ltOfficialFREN, ltOfficialFRFR );
  ltOfficialSP:    array[ tDisLang ] of String =
                   ( ltOfficialSPEN, ltOfficialSPFR );
  ltOfficialRU:    array[ tDisLang ] of String =
                   ( ltOfficialRUEN, ltOfficialRUFR );
  ltOfficialIT:    array[ tDisLang ] of String =
                   ( ltOfficialITEN, ltOfficialITFR );
  ltOfficialGE:    array[ tDisLang ] of String =
                   ( ltOfficialGEEN, ltOfficialGEFR );
  ltOfficialPT:    array[ tDisLang ] of String =
                   ( ltOfficialPTEN, ltOfficialPTFR );
  ltExpOfficialLA: array[ tDisLang ] of String =
                   ( ltExpOfficialLAEN, ltExpOfficialLAFR );
  ltExpOfficialEN: array[ tDisLang ] of String =
                   ( ltExpOfficialENEN, ltExpOfficialENFR );
  ltExpOfficialFR: array[ tDisLang ] of String =
                   ( ltExpOfficialFREN, ltExpOfficialFRFR );
  ltExpOfficialSP: array[ tDisLang ] of String =
                   ( ltExpOfficialSPEN, ltExpOfficialSPFR );
  ltExpOfficialRU: array[ tDisLang ] of String =
                   ( ltExpOfficialRUEN, ltExpOfficialRUFR );
  ltDisplayLA:     array[ tDisLang ] of String =
                   ( ltDisplayLAEN, ltDisplayLAFR );
  ltShortDisplayLA:array[ tDisLang ] of String =
                   ( ltShortDisplayLAEN, ltShortDisplayLAFR );
  ltShortPluralLA: array[ tDisLang ] of String =
                   ( ltShortPluralLAEN, ltShortPluralLAFR );
  ltDisplayRATLA:  array[ tDisLang ] of String =
                   ( ltDisplayRATLAEN, ltDisplayRATLAFR );
  ltNOSLA:         array[ tDisLang ] of String =
                   ( ltNOSLAEN, ltNOSLAFR );
  ltDisplayEN:     array[ tDisLang ] of String =
                   ( ltDisplayENEN, ltDisplayENFR );
  ltDisplayFR:     array[ tDisLang ] of String =
                   ( ltDisplayFREN, ltDisplayFRFR );
  ltInternalLA:    array[ tDisLang ] of String =
                   ( ltInternalLAEN, ltInternalLAFR );
  ltBasleLA:       array[ tDisLang ] of String =
                   ( ltBasleLAEN, ltBasleLAFR );
  ltVocabularyLA:  array[ tDisLang ] of String =
                   ( ltVocabularyLAEN, ltVocabularyLAFR );
  ltVocabularyEN:  array[ tDisLang ] of String =
                   ( ltVocabularyENEN, ltVocabularyENFR );
  ltVocabularyFR:  array[ tDisLang ] of String =
                   ( ltVocabularyFREN, ltVocabularyFRFR );
  ltVocabularySP:  array[ tDisLang ] of String =
                   ( ltVocabularySPEN, ltVocabularySPFR );
  ltVocabularyRU:  array[ tDisLang ] of String =
                   ( ltVocabularyRUEN, ltVocabularyRUFR );
  ltAutoBaseLA:    array[ tDisLang ] of String =
                   ( ltAutoBaseLAEN, ltAutoBaseLAFR );
  ltAutoBaseEN:    array[ tDisLang ] of String =
                   ( ltAutoBaseENEN, ltAutoBaseENFR );
  ltAutoBaseFR:    array[ tDisLang ] of String =
                   ( ltAutoBaseFREN, ltAutoBaseFRFR );
  ltShortModelFR:  array[ tDisLang ] of String =
                   ( ltShortModelFREN, ltShortModelFRFR );
  ltFullModelFR:   array[ tDisLang ] of String =
                   ( ltFullModelFREN, ltFullModelFRFR );
  ltAutoDisLA:     array[ tDisLang ] of String =
                   ( ltAutoDisLAEN, ltAutoDisLAFR );
  ltAutoDisEN:     array[ tDisLang ] of String =
                   ( ltAutoDisENEN, ltAutoDisENFR );
  ltAutoDisFR:     array[ tDisLang ] of String =
                   ( ltAutoDisFREN, ltAutoDisFRFR );
  ltSynonymEN:     array[ tDisLang ] of String =
                   ( ltSynonymENEN, ltSynonymENFR );
  ltSynonymFR:     array[ tDisLang ] of String =
                   ( ltSynonymFREN, ltSynonymFRFR );
  ltEponymEN:      array[ tDisLang ] of String =
                   ( ltEponymENEN, ltEponymENFR );
  ltEponymFR:      array[ tDisLang ] of String =
                   ( ltEponymFREN, ltEponymFRFR );
  ltAuthorEN:      array[ tDisLang ] of String =
                   ( ltAuthorENEN, ltAuthorENFR );
  ltAuthorFR:      array[ tDisLang ] of String =
                   ( ltAuthorFREN, ltAuthorFRFR );
  ltExpSynonymLA:  array[ tDisLang ] of String =
                   ( ltExpSynonymLAEN, ltExpSynonymLAFR );
  ltExpSynonymEN:  array[ tDisLang ] of String =
                   ( ltExpSynonymENEN, ltExpSynonymENFR );
  ltExpSynonymFR:  array[ tDisLang ] of String =
                   ( ltExpSynonymFREN, ltExpSynonymFRFR );
  ltNonRATLA:      array[ tDisLang ] of String =
                   ( ltNonRATLAEN, ltNonRATLAFR );
  ltAlternateLA:   array[ tDisLang ] of String =
                   ( ltAlternateLAEN, ltAlternateLAFR );
  ltAlternateEN:   array[ tDisLang ] of String =
                   ( ltAlternateENEN, ltAlternateENFR );
  ltInitialLA:     array[ tDisLang ] of String =
                   ( ltInitialLAEN, ltInitialLAFR );
  ltInitialEN:     array[ tDisLang ] of String =
                   ( ltInitialENEN, ltInitialENFR );

                   // English texts for paragraph and subparagraph headings
  paPageTitle      = 'Details on';
  paDirTEN         = 'Direction terms';
  paRefPEN         = 'Reference planes';
  paRefLEN         = 'Reference lines';
  paMovJEN         = 'Joint Movements';
  paTA98NavigEN    = 'TA98 navigation';
  paTA98ListEN     = 'TA98 List';
  paNavigationEN   = 'Navigation';
  paNavig4EN       = 'Navigation level 4';
  paL4EN           = 'List level 4';
  paL5ShortEN      = 'Unit list';
  paL5FullEN       = 'Entity list';
  paTaxDefListEN   = 'Taxonomic cascade';
  paPartDefListEN  = 'Partonomic definition list';
  paTACodeEN       = 'TA98 code';
  paFMAIDEN        = 'FMA identifier';
  paLanguageENEN   = 'English terms';
  paModelTermEN    = 'Raw term composition';
  paTransTermEN    = 'Translation setting';
  paTreeFormulaEN  = 'Tree formula';
  paConcordanceEN  = 'Concordance table';
  paDisplayTransEN = 'Final translation';
  paAutoTermEN     = 'Automatic translation';
  paPropertyEN     = 'Properties';
  paLinkageEN      = 'Linkage';
  paEncyclopedicEN = 'Encyclopedic';
  paLinkedEN       = 'Linked';
  paTaxonomicENEN  = 'Taxonomic';
  paTaxonomicFREN  = 'French taxonomic';
  paAutoLateralEN  = 'Lateral definition (auto)';
  paAutoPairEN     = 'Pair definition (auto)';
  paAutoSetEN      = 'Set definition (auto)';
  paAutoPSetEN     = 'Pair set definition (auto)';
  paSpatialEN      = 'Spatial';
  paFunctionalEN   = 'Functional';
  paHistologicalEN = 'Histological';
  paPhysicalEN     = 'Physical';
  paPlainLanguageEN= 'Plain language';
  paNoteEN         = 'Notes';
  paNote98EN       = 'TA98 footnote';
  paNoteErEN       = 'TA98 correction note';
  paNoteProbEN     = 'TA98 problem note';
  paNoteRedirEN    = 'TA98 redirection note';
  paNoteRATEN      = 'TA98 RAT note';
  paNote10EN       = 'Transition note';
  paNoteRvEN       = 'Note RevTermA';
  paNoteTnEN       = 'Terminology note';
  paNoteTxEN       = 'Taxonomy change note';
  paNoteScEN       = 'Scientific note';
  paNoteImplEN     = 'Implementation note';
  paNoteTraEN      = 'Translation note';
  paPartonomyEN    = 'Extended part_of Hierarchy';
  paInferredEN     = 'Part_of Hierarchy';
  paTaxonomyEN     = 'Taxonomy';
  paCardinalityEN  = 'Cardinality';
  paGeneratorEN    = 'Generator';
  paGenForEN       = 'Generator for';
  paSequenceEN     = 'Sequence';
  paDocumEN        = 'Documentation';
  paBrotherEN      = 'Level';
  paSEQTitleEN     = 'Title';
  paSEQDescrEN     = 'Description';
  paOptExpansionEN = 'Optional expansion';
  paRefNounEN      = 'Referenced noun';
  paRefComplEN     = 'Referenced noun complement';
  paRefAdjEN       = 'Referenced adjective';
  paOriginTermEN   = 'Origin term of the model';
  paBasicPartEN    = 'Basic part';
  paAdjExpansionEN = 'Adjective expansion';
  paFormulaEN      = 'Universal formula';
                   // French texts for paragraph and subparagraph headings
  paPartLFR        = 'Liste partonomique';
  paTaxLFR         = 'Liste taxonomique';
  paDirTFR         = 'Directions dans l''espace';
  paRefPFR         = 'Plans de référence';
  paRefLFR         = 'Lignes de référence';
  paMovJFR         = 'Mouvements des articulations';
  paTA98NavigFR    = 'Navigation TA98';
  paTA98ListFR     = 'Liste TA98';
  paNavigationFR   = 'Navigation';
  paNavig4FR       = 'Navigation niveau 4';
  paL4FR           = 'Liste de niveau 4';
  paL5ShortFR      = 'Liste d''unités';
  paL5FullFR       = 'Liste d''entités';
  paTaxDefListFR   = 'Cascade taxonomique';
  paPartDefListFR  = 'Liste de définitions partonomiques';
  paTACodeFR       = 'Code TA98';
  paFMAIDFR        = 'Identificateur FMA';
  paPropertyFR     = 'Propriétés';
  paLinkageFR      = 'Liens bilatéraux';
  paEncyclopedicFR = 'Encyclopédique';
  paLinkedFR       = 'Référencée';
  paTaxonomicENFR  = 'Taxonomique';
  paTaxonomicFRFR  = 'Taxonomique française';
  paAutoLateralFR  = 'Définition latérale (autogénérée)';
  paAutoPairFR     = 'Définition  de paire (autogénérée)';
  paAutoSetFR      = 'Définition d''ensemble (autogénérée)';
  paAutoPSetFR     = 'Définition de paire d''ensembles (autogénérée)';
  paSpatialFR      = 'Spatiale';
  paFunctionalFR   = 'Fonctionelle';
  paHistologicalFR = 'Histologique';
  paPhysicalFR     = 'Physique';
  paPlainLanguageFR= 'Langage libre';
  paNoteFR         = 'Notes';
  paNote98FR       = 'Note de pied de page TA98';
  paNoteErFR       = 'Note de correction TA98';
  paNoteProbFR     = 'Note de problème TA98';
  paNoteRedirFR    = 'Note de redirection TA98';
  paNoteRATFR      = 'Note RAT TA98';
  paNote10FR       = 'Note de transition';
  paNoteRvFR       = 'Note RevTermA';
  paNoteTnFR       = 'Note de terminologie';
  paNoteTxFR       = 'Note de changement de taxonomie';
  paNoteScFR       = 'Note scientifique';
  paNoteImplFR     = 'Note d''implémentation';
  paNoteTraFR      = 'Note de traduction';
  paPartonomyFR    = 'Hiérarchie partitive étendue';
  paInferredFR     = 'Hiérarchie partitive';
  paTaxonomyFR     = 'Hiérarchie taxonomique';
  paCardinalityFR  = 'Cardinalité';
  paGeneratorFR    = 'Générateur';
  paGenForFR       = 'Générateur pour';
  paSequenceFR     = 'Séquence';
  paDocumFR        = 'Documentation';
  paBrotherFR      = 'Niveau';
  paSEQTitleFR     = 'Titre';
  paSEQDescrFR     = 'Description';
  paModelTermFR    = 'Composition du terme brut';
  paTransTermFR    = 'Paramètres de traduction';
  paTreeFormulaFR  = 'Formule arborescente';
  paConcordanceFR  = 'Table de concordance';
  paDisplayTransFR = 'Traduction finale';
  paAutoTermFR     = 'Traduction automatique';
  paOptExpansionFR = 'Expansion facultative';
  paRefNounFR      = 'Nom référencié';
  paRefComplFR     = 'Complément de nom référencié';
  paRefAdjFR       = 'Adjectif référencié';
  paOriginTermFR   = 'Terme origine du modèle';
  paBasicPartFR    = 'Basic part';
  paAdjExpansionFR = 'Expansion par adjectif';
  paFormulaFR      = 'Formule universelle';

                   { Bilingual constants }
  paDirT:          array[ tDisLang ] of String =
                   ( paDirTEN, paDirTFR );
  paRefP:          array[ tDisLang ] of String =
                   ( paRefPEN, paRefPFR );
  paRefL:          array[ tDisLang ] of String =
                   ( paRefLEN, paRefLFR );
  paMovJ:          array[ tDisLang ] of String =
                   ( paMovJEN, paMovJFR );
  paTA98Navig:     array[ tDisLang ] of String =
                   ( paTA98NavigEN, paTA98NavigFR );
  paTA98List:      array[ tDisLang ] of String =
                   ( paTA98ListEN, paTA98ListFR );
  paNavigation:    array[ tDisLang ] of String =
                   ( paNavigationEN, paNavigationFR );
  paNavig4:        array[ tDisLang ] of String =
                   ( paNavig4EN, paNavig4FR );
  paL4:            array[ tDisLang ] of String =
                   ( paL4EN, paL4FR );
  paL5Short:       array[ tDisLang ] of String =
                   ( paL5ShortEN, paL5ShortFR );
  paL5Full:        array[ tDisLang ] of String =
                   ( paL5FullEN, paL5FullFR );
  paTaxDefList:    array[ tDisLang ] of String =
                   ( paTaxDefListEN, paTaxDefListFR );
  paPartDefList:    array[ tDisLang ] of String =
                   ( paPartDefListEN, paPartDefListFR );
  paTACode:        array[ tDisLang ] of String =
                   ( paTACodeEN, paTACodeFR );
  paFMAID:         array[ tDisLang ] of String =
                   ( paFMAIDEN, paFMAIDFR );
  paGenerator:     array[ tDisLang ] of String =
                   ( paGeneratorEN, paGeneratorFR );
  paCardinality:   array[ tDisLang ] of String =
                   ( paCardinalityEN, paCardinalityFR );
  paGenFor:        array[ tDisLang ] of String =
                   ( paGenForEN, paGenForFR );
  paEncyclopedic:  array[ tDisLang ] of String =
                   ( paEncyclopedicEN, paEncyclopedicFR );
  paTaxonomicEN:   array[ tDisLang ] of String =
                   ( paTaxonomicENEN, paTaxonomicENFR );
  paTaxonomicFR:   array[ tDisLang ] of String =
                   ( paTaxonomicFREN, paTaxonomicFRFR );
  paAutoLateral:   array[ tDisLang ] of String =
                   ( paAutoLateralEN, paAutoLateralFR );
  paAutoPair:      array[ tDisLang ] of String =
                   ( paAutoPairEN, paAutoPairFR );
  paAutoSet:       array[ tDisLang ] of String =
                   ( paAutoSetEN, paAutoSetFR );
  paAutoPSet:      array[ tDisLang ] of String =
                   ( paAutoPSetEN, paAutoPSetFR );
  paLinked:        array[ tDisLang ] of String =
                   ( paLinkedEN, paLinkedFR );
  paSpatial:       array[ tDisLang ] of String =
                   ( paSpatialEN, paSpatialFR );
  paFunctional:    array[ tDisLang ] of String =
                   ( paFunctionalEN, paFunctionalFR );
  paHistological:  array[ tDisLang ] of String =
                   ( paHistologicalEN, paHistologicalFR );
  paPhysical:      array[ tDisLang ] of String =
                   ( paPhysicalEN, paPhysicalFR );
  paPlainLanguage: array[ tDisLang ] of String =
                   ( paPlainLanguageEN, paPlainLanguageFR );
  paDocum:         array[ tDisLang ] of String =
                   ( paDocumEN, paDocumFR );
  paPartonomy:     array[ tDisLang ] of String =
                   ( paPartonomyEN, paPartonomyFR );
  paTaxonomy:      array[ tDisLang ] of String =
                   ( paTaxonomyEN, paTaxonomyFR );
  paBrother:       array[ tDisLang ] of String =
                   ( paBrotherEN, paBrotherFR );
  paInferred:      array[ tDisLang ] of String =
                   ( paInferredEN, paInferredFR );
  paModelTerm:     array[ tDisLang ] of String =
                   ( paModelTermEN, paModelTermFR );
  paTransTerm:     array[ tDisLang ] of String =
                   ( paTransTermEN, paTransTermFR );
  paTreeFormula:   array[ tDisLang ] of String =
                   ( paTreeFormulaEN, paTreeFormulaFR );
  paConcordance:   array[ tDisLang ] of String =
                   ( paConcordanceEN, paConcordanceFR );
  paDisplayTrans:  array[ tDisLang ] of String =
                   ( paDisplayTransEN, paDisplayTransFR );
  paAutoTerm:      array[ tDisLang ] of String =
                   ( paAutoTermEN, paAutoTermFR );
  paNote:          array[ tDisLang ] of String =
                   ( paNoteEN, paNoteFR );
  paNote98:        array[ tDisLang ] of String =
                   ( paNote98EN, paNote98FR );
  paNoteEr:        array[ tDisLang ] of String =
                   ( paNoteErEN, paNoteErFR );
  paNote10:        array[ tDisLang ] of String =
                   ( paNote10EN, paNote10FR );
  paNoteProb:      array[ tDisLang ] of String =
                   ( paNoteProbEN, paNoteProbFR );
  paNoteRv:        array[ tDisLang ] of String =
                   ( paNoteRvEN, paNoteRvFR );
  paNoteTn:        array[ tDisLang ] of String =
                   ( paNoteTnEN, paNoteTNFR );
  paNoteTx:        array[ tDisLang ] of String =
                   ( paNoteTxEN, paNoteTxFR );
  paNoteSc:        array[ tDisLang ] of String =
                   ( paNoteScEN, paNoteScFR );
  paNoteImpl:      array[ tDisLang ] of String =
                   ( paNoteImplEN, paNoteImplFR );
  paNoteTra:       array[ tDisLang ] of String =
                   ( paNoteTraEN, paNoteTraFR );
  paProperty:      array[ tDisLang ] of String =
                   ( paPropertyEN, paPropertyFR );
  paLinkage:       array[ tDisLang ] of String =
                   ( paLinkageEN, paLinkageFR );
  paOptExpansion:  array[ tDisLang ] of String =
                   ( paOptExpansionEN, paOptExpansionFR );
  paRefNoun:       array[ tDisLang ] of String =
                   ( paRefNounEN, paRefNounFR );
  paRefCompl:      array[ tDisLang ] of String =
                   ( paRefComplEN, paRefComplFR );
  paRefAdj:        array[ tDisLang ] of String =
                   ( paRefAdjEN, paRefAdjFR );
  paOriginTerm:    array[ tDisLang ] of String =
                   ( paOriginTermEN, paOriginTermFR );
  paBasicPart:     array[ tDisLang ] of String =
                   ( paBasicPartEN, paBasicPartFR );
  paAdjExpansion:  array[ tDisLang ] of String =
                   ( paAdjExpansionEN, paAdjExpansionFR );
  paFormula:       array[ tDisLang ] of String =
                   ( paFormulaEN, paFormulaFR );

                   // Bubbles for paragraph and subparagraph headings
                   // English texts
  baOptExpansionEN = 'An optional expansion of the basic part of a term';
  baRefNounEN      = 'A representative noun of an anatomical unit';
  baRefComplEN     = 'A representative noun complement of an anatomical unit';
  baRefAdjEN       = 'A representative adjective of an anatomical unit';
  baOriginTermEN   = 'The full term at origin of the model';
  baBasicPartEN    = 'The mandatory part of the term';
  baFormulaEN      = 'The universal formula independent of any language';
                   // French texts
  baOptExpansionFR = 'Une extension facultative de la partie basique d''un terme';
  baRefNounFR      = 'Un nom représenatif d''une unité anatomique';
  baRefComplFR     = 'Un complément de nom représenatif d''une unité anatomique';
  baRefAdjFR       = 'Un adjectif représenatif d''une unité anatomique';
  baOriginTermFR   = 'Le terme plein à l''origine du modèle';
  baBasicPartFR    = 'La partie obligatoire du terme';
  baFormulaFR      = 'La formule universelle du terme indépendante de toute langue';
                   // Bilingual recipients
  baOptExpansion:  array[ tDisLang ] of String =
                   ( baOptExpansionEN, baOptExpansionFR );
  baRefNoun:       array[ tDisLang ] of String =
                   ( baRefNounEN, baRefNounFR );
  baRefCompl:      array[ tDisLang ] of String =
                   ( baRefComplEN, baRefComplFR );
  baRefAdj:        array[ tDisLang ] of String =
                   ( baRefAdjEN, baRefAdjFR );
  baOriginTerm:    array[ tDisLang ] of String =
                   ( baOriginTermEN, baOriginTermFR );
  baBasicPart:     array[ tDisLang ] of String =
                   ( baBasicPartEN, baBasicPartFR );
  baFormula:       array[ tDisLang ] of String =
                   ( baFormulaEN, baFormulaFR );

                   { * Texts for monovalued properties * }
  puBilatEN        = 'Bilaterality';
  puGeneratorEN    = 'Set generator';
  puGenerEN        = 'Genericity';
  puSpeciEN        = 'Specificity';
  puMultiEN        = 'Composite property';
  puPairEN         = 'Symetrical pair';
  puReferEN        = 'Reference';
  puNewCdEN        = 'Revision';
  puIncstEN        = 'Variant';
  puDimEN          = 'Sexual dimorphism';
  puMSymbEN        = 'Male gender';
  puFSymbEN        = 'Female gender';
  puExpndEN        = 'Expansion';
  puMaterEN        = 'Material';
  puImmatEN        = 'Immaterial';
  puNonPhEN        = 'Non physical';
  puBilatFR        = 'Bilatéralité';
  puGeneratorFR    = 'Générateur d''ensembles';
  puGenerFR        = 'Généricité';
  puSpeciFR        = 'Spécificité';
  puMultiFR        = 'Propriété de collection';
  puPairFR         = 'Paire symétrique';
  puReferFR        = 'Référence';
  puNewCdFR        = 'Revision';
  puIncstFR        = 'Inconstant';
  puDimFR          = 'Dimorphisme sexuel';
  puMSymbFR        = 'Genre masculin';
  puFSymbFR        = 'Genre féminin';
  puExpndFR        = 'Expansion';
  puMaterFR        = 'Matériel';
  puImmatFR        = 'Immatériel';
  puNonPhFR        = 'Non physique';
  puBilatTextEN    = 'This entity has left and right members.';
  puGeneratorTextEN= 'This entity is generator of a set.';
  puGenerTextEN    = 'This entity is generic (no direct instance).';
  puSpeciTextEN    = 'This entity is specific.';
  puMultiTextEN    = 'This entity is a set of entities.';
  puPairTextEN     = 'This entity is a symetrical pair.';
  puReferTextEN    = 'This entity is a reference to another entity.';
  puNewCdTextEN    = 'This entity has been redefined in the present TA version.';
  puIncstTextEN    = 'This entity is inconstant.';
  puDimTextEN      = 'This entity is sexually dimorphic.';
  puMSymbTextEN    = 'This entity is male gender-specific.';
  puFSymbTextEN    = 'This entity is female gender-specific.';
  puExpndTextEN    = 'This entity is mandatorily expanded from its base term.';
  puMaterTextEN    = 'This entity represents a material object.';
  puImmatTextEN    = 'This entity represents an immaterial object (no mass).';
  puNonPhTextEN    = 'This entity is a non physical object.';
  puBilatTextFR    = 'Cette entité a un membre gauche et un membre droit.';
  puGeneratorTextFR= 'Cette entité est un générateur d''ensemble.';
  puGenerTextFR    = 'Cette entité est générique (pas d''instance directe).';
  puSpeciTextFR    = 'Cette entité est spécifique.';
  puMultiTextFR    = 'Cette entité est un ensemble d''entités.';
  puPairTextFR     = 'Cette entité est une paire d''entités symétriques.';
  puReferTextFR    = 'Cette entité est une référence à une autre entité classée ailleurs.';
  puNewCdTextFR    = 'Cette entité a été en partie redéfinie dans la revision RevTermA.';
  puIncstTextFR    = 'Cette entité est inconstante.';
  puDimTextFR      = 'Cette entité est sexuellement dimorphique.';
  puMSymbTextFR    = 'Cette entité est spécifique au genre masculin.';
  puFSymbTextFR    = 'Cette entité est spécifique au genre féminin.';
  puExpndTextFR    = 'Cette entité est obligatoirement expansée à partir du terme de base.';
  puMaterTextFR    = 'Cette entité représente un objet matériel';
  puImmatTextFR    = 'Cette entité représente un objet immatériel (pas de masse)';
  puNonPhTextFR    = 'Cette entité représente un objet non physique';

  puBilat:         array[ tDisLang ] of String =
                   ( puBilatEN, puBilatFR );
  puGenerator:     array[ tDisLang ] of String =
                   ( puGeneratorEN, puGeneratorFR );
  puGener:         array[ tDisLang ] of String =
                   ( puGenerEN, puGenerFR );
  puSpeci:         array[ tDisLang ] of String =
                   ( puSpeciEN, puSpeciFR );
  puBilatText:     array[ tDisLang ] of String =
                   ( puBilatTextEN, puBilatTextFR );
  puGeneratorText: array[ tDisLang ] of String =
                   ( puGeneratorTextEN, puGeneratorTextFR );
  puGenerText:     array[ tDisLang ] of String =
                   ( puGenerTextEN, puGenerTextFR );
  puSpeciText:     array[ tDisLang ] of String =
                   ( puSpeciTextEN, puSpeciTextFR );
  puMulti:         array[ tDisLang ] of String =
                   ( puMultiEN, puMultiFR );
  puPair:          array[ tDisLang ] of String =
                   ( puPairEN, puPairFR );
  puMultiText:     array[ tDisLang ] of String =
                   ( puMultiTextEN, puMultiTextFR );
  puPairText:      array[ tDisLang ] of String =
                   ( puPairTextEN, puPairTextFR );
  puIncst:         array[ tDisLang ] of String =
                   ( puIncstEN, puIncstFR );
  puIncstText:     array[ tDisLang ] of String =
                   ( puIncstTextEN, puIncstTextFR );
  puDim:           array[ tDisLang ] of String =
                   ( puDimEN, puDimFR );
  puDimText:       array[ tDisLang ] of String =
                   ( puDimTextEN, puDimTextFR );
  puMSymb:         array[ tDisLang ] of String =
                   ( puMSymbEN, puMSymbFR );
  puMSymbText:     array[ tDisLang ] of String =
                   ( puMSymbTextEN, puMSymbTextFR );
  puFSymb:         array[ tDisLang ] of String =
                   ( puFSymbEN, puFSymbFR );
  puFSymbText:     array[ tDisLang ] of String =
                   ( puFSymbTextEN, puFSymbTextFR );
  puMater:         array[ tDisLang ] of String =
                   ( puMaterEN, puMaterFR );
  puImmat:         array[ tDisLang ] of String =
                   ( puImmatEN, puImmatFR );
  puMaterText:     array[ tDisLang ] of String =
                   ( puMaterTextEN, puMaterTextFR );
  puImmatText:     array[ tDisLang ] of String =
                   ( puImmatTextEN, puImmatTextFR );
  puRefer:         array[ tDisLang ] of String =
                   ( puReferEN, puReferFR );
  puReferText:     array[ tDisLang ] of String =
                   ( puReferTextEN, puReferTextFR );
  puNonPh:         array[ tDisLang ] of String =
                   ( puNonPhEN, puNonPhFR );
  puNonPhText:     array[ tDisLang ] of String =
                   ( puNonPhTextEN, puNonPhTextFR );

                   { * HTML Page titles (not visible) * }
  tiSynonymPageEN  = 'Synonym Page';
  tiMultiLgPage    = 'Multilingual Page';
  tiPropertyPageEN = 'Property Page';
  tiUnivPageEN     = 'Universal Page';
  tiDefinPageEN    = 'Definition Page';
  tiTA98LongPageEN = 'Trace TA98 long Page';
  tiTA98ShortPageEN= 'Trace TA98 short Page';
  tiTA98SubPageEN  = 'Trace TA98 subchapter Page';
  tiTA98ChapPageEN = 'Trace TA98 chapter Page';
  tiL4SegmentPageEN= 'Segmentation Page Level 4';
  tiL5SegmentPageEN= 'Segmentation Page Level 5';
  tiValidPageEN    = 'Validation Page';
  tiPartListPageEN = 'Partonomy List';
  tiPart98PageEN   = 'TA98 List';
  tiGenListPageEN  = 'Generic Partonomy List';
  tiTaxListPageEN  = 'Taxonomy List';
  tiProperty98PageEN = 'Property TA98 Page';
  tiTA98PageSectEN = 'TA98 Page by section';
  tiTA98PageChapEN = 'TA98 Page by chapter';
  tiRevAPageSectEN = 'RevTermA Page by section';
  tiRevAPageChapEN = 'RevTermA Page by chapter';
  tiTetraPageEN    = 'Unit Page';
  tiExtendedPageEN = 'Extended Page';
  tiEntityPage98EN = 'TA98 Entity Page';
  tiLatinPageEN    = 'Universal Page';
  tiTestPageEN     = 'Test Page';
  tiLatinPage98EN  = 'TA98 Latin Page';
  tiTAtoFMAPage    = 'TA-FMA Page';
  tiValidationPage = 'Validation Page';
  ti3LanguagePage  = '3 Language Page';
  tiTATermPage     = 'TA Term Page';
  tiStatPageEN     = 'Statistics Page';
  tiAlphaPageEN    = 'Alphabetical Page';
  tiKWICPageEN     = 'KWIC Page';
  tiTA98AlphaPageEN= 'alphabetical Page';
  tiTA98KWICPageEN = 'index';
  tiTA98TopicalEN  = 'topical index';
  tiProbTA98EN     = 'Problem notes TA98';
  tiNotesPageTA98EN= 'Notes Page TA98';
  tiHierarPageEN   = 'Hierarchy Page';
  tiSinglePageEN   = 'Single letter Page';
  tiThreePageEN    = 'Three letters Page';
                   // French texts
  tiSynonymPageFR  = 'Page de synonymes';
  tiPropertyPageFR = 'Page de propriétés';
  tiDefinPageFR    = 'Page de définitions';
  tiTA98LongPageFR = 'Page de liste longue TA98';
  tiTA98ShortPageFR= 'Page de liste courte TA98';
  tiTA98SubPageFR  = 'Page de liste souschapitre TA98';
  tiTA98ChapPageFR = 'Page de liste chapitre TA98';
  tiL4SegmentPageFR= 'Page de segmentation niveau 4';
  tiL5SegmentPageFR= 'Page de segmentation niveau 5';
  tiValidPageFR    = 'Page de validation';
  tiPartListPageFR = 'Liste partonomique';
  tiPart98PageFR   = 'Liste TA98';
  tiGenListPageFR  = 'Liste partonomique générique';
  tiTaxListPageFR  = 'Liste taxonomique';
  tiTA98PageFR     = 'Page TA98';
  tiTA98PageSectFR = 'TA98 Page par section';
  tiTA98PageChapFR = 'TA98 Page par chapitre';
  tiRevAPageSectFR = 'RevTermA Page par section';
  tiRevAPageChapFR = 'RevTermA Page par chapitre';
  tiTetraPageFR    = 'Page Unité';
  tiExtendedPageFR = 'Page Entité étendue';
  tiLatinPageFR    = 'Page universelle';
  tiTestPageFR     = 'Page de test du langage';
  tiStatPageFR     = 'Page Statistique';
  tiAlphaPageFR    = 'Page alphabétique';
  tiKWICPageFR     = 'Page alphabétique KWIC';
  tiHierarPageFR   = 'Hierarchy Page';

                   { Bilingual constants }
  tiTetraPage:     array[ tDisLang ] of String =
                   ( tiTetraPageEN, tiTetraPageFR );
  tiPartListPage:  array[ tDisLang ] of String =
                   ( tiPartListPageEN, tiPartListPageFR );
  tiPart98Page:    array[ tDisLang ] of String =
                   ( tiPart98PageEN, tiPart98PageFR );
  tiGenListPage:   array[ tDisLang ] of String =
                   ( tiGenListPageEN, tiGenListPageFR );
  tiTaxListPage:   array[ tDisLang ] of String =
                   ( tiTaxListPageEN, tiTaxListPageFR );
  tiLatinPage:     array[ tDisLang ] of String =
                   ( tiLatinPageEN, tiLatinPageFR );
  tiTestPage:      array[ tDisLang ] of String =
                   ( tiTestPageEN, tiTestPageFR );
  tiPropertyPage:  array[ tDisLang ] of String =
                   ( tiPropertyPageEN, tiPropertyPageFR );
  tiDefinPage:     array[ tDisLang ] of String =
                   ( tiDefinPageEN, tiDefinPageFR );
  tiTA98LongPage:  array[ tDisLang ] of String =
                   ( tiTA98LongPageEN, tiTA98LongPageFR );
  tiTA98ShortPage: array[ tDisLang ] of String =
                   ( tiTA98ShortPageEN, tiTA98ShortPageFR );
  tiTA98SubPage:   array[ tDisLang ] of String =
                   ( tiTA98SubPageEN, tiTA98SubPageFR );
  tiTA98ChapPage:  array[ tDisLang ] of String =
                   ( tiTA98ChapPageEN, tiTA98ChapPageFR );
  tiL4SegmentPage: array[ tDisLang ] of String =
                   ( tiL4SegmentPageEN, tiL4SegmentPageFR );
  tiL5SegmentPage: array[ tDisLang ] of String =
                   ( tiL5SegmentPageEN, tiL5SegmentPageFR );
  tiValidPage:     array[ tDisLang ] of String =
                   ( tiValidPageEN, tiValidPageFR );

                   { * Field (or column) headers * }
  fdInBubbleEN     = 'in bubble';
  fdRefIDEN        = 'Ref ID';
  fdTACodeEN       = 'TA Code';
  fdTA98CodeEN     = 'TA98 Code';
  fdPartialCodeEN  = 'TA partial code';
  fdTitleEN        = 'Hierarchy title';
  fdItemsEN        = 'Items';
  fdEntriesEN      = 'Entries';
  fdTermsEN        = 'Terms';
  fdEntityEN       = 'Entities';
  fdNotesEN        = 'Notes';
  fdDateEN         = 'Date';
  fdRefsEN         = 'Refs';
  fdReferencesEN   = 'References';
  fdUpdatesEN      = 'Updates';
  fdSectionsEN     = 'Sections';
  fdSubChaptersEN  = 'Subchapters';
  fdLinesEN        = 'Lines';
  fdAncestorTID    = 'Anc';
  fdChildType      = 'Child';
  fdLinkType       = 'Link';
  fdParentType     = 'Parent';
  fdNoteEN         = 'Note';
  fdExpTID         = 'Exp';
  fdOfficialEN     = 'Latin official term';
  fdENEquivalentEN = 'English equivalent';
  fdLGEquivalentEN = 'Language equivalent';
  fdBaseTermEN     = 'Base term';
  fdLatinTermEN    = 'Latin term';
  fdEnglishTermEN  = 'English term';
  fdExpandedEN     = 'Expanded term';
  fdGenericEN      = 'Generic entity';
  fdSortingEN      = 'Sorting entity';
  fdKeyWordEN      = 'Key word';
  fdTopicEN        = 'Topical word';
  fdSectionEN      = 'SECTION';
  fdItemEN         = 'Item or Ref ID';
  fdValueEN        = 'Value or text';
  fdBySectionEN    = 'by section';
  fdByChapterEN    = 'by chapter';
  fdEntireTAEN     = 'entire TA';
  fdDevFlagEN      = 'experimental version';
  fdVersion98EN    = 'version 98';
  fdVersion10EN    = 'version RevTermA';
  fdPrecursorEN    = 'Original precursor term';
  fdByGroupsEN     = 'thesaurus grouping';
  fdByWordsEN      = 'by words';
  fdDeclensionEN   = 'actual declension';
  fdWordEN         = 'actual word';
                   { French texts }
  fdInBubbleFR     = 'en bulle';
  fdRefIDFR        = 'ID réf.';
  fdTACodeFR       = 'Code TA';
  fdTA98CodeFR     = 'Code TA98';
  fdPartialCodeFR  = 'Code TA partiel';
  fdTitleFR        = 'Titre de hiérarchie';
  fdItemsFR        = 'Items';
  fdEntriesFR      = 'Entrées';
  fdTermsFR        = 'Termes';
  fdEntityFR       = 'Entités';
  fdNotesFR        = 'Notes';
  fdSectionsFR     = 'Sections';
  fdSubChaptersFR  = 'Sous-chapitres';
  fdLinesFR        = 'Lignes en français';
  fdDateFR         = 'Date de création';
  fdRefsFR         = 'Réfs';
  fdReferencesFR   = 'Références';
  fdUpdatesFR      = 'Revisés';
  fdOfficialFR     = 'Terme officiel en Latin';
  fdENEquivalentFR = 'Equivalent anglais';
  fdFREquivalentFR = 'Equivalent français';
  fdBaseTermFR     = 'Terme de base';
  fdLatinTermFR    = 'Terme latin';
  fdEnglishTermFR  = 'Terme anglais';
  fdExpandedFR     = 'Terme expansé';
  fdGenericFR      = 'Entité générique';
  fdSortingFR      = 'Entité de tri';
  fdKeyWordFR      = 'Mot clef';
  fdSectionFR      = 'SECTION';
  fdItemFR         = 'Item ou ID réf';
  fdValueFR        = 'Valeur ou texte';
  fdBySectionFR    = 'par section';
  fdByChapterFR    = 'par chapitre';
  fdDevFlagFR      = 'version expérimentale';
  fdVersion98FR    = 'version 98';
  fdVersion10FR    = 'version RevTermA';
  fdPrecursorFR    = 'Terme précurseur original';
  fdByGroupsFR     = 'par groupes';
  fdByWordsFR      = 'par mots';
  fdDeclensionFR   = 'déclinaison actuelle';
  fdWordFR         = 'mot actuel';

                   { Bilingual constants }
  fdDate:          array[ tDisLang ] of String =
                   ( fdDateEN, fdDateFR );
  fdSection:       array[ tDisLang ] of String =
                   ( fdSectionEN, fdSectionFR );
  fdItem:          array[ tDisLang ] of String =
                   ( fdItemEN, fdItemFR );
  fdValue:         array[ tDisLang ] of String =
                   ( fdValueEN, fdValueFR );
  fdTA98Code:      array[ tDisLang ] of String =
                   ( fdTA98CodeEN, fdTA98CodeFR );
  fdDevFlag:       array[ tDisLang ] of String =
                   ( fdDevFlagEN, fdDevFlagFR );
  fdDisLang:       array[ tDisLang ] of String =
                   ( 'English', 'français' );
  fdEntries:       array[ tDisLang ] of String =
                   ( fdEntriesEN, fdEntriesFR );
  fdRefID:         array[ tDisLang ] of String =
                   ( fdRefIDEN, fdRefIDFR );
  fdExpanded:      array[ tDisLang ] of String =
                   ( fdExpandedEN, fdExpandedFR );
  fdOfficial:      array[ tDisLang ] of String =
                   ( fdOfficialEN, fdOfficialFR );
  fdInBubble:      array[ tDisLang ] of String =
                   ( fdInBubbleEN, fdInBubbleFR );

type
                   { * Enumeration type for working languages. *
                   Description:
                   Working languages are necessarily selected within this
                   enumeration type. But this list is more extensive than
                   implemented languages, except may be small demonstrators.
                   It is the application responsability to limit the selection
                   of a new working languages according to the presence of
                   the corresponding dictionary and language knowledge.<P> }
  tLanguage        = (
                   lt_Latin, lt_English, lt_French, lt_Spanish, lt_Russian,
                   lt_Italian, lt_Dutch, lt_German, lt_Portugese, lt_Swedish,
                   lt_Danish, lt_Greek, lt_Finnish, lt_Norvegian, lt_Roumanian,
                   lt_Universal, lt_None );

                   // Count by language
  tCountLg         = Array [ lt_Latin .. lt_Russian ] of Integer;

                   { * Enumeration type for TAH partonomic links *
                   Description:
                   Partonomic links in TAH are necessary limited to a set
                   of predefined values, which are described by this
                   enumeration type. The undefined value is normally never used
                   because a type is mandatory.<P> }
  tLink            = (
                   // Material from material
                   pw_PartOf,                // mat PartOf mat
                   pw_BranchOf,              // mat BranchOf mat
                   pw_MemberOf,              // mat MemberOf set
                   pw_MemberL,               // mat MemberL pair mat
                   pw_MemberR,               // mat MemberR pair mat
                   pw_MemberF,               // mat MemberF hom mat
                   pw_MemberM,               // mat MemberM hom mat

                   pw_SetOf,                 // set mat SetOf mat
                   pw_SubsetOf,              // set mat SubsetOf set mat
                   pw_SMemberL,              // set mat SMemberL pset mat
                   pw_SMemberR,              // set mat SMemberR pset mat

                   pw_PairOf,                // pair mat PairOf mat
                   pw_BranchPairOf,          // pair mat BranchPairOf mat
                   pw_PairMemberOf,          // pair mat PairMemberOf set mat
                   pw_PairPartOf,            // pair mat PairPartOf pair mat
                   pw_PairBranchOf,          // pair mat PairBranchOf pair mat
                   pw_PMemberOf,             // pair mat PMemberOf pset mat

                   pw_PairSetOf,             // pset mat PairSetOf mat
                   pw_PairSetBranchOf,       // pset mat PairSetBranchOf mat
                   pw_PairSetPairOf,         // pset mat PairSetPairOf pair mat
                   pw_PairSetPairBranchOf,   // pset mat PairSetPairBranchOf pair mat
                   pw_PairSubsetOf,          // pset mat PairSubsetOf pset mat

                   // Immaterial from material
                   pw_SpaceOf,               // imm SpaceOf mat
                   pw_SurfaceOf,             // imm SurfaceOf mat
                   pw_LineOf,                // imm LineOf mat
                   pw_PointOf,               // imm PointOf mat

                   pw_ImmSetOf,              // set imm ImmSetOf mat
                   pw_ImmSubsetOf,           // set imm ImmSubsetOf set mat

                   pw_QSpaceOf,              // pair imm QSpaceOf mat
                   pw_QSurfaceOf,            // pair imm QSurfaceOf mat
                   pw_QLineOf,               // pair imm QLineOf mat
                   pw_QPointOf,              // pair imm QPointOf mat
                   pw_QSpacePairOf,          // pair imm QSpacePairOf pair mat
                   pw_QSurfacePairOf,        // pair imm QSurfacePairOf pair mat
                   pw_QLinePairOf,           // pair imm QLinePairOf pair mat
                   pw_QMemberPairOf,         // pair imm QMemberPairOf pset mat

                   pw_ImmPairSetOf,          // qset imm ImmPairSetOf mat
                   pw_ImmPairSetPairOf,      // qset imm ImmPairSetPairOf pair mat
                   pw_ImmPairSetPsetOf,      // qset imm ImmPairSetPsetOf pset mat

                   // Immaterial from immaterial
                   pw_SpaceIn,               // imm SpaceIn imm
                   pw_SurfaceIn,             // imm SurfaceIn imm
                   pw_LineIn,                // imm LineIn imm
                   pw_MemberIn,              // imm MemberIn set imm
                   pw_IMemberL,              // imm IMemberL pair imm
                   pw_IMemberR,              // imm IMemberR pair imm

                   pw_SetIn,                 // set imm SetIn imm
                   pw_SubsetIn,              // set imm SubsetIn set imm
                   pw_TMemberL,              // set imm TMemberL pset imm
                   pw_TMemberR,              // set imm TMemberR pset imm

                   pw_PairSpaceIn,           // pair imm PairSpaceIn imm
                   pw_PairSurfaceIn,         // pair imm PairSurfaceIn imm
                   pw_PairLineIn,            // pair imm PairLineIn imm
                   pw_PairMemberIn,          // pair imm PairPointIn imm
                   pw_PairSpacePairIn,       // pair imm PairSpacePairIn imm
                   pw_PairSurfacePairIn,     // pair imm PairSurfacePairIn imm
                   pw_PairLinePairIn,        // pair imm PairLinePairIn imm
                   pw_PairMemberPairIn,      // pair imm PairMemberIn qset

                   pw_PairSetIn,             // pair set imm PairSetIn imm
                   pw_PairSubSetIn,          // qset imm PairSubSetIn qset imm

                   // Others
                   pw_MemberNon,             // non MemberNon set
                   pw_NonPhys,               // non PartNon mat
                   pw_Display,               // any
                   pw_top,                   // top of hierarchy, no link
                   pw_Undef,                 // undefined
                   pw_Invalid );             // invalid

                   // Enumeration type for TAH entity type
  tType            = (
                   to_Undef,                 // undefined
                   to_Mat,                   // material single
                   to_Imm,                   // immaterial single (no mass)
                   to_SetMat,                // material set
                   to_SetImm,                // immaterial set
                   to_ParMat,                // material symmetrical pair
                   to_ParImm,                // immaterial symmetrical pair
                   to_PstMat,                // material pset
                   to_PstImm,                // immaterial pset
                   to_MstMat,                // material mixed set
                   to_MstImm,                // immaterial mixed set
                   to_HomMat,                // material homologs pair
                   to_HomImm,                // immaterial homologs pair
                   to_Del,                   // deleted entity
                   to_Non );                 // non-physical entity

                   // Validation type for links
  tChildFather     = ( is_Child, is_Father );
  ChildFather      = Array[ tChildFather ] of tType;

                   // Entity type from unit type
  tUnitChildFather = ( is_UChild, is_UFather );
  UnitChildFather  = Array[ tUnitChildFather ] of tType;

                   { Type of terms and synonyms }
  tSynType         = (
                   st_Bas,                   // Base term
                   st_plm,                   // Plural term main
                   st_pl1,                   // Plural term synonym 1
                   st_pl2,                   // Plural term synonym 2
                   st_pl3,                   // Plural term synonym 3
                   st_Bat,                   // Stored autogenerated base term
                   st_Bis,                   // Base term replaced by Latin model
                   st_Exp,                   // Expanded base term
                   st_Off,                   // First official synonym
                   st_Of2,                   // Second official synonym
                   st_Of3,                   // Third official synonym
                   st_Ofd,                   // First synonym in display form
                   st_Od2,                   // Second synonym in display form
                   st_Od3,                   // Third synonym in display form
                   st_her,                   // Main term from main formula
                   st_hrm,                   // Main term from main formula
                   st_hr1,                   // Main term from syn1 formula
                   st_hr2,                   // Main term from syn2 formula
                   st_hr3,                   // Main term from syn3 formula
                   st_hra,                   // Main term from plus formula
                   st_h1m,                   // Syn1 term from Main formula
                   st_h11,                   // Syn1 term from Syn1 formula
                   st_h12,                   // Syn1 term from Syn2 formula
                   st_h13,                   // Syn1 term from Syn3 formula
                   st_h1a,                   // Syn1 term from Plus formula
                   st_h2m,                   // Syn2 term from Main formula
                   st_h21,                   // Syn2 term from Syn1 formula
                   st_h22,                   // Syn2 term from Syn2 formula
                   st_h23,                   // Syn2 term from Syn3 formula
                   st_h2a,                   // Syn2 term from Plus formula
                   st_h3m,                   // Syn3 term from Main formula
                   st_h31,                   // Syn3 term from Syn1 formula
                   st_h32,                   // Syn3 term from Syn2 formula
                   st_h33,                   // Syn3 term from Syn3 formula
                   st_h3a,                   // Syn3 term from Plus formula
                   st_dl1,                   // Deleted synonym 1
                   st_dl2,                   // Deleted synonym 2
                   st_dl3,                   // Deleted synonym 3
                   st_RAT,                   // Non RAT-compliant term
                   st_mam,                   // Managed term main
                   st_ma1,                   // Managed term synonym 1
                   st_ma2,                   // Managed term synonym 1
                   st_ma3,                   // Managed term synonym 1
                   st_irr,                   // Zrregular term
                   st_irm,                   // Irregular term main
                   st_ir1,                   // Irregular term synonym 1
                   st_ir2,                   // Irregular term synonym 2
                   st_ir3,                   // Irregular term synonym 3
                   st_FMA,                   // FMA official English term
                   st_BNA,                   // Basle Nomina Anatomica 1916
                   st_Dis,                   // Alternate for st_DisM
                   st_DsM,                   // Display term for main term
                   st_Ds1,                   // Display term for synonym 1
                   st_Ds2,                   // Display term for synonym 2
                   st_Ds3,                   // Display term for synonym 3
                   st_NOS,                   // NOS (simplified unexpanded)
                   st_NOR,                   // NOS with RAT
                   st_Dit,                   // Stored display synonym
                   st_Syn,                   // Additional synonym
                   st_Epo,                   // Eponym
                   st_Nam,                   // Name of author in eponym
                   st_Acr,                   // Acronym
                   st_Dep,                   // Depreciated term
                   st_Gen,                   // Genitive form
                   st_Ori,                   // Original term
                   st_Alt,                   // Alternate original term
                   st_Ini,                   // Initial TA98 term
                   st_His,                   // Historical term
                   st_Usa,                   // US English symbol
                   st_All,                   // All synonyms
                   st_Mod,                   // Model for preferred term
                   st_Mdm,                   // Model for preferred term
                   st_Md1,                   // Model for 1st synonym
                   st_Md2,                   // Model for 2nd synonym
                   st_Md3,                   // Model for 3rd synonym
                   st_Mda,                   // Additional model
                   st_Nou,                   // Vocabulary: noun
                   st_Adj,                   // Vocabulary: adjective
                   st_Pre,                   // Vocabulary: prefix
                   st_Inv,                   // Vocabulary: invariant
                   st_For,                   // Term from model
                   st_frm,                   // Formula term main
                   st_fr1,                   // Formula term synonym 1
                   st_fr2,                   // Formula term synonym 2
                   st_fr3,                   // Formula term synonym 3
                   st_tex,                   // text item
                   st_bul,                   // bubble text item
                   st_tit,                   // title item
                   st_dab,                   // data base item
                   st_val,                   // expected value
                   st_vl2,                   // second expected value
                   st_undef );               // Undefined

                   // Type of libelle
  tLibelleType     = (
                   lb_Undef,                 // Undefined libelle type
                   lb_Official,              // Official libelle
                   lb_Regular,               // Regular official libelle
                   lb_Synonym,               // First synonym
                   lb_Synonym2,              // Second synonym
                   lb_Synonym3,              // Third synonym
                   lb_Single,                // Single type
                   lb_Base,                  // Base libelle
                   lb_Universal,             // Universal libelle
                   lb_Text,                  // Text
                   lb_Bubble,                // Text for a bubble
                   lb_Value,                 // Text value
                   lb_Title );               // Title

                   { Type of definitions }
  tDefType         = (
                   dt_Undef,                 // Undefined type
                   dt_Encyclopedic,          // Encyclopedic definition
                   dt_Taxonomic,             // Taxonomic definition
                   dt_Spatial,               // Spatial definition
                   dt_Functional,            // Functional definition
                   dt_Physical );            // Physical definition

                   { Type of notes }
  tNoteType        = (
                   nt_TA98,                  // TA98 end-of-page note
                   nt_Error,                 // TA98 obvious error note
                   nt_RAT,                   // TA98 problem note
                   nt_Redirection,           // TA98 redirection note
                   nt_Problem,               // TA98 problem note
                   nt_RevTermA,              // Old RevTermA update note
                   nt_Revision,              // RevTermA update note
                   nt_Taxonomy,              // Taxonomy change note
                   nt_Scientific,            // Scientific note
                   nt_Implement,             // Implementation note
                   nt_Translation,           // Translation note
                   nt_Del98,                 // Deleted from TA98 note
                   nt_Terminology,           // Terminology note
                   nt_Universal,             // Universal note
                   nt_Undefined );           // Undefined note

                   { Versions definition }
  tVersion         = (
                   vr_98,                    // Original TA98 version
                   vr_10,                    // RevTermA 2010
                   vr_xx );                  // Any version

                   // Partonomy levels, valid for TA98
  tLevel           = (
                   lv_1,                     // title 1 (no code)
                   lv_2,                     // title 2 (no code)
                   lv_3,                     // title 3
                   lv_4,                     // title 4
                   lv_5,                     // title 5
                   lv_6,                     // title 6
                   lv_7,                     // title 7
                   lv_a,                     // indentation 0 times
                   lv_b,                     // indentation 1 times
                   lv_c,                     // indentation 2 times
                   lv_d,                     // indentation 3 times
                   lv_e,                     // indentation 4 times
                   lv_f,                     // indentation 5 times
                   lv_k,                     // hidden entry
                   lv_undef );               // undefined level

                   { Display specification }
  tDisplay         = (
                   ds_u,                     // undefined
                   ds_t,                     // top hierarchy or level T
                   ds_c,                     // chapter partonomy
                   ds_d,                     // chapter taxonomy
                   ds_s,                     // Level S
                   ds_r,                     // Level R
                   ds_q,                     // Level Q
                   ds_p,                     // Level P
                   ds_e );                   // leaf of hierarchy

                   { Properties type }
  tPropType        = (
                   pt_has_insertion,         // has_insertion
                   pt_has_nerve,             // has_nerve
                   pt_has_artery,            // has_artery
                   pt_has_vein,              // has_vein
                   pt_has_origin,            // has_origin
                   pt_part_of,               // part_of
                   pt_located_in,            // located_in
                   pt_adjacent_to,           // adjacent_to
                   pt_subset_of,             // subset_of
                   pt_member_of,             // member_of

                   pt_is_junction_of,        // is_junction_of
                   pt_member_in,             // member_in
                   pt_has_function,          // has_function
                   pt_branch_of,             // branch_of
                   pt_has_part,              // has_part
                   pt_is_insertion_of,       // is_insertion_of
                   pt_is_nerve_of,           // is_nerve_of
                   pt_is_artery_of,          // is_artery_of
                   pt_is_vein_of,            // is_vein_of
                   pt_is_origin_of,          // is_origin_of

                   pt_is_location_of,        // is_location_of
                   pt_has_subset,            // has_subset
                   pt_has_member,            // has_member
                   pt_xxx,                   // place holder
                   pt_is_function_of,        // is_function_of
                   pt_has_branch,            // has_branch
                   pt_has_target,            // has_target
                   pt_is_target_of,          // is_target_of
                   pt_contains,              // contains
                   pt_contained_in,          // contained_in

                   pt_longitudinal_to,       // longitudinal_to
                   pt_has_attachment,        // has_attachment
                   pt_is_attachment_of,      // is_attachment_of
                   pt_has_junction,          // has_junction
                   pt_has_continuation,      // has_continuation
                   pt_is_continuation_of,    // is_continuation_of
                   pt_is_boundary_of,        // is_boundary_of
                   pt_has_boundary,          // has_boundary
                   pt_next_in_sequence,      // next_in_sequence
                   pt_prev_in_sequence,      // prev_in_sequence

                   pt_is_surface_of,         // is_surface_of
                   pt_has_surface,           // has_surface
                   pt_is_side_of,            // is_side_of
                   pt_has_side,              // has_side
                   pt_is_joint_with,         // is_joint_with
                   pt_has_bone,              // has_bone
                   pt_is_bone_of,            // is_bone_of
                   pt_is_Snerve_of,          // is_Snerve_of
                   pt_has_Snerve,            // has_Snerve
                   pt_has_track_origine,     // has_track_origine

                   pt_is_track_origine_of,   // is_track_origine_of
                   pt_has_termination,       // has_termination
                   pt_is_termination_of,     // is_termination_of
                   pt_Ncontains,             // contains a nerve bundle
                   pt_is_Ncontained_in,      // container of a nerve bundle
                   pt_is_Lcontained_in,      // container of a body fluid
                   pt_Lcontains,             // contains a body fluid
                   pt_space_adjacent_to,     // is_space_adjacent_to
                   pt_has_adjacent_space     // has_adjacent_space
                   );

                   // Term model contribution
  tContrib         = (
                   co_Undefined,             // Undefined contribution
                   co_Noun,                  // Noun
                   co_Compl,                 // Noun complement
                   co_Adj,                   // Adjective
                   co_Pref,                  // Prefix
                   co_Inv,                   // Invariant
                   co_Group,                 // Group mandatory or optional
                   co_Ref );                 // Inclusion of partial model

                   // Origin of  a single term
  tBuild           = (
                   bd_undef,                 // Undefined origin
                   bd_direct,                // Language specific origin
                   bd_stored,                // Stored autogenerated term
                   bd_auto,                  // Autogeneration
                   bd_model );               // Model generation

                   { Section type for HTML pages }
  tSectionType     = (
                   sc_Undef,                 // Undefined section
                   sc_Identification,        // Identification section
                   sc_Navigation,            // Navigation section
                   sc_Interface,             // Interface section
                   sc_Navig4,                // Navigation level-4 section
                   sc_Latin,                 // Latin section
                   sc_English,               // English section
                   sc_French,                // French section
                   sc_Spanish,               // Spanish section
                   sc_Russian,               // Russian section
                   sc_Italian,               // Italian section              #10
                   sc_German,                // German section
                   sc_Portugese,             // Portugese section
                   sc_Definition,            // Definition section
                   sc_Documentation,         // Documentation section
                   sc_Sequence,              // Sequence section
                   sc_Property,              // Property section
                   sc_Vocabulary,            // Vocabulary section
                   sc_Level,                 // Level section
                   sc_Linkage,               // Linkage section
                   sc_Note,                  // Note section                 #20
                   sc_FullPartonomy,         // Full partonomy section
                   sc_LightPartonomy,        // Light partonomic section
                   sc_Taxonomy,              // Taxonomy section
                   sc_LatinModel,            // Model section
                   sc_TermDesign,            // Term anatomy
                   sc_Analysis,              // Term analysis section
                   sc_Syntax,                // Syntax section
                   sc_Declension,            // Declension section
                   sc_TaxDefinListe,         // Taxonomic definitions section
                   sc_PartDefinListe,        // Partonomic definitions section
                   sc_SegLevel5Short,        // Level-5 short list section   #31
                   sc_SegLevel5Full,         // Level-5 full list section
                   sc_SegLevel4,             // Level-4 list section
                   sc_TA98Navigation,        // Navigation for TA98 lists
                   sc_TA98List,              // Trace lists TA98
                   sc_TA98Notes,             // Notes TA98
                   sc_ValidTerm,             // Validation of terms
                   sc_ValidFormula,          // Validation of formulas
                   sc_ValidVocab,            // Validation of vocabulary
                   sc_NavList,               // List navigation section      #40
                   sc_PartList,              // Partonomy list section
                   sc_TaxList,               // Taxonomy list section
                   sc_IntList,               // Interface list section
                   sc_NoteList,              // Note list section
                   sc_Reference,             // Reference section
                   sc_TreeFormula,           // Tree formula section
                   sc_Concordance,           // Concordance section
                   sc_ActionList,            // Intermediate translation section
                   sc_Translation,           // Translation section
                   sc_DisplayTrans,          // Display translation section  #50
                   sc_AutoTerm,              // Automatic term section
                   sc_StatUniv,              // Statistic universal
                   sc_ValidUniv,             // Universal validation
                   sc_Signature,             // List signature
                   sc_Part98,                // Partonomy TA98 List
                   sc_TestAdjGender,         // Test gender of adjectives
                   sc_RuleAdjGender,         // Rules for of adjective gender
                   sc_FreeAdjGender,         // Free test gender of adjectives
                   sc_TestNounGender,        // Test gender of noun gender
                   sc_RuleNounGender,        // Rules for for noun gender    #60
                   sc_FreeNounGender,        // Free test for noun gender
                   sc_TestNounPlural,        // Test gender of noun gender
                   sc_RuleWordPlural,        // Rules for for word plural
                   sc_RuleNounPlural,        // Rules for for noun plural
                   sc_FreeNounPlural,        // Free test for noun plural
                   sc_RuleAdjPlural,         // Rules for for adjective plural
                   sc_TestAdjPlural,         // Test plural of adjectives
                   sc_FreeAdjPlural,         // Free test plural of adjectives
                   sc_RuleNounGenSin,        // Rules for genitive sing nouns
                   sc_TestNounGenSin,        // Test for genitive sing nouns #70
                   sc_FreeNounGenSin,        // Free test for gen sing nouns
                   sc_RuleAdjGenSin,         // Rules for genitive singular adj
                   sc_TestAdjGenSin,         // Test for genitive singular adj
                   sc_FreeAdjGenSin,         // Free test for genitive sing adj
                   sc_RuleNounGenPlu,        // Rules for genitive plural nouns
                   sc_TestNounGenPlu,        // Test for genitive plural nouns
                   sc_FreeNounGenPlu,        // Free test for gen plural nouns
                   sc_RuleAdjGenPlu,         // Rules for genitive plural adj
                   sc_TestAdjGenPlu,         // Test for genitive plural adj
                   sc_FreeAdjGenPlu,         // Free test for gen plural adj #80
                   sc_TestNoExp,             // Test terms without expansion
                   sc_TestAdjExp,            // Test adjective expansion
                   sc_RuleAdjExp,            // Rules for adjective expansion
                   sc_FreeAdjExp,            // Free test adjective expansion
                   sc_TestMandExp,           // Test mandatory expansion
                   sc_TestLatExp,            // Test expansion with bilateral t.
                   sc_TestOptExp );          // Test optional expansion      #87

                   // Type of value for language
  tValueType       = (
                   va_word,                  // first argument value
                   va_1,                     // second argument value
                   va_2,                     // third argument value
                   va_3,                     // value of TID
                   va_4,                     // value reference 1
                   va_5 );                   // value reference 2

                   // Type of bilateral entities
  tLaterality      = (
                   la_none,                  // undefined
                   la_unspec,                // unspecified
                   la_left,                  // left of a pair
                   la_right );               // right of a pair

                   // Gender
  tGender          = (
                   ge_none,                  // undefined
                   ge_unspec,                // unspecified
                   ge_masculine,             // masculine
                   ge_feminine,              // feminine
                   ge_neuter );              // neuter

                   // Case
  tCase            = (
                   ca_none,                  // undefined
                   ca_unspec,                // unspecified
                   ca_nom,                   // nominative
                   ca_gen );                 // genitive

                   // Number
  tNumber          = (
                   nu_none,                  // undefined
                   nu_unspec,                // unspecified
                   nu_sin,                   // singular
                   nu_plu,                   // plural
                   nu_plf,                   // plural feminine
                   nu_pln );                 // plural neuter

                   // Bilateral value type: gender + case + number
  tLatType         = (
                   lt_undef,                 // undefined value
                   lt_mns,                   // masc nom sing
                   lt_mgs,                   // masc gen sing
                   lt_mnp,                   // masc nom plur
                   lt_mgp,                   // masc gen plur
                   lt_fns,                   // fem nom sing
                   lt_fgs,                   // fem gen sing
                   lt_fnp,                   // fem nom plur
                   lt_fgp,                   // fem gen plur
                   lt_nns,                   // neuter nom sing
                   lt_ngs,                   // neuter gen sing
                   lt_nnp,                   // neuter nom plur
                   lt_ngp );                 // neuter gen plur


                   // Type of units (formerly tetrahedrons)
  tTetra           = (
                   tt_undef,                 // undefined type
                   tt_single,                // single unit
                   tt_pair,                  // pair
                   tt_pset,                  // pair set
                   tt_set,                   // set
                   tt_ref,                   // reference
                   tt_del,                   // deleted entity
                   tt_lex,                   // lexical reference
                   tt_tax,                   // taxonomic unit
                   tt_trans,                 // transitory unit
                   tt_voc,                   // vocabulary unit
                   tt_dup,                   // duplicate unit
                   tt_int,                   // interface unit
                   tt_mset );                // mixed set

                   // Materiality of units
  tMaterial        = (
                   ma_undef,                 // undefined
                   ma_mat,                   // material, under res corporea
                   ma_imm,                   // immaterial, under spatium anat.
                   ma_surf,                  // immaterial, under
                   ma_line,                  // immaterial, under line
                   ma_point,                 // immaterial, under point
                   ma_non );                 // non-physical entities

                   // Tip of entities in a unit
  tTip             = (
                   tp_undef,                 // undefined tip
                   tp_single,                // single tetrahedron = 1
                   tp_genpair,               // pair generator = 2
                   tp_pair,                  // pair main = 3
                   tp_leftpair,              // pair left = 4
                   tp_rightpair,             // pair right = 5
                   tp_genpset,               // pset generator = 6
                   tp_setpset,               // pset set = 7
                   tp_pset,                  // pset main = 8
                   tp_leftpset,              // pset left = 9
                   tp_rightpset,             // pset right = 10
                   tp_genset,                // set generator = 11
                   tp_set,                   // set main = 12
                   tp_ref,                   // reference = 13
                   tp_del,                   // deleted = 14
                   tp_lex,                   // lexical reference = 15
                   tp_tax,                   // taxonomic generic entity = 16
                   tp_wait,                  // waiting entity = 17
                   tp_voc,                   // vocabulary entity = 18
                   tp_dup,                   // duplicated entity = 19 (TA98)
                   tp_int,                   // interface entity = 20
                   tp_mset,                  // mset main = 21
                   tp_genmset );             // mset generator = 22

                   // Type of list pages
  tTypeListPage    = (
                   li_undef,                  // undefined type
                   li_part0,                  // partonomy list chapter
                   li_part1,                  // partonomy list level 1
                   li_part1f,                 // partonomy list level 1 full
                   li_part2,                  // partonomy list level 2
                   li_part2f,                 // partonomy list level 2 full
                   li_part3,                  // partonomy list level 3
                   li_part3f,                 // partonomy list level 3 full
                   li_part4,                  // partonomy list level 4
                   li_TA98part1,              // TA98 partonomy list level 1
                   li_TA98part2,              // TA98 partonomy list level 2
                   li_TA98part2f,             // TA98 partonomy list level 2full
                   li_TA98part3,              // TA98 partonomy list level 3
                   li_TA98part4,              // TA98 partonomy list level 4
                   li_tax1,                   // taxonomy list level 1
                   li_tax1f,                  // taxonomy list level 1 full
                   li_tax2,                   // taxonomy list level 2
                   li_tax2f,                  // taxonomy list level 2 full
                   li_tax3,                   // taxonomy list level 3
                   li_tax3f,                  // taxonomy list level 3 full
                   li_tax4,                   // taxonomy list level 4
                   li_int4,                   // interface list level 4
                   li_FMA,                    // FMA list
                   li_Excel,                  // Excel semicolumn-sep text file
                   li_gen,                    // generic partonomy list
                   li_Val );                  // universal validation list

                   { Type for storage of synonyms }
  tSynonym         = Array[ 1 .. 20 ] of Integer;

                   { Type for storage of definitions }
  tDefs            = Array[ 1 .. 10 ] of Integer;

                   { Type for storage of terms }
  tTerms           = Array of String;

                   { Type for storage of hierarchy positions }
  tHierarPos       = Array of Integer;

                   { Top nodes for FMA hierarchy }
  tTopNodes        = Array[ 0 .. 3 ] of TTreeNode;

                   // List of TIDs for search engine
  tItems           = Array of Integer;

  tTypeItem        = ( tt_Normal, tt_MakeODiv, tt_MakeEDiv );

                   // Qualifier of entity, together with internal database term
  tQualifier       = (
                   qu_non,             // Base entity
                   qu_exp,             // Base entity with optional expansion
                   qu_exr,             // Base entity opt expansion by reference
                   qu_obl,             // Base entity with mandatory expansion
                   qu_dbl,             // Base entity with both expansion
                   qu_set,             // Set entity
                   qu_pst,             // Pset entity
                   qu_sst,             // Left set entity
                   qu_dst,             // Right set entity
                   qu_par,             // Pair entity
                   qu_sin,             // Left unpaired entity
                   qu_dex,             // Right unpaired entity
                   qu_ref,             // Reference
                   qu_del );           // Deleted entity

                   // Modality for trace TA98 lists
  tModeTA98        = (
                   md_undef,           // mode undefined
                   md_short,           // mode short
                   md_sect,            // mode subsection
                   md_subchap,         // mode subchapter
                   md_chap );          // mode chapter

                   // Lexeme types
  tLexType         = (
                   lx_undef,           // undefined lexeme type
                   lx_noun,            // noun
                   lx_compl,           // noun complement
                   lx_adj,             // adjective
                   lx_pref,            // prefix
                   lx_invar,           // invariant
                   lx_appos );         // apposition

                   // Status of action in translation
  tActionStatus    = (
                   as_undef,           // undefined status
                   as_ok,              // action ok
                   as_skip,            // no-op action
                   as_debug,           // debug suggested
                   as_stop );          // stop processing

                   // Family relations in hierarchies
  tFamily          = (
                   fa_undef,            // undefined
                   fa_direct,           // direct relation
                   fa_parent,           // parent (direct step)
                   fa_gdparent,         // grand-parent (2 direct steps)
                   fa_gdgdparent,       // grand-grand-parent (3 direct steps)
                   fa_ancestor,         // higher direct relation
                   fa_indirect,         // not in direct relation
                   fa_brother,          // brother (same parent)
                   fa_uncle,            // uncle
                   fa_cousin,           // cousin (same grand-parent)
                   fa_gduncle,          // grand-uncle
                   fa_gdgduncle,        // grand-grand-uncle
                   fa_gdcousin );       // grand-cousin (cousin of parent)

                   // Sexe attribute
   tSexe           = (
                   sx_undef,            // Undefined sexe
                   sx_female,           // Female
                   sx_male );           // Male

                   { * Storage of an analyzed words in a term *
                   Description:
                   This record stores the result of analysis of a word as found
                   in a tTerm structure, as described
                   in the following table:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   Wrd        the word as found in the term
                   LID        unique identifier of word in Latin dictionary
                   Cod        code for type, declension, gender, case and number
                   Cla        class to which the present word belongs
                   Lem        representative form of the word (mns)
                   </TABLE>
                   The analysis of a word in tSingle structure is the following:
                   <TABLE>
                   Wrd        the word as found in the term
                   Cod        code for type, declension, gender, case and number
                   </TABLE> }
  WordAnal         = record
    Wrd:           String;
    LID:           String;
    Cod:           String;
    Cla:           String;
    Lem:           String;
  end;

                   { Type for cells for term analysis }
  tCells           = Array of WordAnal;

                   { * Storage of a single entry from the TAH MASTER file *
                   Description:
                   The TAH source file is made of a single record type issued
                   from the MASTER table of the database. This source file is
                   a sequential file sorted on ascending values of TIDs.<P>
                   There are presently 40 fields in the TAH source file, from
                   which 9 fields (marked as G) are generated, as seen below:
                   <TABLE>
                   Field      T  Explanation
                   ---------  -  -----------------------------------------------
                   Cod        M  TA98 source code up to 11 characters
                   TID        M  TID of actual entry in MASTER table
                   FID        M  FMA ID
                   Gen        M  TID of generator of sets or pairs
                   Car        M  Cardinality of set
                   Ins        M  TID of an inserted entry
                   Exp        M  TID of ancestor defining the TA hierarchy
                   Des        G  List of partonomic children (separated by ;)
                   Pst        G  List of positions of partonomic children
                   Nbc        G  Number of partonomic children

                   Seq        M  Position in sequence of partonomy
                   Isa        M  TID of taxonomic ancestor
                   Tes        G  List of taxonomic children (separated by ;)
                   Tst        G  List of positions of taxonomic children
                   Nbt        G  Number of taxonomic children
                   Ord        M  Position in sequence of taxonomy
                   Pis        M  Past ISA link before modification
                   Chl        M  Type of link change (new, modified or deleted)
                   Res        G  List of taxonomic past children (; separated)
                   Rst        G  List of positions of past taxonomic children

                   Rbt        G  Number of past taxonomic children
                   Typ        M  Type of object
                   Lnk        M  Type of ancestor link
                   Ver        M  Type of version
                   Lev        M  Type of entry in the TA source
                   Dis        M  Type of display element (chapter, section)
                   Gnr        M  Flag for generic entity
                   Act        M  Flag for active entity in TA partonomy
                   Ics        M  Flag for inconstant anatomical object
                   Bil        M  Flag for bilateral objects

                   Mul        M  Flag for multiple occurences
                   F98        M  Flag TA98 for female symbole
                   M98        M  Flag TA98 for male symbole
                   Dim        M  Flag for sexually dimorphic entities
                   FSb        M  Flag for female symbole
                   MSb        M  Flag for male symbole
                   Neo        M  Flag for new or remodeled code
                   Imm        M  Flag for immaterial object (no mass)
                   Lat        M  Laterality value
                   Tex        M  Internal term
                   </TABLE> }
  TARec            = record
    Cod:           String;
    TID:           Integer;
    FID:           Integer;
    Gen:           Integer;
    Car:           String;
    Ins:           Integer;
    Exp:           Integer;
    Des:           String;
    Pst:           String;
    Nbc:           Integer;

    Seq:           Integer;
    Isa:           Integer;
    Tes:           String;
    Tst:           String;
    Nbt:           Integer;
    Ord:           Integer;
    Pis:           Integer;
    Chl:           String;
    Res:           String;
    Rst:           String;

    Rbt:           Integer;
    Typ:           tType;
    Lnk:           tLink;
    Ver:           tVersion;
    Lev:           tLevel;
    Dis:           tDisplay;
    Gnr:           Boolean;
    Act:           Boolean;
    Ics:           Boolean;
    Bil:           Boolean;

    Mul:           Boolean;
    F98:           Boolean;
    M98:           Boolean;
    Dim:           Boolean;
    FSb:           Boolean;
    MSb:           Boolean;
    Neo:           Boolean;
    Imm:           Boolean;
    Lat:           tLaterality;
    Tex:           String;
  end;

                   { * Change Record for TARec *
                   Description:
                   The Change Record is an intermediate structure for the
                   collection of changes to the TAH database from multiple
                   authors. They are collected in a Change File applicable to
                   the current version of the DB. The Change File may be
                   circulated and temporally applied in the TAH browser,
                   allowing checks and validations of changes, before the
                   permanent transfer to the actual database, generating a new
                   version.<P>
                   The Change Records are generated by the TAH browser. The
                   collection of Change Records in a local Change File is a
                   procedure of the TAH browser. The Change File is continuously
                   updated when changes occurs and it is automatically loaded
                   when a new session of the TAH browser is started. All changes
                   recorded by the local Change File are automatically applied
                   to the loaded TAH source file. Any Change File may be
                   locally discarded on user's need and later restored.<P>
                   The TAH browser is able to read multiple Change Files from
                   different sources, and to collect the whole content in a new
                   local Change File.<P>
                   There are presently 7 fields in the Change Record:
                   <TABLE>
                   Field       Explanation
                   ---------   -------------------------------------------------
                   TID         The unique code identifier of MASTER table
                   LID         The unique libelle identifier of LIBELLE table
                   Author      Identification string of the author of change
                   Date        Date of change: yyyy.mm.dd hh:mn:ss
                   Field       Field ordinal in TARec: 1 to 26
                   Old:        Old string value for the specified field
                   Value       New string value for the specified field
                   </TABLE> }
  ChangeRec        = record
    TID:           Integer;
    LID:           Integer;
    Author:        String;
    Date:          String;
    Field:         Integer;
    Old:           String;
    Value:         String;
  end;
                   { * NOTES record for notes on TAH entities *
                   Description:
                   There are 5 fields in the NOTES source file:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   TID        The unique code identifier from the MASTER table
                   UID        The Unit identifier corresponding to the TID
                   Dup        The TID of a duplicated note
                   Typ        The type of note
                   Who        The author of the note
                   Dat        The date of last revision of the note
                   Not        The note text in HTML format }
  NoteRec          = record
    TID:           Integer;
    UID:           Integer;
    Dup:           Integer;
    Typ:           tNoteType;
    who:           String;
    Dat:           String;
    Txt:           String;
  end;
                   { * Language record for terms of TAH entities *
                   Description:
                   The language record is the container for any number of
                   libelles of terms in the table language.<P>
                   There are presently 12 fields in the language source file:
                   Field      Explanation
                   ---------  --------------------------------------------------
                   TID        The unique code identifier from the MASTER table
                   LID        The unique language identifier
                   Exp        Expansion TID for non Latin language
                   Mdl        Flag for presence of a model for the term
                   Dat        Date of creation or last update
                   Cat        The category of synonym
                   Src        The source of the present libelle (2 characters)
                   Int        Length of intrinsic part of term
                   Lib        Full term according to the model }
  LangRec          = record
    TID:           Integer;
    LID:           Integer;
    Exp:           Integer;
    Mdl:           Boolean;
    Dat:           String;
    Cat:           tSynType;
    Src:           String;
    Int:           Integer;
    Lib:           String;
  end;
                   { * Storage of model contributions for terms *
                   Description:
                   The model record is the container for any number of
                   contributions describing a single modelised term.<P>
                   There are presently 10 fields in the MODLA source file:
                   Field      Explanation
                   ---------  --------------------------------------------------
                   UID        The unit identifier to be modelled
                   LID        The language identifier of model declaration
                   Seq        Sequential position of model contribution
                   Typ        Type of contribution
                   Sub        Subtype of contribution
                   Lnk        UID of the defining unit of contribution
                   Mand       UID of mandatory expansion
                   Opt        UID of optional expansion
                   Ref        UID of partial model
                   Lib        Libelle of this model contribution }
  ModelRec         = record
    UID:           Integer;
    LID:           Integer;
    Seq:           Integer;
    Typ:           tContrib;
    Sub:           String;
    Lnk:           Integer;
    Mand:          Integer;
    Opt:           Integer;
    Ref:           Integer;
    Rel:           Integer;
    Lib:           String;
  end;
                   { * Storage of a single term and its expansion * }
  TextRec          = record
    Cat:           tSynType;
    Intrinsic:     String;
    Mandat:        String;
    Option:        String;
  end;
                   { * Storage of a multiple terms for a single entity * }
  tTermRec         = Array of TextRec;

                   { * Storage of FMA table optimized for processing *
                   Description:
                   Field      Explanation
                   ---------  --------------------------------------------------
                   FMAid      FMAid of present entry
                   TID        TID of corresponding TA entry
                   ChildSet   Field separated list of all children
                   ParentSet  Field separated list of all direct parents
                   NLPName    NLP name of entry
                   IsObs      Flag indicating an obsolete entry }
  FMArec           = record
    FMAid:         String;
    TID:           Integer;
    ChildSet:      String;
    DesChild:      String;
    ParentSet:     String;
    DesParent:     String;
    NLPName:       String;
    IsObs:         Boolean;
  end;
                   { * Storage of bivalued properties *
                   Description:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   Left       Left object of property
                   RID        Unique property identifier
                   Right      Right object of property
                   </TABLE> }
  PROPSrec         = record
    Left:          Integer;
    RID:           Integer;
    Right:         Integer;
  end;
                   { * Storage of definitions *
                   Description:
                   A definition applies to a Unit. When multiple entities are
                   part of a Unit, the additional definitions are
                   autogenerated.
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   UID        Unit ID to which definition applies
                   typ        Type of definition (see cDef and DefType)
                   Src        Author or origin of the definition
                   Dat        Creation date or last change
                   Def        Full text of the definition
                   </TABLE> }
  DEFrec           = record
    UID:           Integer;
    typ:           tDefType;
    Src:           String;
    Dat:           String;
    Def:           String;
  end;
                   { * Storage of Latin dictionary *
                   Description:
                   The Latin dictionary is made of 5 entries per record, as
                   described in the following table:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   LID        TID unique identifier of Latin dictionary
                   Cas        Latin case in declension
                   Cod        Code for type, declension, gender, case and number
                   Sub        Full Latin term
                   Cla        Class to which the present word belongs
                   </TABLE> }
  LatinRec         = record
    LID:           Integer;
    Cas:           String;
    Cod:           String;
    Sub:           String;
    Cla:           String;
  end;
                   { * Storage of sequence pointer *
                   Description:
                   The SEQ pointer file makes the many to one link between a
                   TID identifier of an anatomical structure and a unique
                   sequence identifier:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   TID        TID unique identifier of entity
                   SID        Sequence unique identifier
                   Ord        ordinal position in sequence
                   </TABLE> }
  SEQRec           = record
    TID:           Integer;
    SID:           Integer;
    Ord:           Integer;
  end;
                   { * Storage of sequence description *
                   Description:
                   The sequence definition file provides for each sequence
                   known by its SID (Unique Sequence Identifier) a textual
                   description as well as a pointer to its starting entity:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   SID        sequence unique identifier
                   title      title of sequence
                   descr      description of sequence
                   </TABLE> }
  SequenceRec      = record
    SID:           Integer;
    Title:         String;
    Descr:         String;
  end;
                   { * Storage of documentation *
                   Description:
                   The DOCUM file makes a link between the TID identifier of
                   a documentation memo as well as a few parameters:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   TID        TID unique identifier of entity
                   DAT        Date of last update
                   AUT        Author of the documentation
                   DES        HTML memo of documentation
                   Ord        ordinal position in sequence
                   </TABLE> }
  DOCUMRec         = record
    TID:           Integer;
    DAT:           String;
    AUT:           String;
    DES:           String;
  end;

                   { * Storage of inquiries *
                   Description:
                   The INQUIRY table is made of 8 entries:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   IID        Inquiry identifier (autonumber)
                   TID        Identifier of the unit
                   Lis        Specification of a list Pi or Ti
                   Who        Initials of author of this inquiry
                   Dat        Date of creation
                   Lib        Short descriptive text about this inquiry
                   Open       Flag for active inquiry
                   Clos       Date of closure of this inquiry
                   </TABLE> }
  InquiryRec       = record
    IID:           Integer;
    TID:           Integer;
    Lis:           String;
    Who:           String;
    Dat:           String;
    Lib:           String;
    Open:          Boolean;
    Clos:          String;
  end;

                   { * Storage of actions *
                   Description:
                   The ACTION table is made of 7 entries:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   AID        Action identifier (autonumber)
                   IID        Identifier of corresponding inquery
                   Typ        Type of action
                   Dat        Date of this action
                   Aut        Initials of the author of this action
                   Status     Status of inquery after this action
                   Descr      Text of description of the action
                   </TABLE> }
  ActionRec        = record
    AID:           Integer;
    IID:           Integer;
    Typ:           String;
    Dat:           String;
    Aut:           String;
    Status:        String;
    Descr:         String;
  end;

                   { * Storage of TA98 lists *
                   Description:
                   The TA98 table is made of 4 entries:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   TID        TAH unique identifier
                   TAcode     11-digit old TA code
                   Ind        Indentation code of TA98 book
                   List       TID of head of list
                   </TABLE> }
  TA98Rec          = record
    TID:           Integer;
    TAcode:        String;
    Ind:           String;
    List:          Integer;
  end;
                   { * Storage of concordance table *
                   Description:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   UID        UID defining a word
                   Categ      Category of word: noun, adj, prefix or invariant
                   LA         Latin word
                   EN         English word
                   FR         French word
                   </TABLE> }
  ConcordRec       = record
    UID:           Integer;
    Categ:         String;
    LA:            String;
    EN:            String;
    FR:            String;
  end;
                   { * Storage of raw formula *
                   Description:
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   UID        UID defining the formula
                   LastUp     Date of last update
                   Source     Author of last update
                   RawB       Raw base part of formula
                   RawM       UID of raw mandatory part of formula
                   RawO       UID of raw optional part of formula
                   </TABLE> }
  RawFormulaRec    = record
    UID:           Integer;
    LastUp:        String;
    Source:        String;
    RawB:          String;
  end;
                   { * Storage of signatures *
                   Description:
                   Signatures are attached to taxonomic and partonomic lists
                   defined as the descendants of a top unit.</P>
                   <TABLE>
                   Field      Explanation
                   ---------  --------------------------------------------------
                   UID        UID of the unit defining the list
                   Typ        Type of list
                   Anc        UID of the unit of the ancestor list
                   Son        List of children lists, semicolumn separated
                   Sign       Signature of the list
                   DatS       Date of validation of signature
                   PastS      String;
                   PastD      String;
                   NbCh       Integer;
                   NbUn       Integer;
                   PrCh       Integer;
                   PrUn       Integer;
                   NbSub      Integer;
                   NbRef      Integer;
                   NbBr       Integer;
                   Descr      Short description of the list
                   </TABLE> }
  SigRec           = record
    UID:           Integer;
    Typ:           String;
    Anc:           Integer;
    Son:           String;
    Sign:          Integer;
    DatS:          String;
    PastS:         String;
    PastD:         String;
    NbCh:          Integer;
    NbUn:          Integer;
    PrCh:          Integer;
    PrUn:          Integer;
    NbSub:         Integer;
    NbRef:         Integer;
    NbBr:          Integer;
    Descr:         String;
  end;

  tInquiries       = Array of InquiryRec;

                   // Array of four positions for lists
  tFourList        = Array[ 1 .. 4 ] of Integer;      // P1, P2, P3, P4

                   // Category of pages
  tCategPage       = (
                   ca_Undef,           // Undefined
                   ca_Entity,          // Entity Page
                   ca_Tetra,           // Tetra Page
                   ca_Extended,        // Extended Page
                   ca_Latin,           // Latin Page
                   ca_Test,            // Test Page
                   ca_Definition,      // Definition Page
                   ca_Segment,         // Segment Page
                   ca_Valid,           // Validation Page
                   ca_Property,        // Property Page
                   ca_Alpha,           // Alpha Page
                   ca_ListPart,        // List Page: partonomic
                   ca_ListTax,         // List Page: taxonomic
                   ca_ListTA98,        // List Page: TA98 partonomic
                   ca_listInt );       // Interface Page

                   // Category of test for Test page
  tTypeTest        = (
                   te_Undef,           // Undefined
                   te_NounGender,      // Test gender of nouns
                   te_AdjGender,       // Test gender of adjectives
                   te_NounPlural,      // Test plural of nouns
                   te_AdjPlural,       // Test plural of adjectives
                   te_NounGenSin,      // Test genitive singular of nouns
                   te_AdjGenSin,       // Test genitive singular of adjs
                   te_NounGenPlu,      // Test genitive plural of nouns
                   te_AdjGenPlu,       // Test genitive plural of adjs
                   te_NoExpansion,     // Test terms without expansion
                   te_AdjExpansion,    // Test adjective expansion
                   te_MandExpansion,   // Test mandatory expansion
                   te_LatExpansion,    // Test lateral expansion
                   te_OptExpansion );  // Test optional expansion

const
                   { Long text for languages in English.
                   Description:
                   The long texts are adjectives representing each language,
                   started with a capital letter. }
  cLgTextEN:       Array[ tLanguage ] of String = (
                   'Latin', 'English', 'French', 'Spanish', 'Russian',
                   'Italian', 'Dutch', 'German', 'Portugese', 'Swedish',
                   'Danish', 'Greek', 'Finnish', 'Norvegian', 'Roumanian',
                   'Universal', 'undefined' );
                   { Long text for languages in French. }
  cLgTextFR:       Array[ tLanguage ] of String = (
                   'latin', 'anglais', 'français', 'espagnol', 'russe',
                   'italien', 'hollandais', 'german', 'portugais', 'suédois',
                   'danois', 'grecque', 'finnois', 'norvegien', 'roumain',
                   'universel', 'indéfini' );
                   { Short text (2 characters) for representation of any
                   language in a short notice. }
  cLgShort:        Array[ tLanguage ] of String = (
                   'LA', 'EN', 'FR', 'ES', 'RU',
                   'IT', 'DU', 'GE', 'PO', 'SW',
                   'DA', 'GR', 'FI', 'NO', 'RO',
                   'MD', 'XX' );
                   // Values for TAH hierarchical partonomic links
  cLink:           Array[ tLink ] of String = (
                   // Material from material
                   'pof', 'bof', 'mbo', 'mbl', 'mbr', 'mbf', 'mbm',
                   'sto', 'sso', 'sbl', 'sbr',
                   'pao', 'bao', 'pmo', 'ppo', 'pbo', 'psm',
                   'pso', 'bso', 'psp', 'bsp', 'pss',
                   // Immaterial from material
                   'eso', 'sfo', 'lno', 'pto',
                   'tto', 'tss',
                   'qae', 'qas', 'qal', 'qap', 'qep', 'qsp', 'qlp', 'qmo',
                   'vso', 'vsp', 'qss',
                   // Immaterial from immaterial
                   'esi', 'sfi', 'lni', 'mbi', 'ibl', 'ibr',
                   'sti', 'ssi', 'tbl', 'tbr',
                   'qei', 'qsi', 'qli', 'qbi', 'qeq', 'qsq', 'qlq', 'qmi',
                   'vsi', 'vss',
                   // Others
                   'mbn', 'non', 'pre', 'top', 'und', 'inv' );

                   // Values for TAH hierarchical partonomic links
  cLinkLong:       Array[ tLink ] of String = (
                   // Material from material
                   'is part of',            // m pof m
                   'is branch of',          // m bof m
                   'is member of',          // m mbo s
                   'is left member',        // m mbl p & i mbl q
                   'is right member',       // m mbr p & i mbr q
                   'is female member',      // m mbf h & i mbf h
                   'is male member',        // m mbm h & i mbr h

                   'is set of',             // s sto m
                   'is subset of',          // s sso s
                   'is left set member of', // s sbl u
                   'is right set member of',// s sbr u

                   'is pair of',            // p pao m
                   'is branch pair of',     // p bao m
                   'is pair member of',     // p pmo s
                   'is pair part of',       // p ppo p
                   'is pair branch of',     // p pbo p
                   'is pair set member of', // p psm u

                   'is pair set of',        // u pso m
                   'is pair set branch of', // u bso m
                   'is pair set pair of',   // u psp p
                   'is pair set pair branch of',// u bsp p
                   'is pair subset of',     // u pss u

                   // Immaterial from material
                   'is space of',           // i eso m
                   'is surface of',         // i sfo m
                   'is line of',            // i lno m
                   'is point of',           // i pto m

                   'is imm set of',         // t tto m
                   'is imm subset of',      // t tss s

                   'is pair space of',      // q qae m
                   'is pair surface of',    // q qas m
                   'is pair line of',       // q qal m
                   'is pair point of',      // q qap m
                   'is pair space pair of', // q qep p
                   'is pair surface pair of',//q qsp p
                   'is pair line pair of',  // q qlp p
                   'is member pair of',     // q qmo p

                   'is imm pair set of',    // v vso m
                   'is imm pair set pair of',// v vsp p
                   'is imm pair set pset of',// v qss u

                   // Immaterial from immaterial
                   'is space in',           // i esi i
                   'is surface in',         // i sfi i
                   'is line in',            // i lni i
                   'is member in',          // i mbi t
                   'is I left member in',   // i ibl q
                   'is I right member in',  // i ibr q

                   'is set in',             // t sti t
                   'is subset in',          // t ssi t
                   'is T left member in',   // t tbl v
                   'is T right member in',  // t tbr v

                   'is pair space in',      // q qei i
                   'is pair surface in',    // q qsi i
                   'is pair line in',       // q qli i
                   'is pair member in',     // q qbi i
                   'is pair space pair in', // q qeq q
                   'is pair surface pair in',// q qsq q
                   'is pair line pair in',  // q qlq q
                   'is pair member pair in',// q qmi t

                   'is pair set in',        // v jsi t
                   'is pair subset in',     // v tsi i

                   // Others
                   'is member non',         // n mbn sn
                   'is part non of',        // n non m
                   'is presentation of',    // fake
                   'is top',                // top of hierarchy
                   'is undefined of',       // undefined
                   'is invalid' );          // invalid

                   // Values for link identifiers
  cLinkID:         Array[ tLink ] of Integer = (
                   // Material from material
                   11395,                   // m pof m
                   11396,                   // m bof m
                   11397,                   // m mbo s
                   11398,                   // m mbl p
                   11384,                   // m mbr p
                   19529,                   // m mbf h
                   19530,                   // m mbm h

                   11399,                   // s sto m
                   11400,                   // s sso s
                   22899,                   // s sbl u
                   22900,                   // s sbr u

                   11402,                   // p pao m
                   23140,                   // p bao m
                   11404,                   // p pmo s
                   11403,                   // p ppo p
                   13722,                   // p pbo p
                   13714,                   // p psm u

                   11405,                   // u pso m
                   23138,                   // u bso m
                   19859,                   // u psp p
                   23139,                   // u bsp p
                   13721,                   // u pss u

                   // Immaterial from material
                   11406,                   // i eso m
                   19523,                   // i sfo m
                   19524,                   // i lno m
                   19525,                   // i pto m

                   11409,                   // t tto m
                   26566,                   // t tss s

                   11412,                   // q qae m
                   13727,                   // q qas m
                   19526,                   // q qal m
                   19527,                   // q qap m
                   20600,                   // q qep p
                   20599,                   // q qsp p
                   20601,                   // q qlp p
                   20602,                   // q qmo u

                   11415,                   // v vso m
                   26564,                   // v vsp p
                   26565,                   // v qss u

                   // Immaterial from immaterial
                   13718,                   // i esi i
                   13719,                   // i sfi i
                   13720,                   // i lni i
                   11407,                   // i mbi t
                   22901,                   // i ibl q
                   22902,                   // i ibr q

                   19555,                   // t sti i
                   11410,                   // t ssi t
                   22903,                   // t tbl v
                   22904,                   // t tbr v

                   11414,                   // q qei i
                   13713,                   // q qsi i
                   13715,                   // q qli i
                   22905,                   // q qbi t
                   20916,                   // q qeq q
                   20917,                   // q qsq q
                   20918,                   // q qlq q
                   11413,                   // q qmi v

                   19556,                   // v vsi i
                   11411,                   // v vss v

                   // Others
                   10549,                   // n mbn sn
                   10549,                   // n non m
                   10549,                   // fake
                   10549,                   // top of hierarchy
                   10549,                   // undefined
                   10549 );                 // invalid

                   // Values for validation of child and father of links
  cLinkValid:      Array[ tLink ] of ChildFather = (

                   // Material from material
                   ( to_Mat, to_Mat ),
                   ( to_Mat, to_Mat ),
                   ( to_Mat, to_SetMat ),
                   ( to_Mat, to_ParMat ),
                   ( to_Mat, to_ParMat ),
                   ( to_Mat, to_HomMat ),
                   ( to_Mat, to_HomMat ),

                   ( to_SetMat, to_Mat ),
                   ( to_SetMat, to_SetMat ),
                   ( to_SetMat, to_PstMat ),
                   ( to_SetMat, to_PstMat ),

                   ( to_ParMat, to_Mat ),
                   ( to_ParMat, to_Mat ),
                   ( to_ParMat, to_SetMat ),
                   ( to_ParMat, to_ParMat ),
                   ( to_ParMat, to_ParMat ),
                   ( to_ParMat, to_PstMat ),

                   ( to_PstMat, to_Mat ),
                   ( to_PstMat, to_Mat ),
                   ( to_PstMat, to_ParMat ),
                   ( to_PstMat, to_ParMat ),
                   ( to_PstMat, to_PstMat ),

                   // Immaterial from material
                   ( to_Imm, to_Mat ),
                   ( to_Imm, to_Mat ),
                   ( to_Imm, to_Mat ),
                   ( to_Imm, to_Mat ),

                   ( to_SetImm, to_Mat ),
                   ( to_SetImm, to_SetMat ),

                   ( to_ParImm, to_Mat ),
                   ( to_ParImm, to_Mat ),
                   ( to_ParImm, to_Mat ),
                   ( to_ParImm, to_Mat ),
                   ( to_ParImm, to_ParMat ),
                   ( to_ParImm, to_ParMat ),
                   ( to_ParImm, to_ParMat ),
                   ( to_ParImm, to_PstMat ),

                   ( to_PstImm, to_Mat ),
                   ( to_PstImm, to_ParMat ),
                   ( to_PstImm, to_PstMat ),

                   // Immaterial from immaterial
                   ( to_Imm, to_Imm ),
                   ( to_Imm, to_Imm ),
                   ( to_Imm, to_Imm ),
                   ( to_Imm, to_SetImm ),
                   ( to_Imm, to_ParImm ),
                   ( to_Imm, to_ParImm ),

                   ( to_SetImm, to_Imm ),
                   ( to_SetImm, to_SetImm ),
                   ( to_SetImm, to_PstImm ),
                   ( to_SetImm, to_PstImm ),

                   ( to_ParImm, to_Imm ),
                   ( to_ParImm, to_Imm ),
                   ( to_ParImm, to_Imm ),
                   ( to_ParImm, to_SetImm ),
                   ( to_ParImm, to_ParImm ),
                   ( to_ParImm, to_ParImm ),
                   ( to_ParImm, to_ParImm ),
                   ( to_ParImm, to_PstImm ),

                   ( to_PstImm, to_Imm ),
                   ( to_PstImm, to_PstImm ),

                   // Others
                   ( to_Non, to_Undef ),
                   ( to_Non, to_Undef ),
                   ( to_Undef, to_Undef ),
                   ( to_Undef, to_Undef ),
                   ( to_Undef, to_Undef ),
                   ( to_Undef, to_Undef )
                   );

                   // Values for entity types
  cType:           Array[ tType ] of String = (
                   'x', 'm', 'i', 's', 't', 'p', 'q', 'u', 'v',
                   'w', 'x', 'h', 'g', 'd', 'n' );
                   // Long term in English for TAH entity types
  cTypeLongEN:     Array[ tType ] of String = (
                   'undefined entity',
                   'material entity',
                   'immaterial entity',
                   'composite material entity',
                   'composite immaterial entity',
                   'pair single material entity',
                   'pair single immaterial entity',
                   'pair composite material entity',
                   'pair composite immaterial entity',
                   'mixed composite material entity',
                   'mixed composite immaterial entity',
                   'sexually dimorphic material entity',
                   'sexually dimorphic immaterial entity',
                   'deleted entity',
                   'non-physical entity' );
                   // Long term in French for TA entity types
  cTypeLongFR:     Array[ tType ] of String = (
                   'Entité indéfinie',
                   'Entité matérielle',
                   'Entité immatérielle',
                   'Entité composite matérielle',
                   'Entité composite immatérielle',
                   'Entité paire simple matérielle',
                   'Entité paire simple immatérielle',
                   'Entité paire composite matérielle',
                   'Entité paire composite immatérielle',
                   'Entité mixte composite matérielle',
                   'Entité mixte composite immatérielle',
                   'Entité paire homologue matérielle',
                   'Entité paire homologue immatérielle',
                   'Entité supprimée',
                   'Entité non physique' );
                   // Values for synonym types
  cSynType:        Array[ tSynType ] of String = (
                   'bas',
                   'plm', 'pl1', 'pl2', 'pl3',
                   'bat', 'bis', 'exp',
                   'off', 'of2', 'of3', 'ofd', 'od2',
                   'od3', 'her', 'hrm', 'hr1', 'hr2',
                   'hr3', 'hra', 'h1m', 'h11', 'h12',
                   'h13', 'h1a', 'h2m', 'h21', 'h22',
                   'h23', 'h2a', 'h3m', 'h31', 'h32',
                   'h33', 'h3a', 'dl1', 'dl2', 'dl3',
                   'RAT', 'mam', 'ma1', 'ma2', 'ma3',
                   'irr', 'irm', 'ir1', 'ir2', 'ir3',
                   'fma', 'bna',
                   'dis', 'dsm', 'ds1', 'ds2', 'ds3',
                   'NOS', 'NOR', 'dit', 'syn', 'epo',
                   'nam', 'acr', 'dep', 'gen', 'ori',
                   'alt', 'ini', 'his', 'usa', 'all',
                   'mod', 'mdm',
                   'md1', 'md2', 'md3', 'mda',
                   'nou', 'adj', 'pre', 'inv',
                   'for', 'frm', 'fr1', 'fr2', 'fr3',
                   'tex', 'bul', 'tit', 'dab',
                   'val', 'vl2', 'und' );

                   // Values for types of language contributions
  cSynLong:        Array[ tSynType ] of String = (
                   'Base term',                       // bas
                   'Plural term main',                // plm
                   'Plural term synonym 1',           // pl1
                   'Plural term synonym 2',           // pl2
                   'Plural term synonym 3',           // pl3
                   'Replaced base term',              // bis
                   'Stored Autogenerated base term',  // bat
                   'Expanded form of official term',  // exp
                   'First official synonym',          // off (dep)
                   'Second official synonym',         // of2 (dep)
                   'Third official synonym',          // of3 (dep)
                   'Display first synonym',           // ofd
                   'Display second synonym',          // od2
                   'Display third synonym',           // od3
                   'Main term from main formula',     // her (dep)
                   'Main term from main formula',     // hrm
                   'Main term from syn1 formula',     // hr1
                   'Main term from syn2 formula',     // hr2
                   'Main term from syn3 formula',     // hr3
                   'Main term from plus formula',     // hra
                   'Syn1 term from Main formula',     // h1m
                   'Syn1 term from Syn1 formula',     // h11
                   'Syn1 term from Syn2 formula',     // h12
                   'Syn1 term from Syn3 formula',     // h13
                   'Syn1 term from Plus formula',     // h1a
                   'Syn2 term from Main formula',     // h2m
                   'Syn2 term from Syn1 formula',     // h21
                   'Syn2 term from Syn2 formula',     // h22
                   'Syn2 term from Syn3 formula',     // h23
                   'Syn2 term from Plus formula',     // h2a
                   'Syn3 term from Main formula',     // h3m
                   'Syn3 term from Syn1 formula',     // h31
                   'Syn3 term from Syn2 formula',     // h32
                   'Syn3 term from Syn3 formula',     // h33
                   'Syn3 term from Plus formula',     // h3a
                   'Deleted synonym 1',               // dl1
                   'Deleted synonym 2',               // dl2
                   'Deleted synonym 3',               // dl3
                   'Non RAT-compliant term',          // RAT (dep)
                   'Managed term main',               // mam
                   'Managed term synonym 1',          // ma1
                   'Managed term synonym 2',          // ma2
                   'Managed term synonym 3',          // ma3
                   'Irregular term',                  // irr (dep)
                   'Irregular term main',             // irm
                   'Irregular term synonym 1',        // ir1
                   'Irregular term synonym 2',        // ir2
                   'Irregular term synonym 3',        // ir3
                   'FMA English term',                // fma
                   'BNA term',                        // bna
                   'Display main term',               // dis (dep)
                   'Display main term',               // dsm
                   'Display synonym 1',               // ds1
                   'Display synonym 2',               // ds2
                   'Display synonym 3',               // ds3
                   'NOS synonym',                     // NOS
                   'NOS traditional synonym',         // NOR
                   'Stored display synonym',          // dit
                   'Trivial synonym',                 // syn
                   'Eponym',                          // epo
                   'Author',                          // nam
                   'Acronym',                         // acr
                   'Depreciated term',                // dep
                   'Genitive form',                   // gen
                   'TA98 precursor',                  // ori
                   'TA98 synonym',                    // alt
                   'TA98 initial term',               // ini
                   'Historical term',                 // his
                   'US English',                      // usa
                   'All synonyms',                    // all
                   'Latin model',                     // mod (dep)
                   'Latin model',                     // mdm
                   'Synonym 1 model',                 // md1
                   'Synonym 2 model',                 // md2
                   'Synonym 3 model',                 // md3
                   'Additional model',                // mda
                   'Noun',                            // nou
                   'Adjective',                       // adj
                   'Prefix',                          // pre
                   'Invariant',                       // inv
                   'Model',                           // for (dep)
                   'Formula term main',               // frm
                   'Formula term synonym 1',          // fr1
                   'Formula term synonym 2',          // fr2
                   'Formula term synonym 3',          // fr3
                   'text',                            // tex
                   'bubble text',                     // bul
                   'title',                           // tit
                   'database',                        // dab
                   'value term',                      // val
                   'second value term',               // vl2
                   'Undefined' );                     // und

                   // Group of base terms
  cGroupBase       = [ st_bas,
                       st_ofd, st_off, st_od2, st_od3 ];
                   // Group of main terms
  cGroupMain       = [ st_bas, st_irr, st_irm, st_RAT,
                       st_mam, st_her, st_hrm, st_plm,
                       st_hr1, st_hr2, st_hr3, st_hra,
                       st_dis ];
                   // Group of syn1 terms
  cGroupSyn1       = [ st_ofd, st_ir1, st_ma1, st_h1m,
                       st_h11, st_h12, st_h13, st_h1a ];
                   // Group of syn2 terms
  cGroupSyn2       = [ st_od2, st_ir2, st_ma2, st_h2m,
                       st_h21, st_h22, st_h23, st_h2a ];
                   // Group of syn3 terms
  cGroupSyn3       = [ st_od3, st_ir3, st_ma3, st_h3m,
                       st_h31, st_h32, st_h33, st_h3a ];
                   // Group of inheritance terms
  cGroupInherit    = [ st_her,
                       st_hrm, st_hr1, st_hr2, st_hr3, st_hra,
                       st_h1m, st_h11, st_h12, st_h13, st_h1a,
                       st_h2m, st_h21, st_h22, st_h23, st_h2a,
                       st_h3m, st_h31, st_h32, st_h33, st_h3a ];
                   // Group of managed terms
  cGroupManaged    = [ st_RAT,
                       st_mam, st_ma1, st_ma2, st_ma3 ];
                   // Group of plural terms
  cGroupPlural     = [ st_plm, st_pl1, st_pl2, st_pl3 ];
                   // Group of display terms
  cGroupDisplay    = [ st_dis,
                       st_dsm, st_ds1, st_ds2, st_ds3 ];
                   // Group of model terms
  cGroupModel      = [ st_mod,
                       st_mdm, st_md1, st_md2, st_md3, st_mda ];
                   // Group of vocabulary terms
  cGroupVocab      = [ st_nou, st_adj, st_pre, st_inv ];
                   // Group of formula terms
  cGroupFormula    = [ st_for,
                       st_frm, st_fr1, st_fr2, st_fr3 ];
                   // Group of text terms
  cGroupText       = [ st_tex, st_tit, st_val, st_bul ];

                   // Values for versions
  cVersion:        Array[ tVersion ] of String = (
                   '98', '10', '  ' );
                   // Values for note type
  cNoteValue:      Array[ tNoteType ] of String = (
                   '98', 'er', 'ra', 'rd', 'pb', '10', 'rv', 'tx',
                   'sc', 'im', 'tr', 'dl', 'tn', 'un', '  ' );
                   // Long values for note's type
  cNoteLongValue:  Array[ tNoteType ] of String = (
                   'TA98 source notes',
                   'TA98 correction notes',
                   'TA98 RAT notes',
                   'TA98 direction notes',
                   'TA98 problem notes',
                   'Transition notes',
                   'RevTermA notes',
                   'Taxonomy change notes',
                   'Scientific notes',
                   'Implementation notes',
                   'Translation notes',
                   'Terminology notes',
                   'TA98 seleted entities',
                   'Universal notes',
                   '  ' );
                   // Values for level
  cLevel:          Array[ tLevel ] of String = (
                   '1', '2', '3', '4', '5', '6', '7',
                   'a', 'b', 'c', 'd', 'e', 'f', 'k', ' ' );
                   // Values for duisplay specification
  cDisplay:         Array[ tDisplay ] of String = (
                   ' ', 't', 'c', 'd', 's', 'r', 'q', 'p', 'e' );
                   // Names of properties
  cPROPS:          Array[ tPropType ] of String = (
                   'has_insertion',      // inverse of is_insertion_of
                   'has_nerve',          // inverse of is_nerve_of
                   'has_artery',         // inverse os is_artery_of
                   'has_vein',           // inverse of is_vein_of
                   'has_origin',         // inverse of is_origin_of
                   'part_of',            // inverse of has_part
                   'located_in',         // inverse of is_location_of
                   'adjacent_to',        // symetric inverse
                   'subset_of',          // inverse of has_subset
                   'member_of',          // inverse of has_member

                   'is_joint_of',        // inverse of has_joint
                   'member_in',          // inverse of has_imm_member
                   'has_function',       // inverse of is_function_of
                   'branch_of',          // inverse of has_branch
                   'has_part',           // inverse of part_of
                   'is_insertion_of',    // inverse of has_insertion
                   'is_nerve_of',        // inverse of has_nerve
                   'is_artery_of',       // inverse of has_artery
                   'is_vein_of',         // inverse of has-vein
                   'is_origin_of',       // inverse of has_origin

                   'is_location_of',     // inverse of located_in
                   'has_subset',         // inverse of subset_of
                   'has_member',         // inverse of member_of
                   'has_imm_member',     // inverse of member_in
                   'is_function_of',     // inverse of has_function
                   'has_branch',         // inverse of branch_of
                   'has_target',         // inverse of is_target_of
                   'is_target_of',       // inverse of has_target
                   'contains',           // inverse of is_contained_in
                   'is_contained_in',    // inverse of contains

                   'longitudinal_to',    // symetric inverse
                   'has_attachment',     // inverse of is_attachment_of
                   'is_attachment_of',   // inverse of has_attachment
                   'has_joint',          // inverse of is_joint_of
                   'has_continuation',   // inverse of iss_continuation_of
                   'is_continuation_of', // inverse of has_continuation
                   'is_boundary_of',     // inverse of has_boundary
                   'has_boundary',       // inverse of is_boundary_of
                   'next_in_sequence',   // inverse of prev_in_sequence
                   'prev_in_sequence',   // inverse of next_in_sequence

                   'is_surface_of',      // inverse of has_surface
                   'has_surface',        // inverse of is_surface_of
                   'is_side_of',         // inverse of has_side
                   'has_side',           // inverse of is_side_of
                   'is_joint_with',      // symetric inverse
                   'has_bone',           // inverse of is_bone_of
                   'is_bone_of',         // inverse of has_bone
                   'is_Snerve_of',       // inverse of has_Snerve
                   'has_Snerve',         // inverse of is_Snerve_of
                   'has_track_origin',   // inverse of is_track_origin_of

                   'is_track_origin_of', // inverse of has_track_origin
                   'has_termination',    // inverse of is_termination_of
                   'is_termination_of',  // inverse of has_termination
                   'Ncontains',          // inverse of is_Ncontained_in
                   'is_Ncontained_in',   // inverse of Ncontains
                   'is_Lcontained_in',   // inverse of Lcontains
                   'Lcontains',          // inverse of is_Lcontained_in
                   'is_adjacent_space_to',//inverse of has_adjacent_space
                   'has_adjacent_space'  // inverse of is_adjacent_space_to
                   );

                   // Properties definitions
  cPropDef:        Array[ tPropType ] of String = (
                   '<muscle> has_insertion <bone>',
                   '<organ> has_nerve <nerve>',
                   '<organ> has_artery <artery>',
                   '<organ> has_vein <vein>',
                   '<muscle> has_origin <bone>',
                   '<material anatomical entity> part_of <material anatomical entity>',
                   '<immaterial anatomical entity> located_in <material anatomical entity>',
                   '<material anatomical entity> adjacent_to <material anatomical entity>',
                   '<composite entity> subset_of <composite entity>',
                   '<material anatomical entity> member_of <composite entity>',

                   '<joint> is_joint_of <bone>',
                   '<immmaterial anatomical entity> member_in <composite entity>',
                   '<muscle> has_function <muscular function>',
                   '<vessel or nerve> branch_of <vessel or nerve>',
                   '<material anatomical entity> has_part <material anatomical entity>',
                   '<bone> is_insertion_of <muscle>',
                   '<nerve> is_nerve_of <organ>',
                   '<artery> is_artery_of <organ>',
                   '<vein> is_vein_of <organ>',
                   '<bone> is_origin_of <muscle>',

                   '<material anatomical entity> is_location_of <immaterial anatomical entity>',
                   '<composite entity> has_subset <composite entity>',
                   '<composite entity> has_member <material anatomical entity>',
                   '<composite entity> has_imm_member <immaterial anatomical entity>',
                   '<muscular function> is_function_of <joint>',
                   '<vessel or nerve> has_branch <vessel or nerve>',
                   '<muscle> has_target <joint>',
                   '<joint> is_target_of <muscle>',
                   '<material anatomical entity> contains <material anatomical entity>',
                   '<material anatomical entity> is_contained_in <material anatomical entity>',

                   '<> longitudinal_to <>',
                   '<ligament> has_attachment <bone>',
                   '<bone> is_attachment_of <ligament>',
                   '<bone> has_joint <joint>',
                   '<> has_continuation <>',
                   '<> is_continuation_of <>',
                   '<> is_boundary_of <material anatomical entity>',
                   '<material anatomical entity> has_boundary <2-dim immaterial entity>',
                   '<physical anatomical entity> next_in_sequence <physical anatomical entity>',
                   '<physical anatomical entity> prev_in_sequence <physical anatomical entity>',

                   '<2-dim immaterial entity> is_surface_of <material anatomical entity>',
                   '<material anatomical entity> has_surface <2-dim immaterial entity>',
                   '<1-dim immaterial entity> is_side_of <material anatomical entity>',
                   '<material anatomical entity> has_side <1-dim immaterial entity>',
                   '<bone> is_joint_with <bone>',
                   '<joint> has_bone <bone>',
                   '<bone> is_joint_of <joint>',
                   '<nerve> is_Snerve_of <organ>',
                   '<organ> has_Snerve <nerve>',
                   '<track> has_track_origin <nucleus or ganglion>',

                   '<nucleus or ganglion> is_track_origin_of <track>',
                   '<track> has_termination <nucleus or ganglion>',
                   '<nucleus or ganglion> is_termination_of <track>',
                   '<nerve container> Ncontains <nerve bundle>',
                   '<nerve bundle> is_Ncontained_in <nerve container>',
                   '<body fluid> is_Lcontained_in <body fluid container>',
                   '<body fluid container> Lcontains <body fluid>',
                   '<space> is_adjacent_space_to <material entity>',
                   '<material entity> has_adjacent_space <space>'
                   );

                   // Codes for definition type
  cDef:            Array[ tDefType ] of String = (
                   'und', 'enc', 'tax', 'spa', 'fun', 'phy' );

                   // Values for contributions to the term model
  cContrib:        Array[ tContrib ] of String = (
                   'u', 'n', 'c', 'a', 'p', 'i', 'g', 'r' );

                   // Values for laterality
  cLateral:        Array[ tLaterality ] of String = (
                   '', 'u', 's', 'd' );

                   // ID definitions of sections for CSS
  cIDSection:      Array[ tSectionType ] of String = (
                   'SectUndef',              // Undefined section
                   'SectID',                 // Identification section
                   'SectNav',                // Navigation section
                   'SectInt',                // Interface section
                   'SectNav4',               // Navigation level-4
                   'SectLA',                 // Latin section
                   'SectEN',                 // English section
                   'SectFR',                 // French section
                   'SectSP',                 // Spanish section
                   'SectRU',                 // Russian section
                   'SectIT',                 // Italian section
                   'SectGE',                 // German section
                   'SectPT',                 // Portugese section
                   'SectDef',                // Definition section
                   'SectDoc',                // Documentation section
                   'SectSeq',                // Sequence section
                   'SectProp',               // Property section
                   'SectVoc',                // Vocabulary section
                   'SectLev',                // Level section
                   'SectLink',               // Linkage section
                   'SectNote',               // Note section
                   'SectPart',               // Partonomy section
                   'SectInf',                // Short partonomic section
                   'SectTax',                // Taxonomy section
                   'SectInt',                // Interface section
                   'SectMod',                // Model section
                   'SectDesign',             // Design section
                   'SectAnal',               // Term analysis section
                   'SectSynt',               // Syntax section
                   'SectDecl',               // Declension section
                   'SectTaxL',               // Taxonomic definitions section
                   'SectPartL',              // Partonomic definitions section
                   'SectSSeg',               // Segment level 5 short section
                   'SectFSeg',               // Segment level 5 full section
                   'SectLv4',                // Segment level 4 section
                   'SectTA98Navig',          // Trace TA98 navigation
                   'SectTA98',               // Trace TA98 list
                   'SectTA98Notes',          // Notes TA98
                   'SectValid',              // Segment validation section
                   'SectValidFormula',       // Validation of formulas
                   'SectValidVocab',         // Validation of vocabulary
                   'SectNavL',               // List navigation scetion
                   'SectPartL',              // Partonomy list section
                   'SectPartT',              // Taxonomy list section
                   'SectNoteList',           // Note list section
                   'SectRefer',              // Note list section
                   'SectTreeFormula',        // Tree formula section
                   'SectConcordance',        // Concordance section
                   'SectActionList',         // Action list section
                   'SectTranslation',        // Translation section
                   'SectDisplayTrans',       // Display translation section
                   'SectAutoTerm',           // Automatic term section
                   'SectStatUniv',           // Universal statistic section
                   'SectValidUniv',          // Universal validation section
                   'SectSignature',          // Signature section
                   'SectPart98',             // TA98 partonomic section
                   'SectRuleAdjGender',      // Rules adj gender section
                   'SectTestAdjGender',      // Test adjective gender section
                   'SectFreeTestAdjGender',  // Free test adj. gender section
                   'SectTestNounGender',     // Test noun gender section
                   'SectRuleNounGender',     // Rules noun gender section
                   'SectFreeTestNounGender', // Free test noun gender section
                   'SectTestNounPlural',     // Test of noun plural
                   'SectRuleWordPlural',     // Rules for word plural
                   'SectRuleNounPlural',     // Rules for noun plural
                   'SectFreeNounPlural',     // Free test for noun gender
                   'SectRuleAdjPlural',      // Rules for adjective plural
                   'SectTestAdjPlural',      // Test gender of adjectives
                   'SectFreeAdjPlural',      // Free test gender of adjectives
                   'SectRuleNounGenSin',     // Rules for genitive sing nouns
                   'SectTestNounGenSin',     // Test for genitive sing nouns
                   'SectFreeNounGenSin',     // Free test for gen sing nouns
                   'SectRuleAdjGenSin',      // Rules for genitive singular adj
                   'SectTestAdjGenSin',      // Test for genitive singular adj
                   'SectFreeAdjGenSin',      // Free test for genitive sing adj
                   'SectRuleNounGenPlu',     // Rules for genitive plural nouns
                   'SectTestNounGenPlu',     // Test for genitive plural nouns
                   'SectFreeNounGenPlu',     // Free test for gen plural nouns
                   'SectRuleAdjGenPlu',      // Rules for genitive plural adj
                   'SectTestAdjGenPlu',      // Test for genitive plural adj
                   'SectFreeAdjGenPlu',      // Free test for gen plural adj
                   'SectTestNoExp',          // Test terms without expansion
                   'SectTestAdjExp',         // Test adjective expansion
                   'SectRuleAdjExp',         // Rules for adjective expansion
                   'SectFreeAdjExp',         // Free test for adj expansion
                   'SectTestMandExp',        // Test mandatory expansion
                   'SectTestLatExp',         // Test lateral expansion
                   'SectTestOptjExp' );      // Test optional expansion

                   // ID definitions of toggle buttons of sections for CSS
  cIDButton:       Array[ tSectionType ] of String = (
                   'BtnUndef',               // Undefined section
                   'BtnID',                  // Identification section
                   'BtnNav',                 // Navigation section
                   'BtnInt',                 // Interface section
                   'BtnNav4',                // Navigation level-4
                   'BtnLA',                  // Latin section
                   'BtnEN',                  // English section
                   'BtnFR',                  // French section
                   'BtnSP',                  // Spanish section
                   'BtnRU',                  // Russian section
                   'BtnIT',                  // Italian section
                   'BtnGE',                  // German section
                   'BtnPT',                  // Portugese section
                   'BtnDef',                 // Definition section
                   'BtnDoc',                 // Documentation section
                   'BtnSeq',                 // Sequence section
                   'BtnProp',                // Property section
                   'BtnVoc',                 // Vocabulary section
                   'BtnLev',                 // Level section
                   'BtnLink',                // Linkage section
                   'BtnNote',                // Note section
                   'BtnPart',                // Partonomy section
                   'BtnInf',                 // Short partonomic section
                   'BtnTax',                 // Taxonomy section
                   'BtnInt',                 // Interface section
                   'BtnMod',                 // Model section
                   'BtnDesign',              // Design section
                   'BtnAnal',                // Term analysis section
                   'BtnSynt',                // Syntax section
                   'BtnDecl',                // Declension section
                   'BtnTaxL',                // Taxonomic definitions section
                   'BtnPartL',               // Partonomic definitions section
                   'BtnSSeg',                // Segment level 5 short section
                   'BtnFSeg',                // Segment level 5 full section
                   'BtnLv4',                 // Segment level 4 section
                   'BtnTA98Navig',           // TA98 navigation
                   'BtnTA98',                // Trace TA98 list
                   'BtnTA98Notes',           // Notes TA98
                   'BtnValid',               // Validation section
                   'BtnValidFormula',        // Validation of formulas
                   'BtnValidVocab',          // Validation of vocabulary
                   'BtnNavL',                // List navigation section
                   'BtnPartL',               // Partonomy list section
                   'BtnPartT',               // Taxonomy list section
                   'BtnNoteList',            // Note list section
                   'BtnRefer',               // Reference section
                   'BtnTreeFormula',         // Tree formula section
                   'BtnConcordance',         // Concordance section
                   'BtnActionList',          // Intermediate translation section
                   'BtnTranslation',         // Translation section
                   'BtnDisplayTrans',        // Display tramslation section
                   'BtnAutoTerm',            // Automatic term section
                   'BtnStatUniv',            // Universal statistic section
                   'BtnValidUniv',           // Universal validation section
                   'BtnSignature',           // Signature section
                   'BtnPart98',              // Signature section
                   'BtnRuleAdjGender',       // Rules for adj gender section
                   'BtnTestAdjGender',       // Test adjective gender section
                   'BtnFreeTestAdjGender',   // Free test adj. gender section
                   'BtnTestNounGender',      // Test noun gender section
                   'BtnRuleNounGender',      // Rules for noun gender section
                   'BtnFreeNounGender',      // Free test noun gender section
                   'BtnTestNounPlural',      // Test gender of noun plural
                   'BtnRuleWordPlural',      // Rules for for word plural
                   'BtnRuleNounPlural',      // Rules for for noun plural
                   'BtnFreeNounPlural',      // Free test for noun plural
                   'BtnRuleAdjPlural',       // Rules for for adjective plural
                   'BtnTestAdjPlural',       // Test plural of adjectives
                   'BtnFreeAdjPlural',       // Free test plural of adjectives
                   'BtnRuleNounGenSin',      // Rules for genitive sing nouns
                   'BtnTestNounGenSin',      // Test for genitive sing nouns
                   'BtnFreeNounGenSin',      // Free test for gen sing nouns
                   'BtnRuleAdjGenSin',       // Rules for genitive singular adj
                   'BtnTestAdjGenSin',       // Test for genitive singular adj
                   'BtnFreeAdjGenSin',       // Free test for genitive sing adj
                   'BtnRuleNounGenPlu',      // Rules for genitive plural nouns
                   'BtnTestNounGenPlu',      // Test for genitive plural nouns
                   'BtnFreeNounGenPlu',      // Free test for gen plural nouns
                   'BtnRuleAdjGenPlu',       // Rules for genitive plural adj
                   'BtnTestAdjGenPlu',       // Test for genitive plural adj
                   'BtnFreeAdjGenPlu',       // Free test for gen plural adj
                   'BtnTestNoExp',           // Test terms without expansion
                   'BtnTestAdjExp',          // Test adjective expansion
                   'BtnRuleAdjExp',          // Rules for adjective expansion
                   'BtnFreeAdjExp',          // Free test for adj expansion
                   'BtnTestMandExp',         // Test mandatory expansion
                   'BtnTestLatExp',          // Test lateral expansion
                   'BtnTestOptjExp' );       // Test optional expansion

                   // KN definitions of sections for CSS
  cKnSection:      Array[ tSectionType ] of String = (
                   'SectUndef',              // Undefined section
                   'SectID',                 // Identification section
                   'SectNav',                // Navigation section
                   'SectInt',                // Interface section
                   'SectNav4',               // Navigation level-4
                   'SectLA',                 // Latin section
                   'SectEN',                 // English section
                   'SectFR',                 // French section
                   'SectSP',                 // Spanish section
                   'SectRU',                 // Russian section
                   'SectIT',                 // Italian section
                   'SectGE',                 // German section
                   'SectPT',                 // Portugese section
                   'SectDef',                // Definition section
                   'SectDoc',                // Documentation section
                   'SectSeq',                // Sequence section
                   'SectProp',               // Property section
                   'SectVoc',                // Vocabulary section
                   'SectLev',                // Level section
                   'SectLink',               // Linkage section
                   'SectNote',               // Note section
                   'SectPart',               // Partonomy section
                   'SectInf',                // Short partonomic section
                   'SectTax',                // Taxonomy section
                   'SectInt',                // Interface section
                   'SectMod',                // Model section
                   'SectDesign',             // Design section
                   'SectAnal',               // Term analysis section
                   'SectSynt',               // Syntax section
                   'SectDecl',               // Declension section
                   'SectTaxL',               // Taxonomic definitions section
                   'SectPartL',              // Partonomic definitions section
                   'SectSSeg',               // Segment level 5 short section
                   'SectFSeg',               // Segment level 5 full section
                   'SectLv4',                // Segment level 4 section
                   'SectTA98Navig',          // Trace TA98 navigation
                   'SectTA98',               // Trace TA98 list
                   'SectTA98Notes',          // Notes TA98
                   'SectValid',              // Segment validation section
                   'SectValidFormula',       // Validation of formulas
                   'SectValidVocab',         // Validation of vocabulary
                   'SectNavL',               // List navigation scetion
                   'SectPartL',              // Partonomy list section
                   'SectPartT',              // Taxonomy list section
                   'SectNoteList',           // Note list section
                   'SectRefer',              // Note list section
                   'SectTreeFormula',        // Tree formula section
                   'SectConcordance',        // Concordance section
                   'SectActionList',         // Action list section
                   'SectTranslation',        // Translation section
                   'SectDisplayTrans',       // Display translation section
                   'SectAutoTerm',           // Automatic term section
                   'SectStatUniv',           // Universal statistic section
                   'SectValidUniv',          // Universal validation section
                   'SectSignature',          // Signature section
                   'SectPart98',             // TA98 partonomic section
                   'SectRuleAdjGender',      // Rules adj gender section
                   'SectTestAdjGender',      // Test adjective gender section
                   'SectFreeTestAdjGender',  // Free test adj. gender section
                   '',                       // Test noun gender section
                   'KnowRuleNounGender',     // Rules noun gender section
                   '',                       // Free test noun gender section
                   'SectTestNounPlural',     // Test of noun plural
                   'SectRuleWordPlural',     // Rules for word plural
                   'SectRuleNounPlural',     // Rules for noun plural
                   'SectFreeNounPlural',     // Free test for noun gender
                   'SectRuleAdjPlural',      // Rules for adjective plural
                   'SectTestAdjPlural',      // Test gender of adjectives
                   'SectFreeAdjPlural',      // Free test gender of adjectives
                   'SectRuleNounGenSin',     // Rules for genitive sing nouns
                   'SectTestNounGenSin',     // Test for genitive sing nouns
                   'SectFreeNounGenSin',     // Free test for gen sing nouns
                   'SectRuleAdjGenSin',      // Rules for genitive singular adj
                   'SectTestAdjGenSin',      // Test for genitive singular adj
                   'SectFreeAdjGenSin',      // Free test for genitive sing adj
                   'SectRuleNounGenPlu',     // Rules for genitive plural nouns
                   'SectTestNounGenPlu',     // Test for genitive plural nouns
                   'SectFreeNounGenPlu',     // Free test for gen plural nouns
                   'SectRuleAdjGenPlu',      // Rules for genitive plural adj
                   'SectTestAdjGenPlu',      // Test for genitive plural adj
                   'SectFreeAdjGenPlu',      // Free test for gen plural adj
                   'SectTestNoExp',         // Test terms without expansion
                   'SectTestAdjExp',         // Test adjective expansion
                   'SectRuleAdjExp',         // Rules for adjective expansion
                   'SectFreeAdjExp',         // Free test for adj expansion
                   'SectTestMandExp',        // Test mandatory expansion
                   'SectTestLatExp',         // Test lateral expansion
                   'SectTestOptjExp' );      // Test optional expansion

                   // KN definitions of toggle buttons of sections for CSS
  cKnButton:       Array[ tSectionType ] of String = (
                   'BtnUndef',               // Undefined section
                   'BtnID',                  // Identification section
                   'BtnNav',                 // Navigation section
                   'BtnInt',                 // Interface section
                   'BtnNav4',                // Navigation level-4
                   'BtnLA',                  // Latin section
                   'BtnEN',                  // English section
                   'BtnFR',                  // French section
                   'BtnSP',                  // Spanish section
                   'BtnRU',                  // Russian section
                   'BtnIT',                  // Italian section
                   'BtnGE',                  // German section
                   'BtnPT',                  // Portugese section
                   'BtnDef',                 // Definition section
                   'BtnDoc',                 // Documentation section
                   'BtnSeq',                 // Sequence section
                   'BtnProp',                // Property section
                   'BtnVoc',                 // Vocabulary section
                   'BtnLev',                 // Level section
                   'BtnLink',                // Linkage section
                   'BtnNote',                // Note section
                   'BtnPart',                // Partonomy section
                   'BtnInf',                 // Short partonomic section
                   'BtnTax',                 // Taxonomy section
                   'BtnInt',                 // Interface section
                   'BtnMod',                 // Model section
                   'BtnDesign',              // Design section
                   'BtnAnal',                // Term analysis section
                   'BtnSynt',                // Syntax section
                   'BtnDecl',                // Declension section
                   'BtnTaxL',                // Taxonomic definitions section
                   'BtnPartL',               // Partonomic definitions section
                   'BtnSSeg',                // Segment level 5 short section
                   'BtnFSeg',                // Segment level 5 full section
                   'BtnLv4',                 // Segment level 4 section
                   'BtnTA98Navig',           // TA98 navigation
                   'BtnTA98',                // Trace TA98 list
                   'BtnTA98Notes',           // Notes TA98
                   'BtnValid',               // Validation section
                   'BtnValidFormula',        // Validation of formulas
                   'BtnValidVocab',          // Validation of vocabulary
                   'BtnNavL',                // List navigation section
                   'BtnPartL',               // Partonomy list section
                   'BtnPartT',               // Taxonomy list section
                   'BtnNoteList',            // Note list section
                   'BtnRefer',               // Reference section
                   'BtnTreeFormula',         // Tree formula section
                   'BtnConcordance',         // Concordance section
                   'BtnActionList',          // Intermediate translation section
                   'BtnTranslation',         // Translation section
                   'BtnDisplayTrans',        // Display tramslation section
                   'BtnAutoTerm',            // Automatic term section
                   'BtnStatUniv',            // Universal statistic section
                   'BtnValidUniv',           // Universal validation section
                   'BtnSignature',           // Signature section
                   'BtnPart98',              // Signature section
                   'BtnRuleAdjGender',       // Rules for adj gender section
                   'BtnTestAdjGender',       // Test adjective gender section
                   'BtnFreeTestAdjGender',   // Free test adj. gender section
                   '',                       // Test noun gender section
                   'BtnKnowNounGender',      // Rules for noun gender section
                   '',                       // Free test noun gender section
                   'BtnTestNounPlural',      // Test gender of noun plural
                   'BtnRuleWordPlural',      // Rules for for word plural
                   'BtnRuleNounPlural',      // Rules for for noun plural
                   'BtnFreeNounPlural',      // Free test for noun plural
                   'BtnRuleAdjPlural',       // Rules for for adjective plural
                   'BtnTestAdjPlural',       // Test plural of adjectives
                   'BtnFreeAdjPlural',       // Free test plural of adjectives
                   'BtnRuleNounGenSin',      // Rules for genitive sing nouns
                   'BtnTestNounGenSin',      // Test for genitive sing nouns
                   'BtnFreeNounGenSin',      // Free test for gen sing nouns
                   'BtnRuleAdjGenSin',       // Rules for genitive singular adj
                   'BtnTestAdjGenSin',       // Test for genitive singular adj
                   'BtnFreeAdjGenSin',       // Free test for genitive sing adj
                   'BtnRuleNounGenPlu',      // Rules for genitive plural nouns
                   'BtnTestNounGenPlu',      // Test for genitive plural nouns
                   'BtnFreeNounGenPlu',      // Free test for gen plural nouns
                   'BtnRuleAdjGenPlu',       // Rules for genitive plural adj
                   'BtnTestAdjGenPlu',       // Test for genitive plural adj
                   'BtnFreeAdjGenPlu',       // Free test for gen plural adj
                   'BtnTestNoExp',           // Test terms without expansion
                   'BtnTestAdjExp',          // Test adjective expansion
                   'BtnRuleAdjExp',          // Rules for adjective expansion
                   'BtnFreeAdjExp',          // Free test for adj expansion
                   'BtnTestMandExp',         // Test mandatory expansion
                   'BtnTestLatExp',          // Test lateral expansion
                   'BtnTestOptjExp' );       // Test optional expansion

                   // Values for syntactic tests
  cTypeTest:       Array[ tTypeTest ] of String = (
                   'undef',                  // Undefined
                   'NounGender',             // Test gender of nouns
                   'AdjGender',              // Test gender of adjectives
                   'NounPlural',             // Test plural of nouns
                   'AdjPlural',              // Test plural of adjectives
                   'NounGenSin',             // Test genitive singular of nouns
                   'AdjGenSin',              // Test genitive singular of adjs
                   'NounGenPlu',             // Test genitive plural of nouns
                   'AdjGenPlu',              // Test genitive plural of adjs
                   'NoExp',                  // Test terms without expansion
                   'AdjExp',                 // Test adjective expansion
                   'MandExp',                // Test mandatory expansion
                   'LatExp',                 // Test lateral expansion
                   'OptExp' );               // Test optional expansion

                   // Lateral strings
  cLatString:      Array[ tLatType ] of String = (
                   '',                       // undefined value
                   'mns',                    // masc nom sing
                   'mgs',                    // masc gen sing
                   'mnp',                    // masc nom plur
                   'mgp',                    // masc gen plur
                   'fns',                    // fem nom sing
                   'fgs',                    // fem gen sing
                   'fnp',                    // fem nom plur
                   'fgp',                    // fem gen plur
                   'nns',                    // neuter nom sing
                   'ngs',                    // neuter gen sing
                   'nnp',                    // neuter nom plur
                   'ngp' );                  // neuter gen plur

  cQualShort:      Array[ tQualifier ] of String = (
                   'non', 'exp', 'exr', 'obl', 'dbl',
                   'set', 'pst', 'sst', 'dst', 'par',
                   'sin', 'dex', 'ref', 'del' );

  cQualifier:      Array[ tQualifier ] of String = (
                   'single entity',
                   'optional expansion',
                   'indirect optional expansion',
                   'mandatory expansion',
                   'double expansion',
                   'set entity',
                   'pset entity',
                   'left set entity',
                   'right set entity',
                   'pair entity',
                   'left member',
                   'right member',
                   'reference',
                   'deleted entity' );

                   // Values for type of entity in English
  cTipEN:          Array[ tTip ] of String = (
                   'undefined',             // undefined tip
                   'single',                // single tetrahedron = 1
                   'generic pair',          // pair generator = 2
                   'specific pair',         // pair main = 3
                   'left pair',             // pair left = 4
                   'right pair',            // pair right = 5
                   'generic pset',          // pset generator = 6
                   'generic set pset',      // pset set = 7
                   'specific pset',         // pset main = 8
                   'left pset',             // pset left = 9
                   'right pset',            // pset right = 10
                   'generic set',           // set generator = 11
                   'specific set',          // set main = 12
                   'reference',             // reference = 13
                   'deleted',               // deleted = 14
                   'lexical',               // lexical reference = 15
                   'taxonomic',             // taxonomic generic entity = 16
                   'disabled',              // waiting entity = 17
                   'vocabulary',            // vocabulary entity = 18
                   'TA98 duplicate',        // duplicated entity = 19 (TA98)
                   'presentation',          // interface entity = 20
                   'specific mset',         // mset main = 21
                   'generic mset' );        // mset generator = 22

                   // Values for type of entity in French
  cTipFR:          Array[ tTip ] of String = (
                   'indéfinie',             // undefined tip
                   'simple',                // single tetrahedron = 1
                   'paire générique',       // pair generator = 2
                   'paire spécifique',      // pair main = 3
                   'paire gauche',          // pair left = 4
                   'paire droite',          // pair right = 5
                   'pset générique',        // pset generator = 6
                   'set pset générique',    // pset set = 7
                   'pset spécifique',       // pset main = 8
                   'pset gauche',           // pset left = 9
                   'pset droit',            // pset right = 10
                   'set générique',         // set generator = 11
                   'set spécifique',        // set main = 12
                   'référence',             // reference = 13
                   'effacée',               // deleted = 14
                   'lexicale',              // lexical reference = 15
                   'taxonomique',           // taxonomic generic entity = 16
                   'en attente',            // waiting entity = 17
                   'vocabulaire',           // vocabulary entity = 18
                   'TA98 duplifiée',        // duplicated entity = 19 (TA98)
                   'présentation',          // interface entity = 20
                   'mset spécifique',       // mset main = 21
                   'mset générique' );      // mset generator = 22

                   // Values for type of entity in Spanish
  cTipES:          Array[ tTip ] of String = (
                   'undefined',             // undefined tip
                   'single',                // single tetrahedron = 1
                   'generic pair',          // pair generator = 2
                   'specific pair',         // pair main = 3
                   'left pair',             // pair left = 4
                   'right pair',            // pair right = 5
                   'generic pset',          // pset generator = 6
                   'generic set pset',      // pset set = 7
                   'specific pset',         // pset main = 8
                   'left pset',             // pset left = 9
                   'right pset',            // pset right = 10
                   'generic set',           // set generator = 11
                   'specific set',          // set main = 12
                   'reference',             // reference = 13
                   'deleted',               // deleted = 14
                   'lexical',               // lexical reference = 15
                   'taxonomic',             // taxonomic generic entity = 16
                   'disabled',              // waiting entity = 17
                   'vocabulary',            // vocabulary entity = 18
                   'TA98 duplicate',        // duplicated entity = 19 (TA98)
                   'presentation',          // interface entity = 20
                   'specific mset',         // mset main = 21
                   'mset generic' );        // mset generator = 22

                   // Values for type of entity in Russian
  cTipRU:          Array[ tTip ] of String = (
                   'undefined',             // undefined tip
                   'single',                // single tetrahedron = 1
                   'generic pair',          // pair generator = 2
                   'specific pair',         // pair main = 3
                   'left pair',             // pair left = 4
                   'right pair',            // pair right = 5
                   'generic pset',          // pset generator = 6
                   'generic set pset',      // pset set = 7
                   'specific pset',         // pset main = 8
                   'left pset',             // pset left = 9
                   'right pset',            // pset right = 10
                   'generic set',           // set generator = 11
                   'specific set',          // set main = 12
                   'reference',             // reference = 13
                   'deleted',               // deleted = 14
                   'lexical',               // lexical reference = 15
                   'taxonomic',             // taxonomic generic entity = 16
                   'disabled',              // waiting entity = 17
                   'vocabulary',            // vocabulary entity = 18
                   'TA98 duplicate',        // duplicated entity = 19 (TA98)
                   'presentation',          // interface entity = 20
                   'specific mset',         // mset main = 21
                   'generic mset' );        // mset generator = 22

                   // Values for Unit type in English
  cTetraEN:        Array[ tTetra ] of String = (
                   'undef',                  // undefined type
                   'single',                 // single entity
                   'pair',                   // pair
                   'pset',                   // pair set
                   'set',                    // set
                   'ref',                    // reference
                   'del',                    // deleted entity
                   'lex',                    // lexical reference
                   'tax',                    // taxonomic entity
                   'trans',                  // no op entity or placeholder
                   'voc',                    // vocabulary unit
                   'dup',                    // duplicate unit
                   'int',                    // interface unit
                   'mset' );                 // mixed set

                   // Values for Unit type in French
  cTetraFR:        Array[ tTetra ] of String = (
                   'indéfinie',              // undefined type
                   'simple',                 // single entity
                   'paire',                  // pair
                   'pset',                   // pair set
                   'set',                    // set
                   'référence',              // reference
                   'effacée',                // deleted entity
                   'lexicale',               // lexical reference
                   'taxonomique',            // taxonomic entity
                   'en attente',             // no op entity or placeholder
                   'vocabulaire',            // vocabulary unit
                   'TA98 duplifiée',         // duplicate unit
                   'présentation',           // interface unit
                   'mset' );                 // mixed set

                   // Values for Unit type in Spanish
  cTetraES:        Array[ tTetra ] of String = (
                   'undef',                  // undefined type
                   'single',                 // single entity
                   'pair',                   // pair
                   'pset',                   // pair set
                   'set',                    // set
                   'ref',                    // reference
                   'del',                    // deleted entity
                   'lex',                    // lexical reference
                   'tax',                    // taxonomic entity
                   'trans',                  // no op entity or placeholder
                   'voc',                    // vocabulary unit
                   'dup',                    // duplicate unit
                   'int',                    // interface unit
                   'mset' );                 // mixed set

                   // Values for Unit type in Russian
  cTetraRU:        Array[ tTetra ] of String = (
                   'undef',                  // undefined type
                   'single',                 // single entity
                   'pair',                   // pair
                   'pset',                   // pair set
                   'set',                    // set
                   'ref',                    // reference
                   'del',                    // deleted entity
                   'lex',                    // lexical reference
                   'tax',                    // taxonomic entity
                   'trans',                  // no op entity or placeholder
                   'voc',                    // vocabulary unit
                   'dup',                    // duplicate unit
                   'int',                    // interface unit
                   'mset' );                 // mixed set

                   // Modifier for term composition (Latin Page)
  cModif:          Array[ tp_single .. tp_dup ] of String = (
                   '',                       // single tetra
                   '',                       // head of pair tetra
                   'pair',                   // main of pair tera
                   'left entity',            // left of pair tetra
                   'right entity',           // right of pair tetra
                   '',                       // head of pset tetra
                   'plural',                 // set of pset tetra
                   'pair set',               // main of pset tera
                   'left plural',            // left of pset tetra
                   'right plural',           // right of pset tetra
                   '',                       // head of set tetra
                   'plural',                 // main of set tetra
                   'reference',              // reference
                   'deleted',                // deleted entity
                   'lexical reference',      // lexical reference
                   '',                       // generic entity
                   '',                       // discarded entity
                   '',                       // vacabulary entity
                   'duplicate (TA98)' );     // duplicate entity

  cTypeListPage:   Array[ tTypeListPage ] of String = (
                   'un',
                   'P1F',                    // partonomy level 1 full
                   'P1',                     // partonomy level 1
                   'P1F',                    // partonomy level 2 full
                   'P2',                     // partonomy level 2
                   'P2F',                    // partonomy level 2 full
                   'P3',                     // partonomy level 3
                   'P3F',                     // partonomy level 3 full
                   'P4',                     // partonomy level 4
                   'A1',                     // partonomy level 1
                   'A2',                     // partonomy level 2
                   'A2F',                    // partonomy level 2 full
                   'A3',                     // partonomy level 3
                   'A4',                     // partonomy level 4
                   'T1',                     // taxonomy level 1
                   'T1F',                    // taxonomy level 1 full
                   'T2',                     // taxonomy level 2
                   'T2F',                    // taxonomy level 2 full
                   'T3',                     // taxonomy level 3
                   'T3F',                    // taxonomy level 3 full
                   'T4',                     // taxonomy level 4
                   'T4',                     // interface level 4
                   'FMA',                    // FMA list
                   'XLS',                    // Excel input file
                   'GN',                     // generic any level
                   'Val' );                  // Universal validation

  cLexType:        Array[ tLexType ] of String = (
                   'u',                      // undefined lexeme
                   'N',                      // noun
                   'C',                      // noun complement
                   'A',                      // adjective
                   'P',                      // prefix
                   'I',                      // invariant
                   'M' );                    // apposition

  cFamily:         Array[ tFamily ] of String = (
                   '',                       // undefined
                   'direct ancestor',        // direct relation
                   'parent',                 // parent (direct step)
                   'grand-parent',           // grand-parent (2 direct steps)
                   'grand-grand-parent',     // grand-grand-parent (3 direct steps)
                   'ancestor',               // higher direct relation
                   'indirect ancestor',      // not in direct relation
                   'brother',                // brother (same parent)
                   'uncle',                  // uncle
                   'cousin',                 // cousin (same grand-parent)
                   'grand-uncle',            // grand-uncle
                   'grand-grand-uncle',      // grand-grand-uncle
                   'grand-cousin' );         // grand-cousin (cousin of parent)

                   // Generic access
  cShortOFF:       array[ lt_Latin .. lt_Russian, en .. fr ] of String = (
                   ( cShortOFFLAEN, cShortOFFLAFR ),
                   ( cShortOFFENEN, cShortOFFENFR ),
                   ( cShortOFFFREN, cShortOFFFRFR ),
                   ( cShortOFFSPEN, cShortOFFSPFR ),
                   ( cShortOFFRUEN, cShortOFFRUFR ) );
                   // Generic access
  bbShortOFF:      array[ lt_Latin ..lt_Spanish, en .. fr ] of String = (
                   ( bbShortOFFLAEN, bbShortOFFLAFR ),
                   ( bbShortOFFENEN, bbShortOFFENFR ),
                   ( bbShortOFFFREN, bbShortOFFFRFR ),
                   ( bbShortOFFSPEN, bbShortOFFSPFR ) );

                   // Sexe representation
  cSexe:           array[ sx_undef .. sx_Male ] of String = (
                   '',                         // undefined
                   'F',                        // female
                   'M' );                      // male

var
                   { Current working language. }
  LgCur:           tLanguage = lt_Latin;

implementation

end.
