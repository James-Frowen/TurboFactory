
local spaceFlight = {
  type = "technology",
  name = "space-flight",
  icon_size = 128,
  icon = "__base__/graphics/technology/rocket-silo.png",
  effects =
  {
  },
  prerequisites = {"turbo-nuclear-power"},
  unit =
  {
    count_formula = 20000,
    time = 2400,
    ingredients =
    {
      {"science-pack-1", 1},
      {"science-pack-2", 1},
      {"science-pack-3", 1},
      {"production-science-pack", 1},
      {"high-tech-science-pack", 1},
      {"space-science-pack", 5}
    },
  },
  order = "x-space"
}

-- data:extend({spaceFlight})
