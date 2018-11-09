local name = "turbo-nuclear-power"
local prerequisites = {
  "nuclear-power"
}
local science_count = 10000


local tech = {
  type = "technology",
  name = name,
  icon_size = 128,
  icon = "__base__/graphics/technology/nuclear-power.png",
  effects =
  {
    
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

data:extend({tech})
