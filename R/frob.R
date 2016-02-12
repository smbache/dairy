#' Get Frob
#'
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET content stop_for_status
#'
#' @noRd
get_frob <- function()
{
  quairy("rtm.auth.getFrob", .auth = FALSE)[["frob"]]
}
