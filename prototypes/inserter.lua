function makeEntity(args)
  local raw = args.raw
  local name = args.name
  local ext_speed = args.ext_speed
  local rot_speed = args.rot_speed
  local energy = args.energy
  local ingredients = args.ingredients
  local iconTint = args.iconTint
  local entityTint = args.entityTint
  local health = args.health
  local prerequisites = args.prerequisites
  local science_count = args.science_count
  local filter = args.filter
  if filter == nil then filter = 0 end

  local entity = table.deepcopy(data.raw.inserter[raw])
  local item = table.deepcopy(data.raw.item[raw])
  local recipe = table.deepcopy(data.raw.recipe[raw])

  local icon = {{
    icon=data.raw.item["stack-filter-inserter"].icon,
    tint=iconTint
  }}


  item.name = name
  item.place_result = name
  item.icons = icon
  
  entity.name = name
  entity.minable = {mining_time = 2, result = name}
  entity.extension_speed = ext_speed
  entity.rotation_speed = rot_speed
  entity.energy_per_movement = energy
  entity.energy_per_rotation = energy

  
  entity.stack = true
  entity.filter_count = filter
  

  energy_source = {
    drain = "2kW",
    type = "electric",
    usage_priority = "secondary-input"
  }
  entity.max_health = health

  entity.platform_picture.sheet.tint = entityTint
  entity.hand_base_picture.tint = entityTint
  entity.hand_open_picture.tint = entityTint
  entity.hand_closed_picture.tint = entityTint
  
  recipe.enabled = false
  recipe.name = name
  recipe.normal = nil
  recipe.expensive = nil
  recipe.category = "crafting-with-fluid"
  recipe.ingredients = ingredients
  if (cat == "underground-belt") then
    recipe.result_count = 2
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

local entityTint1 = {r=0.4,g=1,b=1,a=1}
local speed = 2

local inserter = {
  raw = "stack-inserter",
  name = "turbo-stack-inserter",
  rot_speed = 0.07 * speed,
  ext_speed = 0.04 * speed, 
  energy = 20000 * 10,
  ingredients =  {
    {"stack-inserter",2},
    {"processing-unit", 6},
    {"iron-gear-wheel", 40},
    {"low-density-structure",2},
    {type="fluid", name="lubricant", amount=10},
  },  
  iconTint = {r=0.4, g=1,b=0.4,a=0.8},
  entityTint = entityTint1,
  health = 560,
}

local filter_inserter = {
  raw = "stack-filter-inserter",
  name = "turbo-stack-filter-inserter",
  rot_speed = 0.07 * speed,
  ext_speed = 0.04 * speed, 
  energy = 20000 * 11,
  filter = 3,
  ingredients =  {
    {"stack-filter-inserter",2},
    {"processing-unit", 10},
    {"iron-gear-wheel", 40},
    {"low-density-structure",2},
    {type="fluid", name="lubricant", amount=10},
  },  
  iconTint = {r=0.4, g=0.8,b=1,a=0.8},
  entityTint = entityTint1,
  health = 560,
}

local long_inserter = {
  raw = "long-handed-inserter",
  name = "turbo-long-handed-inserter",
  rot_speed = 0.0457 * speed,
  ext_speed = 0.02 * speed, 
  energy = 20000 * 15,
  ingredients =  {
    {"long-handed-inserter",2},
    {"processing-unit", 6},
    {"iron-gear-wheel", 80},
    {"low-density-structure",3},
    {type="fluid", name="lubricant", amount=15},
  },  
  iconTint = {r=1, g=0.8,b=0.5,a=0.8},
  entityTint = entityTint1,
  health = 560,
}


makeEntity(inserter)
makeEntity(filter_inserter)
makeEntity(long_inserter)

local tech1 = {
  type = "technology",
  name = "turbo-inserters",
  icon_size = 128,
  icon = "__base__/graphics/technology/stack-inserter.png",
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = inserter.name
    },
    {
      type = "unlock-recipe",
      recipe = long_inserter.name
    },
    {
      type = "unlock-recipe",
      recipe = filter_inserter.name
    }
  },
  prerequisites = {"turbo-nuclear-power", "logistics-3"},
  unit =
  {
    count_formula = 7000,
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

data:extend({tech1})
