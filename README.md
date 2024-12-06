```Bash
# Save your configuration
mv ~/.config/nvim ~/.config/nvim-backup

# Setup new configuration
git clone https://github.com/ivostrilov/custom-neovim.git ~/.config/nvim

# Check dependencies.txt. All binaries should be adble from PATH.
# All plugins in lua/plugins has url to source.  You can check manual there.
# Firstly, I recommend check plugin manager https://github.com/folke/lazy.nvim.
# Configuration file locates here lua/config/lazy.lua.
```
In `lua/plugins/lsp.lua` you will find:
```lua
local enabled_servers = {
    bashls = false,
    pylsp = false,
    clangd = false,
}
```
Set `true` if you want enable some lsp servers.
