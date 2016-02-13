#' Get or Create a new Timeline
#'
#' A new timeline will be created if no existing timeline exists. If it
#' does exist and \code{new = FALSE} then the existing timeline is returned.
#'
#' @param new logical indicating whether a new timeline should be created.
#'
#' @export
get_timeline <- local({

  .timeline <- NULL

  function(new = FALSE)
  {
    if (!new && !is.null(.timeline))
      return(.timeline)

    .timeline <<- quairy("rtm.timelines.create")[["timeline"]]

    .timeline
  }
})
