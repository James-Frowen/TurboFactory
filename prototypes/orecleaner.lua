local energy_source = require("prototypes.parts.energy_source")

function oreCleaner(args)
  local name = args.name
  local speed = args.speed
  local energy = args.energy
  local modSlots = args.modSlots
  local ingredients = args.ingredients
  local iconTint = args.iconTint
  local entityTint = args.entityTint
  local health = args.health

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
  entity.crafting_categories = {"t-clean-nuclear"}
  entity.minable = {mining_time = 2, result = name}
  entity.energy_source =
  {
    type = "electric",
    -- will produce this much * energy pollution units per tick
    emissions = 0.001,
    usage_priority = "secondary-input"
  }
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

  data:extend({entity, recipe, item})
  -- body
end

local mk1 = {
  name = "radioactive-cleaner",
  speed = 5, 
  energy = "900kW", 
  modSlots = 0, 
  ingredients =  {
    {"pipe", 500},
    {"processing-unit",20},
    {"steel-plate",120},
    {"concrete",500},
  },  
  iconTint = {r=0.5,g=0.8,b=1,a=0.8},
  entityTint = {r=0.5,g=0.8,b=1,a=1},
  health = 3000,
  prerequisites = nil,
  science_count = nil
}


oreCleaner(mk1)
table.insert(data.raw.technology["clean-nuclear-ore"].effects, {
  type = "unlock-recipe", 
  recipe = mk1.name
})