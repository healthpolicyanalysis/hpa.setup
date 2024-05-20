test_that("simple project with dplyr works", {
  test_file_dest <- tempfile(fileext = ".zip")
  get_setup_zip(outfile = test_file_dest, dependencies = "dplyr")

  expect_true(file.exists(test_file_dest))
})
