return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<leader>dt", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle Breakpoint" })

		vim.keymap.set("n", "<leader>dc", function()
			dap.continue()
		end, { desc = "Continue" })

		vim.keymap.set("n", "<leader>dw", function()
			local expr = vim.fn.expand("<cexpr>")
			local watches = require("dapui").elements.watches

			--
			local ok_remove = pcall(watches.remove, expr)

			if not ok_remove then
				watches.add(expr)
			end
		end, { desc = "Toggle watch" })

		vim.keymap.set("n", "<leader>de", function()
			require("dapui").eval()
		end, { desc = "Evaluate expression" })

		vim.keymap.set("n", "<leader>di", function()
			dap.step_into()
		end, { desc = "Step Into" })

		vim.keymap.set("n", "<leader>do", function()
			dap.step_over()
		end, { desc = "Step Over" })

		vim.keymap.set("n", "<leader>du", function()
			dap.step_out()
		end, { desc = "Step Out" })

		vim.keymap.set("n", "<leader>dr", function()
			dap.repl.open()
		end, { desc = "Open REPL" })

		vim.keymap.set("n", "<leader>dq", function()
			dap.terminate()
			dapui.close()
		end, { desc = "Terminate" })

		-- c
		local dap = require("dap")

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}

		dap.configurations.c = {
			{
				name = "Debug C with GDB",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
		}
		-- rust
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "~/debug/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}

		-- js/tp node config
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					vim.fn.expand("~/js-debug/src/dapDebugServer.js"),
					"${port}",
				},
			},
		}
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch TS (tsx)",
				runtimeExecutable = "node",
				runtimeArgs = { "--loader", "tsx" },
				program = "${file}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				skipFiles = { "<node_internals>/**" },
			},
		}
	end,
}
