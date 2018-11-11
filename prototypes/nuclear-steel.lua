-- nuclearIcon = {
--   icon="__TurboFactory__/graphics/radioactive-ore.png",
--   tint={r=0.6, g=0.6, b=0.6, a=1}
-- }
-- cleaningIcon = 
-- {
--   icon="__TurboFactory__/graphics/radioactive-ore-half.png",
--   tint={r=0.6, g=0.6, b=0.6, a=1}
-- }
-- variables for name
-- nuclearCleaning = {
--   name = "t-clean-nuclear"
-- }
-- nuclearSmelting = {
--   name = "t-nuclear-smelting"
-- }


local rawName = "steel-plate"
local name = "radioactive-plate-" .. rawName

local rawPlate = data.raw.item[rawName]
local plate = table.deepcopy(rawPlate)

plate.name = name
plate.icon = nil
plate.icons = {
  {icon=rawPlate.icon},
  nuclearIcon
}

local recipe = {
  enabled = false,
  type = "recipe",
  name = "smelt-" .. plate.name,
  icons = plate.icons,
  icon_size = 32,
  category = nuclearSmelting.name,
  subgroup = "intermediate-product",
  energy_required = 17.5 * 2,
  ingredients = {{ "radioactive-plate-iron-plate", 5}},
  result = plate.name
}
local recipe2 = {
  enabled = false,
  type = "recipe",
  name = "smelt-c-" .. plate.name,
  icons = plate.icons,
  icon_size = 32,
  category = nuclearSmelting.name,
  subgroup = "intermediate-product",
  energy_required = 17.5,
  ingredients = {{ "iron-plate", 5}},
  result = plate.name
}

local nuclearIn = 50
local WaterIn = 10

local nuclearOut = 40
local WaterOut = 10
local cleanOut = 10
local uraniumOut = 1 / 8
local steelClean = {
  enabled = false,
  type = "recipe",
  name = "clean-".. plate.name,
  energy_required = 1,
  icons = {
    {icon=rawPlate.icon},
    cleaningIcon
  },
  icon_size = 32,
  subgroup = "raw-material",
  category = nuclearCleaning.name,
  ingredients =
  {
    {plate.name, nuclearIn},
    {type="fluid", name = "water", amount = WaterIn},
  },
  results = {
    {name = plate.name, amount=nuclearOut},
    {name = rawPlate.name, amount=cleanOut},
    {name = "uranium-238", amount=1, probability =  1 / 16 },
    {type="fluid", name = radioactiveWater.name, amount = WaterOut},
  },
  allow_decomposition = false,
}

local nuclearSmeltingSteelTech = {
  type = "technology",
  name = "smelt-nuclear-plate",
  icon_size = 128,
  icons = 
  {{
    icon = "__base__/graphics/technology/mining-productivity.png",
  },{
    icon="__TurboFactory__/graphics/radioactive-ore-large.png",
    tint={r=.2, g=.2, b=.2, a=0.2},
  }},
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = recipe.name
    },
    {
      type = "unlock-recipe",
      recipe = recipe2.name
    },
  },
  prerequisites = {"smelt-nuclear-ore"},
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

local cleanNuclearSteelTech = {
  type = "technology",
  name = "clean-nuclear-plate",
  icon_size = 128,
  icon = "__base__/graphics/technology/kovarex-enrichment-process.png",
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = steelClean.name
    },
  },
  prerequisites = {"clean-nuclear-ore"},
  unit =
  {
    count_formula = 1000,
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


data:extend({
  plate,
  recipe,
  recipe2,
  steelClean,
  nuclearSmeltingSteelTech,
  cleanNuclearSteelTech
})
