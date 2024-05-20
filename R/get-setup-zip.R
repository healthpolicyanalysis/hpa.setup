get_setup_zip <- function(outfile,
                          project_name = "new_project",
                          dependencies_file_path = NULL,
                          dependencies = NULL,
                          add_gitzip = TRUE) {
  # 1. create the project with the required dependencies
  # 2. initializes it as an renv project
  # 3. (optionally) adds a gitzip.sh file to the project
  # 4. zips up the project (library) for the user to send to the remote machine

  project_path <- file.path(tempdir(), project_name)

  dir.create(project_path, recursive = TRUE)

  withr::defer({
    # when exiting the
    unlink(project_path, recursive = TRUE)
  })

  # 1 and 2
  setup_renv(project_path, dependencies_file_path, dependencies)

  # 3.
  if (add_gitzip) {
    add_gitzip_file(project_path)
  }

  # 4.
  zip_project(project_path, outfile)

  outfile
}

zip_project <- function(project_path, outfile) {
  # package up all the renv required content from project_path and put in
  # zip file to be unzipped on remote machine
  withr::with_dir(
    project_path,
    utils::zip(
      zipfile = here::here(outfile),
      files = list.files(project_path, recursive = TRUE, all.files = T)
    )
  )
}
