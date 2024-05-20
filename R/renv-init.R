setup_renv <- function(path,
                       dependencies_file_path,
                       dependencies) {

  # assertions...
  # at least one of dependencies exist
  # dir exists

  usethis::create_project(path, open = FALSE)


  # create dependencies file in project dir
  if(!is.null(dependencies_file_path)) {
    file.copy(dependencies_file_path, file.path(path, "deps.R"))
  }

  if(!is.null(dependencies)) {
    for (pkg in dependencies) {
      pkg_line <- glue::glue("library({pkg})")
      write(pkg_line, file.path(path, "deps.R"), append = TRUE)
    }
  }

  write("renv::init(load = FALSE, restart = FALSE)", file.path(path, "run-setup.R"))
  withr::with_dir(path, source("run-setup.R"))

  path
}


package_renv <- function(project_path, outfile) {
  # package up all the renv required content from project_path and put in
  # zip file to be unzipped on remote machine
}


get_setup_zip <- function(outfile,
                          dependencies_file_path = NULL,
                          dependencies = NULL,
                          add_gitzip = TRUE) {
  project_path <- tempdir()
  setup_renv(project_path, dependencies_file_path, dependencies)
  package_renv(project_path, outfile)

  outfile
}


add_gitzip <- function(path) {

  file.create(file.path(path, "gitzip.sh"))

  lines <- c(
    'git add .',
    'git commit -m "daily changes"',
    'alias gitzip="git archive HEAD -o ${PWD##*/}.zip"',
    'gitzip'
  )

  purrr::map(lines, ~ write(.x, file.path(path, "gitzip.sh"), append = TRUE))

  file.path(path, "gitzip.sh")
}
