#' Get MD5 signature for Parameter List
#'
#' @param ... A name-value list of parameters to sign.
#' @noRd
params_md5 <- function(...)
{
  dots   <- append(non_null(list(...)), c(format = "json"))
  params <- names(dots)
  param_order <- order(params)

  params_string <-
    paste(paste0(params[param_order], unlist(dots[param_order])), collapse = "")

  shared_secret <- getOption("dairy_secret")

  signature <- paste0(shared_secret, params_string)

  md5(signature)
}
