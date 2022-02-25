# number of vertices in a graph
nv <- function(g) length(igraph::V(g))

# check whether an object is a family_tree
is_family_tree <- function(o) methods::is(o, c('family_tree', 'dag', 'igraph'))

get_parents_idxs <- function(t, i) {
	igraph::neighborhood(
		graph = t,
		nodes = i,
		mode = 'in',
		order = 1,
		mindist = 1)[[1]] %>%
		as.integer()
}
