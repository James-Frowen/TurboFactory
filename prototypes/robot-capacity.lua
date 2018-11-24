local rawResearch = data.raw["technology"]["worker-robots-storage-3"]

local research = {
  type = "technology",
  name = "turbo-worker-robot-cargo-size",
  icon_size = 128,
  icon = rawResearch.icon,
  max_level = "6",
  effects =
  {
    {
      modifier = 1,
      type = "worker-robot-storage"
    }
  },
  prerequisites = {"turbo-nuclear-power"},
  unit =
  {
    count_formula = "2^(L)*1000",
    time = 600,
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
  order = "x-rc"
}

data:extend({research})
