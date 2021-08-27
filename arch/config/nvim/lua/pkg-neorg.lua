require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {},            -- Load all the default modules
        ["core.norg.concealer"] = {},      -- Allows for use of icons
        ["core.norg.dirman"] = {           -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/neorg"
                },

                -- Automatically detect whenever we have entered a subdirectory of a workspace
                autodetect = true,
                -- Automatically change the directory to the root of the workspace every time
                autochdir = true,
            }
        }
    },
		hook = function()
      -- This sets the leader for all Neorg keybinds. It is separate from the regular <Leader>,
      -- And allows you to shove every Neorg keybind under one "umbrella".
      local neorg_leader = "<Leader>o"

      -- Require the user callbacks module, which allows us to tap into the core of Neorg
      local neorg_callbacks = require('neorg.callbacks')

      -- Listen for the enable_keybinds event, which signals a "ready" state meaning we can bind keys.
      -- This hook will be called several times, e.g. whenever the Neorg Mode changes or an event that
      -- needs to reevaluate all the bound keys is invoked
      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)

        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          n = { -- Bind keys in normal mode

            -- Keys for managing TODO items and setting their states
            { "gtd", "core.norg.qol.todo_items.todo.task_done" },
            { "gtu", "core.norg.qol.todo_items.todo.task_undone" },
            { "gtp", "core.norg.qol.todo_items.todo.task_pending" },
            { "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" }

          },
        }, { silent = true, noremap = true })

      end)
		end
}

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = { "src/parser.c" },
        branch = "main"
    },
}