# nonogram-solver
## Introductie
Voor mijn studie ga ik een programmeertaal leren dat niet binnen de imperatieve of object georiënteerde programmeer paradigma's vallen. Ik heb gekozen voor Prolog van het logische paradigma. 

In deze README.md houd ik een blog bij met mijn leerproces van Prolog.

Het ultieme doel is om met mijn opgedane kennis van Prolog een nonogram solver te maken. 

## Nonogrammen

## Blog
### 07-02-2020
Vandaag ben ik begonnen met het leren van Prolog. Prolog is een programmeertaal volgens het logische programmeer paradigma.  
Logisch programmeren is gebaseerd op logica, waarin op basis van feiten en regels informatie kan worden gededuceerd. 

Een voorbeeld van logische redenering:  

Liam is geslaagd voor zijn studie als hij minimaal een 5.5 voor zijn toets haalt. (Regel)  
Liam heeft een 8 voor zijn toets. (Feit)  
DUS Liam is geslaagd voor zijn studie. (Gededuceerd vanuit bovenstaande feit en regel)  

Bovenstaand is een bevestiging dat Liam is geslaagd voor zijn studie. Met logica kan je naast bevestiging ook vragen voor welke waarden van het toetscijfer Liam kan slagen:

Liam is geslaagd voor zijn studie als hij mimimaal een 5.5 voor zijn toets haalt. (Regel)  
Om te slagen voor zijn studie, welke toetscijfers X zou Liam moeten halen?  
X = 5.5, X = 5.6 ... X = 10.0  

Hoewel dit een simpel voorbeeld is, kunnen met een grote hoeveelheid feiten en complexe regels interessante applicaties worden gebouwd. Zo kan logisch programmeren toegepast worden in bijvoorbeeld kunstmatige intelligentie.

Bovenstaand voorbeeld kan worden geprogrammeerd in Prolog. In Prolog bestanden worden feiten en regels gedefinieerd. Vervolgens kunnen vragen (query's) worden gesteld over deze feiten en regels in een Prolog compiler. Voor mijn leerproces gebruik ik SWIPL, een open-source versie van Prolog.

``` 
toetscijfer(liam, 8). /*liam heeft een 8 voor zijn toets*/ 
geslaagd(Student) :- 
toetscijfer(Student, Cijfer), Cijfer >= 5.5. /* Een Student is geslaagd als die Student een toetscijfer heeft,  
waarbij zijn Cijfer >= 5.5 is */
```

