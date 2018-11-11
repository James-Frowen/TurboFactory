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

  local entity = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
  local item = table.deepcopy(data.raw.item["assembling-machine-3"])
  local recipe = table.deepcopy(data.raw.recipe["assembling-machine-3"])

  local icon = {{
    icon=item.icon,
    tint=iconTint
  }}


  item.name = name
  item.place_result = name
  item.icons = icon
  
  entity.name = name
  entity.crafting_speed = speed
  entity.crafting_categories = 
  {
    "crafting",
    "advanced-crafting",
    "crafting-with-fluid",
    "t-nuclear-crafting"
  }
  entity.minable = {mining_time = 2, result = name}
  entity.energy_source = energy_source.nuclear()
  entity.energy_usage = energy
  entity.max_health = health
  entity.module_specification =
  {
    module_slots = modSlots
  }
  for k, v in pairs(entity.animation.layers) do 
    v.tint = entityTint
  end
  
  recipe.enabled = false
  recipe.name = name
  recipe.normal = nil
  recipe.expensive = nil
  recipe.ingredients = ingredients
  recipe.energy_required = 60
  recipe.requester_paste_multiplier = 2
  
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
    icon = "__base__/graphics/technology/automation.png",
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
    order = "x-a"
  }

  data:extend({entity, recipe, item, tech})
  -- body
end

local mk1 = {
  name = "nuclear-assembling-mk1",
  speed = 5, 
  energy = "2100kW", 
  modSlots = 0, 
  ingredients =  {
    {"advanced-circuit",60},
    {"steel-plate",40},
    {"concrete",100},
    {"nuclear-reactor",1},
    {"assembling-machine-3",1}
  },  
  iconTint = {r=0.9,g=1,b=0.9,a=0.8},
  entityTint = {r=0.9,g=1,b=0.9,a=1},
  health = 3000,
  prerequisites = {"turbo-nuclear-power"},
  science_count = 1500
}

local mk2 = {
  name = "nuclear-assembling-mk2",
  speed = 12, 
  energy = "7500kW", 
  modSlots = 2, 
  ingredients =  {
    {"advanced-circuit",140},
    {"steel-plate",140},
    {"concrete",50},
    {"processing-unit", 100},
    {mk1.name,1}
  },  
  iconTint = {r=0.7,g=0.9,b=0.7,a=0.8},
  entityTint = {r=0.7,g=0.9,b=0.7,a=1},
  health = 9000,
  prerequisites = {mk1.name},
  science_count = 6500
}

local mk3 = {
  name = "nuclear-assembling-mk3",
  speed = 20, 
  energy = "26400kW", 
  modSlots = 4, 
  ingredients =  {
    {"advanced-circuit",100},
    {"steel-plate",360},
    {"concrete",150},
    {"nuclear-reactor",1},
    {"processing-unit", 150},
    {mk2.name,1}
  },  
  iconTint = {r=0.4,g=1,b=0.4,a=0.8},
  entityTint = {r=0.4,g=1,b=0.4,a=1},
  health = 30000,
  prerequisites = {mk2.name},
  science_count = 12000
}

local mk4 = {
  name = "nuclear-assembling-mk4",
  speed = 80, 
  energy = "54000kW", 
  modSlots = 8, 
  ingredients =  {
    {"advanced-circuit",200},
    {"steel-plate",440},
    {"concrete",400},
    {"nuclear-reactor",1},
    {"processing-unit", 350},
    {mk3.name,2}
  },  
  iconTint = {r=0.4,g=1,b=0.4,a=0.8},
  entityTint = {r=0.4,g=1,b=0.4,a=1},
  health = 30000,
  prerequisites = {mk3.name},
  science_count = 40000
}


makeEntity(mk1)
makeEntity(mk2)
makeEntity(mk3)
makeEntity(mk4)