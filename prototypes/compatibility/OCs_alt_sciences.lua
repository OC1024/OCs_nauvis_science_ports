log("OCs Alt Sciences Techs are used for OCs Nauvis Science Ports")
local bonus
if settings.startup["alt-sci-easy-mode"].value then
  bonus = 0.10
else
  bonus = 0.05
end

local recipe_unlocks = {
  ["foundry-automation-science-pack"] = "foundry-science-packs-tech",
  ["foundry-logistic-science-pack"] = "foundry-science-packs-tech",
  ["foundry-military-science-pack"] = "foundry-science-packs-tech",
  ["biochamber-chemical-science-pack"] = "biochamber-science-packs-tech",
  ["biochamber-space-science-pack"] = "biochamber-science-packs-tech",
  ["emplant-production-science-pack"] = "emp-science-packs-tech",
  ["emplant-utility-science-pack"] = "emp-science-packs-tech",
}
oc_tech.add_recipe_unlocks(recipe_unlocks)

-- add nauvis-science-port recipes to the prod bonus techs
local recipe_tech_bonus = {
  ["foundry-automation-science-pack"] = "foundry-science-packs-productivity-tech",
  ["foundry-logistic-science-pack"] = "foundry-science-packs-productivity-tech",
  ["foundry-military-science-pack"] = "foundry-science-packs-productivity-tech",
  ["biochamber-chemical-science-pack"] = "biochamber-science-packs-productivity-tech",
  ["biochamber-space-science-pack"] = "biochamber-science-packs-productivity-tech",
  ["emplant-production-science-pack"] = "emp-science-packs-productivity-tech",
  ["emplant-utility-science-pack"] = "emp-science-packs-productivity-tech",
}
for recipe_name, techname in pairs(recipe_tech_bonus) do
  oc_tech.add_productivity_bonus(techname, recipe_name, bonus)
end
