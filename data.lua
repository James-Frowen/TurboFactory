--data.lua

TurboFactory = {}
TurboFactory.Debug = false;

-- local dump = {
--   data.raw["transport-belt"]["express-transport-belt"],
--   data.raw["underground-belt"]["express-underground-belt"],
--   data.raw["splitter"]["express-splitter"],
  -- data.raw["inserter"]["stack-inserter"],
--   data.raw["inserter"]["stack-filter-inserter"],
--   data.raw["inserter"]["burner-inserter"],
--   data.raw["inserter"]["long-handed-inserter"],
-- }
local dump = data.raw["recipe"]["steel-plate"]
log("***Before Mass log***")
log(serpent.block(dump))
log("***After Mass log***")

require("prototypes.technology")
require("prototypes.ore")
require("prototypes.orecleaner")


require("prototypes.assembling")
require("prototypes.recipe")
require("prototypes.belts")
require("prototypes.chemical")
require("prototypes.furnace")
require("prototypes.inserter")
require("prototypes.mining")
require("prototypes.pumpjack")
require("prototypes.refinery")
require("prototypes.nuclear-steel")

require("prototypes.space-station.space-flight")
