{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit FRProc
  * Formal management of the French language *
   ==========================================
  Description:
  This package handles all aspects of the French language in order to
  manipulate and generate French terms. This package is defined in conformity
  to the language specifications for the universal terminology. It is sufficient
  for the domain of anatomy when the RAT rules are applied. There is no need
  of a dictionary.</p>
  For testing purpose, rules, exceptions and check data are made available and
  are uniquely defined in the present package.</P>

  Specifications for anatomical French:
  - French has two genders for nouns and adjectives.
  - Genitive is built with a preposition, without declension, similar to the
    nominative form.
  - Articles may be necessary for the genitive: an ellision is possible in
    front of some words.
  - Prepositions are possible, without declension, as for the genitive form.
  - Adjectives are variable in number and gender, in accordance with the
    noun that they qualify.
  - The order of words issued from the universal formula is exactly the Latin
    order.</p>
  The ground treatment of French terms is realized by basic procedures
  belonging to the class French term. They are the following:
  - Create: makes a French term at nominative singular.
  - MakePluralFR: gives the nominative plural of a term.
  - MakeLateralFR: gives the lateral term at nominative singular.
  - MakeLatPluralFR: gives the lateral term at nominative plural.
  - MakeGenLatPluralFR: gives the lateral term at genitive plural.
  - MakeGenitiveFR: gives the genitive singular of a term.
  - SetNominativeFR: makes a French term at nominative singular.
  - SetSyntaxFR: verify and adjust the syntax of a term.
  - SetFormulaFR: create the base part of a universal formula in French.
  - GenderFR: gives the gender of a term.
  - MakeGenderFR: makes a feminine adjective.
  - MakeMandatFR: build a mandatory expansion as the genitive form of the entity
    defined for the mandatory expansion.
  Several procedures are needed for the realization of expansions of the
  French terms. They are independant procedures, external to the class
  French term. They are the followings:
  - SetBaseFR: build the base part of a term.
  - SetOptionFR: build an optional expansion as the genitive form of the entity
    defined for the oprional expansion.
  - SetAdjectiveFR: add a (prefixed) adjective to the base part of a
    term, resulting from an adjective expansion.
  - SetFormalPSetFR: build a formal pset term.
  - SetFormalSetFR: build a formal set term.</p>
  In addition, a number of independant utilities are provided. Test procedures
  have been developed. They are the followings:
  - TestNounGenderFR: for a given noun, it gives its gender.
  - TestAdjectiveGenderFR: for a given masculine adjective, it gives its
    feminine.
  - TestNounPluralFR: for a given singular noun, it gives its plural.
  - TestAdjPluralFR: for a given singular adjective, whatever its gender, it
    gives its plural</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit FRProc;

interface

uses
  TAHParam, Term, SingleTerms;

                   // Constant value for count of occurences
                   // All these constants starts with Nbxxx
const
  NbWordRuPluralFR = 8;
  NbNounExPluralFR = 4;
  NbNounChPluralFR = 26;
  NbAdjExPluralFR  = 1;
  NbAdjChPluralFR  = 2;
  NbFrontFR        = 17;
  NbBinome         = 4;
  NbAdjRuGenderFR  = 20;
  NbAdjExGenderFR  = 14;
  NbAdjChGenderFR  = 41;
  NbNounRuGenderFR = 8;
  NbNounExGenderFR = 102;
  NbNounChGenderFR = 17;
  NbNoChExpFR      = 11;
  NbAdjChExpFR     = 9;
  NbAdjRuExpFR     = 7;
  NbMandChExpFR    = 4;
  NbLatChExpFR     = 7;
  NbOptChExpFR     = 1;

type
                   // Rules for plural of nouns and adjectives
  tWordRuPluralFR  = Array[ 1 .. NbWordRuPluralFR,
                            nu_sin .. nu_plu ] of String;
                   // Exceptions for plural of nouns
  tNounExPluralFR  = Array[ 1 .. NbNounExPluralFR,
                            nu_sin .. nu_plu ] of String;
                   // Test values for plural of nouns
  tNounChPluralFR  = Array[ 1 .. NbNounChPluralFR,
                            nu_sin .. nu_plu ] of String;
                   // Exceptions for plural of adjectives
  tAdjExPluralFR   = Array[ 1 .. NbAdjExPluralFR,
                            nu_sin .. nu_plu ] of String;
                   // Test values for plural of adjectives
  tAdjChPluralFR   = Array[ 1 .. NbAdjChPluralFR,
                            nu_sin .. nu_plf ] of String;
                   // Frontal adjectives
  tFrontFR         = Array[ 1 .. NbFrontFR ] of String;
                   // To be deleted
  tBinome          = Array[ 1 .. NbBinome, 1 .. 2 ] of String;
                   // Rules for feminine adjective
  tAdjRuGenderFR   = Array[ 1 .. NbAdjRuGenderFR,
                            ge_masculine .. ge_feminine ] of String;
                   // Exceptions for feminine adjectives
  tAdjExGenderFR   = Array[ 1 .. NbAdjExGenderFR,
                            ge_masculine .. ge_feminine ] of String;
                   // Controled tests for feminine adjectives
  tAdjChGenderFR   = Array[ 1 .. NbAdjChGenderFR,
                            ge_masculine .. ge_feminine ] of String;
                   // Rules for feminine nouns
  tNounRuGenderFR  = Array[ 1 .. NbNounRuGenderFR,
                            va_word .. va_1 ] of String;
                   // Exceptions for feminine nouns
  tNounExGenderFR  = Array[ 1 .. NbNounExGenderFR,
                            va_word .. va_1 ] of String;
                   // Controlled tests for feminine nouns
  tNounChGenderFR  = Array[ 1 .. NbNounChGenderFR, va_word .. va_1 ] of String;
                   // Tests for terms without expansion
  tNoChExpFR       = Array[ 1 .. NbNoChExpFR, nu_sin .. nu_plu ] of Integer;
                   // Tests for adjective expansions
  tAdjChExpFR      = Array[ 1 .. NbAdjChExpFR, nu_sin .. nu_plu ] of Integer;
  tAdjRuExpFR      = Array[ 1 .. NbAdjRuExpFR, 1 .. 2 ] of String;
                   // Tests for mandatory expansions
  tMandChExpFR     = Array[ 1 .. NbMandChExpFR,  nu_sin .. nu_plu ] of Integer;
                   // Tests for lateral expansions
  tLatChExpFR      = Array[ 1 .. NbLatChExpFR, nu_sin .. nu_plu ] of Integer;
                   // Tests for optional expansions
  tOptChExpFR      = Array[ 1 .. NbOptChExpFR, nu_sin .. nu_plu ] of Integer;

                             // Define the French Term object
  tFRTerm                    = class( tTerm )

                             // Constructor with a nominative
    constructor              Create(
                               Nominative: String );
                             // Make the nominative plural of the term
    function                 MakePluralFR(
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Make the lateral form of the term
    function                 MakeLateralFR
                               : String;
                             // Make the lateral plural form of the term
    function                 MakeLatPluralFR
                               : String;
                             // Make the genitive singular of the term
    function                 MakeGenitiveFR
                               : String;
                             // Make the genitive lateral plural of the term
    function                 MakeGenLatPluralFR
                               : String;
                             // Enter the nominative singular of the term
    procedure                SetNominativeFR;
                             // Compile the syntax of a term
    procedure                SetSyntaxFR;
                             // Enter the formula of the term
    procedure                SetFormulaFR;
                             // Find the gender of a term
    function                 GenderFR(
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : tGender;
                             // Make a feminine adjective from a masculine form
    function                 MakeGenderFR(
                               AWord: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Make the mandatory expansion of a term
    function                 MakeMandatFR(
                               MyTerm: tSingle )
                               : Boolean;
                             // Set the optional expansion of a term
    function                 MakeOptionFR(
                               MyTerm: tSingle )
                               : Boolean;
                             // Add a specified adjective to a term
    function                 MakeAdjectiveFR(
                               Adj: String;
                               Pre: String )
                               : Boolean;
                             // Set the base part of a term
    function                 SetBaseFR
                               : Boolean;
  end; // type tFRTerm

                             // Create the elision flag
  function                   IsElisionFR(
                               Text: String )
                               : Boolean;
                             // Create the front adjective flag
  function                   IsFrontFR(
                               Text: String )
                               : Boolean;
                             // Set a formal pset term
  function                   SetFormalPSetFR(
                               Term: tSingle )
                               : String;
                             // Set a formal set term
  function                   SetFormalSetFR(
                               Term: tSingle )
                               : String;
                             // Test for gender of nouns
  function                   TestNounGenderFR(
                               ANoun: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Test for gender of adjectives
  function                   TestAdjectiveGenderFR(
                               AGender: tGender;
                               AnAdj: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Test for plural of nouns
  function                   TestNounPluralFR(
                               ANoun: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Test for plural of adjectives
  function                   TestAdjPluralFR(
                               AnAdj: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;

                   // Constants of the French language
                   // All these constants starts with cxxx
const
                   // Rules for plural of nouns and adjectives:
                   // The below list presents all the rules governing the
                   // creation of plural words from their singular counterpart.
  cWordRuPluralFR: tWordRuPluralFR = (
                   ( 's', 's' ),       // biceps
                   ( 'x', 'x' ),       // faux, squameux
                   ( 'al', 'aux' ),    // bicipital
                   ( 'ail', 'aux' ),   //
                   ( 'au', 'aux' ),    // peau, noyau,
                   ( 'eu', 'eux' ),    // cheveu
                   ( 'z', 'z' ),       // nez
                   ( '', 's' ) );      // aorte, aortique

                   // Plural exceptions for nouns:
  cNounExPluralFR: tNounExPluralFR = (
                   ( 'caillou', 'cailloux' ),
                   ( 'genou', 'genoux' ),
                   ( 'œil', 'yeux' ),
                   ( 'pou', 'poux' ) );

                   // Test values for plural of nouns
  cNounChPluralFR: tNounChPluralFR = (
                   ( 'abdomen', 'abdomens' ),
                   ( 'amygdale', 'amygdales' ),
                   ( 'appareil', 'appareils' ),
                   ( 'caillou', 'cailloux' ),
                   ( 'canal', 'canaux' ),
                   ( 'cerveau', 'cerveaux' ),
                   ( 'cou', 'cous' ),
                   ( 'cheveu', 'cheveux' ),
                   ( 'cortex', 'cortex' ),
                   ( 'dos', 'dos' ),
                   ( 'faux', 'faux' ),
                   ( 'forceps', 'forceps' ),
                   ( 'genou', 'genoux' ),
                   ( 'nez', 'nez' ),
                   ( 'noyau', 'noyaux' ),
                   ( 'os', 'os' ),
                   ( 'palai', 'palais' ),
                   ( 'peau', 'peaux' ),
                   ( 'pou', 'poux' ),
                   ( 'pubis', 'pubis' ),
                   ( 'scrotum', 'scrotums' ),
                   ( 'sinus', 'sinus' ),
                   ( 'travail', 'travaux' ),
                   ( 'vaisseau', 'vaisseaux' ),
                   ( 'vertex', 'vertex' ),
                   ( 'vomer', 'vomers' ) );

                   // Plural exceptions for adjectives:
  cAdjExPluralFR:  tAdjExPluralFR = (
                   ( 'natal', 'natals' ) );

                   // Test values for plural of adjectives
  cAdjChPluralFR:  tAdjChPluralFR = (
                   ( 'abdominal', 'abdominaux', 'abdominales' ),
                   ( 'adipeux', 'adipeux', 'adipeuses' ) );

                   // Frontal adjectives:
                   // These adjectives are expected to be placed in front of
                   // the noun they qualify, on the contrary of other adjectives
                   // to be placed after the noun.
  cFrontFR:        tFrontFR = (
                   'grand',
                   'grande',
                   'petit',
                   'petite',
                   'premier',
                   'première',
                   'deuxième',
                   'troisième',
                   'quatrième',
                   'cinquième',
                   'sixième',
                   'septième',
                   'huitième',
                   'neuvième',
                   'dixième',
                   'onzième',
                   'douzième' );

                   // Exceptions for gender of nouns.
  cNounExGenderFR: tNounExGenderFR = (
                   // feminine nouns
                   ( 'ampoule', 'f' ), ( 'amygdale', 'f' ), ( 'capsule', 'f' ),
                   ( 'cellule', 'f' ), ( 'clavicule', 'f' ), ( 'cloison', 'f' ),
                   ( 'dent', 'f' ), ( 'division', 'f' ), ( 'dure-mère', 'f' ),
                   ( 'faux', 'f' ),
                   ( 'humeur', 'f' ),
                   ( 'liaison', 'f' ),
                   ( 'main', 'f' ),
                   ( 'paroi', 'f' ), ( 'peau', 'f' ),
                   ( 'spérule', 'f' ),
                   ( 'trabécule', 'f' ),
                   ( 'vallécule', 'f' ), ( 'veinule', 'f' ), ( 'voie', 'f' ),
                   // masculine nouns
                   ( 'acromion', 'm' ), ( 'angle', 'm' ), ( 'antre', 'm' ),
                   ( 'appendice', 'm' ), ( 'arbre', 'm' ), ( 'axe', 'm' ),
                   ( 'axone', 'm' ),
                   ( 'bulbe', 'm' ),
                   ( 'calice', 'm' ),( 'capillaire', 'm' ),( 'cartilage', 'm' ),
                   ( 'centre', 'm' ), ( 'cercle', 'm' ), ( 'chiasme', 'm' ),
                   ( 'cône', 'm' ), ( 'coude', 'm' ), ( 'condyle', 'm' ),
                   ( 'crâne', 'm' ),
                   ( 'déclive', 'm' ), ( 'derme', 'm' ), ( 'diaphragme', 'm' ),
                   ( 'disque', 'm' ),
                   ( 'ensemble', 'm' ), ( 'épicondyle', 'm' ),( 'espace', 'm' ),
                   ( 'fascia', 'm' ), ( 'foie', 'm' ),
                   ( 'ganglion', 'm' ), ( 'globe', 'm' ), ( 'glomérule', 'm' ),
                   ( 'hélicotrème', 'm' ),( 'hémisphère', 'm' ),( 'hile', 'm' ),
                   ( 'hippocampe', 'm' ), ( 'hypogastre', 'm' ),
                   ( 'interneurone', 'm' ), ( 'isthme', 'm' ),
                   ( 'labyrinthe', 'm' ),( 'lemnisque', 'm' ),( 'liquide','m' ),
                   ( 'lobe', 'm' ),
                   ( 'maxillaire', 'm' ), ( 'membre', 'm' ),( 'ménisque', 'm' ),
                   ( 'mésentère', 'm' ),( 'motoneurone', 'm' ),( 'muscle','m' ),
                   ( 'neurone', 'm' ), ( 'névraxe', 'm' ),
                   ( 'œsophage', 'm' ), ( 'oesophage', 'm' ), ( 'organe', 'm' ),
                   ( 'orifice', 'm' ), ( 'ovaire', 'm' ),
                   ( 'périnée', 'm' ), ( 'péritoine', 'm' ), ( 'péronné', 'm' ),
                   ( 'pôle', 'm' ), ( 'prépuce', 'm' ), ( 'promontoire', 'm' ),
                   ( 'pylore', 'm' ),
                   ( 'raphé', 'm' ), ( 'rythme', 'm' ),
                   ( 'soma', 'm' ), ( 'scaphe', 'm' ), ( 'sphinctère', 'm' ),
                   ( 'squelette', 'm' ),( 'statocône','m' ),( 'striosome','m' ),
                   ( 'stroma', 'm' ), ( 'synapse', 'm' ), ( 'système', 'm' ),
                   ( 'tarse', 'm' ), ( 'ténia', 'm' ), ( 'terme', 'm' ),
                   ( 'tibia', 'm' ), ( 'trapèze', 'm' ), ( 'triangle', 'm' ),
                   ( 'trigone', 'm' ), ( 'type', 'm' ),
                   ( 'ulna', 'm' ),
                   ( 'voile', 'm' ) );

                   // Gender rules for nouns (default is masculine)
  cNounRuGenderFR: tNounRuGenderFR = (
                   ( 'é', 'f' ),            // cavité, entité, unité
                   ( 'a', 'f' ),            // patella, striola, habénula
                   ( 'ion', 'f' ),          // division, association, formation
                   ( 'ale', 'm' ),          // encéphale
                   ( 'ule', 'm' ),          // ventricule, pédoncule
                   ( 'yte', 'm' ),          // astrocyte
                   ( 'e', 'f' ),            // bulle, veine, hélice
                   ( '', 'm' ) );           // default masculine

                   // Test values for gender of nouns
  cNounChGenderFR: tNounChGenderFR = (
                   ( 'aggrégat', 'm' ),
                   ( 'astrocyte', 'm' ),
                   ( 'capsule', 'f' ),
                   ( 'cavité', 'f' ),
                   ( 'cellule', 'f' ),
                   ( 'cloison', 'f' ),
                   ( 'encéphale', 'm' ),
                   ( 'foie', 'm' ),
                   ( 'ganglion', 'm' ),
                   ( 'muscle', 'm' ),
                   ( 'paroi', 'f' ),
                   ( 'sphinctère', 'm' ),
                   ( 'striola', 'f' ),
                   ( 'système', 'm' ),
                   ( 'tibia', 'm' ),
                   ( 'ventricule', 'm' ),
                   ( 'voie', 'f' ) );

                   // Gender rules for feminine of adjectives
  cAdjRuGenderFR:  tAdjRuGenderFR = (
                   ( 'al', 'ale' ),         // spinal, cérébral, médial
                   ( 'e', 'e' ),            // interne, jaune, gracile, oblique,
                                            // fusiforme, médullaire, cuboïde
                   ( 'é', 'ée' ),           // cassé, strié, perforé, cutané
                   ( 'en', 'enne' ),        // moyen, coccygien, pubien
                   ( 'el', 'elle' ),        // sexuel, tentoriel, artériel
                   ( 'teur', 'trice' ),     // inhibiteur, excitateur
                   ( 'eur', 'eure' ),       // postérieur, majeur
                   ( 'eux', 'euse' ),       // bulbeux, osseux, fibreux, veineux
                   ( 'er', 'ère' ),         // premier, péronier, régulier
                   ( 'if', 'ive' ),         // olfactif, gustatif, auditif
                   ( 'il', 'ille' ),        // gentil
                   ( 'is', 'ise' ),         // gris
                   ( 'i', 'ie' ),           // arrondi, fléchi
                   ( 'u', 'ue' ),           // moussu, velu, charnu, crochu
                   ( 'us', 'use' ),         // diffus
                   ( 'c', 'che' ),          // blanc, franc
                   ( 'd', 'de' ),           // profond, rond, grand
                   ( 'n', 'ne' ),           // commun, médian, calcarin
                   ( 'r', 're' ),           // noir
                   ( 't', 'te' ) );         // petit, direct, court

                   // Exceptions for feminine of adjectives:
                   // Feminine adjectives are defined from their masculine
                   // value, applying the gender rules for adjectives. The
                   // below list present all exceptions prevailing on the rules.
  cAdjExGenderFR:  tAdjExGenderFR = (
                   ( 'ambigü', 'ambigüe' ),
                   ( 'beau', 'belle' ),
                   ( 'bijumeau', 'bijumelle' ),
                   ( 'bref', 'brève' ),
                   ( 'doux', 'douce' ),
                   ( 'faux', 'fausse' ),
                   ( 'fléchisseur', 'fléchisseuse' ),
                   ( 'gros', 'grosse' ),
                   ( 'long', 'longue' ),
                   ( 'mou', 'molle' ),
                   ( 'roux', 'rousse' ),
                   ( 'souteneur', 'souteneuse' ),
                   ( 'suspenseur', 'suspenseuse' ),
                   ( 'vieux', 'vieille' ) );

                   // Test values for feminine of adjectives
                   // This list, as far as possible, try to have one adjective
                   // similar by its ending to any existing adjective.
                   // In alphabetic order
  cAdjChGenderFR:  tAdjChGenderFR = (
                   ( 'arrondi', 'arrondie' ),
                   ( 'ascendant', 'ascendante' ),
                   ( 'beau', 'belle' ),
                   ( 'blanc', 'blanche' ),
                   ( 'bref', 'brève' ),
                   ( 'bulbeux', 'bulbeuse' ),
                   ( 'calcarin', 'calcarine' ),
                   ( 'cassé', 'cassée' ),
                   ( 'coccygien', 'coccygienne' ),
                   ( 'commun', 'commune' ),
                   ( 'compact', 'compacte' ),
                   ( 'court', 'courte' ),
                   ( 'direct', 'directe' ),
                   ( 'efférent', 'efférente' ),
                   ( 'externe', 'externe' ),
                   ( 'extrème', 'extrème' ),
                   ( 'gracile', 'gracile' ),
                   ( 'grand', 'grande' ),
                   ( 'gris', 'grise' ),
                   ( 'gros', 'grosse' ),
                   ( 'jaune', 'jaune' ),
                   ( 'lobaire', 'lobaire' ),
                   ( 'long', 'longue' ),
                   ( 'médian', 'médiane' ),
                   ( 'moteur', 'motrice' ),
                   ( 'mou', 'molle' ),
                   ( 'moussu', 'moussue' ),
                   ( 'moyen', 'moyenne' ),
                   ( 'noir', 'noire' ),
                   ( 'oblique', 'oblique' ),
                   ( 'olfactif', 'olfactive' ),
                   ( 'osseux', 'osseuse' ),
                   ( 'petit', 'petite' ),
                   ( 'premier', 'première' ),
                   ( 'profond', 'profonde' ),
                   ( 'propre', 'propre' ),
                   ( 'supérieur', 'supérieure' ),
                   ( 'suspenseur', 'suspenseuse' ),
                   ( 'spinal', 'spinale' ),
                   ( 'trapézoïde', 'trapézoïde' ),
                   ( 'vieux', 'vieille' ) );

                   // Test of terms without expansion
  cNoChExpFR:      tNoChExpFR = (
                   ( 5264, 5264 ),     // télencéphale (générique)
                   ( 29947, 29947 ),   // paupière (générique)
                   ( 7053, 7053 ),     // paupières
                   ( 6005, 6005 ),     // gyrus angulaire
                   ( 5973, 5973 ),     // gyrus cérébral
                   ( 7816, 7816 ),     // compartiment infratentoriel
                   ( 7670, 7670 ),     // neurone ganglionaire nain
                   ( 7044, 7044 ),     // anneau tendineux commun
                   ( 8088, 8088 ),     // méat acoustique externe osseux
                   ( 28553, 28553 ),   // fibre d'association courte
                   ( 6274, 6274 ) );   // fibres d'association courtes

                   // Test of adjective expansion
                   // First TID: st_mod; second TID: st_val
  cAdjChExpFR:     tAdjChExpFR = (
                   ( 4155, 4155 ),     // artère ulnaire
                   ( 33461, 7985 ),    // segments cervicaux de la m. épinière
                   ( 7986, 7986 ),     // segment cervical 1
                   ( 6985, 6985 ),     // artériole rétinienne temporale sup.
                   ( 8415, 8415 ),     // voie hypothalamospinale
                   ( 5792, 5792 ),     // commissure habénulaire
                   ( 6281, 6281 ),     // faisceaux occipitaux horizontaux
                   ( 11830, 11830 ),   // faisceau temporopariétal vertical
                   ( 10691, 10691 ) ); // quatrième vertèbre cervicale
  cAdjRuExpFR:     tAdjRuExpFR = (
                   ( '4155', 'NQ' ),   // artère ulnaire
                   ( '6281', 'NQA' ),  // faisceau occipital horizontal
                   ( '11830', 'NOQA' ),// faisceau temporopariétal vertical
                   ( '7986', 'NQI' ),  // segment cervical 1
                   ( '9511', 'NQPA' ), // faisceau frontal orbitopolaire
                   ( '6985', 'NQAA' ), // artériole rétinienne temporale sup.
                   ( '8415', 'NOQ' ) );// voie hypothalamospinale

                   // Test of mandatory expansion
  cMandChExpFR:    tMandChExpFR = (
                   ( 6085, 6085 ),     // radiation du corps calleux
                   ( 12294, 12294 ),   // fas medial ascendant du prosencephalon
                   ( 5142, 5142 ),     // partie spinale du fil terminal
                   ( 13172, 13172 ) ); // voie commissurale de l'hippocampe

                   // Test of lateral expansion
  cLatChExpFR:     tLatChExpFR = (
                   ( 38488, 38488 ),   // face supérolatérale du lobe frontal
                                       // gauche
                   ( 38443, 38443 ),   // lobe temporal droit
                   ( 28635, 28635 ),   // radiation gauche du corps calleux
                   ( 28935, 28935 ),   // cellules cholinergiques du bras
                                       // vertical de la strie diagonale droite
                   ( 32446, 32446 ),   // voies commissurales de l'hippocampe
                                       // gauche
                   ( 28074, 28074 ),   // fibres périventriculaires du thalamus
                                       // droit
                   ( 0, 0 ) );

                   // Test of optional expansion
  cOptChExpFR:     tOptChExpFR = (
                   ( 7985, 7985 ) );

                   // Binomes Latin-French
  cLAFREquiv:      tBinome = (
                   ( 'cornu', 'corne' ),
                   ( 'lamina', 'lame' ),
                   ( 'posterior', 'postérieur' ),
                   ( 'spinalis', 'spinal' ) );

implementation

uses
  SysUtils, Entity, TAHBrowser, LAProc, Tetra;

constructor        tFRTerm.Create(
  Nominative:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create
  * Variant of constructor of a French term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited Create( Nominative, lt_French );
end; // __________________________________________________________________Create

function           tFRTerm.MakePluralFR(
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralFR
  * Construction of a nominative plural French term *
  Description:
  This procedure handles a French nominative singular term made of any number
  of words (blank separated) and transform it to the nominative plural
  form.</p>
  It takes care of possible noun complements in the term, which are left
  unchanged. Prefixes are not recognized in this procedure and are considered
  as a part of the noun or adjective they modify. The presence of invariants
  is checked from a specified list, in order to left them unchanged by this
  procedure. The check for the presence of prepositional complements is only
  partially implemented.</p>
  The plural form is computed thanks to plural rules for French. These rules
  are considered in their initial order and only the first rule matching a word
  is applied, making their order quite significant. The last rule, because its
  singular form is empty, is always applied if no other rule matches
  before.</p>
  Invariants have to be recognized, in order not to change them at plural!
  This is performed through a local list.</p>
  Warning: as soon as a preposition or genitive is detected, the right part of
  the term is left unchanged. This could be wrong in a term like; fibres
  d'association latérales! But such a term must be considered as irregular.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
const
                   // List of invariants in set or pset
  Invar            : Array[ 1 .. 36 ] of String
                   = ( 'A2', 'A3', 'A4', 'A5', 'A6',
                       'A7', 'A8', 'A9', 'A10', 'A11',
                       'A12', 'A13', 'A14', 'A15', 'A16',
                       'Ch1', 'Ch2', 'Ch3', 'Ch4', 'Ch7',
                       'B4', 'B5', 'B6', 'B7', 'B8',
                       'B1', 'B2', 'B3', 'A1', '6',
                       'C1-C2', 'A1-A2', 'HVIIA', '1', '2',
                       'Ib' );
var
  Posit:           Integer;
  Indx:            Integer;
  Lgt:             Integer;
  NbInvar:         Integer;
  IsGen:           Boolean;
  IsInvar:         Boolean;
  IsExcept:        Boolean;
  Word:            String;
  Plural:          String;
  SingVal:         String;
  ATerm:           String;
begin

  // Loop on all words of the term
  ATerm := Self.Nominative;
  Plural := cEmpty;
  IsGen := False;
  IsRule := False;
  Ident := 0;
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

    // Check for presence of genitive or prepositions
    if ( not IsGen ) then
    begin
      IsGen := ( ( Word = 'de' ) or
                 ( Word = 'du' ) or
                 ( Word = 'des' ) or
                 ( Copy( Word, 1, 2 ) = 'd''' ) or
                 ( Word = 'en' ) );
    end;

    // Check for presence of an invariant
    IsInvar := False;
    NbInvar := Length( Invar );
    for Indx := 1 to NbInvar do
    begin
      if ( Word = Invar[ Indx ] ) then
      begin
        IsInvar := True;
        Break;
      end;
    end; // loop on all invariants

    // Append words at genitive, left unchanged
    if ( IsGen ) then
    begin
      Plural := Plural + cSpace + Word
    end else

    // Append invariant word, left unchanged
    if ( IsInvar ) then
    begin
      Plural := Plural + cSpace + Word
    end else
    begin

      // Define plural from exceptions for nouns
      IsExcept := False;
      for Indx := 1 to NbNounExPluralFR do
      begin
        if ( Word = cNounExPluralFR[ Indx, nu_sin ] )  then
        begin
          Word := cNounExPluralFR[ Indx, nu_plu ];
          Plural := Plural + cSpace + Word;
          IsExcept := True;
          Break;
        end;
      end; // for on all exceptions for plural nouns
      if ( IsExcept ) then
        Break;

      // Define plural from exceptions for adjectives
      IsExcept := False;
      for Indx := 1 to NbAdjExPluralFR do
      begin
        if ( Word = cAdjExPluralFR[ Indx, nu_sin ] )  then
        begin
          Word := cAdjExPluralFR[ Indx, nu_plu ];
          Plural := Plural + cSpace + Word;
          IsExcept := True;
          Break;
        end;
      end; // for on all exceptions for plural adjectives
      if ( IsExcept ) then
        Break;

      // Loop on all French plural rules for nouns and adjectives
      Plural := Plural + cSpace + Word;
      for Indx := 1 to NbWordRuPluralFR do
      begin
        SingVal := cWordRuPluralFR[ Indx, nu_sin ];
        Lgt := Length( SingVal );
        if ( Lgt > 0 ) then
        begin
          if ( Copy( Word, Length( Word ) - Lgt + 1, Lgt ) = SingVal ) then
          begin
            Plural := Copy( Plural, 1, Length( Plural ) - Lgt ) +
                      cWordRuPluralFR[ Indx, nu_plu ];
            IsRule := True;
            Ident := Indx;
            Break;
          end;
        end else
        begin
          Plural := Plural + cWordRuPluralFR[ Indx, nu_plu ];
          IsRule := True;
          Ident := Indx;
        end;
      end; // for on all rules for plural
    end;
  end; // while on all words of the term

  // Return plural term
  Result := Copy( Plural, 2, Length( Plural ) );
end; // ____________________________________________________________MakePluralFR

function           tFRTerm.GenderFR(
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                tGender;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GenderFR
  * Search for gender of the nominative noun of a term in French *
  Description:
  This procedure handles a French nominative singular term and determines
  its gender.</P>
  Usually a French terms start with a noun, but a few adjectives may come in
  front, as well as prefixes. Adjectives have to be checked from an explicit
  list. When this occurs, the noun is searched as a subsequent word of the
  term.</P>
  The gender is defined by rules based on endings for feminine nouns. In
  addition, a list of masculine and feminine exceptions is considered.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  CellPos:         Integer;
  Lgt:             Integer;
  Noun:            String;
  Termin:          String;
  Syntax:          String;
  MyNode:          WordAnal;
begin

  // Check for a possible adjective before the noun
  CellPos := 0;
  MyNode := Self.Node[ 0 ];
  Noun := MyNode.Lem;
  if ( IsFrontFR( Noun ) ) then
  begin
    {Noun := Copy( Self.Nominative, Length( Noun ) + 2,
            Length( Self.Nominative ) );
    Posit := Pos( cSpace, Noun );
    if ( Posit > 0 ) then
      Noun := Copy( Noun, 1, Posit - 1 );}
    Noun := Self.Node[ 1 ].Lem;
    CellPos := 1;
    Syntax := MyNode.Cod;
    MyNode.Cod[ 1 ] := 'n';
    Self.Node[ 0 ] := MyNode;
  end;

  // Skip an initial prefix
  Syntax := MyNode.Cod;
  if ( ( Syntax <> cEmpty ) and ( Syntax[ 1 ] = 'p' ) ) then
  begin
    Inc( CellPos );
    MyNode := Self.Node[ CellPos ];
    Noun := MyNode.Lem;
    Syntax := MyNode.Cod;
    MyNode.Cod[ 1 ] := 'n';
    Self.Node[ CellPos ] := MyNode;
  end;

  // Skip a possible second prefix
  if ( ( Syntax <> cEmpty ) and ( Syntax[ 1 ] = 'p' ) ) then
  begin
    Inc( CellPos );
    MyNode := Self.Node[ CellPos ];
    Noun := MyNode.Lem;
    Syntax := MyNode.Cod;
    MyNode.Cod[ 1 ] := 'n';
    Self.Node[ CellPos ] := MyNode;
  end;

  // Gender from the list of exceptions
  Result := ge_unspec;
  IsRule := False;
  Ident := 0;
  for Indx := 1 to NbNounExGenderFR do
  begin
    if ( Noun = cNounExGenderFR[ Indx, va_word ] ) then
    begin
      if ( cNounExGenderFR[ Indx, va_1 ] = 'm' ) then
        Result := ge_masculine
      else
        Result := ge_feminine;
      IsRule := True;
      Break;
    end;
  end; // for on all exception nouns

  // Gender by rules
  IsRule := False;
  if ( Result = ge_unspec ) then
  begin
    for Indx := 1 to NbNounRuGenderFR do
    begin
      Termin := cNounRuGenderFR[ Indx, va_word ];
      Lgt := Length( Termin );
      if ( Copy( Noun, Length( Noun) - Lgt + 1, Length( Noun) ) = Termin ) then
      begin
        if ( cNounRuGenderFR[ Indx, va_1 ] = 'm' ) then
        begin
          Result := ge_masculine
        end else
        if ( cNounRuGenderFR[ Indx, va_1 ] = 'f' ) then
        begin
          Result := ge_feminine;
        end;
        Ident := Indx;
        IsRule := True;
        Break;
      end;
    end; // on all rules for noun gender

    // Default value
    if ( Result = ge_unspec ) then
    begin
      IsRule := True;
      Ident := 0;
      Result := ge_masculine;
    end;
  end;
end; // ________________________________________________________________GenderFR

function           tFRTerm.MakeGenderFR(
  AWord:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenderFR
  * Make an adjective at feminine *
  Description:
  This routine create a feminine adjective from its masculine counterpart. The
  inverse process is not implemented.</P>
  At first, a list of exception is examined, that gives directly any irregular
  feminine adjective. At second, a list of rules based on the masculine
  ending of the adjective is considered. When a rule matches the specified
  adjective, its feminine value is computed. If no rule matches, the adjective
  is considered as invariant in gender. By definition, any adjective either
  matches a rule, or is an exception.</P>
  This procedure indicates if the result comes from a rule or an exception,
  and gives the corresponding identifier.</p>
  This function is tested by data of type tAdjChGenderFR.
  Exceptions are stored as tAdjExGenderFR.
  Rules are stored as tAdjRuGenderFR.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Lgt:             Integer;
  Last:            String;
  MyMasc:          String;
begin

  // Scan for the exceptions
  IsRule := False;
  for Indx := 1 to NbAdjExGenderFR do
  begin
    if ( AWord = cAdjExGenderFR[ Indx, ge_masculine ] ) then
    begin
      Result := cAdjExGenderFR[ Indx, ge_feminine ];
      Exit;
    end;
  end; // for on all exceptions for gender of adjectives

  // Apply the rules for French feminine
  IsRule := True;
  for Indx := 1 to NbAdjRuGenderFR do
  begin
    MyMasc := cAdjRuGenderFR[ Indx, ge_masculine ];
    Lgt := Length( MyMasc );
    Last :=  Copy( AWord, Length( AWord ) - Lgt + 1, Lgt );
    if ( Last = MyMasc ) then
    begin
      Result := Copy( AWord, 1, Length( AWord ) - Lgt ) +
                cAdjRuGenderFR[ Indx, ge_feminine ];
      Ident := Indx;
      Exit;
    end;
  end;
  IsRule := False;
  Result := cEmpty;
end; // ____________________________________________________________MakeGenderFR

function           tFRTerm.MakeGenitiveFR()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenitiveFR
  * Construction of a genitive French term *
  Description:
  This procedure handles a French singular term and transform it to the
  genitive singular form. An elision before a wowel is taken into account.</P>
  The genitive is different according to genericity in French. The genitive
  is without definite article for generic term and with definite article for
  specific terms. The selection is done from the given parameter.</P>
  When a laterality is specified for the term, the genitive is built with the
  corresponding lateral adjective.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Ident:           Integer;
  Plus:            Integer;
  IsRule:          Boolean;
  IsElud:          Boolean;
  IsGen:           Boolean;
  Gender:          tGender;
  DeForm:          String;
  ATerm:           String;
  MyCell:          WordAnal;
begin
  // Search for the gender
  ATerm := Self.Nominative;
  Gender := Self.GenderFR( IsRule, Ident );
  IsGen := Self.IsGeneric;

  // Check for an apostrophe
  IsElud := IsElisionFR( ATerm );
  if ( not IsElud ) then
  begin
    if ( Gender = ge_masculine ) then
    begin
      if ( IsGen ) then
        DeForm := 'de' + cSpace
      else
        DeForm := 'du' + cSpace;
    end else
    if ( Gender = ge_feminine ) then
    begin
      if ( IsGen ) then
        DeForm := 'de' + cSpace
      else
        DeForm := 'de la' + cSpace;
    end;
  end else
  begin
    if ( IsGen ) then
      DeForm := 'd'''
    else
      DeForm := 'de l''';
  end;
  Result := DeForm + ATerm;

  // Adjust the syntax
  Plus := 2;
  if ( IsGen ) then
    Plus := 1;
  NbWord := Self.NbWord;
  for Indx := 0 to NbWord - 1 do
  begin
    MyCell := Self.Node[ Indx ];
    MyCell.Cod := Copy( MyCell.Cod, 1, 3 ) + 'g' + MyCell.Cod[ 5 ];
    Self.NodeGS[ Indx + Plus ] := MyCell;
  end;
  MyCell.Lem := 'de';
  MyCell.Cod := 'rxxxx';
  Self.NodeGS[ 0 ] := MyCell;
  if ( not IsGen ) then
  begin
    if ( Gender = ge_masculine ) then
    begin
      MyCell.Lem := 'le';
      MyCell.Cod := 'dxmxs';
    end else
    begin
      MyCell.Lem := 'la';
      MyCell.Cod := 'dxfxs';
    end;
    Self.NodeGS[ 1 ] := MyCell;
  end;
end; // __________________________________________________________MakeGenitiveFR

function           tFRTerm.MakeLateralFR()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLateralFR
  * Construction of a lateral French term *
  Description:
  This procedure handles a French singular term and transform it to the
  equivalent lateral form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Ident:           Integer;
  IsRule:          Boolean;
  LatForm:         String;
  NewTerm:         String;
  ATerm:           String;
  MyNumber:        String;
  Gender:          tGender;
  Later:           tLink;
begin

  // Find the adjective of laterality
  ATerm := Self.Nominative;
  Later := Self.Side;
  LatForm := cEmpty;
  if ( ( Later = pw_MemberL ) or ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or ( Later = pw_TMemberL ) ) then
    LatForm := 'gauche'
  else
  if ( ( Later = pw_MemberR ) or ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or ( Later = pw_TMemberR ) ) then
  begin
    Gender := Self.GenderFR( IsRule, Ident );
    if ( Gender = ge_masculine ) then
      LatForm := 'droit'
    else
      LatForm := 'droite';
  end;
  if ( LatForm = cEmpty ) then
  begin
    Result := ATerm;
    Exit;
  end;

  // Last word by default in French
  if ( Self.WordType = lt_undef ) then
  begin
    Self.WordPos := Self.NbWord;
  end;

  // Retrieve the number of the lateral word and adjust the lateral form
  MyNumber := 'x';
  if ( ( WordPos - 1 <= Self.NbWord ) and ( WordPos - 1 >= 0 ) ) then
    MyNumber := Self.Node[ WordPos - 1 ].Cod[ 5 ];
  if ( MyNumber = 'p' ) then
    LatForm := LatForm + 's';

  // Position the lateral modifier
  begin
    NewTerm := cEmpty;
    for Indx := 0 to Self.NbWord - 1 do
    begin
      if ( Indx = Self.WordPos ) then
        NewTerm := NewTerm + cSpace + LatForm;
      NewTerm := NewTerm + cSpace + Self.Node[ Indx ].Lem;
    end; // for
    NewTerm := Copy( NewTerm, 2, Length( NewTerm ) );
  end;
  if ( Self.WordPos = Self.NbWord ) then
    NewTerm := NewTerm + cSpace + LatForm;
  Result := NewTerm;
end; // ___________________________________________________________MakeLateralFR

function           tFRTerm.MakeLatPluralFR
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLatPluralFR
  * Construction of a nominative lateral plural French term *
  Description:
  This procedure handles a French singular term and transform it to the
  equivalent lateral plural form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Lgt:             Integer;
  Ident:           Integer;
  IsRule:          Boolean;
  IsExcept:        Boolean;
  IsGen:           Boolean;
  IsPosLat:        Boolean;
  LatForm:         String;
  NewTerm:         String;
  ATerm:           String;
  SingVal:         String;
  MyWord:          String;
  MyPlural:        String;
  Gender:          tGender;
  Later:           tLink;
begin

  // Generate the adjective of laterality
  ATerm := Self.Nominative;
  Later := Self.Side;
  LatForm := cEmpty;
  if ( ( Later = pw_MemberL ) or ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or ( Later = pw_TMemberL ) ) then
    LatForm := 'gauches'
  else
  if ( ( Later = pw_MemberR ) or ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or ( Later = pw_TMemberR ) ) then
  begin
    Gender := Self.GenderFR( IsRule, Ident );
    if ( Gender = ge_masculine ) then
      LatForm := 'droits'
    else
      LatForm := 'droites';
  end;
  if ( LatForm = cEmpty ) then
  begin
    Result := ATerm;
    Exit;
  end;

  // Loop on all words of the term
  NewTerm := cEmpty;
  IsGen := False;
  IsPosLat := False;
  for Indy := 0 to Self.NbWord - 1 do
  begin
    MyWord := Self.Node[ Indy ].Lem;
    MyPlural := MyWord;

    // Stop on first genitive word
    if ( ( Length( Self.Node[ Indy ].Cod ) >= 4 ) and
         ( Self.Node[ Indy ].Cod[ 4 ] = 'n' ) ) then
    begin

      // Make the plural of the word at nominative
      // Define plural from exceptions for nouns
      IsExcept := False;
      MyPlural := cEmpty;
      for Indx := 1 to NbNounExPluralFR do
      begin
        if ( MyWord = cNounExPluralFR[ Indx, nu_sin ] )  then
        begin
          MyWord := cNounExPluralFR[ Indx, nu_plu ];
          MyPlural := MyPlural + cSpace + MyWord;
          IsExcept := True;
          Break;
        end;
      end; // for on all exceptions for plural

      // Define plural from exceptions for adjectives
      IsExcept := False;
      MyPlural := cEmpty;
      for Indx := 1 to NbAdjExPluralFR do
      begin
        if ( MyWord = cAdjExPluralFR[ Indx, nu_sin ] )  then
        begin
          MyWord := cAdjExPluralFR[ Indx, nu_plu ];
          MyPlural := MyPlural + cSpace + MyWord;
          IsExcept := True;
          Break;
        end;
      end; // for on all exceptions for plural
      if ( IsExcept ) then
        Break;

      // Loop on all French plural rules if no exception matches
      MyPlural := MyPlural + cSpace + MyWord;
      for Indx := 1 to NbWordRuPluralFR do
      begin
        SingVal := cWordRuPluralFR[ Indx, nu_sin ];
        Lgt := Length( SingVal );
        if ( Lgt > 0 ) then
        begin
          if ( Copy( MyWord, Length( MyWord ) - Lgt + 1, Lgt ) = SingVal ) then
          begin
            MyPlural := Copy( MyPlural, 1, Length( MyPlural ) - Lgt ) +
                        cWordRuPluralFR[ Indx, nu_plu ];
            Break;
          end;
        end else
        begin
          MyPlural := MyPlural + cWordRuPluralFR[ Indx, nu_plu ];
        end;
      end; // for on all rules for plural
    end else
    begin
      if ( not IsGen ) then
        IsPosLat := True;
      IsGen := True;
    end;

    // Build the new term
    NewTerm := NewTerm + cSpace + MyPlural;
    if ( ( IsPosLat ) or
         ( ( Indy = Self.NbWord - 1 ) and ( not IsGen ) ) ) then
    begin
      NewTerm := NewTerm + cSpace + LatForm;
      IsPosLat := False;
    end;
  end; // for on all words of the term
  NewTerm := Copy( NewTerm, 2, Length( NewTerm ) );
  // if ( Self.WordPos = Self.NbWord ) then
  //   NewTerm := NewTerm + cSpace + LatForm;
  Result := NewTerm;
end; // _________________________________________________________MakeLatPluralFR

function           tFRTerm.MakeGenLatPluralFR
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenLatPluralFR
  * Construction of a genitive lateral plural French term *
  Description:
  This procedure handles a French singular term and transform it to the
  equivalent lateral plural form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  NewTerm:         String;
begin
  NewTerm := Self.MakeLatPluralFR;
  Result := 'des' + cSpace + NewTerm;
end; // ______________________________________________________MakeGenLatPluralFR

procedure          tFRTerm.SetNominativeFR;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNominativeFR
  * Action when entering a new value for nominative *
  Description:
  This method enters a new value for the nominative.</p>
  This procedure probably does not work for complicated terms!!!</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  NbWord:          Integer;
  CellPos:         Integer;
  IsGen:           Boolean;
  MyTerm:          String;
  MyWord:          String;
  MyCell:          WordAnal;
  MyNode:          WordAnal;
begin
  // Initial stuff
  MyTerm := Self.Nominative;
  NbWord := 0;
  if ( Length( MyTerm ) = 0 ) then
    Exit;

  // Check for a possible frontal adjective before the noun
  CellPos := 0;
  MyNode := Self.Node[ 0 ];
  MyWord := MyNode.Lem;
  if ( IsFrontFR( MyWord ) ) then
  begin
    MyWord := Self.Node[ 1 ].Lem;
    CellPos := 1;
  end;

  // Dispatch all words
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
    if ( NbWord = CellPos ) then
      MyCell.Cod := 'nxxnx'
    else
      MyCell.Cod := 'axxnx';
    IsGen := ( ( MyCell.Lem = 'de' ) or ( MyCell.Lem = 'du' ) or
               ( MyCell.Lem = 'des' ) or ( MyCell.Lem = 'd''' ) );
    if ( IsGen ) then
      MyCell.Cod := 'xxxgx';
    Self.NbWord := NbWord + 1;
    Self.Node[ NbWord ] := MyCell;
    Inc( NbWord );
  until ( Posit = 0 ); // Loop on all words of the term

  // Validate the syntax information
  Self.SetSyntaxFR;
end; // _________________________________________________________SetNominativeFR

procedure          tFRTerm.SetSyntaxFR;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetSyntaxFR
  * Compile the syntax of a term *
  Description:
  This procedure defines, validates or adjusts the syntax of a term.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  CellPos:         Integer;
  FirstGen:        Integer;
  Ident:           Integer;
  IsRule:          Boolean;
  IsFront:         Boolean;
  MyWord:          String;
  MyCode:          String;
  MyGender:        tGender;
  MyNode:          WordAnal;
begin
  // Get the gender of nominative noun
  MyGender := Self.GenderFR( IsRule, Ident );

  // Check for a possible frontal adjective before the noun
  CellPos := 0;
  MyNode := Self.Node[ 0 ];
  MyWord := MyNode.Lem;
  IsFront := False;
  if ( IsFrontFR( MyWord ) ) then
  begin
    MyWord := Self.Node[ 1 ].Lem;
    CellPos := 1;
    IsFront := CellPos = 1;
  end;

  // Update the nominative cells
  if ( MyGender <> ge_unspec ) then
  begin
    MyCode := Self.Node[ CellPos ].Cod;

    // Update the front cell if any
    if ( IsFront ) then
    begin
      if ( MyGender = ge_masculine ) then
        Self.SetCode( 0, 'axmns' )
      else
      begin
        Self.SetCode( 0, 'axfns' );
        MyNode := Self.Node[ 0 ];
        MyNode.Lem := Self.MakeGenderFR( MyNode.Lem, IsRule, Ident );
        Self.Node[ 0 ] := MyNode;
      end;
    end;

    // Update the prefix cell
    if ( ( MyCode <> cEmpty ) and ( MyCode[ 1 ] = 'p' ) ) then
    begin
      Inc( CellPos );
      MyCode := Self.Node[ CellPos ].Cod;
    end;

    // Update the noun cell
    if ( ( MyCode <> cEmpty ) and ( MyCode[ 1 ] = 'n' ) ) then
    begin
      if ( MyGender = ge_masculine ) then
        Self.SetCode( CellPos, 'nxmns' )
      else
        Self.SetCode( CellPos, 'nxfns' );
    end;

    // Update the adjective cells if any
    FirstGen := Self.NbWord;
    if ( Self.NbWord > CellPos ) then
    begin
      for Indx := CellPos + 1 to Self.NbWord - 1 do
      begin
        MyNode := Self.Node[ Indx ];
        if ( ( MyNode.Lem = 'de' ) or
             ( MyNode.Lem = 'du' ) or
             ( MyNode.Lem = 'd''' ) ) then
        begin
          FirstGen := Indx;
          Break;
        end;
        if ( ( MyNode.Cod <> cEmpty ) and ( MyNode.Cod[ 1 ] = 'a' ) ) then
        begin
          if ( MyGender = ge_masculine ) then
            Self.SetCode( Indx, 'axmns' )
          else
          begin
            MyNode.Cod := 'axfns';
            MyNode.Lem := Self.MakeGenderFR( MyNode.Lem, IsRule, Ident );
            Self.Node[ Indx ] := MyNode;
          end;
        end;
      end; // on all adjectives after the head noun at nominative
    end;
  end;
  Self.IsRegular := True;
end; // _____________________________________________________________SetSyntaxFR

procedure          tFRTerm.SetFormulaFR;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormulaFR
  * Action when entering a new value for Formula property in French *
  Description:
  This methods aims at building the basic part of a term in French
  from a universal formula. Expansions are not considerd here.</P>
  The universal basic part of a term is governed by a formal syntax documented
  elsewhere. This syntax is supposed to protect against language accidents,
  ambiguities or approximative terms. Formulas are supposed to be built in
  conformity to this syntax and the resulting basic part will be also
  in conformity with the syntax of the target language.</P>
  The basic part of a term is specified by the universal formula of this term.
  A universal formula is made of an ordered sequence of contributions. Each
  contribution is interpreted by one single words in general, rarely by more
  than one word (presence of prefixes). The universal formula is independant
  of any language. Here, it is interpreted in the French language.</P>
  The French order of words is exactly the same than the universal order that
  corresponds to the Latin. Therefore, no interpretation of the order of the
  universal formula is necessary.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Posit:           Integer;
  UID:             Integer;
  IsFront:         Boolean;
  MyFormula:       String;
  MyPart:          String;
  MyCode:          String;
  MyWord:          String;
  LexUnit:         tUnit;
  LexEntity:       tEntity;
  Query:           tSearch;
  ANode:           WordAnal;
  TempNode:        WordAnal;
  MyLex:           tLexType;
begin

  // Loop on all contributions of the universal formula
  MyFormula := Self.Formula;
  Indx := 0;
  repeat

    // Retrieve the next contribution of the formula.
    // The universal formula is a comma-separated sequence of contributions
    Posit := Pos( cComma, MyFormula );
    if ( Posit > 0 ) then
    begin
      MyPart := Copy( MyFormula, 1, Posit - 1 );
      MyFormula := Copy( MyFormula, Posit + 1, Length( MyFormula ) );
    end else
    begin
      MyPart := MyFormula;
      MyFormula := cEmpty;
    end;

    // Retrieve the lexical entity identifier.
    // The type of the contribution is a single character in front.
    // Each contribution contains a unit identifier between round brackets.
    Posit := Pos( cRol, MyPart );
    UID := 0;
    MyLex := lx_Undef;
    if ( Posit > 0 ) then
    begin
      MyLex := LexOf( Copy( MyPart, 1, Posit - 1 ) );
      MyPart := Copy( Mypart, Posit + 1, Length( MyPart ) );
      Posit := Pos( cRor, MyPart );
      if ( Posit > 0 ) then
      begin
        MyPart := Copy( Mypart, 1, Posit - 1 );
        UID := StrToInt( MyPart );
      end;
    end;

    // Retrieve the lexical entity (always the generator of the unit)
    LexEntity := nil;
    if ( UID > 0 ) then
    begin
      LexUnit := TAH.GetUnitByPos( UID );
      if ( LexUnit <> nil ) then
        LexEntity := TAH.GetEntityByPos( LexUnit.Generator );
    end;

    // Retrieve the French word for this contribution
    MyWord := cEmpty;
    if ( LexEntity <> nil ) then
    begin
      ANode := Self.Node[ Indx ];
      Query := nil;
      IsFront := False;
      case MyLex of

      // Handling of a noun
      lx_Noun:
        begin
          MyWord := LexEntity.GetVocabulary( lt_French, st_Nou );
          MyCode := 'nxxxx';
        end;

      // Handling of a noun complement at genitive
      // The noun is preceeded by the preposition de
      lx_Compl:
        begin
          MyWord := LexEntity.GetVocabulary( lt_French, st_Nou );
          ANode.Lem := 'de';
          ANode.Cod := 'qxxgx';
          if ( ( MyWord <> cEmpty ) and ( IsElisionFR( MyWord ) ) ) then
            ANode.Lem := 'd''';
          Self.Node[ Indx ] := ANode;
          Inc( Indx );
          ANode := Self.Node[ Indx ];
          MyCode := 'nxxgx';
        end;

      // Handling of an adjective, without prefix
      lx_Adj:
        begin
          MyWord := LexEntity.GetVocabulary( lt_French, st_Adj );
          MyCode := 'axxxx';
          IsFront := IsFrontFR( MyWord );
        end;

      // Handling of a prefix to which the next word is appended
      lx_Pref:
        begin
          MyWord := LexEntity.GetVocabulary( lt_French, st_Pre );
          MyCode := 'pxxxx';
        end;

      // Handling of an invariant always in last position
      lx_Invar:
        begin
          MyWord := LexEntity.GetVocabulary( lt_French, st_Inv );
          MyCode := 'ixxxx';
        end;

      // Handling of an apposition
      lx_Appos:
        begin
          MyWord := LexEntity.GetVocabulary( lt_French, st_Nou );
          if ( MyWord = cEmpty ) then
          begin
            MyWord := LexEntity.GetVocabulary( lt_French, st_Adj );
            if ( MyWord = cEmpty ) then
            begin
              MyWord := LexEntity.GetVocabulary( lt_French, st_Pre );
              if ( MyWord = cEmpty ) then
              begin
                MyWord := LexEntity.GetVocabulary( lt_French, st_Inv );
                if ( MyWord = cEmpty ) then
                  MyWord := 'ERR';
              end;
            end;
          end;
          MyCode := 'ixxxx';
        end;
      end; // case on all lexical types

      // A word has been retrieved
      if ( MyWord <> cEmpty ) then
      begin
        Self.NbWord := Indx + 1;
        ANode.Lem := MyWord;
        ANode.Cod := MyCode;
        Self.Node[ Indx ] := ANode;
      end else

      // No word has been found
      begin
        ANode.Lem := LexEntity.InternalTex;
        ANode.Cod := MyCode;
        Self.Node[ Indx ] := ANode;
      end;

      // Reposition of a front adjective at the first place
      if ( IsFront ) then
      begin
        TempNode := Self.Node[ Indx ];
        for Indy := Indx downto 1 do
          Self.Node[ Indy ] := Self.Node[ Indy - 1 ];
        Self.Node[ 0 ] := TempNode;
      end;
    end;

    // Move to next contribution
    Inc( Indx );
  until ( MyFormula = cEmpty ); // on all contributions of a formula

  // Adjustment of the syntax
  Self.SetSyntaxFR;
end; // ____________________________________________________________SetFormulaFR

function           IsElisionFR(
  Text:            String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsElisionFR
  * Find if an elision is necessary *
  Description:
  There may be a few exceptions not taken into account.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := False;
  if ( Text <> cEmpty ) then
    Result := CharInSet( Text[ 1 ],
              [ 'a', 'e', 'é', 'è', 'ê', 'i', 'o', 'u', 'h', 'y' ] );
end; // _____________________________________________________________IsElisionFR

function           IsFrontFR(
  Text:            String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsFrontFR
  * Find if an adjective is a front adjective *
  Description:
  In French, adjectives are positioned after the noun they are qualifying. But
  a number of exceptions are possible. This routine checks if a specified
  adjective is a front adjective, according to a preset list.</P>
  The specified adjective may be given at masculine or feminine.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  Result := False;
  for Indx := 1 to NbFrontFR do
  begin
    if ( Text = cFrontFR[ Indx ] ) then
    begin
      Result := True;
      Exit;
    end;
  end; // for on all front adjectives
end; // _______________________________________________________________IsFrontFR

function           tFRTerm.SetBaseFR
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetBaseFR
  * Set the base part of a French term after an expansion *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index
  PosWord:         Integer;            // Position of bilateral placeholder
  Syntax:          String;             // Syntax for placeholder
  MyCell:          WordAnal;           // Placeholder cell
begin

  // Determine the syntax and position of the lateral placeholder
  // Last position in French
  Posword := Self.NbWord;
  if ( Self.WordPos > 0 ) then
    PosWord := Self.WordPos;
  Syntax := 'mns';
  for Indx := 0 to Self.NbWord - 1 do
  if ( Self.Node[ Indx ].Cod[ 1 ] = 'n' ) then
  begin
    Syntax := Self.Node[ 0 ].Cod[ 3 ] + 'n' + Self.Node[ 0 ].Cod[ 5 ];
    Break;
  end; // for

  // Add the bilateral place holder: xter stands for dexter or sinister
  MyCell.Lem := 'xter';
  MyCell.Cod := 'hx' + Syntax;
  for Indx := Self.NbWord downto 0 do
    if ( Indx > PosWord  ) then
      Self.Node[ Indx ] := Self.Node[ Indx - 1 ];
  Self.Node[ PosWord ] := MyCell;
  Result := True;
end; // _______________________________________________________________SetBaseFR

function           tFRTerm.MakeMandatFR(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeMandatFR
  * Make the mandatory part of a French term *
  Description:
  This procedure defines the mandatory part specified single in argument.</p>
  The part to be added is retrieved as a French term at nominative that is
  expected to be regular. The genitive is computed and then returned. The
  syntax analysis of term is updated.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  MyGenitive:      String;             // Genitive generated term
  MyFRTerm:        tFRTerm;            // Applicable term
begin

  // Build the genitive
  Result := False;
  Past := Self.NbWord;
  MyFRTerm := tFRTerm( MyTerm.LgTerm );
  if ( MyFRTerm = nil ) then
  begin
    MyTerm.SetError( 999 );
    Exit;
  end;
  MyGenitive := Trim( MyFRTerm.Genitive );

  // Adjust the syntax of owner French term
  NbWordGS := MyFRTerm.NbWordGS;
  for Indx := 0 to NbWordGS - 1 do
  begin
    Self.Node[ Indx + Past ] := MyFRTerm.NodeGS[ Indx ];
  end; // for on all genitive words
  Self.NewNom := MyGenitive;
  Result := True;
end; // ____________________________________________________________MakeMandatFR

function           tFRTerm.MakeOptionFR(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOptionFR
  * Make the optional part of a French term *
  Description:
  This procedure defines the mandatory part specified single in argument.</p>
  The part to be added is retrieved as a French term at nominative that is
  expected to be regular. The genitive is computed and then returned. The
  syntax analysis of term is updated.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  MyGenitive:      String;             // Genitive generated term
  MyFRTerm:        tFRTerm;            // Applicable term
begin

  // Build the genitive
  Result := False;
  Past := Self.NbWord;
  MyFRTerm := tFRTerm( MyTerm.LgTerm );
  if ( MyFRTerm = nil ) then
  begin
    MyTerm.SetError( 999 );
    Exit;
  end;
  MyGenitive := Trim( MyFRTerm.Genitive );

  // Adjust the syntax of owner French term
  NbWordGS := MyFRTerm.NbWordGS;
  for Indx := 0 to NbWordGS - 1 do
  begin
    Self.Node[ Indx + Past ] := MyFRTerm.NodeGS[ Indx ];
  end; // for on all genitive words
  Self.NewNom := MyGenitive;
  Result := True;
end; // ____________________________________________________________MakeOptionFR

function           tFRTerm.MakeAdjectiveFR(
  Adj:             String;
  Pre:             String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAdjectiveFR
  * Insert an adjective of expansion in base part of a term *
  Description:
  This procedure receives an adjective and inserts it in the base part of the
  term given as argument. The position of this adjective is defined with
  strict syntactic rules specific to the language. The adjective is first
  modified in gender and number before being inserted.</p>
  The possibility of a genitive noun complement immediatly following the main
  nominative noun is not compatible with an adjective expansion and must not
  occur here.</p>
  The adjective may be accompanied by a prefix, to be added in front of the
  adjective.<p>
  About local variables:
  - Nounpos: position of the noun (last by default)
  - NbPlus: number of additional words after the noun
  - NbShift: 1 for adjective only, 2 for prefix and adjective.</p>
  In French, it is necessary to take care of possible frontal adjectives.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  NbWord:          Integer;
  NounPos:         Integer;
  AdjPos:          Integer;
  NbShift:         Integer;
  NbPlus:          Integer;            // Nomber of words after the noun
  Ident:           Integer;
  IsRule:          Boolean;
  IsFront:         Boolean;
  MyWord:          String;
  MyTerm:          String;
  NewAdj:          WordAnal;
  NewPref:         WordAnal;
  MyNode:          WordAnal;
  MyAdj:           tFRTerm;
begin

  // Check for a possible frontal adjective before the noun
  NounPos := 0;
  MyNode := Self.Node[ 0 ];
  MyWord := MyNode.Wrd;
  IsFront := False;
  if ( IsFrontFR( MyWord ) ) then
  begin
    MyWord := Self.Node[ 1 ].Wrd;
    NounPos := 1;
    IsFront := NounPos = 1;
  end;
  AdjPos := NounPos + 1;
  NbWord := Self.NbWord;
  NbPlus := NbWord - 1 - NounPos;

  // Prepare a new node for the adjective
  MyNode := Self.Node[ NounPos ];
  NewAdj.Cod := 'axmns';
  if ( MyNode.Cod[ 3 ] = 'f' ) then
  begin
    MyAdj := tFRTerm.Create( Adj );
    Adj := MyAdj.MakeGenderFR( Adj, IsRule, Ident );
    NewAdj.Cod := 'axfns';
  end;
  NewAdj.Lem := Adj;

  // Prepare a new node for the prefix
  if ( Pre <> cEmpty ) then
  begin
    NewPref.Wrd := Pre;
    NewPref.Cod := 'pxxxx';
  end;

  // Create the new nodes for the adjective (and prefix) after the noun
  Inc( NbWord );
  NbShift := 1;
  if ( Pre <> cEmpty ) then
  begin
    Inc( NbWord );
    NbShift := 2
  end;
  Self.NbWord := NbWord;
  if ( NbPlus > 0 ) then
  begin
    for Indx := NbWord - 1 downto NbWord - 1 - NbPlus do
      Self.Node[ Indx ] := Self.Node[ Indx - NbShift ];
  end;

  // Add the new nodes
  if ( Pre <> cEmpty ) then
  begin
    Self.Node[ NounPos + 1 ] := NewPref;
    Self.Node[ NounPos + 2 ] := NewAdj;
  end else
    Self.Node[ NounPos + 1 ] := NewAdj;

  // Rebuild the term
  // MyMandat.SetSyntaxFR;
  MyTerm := cEmpty;
  for Indx := 0 to NbWord - 1 do
  begin
    MyWord := Self.Node[ Indx ].Lem;
    if ( Self.Node[ Indx ].Cod[ 1 ] = 'p' ) then
      MyTerm := MyTerm + MyWord
    else
      MyTerm := MyTerm + MyWord + cSpace;
  end;
  Result := True;
  Self.NewNom := Trim( MyTerm );
end; // _________________________________________________________MakeAdjectiveFR

function           SetFormalPSetFR(
  Term:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormalPSetFR
  * Define the formal term for a pset *
  Description:
  The formal term for a specific pset is created, with its nominative part at
  singular because plurals are not accepted in the formal terms. The head part
  is followed by the genitive plural form of the generic term.</p>
  In French, it is necessary to take care of a possible ellision.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTerm:          tTerm;
  NewTerm:         String;
  Prefix:          String;
begin
  MyTerm := tTerm.Create( Term.Mandat, lt_French );
  NewTerm := MyTerm.Plural;
  Result := cEmpty;
  if ( MyTerm.IsRegular ) then
  begin
    if ( IsElisionFR( NewTerm ) ) then
    begin
      Prefix := 'paire d''ensembles d''';
      Result := Prefix + NewTerm;
    end else
    begin
      Prefix := 'paire d''ensembles de';
      Result := Prefix + cSpace + NewTerm;
    end;
  end;
end; // _________________________________________________________SetFormalPSetFR

function           SetFormalSetFR(
  Term:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormalSetFR
  * Define the formal term for a set *
  Description:
  The formal term for a specific pset is created, with its nominative part at
  singular because plurals are not accepted in the formal terms. The head part
  is followed by the genitive plural form of the generic term.</p>
  In French, it is necessary to take care of a possible ellision.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTerm:          tTerm;
  NewTerm:         String;
  Prefix:          String;
begin
  MyTerm := tTerm.Create( Term.Mandat, lt_French );
  NewTerm := MyTerm.Plural;
  Result := cEmpty;
  if ( MyTerm.IsRegular ) then
  begin
    if ( IsElisionFR( NewTerm ) ) then
    begin
      Prefix := 'ensemble d''';
      Result := Prefix + NewTerm;
    end else
    begin
      Prefix := 'ensemble de';
      Result := Prefix + cSpace + NewTerm;
    end;
  end;
end; // __________________________________________________________SetFormalSetFR

function           TestAdjectiveGenderFR(
  AGender:         tGender;
  AnAdj:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestAdjectiveGenderFR
  * Test for feminine of French adjective *
  Description:
  This function defines a feminine adjective from its masculine counterpart.
  The feminine form is computed on a rules and exceptions basis.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyAdj:           tFRTerm;
begin
  MyAdj := tFRTerm.Create( AnAdj );
  Result := MyAdj.MakeGenderFR( AnAdj, IsRule, Ident );
end; // ___________________________________________________TestAdjectiveGenderFR

function           TestNounGenderFR(
  ANoun:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestNounGenderFR
  * Test for gender of French nouns *
  Description:
  This function defines the gender of a noun. The gender is computed on a
  rules and exceptions basis.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyNoun:          tFRTerm;
  MyGender:        tGender;
begin
  MyNoun := tFRTerm.Create( ANoun );
  MyGender := MyNoun.GenderFR( IsRule, Ident );
  if ( MyGender = ge_masculine ) then
    Result := 'm'
  else
    Result := 'f';
end; // ________________________________________________________TestNounGenderFR

function           TestNounPluralFR(
  ANoun:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestNounPluralFR
  * Test for plural of French nouns *
  Description:
  This function defines the plural of a noun. The plural is computed on a
  rules and exceptions basis.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyNoun:          tFRTerm;
  MyNumber:        tNumber;
begin
  MyNoun := tFRTerm.Create( ANoun );
  Result := MyNoun.MakePluralFR( IsRule, Ident );
end; // ________________________________________________________TestNounPluralFR

function           TestAdjPluralFR(
  AnAdj:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestAdjPluralFR
  * Test for plural of French adjectives *
  Description:
  This function defines the plural of an adjective. The plural is computed on a
  rules and exceptions basis.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyAdj:          tFRTerm;
  MyNumber:       tNumber;
begin
  MyAdj := tFRTerm.Create( AnAdj );
  Result := MyAdj.MakePluralFR( IsRule, Ident );
end; // _________________________________________________________TestAdjPluralFR

end.
