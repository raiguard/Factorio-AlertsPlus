local event = require("__flib__.event")

local global_data = require("scripts.global-data")
local player_data = require("scripts.player-data")

event.on_init(function()
  global_data.init()

  for player_index, player in pairs(game.players) do
    player_data.init(player_index, player)
  end
end)

event.on_player_created(function(e)
  player_data.init(e.player_index, game.get_player(e.player_index))
end)
