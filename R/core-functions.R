#' @title Core Functions
#'
#' @param first_name first name
#' @param last_name last name
#' @param sex sex
#' @param nick_name nick name or alternate name
#' @param year_of_birth year of birth
#' @param note other notes about a person
#'
#' @return a new family tree with one person
#'
#' @export
#' @examples
#' there_was(first_name = 'Abraham', last_name = 'Lincoln')
#' there_was(first_name = 'Abraham', last_name = 'Lincoln',
#'                 nick_name = 'Honest Abe', year_of_birth = 1809)
#'
there_was <- function(
	first_name = NULL,
	last_name = NULL,
	sex = NULL,
	nick_name = NULL,
	year_of_birth = NULL,
	note = NULL
) {
	if (any(is.null(first_name), is.null(last_name))) {
		stop('Must specify first name and last name of first person added to family tree.')
	}
	igraph::make_empty_graph() %>%
		igraph::add_vertices(
			nv = 1,
			first_name = first_name,
			last_name = last_name,
			sex = sex,
			nick_name = nick_name,
			year_of_birth = year_of_birth,
			note = note
		) %>%
		magrittr::set_class(c('family_tree', 'dag', 'igraph')) %>%
		magrittr::set_attr(which = 'last_added', value = 1L)
}


# add_son <- function(first_name = NULL, last_name = NULL) {
#
# }
