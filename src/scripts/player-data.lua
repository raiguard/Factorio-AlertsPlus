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

  local refs = gui_data.refs
  local window = refs.window.frame
  window.clear()

  local player_alerts = player_table.alerts
  for surface_index, alerts in pairs(player.get_alerts{}) do
    window.add{type = "label", style = "caption_label", caption = game.surfaces[surface_index].name}
    for alert_type, alerts in pairs(alerts) do
      for _, alert_data in pairs(alerts) do
        window.add{
          type = "label",
          caption = reverse_defines.alert_type[alert_type]
            .." "
            ..(
              alert_type == defines.alert_type.custom
                and "[img="..alert_data.icon.type.."/"..alert_data.icon.name.."]  "..alert_data.message
                or ""
            )
        }
      end
    end
  end
end

return player_data
