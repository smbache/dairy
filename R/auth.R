#' Get Authentication Token
#'
#' Reads the authentication token. If the package has not yet been authorized
#' an error is raised with information on how to authenticate.
#'
#' @return token
#' @noRd
auth_token <- local({
  .token <- NULL

  function()
  {
    if (!is.null(.token))
      return(.token)

    auth_file <-
      system.file("auth/TOKEN", package = .packageName, mustWork = TRUE)

    # Make sure there is an AUTH file
    if (!file.exists(auth_file)) {
      writeLines("PLACEHOLDER", auth_file)
    }

    token <- readLines(auth_file)

    if (length(token) < 1 || token[1L] == "PLACEHOLDER")
      stop("The dairy application is not authenticated. Use authenticate_dairy.")

    # check that authentication is value here!!
    #
    .token <<- trimws(token[1L])
  }
})

#' Authenticate Application with Remember the Milk
#'
#' This function will authenticate the package with your online account.
#' A browser will be opened, in which will can authorize the dairy package.
#' You may need to log in to your account, if you are not already logged in.
#'
#' @export
authenticate_dairy <- function()
{
  url_template <-
    paste0("https://www.rememberthemilk.com/services/auth/",
           "?api_key=%s",
           "&perms=delete",
           "&frob=%s",
           "&format=json",
           "&api_sig=%s")

  api_key <- getOption("dairy_apikey")
  frob <- get_frob()

  api_sig <-
    params_md5(api_key = api_key, frob = frob, perms = "delete")

  url <- sprintf(url_template, api_key, frob, api_sig)

  browseURL(url)

  cat("Opening browser for application authentication.\n")
  cat("If browser did not open correctly, browse manually to this URL:\n")
  cat(url, "\n")
  cat("Press enter when application when you have authenticated.\n")
  readLines(n = 1)

  token <- get_token(frob)
  auth_file <- system.file("auth/TOKEN", package = .packageName, mustWork = TRUE)

  # Possibly check token validity here as well.
  writeLines(token, auth_file)
  cat("Done.\n")
}

