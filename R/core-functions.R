#' @title Core Functions
#'
#' @param fn first name
#' @param ln last name
#' @param sex sex
#' @param nn nick name or alternate name
#' @param yob year of birth
#' @param note other notes about a person
#'
#' @return a new family tree with one person
#'
#' @export
#' @examples
#' new_family_tree(fn = 'Abraham', ln = 'Lincoln')
#' new_family_tree(fn = 'Abraham', ln = 'Lincoln', nn = 'Honest Abe', yob = 1809)
#'
new_family_tree <- function(fn = NULL,
														ln = NULL,
														sex = NULL,
														nn = NULL,
														yob = NULL,
														note = NULL) {
	if (any(is.null(fn), is.null(ln))) {
		stop('Must specify first name and last name of first person added to family tree.')
	}
	igraph::make_empty_graph() %>%
		igraph::add_vertices(nv = 1, fn = fn, ln = ln,
												 sex = sex, nn = nn,
												 yob = yob, note = note) %>%
		magrittr::set_class(c('family_tree', 'dag', 'igraph'))
}


