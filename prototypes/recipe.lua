local icon_helper = require("__OCs_base_assets__.prototypes.utils.icon_helper")
local oc_helper = require("__OCs_base_assets__.prototypes.utils.helper")
local oc_recipe = require("__OCs_base_assets__.prototypes.utils.oc_recipe")

if settings.startup["science-cloning"].value then -- deepcopy science pack
  local category_mapping = {}
  local science_ports = {
    ["foundry-automation-science-pack"] = {
      "automation-science-pack",
      "metallurgy",
      {
        icon = "__space-age__/graphics/icons/foundry.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 8, -8 },
      }
    },
    ["foundry-logistic-science-pack"] = {
      "logistic-science-pack",
      "metallurgy",
      {
        icon = "__space-age__/graphics/icons/foundry.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 8, -8 },
      }
    },
    ["foundry-military-science-pack"] = {
      "military-science-pack",
      "metallurgy",
      {
        icon = "__space-age__/graphics/icons/foundry.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 8, -8 },
      }
    },
    ["biochamber-chemical-science-pack"] = {
      "chemical-science-pack",
      "organic",
      {
        icon = "__space-age__/graphics/icons/biochamber.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 8, -8 },
      }
    },
    ["biochamber-space-science-pack"] = {
      "space-science-pack",
      "organic",
      {
        icon = "__space-age__/graphics/icons/biochamber.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 8, -8 },
      }
    },
    ["emplant-production-science-pack"] = {
      "production-science-pack",
      "electromagnetics",
      {
        icon = "__space-age__/graphics/icons/electromagnetic-plant.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 8, -8 },
      }
    },
    ["emplant-utility-science-pack"] = {
      "utility-science-pack",
      "electromagnetics", {
      icon = "__space-age__/graphics/icons/electromagnetic-plant.png",
      icon_size = 64,
      scale = 0.25,
      shift = { 8, -8 },
    }
    },
  }

  for new_name, data_in in pairs(science_ports) do
    local base_recipe_name = data_in[1]
    local target_category  = data_in[2]
    local target_overlay   = data_in[3]

    local cloned_recipe    = table.deepcopy(data.raw.recipe[base_recipe_name])
    cloned_recipe.name     = new_name

    -- make sure the rew recipe has its own icon(s).
    local base_item        = data.raw.item[base_recipe_name]
    if base_item then
      if base_item.icons then
        cloned_recipe.icons = table.deepcopy(base_item.icons)
        cloned_recipe.icon = nil
      elseif base_item.icon then
        cloned_recipe.icon = base_item.icon
        cloned_recipe.icon_size = base_item.icon_size or 64
        cloned_recipe.icon_mipmaps = base_item.icon_mipmaps
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

    icon_helper.apply_overlay(
      "recipe",
      new_name,
      target_overlay,
      {
        resolve_inherited = true,
        auto_rescale = true,
        anchor = "top-right",
        prevent_duplicates = true
      }
    )
  end
  oc_recipe.change_crafting_categories(category_mapping)
else -- just changing the category
  local category_mapping = {
    ["automation-science-pack"] = { "metallurgy" },
    ["logistic-science-pack"]   = { "metallurgy" },
    ["military-science-pack"]   = { "metallurgy" },
    ["chemical-science-pack"]   = { "organic" },
    ["space-science-pack"]      = { "organic" },
    ["production-science-pack"] = { "electromagnetics" },
    ["utility-science-pack"]    = { "electromagnetics" },
  }
  oc_recipe.add_crafting_categories(category_mapping)
end
