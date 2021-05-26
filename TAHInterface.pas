{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit TAHInterface
  * Class for interface texts *
   ===========================
  Description:
  This unit contains the constants defining any texts of interface, pointing
  to the interface entities, and their multilingual content.</p>
  Each constant is a pointer to an interface entity, that contains three
  possible items in each language:
  - a title for classification and organization of all interface entities,
  - a value, that is the text to be made visible,
  - a bubble, that is a complement text to appear on user request as a bubble,
    making the first level of help system.</p>
  Each interface entity is possibly defined in all languages used as
  interface languages.</p>
  All interface entities are part of the taxonomy under the top entity
  12682 res presentationis. The top levels organizes the corpus of these
  entities according to classification criteria. At the bottom of this hierarchy
  we find the T4 level interface lists with a head entity and numerous
  related items.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit TAHInterface;

interface

const
                   // Libelles for section titles (under 12694)
  reSectIdent      = 12643;            // identification section
  reSectNavig      = 12653;            // navigation section
  reSectInt        = 12703;            // interface section
  reSectDefin      = 13245;            // definition section
  reSectProp       = 12655;            // property section
  reSectLatin      = 12641;            // Latin terms section
  reSectEnglish    = 12645;            // English terms section
  reSectFrench     = 12647;            // French terms section
  reSectSpanish    = 12649;            // Spanish terms section
  reSectRussian    = 12651;            // Russian terms section
  reSectPart       = 14093;            // partonomy section
  reSectLightPart  = 12657;            // light partonomy section
  reSectFullPart   = 12659;            // full partonomy section
  reSectTax        = 12661;            // taxonomy section
  reSectNavigList  = 13191;            // list navigation section
  reSectPartList   = 13192;            // partonomic list section
  reSectTaxList    = 13193;            // taxonomic list section
  reSectIntList    = 12624;            // interface list section
  reSectNote       = 13194;            // scientific notes section
  reSectSign       = 13195;            // signature section
  reSectTaxAnc     = 13225;            // taxonomic ancestor section
  reSectTaxDef     = 13242;            // taxonomic definition section
  reSectOcc        = 12760;            // occurence section
  reSectCTNGender  = 13198;            // controlled test of noun gender
  reSectFTNGender  = 14337;            // free test of noun gender
  reSectRTNGender  = 14339;            // rule test of noun gender

                   // Libelles for page titles (under 12685)
  reUnitPage       = 11343;            // Unit page
  reEntityPage     = 12625;            // Entity page
  reUniversalPage  = 14107;            // Universal page
  reDefinitionPage = 14187;            // Definition page
  rePartonomyPage  = 13189;            // Partonomy page
  reTaxonomyPage   = 13190;            // Taxonomy page
  reInterfacePage  = 12626;            // Interface page
  reLangTestPage   = 12660;            // Language test page

                   // Libelles for Language Test Page (under 12700)
  reTestNounGender = 12662;            // Test noun gender
  reTestAdjGender  = 12696;            // Test adjective gender
  reTestNoExp      = 14368;            // Test of terms without expansion
  reTestAllExp     = 14372;            // Test of terms for all expansions

                   // Libelles for Test Language sections (under 13199)
  reTestByDefault  = 13200;            // Test by default
  reTestByRule     = 13226;            // Test by rule
  reTestByExcept   = 13243;            // Test by exception
  reTestByDico     = 13246;            // Test by dictionary
  reTestResult     = 14094;            // Result of test
  reTestSuccess    = 14241;            // Success of test
  reTestFound      = 14255;            // Found a positive value
  reTestFail       = 14309;            // Failure of test
  reTestInstead    = 14311;            // Expected value of test
  reTestMasculine  = 14316;            // Masculine value for gender test
  reTestFeminine   = 14318;            // Feminine value for gender test
  reTestNeuter     = 14320;            // Neuter value for gender test
  reTestEntries    = 14322;            // Number of entries in test
  reTestSize       = 14329;            // Size of test
  reTestTotRules   = 14364;            // Total of rules
  reTestDefault    = 14351;            // Word default
  reTestStatistics = 14353;            // Statistics for test
  reTestTotMasc    = 14355;            // Total of masculine items
  reTestTotFem     = 14357;            // Total of feminine items
  reTestValid      = 14360;            // Total of validated entries
  reTestDuplic     = 14362;            // Total of duplicates
  reTestTotal      = 14363;            // Grand total
  reTestExcMasc    = 14365;            // Masculine exceptions
  reTestExcFem     = 14366;            // Feminine execptions

                   // General libelles for page (under 12686)
  rePrimaryLang    = 12627;            // Primary language
  reSecondaryLang  = 12628;            // Secondary language
  reDisplayLang    = 12629;            // Display language
  reWorkInProgress = 12630;            // Experimental version
  reLines          = 13211;            // Line number for lists
  reDateGener      = 13212;            // Date of page
  reHelpOnColors   = 12663;            // Help on colors
  reHelpOnPage     = 12667;            // Help on current page
  rePageIntro      = 12761;            // Page introduction
  reBicolSection   = 14331;            // Head section for Bicol
  reBicolLeft      = 14333;            // Head left column for Bicol
  reBicolRight     = 14335;            // Head right column for Bicol
  reInLatin        = 14341;            // Test working language LA
  reInEnglish      = 14343;            // Test working language EN
  reInFrench       = 14345;            // Test working language FR
  reInSpanish      = 14347;            // Test working language ES
  reInRussian      = 14349;            // Test working language RU

                   // Libelles for Identification section (under 12688)
  reLibOffLatin    = 12612;            // Official Latin term
  reLibOffTerm     = 12613;            // Official term (primary language)
  reLibFormalTerm  = 12614;            // Formal term
  reLibEquivTerm   = 12615;            // Equivalent term (subsidiary language)
  reLibEntityID    = 12616;            // Entity identifier
  reLibUnitID      = 12617;            // Unit identifier
  reLibTypeEntity  = 12618;            // Type of entity
  reLibTypeUnit    = 12619;            // Type of unit
  reLibMaterial    = 14310;            // Materiality

                   // Libelles for Interface list section (under 12644)
  reLibHeadTitle   = 12638;            // Column title
  reLibHeadBubble  = 12642;            // Column bubble


                   // Libelles for Interface section (under 13196)
  reInterfaceEN    = 12664;            // English interface
  reInterfaceFR    = 12668;            // French interface
  reInterfaceES    = 12669;            // Spanish interface
  reInterfaceRU    = 12704;            // Russian interface

                   // Values for types of materiality (under 12621)
  reValGenusMat    = 14312;            // value material
  reValGenusImm    = 14313;            // value immaterial
  reValGenusNon    = 14314;            // value non physical

                   //  Values for types of entity (under 12622)
  reUnitGeneric    = 12718;            // type of entity generic
  reUnitSpecific   = 12722;            // type of entity specific
  reEntityEntity   = 12743;            // type of entity entity
  reValGenusUndef  = 12705;            // type undefined entity
  reValGenusSingle = 14338;            // type single
  reValGenusGenpair= 14340;            // type genpair
  reValGenusPair   = 14342;            // type pair
  reValGenusLpair  = 14344;            // type leftpair
  reValGenusRpair  = 14346;            // type rightpair
  reValGenusGenps  = 14348;            // type genpset
  reValGenusSetps  = 14350;            // type setpset
  reValGenusPset   = 14352;            // type pset
  reValGenusLps    = 14354;            // type leftpset
  reValGenusRps    = 14356;            // type rightpset
  reValGenusGenset = 14315;            // type genset
  reValGenusSet    = 14307;            // type set
  reValGenusGenms  = 14359;            // type genmset
  reValGenusMset   = 14358;            // type mset
  reValGenusRef    = 14317;            // type ref
  reValGenusDel    = 14334;            // type del
  reValGenusLex    = 14332;            // type lex
  reValGenusTax    = 14330;            // type tax
  reValGenusWait   = 14328;            // type wait
  reValGenusVoc    = 14319;            // type voc
  reValGenusDup    = 14336;            // type dup (TA98)
  reValGenusInt    = 14321;            // type int

                   // Values for types of unit (under 12623)
  reUnitGenusUndef = 12658;            // type undefined unit
  reUnitGenusSingle= 12739;            // type single
  reUnitGenusPair  = 12740;            // type pair
  reUnitGenusSet   = 12741;            // type set
  reUnitGenusPset  = 12742;            // type pset
  reUnitGenusMset  = 14371;            // type mset
  reUnitGenusref   = 12648;            // type ref
  reUnitGenusdel   = 12650;            // type del
  reUnitGenuslex   = 12652;            // type lex
  reUnitGenusTax   = 12719;            // type tax
  reUnitGenusWait  = 12654;            // type wait
  reUnitGenusVoc   = 12720;            // type voc
  reUnitGenusDup   = 12656;            // type dup
  reUnitGenusInt   = 12721;            // type int

                   // Libelles for List Navigation section (under )
  reHomePage       = 14095;            // Home page
  buHomePage       = 14096;            // Bubble of home page
  reTopLevel       = 13181;            // Top level
  buTopLevel       = 13185;            // Top level bubble
  reLevel2         = 13182;            // Level 2
  buLevel2         = 13186;            // Level 2 bubble
  reLevel3         = 13183;            // Level 3
  buLevel3         = 13187;            // Level 3 bubble
  reCurrentLevel   = 13184;            // Current level
  buCurrentLevel   = 13188;            // Current level bubble
  reLatinSel       = 14108;            // Latin language selection
  buLatinSel       = 14112;            // Bubble for latin language selection
  reLanguageSel    = 13227;            // Language selection
  buLanguageSel    = 13228;            // Bubble for language selection
  reLatin          = 13229;            // Latin language
  reEnglish        = 13230;            // English language
  reFrench         = 13231;            // French language
  reSpanish        = 13232;            // Spanish language
  reRussian        = 13233;            // Russian language
  buLAEN           = 14113;            // Bubble Latin-English
  buLAFR           = 14114;            // Bubble Latin-French
  buLAES           = 14115;            // Bubble Latin-Spanish
  buLARU           = 14116;            // Bubble Latin-Russian
  buENLA           = 14117;            // Bubble English-Latin
  buFRLA           = 14128;            // Bubble French-Latin
  buESLA           = 14129;            // Bubble Spanish-Latin
  buRULA           = 14130;            // Bubble Russian-Latin
  buSpecificity    = 12728;            // Property specificity bubble
  buSpecificText   = 12731;            // Specificity specific bubble
  buGenericText    = 12733;            // Specificity generic bubble
  buBilaterality   = 12753;            // Property bilaterality bubble
  buGenerator      = 12756;            // Property generator
  buComposition    = 12750;            // Property composition bubble
  buMateriality    = 12746;            // Property materiality bubble
  buDimension      = 12736;            // Property dimension bubble
  buTridimension   = 12737;            // Dimension tridimension bubbl
  buNavigToUnit    = 12671;            // Link to unit bubble
  buNavigToEntity  = 12673;            // Link to entities bubble
  buLateralNavig   = 12679;            // Lateral navigation bubble
  buEntityOriented = 12702;            // Entity-oriented links bubble
  buToPartonomy    = 12724;            // Link to partonomy bubble
  buToTaxonomy     = 12726;            // Link to taxonomy bubble
  buInternalTerm   = 12640;            // Database internal term bubble
  buMissingUniv    = 12666;            // Missing term from formula bubble
  buVocabulary     = 12758;            // Induced vocabulary bubble
  buByNoun         = 12763;            // Search by noun bubble
  buByAdjective    = 8841;             // Search by adjective bubble
  buByPrefix       = 9939;             // Search by prefix bubble
  buNbOccur        = 9946;             // Number of occurrences

                   // Libelles for Navigation section (under 12689)
  reLevel          = 13178;            // Level
  reShort          = 13179;            // Short for type of partonomic files
  reFull           = 13180;            // Full for type of partonomic files

                   // Libelles for Property section
  reUnitUnit       = 12744;            // Type of unit unit
  reSpecificity    = 12727;            // Property specificity
  reSpecificText   = 12730;            // Specificity specific
  reGenericText    = 12732;            // Specificity generic
  reGenerator      = 12755;            // Property generator
  reBilaterality   = 12752;            // Property bilaterality
  reIsSymPair      = 12754;            // Bilaterality pair
  reComposition    = 12749;            // Property composition
  reIsMultiple     = 12751;            // Composition set
  reMateriality    = 12745;            // Property materiality
  reMaterial       = 12747;            // Materiality material
  reImmaterial     = 12748;            // Materiality immaterial
  reDimension      = 12735;            // Property dimension
  reTridimension   = 12738;            // Dimension tridimension

                   // Libelles for Language sections (under 12691)
  reUniversalTerm  = 12632;            // Universal term
  buUniversalTerm  = 12633;            // Universal term bubble
  reMainTerm       = 12634;            // Official main term
  buMainTerm       = 12635;            // Official main term bubble
  reTermStatus     = 12636;            // Term status
  buTermStatus     = 12637;            // Term status bubble
  reStatusUni      = 14097;            // Status universal
  buStatusUni      = 14101;            // Bubble for status universal
  reStatusHer      = 14135;            // Status modified universal
  buStatusHer      = 14136;            // Bubble for status modified universal
  reStatusReg      = 14098;            // Status regular
  buStatusReg      = 14102;            // Bubble for status regular
  reStatusPro      = 14099;            // Status protected
  buStatusPro      = 14105;            // Bubble for status protected
  reStatusIrr      = 14100;            // Status irregular
  buStatusIrr      = 14106;            // Bubble for status irregular
  reTA98LATerm     = 14175;            // TA98 Latin official term
  buTA98LATerm     = 14176;            // Bubble for TA98 Latin official term
  reTA98ENTerm     = 14177;            // TA98 English official equivalent
  buTA98ENTerm     = 14178;            // Bubble for TA98 English equivalent
  reTA98FRTerm     = 14179;            // TA98 French official equivalent
  buTA98FRTerm     = 14180;            // Bubble for TA98 French equivalent
  reTA98ESTerm     = 14181;            // TA98 Spanish official equivalent
  buTA98ESTerm     = 14182;            // Bubble for TA98 Spanish equivalent
  reTA98RUTerm     = 14183;            // TA98 Russian official equivalent
  buTA98RUTerm     = 14184;            // Bubble for TA98 Russian equivalent
  reRelatedTerm    = 14185;            // TA98 related term
  buRelatedTerm    = 14186;            // Bubble for TA98 related term
  reInternalTerm   = 12639;            // Database internal term
  reMissingUniv    = 12665;            // Missing term from formula
  reVocabulary     = 12757;            // Induced vocabulary
  reByNoun         = 12762;            // Search by noun
  reByAdjective    = 8838;             // Search by adjective
  reByPrefix       = 8839;             // Search by prefix
  reNbOccur        = 8840;             // Number of occurrences
  reNavigToUnit    = 12670;            // Link to unit
  reNavigToEntity  = 12672;            // Link to entities
  reGeneric        = 12674;            // Generic adjective
  reTaxonomic      = 12675;            // Taxonomic adjective
  reGenericSet     = 12676;            // Generic set adjective
  reSpecific       = 12677;            // Specific adjective
  reLateralNavig   = 12678;            // Lateral navigation
  reLeft           = 12680;            // Left adjective
  reRight          = 12681;            // Right adjective
  reEntityOriented = 12701;            // Entity-oriented links
  reToPartonomy    = 12723;            // Link to partonomy
  reToTaxonomy     = 12725;            // Link to taxonomy

                   // Libelles for hierarchy sections
  reShortTermLA    = 13201;            // Short term column header: Latin
  buShortTermLA    = 13206;            // Short term bubble: Latin
  reShortTermEN    = 13202;            // Short term column header: English
  buShortTermEN    = 13207;            // Short term bubble: English
  reShortTermFR    = 13203;            // Short term column header: French
  buShortTermFR    = 13208;            // Short term bubble: French
  reShortTermES    = 13204;            // Short term column header: Spanish
  buShortTermES    = 13209;            // Short term bubble: Spanish
  reShortTermRU    = 13205;            // Short term column header: Russian
  buShortTermRU    = 13210;            // Short term bubble: Russian
  reChildren       = 14188;            // Term for children
  reTotalList      = 14189;            // Term for number of nodes in a list
  buTotalList      = 14190;            // Bubble for number of nodes

                   // Libelles for definition section (under 13247)
  reDefTaxonomic   = 13251;            // Libelle for taxonomic definition
  buDefTaxonomic   = 13252;            // Bubble for taxonomic definition
  reTaxGlobal      = 13254;            // Libelle for global taxonomy
  buTaxGlobal      = 13255;            // Bubble for global taxonomy
  reNoDefinition   = 13256;            // Libelle for absence of definition
  reInDifferentia  = 13257;            // Libelle for entry in differentia
  reLeftSide       = 13258;            // Libelle for left side
  reRightSide      = 13259;            // Libelle for right side

                   // Single word libelles
  rePair           = 14134;            // The term pair

implementation

end.
