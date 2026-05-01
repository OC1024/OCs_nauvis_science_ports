local icon_helper = require("__OCs_base_assets__.prototypes.utils.icon_helper")
local oc_helper = require("__OCs_base_assets__.prototypes.utils.helper")
local oc_recipe = require("__OCs_base_assets__.prototypes.utils.oc_recipe")

if settings.startup["science-cloning"].value then
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
      elseif base_item.icon then
        cloned_recipe.icon = base_item.icon
        cloned_recipe.icon_size = base_item.icon_size or 64
        cloned_recipe.icon_mipmaps = base_item.icon_mipmaps or 4
      else
        log("Base recipe " ..
          base_recipe_name .. " has no icon or icons, cloned recipe " .. new_name .. " will not have an icon.")
      end
    end

    -- change subgroup
    cloned_recipe.subgroup = "science-pack-alternative"

    data:extend({ cloned_recipe })

    category_mapping[new_name] = target_category

    oc_recipe.change_recipes_subgroup({ [new_name] = "science-pack-alternative" })

    icon_helper.apply_overlay({
      type = "recipe",
      name = new_name,
      overlay = target_overlay,
      options = { resolve_inherited = true, auto_rescale = true }
    })
  end
  oc_recipe.change_multiple_crafting_category(category_mapping)
else -- changing the category
  local category_mapping = {
    ["automation-science-pack"] = "pressing",
    ["logistic-science-pack"] = "pressing",
    ["military-science-pack"] = "pressing",
    ["chemical-science-pack"] = "organic-or-hand-crafting",
    ["space-science-pack"] = "organic-or-assembling",-- is the same as "organic-or-hand-crafting"
    ["production-science-pack"] = "electronics",
    ["utility-science-pack"] = "electronics",
  }
  oc_recipe.change_multiple_crafting_category(category_mapping)
end
