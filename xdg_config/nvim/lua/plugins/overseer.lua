return {
  "stevearc/overseer.nvim",
  cmd = {
    "Make",
    "WatchRun",
    "OverseerShell",
    "OverseerOpen",
    "OverseerRun",
    "OverseerToggle",
    "OverseerTestOutput",
  },
  keys = {
    { "<leader>oo", "<cmd>OverseerToggle!<CR>", mode = "n", desc = "[O]verseer [O]pen" },
    { "<leader>or", "<cmd>OverseerRun<CR>", mode = "n", desc = "[O]verseer [R]un" },
    { "<leader>os", "<cmd>OverseerShell<CR>", mode = "n", desc = "[O]verseer [S]hell" },
    { "<leader>ot", "<cmd>OverseerTaskAction<CR>", mode = "n", desc = "[O]verseer [T]ask action" },
    {
      "<leader>od",
      function()
        local overseer = require("overseer")
        local task_list = require("overseer.task_list")
        local tasks = overseer.list_tasks({
          sort = task_list.sort_finished_recently,
          include_ephemeral = true,
        })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          local most_recent = tasks[1]
          overseer.run_action(most_recent)
        end
      end,
      mode = "n",
      desc = "[O]verseer [D]o quick action",
    },
  },
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {
    dap = false,
    log_level = vim.log.levels.INFO,
  },
  init = function()
    vim.cmd.cnoreabbrev("OS OverseerShell")
  end,
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    vim.api.nvim_create_user_command("WatchRun", function()
      local allowed_ft = { "sh", "python", "go" }
      local ft = vim.bo.filetype

      if not vim.tbl_contains(allowed_ft, ft) then
        vim.notify("WatchRun not supported for filetype " .. ft, vim.log.levels.ERROR)
        return
      end

      local file = vim.fn.expand("%:p")
      local cmd = { file }
      if ft == "go" then
        cmd = { "go", "run", file }
      elseif ft == "python" then
        cmd = { "python", file }
      end

      local task = overseer.new_task({
        name = "run script",
        cmd = cmd,
        components = {
          { "on_output_quickfix", set_diagnostics = true },
          "on_result_diagnostics",
          "default",
        },
      })

      task:add_component({ "restart_on_save", paths = { file } })
      task:start()
      task:open_output("vertical")
    end, {})

    vim.api.nvim_create_user_command("Make", function(params)
      -- Insert args at the '$*' in the makeprg
      local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
      if num_subs == 0 then
        cmd = cmd .. " " .. params.args
      end
      local task = require("overseer").new_task({
        cmd = vim.fn.expandcmd(cmd),
        components = {
          { "on_output_quickfix", open = not params.bang, open_height = 8 },
          "unique",
          "default",
        },
      })
      task:start()
    end, {
      desc = "Run your makeprg as an Overseer task",
      nargs = "*",
      bang = true,
    })
  end,
}
