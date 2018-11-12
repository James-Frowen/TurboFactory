local item = {
  name = "compressed-uranium-fuel-cell",
  burnt_result = nil,
  flags = {
    "goes-to-main-inventory"
  },
  fuel_category = "nuclear",
  fuel_value = "16GJ",
  icons = {{
    icon = "__base__/graphics/icons/uranium-fuel-cell.png",
    tint =  {r=1, g=0.5, b=0.5, a=1}
  }},
  icon_size = 32,
  order = "r[uranium-processing]-a[uranium-fuel-cell]-2",
  stack_size = 50,
  subgroup = "intermediate-product",
  type = "item"
}

local recipe = {
  enabled = false,
  type = "recipe",
  name = item.name,
  energy_required = 60,
  icons = item.icons,
  icon_size = 32,
  subgroup = "raw-material",
  category = "crafting",
  ingredients =
  {
    {"uranium-fuel-cell",2}
  },
  results = {
    {item.name, 1}
  },
  allow_decomposition = true,
}
local tech = {
  type = "technology",
  name = item.name,
  icon_size = 128,
  icon = "__base__/graphics/technology/kovarex-enrichment-process.png",
  effects =
  {
    {
      type = "unlock-recipe", 
      recipe = item.name
    }
  },
  prerequisites = {"turbo-nuclear-power"},
  unit =
  {
    count_formula = 750,
    time = 20,
    ingredients =
    {
      {"science-pack-1", 1},
      {"science-pack-2", 1},
      {"science-pack-3", 1},
      {"production-science-pack", 1},
      {"high-tech-science-pack", 2},
    },
  },
  order = "x-fuel"
}

data:extend({recipe, item, tech})
