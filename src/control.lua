-- TODO: Rethink player_data / global_data paradigm?

local event = require("__flib__.event")
-- local gui = require("__flib__.gui-beta")
local migration = require("__flib__.migration")

local global_data = require("scripts.global-data")
local migrations = require("scripts.migrations")
local player_data = require("scripts.player-data")

event.on_init(function()
  global_data.init()

  for player_index, player in pairs(game.players) do
    player_data.init(player_index, player)
    player_data.refresh(player, global.players[player_index])
  end
end)

event.on_configuration_changed(function(e)
  if migration.on_config_changed(e, migrations) then
    for player_index, player in pairs(game.players) do
      player_data.refresh(player, global.players[player_index])
    end
  end
end)

-- gui.hook_events(function(e)
-- end)

event.on_player_created(function(e)
  local player = game.get_player(e.player_index)

  player_data.init(e.player_index, player)
  player_data.refresh(player, global.players[e.player_index])
end)

event.register(
  {
    defines.events.on_player_display_resolution_changed,
    defines.events.on_player_display_scale_changed,
  },
  function(e)
    -- TODO:
  end
)
