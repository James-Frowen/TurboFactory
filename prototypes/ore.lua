nuclearIcon = {
  icon="__TurboFactory__/graphics/radioactive-ore.png",
  tint={r=0.6, g=0.6, b=0.6, a=1}
}
cleaningIcon = 
{
  icon="__TurboFactory__/graphics/radioactive-ore-half.png",
  tint={r=0.6, g=0.6, b=0.6, a=1}
}
local function createRadioactive(oreName, plateName)
  -- log("*t* nuclear ore " .. oreName)
  local rawOre = data.raw.resource[oreName]
  local rawItem = data.raw.item[oreName]
  local ore = table.deepcopy(rawOre)
  local item = table.deepcopy(rawItem)

  local nuclearName = "radioactive-ore-" .. rawOre.name

  
	ore.name = nuclearName
	ore.icon = nil
	ore.icons = {
    {icon=rawOre.icon},
    nuclearIcon
  }
  ore.autoplace = nil
  ore.minable.result = nuclearName
  
  item.name = nuclearName
  item.icons = {
    {icon=rawOre.icon},
    nuclearIcon
  }
  item.fuel_value = nil
  item.fuel_category = nil
  item.fuel_acceleration_multiplier = nil
  item.fuel_top_speed_multiplier = nil
  item.fuel_emissions_multiplier = nil
  item.fuel_glow_color = nil
  
  local nuclearIn = 50
  local WaterIn = 10
  
  local nuclearOut = 40
  local WaterOut = 10
  local cleanOut = 10
  local uraniumOut = 1 / 8

  local cleanRecipe = {
    type = "recipe",
		name = "clean-".. nuclearName,
		enabled = false,
		energy_required = 2,
		icons = {
      {icon=rawOre.icon},
      cleaningIcon
    },
		icon_size = 32,
		subgroup = "raw-material",
		category = nuclearCleaning.name,
		ingredients =
		{
      {nuclearName, nuclearIn},
      {type="fluid", name = "water", amount = WaterIn},
		},
		results = {
      {name = nuclearName, amount=nuclearOut},
      {name = rawItem.name, amount=cleanOut},
      {name = "uranium-238", amount=1, probability = uraniumOut },
      {type="fluid", name = radioactiveWater.name, amount = WaterOut},
    },
		allow_decomposition = false,
  }
  
  -- -- TESTING
  -- cleanRecipe.enabled = true

  table.insert(cleanNuclearOreTech.effects, {
    type = "unlock-recipe", 
    recipe = cleanRecipe.name
  })
  data:extend({ore, item, cleanRecipe})
  
  if (plateName ~= nil) then
    local rawPlate = data.raw.item[plateName]
    local plate = table.deepcopy(rawPlate)
    local nuclearPlateName = "radioactive-plate-" .. rawPlate.name

    plate.name = nuclearPlateName
    plate.icon = nil
    plate.icons = {
      {icon=rawPlate.icon},
      nuclearIcon
    }

    local plateRecipe = {
      enabled = false,
      type = "recipe",
      name = "smelt-" .. plate.name,
      icons = plate.icons,
		  icon_size = 32,
      category = "smelting",
      subgroup = "intermediate-product",
      energy_required = 3.5 * 3,
      ingredients = {{item.name, 1}},
      result = plate.name
    }
    local plateRecipe2 = {
      enabled = false,
      type = "recipe",
      name = "smelt-c-" .. plate.name,
      icons = plate.icons,
		  icon_size = 32,
      category = nuclearSmelting.name,
      subgroup = "intermediate-product",
      energy_required = 3.5 * 1.5,
      ingredients = {{rawItem.name, 1}},
      result = plate.name
    }
    local plateClean = {
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
        {plate.name, 5},
        {type="fluid", name = "water", amount = 5},
      },
      results = {
        {name = plate.name, amount=4},
        {name = rawPlate.name, amount=1},
        {name = "uranium-238", amount=1, probability = uraniumOut / 2 },
        {type="fluid", name = radioactiveWater.name, amount = WaterOut},
      },
      allow_decomposition = false,
    }
    table.insert(cleanNuclearOreTech.effects, {
      type = "unlock-recipe", 
      recipe = plateClean.name
    })
    table.insert(nuclearSmeltingTech.effects,{
      type = "unlock-recipe", 
      recipe = plateRecipe.name
    })
    table.insert(nuclearSmeltingTech.effects,{
      type = "unlock-recipe", 
      recipe = plateRecipe2.name
    })
    
    -- -- TESTING
    -- plateRecipe.enabled = true
    -- plateRecipe2.enabled = true
    -- plateClean.enabled = true
    
    data:extend({plate, plateRecipe, plateRecipe2, plateClean})
  end
end

nuclearSolid = {
  type = "resource-category",
  name = "t-nuclear-solid"
}
nuclearCleaning = {
  type = "recipe-category",
  name = "t-clean-nuclear"
}
nuclearSmelting = {
  type = "recipe-category",
  name = "t-nuclear-smelting"
}

local water = data.raw.fluid["water"];
radioactiveWater = table.deepcopy(water)
radioactiveWater.type = "fluid"
radioactiveWater.name = "radioactive-water"
radioactiveWater.base_color = {
  b = 0.6,
  g = 0.44000000000000004,
  r = 0
}
radioactiveWater.flow_color = {
  b = 0.7,
  g = 0.8,
  r = 0.7
}
radioactiveWater.default_temperature = 80
radioactiveWater.icons = {{icon = water.icon}, nuclearIcon}
radioactiveWater.icon = nil
radioactiveWater.order = "a[fluid]-a[water]-r"


nuclearSmeltingTech = {
  type = "technology",
  name = "smelt-nuclear-ore",
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
  },
  prerequisites = {"turbo-nuclear-power", "nuclear-mining-drill-mk1"},
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
cleanNuclearOreTech = {
  type = "technology",
  name = "clean-nuclear-ore",
  icon_size = 128,
  icon = "__base__/graphics/technology/kovarex-enrichment-process.png",
  effects =
  {
  },
  prerequisites = {"turbo-nuclear-power"},
  unit =
  {
    count_formula = 2000,
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

nuclearOreOverlay = {
  type = "simple-entity",
  name = "nuclear-ore-overlay",
  flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
  icons ={{
    icon="__TurboFactory__/graphics/radioactive-ore.png",
    tint={r=1, g=1, b=1, a=0.5}
  }},
  icon_size = 32,
  subgroup = "raw-material",
  collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  collision_mask = {},
  selectable_in_game = false,
  destructible = false,
  render_layer = "decorative",
  pictures =
  {
    {
      filename = "__TurboFactory__/graphics/radioactive-ore.png",
      width = 32,
      height = 32,
      scale = 2.5,
      tint = {r=.1, g=.1, b=.1, a=0.01}
    }
  },
  order = "x-owo"
}

data:extend({
  nuclearSolid, 
  cleanNuclearOreTech, 
  radioactiveWater,
  nuclearSmelting, 
  nuclearSmeltingTech,
  nuclearCleaning, 
  nuclearOreOverlay
})


createRadioactive("iron-ore", "iron-plate")
createRadioactive("copper-ore", "copper-plate")
createRadioactive("stone", "stone-brick")
createRadioactive("coal", nil)



local burnWater = {
  type = "recipe",
  name = "burn-".. radioactiveWater.name,
  enabled = true,
  energy_required = 1,
  icons = {
    {icon=water.icon},
    cleaningIcon
  },
  icon_size = 32,
  subgroup = "raw-material",
  category = nuclearCleaning.name,
  ingredients =
  {
    {type="fluid", name = radioactiveWater.name, amount = 10},
  },
  results = {
    {name = "uranium-238", amount=1, probability = 0.2 },
  },
  allow_decomposition = false,
}
local cleanWater = {
  type = "recipe",
  name = "clean-".. radioactiveWater.name,
  enabled = true,
  energy_required = 2,
  icons = {
    {icon=water.icon},
    cleaningIcon
  },
  icon_size = 32,
  subgroup = "raw-material",
  category = nuclearCleaning.name,
  ingredients =
  {
    {name = "stone", amount = 1},
    {type="fluid", name = radioactiveWater.name,  amount = 10},
  },
  results = {
    {name = "radioactive-ore-stone", amount=1},
    {type="fluid", name = water.name, amount = 10},
  },
  allow_decomposition = false,
}

data:extend({
  burnWater,
  cleanWater
})
table.insert(cleanNuclearOreTech.effects, {
  type = "unlock-recipe", 
  recipe = burnWater.name
})
table.insert(cleanNuclearOreTech.effects, {
  type = "unlock-recipe", 
  recipe = cleanWater.name
})