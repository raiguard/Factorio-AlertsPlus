local player_data = {}

function player_data.init(player_index, player)
  -- Disable the vanilla alerts GUI
  player.game_view_settings.show_alert_gui = false
end

return player_data
