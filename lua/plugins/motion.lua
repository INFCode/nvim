return {
	{
		"rhysd/accelerated-jk",
		config = function()
			-- Define accelerated_jk_acceleration_table
			vim.g.accelerated_jk_acceleration_table = { 4, 8, 16, 24}
		end,
		keys = {
			{ "j", "<Plug>(accelerated_jk_gj)" },
			{ 'k', '<Plug>(accelerated_jk_gk)' }
		},
	},
}
