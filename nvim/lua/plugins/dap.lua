vim.api.nvim_create_augroup("DapGroup", { clear = true })

local function navigate(args)
	local buffer = args.buf

	local wid = nil
	local win_ids = vim.api.nvim_list_wins() -- Get all window IDs
	for _, win_id in ipairs(win_ids) do
		local win_bufnr = vim.api.nvim_win_get_buf(win_id)
		if win_bufnr == buffer then
			wid = win_id
		end
	end

	if wid == nil then
		return
	end

	vim.schedule(function()
		if vim.api.nvim_win_is_valid(wid) then
			vim.api.nvim_set_current_win(wid)
		end
	end)
end

local function create_nav_options(name)
	return {
		group = "DapGroup",
		pattern = string.format("*%s*", name),
		callback = navigate,
	}
end

return {
	{
		"mfussenegger/nvim-dap",
		lazy = false,
		dependencies = {
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			dap.set_log_level("DEBUG")

			vim.keymap.set("n", "<F8>", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })
			vim.keymap.set("n", "<Leader>gb", dap.run_to_cursor, { desc = "Debug: Run to Cursor" })

			-- Eval variable under cursor
			vim.keymap.set("n", "<Leader>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			require("dap-go").setup({})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")

			require("dapui").setup()
			require("dap-go").setup()

			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>gb", dap.run_to_cursor, { desc = "Debug: Run to cursor" })

			vim.keymap.set("n", "<Leader>dt", function()
				require("dapui").toggle()
			end, { desc = "Debug: Toggle DAP UI" })

			vim.keymap.set("n", "<Leader>v", function()
				require("dapui").toggle()
			end, { desc = "Debug: Eval var under cursor" })

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_back)
			vim.keymap.set("n", "<F7>", dap.restart)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"delve",
				},
				automatic_installation = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
					delve = function(config)
						table.insert(config.configurations, 1, {
							args = function()
								return vim.split(vim.fn.input("args> "), " ")
							end,
							type = "delve",
							name = "file",
							request = "launch",
							program = "${file}",
							outputMode = "remote",
						})
						table.insert(config.configurations, 1, {
							args = function()
								return vim.split(vim.fn.input("args> "), " ")
							end,
							type = "delve",
							name = "file args",
							request = "launch",
							program = "${file}",
							outputMode = "remote",
						})
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},
}
