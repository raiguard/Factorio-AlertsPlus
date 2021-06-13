local reverse_defines = require("__flib__.reverse-defines")

local dash_gui = require("scripts.gui.dash")

local player_data = {}

function player_data.init(player_index, player)
  -- Disable the vanilla alerts GUI
  player.game_view_settings.show_alert_gui = false

  -- Create player data table
  global.players[player_index] = {
    alerts = {},
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

function player_data.update_game_alerts(player, player_table)
  local gui_data = player_table.guis.dash
  if not gui_data then return end

  -- local player_alerts = player_table.alerts
  local compiled_alerts = {}
  for surface_index, alerts in pairs(player.get_alerts{}) do
    local surface_alerts = {}
    for alert_type, alerts in pairs(alerts) do
      local type_key = reverse_defines.alert_type[alert_type]
      local i = 0
      for _ in pairs(alerts) do
        i = i + 1
      end
      if i > 0 then
        surface_alerts[type_key] = i
      end
    end
    if table_size(surface_alerts) > 0 then
      compiled_alerts[game.get_surface(surface_index).name] = surface_alerts
    end
  end

  local refs = gui_data.refs
  local pane = refs.list_pane
  pane.clear()

  for surface_name, surface_alerts in pairs(compiled_alerts) do
    pane.add{type = "label", style = "caption_label", caption = surface_name}
    for alert_type, number in pairs(surface_alerts) do
      pane.add{
        type = "label",
        caption = alert_type.." ("..number..")",
      }
    end
  end
end

return player_data
