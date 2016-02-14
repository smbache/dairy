#' Prefix an API Method Name
#'
#' All 'Remember the Milk' API methods starts with "rtm.", so to allow for
#' omitting this in the R wrapper, this function is called to ensure that
#' the method name includes this.
#'
#' @param method The name of an API method, with or without "rtm." prefix.
#'
#' @return An API method name, including "rtm.".
#' @noRd
prefix_method <- function(method)
{
  `if`(substr(method, 1, 4) != "rtm.", paste0("rtm.", method), method)
}
