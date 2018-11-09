local recipe = {
  type = "recipe",
  name = "rocket-part",
  energy_required = 3,
  enabled = false,
  hidden = true,
  category = "rocket-building",
  ingredients =
  {
    {"rocket-control-unit", 10},
    {"low-density-structure", 10},
    {"rocket-fuel", 10}
  },
  result= "rocket-part"
}