local dash_gui = require("scripts.gui.dash")

local player_data = {}

function player_data.init(player_index, player)
  -- Disable the vanilla alerts GUI
  player.game_view_settings.show_alert_gui = false

  -- Create player data table
  global.players[player_index] = {
    guis = {}
  }
end

function player_data.refresh(player, player_table)
  -- Refresh dash GUI
  if player_table.guis.dash then
    dash_gui.destroy(player_table)
  end
  dash_gui.build(player, player_table)
end

return player_data
