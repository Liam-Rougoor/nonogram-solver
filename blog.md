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

### Recursie

