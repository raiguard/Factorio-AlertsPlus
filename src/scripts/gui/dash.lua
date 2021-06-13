local gui = require("__flib__.gui-beta")

local constants = require("constants")

local dash_gui = {}

function dash_gui.build(player, player_table)
  local refs = gui.build(player.gui.screen, {
    {
      type = "flow",
      direction = "vertical",
      style_mods = {margin = 0, padding = 0, vertical_spacing = 0},
      ref = {"window", "container"},
      {
        type = "empty-widget",
        style = "flib_vertical_pusher",
      },
      {
        type = "frame",
        style = "ap_dash_frame",
        style_mods = {width = constants.dash_gui_width, minimal_height = 50},
        direction = "vertical",
        ref = {"window", "frame"},
        {type = "frame", style = "inside_shallow_frame",
          {type = "empty-widget", style_mods = {height = 70, horizontally_stretchable = true}}
        },
        {type = "flow", style_mods = {horizontal_spacing = 8},
          {type = "frame", style = "inside_shallow_frame",
            {type = "button", style_mods = {horizontally_stretchable = true}, caption = "Expand"}
          }
        }
      }
    }
  })

  player_table.guis.dash = {
    refs = refs,
    state = {}
  }

  dash_gui.reposition(player, player_table)
end

function dash_gui.destroy(player_table)
  player_table.guis.dash.refs.window.container.destroy()
  player_table.guis.dash = nil
end

-- HACK: The GUI cannot have a dynamic height unless we start at the top and make it the height of the monitor
function dash_gui.reposition(player, player_table)
  local gui_data = player_table.guis.dash

  local container = gui_data.refs.window.container

  -- FIXME: This makes it impossible to click everything behind the flow... ugh
  container.location = {
    x = player.display_resolution.width - (constants.dash_gui_width * player.display_scale),
    y = 0
  }
  container.style.height = player.display_resolution.height / player.display_scale
end

return dash_gui
