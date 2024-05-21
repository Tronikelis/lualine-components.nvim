rm *.lua

wget "https://raw.githubusercontent.com/nvim-lualine/lualine.nvim/master/lua/lualine/components/branch/git_branch.lua"
wget "https://raw.githubusercontent.com/nvim-lualine/lualine.nvim/master/lua/lualine/components/branch/init.lua"

patch -p1 ./init.lua ./init.patch
patch -p1 ./git_branch.lua ./git_branch.patch
