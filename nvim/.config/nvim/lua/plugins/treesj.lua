return {
  'Wansmer/treesj',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter'
  },
  config = function()
    local treesj = require('treesj')
    local lang_utils = require('treesj.langs.utils')
    treesj.setup({
      use_default_keymaps = false,
      langs = {
        templ = {
          tag_start = lang_utils.set_default_preset({ -- <div attr1="" attr2=""></div>
            both = { omit = { 'element_identifier' } },
          }),
          element = lang_utils.set_default_preset({ -- <table>element1 element2</table>
            join = {
              space_separator = false,
            },
          }),
          argument_list = lang_utils.set_preset_for_args({ -- hello(a, b, c)
            split = {
              last_separator = true,
            },
          }),
          parameter_list = lang_utils.set_preset_for_args({ -- func hello(a string, b int, c List)
            split = {
              last_separator = true,
            },
          }),
          literal_value = lang_utils.set_preset_for_list(), -- []string{"a", "b", "c"}
        },
      },
    })

    local keymap = vim.keymap.set
    keymap('n', 'gs', function ()
      treesj.split()
    end)
    keymap('n', 'gj', function ()
      treesj.join()
    end)
    keymap('n', 'gS', function()
      treesj.split({
        split = {
          recursive = true,
        },
      })
    end)
  end

}
