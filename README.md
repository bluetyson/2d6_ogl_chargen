CT_Character_Generator
======================

<<<<<<< HEAD
This provides mechanisms for creating "Classic Traveller" (LBB 1-8)
characters. It currently uses Ruby 1.8, SQLite3, and JSON. 
=======
This is the original version. It should remain stable unless
serious bugs are found. 

Ruby based NPC generator. It averages about 2 skills per term.
>>>>>>> 0361dc8c02cc8a6f557af7a8f90bfd4c71f6bafa

```
  ruby bin/Chargen.rb -h
  Usage: Chargen [options]
    -c career                        Career, defaults based on Soc
    -t terms                         Terms, defaults to range of 1-5
```
For example:
```
  ruby bin/Chargen.rb -c Navy -t 4
  Knight PO2 Marlin Underwood Male Age: 34 867A9B Navy: 4 
  Frizzed medium blond close cropped hair black skin 
  GunCbt-1 Leader-1 Blade-1 Carouse-1 Instruction-1 ShipTactics-1 
  Cash: 30000 HighPsg (1) TAS (1) 
```
RDoc files are in the doc directory. Architectures and assumptions are
in the docs directory. Probably need to clean that up. 

[Traveller](https://en.wikipedia.org/wiki/Traveller_(role-playing_game)) 
is a Role-Playing Game copyright [Far Future Enterprises](http://farfuture.net). 

This code is copyright [Leam Hall](https://github.com/LeamHall) and 
is open for free fair use.

The older code is available in the oldstable branch.
