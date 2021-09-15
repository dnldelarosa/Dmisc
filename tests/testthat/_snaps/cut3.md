# cut3

    Code
      cut3(tbl, var_name = "age", breaks = 2)
    Output
                 age freq
      1  (0.991,5.5]    5
      2  (0.991,5.5]    5
      3  (0.991,5.5]    5
      4  (0.991,5.5]    4
      5  (0.991,5.5]    3
      6     (5.5,10]    3
      7     (5.5,10]    5
      8     (5.5,10]    3
      9     (5.5,10]    4
      10    (5.5,10]    5

---

    Code
      cut3(tbl, var_name = "age", breaks = c(0, 5, 10))
    Output
            age freq
      1   (0,5]    5
      2   (0,5]    5
      3   (0,5]    5
      4   (0,5]    4
      5   (0,5]    3
      6  (5,10]    3
      7  (5,10]    5
      8  (5,10]    3
      9  (5,10]    4
      10 (5,10]    5

---

    Code
      cut3(tbl, var_name = "age", breaks = c(2, 5, 8))
    Output
           age freq
      1   <NA>    5
      2   <NA>    5
      3  (2,5]    5
      4  (2,5]    4
      5  (2,5]    3
      6  (5,8]    3
      7  (5,8]    5
      8  (5,8]    3
      9   <NA>    4
      10  <NA>    5

---

    Code
      cut3(tbl, var_name = "age", breaks = quantile, bf_args = list(x = tbl$age))
    Output
                age freq
      1        <NA>    5
      2    (1,3.25]    5
      3    (1,3.25]    5
      4  (3.25,5.5]    4
      5  (3.25,5.5]    3
      6  (5.5,7.75]    3
      7  (5.5,7.75]    5
      8   (7.75,10]    3
      9   (7.75,10]    4
      10  (7.75,10]    5

---

    Code
      cut3(tbl, var_name = "age", breaks = quantile, bf_args = list(x = tbl$age), include.lowest = T)
    Output
                age freq
      1    [1,3.25]    5
      2    [1,3.25]    5
      3    [1,3.25]    5
      4  (3.25,5.5]    4
      5  (3.25,5.5]    3
      6  (5.5,7.75]    3
      7  (5.5,7.75]    5
      8   (7.75,10]    3
      9   (7.75,10]    4
      10  (7.75,10]    5

---

    Code
      cut3(tbl, var_name = "age", breaks = c(0, quantile), bf_args = list(x = tbl$age))
    Output
                age freq
      1       (0,1]    5
      2    (1,3.25]    5
      3    (1,3.25]    5
      4  (3.25,5.5]    4
      5  (3.25,5.5]    3
      6  (5.5,7.75]    3
      7  (5.5,7.75]    5
      8   (7.75,10]    3
      9   (7.75,10]    4
      10  (7.75,10]    5

---

    Code
      cut3(tbl, var_name = "age", breaks = 2, labels = F)
    Output
         age freq
      1    1    5
      2    1    5
      3    1    5
      4    1    4
      5    1    3
      6    2    3
      7    2    5
      8    2    3
      9    2    4
      10   2    5

---

    Code
      cut3(tbl, var_name = "age", breaks = 2, labels = c("Menor o igual que 5", "Mayor a 5"))
    Output
                         age freq
      1  Menor o igual que 5    5
      2  Menor o igual que 5    5
      3  Menor o igual que 5    5
      4  Menor o igual que 5    4
      5  Menor o igual que 5    3
      6            Mayor a 5    3
      7            Mayor a 5    5
      8            Mayor a 5    3
      9            Mayor a 5    4
      10           Mayor a 5    5

---

    Code
      cut3(tbl, var_name = "age", breaks = 2, groups = "sex")
    Output
         age freq
      1    1    5
      2    2    5
      3    3    5
      4    4    4
      5    5    3
      6    6    3
      7    7    5
      8    8    3
      9    9    4
      10  10    5

