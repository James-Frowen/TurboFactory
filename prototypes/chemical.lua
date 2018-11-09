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

  local entity = table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])
  local item = table.deepcopy(data.raw.item["chemical-plant"])
  local recipe = table.deepcopy(data.raw.recipe["chemical-plant"])

  local icon = {{
    icon=item.icon,
    tint=iconTint
  }}


  item.name = name
  item.place_result = name
  item.icons = icon
  
  entity.name = name
  entity.crafting_speed = speed
  entity.minable = {mining_time = 2, result = name}
  entity.energy_source = energy_source.nuclear()
  entity.energy_usage = energy
  entity.max_health = health
  entity.module_specification =
  {
    module_slots = modSlots
  }
  for k, v in pairs(entity.animation.north.layers) do 
    v.tint = entityTint
  end
  for k, v in pairs(entity.animation.south.layers) do 
    v.tint = entityTint
  end
  for k, v in pairs(entity.animation.east.layers) do 
    v.tint = entityTint
  end
  for k, v in pairs(entity.animation.west.layers) do 
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
    icon = "__base__/graphics/technology/advanced-material-processing.png",
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
    order = "x-c"
  }

  data:extend({entity, recipe, item, tech})
  -- body
end

local mk1 = {
  name = "nuclear-chemicals-mk1",
  speed = 5, 
  energy = "900kW", 
  modSlots = 3, 
  ingredients =  {
    {"advanced-circuit",50},
    {"steel-plate",20},
    {"concrete",200},
    {"nuclear-reactor",1}
  },  
  iconTint = {r=0.9,g=1,b=0.9,a=0.8},
  entityTint = {r=0.9,g=1,b=0.9,a=1},
  health = 3000,
  prerequisites = {"turbo-nuclear-power"},
  science_count = 2000
}

local mk2 = {
  name = "nuclear-chemicals-mk2",
  speed = 18, 
  energy = "1800kW", 
  modSlots = 4, 
  ingredients =  {
    {"advanced-circuit",150},
    {"steel-plate",80},
    {"concrete",350},
    {"nuclear-reactor",1},
    {"processing-unit", 200}
  },  
  iconTint = {r=0.7,g=0.9,b=0.7,a=0.8},
  entityTint = {r=0.7,g=0.9,b=0.7,a=1},
  health = 9000,
  prerequisites = {mk1.name},
  science_count = 8000
}

local mk3 = {
  name = "nuclear-chemical-mk3",
  speed = 50, 
  energy = "3600kW", 
  modSlots = 6, 
  ingredients =  {
    {"advanced-circuit",250},
    {"steel-plate",260},
    {"concrete",1200},
    {"nuclear-reactor",3},
    {"processing-unit", 700}
  },  
  iconTint = {r=0.4,g=1,b=0.4,a=0.8},
  entityTint = {r=0.4,g=1,b=0.4,a=1},
  health = 30000,
  prerequisites = {mk2.name},
  science_count = 30000
}


makeEntity(mk1)
makeEntity(mk2)
makeEntity(mk3)