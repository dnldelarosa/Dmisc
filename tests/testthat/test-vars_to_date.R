test_that("Daily date tests", {
  local_edition(3)
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = 1:12,
    day = 1:12,
    value = 100:111
  ),
  year = 1,
  month = 2,
  day = 3))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = month.name,
    day = 1:12,
    value = 100:111
  ),
  year = 1,
  month = 2,
  day = 3))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = month.abb,
    day = 1:12,
    value = 100:111
  ),
  year = 1,
  month = 2,
  day = 3))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"),
    day = 1:12,
    value = 100:111
  ),
  year = 1,
  month = 2,
  day = 3))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = c("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"),
    day = 1:12,
    value = 100:111
  ),
  year = 1,
  month = 2,
  day = 3))
  expect_snapshot(vars_to_date(data.frame(
    anio = rep("2021", 12),
    mes = month.abb,
    dia = 1:12,
    value = 100:111
  ),
  year = "anio",
  month = "mes",
  day = "dia"))
  expect_snapshot(vars_to_date(data.frame(
    anio = rep("2021", 12),
    mes = month.abb,
    dia = 1:12,
    value = 100:111
  ),
  year = 1,
  month = 2,
  day = 3))
})



test_that("Monthly date tests", {
  local_edition(3)
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = 1:12,
    value = 100:111
  ),
  year = 1,
  month = 2))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = month.name,
    value = 100:111
  ),
  year = 1,
  month = 2))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = month.abb,
    value = 100:111
  ),
  year = 1,
  month = 2))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"),
    value = 100:111
  ),
  year = 1,
  month = 2))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = c("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"),
    value = 100:111
  ),
  year = 1,
  month = 2))
  expect_snapshot(vars_to_date(data.frame(
    anio = rep("2021", 12),
    mes = month.abb,
    value = 100:111
  ),
  year = "anio",
  month = "mes"))
  expect_snapshot(vars_to_date(data.frame(
    anio = rep("2021", 12),
    mes = month.abb,
    value = 100:111
  ),
  year = 1,
  month = 2))
})




test_that("Quarter date tests", {
  local_edition(3)
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 4),
    quarter = c(1, 2, 3, 4),
    value = 100:103
  ),
  year = 1,
  quarter = 2))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 4),
    quarter = c("Q1", "Q2", "Q3", "Q4"),
    value = 100:103
  ),
  year = 1,
  quarter = 2))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 4),
    quarter = c("T1", "T2", "T3", "T4"),
    value = 100:103
  ),
  year = 1,
  quarter = 2))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 98),
    quarter = c("e-m", "E-M", "ene-mar", "Ene-Mar", "enero-marzo", "Enero-Marzo", "ENERO-MARZO",
                "j-m", "J-M", "jan-mar", "Jan-Mar", "january-march", "January-March", "JANUARY-MARCH",
                "e-j", "E-J", "ene-jun", "Ene-Jun", "enero-junio", "Enero-Junio", "ENERO-JUNIO",
                "j-j", "J-J", "jan-jun", "Jan-Jun", "january-june", "January-June", "JANUARY-JUNE",
                "e-s", "E-s", "ene-sep", "Ene-Sep", "enero-septiembre", "Enero-Septiembre", "ENERO-SEPTIEMBRE",
                "j-s", "J-S", "jan-sep", "Jan-Sep", "january-september", "January-September", "JANUARY-SEPTEMBER",
                "e-d", "E-D", "ene-dic", "Ene-Dic", "enero-diciembre", "Enero-Diciembre", "ENERO-DICIEMBRE",
                "j-d", "J-D", "jan-dec", "Jan-Dec", "january-december", "January-Decemberr", "JANUARY-DECEMBER",
                "a-j", "A-J", "abr-jun", "Abr-Jun", "abril-junio", "Abril-Junio", "ABRIL-JUNIO",
                "a-j", "A-J", "apr-jun", "Apr-Jun", "april-june", "April-June", "APRIL-JUNE",
                "j-s", "J-s", "jul-sep", "Jul-Sep", "julio-septiembre", "Julio-Septiembre", "JULIO-SEPTIEMBRE",
                "j-s", "J-S", "jul-sep", "Jul-Sep", "july-september", "July-September", "JULY-SEPTEMBER",
                "o-d", "O-D", "oct-dic", "Oct-Dic", "octubre-diciembre", "Octubre-Diciembre", "OCTUBRE-DICIEMBRE",
                "o-d", "O-D", "oct-dec", "Oct-Dec", "october-december", "October-Decemberr", "OCTOBER-DECEMBER"),
    value = 100:197
  ),
  year = 1,
  quarter = 2))
})
