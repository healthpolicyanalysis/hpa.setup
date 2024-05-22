setup_renv <- function(path,
                       dependencies_file_path,
                       dependencies) {
  # TODO: assertions...
  # at least one of dependencies exist
  # dir exists

  usethis::create_project(path, open = FALSE)


  # create dependencies file in project dir
  if (!is.null(dependencies_file_path)) {
    file.copy(dependencies_file_path, file.path(path, "dependencies.R"))
  }

  if (!is.null(dependencies)) {
    for (pkg in dependencies) {
      pkg_line <- glue::glue("library({pkg})")
      write(pkg_line, file.path(path, "dependencies.R"), append = TRUE)
    }
  }

  withr::with_dir(path, renv::init(load = FALSE, restart = FALSE))

  file.remove(file.path(path, "dependencies.R"))

  path
}
