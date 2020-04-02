# Blog
Deze blogpost geeft inzicht in mijn leerproces van Prolog en de implementatie van de nonogram solver.

## Waarom prolog?

## Logisch programmeren
Prolog is een programmeertaal volgens het logische programmeer paradigma.
Logisch programmeren is gebaseerd op logica, waarin op basis van feiten en regels informatie kan worden gededuceerd. 

Een voorbeeld van logische redenering:  
Een regel: Liam blijft binnen wanneer het regent.  
Een feit: Het regent vandaag.  
Conclusie: Liam blijft vandaag binnen.  

Logisch programmeren is dus goed om applicaties af te handelen die op zulke logica gebaseerd is. Logische puzzels, zoals de naam suggereert,
zijn gebaseerd op logica. Voorbeelden van logische puzzels zijn sudoku's, zebrapuzzels en nonogrammen. Deze puzzels zijn op te lossen aan de hand
van een set regels en feiten.

## De nonogram solver uitdaging
Omdat logische puzzels een goed onderwerp zijn voor logisch programmeren, heb ik besloten om een nonogram solver met prolog te maken. 
In mijn vrije tijd los ik graag nonogrammen op, dus leek het me wel interessant om die als uitdaging te gebruiken.  
Mijn uitdaging concreet is om met Prolog een set regels op te stellen, waarmee 5x5 nonogrammen opgelost kunnen worden.  
Meer info over nonogrammen: https://nl.wikipedia.org/wiki/Nonogram

## Starten met Prolog
Prolog is een populaire programmeertaal voor logisch programmeren. Om met de basis te beginnen, tikte ik "Prolog Tutorial" in Google,
en kwam ik op de volgende resultaten:

### SWI-Prolog
SWI-Prolog is een gratis implementatie van Prolog. SWI-Prolog bestaat al sinds 1987 (van Nederlandse bodem) en wordt hedendaags nog steeds
actief gebruikt en ontwikkeld. Ik heb via de officiële website SWI-Prolog geïnstalleerd. Om er nou daadwerkelijk gebruik van te maken,
raadpleegde ik het volgende Google zoekresultaat.

### Programming In Prolog Tutorial Series 
Ik kwam terecht op een Prolog Tutorial op Youtube (https://www.youtube.com/watch?v=gJOZZvYijqk). Deze tutorial is opgesplitst in
verschillende video's. Zo ging de ene video over logische elementen, zoals feiten en regels, en gingen andere regels over andere
bekende programmeerelementen, zoals variabelen en datatypen/lists. Mijn bevindingen van de taal licht ik verder toe.

## Prolog - Basis logica
Logica werkt met feiten en regels en daarop conclusies. Prolog werkt net zo. Laten we ons voorbeeld uit de inleiding gebruiken:  
Liam blijft binnen wanneer het regent.  
Het regent vandaag.  
Liam blijft vandaag binnen. 

### Feiten
Feiten zijn eenvoudig in Prolog te definiëren:
```
regen(vandaag).
regen(morgen).
```
Feiten zijn in dit geval eigenlijk een soort dataset. De syntax is ook eenvoudig: je definieert een feit met waarden tussen de haakjes,
en sluit af met een punt. De punt is vergelijkbaar met de puntkomma uit Java.

### Regels
Regels is een combinatie van andere regels en feiten. Een voorbeeld:  
```blijft_binnen(Dag) :- regen(Dag).```   
Een regel is als volgt te lezen: blijft_binnen, met een waarde Dag, geldt alleen als regen met als waarde Dag geldt.
De syntax lijkt erg op die van een feit, met enkele verschillen:  
:- is een if.   
Variabelen worden altijd aangegeven met een hoofdletter. "dag" zou dus geen goede variabele zijn.  

Nu lijkt deze regel vrij eenvoudig, omdat die gebaseerd is op een enkel feit. Maar we zouden de regel kunnen uitbreiden:  
Liam blijft binnen wanneer het regent of wanneer het koud is.  

In dat geval is de regel in code anders:
```
blijft_binnen(Dag) :-
  regen(Dag);
  koud(Dag).
```
In dit geval geeft de puntkomma een OF aan. Wanneer Liam een taaie is en pas binnen blijft als het zowel koud als nat is buiten, dan zou
er een komma gebruikt moeten worden voor EN.

### Queries
Vervolgens kunnen op de regels en feiten queries uitgevoerd worden. Met queries kunnen conclusies bevestigd worden, maar kunnen ook conclusies gevonden worden. Queries beginnen met een vraagteken.
```
?- regen(vandaag).
> true
% Dit is een bevestiging van een conclusie (en dit is overigens een in-line comment).  

?- regen(Dag).
> Dag = vandaag.
% Hier zoekt het programma zelf mogelijke conclusies.
```

## Prolog - Lists en recursie
### Lists
Prolog kent lists. Lists worden aangegeven via blokhaken. Lists zijn niet streng getypeerd zoals in Java, allerlei soorten datatypen
mogen in een list worden geplaatst. Elk element kan anders zijn: een string, een nummer of zelfs nog een list.  

Het ophalen van elementen uit een list in een rule, kan op verschillende manieren. Een typische manier van Prolog is via een head en een
tail. De head is standaard het eerste element uit de list, en de tail is de rest van de list. Dit gedrag is vergelijkbaar met een stack of queue, waarin ook enkel de uiterste elementen benaderbaar zijn.  

Als we bijvoorbeeld zouden bevestigen dat van een lijst dagen, het regent op de eerste dag, ziet dat er in code zo uit:
```
regen(maandag).
regen_op_eerste_dag_in_lijst([H|_]) :-
  regen(H).
?- regen_op_eerste_dag_in_lijst([maandag, woensdag, zaterdag]).
> true.
```
De onderscheid tussen head en tail wordt met de | gedaan. De underscore geeft aan dat er wel een tail is, maar dat we niet die tail
verder als variabele nodig hebben.

Om specifieke elementen te benaderen uit een list, gaat dat anders dan in bijvoorbeeld Java. Stel we willen kijken of het regent op de tweede dag:  
```
regen_op_tweede_dag_in_lijst([_,Dag2|_]) :-
  regen(H).
```
Om een specifiek element aan te roepen, moeten alle voorgaande elementen met komma's gescheiden worden. Dit vind ik erg vervelend wanneer er sprake is van grote lijsten. Het is volgens mij echter niet gebruikelijk dat hele specifieke elementen uit grote lijsten
geselecteerd moeten worden in logische programma's.

### Recursie
Als we willen bevestigen dat het regent op alle dagen in een lijst, moeten we elk element aflopen. In Java is het dan gebruikelijk om
een for-loop of een while-loop te gebruiken. Deze loops zijn echter in Prolog niet mogelijk. Om te kunnen loopen, maakt men gebruik van
recursie. Bij APP kennen we de volgende onderdelen van recursie, die ook terugkomen in Prolog:  
- Een base case: Wanneer de recursie moet afsluiten, om eindeloze loops te voorkomen.
- De recursieve functie: Die zichzelf aanroept, where the magic happens.

Een base case voor deze situatie zou zijn: wanneer de lijst leeg is. Base cases in Prolog worden niet binnen de recursieve regel gedefinieerd, maar als aparte fact.
```
regen_op_alle_dagen([]). % [] is een lege lijst
```
Voor de recursie, wordt de rule opnieuw aangeroepen, maar dan met de tail als waarde. Hierdoor wordt de head steeds weggehaald, totdat er geen element meer over is. Dit is vergelijkbaar met recursie op een stack.
```
regen_op_alle_dagen([]).
regen_op_alle_dagen(H|T) :-
  koud(H),
  regen_op_alle_dagen(T).
```
Op deze manier is het vrij eenvoudig om te itereren over een lijst.
UPDATE: Inmiddels heb ik een regel gevonden van SWI-Prolog, die daadwerkelijk WEL als een soort for-loop fungeert:
```
regen_op_alle_dagen(Lijst):-
  maplist(koud, Lijst).
```
maplist mapt elk element van een list een keer naar de parameter van de aangegeven regel of feit. 

## Toepassen in nonogram solver
Het werd tijd om mijn opgedane kennis over logica en prolog te gebruiken om mijn nonogram solver te implementeren.  
Als eerste stap, besloot ik om over regels na te denken, en over de representatie van de nonogram elementen. Hierbij kwam ik op de volgende resultaten:
- Vakjes worden gerepresenteerd in cijfers: 0 voor leeg, 1 voor gevuld.
- Een rij wordt gerepesenteerd als een list van cijfers/vakjes.
- Een nonogram veld wordt gerepresenteerd als een list van rijen.
- Clues (de hints aan het begin van rijen en kolommen) worden per rij gepresenteerd in een list.
- Een reeks (een reeks van aangesloten gevulde vakjes) is valide, als die even lang is als de clue.
- Een rij is valide, als alle reeksen voldoen aan hun clues.
- Een nonogram is valide, als alle rijen en kolommen valide zijn.

Om te beginnen, beschreef ik de rule voor het representeren van vakjes.
```
valide_element(Element) :-
    Element is 1 | Element is 0.

gevuld_vakje(Vakje) :-
    Vakje is 1.
```  
Vervolgens is een reeks valide, als die reeks even lang is als de waarde van de clue:
```
valide_reeks(Reeks, Clue):-
    length(Reeks, Clue),
    maplist(gevuld_vakje, Reeks).
```  
length is een ingebouwde regel binnen prolog. Uiteraard is het mogelijk om deze zelf te implementeren via recursie, dat gebeurt hier achter de schermen immers ook. Ik vond echter dat ik dan te veel bezig zou zijn met het wiel opnieuw proberen uit te vinden, in plaats van bezig te zijn met daadwerkelijk domein problemen op te lossen. Ik heb uit interesse wel de source code bekeken.

Voor het splitsen van reeksen uit een rij, heb ik de volgende regel gedefinieerd:  
```
splits_reeksen(Rij, Reeksen) :-
    split(Rij, 0, ReeksenMetLegen),
    delete(ReeksenMetLegen, [], Reeksen).
```  
De split en delete leken mij in eerste instantie iteratief, waardoor ik een soort naar onderbuikgevoel had. Echter, na kijken naar de broncode en naar uitgebreide documentie op "The Power of Prolog" (https://www.metalevel.at/prolog), ben ik van mening dat deze regels wel de principes van logisch programmeren toepassen. Het blijft immers een pure regel, doordat lists niet direct worden aangepast, maar worden gekopieerd. 

Om een hele rij te valideren, heb ik de volgende regel gedefinieerd:  
```
valide_rij(PuzzelGrootte, Rij, Clues) :-
    length(Rij, PuzzelGrootte),
    maplist(valide_element, Rij),
    splits_reeksen(Rij, Reeksen),
    maplist(valide_reeks, Reeksen, Clues).
```  
Met PuzzelGrootte zorgde ik ervoor dat ik de grootte van de puzzel variabel maakte, en dus niet vast zat aan een 5x5 puzzel.
Het valideren van de elementen is hier vooral nodig om het programma ook oplossingen zelf te kunnen laten genereren. Door vast te stellen dat een element 0 of 1 moet zijn, weet het programma dat die geen andere cijfers mag gebruiken.

Om alle rijen te valideren, heb ik een simpele regel gedefinieerd:  
```
valide_rijen(PuzzelGrootte, Rijen, Clues) :-
    maplist(valide_rij(PuzzelGrootte), Rijen, Clues).
```

En tot slot moest de daadwerkelijk nonogram opgelost kunnen worden. In bovengenoemde regels wordt er altijd gesproken over rijen, maar hoe zit het dan met de kolommen? De nonogram was immers een lijst van rijen.  
Om kolommen uit de nonogram te identificeren, bestaat er een transpose regel. Transpose voert een matrix rotatie uit. Hierdoor worden de kolommen heringedeeld als rijen. Hierdoor werd het eenvoudig om de nonogram solver af te ronden:
```
nonogram(PuzzelGrootte, HorizontaleClues, VerticaleClues,Rijen):-
    valide_rijen(PuzzelGrootte, Rijen, HorizontaleClues),
    transpose(Rijen, Kolommen),
    valide_rijen(PuzzelGrootte, Kolommen, VerticaleClues).
```

Alle code bij elkaar is te vinden in [nonogram-solver.pl](nonogram-solver.pl)
## Resultaat
