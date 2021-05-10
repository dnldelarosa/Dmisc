test_that("vars_to_date", {
  local_edition(3)
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = 1:12,
    day = 1:12,
    value = 100:111,
    trim = 2
  ),
  trim = 5,
  month_type = "num"))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = 1:12,
    day = 1:12,
    value = 100:111
  )))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = month.name,
    day = 1:12,
    value = 100:111
  )))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = month.abb,
    day = 1:12,
    value = 100:111
  )))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"),
    day = 1:12,
    value = 100:111
  )))
  expect_snapshot(vars_to_date(data.frame(
    year = rep("2021", 12),
    month = c("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"),
    day = 1:12,
    value = 100:111
  )))
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
  day = 2))
  expect_snapshot(vars_to_date(data.frame(
    anio = rep("2021", 12),
    mes = month.abb,
    value = 100:111
  ),
  year = 1,
  month = 2))
})
