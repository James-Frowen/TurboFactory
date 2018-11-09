local energy_source = require("prototypes.parts.energy_source")

function makeEntity(args)
  local cat = args.cat
  local raw = args.raw
  local name = args.name
  local speed = args.speed
  local energy = args.energy
  local modSlots = args.modSlots
  local ingredients = args.ingredients
  local iconTint = args.iconTint
  local entityTint = args.entityTint
  local health = args.health
  local prerequisites = args.prerequisites
  local science_count = args.science_count

  local entity = table.deepcopy(data.raw[cat][raw])
  local item = table.deepcopy(data.raw.item[raw])
  local recipe = table.deepcopy(data.raw.recipe[raw])
  local icon = {{
    icon=item.icon,
    tint=iconTint
  }}


  item.name = name
  item.place_result = name
  item.icons = icon
  
  entity.name = name
  entity.speed = 0.03125 * speed
  entity.minable = {
    hardness = 0.2,
    mining_time = 0.3,
    result = name
  }
  entity.energy_source = energy_source.nuclear()
  entity.energy_usage = energy
  entity.max_health = health
  entity.module_specification =
  {
    module_slots = modSlots
  }
  local anim = {
    "belt_horizontal",
    "belt_vertical",
    "ending_top",
    "ending_bottom",
    "ending_side",
    "starting_top",
    "starting_bottom",
    "starting_side",
  }
  for nameCount = 1, 8 do
    local v = anim[nameCount]
    if entity[v] ~= nil then
        entity[v].tint = entityTint
      end
  end
  if (entity.ending_patch ~= nil) then
    entity.ending_patch.sheet.tint = entityTint 
  end
  

  if (cat == "transport-belt") then
    entity.animations.tint = entityTint
  end
  if (cat == "underground-belt") then
    entity.structure.direction_in.sheet.tint = entityTint
    entity.structure.direction_out.sheet.tint = entityTint
  end
  if (cat == "splitter") then
    entity.structure.east.tint = entityTint
    entity.structure.north.tint = entityTint
    entity.structure.south.tint = entityTint
    entity.structure.west.tint = entityTint
  end
  
  recipe.enabled = false
  recipe.name = name
  recipe.normal = nil
  recipe.expensive = nil
  recipe.ingredients = ingredients
  if (cat == "underground-belt") then
    recipe.result_count = 2
    entity.max_distance = 3 * speed
  end

  if (TurboFactory.Debug) then
    recipe.enabled = true
    recipe.ingredients = {
      {"iron-plate",1},
    }
  end

  recipe.result = name
  recipe.icons = icon
  recipe.icon_size = 32

 

  data:extend({entity, recipe, item})
  -- body
end

local speed1 = 5
local speed2 = 10
local iconTint1 = {r=0.5,g=1,b=0.5,a=0.8}
local entityTint1 = {r=0.5,g=1,b=0.5,a=1}
local iconTint2 = {r=1,g=0.7,b=0.5,a=0.8}
local entityTint2 = {r=1,g=0.7,b=0.5,a=1}

local belt_mk1 = {
  cat = "transport-belt",
  raw = "express-transport-belt",
  name = "turbo-transport-belt",
  speed = speed1, 
  ingredients =  {
    {"express-transport-belt",2},
    {"processing-unit", 1},
    {"iron-gear-wheel", 25},
    {type="fluid", name="lubricant", amount=30},
  },  
  iconTint = iconTint1,
  entityTint = entityTint1,
  health = 360,
}

local belt_mk2 = {
  cat = "transport-belt",
  raw = "express-transport-belt",
  name = "ultra-transport-belt",
  speed = speed2, 
  ingredients =  {
    {belt_mk1.name,2},
    {"processing-unit", 10},
    {"iron-gear-wheel", 250},
    {type="fluid", name="lubricant", amount=300},
  },  
  iconTint = iconTint2,
  entityTint = entityTint2,
  health = 720,
}

local under_mk1 = {
  cat = "underground-belt",
  raw = "express-underground-belt",
  name = "turbo-underground-belt",
  speed = speed1, 
  ingredients =  {
    {"express-underground-belt",4},
    {"processing-unit", 2},
    {"iron-gear-wheel", 200},
    {type="fluid", name="lubricant", amount=60},
  },  
  iconTint = iconTint1,
  entityTint = entityTint1,
  health = 360,
}

local under_mk2 = {
  cat = "underground-belt",
  raw = "express-underground-belt",
  name = "ultra-underground-belt",
  speed = speed2, 
  ingredients =  {
    {under_mk1.name,4},
    {"processing-unit", 20},
    {"iron-gear-wheel", 2000},
    {type="fluid", name="lubricant", amount=600},
  },
  iconTint = iconTint2,
  entityTint = entityTint2,
  health = 720,
}

local splitter_mk1 = {
  cat = "splitter",
  raw = "express-splitter",
  name = "turbo-splitter",
  speed = speed1, 
  ingredients =  {
    {"express-splitter",2},
    {"processing-unit", 10},
    {"iron-gear-wheel", 30},
    {type="fluid", name="lubricant", amount=120},
  },  
  iconTint = iconTint1,
  entityTint = entityTint1,
  health = 360,
}


local splitter_mk2 = {
  cat = "splitter",
  raw = "express-splitter",
  name = "ultra-splitter",
  speed = speed2, 
  ingredients =  {
    {splitter_mk1.name,2},
    {"processing-unit", 100},
    {"iron-gear-wheel", 300},
    {type="fluid", name="lubricant", amount=1200},
  },    
  iconTint = iconTint2,
  entityTint = entityTint2,
  health = 720,
}

makeEntity(belt_mk1)
makeEntity(belt_mk2)
makeEntity(under_mk1)
makeEntity(under_mk2)
makeEntity(splitter_mk1)
makeEntity(splitter_mk2)

local tech1 = {
  type = "technology",
  name = "t-logistics-4",
  icon_size = 128,
  icon = "__base__/graphics/technology/logistics.png",
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = belt_mk1.name
    },
    {
      type = "unlock-recipe",
      recipe = under_mk1.name
    },
    {
      type = "unlock-recipe",
      recipe = splitter_mk1.name
    }
  },
  prerequisites = {"turbo-nuclear-power", "logistics-3"},
  unit =
  {
    count_formula = 4000,
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
  order = "x-b"
}

local tech2 = {
  type = "technology",
  name = "t-logistics-5",
  icon_size = 128,
  icon = "__base__/graphics/technology/logistics.png",
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = belt_mk2.name
    },
    {
      type = "unlock-recipe",
      recipe = under_mk2.name
    },
    {
      type = "unlock-recipe",
      recipe = splitter_mk2.name
    }
  },
  prerequisites = {tech1.name},
  unit =
  {
    count_formula = 20000,
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
  order = "x-b"
}

data:extend({tech1, tech2})
