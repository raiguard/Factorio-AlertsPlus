local gui = require("__flib__.gui-beta")

local dash_gui = {}

function dash_gui.build(player, player_table)
  local refs = gui.build(player.gui.screen, {
    {type = "frame", style_mods = {width = 300, height = 300}, caption = "Dash TEMP", ref = {"window"}}
  })

  player_table.guis.dash = {
    refs = refs,
    state = {}
  }
end

function dash_gui.destroy(player_table)
  player_table.guis.dash.refs.window.destroy()
  player_table.guis.dash = nil
end

return dash_gui
