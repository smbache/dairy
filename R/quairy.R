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


#' Low-Leveld Query Function for dairy
#'
#' This is a low-level interface to the methods in the API found
#' here: \url{https://www.rememberthemilk.com/services/api/}.
#'
#' @param method The name of the API method to call.
#' @param ... name-value parameter pairs.
#' @param .auth logical indicating whether authentication is required.
#'
#' @importFrom httr POST content
#' @importFrom jsonlite fromJSON
#'
#' @export
quairy <- function(method, ..., .auth = TRUE)
{
  if (!is.character(method) && length(method) == 1L)
    stop("Invalid method specification.", call. = FALSE)

  body  <-
    post_params(append(list(method = method,
                            auth_token = `if`(isTRUE(.auth), auth_token())),
                       list(...)))


  response <- POST("https://api.rememberthemilk.com/services/rest/",
                   body = body, encode = "form")

  stop_for_status(response)

  result <- fromJSON(content(response, "text"))

  if (!identical(result[["rsp"]][["stat"]], "ok"))
    stop("API query failed.", call. = FALSE)

  fromJSON(content(response, "text"), simplifyVector = FALSE)[["rsp"]]
}
