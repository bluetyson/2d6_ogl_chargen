2d6 OGL Character_Generator
===========================

This provides mechanisms for creating 2d6 OGL based characters. 
It currently uses Ruby and SQLite3, though the latter will go away soon.
Some of the code in the "toys" section uses MongoDB.

```
  ruby -Ilib bin/chargen.rb -h
  Usage: chargen [options]
    -c career                        Career, defaults based on Soc
                   Can be used more than once for multiple careers.
    -t terms                         Terms, defaults to range of 1-5
    -b                               Create a basic character
```
For example:
```
  Marquesa PO2 Addie Potter F Age: 34 64458D Navy: 4 Noble: 1 
  Curly medium auburn waist length hair, medium skin 
  Temperament: Provider   Plot: Obstacles to love (2) 
  Traits: Adaptable, Antisocial
  Leader-1 Vehicle-1 Eng-1 Carouse-1 GunCbt-1 Carousing-1 Medical-1 
  Cash: 118909
```
RDoc files are in the doc directory. Architectures and assumptions are
in the docs directory. Probably need to clean that up. 

Many of the original ideas came from Traveller (tm) and Cepheus Engine (tm).
[Traveller](https://en.wikipedia.org/wiki/Traveller_(role-playing_game)) 
is a Role-Playing Game copyright [Far Future Enterprises](http://farfuture.net). 
Cepheus Engine is released under the OGL. The name is copyrgiht Jason "Flynn" Kemp and Samardan Press.

This code is copyright [Leam Hall](https://github.com/LeamHall) and 
is open for free fair use.

The older code is available in the oldstable branch.
