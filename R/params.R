#' Get MD5 signature for Parameter List
#'
#' @param frob A frob string.
#' @noRd
auth_params <- function(frob)
{
  api_key <- getOption("dairy_apikey")
  shared_secret <- getOption("dairy_secret")

  params   <- c(api_key = api_key, format = "json", frob = frob)

  params_string <-
    paste(paste0(names(params), params), collapse = "")

  signature <- paste0(shared_secret, params_string)

  sprintf("api_key=%s&perms=delete&frob=%s&format=json&api_sig=%s",
          api_key,
          frob,
          md5(signature))
}

#' Prepare Parameter List for POST Requests to the API
#'
#' @param ... Name-value parameter pairs.
#' @noRd
post_params <- function(params)
{
  raw_params <- non_null(params)

  if (!all_true(raw_params, is_scalar))
    stop("Parameters expected to be scalar valued.", call. = FALSE)

  api_key <- getOption("dairy_apikey")

  params  <- append(raw_params, c(format = "json", api_key = api_key))
  api_sig <- parameter_signature(params)

  append(params, setNames(api_sig, "api_sig"))
}

#' Sign Paramters
#'
#' @param params list of parameters to be used for signing.
#' @return character.
#' @noRd
parameter_signature <- function(params)
{

  param_names <- names(params)
  param_order <- order(param_names)
  param_values <- unlist(params)

  params_string <-
    paste(paste0(param_names[param_order], param_values[param_order]),
          collapse = "")

  shared_secret <- getOption("dairy_secret")

  signature <- paste0(shared_secret, params_string)

  md5(signature)
}
