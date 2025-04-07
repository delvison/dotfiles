return {
  {
    'williamboman/mason.nvim',
    opts = {},
    lazy = false,
    config = function()
      require("mason").setup({
	  ui = {
	      icons = {
		  package_installed = "✓",
		  package_pending = "➜",
		  package_uninstalled = "✗"
	      }
	  }
      })
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
  }
}
