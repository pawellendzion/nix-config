return {
	{
		'nvim-neo-tree/neo-tree.nvim',

		keys = {
			{ '<leader>ft', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
		},

		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
	},
}
