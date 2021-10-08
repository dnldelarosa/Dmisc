# describe

    Code
      describe(mtcars[[1]])
    Output
      [1] 10.40 15.42 19.20 20.09 22.80 33.90

---

    Code
      describe(mtcars, digits = 2)
    Output
              mpg cyl disp  hp drat  wt qsec   vs   am gear carb
      Min.     10 4.0   71  52  2.8 1.5   14 0.00 0.00  3.0  1.0
      1st Qu.  15 4.0  120  96  3.1 2.6   17 0.00 0.00  3.0  2.0
      Median   19 6.0  200 120  3.7 3.3   18 0.00 0.00  4.0  2.0
      Mean     20 6.2  230 150  3.6 3.2   18 0.44 0.41  3.7  2.8
      3rd Qu.  23 8.0  330 180  3.9 3.6   19 1.00 1.00  4.0  4.0
      Max.     34 8.0  470 340  4.9 5.4   23 1.00 1.00  5.0  8.0

---

    Code
      describe(mtcars, digits = 2, t = F)
    Output
           Min. 1st Qu. Median   Mean 3rd Qu.  Max.
      mpg  10.0    15.0   19.0  20.00    23.0  34.0
      cyl   4.0     4.0    6.0   6.20     8.0   8.0
      disp 71.0   120.0  200.0 230.00   330.0 470.0
      hp   52.0    96.0  120.0 150.00   180.0 340.0
      drat  2.8     3.1    3.7   3.60     3.9   4.9
      wt    1.5     2.6    3.3   3.20     3.6   5.4
      qsec 14.0    17.0   18.0  18.00    19.0  23.0
      vs    0.0     0.0    0.0   0.44     1.0   1.0
      am    0.0     0.0    0.0   0.41     1.0   1.0
      gear  3.0     3.0    4.0   3.70     4.0   5.0
      carb  1.0     2.0    2.0   2.80     4.0   8.0

---

    Code
      describe(mtcars, digits = 2, t = F, flextable = T)
    Output
      a flextable object.
      col_keys: ` `, `Min.`, `1st Qu.`, `Median`, `Mean`, `3rd Qu.`, `Max.` 
      header has 1 row(s) 
      body has 11 row(s) 
      original dataset sample: 
             Min. 1st Qu. Median  Mean 3rd Qu.  Max.
      1  mpg 10.0    15.0   19.0  20.0    23.0  34.0
      2  cyl  4.0     4.0    6.0   6.2     8.0   8.0
      3 disp 71.0   120.0  200.0 230.0   330.0 470.0
      4   hp 52.0    96.0  120.0 150.0   180.0 340.0
      5 drat  2.8     3.1    3.7   3.6     3.9   4.9

---

    Code
      describe(mtcars, digits = 2, t = F, flextable = T, ft_args = list(cwidth = 2))
    Output
      a flextable object.
      col_keys: ` `, `Min.`, `1st Qu.`, `Median`, `Mean`, `3rd Qu.`, `Max.` 
      header has 1 row(s) 
      body has 11 row(s) 
      original dataset sample: 
             Min. 1st Qu. Median  Mean 3rd Qu.  Max.
      1  mpg 10.0    15.0   19.0  20.0    23.0  34.0
      2  cyl  4.0     4.0    6.0   6.2     8.0   8.0
      3 disp 71.0   120.0  200.0 230.0   330.0 470.0
      4   hp 52.0    96.0  120.0 150.0   180.0 340.0
      5 drat  2.8     3.1    3.7   3.6     3.9   4.9

---

    Code
      describe(mtcars, digits = 2, t = F, flextable = T, ft_args = list(cwidth = 2),
      maxsum = 2)
    Output
      a flextable object.
      col_keys: ` `, `Min.`, `1st Qu.`, `Median`, `Mean`, `3rd Qu.`, `Max.` 
      header has 1 row(s) 
      body has 11 row(s) 
      original dataset sample: 
             Min. 1st Qu. Median  Mean 3rd Qu.  Max.
      1  mpg 10.0    15.0   19.0  20.0    23.0  34.0
      2  cyl  4.0     4.0    6.0   6.2     8.0   8.0
      3 disp 71.0   120.0  200.0 230.0   330.0 470.0
      4   hp 52.0    96.0  120.0 150.0   180.0 340.0
      5 drat  2.8     3.1    3.7   3.6     3.9   4.9

