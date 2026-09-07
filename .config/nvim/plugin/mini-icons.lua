
require("vim-pack").add({
  { 
    src = "nvim-mini/mini.icons",
    on_setup = function()
      require("mini.icons").mock_nvim_web_devicons()
    end
  }
})
