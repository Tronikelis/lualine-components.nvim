rm *.lua

url="https://raw.githubusercontent.com/nvim-lualine/lualine.nvim/master/lua/lualine/components/filename.lua"

wget -O "./init.lua" "$url"

patch -p1 ./init.lua ./patch.patch
