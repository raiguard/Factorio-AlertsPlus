local gui = require("__flib__.gui-beta")

local constants = require("constants")

local dash_gui = {}

function dash_gui.build(player, player_table)
  local refs = gui.build(player.gui.screen, {
    {
      type = "flow",
      name = "foobar",
      direction = "vertical",
      style_mods = {margin = 0, padding = 0, vertical_spacing = 0},
      ref = {"window"},
      {
        type = "empty-widget",
        style = "flib_vertical_pusher",
      },
      {type = "frame", style_mods = {width = constants.dash_gui_width, height = 50}}
    }
  })

  player_table.guis.dash = {
    refs = refs,
    state = {}
  }

  dash_gui.reposition(player, player_table)
end

function dash_gui.destroy(player_table)
  player_table.guis.dash.refs.window.destroy()
  player_table.guis.dash = nil
end

-- HACK: The GUI cannot have a dynamic height unless we start at the top and make it the height of the monitor
function dash_gui.reposition(player, player_table)
  local gui_data = player_table.guis.dash

  local window = gui_data.refs.window

  -- FIXME: This makes it impossible to click everything behind the flow... ugh
  window.location = {
    x = player.display_resolution.width - (constants.dash_gui_width * player.display_scale),
    y = 0
  }
  window.style.height = player.display_resolution.height / player.display_scale
end

return dash_gui
