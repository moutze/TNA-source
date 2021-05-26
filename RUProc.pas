{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ unit RUProc
  * Package for Russian language management *
  Description:
  This package handles all aspects of the Russian language in order to
  manipulate and generate Russian terms. It is sufficient for the domain of
  anatomy when the RAT rules are applied. There is no need of a dictionary.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
unit RUProc;

interface

uses
  TAHParam, Term, ComCtrls, SingleTerms;

const
  NbNounRuPluralRU = 23;     // Number of plural rules for nominative nouns
  NbNounExPluralRU = 6;      // Number of exceptions for plural nouns
  NbNounChPluralRU = 3;      // Number of test values for plural nouns
  NbAdjRuPluralRU  = 31;     // Number of plural rules for nominative adjectives
  NbAdjExPluralRU  = 1;      // Number of exceptions for plural adjectives
  NbAdjChPluralRU  = 4;      // Number of test values for plural adjectives

  NbGenAdjRU       = 10;     // Number of genitive rules for singular adjectives
  NbGenNounRU      = 25;     // Number of genitive rules for singular nouns
  NbGenPluralAdjRU = 7;      // Number of genitive rules for plural adjectives
  NbGenPluralNounRU= 20;     // Number of genitive rules for plural nouns
  NbBinome         = 4;      // To be deleted

  NbAdjRuGenderRU  = 4;      // Number of rules for adjective gender
  NbAdjExGenderRU  = 1;      // Number of exceptions for adjective gender
  NbAdjChGenderRU  = 6;      // Number of tests for adjective gender
  NbNounRuGenderRU = 12;     // Number of rules for noun gender
  NbNounExGenderRU = 4;      // Number of exceptions for noun gender
  NbNounChGenderRU = 4;      // Number of tests for noun gender

  NbNoChExpRU      = 14;     // Number of tests without expansion
  NbAdjChExpRU     = 3;      // Number of tests with adjective expansion
  NbAdjRuExpRU     = 7;      // Number of rules for adjective expansion
  NbMandChExpRU    = 6;      // Number of tests with mandatory expansion
  NbLatChExpRU     = 7;      // Number of tests with lateral expansion
  NbOptChExpRU     = 2;      // Number of tests with optional expansion

                   // Lateral values
  cRUSinister:     Array[ tLatType ] of String = (
                   '',                       // undefined value
                   'левый',                  // left masc nom sing
                   'левого',                 // left masc gen sing
                   'sinistri',               // left masc nom plur
                   'sinistrorum',            // left masc gen plur
                   'левая',                  // left fem nom sing
                   'левой',                  // left fem gen sing
                   'sinistrae',              // left fem nom plur
                   'sinistrarum',            // left fem gen plur
                   'левое',                  // left neuter nom sing
                   'левого',                 // left neuter gen sing
                   'sinistra',               // left neuter nom plur
                   'sinistrorum' );          // left neuter gen plur
  cRUDexter:       Array[ tLatType ] of String = (
                   '',                       // undefined value
                   'правый',                 // right masc nom sing
                   'правого',                // right masc gen sing
                   'dextri',                 // right masc nom plur
                   'dextrm',                 // right masc gen plur
                   'правая',                 // right fem nom sing
                   'правой',                 // right fem gen sing
                   'dextrae',                // right fem nom plur
                   'dextrarum',              // right fem gen plur
                   'правое',                 // right neuter nom sing
                   'правого',                // right neuter gen sing
                   'dextra',                 // right neuter nom plur
                   'dextrorum' );            // right neuter gen plur

type
  tNounRuPluralRU  = Array[ 1 .. NbNounRuPluralRU, nu_sin .. nu_plu ]
                            of String;
  tNounExPluralRU  = Array[ 1 .. NbNounExPluralRU, nu_sin .. nu_plu ]
                            of String;
  tNounChPluralRU  = Array[ 1 .. NbNounChPluralRU, nu_sin .. nu_plu ]
                            of String;
  tAdjRuPluralRU   = Array[ 1 .. NbAdjRuPluralRU, nu_sin .. nu_plu ]
                            of String;
  tAdjExPluralRU   = Array[ 1 .. NbAdjExPluralRU, nu_sin .. nu_plu ]
                            of String;
  tAdjChPluralRU   = Array[ 1 .. NbAdjChPluralRU, nu_sin .. nu_plu ]
                            of String;
  tGenAdjRU        = Array[ 1 .. NbGenAdjRU, ca_nom .. ca_gen ]
                            of String;
  tGenNounRU       = Array[ 1 .. NbGenNounRU, ca_nom .. ca_gen ]
                            of String;
  tGenPluralAdjRU  = Array[ 1 .. NbGenPluralAdjRU, ca_nom .. ca_gen ]
                            of String;
  tGenPluralNounRU = Array[ 1 .. NbGenPluralNounRU, ca_nom .. ca_gen ]
                            of String;
  tNbNounExPluralRU= Array[ 1 .. NbNounExPluralRU, nu_sin .. nu_plu ]
                            of String;
  tBinome          = Array[ 1 .. NbBinome, 1 .. 2 ]
                            of String;
  tAdjRuGenderRU   = Array[ 1 .. NbAdjRuGenderRU, ge_masculine .. ge_neuter ]
                            of String;
  tAdjExGenderRU   = Array[ 1 .. NbAdjExGenderRU, ge_masculine .. ge_neuter ]
                            of String;
  tAdjChGenderRU   = Array[ 1 .. NbAdjChGenderRU, ge_masculine .. ge_neuter ]
                            of String;
  tNounRuGenderRU  = Array[ 1 .. NbNounRuGenderRU, ge_masculine .. ge_feminine ]
                            of String;
  tNounExGenderRU  = Array[ 1 .. NbNounExGenderRU, ge_masculine .. ge_feminine ]
                            of String;
  tNounChGenderRU  = Array[ 1 .. NbNounChGenderRU, ge_masculine .. ge_feminine ]
                            of String;
                   // Tests for terms without expansion
  tNoChExpRU       = Array[ 1 .. NbNoChExpRU, nu_sin .. nu_plu ] of Integer;
                   // Tests for adjective expansions
  tAdjChExpRU      = Array[ 1 .. NbAdjChExpRU, nu_sin .. nu_plu ] of Integer;
  tAdjRuExpRU      = Array[ 1 .. NbAdjRuExpRU, 1 .. 2 ] of String;
                   // Tests for mandatory expansions
  tMandChExpRU     = Array[ 1 .. NbMandChExpRU,  nu_sin .. nu_plu ] of Integer;
                   // Tests for lateral expansions
  tLatChExpRU      = Array[ 1 .. NbLatChExpRU, nu_sin .. nu_plu ] of Integer;
                   // Tests for optional expansions
  tOptChExpRU      = Array[ 1 .. NbOptChExpRU, nu_sin .. nu_plu ] of Integer;

                             // Define the Russian term object
  tRUTerm                    = class( tTerm )
    public
                             // Constructor with a nominative term
      constructor            Create(
                               Nominative: String );
                             // Make the nominative plural of the term
      function               MakePluralRU(
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Make the lateral singular form of the term
      function               MakeLateralRU
                               : String;
                             // Make the lateral plural form of the term
      function               MakeLatPluralRU
                               : String;
                             // Make the genitive singular of the term
      function               MakeGenitiveRU
                               : String;
                             // Make the genitive plural of the term
      function               MakeGenPluralRU
                               : String;
                             // Make the genitive lateral plural of the term
      function               MakeGenLatPluralRU
                               : String;
                             //
      procedure              SetNominativeRU;
                             // Compile the syntax of a term
      procedure              SetSyntaxRU;
                             // Enter the formula of the term
      procedure              SetFormulaRU;
                             // Find the gender of a term
      function               GenderRU(
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : tGender;
                             // Make an adjective from a masculine form
      function               MakeGenderRU(
                               Gender: TGender;
                               AWord: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Make the mandatory expansion of a term
      function               MakeMandatRU(
                               TID: Integer )
                               : String;
                             // Make the optional expansion of a term
      function               MakeOptionRU(
                               MyTerm: tSingle )
                               : Boolean;
                             // Add an adjective to a term
      function               MakeAdjectiveRU(
                               Adj: String;
                               Pre: String )
                               : Boolean;
                             // Set the base part of a term
      function               MakeBaseRU
                               : Boolean;
  end; // class tRUTerm
                             // Translate a single word into Russian
  function                   RussianOf(
                               LAWord: String )
                               : String;
                             // Translate a universal formula in Russian
  function                   TranslateTermRU(
                               TreeFormula: TTreeView )
                               : String;
                             // Find the introductory string for genitive
  function                   MakeInGenitiveRU(
                               MyNumber: String;
                               MyGender: tGender;
                               MySpecif: String;
                               MyElision: Boolean )
                               : String;
                             // Create the elision flag
  function                   IsElisionRU(
                               Text: String )
                               : Boolean;
                             // Check for the presence of an adjective
  function                   IsAdjRU(
                               AWord: String )
                               : Boolean;
                             // Validation of Russian procedures
  procedure                  ValidateRU;
                             // Set a formal pset term
  function                   SetFormalPSetRU(
                               Term: tSingle )
                               : String;
                             // Test for gender of adjectives
  function                   TestAdjectiveGenderRU(
                               AGender: tGender;
                               AnAdj: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Test for gender of nouns
  function                   TestNounGenderRU(
                               ANoun: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Test for plural of nouns
  function                   TestNounPluralRU(
                               ANoun: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;
                             // Test for plural of adjectives
  function                   TestAdjPluralRU(
                               AnAdj: String;
                               var IsRule: Boolean;
                               var Ident: Integer )
                               : String;

const
                   // Rules for nominative plural nouns
  cNounRuPluralRU: tNounRuPluralRU = (
                   ( 'га', 'ги' ),
                   ( 'ха', 'хи' ),
                   ( 'жа', 'жи' ),
                   ( 'ша', 'ши' ),
                   ( 'ща', 'щи' ),
                   ( 'ча', 'чи' ),
                   ( 'ка', 'ки' ),     // полоска-полоски клетка-клетки
                   ( 'т', 'ты' ),      // хвост-хвосты
                   ( 'а', 'ы' ),       // борозда-борозды извилина-извилины
                   ( 'ь', 'и' ),       // путь-пути область-области
                   ( 'й', 'и' ),       // слой-слои ручей-ручеи
                   ( 'я', 'и' ),       // артерия-артерии
                   ( 'ок', 'ки' ),     // корешок-корешки пучок-пучки
                   ( 'о', 'а' ),       // волокно-волокна ядро-ядра
                   ( 'ге', 'га' ),
                   ( 'хе', 'ха' ),
                   ( 'же', 'жа' ),
                   ( 'ше', 'ша' ),
                   ( 'ще', 'ща' ),
                   ( 'че', 'ча' ),
                   ( 'ке', 'ка' ),
                   ( 'е', 'я' ),       // соединение-соединения
                   ( '',  'ы' ) );     // мост-мосты нейрон-нейроны

                   // Plural exceptions for nominative nouns
  cNounExPluralRU: tNounExPluralRU = (
                   ( 'веко', 'веки' ),
                   ( 'доктор', 'доктора' ),
                   ( 'щипец', 'щтипцы' ),
                   ( 'палец', 'пальцы' ),
                   ( 'анастомоз', 'анастомозы' ),
                   ( 'аксон', 'аксоны' ) );

                   // Plural test values for nominative nouns
  cNounChPluralRU: tNounChPluralRU = (
                   ( 'доктор', 'доктора' ),
                   ( 'щипец', 'щипцы' ),
                   ( 'плец', 'пальцы' ) );

                   // Rules for nominative plural adjectives
  cAdjRuPluralRU:  tAdjRuPluralRU = (
                   ( 'кый', 'кие' ),   // hard masculine
                   ( 'кой', 'кие' ),   // hard masculine
                   ( 'гый', 'гие' ),   // hard masculine
                   ( 'хый', 'хие' ),   // hard masculine
                   ( 'жый', 'жие' ),   // hard masculine
                   ( 'шый', 'шие' ),   // hard masculine
                   ( 'шой', 'шие' ),   // hard masculine
                   ( 'чый', 'чие' ),   // hard masculine
                   ( 'щый', 'щие' ),   // hard masculine
                   ( 'щой', 'щие' ),   // hard masculine
                   ( 'ый',  'ые'  ),   // hard masculine
                   ( 'кая', 'кие' ),   // hard feminine
                   ( 'гая', 'гие' ),   // hard feminine
                   ( 'хая', 'хие' ),   // hard feminiыne
                   ( 'жая', 'жие' ),   // hard feminine
                   ( 'шая', 'шие' ),   // hard feminine
                   ( 'чая', 'чие' ),   // hard feminine
                   ( 'щая', 'щие' ),   // hard feminine
                   ( 'ая',  'ые'  ),   // hard feminine
                   ( 'кое', 'кие' ),   // hard neuter
                   ( 'гое', 'гие' ),   // hard neuter
                   ( 'хое', 'хие' ),   // hard neuter
                   ( 'жое', 'жие' ),   // hard neuter
                   ( 'шое', 'шие' ),   // hard neuter
                   ( 'чое', 'чие' ),   // hard neuter
                   ( 'щое', 'щие' ),   // hard neuter
                   ( 'ое', 'ые' ),     // hard neuter
                   ( 'ий', 'ие' ),     // soft masculine
                   ( 'ой', 'ые' ),     // soft masculine
                   ( 'яя', 'ие' ),     // soft feminine
                   ( 'ее', 'ие' ) );   // soft neuter

                   // Plural exceptions for nominative adjectives
  cAdjExPluralRU:  tAdjExPluralRU = (
                   ( 'zz', 'zz' ) );

                   // Plural test values for nominative adjectives
  cAdjChPluralRU:  tAdjChPluralRU = (
                   ( 'чёрный', 'чёрные' ),       // black
                   ( 'плечевой', 'плечевые' ),   // humeral
                   ( 'мелкый', 'мелкие' ),       // minor
                   ( 'гладкый', 'гладкие' ) );   // smooth

                   // Rules for genitive singular adjectives
  cGenAdjRU:       tGenAdjRU = (
                   ( 'ый', 'ого' ),    // новый-нового hard masculine
                   ( 'ой', 'ого' ),    // плечевой-плечевого hard masculine
                   ( 'щий', 'щего' ),  // отводящий-отводящего soft masculine
                   ( 'ний', 'него' ),  // нижний-нижнего soft masculine
                   ( 'тий', 'тьего' ), // третий-третьего soft masculine
                   ( 'ий', 'ого' ),    // русский-русского hard masculine
                   ( 'ая', 'ой' ),     // латеральная-латеральной hard feminine
                   ( 'ое', 'ого' ),    // новое-нового hard neuter
                   ( 'яя', 'ей' ),     // задняя-задней soft feminine
                   ( 'ее', 'его' ) );  // soft neuter

                   // Rules for genitive singular nouns
  cGenNounRU:      tGenNounRU = (
                   ( 'ер', 'ра' ),
                   ( 'ек', 'ка' ),     // желудочек-желудочка ventricule
                   ( 'ок', 'ка' ),     // пучок-пучка fasciculus
                   ( 'ов', 'ва' ),     // шов-шва raphe
                   ( 'й', 'я' ),       // слой-слоя
                   ( 'ка', 'ки' ),     // подушка-подушки спайка-спайки
                   ( 'ша', 'ши' ),     // предкрыша-предкрыши
                   ( 'а', 'ы' ),       // kора-kоры
                   ( 'я', 'и' ),       // артерия-артерии петля-петли
                   ( 'вь', 'вя' ),     // червь-червя vermis
                   ( 'ть', 'ти' ),     // часть-части
                   ( 'о', 'а' ),       // тело-телa
                   ( 'е', 'я' ),
                   ( 'п', 'па' ),      // гиппокамп-гиппокампа hippocampus
                   ( 'м', 'ма' ),      // субикулюм-субикулюма subiculum
                   ( 'р', 'ра' ),      // бугор-бугора tuber
                   ( 'д', 'да' ),      // свод-свода fornix
                   ( 'з', 'за' ),      // гипофиз-гипофиза hypophysis
                   ( 'л', 'ла' ),      // канал-канала canal
                   ( 'в', 'ва' ),      // нерв-нерва nerve
                   ( 'г', 'га' ),      // мозг-мозга medulla
                   ( 'т', 'та' ),      // тракт-тракта tract
                   ( 'с', 'са' ),      // таламус-таламуса thalamus
                   ( 'н', 'на' ),      // орган-органа organ
                   ( 'к', 'ка' ) );    // холмик-холмика лемниск-лемниска

                   // Rules for genitive plural adjectives
  cGenPluralAdjRU: tGenPluralAdjRU = (
                   ( 'ый', 'ых' ),     // новый-новых
                   ( 'ая', 'ых' ),     // новая-новых
                   ( 'ое', 'ых' ),     // новое-новых
                   ( 'ой', 'ох' ),
                   ( 'ий', 'их' ),     // синий-синих
                   ( 'яя', 'их' ),     // синяя-синих
                   ( 'ее', 'их' ) );   // синее-синих

                   // Rules for genitive plural nouns
  cGenPluralNounRU:tGenPluralNounRU = (
                   ( 'ж', 'жей' ),
                   ( 'ч', 'чей' ),
                   ( 'ш', 'шей' ),
                   ( 'щ', 'щей' ),
                   ( 'ь', 'ьей' ),
                   ( 'й', 'йев' ),
                   ( 'ц', 'цев' ),
                   ( 'н', 'нoв' ),     // нейрон-нейронов neuron
                   ( 'л', 'лoв' ),     // узел-узелoв ganglion
                   ( 'м', 'мoв' ),     // геликотрем-геликотремoв helicotrema
                   ( 'т', 'тoв' ),     // студент-студентов student
                   ( 'к', 'кoв' ),     // участок-участоков
                   ( 'а', '' ),        // камера-камер chamber
                   ( 'я', 'ь' ),       // after consonant
                   ( 'я', 'й' ),       // after vowel
                   ( 'ь', 'ей' ),
                   ( 'дро', 'дер' ),   // ядро-ядер nucleus
                   ( 'но', 'он' ),     // волокно-волокон
                   ( 'е', 'ей' ),
                   ( 'иe', 'ий' ) );   // здание-зданий

                   // Rules for noun gender (masculine by default)
  cNounRuGenderRU: tNounRuGenderRU = (
                   ( 'г', 'm' ),       // мозг рог порог круг
                   ( 'л', 'm' ),       // канал купол трабекул
                   ( 'с', 'm' ),       // пояс парус мыс гипоталамус
                   ( 'к', 'm' ),       // блок век копчик проток
                   ( 'м', 'm' ),       // ритм геликотрем
                   ( 'р', 'm' ),       // премоляр моляр бугор
                   ( 'н', 'm' ),       // нейрон дофамин сифон термин
                   ( 'ь', 'f' ),       // часть сеть тоннель бугристость ветвь
                   ( 'а', 'f' ),       // пятка рукоятка слюна дуга
                   ( 'я', 'f' ),       // гистология линия проекция
                   ( 'о', 'n' ),       // тело плечо крыло зерно
                   ( 'е', 'n' ) );     // поле ложе обеспечение сплетение

                   // Exceptions for noun gender
  cNounExGenderRU: tNounExGenderRU = (
                   ( 'путь', 'm' ),
                   ( 'гиппокамп', 'm' ),
                   ( 'слой', 'm' ),
                   ( 'соединение', 'n' ) );

                   // Tests for noun gender
  cNounChGenderRU: tNounChGenderRU = (
                   ( 'путь', 'm' ),
                   ( 'сердце', 'n' ),
                   ( 'соединение', 'n' ),
                   ( 'слой', 'm' ) );

                   // Rules for gender of adjectives
  cAdjRuGenderRU:  tAdjRuGenderRU = (
                   ( 'ний', 'няя', 'нее' ),      // soft adjectives
                   ( 'ый', 'ая', 'ое' ),         // hard adjective
                   ( 'ой', 'ая', 'ое' ),         // hard adjective
                   ( 'ий', 'ая', 'ое' ) );       // hard adjective

                   // Exceptions for gender of adjectives
  cAdjExGenderRU:  tAdjExGenderRU = (
                   ( 'общий', 'общяя', 'общее' ) );   // общий soft

                   // Tests for gender of adjectives
  cAdjChGenderRU:  tAdjChGenderRU = (
                   ( 'латеральный', 'латеральнaя', 'латеральнoе' ), // latéral
                   ( 'жёлтый', 'жёлтaя', 'жёлтoе' ),                // jaune
                   ( 'молодой', 'молодaя', 'молодoе' ),             // young
                   ( 'близкий', 'близкaя', 'близкoе' ),             // near
                   ( 'медленный', 'медленнaя', 'медленнoе' ),       // slow
                   ( 'последний', 'последняя', 'последнее' ) );     // last


                   // Test of terms without expansion
  cNoChExpRU:      tNoChExpRU = (
                   ( 8295, 27966 ),    // вестибулоциты типа 1
                   ( 8295, 8295 ),     // вестибулоцит типа 1
                   ( 7044, 7044 ),     // общее сухожильное кольцо
                   ( 7670, 7670 ),     // карликовый ганглиозный нейрон
                   ( 8129, 8129 ),     // латеральное лицо
                   ( 5264, 5264 ),     // конечный мозг (generic)
                   ( 7053, 29947 ),    // веко (generic)
                   ( 7053, 7053 ),     // веки
                   ( 6005, 6005 ),     // Угловая извилина
                   ( 7816, 7816 ),     // подтенториальное ложе
                   ( 8088, 8088 ),     // костлявый наружный слуховой проход
                   ( 28553, 28553 ),   // короткое ассоциативное волокно
                   ( 6274, 6274 ),     // короткие ассоциативные волокна
                   ( 0, 0 ) );

                   // Test of adjective expansion
  cAdjChExpRU:     tAdjChExpRU = (
                   ( 7101, 7101 ),     // вестибулoулитковый орган
                   ( 4155, 4155 ),     // локтевая артерия
                   ( 0, 0 ) );

                   // Test of mandatory expansion
  cMandChExpRU:    tMandChExpRU = (
                   ( 5142, 5142 ),     // спинномозговая часть терминальной нити
                   ( 5973, 5973 ),     // извилины большого мозга
                   ( 6085, 6085 ),     // лучистость мозолистого тела
                   ( 12294, 12294 ),   // восходящий медиальный пучок передний
                                       // мозга
                   ( 13172, 13172 ),   // комиссуральный путь гиппокампа
                   ( 0, 0 ) );

                   // Test of lateral expansion
  cLatChExpRU:     tLatChExpRU = (
                   ( 8658, 38488 ),    // face supérolatérale du lobe frontal
                                       // gauche
                   ( 6017, 38443 ),    // lobe temporal droit
                   ( 6085, 28635 ),    // radiation gauche du corps calleux
                   ( 6317, 28935 ),    // cellules cholinergiques du bras
                                       // vertical de la strie diagonale droite
                   ( 13172, 32446 ),   // voies commissurales de l'hippocampe
                                       // gauche
                   ( 5885, 28074 ),    // fibres périventriculaires du thalamus
                                       // droit
                   ( 0, 0 ) );

                   // Test of optional expansion
  cOptChExpRU:     tOptChExpRU = (
                   ( 7985, 7985 ),     // шейный сегмент спинномозгового мозга
                   ( 0, 0 ) );

                   // First TID: st_mod; second TID: st_val
  {cAdjChExpRU:     tAdjChExpRU = (
                   ( 4155, 4155 ),     // локтевая артерия
                   ( 33461, 7985 ),    // segments cervicaux de la m. épinière
                   ( 7986, 7986 ),     // segment cervical 1
                   ( 6985, 6985 ),     // artériole rétinienne temporale sup.
                   ( 8415, 8415 ),     // voie hypothalamospinale
                   ( 5792, 5792 ),     // commissure habénulaire
                   ( 6281, 6281 ),     // faisceaux occipitaux horizontaux
                   ( 11830, 11830 ),   // faisceau temporopariétal vertical
                   ( 10691, 10691 ) ); // quatrième vertèbre cervicale
  cAdjRuExpRU:     tAdjRuExpRU = (
                   ( '4155', 'NQ' ),   // локтевая артерия
                   ( '6281', 'NQA' ),  // faisceau occipital horizontal
                   ( '11830', 'NOQA' ),// faisceau temporopariétal vertical
                   ( '7986', 'NQI' ),  // segment cervical 1
                   ( '9511', 'NQPA' ), // faisceau frontal orbitopolaire
                   ( '6985', 'NQAA' ), // artériole rétinienne temporale sup.
                   ( '8415', 'NOQ' ) );}// voie hypothalamospinale

                   // Binomes Latin-Russian
  cLARUEquiv:      tBinome = (
                   ( 'cornu', 'corne' ),
                   ( 'lamina', 'lame' ),
                   ( 'posterior', 'postérieur' ),
                   ( 'spinalis', 'spinal' ) );

implementation

uses
  SysUtils, Entity, TAHBrowser, LAProc, Tetra;

constructor        tRUTerm.Create(
  Nominative:      String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create
  * Variant of constructor of a Russian term *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  inherited Create( Nominative, lt_Russian, nu_sin );
end; // __________________________________________________________________Create

function           tRUTerm.MakePluralRU(
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakePluralRU
  * Construction of a plural Russian term *
  Description:
  This procedure handles a Russian singular term made of any number of words
  and transform it to the plural form. It takes care of possible noun
  complements or invariants in the term which are left unchanged.</P>
  The plural form is computed thanks to plural rules for Russian. These rules
  are considered in their initial order and only the first rule matching a word
  is applied, making their order quite significant.</P>
  Nouns and adjectives are handled separately with their specific rules, and
  possibly their sets of exceptions.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Posit:           Integer;
  Indx:            Integer;
  Lgt:             Integer;
  PosCell:         Integer;
  IsExcept:        Boolean;
  AllGen:          Boolean;
  Word:            String;
  Plural:          String;
  MyWord:          String;
  SingVal:         String;
  ATerm:           String;
  MyTerm:          String;
  MyType:          tContrib;
  MyCase:          tCase;
  MyNode:          WordAnal;
begin

  // Loop on all words of the term
  ATerm := Self.Nominative;
  Plural := cEmpty;
  PosCell := 0;
  AllGen := False;
  IsRule := False;
  Ident := 0;
  while ( ( ATerm <> cEmpty ) and ( Poscell <= Self.NbWord ) ) do
  begin
    while ( ( Self.Node[ PosCell ].Cod <> cEmpty ) and
            ( Self.Node[ PosCell ].Cod[ 1 ] = 'p' ) ) do
      Inc( PosCell );
    MyNode := Self.Node[ PosCell ];
    if ( ( MyNode.Cod <> cEmpty ) and
         ( ( MyNode.Cod[ 1 ] = 'h' ) or ( MyNode.Cod[ 1 ] = 's' ) ) ) then
    begin
      Inc( PosCell );
      Continue;
    end;
    MyCase := CaseOf( MyNode );
    MyType := TypeOf( MyNode );

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

    // Append words at genitive, left unchanged
    // AllGen when true means that all next words are not at nominative
    if ( Word = 'к' ) then
      AllGen := True;
    if ( ( MyCase = ca_gen ) or AllGen ) then
    begin
      Plural := Plural + cSpace + Word
    end else

    // Work on a nominative word
    if ( MyCase = ca_nom ) then
    begin

      // Work on an adjective
      if ( MyType = co_Adj ) then
      begin

        // Define the plural of an adjective from exceptions
        IsExcept := False;
        for Indx := 1 to NbAdjExPluralRU do
        begin
          if ( Word = cAdjExPluralRU[ Indx, nu_sin ] )  then
          begin
            Word := cAdjExPluralRU[ Indx, nu_plu ];
            Plural := Plural + cSpace + Word;
            IsExcept := True;
            Break;
          end;
        end; // for on all plural exceptions for nouns

        // Define the plural of a noun from rules
        if ( not IsExcept ) then
        begin

          // Loop on plural rules for nominative adjectives
          for Indx := 1 to NbAdjRuPluralRU do
          begin
            SingVal := cAdjRuPluralRU[ Indx, nu_sin ];
            Lgt := Length( SingVal );
            if ( Lgt > 0 ) then
            begin
              if ( Copy( Word, Length( Word ) - Lgt + 1, Lgt ) = SingVal ) then
              begin
                MyWord := Copy( Word, 1, Length( Word ) - Lgt ) +
                          cAdjRuPluralRU[ Indx, nu_plu ];
                IsRule := True;
                Ident := Indx;
                Break;
              end;
            end;
          end; // for on all plural rules for nominative adjectives
          Plural := Plural + cSpace + MyWord;
        end;
      end else

      // Work on a noun
      if ( MyType = co_Noun ) then
      begin

        // Define the plural of a noun from exceptions
        IsExcept := False;
        for Indx := 1 to NbNounExPluralRU do
        begin
          if ( Word = cNounExPluralRU[ Indx, nu_sin ] )  then
          begin
            Word := cNounExPluralRU[ Indx, nu_plu ];
            Plural := Plural + cSpace + Word;
            IsExcept := True;
            Break;
          end;
        end; // for on all plural exceptions for nouns

        // Define the plural of a noun from rules
        if ( not IsExcept ) then
        begin

          // Loop on all plural rules if no exception matches
          Plural := Plural + cSpace + Word;
          for Indx := 1 to NbNounRuPluralRU do
          begin
            SingVal := cNounRuPluralRU[ Indx, nu_sin ];
            Lgt := Length( SingVal );
            if ( Lgt > 0 ) then
            begin
              if ( Copy( Word, Length( Word ) - Lgt + 1, Lgt ) = SingVal ) then
              begin
                Plural := Copy( Plural, 1, Length( Plural ) - Lgt ) +
                          cNounRuPluralRU[ Indx, nu_plu ];
                IsRule := True;
                Ident := Indx;
                Break;
              end;
            end else
            begin
              Plural := Plural + cNounRuPluralRU[ Indx, nu_plu ];
            end;
          end; // for on all plural rules for nouns
        end;
      end;
    end;

    // Move to the next word
    Inc( PosCell );
  end; // while on all words of the term

  // Return the plural term (after extraction of an initial blank)
  MyTerm := Copy( Plural, 2, Length( Plural ) );
  for Indx := 0 to Self.NbWord - 1 do
  begin
    if ( Self.Node[ Indx ].Cod = cEmpty ) then
      Continue;
    if ( ( Self.Node[ Indx ].Cod[ 1 ] = 'h' ) or
         ( Self.Node[ Indx ].Cod[ 1 ] = 's' ) ) then
      Continue;
    if ( Self.Node[ Indx ].Cod[ 4 ] <> 'n' ) then
      MyTerm := MyTerm + cSpace + Self.Node[ Indx ].Wrd;
  end;
  Result := MyTerm;
end; // ____________________________________________________________MakePluralRU

function           tRUTerm.GenderRU(
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                tGender;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GenderRU
  * Search for gender of the nominative noun of a term in Russian *
  Description:
  This procedure handles a Russian singular noun and determines its gender.</P>
  Usually a Russian term starts with adjectives followed by a single noun.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Posit:           Integer;
  NbCell:          Integer;
  MyPos:           Integer;
  Lgt:             Integer;
  Last:            String;
  Noun:            String;
  Termin:          String;
begin
  // Retrieve the first noun of the term
  NbCell := Self.NbWord;
  for Indx := 0 to NbCell - 1 do
  begin
    if ( Self.Node[ Indx ].Cod = cEmpty ) then
      Exit;
    if ( TypeOf( Self.Node[ Indx ] ) = co_Noun ) then
    begin
      Noun := Self.Node[ Indx ].Lem;
      MyPos := Indx;
      Break;
    end;
  end; // for on all cells

  // Gender from the list of exceptions
  Result := ge_unspec;
  IsRule := False;
  Ident := 0;
  for Indx := 1 to NbNounExGenderRU do
  begin
    if ( Noun = cNounExGenderRU[ Indx, ge_masculine ] ) then
    begin
      if ( cNounExGenderRU[ Indx, ge_feminine ] = 'm' ) then
        Result := ge_masculine
      else
      if ( cNounExGenderRU[ Indx, ge_feminine ] = 'f' ) then
        Result := ge_feminine
      else
      if ( cNounExGenderRU[ Indx, ge_feminine ] = 'n' ) then
        Result := ge_neuter;
      IsRule := True;
      Break;
    end;
  end; // for on all exception nouns

  // Gender by rules
  IsRule := False;
  if ( Result = ge_unspec ) then
  begin
    for Indx := 1 to NbNounRuGenderRU do
    begin
      Termin := cNounRuGenderRU[ Indx, ge_masculine ];
      Lgt := Length( Termin );
      if ( Copy( Noun, Length( Noun) - Lgt + 1, Length( Noun) ) = Termin ) then
      begin
        if ( cNounRuGenderRU[ Indx, ge_feminine ] = 'm' ) then
          Result := ge_masculine
        else
        if ( cNounRuGenderRU[ Indx, ge_feminine ] = 'f' ) then
          Result := ge_feminine
        else
        if ( cNounRuGenderRU[ Indx, ge_feminine ] = 'n' ) then
          Result := ge_neuter;
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
end; // ________________________________________________________________GenderRU

function           tRUTerm.MakeGenitiveRU()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenitiveRU
  * Construction of a genitive singular Russian term *
  Description:
  This procedure handles a Russian nominative singular term and transform it
  to the genitive singular form.</P>
  When a laterality is specified for the term, the genitive is built with the
  corresponding lateral adjective.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbWord:          Integer;
  Len:             Integer;
  Basis:           String;
  Ending:          String;
  Termin:          String;
  NewTerm:         String;
  Gender:          tGender;
  MyCell:          WordAnal;
begin
  // Loop on all words at nominative of the term
  NbWord := Self.NbWord;
  NewTerm := cEmpty;
  for Indx := 0 to NbWord - 1 do
  begin

    // Skip a non nominative words and the rest
    MyCell := Self.Node[ Indx ];
    if ( Length( MyCell.Cod ) < 3 ) then
      Continue;
    if ( CaseOf( MyCell ) <> tCase( ca_Nom ) ) then
    begin
      if ( Indx > 0 ) then
        NewTerm := NewTerm + cSpace;
      NewTerm := NewTerm + MyCell.Wrd;
      Continue;
    end;

    // Work on an adjective
    Len := Length( MyCell.Lem );
    if ( TypeOf( MyCell ) = co_Adj ) then
    begin
      for Indy := 1 to NbGenAdjRU do
      begin
        Termin := cGenAdjRU[ Indy, Succ( Succ( Low( TCase ) ) ) ];
        Basis := Copy( MyCell.Lem, 1, Len - Length( Termin ) );
        Ending := Copy( MyCell.Lem, Len - Length( Termin ) + 1, Len );
        if ( Ending = Termin ) then
        begin
          MyCell.Wrd := Basis + cGenAdjRU[ Indy, High( TCase ) ];
          if ( Indx > 0 ) then
            NewTerm := NewTerm + cSpace;
          NewTerm := NewTerm + MyCell.Wrd;
          MyCell.Cod[ 4 ] := 'g';
          Break;
        end;
      end; // for on all genitive endings of adjectives
    end else

    // Work on a noun
    begin
      for Indy := 1 to NbGenNounRU do
      begin
        Termin := cGenNounRU[ Indy, Succ( Succ( Low( tCase ) ) ) ];
        Basis := Copy( MyCell.Lem, 1, Len - Length( Termin ) );
        Ending := Copy( MyCell.Lem, Len - Length( Termin ) + 1, Len );
        if ( Ending = Termin ) then
        begin
          MyCell.Wrd := Basis + cGenNounRU[ Indy, High( tCase ) ];
          if ( Indx > 0 ) then
            NewTerm := NewTerm + cSpace;
          NewTerm := NewTerm + MyCell.Wrd;
          MyCell.Cod[ 4 ] := 'g';
          Break;
        end;
      end; // for on all genitive endings of nouns
    end;
    Self.NodeGS[ Indx ] := MyCell;
  end; // for on all words of the term
  Result := NewTerm;
end; // __________________________________________________________MakeGenitiveRU

function           tRUTerm.MakeGenPluralRU()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenPluralRU
  * Construction of a genitive plural Russian term *
  Description:
  This procedure handles a Russian nominative singular term and transform it
  to the genitive plural form.</P>
  When a laterality is specified for the term, the genitive is built with the
  corresponding lateral adjective.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  NbWord:          Integer;
  Len:             Integer;
  Basis:           String;
  Ending:          String;
  Termin:          String;
  NewTerm:         String;
  Gender:          tGender;
  MyCell:          WordAnal;
begin
  // Loop on all words at nominative of the term
  NbWord := Self.NbWord;
  NewTerm := cEmpty;
  for Indx := 0 to NbWord - 1 do
  begin

    // Skip non nominative words
    MyCell := Self.Node[ Indx ];
    if ( Length( MyCell.Cod ) < 3 ) then
      Break;
    if ( ( Length( MyCell.Cod ) >= 3 ) and ( MyCell.Cod[ 4 ] <> 'n' ) ) then
    begin
      if ( Indx > 0 ) then
        NewTerm := NewTerm + cSpace;
      NewTerm := NewTerm + MyCell.Wrd;
      Continue;
    end;

    // Work on an adjective
    Len := Length( MyCell.Lem );
    if ( ( Length( MyCell.Cod ) >= 3 ) and ( MyCell.Cod[ 1 ] = 'a'  ) ) then
    begin
      for Indy := 1 to NbGenPluralAdjRU do
      begin
        Termin := cGenPluralAdjRU[ Indy, Succ( Succ( Low( TCase ) ) ) ];
        Basis := Copy( MyCell.Lem, 1, Len - Length( Termin ) );
        Ending := Copy( MyCell.Lem, Len - Length( Termin ) + 1, Len );
        if ( Ending = Termin ) then
        begin
          MyCell.Wrd := Basis + cGenPluralAdjRU[ Indy, High( TCase ) ];
          if ( Indx > 0 ) then
            NewTerm := NewTerm + cSpace;
          NewTerm := NewTerm + MyCell.Wrd;
          MyCell.Cod[ 4 ] := 'g';
          Break;
        end;
      end; // for on all nominative singular endings of adjectives
    end else // end of work on a nominative adjective

    // Work on a noun
    if ( ( Length( MyCell.Cod ) >= 3 ) and ( MyCell.Cod[ 1 ] = 'n'  ) ) then
    begin
      for Indy := 1 to NbGenPluralNounRU do
      begin
        Termin := cGenPluralNounRU[ Indy, Succ( Succ( Low( TCase ) ) ) ];
        Basis := Copy( MyCell.Lem, 1, Len - Length( Termin ) );
        Ending := Copy( MyCell.Lem, Len - Length( Termin ) + 1, Len );
        if ( Ending = Termin ) then
        begin
          MyCell.Wrd := Basis + cGenPluralNounRU[ Indy, High( TCase ) ];
          if ( Indx > 0 ) then
            NewTerm := NewTerm + cSpace;
          NewTerm := NewTerm + MyCell.Wrd;
          MyCell.Cod[ 4 ] := 'g';
          Break;
        end;
      end; // for on all genitive plural endings of nouns
    end; // end of work on a nominative noun
  end; // for on all words of the term
  Result := NewTerm;
end; // _________________________________________________________MakeGenPluralRU

function           tRUTerm.MakeGenLatPluralRU
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenLatPluralRU
  * Construction of a genitive lateral plural Russian term *
  Description:
  This procedure handles a Russian singular term and transform it to the
  equivalent lateral plural form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Len:             Integer;
  CellPos:         Integer;
  LatForm:         String;
  NewTerm:         String;
  Termin:          String;
  Basis:           String;
  Ending:          String;
  ATerm:           String;
  Gender:          tGender;
  Later:           tLink;
  MyCell:          WordAnal;
begin

  // Find the adjective of laterality
  ATerm := Self.Nominative;
  Later := Self.Side;
  LatForm := cEmpty;
  CellPos := Self.WordPos;
  if ( ( Later = pw_MemberL ) or ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or ( Later = pw_TMemberL ) ) then
    LatForm := 'левых' // left at genitive plural
  else
  if ( ( Later = pw_MemberR ) or ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or ( Later = pw_TMemberR ) ) then
    LatForm := 'правых'; // right at genitive plural
  if ( LatForm = cEmpty ) then
  begin
    Result := ATerm;
    Exit;
  end;

  // Loop on all words at nominative of the term
  NbWord := Self.NbWord;
  NewTerm := cEmpty;
  for Indx := 0 to NbWord - 1 do
  begin

    // Skip non nominative words
    MyCell := Self.Node[ Indx ];
    if ( Length( MyCell.Cod ) < 3 ) then
      Break;
    if ( CellPos = Indx ) then
    begin
      if ( NewTerm <> cEmpty ) then
        NewTerm := NewTerm + cSpace;
      NewTerm := NewTerm + LatForm;
    end;
    // if ( TypeOf( MyCell ) = co_Noun )  then
    // begin

      // Work on an adjective
      Len := Length( MyCell.Lem );
      if ( TypeOf( MyCell ) = co_Adj ) then
      begin
        for Indy := 1 to NbGenPluralAdjRU do
        begin
          Termin := cGenPluralAdjRU[ Indy, Succ( Succ( Low( TCase ) ) ) ];
          Basis := Copy( MyCell.Lem, 1, Len - Length( Termin ) );
          Ending := Copy( MyCell.Lem, Len - Length( Termin ) + 1, Len );
          if ( Ending = Termin ) then
          begin
            MyCell.Wrd := Basis + cGenPluralAdjRU[ Indy, High( TCase ) ];
            if ( NewTerm <> cEmpty ) then
              NewTerm := NewTerm + cSpace;
            NewTerm := NewTerm + MyCell.Wrd;
            MyCell.Cod[ 4 ] := 'g';
            Break;
          end;
        end; // for on all genitive plural endings of adjectives
      end else

      // Work on a noun
      if ( TypeOf( MyCell ) = co_Noun ) then
      begin
        for Indy := 1 to NbGenPluralNounRU do
        begin
          Termin := cGenPluralNounRU[ Indy, Succ( Succ( Low( TCase ) ) ) ];
          Basis := Copy( MyCell.Lem, 1, Len - Length( Termin ) );
          Ending := Copy( MyCell.Lem, Len - Length( Termin ) + 1, Len );
          if ( Ending = Termin ) then
          begin
            MyCell.Wrd := Basis + cGenPluralNounRU[ Indy, High( TCase ) ];
            if ( NewTerm <> cEmpty ) then
              NewTerm := NewTerm + cSpace;
            NewTerm := NewTerm + MyCell.Wrd;
            MyCell.Cod[ 4 ] := 'g';
            Break;
          end;
        end; // for on all genitive plural endings of nouns
      end;
    // end;
  end; // for on all words of the term
  Result := NewTerm; // + cSpace + Self.Node[ 1 ].Lem;
end; // ______________________________________________________MakeGenLatPluralRU

function           tRUTerm.MakeLateralRU()
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLateralRU
  * Construction of a lateral Russian term *
  Description:
  This procedure handles a Russian term and transform it
  to its equivalent lateral form, by adjunction of the lateral adjective,
  either left or right. In case of unsufficient information, the term is
  returned unchanged.</P>
  The term may contain the position argument for the lateral adjective that was
  compiled when the term was expanded, as well as the syntax argument
  applicable to the lateral adjective (Self.WordType: tLatType). In absence of
  a specified syntax argument, this one is computed from the noun of the term,
  according to Russian rules.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;  // index through all words of the term
  LatForm:         String;   // the conjugated value of the lateral adjective
  ATerm:           String;   // the initial term without laterality
  NewTerm:         String;   // the computed new term with laterality
  Argument:        String;   // 3-letter syntax argument: gender, case, number
  Later:           tLink;    // side value
  MySyntax:        tLatType; // syntax value, received or computed
begin

  // Find the adjective of laterality
  ATerm := Self.Nominative;
  Later := Self.Side;
  LatForm := cEmpty;
  Self.WordPos := 0; // Always 0 in Russian

  // When undefined, compute the syntax argument from the noun in the term
  MySyntax := lt_undef;
  if ( Self.WordType = lt_undef ) then
  begin
    Argument := Copy( Self.Node[ Self.NbWord - 1 ].Cod, 3, 5 );
    MySyntax := SyntaxOf( Argument );
  end;

  // Retrieve the conjugated lateral adjective
  if ( Later in [ pw_MemberL, pw_SMemberL, pw_IMemberL,  pw_TMemberL ] ) then
    LatForm := cRUSinister[ MySyntax ]
  else
  if ( Later in [ pw_MemberR, pw_SMemberR, pw_IMemberR,  pw_TMemberR ] ) then
    LatForm := cRUDexter[ MySyntax ];

  // Exit on unchanged term
  if ( LatForm = cEmpty ) then
  begin
    Result := ATerm;
    Exit;
  end;

  // Position the lateral modifier in the new term
  NewTerm := cEmpty;
  for Indx := 0 to Self.NbWord - 1 do
  begin
    if ( Indx > 0 ) then
      NewTerm := NewTerm + cSpace;
    if ( Indx = Self.WordPos ) then
      NewTerm := NewTerm + LatForm + cSpace;
    NewTerm := NewTerm + Self.Node[ Indx ].Lem;
  end; // for on all words of the initial term
  Result := Trim( NewTerm );
end; // ___________________________________________________________MakeLateralRU

function           tRUTerm.MakeLatPluralRU
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeLatPluralRU
  * Construction of a nominative lateral plural Russian term *
  Description:
  This procedure handles a Russian singular term and transform it to the
  equivalent lateral plural form.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  Lgt:             Integer;
  IsExcept:        Boolean;
  IsGen:           Boolean;
  LatForm:         String;
  NewTerm:         String;
  ATerm:           String;
  MyNumber:        String;
  SingVal:         String;
  MyWord:          String;
  MyPlural:        String;
  Gender:          tGender;
  Later:           tLink;
  MyType:          tContrib;
  MyNode:          WordAnal;
begin

  // Generate the adjective of laterality
  ATerm := Self.Nominative;
  Later := Self.Side;
  LatForm := cEmpty;
  if ( ( Later = pw_MemberL ) or ( Later = pw_SMemberL ) or
       ( Later = pw_IMemberL ) or ( Later = pw_TMemberL ) ) then
  begin
    LatForm := 'левыe'; // left at nominative plural
  end else
  if ( ( Later = pw_MemberR ) or ( Later = pw_SMemberR ) or
       ( Later = pw_IMemberR ) or ( Later = pw_TMemberR ) ) then
  begin
    LatForm := 'правыe'; // right at nominative plural
  end;
  if ( LatForm = cEmpty ) then
  begin
    Result := ATerm;
    Exit;
  end;

  // Loop on all words of the term
  NewTerm := cEmpty;
  IsGen := False;
  for Indy := 0 to Self.NbWord - 1 do
  begin
    MyNode := Self.Node[ Indy ];
    MyWord := MyNode.Lem;
    MyType := TypeOf( MyNode );
    MyPlural := MyWord;
    if ( not IsGen ) then
    begin

      // Work on a noun
      if ( MyType = co_Noun ) then
      begin

        // Make the plural of the word at nominative
        // Define plural from exceptions
        IsExcept := False;
        MyPlural := cEmpty;
        for Indx := 1 to NbNounExPluralRU do
        begin
          if ( MyWord = cNounExPluralRU[ Indx, nu_sin ] )  then
          begin
            MyWord := cNounExPluralRU[ Indx, nu_plu ];
            MyPlural := MyPlural + cSpace + MyWord;
            IsExcept := True;
            Break;
          end;
        end; // for on all exceptions for plural
        if ( IsExcept ) then
          Break;

        // Loop on all Russian plural rules if no exception matches
        MyPlural := MyPlural + cSpace + MyWord;
        for Indx := 1 to NbNounExPluralRU do
        begin
          SingVal := cNounExPluralRU[ Indx, nu_sin ];
          Lgt := Length( SingVal );
          if ( Lgt > 0 ) then
          begin
            if ( Copy( MyWord, Length( MyWord ) - Lgt + 1, Lgt ) = SingVal ) then
            begin
              MyPlural := Copy( MyPlural, 1, Length( MyPlural ) - Lgt ) +
                          cNounExPluralRU[ Indx, nu_plu ];
              Break;
            end;
          end else
          begin
            MyPlural := MyPlural + cNounExPluralRU[ Indx, nu_plu ];
          end;
        end; // for on all rules for plural
      end else

      // Work on an adjective
      if ( MyType = co_Adj ) then
      begin

        // Make the plural of the word at nominative
        // Define plural from exceptions
        IsExcept := False;
        MyPlural := cEmpty;
        for Indx := 1 to NbAdjExPluralRU do
        begin
          if ( MyWord = cAdjExPluralRU[ Indx, nu_sin ] )  then
          begin
            MyWord := cAdjExPluralRU[ Indx, nu_plu ];
            MyPlural := MyPlural + cSpace + MyWord;
            IsExcept := True;
            Break;
          end;
        end; // for on all exceptions for plural
        if ( IsExcept ) then
          Break;

        // Loop on all Russian plural rules if no exception matches
        MyPlural := MyPlural + cSpace + MyWord;
        for Indx := 1 to NbAdjExPluralRU do
        begin
          SingVal := cAdjExPluralRU[ Indx, nu_sin ];
          Lgt := Length( SingVal );
          if ( Lgt > 0 ) then
          begin
            if ( Copy( MyWord, Length( MyWord ) - Lgt + 1, Lgt ) = SingVal ) then
            begin
              MyPlural := Copy( MyPlural, 1, Length( MyPlural ) - Lgt ) +
                          cAdjExPluralRU[ Indx, nu_plu ];
              Break;
            end;
          end else
          begin
            MyPlural := MyPlural + cAdjExPluralRU[ Indx, nu_plu ];
          end;
        end; // for on all rules for plural
      end;

    end;

    // Build the new term
    if ( Indy = Self.WordPos ) then
      NewTerm := NewTerm + cSpace + LatForm;
    NewTerm := NewTerm + cSpace + MyPlural;
    IsGen := IsGen or ( Self.Node[ Indy ].Cod[ 1 ] = 'n' );
  end; // for on all words of the term

  NewTerm := Copy( NewTerm, 2, Length( NewTerm ) );
  if ( Self.WordPos = Self.NbWord ) then
    NewTerm := NewTerm + cSpace + LatForm;
  Result := NewTerm;
end; // _________________________________________________________MakeLatPluralRU

procedure          tRUTerm.SetNominativeRU;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetNominativeRU
  * Action when entering a new value for Nominative property *
  Description:
  This method is call when a new nominative term is entered. It dispatches all
  the words in separate cells, then it call the GenderRU method in order
  to determine the gender of the term and to adjust all the adjectives to
  this gender.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Posit:           Integer;
  NbWord:          Integer;
  LastNom:         Integer;
  IsRule:          Boolean;
  Ident:           Integer;
  IsGen:           Boolean;
  MyTerm:          String;
  MyWord:          String;
  ValG:            Char;
  ValN:            Char;
  MyCell:          WordAnal;
  MyGender:        TGender;
begin
  // Store the words (blank separated)
  MyTerm := Self.Nominative;
  NbWord := 0;
  LastNom := 0;
  if ( Length( MyTerm ) = 0 ) then
    Exit;

  // Loop on all words of the term
  IsGen := False;
  repeat
    Posit := Pos( cSpace, MyTerm );
    if ( Posit = 0 ) then
    begin
      MyWord := MyTerm;
      MyTerm := cEmpty;
    end else
    begin
      MyWord := Copy( MyTerm, 1, Posit - 1 );
      MyTerm := Copy( MyTerm, Posit + 1, Length( MyTerm ) );
    end;

    // Check if the word is an adjective or a noun
    MyCell := Self.Node[ NbWord ];
    if ( not IsAdjRU( MyWord ) ) then
    begin

      // Treatment of a noun
      MyCell.Wrd := MyWord;
      MyCell.Lem := MyWord;
      if ( IsGen ) then
        MyCell.Cod := 'nxxgx'
      else
      begin
        MyCell.Cod := 'nxxnx';
        LastNom := NbWord;
      end;
      if ( Self.Number = nu_sin ) then
        ValN := 's'
      else
        ValN := 'p';
    end else
    begin

      // Treatment of an adjective
      MyCell.Wrd := MyWord;
      MyCell.Lem := MyWord;
      if ( IsGen ) then
        MyCell.Cod := 'axxgx'
      else
        MyCell.Cod := 'axxnx';
    end;
    IsGen := ( MyCell.Cod[ 1 ] = 'n' ) or IsGen;
    Self.Node[ NbWord ] := MyCell;
    Inc( NbWord );
  until ( Posit = 0 ); // repeat on all words of the term

  // Adjustment of gender and number
  Dec( NbWord );
  MyGender := Self.GenderRU( IsRule, Ident );
  if ( MyGender = ge_masculine ) then
    ValG := 'm'
  else if ( MyGender = ge_feminine ) then
    ValG := 'f'
  else if ( MyGender = ge_neuter ) then
    ValG := 'n';
  for Indx := 0 to LastNom do
  begin
    MyCell := Self.Node[ Indx ];
    if ( ( MyCell.Cod[ 1 ] = 'n' )or ( MyCell.Cod[ 1 ] = 'a' ) ) then
    begin
      MyCell.Cod[ 3 ] := ValG;
      MyCell.Cod[ 5 ] := ValN;
      Self.Node[ Indx ] := MyCell;
    end;
  end; // on all nominative words

  // Check for a regular term
  Self.IsRegular := True;
end; // _________________________________________________________SetNominativeRU

function           tRUTerm.MakeGenderRU(
  Gender:          tGender;
  AWord:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeGenderRU
  * Make an adjective at a specified gender in Russian *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Lgt:             Integer;
  MyMasc:          String;
  Myfem:           String;
  MyNeu:           String;
  Last:            String;
begin
  // Nothing to do for masculine gender
  if ( Gender = ge_masculine ) then
    Exit;

  // Scan the exceptions
  for Indx := 1 to NbAdjExGenderRU do
  begin
    if ( AWord = cAdjExGenderRU[ Indx, ge_masculine ] ) then
    begin
      if ( Gender = ge_feminine ) then
        Result := cAdjExGenderRU[ Indx, ge_feminine ]
      else
      if ( Gender = ge_neuter ) then
        Result := cAdjExGenderRU[ Indx, ge_neuter ];
      Exit;
    end;
  end; // for on all exceptions for gender of adjectives

  // Apply the rules for Russian feminine and neuter
  IsRule := True;
  for Indx := 1 to NbAdjRuGenderRU do
  begin
    MyMasc := cAdjRuGenderRU[ Indx, ge_masculine ];
    MyFem := cAdjRuGenderRU[ Indx, ge_feminine ];
    MyNeu := cAdjRuGenderRU[ Indx, ge_neuter ];
    Lgt := Length( MyMasc );
    Last :=  Copy( AWord, Length( AWord ) - Lgt + 1, Lgt );
    if ( ( Last = MyMasc ) or ( Last = MyFem ) or ( Last = MyNeu ) ) then
    begin
      if ( Gender = ge_feminine ) then
        Result := Copy( AWord, 1, Length( AWord ) - Lgt ) +
                  cAdjRuGenderRU[ Indx, ge_feminine ]
      else
      if ( Gender = ge_neuter ) then
        Result := Copy( AWord, 1, Length( AWord ) - Lgt ) +
                  cAdjRuGenderRU[ Indx, ge_neuter ];
      Ident := Indx;
      Exit;
    end;
  end;
  IsRule := False;
  Result := cEmpty;
end; // ____________________________________________________________MakeGenderRU

function           RussianOf(
  LAWord:          String )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RussianOf
  * Translate a Latin word into Russian *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
begin
  for Indx := 1 to NbBinome do
  begin
    if ( LAWord = cLARUEquiv[ Indx, 1 ] ) then
    begin
      Result := cLARUEquiv[ Indx, 2 ];
      Exit;
    end;
  end; // for
end; // _______________________________________________________________RussianOf

function           TranslateTermRU(
  TreeFormula:     TTreeView )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TranslateTermRU
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
end; // _________________________________________________________TranslateTermRU

function           MakeInGenitiveRU(
  MyNumber:        String;
  MyGender:        TGender;
  MySpecif:        String;
  MyElision:       Boolean )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeInGenitiveRU
  * Prepare the introductory string for genitive in Russian *
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
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
          MyWord := 'du'
        else
          MyWord := 'de'
      else

      // With elision
      if ( MyElision ) then
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
          MyWord := 'de l'''
        else
          MyWord := 'd''';
    end else

    // Feminine target
    if ( MyGender = ge_feminine ) then
    begin

      // No elision
      if ( not MyElision ) then
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
          MyWord := 'de la'
        else
          MyWord := 'de'
      else

      // With elision
      if ( MyElision ) then
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
          MyWord := 'de l'''
        else
          MyWord := 'd''';
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
          MyWord := 'des'
        else
          MyWord := 'de';
      end else

      // With elision
      if ( MyElision ) then
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
          MyWord := 'd'''
        else
          MyWord := 'd''';
    end else

    // Feminine target
    if ( MyGender = ge_feminine ) then
    begin

      // No elision
      if ( not MyElision ) then
      begin
        if ( ( MySpecif = 'S' ) or ( MySpecif = 'U' ) ) then
          MyWord := 'des'
        else
          MyWord := 'de';
      end else

      // With elision
      if ( MyElision ) then
        MyWord := 'd'''
    end;
  end;
  Result := MyWord;
end; // ________________________________________________________MakeInGenitiveRU

function           IsElisionRU(
  Text:            String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsElisionRU
  * Find if an elision is necessary *
  Description:
  There may be a few exceptions not taken into account below!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  Result := CharInSet( Text[ 1 ],
            [ 'a', 'e', 'é', 'è', 'ê', 'i', 'o', 'u', 'h', 'y' ] );
end; // _____________________________________________________________IsElisionRU

function           IsAdjRU(
  AWord:           String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ IsAdjRU
  * Find if a word is an adjective *
  Description:
  Warning: the word should be at nominative!
  This method uses the nominative endings of adjectives as declared for the
  construction of russian adjectives at genitive.</P>
  Warning: this strategy may be unsufficient!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indy:            Integer;
  Len:             Integer;
  Ending:          String;
  Termin:          String;
begin

  // Check with the rules for gender of nouns
  Result := True;
  for Indy := 1 to NbGenAdjRU do
  begin
    Termin := cGenAdjRU[ Indy, ca_nom ];
    Len := Length( AWord );
    Ending := Copy( AWord, Len - Length( Termin ) + 1, Len );
    if ( Ending = Termin ) then
      Exit;
  end; // for on all nominative endings of adjectives
  Result := False;
end; // _________________________________________________________________IsAdjRU

procedure          tRUTerm.SetFormulaRU;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormulaRU
  * Action when entering a new value for Formula property in Russian *
  Description:
  This methods aims at building a new nominative term in the specified
  language from a universal formula.</P>
  The specific problem of Russian is the use of a pseudo inverted order as
  natural order: the Russian order is inverted relative to the universal
  formula, except for subgroups starting with a prefix.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Posit:           Integer;
  UID:             Integer;
  NbContrib:       Integer;
  Shift:           Integer;
  CurrShift:       Integer;
  IsPref1:         Boolean;        // Presence of a first prefix
  IsPref2:         Boolean;        // Presence of a second prefix
  IsPref12:        Boolean;        // First and second prefixes in the same word
  IsPref3:         Boolean;        // Presence of a third prefix
  IsPref23:        Boolean;        // Second and third prefixes in the same word
  IsPrefix:        Boolean;        // Current entry is a prefix
  IsLastPrefix:    Boolean;        // Last entry is a prefix
  IsCompl:         Boolean;
  IsInv:           Boolean;
  MyFormula:       String;
  MyPart:          String;
  MyType:          String;
  MyCode:          String;
  MyContrib:       String;
  MyWord:          String;
  LexUnit:         tUnit;
  LexEntity:       tEntity;
  MySingle:        tSingle;
  ANode:           WordAnal;
  MyGender:        tGender;
  MyLex:           tLexType;
begin

  // Retrieve a single contribution
  MyFormula := Self.Formula;
  NbContrib := 0;
  IsPref1 := False;
  IsPref2 := False;
  IsPref3 := False;
  IsPref12 := False;
  IsPref23 := False;
  IsLastPrefix := False;
  IsCompl := False;
  IsInv := False;
  repeat
    Posit := Pos( ',', MyFormula );
    if ( Posit > 0 ) then
    begin
      MyContrib := Copy( MyFormula, 1, Posit - 1 );
      MyFormula := Copy( MyFormula, Posit + 1, Length( MyFormula ) );
    end else
    begin
      MyContrib := MyFormula;
      MyFormula := cEmpty;
    end;
    if ( MyContrib <> cEmpty ) then
    begin
      IsCompl := IsCompl or ( MyContrib[ 1 ] = 'C' );
      IsInv := IsInv or ( MyContrib[ 1 ] = 'I' );
    end else
      Break;
    Inc( NbContrib );

    // Logics for presence of prefixes
    IsPrefix := MyContrib[ 1 ] = 'P';
    if ( IsPrefix ) then
    begin
      if ( not IsPref1 ) then
        IsPref1 := True
      else
      if ( not IsPref2 ) then
        IsPref2 := True
      else
      if ( not IsPref3 ) then
        IsPref3 := True;
      IsPref12 := IsPref1 and IsPref2 and IsLastPrefix;
      IsPref23 := IsPref2 and IsPref3 and IsLastPrefix;
    end;
    IsLastPrefix := IsPrefix;
  until ( Posit = 0 ); // on all contributions of a formula

  // Loop on all contributions of the formula (inverted order in Russian)
  MyFormula := Self.Formula;
  Indx := NbContrib - 1;
  if IsInv then
    Dec( Indx );
  if IsCompl then
    Dec( Indx );
  Self.NbWord := NbContrib;
  Shift := 0;
  IsLastPrefix := False;
  repeat

    // Retrieve a single contribution
    Posit := Pos( ',', MyFormula );
    if ( Posit > 0 ) then
    begin
      MyPart := Copy( MyFormula, 1, Posit - 1 );
      MyFormula := Copy( MyFormula, Posit + 1, Length( MyFormula ) );
    end else
    begin
      MyPart := MyFormula;
      MyFormula := cEmpty;
    end;

    // Retrieve the contributing lexical entity
    Posit := Pos( cRol, MyPart );
    UID := 0;
    MyLex := lx_Undef;
    if ( Posit > 0 ) then
    begin
      MyType := Copy( MyPart, 1, Posit - 1 );
      MyLex := LexOf( MyType );
      MyPart := Copy( Mypart, Posit + 1, Length( MyPart ) );
      Posit := Pos( cRor, MyPart );
      if ( Posit > 0 ) then
      begin
        MyPart := Copy( Mypart, 1, Posit - 1 );
        UID := StrToInt( MyPart );
      end;
    end;
    if ( UID > 0 ) then
    begin
      LexUnit := TAH.GetUnitByPos( UID );
      if ( LexUnit <> nil ) then
        LexEntity := TAH.GetEntityByPos( LexUnit.Generator );
    end;

    // Retrieve the contribution and store them in pseudo inverted order
    // The natural order is inverted except inside subgroups made of one or two
    // prefixes with their adjective.
    if ( LexEntity <> nil ) then
    begin
      LexEntity.LgCurrent := lt_Russian;
      case MyLex of

      // Handling of a noun
      lx_Noun:
        begin
          LexEntity.Query := tSearch.Create( st_Nou );
          Shift := NbContrib - 1 - Indx;
          MyCode := 'nxxnx';
          IsLastPrefix := False;
        end;

      // Handling of a noun complement
      lx_Compl:
        begin
          LexEntity.Query := tSearch.Create( st_Nou );
          MyCode := 'nxxgx';
          IsLastPrefix := False;
          CurrShift := Shift;
          Self.Node[ Indx + CurrShift ] := Self.Node[ Indx + CurrShift + 1 ];
          Shift := 1;
          if ( ( Self.NbWord > 2 ) and
               ( Self.Node[ Indx + CurrShift ].Cod[ 1 ] <> 'n' ) ) then
          begin
            Self.Node[ Indx + CurrShift + 1 ] :=
              Self.Node[ Indx + CurrShift + 2 ];
            Shift := 2;
          end;
          if ( ( Self.NbWord > 3 ) and
               ( Self.Node[ Indx + CurrShift + 1 ].Cod[ 1 ] <> 'n' ) ) then
          begin
            Self.Node[ Indx + CurrShift + 2 ] :=
              Self.Node[ Indx + CurrShift + 3 ];
            Shift := 3;
          end;
        end;

      // Handling of an invariant (always in last position)
      lx_Invar:
        begin
          LexEntity.Query := tSearch.Create( st_Inv );
          MyCode := 'ixxxx';
          Shift := 0;
          IsLastPrefix := False;
        end;

      // Handling of an adjective
      lx_Adj:
        begin
          LexEntity.Query := tSearch.Create( st_Adj );
          MyCode := 'axxnx';
          Shift := 0;
          if ( IsLastPrefix ) then
          begin
            // After two consecutive prefixes
            if ( ( ( IsPref12 ) or ( IsPref23 ) ) and ( Shift = 0 ) ) then
              Shift := 2
            else
            // After a single prefix
              Shift := 1;
          end;
          IsLastPrefix := False;
        end;

      // Handling of a prefix: determine the shift in position
      lx_Pref:
        begin
          LexEntity.Query := tSearch.Create( st_Pre );
          MyCode := 'pxxxx';
          // First of two consecutive prefixes
          if ( ( ( IsPref1 ) and ( IsPref12 ) and ( not IsLastPrefix ) ) or
               ( ( IsPref2 ) and ( IsPref23 ) and ( not IsLastPrefix ) ) ) then
            Shift := -2
          else
          // Single prefix
          if ( ( ( IsPref1 ) and ( not IsPref12 ) and ( not IsLastPrefix ) ) or
               ( ( IsPref2 ) and ( not IsPref23 ) and ( not IsLastPrefix ) ) or
               ( IsPref3 ) ) then
            Shift := -1
          else
          // Second of two consecutive prefixes
            Shift := 0;
          IsLastPrefix := True;
        end;

      // Handling of an apposition
      lx_Appos:
        begin
          MyWord := LexEntity.GetVocabulary( lt_Russian, st_Nou );
          LexEntity.Query := tSearch.Create( st_Nou );
          if ( MyWord = cEmpty ) then
          begin
            MyWord := LexEntity.GetVocabulary( lt_Russian, st_Adj );
            LexEntity.Query := tSearch.Create( st_Adj );
            if ( MyWord = cEmpty ) then
            begin
              MyWord := LexEntity.GetVocabulary( lt_Russian, st_Pre );
              LexEntity.Query := tSearch.Create( st_Pre );
              if ( MyWord = cEmpty ) then
                MyWord := 'ERR';
            end;
          end;
          MyCode := 'ixxxx';
        end;
      end; // case on all lexical types

      // Search the word and store it at the appropriate position
      LexEntity.Query.MyLang := lt_Russian;
      LexEntity.SearchTerm;
      MySingle := LexEntity.CurrSingle;
      if ( MySingle <> nil ) then
      begin
        ANode := Self.Node[ Indx + Shift ];
        ANode.Lem := MySingle.Mandat;
        ANode.Wrd := MySingle.Mandat;
        ANode.Cod := MyCode;
        Self.Node[ Indx + Shift ] := ANode;
      end else
      begin
        ANode := Self.Node[ Indx + Shift ];
        ANode.Lem := 'ERR';
        ANode.Cod := 'xxxxx';
        Self.Node[ Indx + Shift ] := ANode;
      end;
    end;

    // Move to the next contribution (inverted order in Russian)
    Dec( Indx );
  until ( MyFormula = cEmpty ); // on all contributions of a formula

  // Reposition a possible invariant to last position
  if ( ( Self.Node[ 0 ].Cod <> cEmpty ) and
       ( Self.Node[ 0 ].Cod[ 1 ] = 'i' ) ) then
  begin
    ANode := Self.Node[ 0 ];
    for Indx := 1 to Self.NbWord do
      Self.Node[ Indx - 1 ] := Self.Node[ Indx ];
    Self.Node[ Self.NbWord - 1 ] := ANode;
  end;

  // Check syntax of adjectives
  Self.SetSyntaxRU;
end; // ____________________________________________________________SetFormulaRU

procedure          tRUTerm.SetSyntaxRU;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetSyntaxRU
  * Compile the detailled syntax of a term *
  Description:
  This procedure considers all the words of a term and consolidates the
  syntactic argument, that is only partially set at this stage. Nouns,
  adjective and genitive nouns are considered in turn.</P>
  For the adjectives, they must be converted to their exact gender form. For
  feminine and neuter adjectives, a conversion is necessary.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;
  Indy:            Integer;
  CellPos:         Integer;
  FirstGen:        Integer;
  Posit:           Integer;
  Len:             Integer;
  Ident:           Integer;
  IsRule:          Boolean;
  MyWord:          String;
  MyLem:           String;
  Termin:          String;
  Basis:           String;
  Ending:          String;
  MyGender:        tGender;
  MyNode:          WordAnal;
begin
  // Get the gender of nominative noun
  MyGender := Self.GenderRU( IsRule, Ident );

  // Update the nominative cells
  if ( MyGender <> ge_unspec ) then
  begin

    // Update the noun cell
    CellPos := Self.NbWord - 1;
    if ( ( Length( Self.Node[ CellPos ].Cod ) >= 4 ) and
         ( Self.Node[ CellPos ].Cod[ 4 ] = 'g' ) ) then
      Dec( CellPos );
    if ( ( Self.Node[ CellPos ].Cod <> cEmpty ) and
         ( Self.Node[ CellPos ].Cod[ 1 ] = 'i' ) ) then
      Dec( CellPos );
    if ( MyGender = ge_masculine ) then
      Self.SetCode( CellPos, 'nxmns' )
    else
    if ( MyGender = ge_feminine ) then
      Self.SetCode( CellPos, 'nxfns' )
    else
    if ( MyGender = ge_neuter ) then
      Self.SetCode( CellPos, 'nxnns' );

    // Update the adjective cells if any
    if ( Self.NbWord > CellPos ) then
    begin
      for Indx := 0 to Self.NbWord - 2 do
      begin
        MyNode := Self.Node[ Indx ];
        if ( ( MyNode.Lem <> cEmpty ) and ( MyNode.Cod[ 1 ] <> 'a' ) ) then
          Continue;
        if ( MyGender = ge_masculine ) then
          MyNode.Cod := 'axmns'
        else
        if ( MyGender = ge_feminine ) then
        begin
          MyNode.Cod := 'axfns';
          MyNode.Lem := Self.MakeGenderRU( ge_feminine, MyNode.Lem, IsRule,
                                           Ident );
          Self.Node[ Indx ] := MyNode;
        end else
        if ( MyGender = ge_neuter ) then
        begin
          MyNode.Cod := 'axnns';
          MyNode.Wrd := MyNode.Lem;
          MyNode.Lem := Self.MakeGenderRU( ge_neuter, MyNode.Lem, IsRule,
                                           Ident );
          Self.Node[ Indx ] := MyNode;
        end;
      end; // on all adjectives after the head noun at nominative
    end;

    // Update a genitive noun if any
    FirstGen := Self.NbWord - 1;                           // not sufficient ???
    for Indx := FirstGen to Self.NbWord - 1 do
    begin
      MyNode := Self.Node[ Indx ];
      MyLem := MyNode.Lem;
      if ( ( Length( MyNode.Cod ) >= 4 ) and ( MyNode.Cod[ 4 ] <> 'g' ) ) then
        Continue;
      Self.SetCode( Indx, 'nxxgx' );
      Len := Length( MyLem );
      for Indy := 1 to NbGenNounRU do
      begin
        Termin := cGenNounRU[ Indy, Succ( Succ( Low( TCase ) ) ) ];
        Basis := Copy( MyLem, 1, Len - Length( Termin ) );
        Ending := Copy( MyLem, Len - Length( Termin ) + 1, Len );
        if ( Ending = Termin ) then
        begin
          MyLem := Basis + cGenNounRU[ Indy, High( TCase ) ];
          MyNode.Lem := MyLem;
          Self.Node[ Indx ] := MyNode ;
          Break;
        end;
      end; // for on all genitive endings of nouns
    end; // for on all non nominative words
  end;
  Self.IsRegular := True;
end; // _____________________________________________________________SetSyntaxRU

procedure          ValidateRU;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ValidateRU
  * Validation of Russian procedures *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
type
  SampleRec        = record
    InText:        String;
    OutText:       String;
    Latin:         String;
    TypeText:      ( ty_undef, ty_plur, ty_nom, ty_gen, ty_lat );
    LgText:        tLanguage;
    IsOk:          Boolean;
    Comment:       String;
  end;
const
  NbSample =       7;
  Sample:          Array[ 1 .. NbSample ] of SampleRec = (
  ( InText: 'полоска'; OutText: 'полоски'; Latin: 'stria'; TypeText: ty_plur;
    LgText: lt_Russian; IsOk: True;
    Comment: 'nominative plural word with soft consonant к' ),
  ( InText: 'мост'; OutText: 'мосты'; Latin: 'pons'; TypeText: ty_plur;
    LgText: lt_Russian; IsOk: True; Comment: 'regular nominative plural word' ),
  ( InText: 'клетка'; OutText: 'клеткы'; Latin: 'cellula'; TypeText: ty_plur;
    LgText: lt_Russian; IsOk: False;
    Comment: 'nominative plural word with soft consonant к' ),
  ( InText: 'клетка'; OutText: 'клетки'; Latin: 'cellula'; TypeText: ty_plur;
    LgText: lt_Russian; IsOk: True;
    Comment: 'nominative plural word with soft consonant к' ),
  ( InText: 'глазничная извилина'; OutText: 'глазничные извилины';
    Latin: 'pars orbitalis'; TypeText: ty_nom; LgText: lt_Russian; IsOk: True;
    Comment: 'nominative plural simple term (noun plus adjective)' ),
  ( InText: 'нейрон бледного шара'; OutText: 'нейроны бледного шара';
    Latin: 'neuron globi pallidi'; TypeText: ty_nom; LgText: lt_Russian;
    IsOk: True; Comment: 'nominative plural term with a genitive part' ),
  ( InText: 'ветвь к черному веществу'; OutText: 'ветви к черному веществу';
    Latin: 'ramus substantiae nigrae'; TypeText: ty_nom; LgText: lt_Russian;
    IsOk: True; Comment: 'nominative plural term with preposition к' ) );
var
  Indx:            Integer;
  CountOk:         Integer;
  CountErr:        Integer;
  Ident:           Integer;
  IsRule:          Boolean;
  Singular:        String;
  Plural:          String;
  MyPlural:        String;
  MyTerm:          TRUTerm;
  MyLang:          tLanguage;
begin
  // Loop on all samples
  CountOk := 0;
  CountErr := 0;
  for Indx := 1 to NbSample do
  begin

    // Select the language
    MyLang := Sample[ Indx ].LgText;
    if ( MyLang = lt_Russian ) then
    begin

      // Retrieve the next sample
      Singular := Sample[ Indx ].InText;
      Plural := Sample[ Indx ].OutText;

      // Validation of plural terms: function MakePluralRU
      if ( Sample[ Indx ].TypeText in [ ty_plur, ty_nom ] ) then
      begin
        MyTerm := TRUTerm.Create( Singular );
        MyPlural := MyTerm.MakePluralRU( IsRule, Ident );
      end;
    end;

    // Publish the result of validation
    if ( ( MyPlural = Plural ) and ( Sample[ Indx ].IsOk ) or
         ( MyPlural <> Plural ) and ( not Sample[ Indx ].IsOk ) ) then
    begin
      Inc( CountOk );
    end else
    begin
      Inc( CountErr );
    end;
  end;  // for on all samples
end; // ______________________________________________________________ValidateRU

function           SetFormalPSetRU(
  Term:            tSingle )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SetFormalPSetRU
  * Define the formal term for a pset *
  Description:
  The formal term for a specific pset is created, with its nominative part at
  singular because plurals are not accepted in the formal terms. The head part
  is followed by the genitive plural form of the generic term.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyTerm:          tTerm;
  NewTerm:         String;
  Prefix:          String;
begin
  MyTerm := tTerm.Create( Term.Mandat, lt_Russian );
  NewTerm := MyTerm.GenPlural;
  Result := cEmpty;
  if ( MyTerm.IsRegular ) then
  begin
    Prefix := 'пара вместов';
    Result := Prefix + cSpace + NewTerm;
  end;
end; // _________________________________________________________SetFormalPSetRU

function           TestAdjectiveGenderRU(
  AGender:         tGender;
  AnAdj:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestAdjectiveGenderRU
  * Test for feminine of French adjective *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyAdj:           tRUTerm;
begin
  MyAdj := tRUTerm.Create( AnAdj );
  Result := MyAdj.MakeGenderRU( AGender, AnAdj, IsRule, Ident );
end; // ___________________________________________________TestAdjectiveGenderRU

function           TestNounGenderRU(
  ANoun:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestNounGenderRU
  * Test for gender of French nouns *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyNoun:          tRUTerm;
  MyGender:        tGender;
begin
  MyNoun := tRUTerm.Create( ANoun );
  MyGender := MyNoun.GenderRU( IsRule, Ident );
  if ( MyGender = ge_masculine ) then
    Result := 'm'
  else
  if ( MyGender = ge_feminine ) then
    Result := 'f'
  else
  if ( MyGender = ge_neuter ) then
    Result := 'n';
end; // ________________________________________________________TestNounGenderRU

function           TestNounPluralRU(
  ANoun:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestNounPluralRU
  * Test for plural of Russian nouns *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyNoun:          tRUTerm;
  MyNumber:        tNumber;
begin
  MyNoun := tRUTerm.Create( ANoun );
  Result := MyNoun.MakePluralRU( IsRule, Ident );
end; // ________________________________________________________TestNounPluralRU

function           TestAdjPluralRU(
  AnAdj:           String;
  var IsRule:      Boolean;
  var Ident:       Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TestAdjPluralRU
  * Test for plural of Russian adjectives *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  MyAdj:          tRUTerm;
  MyNumber:       tNumber;
begin
  MyAdj := tRUTerm.Create( AnAdj );
  Result := MyAdj.MakePluralRU( IsRule, Ident );
end; // _________________________________________________________TestAdjPluralRU

function           tRUTerm.MakeAdjectiveRU(
  Adj :            String;
  Pre:             String )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeAdjectiveRU
  * Insert an adjective of expansion in base term *
  Description:
  This procedure works on the base part of an entity and adds the adjective
  resulting from its adjective expansion. The new cell of the adjective is
  computed, then the new cell is inserted immediately before the noun. Finally
  the term is rebuilt as a single string.</p>
  The adjective may be accompanied by a prefix, to be added in front of the
  adjective.<P>
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
  MyWord:          String;
  MyTerm:          String;
  NewAdj:          WordAnal;
  NewPref:         WordAnal;
  MyNode:          WordAnal;
  MyAdj:           tRUTerm;
begin

  // Initial stuff
  NounPos := 0;
  MyNode := Self.Node[ 0 ];
  MyWord := MyNode.Wrd;
  AdjPos := NounPos + 1;
  NbWord := Self.NbWord;
  NbPlus := NbWord - 1 - NounPos;

  // Prepare a new node for the adjective
  MyNode := Self.Node[ NounPos ];
  NewAdj.Cod := 'axmns';
  if ( MyNode.Cod[ 3 ] = 'f' ) then
  begin
    MyAdj := tRUTerm.Create( Adj );
    Adj := MyAdj.MakeGenderRU( ge_feminine, Adj, IsRule, Ident );
    NewAdj.Cod := 'axfns';
  end else
  if ( MyNode.Cod[ 3 ] = 'n' ) then
  begin
    MyAdj := tRUTerm.Create( Adj );
    Adj := MyAdj.MakeGenderRU( ge_neuter, Adj, IsRule, Ident );
    NewAdj.Cod := 'axnns';
  end;
  NewAdj.Lem := Adj;

  // Prepare a new node for the prefix
  if ( Pre <> cEmpty ) then
  begin
    NewPref.Wrd := Pre;
    NewPref.Lem := Pre;
    NewPref.Cod := 'pxxxx';
  end;

  // Create the new nodes for the adjective (and prefix) before the noun
  Inc( NbWord );
  NbShift := 1;
  if ( Pre <> cEmpty ) then
  begin
    Inc( NbWord );
    NbShift := 2
  end;
  Self.NbWord := NbWord;
  for Indx := NbWord - 1 downto NbWord - 1 - NbPlus do
    Self.Node[ Indx ] := Self.Node[ Indx - NbShift ];

  // Add the new nodes
  if ( Pre <> cEmpty ) then
  begin
    Self.Node[ 0 ] := NewPref;
    Self.Node[ 1 ] := NewAdj;
  end else
    Self.Node[ 0 ] := NewAdj;

  // Rebuild the term
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
end; // _________________________________________________________MakeAdjectiveRU

function           tRUTerm.MakeBaseRU
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeBaseRU
  * Set the base of a Russian term after an expansion *
  Description:
  This method defines the values applicable to lateral adjectives for the
  Russian language.</P>
  In Russian, the lateral adjective comes in first position before the noun
  it qualifies. It is dependant on this noun in gender, number and case.</P>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index
  PosWord:         Integer;            // Position of bilateral placeholder
  Syntax:          String;             // Syntax for placeholder
  MyCell:          WordAnal;           // Placeholder cell
begin

  // Determine the syntax and position of the lateral placeholder
  // first position in Russian
  Posword := 0;
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
  for Indx := Self.NbWord downto 1 do
    Self.Node[ Indx ] := Self.Node[ Indx - 1 ];
  Self.Node[ PosWord ] := MyCell;
  Result := True;
end; // ______________________________________________________________MakeBaseRU

function           tRUTerm.MakeMandatRU(
  TID:             Integer )
  :                String;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeMandatRU
  * Set the mandatory part of a Russian term *
  Description:
  This procedure defines the mandatory part specified by the TID argument.</p>
  The part to be added is retrieved as a Russian term at nominative that is
  expected to be regular. The genitive is computed and then returned. The
  syntax analysis of term is updated.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  NbSingle:        Integer;            // Number of singles in generating entity
  MandatEntity:    tEntity;            // Generating entity of expansion
  MyTerm:          tSingle;            // Applicable single
  MyRUTerm:        tRUTerm;            // Applicable term
begin

  // Build the genitive
  Past := Self.NbWord;
  MandatEntity := TAH.GetEntityByTID( TID );
  NbSingle := MandatEntity.NbCurrent;
  for Indx := 0 to NbSingle - 1 do
  begin
    MyTerm := MandatEntity.CurrTerm[ Indx ];
    if ( MyTerm.Category in cGroupBase ) then
      Break;
  end; // for on all singles of the current language
  if ( MyTerm <> nil ) then
  begin
    MyRUTerm := tRUTerm( MyTerm.LgTerm );
    if ( MyRUTerm <> nil ) then
    begin
      Result := Trim( MyRUTerm.Genitive );

      // Adjust the syntax of owner Russian term
      NbWordGS := MyRUTerm.NbWordGS;
      for Indx := 0 to NbWordGS - 1 do
      begin
        Self.Node[ Indx + Past ] := MyRUTerm.NodeGS[ Indx ];
      end; // for on all genitive words
    end;
  end;
end; // ____________________________________________________________MakeMandatRU

function           tRUTerm.MakeOptionRU(
  MyTerm:          tSingle )
  :                Boolean;
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MakeOptionRU
  * Make the optional part of a Russian term *
  Description:
  This procedure defines the optional part specified as a single in
  argument.</p>
  The part to be added is retrieved as a Russian term at nominative that is
  expected to be regular. The genitive is computed and added. The
  syntax analysis of the term is updated.</p>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  Indx:            Integer;            // Index on all genitive words
  NbWordGS:        Integer;            // Number of genitive words
  Past:            Integer;            // Number of initial words
  MyGenitive:      String;             // Genitive generated term
  MyRUTerm:        tRUTerm;            // Applicable term
begin

  // Build the genitive
  Past := Self.NbWord;
  MyRUTerm := tRUTerm( MyTerm.LgTerm );
  if ( MyRUTerm = nil ) then
  begin
    MyTerm.SetError( 995 );
    Result := False;
    Exit;
  end;
  MyGenitive := MyRUTerm.MakeGenitiveRU;

  // Adjust the syntax of owner Russian term
  NbWordGS := MyRUTerm.NbWordGS;
  for Indx := 0 to NbWordGS - 1 do
  begin
    Self.Node[ Indx + Past ] := MyRUTerm.NodeGS[ Indx ];
  end; // for on all genitive words
  Self.NewNom := Trim( MyGenitive );
  Result := True;
end; // ____________________________________________________________MakeOptionRU

end.

