#' Get Authentication Token
#'
#' @param frob A frob.
#'
#' @importFrom httr GET
#' @noRd
get_token <- function(frob)
{
  result  <- quairy("auth.getToken", frob = frob, .auth = FALSE)
  if (!quairy_status(result))
    stop("Failed to obtain token.", call. = FALSE)

  result[["rsp"]][["auth"]][["token"]]
}

#' Check Authentication Token.
#'
#' Check whether installed authentication token is (still) valid.
#'
#' @export
check_token <- function()
{
  result <- quairy("auth.checkToken")
  if (!quairy_status(result))
    stop("Failed to check token.", call. = FALSE)

  identical(result[["rsp"]][["stat"]], "ok")
}
