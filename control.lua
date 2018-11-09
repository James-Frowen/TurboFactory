--control.lua

local function replaceOre(entity, new)
  local surf = entity.surface
	local pos = entity.position
	local amt = entity.amount
	local force = entity.force
	entity.destroy()
	surf.create_entity({name = new, position = pos, force = force, amount = amt})
  surf.create_entity({name = "nuclear-ore-overlay", position = pos, force = force})
end

local function makeOreNuclear(drill) 
  local surface = drill.surface
  local size = drill.prototype.mining_drill_radius
  local pos = drill.position
  local area = {{pos.x - size, pos.y - size}, {pos.x + size, pos.y + size}}
  local ores = surface.find_entities_filtered({ area = area, type= "resource"})
  for _,ore in pairs(ores) do
    if (ore.valid) then
      if ore.type == "resource" then
        if game.entity_prototypes[ore.name].resource_category == "basic-solid" then
          local nuclearName = "radioactive-ore-" .. ore.name
          if (game.entity_prototypes[nuclearName] ~= nil) then
            replaceOre(ore, nuclearName)
          end
        end
      end
    end
  end
end

local function onEntityCreated(e)
  local entity = e.created_entity
  if string.match(entity.name, "nuclear%-mining%-drill") then
    -- log("Nuclear Miner Built")
    makeOreNuclear(entity)
  end
end

script.on_event(defines.events.on_built_entity, onEntityCreated)
script.on_event(defines.events.on_robot_built_entity, onEntityCreated)