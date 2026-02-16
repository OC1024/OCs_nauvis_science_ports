local icon_helper = require("__OCs_base_assets__.prototypes.utils.icon_helper")

local science_ports = {
    ["foundry-automation-science-pack"] = {"automation-science-pack", "metallurgy", "__OCs_base_assets__/graphics/icons/overlayer-recipe-foundry.png"},
    ["foundry-logistic-science-pack"] = {"logistic-science-pack", "metallurgy", "__OCs_base_assets__/graphics/icons/overlayer-recipe-foundry.png"},
    ["foundry-military-science-pack"] = {"military-science-pack", "metallurgy", "__OCs_base_assets__/graphics/icons/overlayer-recipe-foundry.png"},
    ["biochamber-chemical-science-pack"] = {"chemical-science-pack", "organic", "__OCs_base_assets__/graphics/icons/overlayer-recipe-biochamber.png"},
    ["biochamber-bio-space-science-pack"] = {"space-science-pack", "organic", "__OCs_base_assets__/graphics/icons/overlayer-recipe-biochamber.png"},
    ["emplant-production-science-pack"] = {"production-science-pack", "electromagnetics", "__OCs_base_assets__/graphics/icons/overlayer-recipe-em-plant.png"},
    ["emplant-utility-science-pack"] = {"utility-science-pack", "electromagnetics", "__OCs_base_assets__/graphics/icons/overlayer-recipe-em-plant.png"},
}

local category_mapping = {}
for new_name, data_in in pairs(science_ports) do
  local base_recipe_name = data_in[1]
  local target_category  = data_in[2]
  local target_overlay = data_in[3]

  local cloned = table.copy_and_rename( { type = "recipe", name = base_recipe_name }, new_name )

  -- science-specific safety flags
  -- cloned.allow_decomposition = false
  -- cloned.always_show_products = true

  data:extend({cloned})
  log("Created recipe: " .. new_name .. " based on " .. base_recipe_name .. " with category " .. target_category)

  category_mapping[new_name] = target_category

  change_recipes_subgroup({new_name, "science-pack-alternative"})

  icon_helper.apply_overlay({
    type = "recipe",
    name = new_name,
    overlay = target_overlay,
    options = { resolve_inherited = true }
  })
end
change_multiple_crafting_category(category_mapping)
