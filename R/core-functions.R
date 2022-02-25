#' @title Core Functions
#' @rdname Core-Functions
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
)
{
	if (any(is.null(first_name), is.null(last_name))) {
		stop('Must specify first name and last name of first person to add to family tree.')
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
		magrittr::set_attr(which = 'selected', value = 1L)
}

#' @rdname Core-Functions
#'
#' @param family_tree the tree to add to
#' @param what what to add (spouse, child, parent, or sibling)
#'
#' @return
#' @export
#'
#' @examples
#' there_was('Abraham', 'Lincoln') %>%
#'     who_had_a('spouse', 'Mary', 'Lincoln')
#'
who_had_a <- function(
	family_tree,
	what,
	first_name = NULL,
	last_name = NULL,
	sex = NULL,
	nick_name = NULL,
	year_of_birth = NULL,
	note = NULL)
{
	stopifnot(is_family_tree(family_tree))
	what <- match.arg(arg = what, choices = c('spouse', 'child', 'parent', 'sibling'))
	if (any(is.null(first_name), is.null(last_name))) {
		stop('Must specify first name and last name of person to add to family tree.')
	}

	adder_function <- switch(what,
													 spouse = add_spouse,
													 child = add_child,
													 parent = add_parent,
													 sibling = add_sibling)

	selected <- attr(family_tree,  'selected')
	input_nv <- nv(family_tree)

	family_tree %>%
		igraph::add_vertices(
			nv = 1,
			first_name = first_name,
			last_name = last_name,
			sex = sex,
			nick_name = nick_name,
			year_of_birth = year_of_birth,
			note = note
		) %>%
		magrittr::set_attr(which = 'selected', value = selected) %>%
		adder_function() %>%
		magrittr::set_class(c('family_tree', 'dag', 'igraph')) %>%
		magrittr::set_attr(which = 'selected', value = input_nv + 1)
}

# may want to find a better way to represent spousal relations
add_spouse <- function(tree) {
	igraph::add_edges(
		graph = tree,
		edges = c(attr(tree, 'selected'), nv(tree),
							nv(tree), attr(tree, 'selected'))
	)
}

# TODO really should somehow require two parents to define a child
# haven't figured out how to do it yet
add_child <- function(tree) {
	igraph::add_edges(
		graph = tree,
		edges = c(attr(tree, 'selected'), nv(tree))
	)
}

add_parent <- function(tree) {
	igraph::add_edges(
		graph = tree,
		edges = c(nv(tree), attr(tree, 'selected'))
	)
}

add_sibling <- function(tree) {
	igraph::add_edges(
		graph = tree,
		edges = c(get_parents_idxs(tree, attr(tree, 'selected'))[1],
							nv(tree))
	)
}

