#' Get Authentication Token
#'
#' @param frob A frob.
#'
#' @importFrom httr GET
#' @noRd
get_token <- function(frob)
{
  method  <- "rtm.auth.getToken"
  quairy("rtm.auth.getToken", frob = frob, .auth = FALSE)[["auth"]][["token"]]
}

#' Check Authentication Token.
#'
#' Check whether installed authentication token is (still) valid.
#'
#' @export
check_token <- function()
{
  result <- quairy("rtm.auth.checkToken")
  identical(result[["rsp"]][["stat"]], "ok")
}
