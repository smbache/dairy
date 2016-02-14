#' Get Frob
#'
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET content stop_for_status
#'
#' @noRd
get_frob <- function()
{
  result <- quairy("rtm.auth.getFrob", .auth = FALSE)

  if (!quairy_status(result))
    stop("Unable to obtain frob.", call. = FALSE)

  result[["rsp"]][["frob"]]
}
