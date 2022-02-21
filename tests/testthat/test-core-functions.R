test_that(
	desc = 'can make new family tree',
	code =
		{
			expect_silent(new_family_tree())
			expect_silent(new_family_tree(tree_name = 'test tree'))
		}
)
