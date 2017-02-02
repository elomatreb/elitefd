# EliteFD.rb

Small Ruby utility script that scans your Elite: Dangerous journal files for
first discoviers and summarises them.

## Usage

`$ ./elitefd.rb <path_to_dir_containing_logs>`

## Example

Given the journals from one of my recent exploration trips:

```
$ ./elitefd.rb path_to_my_logs/
Scanning 137 log files in '[REDACTED]' for first discoveries.
Parsing log 137/137... done.

-> Found 4587 scanned or sold bodies,
   out of which 3042 are first discoveries (66.32%).

 Type                              | Scanned | First | FD %  
-----------------------------------+---------+-------+-------
                                 M |    1383 |   939 |  67.9%
                                 K |     637 |   484 | 75.98%
           High metal content body |     432 |   276 | 63.89%
                                 F |     232 |   165 | 71.12%
                                 N |     225 |    77 | 34.22%
                                 G |     218 |   168 | 77.06%
                       Water world |     188 |   140 | 74.47%
                                 L |     160 |   111 | 69.38%
        Sudarsky class I gas giant |     136 |    94 | 69.12%
                                 A |     132 |    92 |  69.7%
      Sudarsky class III gas giant |     112 |    81 | 72.32%
                                 B |     106 |    35 | 33.02%
                                 H |      97 |    43 | 44.33%
                                 T |      73 |    55 | 75.34%
   Gas giant with water based life |      69 |    48 | 69.57%
                               TTS |      56 |    19 | 33.93%
       Sudarsky class II gas giant |      45 |    34 | 75.56%
                        Rocky body |      38 |    27 | 71.05%
                                 Y |      36 |    19 | 52.78%
                                 O |      24 |     4 | 16.67%
                   Metal rich body |      23 |    16 | 69.57%
                    Earthlike body |      21 |    17 | 80.95%
                     Ammonia world |      20 |    20 | 100.0%
 Gas giant with ammonia based life |      18 |    14 | 77.78%
                          Icy body |      18 |    10 | 55.56%
                    Rocky ice body |      17 |    12 | 70.59%
       Sudarsky class IV gas giant |      16 |     8 |  50.0%
                              AeBe |      12 |     3 |  25.0%
                                DA |      10 |    10 | 100.0%
        Sudarsky class V gas giant |       5 |     2 |  40.0%
                                CN |       4 |     4 | 100.0%
                                DC |       4 |     4 | 100.0%
                               DAB |       3 |     3 | 100.0%
                                 S |       3 |     3 | 100.0%
                                 C |       3 |     0 |   0.0%
                     K_OrangeGiant |       2 |     0 |   0.0%
                        M_RedGiant |       2 |     1 |  50.0%
                                MS |       2 |     2 | 100.0%
                                 W |       2 |     0 |   0.0%
                         (Unknown) |       1 |     1 | 100.0%
                                DB |       1 |     1 | 100.0%
             SupermassiveBlackHole |       1 |     0 |   0.0%
```

## Types

The type names are used like they occur in the journal files.

The special type `(Unknown)` is used for bodies that were sold as cartographic
data and were first discoveries, but did not have an associated scan in the
journal.
