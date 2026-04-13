local icon_helper = require("__OCs_base_assets__.prototypes.utils.icon_helper")
local oc_helper = require("__OCs_base_assets__.prototypes.utils.helper")

local science_ports = {
  ["foundry-automation-science-pack"] = { "automation-science-pack", "metallurgy", { icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-foundry.png", icon_size = 64 } },
  ["foundry-logistic-science-pack"] = { "logistic-science-pack", "metallurgy", { icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-foundry.png", icon_size = 64 } },
  ["foundry-military-science-pack"] = { "military-science-pack", "metallurgy", { icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-foundry.png", icon_size = 64 } },
  ["biochamber-chemical-science-pack"] = { "chemical-science-pack", "organic", { icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-biochamber.png", icon_size = 64 } },
  ["biochamber-space-science-pack"] = { "space-science-pack", "organic", { icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-biochamber.png", icon_size = 64 } },
  ["emplant-production-science-pack"] = { "production-science-pack", "electromagnetics", { icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-em-plant.png", icon_size = 64 } },
  ["emplant-utility-science-pack"] = { "utility-science-pack", "electromagnetics", { icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-em-plant.png", icon_size = 64 } },
}

local category_mapping = {}
for new_name, data_in in pairs(science_ports) do
  local base_recipe_name = data_in[1]
  local target_category  = data_in[2]
  local target_overlay   = data_in[3]

  local cloned_recipe    = table.copy_and_rename({ type = "recipe", name = base_recipe_name }, new_name)

  -- make sure the rew recipe has its own icon(s).
  local base_item        = data.raw.tool[base_recipe_name]
  if base_item then
    if base_item.icons then
      cloned_recipe.icons = table.deepcopy(base_item.icons)
      cloned_recipe.icon = nil
      log("Recipe "..new_name.." has icons table, copying icons from "..base_item.name..". it is like this: "..serpent.line(cloned_recipe.icons))
    else
      cloned_recipe.icon = base_item.icon
      cloned_recipe.icon_size = base_item.icon_size or 64
      cloned_recipe.icon_mipmaps = base_item.icon_mipmaps or 4
      log("recipe "..new_name.." has icon, copied: "..tostring(cloned_recipe.icon or "nil").." with size "..tostring(cloned_recipe.icon_size or "nil"))
    end
  end

  -- [[
  -- if mods["science-table"] then
  --   data:extend({
  --     {
  --       type = "recipe-group",
  --       name = "science",
  --     },
  --     {
  --       type = "recipe-subgroup",
  --       name = "science-pack-alternative",
  --       group = "science",
  --       order = "z[science]"
  --     }
  --   })
  --   cloned.group = "science"
  -- end
  -- ]]
  data:extend({ cloned_recipe })
  log("Created recipe: " .. new_name .. " based on " .. base_recipe_name .. " with category " .. target_category)

  category_mapping[new_name] = target_category

  oc_helper.change_recipes_subgroup({ [new_name] = "science-pack-alternative" })

  icon_helper.apply_overlay({
    type = "recipe",
    name = new_name,
    overlay = target_overlay,
    options = { resolve_inherited = true, auto_rescale = true }
  })
end
oc_helper.change_multiple_crafting_category(category_mapping)
