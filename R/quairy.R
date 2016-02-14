#' Low-Leveld Query Function for dairy
#'
#' This is a low-level interface to the methods in the API found
#' here: \url{https://www.rememberthemilk.com/services/api/}.
#'
#' @param method The name of the API method to call.
#' @param ... name-value parameter pairs.
#' @param .auth logical indicating whether authentication is required.
#' @param .json logical indicating whether pure json result should be returned
#'   instead of an R list (with class \code{quairy_result}).
#'
#' @importFrom httr POST content
#' @importFrom jsonlite fromJSON
#'
#' @export
#' @examples
#' \dontrun{
#' task_list <- quairy("tasks.getList")
#'
#' timeline <- get_timeline()
#' new_task <- quairy("tasks.add",
#'                     name = "Use dairy package", timeline = timeline)
#' }
quairy <- function(method, ..., .auth = TRUE, .json = FALSE)
{
  if (!is_scalar(method) && is.character(method))
    stop("Invalid method specification.", call. = FALSE)

  body  <-
    post_params(append(list(method = prefix_method(method),
                            auth_token = `if`(isTRUE(.auth), auth_token())),
                       list(...)))

  response <- POST("https://api.rememberthemilk.com/services/rest/",
                   body = body, encode = "form")

  stop_for_status(response)

  json <- content(response, as = "text")

  finalize <-
    `if`(isTRUE(.json), identity,
         function(.) structure(fromJSON(., simplifyVector = FALSE),
                               class = "quairy_result"))

  finalize(json)
}
