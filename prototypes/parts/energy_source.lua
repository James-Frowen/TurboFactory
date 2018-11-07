--energy_source.lua

local M = {}

local function nuclear() 
  return {
    type = "burner",
    fuel_category = "nuclear",
    effectivity = 1,
    fuel_inventory_size = 1,
    burnt_inventory_size = 1
  }
end

M.nuclear = nuclear

return M