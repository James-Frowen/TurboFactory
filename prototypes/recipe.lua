cleaningIcon = 
{
  icon="__TurboFactory__/graphics/radioactive-ore-half.png",
  tint={r=0.6, g=0.6, b=0.6, a=1}
}
nuclearIcon = {
  icon="__TurboFactory__/graphics/radioactive-ore.png",
  tint={r=0.4, g=0.4, b=0.4, a=1}
}


nuclearCrafting = {
  type = "recipe-category",
  name = "t-nuclear-crafting"
}
data:extend({nuclearCrafting})

local waterRequired = 2

local rawGear = data.raw.recipe["iron-gear-wheel"]
local gear = {}

gear.enabled = false
gear.name = "radioactive-gear"
gear.type = "recipe"
gear.energy_required = 0.9
gear.icon = nil
gear.icons = {
  {icon=data.raw.item[rawGear.name].icon}, 
  cleaningIcon
}
gear.icon_size = 32
gear.category = nuclearCrafting.name
gear.subgroup = "raw-resource"
gear.ingredients =
{
  {"radioactive-plate-iron-plate", 4},
  {type="fluid", name = "water", amount = waterRequired},
}
gear.results = {
  {name = rawGear.name, amount=2},
  {type="fluid", name = radioactiveWater.name, amount = waterRequired},
}
gear.allow_decomposition = false

data:extend({gear})

local rawCableItem = data.raw.item["copper-cable"]
local cableItem = table.deepcopy(rawCableItem)
cableItem.name = "radioactive-item-"..rawCableItem.name
cableItem.icon = nil
cableItem.icons = {
  {icon=rawCableItem.icon},
  nuclearIcon
}
cableItem.subgroup = "intermediate-product"

local rawCable = data.raw.recipe["copper-cable"]
local cable = {}

cable.enabled = false
cable.name = "radioactive-cable"
cable.type = "recipe"
cable.energy_required = 0.9
cable.icon = nil
cable.icons = cableItem.icons
cable.icon_size = 32
cable.category = nuclearCrafting.name
cable.subgroup = nil
cable.subgroup = "raw-resource"
cable.ingredients =
{
  {"radioactive-plate-copper-plate", 2},
}
cable.results = {
  {name = cableItem.name, amount=4},
}
cable.allow_decomposition = false

data:extend({cable, cableItem})


local rawCircuit = data.raw.recipe["electronic-circuit"]
local circuit = {}

circuit.enabled = false
circuit.type = "recipe"
circuit.name = "radioactive-circuit"
circuit.energy_required =  0.9
circuit.icon = nil
circuit.icons = {
  {icon=data.raw.item[rawCircuit.name].icon}, 
  cleaningIcon
}
circuit.icon_size = 32
circuit.category = nuclearCrafting.name
circuit.subgroup = "raw-resource"
circuit.ingredients =
{
  {"radioactive-plate-iron-plate", 2},
  {cableItem.name, 6},
  {type="fluid", name = "water", amount = waterRequired*2},
}
circuit.results = {
  {name = rawCircuit.name, amount=2},
  {type="fluid", name = radioactiveWater.name, amount = waterRequired*2},
}
circuit.allow_decomposition = false

local wireClean = {
  enabled = false,
  type = "recipe",
  name = "clean-".. rawCableItem.name,
  energy_required = 2,
  icons = {
    {icon=rawCableItem.icon},
    cleaningIcon
  },
  icon_size = 32,
  subgroup = "raw-material",
  category = nuclearCleaning.name,
  ingredients =
  {
    {cableItem.name, 10},
    {type="fluid", name = "water", amount = waterRequired * 4},
  },
  results = {
    {name = rawCableItem.name, amount=10},
    {type="fluid", name = radioactiveWater.name, amount = waterRequired * 4},
  },
  allow_decomposition = false,
}

data:extend({circuit, wireClean})



nuclearCraftingTech = {
  type = "technology",
  name = "nuclear-crafting",
  icon_size = 128,
  icons = 
  {{
    icon = "__base__/graphics/technology/automation.png",
  },{
    icon="__TurboFactory__/graphics/radioactive-ore-large.png",
    tint={r=.2, g=.2, b=.2, a=0.2},
  }},
  effects =
  {
    {
      type = "unlock-recipe", 
      recipe = gear.name
    },
    {
      type = "unlock-recipe", 
      recipe = cable.name
    },
    {
      type = "unlock-recipe", 
      recipe = circuit.name
    },
    {
      type = "unlock-recipe", 
      recipe = wireClean.name
    },
  },
  prerequisites = {"turbo-nuclear-power", "nuclear-furnace-mk1"},
  unit =
  {
    count_formula = 500,
    time = 120,
    ingredients =
    {
      {"science-pack-1", 1},
      {"science-pack-2", 1},
      {"science-pack-3", 1},
      {"production-science-pack", 1},
      {"high-tech-science-pack", 1},
      {"space-science-pack", 1}
    },
  },
  order = "x-o"
}

data:extend({nuclearCraftingTech})
