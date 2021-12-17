# train-test-split tests

    Code
      str(tts)
    Output
      List of 3
       $ data :'data.frame':	54 obs. of  3 variables:
        ..$ breaks : num [1:54] 26 30 54 25 70 52 51 26 67 18 ...
        ..$ wool   : Factor w/ 2 levels "A","B": 1 1 1 1 1 1 1 1 1 1 ...
        ..$ tension: Factor w/ 3 levels "L","M","H": 1 1 1 1 1 1 1 1 1 2 ...
       $ train: int [1:43] 1 2 3 4 5 6 7 8 9 10 ...
       $ test : int [1:11] 44 45 46 47 48 49 50 51 52 53 ...

---

    Code
      train_split(tts)
    Output
         breaks wool tension
      1      26    A       L
      2      30    A       L
      3      54    A       L
      4      25    A       L
      5      70    A       L
      6      52    A       L
      7      51    A       L
      8      26    A       L
      9      67    A       L
      10     18    A       M
      11     21    A       M
      12     29    A       M
      13     17    A       M
      14     12    A       M
      15     18    A       M
      16     35    A       M
      17     30    A       M
      18     36    A       M
      19     36    A       H
      20     21    A       H
      21     24    A       H
      22     18    A       H
      23     10    A       H
      24     43    A       H
      25     28    A       H
      26     15    A       H
      27     26    A       H
      28     27    B       L
      29     14    B       L
      30     29    B       L
      31     19    B       L
      32     29    B       L
      33     31    B       L
      34     41    B       L
      35     20    B       L
      36     44    B       L
      37     42    B       M
      38     26    B       M
      39     19    B       M
      40     16    B       M
      41     39    B       M
      42     28    B       M
      43     21    B       M

---

    Code
      test_split(tts)
    Output
         breaks wool tension
      44     39    B       M
      45     29    B       M
      46     20    B       H
      47     21    B       H
      48     24    B       H
      49     17    B       H
      50     13    B       H
      51     15    B       H
      52     15    B       H
      53     16    B       H
      54     28    B       H

---

    Code
      valid_split(train_test_split(warpbreaks, valid_split = TRUE))
    Output
         breaks wool tension
      44     39    B       M
      45     29    B       M
      46     20    B       H
      47     21    B       H
      48     24    B       H
      49     17    B       H

