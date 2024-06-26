return {
	'fladson/vim-kitty',
	'baskerville/vim-sxhkdrc',
	{
		'SirVer/ultisnips',
		init = function()
			vim.g.UltiSnipsExpandTrigger = '<Nop>'
			vim.g.UltiSnipsJumpForwardTrigger = '<Nop>'
			vim.g.UltiSnipsJumpBackwardTrigger = '<Nop>'
		end,
	},
	{
		'KeitaNakamura/tex-conceal.vim',
		init = function()
			vim.opt.conceallevel = 1
			vim.g.tex_concel = 'abdmg'
			vim.cmd('hi Conceal ctermbg=None')
		end,
	},
	'tpope/vim-fugitive',
	'tpope/vim-surround',
	'andweeb/presence.nvim',
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
	},
	{
		'mg979/vim-visual-multi',
		branch = 'master',
	},
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		ft = { 'markdown' },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		'numToStr/Comment.nvim',
		config = true,
		lazy = false,
	},
}
