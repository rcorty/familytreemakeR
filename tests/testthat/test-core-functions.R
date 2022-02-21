test_that(
	desc = 'can make new family tree',
	code =
		{
			# not enough input
			expect_error(new_family_tree())

			# minimal sufficient input
			tree1 <- new_family_tree(first_name = 'Abraham', last_name = 'Lincoln')
			expect_s3_class(
				object = tree1,
				class = c('family_tree', 'dag', 'igraph'),
				exact = TRUE
			)
			expect_identical(
				object = igraph::as_data_frame(x = tree1, what = 'vertices'),
				expected = data.frame(first_name = 'Abraham', last_name = 'Lincoln')
			)
			expect_identical(
				object = length(igraph::E(graph = tree1)),
				expected = 0L
			)

			# more input
			tree2 <-  new_family_tree(first_name = 'Abraham', last_name = 'Lincoln',
																nick_name = 'Honest Abe', year_of_birth = 1809)
			expect_s3_class(
				object = tree2,
				class = c('family_tree', 'dag', 'igraph'),
				exact = TRUE
			)
			expect_identical(
				object = igraph::as_data_frame(x = tree2, what = 'vertices'),
				expected = data.frame(first_name = 'Abraham', last_name = 'Lincoln',
															nick_name = 'Honest Abe', year_of_birth = 1809)
			)
			expect_identical(
				object = length(igraph::E(graph = tree1)),
				expected = 0L
			)
		}
)
