test_that("octave_path", {
  expect_equal(octave_path(sysname = "Windows"), "C:/Octave/Octave-5.2.0/mingw64/bin/octave-cli-5.2.0.exe")
  expect_equal(octave_path(sysname = "linux"), "/usr/bin/octave-cli")
  expect_true(any(
    octave_path() == "C:/Octave/Octave-5.2.0/mingw64/bin/octave-cli-5.2.0.exe",
    octave_path() == "/usr/bin/octave-cli"
  ))
})
