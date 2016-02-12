#' Return Non-NULL elements from a List
#'
#' @param l A list.
#'
#' @noRd
non_null <- function(l)
{
  l[!vapply(l, is.null, logical(1))]
}

#' MD5 Hash
#'
#' @param string The string to compute the md5 for.
#' @importFrom digest digest
#'
#' @noRd
md5 <- function(string)
{
  setNames(digest(string, algo = "md5", serialize = FALSE), string)
}

#' Test if All Elements of an Iterable Satifies A Predicate
#'
#' @param list The list to test.
#' @param predicate The predicate function to apply.
#' @return logical
#' @noRd
all_true <- function(list, predicate)
{
  all(vapply(list, predicate, logical(1)))
}

#' Check if Value is Atomic with Unit Length
#' @param x A value.
#' @noRd
is_scalar <- function(x)
{
  is.atomic(x) && length(x) == 1L
}
