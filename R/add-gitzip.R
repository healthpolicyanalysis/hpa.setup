add_gitzip_file <- function(path) {
  # create gitzip.sh file at desired path

  lines <- c(
    "git add .",
    'git commit -m "daily changes"',
    'alias gitzip="git archive HEAD -o ${PWD##*/}.zip"',
    "gitzip"
  )

  write_script(
    filepath = file.path(path, "gitzip.sh"),
    lines = lines
  )
}


write_script <- function(filepath, lines, overwrite = TRUE) {
  if (file.exists(filepath)) {
    if (overwrite) {
      file.remove(filepath)
      file.create(filepath)
    }
  } else {
    file.create(filepath)
  }

  purrr::map(lines, ~ write(.x, filepath, append = TRUE))
  filepath
}
