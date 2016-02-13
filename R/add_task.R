#' Add a Task
#'
#' @param name The task name.
#' @param timeline A timeline (see \code{get_timeline}).
#' @param list_id An id of a list to which the task is added.
#' @param parse If \code{parse = TRUE} Smart Add will be used to process the task.
#' @param parent (Pro feature): when a parent task id is provided, the task is
#'   created as a sub-task.
#'
#' @importFrom httr GET content stop_for_status
#' @importFrom jsonlite fromJSON
#' @export
add_task <- function(name, timeline = get_timeline(), list_id = NULL,
                     parse = FALSE, parent = NULL)
{
  parse <- `if`(isTRUE(parse), 1, NULL)

  quairy("rtm.tasks.add", timeline = timeline, list_id = list_id, parse = parse,
         parent = parent, name = name)
}

