# Daily date tests

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = 1:12, day = 1:12,
      value = 100:111), year = 1, month = 2, day = 3)
    Output
               date value
      1  2021-01-01   100
      2  2021-02-02   101
      3  2021-03-03   102
      4  2021-04-04   103
      5  2021-05-05   104
      6  2021-06-06   105
      7  2021-07-07   106
      8  2021-08-08   107
      9  2021-09-09   108
      10 2021-10-10   109
      11 2021-11-11   110
      12 2021-12-12   111

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = month.name, day = 1:12,
      value = 100:111), year = 1, month = 2, day = 3)
    Output
               date value
      1  2021-01-01   100
      2  2021-02-02   101
      3  2021-03-03   102
      4  2021-04-04   103
      5  2021-05-05   104
      6  2021-06-06   105
      7  2021-07-07   106
      8  2021-08-08   107
      9  2021-09-09   108
      10 2021-10-10   109
      11 2021-11-11   110
      12 2021-12-12   111

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = month.abb, day = 1:12,
      value = 100:111), year = 1, month = 2, day = 3)
    Output
               date value
      1  2021-01-01   100
      2  2021-02-02   101
      3  2021-03-03   102
      4  2021-04-04   103
      5  2021-05-05   104
      6  2021-06-06   105
      7  2021-07-07   106
      8  2021-08-08   107
      9  2021-09-09   108
      10 2021-10-10   109
      11 2021-11-11   110
      12 2021-12-12   111

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = c("Enero", "Febrero",
        "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre",
        "Noviembre", "Diciembre"), day = 1:12, value = 100:111), year = 1, month = 2,
      day = 3)
    Output
               date value
      1  2021-01-01   100
      2  2021-02-02   101
      3  2021-03-03   102
      4  2021-04-04   103
      5  2021-05-05   104
      6  2021-06-06   105
      7  2021-07-07   106
      8  2021-08-08   107
      9  2021-09-09   108
      10 2021-10-10   109
      11 2021-11-11   110
      12 2021-12-12   111

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = c("Ene", "Feb", "Mar",
        "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"), day = 1:12,
      value = 100:111), year = 1, month = 2, day = 3)
    Output
               date value
      1  2021-01-01   100
      2  2021-02-02   101
      3  2021-03-03   102
      4  2021-04-04   103
      5  2021-05-05   104
      6  2021-06-06   105
      7  2021-07-07   106
      8  2021-08-08   107
      9  2021-09-09   108
      10 2021-10-10   109
      11 2021-11-11   110
      12 2021-12-12   111

---

    Code
      vars_to_date(data.frame(anio = rep("2021", 12), mes = month.abb, dia = 1:12,
      value = 100:111), year = "anio", month = "mes", day = "dia")
    Output
               date value
      1  2021-01-01   100
      2  2021-02-02   101
      3  2021-03-03   102
      4  2021-04-04   103
      5  2021-05-05   104
      6  2021-06-06   105
      7  2021-07-07   106
      8  2021-08-08   107
      9  2021-09-09   108
      10 2021-10-10   109
      11 2021-11-11   110
      12 2021-12-12   111

---

    Code
      vars_to_date(data.frame(anio = rep("2021", 12), mes = month.abb, dia = 1:12,
      value = 100:111), year = 1, month = 2, day = 3)
    Output
               date value
      1  2021-01-01   100
      2  2021-02-02   101
      3  2021-03-03   102
      4  2021-04-04   103
      5  2021-05-05   104
      6  2021-06-06   105
      7  2021-07-07   106
      8  2021-08-08   107
      9  2021-09-09   108
      10 2021-10-10   109
      11 2021-11-11   110
      12 2021-12-12   111

# Monthly date tests

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = 1:12, value = 100:111),
      year = 1, month = 2)
    Output
         value       date
      1    100 2021-01-31
      2    101 2021-02-28
      3    102 2021-03-31
      4    103 2021-04-30
      5    104 2021-05-31
      6    105 2021-06-30
      7    106 2021-07-31
      8    107 2021-08-31
      9    108 2021-09-30
      10   109 2021-10-31
      11   110 2021-11-30
      12   111 2021-12-31

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = month.name, value = 100:
        111), year = 1, month = 2)
    Output
         value       date
      1    100 2021-01-31
      2    101 2021-02-28
      3    102 2021-03-31
      4    103 2021-04-30
      5    104 2021-05-31
      6    105 2021-06-30
      7    106 2021-07-31
      8    107 2021-08-31
      9    108 2021-09-30
      10   109 2021-10-31
      11   110 2021-11-30
      12   111 2021-12-31

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = month.abb, value = 100:
        111), year = 1, month = 2)
    Output
         value       date
      1    100 2021-01-31
      2    101 2021-02-28
      3    102 2021-03-31
      4    103 2021-04-30
      5    104 2021-05-31
      6    105 2021-06-30
      7    106 2021-07-31
      8    107 2021-08-31
      9    108 2021-09-30
      10   109 2021-10-31
      11   110 2021-11-30
      12   111 2021-12-31

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = c("Enero", "Febrero",
        "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre",
        "Noviembre", "Diciembre"), value = 100:111), year = 1, month = 2)
    Output
         value       date
      1    100 2021-01-31
      2    101 2021-02-28
      3    102 2021-03-31
      4    103 2021-04-30
      5    104 2021-05-31
      6    105 2021-06-30
      7    106 2021-07-31
      8    107 2021-08-31
      9    108 2021-09-30
      10   109 2021-10-31
      11   110 2021-11-30
      12   111 2021-12-31

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = c("Ene", "Feb", "Mar",
        "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"), value = 100:
        111), year = 1, month = 2)
    Output
         value       date
      1    100 2021-01-31
      2    101 2021-02-28
      3    102 2021-03-31
      4    103 2021-04-30
      5    104 2021-05-31
      6    105 2021-06-30
      7    106 2021-07-31
      8    107 2021-08-31
      9    108 2021-09-30
      10   109 2021-10-31
      11   110 2021-11-30
      12   111 2021-12-31

---

    Code
      vars_to_date(data.frame(anio = rep("2021", 12), mes = month.abb, value = 100:
      111), year = "anio", month = "mes")
    Output
         value       date
      1    100 2021-01-31
      2    101 2021-02-28
      3    102 2021-03-31
      4    103 2021-04-30
      5    104 2021-05-31
      6    105 2021-06-30
      7    106 2021-07-31
      8    107 2021-08-31
      9    108 2021-09-30
      10   109 2021-10-31
      11   110 2021-11-30
      12   111 2021-12-31

---

    Code
      vars_to_date(data.frame(anio = rep("2021", 12), mes = month.abb, value = 100:
      111), year = 1, month = 2)
    Output
         value       date
      1    100 2021-01-31
      2    101 2021-02-28
      3    102 2021-03-31
      4    103 2021-04-30
      5    104 2021-05-31
      6    105 2021-06-30
      7    106 2021-07-31
      8    107 2021-08-31
      9    108 2021-09-30
      10   109 2021-10-31
      11   110 2021-11-30
      12   111 2021-12-31

# Quarter date tests

    Code
      vars_to_date(data.frame(year = rep("2021", 4), quarter = c(1, 2, 3, 4), value = 100:
        103), year = 1, quarter = 2)
    Output
        value       date
      1   100 2021-03-31
      2   101 2021-06-30
      3   102 2021-09-30
      4   103 2021-12-31

---

    Code
      vars_to_date(data.frame(year = rep("2021", 4), quarter = c("Q1", "Q2", "Q3",
        "Q4"), value = 100:103), year = 1, quarter = 2)
    Output
        value       date
      1   100 2021-03-31
      2   101 2021-06-30
      3   102 2021-09-30
      4   103 2021-12-31

---

    Code
      vars_to_date(data.frame(year = rep("2021", 4), quarter = c("T1", "T2", "T3",
        "T4"), value = 100:103), year = 1, quarter = 2)
    Output
        value       date
      1   100 2021-03-31
      2   101 2021-06-30
      3   102 2021-09-30
      4   103 2021-12-31

---

    Code
      vars_to_date(data.frame(year = rep("2021", 98), quarter = c("e-m", "E-M",
        "ene-mar", "Ene-Mar", "enero-marzo", "Enero-Marzo", "ENERO-MARZO", "j-m",
        "J-M", "jan-mar", "Jan-Mar", "january-march", "January-March",
        "JANUARY-MARCH", "e-j", "E-J", "ene-jun", "Ene-Jun", "enero-junio",
        "Enero-Junio", "ENERO-JUNIO", "j-j", "J-J", "jan-jun", "Jan-Jun",
        "january-june", "January-June", "JANUARY-JUNE", "e-s", "E-s", "ene-sep",
        "Ene-Sep", "enero-septiembre", "Enero-Septiembre", "ENERO-SEPTIEMBRE", "j-s",
        "J-S", "jan-sep", "Jan-Sep", "january-september", "January-September",
        "JANUARY-SEPTEMBER", "e-d", "E-D", "ene-dic", "Ene-Dic", "enero-diciembre",
        "Enero-Diciembre", "ENERO-DICIEMBRE", "j-d", "J-D", "jan-dec", "Jan-Dec",
        "january-december", "January-Decemberr", "JANUARY-DECEMBER", "a-j", "A-J",
        "abr-jun", "Abr-Jun", "abril-junio", "Abril-Junio", "ABRIL-JUNIO", "a-j",
        "A-J", "apr-jun", "Apr-Jun", "april-june", "April-June", "APRIL-JUNE", "j-s",
        "J-s", "jul-sep", "Jul-Sep", "julio-septiembre", "Julio-Septiembre",
        "JULIO-SEPTIEMBRE", "j-s", "J-S", "jul-sep", "Jul-Sep", "july-september",
        "July-September", "JULY-SEPTEMBER", "o-d", "O-D", "oct-dic", "Oct-Dic",
        "octubre-diciembre", "Octubre-Diciembre", "OCTUBRE-DICIEMBRE", "o-d", "O-D",
        "oct-dec", "Oct-Dec", "october-december", "October-Decemberr",
        "OCTOBER-DECEMBER"), value = 100:197), year = 1, quarter = 2)
    Output
         value       date
      1    100 2021-03-31
      2    101 2021-03-31
      3    102 2021-03-31
      4    103 2021-03-31
      5    104 2021-03-31
      6    105 2021-03-31
      7    106 2021-03-31
      8    107 2021-03-31
      9    108 2021-03-31
      10   109 2021-03-31
      11   110 2021-03-31
      12   111 2021-03-31
      13   112 2021-03-31
      14   113 2021-03-31
      15   114 2021-06-30
      16   115 2021-06-30
      17   116 2021-06-30
      18   117 2021-06-30
      19   118 2021-06-30
      20   119 2021-06-30
      21   120 2021-06-30
      22   121 2021-06-30
      23   122 2021-06-30
      24   123 2021-06-30
      25   124 2021-06-30
      26   125 2021-06-30
      27   126 2021-06-30
      28   127 2021-06-30
      29   128 2021-09-30
      30   129 2021-09-30
      31   130 2021-09-30
      32   131 2021-09-30
      33   132 2021-09-30
      34   133 2021-09-30
      35   134 2021-09-30
      36   135 2021-09-30
      37   136 2021-09-30
      38   137 2021-09-30
      39   138 2021-09-30
      40   139 2021-09-30
      41   140 2021-09-30
      42   141 2021-09-30
      43   142 2021-12-31
      44   143 2021-12-31
      45   144 2021-12-31
      46   145 2021-12-31
      47   146 2021-12-31
      48   147 2021-12-31
      49   148 2021-12-31
      50   149 2021-12-31
      51   150 2021-12-31
      52   151 2021-12-31
      53   152 2021-12-31
      54   153 2021-12-31
      55   154 2021-12-31
      56   155 2021-12-31
      57   156 2021-06-30
      58   157 2021-06-30
      59   158 2021-06-30
      60   159 2021-06-30
      61   160 2021-06-30
      62   161 2021-06-30
      63   162 2021-06-30
      64   163 2021-06-30
      65   164 2021-06-30
      66   165 2021-06-30
      67   166 2021-06-30
      68   167 2021-06-30
      69   168 2021-06-30
      70   169 2021-06-30
      71   170 2021-09-30
      72   171 2021-09-30
      73   172 2021-09-30
      74   173 2021-09-30
      75   174 2021-09-30
      76   175 2021-09-30
      77   176 2021-09-30
      78   177 2021-09-30
      79   178 2021-09-30
      80   179 2021-09-30
      81   180 2021-09-30
      82   181 2021-09-30
      83   182 2021-09-30
      84   183 2021-09-30
      85   184 2021-12-31
      86   185 2021-12-31
      87   186 2021-12-31
      88   187 2021-12-31
      89   188 2021-12-31
      90   189 2021-12-31
      91   190 2021-12-31
      92   191 2021-12-31
      93   192 2021-12-31
      94   193 2021-12-31
      95   194 2021-12-31
      96   195 2021-12-31
      97   196 2021-12-31
      98   197 2021-12-31

