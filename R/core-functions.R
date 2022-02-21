#' @title Core Functions
#'
#' @param tree_name a name for the tree to be created,
#' e.g. 'The Wallace Family'
#'
#' @return a new tree
#' @export
#'
#' @examples
#' new_family_tree(tree_name = 'The Wallace Family')
new_family_tree <- function(tree_name = 'my new tree') {
	return(list(name = tree_name))
}
