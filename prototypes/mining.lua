local energy_source = require("prototypes.parts.energy_source")

-- {name, speed, energy, area, modSlots, ingredients,  iconTint, entityTint} 
function miningDrill(args)
  local name = args.name
  local speed = args.speed
  local energy = args.energy
  local area = args.area
  local modSlots = args.modSlots
  local ingredients = args.ingredients
  local iconTint = args.iconTint
  local entityTint = args.entityTint
  local health = args.health
  local prerequisites = args.prerequisites
  local science_count = args.science_count

  local entity = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
  local item = table.deepcopy(data.raw.item["electric-mining-drill"])
  local recipe = table.deepcopy(data.raw.recipe["electric-mining-drill"])

  local icon = {{
    icon=item.icon,
    tint=iconTint
  }}


  item.name = name
  item.place_result = name
  item.icons = icon
  
  entity.name = name
  entity.minable = {mining_time = 2, result = name}
  entity.mining_speed = speed
  entity.resource_categories = {
    "basic-solid",
    "t-nuclear-solid"
  }
  entity.energy_source = energy_source.nuclear()
  entity.energy_usage = energy
  entity.max_health = health
  entity.mining_power = 3
  entity.resource_searching_radius = area
  entity.module_specification =
  {
    module_slots = modSlots
  }
  entity.animations.north.tint = entityTint
  entity.animations.east.tint = entityTint
  entity.animations.south.tint = entityTint
  entity.animations.west.tint = entityTint

  
  recipe.enabled = false
  recipe.name = name
  recipe.normal = nil
  recipe.expensive = nil
  recipe.ingredients = ingredients
  recipe.energy_required = 60
  recipe.requester_paste_multiplier = 2

  recipe.result = name
  recipe.icons = icon
  recipe.icon_size = 32

  if (TurboFactory.Debug) then
    recipe.enabled = true
    recipe.ingredients = {
      {"iron-plate",1},
    }
  end

  local tech = {
    type = "technology",
    name = name,
    icon_size = 128,
    icon = "__base__/graphics/technology/mining-productivity.png",
    effects =
    {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.10
      },
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
    order = "x-m"
  }

  data:extend({entity, recipe, item, tech})
  -- body
end

local mk1 = {
  name = "nuclear-mining-drill-mk1",
  prerequisites = {"turbo-nuclear-power"},
  speed = 4, 
  energy = "900kW", 
  area = 2.49, 
  modSlots = 0, 
  ingredients =  {
    {"advanced-circuit",40},
    {"steel-plate",40},
    {"concrete",100},
    {"nuclear-reactor",1},
    {"electric-mining-drill",2}
  },  
  iconTint = {r=0.9,g=1,b=0.9,a=0.8},
  entityTint = {r=0.9,g=1,b=0.9,a=1},
  health = 3000,
  science_count = 2000
}

local mk2 = {
  name ="nuclear-mining-drill-mk2",
  prerequisites = {mk1.name},
  speed = 10, 
  energy = "5800kW", 
  area = 3.49, 
  modSlots = 2, 
  ingredients =  {
    {"advanced-circuit",100},
    {"steel-plate",170},
    {"concrete",100},
    {"processing-unit", 50},
    {mk1.name, 2},
  },  
  iconTint = {r=0.7,g=0.9,b=0.7,a=0.8},
  entityTint = {r=0.7,g=0.9,b=0.7,a=1},
  health = 9000,
  science_count = 8000
}

local mk3 = {
  name ="nuclear-mining-drill-mk3",
  prerequisites = {mk2.name},
  speed = 50, 
  energy = "24600kW", 
  area = 4.49, 
  modSlots = 8, 
  ingredients =  {
    {"steel-plate",500},
    {"concrete",200},
    {"processing-unit", 400}
    {mk2.name, 2},
  },  
  iconTint = {r=0.4,g=1,b=0.4,a=0.8},
  entityTint = {r=0.4,g=1,b=0.4,a=1},
  health = 30000,
  science_count = 30000
}


miningDrill(mk1)
miningDrill(mk2)
miningDrill(mk3)