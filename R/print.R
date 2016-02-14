#' Tree Structure of a List
#'
#' @param list A list object.
#'
#' @noRd
list_structure <- function(list, depth = 0)
{
  if (!is.list(list) || is.null(names(list)))
    return(invisible())

  for (i in seq_along(list)) {
    line <- paste(rep("--", depth), collapse = "")
    cat(paste0("|", line, " ", names(list)[i]))
    if (is.list(list[[i]])) {
      cat("\n")
      list_structure(list[[i]], depth = depth + 1)
    } else {
      cat(paste0("(", paste(class(list[[i]]), collapse = ","), ")"),
          "=", as.character(list[[i]]), "\n")
    }
  }
}

#' Print Method for Quairy Results
#'
#' @param x An object of class \code{quairy_result}
#' @param ... Not used.
#'
#' @return x, invisibly.
#' @export
print.quairy_result <- function(x, ...) {

  if (!inherits(x, "quairy_result"))
    stop("Expect a 'quairy_result' for printing.")

  cat("Quairy result (status ", x[["rsp"]][["stat"]], ")\n", sep = "")
  list_structure(x[["rsp"]][-1L])

  invisible(x)
}
