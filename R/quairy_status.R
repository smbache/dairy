#' Check status of a Quairy Result.
#'
#' The 'Remember the Milk' API method results includes a status.
#' This function checks whether this is "ok", or not.
#'
#' @param quairy_result An object of type \code{quairy_result}.
#' @return \code{TRUE} for "ok", \code{FALSE} otherwise.
#' @export
quairy_status <- function(quairy_result)
{
  if (!inherits(quairy_result, "quairy_result"))
    stop("An object of type 'quairy_status' was expected.", call. = FALSE)

  identical(quairy_result[["rsp"]][["stat"]], "ok")
}
