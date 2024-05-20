rm *.lua

wget "https://raw.githubusercontent.com/nvim-lualine/lualine.nvim/master/lua/lualine/components/branch/init.lua"
wget "https://raw.githubusercontent.com/nvim-lualine/lualine.nvim/master/lua/lualine/components/branch/git_branch.lua"

patch -p1 ./git_branch.lua ./patch.patch
