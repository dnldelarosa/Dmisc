# cut3

    Code
      cut3(tbl, var_name = "age", breaks = 2)
    Output
                 age freq sex
      1  (0.991,5.5]    5   F
      2  (0.991,5.5]    5   F
      3  (0.991,5.5]    5   F
      4  (0.991,5.5]    4   F
      5  (0.991,5.5]    3   F
      6     (5.5,10]    3   M
      7     (5.5,10]    5   M
      8     (5.5,10]    3   M
      9     (5.5,10]    4   M
      10    (5.5,10]    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = c(0, 5, 10))
    Output
            age freq sex
      1   (0,5]    5   F
      2   (0,5]    5   F
      3   (0,5]    5   F
      4   (0,5]    4   F
      5   (0,5]    3   F
      6  (5,10]    3   M
      7  (5,10]    5   M
      8  (5,10]    3   M
      9  (5,10]    4   M
      10 (5,10]    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = c(2, 5, 8))
    Output
           age freq sex
      1   <NA>    5   F
      2   <NA>    5   F
      3  (2,5]    5   F
      4  (2,5]    4   F
      5  (2,5]    3   F
      6  (5,8]    3   M
      7  (5,8]    5   M
      8  (5,8]    3   M
      9   <NA>    4   M
      10  <NA>    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = stats::quantile)
    Output
                age freq sex
      1        <NA>    5   F
      2    (1,3.25]    5   F
      3    (1,3.25]    5   F
      4  (3.25,5.5]    4   F
      5  (3.25,5.5]    3   F
      6  (5.5,7.75]    3   M
      7  (5.5,7.75]    5   M
      8   (7.75,10]    3   M
      9   (7.75,10]    4   M
      10  (7.75,10]    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = stats::quantile, include.lowest = T)
    Output
                age freq sex
      1    [1,3.25]    5   F
      2    [1,3.25]    5   F
      3    [1,3.25]    5   F
      4  (3.25,5.5]    4   F
      5  (3.25,5.5]    3   F
      6  (5.5,7.75]    3   M
      7  (5.5,7.75]    5   M
      8   (7.75,10]    3   M
      9   (7.75,10]    4   M
      10  (7.75,10]    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = c(0, stats::quantile(tbl$age)))
    Output
                age freq sex
      1       (0,1]    5   F
      2    (1,3.25]    5   F
      3    (1,3.25]    5   F
      4  (3.25,5.5]    4   F
      5  (3.25,5.5]    3   F
      6  (5.5,7.75]    3   M
      7  (5.5,7.75]    5   M
      8   (7.75,10]    3   M
      9   (7.75,10]    4   M
      10  (7.75,10]    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = 2, labels = FALSE)
    Output
         age freq sex
      1    1    5   F
      2    1    5   F
      3    1    5   F
      4    1    4   F
      5    1    3   F
      6    2    3   M
      7    2    5   M
      8    2    3   M
      9    2    4   M
      10   2    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = 2, labels = c("Menor o igual que 5",
        "Mayor a 5"))
    Output
                         age freq sex
      1  Menor o igual que 5    5   F
      2  Menor o igual que 5    5   F
      3  Menor o igual que 5    5   F
      4  Menor o igual que 5    4   F
      5  Menor o igual que 5    3   F
      6            Mayor a 5    3   M
      7            Mayor a 5    5   M
      8            Mayor a 5    3   M
      9            Mayor a 5    4   M
      10           Mayor a 5    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = 2, groups = "sex")
    Output
      # A tibble: 10 × 3
         age        freq sex  
         <fct>     <dbl> <chr>
       1 (0.996,3]     5 F    
       2 (0.996,3]     5 F    
       3 (0.996,3]     5 F    
       4 (3,5]         4 F    
       5 (3,5]         3 F    
       6 (6,8]         3 M    
       7 (6,8]         5 M    
       8 (6,8]         3 M    
       9 (8,10]        4 M    
      10 (8,10]        5 M    

---

    Code
      cut3(tbl, var_name = "age", breaks = 2, labels = c("low", "high"))
    Output
          age freq sex
      1   low    5   F
      2   low    5   F
      3   low    5   F
      4   low    4   F
      5   low    3   F
      6  high    3   M
      7  high    5   M
      8  high    3   M
      9  high    4   M
      10 high    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = stats::quantile, probs = c(0.3, 0.7))
    Output
                age freq sex
      1        <NA>    5   F
      2    (1,3.25]    5   F
      3    (1,3.25]    5   F
      4  (3.25,5.5]    4   F
      5  (3.25,5.5]    3   F
      6  (5.5,7.75]    3   M
      7  (5.5,7.75]    5   M
      8   (7.75,10]    3   M
      9   (7.75,10]    4   M
      10  (7.75,10]    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = function(x) {
        quantile(x, probs = c(0.3, 0.7))
      })
    Output
               age freq sex
      1       <NA>    5   F
      2       <NA>    5   F
      3       <NA>    5   F
      4  (3.7,7.3]    4   F
      5  (3.7,7.3]    3   F
      6  (3.7,7.3]    3   M
      7  (3.7,7.3]    5   M
      8       <NA>    3   M
      9       <NA>    4   M
      10      <NA>    5   M

---

    Code
      cut3(tbl, var_name = "age", breaks = 2, groups = "sex")
    Output
      # A tibble: 10 × 3
         age        freq sex  
         <fct>     <dbl> <chr>
       1 (0.996,3]     5 F    
       2 (0.996,3]     5 F    
       3 (0.996,3]     5 F    
       4 (3,5]         4 F    
       5 (3,5]         3 F    
       6 (6,8]         3 M    
       7 (6,8]         5 M    
       8 (6,8]         3 M    
       9 (8,10]        4 M    
      10 (8,10]        5 M    

