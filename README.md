# lualine-components

My collection of custom lualine components




## filename-oil

`require("lualine-components.filename-oil")`

Patched version of lualine filename component with oil support

#### Options

Same as lualine




## linecount

`require("lualine-components.linecount")`

Shows current buffer's linecount

#### Options

No options





## git-prompt

`require("lualine-components.git-prompt")`

Shows the `?M` git prompt from `git status`

![example](https://github.com/user-attachments/assets/bfff87a2-33e6-4341-abe6-bd479214dbfa)

#### Options

No options




## active-lsp

`require("lualine-components.active-lsp")`

Shows the first active lsp with options to filter / sort

#### Options

- `filter`: table passed to `vim.lsp.get_clients(filter)`
- `sort_clients`: function passed to `table.sort(clients, the_function)`
- `exclude`: array of clients to exclude
- `refresh_autocmd`: refresh on these autocmds, passed to `vim.api.nvim_create_autocmd`




Default options

```lua
{
    icon = "󰣖",
    filter = { bufnr = 0 },
    sort_clients = sort_clients,
    exclude = {},
    refresh_autocmd = { "LspAttach", "LspDetach", "BufEnter" },
}
```
