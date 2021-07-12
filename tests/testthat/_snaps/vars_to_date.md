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
               date value
      1  2021-01-31   100
      2  2021-02-28   101
      3  2021-03-31   102
      4  2021-04-30   103
      5  2021-05-31   104
      6  2021-06-30   105
      7  2021-07-31   106
      8  2021-08-31   107
      9  2021-09-30   108
      10 2021-10-31   109
      11 2021-11-30   110
      12 2021-12-31   111

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = month.name, value = 100:
        111), year = 1, month = 2)
    Output
               date value
      1  2021-01-31   100
      2  2021-02-28   101
      3  2021-03-31   102
      4  2021-04-30   103
      5  2021-05-31   104
      6  2021-06-30   105
      7  2021-07-31   106
      8  2021-08-31   107
      9  2021-09-30   108
      10 2021-10-31   109
      11 2021-11-30   110
      12 2021-12-31   111

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = month.abb, value = 100:
        111), year = 1, month = 2)
    Output
               date value
      1  2021-01-31   100
      2  2021-02-28   101
      3  2021-03-31   102
      4  2021-04-30   103
      5  2021-05-31   104
      6  2021-06-30   105
      7  2021-07-31   106
      8  2021-08-31   107
      9  2021-09-30   108
      10 2021-10-31   109
      11 2021-11-30   110
      12 2021-12-31   111

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = c("Enero", "Febrero",
        "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre",
        "Noviembre", "Diciembre"), value = 100:111), year = 1, month = 2)
    Output
               date value
      1  2021-01-31   100
      2  2021-02-28   101
      3  2021-03-31   102
      4  2021-04-30   103
      5  2021-05-31   104
      6  2021-06-30   105
      7  2021-07-31   106
      8  2021-08-31   107
      9  2021-09-30   108
      10 2021-10-31   109
      11 2021-11-30   110
      12 2021-12-31   111

---

    Code
      vars_to_date(data.frame(year = rep("2021", 12), month = c("Ene", "Feb", "Mar",
        "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"), value = 100:
        111), year = 1, month = 2)
    Output
               date value
      1  2021-01-31   100
      2  2021-02-28   101
      3  2021-03-31   102
      4  2021-04-30   103
      5  2021-05-31   104
      6  2021-06-30   105
      7  2021-07-31   106
      8  2021-08-31   107
      9  2021-09-30   108
      10 2021-10-31   109
      11 2021-11-30   110
      12 2021-12-31   111

---

    Code
      vars_to_date(data.frame(anio = rep("2021", 12), mes = month.abb, value = 100:
      111), year = "anio", month = "mes")
    Output
               date value
      1  2021-01-31   100
      2  2021-02-28   101
      3  2021-03-31   102
      4  2021-04-30   103
      5  2021-05-31   104
      6  2021-06-30   105
      7  2021-07-31   106
      8  2021-08-31   107
      9  2021-09-30   108
      10 2021-10-31   109
      11 2021-11-30   110
      12 2021-12-31   111

---

    Code
      vars_to_date(data.frame(anio = rep("2021", 12), mes = month.abb, value = 100:
      111), year = 1, month = 2)
    Output
               date value
      1  2021-01-31   100
      2  2021-02-28   101
      3  2021-03-31   102
      4  2021-04-30   103
      5  2021-05-31   104
      6  2021-06-30   105
      7  2021-07-31   106
      8  2021-08-31   107
      9  2021-09-30   108
      10 2021-10-31   109
      11 2021-11-30   110
      12 2021-12-31   111

# Quarter date tests

    Code
      vars_to_date(data.frame(year = rep("2021", 4), quarter = c(1, 2, 3, 4), value = 100:
        103), year = 1, quarter = 2)
    Output
              date value
      1 2021-03-31   100
      2 2021-06-30   101
      3 2021-09-30   102
      4 2021-12-31   103

---

    Code
      vars_to_date(data.frame(year = rep("2021", 4), quarter = c("Q1", "Q2", "Q3",
        "Q4"), value = 100:103), year = 1, quarter = 2)
    Output
              date value
      1 2021-03-31   100
      2 2021-06-30   101
      3 2021-09-30   102
      4 2021-12-31   103

---

    Code
      vars_to_date(data.frame(year = rep("2021", 4), quarter = c("T1", "T2", "T3",
        "T4"), value = 100:103), year = 1, quarter = 2)
    Output
              date value
      1 2021-03-31   100
      2 2021-06-30   101
      3 2021-09-30   102
      4 2021-12-31   103

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
               date value
      1  2021-03-31   100
      2  2021-03-31   101
      3  2021-03-31   102
      4  2021-03-31   103
      5  2021-03-31   104
      6  2021-03-31   105
      7  2021-03-31   106
      8  2021-03-31   107
      9  2021-03-31   108
      10 2021-03-31   109
      11 2021-03-31   110
      12 2021-03-31   111
      13 2021-03-31   112
      14 2021-03-31   113
      15 2021-06-30   114
      16 2021-06-30   115
      17 2021-06-30   116
      18 2021-06-30   117
      19 2021-06-30   118
      20 2021-06-30   119
      21 2021-06-30   120
      22 2021-06-30   121
      23 2021-06-30   122
      24 2021-06-30   123
      25 2021-06-30   124
      26 2021-06-30   125
      27 2021-06-30   126
      28 2021-06-30   127
      29 2021-09-30   128
      30 2021-09-30   129
      31 2021-09-30   130
      32 2021-09-30   131
      33 2021-09-30   132
      34 2021-09-30   133
      35 2021-09-30   134
      36 2021-09-30   135
      37 2021-09-30   136
      38 2021-09-30   137
      39 2021-09-30   138
      40 2021-09-30   139
      41 2021-09-30   140
      42 2021-09-30   141
      43 2021-12-31   142
      44 2021-12-31   143
      45 2021-12-31   144
      46 2021-12-31   145
      47 2021-12-31   146
      48 2021-12-31   147
      49 2021-12-31   148
      50 2021-12-31   149
      51 2021-12-31   150
      52 2021-12-31   151
      53 2021-12-31   152
      54 2021-12-31   153
      55 2021-12-31   154
      56 2021-12-31   155
      57 2021-06-30   156
      58 2021-06-30   157
      59 2021-06-30   158
      60 2021-06-30   159
      61 2021-06-30   160
      62 2021-06-30   161
      63 2021-06-30   162
      64 2021-06-30   163
      65 2021-06-30   164
      66 2021-06-30   165
      67 2021-06-30   166
      68 2021-06-30   167
      69 2021-06-30   168
      70 2021-06-30   169
      71 2021-09-30   170
      72 2021-09-30   171
      73 2021-09-30   172
      74 2021-09-30   173
      75 2021-09-30   174
      76 2021-09-30   175
      77 2021-09-30   176
      78 2021-09-30   177
      79 2021-09-30   178
      80 2021-09-30   179
      81 2021-09-30   180
      82 2021-09-30   181
      83 2021-09-30   182
      84 2021-09-30   183
      85 2021-12-31   184
      86 2021-12-31   185
      87 2021-12-31   186
      88 2021-12-31   187
      89 2021-12-31   188
      90 2021-12-31   189
      91 2021-12-31   190
      92 2021-12-31   191
      93 2021-12-31   192
      94 2021-12-31   193
      95 2021-12-31   194
      96 2021-12-31   195
      97 2021-12-31   196
      98 2021-12-31   197

