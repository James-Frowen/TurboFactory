local energy_source = require("prototypes.parts.energy_source")

function makeEntity(args)
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

  local entity = table.deepcopy(data.raw["mining-drill"]["pumpjack"])
  local item = table.deepcopy(data.raw.item["pumpjack"])
  local recipe = table.deepcopy(data.raw.recipe["pumpjack"])

  local icon = {{
    icon=item.icon,
    tint=iconTint
  }}


  item.name = name
  item.place_result = name
  item.icons = icon
  
  entity.name = name
  entity.mining_speed = speed
  entity.minable = {mining_time = 2, result = name}
  -- entity.energy_source =
  -- {
  --   type = "electric",
  --   -- will produce this much * energy pollution units per tick
  --   emissions = 0,
  --   usage_priority = "secondary-input"
  -- }
  entity.energy_source = energy_source.nuclear()
  entity.energy_usage = energy
  entity.max_health = health
  entity.module_specification =
  {
    module_slots = modSlots
  }
  for k, v in pairs(entity.animations.north.layers) do 
    v.tint = entityTint
  end

  for k, v in pairs(entity.base_picture.sheets) do 
    v.tint = entityTint
  end
  
  recipe.enabled = false
  recipe.name = name
  recipe.normal = nil
  recipe.expensive = nil
  recipe.ingredients = ingredients

  if (TurboFactory.Debug) then
    recipe.enabled = true
    recipe.ingredients = {
      {"iron-plate",1},
    }
  end

  recipe.result = name
  recipe.icons = icon
  recipe.icon_size = 32

  local tech = {
    type = "technology",
    name = name,
    icon_size = 128,
    icon = "__base__/graphics/technology/oil-gathering.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = name
      }
    },
    prerequisites = prerequisites,
    unit =
    {
      count_formula = science_count,
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
    order = "x-p"
  }

  data:extend({entity, recipe, item, tech})
  -- body
end

local mk1 = {
  name = "nuclear-pumpjack-mk1",
  speed = 4, 
  energy = "1400kW", 
  modSlots = 2, 
  ingredients =  {
    {"advanced-circuit",40},
    {"steel-plate",120},
    {"concrete",150},
    {"nuclear-reactor",1},
    {"processing-unit", 10}
  },  
  iconTint = {r=0.9,g=1,b=0.9,a=0.8},
  entityTint = {r=0.9,g=1,b=0.9,a=1},
  health = 3000,
  prerequisites = {"turbo-nuclear-power"},
  science_count = 2500
}

local mk2 = {
  name = "nuclear-pumpjack-mk2",
  speed = 20, 
  energy = "15400kW", 
  modSlots = 4, 
  ingredients =  {
    {"advanced-circuit",200},
    {"steel-plate",600},
    {"concrete",400},
    {"nuclear-reactor",1},
    {"processing-unit", 400}
  },  
  iconTint = {r=0.7,g=0.9,b=0.7,a=0.8},
  entityTint = {r=0.7,g=0.9,b=0.7,a=1},
  health = 9000,
  prerequisites = {mk1.name},
  science_count = 9000
}

makeEntity(mk1)
makeEntity(mk2)