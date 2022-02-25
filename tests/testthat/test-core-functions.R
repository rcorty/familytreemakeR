test_that(
	desc = 'can make new family tree',
	code =
		{
			# not enough input
			expect_error(there_was())

			# minimal sufficient input
			tree1 <- there_was(first_name = 'Abraham', last_name = 'Lincoln')
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
			tree2 <-  there_was(first_name = 'Abraham', last_name = 'Lincoln',
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

test_that(
	desc = 'can add first degree relatives',
	code =
		{
			there_was('Abraham', 'Lincoln') %>%
				who_had_a('spouse', 'Mary', 'Lincoln') ->
				tree1

			expect_true(is_family_tree(tree1))
			expect_length(igraph::V(tree1), 2)

			there_was('Abraham', 'Lincoln') %>%
				who_had_a('spouse', 'Mary', 'Lincoln') %>%
				who_had_a('child', 'Robert', 'Lincoln') ->
				tree2

			expect_true(is_family_tree(tree2))
			expect_length(igraph::V(tree2), 3)

			there_was('Abraham', 'Lincoln') %>%
				who_had_a('child', 'Robert', 'Lincoln') %>%
				who_had_a('parent', 'Mary', 'Lincoln') ->
				tree3

			expect_true(is_family_tree(tree3))
			expect_length(igraph::V(tree3), 3)

			there_was('Anakin', 'Skywalker') %>%
				who_had_a('child', 'Luke', 'Skywalker') %>%
				who_had_a('sibling', 'Leia', 'Skywalker') ->
				tree4

			expect_true(is_family_tree(tree4))
			expect_length(igraph::V(tree4), 3)
		}
)
